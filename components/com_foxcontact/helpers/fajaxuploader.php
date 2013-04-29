<?php defined('_JEXEC') or die ('Restricted access');
/*
This file is part of "Fox Joomla Extensions".

You can redistribute it and/or modify it under the terms of the GNU General Public License
GNU/GPLv3 http://www.gnu.org/licenses/gpl-3.0.html

You have the freedom:
	* to use this software for both commercial and non-commercial purposes
	* to share, copy, distribute and install this software and charge for it if you wish.
Under the following conditions:
	* You must attribute the work to the original author by leaving untouched the link "powered by",
	  except if you obtain a "registerd version" http://www.fox.ra.it/forum/14-licensing/151-remove-the-backlink-powered-by-fox-contact.html

Author: Demis Palma
Documentation at http://www.fox.ra.it/forum/2-documentation.html
*/

$inc_dir = realpath(dirname(__FILE__));
require_once($inc_dir . DS . 'fdatapump.php');
require_once($inc_dir . DS . 'fsession.php');

class FAjaxUploader extends FDataPump
	{
	public function __construct(&$params, &$messages)
		{
		parent::__construct($params, $messages);

		$this->Name = "FAjaxFilePump";
		$this->isvalid = true;
		}

 
	protected function LoadFields()
		{
		// Nothing to load for the moment
		}

        
	// Build a multiple upload field
	public function Show()
		{
		// Load into <head> needed js only once and only if upload feature is enabled
		if (!(bool)$this->Params->get("uploaddisplay")) return "";

		if (!isset($GLOBALS[$GLOBALS["ext_name"] . '_upload_js_loaded']))
			{
			$placeholders = $values = array();
			$placeholders[] = '{%BROWSE_FILES%}';
			$placeholders[] = '{%FLOAT%}';
			$placeholders[] = '{%JCANCEL%}';
			$placeholders[] = '{%FAILED%}';
			$placeholders[] = '{%SUCCESS%}';
			$placeholders[] = '{%Action%}';
			$values[] = JTEXT::_($GLOBALS["COM_NAME"] . '_BROWSE_FILES');
			$values[] = $GLOBALS["left"];
			$values[] = JTEXT::_('JCANCEL');
			$values[] = JTEXT::_($GLOBALS["COM_NAME"] . '_FAILED');
			$values[] = JTEXT::_($GLOBALS["COM_NAME"] . '_SUCCESS');
			// Use "/" instead of "DS", since this string is used on client side in Javascript createUploader function
			$values[] = JURI::base(true) . '/components/' . $GLOBALS["com_name"] . '/lib/file-uploader.php';

			// Show main uploader javascript in <head> section as a source
			$this->js_load("fileuploader-min.js", 1, 0, $placeholders, $values);
			$GLOBALS[$GLOBALS["ext_name"] . '_upload_js_loaded'] = true;
			}

		$id = $this->GetId();
		//$cid = ((bool)$this->Application->mid) ? 0 : $this->GetComponentId();

		$result =
			// Open row container
			'<div style="clear:both;">' .
			// Label
			'<label ' .
         'style="' .
//            'float:' . $GLOBALS["left"] . ';' .
//            'width:' . $this->Params->get('labelswidth') . $this->Params->get('labelsunit') . ' !important;' .
            '">' .
			$this->Params->get('upload') . ". " .
			JTEXT::_($GLOBALS["COM_NAME"] . '_FILE_SIZE_LIMIT') . " " . $this->human_readable($this->Params->get("uploadmax_file_size") * 1024) .
			'</label>' .

			// Upload button and list container
			'<div id="foxupload_' . $id . '" ' .
			//'style="float:' . $GLOBALS["left"] . '"' .
			'></div>' . PHP_EOL .
			"<script language=\"javascript\" type=\"text/javascript\">createUploader('foxupload_$id', " . $this->Application->cid . ", " . $this->Application->mid . ");</script>" .

			// for browsers without javascript support only
			'<noscript>' . 
			// Standard file input 
			'<input ' .
			'type="file" ' .
// id raise a w3c error in case of more contact form in the same page: ID "foxstdupload" already defined
//			'id="foxstdupload" ' .
			'name="foxstdupload"' .
			" />" . 
			'</noscript>';

		$jsession = JFactory::getSession();
		$fsession = new FSession($jsession->getId(), $this->Application->cid, $this->Application->mid);
		$data = $fsession->Load('filelist');  // Read the list from the session
		if ($data) $filelist = explode("|", $data);
		else $filelist = array();

		if (count($filelist))
			{
			// Previuosly completed uploads
			$result .= '<ul class="qq-upload-list">';
			foreach ($filelist as &$file)
				{
				$result .=
				'<li class="qq-upload-success" style="background-position:' . $GLOBALS["left"] . ';">' .
				'<span class="qq-upload-file" style="float:' . $GLOBALS["left"] . '">' . substr($file, 14) . '</span>' .
				'<span class="qq-upload-success-text" style="background-position:' . $GLOBALS["left"] . ';">' . JTEXT::_($GLOBALS["COM_NAME"] . '_SUCCESS') . '</span>' .
				'</li>';
				}
			$result .= '</ul>' . PHP_EOL;                			
			}

		// Close row container
		$result .= "</div>". PHP_EOL;
		return $result;
		}

      
	protected function human_readable($value)
		{		
		for ($i = 0; $value >= 1000; ++$i) $value /= 1024;
		$powers = array('B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB');
		return round($value, 1) . " " . $powers[$i];
		}

	}
?>
