<?php


defined('_JEXEC') or die;
?>
  <div class="bottom_ul ">
<div class="container_12">
<ul class="grid_12">
    <?php foreach ($list as $item) :  ?>
 <?php if($item->state==1):?>
<li>
            <a href="<?php echo $item->link; ?>">
            <?php echo $item->title; ?><?php {echo ' »';} ?></a>
        </li>
<?php endif;?>
    <?php endforeach; ?>
	</ul>
    </div>
</div>


