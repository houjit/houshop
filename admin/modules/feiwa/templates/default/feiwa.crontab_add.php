<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title"><a class="back" href="index.php?app=feiwa&feiwa=crontab" title="返回列表"><i class="fa fa-arrow-circle-o-left"></i></a>
      <div class="subject">
        <h3>计划任务设置</h3>
        <h5>当设置为自动的时候就会自动执行哦</h5>
      </div>
    </div>
  </div>

  <form id="crontab_form" method="post">
    <input type="hidden" name="form_submit" value="ok" />
    <input type="hidden" name="id" value='<?php echo $_GET['id']?>'>
    <div class="ncap-form-default">
       
       <dl class="row">
        <dt class="tit">
          <label for="crontab_name"><em>*</em>间隔时间</label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['current_info']['name'];?>" name="crontab_name" id="crontab_name" class="input-txt">
          <span class="err"></span>
          <p class="notic">设置间隔时间，以毫秒为单位</p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="crontab_name"><em>*</em>任务链接</label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['current_info']['value'];?>" name="crontab_value" id="crontab_value" class="input-txt">
          <span class="err"></span>
          <p class="notic">任务链接必须包含‘http://’以及准确域名</p>
        </dd>
      </dl>

      <dl class="row">
        <dt class="tit">
          <label>是否自动执行</label>
        </dt>
        <dd class="opt">
          <label>
            <input name="crontab_is"  type="radio" value="1" <?php if($output['current_info']['crontab_is']==1) echo 'checked="checked"'?>>
            是</label>
          <label>
            <input type="radio" name="crontab_is" value="2" <?php if($output['current_info']['crontab_is']==2) echo 'checked="checked"'?>>
            否</label>
            <span class="err"></span>
          <p class="notic">请选择是否自动执行</p>
        </dd>
      </dl>
      <div class="bot"><a href="JavaScript:void(0);" class="ncap-btn-big ncap-btn-green" id="submitBtn"><?php echo $lang['sys_submit'];?></a></div>
    </div>
  </form>
</div>
<script>
//按钮先执行验证再提交表单
$(function(){$("#submitBtn").click(function(){
    if($("#crontab_form").valid()){
        $("#crontab_form").submit();
    }
	});
});

$(document).ready(function(){
	$('#crontab_form').validate({
        errorPlacement: function(error, element){
			var error_td = element.parent('dd').children('span.err');
            error_td.append(error);
        },
        rules : {
            crontab_name : {
                required : true
            },
            crontab_value : {
                required : true
            },
			crontab_is : {
                required : true
            }
        },
        messages : {
            crontab_name : {
                required : '<i class="fa fa-exclamation-circle"></i>请填写推荐词名称'
            },
            crontab_value : {
            	required : '<i class="fa fa-exclamation-circle"></i>请填写推荐词链接'
            },
			crontab_is : {
            	required : '<i class="fa fa-exclamation-circle"></i>请选择是否高亮'
            }
        }
    });
});
</script>