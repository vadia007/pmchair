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

jimport( 'joomla.application.component.controller' );

// Preloading joomla tools
jimport( 'joomla.installer.helper' );
jimport('joomla.filesystem.file');
jimport('joomla.filesystem.archive');
jimport('joomla.html.pagination');
jimport('joomla.filesystem.folder');
JHTML::_('behavior.tooltip');

class AdmirorgalleryControllerResourcemanager extends AdmirorgalleryController
{
	/**
	 * Constructor
	 */
	function __construct()
	{
		parent::__construct();

		// Register Extra tasks
		$this->registerTask( 'AG_apply', 'AG_apply' );
		$this->registerTask( 'AG_reset', 'AG_reset' );
	}

	function AG_apply()
	{

	       $model = $this->getModel('resourcemanager');

	       // INSTALL
	       $file = JRequest::getVar( 'AG_fileUpload', null, 'files' );
	       if(isset($file) && !empty($file['name'])){ 
		    $model->_install($file);
	       }

	       // UNINSTALL
	       $ag_cidArray = JRequest::getVar( 'cid' );
	       if(!empty($ag_cidArray)){
		    $model->_uninstall($ag_cidArray);
	       }

	       parent::display();
	}

	function AG_reset()
	{
	    parent::display();
	}


}
