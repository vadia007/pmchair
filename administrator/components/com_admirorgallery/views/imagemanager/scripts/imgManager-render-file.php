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
defined( '_JEXEC' ) or die( 'Restricted access' );

require_once (JPATH_SITE . DS . 'plugins' . DS . 'content' . DS . 'admirorgallery' . DS . 'admirorgallery' . DS . 'classes' . DS . 'agHelper.php');

$ag_itemURL = $ag_init_itemURL;

$ag_folderName = dirname($ag_itemURL);
$ag_fileName = basename($ag_itemURL);
$AG_imgInfo = agHelper::ag_imageInfo(JPATH_SITE.$ag_itemURL);

require_once (JPATH_SITE.DS.'plugins'.DS.'content'.DS.'admirorgallery'.DS.'admirorgallery'.DS.'classes'.DS.'agHelper.php');

$thumbsFolderPhysicalPath = JPATH_SITE.DS.'administrator'.DS.'components'.DS.'com_admirorgallery'.DS.'assets'.DS.'thumbs';

agHelper::ag_sureRemoveDir($thumbsFolderPhysicalPath,true);
if(!JFolder::create($thumbsFolderPhysicalPath,0755)){
    JFactory::getApplication()->enqueueMessage( JText::_( "AG_CANNOT_CREATE_FOLDER" )."&nbsp;".$newFolderName, 'error' );
}

$ag_hasXML="";
$ag_hasThumb="";

// Set Possible Description File Apsolute Path // Instant patch for upper and lower case...
$ag_pathWithStripExt=JPATH_SITE.$ag_folderName.'/'.JFile::stripExt(basename($ag_itemURL));
$ag_imgXML_path=$ag_pathWithStripExt.".XML";
if(JFIle::exists($ag_pathWithStripExt.".xml")){
    $ag_imgXML_path=$ag_pathWithStripExt.".xml";
}

if(file_exists(JPATH_SITE."/plugins/content/admirorgallery/admirorgallery/thumbs/".basename($ag_folderName)."/".basename($ag_fileName))){
     $ag_hasThumb='<img src="'.JURI::root().'administrator/components/com_admirorgallery/templates/'.$AG_templateID.'/images/icon-hasThumb.png" class="ag_hasThumb" />';
}

if(file_exists($ag_imgXML_path)){
     $ag_hasXML='<img src="'.JURI::root().'administrator/components/com_admirorgallery/templates/'.$AG_templateID.'/images/icon-hasXML.png" class="ag_hasXML" />';
     $ag_imgXML_xml = JFactory::getXMLParser( 'simple' );
     $ag_imgXML_xml->loadFile($ag_imgXML_path);
     $ag_imgXML_captions = $ag_imgXML_xml->document->captions[0];
}

$ag_preview_content='';

// GET IMAGES FOR NEXT AND PREV IMAGES FUNCTIONS
$ag_files=JFolder::files(JPATH_SITE.$ag_folderName);

if(!empty($ag_files)){
    $ag_ext_valid = array ("jpg","jpeg","gif","png");// SET VALID IMAGE EXTENSION
    $ag_images=Array();
    foreach($ag_files as $key => $value){
        if(is_numeric(array_search(strtolower(JFile::getExt(basename($value))),$ag_ext_valid))){
            $ag_images[]=$value;
        }
    }
 if(array_search($ag_fileName, $ag_images)!=0){    
        $ag_fileName_prev=$ag_images[array_search($ag_fileName, $ag_images)-1];
    }
    if(array_search($ag_fileName, $ag_images)<count($ag_images)-1){
        $ag_fileName_next=$ag_images[array_search($ag_fileName, $ag_images)+1];
    }
    if(!empty($ag_fileName_prev)){
        $ag_preview_content.='<a class="AG_common_button" href="" onclick="AG_jQuery(\'#AG_input_itemURL\').val(\''.$ag_folderName.'/'.$ag_fileName_prev.'\');submitbutton(\'AG_reset\');return false;"><span><span>'.JText::_( "AG_PREVIOUS_IMAGE").'</span></span></a>'."\n";
    }
    if(!empty($ag_fileName_next)){
        $ag_preview_content.='<a class="AG_common_button" href="" onclick="AG_jQuery(\'#AG_input_itemURL\').val(\''.$ag_folderName.'/'.$ag_fileName_next.'\');submitbutton(\'AG_reset\');return false;"><span><span>'.JText::_( "AG_NEXT_IMAGE").'</span></span></a>'."\n";
    }
}

$ag_preview_content.='<hr />';

$ag_preview_content.='
<h1>'.JText::_( 'AG_IMAGE_DETAILS_FOR_FILE' ).'</h1>
<div class="AG_border_color AG_border_width AG_margin_bottom AG_breadcrumbs_wrapper">
'.$this->_renderBreadcrumb($ag_itemURL, $ag_starting_folder, $ag_folderName, $ag_fileName).'
</div>
';

