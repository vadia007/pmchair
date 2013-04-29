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
	require_once($inc_dir . DS . 'fdispatcher.php');
	require_once($inc_dir . DS . 'fieldsbuilder.php');

	class FSubmitterMailer extends FDispatcher
	{

		public function __construct(&$params, &$messages, &$fieldsbuilder)
		{
			parent::__construct($params, $messages, $fieldsbuilder);
		}


		protected function LoadFields()
		{
		}


		public function Process()
		{
			$copy_to_submitter =
			(bool)JRequest::getVar($this->SafeName("copy_to_submitter" . $this->GetId()), NULL, 'POST') ||  // Checkbox is enabled
			($this->Params->get("copy_to_submitter", NULL) == 1);                            // always send a copy parameter

			if (!$copy_to_submitter || !isset($this->FieldsBuilder->Fields['sender1']) || empty($this->FieldsBuilder->Fields['sender1']['Value']))
			{
				$this->FSession->Clear('filelist');
				//JLog::add("Copy email for the submitter skipped.", JLog::INFO, get_class($this));
				return true;
			}

			$mail = JFactory::getMailer();

			$this->set_from($mail);
			$this->set_to($mail);
			$mail->setSubject(JMailHelper::cleanSubject($this->Params->get("email_copy_subject", "")));

			// Body
			$body = $this->Params->get("email_copy_text", "") . PHP_EOL;
			// a blank line
			$body .= PHP_EOL;

			if ($this->Params->get("email_copy_summary", NULL))
			{
				$body .= $this->body();
				$body .= $this->attachments();
				$body .= PHP_EOL;
			}

			// A null body will raise a mail error, so always add at least a signature.
			$body .= "------" . PHP_EOL . $this->Application->getCfg("sitename") . PHP_EOL;

			$body = JMailHelper::cleanBody($body);
			$mail->setBody($body);

			// Clear file list for the next submission of the same users
			$this->FSession->Clear('filelist');

			$this->send($mail);

			return true;
		}


		private function set_from(&$mail)
		{
			//		if ($this->Application->getCfg("mailer") == "smtp" && (bool)$this->Application->getCfg("smtpauth") == true)
			if ($this->Application->getCfg("mailer") == "smtp" && (bool)$this->Application->getCfg("smtpauth") && strpos($this->Application->getCfg("smtpuser"), "@") !== false)
			{
				// With SMTP auth may be needed to set the username as the sender
				$mail->setSender(array($this->Application->getCfg("smtpuser"), $this->Application->getCfg("fromname")));
				// In Joomla 1.7 From and Reply-to fields is set by default to the Global admin email
				// but a call to setSender() won't change the Reply-to field
				$mail->ClearReplyTos();
				$mail->addReplyTo(array($this->Application->getCfg("mailfrom"), $this->Application->getCfg("fromname")));
			}
			else
			{
				$mail->setSender(array($this->Application->getCfg("mailfrom"), $this->Application->getCfg("fromname")));
			}
		}


		private function set_to(&$mail)
		{
			$addr = $this->FieldsBuilder->Fields['sender1']['Value'];
			$mail->addRecipient(JMailHelper::cleanAddress($addr));
		}


		protected function attachments()
		{
			$result = "";

			// this email is for the submitter
			// a further separation from signature above
			if (count($this->FileList)) $result .= $this->Language->_($GLOBALS["COM_NAME"] . "_UPLOAD_LBL") . PHP_EOL;
			foreach ($this->FileList as &$file)
			{
				$result .= substr($file, 14) . PHP_EOL;
			}

			return $result;
		}

	}
?>
