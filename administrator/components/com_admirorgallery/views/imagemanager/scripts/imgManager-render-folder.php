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
/** ensure this file is being included by a parent file */
defined('_JEXEC') or die('Restricted access');

require_once (JPATH_SITE . DS . 'plugins' . DS . 'content' . DS . 'admirorgallery' . DS . 'admirorgallery' . DS . 'classes' . DS . 'agHelper.php');

$ag_itemURL = $ag_init_itemURL;

$ag_XML_thumb = "";

$ag_folderName = dirname($ag_itemURL);
$ag_fileName = basename($ag_itemURL);

$thumbsFolderPhysicalPath = JPATH_SITE . DS . 'administrator' . DS . 'components' . DS . 'com_admirorgallery' . DS . 'assets' . DS . 'thumbs';

agHelper::ag_sureRemoveDir($thumbsFolderPhysicalPath, true);
if (!JFolder::create($thumbsFolderPhysicalPath, 0755)) {
    JFactory::getApplication()->enqueueMessage(JText::_("AG_CANNOT_CREATE_FOLDER") . "&nbsp;" . $newFolderName, 'error');
}

function ag_render_caption($ag_lang_name, $ag_lang_tag, $ag_lang_content) {
    return '
	<div class="AG_border_color AG_border_width AG_margin_bottom">
	    ' . $ag_lang_name . ' / ' . $ag_lang_tag . '
	    <textarea class="AG_textarea" name="AG_desc_content[]">' . $ag_lang_content . '</textarea><input type="hidden" name="AG_desc_tags[]" value="' . $ag_lang_tag . '" />
	</div>
    ';
}

$ag_preview_content = '';

$ag_preview_content.='
<hr />
' . "\n";

$ag_preview_content.='
<h1>' . JText::_('AG_CURRENT_FOLDER') . '</h1>

<div class="AG_breadcrumbs_wrapper">
     ' . $this->_renderBreadcrumb($ag_itemURL, $ag_starting_folder, $ag_folderName, $ag_fileName) . '
</div>
<hr />

<table cellspacing="0" cellpadding="0" border="0" class="AG_fieldset">
     <tbody>
     <tr>
          <td>
                <img src="' . JURI::root() . 'administrator/components/com_admirorgallery/templates/' . $AG_templateID . '/images/operations.png" style="float:left;" />
          </td>
	      <td>
	            ' . JText::_('AG_OPERATION_WITH_SELECTED_ITEMS') . '
	      </td>
	      <td>
            <select id="AG_operations" name="AG_operations">
                <option value="none" >' . JText::_('AG_NONE') . '</option>
                <option value="delete" >' . JText::_('AG_DELETE') . '</option>
                <option value="copy">' . JText::_('AG_COPY_TO') . '</option>
                <option value="move">' . JText::_('AG_MOVE_TO') . '</option>
                <option value="bookmark">' . JText::_('AG_BOOKMARK') . '</option>
                <option value="show">' . JText::_('AG_SHOW') . '</option>
                <option value="hide">' . JText::_('AG_HIDE') . '</option>
            </select>
	      </td>
      	  <td id="AG_targetFolder">
      	  </td>
     </tr>
     </tbody>
</table>
<hr />

<table cellspacing="0" cellpadding="0" border="0" class="AG_fieldset">
     <tbody>
     <tr>
	  <td><img src="' . JURI::root() . 'administrator/components/com_admirorgallery/templates/' . $AG_templateID . '/images/upload.png" style="float:left;" /></td><td>&nbsp;' . JText::_('AG_UPLOAD_IMAGES_JPG_JPEG_GIF_PNG_OR_ZIP') . '&nbsp;[ <b>' . JText::_('AG_MAX') . '&nbsp;' . (JComponentHelper::getParams('com_media')->get('upload_maxsize',0)).' MB</b> ]:&nbsp;</td><td><input type="file" name="AG_fileUpload" /></td>
     </tr>
     </tbody>
