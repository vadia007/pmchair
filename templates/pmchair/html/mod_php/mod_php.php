<?php
/*
* mod_html allows inclusion of HTML/JS/CSS and now PHP, in Joomla/Mambo Modules
* @copyright (c) Copyright: Fiji Web Design, www.fijiwebdesign.com.
* @author gabe@fijiwebdesign.com 
* @date June 17, 2008
* @package Joomla1.5
*/

// no direct access
defined('_JEXEC') or die('Restricted access');

// mod_php version
$ver = '1.0.0.Alpha1-J1.5';

// get module parameters
$php = $params->get( 'php' );
$eval_php = $params->get( 'eval_php' );
$discovery = $params->get( 'discovery' );

// remove annoying <br /> tags from module parameter
$php = str_replace('<br />', '', $php);

// show that site uses mod_php
$debug = $discovery ? JRequest::getVar('debug') : false;
if ($discovery) {
	echo "\r\n<!-- /mod_php version $ver (c) www.fijiwebdesign.com -->\r\n";
}
if ($debug == 'mod_php') {
	echo '<div style="border:1px solid red;padding:6px;">';
	echo '<div style="color:red;font-weight:bold;">Mod PHP</div>';
}

// evaluate the PHP code
if ($eval_php) {
	eval("\r\n?>\r\n ".urldecode($php)."\r\n<?php\r\n");
} else {
	echo $php;
}

// end show site uses mod_php
if ($debug == 'mod_php') {
	echo '</div>';
}
if ($discovery) {
	echo "\r\n<!-- mod_php version $ver/ -->\r\n";
}

?>