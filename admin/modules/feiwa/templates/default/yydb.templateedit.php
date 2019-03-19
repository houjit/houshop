<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<div class="page">
  <div class="fixed-bar">
    <div class="item-title"><a class="back" href="index.php?app=yydb&feiwa=yydblist" title="返回列表"><i class="fa fa-arrow-circle-o-left"></i></a>
      <div class="subject">
        <h3>平台夺宝 - 编辑夺宝模板</h3>
        <h5>平台夺宝新增与管理</h5>
      </div>
    </div>
  </div>
  <form id="ydb_form" method="post" name="ydb_form" enctype="multipart/form-data">
    <input type="hidden" name="form_submit" value="ok" />
    <div class="ncap-form-default">
      <dl class="row">
        <dt class="tit">
          <label for="ydb_title"><em>*</em>夺宝名称</label>
        </dt>
        <dd class="opt">
          <?php if($output['t_info']['ableedit']==false){?>
            <?php echo $output['t_info']['yydb_t_title'];?>
          <?php }else{ ?>
            <input type="text" value="<?php echo $output['t_info']['yydb_t_title'];?>" name="ydb_title" id="ydb_title" class="input-txt" <?php echo $output['t_info']['ableedit']==false?'readonly':'';?>>
            <span class="err"></span>
            <p class="notic">模版名称不能为空且不能大于50个字符</p>
          <?php }?>
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
              <option <?php if($output['t_info']['yydb_t_class'] == $v['sc_id']){ ?>selected="selected"<?php } ?> value="<?php echo $v['sc_id']; ?>"><?php echo $v['sc_name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
            <span class="err"></span>
            <p class="notic"> </p>
          </dd>
        </dl>
        
      <dl class="row">
        <dt class="tit">
          <label for="ydb_total"><em>*</em>可发放总数</label>
        </dt>
        <dd class="opt">
            <?php if($output['t_info']['ableedit']==false){?>
                <?php echo $output['t_info']['yydb_t_total'];?>
            <?php }else{?>
                <input type="text" id="ydb_total" name="ydb_total" value="<?php echo $output['t_info']['yydb_t_total'];?>"/>
                <span class="err"></span>
                <p class="notic">如果夺宝领取方式为卡密兑换，则发放总数应为1~10000之间的整数</p>
            <?php }?>
        </dd>
      </dl>
            <dl class="row">
        <dt class="tit">
          <label for="ydb_total"><em>*</em>关联商品ID</label>
        </dt>
        <dd class="opt">
            <?php if($output['t_info']['ableedit']==false){?>
                <?php echo $output['t_info']['yydb_t_goodsid'];?>
            <?php }else{?>
                <input type="text" id="ydb_goodsid" name="ydb_goodsid" value="<?php echo $output['t_info']['yydb_t_goodsid'];?>"/>
                <span class="err"></span>
                <p class="notic">关联商品ID只允许填写一个商品ID</p>
            <?php }?>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
            <label for="ydb_desc"><em>*</em>夺宝描述</label>
        </dt>
        <dd class="opt">
            <textarea id="ydb_desc" name="ydb_desc" class="w300" ><?php echo $output['t_info']['yydb_t_desc'];?></textarea>
            <span class="err"></span>
            <p class="notic">模版描述不能为空且小于200个字符</p>
        </dd>
      </dl>
            <dl class="row">
        <dt class="tit">
          <label for="">夺宝主图</label>
        </dt>
        <dd class="opt">
          <div class="input-file-show"><span class="show"><a class="nyroModal" rel="gal" href="<?php echo $output['t_info']['yydb_t_customimg_url'];?>"><i class="fa fa-picture-o" onMouseOver="toolTip('<img src=<?php echo $output['t_info']['yydb_t_customimg_url'];?>>')" onMouseOut="toolTip()" onerror="this.src='<?php echo UPLOAD_SITE_URL.DS.ATTACH_COMMON.DS.C('default_goods_image');?>'"feiwa_type="goods_image" /></i></a></span><span class="type-file-box">
            <input name="goods_images" type="file" class="type-file-file" id="goods_images" size="30" hidefocus="true" feiwa_type="change_goods_image">
            </span></div>
        </dd>
      </dl>
      
       <dl class="row">
        <dt class="tit">夺宝描述</dt>
        <dd class="opt">
          <?php showEditor('pgoods_body',$output['t_info']['yydb_t_dbody'],'600px','400px','visibility:hidden;',"false",$output['editor_multimedia']);?>
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
              <li id="<?php echo $v['upload_id'];?>" class="picture" >
                <input type="hidden" name="file_id[]" value="<?php echo $v['upload_id'];?>" />
                <div class="thumb-list-pics"><a href="javascript:void(0);"><img src="<?php echo $v['upload_path'];?>" alt="<?php echo $v['file_name'];?>"/></a></div>
                <a href="javascript:del_file_upload('<?php echo $v['upload_id'];?>');" class="del" title="<?php echo $lang['sys_del'];?>">X</a><a href="javascript:insert_editor('<?php echo $v['upload_path'];?>');" class="inset"><i class="fa fa-trash"></i>插入图片</a> </li>
              <?php } ?>
              <?php } ?>
            </ul>
          </div>
        </dd>
      </dl>
      
      <dl class="row">
        <dt class="tit">
            <label>最近修改时间</label>
        </dt>
        <dd class="opt">
            <?php echo @date('Y-m-d H:i:s',$output['t_info']['yydb_t_updatetime']);?>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
            <label>最近修改人</label>
        </dt>
        <dd class="opt">
            <?php echo $output['t_info']['yydb_t_creator_name'];?>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label>当前期数</label>
        </dt>
        <dd class="opt">
            <?php echo $output['t_info']['yydb_t_giveout'];?>  张
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label>状态</label>
        </dt>
        <dd class="opt">
          <?php foreach ($output['templatestate_arr'] as $k=>$v){?>
            <label for="ydb_state<?php echo $v['sign'];?>"><input type="radio" value="<?php echo $v['sign'];?>" id="ydb_state<?php echo $v['sign'];?>" name="ydb_state" <?php echo $v['sign'] == $output['t_info']['yydb_t_state']?'checked="checked"':'';?>><?php echo $v['name'];?></label>
          <?php }?>
          <span class="err"></span>
          <p class="notic"></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label>是否推荐</label>
        </dt>
        <dd class="opt">
          <div class="onoff">
            <label title="<?php echo $lang['sys_yes'];?>" class="cb-enable <?php if($output['t_info']['yydb_t_recommend'] == '1'){ ?>selected<?php } ?>" for="recommend1"><?php echo $lang['sys_yes'];?></label>
            <label title="<?php echo $lang['sys_no'];?>" class="cb-disable <?php if($output['t_info']['yydb_t_recommend'] == '0'){ ?>selected<?php } ?>" for="recommend0"><?php echo $lang['sys_no'];?></label>
            <input type="radio" value="1" <?php if($output['t_info']['yydb_t_recommend'] == '1'){ ?>checked="checked"<?php } ?> name="recommend" id="recommend1">
            <input type="radio" value="0" <?php if($output['t_info']['yydb_t_recommend'] == '0'){ ?>checked="checked"<?php } ?> name="recommend" id="recommend0">
          </div>
          <p class="notic"></p>
        </dd>
      </dl>
      <div class="bot"><a href="JavaScript:void(0);" class="ncap-btn-big ncap-btn-green" id="submitBtn"><?php echo $lang['sys_submit'];?></a></div>
    </div>
  </form>
