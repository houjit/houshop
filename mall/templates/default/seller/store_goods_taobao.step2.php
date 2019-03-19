<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<!-- S setp -->

<div class="tabmenu">
  <?php include template('layout/submenu');?>
</div>
</br>
<ul class="add-goods-step">
  <li class="current"><i class="icon icon-list-alt"></i>
    <h6>STEP.1</h6>
    <h2>选择商品分类</h2>
    <i class="arrow icon-angle-right"></i> </li>
  <li><i class="icon icon-edit"></i>
    <h6>STEP.2</h6>
    <h2>复制商品链接</h2>
    <i class="arrow icon-angle-right"></i> </li>
</ul>

<!--S 分类选择区域-->
<div class="wrapper_search">
  <div class="wp_sort">
    <div id="dataLoading" class="wp_data_loading">
      <div class="data_loading"><?php echo $lang['store_goods_step1_loading'];?></div>
    </div>
    <div class="sort_selector">
      <div class="sort_title"><?php echo $lang['store_goods_step1_choose_common_category'];?>
        <div class="text" id="commSelect">
            <div><?php echo $lang['store_goods_step1_please_select'];?></div>
            <div class="select_list" id="commListArea">
              <ul>
                <?php if(is_array($output['staple_array']) && !empty($output['staple_array'])) {?>
                <?php foreach ($output['staple_array'] as $val) {?>
                <li  data-param="{stapleid:<?php echo $val['staple_id']?>}"><span nctype="staple_name"><?php echo $val['staple_name']?></span><a href="JavaScript:void(0);" nctype="del-comm-cate" title="<?php echo $lang['feiwa_delete'];?>">X</a></li>
                <?php }?>
                <?php }?>
                <li id="select_list_no" <?php if (!empty($output['staple_array'])) {?>style="display: none;"<?php }?>><span class="title"><?php echo $lang['store_goods_step1_no_common_category'];?></span></li>
              </ul>
            </div>
        </div>
        <i class="icon-angle-down"></i>
      </div>
    </div>
    <div id="class_div" class="wp_sort_block">
      <div class="sort_list">
        <div class="wp_category_list">
          <div id="class_div_1" class="category_list">
            <ul>
              <?php if(isset($output['goods_class']) && !empty($output['goods_class']) ) {?>
              <?php foreach ($output['goods_class'] as $val) {?>
              <li class="" nctype="selClass" data-param="{gcid:<?php echo $val['gc_id'];?>,deep:1,tid:<?php echo $val['type_id'];?>}"> <a class="" href="javascript:void(0)"><i class="icon-double-angle-right"></i><?php echo $val['gc_name'];?></a></li>
              <?php }?>
              <?php }?>
            </ul>
          </div>
        </div>
      </div>
      <div class="sort_list">
        <div class="wp_category_list blank">
          <div id="class_div_2" class="category_list">
            <ul>
            </ul>
          </div>
        </div>
      </div>
      <div class="sort_list sort_list_last">
        <div class="wp_category_list blank">
          <div id="class_div_3" class="category_list">
            <ul>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="alert">
    <dl class="hover_tips_cont">
      <dt id="commodityspan"><span style="color:#F00;"><?php echo $lang['store_goods_step1_please_choose_category'];?></span></dt>
      <dt id="commoditydt" style="display: none;" class="current_sort"><?php echo $lang['store_goods_step1_current_choose_category'];?><?php echo $lang['feiwa_colon'];?></dt>
      <dd id="commoditydd"></dd>
    </dl>
  </div>
  <div class="wp_confirm">
    <form method="get">
   
      <input type="hidden" name="app" value="taobao_caiji" />
      <input type="hidden" name="feiwa" value="batchco2" />
      <input type="hidden" name="commonid" value="<?php echo $output['commonid'];?>" />
      <input type="hidden" name="ref_url" value="<?php echo $_GET['ref_url'];?>" />
      <input type="hidden" name="class_id" id="class_id" value="" />
      <input type="hidden" name="t_id" id="t_id" value="" />
      <div class="bottom tc">
      <label class="submit-border"><input disabled="disabled" nctype="buttonNextStep" value="<?php echo '下一步';?>，粘贴商品ID" type="submit" class="submit"style=" width: 200px;" /></label>
      </div>
    </form>
  </div>
