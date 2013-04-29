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

class AriError
{
	var $error;
	var $file;
	var $line;
	
	function AriError($error, $file = null, $line = null)
	{
		$this->error = $error;
		$this->file = $file;
		$this->line = $line; 
	}
}
?>
