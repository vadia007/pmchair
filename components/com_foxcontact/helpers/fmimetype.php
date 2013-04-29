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
	require_once($inc_dir . DS . 'flogger.php');
	include_once(realpath(dirname(__FILE__) . DS . ".." . DS . substr(basename(realpath(dirname(__FILE__) . DS . "..")), 4) . ".inc"));


	class FMimeType
	{
		public $Allowed = array();
		public $Mimetype;

		public function __construct()
		{
		}


		public function Check($filename, &$cparams)
		{
			// If a filter is not required, return without checking anything else
			// Note that default value is 1 as a protection against malformed session
			if (!(bool)$cparams->get("upload_filter", 1)) return true;

			// Ok, we are not so lucky. First we read allowed mime types family
			// Note that default value is 0 as a protection against malformed session
			if ((bool)$cparams->get("upload_audio", 0)) $this->Allowed[] = "/^audio\//";
			if ((bool)$cparams->get("upload_video", 0)) $this->Allowed[] = "/^video\//";
			if ((bool)$cparams->get("upload_images", 0)) $this->Allowed[] = "/^image\//";
			if ((bool)$cparams->get("upload_archives", 0))
			{
				$this->Allowed[] = "/^application\/.*zip/"; // zip
				$this->Allowed[] = "/^application\/x-compress/"; // z
				$this->Allowed[] = "/^application\/x-compressed/"; // tgz
				$this->Allowed[] = "/^application\/x-gzip/"; // gz
				$this->Allowed[] = "/^application\/x-rar/"; // rar
			}

			if ((bool)$cparams->get("upload_documents", 0))
			{
				$this->Allowed[] = "/^(application|text)\/rtf/"; // rtf
				$this->Allowed[] = "/^application\/pdf/"; // pdf
				$this->Allowed[] = "/^application\/msword/"; // doc dot
				$this->Allowed[] = "/^application\/vnd.ms-/"; // (excel) xla xlc xlm xls xlt xlw (powerpoint) pot pps ppt (works) wcm wdb wks wps
				$this->Allowed[] = "/^application\/vnd\.openxmlformats-officedocument\./"; // docx xlsx pptx
				$this->Allowed[] = "/^application\/x-mspublisher/"; // pub
				$this->Allowed[] = "/^application\/x-mswrite/"; // wri
				$this->Allowed[] = "/^application\/vnd\.oasis\.opendocument\.text/"; // odt
			}

			$this->Mimetype = $this->read_mimetype($filename);

			// Filter disabled because of poor mimeinfo support on server
			// which means that $cparams->get("upload_filter") IS NOT SET IN THE PARAMETERS
			// and weren't return in the first line of this function
			if ($this->Mimetype == "disabled") return true;

			// Remove charset information. Not really needed, but useful if the caller wants to display the mimetype
			$this->Mimetype = preg_replace("/;.*/", "", $this->Mimetype);

			foreach ($this->Allowed as $allowed_type)
			{
				if ((bool)preg_match($allowed_type, $this->Mimetype)) return true;
			}

			return false;
		}


		private function read_mimetype($filename)
		{
			$debug_log = new FDebugLogger("fmimetype");
			$debug_log->Write("Determining mimetype");

			$db = JFactory::getDBO();
			$sql = "SELECT value FROM #__" . $GLOBALS["ext_name"] . "_settings WHERE name = 'mimefilter';";
			$db->setQuery($sql);
			$method = $db->loadResult();
			if (!$method)
			{
				// $db->getErrorMsg() contains sensitive data after " SQL="
				$debug_log->Write("Error #" . $db->getErrorNum() . " while loading mimefilter from database");
				return "";
			}

			$result = $this->$method($filename);
			$debug_log->Write("mime method: [" . $method . "], mime detected: [" . $result . "]");
			return $result;
		}


		private function use_fileinfo($filename)
		{
			$minfo = new finfo(FILEINFO_MIME);
			return $minfo->file($filename);
		}


		private function use_mimecontent($filename)
		{
			return mime_content_type($filename);
		}


		private function use_exec($filename)
		{
			$output = array();
			$returncode = 0;
			return exec('file -b --mime-type ' . escapeshellarg($filename), $output, $returncode);
		}


		private function disabled($filename)
		{
			// 1) In the component options, a disabled value is not stored and subsequential query load a default
			// 2) I have to set as default filter enabled to 1 and all filetype to 0 in function Check()
			// This is the only rasonable point to detect that mime filter is disabled. The caller will check this return value
			return "disabled";
		}

	}


	class fmimetypeCheckEnvironment
	{
		protected $InstallLog;

		public function __construct()
		{
			$this->InstallLog = new FLogger("fmimetype", "install");
			$this->InstallLog->Write("--- Determining if this system is able to detect file mime types ---");

			switch (true)
			{
				case $this->fileinfo_usable(): $value = "use_fileinfo"; break;
				case $this->mimecontent_usable(): $value = "use_mimecontent"; break;
				case $this->exec_usable(): $value = "use_exec"; break;
					// No way to determine files mime type
				default: $value = "disabled";
			}

			$db = JFactory::getDBO();
			$sql = "REPLACE INTO #__" . $GLOBALS["ext_name"] . "_settings (name, value) VALUES ('mimefilter', '$value');";
			$db->setQuery($sql);
			$result = $db->query();

			$this->InstallLog->Write("--- Method choosen to detect file mime types is [$value] ---");
			return $result;
		}

		// If available, we'll use PECL FileInfo
		private function fileinfo_usable()
		{
			if (!extension_loaded('fileinfo'))
			{
				$this->InstallLog->Write("fileinfo extension not found");
				return false;
			}
			$this->InstallLog->Write("fileinfo extension found. Let's see if it works.");

			$minfo = new finfo(FILEINFO_MIME);

			$result = true;
			$result &= $this->test($minfo->file($this->filename("test.mp3")), "/^audio\//");
			$result &= $this->test($minfo->file($this->filename("test.mp4")), "/^video\//");
			$result &= $this->test($minfo->file($this->filename("test.jpg")), "/^image\//");
			$result &= $this->test($minfo->file($this->filename("test.zip")), "/^application\/.*zip/");
			$result &= $this->test($minfo->file($this->filename("test.pdf")), "/^application\/pdf/");
			return $result;
		}


		// So you have an outdated server... as a second choice, we'll use deprecated function mime_content_type
		private function mimecontent_usable()
		{
			if (!function_exists('mime_content_type'))
			{
				$this->InstallLog->Write("mime_content_type() function not found");
				return false;
			}
			$this->InstallLog->Write("mime_content_type() function found. Let's see if it works.");

			$result = true;
			$result &= $this->test(mime_content_type($this->filename("test.mp3")), "/^audio\//");
			$result &= $this->test(mime_content_type($this->filename("test.mp4")), "/^video\//");
			$result &= $this->test(mime_content_type($this->filename("test.jpg")), "/^image\//");
			$result &= $this->test(mime_content_type($this->filename("test.zip")), "/^application\/.*zip/");
			$result &= $this->test(mime_content_type($this->filename("test.pdf")), "/^application\/pdf/");
			return $result;
		}


		// Call system shell functions
		private function exec_usable()
		{
			// Check if we are on linux environment
			if (substr($_SERVER['PATH'], 0, 1) != '/')
			{
				$this->InstallLog->Write("Not a unix environment. No way to get mime info by calling system shell functions.");
				return false;
			}

			//		if (strpos(ini_get("disable_functions"), "exec") !== false)
			if (!function_exists('exec'))
			{
				$this->InstallLog->Write("exec() function disabled by server administrator. No way to get mime info by calling system shell functions.");
				return false;
			}

			if (!function_exists('escapeshellarg'))
			{
				$this->InstallLog->Write("escapeshellarg() function disabled by server administrator. It isn't safe to call exec().");
				return false;
			}


			$this->InstallLog->Write("exec() enabled. It should be safe to call it. Let's see if it works.");

			$result = true;
			$result &= $this->test($this->system_opinion($this->filename("test.mp3")), "/^audio\//");
			$result &= $this->test($this->system_opinion($this->filename("test.mp4")), "/^video\//");
			$result &= $this->test($this->system_opinion($this->filename("test.jpg")), "/^image\//");
			$result &= $this->test($this->system_opinion($this->filename("test.zip")), "/^application\/.*zip/");
			$result &= $this->test($this->system_opinion($this->filename("test.pdf")), "/^application\/pdf/");
			return $result;
		}


		private function system_opinion($filename)
		{
			$output = array();
			$returncode = 0;
			return /*$system_opinion =*/ exec('file -b --mime-type ' . escapeshellarg($filename), $output, $returncode);
			/*
			if ($returncode == '0' && $system_opinion) 
			{
			// Succesfull
			return $system_opinion;
			}
			*/
		}


		private function test($detected, $expected)
		{
			//$result = strpos($detected, $expected) !== false;
			$result = preg_match($expected, $detected);
			$this->InstallLog->Write("testing detected mimetype [$detected] seeking expected string [$expected]... [" . intval($result) . "]");
			return $result;
		}


		private function filename($filename)
		{
			return JPATH_ROOT . DS . "media" . DS . $GLOBALS["com_name"] . DS . "mimetypes" . DS . $filename;
		}



	}

?>