</table>
<hr />
<table cellspacing="0" cellpadding="0" border="0" class="AG_fieldset">
     <tbody>
     <tr>
	  <td><img src="' . JURI::root() . 'administrator/components/com_admirorgallery/templates/' . $AG_templateID . '/images/folder-new.png" style="float:left;" /></td><td>&nbsp;' . JText::_('AG_CREATE_FOLDERS') . '&nbsp;</td>
<td id="AG_folder_add">
    <a href=""  class="AG_common_button">
    <span><span>
	' . JText::_('AG_ADD') . '
    </span></span>
    </a>
</td>
     </tr>
     </tbody>
</table>
<hr />

<input type="hidden" name="AG_folderSettings_status" id="AG_folderSettings_status" />
<a href="" id="AG_btn_showFolderSettings" class="AG_common_button">
    <span><span>
    ' . JText::_('AG_EDIT_FOLDER_CAPTIONS') . '
    </span></span>
</a>
<div id="AG_folderSettings_wrapper" style="display:none;">

<br />
' . "\n";

// Set Possible Description File Apsolute Path // Instant patch for upper and lower case...
$ag_pathWithStripExt = JPATH_SITE . $ag_folderName . '/' . JFile::stripExt($ag_fileName);
$ag_XML_path = $ag_pathWithStripExt . ".XML";
if (JFIle::exists($ag_pathWithStripExt . ".xml")) {
    $ag_XML_path = $ag_pathWithStripExt . ".xml";
}

// Load if XML exists
if (file_exists($ag_XML_path)) {
    $ag_XML_xml =  JFactory::getXMLParser('simple');
    $ag_XML_xml->loadFile($ag_XML_path);
    if ($ag_XML_xml->document->thumb[0]) {
        $ag_XML_thumb = $ag_XML_xml->document->thumb[0]->data();
    }
    if ($ag_XML_xml->document->captions[0]) {
        $ag_XML_captions = $ag_XML_xml->document->captions[0];
    }
}


$ag_matchCheck = Array("default");

// GET DEFAULT LABEL
$ag_XML_caption_content = "";
if (!empty($ag_XML_captions->caption)) {
    foreach ($ag_XML_captions->caption as $ag_imgXML_caption) {
        if (strtolower($ag_imgXML_caption->attributes('lang')) == "default") {
            $ag_XML_caption_content = $ag_imgXML_caption->data();
        }
    }
}
$ag_preview_content.= ag_render_caption("Default", "default", $ag_XML_caption_content);


// GET LABELS ON SITE LANGUAGES
$ag_lang_available = JLanguage::getKnownLanguages(JPATH_SITE);
if (!empty($ag_lang_available)) {
    foreach ($ag_lang_available as $ag_lang) {
        $ag_XML_caption_content = "";
        if (!empty($ag_XML_captions->caption)) {
            foreach ($ag_XML_captions->caption as $ag_imgXML_caption) {
                if (strtolower($ag_imgXML_caption->attributes('lang')) == strtolower($ag_lang["tag"])) {
                    $ag_XML_caption_content = $ag_imgXML_caption->data();
                    $ag_matchCheck[] = strtolower($ag_lang["tag"]);
                }
            }
        }
        $ag_preview_content.= ag_render_caption($ag_lang["name"], $ag_lang["tag"], $ag_XML_caption_content);
    }
}

if (!empty($ag_XML_captions->caption)) {
    foreach ($ag_XML_captions->caption as $ag_imgXML_caption) {
        $ag_imgXML_caption_attr = $ag_imgXML_caption->attributes('lang');
        if (!is_numeric(array_search(strtolower($ag_imgXML_caption_attr), $ag_matchCheck))) {
            $ag_preview_content.= ag_render_caption($ag_imgXML_caption_attr, $ag_imgXML_caption_attr, $ag_imgXML_caption->data());
        }
    }
}


$ag_preview_content.='
</div>

<hr />

';


// RENDER FOLDERS
// CREATED SORTED ARRAY OF FOLDERS
$ag_files = JFolder::folders(JPATH_SITE . $ag_itemURL);

