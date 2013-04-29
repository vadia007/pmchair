<?php
// no direct access
defined('_JEXEC') or die;
require_once dirname(__FILE__).'/helper.php';
$list = modAnnouncementHelper::getList($params);
require JModuleHelper::getLayoutPath('mod_announcement', $params->get('layout', 'default'));