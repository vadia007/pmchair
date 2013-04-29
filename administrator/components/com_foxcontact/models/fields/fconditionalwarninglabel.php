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
*/

defined('JPATH_BASE') or die;
jimport('joomla.html.html');
jimport('joomla.form.formfield');

class JFormFieldFConditionalWarningLabel extends JFormField
	{
	protected $type = 'FConditionalWarningLabel';
	
	protected function getInput()
		{
		return '';
		}

	protected function getLabel()
		{
		$cn = basename(realpath(dirname(__FILE__) . DS . '..' . DS . '..'));

		$direction = intval(JFactory::getLanguage()->get('rtl', 0));
		$left  = $direction ? "right" : "left";
		$right = $direction ? "left" : "right";

		$db = JFactory::getDBO();
		$sql = "SELECT value FROM #__" . substr($cn, 4) . "_settings WHERE name = '" . $this->element['triggerkey'] . "';";
		$db->setQuery($sql);
		$method = $db->loadResult();

		if (!$method)			 
			{
			// Database error. Example: table missing. $method = NULL, $db->_errornum = 1146, $db->_errormsg = table doesn't exist
			// Record missing. $method = NULL, $db->_errornum = 0, $db->_errormsg = ""
			// $db->getErrorNum()
			// $db->getErrorMsg()
			$style = 'clear:both; background:#f4f4f4; border:1px solid silver; padding:5px; margin:5px 0;';
			$image .= '<img style="margin:0; float:' . $left . ';" src="' . JURI::base() . '../media/' . $cn . '/images/exclamation-16.png">';
			return
				'<div style="' . $style . '">' .
				$image .
				'<span style="padding-' . $left . ':5px; line-height:16px;">' .
				JText::_(strtoupper($cn) . '_ERR_DATABASE_PROBLEMS') .
				' <a href="http://www.fox.ra.it/forum/15-installation/1579-error-message-qproblems-with-databaseq.html" target="_blank">' .
				JText::_(strtoupper($cn) . '_DOCUMENTATION') .
				'</a>.' .
				'</span>' .
				'</div>';
			}

		if (/*$method &&*/ $method != $this->element['triggervalue'])
			{
			return "";
			}

		echo '<div class="clr"></div>';
		$image = '';		
		$icon	= (string)$this->element['icon'];		
		if (!empty($icon))
			{
			//$image 	= JHTML::_('image', 'media/com_foxcontact/images/'. $icon, '' );
			$image .= '<img style="margin:0; float:' . $left . ';" src="' . JURI::base() . '../media/' . $cn . '/images/' . $icon . '">';
			}

		$style = 'background:#f4f4f4; border:1px solid silver; padding:5px; margin:5px 0;';
		if ($this->element['default'])
			{		
			return '<div style="' . $style . '">' .
				$image .
				'<span style="padding-' . $left . ':5px; line-height:16px;">' .
				JText::_($this->element['default']) .
				'. <a href="' . $this->element['triggerdata'] . '" target="_blank">' .
				JText::_(strtoupper($cn) . '_DOCUMENTATION') .
				'</a>.' .
				'</span>' .
				'</div>';
			}
		else
			{
			return parent::getLabel();
			}

		echo '<div class="clr"></div>';
		}
	}
?>
