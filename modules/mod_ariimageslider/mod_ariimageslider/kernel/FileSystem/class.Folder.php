<?php
/*
 * ARI Framework Lite
 *
 * @package		ARI Framework Lite
 * @version		1.0.0
 * @author		ARI Soft
 * @copyright	Copyright (c) 2009 www.ari-soft.com. All rights reserved
 * @license		GNU/GPL (http://www.gnu.org/copyleft/gpl.html)
 * 
 */

defined('ARI_FRAMEWORK_LOADED') or die('Direct Access to this location is not allowed.');

AriKernel::import('Image.ImageHelper');
AriKernel::import('CSV.CSVParser');

jimport('joomla.filesystem.path');
jimport('joomla.filesystem.folder');

class AriFolder
{
	function files($path, $filter = '.', $recurse = false, $fullpath = false, $sort = null, $exclude = array('.svn', 'CVS'))
	{
		$files = JFolder::files($path, $filter, $recurse, $fullpath, $exclude);
		if (!is_null($sort) && !empty($sort['sortBy']) && !empty($files))
		{
			$files = AriFolderSorter::sort($files, $sort['sortBy'], !empty($sort['sortDir']) ? $sort['sortDir'] : 'asc');
		}
		
		return $files;
	}

	function clean(&$path)
	{
		$path = JPath::clean($path);
		$path = trim($path, '\\/');
		
		return $path;
	}
}

class AriFolderSorter
{
	function sort($files, $method, $dir = 'asc')
	{ 
		$method = 'sortBy' . $method;
		$inst = new AriFolderSorter();
		if (!method_exists($inst, $method))
			return $files;
			
		$files = $inst->$method($files);
		if ($dir == 'desc')
			$files = array_reverse($files);

		return $files;
	}
	
	function sortByFilename($files)
	{
		$idx = 0;
		$postfix = uniqid('sf', false);
		$tmpFiles = array();
		foreach ($files as $file)
		{
			$key = basename($file);
			if (isset($tmpFiles[$key]))
				$key = $key . (++$idx) . $postfix;
			
			$tmpFiles[$key] = $file;
		}

		uksort($tmpFiles, 'strnatcasecmp');
		$files = array_values($tmpFiles);

		return $files;
	}
	
	function sortByModified($files)
	{
		$hasComplexKeys = false;

		$tmpFiles = array();
		foreach ($files as $file)
		{
			$key = @filemtime(JPATH_ROOT . DS . $file);
			if (isset($tmpFiles[$key]))
			{
				$hasComplexKeys = true;
				if (!is_array($tmpFiles[$key]))
					 $tmpFiles[$key] = array($tmpFiles[$key]);

				$tmpFiles[$key][] = $file;
			}
			else 
				$tmpFiles[$key] = $file;

			ksort($tmpFiles, SORT_NUMERIC);
		}
		
		if (!$hasComplexKeys)
		{
			$files = array_values($tmpFiles);
		}
		else
		{
			$files = array();
			$tmpFiles = array_values($tmpFiles);
			foreach ($tmpFiles as $file)
			{
				if (is_array($file))
					$files = array_merge($files, $file);
				else 
					$files[] = $file;
			}
		}
		
		
		return $files;
	}
	
	function sortByRandom($files)
	{
		shuffle($files);

		return $files;
	}
}
?>