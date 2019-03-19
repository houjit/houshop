<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <a class="back" href="index.php?app=promotion_xianshi&feiwa=class_list" title="返回列表">
        <i class="fa fa-arrow-circle-o-left"></i>
      </a>
      <div class="subject">
        <h3>淘特卖 - 新增淘特卖分类</h3>
        <h5>商家可设置其淘特卖的分类以便于会员检索</h5>
      </div>
    </div>
  </div>
  <form id="add_form" method="post" action="index.php?app=promotion_xianshi&feiwa=class_save">
    <input name="class_id" type="hidden" value="<?php echo $output['class_info']['class_id'];?>" />
    <div class="ncap-form-default">
      <dl class="row">
        <dt class="tit">
          <label for="input_class_name"><em>*</em>分类名称</label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo $output['class_info']['class_name'];?>" name="input_class_name" id="input_class_name" class="input-txt">
          <span class="err"></span>
          <p class="notic"><?php echo $lang[''];?></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label><?php echo $lang['sys_sort'];?></label>
        </dt>
        <dd class="opt">
          <input type="text" value="<?php echo empty($output['class_info'])?'0':$output['class_info']['sort'];?>" name="input_sort" id="input_sort" class="input-txt">
          <span class="err"></span>
          <p class="notic"><?php echo $lang['sort_tip'];?></p>
        </dd>
      </dl>
      <div class="bot"><a id="submit" href="JavaScript:void(0);" class="ncap-btn-big ncap-btn-green"><?php echo $lang['sys_submit'];?></a></div>
    </div>
  </form>
</div>
<script type="text/javascript">
$(document).ready(function(){
    $("#submit").click(function(){
        $("#add_form").submit();
    });
	$('#add_form').validate({
        errorPlacement: function(error, element){
			var error_td = element.parent('dd').children('span.err');
            error_td.append(error);
        },
        rules : {
            input_class_name : {
                required : true
            },
            input_sort : {
                number   : true
            }
        },
        messages : {
            input_class_name: {
                required : '<i class="fa fa-exclamation-circle"></i><?php echo $lang['class_name_error'];?>'
            },
            input_sort: {
                number   : '<i class="fa fa-exclamation-circle"></i><?php echo $lang['sort_error'];?>'
            }
        }
    });
});
</script>
