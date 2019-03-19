<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<link rel="stylesheet" type="text/css" href="<?php echo RESOURCE_SITE_URL;?>/js/jquery-ui/themes/ui-lightness/jquery.ui.css"  />
<div class="tabmenu">
  <?php include template('layout/submenu');?>
</div>
<div class="feiwast-form-default">
    <?php if(empty($output['xianshi_info'])) { ?>
    <form id="add_form" action="index.php?app=store_promotion_xianshi&feiwa=xianshi_save" method="post">
    <?php } else { ?>
    <form id="add_form" action="index.php?app=store_promotion_xianshi&feiwa=xianshi_edit_save" method="post">
        <input type="hidden" name="xianshi_id" value="<?php echo $output['xianshi_info']['xianshi_id'];?>">
    <?php } ?>
    <dl>
      <dt><i class="required">*</i><?php echo $lang['xianshi_name'];?><?php echo $lang['feiwa_colon'];?></dt>
      <dd>
          <input id="xianshi_name" name="xianshi_name" type="text"  maxlength="25" class="text w400" value="<?php echo empty($output['xianshi_info'])?'':$output['xianshi_info']['xianshi_name'];?>"/>
          <span></span>
        <p class="hint"><?php echo $lang['xianshi_name_explain'];?></p>
      </dd>
    </dl>
    <dl>
      <dt>活动标题<?php echo $lang['feiwa_colon'];?></dt>
      <dd>
          <input id="xianshi_title" name="xianshi_title" type="text"  maxlength="10" class="text w200" value="<?php echo empty($output['xianshi_info'])?'':$output['xianshi_info']['xianshi_title'];?>"/>
          <span></span>
        <p class="hint"><?php echo $lang['xianshi_title_explain'];?></p>
      </dd>
    </dl>
    <dl>
      <dt>活动描述<?php echo $lang['feiwa_colon'];?></dt>
      <dd>
          <input id="xianshi_explain" name="xianshi_explain" type="text"  maxlength="30" class="text w400" value="<?php echo empty($output['xianshi_info'])?'':$output['xianshi_info']['xianshi_explain'];?>"/>
          <span></span>
        <p class="hint"><?php echo $lang['xianshi_explain_explain'];?></p>
      </dd>
    </dl>
    <?php if(empty($output['xianshi_info'])) { ?>
    <dl>
      <dt><i class="required">*</i><?php echo $lang['start_time'];?><?php echo $lang['feiwa_colon'];?></dt>
      <dd>
          <input id="start_time" name="start_time" type="text" class="text w130" /><em class="add-on"><i class="icon-calendar"></i></em><span></span>
        <p class="hint">
<?php if (!$output['isOwnMall'] && $output['current_xianshi_quota']['start_time'] > 1) { ?>
        <?php echo sprintf($lang['xianshi_add_start_time_explain'],date('Y-m-d H:i',$output['current_xianshi_quota']['start_time']));?>
<?php } ?>
        </p>
      </dd>
    </dl>
    <dl>
      <dt><i class="required">*</i><?php echo $lang['end_time'];?><?php echo $lang['feiwa_colon'];?></dt>
      <dd>
          <input id="end_time" name="end_time" type="text" class="text w130"/><em class="add-on"><i class="icon-calendar"></i></em><span></span>
        <p class="hint">
<?php if (!$output['isOwnMall']) { ?>
        <?php echo sprintf($lang['xianshi_add_end_time_explain'],date('Y-m-d H:i',$output['current_xianshi_quota']['end_time']));?>
<?php } ?>
        </p>
      </dd>
    </dl>
    <?php } ?>
    <dl>
      <dt><i class="required">*</i>购买下限<?php echo $lang['feiwa_colon'];?></dt>
      <dd>
        <input id="lower_limit" name="lower_limit" type="text" class="text w130" value="<?php echo empty($output['xianshi_info'])?'1':$output['xianshi_info']['lower_limit'];?>"/><span></span>
        <p class="hint">参加活动的最低购买数量，默认为1</p>
      </dd>
    </dl>
	    <dl>
	      <dt><i class="required">*</i>淘特卖分类</dt>
	      <dd>
	        <select name="sc_id">
	           <option value="">特卖分类</option>
	           <?php foreach ($output['xianshi_class'] as $k=>$v){?>
	           <option value="<?php echo $v['class_id'];?>" <?php if ($output['xianshi_info']['class_id']==$v['class_id']){ echo 'selected';}?>><?php echo $v['class_name'];?></option>
	           <?php }?>
	        </select>
	        <span></span>
	      </dd>
	    </dl>
    <dl>
      <dt><i class="required">*</i>活动图片<?php echo $lang['feiwa_colon'];?></dt>
      <dd>
      <div class="feiwast-upload-thumb xianshi-pic">
          <p><i class="icon-picture" style="<?php echo empty($output['xianshi_info']['xianshi_image'])?'display:block':'display:none';?>"></i>
          <img nctype="img_xianshi_image" style="<?php echo empty($output['xianshi_info']['xianshi_image'])?'display:none':'display:block';?>" src="<?php echo xsthumb($output['xianshi_info']['xianshi_image']);?>"/></p>
      </div>
        <input nctype="xianshi_image" name="xianshi_image5" type="hidden" value="<?php echo $output['xianshi_info']['xianshi_image'];?>">
        <div class="feiwast-upload-btn">
            <a href="javascript:void(0);">
                <span>
                    <input type="file" hidefocus="true" size="1" class="input-file" name="xianshi_image" nctype="btn_upload_image"/>
                </span>
                <p><i class="icon-upload-alt"></i>图片上传</p>
            </a>
        </div>
        <span></span>
        <p class="hint">用于抢购活动页面的图片,请使用宽度2000像素、高度385像素、大小1M内的图片，支持jpg、jpeg、gif、png格式上传。</p>
        </dd>
    </dl>
    <dl>
      <dt>限时推荐位图片<?php echo $lang['feiwa_colon'];?></dt>
      <dd>
      <div class="feiwast-upload-thumb xianshi-commend-pic">
          <p><i class="icon-picture" style="<?php echo empty($output['xianshi_info']['xianshi_image1'])?'display:block':'display:none';?>"></i>
          <img nctype="img_xianshi_image" style="<?php echo empty($output['xianshi_info']['xianshi_image1'])?'display:none':'display:block';?>" src="<?php echo xsthumb($output['xianshi_info']['xianshi_image1']);?>"/></p>
      </div>
        <input nctype="xianshi_image" name="xianshi_image1" type="hidden" value="<?php echo $output['xianshi_info']['xianshi_image1'];?>">
        <span></span>
        <div class="feiwast-upload-btn">
            <a href="javascript:void(0);">
                <span>
                    <input type="file" hidefocus="true" size="1" class="input-file" name="xianshi_image" nctype="btn_upload_image"/>
                </span>
                <p><i class="icon-upload-alt"></i>图片上传</p>
            </a>
        </div>
        <p class="hint">用于抢购页侧边推荐位，首页推荐位的图片,请使用宽度960像素、高度380像素、大小1M内的图片，支持jpg、jpeg、gif、png格式上传。</p>
        </dd>
    </dl>
        <dl>
      <dt>品牌图片<?php echo $lang['feiwa_colon'];?></dt>
      <dd>
      <div class="feiwast-upload-thumb xianshi-commend-pic2">
          <p><i class="icon-picture" style="<?php echo empty($output['xianshi_info']['xianshi_image2'])?'display:block':'display:none';?>"></i>
          <img nctype="img_xianshi_image" style="<?php echo empty($output['xianshi_info']['xianshi_image2'])?'display:none':'display:block';?>" src="<?php echo xsthumb($output['xianshi_info']['xianshi_image2']);?>"/></p>
      </div>
        <input nctype="xianshi_image" name="xianshi_image2" type="hidden" value="<?php echo $output['xianshi_info']['xianshi_image2'];?>">
        <span></span>
        <div class="feiwast-upload-btn">
            <a href="javascript:void(0);">
                <span>
                    <input type="file" hidefocus="true" size="1" class="input-file" name="xianshi_image" nctype="btn_upload_image"/>
                </span>
                <p><i class="icon-upload-alt"></i>图片上传</p>
            </a>
        </div>
        <p class="hint">用于抢购页侧边推荐位，首页推荐位的图片,请使用宽度150像素、高度35像素、大小1M内的图片，支持jpg、jpeg、gif、png格式上传。</p>
        </dd>
    </dl>
        <dl>
      <dt>自定义页面：</dt>
      <dd>
        <?php showEditor('xianshi_intro',$output['xianshi_info']['xianshi_intro'],'740px','360px','','false',false);?>
        <p class="hr8"><a class="des_demo ncbtn" href="index.php?app=store_album&feiwa=pic_list&item=groupbuy"><i class="icon-picture"></i>插入相册图片</a></p>
        <p id="des_demo" style="display:none;"></p>
      </dd>
    </dl>
    <div class="bottom">
      <label class="submit-border"><input id="submit_button" type="submit" class="submit" value="<?php echo $lang['feiwa_submit'];?>"></label>
    </div>
  </form>
