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
defined( '_JEXEC' ) or die( 'Restricted access' );
//Check if plugin is installed, othervise don't show view
if(!is_dir(JPATH_SITE.'/plugins/content/admirorgallery/')){ return;}
jimport('joomla.filesystem.file');	  
jimport('joomla.filesystem.folder');
jimport('joomla.language.language');
jimport('joomla.filesystem.archive');

$AG_templateID = JRequest::getVar( 'AG_template' );// Current template for AG Component
$AG_itemURL = JRequest::getVar( 'AG_itemURL' );
$AG_frontEnd = JRequest::getVar( 'AG_frontEnd' );// Current template for AG Component

// GET ROOT FOLDER
$plugin = JPluginHelper::getPlugin('content', 'admirorgallery');
$pluginParams = new JRegistry($plugin->params);
$ag_rootFolder = $pluginParams->get('rootFolder','/images/sampledata/');
if($AG_frontEnd=='true'){
    $ag_starting_folder = $pluginParams->get('rootFolder','/images/sampledata/').$this->galleryName.'/';
}else{
    $ag_starting_folder = $ag_rootFolder;
}

if(!empty($AG_itemURL)){
    $ag_init_itemURL = $AG_itemURL;
}else{
     if($AG_frontEnd=='true'){
	  $ag_init_itemURL = $pluginParams->get('rootFolder','/images/sampledata/').$this->galleryName.'/';
     }else{
	  $ag_init_itemURL = $ag_rootFolder;
     }
}

?>

<form action="<?php echo JURI::getInstance()->toString();?>" method="post" name="adminForm" id="adminForm" enctype="multipart/form-data">

<input type="hidden" name="option" value="com_admirorgallery" />
<input type="hidden" name="task" value="" />
<input type="hidden" name="view" value="imagemanager" />
<input type="hidden" name="controller" value="imagemanager" />
<input type="hidden" name="AG_itemURL" value="<?php echo $ag_init_itemURL;?>" id="AG_input_itemURL" />

<?php

if(file_exists(JPATH_SITE.$ag_init_itemURL)){
     if(is_dir(JPATH_SITE.$ag_init_itemURL)){
	  $ag_init_itemType="folder";
     }else{
	  $ag_init_itemType="file";
     }
     require_once (JPATH_ROOT.DS.'administrator'.DS.'components'.DS.'com_admirorgallery'.DS.'views'.DS.'imagemanager'.DS.'scripts'.DS.'imgManager-render-'.$ag_init_itemType.'.php');
}else{
     $ag_error[] = Array (JText::_('AG_FOLDER_OR_IMAGE_NOT_FOUND'), $ag_init_itemURL);
     JError::raiseWarning('3', JText::_('AG_FOLDER_OR_IMAGE_NOT_FOUND').'<br>'.$ag_init_itemURL);
$ag_preview_content='
<div class="ag_screenSection_title">
     '.$ag_init_itemURL.'
</div>
';
return;
}


echo '
<script type="text/javascript">

var ag_init_itemURL="'.$ag_init_itemURL.'";
var ag_init_itemType="'.$ag_init_itemType.'";
'."\n";

