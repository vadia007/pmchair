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

class JFormFieldFEnvironment extends JFormField
	{
	protected $type = 'FEnvironment';

	protected function getInput()
		{
		return "";
		}

	protected function getLabel()
		{
		$lang = JFactory::getLanguage();
		// If we are in the module, loads component language too
		$lang->load("com_foxcontact");
		$lang->load("com_foxcontact.sys");
		return "";
		}
	}