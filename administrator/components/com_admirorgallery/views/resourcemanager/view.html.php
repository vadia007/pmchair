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
// no direct access
defined( '_JEXEC' ) or die( 'Restricted access' );

jimport( 'joomla.application.component.view');

class AdmirorgalleryViewResourcemanager extends JView
{

    function display($tpl = null)
    {
          $AG_resourceType = JRequest::getVar( 'AG_resourceType' );// Current resource type
	  JToolBarHelper::title( JText::_( 'COM_ADMIRORGALLERY_'.strtoupper($AG_resourceType)), $AG_resourceType);
	  parent::display($tpl);
    }
}
