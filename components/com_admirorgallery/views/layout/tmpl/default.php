<?php
 /*------------------------------------------------------------------------
# com_admirorgallery - Admiror Gallery Component
# ------------------------------------------------------------------------
# author   Igor Kekeljevic & Nikola Vasiljevski
# copyright Copyright (C) 2011 admiror-design-studio.com. All Rights Reserved.
# @license - http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
# Websites: http://www.admiror-design-studio.com/joomla-extensions
# Technical Support:  Forum - http://www.vasiljevski.com/forum/index.php
# Version: 4.5.0
-------------------------------------------------------------------------*/
// No direct access
defined('_JEXEC') or die('Restricted access');

$ag_inlineParams='';
$ag_inlineParams.=' template="'.$this->template.'"';
$ag_inlineParams.=' thumbWidth="'.$this->thumbWidth.'"';
$ag_inlineParams.=' thumbHeight="'.$this->thumbHeight.'"';
$ag_inlineParams.=' thumbAutoSize="'.$this->thumbAutoSize.'"';
$ag_inlineParams.=' arrange="'.$this->arrange.'"';
$ag_inlineParams.=' newImageTag="'.$this->newImageTag.'"';
$ag_inlineParams.=' newImageDays="'.$this->newImageDays.'"';
$ag_inlineParams.=' frameWidth="'.$this->frameWidth.'"';
$ag_inlineParams.=' frameHeight="'.$this->frameHeight.'"';
$ag_inlineParams.=' showSignature="'.$this->showSignature.'"';
$ag_inlineParams.=' plainTextCaptions="'.$this->plainTextCaptions.'"';
$ag_inlineParams.=' popupEngine="'.$this->popupEngine.'"';
$ag_inlineParams.=' backgroundColor="'.$this->backgroundColor.'"';
$ag_inlineParams.=' foregroundColor="'.$this->foregroundColor.'"';
$ag_inlineParams.=' highliteColor="'.$this->highliteColor.'"';

// Albums Support
$ag_inlineParams.=' albumUse="'.$this->albumUse.'"';
// Paginations Support
$ag_inlineParams.=' paginUse="'.$this->paginUse.'"';
$ag_inlineParams.=' paginImagesPerGallery="'.$this->paginImagesPerGallery.'"';

JPluginHelper::importPlugin( 'content' );

$article = new JObject();
$article->text = '{AG '.$ag_inlineParams.' }'.$this->galleryName.'{/AG}';
$article->id = 0;
$limitstart = 0;
$dispatcher = JDispatcher::getInstance();
$results = $dispatcher->trigger('onContentPrepare', array ( &$context, &$article, & $params, $limitstart));
echo $article->text;

?>