if (!empty($ag_files)) {

    $ag_folders_priority = Array();
    $ag_folders_noPriority = Array();
    $ag_folders = Array();

    foreach ($ag_files as $key => $value) {
        $ag_folderName = $ag_itemURL;
        $ag_fileName = basename($value);
        // Set Possible Description File Apsolute Path // Instant patch for upper and lower case...
        $ag_pathWithStripExt = JPATH_SITE . $ag_folderName . JFile::stripExt($ag_fileName);
        $ag_XML_path = $ag_pathWithStripExt . ".XML";
        if (JFIle::exists($ag_pathWithStripExt . ".xml")) {
            $ag_XML_path = $ag_pathWithStripExt . ".xml";
        }
        if (file_exists($ag_XML_path)) {
            $ag_XML_xml =  JFactory::getXMLParser('simple');
            $ag_XML_xml->loadFile($ag_XML_path);
            $ag_XML_priority = $ag_XML_xml->document->priority[0]->data();
        }

        if (!empty($ag_XML_priority) && file_exists($ag_XML_path)) {
            $ag_folders_priority[$value] = $ag_XML_priority; // PRIORITIES IMAGES
        } else {
            $ag_folders_noPriority[] = $value; // NON PRIORITIES IMAGES
        }
    }
}

if (!empty($ag_folders_priority)) {
    asort($ag_folders_priority);
    foreach ($ag_folders_priority as $key => $value) {
        $ag_folders[] = $key;
    }
}

if (!empty($ag_folders_noPriority)) {
    natcasesort($ag_folders_noPriority);
    foreach ($ag_folders_noPriority as $key => $value) {
        $ag_folders[] = $value;
    }
}

if (!empty($ag_folders)) {
    foreach ($ag_folders as $key => $value) {

        $ag_hasXML = "";
        $ag_hasThumb = "";

        // Set Possible Description File Apsolute Path // Instant patch for upper and lower case...
        $ag_pathWithStripExt = JPATH_SITE . $ag_itemURL . JFile::stripExt(basename($value));
        $ag_XML_path = $ag_pathWithStripExt . ".xml";
        if (JFIle::exists($ag_pathWithStripExt . ".XML")) {
            $ag_XML_path = $ag_pathWithStripExt . ".XML";
        }

        $ag_XML_visible = "AG_VISIBLE";
        $ag_XML_priority = "";
        if (file_exists($ag_XML_path)) {
            $ag_hasXML = '<img src="' . JURI::root() . 'administrator/components/com_admirorgallery/templates/' . $AG_templateID . '/images/icon-hasXML.png"  class="ag_hasXML" />';
            $ag_XML_xml = JFactory::getXMLParser('simple');
            $ag_XML_xml = simplexml_load_file($ag_XML_path);
            if (isset($ag_XML_xml->priority)) {
                $ag_XML_priority = $ag_XML_xml->priority;
            }
            if (isset($ag_XML_xml->visible)) {
                if ((string) $ag_XML_xml->visible == "false") {
                    $ag_XML_visible = "AG_HIDDEN";
                }
            }
        }





        $ag_preview_content.='
    <div class="AG_border_color AG_border_width AG_item_wrapper">
	    <a href="' . $ag_itemURL . $value . '/" class="AG_folderLink AG_item_link" title="' . $value . '">
	        <div style="display:block; text-align:center;" class="AG_item_img_wrapper">
		    <img src="' . JURI::root() . 'administrator/components/com_admirorgallery/templates/' . $AG_templateID . '/images/folder.png" />
	        </div>
	    </a>
	    <div class="AG_border_color AG_border_width AG_item_controls_wrapper">
	        <input type="text" value="' . $value . '" name="AG_rename[' . $ag_itemURL . $value . ']" class="AG_input" style="width:95%" /><hr />
	        ' . JText::_($ag_XML_visible) . '<hr />
	        <img src="' . JURI::root() . 'administrator/components/com_admirorgallery/templates/' . $AG_templateID . '/images/operations.png" style="float:left;" /><input type="checkbox" value="' . $ag_itemURL . $value . '/" name="AG_cbox_selectItem[]" class="AG_cbox_selectItem"><hr />
	        ' . JText::_('AG_PRIORITY') . ':&nbsp;<input type="text" size="3" value="' . $ag_XML_priority . '" name="AG_cbox_priority[' . $ag_itemURL . $value . ']" class="AG_input" />
	    </div>
    </div>
    ';
    }
}

