<?php
/*
 *
 * @package		ARI Framework
 * @author		ARI Soft
 * @copyright	Copyright (c) 2011 www.ari-soft.com. All rights reserved
 * @license		GNU/GPL (http://www.gnu.org/copyleft/gpl.html)
 * 
 */

defined('_JEXEC') or die;

if (version_compare(PHP_VERSION, '5.3.0') >= 0)
{
	$error_reporting = ini_get('error_reporting');
	$error_reporting &= ~E_STRICT;
	error_reporting($error_reporting);
}

if (!defined('DS'))
	define('DS', DIRECTORY_SEPARATOR);

if (!defined('J1_5'))
{
	$version = new JVersion();
	define('J1_5', version_compare($version->getShortVersion(), '1.6.0', '<'));
}

if (!defined('J1_6'))
{
	$version = new JVersion();
	define('J1_6', version_compare($version->getShortVersion(), '1.6.0', '>='));
}

if (!defined('J3_0'))
{
	$version = new JVersion();
	define('J3_0', version_compare($version->getShortVersion(), '3.0.0', '>='));
}

if (!defined('ARI_FRAMEWORK_LOADED'))
{
	define('ARI_ROOT_NAMESPACE', '_ARISoft');
	define('ARI_CONSTANTS_NAMESPACE', 'Constants');
	define('ARI_FRAMEWORK_LOADED', true);
	
	class AriKernel
	{
		var $_loadedNamespace = array();
		var $_frameworkPathList = array();
		
		function &instance()
		{
			static $instance;
			
			if (!isset($instance))
			{
				$instance = new AriKernel();
			}
			
			return $instance;
		}
		
		function init()
		{
			$GLOBALS[ARI_ROOT_NAMESPACE] = array();
			$GLOBALS[ARI_ROOT_NAMESPACE][ARI_CONSTANTS_NAMESPACE] = array();
			
			AriKernel::addFrameworkPath(dirname(__FILE__) . '/');
		}
		
		function addFrameworkPath($path)
		{
			$inst =& AriKernel::instance();
			$inst->_frameworkPathList[] = $path;
		}
		
		function import($namespace)
		{
			$inst =& AriKernel::instance();
	
			if (isset($inst->_loadedNamespace[$namespace])) return ;
	
			$part = explode('.', $namespace);
			$lastPos = count($part) - 1;
			$part[$lastPos] = 'class.' . $part[$lastPos] . '.php';

			$pathList = $inst->_frameworkPathList;
			$fileLocalPath = join('/', $part);
			foreach ($pathList as $path)
			{
				$filePath = $path . $fileLocalPath;
				if (file_exists($filePath))
				{ 
					require_once $filePath;
					$inst->_loadedNamespace[$namespace] = true;
					break;
				}
			}
		}	
	}
	
	AriKernel::init();
	AriKernel::import('Core.Object');
}
else 
{
	AriKernel::addFrameworkPath(dirname(__FILE__) . '/');
	AriKernel::import('Core.Object');
}