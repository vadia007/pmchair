<?php
/**
 * Plugin Helper File
 *
 * @package         Sourcerer
 * @version         4.0.1
 *
 * @author          Peter van Westen <peter@nonumber.nl>
 * @link            http://www.nonumber.nl
 * @copyright       Copyright © 2012 NoNumber All Rights Reserved
 * @license         http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

defined('_JEXEC') or die;

require_once JPATH_PLUGINS . '/system/nnframework/helpers/protect.php';

/**
 * Plugin that replaces Sourcerer code with its HTML / CSS / JavaScript / PHP equivalent
 */
class plgSystemSourcererHelper
{
	function __construct(&$params)
	{
		// Set plugin parameters
		$this->src_params = new stdClass;
		$this->src_params->syntax_word = $params->syntax_word;
		$this->src_params->syntax_start = '{' . $this->src_params->syntax_word . '}';
		$this->src_params->syntax_start_0 = '{' . $this->src_params->syntax_word . ' 0}';
		$this->src_params->syntax_end = '{/' . $this->src_params->syntax_word . '}';

		// Matches the start and end tags with everything in between
		// Also matches any surrounding breaks and paragraph tags, to prevent unwanted empty lines in output.
		$breaks_start = '(<p(?: [^>]*)?>\s*)?(?:<span [^>]*>\s*)*';
		$breaks_end = '(?:\s*</span>)*(\s*</p>)?';
		$this->src_params->regex = '#(' . $breaks_start . '(' . preg_quote($this->src_params->syntax_start, '#') . '|' . preg_quote($this->src_params->syntax_start_0, '#') . ')(.*?)' . preg_quote($this->src_params->syntax_end, '#') . $breaks_end . ')#s';

		// Escape any regex characters!
		$this->src_params->tags_syntax = array(array('<', '>'), array('\[\[', '\]\]'));
		$this->src_params->splitter = '<!-- START: SRC_SPLIT -->';

		$this->src_params->debug_php = $params->debug_php;
		$this->src_params->debug_php_article = $this->src_params->debug_php;

		$user = JFactory::getUser();
		$this->src_params->user_is_admin = $user->authorise('core.admin', 1);

		$this->src_params->areas = array();
		$this->src_params->areas['default'] = array();
		$this->src_params->areas['default']['enable_css'] = $params->enable_css;
		$this->src_params->areas['default']['enable_js'] = $params->enable_js;
		$this->src_params->areas['default']['enable_php'] = $params->enable_php;
		$this->src_params->areas['default']['forbidden_php'] = $params->forbidden_php;
		$this->src_params->areas['default']['forbidden_tags'] = $params->forbidden_tags;


		$this->src_params->currentarea = 'default';
	}

	////////////////////////////////////////////////////////////////////
	// onContentPrepare
	////////////////////////////////////////////////////////////////////

	function onContentPrepare(&$article, $params = '')
	{
		if ($params && $params->get('nn_search')) {
			$this->src_params->debug_php_article = 0;
		}
		if (isset($article->created_by)) {
			$user = JFactory::getUser($article->created_by);
			$groups = $user->getAuthorisedGroups();
			array_unshift($groups, -1);

		}

		if (isset($article->text)) {
			$this->replace($article->text, 'articles', $article);
		}
		if (isset($article->description)) {
			$this->replace($article->description, 'articles', $article);
		}
		if (isset($article->title)) {
			$this->replace($article->title, 'articles', $article);
		}
		if (isset($article->author)) {
			if (isset($article->author->name)) {
				$this->replace($article->author->name, 'articles', $article);
			} else if (is_string($article->author)) {
				$this->replace($article->author, 'articles', $article);
			}
		}
	}

	////////////////////////////////////////////////////////////////////
	// onAfterDispatch
	////////////////////////////////////////////////////////////////////

