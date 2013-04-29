<?php
/*
This file is part of "Fox Joomla Extensions".

You can redistribute it and/or modify it under the terms of the GNU General Public License
GNU/GPLv3 http://www.gnu.org/licenses/gpl-3.0.html

You have the freedom:
	* to use this software for both commercial and non-commercial purposes
	* to share, copy, distribute and install this software and charge for it if you wish.
Under the following conditions:
	* You must attribute the work to the original author by leaving untouched the link "powered by",
	  except if you obtain a "registerd version" http://www.fox.ra.it/forum/14-licensing/151-remove-the-backlink-powered-by-fox-contact.html

Author: Demis Palma
Documentation at http://www.fox.ra.it/forum/2-documentation.html

@version		$Id: hidden.php 20196 2011-01-09 02:40:25Z ian $
*/

defined('JPATH_BASE') or die;

jimport('joomla.form.formfield');

class JFormFieldFTranschecker extends JFormField
	{
	protected $type = 'FTranschecker';

	protected function getInput()
		{
		return "";
		}

	protected function getLabel()
		{
		$lang = JFactory::getLanguage();

		$cn = basename(realpath(dirname(__FILE__) . DS . '..' . DS . '..'));
		$direction = intval($lang->get('rtl', 0));
		$left  = $direction ? "right" : "left";
		$right = $direction ? "left" : "right";
		$image = '<img style="margin:0; float:' . $left . ';" src="' . JURI::base() . '..' . DS . 'media' . DS . $cn . DS . 'images' . DS . 'translations.png' . '">';
		$style = 'background:#f4f4f4; border:1px solid silver; padding:5px; margin:5px 0;';
		$msg_skel = 
			'<div style="' . $style . '">' .
			$image .
			'<span style="padding-' . $left . ':5px; line-height:16px;">' .
			'Admin side translation for %s language is still %s. Please consider to contribute by writing and sharing your own translation. <a href="http://www.fox.ra.it/forum/19-languages-and-translations/1265-how-to-write-your-own-translation.html" target="_blank">Learn more.</a>' .
			'</span>' .
			'</div>';


		if (intval(JText::_(strtoupper($cn) . '_PARTIAL')))
			{
			return sprintf($msg_skel, $lang->get("name"), "incomplete");
			}

		if (!file_exists(JPATH_ADMINISTRATOR . DS . "language" . DS . $lang->get("tag") . DS . $lang->get("tag") . "." . $cn . ".ini"))
			{
			return sprintf($msg_skel, $lang->get("name"), "missing") . $suffix;
			}

		return "";
		}
	}