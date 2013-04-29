<?php
/**
 * @package		Joomla.Site
 * @copyright	Copyright (C) 2005 - 2012 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 */

defined('_JEXEC') or die;

?>
<?php
//get template params
$templateparams	=  JFactory::getApplication()->getTemplate(true)->params;

//get language and direction
$doc = JFactory::getDocument();
$this->language = $doc->language;
$this->direction = $doc->direction;

if(!$templateparams->get('html5', 0)): ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?php else: ?>
	<?php echo '<!DOCTYPE html>'; ?>
<?php endif; ?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php echo $this->language; ?>" lang="<?php echo $this->language; ?>" dir="<?php echo $this->direction; ?>">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="language" content="<?php echo $this->language; ?>" />

<title><?php echo $this->error->getCode(); ?> - <?php echo $this->title; ?></title>
<?php if ($this->error->getCode()>=400 && $this->error->getCode() < 500) { 	?>


</head>

<body
     <h3>Даної сторінки не існує. Перейдіть будь ласка на <a href="<?php echo JURI::base();?>">головну</a></h3>
</body>
</html>


<?php } ?>
