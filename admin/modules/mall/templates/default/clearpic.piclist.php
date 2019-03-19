<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <div class="subject">
        <h3>无效图片清理</h3>
        <h5>以下列出是无效图片</h5>
      </div>
    </div>
  </div>
  <form method='post' id="form_pic">
    <input type="hidden" name="form_submit" value="ok" />
    <?php if(!empty($output['pic_list'])){ ?>
    <ul class="ncap-thumb-list">
      <?php foreach($output['pic_list'] as $key=> $val){?>
      <li class="picture">
        <input class="checkitem" type="checkbox" name="id[]" value="<?php echo $key;?>" />
        <div class="thumb-list-pics"> <a nctype="nyroModal" href="<?php echo str_ireplace(BASE_UPLOAD_PATH, UPLOAD_SITE_URL, $val);?>" rel="gal"> <img src="<?php echo str_ireplace(BASE_UPLOAD_PATH, UPLOAD_SITE_URL, $val);?>"> </a> </div>
      </li>
      <?php } ?>
    </ul>
    <?php }else { ?>
    <div class="no-data"><i class="fa fa-exclamation-circle"></i><?php echo $lang['sys_no_record']; ?>
      <?php } ?>
    </div>
    <div class="bot">
      <input id="checkallBottom" class="checkall" type="checkbox" />
      <label for="checkallBottom"><?php echo $lang['sys_select_all'];?></label>
      <a class="ncap-btn-mini ncap-btn-red" href="javascript:void(0);" onclick="if(confirm('<?php echo $lang['sys_ensure_del'];?>')){$('#form_pic').submit();}"><span><?php echo $lang['sys_del'];?></span></a>
      <div class="pagination"><?php echo $output['showpage'];?> </div>
    </div>
  </form>
</div>
<script type="text/javascript" src="<?php echo ADMIN_RESOURCE_URL;?>/js/jquery.nyroModal.js"></script> 
<script>
$(function(){
	$('a[nctype="nyroModal"]').nyroModal();
	
});
</script> 
