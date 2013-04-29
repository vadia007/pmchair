<?php

    defined('_JEXEC') or die;

JModelLegacy::addIncludePath(JPATH_SITE.'/components/com_content/models', 'ContentModel');

class modAnnouncementHelper
{
 public static function getList(&$params)
 {
     // Get the dbo
     $db = JFactory::getDbo();
     // Get an instance of the generic articles model
     $model = JModelLegacy::getInstance('Articles', 'ContentModel', array('ignore_request' => true));

     // Set application parameters in model
     $app = JFactory::getApplication();
     $appParams = $app->getParams();
     $model->setState('params', $appParams);

     // Category filter
     $model->setState('filter.category_id', $params->get('catid', array()));

     // Set ordering
     $order_map = array(
         'l_cre' => 'a.created',
         'l_mod' => 'CASE WHEN (a.modified = '.$db->quote($db->getNullDate()).') THEN a.created ELSE a.modified END',
     );

     $ordering = JArrayHelper::getValue($order_map, $params->get('ordering'));
     $dir = 'DESC';

     $model->setState('list.ordering', $ordering);
     $model->setState('list.direction', $dir);

     $items = $model->getItems();


     return $items;

 }
}