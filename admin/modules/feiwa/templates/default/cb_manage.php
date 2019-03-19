<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <div class="subject">
        <h3>跨境设置</h3>
        <h5>跨境相关基础信息及功能设置选项</h5>
      </div>
    </div>
  </div>
  <form id="add_form" method="post" enctype="multipart/form-data" action="index.php?app=cb_manage&feiwa=cb_manage_save">
    <div class="ncap-form-default">
      <dl class="row">
        <dt class="tit">
          <label for="cb_isuse"><?php echo $lang['cb_isuse'];?></label>
        </dt>
        <dd class="opt">
          <div class="onoff">
            <label for="cb_isuse_1" class="cb-enable <?php if($output['setting']['cb_isuse'] == '1'){ ?>selected<?php } ?>" title="<?php echo $lang['sys_open'];?>"><?php echo $lang['sys_open'];?></label>
            <label for="cb_isuse_0" class="cb-disable <?php if($output['setting']['cb_isuse'] == '0'){ ?>selected<?php } ?>" title="<?php echo $lang['sys_close'];?>"><?php echo $lang['sys_close'];?></label>
            <input type="radio" id="cb_isuse_1" name="cb_isuse" value="1" <?php echo $output['setting']['cb_isuse']==1?'checked=checked':''; ?>>
            <input type="radio" id="cb_isuse_0" name="cb_isuse" value="0" <?php echo $output['setting']['cb_isuse']==0?'checked=checked':''; ?>>
          </div>
          <p class="notic"><?php echo $lang['cb_isuse_explain'];?></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="class_image">跨境LOGO</label>
        </dt>
        <dd class="opt">
          <div class="input-file-show"><span class="show">
            <?php if(empty($output['setting']['cb_logo'])) { ?>
            <a class="nyroModal" rel="gal" href="<?php echo UPLOAD_SITE_URL.DS.ATTACH_CB.DS.'cb_default_logo.png';?>"> <i class="fa fa-picture-o" onMouseOver="toolTip('<img src=<?php echo UPLOAD_SITE_URL.DS.ATTACH_CB.DS.'cb_default_logo.png';?>>')" onMouseOut="toolTip()"></i></a>
            <?php } else { ?>
            <a class="nyroModal" rel="gal" href="<?php echo UPLOAD_SITE_URL.DS.ATTACH_CB.DS.$output['setting']['cb_logo'];?>"> <i class="fa fa-picture-o" onMouseOver="toolTip('<img src=<?php echo UPLOAD_SITE_URL.DS.ATTACH_CB.DS.$output['setting']['cb_logo'];?>>')" onMouseOut="toolTip()"></i> </a>
            <?php } ?>
            </span><span class="type-file-box">
            <input class="type-file-file" id="cb_logo" name="cb_logo" type="file" size="30" hidefocus="true" feiwa_type="cb_image" title="点击前方预览图可查看大图，点击按钮选择文件并提交表单后上传生效">
            </span></div>
          <p class="notic"><?php echo $lang['cb_logo_explain'];?></p>
        </dd>
      </dl>
    
      <dl class="row">
        <dt class="tit">
          <label for="cb_seo_title"><?php echo $lang['cb_seo_title'];?></label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['setting']['cb_seo_title'];?>" name="cb_seo_title" class="input-txt">
          <span class="err"></span>
          <p class="notic"></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="cb_seo_keywords"><?php echo $lang['cb_seo_keywords'];?></label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['setting']['cb_seo_key'];?>" name="cb_seo_keywords" class="input-txt">
          <span class="err"></span>
          <p class="notic"></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="cb_seo_description"><?php echo $lang['cb_seo_description'];?></label>
        </dt>
        <dd class="opt">
          <textarea name="cb_seo_description" class="tarea" rows="6"><?php echo $output['setting']['cb_seo_dis'];?></textarea>
          <span class="err"></span>
          <p class="notic"></p>
        </dd>
      </dl>
      <div class="bot"><a id="submit" href="javascript:void(0)" class="ncap-btn-big ncap-btn-green"><?php echo $lang['sys_submit'];?></a></div>
    </div>
  </form>
</div>
<script type="text/javascript" src="<?php echo ADMIN_RESOURCE_URL;?>/js/jquery.nyroModal.js"></script>

<script type="text/javascript">
$(document).ready(function(){

    //文件上传
    var textButton1="<input type='text' name='textfield' id='textfield1' class='type-file-text' /><input type='button' name='button' id='button1' value='选择上传...' class='type-file-button' />";
    $(textButton1).insertBefore("#cb_logo");
    $("#cb_store_banner").change(function(){
        $("#textfield3").val($("#cb_logo").val());
    });
    $("input[feiwa_type='cb_image']").live("change", function(){
        var src = getFullPath($(this)[0]);
        $(this).parent().prev().find('.low_source').attr('src',src);
        $(this).parent().find('input[class="type-file-text"]').val($(this).val());
    });

    $("input[feiwa_type='cb_image']").live("change", function(){
        var src = getFullPath($(this)[0]);
        $(this).parent().prev().find('.low_source').attr('src',src);
        $(this).parent().find('input[class="type-file-text"]').val($(this).val());
    });

    $("#submit").click(function(){
        $("#add_form").submit();
    });
	// 点击查看图片
	$('.nyroModal').nyroModal();
});
</script> 
