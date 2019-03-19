<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<script>var PURL = '<?php echo $output['purl'];?>';$(document).ready(function(){ $('#area_info').feiwa_region();});</script>
<link href="<?php echo MALL_TEMPLATES_URL;?>/css/feiwa-main.css" rel="stylesheet" type="text/css">
<link href="<?php echo RESOURCE_SITE_URL;?>/js/jcarousel/skins/tango/skin.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo MALL_RESOURCE_SITE_URL.'/js/Jquery.Query.js';?>" charset="utf-8"></script>
<script type="text/javascript">
//<!CDATA[
/* 替换参数 */
function ss_replaceParam(key, value)
{
    location.assign($.query.set('key', key).set('order', value));
}

/* 替换参数 */
function ss_dropParam(key1, key2)
{
	location.assign($.query.REMOVE(key1).REMOVE(key2));
}

/* 替换参数 */
function ss_dropParam2(key1)
{
	location.assign($.query.REMOVE(key1));
}

/* 替换参数 */
function ss_replaceParam2(key, value)
{
    location.assign($.query.set(key, value, value));
}

$(function (){
    var order = '<?php echo $_GET['order'];?>';
    var arrow = '';
    var class_val = 'sort_desc';

    switch (order){
        case 'store_credit desc' : order = 'store_credit asc';  class_val = 'sort_desc'; break;
        case 'store_credit asc'  : order = 'store_credit desc'; class_val = 'sort_asc' ; break;
        default : order = 'store_credit asc';
    }
    $('#credit_grade').addClass(class_val);
    $('#credit_grade').click(function(){query('order', order);return false;});
}
);

function query(name, value){
    $("input[name='"+name+"']").val(value);
    $('#searchStore').submit();
}

//]]>
</script>

	    <div class="feiwa-module feiwa-new-list zoom">
    	<div class="pageTab">
            <a href="<?php echo urlMall('search','index');?>" class="item1">找商品</a>
            <a href="<?php echo urlMall('store_list');?>" class="item2 now">找店铺</a>
        </div>
    <?php if(!empty($output['class_list']) && is_array($output['class_list'])){?>    
   <div class="filter-item area">
            <div class="item-cont">
                <span class="item-tit feiwa-left">分类</span>
                <dl class="feiwa-left item-links">
                    <dt class="feiwa-left all"><a href="<?php echo urlMall('store_list','index');?>" class="now">不限</a></dt>
                    <dd class="feiwa-left eachLink leftA">
                        <div class="clearfix">
                        	      <?php foreach($output['class_list'] as $k=>$v){?>
	      <?php if ($_GET['cate_id'] == $v['sc_parent_id']){?>
	      <span><a href="<?php echo urlMall('store_list','index',array('cate_id'=>$k));?>"><?php echo $v['sc_name'];?></a></span>
	      <?php }elseif (!isset($v['child']) && $output['class_list'][$_GET['cate_id']]['sc_parent_id'] == $v['sc_parent_id']){?>
	      <span><a href="<?php echo urlMall('store_list','index',array('cate_id'=>$k));?>"><?php echo $v['sc_name'];?></a></span>
	      <?php }?>
      <?php }?>     
                                                </div>
                    </dd>
                </dl>
            </div>
        </div>     
        <?php }?>
        	
    <div class="filter-item moreItem">
            <div class="item-cont">
                <span class="item-tit">更多</span>
                      <form id="store_list" method="GET" action="index.php">
        <input type="hidden" name="order" value="<?php echo $_GET['order'];?>"/>
        <input type="hidden" name="app" value="store_list"/>
        <input type="hidden" name="cate_id" value="<?php echo $_GET['cate_id'];?>"/>
                <?php if (!C('fullindexer.open')){?> <div class="feiwa-left pos-re feiwa-m">
                <input id="area_info" name="area_info" type="hidden" value=""/>
<div class="feiwa-newinput">
                       <input class="text" type="text" name="keyword" value="<?php echo $_GET['keyword'];?>" placeholder="请输入店铺名称"/>
                    </div>
                </div>
                 <input class="btn" type="submit" value="<?php echo $lang['feiwa_search'];?>" /><?php }?>
                <div class="clear"></div>
            </div>
        </div>
        </form>
        </div>

<div class="wrapper  feiwa-new-st">
        <div class="feiwa-left w965">
            <!--排序-->
            <div class="sort zoom f14">
                <p class="sort-item">
                    <a href="javascript:void(0)" onClick="javascript:ss_dropParam('key','order');"  <?php if(!$_GET['key']){?>class="now"<?php }?>>默认</a>
                    <!-- <a href="">好评</a> -->
                    <a href="javascript:void(0)" onClick="javascript:ss_replaceParam('store_sales','<?php echo ($_GET['order'] == 'desc' && $_GET['key'] == 'store_sales')?'asc':'desc' ?>');" <?php if($_GET['key'] == 'store_sales'){?>class="now"<?php }?>>销量</a>
                   <a href="javascript:void(0)" onClick="javascript:ss_replaceParam('store_credit','<?php  echo ($_GET['order'] == 'desc' && $_GET['key'] == 'store_credit')?'asc':'desc' ?>');" <?php if($_GET['key'] == 'store_credit'){?>class="now"<?php }?>>信用</a>
                </p>
            </div>
            <!--//排序-->
            <!--店铺列表-->
            <div class="storesList feiwa-bs">
