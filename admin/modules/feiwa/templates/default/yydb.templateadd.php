<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<div class="page">
  <div class="fixed-bar">
    <div class="item-title"><a class="back" href="index.php?app=yydb&feiwa=yydblist" title="返回列表"><i class="fa fa-arrow-circle-o-left"></i></a>
      <div class="subject">
        <h3>平台夺宝 - 新增夺宝模板</h3>
        <h5>平台夺宝新增与管理</h5>
      </div>
    </div>
  </div>
  <form id="yydb_form" method="post" enctype="multipart/form-data" >
    <input type="hidden" name="form_submit" value="ok" />
    <div class="ncap-form-default">
      <dl class="row">
        <dt class="tit">
          <label for="ydb_title"><em>*</em>夺宝标题</label>
        </dt>
        <dd class="opt">
          <input type="text" name="ydb_title" id="ydb_title" class="input-txt"/>
          <span class="err"></span>
          <p class="notic"></p>
        </dd>
      </dl>
       <dl class="row">
          <dt class="tit">
            <label>夺宝分类</label>
          </dt>
          <dd class="opt">
            <select name="sc_id">
              <option value="0"><?php echo $lang['sys_please_choose'];?></option>
              <?php if(is_array($output['class_list'])){ ?>
              <?php foreach($output['class_list'] as $k => $v){ ?>
              <option value="<?php echo $v['sc_id']; ?>"><?php echo $v['sc_name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
            <span class="err"></span>
            <p class="notic"> </p>
          </dd>
        </dl>
      <dl class="row">
        <dt class="tit">
          <label for="ydb_desc"><em>*</em>夺宝简介</label>
        </dt>
        <dd class="opt">
          <input type="text" name="ydb_desc" id="ydb_desc" class="input-txt"/>
          <span class="err"></span>
          <p class="notic"></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="ydb_goodsid"><em>*</em>关联商品ID</label>
        </dt>
        <dd class="opt">
                <input type="text" id="ydb_goodsid" name="ydb_goodsid"/>
                <span class="err"></span>
                <p class="notic">可为空,设置关联商品ID机会在前台显示关联商品ID连接</p>
        </dd>
      </dl>
      
        <dl class="row">
        <dt class="tit">
          <label for="ydb_total"><em>*</em>可发放总数</label>
        </dt>
        <dd class="opt">
                <input type="text" id="ydb_total" name="ydb_total"  class="input-txt"/>
                <span class="err"></span>
                <p class="notic">发放总数为一元一个，设置多少数量就是多少金额！设置整数</p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="">夺宝主图</label>
        </dt>
        <dd class="opt">
          <div class="input-file-show"><span class="type-file-box">
            <input name="goods_images" type="file" class="type-file-file" id="goods_images" size="30" hidefocus="true" feiwa_type="change_goods_image">
            </span></div>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">夺宝详情</dt>
        <dd class="opt">
          <?php showEditor('pgoods_body',$output['goods']['goods_body'],'600px','400px','visibility:hidden;',"false",$output['editor_multimedia']);?>
          <span class="err"></span>
          <p class="notic"></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit"><?php echo $lang['admin_pointprod_uploadimg']; ?></dt>
        <dd class="opt" id="divComUploadContainer">
          <div class="input-file-show"><span class="type-file-box">
            <input class="type-file-file" id="fileupload" name="fileupload" type="file" size="30" multiple hidefocus="true" title="点击按钮选择文件上传">
            <input type="text" name="text" id="text" class="type-file-text" />
            <input type="button" name="button" id="button" value="选择上传..." class="type-file-button" />
            </span></div>
          <div id="thumbnails" class="ncap-thumb-list">
            <h5><i class="fa fa-exclamation-circle"></i>上传后的图片可以插入到富文本编辑器中使用，无用附件请手动删除，如不处理系统会始终保存该附件图片。</h5>
            <ul>
              <?php if(is_array($output['file_upload'])){?>
              <?php foreach($output['file_upload'] as $k => $v){ ?>
              <li id="<?php echo $v['upload_id'];?>">
                <input type="hidden" name="file_id[]" value="<?php echo $v['upload_id'];?>" />
                <div class="thumb-list-pics"><a href="javascript:void(0);"><img src="<?php echo $v['upload_path'];?>" alt="<?php echo $v['file_name'];?>"/></a></div>
                <a href="javascript:del_file_upload('<?php echo $v['upload_id'];?>');" class="del" title="<?php echo $lang['sys_del'];?>">X</a><a href="javascript:insert_editor('<?php echo $v['upload_path'];?>');" class="inset"><i class="fa fa-trash"></i>插入图片</a> </li>
              <?php } ?>
              <?php } ?>
            </ul>
          </div>
        </dd>
      </dl>
      <div class="bot"><a href="JavaScript:void(0);" class="ncap-btn-big ncap-btn-green" id="submitBtn"><?php echo $lang['sys_submit'];?></a></div>
    </div>
  </form>
</div>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/fileupload/jquery.iframe-transport.js" charset="utf-8"></script>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/fileupload/jquery.ui.widget.js" charset="utf-8"></script>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/fileupload/jquery.fileupload.js" charset="utf-8"></script>
<script>
// 模拟上传input type='file'样式
$(function(){
    var textButton="<input type='text' name='textfield' id='textfield1' class='type-file-text' /><input type='button' name='button' id='button1' value='选择上传' class='type-file-button' />"
	$(textButton).insertBefore("#goods_images");
	$("#goods_images").change(function(){
	$("#textfield1").val($("#goods_images").val());
	});
});

//按钮先执行验证再提交表单
$(function(){$("#submitBtn").click(function(){
    if($("#yydb_form").valid()){
     $("#yydb_form").submit();
	}
	});
});
//
function showlimit(){
	//var islimit = $('input[name=islimit][checked]').val();
	var islimit = $(":radio[name=islimit]:checked").val();
	if(islimit == '1'){
		$("#limitnum_div").show();
		$("#limitnum").val('');
	}else{
		$("#limitnum_div").hide();
		$("#limitnum").val('1');//为了减少提交表单的验证，所以添加一个虚假值
	}
}
function showforbidreason(){
	var forbidstate = $(":radio[name=forbidstate]:checked").val();
	if(forbidstate == '1'){
		$("#forbidreason_div").show();
	}else{
		$("#forbidreason_div").hide();
	}
}
function showlimittime(){
	var islimit = $(":radio[name=islimittime]:checked").val();
	if(islimit == '1'){
		$("[name=limittime_div]").show();
		$("#starttime").val('');
		$("#endtime").val('');
	}else{
		$("[name=limittime_div]").hide();
		$("#starttime").val('<?php echo @date('Y-m-d',time()); ?>');
		$("#endtime").val('<?php echo @date('Y-m-d',time()); ?>');
	}
}
$(function(){
	$('input[feiwa_type="change_goods_image"]').change(function(){
		var src = getFullPath($(this)[0]);
		$('img[feiwa_type="goods_image"]').attr('src', src);
		$('input[feiwa_type="change_goods_image"]').removeAttr('name');
		$(this).attr('name', 'goods_image');
	});

	showlimit();
	showforbidreason();
	showlimittime();

	$('#starttime').datepicker({dateFormat: 'yy-mm-dd'});
	$('#endtime').datepicker({dateFormat: 'yy-mm-dd'});

    $('#yydb_form').validate({
        errorPlacement: function(error, element){
			var error_td = element.parent('dd').children('span.err');
            error_td.append(error);
        },
        rules : {
        	ydb_title : {
                required   : true
           }
        },
        messages : {
        	ydb_title  : {
                required : '<i class="fa fa-exclamation-circle"></i>请输入标题'
           }
        }
    });

    // 替换图片
    $('#fileupload').each(function(){
        $(this).fileupload({
            dataType: 'json',
            url: 'index.php?app=yydb&feiwa=yydb_pic_upload',
            done: function (e,data) {
                if(data != 'error'){
                	add_uploadedfile(data.result);
                }
            }
        });
    });
});
function add_uploadedfile(file_data)
{
    var newImg = '<li id="' + file_data.file_id + '"><input type="hidden" name="file_id[]" value="' + file_data.file_id + '" /><div class="thumb-list-pics"><a href="javascript:void(0);"><img src="<?php echo UPLOAD_SITE_URL.'/'.ATTACH_TTM.'/';?>' + file_data.file_name + '" alt="' + file_data.file_name + '"/></a></div><a href="javascript:del_file_upload(' + file_data.file_id + ');" class="del" title="<?php echo $lang['sys_del'];?>">X</a><a href="javascript:insert_editor(\'<?php echo UPLOAD_SITE_URL.'/'.ATTACH_TTM.'/';?>' + file_data.file_name + '\');" class="inset"><i class="fa fa-clipboard"></i>插入图片</a></li>';
    $('#thumbnails > ul').prepend(newImg);
}
function insert_editor(file_path){
	KE.appendHtml('pgoods_body', '<img src="'+ file_path + '" alt="'+ file_path + '">');
}
function del_file_upload(file_id)
{
    if(!window.confirm('确定删除吗？')){
        return;
    }
    $.getJSON('index.php?app=yydb&feiwa=ajaxdelupload&file_id=' + file_id, function(result){
        if(result){
            $('#' + file_id).remove();
        }else{
            alert('删除成功');
        }
    });
}
</script>