	function onAfterDispatch()
	{
		$document = JFactory::getDocument();
		$docType = $document->getType();

		// PDF
		if ($docType == 'pdf') {
			$buffer = $document->getBuffer('component');
			if (is_array($buffer)) {
				if (isset($buffer['component'], $buffer['component'][''])) {
					if (isset($buffer['component']['']['component'], $buffer['component']['']['component'][''])) {
						$this->replaceInTheRest($buffer['component']['']['component'][''], 0);
					} else {
						$this->replaceInTheRest($buffer['component'][''], 0);
					}
				} else if (isset($buffer['0'], $buffer['0']['component'], $buffer['0']['component'][''])) {
					if (isset($buffer['0']['component']['']['component'], $buffer['0']['component']['']['component'][''])) {
						$this->replaceInTheRest($buffer['component']['']['component'][''], 0);
					} else {
						$this->replaceInTheRest($buffer['0']['component'][''], 0);
					}
				}
			} else {
				$this->replaceInTheRest($buffer);
			}
			$document->setBuffer($buffer, 'component');
			return;
		}

		// FEED
		if (($docType == 'feed' || JFactory::getApplication()->input->get('option') == 'com_acymailing') && isset($document->items)) {
			for ($i = 0; $i < count($document->items); $i++) {
				$this->onContentPrepare($document->items[$i]);
			}
		}

		$buffer = $document->getBuffer('component');
		if (!empty($buffer)) {
			if (is_array($buffer)) {
				if (isset($buffer['component']) && isset($buffer['component'][''])) {
					$this->tagArea($buffer['component'][''], 'SRC', 'component');
				}
			} else {
				$this->tagArea($buffer, 'SRC', 'component');
			}
			$document->setBuffer($buffer, 'component');
		}
	}

	////////////////////////////////////////////////////////////////////
	// onAfterRender
	////////////////////////////////////////////////////////////////////
	function onAfterRender()
	{
		$document = JFactory::getDocument();
		$docType = $document->getType();

		// not in pdf's
		if ($docType == 'pdf') {
			return;
		}

		$html = JResponse::getBody();

		$this->protect($html);
		$this->replaceInTheRest($html);
		$this->unprotect($html);

		$this->cleanLeftoverJunk($html);

		JResponse::setBody($html);
	}

	function replaceInTheRest(&$str)
	{
		if (!is_string($str) || $str == '') {
			return;
		}

		$document = JFactory::getDocument();
		$docType = $document->getType();

		// COMPONENT
		if ($docType == 'feed' || JFactory::getApplication()->input->get('option') == 'com_acymailing') {
			$s = '#(<item[^>]*>)#s';
			$str = preg_replace($s, '\1<!-- START: SRC_COMPONENT -->', $str);
			$str = str_replace('</item>', '<!-- END: SRC_COMPONENT --></item>', $str);
		}
		if (strpos($str, '<!-- START: SRC_COMPONENT -->') === false) {
			$this->tagArea($str, 'SRC', 'component');
		}


		$components = $this->getTagArea($str, 'SRC', 'component');
		foreach ($components as $component) {
			$this->replace($component['1'], 'components', '');
			$str = str_replace($component['0'], $component['1'], $str);
		}

		// EVERYWHERE
		$this->replace($str, 'other');
	}

	function tagArea(&$str, $ext = 'EXT', $area = '')
	{
		if ($str && $area) {
			$str = '<!-- START: ' . strtoupper($ext) . '_' . strtoupper($area) . ' -->' . $str . '<!-- END: ' . strtoupper($ext) . '_' . strtoupper($area) . ' -->';
			if ($area == 'article_text') {
				$str = preg_replace('#(<hr class="system-pagebreak".*?/>)#si', '<!-- END: ' . strtoupper($ext) . '_' . strtoupper($area) . ' -->\1<!-- START: ' . strtoupper($ext) . '_' . strtoupper($area) . ' -->', $str);
			}
		}
	}

	function getTagArea(&$str, $ext = 'EXT', $area = '')
	{
		$matches = array();
		if ($str && $area) {
			$start = '<!-- START: ' . strtoupper($ext) . '_' . strtoupper($area) . ' -->';
			$end = '<!-- END: ' . strtoupper($ext) . '_' . strtoupper($area) . ' -->';
			$matches = explode($start, $str);
			array_shift($matches);
			foreach ($matches as $i => $match) {
				list($text) = explode($end, $match, 2);
				$matches[$i] = array(
					$start . $text . $end,
					$text
				);
			}
		}
		return $matches;
	}

