<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <div class="subject">
        <h3>商家入驻</h3>
        <h5>开店招商及商家开店申请页面内容管理</h5>
      </div>
      <ul class="tab-base nc-row">
        <li><a href="index.php?app=store_joinin&feiwa=edit_info" ><?php echo '入驻首页';?></a></li>
        <li><a href="index.php?app=store_joinin&feiwa=help_list"><?php echo '入驻指南';?></a></li>
        <li><a href="JavaScript:void(0);" class="current"><?php echo '合同与汇款';?></a></li>
      </ul>
    </div>
  </div>
  <form method="post" enctype="multipart/form-data" name="form1">
    <input type="hidden" name="form_submit" value="ok" />
    <div class="ncap-form-default">
      <dl class="row">
        <dt class="tit">
          <label for="show_txt">合同地址:</label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['list_setting']['hetong']; ?>" name="hetong" class="input-txt">
          <p><span class="vatop rowform">填写合同的下载地址</span></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="show_txt">接收邮箱:</label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['list_setting']['join_email']; ?>" name="join_email" class="input-txt">
          <p><span class="vatop rowform">接收凭证的邮箱</span></p>
        </dd>
      </dl>

      <dl class="row">
        <dt class="tit">
          <label for="show_txt">企业银行汇款信息</label>
        </dt>
        <dd class="opt">
         
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="show_txt">银行开户名:</label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['list_setting']['qyname']; ?>" name="qyname" class="input-txt">
          <p><span class="vatop rowform"></span></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="show_txt">银行账号:</label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['list_setting']['qynumber']; ?>" name="qynumber" class="input-txt">
          <p><span class="vatop rowform"></span></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="show_txt">开户银行支行名称:</label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['list_setting']['qybankname']; ?>" name="qybankname" class="input-txt">
          <p><span class="vatop rowform"></span></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="show_txt">支行联行号:</label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['list_setting']['qylianhanghao']; ?>" name="qylianhanghao" class="input-txt">
          <p><span class="vatop rowform"></span></p>
        </dd>
      </dl>

      <dl class="row">
        <dt class="tit">
          <label for="show_txt">个人银行汇款信息</label>
        </dt>
        <dd class="opt">
         
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="show_txt">银行开户名:</label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['list_setting']['grname']; ?>" name="grname" class="input-txt">
          <p><span class="vatop rowform"></span></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="show_txt">银行账号:</label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['list_setting']['grnumber']; ?>" name="grnumber" class="input-txt">
          <p><span class="vatop rowform"></span></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="show_txt">开户银行支行名称:</label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['list_setting']['grbankname']; ?>" name="grbankname" class="input-txt">
          <p><span class="vatop rowform"></span></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="show_txt">支行联行号:</label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['list_setting']['grlianhanghao']; ?>" name="grlianhanghao" class="input-txt">
          <p><span class="vatop rowform"></span></p>
        </dd>
      </dl>
      

      <div class="bot"><a href="JavaScript:void(0);" class="ncap-btn-big ncap-btn-green" onclick="document.form1.submit()"><?php echo $lang['sys_submit'];?></a></div>
    </div>
  </form>
</div>
<script type="text/javascript" src="<?php echo ADMIN_RESOURCE_URL;?>/js/jquery.nyroModal.js"></script>

<script type="text/javascript">
$(function(){
    $('input[class="type-file-file"]').change(function(){
      var pic=$(this).val();
      var extStart=pic.lastIndexOf(".");
      var ext=pic.substring(extStart,pic.length).toUpperCase();
      $(this).parent().find(".type-file-text").val(pic);
    if(ext!=".PNG"&&ext!=".GIF"&&ext!=".JPG"&&ext!=".JPEG"){
        alert("<?php echo $lang['default_img_wrong'];?>");
      $(this).attr('value','');
      return false;
    }
  });
    $('.nyroModal').nyroModal();
});
function clear_pic(n){//置空
  $("#show"+n+"").remove();
  $("#textfield"+n+"").val("");
  $("#pic"+n+"").val("");
  $("#show_pic"+n+"").val("");
}
</script> 