if($AG_frontEnd=='true'){
echo '
Joomla.submitbutton = function(pressbutton) {
     AG_jQuery(\'input[name="task"]\').val(pressbutton);
     AG_jQuery(\'form[id="adminForm"]\').submit();
}
'."\n";
}

echo '
function basename(path) {
     return path.replace(/'.chr(92).chr(92).'/g,"/").replace( /.*\//, "" );
}

function dirname(path) {
     return path.replace(/'.chr(92).chr(92).'/g,"/").replace(/\/[^\/]*$/, "")+"/";
}

function ag_folder_selected(itemURL){
    AG_jQuery(\'input[name="AG_itemURL"]\').val(itemURL);
    AG_jQuery(\'input[name="task"]\').val("AG_imgMan_renderFolder");
    AG_jQuery(\'form[id="adminForm"]\').submit();
}

function ag_file_selected(itemURL){
    AG_jQuery(\'input[name="AG_itemURL"]\').val(itemURL);
    AG_jQuery(\'input[name="task"]\').val("AG_imgMan_renderFile");
    AG_jQuery(\'form[id="adminForm"]\').submit();
}

AG_jQuery(function(){

     // Binding event to Folder Add
    AG_jQuery("#AG_folder_add a").click(function(e) {
	e.preventDefault();        
	AG_jQuery("#AG_folder_add").prepend("<input type=\'text\' class=\'AG_input\' name=\'AG_addFolders[]\' /><br />");
    });
    
     // Binding event to folder links
    AG_jQuery(".AG_folderLink").click(function(e) {
	e.preventDefault();        
	ag_folder_selected(AG_jQuery(this).attr("href"));
    });

    // Binding event to file links
    AG_jQuery(".AG_fileLink").click(function(e) {
	e.preventDefault();
	ag_file_selected(AG_jQuery(this).attr("href"));
    });

      // Binding event to folder links
      AG_jQuery("#ag_preview .AG_folderLink").click(function(e) {
	  e.preventDefault();
	  ag_folder_selected(AG_jQuery(this).attr("href"));
      });

      // Binding event to file links
      AG_jQuery("#ag_preview .AG_fileLink").click(function(e) {
	  e.preventDefault();
	  ag_file_selected(AG_jQuery(this).attr("href"));
      });

      AG_jQuery(".AG_cbox_selectItem").click(function(e) {
	  AG_jQuery(this).closest(".AG_item_wrapper").toggleClass("AG_mark_selectItem");
      });


      AG_jQuery("#AG_bookmarks_showHide").click(function(e) {
        e.preventDefault();
        if(AG_jQuery(".AG_bookmarks_wrapper").css("display")!="none"){
            AG_jQuery(".AG_bookmarks_wrapper").css("display","none");
            AG_jQuery("#AG_bookmarks_showHide").find("span").find("span").html("'.JText::_( 'AG_SHOW_SIDEBAR' ).'");
        }else{
            AG_jQuery(".AG_bookmarks_wrapper").css("display","block");  
            AG_jQuery("#AG_bookmarks_showHide").find("span").find("span").html("'.JText::_( 'AG_HIDE_SIDEBAR' ).'");   
        }

      });
      
      AG_jQuery("#AG_btn_showFolderSettings").click(function(e) {
        e.preventDefault();
        if(AG_jQuery("#AG_folderSettings_wrapper").css("display")!="none"){     
            AG_jQuery("#AG_folderSettings_wrapper").css("display","none"); 
            AG_jQuery("#AG_btn_showFolderSettings").find("span").find("span").html("'.JText::_( 'AG_EDIT_FOLDER_CAPTIONS' ).'");
        }else{
            AG_jQuery("#AG_folderSettings_wrapper").css("display","block"); 
            AG_jQuery("#AG_folderSettings_status").val("edit");
            AG_jQuery("#AG_btn_showFolderSettings").find("span").find("span").html("'.JText::_( 'AG_CLOSE_FOLDER_CAPTIONS' ).'");   
        }
      });
      
        AG_jQuery(".AG_folder_thumb").change(function(){
            AG_jQuery("#AG_folderSettings_status").val("edit");
        });
            
'."\n";

if($AG_frontEnd=='true'){
echo '
     // SET SHORCUTS
    AG_jQuery(document).bind("keydown", "ctrl+return", function (){submitbutton("AG_apply");return false;});	
    AG_jQuery(document).bind("keydown", "ctrl+backspace", function (){submitbutton("AG_reset");return false;});
'."\n";
}

echo '
});//AG_jQuery(function()

</script>
'."\n";

// FORMAT FORM

if($AG_frontEnd=='true'){
require_once( JPATH_COMPONENT.DS.'helpers'.DS.'toolbar.php' );
echo '
<div class="AG_border_color AG_border_width AG_background_color AG_toolbar">
'.AdmirorgalleryHelperToolbar::getToolbar().'
</div>
';
}

echo '
<div class="AG_background_color AG_body_wrapper">
'."\n";

// FORMAT SCREEN
echo '
<table border="0" cellspacing="0" cellpadding="0" width="100%">
     <tbody>
	  <tr>
	       <td class="AG_bookmarks_wrapper" style="display:none;">
	       
		    <h1><img src="'.JURI::root().'administrator/components/com_admirorgallery/templates/'.$AG_templateID.'/images/bookmark.png" style="float:left;" />&nbsp;'.JText::_( "AG_GALLERIES").'</h1>
		    '."\n";

$bookmarkPath = JPATH_SITE.'/administrator/components/com_admirorgallery/assets/bookmarks.xml';
$ag_bookmarks_xml = JFactory::getXMLParser( 'simple' );
$ag_bookmarks_xml->loadFile( $bookmarkPath );
if(isset($ag_bookmarks_xml->document->bookmark)){
    foreach($ag_bookmarks_xml->document->bookmark as $key => $value){
        echo '
<table border="0" cellspacing="0" cellpadding="0"><tbody><tr>
<td><img src="'.JURI::root().'administrator/components/com_admirorgallery/templates/'.$AG_templateID.'/images/bookmarkRemove.png" style="float:left;" /></td>
<td><input type="checkbox" value="'.$ag_bookmarks_xml->document->bookmark[$key]->data().'" name="AG_cbox_bookmarkRemove[]"></td>
<td><span class="AG_border_color AG_border_width AG_separator">&nbsp;</span></td>
<td>
<a href="'.$ag_bookmarks_xml->document->bookmark[$key]->data().'"  class="AG_folderLink AG_common_button" title="'.$ag_bookmarks_xml->document->bookmark[$key]->data().'">
<span><span>
          '.agHelper::ag_shrinkString(basename($ag_bookmarks_xml->document->bookmark[$key]->data()),20,'...').'
</span></span>
</a>
</td>
</tr></tbody></table>
        '."\n";
    }
}

echo '
	              <div style="clear:both" class="AG_margin_bottom"></div>
	              <hr />
	              <div  class="AG_legend">
	              <h2>'.JText::_( 'AG_LEGEND' ).'</h2>
	              <table><tbody>
	              <tr>
		          <td><img src="'.JURI::root().'administrator/components/com_admirorgallery/templates/'.$AG_templateID.'/images/bookmarkRemove.png" style="float:left;" /></td>
		          <td>'.JText::_( 'AG_SELECT_TO_REMOVE_BOOKMARK' ).'</td>
	              </tr>
	              </tbody></table>
	              <div>
	          
	       </td>
	       <td class="AG_border_color AG_border_width AG_details_wrapper">
	       <a class="AG_common_button" href="" id="AG_bookmarks_showHide"><span><span>'.JText::_( 'AG_SHOW_SIDEBAR').'</span></span></a>
		    '.$ag_preview_content.'
	       </td>
	  </tr>
     </tbody>
</table>

</div>
'."\n";

?>
 
</form>
