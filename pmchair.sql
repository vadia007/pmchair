-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Янв 13 2013 г., 23:29
-- Версия сервера: 5.5.28
-- Версия PHP: 5.4.6-1ubuntu1.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `pmchair`
--

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_assets`
--

CREATE TABLE IF NOT EXISTS `pc7bw_assets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set parent.',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `level` int(10) unsigned NOT NULL COMMENT 'The cached level in the nested tree.',
  `name` varchar(50) NOT NULL COMMENT 'The unique name for the asset.\n',
  `title` varchar(100) NOT NULL COMMENT 'The descriptive title for the asset.',
  `rules` varchar(5120) NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_asset_name` (`name`),
  KEY `idx_lft_rgt` (`lft`,`rgt`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=64 ;

--
-- Дамп данных таблицы `pc7bw_assets`
--

INSERT INTO `pc7bw_assets` (`id`, `parent_id`, `lft`, `rgt`, `level`, `name`, `title`, `rules`) VALUES
(1, 0, 1, 123, 0, 'root.1', 'Root Asset', '{"core.login.site":{"6":1,"2":1},"core.login.admin":{"6":1,"9":1},"core.login.offline":{"6":1},"core.admin":{"8":1},"core.manage":{"7":1},"core.create":{"6":1,"9":1,"3":1},"core.delete":{"6":1,"9":0},"core.edit":{"6":1,"9":0,"4":1},"core.edit.state":{"6":1,"9":0,"5":1},"core.edit.own":{"6":1,"3":1}}'),
(2, 1, 1, 2, 1, 'com_admin', 'com_admin', '{}'),
(3, 1, 3, 6, 1, 'com_banners', 'com_banners', '{"core.admin":{"7":1},"core.manage":{"6":1,"9":0},"core.create":{"9":0},"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(4, 1, 7, 8, 1, 'com_cache', 'com_cache', '{"core.admin":{"7":1},"core.manage":{"7":1}}'),
(5, 1, 9, 10, 1, 'com_checkin', 'com_checkin', '{"core.admin":{"7":1},"core.manage":{"7":1}}'),
(6, 1, 11, 12, 1, 'com_config', 'com_config', '{}'),
(7, 1, 13, 16, 1, 'com_contact', 'com_contact', '{"core.admin":{"7":1},"core.manage":{"6":1,"9":0},"core.create":{"9":0},"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":{"9":0}}'),
(8, 1, 17, 74, 1, 'com_content', 'com_content', '{"core.admin":{"7":1},"core.manage":{"6":1,"9":1},"core.create":{"9":1,"3":1},"core.delete":[],"core.edit":{"4":1},"core.edit.state":{"5":1},"core.edit.own":{"9":1}}'),
(9, 1, 75, 76, 1, 'com_cpanel', 'com_cpanel', '{}'),
(10, 1, 77, 78, 1, 'com_installer', 'com_installer', '{"core.admin":[],"core.manage":{"7":0},"core.delete":{"7":0},"core.edit.state":{"7":0}}'),
(11, 1, 79, 80, 1, 'com_languages', 'com_languages', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(12, 1, 81, 82, 1, 'com_login', 'com_login', '{}'),
(13, 1, 83, 84, 1, 'com_mailto', 'com_mailto', '{}'),
(14, 1, 85, 86, 1, 'com_massmail', 'com_massmail', '{}'),
(15, 1, 87, 88, 1, 'com_media', 'com_media', '{"core.admin":{"7":1},"core.manage":{"6":1,"9":0},"core.create":{"9":0,"3":1},"core.delete":{"5":1}}'),
(16, 1, 89, 90, 1, 'com_menus', 'com_menus', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(17, 1, 91, 92, 1, 'com_messages', 'com_messages', '{"core.admin":{"7":1},"core.manage":{"7":1}}'),
(18, 1, 93, 94, 1, 'com_modules', 'com_modules', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(19, 1, 95, 98, 1, 'com_newsfeeds', 'com_newsfeeds', '{"core.admin":{"7":1},"core.manage":{"6":1,"9":0},"core.create":{"9":0},"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":{"9":0}}'),
(20, 1, 99, 100, 1, 'com_plugins', 'com_plugins', '{"core.admin":{"7":1},"core.manage":[],"core.edit":[],"core.edit.state":[]}'),
(21, 1, 101, 102, 1, 'com_redirect', 'com_redirect', '{"core.admin":{"7":1},"core.manage":[]}'),
(22, 1, 103, 104, 1, 'com_search', 'com_search', '{"core.admin":{"7":1},"core.manage":{"6":1,"9":0},"core.edit.state":[]}'),
(23, 1, 105, 106, 1, 'com_templates', 'com_templates', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(24, 1, 107, 110, 1, 'com_users', 'com_users', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(25, 1, 111, 114, 1, 'com_weblinks', 'com_weblinks', '{"core.admin":{"7":1},"core.manage":{"6":1,"9":0},"core.create":{"9":0,"3":1},"core.delete":[],"core.edit":{"4":1},"core.edit.state":{"5":1},"core.edit.own":[]}'),
(26, 1, 115, 116, 1, 'com_wrapper', 'com_wrapper', '{}'),
(27, 8, 18, 19, 2, 'com_content.category.2', 'Uncategorised', '{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":[]}'),
(28, 3, 4, 5, 2, 'com_banners.category.3', 'Uncategorised', '{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(29, 7, 14, 15, 2, 'com_contact.category.4', 'Uncategorised', '{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":[]}'),
(30, 19, 96, 97, 2, 'com_newsfeeds.category.5', 'Uncategorised', '{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":[]}'),
(31, 25, 112, 113, 2, 'com_weblinks.category.6', 'Uncategorised', '{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":[]}'),
(32, 24, 108, 109, 1, 'com_users.category.7', 'Uncategorised', '{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(33, 1, 117, 118, 1, 'com_finder', 'com_finder', '{"core.admin":{"7":1},"core.manage":{"6":1,"9":0},"core.create":{"9":0},"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(34, 1, 119, 120, 1, 'com_joomlaupdate', 'com_joomlaupdate', '{"core.admin":[],"core.manage":[],"core.delete":[],"core.edit.state":[]}'),
(35, 8, 20, 27, 2, 'com_content.category.8', 'Викладачі кафедри', '{"core.create":{"6":1,"3":1},"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1},"core.edit.own":{"6":1,"3":1}}'),
(36, 8, 28, 41, 2, 'com_content.category.9', 'Новини', '{"core.create":{"6":1,"3":1},"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1},"core.edit.own":{"6":1,"3":1}}'),
(37, 8, 42, 57, 2, 'com_content.category.10', 'Оголошення', '{"core.create":{"6":1,"3":1},"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1},"core.edit.own":{"6":1,"3":1}}'),
(38, 8, 58, 71, 2, 'com_content.category.11', 'Дисципліни', '{"core.create":{"6":1,"3":1},"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1},"core.edit.own":{"6":1,"3":1}}'),
(39, 36, 29, 30, 3, 'com_content.article.1', 'Новина 1', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(40, 36, 31, 32, 3, 'com_content.article.2', 'Новина 2', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(41, 37, 43, 44, 3, 'com_content.article.3', 'Оголошення 1', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(42, 37, 45, 46, 3, 'com_content.article.4', 'Оголошення 2', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(43, 37, 47, 48, 3, 'com_content.article.5', 'Оголошення 3', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(44, 37, 49, 50, 3, 'com_content.article.6', 'Оголошення 3', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(45, 37, 51, 52, 3, 'com_content.article.7', 'Оголошення 4', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(46, 37, 53, 54, 3, 'com_content.article.8', 'Оголошення 5', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(47, 38, 59, 60, 3, 'com_content.article.9', 'Дисципліна 1', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(48, 1, 121, 122, 1, 'com_attachments', 'com_attachments', '{"core.admin":[],"core.manage":{"9":1},"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":{"9":1},"attachments.edit.state.own":{"9":1},"attachments.delete.own":{"9":0},"attachments.edit.ownparent":{"9":0},"attachments.edit.state.ownparent":{"9":0},"attachments.delete.ownparent":{"9":0}}'),
(49, 36, 33, 34, 3, 'com_content.article.10', 'Новина 3', ''),
(50, 8, 72, 73, 2, 'com_content.category.12', '11', ''),
(51, 38, 61, 62, 3, 'com_content.article.11', 'Дисципліна 2', '{"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(52, 38, 63, 64, 3, 'com_content.article.12', 'Дисципліна 3', ''),
(53, 38, 65, 66, 3, 'com_content.article.13', 'Дисципліна 4', '{"core.delete":{"6":1,"9":0},"core.edit":{"6":1,"9":0,"4":1},"core.edit.state":{"6":1,"9":0,"5":1}}'),
(54, 36, 35, 36, 3, 'com_content.article.14', 'Новина 3', '{"core.delete":{"6":1,"9":0},"core.edit":{"6":1,"9":0,"4":1},"core.edit.state":{"6":1,"9":0,"5":1}}'),
(55, 36, 37, 38, 3, 'com_content.article.15', 'якась новина', '{"core.delete":{"6":1,"9":0},"core.edit":{"6":1,"9":0,"4":1},"core.edit.state":{"6":1,"9":0,"5":1}}'),
(56, 37, 55, 56, 3, 'com_content.article.16', 'Оголошення 2', '{"core.delete":{"6":1,"9":0},"core.edit":{"6":1,"9":0,"4":1},"core.edit.state":{"6":1,"9":0,"5":1}}'),
(57, 36, 39, 40, 3, 'com_content.article.17', 'Новина викладача', ''),
(58, 35, 21, 22, 3, 'com_content.article.18', 'викладач 2', '{"core.delete":{"6":1,"9":0},"core.edit":{"6":1,"9":0,"4":1},"core.edit.state":{"6":1,"9":0,"5":1}}'),
(59, 38, 67, 68, 3, 'com_content.article.19', 'Дисципліна викладача 2', '{"core.delete":{"6":1,"9":0},"core.edit":{"6":1,"9":0,"4":1},"core.edit.state":{"6":1,"9":0,"5":1}}'),
(60, 35, 23, 24, 3, 'com_content.article.20', 'Викладач 3', '{"core.delete":{"6":1,"9":0},"core.edit":{"6":1,"9":0,"4":1},"core.edit.state":{"6":1,"9":0,"5":1}}'),
(61, 38, 69, 70, 3, 'com_content.article.21', 'Дисципліна викладача 3', '{"core.delete":{"6":1,"9":0},"core.edit":{"6":1,"9":0,"4":1},"core.edit.state":{"6":1,"9":0,"5":1}}'),
(62, 35, 25, 26, 3, 'com_content.article.22', 'Викладач 1', '');

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_associations`
--

