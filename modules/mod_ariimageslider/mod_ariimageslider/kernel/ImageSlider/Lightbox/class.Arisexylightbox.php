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

class ArisexylightboxImageSliderEngine extends AriImageSliderLightboxEngine 
{
	function preCheck()
	{
		$version = new JVersion();
		$j15 = version_compare($version->getShortVersion(), '1.6.0', '<');
		$plgPath = JPATH_ROOT . DS . 'plugins' . DS . 'system' . DS . (!$j15 ? 'arisexylightbox' . DS : '') . 'arisexylightbox.php';
		if (!@file_exists($plgPath))
		{
			$mainframe =& JFactory::getApplication();

			$mainframe->enqueueMessage('<b>ARI Image Slider</b>: "System - ARI Sexy Lightbox" plugin isn\'t installed.');
			
			return false;
		}
		
		return true;
	}
	
	function modifyAttrs($lnkAttrs, $imgAttrs, $group, $params)
	{
		$lnkAttrs['rel'] = 'sexylightbox';
		if ($group)
			$lnkAttrs['rel'] .= '[' . $group . ']';
			
		$link = $lnkAttrs['href'];
		$bgColor = $params->get('lightbox_bgColor');
		if ($this->isLink($link))
		{
			$uri = new JURI($link);
			$uri->setVar('TB_iframe', 'true');
			$uri->setVar('height', intval($params->get('lightbox_height'), 10));
			$uri->setVar('width', intval($params->get('lightbox_width'), 10));
			if ($bgColor) $uri->setVar('background', $bgColor);
			$lnkAttrs['href'] = $uri->toString();
		}
		else if ($bgColor)
		{
			$uri = new JURI($link);
			$uri->setVar('background', $bgColor);
			$lnkAttrs['href'] = $uri->toString();
		}

		return parent::modifyAttrs($lnkAttrs, $imgAttrs, $group, $params);
	}
}
?>