</div>
<link rel="stylesheet" type="text/css" href="<?php echo RESOURCE_SITE_URL;?>/js/jquery-ui/themes/ui-lightness/jquery.ui.css"  />
<link rel="stylesheet" type="text/css" href="<?php echo RESOURCE_SITE_URL;?>/js/jquery-ui-timepicker-addon/jquery-ui-timepicker-addon.min.css"  />
<script src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.ajaxContent.pack.js"></script>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/jquery-ui/i18n/zh-CN.js"></script>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/jquery-ui-timepicker-addon/jquery-ui-timepicker-addon.min.js"></script>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/fileupload/jquery.iframe-transport.js" charset="utf-8"></script>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/fileupload/jquery.ui.widget.js" charset="utf-8"></script>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/fileupload/jquery.fileupload.js" charset="utf-8"></script>
<script>
$(document).ready(function(){
    <?php if(empty($output['xianshi_info'])) { ?>
    $('#start_time').datetimepicker({
        controlType: 'select'
    });

    $('#end_time').datetimepicker({
        controlType: 'select'
    });
    <?php } ?>
    
     //图片上传
    $('[nctype="btn_upload_image"]').fileupload({
        dataType: 'json',
            url: "<?php echo urlMall('store_promotion_xianshi', 'image_upload');?>",
            add: function(e, data) {
                $parent = $(this).parents('dd');
                $input = $parent.find('[nctype="xianshi_image"]');
                $img = $parent.find('[nctype="img_xianshi_image"]');
                data.formData = {old_xianshi_image:$input.val()};
                $img.attr('src', "<?php echo MALL_TEMPLATES_URL.'/images/loading.gif';?>");
                data.submit();
            },
            done: function (e,data) {
                var result = data.result;
                $parent = $(this).parents('dd');
                $input = $parent.find('[nctype="xianshi_image"]');
                $img = $parent.find('[nctype="img_xianshi_image"]');
                if(result.result) {
                    $img.prev('i').hide();
                    $img.attr('src', result.file_url);
                    $img.show();
                    $input.val(result.file_name);
                } else {
                    showError(data.message);
                }
            }
    });

    jQuery.validator.methods.greaterThanDate = function(value, element, param) {
        var date1 = new Date(Date.parse(param.replace(/-/g, "/")));
        var date2 = new Date(Date.parse(value.replace(/-/g, "/")));
        return date1 < date2;
    };
    jQuery.validator.methods.lessThanDate = function(value, element, param) {
        var date1 = new Date(Date.parse(param.replace(/-/g, "/")));
        var date2 = new Date(Date.parse(value.replace(/-/g, "/")));
        return date1 > date2;
    };
    jQuery.validator.methods.greaterThanStartDate = function(value, element) {
        var start_date = $("#start_time").val();
        var date1 = new Date(Date.parse(start_date.replace(/-/g, "/")));
        var date2 = new Date(Date.parse(value.replace(/-/g, "/")));
        return date1 < date2;
    };

    //页面输入内容验证
    $("#add_form").validate({
        errorPlacement: function(error, element){
            var error_td = element.parent('dd').children('span');
            error_td.append(error);
        },
        onfocusout: false,
    	submitHandler:function(form){
    		ajaxpost('add_form', '', '', 'onerror');
    	},
        rules : {
            xianshi_name : {
                required : true
            },
            start_time : {
                required : true,
                greaterThanDate : '<?php echo date('Y-m-d H:i',$output['current_xianshi_quota']['start_time']);?>'
            },
            sc_id: {
            	required : true
            },
            end_time : {
                required : true,
<?php if (!$output['isOwnMall']) { ?>
                lessThanDate : '<?php echo date('Y-m-d H:i',$output['current_xianshi_quota']['end_time']);?>',
<?php } ?>
                greaterThanStartDate : true
            },
            lower_limit: {
                required: true,
                digits: true,
                min: 1
            }
        },
        messages : {
            xianshi_name : {
                required : '<i class="icon-exclamation-sign"></i><?php echo $lang['xianshi_name_error'];?>'
            },
            start_time : {
            required : '<i class="icon-exclamation-sign"></i><?php echo sprintf($lang['xianshi_add_start_time_explain'],date('Y-m-d H:i',$output['current_xianshi_quota']['start_time']));?>',
                greaterThanDate : '<i class="icon-exclamation-sign"></i><?php echo sprintf($lang['xianshi_add_start_time_explain'],date('Y-m-d H:i',$output['current_xianshi_quota']['start_time']));?>'
            },
            sc_id: {
            	required : '<i class="icon-exclamation-sign"></i>请选择特卖分类'
            },
            end_time : {
            required : '<i class="icon-exclamation-sign"></i><?php echo sprintf($lang['xianshi_add_end_time_explain'],date('Y-m-d H:i',$output['current_xianshi_quota']['end_time']));?>',
<?php if (!$output['isOwnMall']) { ?>
                lessThanDate : '<i class="icon-exclamation-sign"></i><?php echo sprintf($lang['xianshi_add_end_time_explain'],date('Y-m-d H:i',$output['current_xianshi_quota']['end_time']));?>',
<?php } ?>
                greaterThanStartDate : '<i class="icon-exclamation-sign"></i><?php echo $lang['greater_than_start_time'];?>'
            },
            lower_limit: {
                required : '<i class="icon-exclamation-sign"></i>购买下限不能为空',
                digits: '<i class="icon-exclamation-sign"></i>购买下限必须为数字',
                min: '<i class="icon-exclamation-sign"></i>购买下限不能小于1'
            }
        }
    });



	$('#goods_demo').click(function(){
		$('#li_1').attr('class','');
		$('#li_2').attr('class','active');
		$('#demo').show();
	});

	$('.des_demo').click(function(){
		if($('#des_demo').css('display') == 'none'){
            $('#des_demo').show();
        }else{
            $('#des_demo').hide();
        }
	});

    $('.des_demo').ajaxContent({
        event:'click', //mouseover
            loaderType:"img",
            loadingMsg:"<?php echo MALL_TEMPLATES_URL;?>/images/loading.gif",
            target:'#des_demo'
    });
});

function insert_editor(file_path){
	KE.appendHtml('goods_body', '<img src="'+ file_path + '">');
}
</script>