agHelper::ag_createThumb(JPATH_SITE.$ag_itemURL, $thumbsFolderPhysicalPath.DS.basename($ag_itemURL), 145, 80, "none");

$ag_preview_content.='
<div class="AG_margin_bottom AG_thumbAndInfo_wrapper">
<table cellspacing="0" cellpadding="0" border="0">
    <tbody>
	<tr>
	    <td>
		<a class="AG_item_link" href="'.substr(JURI::root(),0,-1).$ag_itemURL.'" title="'.$ag_itemURL.'" rel="lightbox[\'AG\']" target="_blank">
		    <img src="'.JURI::root().'administrator/components/com_admirorgallery/assets/thumbs/'.basename($ag_itemURL).'" alt="'.$ag_itemURL.'">
		</a>
	    </td>
	    <td class="AG_border_color AG_border_width" style="border-left-style:solid;">
		<div>'.JText::_( "AG_IMG_WIDTH").': '.$AG_imgInfo["width"].'px</div>
		<div>'.JText::_( "AG_IMG_HEIGHT").': '.$AG_imgInfo["height"].'px</div>
		<div>'.JText::_( "AG_IMG_TYPE").': '.$AG_imgInfo["type"].'</div>
		<div>'.JText::_( "AG_IMG_SIZE").': '.$AG_imgInfo["size"].'</div>
		<div>'.$ag_hasXML.$ag_hasThumb.'</div>
	    </td>
	</tr>
    </tbody>
</table>   
</div>
';


require_once (JPATH_ROOT.DS.'administrator'.DS.'components'.DS.'com_admirorgallery'.DS.'slimbox'.DS.'index.php');


function ag_render_caption($ag_lang_name, $ag_lang_tag, $ag_lang_content){
    return '
	<div class="AG_border_color AG_border_width AG_margin_bottom">
	    '.$ag_lang_name.' / '.$ag_lang_tag.'
	    <textarea class="AG_textarea" name="AG_desc_content[]">'.$ag_lang_content.'</textarea><input type="hidden" name="AG_desc_tags[]" value="'.$ag_lang_tag.'" />
	</div>
    ';
}

$ag_matchCheck = Array("default");

// GET DEFAULT LABEL
$ag_imgXML_caption_content="";
if(!empty($ag_imgXML_captions->caption)){
  foreach($ag_imgXML_captions->caption as $ag_imgXML_caption){
      if(strtolower($ag_imgXML_caption->attributes('lang')) == "default"){
	  $ag_imgXML_caption_content = $ag_imgXML_caption->data();
      }
  }
}
$ag_preview_content.= ag_render_caption("Default", "default", $ag_imgXML_caption_content);


// GET LABELS ON SITE LANGUAGES
$ag_lang_available = JLanguage::getKnownLanguages(JPATH_SITE);
if(!empty($ag_lang_available)){
    foreach($ag_lang_available as $ag_lang){
	$ag_imgXML_caption_content="";
	if(!empty($ag_imgXML_captions->caption)){
	  foreach($ag_imgXML_captions->caption as $ag_imgXML_caption){
	      if(strtolower($ag_imgXML_caption->attributes('lang')) == strtolower($ag_lang["tag"])){
		  $ag_imgXML_caption_content = $ag_imgXML_caption->data();
		  $ag_matchCheck[]=strtolower($ag_lang["tag"]);
	      }
	  }
	}
	$ag_preview_content.= ag_render_caption($ag_lang["name"], $ag_lang["tag"], $ag_imgXML_caption_content);
    }
}

if(!empty($ag_imgXML_captions->caption)){
    foreach($ag_imgXML_captions->caption as $ag_imgXML_caption){
	$ag_imgXML_caption_attr = $ag_imgXML_caption->attributes('lang');
	if(!is_numeric(array_search(strtolower($ag_imgXML_caption_attr),$ag_matchCheck))){
	      $ag_preview_content.= ag_render_caption($ag_imgXML_caption_attr, $ag_imgXML_caption_attr, $ag_imgXML_caption->data());
	}
    }
}

$ag_preview_content.='
<div style="clear:both" class="AG_margin_bottom"></div>
<hr />
<div  class="AG_legend">
<h2>'.JText::_( 'AG_LEGEND' ).'</h2>
<table><tbody>
<tr>
    <td><img src="'.JURI::root().'administrator/components/com_admirorgallery/templates/'.$AG_templateID.'/images/icon-hasThumb.png" style="float:left;" /></td>
    <td>'.JText::_( 'AG_IMAGE_HAS_THUMBNAIL_CREATED' ).'</td>
</tr>
<tr>
    <td><img src="'.JURI::root().'administrator/components/com_admirorgallery/templates/'.$AG_templateID.'/images/icon-hasXML.png" style="float:left;" /></td>
    <td>'.JText::_( 'AG_IMAGE_HAS_ADDITIONAL_DETAILS_SAVED' ).'</td>
</tr>
</tbody></table>
<div>
';

?>
