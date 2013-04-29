<?php
/**
 * Element: Articles
 * Displays an article id field with a button
 *
 * @package         NoNumber Framework
 * @version         12.11.6
 *
 * @author          Peter van Westen <peter@nonumber.nl>
 * @link            http://www.nonumber.nl
 * @copyright       Copyright © 2012 NoNumber All Rights Reserved
 * @license         http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

defined('_JEXEC') or die;

class JFormFieldNN_Articles extends JFormField
{
	public $type = 'Articles';

	protected function getInput()
	{
		$this->params = $this->element->attributes();

		JHtml::_('behavior.modal', 'a.modal');

		$_size = $this->def('size');
		$_multiple = $this->def('multiple', 1);

		$_doc = JFactory::getDocument();

		$_js_part = "
			if ( document.getElementById(object+'_name') ) {
				document.getElementById(object+'_id').value = id;
				document.getElementById(object+'_name').value = title;
			} else {
				// multiple
				var vals = document.getElementById(object+'_id').value.trim().split(',');
				vals[vals.length] = id;
				var tmpvals = [];
				for ( var i=0; i<vals.length; i++ ) {
					val = vals[i].trim().toInt();
					if ( val ) {
						tmpvals[val] = val;
					}
				}
				vals = [];
				for ( val in tmpvals ) {
					if ( typeof(tmpvals[val]) === 'number'  ) {
						vals[vals.length] = tmpvals[val];
					}
				}
				document.getElementById(object+'_id').value = vals.join();
			}";

		$_js = "
			function nnSelectArticle_" . $this->id . "( id, title, catid )
			{
				var object = '" . $this->id . "';
				" . $_js_part . "
				SqueezeBox.close();
			}";
		$_doc->addScriptDeclaration($_js);
		$_link = 'index.php?option=com_content&amp;view=articles&amp;layout=modal&amp;tmpl=component&amp;function=nnSelectArticle_' . $this->id;

		$html = "\n" . '<div style="float: left;">';
		if (!$_multiple) {
			$val_name = $this->value;
			if ($this->value) {
				$db = JFactory::getDBO();
				$query = $db->getQuery(true);
				$query->select('c.title');
				$query->from('#__content AS c');
				$query->where('c.id = ' . (int) $this->value);
				$db->setQuery($query);
				$val_name = $db->loadResult();
				$val_name .= ' [' . $this->value . ']';
			}
			$html .= '<input type="text" id="' . $this->id . '_name" value="' . $val_name . '" class="inputbox" size="' . $_size . '" disabled="disabled" />';
			$html .= '<input type="hidden" name="' . $this->name . '" id="' . $this->id . '_id" value="' . $this->value . '" />';
		} else {
			$html .= '<input type="text" name="' . $this->name . '" id="' . $this->id . '_id" value="' . $this->value . '" class="inputbox" size="' . $_size . '" />';
		}
		$html .= '</div>';
		$html .= '<div class="button2-left"><div class="blank"><a class="modal" title="' . JText::_('NN_SELECT_AN_ARTICLE') . '"  href="' . $_link . '" rel="{handler: \'iframe\', size: {x: 650, y: 375}}">' . JText::_('NN_SELECT') . '</a></div></div>' . "\n";

		return $html;
	}

	private function def($val, $default = '')
	{
		return (isset($this->params[$val]) && (string) $this->params[$val] != '') ? (string) $this->params[$val] : $default;
	}
}