// RENDER IMAGES
// CREATED SORTED ARRAY OF IMAGES
$ag_files = JFolder::files(JPATH_SITE . $ag_itemURL);
$ag_ext_valid = array("jpg", "jpeg", "gif", "png"); // SET VALID IMAGE EXTENSION

if (!empty($ag_files)) {

    $ag_images_priority = Array();
    $ag_images_noPriority = Array();
    $ag_images = Array();

    foreach ($ag_files as $key => $value) {
        if (is_numeric(array_search(strtolower(JFile::getExt(basename($value))), $ag_ext_valid))) {

            $ag_folderName = $ag_itemURL;
            $ag_fileName = basename($value);

            // Set Possible Description File Apsolute Path // Instant patch for upper and lower case...
            $ag_pathWithStripExt = JPATH_SITE . $ag_folderName . JFile::stripExt($ag_fileName);
            $ag_XML_path = $ag_pathWithStripExt . ".XML";
            if (JFIle::exists($ag_pathWithStripExt . ".xml")) {
                $ag_XML_path = $ag_pathWithStripExt . ".xml";
            }
            if (file_exists($ag_XML_path)) {
                $ag_XML_xml = JFactory::getXMLParser('simple');
                $ag_XML_xml->loadFile($ag_XML_path);
                $ag_XML_priority = $ag_XML_xml->document->priority[0]->data();
            }

            if (!empty($ag_XML_priority) && file_exists($ag_XML_path)) {
                $ag_images_priority[$value] = $ag_XML_priority; // PRIORITIES IMAGES
            } else {
                $ag_images_noPriority[] = $value; // NON PRIORITIES IMAGES
            }
        }
    }
}

if (!empty($ag_images_priority)) {
    asort($ag_images_priority);
    foreach ($ag_images_priority as $key => $value) {
        $ag_images[] = $key;
    }
}

if (!empty($ag_images_noPriority)) {
    natcasesort($ag_images_noPriority);
    foreach ($ag_images_noPriority as $key => $value) {
        $ag_images[] = $value;
    }
}