	function replace(&$str, $area = 'articles', $article = '')
	{
		if (!is_string($str) || $str == '') {
			return;
		}

		$string_array = $this->stringToSplitArray($str, $this->src_params->regex);
		$string_array_count = count($string_array);
		if ($string_array_count > 1) {
			for ($i = 1; $i < $string_array_count - 1; $i++) {
				if (fmod($i, 2)) {
					$sub_string_array = preg_replace($this->src_params->regex, implode($this->src_params->splitter, array('\2', '\3', '\4', '\5')), $string_array[$i]);
					$sub_string_array = explode($this->src_params->splitter, $sub_string_array);

					$string_array[$i] = $sub_string_array['2'];

					if ($sub_string_array['1'] == $this->src_params->syntax_start) {
						$this->cleanText($string_array[$i]);
					}

					$this->replaceTags($string_array[$i], $area, $article);

					// Restore leading/trailing paragraph tags if not both present
					if (!($sub_string_array['0'] && $sub_string_array['3'])) {
						$string_array[$i] = $sub_string_array['0'] . $string_array[$i] . $sub_string_array['3'];
					}
				}
			}
		}
		$str = implode('', $string_array);
	}

	function replaceTags(&$str, $area = 'articles', $article = '')
	{
		if (!is_string($str) || $str == '') {
			return;
		}

		$this->replaceTagsByType($str, $area, 'php', $article);
		if (strpos($str, '<!-- SORCERER DEBUGGING -->') === false) {
			$this->replaceTagsByType($str, $area, 'all', '');
			$this->replaceTagsByType($str, $area, 'js', '');
			$this->replaceTagsByType($str, $area, 'css', '');
		}
	}

	function replaceTagsByType(&$str, $area = 'articles', $type = 'all', $article = '')
	{
		if (!is_string($str) || $str == '') {
			return;
		}

		$type_ext = '_' . $type;
		if ($type == 'all') {
			$type_ext = '';
		}

		$a = $this->src_params->areas['default'];
		$security_pass = 1;
		$enable = isset($a['enable' . $type_ext]) ? $a['enable' . $type_ext] : 1;

		switch ($type) {
			case 'php':
				$this->replaceTagsPHP($str, $enable, $security_pass, $article);
				break;
			case 'js':
				$this->replaceTagsJS($str, $enable, $security_pass);
				break;
			case 'css':
				$this->replaceTagsCSS($str, $enable, $security_pass);
				break;
			default:
				$this->replaceTagsAll($str, $enable, $security_pass);
				break;
		}
	}

