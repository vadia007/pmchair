<?php
/*
 * ARI Image Slider
 *
 * @package		ARI Image Slider
 * @version		1.0.0
 * @author		ARI Soft
 * @copyright	Copyright (c) 2010 www.ari-soft.com. All rights reserved
 * @license		GNU/GPL (http://www.gnu.org/copyleft/gpl.html)
 * 
 */

defined('ARI_FRAMEWORK_LOADED') or die('Direct Access to this location is not allowed.');

jimport('joomla.environment.uri');

class AriImageSliderLightboxEngine
{
	function preCheck()
	{
		return true;
	}
	
	function modifyAttrs($lnkAttrs, $imgAttrs, $group, $params)
	{
		return array($lnkAttrs, $imgAttrs);
	}
	
	function isImage($link)
	{
		$uri = new JURI($link);
		$path = $uri->getPath();
		
		return (preg_match('/\.(jpg|jpeg|png|bmp|gif)$/i', $path) > 0);
	}
	
	function isLink($link)
	{
		return !$this->isImage($link);
	}
}
?>