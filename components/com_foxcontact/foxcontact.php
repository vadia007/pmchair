<?php defined('_JEXEC') or die('Restricted access');
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

	$GLOBALS["ext_name"] = basename(__FILE__);
	$GLOBALS["com_name"] = dirname(__FILE__);
	$GLOBALS["mod_name"] = realpath(dirname(__FILE__) . DS . ".." . DS . ".." . DS . "modules");
	$GLOBALS["EXT_NAME"] = strtoupper($GLOBALS["ext_name"]);
	$GLOBALS["COM_NAME"] = strtoupper($GLOBALS["com_name"]);
	$GLOBALS["MOD_NAME"] = strtoupper($GLOBALS["mod_name"]);
	$GLOBALS["left"] = false;
	$GLOBALS["right"] = true;
	//$site = new JSite();
	//$menu = $site->getMenu();
	$application = JFactory::getApplication('site');
	$menu = $application->getMenu();
	$activemenu = $menu->getActive();
	$application->cid = $activemenu->id;
	$application->mid = 0;
	$application->submitted = (bool)count($_POST) && isset($_POST["cid_$application->cid"]);
	$me = basename(__FILE__);
	$name = substr($me, 0, strrpos($me, '.'));
	include(realpath(dirname(__FILE__) . DS . $name . ".inc"));

	require_once(realpath(dirname(__FILE__) . DS . 'lib') . DS . 'functions.php');

	if ($activemenu)
	{
		$document = JFactory::getDocument();

		// The following code will access the Component-wide default parameters,
		// already overridden with those for the menu item (if applicable):
		$params = JFactory::getApplication()->getParams('com_foxcontact');
		// Add a stylesheet
		$document->addStyleSheet(JURI::base(true) . '/components/' . $application->scope . "/css/" . $params->get("stylesheet", "neon.css"));

		// import joomla controller library
		jimport('joomla.application.component.controller');

		// Get an instance of the controller prefixed by FoxContact
		$controller = JController::getInstance('FoxContact');

		// Perform the Request task
		$controller->execute(JRequest::getCmd('task'));

		// Redirect if set by the controller
		$controller->redirect();
	}
	else
	{
		$language = JFactory::getLanguage();

		echo("<h2>" . $language->_($GLOBALS["COM_NAME"] . "_ERR_PROVIDE_VALID_URL") . "</h2>");

		$valid_items = $menu->getItems("component", $GLOBALS["com_name"]);

		echo("<ul>");
		foreach ($valid_items as &$valid_item)
		{
			// $id = $valid_item->id;
			// $link = $valid_item->link;
			echo('<li><a href="' . FGetLink($valid_item->id) . '">' . $valid_item->title . '</a></li>');
		}
		echo("</ul>");

		// See the documentation string
		$language->load('com_foxcontact.sys', JPATH_ADMINISTRATOR);
		echo('<p><a href="http://www.fox.ra.it/forum/22-how-to/1574-hide-the-contact-page-menu-item.html">' . $language->_($GLOBALS["COM_NAME"] . "_DOCUMENTATION") . "</a></p>");
	}
?>