	// Replace any html style tags by a comment tag if not permitted
	// Match:
	// <...>
	function replaceTagsAll(&$str, $enabled = 1, $security_pass = 1)
	{
		if (!is_string($str) || $str == '') {
			return;
		}

		if (!$enabled) {
			// replace source block content with HTML comment
			$str = '<!-- ' . JText::_('SRC_COMMENT') . ': ' . JText::_('SRC_OUTPUT_REMOVED_NOT_ENABLED') . ' -->';
		} else if (!$security_pass) {
			// replace source block content with HTML comment
			$str = '<!-- ' . JText::_('SRC_COMMENT') . ': ' . JText::_('SRC_OUTPUT_REMOVED_SECURITY') . ' -->';
		} else {
			$this->cleanTags($str);

			$a = $this->src_params->areas['default'];
			$forbidden_tags_array = explode(',', $a['forbidden_tags']);
			$this->cleanArray($forbidden_tags_array);
			// remove the comment tag syntax from the array - they cannot be disabled
			$forbidden_tags_array = array_diff($forbidden_tags_array, array('!--'));
			// reindex the array
			$forbidden_tags_array = array_merge($forbidden_tags_array);

			$has_forbidden_tags = 0;
			foreach ($forbidden_tags_array as $forbidden_tag) {
				if (!(strpos($str, '<' . $forbidden_tag) == false)) {
					$has_forbidden_tags = 1;
					break;
				}
			}

			if ($has_forbidden_tags) {
				// double tags
				$tag_regex = '#<\s*([a-z\!][^>\s]*?)(?:\s+.*?)?>.*?</\1>#si';
				if (preg_match_all($tag_regex, $str, $matches, PREG_SET_ORDER) > 0) {
					foreach ($matches as $match) {
						if (in_array($match['1'], $forbidden_tags_array)) {
							$tag = '<!-- ' . JText::_('SRC_COMMENT') . ': ' . JText::sprintf('SRC_TAG_REMOVED_FORBIDDEN', $match['1']) . ' -->';
							$str = str_replace($match['0'], $tag, $str);
						}
					}
				}
				// single tags
				$tag_regex = '#<\s*([a-z\!][^>\s]*?)(?:\s+.*?)?>#si';
				if (preg_match_all($tag_regex, $str, $matches, PREG_SET_ORDER) > 0) {
					foreach ($matches as $match) {
						if (in_array($match['1'], $forbidden_tags_array)) {
							$tag = '<!-- ' . JText::_('SRC_COMMENT') . ': ' . JText::sprintf('SRC_TAG_REMOVED_FORBIDDEN', $match['1']) . ' -->';
							$str = str_replace($match['0'], $tag, $str);
						}
					}
				}
			}
		}
	}

