<?php


defined('_JEXEC') or die;
?>

    <?php foreach ($list as $item) :  ?>
    <div>
	<?php if($item->state==1):?>
	        <h3>
	            <a href="<?php echo $item->link; ?>">
	            <?php echo $item->title; ?></a>
        	</h3>
	<?php endif;?>
    </div>
    <?php endforeach; ?>
