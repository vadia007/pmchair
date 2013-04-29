<?php defined('_JEXEC') or die;
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

if (version_compare(JVERSION, '1.6.0', '<'))
	{
	JError::raiseWarning(500, 'This extension requires Joomla 1.6 or newer. See the <a href="http://www.fox.ra.it/forum/15-installation/77-joomla-compatibility-list.html" target="_blank">compatibility list</a>.');
	}

?>