CREATE TABLE IF NOT EXISTS `pc7bw_associations` (
  `id` varchar(50) NOT NULL COMMENT 'A reference to the associated item.',
  `context` varchar(50) NOT NULL COMMENT 'The context of the associated item.',
  `key` char(32) NOT NULL COMMENT 'The key for the association computed from an md5 on associated ids.',
  PRIMARY KEY (`context`,`id`),
  KEY `idx_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_attachments`
--

CREATE TABLE IF NOT EXISTS `pc7bw_attachments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(80) NOT NULL,
  `filename_sys` varchar(255) NOT NULL,
  `file_type` varchar(128) NOT NULL,
  `file_size` int(11) unsigned NOT NULL,
  `url` varchar(1024) NOT NULL DEFAULT '',
  `uri_type` enum('file','url') DEFAULT 'file',
  `url_valid` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `url_relative` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `display_name` varchar(80) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `icon_filename` varchar(20) NOT NULL,
  `access` int(11) NOT NULL DEFAULT '1',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `user_field_1` varchar(255) NOT NULL DEFAULT '',
  `user_field_2` varchar(255) NOT NULL DEFAULT '',
  `user_field_3` varchar(255) NOT NULL DEFAULT '',
  `parent_type` varchar(100) NOT NULL DEFAULT 'com_content',
  `parent_entity` varchar(100) NOT NULL DEFAULT 'article',
  `parent_id` int(11) unsigned DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modified_by` int(11) NOT NULL,
  `download_count` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Дамп данных таблицы `pc7bw_attachments`
--

INSERT INTO `pc7bw_attachments` (`id`, `filename`, `filename_sys`, `file_type`, `file_size`, `url`, `uri_type`, `url_valid`, `url_relative`, `display_name`, `description`, `icon_filename`, `access`, `state`, `user_field_1`, `user_field_2`, `user_field_3`, `parent_type`, `parent_entity`, `parent_id`, `created`, `created_by`, `modified`, `modified_by`, `download_count`) VALUES
(5, 'KP_Nikolaenko1.doc', '/var/www/pmchair/attachments/article/1/KP_Nikolaenko1.doc', 'application/msword', 939520, 'attachments/article/1/KP_Nikolaenko1.doc', 'file', 0, 0, '', '', 'word.gif', 1, 1, '', '', '', 'com_content', 'article', 1, '2013-01-06 22:22:52', 974, '2013-01-06 22:32:10', 974, 0),
(12, 'Курсова_Приймак_САОД.docx', '/var/www/pmchair/attachments/article/1/Курсова_Приймак_САОД.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 1012119, 'attachments/article/1/Курсова_Приймак_САОД.docx', 'file', 0, 0, '', '', 'wordx.gif', 1, 1, '', '', '', 'com_content', 'article', 1, '2013-01-06 22:49:50', 974, '2013-01-06 22:49:50', 974, 0),
(15, 'гимнастика.doc', '/var/www/pmchair/attachments/article/21/гимнастика.doc', 'application/msword', 22528, 'attachments/article/21/гимнастика.doc', 'file', 0, 0, '', '', 'word.gif', 1, 1, '', '', '', 'com_content', 'article', 21, '2013-01-12 14:20:30', 974, '2013-01-12 14:20:30', 974, 0),
(14, 'гимнастика.doc', '/var/www/pmchair/attachments/article/6/гимнастика.doc', 'application/msword', 22528, 'attachments/article/6/гимнастика.doc', 'file', 0, 0, '', '', 'word.gif', 1, 1, '', '', '', 'com_content', 'article', 6, '2013-01-08 20:22:18', 974, '2013-01-08 20:22:18', 974, 0),
(13, 'гимнастика.doc', '/var/www/pmchair/attachments/article/9/гимнастика.doc', 'application/msword', 22528, 'attachments/article/9/гимнастика.doc', 'file', 0, 0, '', '', 'word.gif', 1, 1, '', '', '', 'com_content', 'article', 9, '2013-01-06 23:39:10', 975, '2013-01-06 23:39:10', 975, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_banners`
--

CREATE TABLE IF NOT EXISTS `pc7bw_banners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `imptotal` int(11) NOT NULL DEFAULT '0',
  `impmade` int(11) NOT NULL DEFAULT '0',
  `clicks` int(11) NOT NULL DEFAULT '0',
  `clickurl` varchar(200) NOT NULL DEFAULT '',
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `custombannercode` varchar(2048) NOT NULL,
  `sticky` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `params` text NOT NULL,
  `own_prefix` tinyint(1) NOT NULL DEFAULT '0',
  `metakey_prefix` varchar(255) NOT NULL DEFAULT '',
  `purchase_type` tinyint(4) NOT NULL DEFAULT '-1',
  `track_clicks` tinyint(4) NOT NULL DEFAULT '-1',
  `track_impressions` tinyint(4) NOT NULL DEFAULT '-1',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reset` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `language` char(7) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_state` (`state`),
  KEY `idx_own_prefix` (`own_prefix`),
  KEY `idx_metakey_prefix` (`metakey_prefix`),
  KEY `idx_banner_catid` (`catid`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_banner_clients`
--

CREATE TABLE IF NOT EXISTS `pc7bw_banner_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `contact` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `extrainfo` text NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `metakey` text NOT NULL,
  `own_prefix` tinyint(4) NOT NULL DEFAULT '0',
  `metakey_prefix` varchar(255) NOT NULL DEFAULT '',
  `purchase_type` tinyint(4) NOT NULL DEFAULT '-1',
  `track_clicks` tinyint(4) NOT NULL DEFAULT '-1',
  `track_impressions` tinyint(4) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `idx_own_prefix` (`own_prefix`),
  KEY `idx_metakey_prefix` (`metakey_prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_banner_tracks`
--

CREATE TABLE IF NOT EXISTS `pc7bw_banner_tracks` (
  `track_date` datetime NOT NULL,
  `track_type` int(10) unsigned NOT NULL,
  `banner_id` int(10) unsigned NOT NULL,
  `count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`track_date`,`track_type`,`banner_id`),
  KEY `idx_track_date` (`track_date`),
  KEY `idx_track_type` (`track_type`),
  KEY `idx_banner_id` (`banner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_categories`
--

CREATE TABLE IF NOT EXISTS `pc7bw_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table.',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `level` int(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(255) NOT NULL DEFAULT '',
  `extension` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `note` varchar(255) NOT NULL DEFAULT '',
  `description` mediumtext NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(11) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `params` text NOT NULL,
  `metadesc` varchar(1024) NOT NULL COMMENT 'The meta description for the page.',
  `metakey` varchar(1024) NOT NULL COMMENT 'The meta keywords for the page.',
  `metadata` varchar(2048) NOT NULL COMMENT 'JSON encoded metadata properties.',
  `created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cat_idx` (`extension`,`published`,`access`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_path` (`path`),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Дамп данных таблицы `pc7bw_categories`
--

INSERT INTO `pc7bw_categories` (`id`, `asset_id`, `parent_id`, `lft`, `rgt`, `level`, `path`, `extension`, `title`, `alias`, `note`, `description`, `published`, `checked_out`, `checked_out_time`, `access`, `params`, `metadesc`, `metakey`, `metadata`, `created_user_id`, `created_time`, `modified_user_id`, `modified_time`, `hits`, `language`) VALUES
(1, 0, 0, 0, 23, 0, '', 'system', 'ROOT', 'root', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{}', '', '', '', 0, '2009-10-18 16:07:09', 0, '0000-00-00 00:00:00', 0, '*'),
(2, 27, 1, 1, 2, 1, 'uncategorised', 'com_content', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"target":"","image":""}', '', '', '{"page_title":"","author":"","robots":""}', 42, '2010-06-28 13:26:37', 0, '0000-00-00 00:00:00', 0, '*'),
(3, 28, 1, 3, 4, 1, 'uncategorised', 'com_banners', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"target":"","image":"","foobar":""}', '', '', '{"page_title":"","author":"","robots":""}', 42, '2010-06-28 13:27:35', 0, '0000-00-00 00:00:00', 0, '*'),
(4, 29, 1, 5, 6, 1, 'uncategorised', 'com_contact', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"target":"","image":""}', '', '', '{"page_title":"","author":"","robots":""}', 42, '2010-06-28 13:27:57', 0, '0000-00-00 00:00:00', 0, '*'),
(5, 30, 1, 7, 8, 1, 'uncategorised', 'com_newsfeeds', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"target":"","image":""}', '', '', '{"page_title":"","author":"","robots":""}', 42, '2010-06-28 13:28:15', 0, '0000-00-00 00:00:00', 0, '*'),
(6, 31, 1, 9, 10, 1, 'uncategorised', 'com_weblinks', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"target":"","image":""}', '', '', '{"page_title":"","author":"","robots":""}', 42, '2010-06-28 13:28:33', 0, '0000-00-00 00:00:00', 0, '*'),
(7, 32, 1, 11, 12, 1, 'uncategorised', 'com_users', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"target":"","image":""}', '', '', '{"page_title":"","author":"","robots":""}', 42, '2010-06-28 13:28:33', 0, '0000-00-00 00:00:00', 0, '*'),
(8, 35, 1, 13, 14, 1, '2012-12-25-10-08-50', 'com_content', 'Викладачі кафедри', '2012-12-25-10-08-50', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"category_layout":"","image":""}', '', '', '{"author":"","robots":""}', 974, '2012-12-25 10:08:50', 974, '2013-01-12 12:29:42', 0, '*'),
(9, 36, 1, 15, 16, 1, '2012-12-25-10-09-15', 'com_content', 'Новини', '2012-12-25-10-09-15', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"category_layout":"","image":""}', '', '', '{"author":"","robots":""}', 974, '2012-12-25 10:09:15', 0, '0000-00-00 00:00:00', 0, '*'),
(10, 37, 1, 17, 18, 1, '2012-12-25-10-09-48', 'com_content', 'Оголошення', '2012-12-25-10-09-48', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"category_layout":"","image":""}', '', '', '{"author":"","robots":""}', 974, '2012-12-25 10:09:48', 0, '0000-00-00 00:00:00', 0, '*'),
(11, 38, 1, 19, 20, 1, 'discipliny', 'com_content', 'Дисципліни', 'discipliny', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"category_layout":"","image":""}', '', '', '{"author":"","robots":""}', 974, '2012-12-25 10:10:06', 974, '2013-01-13 14:48:59', 0, '*'),
(12, 50, 1, 21, 22, 1, '11', 'com_content', '11', '11', '', '', -2, 0, '0000-00-00 00:00:00', 1, '{"category_layout":"","image":""}', '', '', '{"author":"","robots":""}', 975, '2013-01-08 20:55:58', 0, '0000-00-00 00:00:00', 0, '*');

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_contact_details`
--

CREATE TABLE IF NOT EXISTS `pc7bw_contact_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `con_position` varchar(255) DEFAULT NULL,
  `address` text,
  `suburb` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `postcode` varchar(100) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `misc` mediumtext,
  `image` varchar(255) DEFAULT NULL,
  `imagepos` varchar(20) DEFAULT NULL,
  `email_to` varchar(255) DEFAULT NULL,
  `default_con` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `params` text NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `catid` int(11) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `mobile` varchar(255) NOT NULL DEFAULT '',
  `webpage` varchar(255) NOT NULL DEFAULT '',
  `sortname1` varchar(255) NOT NULL,
  `sortname2` varchar(255) NOT NULL,
  `sortname3` varchar(255) NOT NULL,
  `language` char(7) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `metadata` text NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Set if article is featured.',
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`published`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_content`
--

CREATE TABLE IF NOT EXISTS `pc7bw_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table.',
  `title` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `title_alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Deprecated in Joomla! 3.0',
  `introtext` mediumtext NOT NULL,
  `fulltext` mediumtext NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `sectionid` int(10) unsigned NOT NULL DEFAULT '0',
  `mask` int(10) unsigned NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `images` text NOT NULL,
  `urls` text NOT NULL,
  `attribs` varchar(5120) NOT NULL,
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  `parentid` int(10) unsigned NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `metadata` text NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Set if article is featured.',
  `language` char(7) NOT NULL COMMENT 'The language code for the article.',
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- Дамп данных таблицы `pc7bw_content`
--

INSERT INTO `pc7bw_content` (`id`, `asset_id`, `title`, `alias`, `title_alias`, `introtext`, `fulltext`, `state`, `sectionid`, `mask`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `parentid`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`, `featured`, `language`, `xreference`) VALUES
(1, 39, 'Новина 1', 'novina11', '', '<p>Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина</p>\r\n', '\r\n<p>1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1Новина 1</p>', 1, 0, 0, 9, '2012-12-25 10:11:21', 974, '', '2013-01-09 14:12:48', 974, 0, '0000-00-00 00:00:00', '2012-12-25 10:11:21', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 11, 0, 4, '', '', 1, 30, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(2, 40, 'Новина 2', '2', '', '<p>Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина</p>\r\n', '\r\n<p>2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2Новина 2</p>', 1, 0, 0, 9, '2012-12-25 10:12:04', 974, '', '2013-01-06 22:36:18', 974, 0, '0000-00-00 00:00:00', '2012-12-25 10:12:04', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 8, 0, 3, '', '', 1, 14, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(3, 41, 'Оголошення 1', '1', '', '<p>Оголошення 1Оголошення 1Оголошен ня 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошенн 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошення 1Оголошенвпвапвапвапвапвпвпвпвп вапвапвап в пвапвпв</p>', '', 1, 0, 0, 10, '2012-12-25 10:13:38', 974, '', '2012-12-29 12:20:45', 974, 0, '0000-00-00 00:00:00', '2012-12-25 10:13:38', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 6, 0, 4, '', '', 1, 73, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(4, 42, 'Оголошення 2', '2', '', '<p><a href="index.php?option=com_content&amp;view=article&amp;id=3&amp;catid=10">Оголошення 1</a>Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголо шення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2</p>', '', -2, 0, 0, 10, '2012-12-28 18:28:20', 974, '', '2012-12-29 12:33:03', 974, 0, '0000-00-00 00:00:00', '2012-12-28 18:28:20', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 3, 0, 3, '', '', 1, 3, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(5, 43, 'Оголошення 3', '2-2', '', '<p>Оголошення3 Оголошення3Оголошенн3 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Ого3333 33333333333333333333 333333 я 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2 Оголошення 2</p>', '', -2, 0, 0, 10, '2012-12-28 18:28:20', 974, '', '2012-12-28 18:31:02', 974, 0, '0000-00-00 00:00:00', '2012-12-28 18:28:20', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 2, 0, 0, '', '', 1, 0, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(6, 44, 'Оголошення 3', '3', '', '<p>{source}<span style="font-family: courier new, courier, monospace;"><br /><span>&lt;</span>iframe width="560" height="315" src="http://www.youtube.com/embed/JbrMYS1pxMI" frameborder="0" allowfullscreen<span>&gt;</span><span>&lt;</span>/iframe<span>&gt;</span><br /></span>{/source}Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3Оголошення 3</p>', '', 1, 0, 0, 10, '2012-12-29 12:15:01', 974, '', '2013-01-08 20:22:28', 974, 0, '0000-00-00 00:00:00', '2012-12-29 12:15:01', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 4, 0, 3, '', '', 1, 2, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(7, 45, 'Оголошення 4', '4', '', '<p>Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4Оголошення 4</p>', '', -2, 0, 0, 10, '2012-12-29 12:15:39', 974, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2012-12-29 12:15:39', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 2, '', '', 1, 8, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(8, 46, 'Оголошення 5', '5', '', '<p>Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5Оголошення 5</p>', '', -2, 0, 0, 10, '2012-12-29 12:19:30', 974, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2012-12-29 12:19:30', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 1, '', '', 1, 8, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(9, 47, 'Дисципліна 1', 'dystsyplina-1', '', '<p>фівфівф   вфвфвфвфваіа іваіва</p>', '', 1, 0, 0, 11, '2013-01-02 21:51:08', 975, '', '2013-01-06 23:39:21', 975, 0, '0000-00-00 00:00:00', '2013-01-02 21:51:08', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":""}', 3, 0, 5, '', '', 4, 0, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(10, 49, 'Новина 3', 'novyna-3', '', '<p>Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3</p>', '', -2, 0, 0, 9, '2013-01-06 21:57:34', 975, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":""}', 1, 0, 0, '', '', 1, 0, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(11, 51, 'Дисципліна 2', 'dystsyplina-2', '', '<p>Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2Дисципліна 2</p>', '', 1, 0, 0, 11, '2013-01-08 20:56:44', 975, '', '2013-01-08 20:59:19', 974, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 2, 0, 4, '', '', 4, 0, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(12, 52, 'Дисципліна 3', 'dystsyplina-3', '', '<p>Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3Дисципліна 3</p>', '', 1, 0, 0, 11, '2013-01-08 23:20:36', 975, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":""}', 1, 0, 3, '', '', 1, 3, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(13, 53, 'Дисципліна 4', 'dystsyplina-4', '', '<p>Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4Дисципліна 4м</p>', '', 1, 0, 0, 11, '2013-01-08 23:32:43', 974, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-01-08 23:32:43', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 2, '', '', 1, 0, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(14, 54, 'Новина 3', 'n3', '', '<p>Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3Новина 3</p>', '', 1, 0, 0, 9, '2013-01-09 14:16:43', 974, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-01-09 14:16:43', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 2, '', '', 1, 6, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(15, 55, 'якась новина', 'iakas-novyna', '', '<p>якась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась</p>\r\n', '\r\n<p>новинаякась новинаякась новинаякась новинаякась новинаякась новинаякась новина</p>', 1, 0, 0, 9, '2013-01-09 14:57:49', 974, '', '2013-01-13 19:53:14', 974, 0, '0000-00-00 00:00:00', '2013-01-09 14:57:49', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 2, 0, 1, '', '', 1, 9, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(16, 56, 'Оголошення 2', 'oholoshennia-2', '', '<p>мммммммОголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2Оголошення 2</p>', '', 1, 0, 0, 10, '2013-01-09 15:15:28', 974, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-01-09 15:15:28', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 0, '', '', 1, 3, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(17, 57, 'Новина викладача', 'novyna-vykladacha', '', '<p>Новина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладачаНовина викладача</p>', '', -2, 0, 0, 9, '2013-01-09 21:37:47', 975, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":""}', 1, 0, 0, '', '', 1, 0, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(18, 58, 'викладач 2', 'vykladach-2', '', '<p>викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач</p>\r\n', '\r\n<p>2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2викладач 2м</p>', 1, 0, 0, 8, '2013-01-12 11:46:31', 977, '', '2013-01-12 14:10:05', 974, 0, '0000-00-00 00:00:00', '2013-01-12 11:46:31', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 2, 0, 2, '', '', 1, 35, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(19, 59, 'Дисципліна викладача 2', 'dystsyplina-vykladacha-2', '', '<p>Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2Дисципліна викладача 2</p>', '', 1, 0, 0, 11, '2013-01-12 11:47:17', 977, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-01-12 11:47:17', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 1, '', '', 1, 5, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(20, 60, 'Викладач 3', 'vykladach-3', '', '<p>Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач</p>\r\n', '\r\n<p>3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3Викладач 3</p>', 1, 0, 0, 8, '2013-01-12 14:10:57', 982, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '2013-01-12 14:10:57', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 1, 0, 1, '', '', 1, 51, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(21, 61, 'Дисципліна викладача 3', 'dystsyplina-vykladacha-222', '', '<p>Дисципліна викладачауДисципліна викладача 3Дисципліна викладача 3Дисципліна викладача Дисципліна викладачауДисципліна викладача 3Дисципліна викладача 3Дисципліна викладача Дисципліна викладачауДисципліна викладача 3Дисципліна викладача 3Дисципліна викладача Дисципліна викладачауДисципліна викладача 3Дисципліна викладача 3Дисципліна викладача Дисципліна викладачауДисципліна викладача 3Дисципліна викладача 3Дисципліна викладача Дисципліна викладачауДисципліна викладача 3Дисципліна викладача 3Дисципліна викладача Дисципліна викладачауДисципліна викладача 3Дисципліна викладача 3Дисципліна викладача Дисципліна викладачауДисципліна викладача 3Дисципліна викладача 3Дисципліна викладача Дисципліна викладачауДисципліна викладача 3Дисципліна викладача 3Дисципліна викладача Дисципліна викладачауДисципліна викладача 3Дисципліна викладача 3Дисципліна викладача Дисципліна</p>\r\n', '\r\n<p>викладачауДисципліна викладача 3Дисципліна викладача 3Дисципліна викладача Дисципліна викладачауДисципліна викладача 3Дисципліна викладача 3Дисципліна викладача Дисципліна викладачауДисципліна викладача 3Дисципліна викладача 3Дисципліна викладача Дисципліна викладачауДисципліна викладача 3Дисципліна викладача 3Дисципліна викладача Дисципліна викладачауДисципліна викладача 3Дисципліна викладача 3Дисципліна викладача Дисципліна викладачауДисципліна викладача 3Дисципліна викладача 3Дисципліна викладача</p>', 1, 0, 0, 11, '2013-01-12 14:20:37', 982, '', '2013-01-13 19:54:09', 974, 0, '0000-00-00 00:00:00', '2013-01-12 14:20:37', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', 3, 0, 0, '', '', 1, 17, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', '');
INSERT INTO `pc7bw_content` (`id`, `asset_id`, `title`, `alias`, `title_alias`, `introtext`, `fulltext`, `state`, `sectionid`, `mask`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `parentid`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`, `featured`, `language`, `xreference`) VALUES
(22, 62, 'Викладач 1', 'vykladach-1', '', '<p>Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач</p>\r\n', '\r\n<p>1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1Викладач 1</p>', 1, 0, 0, 8, '2013-01-13 15:20:44', 975, '', '0000-00-00 00:00:00', 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":null,"urlatext":"","targeta":"","urlb":null,"urlbtext":"","targetb":"","urlc":null,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":""}', 1, 0, 0, '', '', 1, 4, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', '');

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_content_frontpage`
--

CREATE TABLE IF NOT EXISTS `pc7bw_content_frontpage` (
  `content_id` int(11) NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_content_rating`
--

CREATE TABLE IF NOT EXISTS `pc7bw_content_rating` (
  `content_id` int(11) NOT NULL DEFAULT '0',
  `rating_sum` int(10) unsigned NOT NULL DEFAULT '0',
  `rating_count` int(10) unsigned NOT NULL DEFAULT '0',
  `lastip` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_core_log_searches`
--

CREATE TABLE IF NOT EXISTS `pc7bw_core_log_searches` (
  `search_term` varchar(128) NOT NULL DEFAULT '',
  `hits` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_extensions`
--

CREATE TABLE IF NOT EXISTS `pc7bw_extensions` (
  `extension_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` varchar(20) NOT NULL,
  `element` varchar(100) NOT NULL,
  `folder` varchar(100) NOT NULL,
  `client_id` tinyint(3) NOT NULL,
  `enabled` tinyint(3) NOT NULL DEFAULT '1',
  `access` int(10) unsigned NOT NULL DEFAULT '1',
  `protected` tinyint(3) NOT NULL DEFAULT '0',
  `manifest_cache` text NOT NULL,
  `params` text NOT NULL,
  `custom_data` text NOT NULL,
  `system_data` text NOT NULL,
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) DEFAULT '0',
  `state` int(11) DEFAULT '0',
  PRIMARY KEY (`extension_id`),
  KEY `element_clientid` (`element`,`client_id`),
  KEY `element_folder_clientid` (`element`,`folder`,`client_id`),
  KEY `extension` (`type`,`element`,`folder`,`client_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10025 ;

--
-- Дамп данных таблицы `pc7bw_extensions`
--

INSERT INTO `pc7bw_extensions` (`extension_id`, `name`, `type`, `element`, `folder`, `client_id`, `enabled`, `access`, `protected`, `manifest_cache`, `params`, `custom_data`, `system_data`, `checked_out`, `checked_out_time`, `ordering`, `state`) VALUES
(1, 'com_mailto', 'component', 'com_mailto', '', 0, 1, 1, 1, '{"legacy":false,"name":"com_mailto","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_MAILTO_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(2, 'com_wrapper', 'component', 'com_wrapper', '', 0, 1, 1, 1, '{"legacy":false,"name":"com_wrapper","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\n\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_WRAPPER_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(3, 'com_admin', 'component', 'com_admin', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_admin","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\n\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_ADMIN_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(4, 'com_banners', 'component', 'com_banners', '', 1, 1, 1, 0, '{"legacy":false,"name":"com_banners","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\n\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_BANNERS_XML_DESCRIPTION","group":""}', '{"purchase_type":"3","track_impressions":"0","track_clicks":"0","metakey_prefix":""}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(5, 'com_cache', 'component', 'com_cache', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_cache","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_CACHE_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(6, 'com_categories', 'component', 'com_categories', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_categories","type":"component","creationDate":"December 2007","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_CATEGORIES_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(7, 'com_checkin', 'component', 'com_checkin', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_checkin","type":"component","creationDate":"Unknown","author":"Joomla! Project","copyright":"(C) 2005 - 2008 Open Source Matters. All rights reserved.\\n\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_CHECKIN_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(8, 'com_contact', 'component', 'com_contact', '', 1, 1, 1, 0, '{"legacy":false,"name":"com_contact","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\n\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_CONTACT_XML_DESCRIPTION","group":""}', '{"contact_layout":"_:default","show_contact_category":"hide","show_contact_list":"0","presentation_style":"sliders","show_name":"1","show_position":"1","show_email":"0","show_street_address":"1","show_suburb":"1","show_state":"1","show_postcode":"1","show_country":"1","show_telephone":"1","show_mobile":"1","show_fax":"1","show_webpage":"1","show_misc":"1","show_image":"1","image":"","allow_vcard":"0","show_articles":"0","show_profile":"0","show_links":"0","linka_name":"","linkb_name":"","linkc_name":"","linkd_name":"","linke_name":"","contact_icons":"0","icon_address":"","icon_email":"","icon_telephone":"","icon_mobile":"","icon_fax":"","icon_misc":"","category_layout":"_:default","show_category_title":"1","show_description":"1","show_description_image":"0","maxLevel":"-1","show_empty_categories":"0","show_subcat_desc":"1","show_cat_items":"1","show_base_description":"1","maxLevelcat":"-1","show_empty_categories_cat":"0","show_subcat_desc_cat":"1","show_cat_items_cat":"1","show_pagination_limit":"1","show_headings":"1","show_position_headings":"1","show_email_headings":"0","show_telephone_headings":"1","show_mobile_headings":"0","show_fax_headings":"0","show_suburb_headings":"1","show_state_headings":"1","show_country_headings":"1","show_pagination":"2","show_pagination_results":"1","initial_sort":"ordering","captcha":"","show_email_form":"1","show_email_copy":"1","banned_email":"","banned_subject":"","banned_text":"","validate_session":"1","custom_reply":"0","redirect":"","show_feed_link":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(9, 'com_cpanel', 'component', 'com_cpanel', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_cpanel","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_CPANEL_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10, 'com_installer', 'component', 'com_installer', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_installer","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_INSTALLER_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(11, 'com_languages', 'component', 'com_languages', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_languages","type":"component","creationDate":"2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\n\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_LANGUAGES_XML_DESCRIPTION","group":""}', '{"administrator":"uk-UA","site":"uk-UA"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(12, 'com_login', 'component', 'com_login', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_login","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_LOGIN_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(13, 'com_media', 'component', 'com_media', '', 1, 1, 0, 1, '{"legacy":false,"name":"com_media","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_MEDIA_XML_DESCRIPTION","group":""}', '{"upload_extensions":"doc,docx,pdf,xlsx,xls,DOC,DOCX,PDF,XLSX,XLS","upload_maxsize":"20","file_path":"images","image_path":"images","restrict_uploads":"1","check_mime":"1","image_extensions":"bmp,gif,jpg,png","ignore_extensions":"","upload_mime":"image\\/jpeg,image\\/gif,image\\/png,image\\/bmp,application\\/x-shockwave-flash,application\\/msword,application\\/excel,application\\/pdf,application\\/powerpoint,text\\/plain,application\\/x-zip","upload_mime_illegal":"text\\/html","enable_flash":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(14, 'com_menus', 'component', 'com_menus', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_menus","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_MENUS_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(15, 'com_messages', 'component', 'com_messages', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_messages","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_MESSAGES_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(16, 'com_modules', 'component', 'com_modules', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_modules","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_MODULES_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(17, 'com_newsfeeds', 'component', 'com_newsfeeds', '', 1, 1, 1, 0, '{"legacy":false,"name":"com_newsfeeds","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_NEWSFEEDS_XML_DESCRIPTION","group":""}', '{"newsfeed_layout":"_:default","show_feed_image":"1","show_feed_description":"1","show_item_description":"1","feed_character_count":"0","feed_display_order":"des","category_layout":"_:default","show_category_title":"1","show_description":"1","show_description_image":"1","maxLevel":"-1","show_empty_categories":"0","show_subcat_desc":"1","show_cat_items":"1","show_base_description":"1","maxLevelcat":"-1","show_empty_categories_cat":"0","show_subcat_desc_cat":"1","show_cat_items_cat":"1","show_pagination_limit":"1","show_headings":"1","show_articles":"0","show_link":"1","show_pagination":"1","show_pagination_results":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(18, 'com_plugins', 'component', 'com_plugins', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_plugins","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_PLUGINS_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(19, 'com_search', 'component', 'com_search', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_search","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\n\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_SEARCH_XML_DESCRIPTION","group":""}', '{"enabled":"0","search_areas":"1","show_date":"1","opensearch_name":"","opensearch_description":""}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(20, 'com_templates', 'component', 'com_templates', '', 1, 1, 1, 1, '{"legacy":false,"name":"com_templates","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_TEMPLATES_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(21, 'com_weblinks', 'component', 'com_weblinks', '', 1, 1, 1, 0, '{"legacy":false,"name":"com_weblinks","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\n\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_WEBLINKS_XML_DESCRIPTION","group":""}', '{"target":"0","count_clicks":"1","icons":1,"link_icons":"","category_layout":"_:default","show_category_title":"1","show_description":"1","show_description_image":"1","maxLevel":"-1","show_empty_categories":"0","show_subcat_desc":"1","show_cat_num_links":"1","show_base_description":"1","maxLevelcat":"-1","show_empty_categories_cat":"0","show_subcat_desc_cat":"1","show_cat_num_links_cat":"1","show_pagination_limit":"1","show_headings":"0","show_link_description":"1","show_link_hits":"1","show_pagination":"2","show_pagination_results":"1","show_feed_link":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(22, 'com_content', 'component', 'com_content', '', 1, 1, 0, 1, '{"legacy":false,"name":"com_content","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_CONTENT_XML_DESCRIPTION","group":""}', '{"article_layout":"_:default","show_title":"1","link_titles":"1","show_intro":"1","show_category":"0","link_category":"0","show_parent_category":"0","link_parent_category":"0","show_author":"0","link_author":"0","show_create_date":"0","show_modify_date":"0","show_publish_date":"0","show_item_navigation":"0","show_vote":"0","show_readmore":"1","show_readmore_title":"0","readmore_limit":"100","show_icons":"0","show_print_icon":"0","show_email_icon":"0","show_hits":"0","show_noauth":"0","urls_position":"0","show_publishing_options":"1","show_article_options":"1","show_urls_images_frontend":"0","show_urls_images_backend":"1","targeta":0,"targetb":0,"targetc":0,"float_intro":"left","float_fulltext":"left","category_layout":"_:blog","show_category_title":"0","show_description":"0","show_description_image":"0","maxLevel":"1","show_empty_categories":"0","show_no_articles":"1","show_subcat_desc":"1","show_cat_num_articles":"0","show_base_description":"1","maxLevelcat":"-1","show_empty_categories_cat":"0","show_subcat_desc_cat":"1","show_cat_num_articles_cat":"1","num_leading_articles":"1","num_intro_articles":"4","num_columns":"2","num_links":"4","multi_column_order":"0","show_subcategory_content":"0","show_pagination_limit":"1","filter_field":"hide","show_headings":"1","list_show_date":"0","date_format":"","list_show_hits":"1","list_show_author":"1","orderby_pri":"order","orderby_sec":"rdate","order_date":"published","show_pagination":"2","show_pagination_results":"1","show_feed_link":"1","feed_summary":"0","feed_show_readmore":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(23, 'com_config', 'component', 'com_config', '', 1, 1, 0, 1, '{"legacy":false,"name":"com_config","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_CONFIG_XML_DESCRIPTION","group":""}', '{"filters":{"1":{"filter_type":"NH","filter_tags":"","filter_attributes":""},"6":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"7":{"filter_type":"NONE","filter_tags":"","filter_attributes":""},"9":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"2":{"filter_type":"NH","filter_tags":"","filter_attributes":""},"3":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"4":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"5":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"8":{"filter_type":"NONE","filter_tags":"","filter_attributes":""}}}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(24, 'com_redirect', 'component', 'com_redirect', '', 1, 1, 0, 1, '{"legacy":false,"name":"com_redirect","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_REDIRECT_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(25, 'com_users', 'component', 'com_users', '', 1, 1, 0, 1, '{"legacy":false,"name":"com_users","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_USERS_XML_DESCRIPTION","group":""}', '{"allowUserRegistration":"1","new_usertype":"2","useractivation":"1","frontend_userparams":"1","mailSubjectPrefix":"","mailBodySuffix":""}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(27, 'com_finder', 'component', 'com_finder', '', 1, 1, 0, 0, '{"legacy":false,"name":"com_finder","type":"component","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_FINDER_XML_DESCRIPTION","group":""}', '{"show_description":"1","description_length":255,"allow_empty_query":"0","show_url":"1","show_autosuggest":"1","show_advanced":"1","show_advanced_tips":"1","expand_advanced":"0","show_date_filters":"0","sort_order":"relevance","sort_direction":"desc","highlight_terms":"1","opensearch_name":"","opensearch_description":"","batch_size":"50","memory_table_limit":30000,"title_multiplier":"1.7","text_multiplier":"0.7","meta_multiplier":"1.2","path_multiplier":"2.0","misc_multiplier":"0.3","stem":"1","stemmer":"snowball","enable_logging":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(28, 'com_joomlaupdate', 'component', 'com_joomlaupdate', '', 1, 1, 0, 1, '{"legacy":false,"name":"com_joomlaupdate","type":"component","creationDate":"February 2012","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"COM_JOOMLAUPDATE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(100, 'PHPMailer', 'library', 'phpmailer', '', 0, 1, 1, 1, '{"legacy":false,"name":"PHPMailer","type":"library","creationDate":"2001","author":"PHPMailer","copyright":"(c) 2001-2003, Brent R. Matzelle, (c) 2004-2009, Andy Prevost. All Rights Reserved., (c) 2010-2011, Jim Jagielski. All Rights Reserved.","authorEmail":"jimjag@gmail.com","authorUrl":"https:\\/\\/code.google.com\\/a\\/apache-extras.org\\/p\\/phpmailer\\/","version":"5.2","description":"LIB_PHPMAILER_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(101, 'SimplePie', 'library', 'simplepie', '', 0, 1, 1, 1, '{"legacy":false,"name":"SimplePie","type":"library","creationDate":"2004","author":"SimplePie","copyright":"Copyright (c) 2004-2009, Ryan Parman and Geoffrey Sneddon","authorEmail":"","authorUrl":"http:\\/\\/simplepie.org\\/","version":"1.2","description":"LIB_SIMPLEPIE_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(102, 'phputf8', 'library', 'phputf8', '', 0, 1, 1, 1, '{"legacy":false,"name":"phputf8","type":"library","creationDate":"2006","author":"Harry Fuecks","copyright":"Copyright various authors","authorEmail":"hfuecks@gmail.com","authorUrl":"http:\\/\\/sourceforge.net\\/projects\\/phputf8","version":"0.5","description":"LIB_PHPUTF8_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(103, 'Joomla! Platform', 'library', 'joomla', '', 0, 1, 1, 1, '{"legacy":false,"name":"Joomla! Platform","type":"library","creationDate":"2008","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"http:\\/\\/www.joomla.org","version":"11.4","description":"LIB_JOOMLA_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(200, 'mod_articles_archive', 'module', 'mod_articles_archive', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_articles_archive","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters.\\n\\t\\tAll rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_ARTICLES_ARCHIVE_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(201, 'mod_articles_latest', 'module', 'mod_articles_latest', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_articles_latest","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_LATEST_NEWS_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(202, 'mod_articles_popular', 'module', 'mod_articles_popular', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_articles_popular","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_POPULAR_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(203, 'mod_banners', 'module', 'mod_banners', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_banners","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_BANNERS_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(204, 'mod_breadcrumbs', 'module', 'mod_breadcrumbs', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_breadcrumbs","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_BREADCRUMBS_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(205, 'mod_custom', 'module', 'mod_custom', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_custom","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_CUSTOM_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(206, 'mod_feed', 'module', 'mod_feed', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_feed","type":"module","creationDate":"July 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_FEED_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(207, 'mod_footer', 'module', 'mod_footer', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_footer","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_FOOTER_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(208, 'mod_login', 'module', 'mod_login', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_login","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_LOGIN_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(209, 'mod_menu', 'module', 'mod_menu', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_menu","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_MENU_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(210, 'mod_articles_news', 'module', 'mod_articles_news', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_articles_news","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_ARTICLES_NEWS_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(211, 'mod_random_image', 'module', 'mod_random_image', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_random_image","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_RANDOM_IMAGE_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(212, 'mod_related_items', 'module', 'mod_related_items', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_related_items","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_RELATED_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(213, 'mod_search', 'module', 'mod_search', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_search","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_SEARCH_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(214, 'mod_stats', 'module', 'mod_stats', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_stats","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_STATS_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(215, 'mod_syndicate', 'module', 'mod_syndicate', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_syndicate","type":"module","creationDate":"May 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_SYNDICATE_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(216, 'mod_users_latest', 'module', 'mod_users_latest', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_users_latest","type":"module","creationDate":"December 2009","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_USERS_LATEST_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(217, 'mod_weblinks', 'module', 'mod_weblinks', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_weblinks","type":"module","creationDate":"July 2009","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_WEBLINKS_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(218, 'mod_whosonline', 'module', 'mod_whosonline', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_whosonline","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_WHOSONLINE_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(219, 'mod_wrapper', 'module', 'mod_wrapper', '', 0, 1, 1, 0, '{"legacy":false,"name":"mod_wrapper","type":"module","creationDate":"October 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_WRAPPER_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(220, 'mod_articles_category', 'module', 'mod_articles_category', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_articles_category","type":"module","creationDate":"February 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_ARTICLES_CATEGORY_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(221, 'mod_articles_categories', 'module', 'mod_articles_categories', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_articles_categories","type":"module","creationDate":"February 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_ARTICLES_CATEGORIES_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(222, 'mod_languages', 'module', 'mod_languages', '', 0, 1, 1, 1, '{"legacy":false,"name":"mod_languages","type":"module","creationDate":"February 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_LANGUAGES_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(223, 'mod_finder', 'module', 'mod_finder', '', 0, 1, 0, 0, '{"legacy":false,"name":"mod_finder","type":"module","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_FINDER_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(300, 'mod_custom', 'module', 'mod_custom', '', 1, 1, 1, 1, '{"legacy":false,"name":"mod_custom","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_CUSTOM_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(301, 'mod_feed', 'module', 'mod_feed', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_feed","type":"module","creationDate":"July 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_FEED_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(302, 'mod_latest', 'module', 'mod_latest', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_latest","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_LATEST_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(303, 'mod_logged', 'module', 'mod_logged', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_logged","type":"module","creationDate":"January 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_LOGGED_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(304, 'mod_login', 'module', 'mod_login', '', 1, 1, 1, 1, '{"legacy":false,"name":"mod_login","type":"module","creationDate":"March 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_LOGIN_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(305, 'mod_menu', 'module', 'mod_menu', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_menu","type":"module","creationDate":"March 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_MENU_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(307, 'mod_popular', 'module', 'mod_popular', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_popular","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_POPULAR_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(308, 'mod_quickicon', 'module', 'mod_quickicon', '', 1, 1, 1, 1, '{"legacy":false,"name":"mod_quickicon","type":"module","creationDate":"Nov 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_QUICKICON_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(309, 'mod_status', 'module', 'mod_status', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_status","type":"module","creationDate":"Feb 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_STATUS_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(310, 'mod_submenu', 'module', 'mod_submenu', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_submenu","type":"module","creationDate":"Feb 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_SUBMENU_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(311, 'mod_title', 'module', 'mod_title', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_title","type":"module","creationDate":"Nov 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_TITLE_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(312, 'mod_toolbar', 'module', 'mod_toolbar', '', 1, 1, 1, 1, '{"legacy":false,"name":"mod_toolbar","type":"module","creationDate":"Nov 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_TOOLBAR_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(313, 'mod_multilangstatus', 'module', 'mod_multilangstatus', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_multilangstatus","type":"module","creationDate":"September 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_MULTILANGSTATUS_XML_DESCRIPTION","group":""}', '{"cache":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(314, 'mod_version', 'module', 'mod_version', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_version","type":"module","creationDate":"January 2012","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_VERSION_XML_DESCRIPTION","group":""}', '{"format":"short","product":"1","cache":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(400, 'plg_authentication_gmail', 'plugin', 'gmail', 'authentication', 0, 0, 1, 0, '{"legacy":false,"name":"plg_authentication_gmail","type":"plugin","creationDate":"February 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_GMAIL_XML_DESCRIPTION","group":""}', '{"applysuffix":"0","suffix":"","verifypeer":"1","user_blacklist":""}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(401, 'plg_authentication_joomla', 'plugin', 'joomla', 'authentication', 0, 1, 1, 1, '{"legacy":false,"name":"plg_authentication_joomla","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_AUTH_JOOMLA_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(402, 'plg_authentication_ldap', 'plugin', 'ldap', 'authentication', 0, 0, 1, 0, '{"legacy":false,"name":"plg_authentication_ldap","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_LDAP_XML_DESCRIPTION","group":""}', '{"host":"","port":"389","use_ldapV3":"0","negotiate_tls":"0","no_referrals":"0","auth_method":"bind","base_dn":"","search_string":"","users_dn":"","username":"admin","password":"bobby7","ldap_fullname":"fullName","ldap_email":"mail","ldap_uid":"uid"}', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(404, 'plg_content_emailcloak', 'plugin', 'emailcloak', 'content', 0, 1, 1, 0, '{"legacy":false,"name":"plg_content_emailcloak","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_CONTENT_EMAILCLOAK_XML_DESCRIPTION","group":""}', '{"mode":"1"}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(405, 'plg_content_geshi', 'plugin', 'geshi', 'content', 0, 0, 1, 0, '{"legacy":false,"name":"plg_content_geshi","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"","authorUrl":"qbnz.com\\/highlighter","version":"2.5.0","description":"PLG_CONTENT_GESHI_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(406, 'plg_content_loadmodule', 'plugin', 'loadmodule', 'content', 0, 1, 1, 0, '{"legacy":false,"name":"plg_content_loadmodule","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_LOADMODULE_XML_DESCRIPTION","group":""}', '{"style":"xhtml"}', '', '', 0, '2011-09-18 15:22:50', 0, 0),
(407, 'plg_content_pagebreak', 'plugin', 'pagebreak', 'content', 0, 1, 1, 1, '{"legacy":false,"name":"plg_content_pagebreak","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_CONTENT_PAGEBREAK_XML_DESCRIPTION","group":""}', '{"title":"1","multipage_toc":"1","showall":"1"}', '', '', 0, '0000-00-00 00:00:00', 4, 0),
(408, 'plg_content_pagenavigation', 'plugin', 'pagenavigation', 'content', 0, 1, 1, 1, '{"legacy":false,"name":"plg_content_pagenavigation","type":"plugin","creationDate":"January 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_PAGENAVIGATION_XML_DESCRIPTION","group":""}', '{"position":"1"}', '', '', 0, '0000-00-00 00:00:00', 5, 0),
(409, 'plg_content_vote', 'plugin', 'vote', 'content', 0, 1, 1, 1, '{"legacy":false,"name":"plg_content_vote","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_VOTE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 6, 0),
(410, 'plg_editors_codemirror', 'plugin', 'codemirror', 'editors', 0, 1, 1, 1, '{"legacy":false,"name":"plg_editors_codemirror","type":"plugin","creationDate":"28 March 2011","author":"Marijn Haverbeke","copyright":"","authorEmail":"N\\/A","authorUrl":"","version":"1.0","description":"PLG_CODEMIRROR_XML_DESCRIPTION","group":""}', '{"linenumbers":"0","tabmode":"indent"}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(411, 'plg_editors_none', 'plugin', 'none', 'editors', 0, 1, 1, 1, '{"legacy":false,"name":"plg_editors_none","type":"plugin","creationDate":"August 2004","author":"Unknown","copyright":"","authorEmail":"N\\/A","authorUrl":"","version":"2.5.0","description":"PLG_NONE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(412, 'plg_editors_tinymce', 'plugin', 'tinymce', 'editors', 0, 1, 1, 1, '{"legacy":false,"name":"plg_editors_tinymce","type":"plugin","creationDate":"2005-2012","author":"Moxiecode Systems AB","copyright":"Moxiecode Systems AB","authorEmail":"N\\/A","authorUrl":"tinymce.moxiecode.com\\/","version":"3.5.4.1","description":"PLG_TINY_XML_DESCRIPTION","group":""}', '{"mode":"1","skin":"0","entity_encoding":"raw","lang_mode":"0","lang_code":"en","text_direction":"ltr","content_css":"1","content_css_custom":"","relative_urls":"1","newlines":"0","invalid_elements":"script,applet,iframe","extended_elements":"","toolbar":"top","toolbar_align":"left","html_height":"550","html_width":"750","resizing":"true","resize_horizontal":"false","element_path":"1","fonts":"1","paste":"1","searchreplace":"1","insertdate":"1","format_date":"%Y-%m-%d","inserttime":"1","format_time":"%H:%M:%S","colors":"1","table":"1","smilies":"1","media":"1","hr":"1","directionality":"1","fullscreen":"1","style":"1","layer":"1","xhtmlxtras":"1","visualchars":"1","nonbreaking":"1","template":"1","blockquote":"1","wordcount":"1","advimage":"1","advlink":"1","advlist":"1","autosave":"1","contextmenu":"1","inlinepopups":"1","custom_plugin":"","custom_button":""}', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(413, 'plg_editors-xtd_article', 'plugin', 'article', 'editors-xtd', 0, 1, 1, 1, '{"legacy":false,"name":"plg_editors-xtd_article","type":"plugin","creationDate":"October 2009","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_ARTICLE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(414, 'plg_editors-xtd_image', 'plugin', 'image', 'editors-xtd', 0, 1, 1, 0, '{"legacy":false,"name":"plg_editors-xtd_image","type":"plugin","creationDate":"August 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_IMAGE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(415, 'plg_editors-xtd_pagebreak', 'plugin', 'pagebreak', 'editors-xtd', 0, 1, 1, 0, '{"legacy":false,"name":"plg_editors-xtd_pagebreak","type":"plugin","creationDate":"August 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_EDITORSXTD_PAGEBREAK_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(416, 'plg_editors-xtd_readmore', 'plugin', 'readmore', 'editors-xtd', 0, 1, 1, 0, '{"legacy":false,"name":"plg_editors-xtd_readmore","type":"plugin","creationDate":"March 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_READMORE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 4, 0),
(417, 'plg_search_categories', 'plugin', 'categories', 'search', 0, 1, 1, 0, '{"legacy":false,"name":"plg_search_categories","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SEARCH_CATEGORIES_XML_DESCRIPTION","group":""}', '{"search_limit":"50","search_content":"1","search_archived":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(418, 'plg_search_contacts', 'plugin', 'contacts', 'search', 0, 1, 1, 0, '{"legacy":false,"name":"plg_search_contacts","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SEARCH_CONTACTS_XML_DESCRIPTION","group":""}', '{"search_limit":"50","search_content":"1","search_archived":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(419, 'plg_search_content', 'plugin', 'content', 'search', 0, 1, 1, 0, '{"legacy":false,"name":"plg_search_content","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SEARCH_CONTENT_XML_DESCRIPTION","group":""}', '{"search_limit":"50","search_content":"1","search_archived":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(420, 'plg_search_newsfeeds', 'plugin', 'newsfeeds', 'search', 0, 1, 1, 0, '{"legacy":false,"name":"plg_search_newsfeeds","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SEARCH_NEWSFEEDS_XML_DESCRIPTION","group":""}', '{"search_limit":"50","search_content":"1","search_archived":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(421, 'plg_search_weblinks', 'plugin', 'weblinks', 'search', 0, 1, 1, 0, '{"legacy":false,"name":"plg_search_weblinks","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SEARCH_WEBLINKS_XML_DESCRIPTION","group":""}', '{"search_limit":"50","search_content":"1","search_archived":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(422, 'plg_system_languagefilter', 'plugin', 'languagefilter', 'system', 0, 0, 1, 1, '{"legacy":false,"name":"plg_system_languagefilter","type":"plugin","creationDate":"July 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SYSTEM_LANGUAGEFILTER_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(423, 'plg_system_p3p', 'plugin', 'p3p', 'system', 0, 1, 1, 1, '{"legacy":false,"name":"plg_system_p3p","type":"plugin","creationDate":"September 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_P3P_XML_DESCRIPTION","group":""}', '{"headers":"NOI ADM DEV PSAi COM NAV OUR OTRo STP IND DEM"}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(424, 'plg_system_cache', 'plugin', 'cache', 'system', 0, 0, 1, 1, '{"legacy":false,"name":"plg_system_cache","type":"plugin","creationDate":"February 2007","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_CACHE_XML_DESCRIPTION","group":""}', '{"browsercache":"0","cachetime":"15"}', '', '', 0, '0000-00-00 00:00:00', 9, 0);
INSERT INTO `pc7bw_extensions` (`extension_id`, `name`, `type`, `element`, `folder`, `client_id`, `enabled`, `access`, `protected`, `manifest_cache`, `params`, `custom_data`, `system_data`, `checked_out`, `checked_out_time`, `ordering`, `state`) VALUES
(425, 'plg_system_debug', 'plugin', 'debug', 'system', 0, 1, 1, 0, '{"legacy":false,"name":"plg_system_debug","type":"plugin","creationDate":"December 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_DEBUG_XML_DESCRIPTION","group":""}', '{"profile":"1","queries":"1","memory":"1","language_files":"1","language_strings":"1","strip-first":"1","strip-prefix":"","strip-suffix":""}', '', '', 0, '0000-00-00 00:00:00', 4, 0),
(426, 'plg_system_log', 'plugin', 'log', 'system', 0, 1, 1, 1, '{"legacy":false,"name":"plg_system_log","type":"plugin","creationDate":"April 2007","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_LOG_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 5, 0),
(427, 'plg_system_redirect', 'plugin', 'redirect', 'system', 0, 1, 1, 1, '{"legacy":false,"name":"plg_system_redirect","type":"plugin","creationDate":"April 2009","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_REDIRECT_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 6, 0),
(428, 'plg_system_remember', 'plugin', 'remember', 'system', 0, 1, 1, 1, '{"legacy":false,"name":"plg_system_remember","type":"plugin","creationDate":"April 2007","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_REMEMBER_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 7, 0),
(429, 'plg_system_sef', 'plugin', 'sef', 'system', 0, 1, 1, 0, '{"legacy":false,"name":"plg_system_sef","type":"plugin","creationDate":"December 2007","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SEF_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 8, 0),
(430, 'plg_system_logout', 'plugin', 'logout', 'system', 0, 1, 1, 1, '{"legacy":false,"name":"plg_system_logout","type":"plugin","creationDate":"April 2009","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SYSTEM_LOGOUT_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(431, 'plg_user_contactcreator', 'plugin', 'contactcreator', 'user', 0, 0, 1, 1, '{"legacy":false,"name":"plg_user_contactcreator","type":"plugin","creationDate":"August 2009","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_CONTACTCREATOR_XML_DESCRIPTION","group":""}', '{"autowebpage":"","category":"34","autopublish":"0"}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(432, 'plg_user_joomla', 'plugin', 'joomla', 'user', 0, 1, 1, 0, '{"legacy":false,"name":"plg_user_joomla","type":"plugin","creationDate":"December 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2009 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_USER_JOOMLA_XML_DESCRIPTION","group":""}', '{"autoregister":"1"}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(433, 'plg_user_profile', 'plugin', 'profile', 'user', 0, 0, 1, 1, '{"legacy":false,"name":"plg_user_profile","type":"plugin","creationDate":"January 2008","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_USER_PROFILE_XML_DESCRIPTION","group":""}', '{"register-require_address1":"1","register-require_address2":"1","register-require_city":"1","register-require_region":"1","register-require_country":"1","register-require_postal_code":"1","register-require_phone":"1","register-require_website":"1","register-require_favoritebook":"1","register-require_aboutme":"1","register-require_tos":"1","register-require_dob":"1","profile-require_address1":"1","profile-require_address2":"1","profile-require_city":"1","profile-require_region":"1","profile-require_country":"1","profile-require_postal_code":"1","profile-require_phone":"1","profile-require_website":"1","profile-require_favoritebook":"1","profile-require_aboutme":"1","profile-require_tos":"1","profile-require_dob":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(434, 'plg_extension_joomla', 'plugin', 'joomla', 'extension', 0, 1, 1, 1, '{"legacy":false,"name":"plg_extension_joomla","type":"plugin","creationDate":"May 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_EXTENSION_JOOMLA_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(435, 'plg_content_joomla', 'plugin', 'joomla', 'content', 0, 1, 1, 0, '{"legacy":false,"name":"plg_content_joomla","type":"plugin","creationDate":"November 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_CONTENT_JOOMLA_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(436, 'plg_system_languagecode', 'plugin', 'languagecode', 'system', 0, 0, 1, 0, '{"legacy":false,"name":"plg_system_languagecode","type":"plugin","creationDate":"November 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SYSTEM_LANGUAGECODE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 10, 0),
(437, 'plg_quickicon_joomlaupdate', 'plugin', 'joomlaupdate', 'quickicon', 0, 1, 1, 1, '{"legacy":false,"name":"plg_quickicon_joomlaupdate","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_QUICKICON_JOOMLAUPDATE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(438, 'plg_quickicon_extensionupdate', 'plugin', 'extensionupdate', 'quickicon', 0, 1, 1, 1, '{"legacy":false,"name":"plg_quickicon_extensionupdate","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_QUICKICON_EXTENSIONUPDATE_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(439, 'plg_captcha_recaptcha', 'plugin', 'recaptcha', 'captcha', 0, 1, 1, 0, '{"legacy":false,"name":"plg_captcha_recaptcha","type":"plugin","creationDate":"December 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_CAPTCHA_RECAPTCHA_XML_DESCRIPTION","group":""}', '{"public_key":"","private_key":"","theme":"clean"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(440, 'plg_system_highlight', 'plugin', 'highlight', 'system', 0, 1, 1, 0, '{"legacy":false,"name":"plg_system_highlight","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_SYSTEM_HIGHLIGHT_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 7, 0),
(441, 'plg_content_finder', 'plugin', 'finder', 'content', 0, 0, 1, 0, '{"legacy":false,"name":"plg_content_finder","type":"plugin","creationDate":"December 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_CONTENT_FINDER_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(442, 'plg_finder_categories', 'plugin', 'categories', 'finder', 0, 1, 1, 0, '{"legacy":false,"name":"plg_finder_categories","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_FINDER_CATEGORIES_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(443, 'plg_finder_contacts', 'plugin', 'contacts', 'finder', 0, 1, 1, 0, '{"legacy":false,"name":"plg_finder_contacts","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_FINDER_CONTACTS_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(444, 'plg_finder_content', 'plugin', 'content', 'finder', 0, 1, 1, 0, '{"legacy":false,"name":"plg_finder_content","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_FINDER_CONTENT_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(445, 'plg_finder_newsfeeds', 'plugin', 'newsfeeds', 'finder', 0, 1, 1, 0, '{"legacy":false,"name":"plg_finder_newsfeeds","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_FINDER_NEWSFEEDS_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 4, 0),
(446, 'plg_finder_weblinks', 'plugin', 'weblinks', 'finder', 0, 1, 1, 0, '{"legacy":false,"name":"plg_finder_weblinks","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"PLG_FINDER_WEBLINKS_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 5, 0),
(500, 'atomic', 'template', 'atomic', '', 0, 1, 1, 0, '{"legacy":false,"name":"atomic","type":"template","creationDate":"10\\/10\\/09","author":"Ron Severdia","copyright":"Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.","authorEmail":"contact@kontentdesign.com","authorUrl":"http:\\/\\/www.kontentdesign.com","version":"2.5.0","description":"TPL_ATOMIC_XML_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(502, 'bluestork', 'template', 'bluestork', '', 1, 1, 1, 0, '{"legacy":false,"name":"bluestork","type":"template","creationDate":"07\\/02\\/09","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"TPL_BLUESTORK_XML_DESCRIPTION","group":""}', '{"useRoundedCorners":"1","showSiteName":"0","textBig":"0","highContrast":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(503, 'beez_20', 'template', 'beez_20', '', 0, 1, 1, 0, '{"legacy":false,"name":"beez_20","type":"template","creationDate":"25 November 2009","author":"Angie Radtke","copyright":"Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.","authorEmail":"a.radtke@derauftritt.de","authorUrl":"http:\\/\\/www.der-auftritt.de","version":"2.5.0","description":"TPL_BEEZ2_XML_DESCRIPTION","group":""}', '{"wrapperSmall":"53","wrapperLarge":"72","sitetitle":"","sitedescription":"","navposition":"center","templatecolor":"nature"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(504, 'hathor', 'template', 'hathor', '', 1, 1, 1, 0, '{"legacy":false,"name":"hathor","type":"template","creationDate":"May 2010","author":"Andrea Tarr","copyright":"Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.","authorEmail":"hathor@tarrconsulting.com","authorUrl":"http:\\/\\/www.tarrconsulting.com","version":"2.5.0","description":"TPL_HATHOR_XML_DESCRIPTION","group":""}', '{"showSiteName":"0","colourChoice":"0","boldText":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(505, 'beez5', 'template', 'beez5', '', 0, 1, 1, 0, '{"legacy":false,"name":"beez5","type":"template","creationDate":"21 May 2010","author":"Angie Radtke","copyright":"Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.","authorEmail":"a.radtke@derauftritt.de","authorUrl":"http:\\/\\/www.der-auftritt.de","version":"2.5.0","description":"TPL_BEEZ5_XML_DESCRIPTION","group":""}', '{"wrapperSmall":"53","wrapperLarge":"72","sitetitle":"","sitedescription":"","navposition":"center","html5":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(600, 'English (United Kingdom)', 'language', 'en-GB', '', 0, 1, 1, 1, '{"legacy":false,"name":"English (United Kingdom)","type":"language","creationDate":"2008-03-15","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.5","description":"en-GB site language","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(601, 'English (United Kingdom)', 'language', 'en-GB', '', 1, 1, 1, 1, '{"legacy":false,"name":"English (United Kingdom)","type":"language","creationDate":"2008-03-15","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.5","description":"en-GB administrator language","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(700, 'files_joomla', 'file', 'joomla', '', 0, 1, 1, 1, '{"legacy":false,"name":"files_joomla","type":"file","creationDate":"November 2012","author":"Joomla! Project","copyright":"(C) 2005 - 2012 Open Source Matters. All rights reserved","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.8","description":"FILES_JOOMLA_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(800, 'PKG_JOOMLA', 'package', 'pkg_joomla', '', 0, 1, 1, 1, '{"legacy":false,"name":"PKG_JOOMLA","type":"package","creationDate":"2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"http:\\/\\/www.joomla.org","version":"2.5.0","description":"PKG_JOOMLA_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10000, 'pmchair', 'template', 'pmchair', '', 0, 1, 1, 0, '{"legacy":false,"name":"pmchair","type":"template","creationDate":"21 May 2010","author":"Angie Radtke","copyright":"Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.","authorEmail":"a.radtke@derauftritt.de","authorUrl":"http:\\/\\/www.der-auftritt.de","version":"2.5.0","description":"TPL_BEEZ5_XML_DESCRIPTION","group":""}', '{"wrapperSmall":"53","wrapperLarge":"72","sitetitle":"","sitedescription":"","navposition":"center","html5":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10001, 'mod_announcement', 'module', 'mod_announcement', '', 0, 1, 0, 0, '{"legacy":false,"name":"mod_announcement","type":"module","creationDate":"2012","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"","version":"1.0","description":"MOD_FOOTER_XML_DESCRIPTION","group":""}', '[]', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10002, 'PLG_SYSTEM_SOURCERER', 'plugin', 'sourcerer', 'system', 0, 1, 1, 0, '{"legacy":false,"name":"PLG_SYSTEM_SOURCERER","type":"plugin","creationDate":"November 2012","author":"NoNumber (Peter van Westen)","copyright":"Copyright \\u00a9 2012 NoNumber All Rights Reserved","authorEmail":"peter@nonumber.nl","authorUrl":"http:\\/\\/www.nonumber.nl","version":"4.0.1FREE","description":"PLG_SYSTEM_SOURCERER_DESC","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10003, 'Button - Sourcerer', 'plugin', 'sourcerer', 'editors-xtd', 0, 1, 1, 0, '{"legacy":false,"name":"Button - Sourcerer","type":"plugin","creationDate":"November 2012","author":"NoNumber (Peter van Westen)","copyright":"Copyright \\u00a9 2012 NoNumber All Rights Reserved","authorEmail":"peter@nonumber.nl","authorUrl":"http:\\/\\/www.nonumber.nl","version":"4.0.1FREE","description":"PLG_EDITORS-XTD_SOURCERER_DESC","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10004, 'PLG_SYSTEM_NNFRAMEWORK', 'plugin', 'nnframework', 'system', 0, 1, 1, 0, '{"legacy":false,"name":"PLG_SYSTEM_NNFRAMEWORK","type":"plugin","creationDate":"November 2012","author":"NoNumber (Peter van Westen)","copyright":"Copyright \\u00a9 2012 NoNumber All Rights Reserved","authorEmail":"peter@nonumber.nl","authorUrl":"http:\\/\\/www.nonumber.nl","version":"12.11.6","description":"PLG_SYSTEM_NNFRAMEWORK_DESC","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10005, '', 'language', 'uk-UA', '', 0, 1, 0, 0, '{"legacy":false,"name":"\\u0423\\u043a\\u0440\\u0430\\u0457\\u043d\\u0441\\u044c\\u043a\\u0430 (\\u0423\\u043a\\u0440\\u0430\\u0457\\u043d\\u0430)","type":"language","creationDate":"11.10.2012","author":"Joomla! Ukraine","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved. Copyright (C) 2006 - 2012 Joomla! Ukraine. All rights reserved.","authorEmail":"denys@joomla-ua.org","authorUrl":"joomla-ua.org","version":"2.5.7.3","description":"\\u0423\\u043a\\u0440\\u0430\\u0457\\u043d\\u0441\\u044c\\u043a\\u0438\\u0439 \\u043f\\u0435\\u0440\\u0435\\u043a\\u043b\\u0430\\u0434 \\u0444\\u0440\\u043e\\u043d\\u0442\\u0430\\u043b\\u044c\\u043d\\u043e\\u0457 \\u0447\\u0430\\u0441\\u0442\\u0438\\u043d\\u0438 Joomla 2.5.","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10006, '', 'language', 'uk-UA', '', 1, 1, 0, 0, '{"legacy":false,"name":"\\u0423\\u043a\\u0440\\u0430\\u0457\\u043d\\u0441\\u044c\\u043a\\u0430 (\\u0423\\u043a\\u0440\\u0430\\u0457\\u043d\\u0430)","type":"language","creationDate":"11.10.2012","author":"Joomla! Ukraine","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved. Copyright (C) 2006 - 2012 Joomla! Ukraine. All rights reserved.","authorEmail":"denys@joomla-ua.org","authorUrl":"www.joomla-ua.org","version":"2.5.7.3","description":"\\u0423\\u043a\\u0440\\u0430\\u0457\\u043d\\u0441\\u044c\\u043a\\u0438\\u0439 \\u043f\\u0435\\u0440\\u0435\\u043a\\u043b\\u0430\\u0434 \\u0444\\u0440\\u043e\\u043d\\u0442\\u0430\\u043b\\u044c\\u043d\\u043e\\u0457 \\u0447\\u0430\\u0441\\u0442\\u0438\\u043d\\u0438 Joomla 2.5.","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10007, 'TinyMCE uk-UA', 'file', 'tinymce_uk-ua', '', 0, 1, 0, 0, '{"legacy":false,"name":"TinyMCE uk-UA","type":"file","creationDate":"23.07.2012","author":"Joomla! Ukraine","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved","authorEmail":"denys@joomla-ua.org","authorUrl":"www.joomla-ua.org","version":"3.5.5","description":"Ukrainian Language Package for TinyMCE 3.4.9 in Joomla 2.5","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10008, 'Joomla! Україна Admin Menu', 'module', 'mod_jumenu', '', 1, 1, 2, 0, '{"legacy":false,"name":"Joomla! \\u0423\\u043a\\u0440\\u0430\\u0457\\u043d\\u0430 Admin Menu","type":"module","creationDate":"23.09.2012","author":"Joomla! \\u0423\\u043a\\u0440\\u0430\\u0457\\u043d\\u0430","copyright":"Copyright (C) 2006-2012 Joomla! \\u0423\\u043a\\u0440\\u0430\\u0457\\u043d\\u0430","authorEmail":"denys@joomla.org\\"","authorUrl":"http:\\/\\/www.joomla.org\\/","version":"1.20.0","description":"","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10009, 'Новини Joomla! Україна', 'module', 'mod_junews', '', 1, 1, 2, 0, '{"legacy":false,"name":"\\u041d\\u043e\\u0432\\u0438\\u043d\\u0438 Joomla! \\u0423\\u043a\\u0440\\u0430\\u0457\\u043d\\u0430","type":"module","creationDate":"23.09.2012","author":"Joomla! \\u0423\\u043a\\u0440\\u0430\\u0457\\u043d\\u0430","copyright":"Copyright (C) 2006-2012 Joomla! \\u0423\\u043a\\u0440\\u0430\\u0457\\u043d\\u0430","authorEmail":"denys@joomla.org\\"","authorUrl":"http:\\/\\/www.joomla.org\\/","version":"1.20.0","description":"","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10010, 'uk-UA', 'package', 'pkg_uk-UA', '', 0, 1, 1, 0, '{"legacy":false,"name":"Ukrainian Language Pack","type":"package","creationDate":"Unknown","author":"Unknown","copyright":"","authorEmail":"","authorUrl":"","version":"2.5.7.3","description":"<div style=\\"background: #fff; border: 1px #ccc solid; padding: 15px; overflow: hidden;\\"><iframe style=\\"float: right; width: 70%; height: 560px; overflow-y: auto;\\" id=\\"julatest\\" src=\\"http:\\/\\/joomla-ua.org\\/latest\\" frameborder=\\"0\\" scrolling=\\"no\\"><\\/iframe><h2 style=\\"padding: 0 0 8px 0; margin: 0;font-weight: normal;\\">\\u0423\\u043a\\u0440\\u0430\\u0457\\u043d\\u0441\\u044c\\u043a\\u0438\\u0439 \\u043f\\u0430\\u043a\\u0435\\u0442 \\u043b\\u043e\\u043a\\u0430\\u043b\\u0456\\u0437\\u0430\\u0446\\u0456\\u0457 Joomla 2.5<\\/h2><p>\\u041e\\u0444\\u0456\\u0446\\u0456\\u0439\\u043d\\u0430 \\u043b\\u043e\\u043a\\u0430\\u043b\\u0456\\u0437\\u0430\\u0446\\u0456\\u044f Joomla!<\\/p><div id=\\"system-message-container\\"><dl id=\\"system-message\\"><dt class=\\"message\\"><\\/dt><dd class=\\"message message\\"><ul><li><strong>\\u0423\\u0432\\u0430\\u0433\\u0430! \\u0406\\u043d\\u0444\\u043e\\u0440\\u043c\\u0430\\u0446\\u0456\\u044f \\u043f\\u0440\\u043e \\u0432\\u0438\\u043a\\u043e\\u0440\\u0438\\u0441\\u0442\\u0430\\u043d\\u043d\\u044f \\u043b\\u043e\\u043a\\u0430\\u043b\\u0456\\u0437\\u0430\\u0446\\u0456\\u0457 \\u0432 \\u043a\\u043e\\u043c\\u0435\\u0440\\u0446\\u0456\\u0439\\u043d\\u0438\\u0445 \\u0446\\u0456\\u043b\\u044f\\u0445:<\\/strong><\\/li><\\/ul><\\/dd><\\/dl><\\/div><p style=\\"font-weight: normal;\\">\\u042f\\u043a\\u0449\\u043e \\u0412\\u0438 \\u0432\\u0438\\u043a\\u043e\\u0440\\u0438\\u0441\\u0442\\u043e\\u0432\\u0443\\u0454\\u0442\\u0435 \\u0443\\u043a\\u0440\\u0430\\u0457\\u043d\\u0441\\u044c\\u043a\\u0443 \\u043b\\u043e\\u043a\\u0430\\u043b\\u0456\\u0437\\u0430\\u0446\\u0456\\u044e \\u0434\\u043b\\u044f \\u043a\\u043e\\u043c\\u0435\\u0440\\u0446\\u0456\\u0439\\u043d\\u0438\\u0445 \\u0441\\u0430\\u0439\\u0442\\u0456\\u0432, \\u043c\\u0438 \\u0431\\u0443\\u0434\\u0435\\u043c\\u043e \\u0432\\u0434\\u044f\\u0447\\u043d\\u0456 \\u0437\\u0430 \\u043f\\u043e\\u0436\\u0435\\u0440\\u0442\\u0432\\u0443\\u0432\\u0430\\u043d\\u043d\\u044f \\u043f\\u0440\\u043e\\u0435\\u043a\\u0442\\u0443 Joomla! \\u0423\\u043a\\u0440\\u0430\\u0457\\u043d\\u0430, \\u0437\\u0430 \\u0440\\u0430\\u0445\\u0443\\u043d\\u043e\\u043a \\u0432\\u0430\\u0448\\u043e\\u0433\\u043e \\u043a\\u043b\\u0456\\u0454\\u043d\\u0442\\u0443!<\\/p><p style=\\"font-weight: normal;\\">\\u041f\\u043e\\u0436\\u0435\\u0440\\u0442\\u0432\\u0443\\u0432\\u0430\\u043d\\u043d\\u044f \\u043e\\u0437\\u043d\\u0430\\u0447\\u0430\\u0454 \\u0434\\u043e\\u043f\\u043e\\u043c\\u043e\\u0433\\u0430 \\u0443 \\u043b\\u043e\\u043a\\u0430\\u043b\\u0456\\u0437\\u0430\\u0446\\u0456\\u0457 \\u043e\\u0444\\u0456\\u0446\\u0456\\u0439\\u043d\\u043e\\u0433\\u043e \\u043f\\u0430\\u043a\\u0435\\u0442\\u0443 \\u043b\\u043e\\u043a\\u0430\\u043b\\u0456\\u0437\\u0430\\u0446\\u0456\\u0457 Joomla! \\u0442\\u0430 \\u0441\\u0442\\u043e\\u0440\\u043e\\u043d\\u043d\\u0456\\u0445 \\u0440\\u043e\\u0437\\u0448\\u0438\\u0440\\u0435\\u043d\\u044c, \\u0432\\u043a\\u043b\\u044e\\u0447\\u0430\\u044e\\u0447\\u0438 \\u043a\\u043e\\u043c\\u0435\\u0440\\u0446\\u0456\\u0439\\u043d\\u0456 \\u0440\\u043e\\u0437\\u0448\\u0438\\u0440\\u0435\\u043d\\u043d\\u044f.<\\/p><p style=\\"font-weight: normal;\\"><strong>\\u0412\\u0438 \\u043c\\u043e\\u0436\\u0435\\u0442\\u0435 \\u0437\\u0440\\u043e\\u0431\\u0438\\u0442\\u0438 \\u043f\\u043e\\u0436\\u0435\\u0440\\u0442\\u0432\\u0443\\u0432\\u0430\\u043d\\u043d\\u044f \\u043d\\u0430\\u0441\\u0442\\u0443\\u043f\\u043d\\u0438\\u043c \\u0447\\u0438\\u043d\\u043e\\u043c:<\\/strong><br \\/><br \\/>WebMoney: Z162084860012 \\u0442\\u0430 R371967759323.<\\/p>\\u0414\\u0435\\u043c\\u043e: <a href=\\"http:\\/\\/demo.joomla-ua.org\\/\\">demo.joomla-ua.org<\\/a><br \\/>\\u041f\\u0456\\u0434\\u0442\\u0440\\u0438\\u043c\\u043a\\u0430: <a href=\\"http:\\/\\/joomla-ua.org\\/forum\\/\\">\\u0424\\u043e\\u0440\\u0443\\u043c Joomla! \\u0423\\u043a\\u0440\\u0430\\u0457\\u043d\\u0430<\\/a><br \\/><br \\/><span style=\\"font-size: 85%;\\">2006-2012 &copy; Joomla! \\u0423\\u043a\\u0440\\u0430\\u0457\\u043d\\u0430. \\u0412\\u0441\\u0456 \\u043f\\u0440\\u0430\\u0432\\u0430 \\u0437\\u0430\\u0445\\u0438\\u0449\\u0435\\u043d\\u0456.<\\/span><\\/div>","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10011, 'plg_content_attachments', 'plugin', 'attachments', 'content', 0, 1, 1, 0, '{"legacy":false,"name":"plg_content_attachments","type":"plugin","creationDate":"September  7, 2012","author":"Jonathan M. Cameron","copyright":"(C) 2007-2012 Jonathan M. Cameron. All rights reserved.","authorEmail":"jmcameron@jmcameron.net","authorUrl":"http:\\/\\/joomlacode.org\\/gf\\/project\\/attachments\\/","version":"3.0.4","description":"ATTACH_ATTACHMENTS_PLUGIN_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10012, 'plg_search_attachments', 'plugin', 'attachments', 'search', 0, 1, 1, 0, '{"legacy":false,"name":"plg_search_attachments","type":"plugin","creationDate":"September  7, 2012","author":"Jonathan M. Cameron","copyright":"(C) 2007-2012 Jonathan M. Cameron. All rights reserved.","authorEmail":"jmcameron@jmcameron.net","authorUrl":"http:\\/\\/joomlacode.org\\/gf\\/project\\/attachments\\/","version":"3.0.4","description":"ATTACH_ATTACHMENTS_SEARCH_PLUGIN_DESCRIPTION","group":""}', '{"search_limit":"50"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10013, 'plg_attachments_plugin_framework', 'plugin', 'attachments_plugin_framework', 'attachments', 0, 1, 1, 0, '{"legacy":false,"name":"plg_attachments_plugin_framework","type":"plugin","creationDate":"September  7, 2012","author":"Jonathan M. Cameron","copyright":"(C) 2009-2012 Jonathan M. Cameron. All rights reserved.","authorEmail":"jmcameron@jmcameron.net","authorUrl":"http:\\/\\/joomlacode.org\\/gf\\/project\\/attachments\\/","version":"3.0.4","description":"ATTACH_ATTACHMENTS_FOR_COMPONENTS_PLUGIN_FRAMEWORK_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10014, 'plg_attachments_for_content', 'plugin', 'attachments_for_content', 'attachments', 0, 1, 1, 0, '{"legacy":false,"name":"plg_attachments_for_content","type":"plugin","creationDate":"September  7, 2012","author":"Jonathan M. Cameron","copyright":"(C) 2009-2012 Jonathan M. Cameron. All rights reserved.","authorEmail":"jmcameron@jmcameron.net","authorUrl":"http:\\/\\/joomlacode.org\\/gf\\/project\\/attachments\\/","version":"3.0.4","description":"ATTACH_ATTACHMENTS_FOR_CONTENT_PLUGIN_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10015, 'plg_system_show_attachments_in_editor', 'plugin', 'show_attachments', 'system', 0, 1, 1, 0, '{"legacy":false,"name":"plg_system_show_attachments_in_editor","type":"plugin","creationDate":"September  7, 2012","author":"Jonathan M. Cameron","copyright":"(C) 2011-2012 Jonathan M. Cameron. All rights reserved.","authorEmail":"jmcameron@jmcameron.net","authorUrl":"http:\\/\\/joomlacode.org\\/gf\\/project\\/attachments\\/","version":"3.0.4","description":"ATTACH_SHOW_ATTACHMENTS_IN_EDITOR_PLUGIN_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10016, 'plg_editors-xtd_add_attachment_btn', 'plugin', 'add_attachment', 'editors-xtd', 0, 1, 1, 0, '{"legacy":false,"name":"plg_editors-xtd_add_attachment_btn","type":"plugin","creationDate":"September  7, 2012","author":"Jonathan M. Cameron","copyright":"(C) 2007-2012 Jonathan M. Cameron. All rights reserved.","authorEmail":"jmcameron@jmcameron.net","authorUrl":"http:\\/\\/joomlacode.org\\/gf\\/project\\/attachments\\/","version":"3.0.4","description":"ATTACH_ADD_ATTACHMENT_BUTTON_PLUGIN_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10017, 'plg_editors-xtd_insert_attachments_token_btn', 'plugin', 'insert_attachments_token', 'editors-xtd', 0, 1, 1, 0, '{"legacy":false,"name":"plg_editors-xtd_insert_attachments_token_btn","type":"plugin","creationDate":"September  7, 2012","author":"Jonathan M. Cameron","copyright":"(C) 2007-2012 Jonathan M. Cameron. All rights reserved.","authorEmail":"jmcameron@jmcameron.net","authorUrl":"http:\\/\\/joomlacode.org\\/gf\\/project\\/attachments\\/","version":"3.0.4","description":"ATTACH_INSERT_ATTACHMENTS_TOKEN_BUTTON_PLUGIN_DESCRIPTION","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10018, 'com_attachments', 'component', 'com_attachments', '', 1, 1, 0, 0, '{"legacy":false,"name":"com_attachments","type":"component","creationDate":"September  7, 2012","author":"Jonathan M. Cameron","copyright":"(C) 2007-2012 Jonathan M. Cameron. All rights reserved.","authorEmail":"jmcameron@jmcameron.net","authorUrl":"http:\\/\\/joomlacode.org\\/gf\\/project\\/attachments3\\/","version":"3.0.4","description":"ATTACH_ATTACHMENTS_COMPONENT_DESCRIPTION","group":""}', '{"publish_default":"1","auto_publish_warning":"","default_access_level":"1","user_field_1_name":"","user_field_2_name":"","user_field_3_name":"","max_filename_length":0,"attachments_placement":"end","allow_frontend_access_editing":"0","show_column_titles":"0","show_description":"0","show_creator":"0","show_file_size":"0","show_downloads":"0","show_modified_date":"0","mod_date_format":"%x %H:%M","sort_order":"filename","hide_on_frontpage":"0","hide_with_readmore":"0","hide_on_blogs":"0","hide_except_article_views":"0","always_show_category_attachments":"0","hide_attachments_for_categories":["8"],"hide_add_attachments_link":"0","forbidden_filename_characters":"#=?%&","attachments_table_style":"attachmentsList","file_link_open_mode":"in_same_window","attachments_titles":"","link_check_timeout":"10","superimpose_url_link_icons":"1","suppress_obsolete_attachments":"0","secure":"0","download_mode":"attachment"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10019, 'attachments', 'package', 'pkg_attachments', '', 0, 1, 1, 0, '{"legacy":false,"name":"pkg_attachments","type":"package","creationDate":"September  7, 2012","author":"Jonathan M. Cameron","copyright":"(C) 2007-2012 Jonathan M. Cameron. All rights reserved.","authorEmail":"jmcameron@jmcameron.net","authorUrl":"http:\\/\\/joomlacode.org\\/gf\\/project\\/attachments\\/","version":"3.0.4","description":"ATTACH_PACKAGE_ATTACHMENTS_FOR_JOOMLA_16PLUS","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10022, 'attachments_uk_ua_language_pack', 'file', 'attachments_uk_ua_language_pack', '', 0, 0, 0, 0, '{"legacy":false,"name":"attachments_uk_ua_language_pack","type":"file","creationDate":"2012-09-29","author":"Jonathan M. Cameron, Version 3.0: Sergey Litvintsev (serge_li@ukr.net)","copyright":"Copyright (C) 2011-2012 Jonathan M. Cameron. All rights reserved.","authorEmail":"jmcameron@jmcameron.net","authorUrl":"","version":"3.0.3","description":"ATTACHMENTS_UK_UA_LANGUAGE_PACK","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10023, 'mod_teacherblog', 'module', 'mod_teacherblog', '', 0, 1, 0, 0, '{"legacy":false,"name":"mod_teacherblog","type":"module","creationDate":"2013","author":"Vadimka=)","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"","version":"1.0","description":"MOD_FOOTER_XML_DESCRIPTION","group":""}', '[]', '', '', 0, '0000-00-00 00:00:00', 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_filters`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_filters` (
  `filter_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL,
  `created_by_alias` varchar(255) NOT NULL,
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `map_count` int(10) unsigned NOT NULL DEFAULT '0',
  `data` text NOT NULL,
  `params` mediumtext,
  PRIMARY KEY (`filter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_links`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_links` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `route` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `indexdate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `md5sum` varchar(32) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `state` int(5) DEFAULT '1',
  `access` int(5) DEFAULT '0',
  `language` varchar(8) NOT NULL,
  `publish_start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `list_price` double unsigned NOT NULL DEFAULT '0',
  `sale_price` double unsigned NOT NULL DEFAULT '0',
  `type_id` int(11) NOT NULL,
  `object` mediumblob NOT NULL,
  PRIMARY KEY (`link_id`),
  KEY `idx_type` (`type_id`),
  KEY `idx_title` (`title`),
  KEY `idx_md5` (`md5sum`),
  KEY `idx_url` (`url`(75)),
  KEY `idx_published_list` (`published`,`state`,`access`,`publish_start_date`,`publish_end_date`,`list_price`),
  KEY `idx_published_sale` (`published`,`state`,`access`,`publish_start_date`,`publish_end_date`,`sale_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_links_terms0`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_links_terms0` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_links_terms1`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_links_terms1` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_links_terms2`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_links_terms2` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_links_terms3`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_links_terms3` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_links_terms4`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_links_terms4` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_links_terms5`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_links_terms5` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_links_terms6`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_links_terms6` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_links_terms7`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_links_terms7` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_links_terms8`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_links_terms8` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_links_terms9`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_links_terms9` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_links_termsa`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_links_termsa` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_links_termsb`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_links_termsb` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_links_termsc`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_links_termsc` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_links_termsd`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_links_termsd` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_links_termse`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_links_termse` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_links_termsf`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_links_termsf` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_taxonomy`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_taxonomy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `state` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `access` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ordering` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `state` (`state`),
  KEY `ordering` (`ordering`),
  KEY `access` (`access`),
  KEY `idx_parent_published` (`parent_id`,`state`,`access`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `pc7bw_finder_taxonomy`
--

INSERT INTO `pc7bw_finder_taxonomy` (`id`, `parent_id`, `title`, `state`, `access`, `ordering`) VALUES
(1, 0, 'ROOT', 0, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_taxonomy_map`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_taxonomy_map` (
  `link_id` int(10) unsigned NOT NULL,
  `node_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`node_id`),
  KEY `link_id` (`link_id`),
  KEY `node_id` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_terms`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_terms` (
  `term_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `weight` float unsigned NOT NULL DEFAULT '0',
  `soundex` varchar(75) NOT NULL,
  `links` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  UNIQUE KEY `idx_term` (`term`),
  KEY `idx_term_phrase` (`term`,`phrase`),
  KEY `idx_stem_phrase` (`stem`,`phrase`),
  KEY `idx_soundex_phrase` (`soundex`,`phrase`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_terms_common`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_terms_common` (
  `term` varchar(75) NOT NULL,
  `language` varchar(3) NOT NULL,
  KEY `idx_word_lang` (`term`,`language`),
  KEY `idx_lang` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pc7bw_finder_terms_common`
--

INSERT INTO `pc7bw_finder_terms_common` (`term`, `language`) VALUES
('a', 'en'),
('about', 'en'),
('after', 'en'),
('ago', 'en'),
('all', 'en'),
('am', 'en'),
('an', 'en'),
('and', 'en'),
('ani', 'en'),
('any', 'en'),
('are', 'en'),
('aren''t', 'en'),
('as', 'en'),
('at', 'en'),
('be', 'en'),
('but', 'en'),
('by', 'en'),
('for', 'en'),
('from', 'en'),
('get', 'en'),
('go', 'en'),
('how', 'en'),
('if', 'en'),
('in', 'en'),
('into', 'en'),
('is', 'en'),
('isn''t', 'en'),
('it', 'en'),
('its', 'en'),
('me', 'en'),
('more', 'en'),
('most', 'en'),
('must', 'en'),
('my', 'en'),
('new', 'en'),
('no', 'en'),
('none', 'en'),
('not', 'en'),
('noth', 'en'),
('nothing', 'en'),
('of', 'en'),
('off', 'en'),
('often', 'en'),
('old', 'en'),
('on', 'en'),
('onc', 'en'),
('once', 'en'),
('onli', 'en'),
('only', 'en'),
('or', 'en'),
('other', 'en'),
('our', 'en'),
('ours', 'en'),
('out', 'en'),
('over', 'en'),
('page', 'en'),
('she', 'en'),
('should', 'en'),
('small', 'en'),
('so', 'en'),
('some', 'en'),
('than', 'en'),
('thank', 'en'),
('that', 'en'),
('the', 'en'),
('their', 'en'),
('theirs', 'en'),
('them', 'en'),
('then', 'en'),
('there', 'en'),
('these', 'en'),
('they', 'en'),
('this', 'en'),
('those', 'en'),
('thus', 'en'),
('time', 'en'),
('times', 'en'),
('to', 'en'),
('too', 'en'),
('true', 'en'),
('under', 'en'),
('until', 'en'),
('up', 'en'),
('upon', 'en'),
('use', 'en'),
('user', 'en'),
('users', 'en'),
('veri', 'en'),
('version', 'en'),
('very', 'en'),
('via', 'en'),
('want', 'en'),
('was', 'en'),
('way', 'en'),
('were', 'en'),
('what', 'en'),
('when', 'en'),
('where', 'en'),
('whi', 'en'),
('which', 'en'),
('who', 'en'),
('whom', 'en'),
('whose', 'en'),
('why', 'en'),
('wide', 'en'),
('will', 'en'),
('with', 'en'),
('within', 'en'),
('without', 'en'),
('would', 'en'),
('yes', 'en'),
('yet', 'en'),
('you', 'en'),
('your', 'en'),
('yours', 'en');

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_tokens`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_tokens` (
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `weight` float unsigned NOT NULL DEFAULT '1',
  `context` tinyint(1) unsigned NOT NULL DEFAULT '2',
  KEY `idx_word` (`term`),
  KEY `idx_context` (`context`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_tokens_aggregate`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_tokens_aggregate` (
  `term_id` int(10) unsigned NOT NULL,
  `map_suffix` char(1) NOT NULL,
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `term_weight` float unsigned NOT NULL,
  `context` tinyint(1) unsigned NOT NULL DEFAULT '2',
  `context_weight` float unsigned NOT NULL,
  `total_weight` float unsigned NOT NULL,
  KEY `token` (`term`),
  KEY `keyword_id` (`term_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_finder_types`
--

CREATE TABLE IF NOT EXISTS `pc7bw_finder_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `mime` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_languages`
--

CREATE TABLE IF NOT EXISTS `pc7bw_languages` (
  `lang_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `lang_code` char(7) NOT NULL,
  `title` varchar(50) NOT NULL,
  `title_native` varchar(50) NOT NULL,
  `sef` varchar(50) NOT NULL,
  `image` varchar(50) NOT NULL,
  `description` varchar(512) NOT NULL,
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `sitename` varchar(1024) NOT NULL DEFAULT '',
  `published` int(11) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`lang_id`),
  UNIQUE KEY `idx_sef` (`sef`),
  UNIQUE KEY `idx_image` (`image`),
  UNIQUE KEY `idx_langcode` (`lang_code`),
  KEY `idx_access` (`access`),
  KEY `idx_ordering` (`ordering`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `pc7bw_languages`
--

INSERT INTO `pc7bw_languages` (`lang_id`, `lang_code`, `title`, `title_native`, `sef`, `image`, `description`, `metakey`, `metadesc`, `sitename`, `published`, `access`, `ordering`) VALUES
(1, 'en-GB', 'English (UK)', 'English (UK)', 'en', 'en', '', '', '', '', 1, 0, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_menu`
--

CREATE TABLE IF NOT EXISTS `pc7bw_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menutype` varchar(24) NOT NULL COMMENT 'The type of menu this item belongs to. FK to #__menu_types.menutype',
  `title` varchar(255) NOT NULL COMMENT 'The display title of the menu item.',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The SEF alias of the menu item.',
  `note` varchar(255) NOT NULL DEFAULT '',
  `path` varchar(1024) NOT NULL COMMENT 'The computed path of the menu item based on the alias field.',
  `link` varchar(1024) NOT NULL COMMENT 'The actually link the menu item refers to.',
  `type` varchar(16) NOT NULL COMMENT 'The type of link: Component, URL, Alias, Separator',
  `published` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The published state of the menu link.',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'The parent menu item in the menu tree.',
  `level` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The relative level in the tree.',
  `component_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to #__extensions.id',
  `ordering` int(11) NOT NULL DEFAULT '0' COMMENT 'The relative ordering of the menu item in the tree.',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to #__users.id',
  `checked_out_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'The time the menu item was checked out.',
  `browserNav` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The click behaviour of the link.',
  `access` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The access level required to view the menu item.',
  `img` varchar(255) NOT NULL COMMENT 'The image of the menu item.',
  `template_style_id` int(10) unsigned NOT NULL DEFAULT '0',
  `params` text NOT NULL COMMENT 'JSON encoded data for the menu item.',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `home` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Indicates if this menu item is the home or default page.',
  `language` char(7) NOT NULL DEFAULT '',
  `client_id` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_client_id_parent_id_alias_language` (`client_id`,`parent_id`,`alias`,`language`),
  KEY `idx_componentid` (`component_id`,`menutype`,`published`,`access`),
  KEY `idx_menutype` (`menutype`),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`),
  KEY `idx_path` (`path`(255)),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=120 ;

--
-- Дамп данных таблицы `pc7bw_menu`
--

INSERT INTO `pc7bw_menu` (`id`, `menutype`, `title`, `alias`, `note`, `path`, `link`, `type`, `published`, `parent_id`, `level`, `component_id`, `ordering`, `checked_out`, `checked_out_time`, `browserNav`, `access`, `img`, `template_style_id`, `params`, `lft`, `rgt`, `home`, `language`, `client_id`) VALUES
(1, '', 'Menu_Item_Root', 'root', '', '', '', '', 1, 0, 0, 0, 0, 0, '0000-00-00 00:00:00', 0, 0, '', 0, '', 0, 57, 0, '*', 0),
(2, 'menu', 'com_banners', 'Banners', '', 'Banners', 'index.php?option=com_banners', 'component', 0, 1, 1, 4, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners', 0, '', 1, 10, 0, '*', 1),
(3, 'menu', 'com_banners', 'Banners', '', 'Banners/Banners', 'index.php?option=com_banners', 'component', 0, 2, 2, 4, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners', 0, '', 2, 3, 0, '*', 1),
(4, 'menu', 'com_banners_categories', 'Categories', '', 'Banners/Categories', 'index.php?option=com_categories&extension=com_banners', 'component', 0, 2, 2, 6, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners-cat', 0, '', 4, 5, 0, '*', 1),
(5, 'menu', 'com_banners_clients', 'Clients', '', 'Banners/Clients', 'index.php?option=com_banners&view=clients', 'component', 0, 2, 2, 4, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners-clients', 0, '', 6, 7, 0, '*', 1),
(6, 'menu', 'com_banners_tracks', 'Tracks', '', 'Banners/Tracks', 'index.php?option=com_banners&view=tracks', 'component', 0, 2, 2, 4, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners-tracks', 0, '', 8, 9, 0, '*', 1),
(7, 'menu', 'com_contact', 'Contacts', '', 'Contacts', 'index.php?option=com_contact', 'component', 0, 1, 1, 8, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:contact', 0, '', 11, 16, 0, '*', 1),
(8, 'menu', 'com_contact', 'Contacts', '', 'Contacts/Contacts', 'index.php?option=com_contact', 'component', 0, 7, 2, 8, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:contact', 0, '', 12, 13, 0, '*', 1),
(9, 'menu', 'com_contact_categories', 'Categories', '', 'Contacts/Categories', 'index.php?option=com_categories&extension=com_contact', 'component', 0, 7, 2, 6, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:contact-cat', 0, '', 14, 15, 0, '*', 1),
(10, 'menu', 'com_messages', 'Messaging', '', 'Messaging', 'index.php?option=com_messages', 'component', 0, 1, 1, 15, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:messages', 0, '', 17, 22, 0, '*', 1),
(11, 'menu', 'com_messages_add', 'New Private Message', '', 'Messaging/New Private Message', 'index.php?option=com_messages&task=message.add', 'component', 0, 10, 2, 15, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:messages-add', 0, '', 18, 19, 0, '*', 1),
(12, 'menu', 'com_messages_read', 'Read Private Message', '', 'Messaging/Read Private Message', 'index.php?option=com_messages', 'component', 0, 10, 2, 15, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:messages-read', 0, '', 20, 21, 0, '*', 1),
(13, 'menu', 'com_newsfeeds', 'News Feeds', '', 'News Feeds', 'index.php?option=com_newsfeeds', 'component', 0, 1, 1, 17, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:newsfeeds', 0, '', 23, 28, 0, '*', 1),
(14, 'menu', 'com_newsfeeds_feeds', 'Feeds', '', 'News Feeds/Feeds', 'index.php?option=com_newsfeeds', 'component', 0, 13, 2, 17, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:newsfeeds', 0, '', 24, 25, 0, '*', 1),
(15, 'menu', 'com_newsfeeds_categories', 'Categories', '', 'News Feeds/Categories', 'index.php?option=com_categories&extension=com_newsfeeds', 'component', 0, 13, 2, 6, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:newsfeeds-cat', 0, '', 26, 27, 0, '*', 1),
(16, 'menu', 'com_redirect', 'Redirect', '', 'Redirect', 'index.php?option=com_redirect', 'component', 0, 1, 1, 24, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:redirect', 0, '', 41, 42, 0, '*', 1),
(17, 'menu', 'com_search', 'Basic Search', '', 'Basic Search', 'index.php?option=com_search', 'component', 0, 1, 1, 19, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:search', 0, '', 33, 34, 0, '*', 1),
(18, 'menu', 'com_weblinks', 'Weblinks', '', 'Weblinks', 'index.php?option=com_weblinks', 'component', 0, 1, 1, 21, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:weblinks', 0, '', 35, 40, 0, '*', 1),
(19, 'menu', 'com_weblinks_links', 'Links', '', 'Weblinks/Links', 'index.php?option=com_weblinks', 'component', 0, 18, 2, 21, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:weblinks', 0, '', 36, 37, 0, '*', 1),
(20, 'menu', 'com_weblinks_categories', 'Categories', '', 'Weblinks/Categories', 'index.php?option=com_categories&extension=com_weblinks', 'component', 0, 18, 2, 6, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:weblinks-cat', 0, '', 38, 39, 0, '*', 1),
(21, 'menu', 'com_finder', 'Smart Search', '', 'Smart Search', 'index.php?option=com_finder', 'component', 0, 1, 1, 27, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:finder', 0, '', 31, 32, 0, '*', 1),
(22, 'menu', 'com_joomlaupdate', 'Joomla! Update', '', 'Joomla! Update', 'index.php?option=com_joomlaupdate', 'component', 0, 1, 1, 28, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:joomlaupdate', 0, '', 41, 42, 0, '*', 1),
(101, 'mainmenu', 'Головна', '2012-12-25-10-30-50', '', '2012-12-25-10-30-50', 'index.php?option=com_content&view=category&layout=blog&id=9', 'component', 1, 1, 1, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"layout_type":"blog","show_category_title":"","show_description":"","show_description_image":"","maxLevel":"","show_empty_categories":"","show_no_articles":"","show_subcat_desc":"","show_cat_num_articles":"","page_subheading":"","num_leading_articles":"1","num_intro_articles":"3","num_columns":"3","num_links":"0","multi_column_order":"1","show_subcategory_content":"","orderby_pri":"","orderby_sec":"front","order_date":"","show_pagination":"2","show_pagination_results":"1","show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_readmore":"","show_readmore_title":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","show_feed_link":"1","feed_summary":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":1,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 29, 30, 1, '*', 0),
(102, 'mainmenu', 'Про спеціальність', '2012-12-25-10-31-40', '', '2012-12-25-10-31-40', '', 'separator', 1, 1, 1, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"menu_image":"","menu_text":1}', 43, 44, 0, '*', 0),
(103, 'mainmenu', 'Викладачі кафедри', 'vikladachi-kafedri', '', 'vikladachi-kafedri', 'index.php?option=com_content&view=category&layout=blog&id=8', 'component', -2, 1, 1, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"layout_type":"blog","show_category_title":"","show_description":"","show_description_image":"","maxLevel":"","show_empty_categories":"","show_no_articles":"","show_subcat_desc":"","show_cat_num_articles":"","page_subheading":"","num_leading_articles":"","num_intro_articles":"","num_columns":"","num_links":"","multi_column_order":"","show_subcategory_content":"","orderby_pri":"","orderby_sec":"","order_date":"","show_pagination":"","show_pagination_results":"","show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_readmore":"","show_readmore_title":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","show_feed_link":"","feed_summary":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 45, 46, 0, '*', 0),
(104, 'mainmenu', 'Контакти', '2012-12-25-10-33-06', '', '2012-12-25-10-33-06', '', 'separator', 1, 1, 1, 0, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"menu_image":"","menu_text":1}', 49, 50, 0, '*', 0),
(105, 'main', 'ATTACH_ATTACHMENTS', 'attach-attachments', '', 'attach-attachments', 'index.php?option=com_attachments', 'component', 0, 1, 1, 10018, 0, 0, '0000-00-00 00:00:00', 0, 1, 'components/com_attachments/media/attachments.png', 0, '', 51, 56, 0, '', 1),
(106, 'main', 'ATTACH_ADD_NEW_ATTACHMENT', 'attach-add-new-attachment', '', 'attach-attachments/attach-add-new-attachment', 'index.php?option=com_attachments&task=attachment.add', 'component', 0, 105, 2, 10018, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:newarticle', 0, '', 52, 53, 0, '', 1),
(107, 'main', 'JTOOLBAR_OPTIONS', 'jtoolbar-options', '', 'attach-attachments/jtoolbar-options', 'index.php?option=com_attachments&task=params.edit', 'component', 0, 105, 2, 10018, 0, 0, '0000-00-00 00:00:00', 0, 1, 'class:config', 0, '', 54, 55, 0, '', 1),
(108, 'mainmenu', 'Викладачі кафедри', 'vykladachi-kafedry', '', 'vykladachi-kafedry', 'index.php?option=com_content&view=category&layout=blog&id=8', 'component', 1, 1, 1, 22, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"layout_type":"blog","show_category_title":"","show_description":"","show_description_image":"","maxLevel":"","show_empty_categories":"","show_no_articles":"","show_subcat_desc":"","show_cat_num_articles":"","page_subheading":"","num_leading_articles":"","num_intro_articles":"","num_columns":"","num_links":"","multi_column_order":"","show_subcategory_content":"","orderby_pri":"","orderby_sec":"","order_date":"","show_pagination":"","show_pagination_results":"","show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_readmore":"","show_readmore_title":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_noauth":"","show_feed_link":"","feed_summary":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 47, 48, 0, '*', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_menu_types`
--

CREATE TABLE IF NOT EXISTS `pc7bw_menu_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menutype` varchar(24) NOT NULL,
  `title` varchar(48) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_menutype` (`menutype`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `pc7bw_menu_types`
--

INSERT INTO `pc7bw_menu_types` (`id`, `menutype`, `title`, `description`) VALUES
(1, 'mainmenu', 'Main Menu', 'The main menu for the site');

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_messages`
--

CREATE TABLE IF NOT EXISTS `pc7bw_messages` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id_from` int(10) unsigned NOT NULL DEFAULT '0',
  `user_id_to` int(10) unsigned NOT NULL DEFAULT '0',
  `folder_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `priority` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `useridto_state` (`user_id_to`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_messages_cfg`
--

CREATE TABLE IF NOT EXISTS `pc7bw_messages_cfg` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `cfg_name` varchar(100) NOT NULL DEFAULT '',
  `cfg_value` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `idx_user_var_name` (`user_id`,`cfg_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_modules`
--

CREATE TABLE IF NOT EXISTS `pc7bw_modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '',
  `note` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `ordering` int(11) NOT NULL DEFAULT '0',
  `position` varchar(50) NOT NULL DEFAULT '',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `module` varchar(50) DEFAULT NULL,
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `showtitle` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `params` text NOT NULL,
  `client_id` tinyint(4) NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `published` (`published`,`access`),
  KEY `newsfeeds` (`module`,`published`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=93 ;

--
-- Дамп данных таблицы `pc7bw_modules`
--

INSERT INTO `pc7bw_modules` (`id`, `title`, `note`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `published`, `module`, `access`, `showtitle`, `params`, `client_id`, `language`) VALUES
(1, 'Main Menu', '', '', 1, 'menu', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_menu', 1, 0, '{"menutype":"mainmenu","startLevel":"1","endLevel":"0","showAllChildren":"0","tag_id":"","class_sfx":"","window_open":"","layout":"_:default","moduleclass_sfx":"_menu","cache":"1","cache_time":"900","cachemode":"itemid"}', 0, '*'),
(2, 'Login', '', '', 1, 'login', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_login', 1, 1, '', 1, '*'),
(3, 'Popular Articles', '', '', 3, 'cpanel', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_popular', 3, 1, '{"count":"5","catid":"","user_id":"0","layout":"_:default","moduleclass_sfx":"","cache":"0","automatic_title":"1"}', 1, '*'),
(4, 'Recently Added Articles', '', '', 4, 'cpanel', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_latest', 3, 1, '{"count":"5","ordering":"c_dsc","catid":"","user_id":"0","layout":"_:default","moduleclass_sfx":"","cache":"0","automatic_title":"1"}', 1, '*'),
(8, 'Toolbar', '', '', 1, 'toolbar', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_toolbar', 3, 1, '', 1, '*'),
(9, 'Quick Icons', '', '', 1, 'icon', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_quickicon', 3, 1, '', 1, '*'),
(10, 'Logged-in Users', '', '', 2, 'cpanel', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_logged', 3, 1, '{"count":"5","name":"1","layout":"_:default","moduleclass_sfx":"","cache":"0","automatic_title":"1"}', 1, '*'),
(12, 'Admin Menu', '', '', 1, 'menu', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_menu', 3, 1, '{"layout":"","moduleclass_sfx":"","shownew":"1","showhelp":"1","cache":"0"}', 1, '*'),
(13, 'Admin Submenu', '', '', 1, 'submenu', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_submenu', 3, 1, '', 1, '*'),
(14, 'User Status', '', '', 2, 'status', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_status', 3, 1, '', 1, '*'),
(15, 'Title', '', '', 1, 'title', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_title', 3, 1, '', 1, '*'),
(16, 'Login Form', '', '', 1, 'announcement', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 'mod_login', 1, 1, '{"pretext":"","posttext":"","login":"","logout":"","greeting":"1","name":"0","usesecure":"0","layout":"_:default","moduleclass_sfx":"","cache":"0"}', 0, '*'),
(17, 'Breadcrumbs', '', '', 1, 'position-2', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 'mod_breadcrumbs', 1, 1, '{"moduleclass_sfx":"","showHome":"1","homeText":"Home","showComponent":"1","separator":"","cache":"1","cache_time":"900","cachemode":"itemid"}', 0, '*'),
(79, 'Multilanguage status', '', '', 1, 'status', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 'mod_multilangstatus', 3, 1, '{"layout":"_:default","moduleclass_sfx":"","cache":"0"}', 1, '*'),
(86, 'Joomla Version', '', '', 1, 'footer', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_version', 3, 1, '{"format":"short","product":"1","layout":"_:default","moduleclass_sfx":"","cache":"0"}', 1, '*'),
(87, 'Оголошення', '', '', 1, 'announcement', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', -2, 'mod_articles_latest', 1, 0, '{"catid":["10"],"count":"1","show_featured":"","ordering":"c_dsc","user_id":"0","layout":"_:default","moduleclass_sfx":"","cache":"1","cache_time":"900","cachemode":"static"}', 0, '*'),
(88, 'Оголошення1', '', '', 1, 'announcement', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', -2, 'mod_articles_category', 1, 0, '{"mode":"normal","show_on_article_page":"1","show_front":"hide","count":"0","category_filtering_type":"1","catid":["10"],"show_child_category_articles":"0","levels":"1","author_filtering_type":"1","created_by":[""],"author_alias_filtering_type":"1","created_by_alias":[""],"excluded_articles":"","date_filtering":"off","date_field":"a.created","start_date_range":"","end_date_range":"","relative_date":"30","article_ordering":"a.title","article_ordering_direction":"ASC","article_grouping":"none","article_grouping_direction":"ksort","month_year_format":"F Y","item_heading":"4","link_titles":"1","show_date":"0","show_date_field":"created","show_date_format":"Y-m-d H:i:s","show_category":"0","show_hits":"0","show_author":"0","show_introtext":"1","introtext_limit":"100","show_readmore":"0","show_readmore_title":"1","readmore_limit":"15","layout":"_:default","moduleclass_sfx":"","owncache":"1","cache_time":"900"}', 0, '*'),
(89, 'Оголошення', '', '', 1, 'announcement', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_announcement', 1, 0, '{"catid":["10"],"ordering":"l_cre"}', 0, '*'),
(90, 'Joomla! Україна Admin Menu', '', '', 99, 'menu', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_jumenu', 1, 0, '', 1, '*'),
(91, 'Новини Joomla! Україна', '', '', 99, 'cpanel', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_junews', 1, 0, '', 1, '*'),
(92, 'Блог викладача', '', '', 1, 'teacherblog', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_teacherblog', 1, 0, '{"name":""}', 0, '*');

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_modules_menu`
--

CREATE TABLE IF NOT EXISTS `pc7bw_modules_menu` (
  `moduleid` int(11) NOT NULL DEFAULT '0',
  `menuid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`moduleid`,`menuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pc7bw_modules_menu`
--

INSERT INTO `pc7bw_modules_menu` (`moduleid`, `menuid`) VALUES
(1, 0),
(2, 0),
(3, 0),
(4, 0),
(6, 0),
(7, 0),
(8, 0),
(9, 0),
(10, 0),
(12, 0),
(13, 0),
(14, 0),
(15, 0),
(16, 0),
(17, 0),
(79, 0),
(86, 0),
(87, 0),
(88, 0),
(89, 101),
(90, 0),
(91, 0),
(92, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_newsfeeds`
--

CREATE TABLE IF NOT EXISTS `pc7bw_newsfeeds` (
  `catid` int(11) NOT NULL DEFAULT '0',
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `link` varchar(200) NOT NULL DEFAULT '',
  `filename` varchar(200) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `numarticles` int(10) unsigned NOT NULL DEFAULT '1',
  `cache_time` int(10) unsigned NOT NULL DEFAULT '3600',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `rtl` tinyint(4) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `metadata` text NOT NULL,
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`published`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_overrider`
--

CREATE TABLE IF NOT EXISTS `pc7bw_overrider` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `constant` varchar(255) NOT NULL,
  `string` text NOT NULL,
  `file` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_redirect_links`
--

CREATE TABLE IF NOT EXISTS `pc7bw_redirect_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `old_url` varchar(255) NOT NULL,
  `new_url` varchar(255) NOT NULL,
  `referer` varchar(150) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `published` tinyint(4) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_link_old` (`old_url`),
  KEY `idx_link_modifed` (`modified_date`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

--
-- Дамп данных таблицы `pc7bw_redirect_links`
--

INSERT INTO `pc7bw_redirect_links` (`id`, `old_url`, `new_url`, `referer`, `comment`, `hits`, `published`, `created_date`, `modified_date`) VALUES
(1, 'http://localhost/pmchair/index.php/10-novyna-3', '', 'http://localhost/pmchair/', '', 7, 0, '2013-01-08 22:50:34', '0000-00-00 00:00:00'),
(2, 'http://localhost/pmchair/index.php/10-2012-12-25-10-09-48/5-2-2', '', 'http://localhost/pmchair/index.php/10-2012-12-25-10-09-48/6-3', '', 4, 0, '2013-01-08 22:50:55', '0000-00-00 00:00:00'),
(3, 'http://localhost/pmchair/?id=11:dystsyplina-2', '', 'http://localhost/pmchair/index.php/2-2', '', 7, 0, '2013-01-08 22:52:23', '0000-00-00 00:00:00'),
(4, 'http://localhost/pmchair/?id=12:dystsyplina-3', '', 'http://localhost/pmchair/?id=9:dystsyplina-1', '', 3, 0, '2013-01-08 23:22:32', '0000-00-00 00:00:00'),
(5, 'http://localhost/pmchair/index.php?id=12:dystsyplina-3', '', '', '', 1, 0, '2013-01-08 23:30:23', '0000-00-00 00:00:00'),
(6, 'http://localhost/pmchair/?id=13:dystsyplina-4', '', 'http://localhost/pmchair/index.php/10-2012-12-25-10-09-48/7-4', '', 3, 0, '2013-01-08 23:33:03', '0000-00-00 00:00:00'),
(7, 'http://localhost/pmchair/index.php/17-novyna-vykladacha', '', 'http://localhost/pmchair/', '', 2, 0, '2013-01-11 22:28:25', '0000-00-00 00:00:00'),
(8, 'http://localhost/pmchair/index.php/10-2012-12-25-10-09-48/4-2', '', 'http://localhost/pmchair/index.php/15-iakas-novyna', '', 1, 0, '2013-01-11 22:31:29', '0000-00-00 00:00:00'),
(9, 'http://localhost/pmchair/index.php/2012-12-25-10-32-47', '', 'http://localhost/pmchair/index.php/15-iakas-novyna', '', 3, 0, '2013-01-11 22:31:41', '0000-00-00 00:00:00'),
(10, 'http://localhost/pmchair/index.php/vikladachi-kafedri', '', 'http://localhost/pmchair/index.php/1-novina11', '', 5, 0, '2013-01-12 11:56:52', '0000-00-00 00:00:00'),
(11, 'http://localhost/pmchair/index.php/vykladachi-kafedry', '', 'http://localhost/pmchair/', '', 8, 0, '2013-01-12 12:08:12', '0000-00-00 00:00:00'),
(12, 'http://localhost/pmchair/index.php/vykladachi-kafedry?id=19:dystsyplina-vykladacha-2', '', 'http://localhost/pmchair/index.php/vykladachi-kafedry/18-vykladach-2', '', 7, 0, '2013-01-12 13:37:02', '0000-00-00 00:00:00'),
(13, 'http://localhost/pmchair/index.php/vykladachi-kafedry?id=13:dystsyplina-4', '', 'http://localhost/pmchair/index.php/vykladachi-kafedry', '', 1, 0, '2013-01-12 13:37:29', '0000-00-00 00:00:00'),
(14, 'http://localhost/pmchair/index.php/vykladachi-kafedry?id=21:dystsyplina-vykladacha-222', '', 'http://localhost/pmchair/index.php/vykladachi-kafedry/20-vykladach-3', '', 8, 0, '2013-01-12 14:24:06', '0000-00-00 00:00:00'),
(15, 'http://localhost/pmchair/index.php/vykladachi-kafedry/id=19:dystsyplina-vykladacha-2', '', '', '', 1, 0, '2013-01-12 14:33:56', '0000-00-00 00:00:00'),
(16, 'http://localhost/pmchair/index.php/dystsyplina-vykladacha-222', '', '', '', 2, 0, '2013-01-12 14:37:34', '0000-00-00 00:00:00'),
(17, 'http://localhost/pmchair/index.php/vykladachi-kafedry?layout=edit&id=21', '', 'http://localhost/pmchair/index.php/vykladachi-kafedry/20-vykladach-3', '', 2, 0, '2013-01-13 14:00:43', '0000-00-00 00:00:00'),
(18, 'http://localhost/pmchair/index.php/vykladachi-kafedry?id=21', '', 'http://localhost/pmchair/index.php/vykladachi-kafedry/20-vykladach-3', '', 4, 0, '2013-01-13 14:03:54', '0000-00-00 00:00:00'),
(19, 'http://localhost/pmchair/index.php/vykladachi-kafedry?id=19', '', 'http://localhost/pmchair/index.php/vykladachi-kafedry/18-vykladach-2', '', 3, 0, '2013-01-13 14:06:32', '0000-00-00 00:00:00'),
(20, 'http://localhost/pmchair/index.php/vykladachi-kafedry?id=21-dystsyplina-vykladacha-222', '', 'http://localhost/pmchair/index.php/vykladachi-kafedry/20-vykladach-3', '', 1, 0, '2013-01-13 14:28:52', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_schemas`
--

CREATE TABLE IF NOT EXISTS `pc7bw_schemas` (
  `extension_id` int(11) NOT NULL,
  `version_id` varchar(20) NOT NULL,
  PRIMARY KEY (`extension_id`,`version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pc7bw_schemas`
--

INSERT INTO `pc7bw_schemas` (`extension_id`, `version_id`) VALUES
(700, '2.5.8'),
(10008, '1.20.0'),
(10009, '1.20.0');

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_session`
--

CREATE TABLE IF NOT EXISTS `pc7bw_session` (
  `session_id` varchar(200) NOT NULL DEFAULT '',
  `client_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `guest` tinyint(4) unsigned DEFAULT '1',
  `time` varchar(14) DEFAULT '',
  `data` mediumtext,
  `userid` int(11) DEFAULT '0',
  `username` varchar(150) DEFAULT '',
  `usertype` varchar(50) DEFAULT '',
  PRIMARY KEY (`session_id`),
  KEY `whosonline` (`guest`,`usertype`),
  KEY `userid` (`userid`),
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pc7bw_session`
--

INSERT INTO `pc7bw_session` (`session_id`, `client_id`, `guest`, `time`, `data`, `userid`, `username`, `usertype`) VALUES
('ebc8af4d47bdb3627967a3ae1d97e8cd', 0, 1, '1358112342', '__default|a:7:{s:22:"session.client.browser";s:74:"Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:17.0) Gecko/20100101 Firefox/17.0";s:15:"session.counter";i:7;s:8:"registry";O:9:"JRegistry":1:{s:7:"\0*\0data";O:8:"stdClass":0:{}}s:4:"user";O:5:"JUser":25:{s:9:"\0*\0isRoot";b:0;s:2:"id";i:0;s:4:"name";N;s:8:"username";N;s:5:"email";N;s:8:"password";N;s:14:"password_clear";s:0:"";s:8:"usertype";N;s:5:"block";N;s:9:"sendEmail";i:0;s:12:"registerDate";N;s:13:"lastvisitDate";N;s:10:"activation";N;s:6:"params";N;s:6:"groups";a:0:{}s:5:"guest";i:1;s:13:"lastResetTime";N;s:10:"resetCount";N;s:10:"\0*\0_params";O:9:"JRegistry":1:{s:7:"\0*\0data";O:8:"stdClass":0:{}}s:14:"\0*\0_authGroups";a:1:{i:0;i:1;}s:14:"\0*\0_authLevels";a:2:{i:0;i:1;i:1;i:1;}s:15:"\0*\0_authActions";N;s:12:"\0*\0_errorMsg";N;s:10:"\0*\0_errors";a:0:{}s:3:"aid";i:0;}s:19:"session.timer.start";i:1358112321;s:18:"session.timer.last";i:1358112336;s:17:"session.timer.now";i:1358112341;}', 0, '', ''),
('vhf2341hl844abqdelup7h7te4', 1, 0, '1358110065', '__default|a:8:{s:15:"session.counter";i:21;s:19:"session.timer.start";i:1358109891;s:18:"session.timer.last";i:1358110064;s:17:"session.timer.now";i:1358110065;s:22:"session.client.browser";s:74:"Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:17.0) Gecko/20100101 Firefox/17.0";s:8:"registry";O:9:"JRegistry":1:{s:7:"\0*\0data";O:8:"stdClass":2:{s:11:"application";O:8:"stdClass":1:{s:4:"lang";s:0:"";}s:15:"com_attachments";O:8:"stdClass":1:{s:11:"attachments";O:8:"stdClass":1:{s:8:"ordercol";N;}}}}s:4:"user";O:5:"JUser":25:{s:9:"\0*\0isRoot";b:0;s:2:"id";s:3:"975";s:4:"name";s:17:"Викладач1";s:8:"username";s:2:"v1";s:5:"email";s:13:"maill@mail.ru";s:8:"password";s:65:"1a3c567366830a186a0d3088a588f1f1:gy07XCOP3SJxxWRTBJNnHNCrUpOofr7d";s:14:"password_clear";s:0:"";s:8:"usertype";s:0:"";s:5:"block";s:1:"0";s:9:"sendEmail";s:1:"0";s:12:"registerDate";s:19:"2013-01-02 21:00:20";s:13:"lastvisitDate";s:19:"2013-01-13 20:06:33";s:10:"activation";s:0:"";s:6:"params";s:92:"{"admin_style":"","admin_language":"","language":"","editor":"","helpsite":"","timezone":""}";s:6:"groups";a:1:{i:9;s:1:"9";}s:5:"guest";i:0;s:13:"lastResetTime";s:19:"0000-00-00 00:00:00";s:10:"resetCount";s:1:"0";s:10:"\0*\0_params";O:9:"JRegistry":1:{s:7:"\0*\0data";O:8:"stdClass":6:{s:11:"admin_style";s:0:"";s:14:"admin_language";s:0:"";s:8:"language";s:0:"";s:6:"editor";s:0:"";s:8:"helpsite";s:0:"";s:8:"timezone";s:0:"";}}s:14:"\0*\0_authGroups";a:3:{i:0;i:1;i:1;i:6;i:2;i:9;}s:14:"\0*\0_authLevels";a:5:{i:0;i:1;i:1;i:1;i:2;i:2;i:3;i:3;i:4;i:4;}s:15:"\0*\0_authActions";N;s:12:"\0*\0_errorMsg";N;s:10:"\0*\0_errors";a:0:{}s:3:"aid";i:0;}s:13:"session.token";s:32:"4b50f8cd0bcf3cd62b7ec7d7dd796c2f";}', 975, 'v1', '');

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_template_styles`
--

CREATE TABLE IF NOT EXISTS `pc7bw_template_styles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `template` varchar(50) NOT NULL DEFAULT '',
  `client_id` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `home` char(7) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_template` (`template`),
  KEY `idx_home` (`home`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Дамп данных таблицы `pc7bw_template_styles`
--

INSERT INTO `pc7bw_template_styles` (`id`, `template`, `client_id`, `home`, `title`, `params`) VALUES
(2, 'bluestork', 1, '1', 'Bluestork - Default', '{"useRoundedCorners":"1","showSiteName":"0"}'),
(3, 'atomic', 0, '0', 'Atomic - Default', '{}'),
(4, 'beez_20', 0, '0', 'Beez2 - Default', '{"wrapperSmall":"53","wrapperLarge":"72","logo":"images\\/joomla_black.gif","sitetitle":"Joomla!","sitedescription":"Open Source Content Management","navposition":"left","templatecolor":"personal","html5":"0"}'),
(5, 'hathor', 1, '0', 'Hathor - Default', '{"showSiteName":"0","colourChoice":"","boldText":"0"}'),
(6, 'beez5', 0, '0', 'Beez5 - Default', '{"wrapperSmall":"53","wrapperLarge":"72","logo":"images\\/sampledata\\/fruitshop\\/fruits.gif","sitetitle":"Joomla!","sitedescription":"Open Source Content Management","navposition":"left","html5":"0"}'),
(7, 'pmchair', 0, '1', 'pmchair - Default', '{"wrapperSmall":"53","wrapperLarge":"72","sitetitle":"","sitedescription":"","navposition":"center","html5":"0"}');

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_updates`
--

CREATE TABLE IF NOT EXISTS `pc7bw_updates` (
  `update_id` int(11) NOT NULL AUTO_INCREMENT,
  `update_site_id` int(11) DEFAULT '0',
  `extension_id` int(11) DEFAULT '0',
  `categoryid` int(11) DEFAULT '0',
  `name` varchar(100) DEFAULT '',
  `description` text NOT NULL,
  `element` varchar(100) DEFAULT '',
  `type` varchar(20) DEFAULT '',
  `folder` varchar(20) DEFAULT '',
  `client_id` tinyint(3) DEFAULT '0',
  `version` varchar(10) DEFAULT '',
  `data` text NOT NULL,
  `detailsurl` text NOT NULL,
  `infourl` text NOT NULL,
  PRIMARY KEY (`update_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Available Updates' AUTO_INCREMENT=85 ;

--
-- Дамп данных таблицы `pc7bw_updates`
--

INSERT INTO `pc7bw_updates` (`update_id`, `update_site_id`, `extension_id`, `categoryid`, `name`, `description`, `element`, `type`, `folder`, `client_id`, `version`, `data`, `detailsurl`, `infourl`) VALUES
(1, 3, 0, 0, 'Armenian', '', 'pkg_hy-AM', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/hy-AM_details.xml', ''),
(2, 3, 0, 0, 'Danish', '', 'pkg_da-DK', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/da-DK_details.xml', ''),
(3, 3, 0, 0, 'Khmer', '', 'pkg_km-KH', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/km-KH_details.xml', ''),
(4, 3, 0, 0, 'Swedish', '', 'pkg_sv-SE', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/sv-SE_details.xml', ''),
(5, 3, 0, 0, 'Hungarian', '', 'pkg_hu-HU', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/hu-HU_details.xml', ''),
(6, 3, 0, 0, 'Bulgarian', '', 'pkg_bg-BG', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/bg-BG_details.xml', ''),
(7, 3, 0, 0, 'French', '', 'pkg_fr-FR', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/fr-FR_details.xml', ''),
(8, 3, 0, 0, 'Italian', '', 'pkg_it-IT', 'package', '', 0, '2.5.8.2', '', 'http://update.joomla.org/language/details/it-IT_details.xml', ''),
(9, 3, 0, 0, 'Spanish', '', 'pkg_es-ES', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/es-ES_details.xml', ''),
(10, 3, 0, 0, 'Dutch', '', 'pkg_nl-NL', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/nl-NL_details.xml', ''),
(11, 3, 0, 0, 'Turkish', '', 'pkg_tr-TR', 'package', '', 0, '2.5.7.2', '', 'http://update.joomla.org/language/details/tr-TR_details.xml', ''),
(12, 3, 0, 0, 'Ukrainian', '', 'pkg_uk-UA', 'package', '', 0, '2.5.7.2', '', 'http://update.joomla.org/language/details/uk-UA_details.xml', ''),
(13, 3, 0, 0, 'Indonesian', '', 'pkg_id-ID', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/id-ID_details.xml', ''),
(14, 3, 0, 0, 'Slovak', '', 'pkg_sk-SK', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/sk-SK_details.xml', ''),
(15, 3, 0, 0, 'Belarusian', '', 'pkg_be-BY', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/be-BY_details.xml', ''),
(16, 3, 0, 0, 'Latvian', '', 'pkg_lv-LV', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/lv-LV_details.xml', ''),
(17, 3, 0, 0, 'Estonian', '', 'pkg_et-EE', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/et-EE_details.xml', ''),
(18, 3, 0, 0, 'Romanian', '', 'pkg_ro-RO', 'package', '', 0, '2.5.5.3', '', 'http://update.joomla.org/language/details/ro-RO_details.xml', ''),
(19, 3, 0, 0, 'Flemish', '', 'pkg_nl-BE', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/nl-BE_details.xml', ''),
(20, 3, 0, 0, 'Macedonian', '', 'pkg_mk-MK', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/mk-MK_details.xml', ''),
(21, 3, 0, 0, 'Japanese', '', 'pkg_ja-JP', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/ja-JP_details.xml', ''),
(22, 3, 0, 0, 'Serbian Latin', '', 'pkg_sr-YU', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/sr-YU_details.xml', ''),
(23, 3, 0, 0, 'Arabic Unitag', '', 'pkg_ar-AA', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/ar-AA_details.xml', ''),
(24, 3, 0, 0, 'German', '', 'pkg_de-DE', 'package', '', 0, '2.5.8.2', '', 'http://update.joomla.org/language/details/de-DE_details.xml', ''),
(25, 3, 0, 0, 'Norwegian Bokmal', '', 'pkg_nb-NO', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/nb-NO_details.xml', ''),
(26, 3, 0, 0, 'English AU', '', 'pkg_en-AU', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/en-AU_details.xml', ''),
(27, 3, 0, 0, 'English US', '', 'pkg_en-US', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/en-US_details.xml', ''),
(28, 3, 0, 0, 'Serbian Cyrillic', '', 'pkg_sr-RS', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/sr-RS_details.xml', ''),
(29, 3, 0, 0, 'Lithuanian', '', 'pkg_lt-LT', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/lt-LT_details.xml', ''),
(30, 3, 0, 0, 'Albanian', '', 'pkg_sq-AL', 'package', '', 0, '2.5.1.5', '', 'http://update.joomla.org/language/details/sq-AL_details.xml', ''),
(31, 3, 0, 0, 'Persian', '', 'pkg_fa-IR', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/fa-IR_details.xml', ''),
(32, 3, 0, 0, 'Galician', '', 'pkg_gl-ES', 'package', '', 0, '2.5.7.4', '', 'http://update.joomla.org/language/details/gl-ES_details.xml', ''),
(33, 3, 0, 0, 'Polish', '', 'pkg_pl-PL', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/pl-PL_details.xml', ''),
(34, 3, 0, 0, 'Syriac', '', 'pkg_sy-IQ', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/sy-IQ_details.xml', ''),
(35, 3, 0, 0, 'Portuguese', '', 'pkg_pt-PT', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/pt-PT_details.xml', ''),
(36, 3, 0, 0, 'Russian', '', 'pkg_ru-RU', 'package', '', 0, '2.5.8.4', '', 'http://update.joomla.org/language/details/ru-RU_details.xml', ''),
(37, 3, 0, 0, 'Hebrew', '', 'pkg_he-IL', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/he-IL_details.xml', ''),
(38, 3, 0, 0, 'Catalan', '', 'pkg_ca-ES', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/ca-ES_details.xml', ''),
(39, 3, 0, 0, 'Laotian', '', 'pkg_lo-LA', 'package', '', 0, '2.5.6.1', '', 'http://update.joomla.org/language/details/lo-LA_details.xml', ''),
(40, 3, 0, 0, 'Afrikaans', '', 'pkg_af-ZA', 'package', '', 0, '2.5.6.2', '', 'http://update.joomla.org/language/details/af-ZA_details.xml', ''),
(41, 3, 0, 0, 'Chinese Simplified', '', 'pkg_zh-CN', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/zh-CN_details.xml', ''),
(42, 3, 0, 0, 'Greek', '', 'pkg_el-GR', 'package', '', 0, '2.5.6.1', '', 'http://update.joomla.org/language/details/el-GR_details.xml', ''),
(43, 3, 0, 0, 'Esperanto', '', 'pkg_eo-XX', 'package', '', 0, '2.5.6.1', '', 'http://update.joomla.org/language/details/eo-XX_details.xml', ''),
(44, 3, 0, 0, 'Finnish', '', 'pkg_fi-FI', 'package', '', 0, '2.5.8.2', '', 'http://update.joomla.org/language/details/fi-FI_details.xml', ''),
(45, 3, 0, 0, 'Portuguese Brazil', '', 'pkg_pt-BR', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/pt-BR_details.xml', ''),
(46, 3, 0, 0, 'Chinese Traditional', '', 'pkg_zh-TW', 'package', '', 0, '2.5.7.2', '', 'http://update.joomla.org/language/details/zh-TW_details.xml', ''),
(47, 3, 0, 0, 'Vietnamese', '', 'pkg_vi-VN', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/vi-VN_details.xml', ''),
(48, 3, 0, 0, 'Kurdish Sorani', '', 'pkg_ckb-IQ', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/ckb-IQ_details.xml', ''),
(49, 3, 0, 0, 'Bosnian', '', 'pkg_bs-BA', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/bs-BA_details.xml', ''),
(50, 3, 0, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/hr-HR_details.xml', ''),
(51, 3, 0, 0, 'Azeri', '', 'pkg_az-AZ', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/az-AZ_details.xml', ''),
(52, 3, 0, 0, 'Norwegian Nynorsk', '', 'pkg_nn-NO', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/nn-NO_details.xml', ''),
(53, 3, 0, 0, 'Tamil India', '', 'pkg_ta-IN', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/ta-IN_details.xml', ''),
(54, 3, 0, 0, 'Scottish Gaelic', '', 'pkg_gd-GB', 'package', '', 0, '2.5.7.1', '', 'http://update.joomla.org/language/details/gd-GB_details.xml', ''),
(55, 3, 0, 0, 'Thai', '', 'pkg_th-TH', 'package', '', 0, '2.5.8.1', '', 'http://update.joomla.org/language/details/th-TH_details.xml', ''),
(56, 3, 0, 0, 'Basque', '', 'pkg_eu-ES', 'package', '', 0, '1.7.0.1', '', 'http://update.joomla.org/language/details/eu-ES_details.xml', ''),
(57, 3, 0, 0, 'Uyghur', '', 'pkg_ug-CN', 'package', '', 0, '2.5.7.2', '', 'http://update.joomla.org/language/details/ug-CN_details.xml', ''),
(58, 3, 0, 0, 'Korean', '', 'pkg_ko-KR', 'package', '', 0, '2.5.7.2', '', 'http://update.joomla.org/language/details/ko-KR_details.xml', ''),
(59, 3, 0, 0, 'Hindi', '', 'pkg_hi-IN', 'package', '', 0, '2.5.6.1', '', 'http://update.joomla.org/language/details/hi-IN_details.xml', ''),
(60, 3, 0, 0, 'Welsh', '', 'pkg_cy-GB', 'package', '', 0, '2.5.6.1', '', 'http://update.joomla.org/language/details/cy-GB_details.xml', ''),
(61, 3, 0, 0, 'Swahili', '', 'pkg_sw-KE', 'package', '', 0, '2.5.8.3', '', 'http://update.joomla.org/language/details/sw-KE_details.xml', ''),
(62, 4, 0, 0, 'Sourcerer', '', 'sourcerer', 'plugin', 'system', 1, '4.1.0FREE', '', 'http://download.nonumber.nl/updates.php?e=sourcerer&/extension.xml', 'http://www.nonumber.nl/extensions/sourcerer#download'),
(63, 4, 0, 0, 'Sourcerer', '', 'sourcerer', 'plugin', 'system', 1, '4.1.0FREE', '', 'http://download.nonumber.nl/updates.php?e=sourcerer&/extension.xml', 'http://www.nonumber.nl/extensions/sourcerer#download'),
(64, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', ''),
(65, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', ''),
(66, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', ''),
(67, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', ''),
(68, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', ''),
(69, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', ''),
(70, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', ''),
(71, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', ''),
(72, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', ''),
(73, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', ''),
(74, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', ''),
(75, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', ''),
(76, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', ''),
(77, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', ''),
(78, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', ''),
(79, 4, 0, 0, 'Sourcerer', '', 'sourcerer', 'plugin', 'system', 1, '4.1.1FREE', '', 'http://download.nonumber.nl/updates.php?e=sourcerer&/extension.xml', 'http://www.nonumber.nl/extensions/sourcerer#download'),
(80, 4, 0, 0, 'Sourcerer', '', 'sourcerer', 'plugin', 'system', 1, '4.1.1FREE', '', 'http://download.nonumber.nl/updates.php?e=sourcerer&/extension.xml', 'http://www.nonumber.nl/extensions/sourcerer#download'),
(81, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', ''),
(82, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', ''),
(83, 4, 0, 0, 'Sourcerer', '', 'sourcerer', 'plugin', 'system', 1, '4.1.1FREE', '', 'http://download.nonumber.nl/updates.php?e=sourcerer&/extension.xml', 'http://www.nonumber.nl/extensions/sourcerer#download'),
(84, 5, 0, 0, 'Українська локалізація Joomla!', '<div style=""><img src="http://joomla-ua.org/update/lang/uk-ua.png" align="right" border="0" style="float: right; padding-left: 5px;" width="140" /><h2 style="padding: 0 0 8px 0; margin: 0; font-weight: normal;">Український пакет локалізації Joomla!</h2><strong style="color: green;">Оновлення до версії 2.5.7.3 від 11.10.2012 готове для встановлення!</strong><div style="background: #fff; width: 57%; border: 1px solid #ccc; padding: 9px; margin: 6px 0;">Зробіть пожертвування для розвитку української локалізації:<br /><br /><strong>WebMoney:</strong> Z162084860012 або R371967759323</div><span style="font-size: 85%;">2009-2013 &copy; Joomla! Україна. Всі права захищено!</span></div>', 'pkg_uk-UA', 'package', '', 0, '2.5.7.3', '', 'http://joomla-ua.org/update/lang/joomla/update-2.5.7.3.xml', '');

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_update_categories`
--

CREATE TABLE IF NOT EXISTS `pc7bw_update_categories` (
  `categoryid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT '',
  `description` text NOT NULL,
  `parent` int(11) DEFAULT '0',
  `updatesite` int(11) DEFAULT '0',
  PRIMARY KEY (`categoryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Update Categories' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_update_sites`
--

CREATE TABLE IF NOT EXISTS `pc7bw_update_sites` (
  `update_site_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '',
  `type` varchar(20) DEFAULT '',
  `location` text NOT NULL,
  `enabled` int(11) DEFAULT '0',
  `last_check_timestamp` bigint(20) DEFAULT '0',
  PRIMARY KEY (`update_site_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Update Sites' AUTO_INCREMENT=10 ;

--
-- Дамп данных таблицы `pc7bw_update_sites`
--

INSERT INTO `pc7bw_update_sites` (`update_site_id`, `name`, `type`, `location`, `enabled`, `last_check_timestamp`) VALUES
(1, 'Joomla Core', 'collection', 'http://update.joomla.org/core/list.xml', 1, 1358100691),
(2, 'Joomla Extension Directory', 'collection', 'http://update.joomla.org/jed/list.xml', 1, 1358100691),
(3, 'Accredited Joomla! Translations', 'collection', 'http://update.joomla.org/language/translationlist.xml', 1, 1358100691),
(4, 'Sourcerer', 'extension', 'http://download.nonumber.nl/updates.php?e=sourcerer&', 1, 1358100691),
(5, 'Ukrainian language (uk-UA)', 'collection', 'http://joomla-ua.org/update/lang/joomla25.xml', 1, 1358100691),
(6, 'Attachments Updates', 'extension', 'http://jmcameron.net/attachments/updates/updates.xml', 1, 1358100691),
(9, 'Attachments Ukrainian (uk-UA) Language Pack Updates', 'extension', 'http://jmcameron.net/attachments/updates/translations/Ukrainian-uk-UA/updates.xml', 1, 1358100691);

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_update_sites_extensions`
--

CREATE TABLE IF NOT EXISTS `pc7bw_update_sites_extensions` (
  `update_site_id` int(11) NOT NULL DEFAULT '0',
  `extension_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`update_site_id`,`extension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Links extensions to update sites';

--
-- Дамп данных таблицы `pc7bw_update_sites_extensions`
--

INSERT INTO `pc7bw_update_sites_extensions` (`update_site_id`, `extension_id`) VALUES
(1, 700),
(2, 700),
(3, 600),
(3, 10010),
(4, 10002),
(4, 10003),
(5, 10010),
(6, 10019),
(9, 10022);

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_usergroups`
--

CREATE TABLE IF NOT EXISTS `pc7bw_usergroups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Adjacency List Reference Id',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `title` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_usergroup_parent_title_lookup` (`parent_id`,`title`),
  KEY `idx_usergroup_title_lookup` (`title`),
  KEY `idx_usergroup_adjacency_lookup` (`parent_id`),
  KEY `idx_usergroup_nested_set_lookup` (`lft`,`rgt`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Дамп данных таблицы `pc7bw_usergroups`
--

INSERT INTO `pc7bw_usergroups` (`id`, `parent_id`, `lft`, `rgt`, `title`) VALUES
(1, 0, 1, 18, 'Public'),
(2, 1, 8, 15, 'Registered'),
(3, 2, 9, 14, 'Author'),
(4, 3, 10, 13, 'Editor'),
(5, 4, 11, 12, 'Publisher'),
(6, 1, 2, 7, 'Manager'),
(7, 6, 3, 4, 'Administrator'),
(8, 1, 16, 17, 'Super Users'),
(9, 6, 5, 6, 'Викладачі');

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_users`
--

CREATE TABLE IF NOT EXISTS `pc7bw_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(150) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `usertype` varchar(25) NOT NULL DEFAULT '',
  `block` tinyint(4) NOT NULL DEFAULT '0',
  `sendEmail` tinyint(4) DEFAULT '0',
  `registerDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `lastvisitDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `activation` varchar(100) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  `lastResetTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date of last password reset',
  `resetCount` int(11) NOT NULL DEFAULT '0' COMMENT 'Count of password resets since lastResetTime',
  PRIMARY KEY (`id`),
  KEY `usertype` (`usertype`),
  KEY `idx_name` (`name`),
  KEY `idx_block` (`block`),
  KEY `username` (`username`),
  KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=983 ;

--
-- Дамп данных таблицы `pc7bw_users`
--

INSERT INTO `pc7bw_users` (`id`, `name`, `username`, `email`, `password`, `usertype`, `block`, `sendEmail`, `registerDate`, `lastvisitDate`, `activation`, `params`, `lastResetTime`, `resetCount`) VALUES
(974, 'Super User', 'admin', 'mail@mail.ru', '9d037711a4be0d61350b5ef4ddab8090:ee52GNukjjmEJFmp56GRkEBDqXqGHwai', 'deprecated', 0, 1, '2012-12-24 11:29:18', '2013-01-13 20:44:50', '0', '', '0000-00-00 00:00:00', 0),
(975, 'Викладач1', 'v1', 'maill@mail.ru', '1a3c567366830a186a0d3088a588f1f1:gy07XCOP3SJxxWRTBJNnHNCrUpOofr7d', '', 0, 0, '2013-01-02 21:00:20', '2013-01-13 20:45:05', '', '{"admin_style":"","admin_language":"","language":"","editor":"","helpsite":"","timezone":""}', '0000-00-00 00:00:00', 0),
(977, 'Викладач2', 'v2', 'maaailll@mail.ru', '4bc4115b1d56f9277c023bf3963b0332:hprsDLHklg0ED0zCm29JlRNHIuBapzup', '', 0, 0, '2013-01-03 12:25:53', '0000-00-00 00:00:00', '', '{"admin_style":"","admin_language":"","language":"","editor":"","helpsite":"","timezone":""}', '0000-00-00 00:00:00', 0),
(982, 'Викладач3', 'v3', 'vaaadik@mail.ru', 'd05dbd62b859fbb93472bb370ad31ccf:5n347BzuwGhNuXqIBjJ5v5XOlOp047dw', '', 0, 0, '2013-01-04 21:56:10', '0000-00-00 00:00:00', '', '{"admin_style":"","admin_language":"","language":"","editor":"","helpsite":"","timezone":""}', '0000-00-00 00:00:00', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_user_notes`
--

CREATE TABLE IF NOT EXISTS `pc7bw_user_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(100) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_user_id` int(10) unsigned NOT NULL,
  `modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `review_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_category_id` (`catid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_user_profiles`
--

CREATE TABLE IF NOT EXISTS `pc7bw_user_profiles` (
  `user_id` int(11) NOT NULL,
  `profile_key` varchar(100) NOT NULL,
  `profile_value` varchar(255) NOT NULL,
  `ordering` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `idx_user_id_profile_key` (`user_id`,`profile_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Simple user profile storage table';

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_user_usergroup_map`
--

CREATE TABLE IF NOT EXISTS `pc7bw_user_usergroup_map` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Foreign Key to #__users.id',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Foreign Key to #__usergroups.id',
  PRIMARY KEY (`user_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pc7bw_user_usergroup_map`
--

INSERT INTO `pc7bw_user_usergroup_map` (`user_id`, `group_id`) VALUES
(974, 8),
(975, 9),
(977, 9),
(982, 9);

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_viewlevels`
--

CREATE TABLE IF NOT EXISTS `pc7bw_viewlevels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `title` varchar(100) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `rules` varchar(5120) NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_assetgroup_title_lookup` (`title`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `pc7bw_viewlevels`
--

INSERT INTO `pc7bw_viewlevels` (`id`, `title`, `ordering`, `rules`) VALUES
(1, 'Public', 0, '[1,8]'),
(2, 'Registered', 1, '[6,2,8]'),
(3, 'Special', 2, '[6,3,8]'),
(4, 'Для викладачів', 0, '[9]');

-- --------------------------------------------------------

--
-- Структура таблицы `pc7bw_weblinks`
--

CREATE TABLE IF NOT EXISTS `pc7bw_weblinks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `catid` int(11) NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL DEFAULT '0',
  `title` varchar(250) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `url` varchar(250) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `hits` int(11) NOT NULL DEFAULT '0',
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(11) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `approved` tinyint(1) NOT NULL DEFAULT '1',
  `access` int(11) NOT NULL DEFAULT '1',
  `params` text NOT NULL,
  `language` char(7) NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `metadata` text NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Set if link is featured.',
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