if (!empty($ag_images)) {
    foreach ($ag_images as $key => $value) {


        $ag_hasXML = "";
        $ag_hasThumb = "";

        // Set Possible Description File Apsolute Path // Instant patch for upper and lower case...
        $ag_pathWithStripExt = JPATH_SITE . $ag_itemURL . JFile::stripExt(basename($value));
        $ag_XML_path = $ag_pathWithStripExt . ".xml";
        if (JFIle::exists($ag_pathWithStripExt . ".XML")) {
            $ag_XML_path = $ag_pathWithStripExt . ".XML";
        }

        $ag_XML_visible = "AG_VISIBLE";
        $ag_XML_priority = "";
        if (file_exists($ag_XML_path)) {
            $ag_hasXML = '<img src="' . JURI::root() . 'administrator/components/com_admirorgallery/templates/' . $AG_templateID . '/images/icon-hasXML.png"  class="ag_hasXML" />';
            $ag_XML_xml = JFactory::getXMLParser('simple');
            $ag_XML_xml = simplexml_load_file($ag_XML_path);
            if (isset($ag_XML_xml->priority)) {
                $ag_XML_priority = $ag_XML_xml->priority;
            }
            if (isset($ag_XML_xml->visible)) {
                if ((string) $ag_XML_xml->visible == "false") {
                    $ag_XML_visible = "AG_HIDDEN";
                }
            }
        }

        if (file_exists(JPATH_SITE . "/plugins/content/admirorgallery/admirorgallery/thumbs/" . basename($ag_folderName) . "/" . basename($value))) {
            $ag_hasThumb = '<img src="' . JURI::root() . 'administrator/components/com_admirorgallery/templates/' . $AG_templateID . '/images/icon-hasThumb.png"  class="ag_hasThumb" />';
        }



        agHelper::ag_createThumb(JPATH_SITE . $ag_itemURL . $value, $thumbsFolderPhysicalPath . DS . $value, 145, 80, "none");

        $AG_thumb_checked = "";
        if ($ag_XML_thumb == $value) {
            $AG_thumb_checked = " CHECKED";
        }

        $ag_preview_content.='
     <div class="AG_border_color AG_border_width AG_item_wrapper">
	<a href="' . $ag_itemURL . $value . '" class="AG_fileLink AG_item_link" title="' . $value . '">
	      <div style="display:block; text-align:center;" class="AG_item_img_wrapper">
	      <img src="' . JURI::root() . 'administrator/components/com_admirorgallery/assets/thumbs/' . $value . '" class="ag_imgThumb" />
	      </div>
	</a>
	<div class="AG_border_color AG_border_width AG_item_controls_wrapper">
	    <input type="text" value="' . JFile::stripExt(basename($value)) . '" name="AG_rename[' . $ag_itemURL . $value . ']" class="AG_input" style="width:95%" /><hr />
	    ' . JText::_($ag_XML_visible) . '<hr />
        <img src="' . JURI::root() . 'administrator/components/com_admirorgallery/templates/' . $AG_templateID . '/images/operations.png" style="float:left;" /><input type="checkbox" value="' . $ag_itemURL . $value . '" name="AG_cbox_selectItem[]" class="AG_cbox_selectItem"><hr />
	    ' . JText::_('AG_PRIORITY') . ':&nbsp;<input type="text" size="3" value="' . $ag_XML_priority . '" name="AG_cbox_priority[' . $ag_itemURL . $value . ']" class="AG_input" /><hr />
        <input type="radio" value="' . $value . '" name="AG_folder_thumb" class="AG_folder_thumb" class="AG_input"' . $AG_thumb_checked . ' />&nbsp;' . JText::_('AG_FOLDER_THUMB') . '
	</div>
     </div>
     ';
    }
}

if (empty($ag_folders) && empty($ag_images)) {
    $ag_preview_content.= JText::_('AG_NO_FOLDERS_OR_IMAGES_FOUND_IN_CURRENT_FOLDER');
}


$AG_folderDroplist = "<select id='AG_operations_targetFolder' name='AG_operations_targetFolder'>";
$AG_folders = JFolder::listFolderTree(JPATH_SITE . $ag_rootFolder, "");
$AG_rootFolder_strlen = strlen($ag_rootFolder);
$AG_folderDroplist.="<option value='" . $ag_rootFolder . "' >" . JText::_('AG_IMAGES_ROOT_FOLDER') . "</option>";
if (!empty($AG_folders)) {
    foreach ($AG_folders as $AG_folders_key => $AG_folders_value) {
        $AG_folderName = substr($AG_folders_value['relname'], $AG_rootFolder_strlen);
        $AG_folderDroplist.="<option value='" . $ag_rootFolder . $AG_folderName . "' >" . $AG_folderName . "</option>";
    }
}
$AG_folderDroplist.="</select>";


$ag_preview_content.='

<script type="text/javascript">
AG_jQuery("#AG_operations").change(function() {
        switch(AG_jQuery(this).val())
        {
        case "delete":
          AG_jQuery("#AG_targetFolder").html("<img src=\'' . JURI::root() . 'administrator/components/com_admirorgallery/templates/' . $AG_templateID . '/images/alert.png\'  style=\'float:left;\' />&nbsp;' . JText::_('AG_SELECTED_ITEMS_WILL_BE_DELETED') . '");
          break;
        case "move":
          AG_jQuery("#AG_targetFolder").html("' . $AG_folderDroplist . '");
          break;
        case "copy":
          AG_jQuery("#AG_targetFolder").html("' . $AG_folderDroplist . '");
          break;
        default:
          AG_jQuery("#AG_targetFolder").html("");
        }
});


</script>

';
?>
