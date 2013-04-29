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

AriKernel::import('ImageSlider.Lightbox.LightboxEngine');
AriKernel::import('Web.JSON.JSONHelper');

class ArifancyboxImageSliderEngine extends AriImageSliderLightboxEngine 
{
	function preCheck()
	{
		$version = new JVersion();
		$j15 = version_compare($version->getShortVersion(), '1.6.0', '<');
		$plgPath = JPATH_ROOT . DS . 'plugins' . DS . 'system' . DS . (!$j15 ? 'arifancybox' . DS : '') . 'arifancybox.php';
		if (!@file_exists($plgPath))
		{
			$mainframe =& JFactory::getApplication();

			$mainframe->enqueueMessage('<b>ARI Image Slider</b>: "System - ARI Fancybox" plugin isn\'t installed.');
			
			return false;
		}
		
		return true;
	}
	
	function modifyAttrs($lnkAttrs, $imgAttrs, $group, $params)
	{
		if ($group)
			$lnkAttrs['rel'] = $group;
			
		if (empty($lnkAttrs['class']))
			$lnkAttrs['class'] = '';
		else
			$lnkAttrs['class'] .= ' ';
			
		$lnkAttrs['class'] .= 'arifancybox';

		$link = $lnkAttrs['href'];
		if ($this->isLink($link))
		{
			$lnkParams = array('width' => $params->get('lightbox_width'), 'height' => $params->get('lightbox_height'));
			foreach ($lnkParams as $key => $value)
			{
				if (strpos($value, '%') === false)
					$lnkParams[$key] = intval($value, 10);
			}
			
			$lnkAttrs['class'] .= ' iframe ' . str_replace('"', '&quot;', AriJSONHelper::encode($lnkParams));
		}

		return parent::modifyAttrs($lnkAttrs, $imgAttrs, $group, $params);
	}
}
?>