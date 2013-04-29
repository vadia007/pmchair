<?php defined('_JEXEC') or die('Restricted access');
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
require_once($inc_dir . DS . 'flogger.php');
jimport('joomla.mail.helper');
defined("DEFAULT_CHECKBOXMAP") or define("DEFAULT_CHECKBOXMAP", "hidden|hidden");

class FNewsletter extends FDataPump
{
	const master = 0;
	const lists = 1;

	protected $FieldsBuilder;
	protected $lists;
	protected $logger;
	protected $enabled;
	protected $prefix;

	public function __construct(&$params, &$messages, &$fieldsbuilder)
	{
		parent::__construct($params, $messages);

		$this->FieldsBuilder = $fieldsbuilder;

		$this->logger = new FLogger();

		$this->load_newsletter_config();
		$this->load_newsletter_lists();
	}


	public function Show()
	{
		// Newsletter component disabled or not found. Aborting.
		if (!$this->enabled) return "";
		$result = "";

		// Some friendly aliases
		$post = isset($_POST[$this->GetId()]);
		// Checkboxes selected by user or hidden and enabled fields
		$values = JRequest::getVar($this->prefix . "_subscribe", array(), "POST");
		// Checkbox drawing behaviour
		$checkbox_map = explode("|", $this->Params->get($this->prefix . "_checkboxes", DEFAULT_CHECKBOXMAP));
		// Parameter automatically check the checkboxes
		$autocheck = $this->Params->get($this->prefix . "_auto_checked", 0);

		// Draw the cumulative field
		$field = array();

		// Standard attributes
		$field["value"] = 1;
		$field["caption"] = JText::_('COM_FOXCONTACT_ALL_NEWSLETTERS');
		$field["PostName"] = $this->prefix . "_subscribe_cumulative";

		// checked status
		$value = JRequest::getVar($this->prefix . "_subscribe_cumulative", NULL, "POST");
		$field["checked"] = $post && $value || !$post && $autocheck;

		// "visible" attribute
		$field["visible"] = $checkbox_map[FNewsletter::master];

		// Draw the global field
		$result .= $this->{$field["visible"]}($field);

		// Draw each field
		foreach ($this->lists as $list)
		{
			$field = array();

			// Standard attributes
			$field["value"] = $list["id"];
			$field["caption"] = $list["name"];
			$field["PostName"] = $this->prefix . "_subscribe[" . $list["id"] . "]";

			// checked status
			$value = @$values[$list["id"]];
			$field["checked"] = $post && $value || !$post && $autocheck;

			// "visible" attribute
			$field["visible"] = $list["visible"] ? $checkbox_map[FNewsletter::lists] : "hidden";

			// Draw the field
			$result .= $this->{$field["visible"]}($field);
		}

		// Display checkboxes
		return $result;
	}


	public function Process()
	{
		// Disabled in form configuration. Aborting.
		if (!$this->enabled) return true;

		// Trig the contact plugins to integrate with other applications
		$contact = NULL;
		$data = array();
		$data["contact_name"] = isset($this->FieldsBuilder->Fields['sender0']) ? $this->FieldsBuilder->Fields['sender0']['Value'] : "";
		$data["contact_email"] = empty($this->FieldsBuilder->Fields['sender1']['Value']) ? NULL : JMailHelper::cleanAddress($this->FieldsBuilder->Fields['sender1']['Value']);
		$data["contact_subject"] = $this->Params->get("email_subject", "");
		$data["contact_message"] = isset($this->FieldsBuilder->Fields['textarea0']) ? $this->FieldsBuilder->Fields['textarea0']['Value'] : "";
		JDispatcher::getInstance()->trigger('onSubmitContact', array(&$contact, &$data));
		return true;
	}


	protected function LoadFields()
	{
	}


	protected function load_newsletter_config()
	{
		return $this->enabled = (int)$this->Params->get("othernewsletters", 1);
	}


	protected function load_newsletter_lists()
	{
		$this->lists = array();
	}


	protected function checkbox($field)
	{
		// Fixes che "checked" value suitable for html output
		$field["checked"] = (bool)$field["checked"] ? 'checked=""' : "";

		$result =
		'<div style="clear:both;">' .
		'<input ' .
		'type="checkbox" ' .
		'class="foxcheckbox" ' .
		'value="' . $field["value"] . '" ' .
		$field["checked"] . " " .
		'name="' . $field['PostName'] . '" ' .
		'id="c' . $field['PostName'] . '" ' .
		'/>' .
		'<span ' .
		'id="s' . $field['PostName'] . '" ' .
		"onclick=\"ChangeCheckboxState('" . $field['PostName'] . "');\" " .
		'style="background-position: ' . $GLOBALS["left"]. ' 50%;" ' .
		'>' .
		JText::_('COM_FOXCONTACT_SUBSCRIBE_TO') . " " . $field['caption'] .
		'</span>' .
		"</div>" . PHP_EOL;

		return $result;
	}


	protected function hidden($field)
	{
		$result =
		'<input ' .
		'type="hidden" ' .
		'value="' . $field["value"] . '" ' .
		'name="' . $field['PostName'] . '" ' .
		'/>' . PHP_EOL;

		return $result;
	}

	protected function label($field)
	{
		$result =
		$this->hidden($field) .
		'<div><label>' .
		$field["caption"] .
		'</label></div>' . PHP_EOL;

		return $result;
	}

}

