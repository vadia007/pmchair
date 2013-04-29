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

	class FAdminMailer extends FDispatcher
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
			$mail = JFactory::getMailer();

			$this->set_from($mail);
			$this->set_to($mail, "to_address", "addRecipient");
			$this->set_to($mail, "cc_address", "addCC");
			$this->set_to($mail, "bcc_address", "addBCC");

			$mail->setSubject(JMailHelper::cleanSubject($this->Params->get("email_subject", "")));

			$body = $this->body();
			$body .= $this->attachments($mail);
			$body .= PHP_EOL;

			// Info about url
			$body .= $this->Application->getCfg("sitename") . " - " . $this->CurrentURL() . PHP_EOL;

			// Info about client
			$body .= "Client: " . $this->ClientIPaddress() . " - " . $_SERVER['HTTP_USER_AGENT'] . PHP_EOL;

			$body = JMailHelper::cleanBody($body);
			$mail->setBody($body);

			$this->Logger->Write("---------------------------------------------------" . PHP_EOL . $body);

			return $this->send($mail);
		}


		private function set_from(&$mail)
		{
			//		if ($this->Application->getCfg("mailer") == "smtp" && (bool)$this->Application->getCfg("smtpauth") == true)
			if ($this->Application->getCfg("mailer") == "smtp" && (bool)$this->Application->getCfg("smtpauth") && strpos($this->Application->getCfg("smtpuser"), "@") !== false)
			{
				// SMTP auth may require to set the username as the sender
				$mail->setSender(array($this->Application->getCfg("smtpuser"), $this->Application->getCfg("fromname")));

				// In Joomla 1.7 From and Reply-to fields is set by default to the Global admin email
				// but a call to setSender() won't change the Reply-to field
				$mail->ClearReplyTos();
				$mail->addReplyTo(array($this->submitteraddress(), $this->submittername()));
			}
			else
			{
				$mail->setSender(array($this->submitteraddress(), $this->submittername()));
			}
		}

		// $param_name | $method
		// ------------+-------------
		// to_address  | addRecipient
		// cc_address  | addCC
		// bcc_address | addBCC
		private function set_to(&$mail, $param_name, $method)
		{
			if ($this->Params->get($param_name, NULL))
				$recipients = explode(",", $this->Params->get($param_name, ""));
			else
				$recipients = array();

			// http://docs.joomla.org/How_to_send_email_from_components
			foreach ($recipients as $recipient)
			{
				// Avoid to call $mail->add..() with an empty string, since explode(",", $string) returns al least 1 item, even if $string is empty
				if (empty($recipient)) continue;
				$mail->$method($recipient);
			}
		}


		protected function attachments(&$mail)
		{
			$result = "";
			// this email is for the webmaster
			$uploadmethod = intval($this->Params->get("uploadmethod", "1"));  // How the webmaster wants to receive attachments

			if (count($this->FileList) && ($uploadmethod & 1)) $result .= $this->Language->_($GLOBALS["COM_NAME"] . "_UPLOAD_LBL") . PHP_EOL;
			foreach ($this->FileList as &$file)
			{  // binary 01: http link, binary 10: attach, binary 11: both
				$filename = 'components' . DS . $GLOBALS["com_name"] . DS . 'uploads' . DS . $file;
				if ($uploadmethod & 1) $result .= JURI::base() . $filename . PHP_EOL;
				if ($uploadmethod & 2) $mail->addAttachment(JPATH_SITE . DS . $filename);
			}

			return $result;
		}

	}
?>
