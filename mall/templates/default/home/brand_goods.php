<?php defined('INSYSVIEW') or exit('Access Invalid!');?>


<script>
var PURL = [<?php echo $output['purl'];?>];
</script>
<link href="<?php echo MALL_TEMPLATES_URL;?>/css/layout.css" rel="stylesheet" type="text/css">
<script src="<?php echo MALL_RESOURCE_SITE_URL.'/js/search_goods.js';?>"></script>
<link href="<?php echo MALL_TEMPLATES_URL;?>/css/feiwa-main.css" rel="stylesheet" type="text/css">
<div class="container wrapper"><div class="feiwa-ht-brand2"><img class="detailImg" src="<?php echo $output['brand_int']['brand_bgpic'];?>"><div class="content"><div class="info"><img class="logo" src="<?php echo brandImage($output['brand_int']['brand_pic']);?>"><div class="bname"><h1 class="title"><?php echo $output['brand_int']['brand_name'];?></h1>
<p class="sold">在售商品<span><?php if(!empty($output['goods_num'])){;?><?php echo $output['goods_num']?><?php }else{?>0<?php }?></span>个</p></div>
</div><div class="intro"><p><?php echo $output['brand_int']['brand_introduction'];?></p><div class="focus"><span class="follow" id="followBtn" data-bid="<?php echo $output['brand_int']['brand_id'];?>"><b></b>&nbsp;关注该品牌</span></div></div></div></div>

 
    <div class="mall_con_list" id="main-nav-holder">
      <nav class="sort-bar" id="main-nav">
        <div class="sortbar-array"> 排序方式：
          <ul class="array">
            <li <?php if(!$_GET['key']){?>class="selected"<?php }?>><a href="<?php echo dropParam(array('order', 'key'));?>" class="nobg" title="<?php echo $lang['brand_index_default_sort'];?>"><?php echo $lang['brand_index_default'];?></a></li>
            <li <?php if($_GET['key'] == '1'){?>class="selected"<?php }?>><a href="<?php echo ($_GET['order'] == '2' && $_GET['key'] == '1') ? replaceParam(array('key' => '1', 'order' => '1')):replaceParam(array('key' => '1', 'order' => '2')); ?>" <?php if($_GET['key'] == '1'){?>class="<?php echo $_GET['order'] == 1 ? 'asc' : 'desc';?>"<?php }?> title="<?php echo ($_GET['order'] == 'desc' && $_GET['key'] == '1')?$lang['brand_index_sold_asc']:$lang['brand_index_sold_desc']; ?>"><?php echo $lang['brand_index_sold'];?><i></i></a></li>
            <li <?php if($_GET['key'] == '2'){?>class="selected"<?php }?>><a href="<?php echo ($_GET['order'] == '2' && $_GET['key'] == '2') ? replaceParam(array('key' => '2', 'order' => '1')):replaceParam(array('key' => '2', 'order' => '2')); ?>" <?php if($_GET['key'] == '2'){?>class="<?php echo $_GET['order'] == 1 ? 'asc' : 'desc';?>"<?php }?> title="<?php  echo ($_GET['order'] == 'desc' && $_GET['key'] == '2')?$lang['brand_index_click_asc']:$lang['brand_index_click_desc']; ?>"><?php echo $lang['brand_index_click']?><i></i></a></li>
            <li <?php if($_GET['key'] == '3'){?>class="selected"<?php }?>><a href="<?php echo ($_GET['order'] == '2' && $_GET['key'] == '3') ? replaceParam(array('key' => '3', 'order' => '1')):replaceParam(array('key' => '3', 'order' => '2')); ?>" <?php if($_GET['key'] == '3'){?>class="<?php echo $_GET['order'] == 1 ? 'asc' : 'desc';?>"<?php }?> title="<?php echo ($_GET['order'] == 'desc' && $_GET['key'] == '3')?$lang['brand_index_price_asc']:$lang['brand_index_price_desc']; ?>"><?php echo $lang['brand_index_price'];?><i></i></a></li>
          </ul>
        </div>
        <div class="sortbar-filter" feiwa_type="more-filter">
        <span class="arrow"></span>
          <ul>
            <li><a href="<?php if ($_GET['type'] == 1) { echo dropParam(array('type'));} else { echo replaceParam(array('type' => '1'));}?>" <?php if ($_GET['type'] == 1) {?>class="selected"<?php }?>><i></i>平台自营</a></li>
            <li><a href="<?php if ($_GET['gift'] == 1) { echo dropParam(array('gift'));} else { echo replaceParam(array('gift' => '1'));}?>" <?php if ($_GET['gift'] == 1) {?>class="selected"<?php }?>><i></i>赠品</a></li>
            <!-- 消费者保障服务 -->
            <?php if($output['contract_item']){?>
            <?php foreach($output['contract_item'] as $citem_k=>$citem_v){ ?>
            <li><a mzf="sqde" href="<?php if (in_array($citem_k,$output['search_ci_arr'])){ echo removeParam(array('ci' => $citem_k));} else { echo replaceParam(array("ci" => $output['search_ci_str'].$citem_k));}?>" <?php if (in_array($citem_k,$output['search_ci_arr'])) {?>class="selected"<?php }?>><i></i><?php echo $citem_v['cti_name']; ?></a></li>
            <?php }?>
            <?php }?>
          </ul>
        </div>
   <div class="sortbar-location">商品所在地：
          <div class="select-layer">
            <div class="holder"><em feiwa_type="area_name"><?php echo $lang['brand_index_area']; ?><!-- 所在地 --></em></div>
            <div class="selected"><a feiwa_type="area_name"><?php echo $lang['brand_index_area']; ?><!-- 所在地 --></a></div>
            <i class="direction"></i>
            <ul class="options">
              <?php require(BASE_TPL_PATH.'/home/goods_class_area.php');?>
            </ul>
          </div>
        </div>
        <div class="pagination"> <?php echo $output['show_page1']; ?> </div>
      </nav>

      <!-- 商品列表循环  -->
      <?php require_once (BASE_TPL_PATH.'/home/goods.squares.php');?>
      <div class="tc mt20 mb20">
        <div class="pagination"> <?php echo $output['show_page']; ?> </div>
      </div>
   

    <!-- 猜你喜欢 -->
    <div id="guesslike_div" style="width:1200px;"></div>
  </div>
