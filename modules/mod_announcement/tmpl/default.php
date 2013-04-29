<?php

defined('_JEXEC') or die;

?>
<div class="announcements_wrapper">
    <ul class="announcement">
<?php foreach ($list as $item) :  ?>
    <?php if($item->state==1):?>
        <li>
        <h3><?php echo $item->title;?></h3>
        <p><?php echo $item->introtext;?></p>
    </li>
    <?php endif;?>
    <?php endforeach; ?>
    </ul>
</div>
