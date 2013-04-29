<?php
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

	defined('_JEXEC') or die ('Restricted access');

	jimport('joomla.utilities.date');

	class FSession
	{
		private $db;
		protected $Id;
		protected $Cid;
		protected $Mid;

		public function __construct($id, $cid, $mid)
		{		
			$this->Id  = $id;
			$this->Cid = intval($cid);
			$this->Mid = intval($mid);  // Need intval for the sql: i.e. WHERE mid = 0
			global $app;
			$this->db = JFactory::getDBO();
		}


		public function Save($string, $keyword)
		{
			$sql = "SELECT data FROM #__" . $GLOBALS["ext_name"] . "_sessions WHERE id = '$this->Id' AND cid = $this->Cid AND mid = $this->Mid AND keyword = '$keyword';";
			$this->db->setQuery($sql);
			$result = $this->db->query();

			// $result have to be a valid object even if dataset is empty.
			// If FALSE or NULL, a mysql error occurred. Example: table doesn't exist.'
			//if (!$result) return false;

			if ((bool)$this->db->getNumRows())
			{
				// Existing session. Update it.
				$sql = "UPDATE #__" . $GLOBALS["ext_name"] . "_sessions SET data = '$string', birth = '" . JFactory::getDate()->$GLOBALS["toSql"]() . "' WHERE id = '$this->Id' AND cid = $this->Cid AND mid = $this->Mid AND keyword = '$keyword';";
				$this->db->setQuery($sql);
				$result = $this->db->query();
			}
			else
			{
				// Session doesn't exist. Create it.
				$sql = "INSERT INTO #__" . $GLOBALS["ext_name"] . "_sessions (id, cid, mid, keyword, birth, data) VALUES ('$this->Id', $this->Cid, $this->Mid, '$keyword', '" . JFactory::getDate()->$GLOBALS["toSql"]() . "', '$string');";
				$this->db->setQuery($sql);
				$result = $this->db->query();
			}

			return $result;
		}


		public function Load($keyword)
		{
			$this->PurgeExpiredSessions();

			$sql = "SELECT data FROM #__" . $GLOBALS["ext_name"] . "_sessions WHERE id = '$this->Id' AND cid = $this->Cid AND mid = $this->Mid AND keyword = '$keyword';";
			$this->db->setQuery($sql);
			return $this->db->loadResult();
		}


		public function PurgeValue($keyword)
		{
			$sql = "UPDATE #__" . $GLOBALS["ext_name"] . "_sessions SET data = NULL WHERE id = '$this->Id' AND cid = $this->Cid AND mid = $this->Mid AND keyword = '$keyword';";
			$this->db->setQuery($sql);
			$this->db->query();
		}


		public function Clear($keyword)
		{
			$sql = "DELETE FROM #__" . $GLOBALS["ext_name"] . "_sessions WHERE id = '$this->Id' AND cid = $this->Cid AND mid = $this->Mid AND keyword = '$keyword';";
			$this->db->setQuery($sql);
			$this->db->query();
		}


		private function PurgeExpiredSessions()
		{
			//$app = JFactory::getApplication();
			//global $app;
			//$lifetime = $app->getCfg("lifetime");
			$lifetime = JFactory::$config->get("lifetime");
			$date = new JDate("-" . $lifetime . " minute");
			$sql = "DELETE FROM #__" . $GLOBALS["ext_name"] . "_sessions WHERE birth < '" . $date->$GLOBALS["toSql"]() . "';";
			$this->db->setQuery($sql);
			$this->db->query();
		}


	}

?>
