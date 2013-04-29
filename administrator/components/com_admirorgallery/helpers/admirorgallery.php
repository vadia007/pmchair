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
// No direct access to this file
defined('_JEXEC') or die;

/**
 * AdmirorGallery component helper.
 */
abstract class AdmirorGalleryHelper
{
	/**
	 * Configure the Linkbar.
	 */
	public static function addSubmenu($submenu,$type)
	{
		JSubMenuHelper::addEntry(JText::_('COM_ADMIRORGALLERY_CONTROL_PANEL'),
		                         'index.php?option=com_admirorgallery&amp;controller=admirorgallery', $submenu == 'control_panel');
		JSubMenuHelper::addEntry(JText::_('COM_ADMIRORGALLERY_TEMPLATES'),
		                         'index.php?option=com_admirorgallery&amp;view=resourcemanager&amp;AG_resourceType=templates',
		                         $type == 'templates');
		JSubMenuHelper::addEntry(JText::_('COM_ADMIRORGALLERY_POPUPS'),
		                         'index.php?option=com_admirorgallery&amp;view=resourcemanager&amp;AG_resourceType=popups',
		                         $type == 'popups');
		JSubMenuHelper::addEntry(JText::_('COM_ADMIRORGALLERY_IMAGE_MANAGER'),
		                         'index.php?option=com_admirorgallery&amp;view=imagemanager',
		                         $submenu == 'imagemanager');
	}
}

?>