</div>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/fileupload/jquery.iframe-transport.js" charset="utf-8"></script> 
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/fileupload/jquery.ui.widget.js" charset="utf-8"></script> 
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/fileupload/jquery.fileupload.js" charset="utf-8"></script> 
<script type="text/javascript" src="<?php echo ADMIN_RESOURCE_URL;?>/js/jquery.nyroModal.js"></script>

<script>

function showlimit(){
	var islimit = $(":radio[name=islimit]:checked").val();
	if(islimit == '1'){
		$("#limitnum_div").show();
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
$(function(){
// 点击查看图片
	$('.nyroModal').nyroModal();
	// 模拟上传input type='file'样式
	$(function(){
	    var textButton="<input type='text' name='textfield' id='textfield1' class='type-file-text' /><input type='button' name='button' id='button1' value='选择上传...' class='type-file-button' />"
		$(textButton).insertBefore("#goods_images");
		$("#goods_images").change(function(){
		$("#textfield1").val($("#goods_images").val());
		});
	});

	$('input[feiwa_type="change_goods_image"]').change(function(){
		var src = getFullPath($(this)[0]);
		$('img[feiwa_type="goods_image"]').attr('src', src);
		$('input[feiwa_type="change_goods_image"]').removeAttr('name');
		$(this).attr('name', 'goods_image');
	});

	showlimit();
	showforbidreason();

	$('#starttime').datepicker({dateFormat: 'yy-mm-dd'});
	$('#endtime').datepicker({dateFormat: 'yy-mm-dd'});
	//按钮先执行验证再提交表单
$(function(){$("#submitBtn").click(function(){
    if($("#ydb_form").valid()){
     $("#ydb_form").submit();
	}
	});
});
//
    $('#ydb_form').validate({
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
                required : '<i class="fa fa-exclamation-circle"></i><?php echo $lang['admin_pointprod_add_goodsname_error']; ?>'
           }
        }
    });

    // 替换图片
    $('#fileupload').each(function(){
        $(this).fileupload({
            dataType: 'json',
            url: 'index.php?app=yydb&feiwa=yydb_pic_upload&item_id=<?php echo $output['t_info']['yydb_t_id'];?>',
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
	var newImg = '<li id="' + file_data.file_id + '" class="picture"><input type="hidden" name="file_id[]" value="' + file_data.file_id + '" /><div class="thumb-list-pics"><a href="javascript:void(0);"><img src="<?php echo UPLOAD_SITE_URL.'/'.ATTACH_TTM.'/';?>' + file_data.file_name + '" alt="' + file_data.file_name + '" /></a></div></span><span><a href="javascript:del_file_upload(' + file_data.file_id + ');" class="del" title="<?php echo $lang['sys_del'];?>">X</a><a href="javascript:insert_editor(\'<?php echo UPLOAD_SITE_URL.'/'.ATTACH_TTM.'/';?>' + file_data.file_name + '\');" class="inset"><i class="fa fa-clipboard"></i>插入图片</a</a></li>';
    $('#thumbnails > ul').prepend(newImg);
}
function insert_editor(file_path){
	KE.appendHtml('pgoods_body', '<img src="'+ file_path + '" alt="'+ file_path + '">');
}
function del_file_upload(file_id)
{
    if(!window.confirm('<?php echo $lang['sys_ensure_del'];?>')){
        return;
    }
    $.getJSON('index.php?app=yydb&feiwa=ajaxdelupload&file_id=' + file_id, function(result){
        if(result){
            $('#' + file_id).remove();
        }else{
            alert('删除失败');
        }
    });
}
</script> 