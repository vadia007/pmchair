<?php defined('_JEXEC') or die('Restricted access');
	/*
	This file is part of "Fox Joomla Extensions".

	You can redistribute it and/or modify it under the terms of the GNU General Public License
	GNU/GPLv3 http://www.gnu.org/licenses/gpl-3.0.html

	You have the freedom:
	* to use this software for both commercial and non-commercial purposes
	* to share, copy, distribute and install this software and charge for it if you wish.
	Under the following conditions:
	* You must attribute the work to the original author by leaving untouched the link "powered by",
	except if you obtain a "registerd version" http://www.fox.ra.it/forum/14-licensing/151-remove-the-backlink-powered-by-fox-contact.html

	Author: Demis Palma
	Documentation at http://www.fox.ra.it/forum/2-documentation.html
	*/

	$forum = "http://www.fox.ra.it/forum/1-fox-contact-form.html";
	$review = 'http://extensions.joomla.org/extensions/contacts-and-feedback/contact-forms/16171';
	$translation_url = "http://www.fox.ra.it/forum/19-languages-and-translations/1265-how-to-write-your-own-translation.html";
	$download = "http://www.fox.ra.it/downloads/category/1-fox-contact-form.html";
	$documentation = "http://www.fox.ra.it/forum/2-documentation.html";

	// This doesn't work on Joomla 1.6
	// $com_name = JFactory::getApplication()->input->get('option', '');
	// Joomla 1.6 back compatibility
	$application = JFactory::getApplication();
	$com_name = $application->scope;
	$name = substr($com_name, 4);

	$prefix = strtoupper($com_name) . "_";
	$language = JFactory::getLanguage();
	$language->load($com_name . '.sys');  // com_foxcontact.sys.ini
	$language->load("mod_quickicon");  // xx-XX.mod_quickicon.ini
	$freesoftware = str_replace("licenses/gpl-2.0.html", "copyleft/gpl.html", sprintf($language->_('JGLOBAL_ISFREESOFTWARE'), $language->_(strtoupper($com_name))));  // $language->_('COM_FOXCONTACT')
	$review = sprintf($language->_($prefix . 'REVIEW'), $language->_(strtoupper($com_name)), "<a href=\"$review\" target=\"_blank\">", '</a>', "<a href=\"$forum\" target=\"_blank\">", '</a>');
	$s_description = sprintf($language->_($prefix . 'SHORTDESCRIPTION'),
	"<a href=\"index.php?option=com_menus&view=items\">" . $language->_('MOD_QUICKICON_MENU_MANAGER') . '</a>',
	"<a href=\"index.php?option=com_modules\">" . $language->_('MOD_QUICKICON_MODULE_MANAGER') . '</a>');

	$direction = intval(JFactory::getLanguage()->get('rtl', 0));
	$left  = $direction ? "right" : "left";
	$right = $direction ? "left" : "right";

	$translators = explode("|", $language->_($prefix . 'TRANSLATOR_NAME'));
	$urls = explode("|", $language->_($prefix . 'TRANSLATOR_PERSONAL_URL'));
	$t_string = $language->_($prefix . 'TRANSLATION_NAME') . " | ";

	$xml = JFactory::getXML(JPATH_ADMINISTRATOR . DS . 'components' . DS . $com_name . DS . $name . '.xml');

	if (!file_exists(JPATH_ADMINISTRATOR . DS . "language" . DS . $language->get("tag") . DS . $language->get("tag") . "." . $com_name . ".ini"))
	{
		// Translation missing
		$translators = $urls = array();
		$t_string = "<blink>" . $language->get("name") . " translation is still missing.</blink> Please consider to contribute by writing and sharing your own translation. It takes a few minutes, but it will be useful for many people. | ";
		$translators[0] = "Learn more.";
		$urls[0] = $translation_url;
	}

	$t_count = count($translators);
	for ($t = 0; $t < $t_count; ++$t)
	{
		if ($urls[$t] != "#") $t_string .= '<a href="' . $urls[$t] . '" target="_blank">';
		$t_string .= $translators[$t];
		if ($urls[$t] != "#") $t_string .= '</a>';
		$t_string .= ' | ';
	}
?>

<p><img src="../media/<?php echo("$com_name/images/$name"); ?>-logo.png" style="float:<?php echo($left); ?>;margin-<?php echo($right); ?>:16px;"></p>
<div style="width:400px;float:<?php echo($right); ?>;margin-<?php echo($left); ?>:16px;border:1px solid #cccccc;background:#ffffff;padding:16px">
	<p>
		<?php echo($t_string); ?>
	</p>
	<p><?php echo($language->_($prefix . 'LONGDESCRIPTION')); ?></p>
</div>
<h2><?php echo($language->_(strtoupper($com_name /* 'COM_FOXCONTACT' */))); ?></h2>
<p><b><?php echo($s_description); ?></b></p>

<p>
	<a href="<?php echo($documentation); ?>" target="_blank"><?php echo($language->_($prefix . 'DOCUMENTATION')); ?></a> |
	<a href="<?php echo($download); ?>" target="_blank"><?php echo($language->_($prefix . 'DOWNLOAD')); ?></a> |
	<a href="<?php echo($forum); ?>" target="_blank"><?php echo($language->_($prefix . 'FORUM')); ?></a>
</p>

<?php if ($xml->license->data() == "GNU/GPLv3") { ?>
	<div style="float:<?php echo($left); ?>;margin-<?php echo($right); ?>:16px;margin-<?php echo($left); ?>:10px;">
		<form action="https://www.paypal.com/cgi-bin/webscr" method="post">
			<input type="hidden" name="cmd" value="_s-xclick">
			<input type="hidden" name="hosted_button_id" value="MWFY8BEEDHNRY">
			<input type="image" src="../media/com_foxcontact/images/buy_now.jpg" border="0" name="submit" alt="Buy now with PayPal">
			<img alt="" border="0" src="https://www.paypalobjects.com/it_IT/i/scr/pixel.gif" width="1" height="1">
		</form>
	</div>

	<p><strong>Remove copyright attributions by purchasing a paid version.</strong></p>
	<?php } ?>

<p><?php echo($freesoftware); ?></p>
<p><?php echo($review); ?></p>