	// Replace the PHP tags with the evaluated PHP scripts
	// Or replace by a comment tag the PHP tags if not permitted
	function replaceTagsPHP(&$src_str, $src_enabled = 1, $src_security_pass = 1, $article = '')
	{
		if (!is_string($src_str) || $src_str == '') {
			return;
		}

		if ((strpos($src_str, '<?') === false) && (strpos($src_str, '[[?') === false)) {
			return;
		}

		global $src_vars;

		$document = JFactory::getDocument();
		$docType = $document->getType();

		// Match ( read {} as <> ):
		// {?php ... ?}
		// {? ... ?}
		$src_string_array = $this->stringToSplitArray($src_str, '-start-' . '\?(?:php)?[\s<](.*?)\?' . '-end-', 1);
		$src_string_array_count = count($src_string_array);

		if ($src_string_array_count > 1) {
			if (!$src_enabled) {
				// replace source block content with HTML comment
				$src_string_array = array();
				$src_string_array['0'] = '<!-- ' . JText::_('SRC_COMMENT') . ': ' . JText::sprintf('SRC_CODE_REMOVED_NOT_ALLOWED', JText::_('SRC_PHP'), JText::_('SRC_PHP')) . ' -->';
			} else if (!$src_security_pass) {
				// replace source block content with HTML comment
				$src_string_array = array();
				$src_string_array['0'] = '<!-- ' . JText::_('SRC_COMMENT') . ': ' . JText::sprintf('SRC_CODE_REMOVED_SECURUITY', JText::_('SRC_PHP'), JText::_('SRC_PHP')) . ' -->';
			} else {
				// if source block content has more than 1 php block, combine them
				if ($src_string_array_count > 3) {
					for ($i = 2; $i < $src_string_array_count - 1; $i++) {
						if (fmod($i, 2) == 0) {
							$src_string_array['1'] .= "<!-- SRC_SEMICOLON --> ?>" . trim($src_string_array[$i]) . "<?php ";
						} else {
							$src_string_array['1'] .= $src_string_array[$i];
						}
						unset($src_string_array[$i]);
					}
				}

				// fixes problem with _REQUEST being stripped if there is an error in the code
				$src_backup_REQUEST = $_REQUEST;
				$src_backup_vars = array_keys(get_defined_vars());

				$src_script = trim($src_string_array['1']) . '<!-- SRC_SEMICOLON -->';
				$src_script = preg_replace('#(;\s*)?<\!-- SRC_SEMICOLON -->#s', ';', $src_script);

				$src_errorline = 0;
				$src_php_succes = 0;

				$a = $this->src_params->areas['default'];
				$src_forbidden_php_array = explode(',', $a['forbidden_php']);
				$this->cleanArray($src_forbidden_php_array);
				$src_forbidden_php_regex = '#[^a-z_](' . implode('|', $src_forbidden_php_array) . ')\s*\(#si';

				if (preg_match_all($src_forbidden_php_regex, ' ' . $src_script, $src_functions, PREG_SET_ORDER) > 0) {
					$src_functionsArray = array();
					foreach ($src_functions as $src_function) {
						$src_functionsArray[] = $src_function['1'] . ')';
					}
					$src_string_array['1'] = JText::_('SRC_PHP_FORBIDDEN') . ':<br /><span style="font-family: monospace;"><ul style="margin:0px;"><li>' . implode('</li><li>', $src_functionsArray) . '</li></ul></span>';
					$src_comment = JText::_('SRC_PHP_CODE_REMOVED_FORBIDDEN') . ': ( ' . implode(', ', $src_functionsArray) . ' )';
				} else {
					// evaluate the script
					ob_start();
					if (is_array($src_vars)) {
						foreach ($src_vars as $src_key => $src_value) {
							${$src_key} = $src_value;
						}
					}
					if (!isset($Itemid) && !(strpos($src_script, '$Itemid') === false)) {
						$Itemid = JFactory::getApplication()->input->getInt('Itemid');
					}
					if (!isset($mainframe) && !(strpos($src_script, '$mainframe') === false)) {
						$mainframe = JFactory::getApplication();
					}
					if (!isset($app) && !(strpos($src_script, '$app') === false)) {
						$app = JFactory::getApplication();
					}
					if (!isset($document) && !(strpos($src_script, '$document') === false)) {
						$document = JFactory::getDocument();
					}
					if (!isset($doc) && !(strpos($src_script, '$doc') === false)) {
						$doc = JFactory::getDocument();
					}
					if (!isset($database) && !(strpos($src_script, '$database') === false)) {
						$database = JFactory::getDBO();
					}
					if (!isset($db) && !(strpos($src_script, '$db') === false)) {
						$db = JFactory::getDBO();
					}
					if (!isset($user) && !(strpos($src_script, '$user') === false)) {
						$user = JFactory::getUser();
					}
					$src_script .= "\n" . '$src_php_succes = 1;';
					eval($src_script);
					$src_string_array['1'] = ob_get_contents();
					ob_end_clean();
					if (!(strpos($src_string_array['1'], "eval()'d code") === false)) {
						foreach ($src_backup_REQUEST as $src_key => $src_value) {
							$_REQUEST[$src_key] = $src_value;
						}
						$src_php_succes = 0;
						preg_match('#on line <b>([0-9]+)#si', $src_string_array['1'], $src_errormatch);
						if (count($src_errormatch)) {
							$src_errorline = $src_errormatch['1'];
						}
					}

					$src_comment = JText::_('SRC_PHP_CODE_REMOVED_ERRORS');
				}

				if (!$src_php_succes) {
					if ($docType == 'html') {
						if (($this->src_params->debug_php && !$article) || ($this->src_params->debug_php_article && $article)) {
							if ($this->src_params->user_is_admin) {
								$this->createDebuggingOutput($src_string_array['1'], $src_script, $src_errorline);
							} else {
								$src_string_array['1'] = '<!-- ' . JText::_('SRC_COMMENT') . ': ' . $src_comment . ' ' . JText::_('SRC_LOGIN_TO_SHOW_PHP_DEBUGGING') . ' -->';
							}
						} else {
							$src_string_array['1'] = '<!-- ' . JText::_('SRC_COMMENT') . ': ' . $src_comment . ' -->';
						}
					} else {
						$src_string_array['1'] = '';
					}
				} else {
					$src_new_vars = get_defined_vars();
					$src_diff_vars = array_diff(array_keys($src_new_vars), $src_backup_vars);
					foreach ($src_diff_vars as $src_diff_key) {
						if (substr($src_diff_key, 0, 5) != '_src_' && substr($src_diff_key, 0, 4) != 'src_') {
							$src_vars[$src_diff_key] = $src_new_vars[$src_diff_key];
						}
					}
				}
			}
		}
		$src_str = implode('', $src_string_array);
	}

