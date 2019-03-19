<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<link rel="stylesheet" type="text/css" href="<?php echo RESOURCE_SITE_URL;?>/js/jquery-ui/themes/ui-lightness/jquery.ui.css"  />
<div class="wrap">
  <div class="tabmenu">
    <?php include template('layout/submenu');?>
  </div>
  <div class="alert alert-success">
    <h4>操作提示：</h4>
    <ul>
      <li>请认真填写真实的认证信息，否则审核可能不通过，影响您的使用。</li>
      <?php if($output['member_info']['real_text']!=""){?>
      <li style="color:red;">备注：<?php echo $output['member_info']['real_text']; ?></li>
      <?php } ?>
    </ul>
  </div>
  <div class="ncm-default-form">
    <form method="post" id="real_form" action="<?php echo MEMBER_SITE_URL;?>/index.php?app=member_security&feiwa=modify_realname" enctype="multipart/form-data" >
      <input type="hidden" name="form_submit" value="ok" />
      <dl>
        <dt><i class="required">*</i>真实姓名：</dt>
        <dd>
          <input type="text" class="text w180"  maxlength="40" value="<?php echo $output['member_info']['real_name'];?>" name="real_name" id="real_name" />
          <label for="real_name" generated="true" class="error"></label>
        </dd>
      </dl>
      <dl>
        <dt><i class="required">*</i>身份证号：</dt>
        <dd>
          <input type="text" class="text w180"  maxlength="40" value="<?php echo $output['member_info']['real_cardnumber'];?>" name="real_cardnumber" id="real_cardnumber" onblur="checkcard()" />
          <label for="real_cardnumber" generated="true" class="error"></label>
           <span id="real_cardtext" style="color:#ed5564;"></span>
        </dd>
      </dl>
      <dl>
        <dt><i class="required">*</i>出生日期：</dt>
        <dd>
          <input type="text" class="text w180"  maxlength="40" value="<?php if($output['member_info']['real_birthday']!=""){echo date("Y-m-d",$output['member_info']['real_birthday']);}?>" name="real_birthday" id="real_birthday"/>
          <label for="real_birthday" generated="true" class="error"></label>
        </dd>
      </dl>
      <dl>
        <dt><i class="required">*</i>性别：</dt>
        <dd>
          <input type="radio" value="男" name="real_sex" id="real_sex" <?php if($output['member_info']['real_sex']=="男"){ ?>checked="checked" <?php } ?>/>男
          <input type="radio" value="女" name="real_sex" id="real_sex" <?php if($output['member_info']['real_sex']=="女"){ ?>checked="checked" <?php } ?>/>女
          <label for="real_sex" generated="true" class="error"></label>
        </dd>
      </dl>
      <dl>
        <dt><i class="required">*</i>民族：</dt>
        <dd>
          <input type="text" class="text w180"  maxlength="40" value="<?php echo $output['member_info']['real_minzu'];?>" name="real_minzu" id="real_minzu"/>
          <label for="real_minzu" generated="true" class="error"></label>
        </dd>
      </dl>
      <dl>
        <dt><i class="required">*</i>证件住址：</dt>
        <dd>
          <input type="text" class="text w180"  maxlength="40" value="<?php echo $output['member_info']['real_address'];?>" name="real_address" id="real_address"/>
          <label for="real_address" generated="true" class="error">填写身份证上的住址</label>
        </dd>
      </dl>
      <dl>
        <dt><i class="required">*</i>发证机关</dt>
        <dd>
          <input type="text" class="text w180"  maxlength="40" value="<?php echo $output['member_info']['real_jiguan'];?>" name="real_jiguan" id="real_jiguan"/>
          <label for="real_jiguan" generated="true" class="error"></label>
        </dd>
      </dl>
      <dl>
        <dt><i class="required">*</i>身份证有效期：</dt>
        <dd>
          <input type="text" class="text w90"  maxlength="40" value="<?php if($output['member_info']['real_timestart']!=""){echo date("Y-m-d",$output['member_info']['real_timestart']);}?>" name="real_timestart" id="real_timestart"/> - 
          <input type="text" class="text w90"  maxlength="40" value="<?php if($output['member_info']['real_timeend']!=""){echo date("Y-m-d",$output['member_info']['real_timeend']);}?>" name="real_timeend" id="real_timeend"/>
          <label for="real_timeend" generated="true" class="error"></label>
          <span style="color:#e84723;">有效期为长期的证件请选择大于10年</span>
        </dd>
      </dl>
      <dl>
        <dt><i class="required">*</i>身份证正面：</dt>
        <dd>
        <?php if($output['member_info']['real_card_zheng']!=""){ ?>
        	<img src="/data/upload/member/realname/<?php echo $output['member_info']['real_card_zheng']?>" style="max-width:200px;max-height:200px;"><br>
        <? } ?>
        <?php if($output['member_info']['real_check']!=1){ ?>
          <input type="file" name="real_cardzheng"/>
          <label class="error">请确保图片清晰，身份证上文字可辨（清晰照片也可使用）。</label>
          <label for="real_cardzheng" generated="true" class="error"></label>
        <?php } ?>
        </dd>
      </dl>
      <dl>
        <dt><i class="required">*</i>身份证反面：</dt>
        <dd>
        <?php if($output['member_info']['real_card_fan']!=""){ ?>
        	<img src="/data/upload/member/realname/<?php echo $output['member_info']['real_card_fan']?>" style="max-width:200px;max-height:200px;"><br>
        <? } ?>
        <?php if($output['member_info']['real_check']!=1){ ?>
          <input type="file" name="real_cardfan"/>
          <label class="error">请确保图片清晰，身份证上文字可辨（清晰照片也可使用）。</label>
          <label for="real_cardfan" generated="true" class="error"></label>
        <?php } ?>
        </dd>
      </dl>
      <dl>
        <dt><i class="required">*</i>手持身份证：</dt>
        <dd>
        <?php if($output['member_info']['real_card_shou']!=""){ ?>
        	<img src="/data/upload/member/realname/<?php echo $output['member_info']['real_card_shou']?>" style="max-width:200px;max-height:200px;"><br>
        <? } ?>
        <?php if($output['member_info']['real_check']!=1){ ?>
          <input type="file" name="real_cardshou"/>
          <label for="real_cardshou" generated="true" class="error"></label>
          <br>
          <img src="/mall/templates/default/images/example.jpg" alt="手执身份证照范例">
          <label class="error">请确保图片清晰，身份证上文字可辨（清晰照片也可使用）。</label>
        <?php } ?>
        </dd>
      </dl>
      <?php if($output['member_info']['real_check']!=1){ ?>
      <dl class="bottom">
        <dt>&nbsp;</dt>
        <dd>
        <label class="submit-border">
        	<input type="submit" style="float:left" class="submit" value="提交认证" onclick="checkcard()"/>
        	<?php if($output['member_info']['real_check']!=0){ ?>
        	<span id="xiugai" class="submit" onclick="xiugai()" style="background-color: #48cfae;border: 0 none;border-radius: 3px;color: #fff;cursor: pointer;margin-left:50px;">修改认证</span>
        	<?php } ?>
        </label>
        </dd>
      </dl>
      <?php } ?>
    </form>
  </div>
