<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <div class="subject">
        <h3><?php echo $lang['promotion_xianshi'];?></h3>
        <h5><?php echo $lang['promotion_xianshi_subhead'];?></h5>
      </div>
            <ul class="tab-base nc-row">
        <?php   foreach($output['menu'] as $menu) {  if($menu['menu_type'] == 'text') { ?>
        <li><a href="JavaScript:void(0);" class="current"><?php echo $menu['menu_name'];?></a></li>
        <?php }  else { ?>
        <li><a href="<?php echo $menu['menu_url'];?>" ><?php echo $menu['menu_name'];?></a></li>
        <?php  } }  ?>
      </ul>
    </div>
  </div>
  <div class="explanation" id="explanation">
    <div class="title" id="checkZoom"><i class="fa fa-lightbulb-o"></i>
      <h4 title="<?php echo $lang['sys_prompts_title'];?>"><?php echo $lang['sys_prompts'];?></h4>
      <span id="explanationZoom" title="<?php echo $lang['sys_prompts_span'];?>"></span> </div>
    <ul>
      <li>淘特卖的第一张图片默认为背景大图</li>
      <li>上传图大小请严格按照输入框下方提示文字要求进行选择，过大或过小的图片会引起显示变形</li>
      <li>如该图片需要跳转到某个网址请在上传框后方输入对应链接地址。</li>
    </ul>
  </div>
  <form method="post" enctype="multipart/form-data" name="form1">
    <input type="hidden" name="form_submit" value="ok" />
    <input type="hidden" name="old_adv_pic1" value="<?php echo $output['list'][1]['pic'];?>" />
    <input type="hidden" name="old_adv_pic2" value="<?php echo $output['list'][2]['pic'];?>" />
    <input type="hidden" name="old_adv_pic3" value="<?php echo $output['list'][3]['pic'];?>" />
    <div class="ncap-form-default">
      <dl class="row">
        <dt class="tit">
          <label>淘特卖大背景图-01</label>
        </dt>
        <dd class="opt">
          <div class="input-file-show"><span class="show"><a class="nyroModal" rel="gal" href="<?php echo UPLOAD_SITE_URL.'/'.(ATTACH_LOGIN.'/'.$output['list'][1]['pic']);?>"/><i class="fa fa-picture-o" onMouseOver="toolTip('<img src=<?php echo UPLOAD_SITE_URL.'/'.(ATTACH_LOGIN.'/'.$output['list'][1]['pic']);?>>')" onMouseOut="toolTip()"></i></a></span><span class="type-file-box">
            <input name="adv_pic1" type="file" class="type-file-file" id="adv_pic1" size="30" hidefocus="true" title="点击前方预览图可查看大图，点击按钮选择文件并提交表单后上传生效"/>
            <input type='text' name='textfield' id='textfield1' class='type-file-text' />
            <input type='button' name='button' id='button1' value='选择上传...' class='type-file-button' />
            </span></div>
          <label title="<?php echo $lang['circle_setting_adv_url_address'];?>" class="ml5"><i class="fa fa-link"></i><input class="input-txt ml5" type="text" name="adv_url1" value="<?php echo $output['list'][1]['url'];?>" placeholder="请输入广告连接地址" /></label>
          <p class="notic">请使用宽度2000像素，高度1192像素的jpg/gif/png格式图片作为幻灯片banner上传，<br/>如需跳转请在后方添加以http://开头的链接地址。</p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label>淘特卖大背景左图-02</label>
        </dt>
        <dd class="opt">
          <div class="input-file-show"><span class="show"><a class="nyroModal" rel="gal" href="<?php echo UPLOAD_SITE_URL.'/'.(ATTACH_LOGIN.'/'.$output['list'][2]['pic']);?>"/><i class="fa fa-picture-o" onMouseOver="toolTip('<img src=<?php echo UPLOAD_SITE_URL.'/'.(ATTACH_LOGIN.'/'.$output['list'][2]['pic']);?>>')" onMouseOut="toolTip()"></i></a></span><span class="type-file-box">
            <input name="adv_pic2" type="file" class="type-file-file" id="adv_pic2" size="30" hidefocus="true" title="点击前方预览图可查看大图，点击按钮选择文件并提交表单后上传生效"/>
            <input type='text' name='textfield' id='textfield2' class='type-file-text' />
            <input type='button' name='button' id='button2' value='选择上传...' class='type-file-button' />
            </span></div>
         <label title="<?php echo $lang['circle_setting_adv_url_address'];?>" class="ml5"><i class="fa fa-link"></i><input class="input-txt ml5" type="text" name="adv_url2" value="<?php echo $output['list'][2]['url'];?>" placeholder="请输入广告连接地址" /></label>
          <p class="notic">请使用宽度590像素，高度240像素的jpg/gif/png格式图片作为幻灯片banner上传，<br/>如需跳转请在后方添加以http://开头的链接地址。</p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label>淘特卖大背景右图-03</label>
        </dt>
        <dd class="opt">
          <div class="input-file-show"><span class="show"><a class="nyroModal" rel="gal" href="<?php echo UPLOAD_SITE_URL.'/'.(ATTACH_LOGIN.'/'.$output['list'][3]['pic']);?>"/><i class="fa fa-picture-o" onMouseOver="toolTip('<img src=<?php echo UPLOAD_SITE_URL.'/'.(ATTACH_LOGIN.'/'.$output['list'][3]['pic']);?>>')" onMouseOut="toolTip()"></i></a></span><span class="type-file-box">
            <input name="adv_pic3" type="file" class="type-file-file" id="adv_pic3" size="30" hidefocus="true" title="点击前方预览图可查看大图，点击按钮选择文件并提交表单后上传生效"/>
            <input type='text' name='textfield' id='textfield3' class='type-file-text' />
            <input type='button' name='button' id='button3' value='选择上传...' class='type-file-button' />
            </span></div>
          <label title="<?php echo $lang['circle_setting_adv_url_address'];?>" class="ml5"><i class="fa fa-link"></i><input class="input-txt ml5" type="text" name="adv_url3" value="<?php echo $output['list'][3]['url'];?>" placeholder="请输入广告连接地址" /></label>
          <p class="notic">请使用宽度590像素，高度240像素的jpg/gif/png格式图片作为幻灯片banner上传，<br/>如需跳转请在后方添加以http://开头的链接地址。</p>
        </dd>
      </dl>

      <div class="bot"><a href="JavaScript:void(0);" class="ncap-btn-big ncap-btn-green" onclick="document.form1.submit()"><?php echo $lang['sys_submit'];?></a></div>
    </div>
  </form>
</div>
<script type="text/javascript" src="<?php echo ADMIN_RESOURCE_URL;?>/js/jquery.nyroModal.js"></script>
<script type="text/javascript">
// 模拟网站LOGO上传input type='file'样式
$(function(){
	$("#adv_pic1").change(function(){$("#textfield1").val($(this).val());});
	$("#adv_pic2").change(function(){$("#textfield2").val($(this).val());});
	$("#adv_pic3").change(function(){$("#textfield3").val($(this).val());});
// 上传图片类型
$('input[class="type-file-file"]').change(function(){
	var filepatd=$(this).val();
	var extStart=filepatd.lastIndexOf(".");
	var ext=filepatd.substring(extStart,filepatd.lengtd).toUpperCase();		
		if(ext!=".PNG"&&ext!=".GIF"&&ext!=".JPG"&&ext!=".JPEG"){
			alert("<?php echo $lang['circle_setting_adv_img_check'];?>");
			$(this).attr('value','');
			return false;
		}
	});
$('#time_zone').attr('value','<?php echo $output['list_setting']['time_zone'];?>');
$('.nyroModal').nyroModal();
});
</script>