	// Replace the JavaScript tags by a comment tag if not permitted
	function replaceTagsJS(&$str, $enabled = 1, $security_pass = 1)
	{
		if (!is_string($str) || $str == '') {
			return;
		}

		// quick check to see if i is necessary to do anything
		if ((strpos($str, 'script') === false)) {
			return;
		}

		// Match:
		// <script ...>...</script>
		$tag_regex =
			'(-start-' . '\s*script\s[^' . '-end-' . ']*?[^/]\s*' . '-end-'
				. '(.*?)'
				. '-start-' . '\s*\/\s*script\s*' . '-end-)';
		$string_array = $this->stringToSplitArray($str, $tag_regex, 1);
		$string_array_count = count($string_array);

		// Match:
		// <script ...>
		// single script tags are not xhtml compliant and should not occur, but just incase they do...
		if ($string_array_count == 1) {
			$tag_regex = '(-start-' . '\s*script\s.*?' . '-end-)';
			$string_array = $this->stringToSplitArray($str, $tag_regex, 1);
			$string_array_count = count($string_array);
		}
		if ($string_array_count > 1) {
			if (!$enabled) {
				// replace source block content with HTML comment
				$str = '<!-- ' . JText::_('SRC_COMMENT') . ': ' . JText::sprintf('SRC_OUTPUT_REMOVED_NOT_ALLOWED', array(JText::_('SRC_JAVASCRIPT')), array(JText::_('SRC_JAVASCRIPT'))) . ' -->';
			} else if (!$security_pass) {
				// replace source block content with HTML comment
				$str = '<!-- ' . JText::_('SRC_COMMENT') . ': ' . JText::sprintf('SRC_OUTPUT_REMOVED_SECURUITY', array(JText::_('SRC_JAVASCRIPT')), array(JText::_('SRC_JAVASCRIPT'))) . ' -->';
			}
		}
	}

	// Replace the CSS tags by a comment tag if not permitted
	function replaceTagsCSS(&$str, $enabled = 1, $security_pass = 1)
	{
		if (!is_string($str) || $str == '') {
			return;
		}

		// quick check to see if i is necessary to do anything
		if ((strpos($str, 'style') === false) && (strpos($str, 'link') === false)) {
			return;
		}

		// Match:
		// <script ...>...</script>
		$tag_regex =
			'(-start-' . '\s*style\s[^' . '-end-' . ']*?[^/]\s*' . '-end-'
				. '(.*?)'
				. '-start-' . '\s*\/\s*style\s*' . '-end-)';
		$string_array = $this->stringToSplitArray($str, $tag_regex, 1);
		$string_array_count = count($string_array);

		// Match:
		// <script ...>
		// single script tags are not xhtml compliant and should not occur, but just in case they do...
		if ($string_array_count == 1) {
			$tag_regex = '(-start-' . '\s*link\s[^' . '-end-' . ']*?(rel="stylesheet"|type="text/css").*?' . '-end-)';
			$string_array = $this->stringToSplitArray($str, $tag_regex, 1);
			$string_array_count = count($string_array);
		}

		if ($string_array_count > 1) {
			if (!$enabled) {
				// replace source block content with HTML comment
				$str = '<!-- ' . JText::_('SRC_COMMENT') . ': ' . JText::sprintf('SRC_OUTPUT_REMOVED_NOT_ALLOWED', array(JText::_('SRC_CSS')), array(JText::_('SRC_CSS'))) . ' -->';
			} else if (!$security_pass) {
				// replace source block content with HTML comment
				$str = '<!-- ' . JText::_('SRC_COMMENT') . ': ' . JText::sprintf('SRC_OUTPUT_REMOVED_SECURUITY', array(JText::_('SRC_CSS')), array(JText::_('SRC_CSS'))) . ' -->';
			}
		}
	}

