<?php /*defined('_JEXEC') or die ('Restricted access');*/
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

class FLangHandler
	{
	protected $lang;
	protected $messages = array();

	function __construct()
		{
		$this->lang = JFactory::getLanguage();

		$this->check_partial();
		$this->check_missing();
		}


	public function HasMessages()
		{
		return (bool)count($this->messages);
		}


	public function GetMessages()
		{
		return $this->messages;
		}


	protected function check_partial()
		{
		if (intval(JText::_($GLOBALS["COM_NAME"] . '_PARTIAL')))
			{
			// Translation string is 1
			$this->messages[] = $this->lang->get("name") . " translation is still incomplete. Please consider to contribute by completing and sharing your own translation. <a href=\"http://www.fox.ra.it/forum/19-languages-and-translations/1265-how-to-write-your-own-translation.html\">Learn more</a>.";
			}
		}


	protected function check_missing()
		{
		$filename = JPATH_SITE . DS . "language" . DS . $this->lang->get("tag") . DS . $this->lang->get("tag") . "." . $GLOBALS["com_name"] . ".ini";
		if (!file_exists($filename))
			{
			$this->messages[] = $this->lang->get("name") . " translation is still missing. Please consider to contribute by writing and sharing your own translation. <a href=\"http://www.fox.ra.it/forum/19-languages-and-translations/1265-how-to-write-your-own-translation.html\">Learn more</a>.";
			// Ok, it is missing. Maybe it is available but hasn't been installed?
			$this->check_availability();
			}
		}


	private function check_availability()
		{
		$filename = JPATH_ADMINISTRATOR . DS . 'components' . DS . $GLOBALS["com_name"] . DS . $GLOBALS["ext_name"] . '.xml';
		$xml = JFactory::getXML($filename);

		if (!$xml)
			{
			// Todo: log this event
			//$this->messages[] = "Can't load extension xml file";
			}
		else
			{
			foreach ($xml->languages->language as $l)
				{
				if (strpos($l->data(), $this->lang->get("tag")) === 0)
					{
					$this->messages = array();
					$this->messages[] = $this->lang->get("name") . " translation has not been installed, but <strong>is available</strong>. To fix this problem simply install this extension once again, without uninstalling it. <a href=\"http://www.fox.ra.it/forum/19-languages-and-translations/2886-my-language-is-available-but-it-hasnt-been-installed.html\">Learn more</a>.";
					break;
					}
				}
			}


		}

	}

?>