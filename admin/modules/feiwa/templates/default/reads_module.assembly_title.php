<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<!-- 标题 -->
<div class="reads-module-title">
    <h2 id="reads_module_title" nctype="object_module_edit"><?php echo "<?php echo \$module_content['reads_module_title'];?>";?></h2>
    <?php echo "<?php if(\$output['edit_flag']) { ?>";?>
    <div class="reads-index-module-handle"><a nctype="btn_module_title_edit" href="JavaScript:void(0);" class="tip-r" title="<?php echo $lang['reads_index_module_title_edit'];?>"><?php echo $lang['reads_index_module_title_edit'];?></a></div>
    <?php echo "<?php } ?>";?>
</div>

