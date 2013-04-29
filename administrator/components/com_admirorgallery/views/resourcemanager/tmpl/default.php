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
// Preloading joomla tools
jimport( 'joomla.installer.helper' );
jimport('joomla.filesystem.file');
jimport('joomla.filesystem.archive');
jimport('joomla.html.pagination');
jimport('joomla.filesystem.folder');
JHTML::_('behavior.tooltip');

// Loading globals
$mainframe = JFactory::getApplication();
$option = JRequest::getCmd('option');

$AG_template = JRequest::getVar( 'AG_template' );// Current template for AG Component
$AG_resourceType = JRequest::getVar( 'AG_resourceType' );// Current resource type

// Loading JPagination vars
$limitstart	= $mainframe->getUserStateFromRequest( $option.'.limitstart', 'limitstart', 0, 'int' );
$limit		= $mainframe->getUserStateFromRequest( 'global.list.limit', 'limit', $mainframe->getCfg('list_limit'), 'int' );

?>

<form action="<?php echo JURI::getInstance()->toString();?>" method="post" name="adminForm" enctype="multipart/form-data">

<input type="hidden" name="option" value="com_admirorgallery" />
<input type="hidden" name="task" value="" />
<input type="hidden" name="view" value="resourcemanager" />
<input type="hidden" name="controller" value="resourcemanager" />
<input type="hidden" name="AG_resourceType" value="<?php echo $AG_resourceType;?>" />

<?php

echo '
<script type="text/javascript">

