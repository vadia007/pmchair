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

class FoxInstaller
{
	private $InstallLog;

	function install($parent)
		{
		$lang = JFactory::getLanguage();
		$manifest = $parent->get("manifest");

		$direction = intval(JFactory::getLanguage()->get('rtl', 0));
		$left  = $direction ? "right" : "left";
		$right = $direction ? "left" : "right";

		echo(
			'<img src="' . $manifest->authorUrl->data() . 'images/' . substr($parent->get('element'), 4) . '-logo.php" ' .
			'alt="' . $lang->_($manifest->name->data()) . ' Logo" ' .
			'style="float:' . $left . ';margin:15px;" width="128" height="128" />' .
			'<h2>' . $lang->_($manifest->name->data()) . '</h2>'
			);

		require_once(JPATH_ROOT . DS . 'components' . DS . $parent->get('element') . DS . 'helpers' . DS . 'flogger.php');
		$this->InstallLog = new FLogger("installscript", "install");

		// o.s. version and safe mode
		$this->InstallLog->Write("Running on php " . PHP_VERSION . " | " . PHP_OS . " | safe_mode: " . intval(ini_get("safe_mode")) . " | interface: " . php_sapi_name());

		$this->chain_install($parent);
		$this->check_environment($parent);
		}


	function uninstall($parent) 
		{
		}


	function update($parent) 
		{
		}


	function preflight($type, $parent)
		{
		}


	function postflight($type, $parent) 
		{
		}


	private function chain_install(&$parent)
		{
		$manifest = $parent->get("manifest");
		$p_installer = $parent->getParent();
		$installer = new JInstaller();
		// Install modules
		if (is_object($manifest->modules->module))
			{
			foreach($manifest->modules->module as $module)
				{
				$attributes = $module->attributes();
				$mod = $p_installer->getPath("source") . DS . $attributes['folder'] . DS . $attributes['module'];
				$installer->install($mod);
				}
			}
		}


	private function check_environment(&$parent)
		{
		$this->check_permissions($parent);

		// http://docs.joomla.org/How_to_use_the_filesystem_package
		// http://docs.joomla.org/API16:JFolder/files
		jimport('joomla.filesystem.folder');
		$files = JFolder::files(JPATH_ROOT . DS . 'components' . DS . $parent->get('element') . DS . 'helpers', ".php");
		foreach ($files as $file)
			{
			// Include the file
			require_once(JPATH_ROOT . DS . 'components' . DS . $parent->get('element') . DS . 'helpers' . DS . $file);
			// Remove the extension
			$name = JFile::stripExt($file);
			$classname = $name . 'CheckEnvironment';
			if (class_exists($classname))
				{
				// create a new instance
				$installerclass = new $classname();
				}
			}
		}


	private function check_permissions(&$parent)
		{
		jimport('joomla.filesystem.folder');

		// File permission needed in suexec environments
		$permissions = fileperms(JPATH_ADMINISTRATOR . DS . "index.php");
		$buffer = sprintf("Determining correct file permissions...  [%o]", $permissions);
		$this->InstallLog->Write($buffer);
		if ($permissions)
			{
			$files = JFolder::files(JPATH_ROOT . DS . 'components' . DS . $parent->get('element') . DS . 'lib', ".php", false, true);
			foreach ($files as $file)
				{
				$this->set_permissions($file, $permissions);
				}
			}

		// Directory permission needed in suexec environments
		$permissions = fileperms(JPATH_ADMINISTRATOR);
		$buffer = sprintf("Determining correct directory permissions...  [%o]", $permissions);
		$this->InstallLog->Write($buffer);
		if ($permissions)
			{
			$this->set_permissions(JPATH_ROOT . DS . "components", $permissions);
			$this->set_permissions(JPATH_ROOT . DS . "components" . DS . $parent->get('element'), $permissions);
			$this->set_permissions(JPATH_ROOT . DS . "components" . DS . $parent->get('element') . DS . "lib", $permissions);
			}


		// Todo: If we are using FTP Layer we certainly need to set permissions to upload directory too.
		// ...
		}


	private function set_permissions($filename, $permissions)
		{
		jimport("joomla.client.helper");
		$ftp_config = JClientHelper::getCredentials('ftp');

		if ($ftp_config['enabled'])
			{
			jimport("joomla.client.ftp");
			jimport("joomla.filesystem.path");
			$jpath_root = JPATH_ROOT;
			$filename = JPath::clean(str_replace(JPATH_ROOT, $ftp_config['root'], $filename), '/');
			$ftp = new JFTP($ftp_config);
			$result = intval($ftp->chmod($filename, $permissions));
			}
		else
			{
			$result = intval(@chmod($filename, $permissions));
			}

		$this->InstallLog->Write("setting permissions for [$filename]... [$result]");
		return $result;
		}
}
?>