	function stringToSplitArray($str, $search, $tags = 0)
	{
		if ($tags) {
			foreach ($this->src_params->tags_syntax as $src_tag_syntax) {
				$tag_search = str_replace('-start-', $src_tag_syntax['0'], $search);
				$tag_search = str_replace('-end-', $src_tag_syntax['1'], $tag_search);
				$tag_search = '#' . $tag_search . '#si';
				$str = preg_replace($tag_search, $this->src_params->splitter . '\1' . $this->src_params->splitter, $str);
			}
		} else {
			$str = preg_replace($search, $this->src_params->splitter . '\1' . $this->src_params->splitter, $str);
		}
		return explode($this->src_params->splitter, $str);
	}

	function cleanTags(&$str)
	{
		foreach ($this->src_params->tags_syntax as $src_tag_syntax) {
			$tag_regex = '#' . $src_tag_syntax['0'] . '\s*(\/?\s*[a-z\!][^' . $src_tag_syntax['1'] . ']*?(?:\s+.*?)?)' . $src_tag_syntax['1'] . '#si';
			$str = preg_replace($tag_regex, '<\1\2>', $str);
		}
	}

	function cleanArray(&$array)
	{
		// trim all values
		$array = array_map('trim', $array);
		// remove dublicates
		$array = array_unique($array);
		// remove empty (or false) values
		$array = array_filter($array);
	}

	function cleanText(&$str)
	{
		// Load common functions
		require_once JPATH_PLUGINS . '/system/nnframework/helpers/text.php';

		// replace chr style enters with normal enters
		$str = str_replace(array(chr(194) . chr(160), '&#160;', '&nbsp;'), ' ', $str);

		// replace linbreak tags with normal linebreaks (paragraphs, enters, etc).
		$enter_tags = array('p', 'br');
		$regex = '#</?((' . implode(')|(', $enter_tags) . '))+[^>]*?>\n?#si';
		$str = preg_replace($regex, " \n", $str);

		// replace indent characters with spaces
		$str = preg_replace('#<' . 'img [^>]*/sourcerer/images/tab\.png[^>]*>#si', '    ', $str);

		// strip all other tags
		$regex = '#<(/?\w+((\s+\w+(\s*=\s*(?:".*?"|\'.*?\'|[^\'">\s]+))?)+\s*|\s*)/?)>#si';
		$str = preg_replace($regex, "", $str);

		// reset htmlentities
		$str = NNText::html_entity_decoder($str);

		// convert protected html entities &_...; -> &...;
		$str = preg_replace('#&_([a-z0-9\#]+?);#i', '&\1;', $str);
	}

