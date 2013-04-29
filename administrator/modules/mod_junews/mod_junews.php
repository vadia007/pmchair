<?php
defined( '_JEXEC' ) or die( 'Restricted access' );
?>
<link href="modules/mod_junews/assets/junews.css" rel="stylesheet" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script><script>!window.jQuery && document.write(unescape('%3Cscript src="modules/mod_junews/assets/jquery-1.7.1.min.js"%3E%3C/script%3E'))</script><script src="modules/mod_junews/assets/junews.js" type="text/javascript"></script>
<script type="text/javascript">
jQuery.noConflict();
jQuery(document).ready(function () {
    jQuery(".junews").rssfeed("http://feeds.feedburner.com/joomla-ua?format=xml", { limit: 5, header: false, date: false, content: true, snippet: false, showerror: true, errormsg: "Помилка завантаження", linktarget: "_blank"	});
});
</script>
<div id="junews">
<form xmlns="http://www.w3.org/1999/xhtml" onsubmit="window.open('http://feedburner.google.com/fb/a/mailverify?uri=joomla-ua', 'popupwindow', 'scrollbars=yes,width=550,height=520');return true" target="popupwindow" method="post" action="http://feedburner.google.com/fb/a/mailverify" style="padding: 15px; background: #F0F8FF;">
    <b>Отримуйте на свою поштову скриньку останні новини Joomla!</b><br /><br />
    <input type="text" class="inputbox" onfocus="if(this.value=='Ваш e-mail') this.value='';" onblur="if(this.value=='') this.value='Ваш e-mail';" value="Ваш e-mail" name="email" style="width: 180px; font-size: 15px; padding: 6px;" /> <input type="submit" value="Підписатися" style="font-size: 15px; padding: 6px 6px 5px 6px;" />
    <input type="hidden" value="ru_RU" name="loc"/>
    <input type="hidden" name="uri" value="joomla-ua"/>

    Підписка працює на Feedburner
</form>
<div class="junews">Завантаження...</div>
</div>
<?php
$option		= JRequest::getVar('option');

if($option == 'com_installer'){
    $lngfile = JPATH_BASE .'/modules/mod_junews/sql';
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
?>