</div>
<?php if($output['member_info']['real_check']!=0){ ?>
<script type="text/javascript">
$(document).ready(function(){
    $("input").attr("disabled",true); 
});
</script>
<?php } ?>

<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/jquery-ui/i18n/zh-CN.js" charset="utf-8"></script> 
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.nyroModal/custom.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/IDValidator.js" charset="utf-8"></script> 
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/GB2260.js" charset="utf-8"></script>
<script type="text/javascript">
function xiugai(){
	 if(confirm("修改认证需要重新上传身份证，确认修改吗？"))
	 {
	 $("#xiugai").attr("style","display:none");
	 $("input").attr("disabled",false);
	 return false;
	 }else{
	 	return false;
	 }
}

var Validator = new IDValidator();
var Validator = IDValidator(GB2260);

function checkcard(){
  var code = $("#real_cardnumber").val();
  var i = Validator.isValid(code);
  if(i==false){
    $("#real_cardnumber").val('');
    window.document.getElementById("real_cardtext").innerHTML = '<i class="icon-exclamation-sign"></i>请填写正确的身份证号';
    return false;
  }else{
    $("#real_cardtext").text("");
  }
}
$(document).ready(function(){
    $('a[nctype="nyroModal"]').nyroModal(); 
});
$(function(){
	$('a[nctype="nyroModal"]').nyroModal();
	$('#real_birthday').datepicker({dateFormat: 'yy-mm-dd'});
    $('#real_timestart').datepicker({dateFormat: 'yy-mm-dd'});
    $('#real_timeend').datepicker({dateFormat: 'yy-mm-dd'});
    $('#real_form').validate({
        submitHandler:function(form){
            ajaxpost('real_form', '', '', 'onerror') 
        },
        rules : {
           real_name : {
                required   : true
            },
            real_cardnumber : {
                required   : true                
            },
            real_birthday : {
                required   : true
            },
            real_sex : {
                required   : true
               
            },
            real_minzu : {
                required   : true
            },
            real_address : {
                required   : true
            },
            real_jiguan : {
                required   : true
            },
            real_timestart : {
                required   : true
            },
            real_timeend : {
                required   : true
            },
            real_cardzheng : {
                required   : true
            },
            real_cardfan : {
                required   : true
            },
            real_cardshou : {
                required   : true
            }
        },
        messages : {
            real_name : {
                required : '<i class="icon-exclamation-sign"></i>请正确填写真实姓名'
            },
            real_cardnumber : {
                required : ''
            },
            real_birthday : {
                required : '<i class="icon-exclamation-sign"></i>请正确填写出生日期'
            },
            real_sex : {
                required : '<i class="icon-exclamation-sign"></i>请选择性别'
            },
            real_minzu : {
                required : '<i class="icon-exclamation-sign"></i>请正确填写民族'
            },
            real_address : {
                required : '<i class="icon-exclamation-sign"></i>请正确填写填写身份证上的住址'
            },
            real_jiguan : {
                required : '<i class="icon-exclamation-sign"></i>请正确填写发证机关'
            },
            real_timestart : {
                required : '<i class="icon-exclamation-sign"></i>请正确填写有效期限'
            },
            real_timeend : {
                required : '<i class="icon-exclamation-sign"></i>请正确填写有效期限'
            },
            real_cardzheng : {
                required : '<i class="icon-exclamation-sign"></i>请上传身份证正面'
            },
            real_cardfan : {
                required : '<i class="icon-exclamation-sign"></i>请上传身份证反面'
            },
            real_cardshou : {
                required : '<i class="icon-exclamation-sign"></i>请上传手持身份证'
            }

        }
    });
});
</script> 
