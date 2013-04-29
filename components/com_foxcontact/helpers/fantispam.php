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
	require_once($inc_dir . DS . 'flogger.php');

	class FAntispam extends FDataPump
	{
		protected $FieldsBuilder;

		public function __construct(&$params, &$messages, $fieldsbuilder)
		{
			parent::__construct($params, $messages);

			$this->Name = "FAntispam";
			$this->FieldsBuilder = $fieldsbuilder;
			$this->isvalid = intval($this->ValidateForSpam($fieldsbuilder));
		}


		public function Show()
		{
			if (!$this->isvalid) $this->Messages[] = $this->Params->get("spam_detected_text");
		}


		protected function LoadFields()
		{
		}


		protected function ValidateForSpam(&$fieldsbuilder)
		{
			// Message text to check
			$message = "";
			// Add text area fields to the message
			foreach ($fieldsbuilder->Fields as $key => $field)
			{
				if (strpos($field['Type'], "textarea") !== 0) continue;
				$message .= $field['Value'];
			}
			// If it was a spammer, just log this attempt, drop the email, and of course notify the user with a false return value
			$spam_words = $this->Params->get("spam_words", "");

			// Spam check disabled and copy to submitter disabled. No need to perform spam check
			if (!(bool)($this->Params->get("spam_check", 0)) && !(bool)($this->Params->get("copy_to_submitter", 0))) return true;

			// No spam words issued to antispam system
			if (empty($spam_words)) return true;

			$arr_spam_words = explode(",", $spam_words);
			foreach($arr_spam_words as $word)
			{
				if (stripos($message, $word) !== false)
				{
					$logger = new FLogger();
					$logger->Write("Spam attempt blocked:" . PHP_EOL . print_r($fieldsbuilder->Fields, true) . "-----------------------------------------");
					// this is a spam message
					return false;
				}
			}

			// Spam ckeck successful
			return true;
		}
	}


?>
