<?php
/*------------------------------------------------------------------------
# com_admirorgallery - Admiror Gallery Component
# ------------------------------------------------------------------------
# author   Igor Kekeljevic & Nikola Vasiljevski
# copyright Copyright (C) 2011 admiror-design-studio.com. All Rights Reserved.
# @license - http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
# Websites: http://www.admiror-design-studio.com/joomla-extensions
# Technical Support:  Forum - http://www.vasiljevski.com/forum/index.php
# Version: 4.5.0
-------------------------------------------------------------------------*/
defined( '_JEXEC' ) or die( 'Restricted access' );

JRequest::setVar( 'AG_frontEnd', 'true' );

require_once (JPATH_COMPONENT_ADMINISTRATOR.DS.'views'.DS.'imagemanager'.DS.'tmpl'.DS.'default.php');

?>
