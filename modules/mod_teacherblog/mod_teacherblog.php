<?php
// no direct access
defined('_JEXEC') or die;
require_once dirname(__FILE__) . '/helper.php';
$list = modTeacherBlogHelper::getList($params);
require JModuleHelper::getLayoutPath('mod_teacherblog', $params->get('layout', 'default'));