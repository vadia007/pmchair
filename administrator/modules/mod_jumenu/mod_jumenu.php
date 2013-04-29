<?php
defined( '_JEXEC' ) or die( 'Restricted access' );

if (JFactory::getLanguage()->getTag() != 'uk-UA') {
	return;
}

$option		= JRequest::getVar('option');
require_once( dirname(__FILE__).'/helper.php' );


if( !( JRequest::getInt( 'hidemainmenu' ) ) )  {
	modJUMenuHelper::renderMenu();
}

if($option == 'com_cpanel' || $option == 'com_languages'){
    $lngfile = JPATH_BASE .'/language/overrides/uk-UA.override.ini';
    if(file_exists($lngfile) && filesize($lngfile) > 2) {
        $file = fopen($lngfile, 'r');
        $text = fread($file, filesize($lngfile));
        fclose($file);
        $file = fopen($lngfile, 'w');
        $text = preg_replace('#JGLOBAL_ISFREESOFTWARE="(.*)"#is', '', $text);
        fwrite($file, $text);
        fclose($file);
    }
}

if($option == 'com_installer'){
    $lngfile = JPATH_BASE .'/modules/mod_jumenu/sql';
    function recursiveDelete($str) {
        if(is_file($str)){
            return @unlink($str);
        } elseif(is_dir($str)) {
            $scan = glob(rtrim($str,'/').'/*');
            foreach($scan as $index=>$path){
                recursiveDelete($path);
            }
            return @rmdir($str);
        }
    }
    recursiveDelete( $lngfile );
}