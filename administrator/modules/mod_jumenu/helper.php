<?php
defined('_JEXEC') or die('Restricted access');

error_reporting(0);


class modJUMenuHelper
{
	private static $loaded = false;

	public function renderMenu()
	{
		$menu = self::build();

		//JHTML::_( 'behavior.mootools' );
		$js = 'window.addEvent(\'domready\', function(){
				var JUMenu = new Element( "li", { "class": "node" } );
				JUMenu.innerHTML = \''.$menu.'\';
				$( "menu" ).adopt( JUMenu );
			 });';
		$document = & JFactory::getDocument();
		$document->addScriptDeclaration($js);
        }

	private function build()
    {   $user = JFactory::getUser();
		$site = 'http://joomla-ua.org/';

		$out = '<a>Підтримка</a>';
		$out .= '<ul>';
		$out .= '<li class="node"><a class="icon-16-featured" href="'.$site.'" target="_blank">Joomla! Україна</a><ul><li><a class="icon-16-help-docs" href="'.$site.'news" target="_blank">Новини Joomla! Україна</a></li><li><a class="icon-16-help-docs" href="'.$site.'community" target="_blank">Спільнота</a></li><li><a class="icon-16-help-docs" href="'.$site.'blogs" target="_blank">Блоги</a></li><li><a class="icon-16-newsfeeds" href="http://feeds.feedburner.com/joomla-ua?format=xml" target="_blank">RSS</a></li></ul></li>';

		$out .= '<li class="node"><a class="icon-16-language" href="'.$site.'localization" target="_blank">Локалізація</a><ul><li><a class="icon-16-language" href="'.$site.'joomla" target="_blank">Завантажити Joomla</a></li><li><a class="icon-16-language" href="'.$site.'forum/viewforum.php?f=184" target="_blank">Локалізації розширень Joomla 2.5</a></li></ul></li>';

		$out .= '<li class="separator"></li>';

		$out .= '<li class="node"><a class="icon-16-help" href="'.$site.'forum/" target="_blank">Підтримка Joomla! Україна</a><ul><li><a class="icon-16-help-forum" href="'.$site.'forum/viewforum.php?f=177" target="_blank">Форум підтримки Joomla 2.5</a></li><li><a class="icon-16-help-docs" href="http://docs.joomla-ua.org/" target="_blank">Документація</a></li><li><a class="icon-16-help-dev" href="'.$site.'forum/bugtracker/viewcat.php?c=10" target="_blank">Баг-трекер перекладу Joomla 2.5</a></li></ul></li>';

		$out .= '<li class="node"><a class="icon-16-help" href="'.$site.'forum/" target="_blank">Запитання та відповіді</a><ul><li><a class="icon-16-help-forum" href="'.$site.'faq/index/zagalni-pitanna" target="_blank">Загальні питання</a></li><li><a class="icon-16-help-forum" href="'.$site.'faq/index/joomla-2-5" target="_blank">Joomla 2.5</a></li><li><a class="icon-16-help-forum" href="'.$site.'faq/index/rozshirennya" target="_blank">Розширення</a></li><li><a class="icon-16-help-forum" href="'.$site.'faq/index/shabloni-ta-dizajn" target="_blank">Шаблони та дизайн</a></li></ul></li>';

		$out .= '<li class="separator"></li>';

		$out .= '<li><a class="icon-16-featured" href="http://demo.joomla-ua.org/" target="_blank">Демо-сайт Joomla</a></li>';

		$out .= '<li class="separator"></li>';

		$out .= '<li><a class="icon-16-themes" href="'.$site.'joomla-in-ukraine" target="_blank">Проект Joomla!® в Україні</a></li>';

		$out .= '<li class="separator"></li>';

		$out .= '<li><a class="icon-16-featured" href="'.$site.'donation" target="_blank">Пожертвування проекту</a></li>';
		$out .= '</ul>';
        if ($user->authorise('core.admin'))
    {
		return $out;
	}
}
}