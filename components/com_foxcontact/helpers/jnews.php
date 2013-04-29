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
Thanks to: Lorenzo Milesi (YetOpen S.r.l. maxxer@yetopen.it http://www.yetopen.it/) for his great contribution
*/

$inc_dir = realpath(dirname(__FILE__));
require_once($inc_dir . DS . 'fnewsletter.php');

class FJNewsSubscriber extends FNewsletter
{
	public function __construct(&$params, &$messages, &$fieldsbuilder)
	{
		parent::__construct($params, $messages, $fieldsbuilder);
		$this->Name = "FJNews";
		$this->prefix = "jnews";
	}


	public function Process()
	{
		// Newsletter component disabled or not found. Aborting.
		if (!$this->enabled) return true;

		$config = new jNews_Config();

		// Build subscriber object
		$subscriber = new stdClass;

		// Name field may be absent. JNews will assign an empty name to the user.
		$subscriber->name = isset($this->FieldsBuilder->Fields['sender0']) ? $this->FieldsBuilder->Fields['sender0']['Value'] : "";

		$subscriber->email = empty($this->FieldsBuilder->Fields['sender1']['Value']) ? NULL : JMailHelper::cleanAddress($this->FieldsBuilder->Fields['sender1']['Value']);
		// JNews saves users with empty email address, so we have to check it
		if (empty($subscriber->email))
		{
			$this->logger->Write(get_class($this) . " Process(): Email address empty. User save aborted.");
			return true;
		}

		// It seems that $subscriber->confirmed defaults to unconfirmed if unset, so we need to read and pass the actual value from the configuration
		$subscriber->confirmed = !(bool)$config->get('require_confirmation');

		$subscriber->receive_html = 1;
		$subscriber->ip = jNews_Subscribers::getIP();
		$subscriber->subscribe_date = jnews::getNow();

		// Lists
		$cumulative = JRequest::getVar("jnews_subscribe_cumulative", NULL, "POST");
		$checkboxes = JRequest::getVar("jnews_subscribe", array(), "POST");
		$subscriber->list_id = $cumulative ? $checkboxes : array();

		// Subscription
		$sub_id = null;
		jNews_Subscribers::saveSubscriber($subscriber, $sub_id, true);

		if (empty($sub_id))
		{
			// User save failed. Probably email address is empty or invalid
			$this->logger->Write(get_class($this) . " Process(): User save failed");
			return true;
		}

		// Subscribe $subscriber to $subscriber->list_id
		$subscriber->id = $sub_id;
		jNews_ListsSubs::saveToListSubscribers($subscriber);

		// Log
		$this->logger->Write(get_class($this) . " Process(): subscribed "
		. $this->FieldsBuilder->Fields['sender0']['Value'] . " (". $this->FieldsBuilder->Fields ['sender1']['Value']
		. ") to lists " . implode(",", $subscriber->list_id));

		return true;
	}


	protected function LoadFields()
	{
	}

	protected function load_newsletter_config()
	{
		if (!(bool)$this->Params->get("jnews")) return $this->enabled = false;

		// Load JNews classes
		defined("JNEWS_JPATH_ROOT") or define("JNEWS_JPATH_ROOT", JPATH_ROOT);

		$mainAdminPathDefined = JPATH_ROOT . '/components/com_jnews/defines.php';
		$this->enabled = (bool)@include_once($mainAdminPathDefined);
		$jnews_include = JNEWS_JPATH_ROOT . '/administrator/components/' . JNEWS_OPTION . '/classes/class.jnews.php';
		$this->enabled &= (bool)@include_once($jnews_include);

		$found = $this->enabled ? " " : " not ";
		$this->logger->Write(get_class($this) . " Newsletter component" . $found . "found");
	}


	protected function load_newsletter_lists()
	{
		// Get the lists selected to be shown. Defaults to a null array
		$lists = $this->Params->get("jnews_lists", array("NULL"));

		$db = JFactory::getDBO();
		$query = $db->getQuery(true);

		$query->select("`id`, `hidden` as `visible`, `list_name` as `name`");  // JNews "hidden" means "visible"

		$query->from("#__jnews_lists");

		// Condition: Published
		$query->where("published = 1");
		// Condition: Visible not set, so that invisible lists are hidden but usable

		// Condition: List selected to be shown
		$query->where("id IN (" . implode(',', $lists) .")");

		$db->setQuery($query);

		// Get the definitive lists to be shown. Defaults to an empty array
		$this->lists = $db->loadAssocList() or $this->lists = array();
	}


} // end of class

