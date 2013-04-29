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


	class FSubmitter extends FDataPump
	{

		public function __construct(&$params, &$messages)
		{
			parent::__construct($params, $messages);

			$this->Name = "FSubmitter";
			// count($_POST):
			// 0  -> no submitted
			// 1  -> submitted, but $_FILES exceeds server limits, and is been resetted
			// 1+ -> submittend. We can try to validate fields.
			$this->isvalid = (count($_POST) > 1 && isset($_POST[$this->GetId()]));
		}


		public function Show()
		{
			$result = "";

			$field = array();
			if ($this->Params->get("copy_to_submitter", 0) == 2 &&  // Option "send a copy" is "allow the user to chose"
			(bool)$this->Params->get("sender1display", 0))   // Field "your email" is optonal or required
			{
				// Special field "Send a copy to my own email address"
				$field["Display"] = 1;
				$field["Type"] = "checkbox";
				$field["Name"] = JText::_($GLOBALS["COM_NAME"] . "_SEND_ME_A_COPY");
				//$field["PostName"] = $this->SafeName("copy_to_submitter" . "cid" . $this->Application->cid . "mid" . $this->Application->mid);
				$field["PostName"] = $this->SafeName("copy_to_submitter" . $this->GetId());
				$field["Value"] = JRequest::getVar($field["PostName"], NULL, 'POST');
				$field["IsValid"] = true;
			}
			$result .= $this->BuildCheckboxField("", $field);

			$result .= '<div style="float:left">' . PHP_EOL;

			switch ($this->Params->get("submittype"))
			{
				case 1:
					// Submit input
					$result .= '<input class="foxbutton" type="submit" style="margin-' . $GLOBALS["right"] . ':0px;" name="' . $this->GetId() . '" value="' . $this->Params->get("submittext") . '"/>' . PHP_EOL;
					break;

				default:
					// Submit button
					$icon = $this->Params->get("submiticon");
					// Can't use "value" attribute: http://www.w3schools.com/tags/att_button_value.asp
					$result .= '<button class="foxbutton" type="submit" style="margin-' . $GLOBALS["right"] . ':0px;" name="' . $this->GetId() . '">' . PHP_EOL .
					'<span ';
					if ($icon != "-1") $result .= 'style="background: url(' . JURI::base(true) . '/media/' . $GLOBALS["com_name"] . '/images/submit/' . $icon . ') no-repeat scroll ' . $GLOBALS["left"] . ' top transparent; padding-' . $GLOBALS["left"] . ':20px;" ';
					$result .= '>' . PHP_EOL .
					$this->Params->get("submittext") .
					'</span>' . PHP_EOL .
					'</button>' . PHP_EOL;
			}

			if ($this->Params->get("resetbutton"))
			{
				switch ($this->Params->get("resettype"))
				{
					case 1:
						// input
						$result .= '<input class="foxbutton" type="reset" onClick="ResetFoxControls();" value="' . $this->Params->get("resettext") . '">' . PHP_EOL;
						break;

					default:
						// button

						$reseticon = $this->Params->get("reseticon");
						$result .= '<button class="foxbutton" type="reset" onClick="ResetFoxControls();">' . PHP_EOL .
						'<span ';
						if ($reseticon != "-1") $result .= 'style="background: url(' . JURI::base(true) . '/media/' . $GLOBALS["com_name"] . '/images/reset/' . $reseticon . ') no-repeat scroll ' . $GLOBALS["left"] . ' top transparent; padding-' . $GLOBALS["left"] . ':20px;" ';
						$result .= '>' . PHP_EOL .
						$this->Params->get("resettext") .
						'</span>' . PHP_EOL .
						'</button>' . PHP_EOL;
				}
			}
			return $result . submittext() . PHP_EOL;
		}


		protected function LoadFields()
		{
		}

		// Todo: Duplicated code, except for
		// <div style="clear:both;">
		// </div>
		// DescriptionByValidation
		// AdditionalDescription
		// style="margin:0 32px;
		private function BuildCheckboxField($key, &$field)
		{
			// Todo: we don't need this check. This function is called only for required and optional items
			if (!isset($field['Display']) || !(bool)$field['Display']) return;

			// Here, validation will be successful, because there aren't post data, but it isn't a good right to activate che checkbox with the check
			// if (intval($this->FieldsBuilder->Fields[$index]['Value'])) $this->msg .= "checked=\"\"";
			if ($field['Value'] == JText::_('JYES')) $checked = 'checked=""';
			else $checked = "";

			$result =
			'<div class="fox_copy_to_sender" style="clear:both;"><input ' .
			'type="checkbox" ' .
			'class="foxcheckbox" ' .
			"value=\"" . JText::_('JYES') . "\" " .
			$checked .
			'name="' . $field['PostName'] . '" ' .
			'id="c' . $field['PostName'] . '" ' .
			'/>' . PHP_EOL;
			$result .=
			'<span ' .
			'id="s' . $field['PostName'] . '" ' .
			"onclick=\"ChangeCheckboxState('" . $field['PostName'] . "');\" " .
			'style="background-position: ' . $GLOBALS["left"]. ' 50%;" ' .
			'>' .
			$field['Name'] .
			'</span></div>' . PHP_EOL;

			return $result;
		}

	}


?>
