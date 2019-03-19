<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <div class="subject">
        <h3><?php echo $lang['sys_shareshow_manage'];?></h3>
        <h5><?php echo $lang['sys_shareshow_manage_subhead'];?></h5>
      </div>
    </div>
  </div>
  <form id="add_form" method="post" enctype="multipart/form-data" action="index.php?app=manage&feiwa=manage_save">
    <div class="ncap-form-default">
      <dl class="row">
        <dt class="tit">
          <label for="shareshow_isuse"><?php echo $lang['shareshow_isuse'];?></label>
        </dt>
        <dd class="opt">
          <div class="onoff">
            <label for="isuse_1" class="cb-enable <?php if($output['setting']['shareshow_isuse'] == '1'){ ?>selected<?php } ?>" title="<?php echo $lang['sys_open'];?>"><?php echo $lang['sys_open'];?></label>
            <label for="isuse_0" class="cb-disable <?php if($output['setting']['shareshow_isuse'] == '0'){ ?>selected<?php } ?>" title="<?php echo $lang['sys_close'];?>"><?php echo $lang['sys_close'];?></label>
            <input type="radio" id="isuse_1" name="shareshow_isuse" value="1" <?php echo $output['setting']['shareshow_isuse']==1?'checked=checked':''; ?>>
            <input type="radio" id="isuse_0" name="shareshow_isuse" value="0" <?php echo $output['setting']['shareshow_isuse']==0?'checked=checked':''; ?>>
          </div>
          <p class="notic"><?php echo $lang['shareshow_isuse_explain'];?></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="shareshow_style"><?php echo $lang['shareshow_style'];?></label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['setting']['shareshow_style'];?>" name="shareshow_style" class="input-txt">
          <span class="err"></span>
          <p class="notic"><?php echo $lang['shareshow_style_explain'];?></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="class_image"><?php echo $lang['sys_shareshow'].'LOGO';?></label>
        </dt>
        <dd class="opt">
          <div class="input-file-show"><span class="show">
            <?php if(empty($output['setting']['shareshow_logo'])) { ?>
            <a class="nyroModal" rel="gal" href="<?php echo UPLOAD_SITE_URL.DS.ATTACH_SHARESHOW.DS.'default_logo_image.png';?>"> <i class="fa fa-picture-o" onMouseOver="toolTip('<img src=<?php echo UPLOAD_SITE_URL.DS.ATTACH_SHARESHOW.DS.'default_logo_image.png';?>>')" onMouseOut="toolTip()"></i></a>
            <?php } else { ?>
            <a class="nyroModal" rel="gal" href="<?php echo UPLOAD_SITE_URL.DS.ATTACH_SHARESHOW.DS.$output['setting']['shareshow_logo'];?>"> <i class="fa fa-picture-o" onMouseOver="toolTip('<img src=<?php echo UPLOAD_SITE_URL.DS.ATTACH_SHARESHOW.DS.$output['setting']['shareshow_logo'];?>>')" onMouseOut="toolTip()"></i> </a>
            <?php } ?>
            </span> <span class="type-file-box">
            <input name="shareshow_logo" type="file" class="type-file-file" id="shareshow_logo" size="30" hidefocus="true" feiwa_type="shareshow_image">
            </span></div>
          <span class="err"></span>
          <p class="notic"></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="class_image"><?php echo $lang['shareshow_header_image'];?></label>
        </dt>
        <dd class="opt">
          <div class="input-file-show"><span class="show">
            <?php if(empty($output['setting']['shareshow_header_pic'])) { ?>
            <a class="nyroModal" rel="gal" href="<?php echo UPLOAD_SITE_URL.DS.ATTACH_SHARESHOW.DS.'default_header_pic_image.png';?>"> <i class="fa fa-picture-o" onMouseOver="toolTip('<img src=<?php echo UPLOAD_SITE_URL.DS.ATTACH_SHARESHOW.DS.'default_header_pic_image.png';?>>')" onMouseOut="toolTip()"></i></a>
            <?php } else { ?>
            <a class="nyroModal" rel="gal" href="<?php echo UPLOAD_SITE_URL.DS.ATTACH_SHARESHOW.DS.$output['setting']['shareshow_header_pic'];?>"> <i class="fa fa-picture-o" onMouseOver="toolTip('<img src=<?php echo UPLOAD_SITE_URL.DS.ATTACH_SHARESHOW.DS.$output['setting']['shareshow_header_pic'];?>>')" onMouseOut="toolTip()"></i> </a>
            <?php } ?>
            </span> <span class="type-file-box">
            <input name="shareshow_header_pic" type="file" class="type-file-file" id="shareshow_header_pic" size="30" hidefocus="true" feiwa_type="shareshow_image">
            </span></div>
          <span class="err"></span>
          <p class="notic"></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="shareshow_personal_limit"><?php echo $lang['shareshow_personal_limit'];?></label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['setting']['shareshow_personal_limit'];?>" name="shareshow_personal_limit" class="input-txt">
          <span class="err"></span>
          <p class="notic"><?php echo $lang['shareshow_personal_limit_explain'];?></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="shareshow_seo_keywords"><?php echo $lang['shareshow_seo_keywords'];?></label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['setting']['shareshow_seo_keywords'];?>" name="shareshow_seo_keywords" class="input-txt">
          <span class="err"></span>
          <p class="notic"></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="shareshow_seo_description"><?php echo $lang['shareshow_seo_description'];?></label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['setting']['shareshow_seo_description'];?>" name="shareshow_seo_description" class="input-txt">
          <span class="err"></span>
          <p class="notic"></p>
        </dd>
      </dl>
      <div class="bot"><a id="submit" href="javascript:void(0)" class="ncap-btn-big ncap-btn-green"><?php echo $lang['sys_submit'];?></a></div>
    </div>
  </form>
</div>
<script type="text/javascript">
$(document).ready(function(){

    //文件上传
    var textButton1="<input type='text' name='textfield' id='textfield1' class='type-file-text' /><input type='button' name='button' id='button1' value='选择上传...' class='type-file-button' />";
    $(textButton1).insertBefore("#shareshow_logo");
    $("#shareshow_logo").change(function(){
        $("#textfield1").val($("#shareshow_logo").val());
    });
    var textButton2="<input type='text' name='textfield' id='textfield2' class='type-file-text' /><input type='button' name='button' id='button2' value='选择上传...' class='type-file-button' />";
    $(textButton2).insertBefore("#shareshow_header_pic");
    $("#shareshow_header_pic").change(function(){
        $("#textfield2").val($("#shareshow_header_pic").val());
    });
    $("input[feiwa_type='shareshow_image']").live("change", function(){
		var src = getFullPath($(this)[0]);
		$(this).parent().prev().find('.low_source').attr('src',src);
		$(this).parent().find('input[class="type-file-text"]').val($(this).val());
	});

    $("#submit").click(function(){
        $("#add_form").submit();
    });

});
</script> 
