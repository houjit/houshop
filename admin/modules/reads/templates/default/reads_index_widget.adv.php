<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="reads-index-module-adv1">
  <ul id="adv_content" nctype="object_module_edit">
    <?php echo html_entity_decode($module_content['adv_content']);?>
  </ul>
  <?php if($output['edit_flag']) { ?>
  <div class="reads-index-module-handle"><a nctype="btn_module_image_edit" href="JavaScript:void(0);" image_count="1" class="tip-r" data-title="<?php echo $lang['reads_index_module_adv_edit_title'];?>" title="<?php echo $lang['reads_index_module_adv_edit_title'];?>"><?php echo $lang['reads_index_module_adv_edit'];?></a></div>
  <?php } ?>
</div>
