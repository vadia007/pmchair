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
defined('_JEXEC') or die('Restricted access');
jimport('joomla.utilities.simplexml');

/**
 * Script file of Admiror Gallery component
 */
class com_admirorgalleryInstallerScript {

    var $gallery_install_result = 0;
    var $button_install_result = 0;
    var $gallery_uninstall_result = 0;
    var $button_uninstall_result = 0;

    /**
     * method to install the component
     *
     * @return void
     */
    function install($parent) {
        $manifest = $parent->get("manifest");
        $parent = $parent->getParent();
        $source = $parent->getPath("source");

        $installer = new JInstaller();

        // Install plugins
        foreach ($manifest->plugins->plugin as $plugin) {
            $attributes = $plugin->attributes();
            $plg = $source . DS . $attributes['folder'] . DS . $attributes['plugin'];
            $installer->install($plg);
        }

        $db = JFactory::getDbo();
        $tableExtensions = $db->nameQuote("#__extensions");
        $columnElement = $db->nameQuote("element");
        $columnType = $db->nameQuote("type");
        $columnFolder = $db->nameQuote("folder");
        $columnEnabled = $db->nameQuote("enabled");

        // Enable plugins
        $db->setQuery(
                "UPDATE
                    $tableExtensions
                SET
                    $columnEnabled=1
                WHERE
                    $columnElement='admirorgallery'
                AND
                    $columnType='plugin'
                AND
                    $columnFolder='content'"
        );

        $this->gallery_install_result = $db->query();
        // Enable plugins
        $db->setQuery(
                "UPDATE
                    $tableExtensions
                SET
                    $columnEnabled=1
                WHERE
                    $columnElement='admirorbutton'
                AND
                    $columnType='plugin'
                AND
                    $columnFolder='editors-xtd'"
        );

        $this->button_install_result = $db->query();
    }

    /**
     * method to uninstall the component
     *
     * @return void
     */
    function uninstall($parent) {

        $installer = new JInstaller();

        $db = JFactory::getDbo();
        $tableExtensions = $db->nameQuote("#__extensions");
        $columnElement = $db->nameQuote("element");
        $columnType = $db->nameQuote("type");
        $columnFolder = $db->nameQuote("folder");

        // Find AdmirorGallery plugin ID
        $db->setQuery(
                "SELECT extension_id
				FROM 
					$tableExtensions
				WHERE
					$columnElement='admirorgallery'
				AND
					$columnType='plugin'
				AND
					$columnFolder='content'"
        );
        $admirorgallery_id = $db->loadResult();
        $this->gallery_uninstall_result = $installer->uninstall('plugin', $admirorgallery_id);
        // Find AdmirorButton ID
        $db->setQuery(
                "SELECT extension_id
				FROM 
					$tableExtensions
				WHERE
					$columnElement='admirorbutton'
				AND
					$columnType='plugin'
				AND
					$columnFolder='editors-xtd'"
        );
        $admirorbutton_id = $db->loadResult();
        $this->button_uninstall_result = $installer->uninstall('plugin', $admirorbutton_id);

        $gallery_status = ($this->gallery_uninstall_result) ? JText::_('Removed') : JText::_('Error');
        $button_status = ($this->button_uninstall_result) ? JText::_('Removed') : JText::_('Error');
        $html = '<h2>Admiror Gallery ' . JText::_('Uninstall') . '</h2>
                <table class="adminlist">
                        <thead>
                                <tr>
                                        <th class="title" colspan="2">' . JText::_('Extension') . '</th>
                                        <th width="30%">' . JText::_('Status') . '</th>
                                </tr>
                        </thead>
                        <tfoot>
                                <tr>
                                        <td colspan="3"></td>
                                </tr>
                        </tfoot>
                        <tbody>
                                <tr class="row0">
                                        <td class="key" colspan="2">Admiror Gallery ' . JText::_('Component') . '</td>
                                        <td><strong>' . JText::_('Removed') . '</strong></td>
                                </tr>
                                <tr class="row1">
                                        <th>' . JText::_('Plugin') . '</th>
                                        <th>' . JText::_('Group') . '</th>
                                        <th></th>
                                </tr>
                                <tr class="row0">
                                        <td class="key">' . ucfirst('Admiror Gallery Plugin') . '</td>
                                        <td class="key">' . ucfirst('content') . '</td>
                                        <td><strong>' . $gallery_status . '</strong></td>
                                </tr>
                                <tr class="row0">
                                        <td class="key">' . ucfirst('Admiror Button') . '</td>
                                        <td class="key">' . ucfirst('editors-xtd') . '</td>
                                        <td><strong>' . $button_status . '</strong></td>
                                </tr>
                        </tbody>
                </table>';
        echo $html;
    }

    /**
     * method to update the component
     *
     * @return void
     */
    function update($parent) {
        //On update we just call install, no special case for updating.
        $this->install($parent);
    }

    /**
     * method to run before an install/update/uninstall method
     *
     * @return void
     */
    function preflight($type, $parent) {
        
    }

    /**
     * method to run after an install/update/uninstall method
     *
     * @return void
     */
    function postflight($type, $parent) {
        // $parent is the class calling this method
        // $type is the type of change (install, update or discover_install)
        if ($type == 'install') {
            $gallery_status = ($this->gallery_install_result) ? JText::_('Installed') : JText::_('Not installed');
            $button_status = ($this->button_install_result) ? JText::_('Installed') : JText::_('Not installed');
            $html = '<h2>Admiror Gallery Installation</h2>
                <table class="adminlist">
                        <thead>
                                <tr>
                                        <th class="title" colspan="2">' . JText::_('Extension') . '</th>
                                        <th width="30%">' . JText::_('Status') . '</th>
                                </tr>
                        </thead>
                        <tfoot>
                                <tr>
                                        <td colspan="3"></td>
                                </tr>
                        </tfoot>
                        <tbody>
                                <tr class="row0">
                                        <td class="key" colspan="2">Admiror Gallery ' . JText::_('Component') . '</td>
                                        <td><strong>' . JText::_('Installed') . '</strong></td>
                                </tr>
                                <tr class="row1">
                                        <th>' . JText::_('Plugin') . '</th>
                                        <th>' . JText::_('Group') . '</th>
                                        <th></th>
                                </tr>
                                <tr class="row0">
                                        <td class="key">' . ucfirst('Admiror Gallery Plugin') . '</td>
                                        <td class="key">' . ucfirst('content') . '</td>
                                        <td><strong>' . $gallery_status . '</strong></td>
                                </tr>
                                <tr class="row0">
                                        <td class="key">' . ucfirst('Admiror Button') . '</td>
                                        <td class="key">' . ucfirst('editors-xtd') . '</td>
                                        <td><strong>' . $button_status . '</strong></td>
                                </tr>
                        </tbody>
                </table>';
            echo $html;
        }
    }

}