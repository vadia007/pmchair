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
defined('_JEXEC') or die('Restricted access');

jimport('joomla.application.component.view');

class AdmirorgalleryViewImagemanager extends JView {

    function display($tpl = null) {

        // Make sure you are logged in and have the necessary access
        $validUsers = array(5 /*Publisher*/,6/*Manager*/,7/*Administrator*/,8/*Super Users*/);
        $user = JFactory::getUser();
        $grantAccess = false;
        $userGroups = $user->getAuthorisedGroups();
        foreach ($userGroups as $group) {
            if(in_array($group, $validUsers))
            {
                $grantAccess = true;
                break;
            }
        }
        if(!$grantAccess)
        {
            JResponse::setHeader('HTTP/1.0 403',true);
            JError::raiseWarning( 403, JText::_('JERROR_ALERTNOAUTHOR') );
            return;
        }
        $mainframe = JFactory::getApplication();
        $params = $mainframe->getParams();

        $this->assign('galleryName', $params->get('galleryName'));

        parent::display($tpl);
    }

    function _renderBreadcrumb($AG_itemURL, $ag_rootFolder, $ag_folderName, $ag_fileName) {
        $ag_breadcrumb = '';
        $ag_breadcrumb_link = '';
        if ($ag_rootFolder != $AG_itemURL && !empty($AG_itemURL)) {
            $ag_breadcrumb.='<a href="' . $ag_rootFolder . '" class="AG_folderLink AG_common_button"><span><span>' . substr($ag_rootFolder, 0, -1) . '</span></span></a>/';
            $ag_breadcrumb_link.=$ag_rootFolder;
            $ag_breadcrumb_cut = substr($ag_folderName, strlen($ag_rootFolder));
            $ag_breadcrumb_cut_array = explode("/", $ag_breadcrumb_cut);
            if (!empty($ag_breadcrumb_cut_array[0])) {
                foreach ($ag_breadcrumb_cut_array as $cut_key => $cut_value) {
                    $ag_breadcrumb_link.=$cut_value . '/';
                    $ag_breadcrumb.='<a href="' . $ag_breadcrumb_link . '" class="AG_folderLink AG_common_button"><span><span>' . $cut_value . '</span></span></a>/';
                }
            }
            $ag_breadcrumb.=$ag_fileName;
        } else {
            $ag_breadcrumb.=$ag_rootFolder;
        }
        return $ag_breadcrumb;
    }

}
