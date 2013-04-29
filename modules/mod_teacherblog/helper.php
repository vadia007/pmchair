<?php

    defined('_JEXEC') or die;

JModelLegacy::addIncludePath(JPATH_SITE.'/components/com_content/models', 'ContentModel');

class modTeacherBlogHelper
{
 public static function getList(&$params)
 {
     // Get an instance of the generic articles model
     $model = JModelLegacy::getInstance('Articles', 'ContentModel', array('ignore_request' => true));

     // Set application parameters in model
 //    $app = JFactory::getApplication();
  //   $appParams = $app->getParams();
  //   $model->setState('params', $appParams);

     $input = new JInput;
     $current_art_id = $input->get('id');

     $article = JTable::getInstance('content');
     $article->load( $current_art_id);
     $author = $article->get("created_by");

     $db = JFactory::getDbo();
     $q = $db->getQuery(true);
     $q->select('*');
     $q->from('#__content');
     $q->where('(so_created_by = '.$author.')'.'or (created_by = '.$author.') and (catid = 11)');
     $db->setQuery($q);
     $results = $db->loadObjectList();

//     $model->setState("filter.author_id", $author );
//     $model->setState('filter.category_id', 11);
//     $items = $model->getItems();

     foreach ($results as &$item) {
         $item->link = JRoute::_(ContentHelperRoute::getArticleRoute($item->id, $item->catid));
     }
     return $results;

 }
}