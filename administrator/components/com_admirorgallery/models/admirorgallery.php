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
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die();
 
jimport( 'joomla.application.component.model' );

class AdmirorgalleryModelAdmirorgallery extends JModel
{
    function _update() {
	  $AG_DB_input='{';

	  foreach($_POST['params'] as $key => $value){
	       $AG_DB_input.= '"'.$key.'":"'.$value.'",';
	  }
          $AG_DB_input = substr_replace($AG_DB_input ,'}',-1,1);
          
	  $db = JFactory::getDBO();
	  $query = "UPDATE #__extensions SET params='".$AG_DB_input."' WHERE (element = 'admirorgallery') AND (type = 'plugin')"; // This change value
	  $db->setQuery($query);
	  if($db->query()){
	       JFactory::getApplication()->enqueueMessage( JText::_( "AG_PARAMS_UPDATED" ), 'message' );
	  }else{
	       JFactory::getApplication()->enqueueMessage( JText::_( "AG_CANNOT_ACCESS_TO_DATABASE" ), 'error' );
	  }  
    }

}
