<?php
defined('ARI_FRAMEWORK_LOADED') or die('Direct Access to this location is not allowed.');

AriKernel::import('Image.Asido.AsidoHelper');
AriKernel::import('Utils.Utils');

class AriImageHelper extends AriObject
{
	function getThumbnailDimension($path, $w, $h)
	{
		$dim = array('w' => $w, 'h' => $h);
		if ($w && $h || (!$w && !$h)) return $dim;

		if (@is_readable($path) && function_exists('getimagesize'))
		{
			$info = @getimagesize($path);
			if (!empty($info) && count($info) > 1)
			{
				if (empty($w))
				{
					$w = round($h * $info[0] / $info[1]);
					$dim['w'] = $w;
				}
				else
				{
					$h = round($w * $info[1] / $info[0]);
					$dim['h'] = $h;
				}
			}
		}
		
		return $dim;
	}
	
	function generateThumbnailFileName($prefix, $originalImgPath, $width, $height, $type = 'resize')
	{
		if ($type == 'resize')
			$type = '';
		
		$path_parts = pathinfo($originalImgPath);
		$mTime = @filemtime($originalImgPath);
		return sprintf('%s_%s_%s_%s.%s',
					$prefix,
					md5($originalImgPath . $type . $mTime),
					$width,
					$height,
					$path_parts['extension']);
	}
	
	function generateThumbnail($originalImgPath, $thumbDir, $prefix, $thumbWidth = 0, $thumbHeight = 0, $type = 'resize', $typeParams = array(), $filters = array())
	{
		$thumbSize = AriImageHelper::getThumbnailDimension($originalImgPath, $thumbWidth, $thumbHeight);
		if (!$thumbSize['w'] || !$thumbSize['h'] || !@is_readable($originalImgPath))
			return null;

		$width = $thumbSize['w'];
		$height = $thumbSize['h'];
		$path_parts = pathinfo($originalImgPath);

		$thumbName = AriImageHelper::generateThumbnailFileName($prefix, $originalImgPath, $width, $height, $type);
		$thumbImgPath = $thumbDir . DS . $thumbName;
		if (@file_exists($thumbImgPath) && @filemtime($thumbImgPath) > @filemtime($originalImgPath))
			return $thumbName;

		if (!AriImageHelper::initAsido())
			return ;
		$thumbImg = Asido::image($originalImgPath, $thumbImgPath);
		$needResize = true;		
		
		if ($type == 'crop')
		{
			Asido::crop(
				$thumbImg,
				intval(AriUtils::getParam($typeParams, 'x', 0), 10),
				intval(AriUtils::getParam($typeParams, 'y', 0), 10),
				$width ? $width : $height,
				$height ? $height : $width
			);
			$needResize = false;
		}
		else if ($type == 'cropresize')
		{
			Asido::crop(
				$thumbImg,
				intval(AriUtils::getParam($typeParams, 'x', 0), 10),
				intval(AriUtils::getParam($typeParams, 'y', 0), 10),
				intval(AriUtils::getParam($typeParams, 'width', 0), 10),
				intval(AriUtils::getParam($typeParams, 'height', 0), 10)
			);
		}

		if ($filters)
		{
			if (AriUtils::parseValueBySample(
					AriUtils::getParam($filters, 'grayscale', false),
					false)
				)
			{
				Asido::grayscale($thumbImg);
			}
			
			$rotateFilter = AriUtils::getParam($filters, 'rotate');
			if (is_array($rotateFilter) && 
				AriUtils::parseValueBySample(
					AriUtils::getParam($rotateFilter, 'enable', false),
					false)
				)
			{
				$angle = 0;
				$rotateType = AriUtils::getParam($rotateFilter, 'type', 'fixed');
				if ($rotateType == 'random')
				{
					$startAngle = intval(AriUtils::getParam($rotateFilter, 'startAngle', 0), 10);
					$endAngle = intval(AriUtils::getParam($rotateFilter, 'endAngle', 0), 10);
					$angle = rand($startAngle, $endAngle);
				}
				else
				{
					$angle = intval(AriUtils::getParam($rotateFilter, 'angle', 0), 10);
				}

				$angle = $angle % 360;
				if ($angle != 0)
				{
					Asido::rotate($thumbImg, $angle);
				}
			}
		}

		if ($needResize)
		{
			if (!$width)
				Asido::height($thumbImg, $height);
			else if (!$height)
				Asido::width($thumbImg, $width);
			else
				Asido::resize($thumbImg, $width, $height, ASIDO_RESIZE_STRETCH);
		}

		$thumbImg->save(ASIDO_OVERWRITE_ENABLED);
		
		return $thumbName;
	}
	
	function initAsido()
	{
		static $initialized;
		
		if (is_null($initialized))
			$initialized = AriAsidoHelper::init();

		return $initialized;
	}
}
?>