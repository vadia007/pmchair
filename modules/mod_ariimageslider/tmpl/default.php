<?php
/*
 * ARI Image Slider Joomla! module
 *
 * @package		ARI Image Slider Joomla! module.
 * @version		1.0.0
 * @author		ARI Soft
 * @copyright	Copyright (c) 2009 www.ari-soft.com. All rights reserved
 * @license		GNU/GPL (http://www.gnu.org/copyleft/gpl.html)
 * 
 */

defined('ARI_FRAMEWORK_LOADED') or die('Direct Access to this location is not allowed.');

$baseUri = JURI::base(true);
$cssClass = $params->get('cssClass');
$startSlide = intval($params->get('opt_startSlide'), 10);
$enableNav = (bool)$params->get('opt_controlNav');
$slideCnt = count($slides);
if ($startSlide < 0 || $startSlide > $slideCnt - 1) $startSlide = 0;

$theme = $params->get('theme');
if (empty($theme))
	$theme = 'default';
$controlNav = (bool)$params->get('opt_controlNav');
?>
<div id="<?php echo $sliderId; ?>_wrapper" class="ari-image-slider-wrapper ari-is-theme-<?php echo $theme; ?><?php if ($cssClass):?> <?php echo $cssClass; ?><?php endif; ?><?php if ($controlNav):?> ari-image-slider-wCtrlNav<?php endif; ?>">
	<div id="<?php echo $sliderId; ?>" class="ari-image-slider nivoSlider">
	<?php
	$slideIdx = 0;
	foreach ($slides as $slide):
		$isLink = !empty($slide['link']);
		$imgAttrs = $slide['imgAttrs'];
		
		if ($slideIdx != $startSlide)
		{
			if (!isset($imgAttrs['style']))
				$imgAttrs['style'] = array();
			$imgAttrs['style']['display'] = 'none';
		}
	?>
		<?php
			if ($isLink):
		?>
			<a<?php echo AriHtmlHelper::getAttrStr($slide['lnkAttrs']); ?>>
		<?php
			endif;
		?>
		<img<?php echo AriHtmlHelper::getAttrStr($imgAttrs); ?> />
		<?php
			if ($isLink):
		?>
			</a>
		<?php
			endif; 
		?>
	<?php
		++$slideIdx;
	endforeach;
	
	if ($enableNav):
	?>
		<div class="nivo-controlNavHolder">
			<div class="nivo-controlNav">
			<?php
				$slideIdx = 0;
				foreach ($slides as $slide):
					$thumbNav = !empty($slide['nav']);
					$nav = $thumbNav ? $slide['nav'] : null;
					$navEl = $thumbNav ? '<img' . AriHtmlHelper::getAttrStr(array('src' => $nav['image'], 'width' => $nav['width'], 'height' => $nav['height'], 'alt' => $nav['alt'])) . '/>' : $slideIdx;
			?>
				<a rel="<?php echo $slideIdx; ?>" class="nivo-control<?php if ($startSlide == $slideIdx):?> active<?php endif; ?>">
					<span<?php echo AriHtmlHelper::getAttrStr(array('style' => array('width' => $nav['width'] . 'px', 'height' => $nav['height'] . 'px'), 'class' => 'nivo-thumbNavWrapper')); ?>>
						<?php echo $navEl; ?>
						<span class="nivo-arrow-border"></span>
						<span class="nivo-arrow"></span>
					</span>
				</a>
			<?php
					++$slideIdx;
				endforeach; 
			?>
			</div>
		</div>
	<?php
	endif; 
	?>
	</div>
</div>