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
defined('_JEXEC') or die('Restricted access');
//Check if plugin is installed, othervise don't show view
if (!is_dir(JPATH_SITE . '/plugins/content/admirorgallery/')) {
    return;
}
jimport('joomla.filesystem.file');
jimport('joomla.form.form');

$AG_templateID = JRequest::getVar('AG_template'); // Current template for AG Component
?>

<form action="index.php" method="post" id="adminForm" name="adminForm">

    <input type="hidden" name="option" value="com_admirorgallery" />
    <input type="hidden" name="task" value="" />
    <input type="hidden" name="view" value="" />
    <input type="hidden" name="controller" value="admirorgallery" />

    <?php

    function quickiconButton($link, $image, $text, $AG_templateID) {
        $lang = JFactory::getLanguage();
        ($lang->isRTL()) ? $iconFloat = "right" : $iconFloat = "left";
        echo '
          <div style="float:' . $iconFloat . '">
               <div class="ag_guickIcon">
                    <a href="' . $link . '">
                         <img src="' . JURI::base() . 'components/com_admirorgallery/templates/' . $AG_templateID . '/images/toolbar/' . $image . '" />
                         <span>' . $text . '</span>
                    </a>
               </div>
          </div>
     ';
    }

    echo '
<div id="ag_controlPanel_wrapper">
';
    quickiconButton('index.php?option=com_admirorgallery&view=resourcemanager&AG_resourceType=templates', 'icon-48-templates.png', JText::_('COM_ADMIRORGALLERY_TEMPLATES'), $AG_templateID);
    quickiconButton('index.php?option=com_admirorgallery&view=resourcemanager&AG_resourceType=popups', 'icon-48-popups.png', JText::_('COM_ADMIRORGALLERY_POPUPS'), $AG_templateID);
    quickiconButton('index.php?option=com_admirorgallery&view=imagemanager', 'icon-48-imagemanager.png', JText::_('COM_ADMIRORGALLERY_IMAGE_MANAGER'), $AG_templateID);

    echo '
<br style="clear:both" /><br />
<table border="0" cell>
  <tr>
<td style=" width:50%">
<div style="display:block; border-style:solid;" class="AG_border_color AG_border_width AG_background_color AG_base_font">
<form action="' . JURI::getInstance()->toString() . '" method="post" name="adminForm">

' . "\n";
    $db = JFactory::getDBO();
    $query = "SELECT * FROM #__extensions WHERE (element = 'admirorgallery') AND (type = 'plugin')";
    $db->setQuery($query);
    $row = $db->loadAssoc();
//print_r($paramsdata);
    $paramsdefs = JPATH_SITE . '/administrator/components/com_admirorgallery/config.xml';
//$paramsdefs = JPATH_SITE.'/plugins/content/admirorgallery/admirorgallery.xml';
    $myparams = JForm::getInstance('AG_Settings', $paramsdefs);
    
    $values = array('params' => json_decode($row['params']));
    $myparams->bind($values);

    $fieldSets = $myparams->getFieldsets();

    foreach ($fieldSets as $name => $fieldSet) :
        $label = !empty($fieldSet->label) ? $fieldSet->label : 'COM_PLUGINS_' . $name . '_FIELDSET_LABEL';
        //echo JHtml::_('sliders.panel', JText::_($label), $name.'-options');
        if (isset($fieldSet->description) && trim($fieldSet->description)) :
        //echo '<p class="tip">'.$this->escape(JText::_($fieldSet->description)).'</p>';
        endif;
        ?>
        <fieldset class="panelform">
            <?php $hidden_fields = ''; ?>
            <ul class="adminformlist">
                <?php foreach ($myparams->getFieldset($name) as $field) : ?>
                    <?php if (!$field->hidden) : ?>
                        <li>
                            <?php echo $field->label; ?>
                            <?php echo $field->input; ?>
                        </li>
                    <?php else : $hidden_fields.= $field->input; ?>
                    <?php endif; ?>
                <?php endforeach; ?>
            </ul>
            <?php echo $hidden_fields; ?>
        </fieldset>
    <?php endforeach; ?>
    <?php
    echo '
<input type="hidden" name="pressbutton" value="" id="pressbutton" />
</form>
</div>
<br style="clear:both" />
';

    if (JFIle::exists(JPATH_COMPONENT_ADMINISTRATOR . '/com_admirorgallery.xml')) {
        $ag_admirorgallery_xml = JFactory::getXMLParser('simple');
        $ag_admirorgallery_xml->loadFile(JPATH_COMPONENT_ADMINISTRATOR . '/com_admirorgallery.xml');
        $ag_admirorgallery_version_component = $ag_admirorgallery_xml->document->version[0]->data();
        $ag_admirorgallery_version_plugin = $ag_admirorgallery_xml->document->plugin_version[0]->data();
        $ag_admirorgallery_version_button = $ag_admirorgallery_xml->document->button_version[0]->data();
        echo JText::_('AG_COMPONENT_VERSION') . '&nbsp;' . $ag_admirorgallery_version_component . "<br />";
        echo JText::_('AG_PLUGIN_VERSION') . '&nbsp;' . $ag_admirorgallery_version_plugin . "<br />";
        echo JText::_('AG_BUTTON_VERSION') . '&nbsp;' . $ag_admirorgallery_version_button . "<br />";
    }

    echo '
</td>
<td style="vertical-align:text-top; width:50%" class="AG_descriptionWrapper">
' . "\n";



    echo JText::_('AG_ADMIRORGALLERY_DESCRIPTION');


    echo '
</td>
  </tr>
</table>
</div>
';
    ?>

</form>
