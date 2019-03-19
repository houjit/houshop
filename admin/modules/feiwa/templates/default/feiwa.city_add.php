<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title"><a class="back" href="index.php?app=feiwa&feiwa=city" title="返回列表"><i class="fa fa-arrow-circle-o-left"></i></a>
      <div class="subject">
        <h3>切换城市 - 设置</h3>
        <h5>切换城市用于多城市选择</h5>
      </div>
    </div>
  </div>

  <form id="city_form" method="post">
    <input type="hidden" name="form_submit" value="ok" />
    <input type="hidden" name="id" value='<?php echo $_GET['id']?>'>
    <div class="ncap-form-default">
       
       <dl class="row">
        <dt class="tit">
          <label for="city_name"><em>*</em>城市名称</label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['current_info']['name'];?>" name="city_name" id="city_name" class="input-txt">
          <span class="err"></span>
          <p class="notic">请输入城市名称</p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="city_value"><em>*</em>城市ID</label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['current_info']['value'];?>" name="city_value" id="city_value" class="input-txt">
          <span class="err"></span>
          <p class="notic">请输入对应城市ID</p>
        </dd>
      </dl>
      
       <dl class="row">
        <dt class="tit">
          <label for="city_name"><em>*</em>首页连接</label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['current_info']['curl'];?>" name="city_url" id="city_url" class="input-txt">
          <span class="err"></span>
          <p class="notic">首页链接必须包含‘index.php?app=index&feiwa=index’</p>
        </dd>
      </dl>
      <div class="bot"><a href="JavaScript:void(0);" class="ncap-btn-big ncap-btn-green" id="submitBtn"><?php echo $lang['sys_submit'];?></a></div>
    </div>
  </form>
</div>
<script>
//按钮先执行验证再提交表单
$(function(){$("#submitBtn").click(function(){
    if($("#city_form").valid()){
        $("#city_form").submit();
    }
	});
});

$(document).ready(function(){
	$('#city_form').validate({
        errorPlacement: function(error, element){
			var error_td = element.parent('dd').children('span.err');
            error_td.append(error);
        },
        rules : {
            city_name : {
                required : true
            },
            city_value : {
                required : true
            },
			city_url : {
                required : true
            }
        },
        messages : {
            city_name : {
                required : '<i class="fa fa-exclamation-circle"></i>请填写城市名称'
            },
            city_value : {
            	required : '<i class="fa fa-exclamation-circle"></i>请填写城市ID'
            },
			city_url : {
            	required : '<i class="fa fa-exclamation-circle"></i>请填写城市默认连接'
            }
        }
    });
});
</script>