AG_jQuery(function(){
	AG_jQuery(".ag_title_link").click(function(e) {
		e.preventDefault();
		if(AG_jQuery(this).closest("tr").find(\'input:checkbox\').attr("checked") == true){
			AG_jQuery(this).closest("tr").find(\'input:checkbox\').attr("checked", false);
		}else{
			AG_jQuery(this).closest("tr").find(\'input:checkbox\').attr("checked", true);
		}        		
	});

	AG_jQuery("#checkAll").click(function(e) {

		var numOfRows = AG_jQuery(".adminlist tbody tr").length;

		if(AG_jQuery(this).attr("checked") == true){
			for(i='.$limitstart.';i<('.$limitstart.'+numOfRows);i++){
				AG_jQuery("#cb"+i).attr("checked", true);
			}
		}else{
			for(i='.$limitstart.';i<('.$limitstart.'+numOfRows);i++){
				AG_jQuery("#cb"+i).attr("checked", false);
			}
		}     

	});

});//AG_jQuery

</script>
'."\n";

// Read folder with gallery templates
$ag_resourceManager_installed = JFolder::folders(JPATH_SITE.'/plugins/content/admirorgallery/admirorgallery/'.$AG_resourceType);// N U
sort($ag_resourceManager_installed);

// Rendering the form and table grid
echo '
<script type="text/javascript">AG_jQuery("#ag_screenWrapper").remove();</script>
<div id="ag_screenWrapper">
<form action="index.php?option=com_admirorgallery&task='.$AG_resourceType.'" method="post" name="adminForm" id="adminForm" enctype="multipart/form-data">
'.JText::_('AG_SELECT_TEMPLATE_TO_INSTALL').'&nbsp;[ <b>'.JText::_( 'AG_MAX' ).'&nbsp;'.(JComponentHelper::getParams('com_media')->get('upload_maxsize',0)).' MB</b> ]:&nbsp;<input type="file" name="AG_fileUpload" size="50" />
<br /><br />
';

echo '
<table class="adminlist" cellspacing="1">
<thead>
	<tr>
	      <th width="20px" align="center" nowrap="nowrap">#</th>
	      <th align="center" width="20px">
<table border="0" cellspacing="0" cellpadding="0"><tbody><tr>
<td style="padding:0; background-color:none"><img src="'.JURI::root().'administrator/components/com_admirorgallery/templates/'.$AG_template.'/images/uninstalled.png" /></td>
<td style="padding:0; background-color:transparent"><input type="checkbox" value="" id="checkAll" /></td>
</tr></tbody></table>
</th>
	      <th width="200px" class="title" align="left" nowrap="nowrap">'.JText::_( "AG_TITLE").'</th>
	      <th width="20px" class="title" align="left" nowrap="nowrap">'.JText::_( "AG_ID").'</th>
	      <th align="left" nowrap="nowrap">'.JText::_( "AG_DESCRIPTION").'</th>
	      <th width="20px" align="center" nowrap="nowrap">'.JText::_( "AG_VERSION").'</th>
	      <th width="20px" align="center" nowrap="nowrap">'.JText::_( "AG_DATE").'</th>
	      <th width="100px" align="left" nowrap="nowrap">'.JText::_( "AG_AUTHOR").'</th>
	</tr>
</thead>
<tbody>
';

$total = count($ag_resourceManager_installed);
$pageNav = new JPagination( $total, $limitstart, $limit );
if($limit=="all"){$limit=$total;}

if(!empty($ag_resourceManager_installed)){
foreach ($ag_resourceManager_installed as $ag_resourceManager_Key => $ag_resourceManager_Value) {
	if($ag_resourceManager_Key >= $limitstart && $ag_resourceManager_Key < ($limitstart+$limit)){

		// TEMPLATE DETAILS PARSING
		$ag_resourceManager_id = $ag_resourceManager_Value;
		$ag_resourceManager_name = $ag_resourceManager_id;
		$ag_resourceManager_creationDate = JText::_( "AG_UNDATED");
		$ag_resourceManager_author = JText::_( "AG_UNKNOWN_AUTHOR");
		$ag_resourceManager_version = JText::_( "AG_UNKNOWN_VERSION");
		$ag_resourceManager_description = JText::_( "AG_NO_DESCRITION");

		if(JFIle::exists(JPATH_SITE.'/plugins/content/admirorgallery/admirorgallery/'.$AG_resourceType.'/'.$ag_resourceManager_id.'/details.xml')){// N U
			$ag_resourceManager_xml =JFactory::getXMLParser( 'simple' );
			$ag_resourceManager_xml->loadFile( JPATH_SITE.'/plugins/content/admirorgallery/admirorgallery/'.$AG_resourceType.'/'.$ag_resourceManager_id.'/details.xml' );// N U
			$ag_resourceManager_name = $ag_resourceManager_xml->document->name[0]->data();
			$ag_resourceManager_creationDate = $ag_resourceManager_xml->document->creationDate[0]->data();
			$ag_resourceManager_author = $ag_resourceManager_xml->document->author[0]->data();
			$ag_resourceManager_version = $ag_resourceManager_xml->document->version[0]->data();
			$ag_resourceManager_description = $ag_resourceManager_xml->document->description[0]->data();			
		}

		echo '     
		<tr>
		<td align="right">
		'.($ag_resourceManager_Key+1).'.
		</td> 
		<td align="center">
		';

		//if ($row->checked_out && $row->checked_out != $user->id) {
		//echo '&nbsp;';
		//} else {
		echo '
		<input type="checkbox" id="cb'.$ag_resourceManager_Key.'" name="cid[]" value="'.$ag_resourceManager_id.'" />';
		//}

		echo '
		</td>
		<td style="white-space:nowrap;">

		<span class="editlinktip hasTip" title="'.$ag_resourceManager_name.'::<img border=&quot;1&quot; src=&quot;'.JURI::root().'plugins/content/admirorgallery/admirorgallery/'.$AG_resourceType.'/'.$ag_resourceManager_id.'/preview.jpg'.'&quot; name=&quot;imagelib&quot; alt=&quot;&quot; width=&quot;206&quot; height=&quot;145&quot; />">
		<a href="#" class="ag_title_link">
		'.$ag_resourceManager_name.'
		</a>
		</span>
	
		</td>     
		<td style="white-space:nowrap;">
			'.$ag_resourceManager_id.'
		</td>  
		<td>
			'.$ag_resourceManager_description.'
		</td> 
		<td align="center" style="white-space:nowrap;">
			'.$ag_resourceManager_version.'
		</td>    
		<td style="white-space:nowrap;">
			'.$ag_resourceManager_creationDate.'
		</td>  
		<td>
			'.$ag_resourceManager_author.'
		</td>  
		</tr>
		';
	}
}//foreach ($ag_resourceManager_installed as $ag_resourceManager_Key => $ag_resourceManager_Value)
}//if(!empty($ag_resourceManager_installed))

       
echo '
<tfoot>
<tr>
    <td align="center" colspan="9">
	    '.$pageNav->getListFooter().'
    </td>
</tr>
</tfoot>
</table>
';    

?>

</form>