</div>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/waypoints.js"></script> 
<script src="<?php echo MALL_RESOURCE_SITE_URL;?>/js/search_category_menu.js"></script> 
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/fly/jquery.fly.min.js" charset="utf-8"></script> 
<!--[if lt IE 10]>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/fly/requestAnimationFrame.js" charset="utf-8"></script>
<![endif]-->
<script src="<?php echo RESOURCE_SITE_URL;?>/js/waypoints.js"></script>
<script>
$(function(){
 //浮动导航  waypoints.js
    $('#main-nav-holder').waypoint(function(event, direction) {
        $(this).parent().toggleClass('sticky', direction === "down");
        event.stopPropagation();
    });
    //浏览历史处滚条
	$('#nchSidebarViewed').perfectScrollbar({suppressScrollX:true});
  	//猜你喜欢
	$('#guesslike_div').load('<?php echo urlMall('search', 'get_guesslike', array()); ?>', function(){
        $(this).show();
    });

    //复选框筛选
    $("[feiwa_type='more-filter']").mouseover(function(){
        $("[feiwa_type='more-filter']").addClass('box-hover');
    });
    $("[feiwa_type='more-filter']").mouseout(function(){
        $("[feiwa_type='more-filter']").removeClass('box-hover');
    });
    
});
<?php if(isset($_GET['area_id']) && intval($_GET['area_id']) > 0){?>
$(function(){
    // 选择地区后的地区显示
    $('[feiwa_type="area_name"]').html('<?php echo $output['province_array'][intval($_GET['area_id'])]; ?>');
});
<?php }?>
</script>
