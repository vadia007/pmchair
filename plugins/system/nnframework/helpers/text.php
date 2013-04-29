<?php
/**
 * NoNumber Framework Helper File: Text
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

/**
 * Functions
 */
class NNText
{
	public static function dateToDateFormat($dateFormat)
	{
		$caracs = array(
			// Day
			'%d' => 'd',
			'%a' => 'D',
			'%#d' => 'j',
			'%A' => 'l',
			'%u' => 'N',
			'%w' => 'w',
			'%j' => 'z',
			// Week
			'%V' => 'W',
			// Month
			'%B' => 'F',
			'%m' => 'm',
			'%b' => 'M',
			// Year
			'%G' => 'o',
			'%Y' => 'Y',
			'%y' => 'y',
			// Time
			'%P' => 'a',
			'%p' => 'A',
			'%l' => 'g',
			'%I' => 'h',
			'%H' => 'H',
			'%M' => 'i',
			'%S' => 's',
			// Timezone
			'%z' => 'O',
			'%Z' => 'T',
			// Full Date / Time
			'%s' => 'U'
		);
		return strtr((string) $dateFormat, $caracs);
	}

	public static function dateToStrftimeFormat($dateFormat)
	{
		$caracs = array(
			// Day - no strf eq : S
			'd' => '%d',
			'D' => '%a',
			'jS' => '%#d[TH]',
			'j' => '%#d',
			'l' => '%A',
			'N' => '%u',
			'w' => '%w',
			'z' => '%j',
			// Week - no date eq : %U, %W
			'W' => '%V',
			// Month - no strf eq : n, t
			'F' => '%B',
			'm' => '%m',
			'M' => '%b',
			// Year - no strf eq : L; no date eq : %C, %g
			'o' => '%G',
			'Y' => '%Y',
			'y' => '%y',
			// Time - no strf eq : B, G, u; no date eq : %r, %R, %T, %X
			'a' => '%P',
			'A' => '%p',
			'g' => '%l',
			'h' => '%I',
			'H' => '%H',
			'i' => '%M',
			's' => '%S',
			// Timezone - no strf eq : e, I, P, Z
			'O' => '%z',
			'T' => '%Z',
			// Full Date / Time - no strf eq : c, r; no date eq : %c, %D, %F, %x
			'U' => '%s'
		);
		return strtr((string) $dateFormat, $caracs);
	}

	public static function html_entity_decoder($given_html, $quote_style = ENT_QUOTES, $charset = 'UTF-8')
	{
		if (is_array($given_html)) {
			foreach ($given_html as $i => $html) {
				$given_html[$i] = self::html_entity_decoder($html);
			}
			return $given_html;
		}
		return html_entity_decode($given_html, $quote_style, $charset);
	}

	public static function cleanTitle($str, $striptags = 0)
	{
		// remove comment tags
		$str = preg_replace('#<\!--.*?-->#s', '', $str);

		if ($striptags) {
			// remove html tags
			$str = preg_replace('#</?[a-z][^>]*>#usi', '', $str);
		}

		return trim($str);
	}

	public static function prepareSelectItem($str, $published = 1, $type = '', $remove_first = 0)
	{

		$str = str_replace(array('&nbsp;', '&#160;'), ' ', $str);
		$str = preg_replace('#- #', '  ', $str);
		for ($i = 0; $remove_first > $i; $i++) {
			$str = preg_replace('#^  #', '', $str);
		}
		preg_match('#^( *)(.*)$#', $str, $match);
		list($str, $pre, $name) = $match;

		$pre = preg_replace('#  #', ' ·  ', $pre);
		$pre = preg_replace('#(( ·  )*) ·  #', '\1 »  ', $pre);
		$pre = str_replace(' ', '&nbsp;', $pre);

		if ($type == 'separator') {
			$pre = '[[:font-weight:normal;font-style:italic;color:grey;:]]' . $pre;
		} else if (!$published) {
			$pre = '[[:font-style:italic;color:grey;:]]' . $pre;
			$name = $name . ' [' . JText::_('JUNPUBLISHED') . ']';
		} else if ($published == 2) {
			$pre = '[[:font-style:italic;:]]' . $pre;
			$name = $name . ' [' . JText::_('JARCHIVED') . ']';
		}

		return $pre . $name;
	}
}
