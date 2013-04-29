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

class AdmirorgalleryModelResourcemanager extends JModel
{
    function _install($file) {

	  $AG_resourceType = JRequest::getVar( 'AG_resourceType' );// Current resource type
	  $config =JFactory::getConfig();
	  $tmp_dest = $config->getValue('config.tmp_path');
	  $resourceType = substr($AG_resourceType,0,strlen($AG_resourceType)-1);	

	  $file_type = "zip";

	  if(isset($file) && !empty($file['name'])){ 
	       //Clean up filename to get rid of strange characters like spaces etc
	       $filename = JFile::makeSafe($file['name']);
	       $ext = strtolower(pathinfo($filename, PATHINFO_EXTENSION));

	       $src = $file['tmp_name'];
	       $dest = $tmp_dest.DS.$filename;

	       //First check if the file has the right extension
	       if ($ext == $file_type) {
		    if ( JFile::upload($src, $dest) ) {

			      if(JArchive::extract($tmp_dest.DS.$filename, JPATH_SITE.DS.'plugins'.DS.'content'.DS.'admirorgallery'.DS.'admirorgallery'.DS.$AG_resourceType )){
				   JFile::delete($tmp_dest.DS.$filename);
			      }

			      // TEMPLATE DETAILS PARSING
			      if(JFIle::exists(JPATH_SITE.DS.'plugins'.DS.'content'.DS.'admirorgallery'.DS.'admirorgallery'.DS.$AG_resourceType.DS.JFile::stripExt($filename).DS.'details.xml')){
				   $ag_resourceManager_xml = JFactory::getXMLParser( 'simple' );
				   $ag_resourceManager_xml->loadFile(JPATH_SITE.DS.'plugins'.DS.'content'.DS.'admirorgallery'.DS.'admirorgallery'.DS.$AG_resourceType.DS.JFile::stripExt($filename).DS.'details.xml');
				   if(isset($ag_resourceManager_xml->document->type[0])){
					$ag_resourceManager_type = $ag_resourceManager_xml->document->type[0]->data();	
				   }
			      }

			      if($ag_resourceManager_type == $resourceType){
				   JFactory::getApplication()->enqueueMessage( JText::_( 'AG_ZIP_PACKAGE_IS_INSTALLED' )."&nbsp;".$filename, 'message' );
			      }else{
				   JFolder::delete(JPATH_SITE.DS.'plugins'.DS.'content'.DS.'admirorgallery'.DS.'admirorgallery'.DS.$AG_resourceType.DS.JFile::stripExt($filename));
				   JFactory::getApplication()->enqueueMessage( JText::_( 'AG_ZIP_PACKAGE_IS_NOT_VALID_RESOURCE_TYPE' )."&nbsp;".$filename, 'error' );
			      }
		    } else {
			 JFactory::getApplication()->enqueueMessage( JText::_( 'AG_CANNOT_UPLOAD_FILE_TO_TEMP_FOLDER_PLEASE_CHECK_PERMISSIONS' ), 'error' );
		    }
	       } else {
		    JFactory::getApplication()->enqueueMessage( JText::_( 'AG_ONLY_ZIP_ARCHIVES_CAN_BE_INSTALLED' ), 'error' );
	       }
	  }
    }

    function _uninstall($ag_cidArray) {	  
	  $AG_resourceType = JRequest::getVar( 'AG_resourceType' );// Current resource type
	  foreach($ag_cidArray as $ag_cidArrayKey => $ag_cidArrayValue){
		    if(!empty($ag_cidArrayValue)){
			 if(JFolder::delete(JPATH_SITE.DS.'plugins'.DS.'content'.DS.'admirorgallery'.DS.'admirorgallery'.DS.$AG_resourceType.DS.$ag_cidArrayValue)){
			      JFactory::getApplication()->enqueueMessage( JText::_( 'AG_PACKAGE_REMOVED' )."&nbsp;".$ag_cidArrayValue, 'message' );
			 }else{
			      JFactory::getApplication()->enqueueMessage( JText::_( 'AG_PACKAGE_CANNOT_BE_REMOVED' )."&nbsp;".$ag_cidArrayValue, 'error' );
			 }
		    }
	  }
    }

}