</div>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/common_select.js"></script> 
<script src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.mousewheel.js"></script> 
<script src="<?php echo MALL_RESOURCE_SITE_URL;?>/js/store_goods_add.step1.js"></script> 
<script>
SEARCHKEY = '<?php echo $lang['store_goods_step1_search_input_text'];?>';
RESOURCE_SITE_URL = '<?php echo RESOURCE_SITE_URL;?>';
</script>
<script>
// 选择商品分类
function selClass($this){

    $('.wp_category_list').css('background', '');

    $("#commodityspan").hide();
    $("#commoditydt").show();
    $("#commoditydd").show();
    $this.siblings('li').children('a').attr('class', '');
    $this.children('a').attr('class', 'classDivClick');
    var data_str = '';
    eval('data_str = ' + $this.attr('data-param'));
    $('#class_id').val(data_str.gcid);
    $('#t_id').val(data_str.tid);
    $('#dataLoading').show();
    var deep = parseInt(data_str.deep) + 1;
    
    $.getJSON('index.php?app=store_goods_add&feiwa=ajax_goods_class', {gc_id : data_str.gcid, deep: deep}, function(data) {
        if (data != null) {
            $('input[nctype="buttonNextStep"]').attr('disabled', true);
            $('#class_div_' + deep).children('ul').html('').end()
                .parents('.wp_category_list:first').removeClass('blank')
                .parents('.sort_list:first').nextAll('div').children('div').addClass('blank').children('ul').html('');
            $.each(data, function(i, n){
                $('#class_div_' + deep).children('ul').append('<li data-param="{gcid:'
                        + n.gc_id +',deep:'+ deep +',tid:'+ n.type_id +'}"><a class="" href="javascript:void(0)"><i class="icon-double-angle-right"></i>'
                        + n.gc_name + '</a></li>')
                        .find('li:last').click(function(){
                            selClass($(this));
                        });
            });
        } else {
            $('#class_div_' + data_str.deep).parents('.sort_list:first').nextAll('div').children('div').addClass('blank').children('ul').html('');
            disabledButton();
        }
        // 显示选中的分类
        showCheckClass();
        $('#dataLoading').hide();
    });
}
function disabledButton() {
    if ($('#class_id').val() != '') {
        $('input[nctype="buttonNextStep"]').attr('disabled', false).css('cursor', 'pointer');
    } else {
        $('input[nctype="buttonNextStep"]').attr('disabled', true).css('cursor', 'auto');
    }
}

$(function(){
    //自定义滚定条
    $('#class_div_1').perfectScrollbar();
    $('#class_div_2').perfectScrollbar();
    $('#class_div_3').perfectScrollbar();

    // ajax选择分类
    $('li[nctype="selClass"]').click(function(){
        selClass($(this));
    });

    // 返回分类选择
    $('a[feiwa_type="return_choose_sort"]').unbind().click(function(){
        $('#class_id').val('');
        $('#t_id').val('');
        $("#commodityspan").show();
        $("#commoditydt").hide();
        $('#commoditydd').html('');
        $('.wp_search_result').hide();
        $('.wp_sort').show();
    });
    
    // 常用分类选择 展开与隐藏
    $('#commSelect').hover(
        function(){
            $('#commListArea').show();
        },function(){
            $('#commListArea').hide();
        }
    );
    
    // 常用分类选择
    $('#commListArea').find('span[nctype="staple_name"]').die().live('click',function() {
        $('#dataLoading').show();
        $('.wp_category_list').addClass('blank');
        $this = $(this);
        eval('var data_str = ' + $this.parents('li').attr('data-param'));
        $.getJSON('index.php?app=store_goods_add&feiwa=ajax_show_comm&stapleid=' + data_str.stapleid, function(data) {
            if (data.done) {
                $('.category_list').children('ul').empty();
                if (data.one.length > 0) {
                    $('#class_div_1').children('ul').append(data.one).parents('.wp_category_list').removeClass('blank');
                }
                if (data.two.length > 0) {
                    $('#class_div_2').children('ul').append(data.two).parents('.wp_category_list').removeClass('blank');
                }
                if (data.three.length > 0) {
                    $('#class_div_3').children('ul').append(data.three).parents('.wp_category_list').removeClass('blank');
                }
                // 绑定ajax选择分类事件
                $('#class_div').find('li[nctype="selClass"]').click(function(){
                    selClass($(this));
                });
                $('#class_id').val(data.gc_id);
                $('#t_id').val(data.type_id);
                $("#commodityspan").hide();
                $("#commoditydt").show();
                // 显示选中的分类
                showCheckClass();
                $('#commSelect').children('div:first').html($this.text());
                disabledButton();
                $('#commListArea').hide();
            } else {
                $('.wp_category_list').css('background', '#E7E7E7 none');
                $('#commListArea').find('li').css({'background' : '', 'color' : ''});
                $this.parent().css({'background' : '#3399FD', 'color' : '#FFF'});
            }
        });
        $('#dataLoading').hide();
    });
    
    // ajax删除常用分类
    $('#commListArea').find('a[nctype="del-comm-cate"]').die().live('click',function() {
        $this = $(this);
        eval('var data_str = ' + $this.parents('li').attr('data-param'));
        $.getJSON('index.php?app=store_goods_add&feiwa=ajax_stapledel&staple_id='+ data_str.stapleid, function(data) {
            if (data.done) {
                $this.parents('li:first').remove();
                if ($('#commListArea').find('li').length == 1) {
                    $('#select_list_no').show();
                }
            } else {
                alert(data.msg);
            }
        });
    });
});
// 显示选中的分类
function showCheckClass(){
    var str = "";
    $.each($('a[class=classDivClick]'), function(i) {
        str += $(this).text() + '<i class="icon-double-angle-right"></i>';
    });
    str = str.substring(0, str.length - 39);
    $('#commoditydd').html(str);
}
</script> 