	function createDebuggingOutput(&$str, $script, $errorlinenr)
	{
		$script = str_replace("\n" . '$src_php_succes = 1;', '', $script);
		$script = htmlentities($script);
		$scriptLines = explode("\n", $script);
		$count = count($scriptLines);
		if ($errorlinenr > $count) {
			$str = str_replace('on line <b>' . $errorlinenr . '</b>', 'on line <b>' . $count . '</b>', $str);
			$errorlinenr = $count;
		}
		$script = $this->createNumberedTable($scriptLines, $errorlinenr);
		$this->trimBr($str);
		$id = rand(1000, 9999);
		$str =
			"\n" . '<!-- SORCERER DEBUGGING -->'
				. "\n" . '<div style="clear: both;border: 3px solid #CC3333;background-color: #FFFFFF;">'
				. "\n\t" . '<div id="sourcerer_debugging_' . $id . '_collapsed">'
				. "\n\t\t" . '<div style="float:right;padding: 2px 5px;color:#999999;cursor:pointer;cursor:hand;" onclick="document.getElementById(\'sourcerer_debugging_' . $id . '_expanded\').style.display=\'block\';document.getElementById(\'sourcerer_debugging_' . $id . '_collapsed\').style.display=\'none\';">' . JText::_('SRC_SHOW') . '</div>'
				. "\n\t\t" . '<div style="float:left;font-size:1.2em;padding: 2px 5px;"><strong>' . JText::_('SRC_PHP_DEBUGGING') . '</strong></div>'
				. "\n\t" . '</div>'
				. "\n\t" . '<div style="clear: both;"></div>'
				. "\n\t" . '<div id="sourcerer_debugging_' . $id . '_expanded" style="display:none;">'
				. "\n\t\t" . '<div style="float:right;padding: 2px 5px;color:#999999;cursor:pointer;cursor:hand;" onclick="document.getElementById(\'sourcerer_debugging_' . $id . '_expanded\').style.display=\'none\';document.getElementById(\'sourcerer_debugging_' . $id . '_collapsed\').style.display=\'block\';">' . JText::_('SRC_HIDE') . '</div>'
				. "\n\t\t" . '<div style="float:left;font-size:1.2em;padding: 2px 5px;"><strong>' . JText::_('SRC_PHP_DEBUGGING') . '</strong></div>'
				. "\n\t\t" . '<div style="background-color: #339933;color: #FFFFFF;padding: 2px 5px;"><strong>' . JText::_('SRC_PHP_CODE') . '</strong></div>'
				. "\n\t\t" . '<div style="clear:both;max-height:200px;overflow:auto;position:relative;">' . $script . '</div>'
				. "\n\t\t" . '<div style="background-color: #CC3333;color: #FFFFFF;padding: 2px 5px;"><strong>' . JText::_('SRC_PHP_ERROR') . '</strong></div>'
				. "\n\t\t" . '<div style="background-color: #FFDDDD;padding: 2px 5px;">' . $str . '</div>'
				. "\n\t\t" . '<div style="font-size:0.8em;font-style:italic;padding: 2px 5px;">'
				. "\n\t\t\t" . '<div style="float:right;"><a href="http://www.nonumber.nl/sourcerer" target="_blank">' . JText::_('SRC_MORE_ABOUT') . '</a></div>'
				. "\n\t\t\t" . '<div style="float:left;">' . JText::_('SRC_TO_HIDE_THIS_ERROR_TURN_OFF_PHP_DEBUGGING') . '</div>'
				. "\n\t\t" . '</div>'
				. "\n\t" . '</div>'
				. "\n\t" . '<div style="clear: both;"></div>'
				. "\n" . '</div>';
	}

	function createNumberedTable(&$scriptLines, $errorlinenr)
	{
		$output = '';
		foreach ($scriptLines as $linenr => $scriptLine) {
			$linenr++;
			$scriptLine = str_replace('    ', '&nbsp;&nbsp;&nbsp;&nbsp;', $scriptLine);
			$bgcolor = '#FFFFFF';
			if (fmod($linenr, 2) == 1) {
				$bgcolor = '#F7F7F7';
			}
			if ($errorlinenr == $linenr) {
				$bgcolor = '#FFDDDD';
			}
			$output .=
				"\n\t\t" . '<div style="background-color: ' . $bgcolor . ';position:relative;">'
					. "\n\t\t\t" . '<div style="font-family:monospace;color:#999999;text-align:right;padding: 1px 5px;width: 24px;position: absolute;left:0;">' . $linenr . '</div>'
					. "\n\t\t\t" . '<div style="margin-left: 34px;border-left: 1px solid #DDDDDD;font-family:monospace;padding: 1px 5px;">' . $scriptLine . '</div>'
					. "\n\t\t" . '</div>';
		}
		return $output;
	}

	function trimBr(&$str)
	{
		while (substr($str, 0, 6) == '<br />') {
			$str = trim(substr($str, 6, strlen($str)));
		}
		while (substr($str, strlen($str) - 6, 6) == '<br />') {
			$str = trim(substr($str, 0, strlen($str) - 6));
		}
		$str = trim($str);
	}

	/*
	 * Protect input and text area's
	 */
	function protect(&$str)
	{
		NNProtect::protectForm($str, array($this->src_params->syntax_start, $this->src_params->syntax_start_0, $this->src_params->syntax_end));
	}

	function unprotect(&$str)
	{
		NNProtect::unprotectForm($str, array($this->src_params->syntax_start, $this->src_params->syntax_start_0, $this->src_params->syntax_end));
	}

	function cleanLeftoverJunk(&$str)
	{
		$str = preg_replace('#<\!-- (START|END): SRC_[^>]* -->#', '', $str);
	}
}