<?php if(!empty($output['store_list']) && is_array($output['store_list'])){?>
<?php foreach($output['store_list'] as $skey => $store){?>
                                <dl>
                    <dt class="storesinfo clearfix">
                        <a target="_blank" href="<?php echo urlMall('show_store','index', array('store_id'=>$store['store_id']),$store['store_domain']);?>" class="storesimg" title="<?php echo $store['store_name'];?>">
                            <img src="<?php echo getStoreLogo($store['store_label']);?>" alt="<?php echo $store['store_name'];?>" title="<?php echo $store['store_name'];?>">
                        </a>
                        <div class="storesrelated">
                            <span class="item1"><a target="_blank" href="<?php echo urlMall('show_store','index', array('store_id'=>$store['store_id']),$store['store_domain']);?>"><?php echo $store['store_name'];?></a></span>
                            <div class="item2">
                                <div class="inline"><i>资质：</i><b><?php if($store['is_own_mall']==1){;?>本站自营<?php }else{?>第三方店铺<?php }?></b></div>
                                                             
                                                            </div>
                            <span class="item2"><i>地址：</i><b><?php echo $store['store_address'];?></b></span>
                            <a target="_blank" href="<?php echo urlMall('show_store','index', array('store_id'=>$store['store_id']),$store['store_domain']);?>" class="item3">查看店铺</a>
                        </div>

                                                <div class="storescase feiwa-right">
                            <div class="feiwa-left">
                                <span class="levNum"><em><?php echo $store['store_credit_average'];?></em>分</span>
                                <p><em class="levbox"><i></i><b style="width:<?php echo $store['store_credit_percent'];?>%"></b></em></p>
                                <a href="<?php echo urlMall('show_store','index', array('store_id'=>$store['store_id']),$store['store_domain']);?>" class="c999" target="_blank">已有<?php echo $store['store_collect'];?>人关注</a>
                            </div>
                            <div class="feiwa-right">
                            	<?php  foreach ($store['store_credit'] as $key=>$value) {?>
                                                                    <span><i><?php echo $value['text'];?>：</i><?php echo $value['credit'];?>分</span><?php } ?>
                                                            </div>
                        </div>
                                            </dt> 
                    <?php if(!empty($store['search_list_goods']) && is_array($store['search_list_goods'])){?>
                                        <dd class="goods-serv stores-serv zoom">
                        <p>
                            <span class="item1">商品名称</span>
                            <span class="item5">已收藏</span>
                            <span class="item2">本月已销售</span>
                            <span class="item3">市场价</span>
                            <span class="item4">惊喜价</span>
                        </p>

        <?php foreach($store['search_list_goods'] as $k=>$v){?>
                                                <a href="<?php echo urlMall('goods','index',array('goods_id'=>$v['goods_id']));?>" target="_blank" title="<?php echo $v['goods_name'];?>">
                            <span class="item1"><?php echo $v['goods_name'];?></span>
                            <span class="item5"><?php echo $v['goods_collect'];?>人</span>
                            <span class="item2"><?php echo $v['goods_salenum'];?>件</span>
                            <span class="item3"><del>￥<?php echo $v['goods_marketprice'];?></del></span>
                            <span class="item4"><em>￥<?php echo $v['goods_promotion_price'];?></em></span>
                        </a> <?php }?>
<div class="checkMore"><a target="_blank" href="<?php echo urlMall('show_store','index', array('store_id'=>$store['store_id']),$store['store_domain']);?>">更多<?php echo ($tmp = $store['goods_count']) ? $tmp  : $lang['feiwa_common_goods_null'];?>款商品，买吗&gt;&gt;</a></div>
                                            </dd><?php }?>
                                    </dl><?php }?>
<?php }?>
                     
                            </div>
            <!--//店铺列表-->
 <!--翻页-->
<div class="pagination"> <?php echo $output['show_page'];?> </div>
            <!--//翻页-->
        </div>

        <div class="feiwa-right w220">
            <div class="mb15">
                <a href="#" target="_blank"><img src="<?php echo MALL_SITE_URL;?>/img/whyYw.jpg" alt="" class="mb15"></a>
            </div>
            <!--销量排行-->
            <?php if(!empty($output['goods_list']) && is_array($output['goods_list'])){$i=0?>
            <div class="w218 sales feiwa-bs">
                <p class="sideTit">销量排行</p>
                <?php foreach ($output['goods_list'] as $k=>$v){$i++?>
                                    <a target="_blank" class="rank-item" href="<?php echo urlMall('goods','index',array('goods_id'=>$v['goods_id'])); ?>">
                        <span class="babyImg"><img alt="<?php echo $v['goods_name']; ?>" src="<?php echo thumb($v, 240); ?>"><i class="icon"><?php echo $i;?></i></span>
                        <div class="babyInfo">
                            <p><?php echo $v['goods_name']; ?></p>
                            <span><i class="pink left">￥<?php echo $v['goods_promotion_price']; ?></i></span>
                        </div>
                    </a><?php }?>
        
                            </div><?php }?>
           
            <div class="for-fix">
                <div class="mb15">
                    <a href="#" target="_blank"><img src="<?php echo MALL_SITE_URL;?>/img/taoListApp.jpg" alt=""></a>
                </div>
                <div class="mb15">
                    <a href="#" target="_blank"><img src="<?php echo MALL_SITE_URL;?>/img/pei.jpg" alt=""></a>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/waypoints.js"></script> 
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/jcarousel/jquery.jcarousel.min.js"></script> 

<script type="text/javascript">
$(function(){
	//图片轮换
    $('[feiwa_type="jcarousel"]').jcarousel({visible: 4});
    $('[attr="morep"]').click(function(){
    	var id = $(this).attr('feiwa_type');
    	if($(this).attr('class')=='more-off'){
    		$(this).addClass('more-on').removeClass('more-off').html('切换为小图<i></i>');
    		$('div[feiwa_type="goods_all"]').show();
    	}else{
    		$(this).addClass('more-off').removeClass('more-on').html('切换为大图<i></i>');
    		$('div[feiwa_type="goods_all"]').hide();
    	}
    });
   
});
</script>
