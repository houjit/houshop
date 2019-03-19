<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<?php include template('store/info');?>
<div class="feiwa-ss-sidebar-container feiwa-ss-class-bar">
  <div class="title">
    <h4><?php echo $lang['feiwa_goods_class'];?></h4>
  </div>
  <div class="content">
    <p><span><a href="<?php echo urlMall('show_store', 'goods_all', array('store_id' => $output['store_info']['store_id'], 'key' => '1', 'order' => '2'));?>"><?php echo $lang['feiwa_by_new'];?></a></span><span><a href="<?php echo urlMall('show_store', 'goods_all', array('store_id' => $output['store_info']['store_id'], 'key' => '2', 'order' => '2'));?>"><?php echo $lang['feiwa_by_price'];?></a></span><span><a href="<?php echo urlMall('show_store', 'goods_all', array('store_id' => $output['store_info']['store_id'], 'key' => '3', 'order' => '2'));?>"><?php echo $lang['feiwa_by_sale'];?></a></span><span><a href="<?php echo urlMall('show_store', 'goods_all', array('store_id' => $output['store_info']['store_id'], 'key' => '5', 'order' => '2'));?>"><?php echo $lang['feiwa_by_click'];?></a></span></p>
    <div class="feiwa-ss-search">
      <form id="" name="searchMall" method="get" action="index.php" >
        <input type="hidden" name="app" value="show_store" />
        <input type="hidden" name="feiwa" value="goods_all" />
        <input type="hidden" name="store_id" value="<?php echo $output['store_info']['store_id'];?>" />
        <input type="text" class="text w120" name="inkeyword" value="<?php echo $_GET['inkeyword'];?>" placeholder="搜索店内商品">
        <a href="javascript:document.searchMall.submit();" class="ncbtn"><?php echo $lang['feiwa_search'];?></a>
      </form>
    </div>
    <ul class="feiwa-ss-submenu">
      <li><span class="ico-none"><em>-</em></span><a href="<?php echo urlMall('show_store', 'goods_all', array('store_id' => $output['store_info']['store_id']));?>"><?php echo $lang['feiwa_whole_goods'];?></a></li>
      <?php if(!empty($output['goods_class_list']) && is_array($output['goods_class_list'])){?>
      <?php foreach($output['goods_class_list'] as $value){?>
      <?php if(!empty($value['children']) && is_array($value['children'])){?>
      <li><span class="ico-none" onclick="class_list(this);" span_id="<?php echo $value['stc_id'];?>" style="cursor: pointer;"><em>-</em></span><a href="<?php echo urlMall('show_store', 'goods_all', array('store_id' => $output['store_info']['store_id'], 'stc_id' => $value['stc_id']));?>"><?php echo $value['stc_name'];?></a>
        <ul id="stc_<?php echo $value['stc_id'];?>">
          <?php foreach($value['children'] as $value1){?>
          <li><span class="ico-sub">&nbsp;</span><a href="<?php echo urlMall('show_store', 'goods_all', array('store_id' => $output['store_info']['store_id'], 'stc_id' => $value1['stc_id']));?>"><?php echo $value1['stc_name'];?></a></li>
          <?php }?>
        </ul>
      </li>
      <?php }else {?>
      <li> <span class="ico-none"><em>-</em></span><a href="<?php echo urlMall('show_store', 'goods_all', array('store_id' => $output['store_info']['store_id'], 'stc_id' => $value['stc_id']));?>"><?php echo $value['stc_name'];?></a></li>
      <?php }?>
      <?php }?>
      <?php }?>
    </ul>
    
  </div>
</div>
   <?php if(!empty($output['goods_commend']) && is_array($output['goods_commend']) && count($output['goods_commend'])>1){?>
    <div class="feiwa-ss-sidebar-container feiwa-look-look">
      <div class="title">
        <h4>店铺热卖</h4>
      </div>
      <div class="content">
        <ul>
          <?php foreach($output['goods_commend'] as $goods_commend){?>
          <?php if($output['goods']['goods_id'] != $goods_commend['goods_id']){?>
          <li>
            <dl>
              <dt class="goods-name"><a href="<?php echo urlMall('goods', 'index', array('goods_id' => $goods_commend['goods_id']));?>" target="_blank" title="<?php echo $goods_commend['goods_jingle'];?>"><?php echo $goods_commend['goods_name'];?><em><?php echo $goods_commend['goods_jingle'];?></em></a></dt>
              <dd class="goods-pic"><a href="<?php echo urlMall('goods', 'index', array('goods_id' => $goods_commend['goods_id']));?>" target="_blank" title="<?php echo $goods_commend['goods_jingle'];?>"><img src="<?php echo thumb($goods_commend, 240);?>" alt="<?php echo $goods_commend['goods_name'];?>"/></a></dd>
              <dd class="goods-price"><?php echo $lang['currency'];?><?php echo $goods_commend['goods_promotion_price'];?></dd>
            </dl>
          </li>
          <?php }?>
          <?php }?>
        </ul>
        <div class="clear"></div>
      </div>
    </div>
    <?php }?>  	
<div class="feiwa-ss-sidebar-container feiwa-ss-top-bar">
  <div class="title">
    <h4><?php echo $lang['feiwa_goods_rankings'];?></h4>
  </div>
  <div class="content">
    <ul class="feiwa-ss-top-tab pngFix">
      <li id="hot_sales_tab" class="current"><a href="<?php echo urlMall('show_store', 'goods_all', array('store_id' => $output['store_info']['store_id'], 'key' => '3', 'order' => '2'));?>"><?php echo $lang['feiwa_hot_goods_rankings'];?></a></li>
      <li id="hot_collect_tab"><a href="<?php echo urlMall('show_store', 'goods_all', array('store_id' => $output['store_info']['store_id'], 'key' => '4', 'order' => '2'));?>"><?php echo $lang['feiwa_hot_collect_rankings'];?></a></li>
    </ul>
    <div id="hot_sales_list" class="feiwa-ss-top-panel">
      <?php if(is_array($output['hot_sales']) && !empty($output['hot_sales'])){?>
      <ol>
        <?php foreach($output['hot_sales'] as $val){?>
        <li>
          <dl>
            <dt><a href="<?php echo urlMall('goods', 'index',array('goods_id'=>$val['goods_id']));?>"><?php echo $val['goods_name']?></a></dt>
            <dd class="goods-pic"><a href="<?php echo urlMall('goods', 'index', array('goods_id'=>$val['goods_id']));?>"><span class="thumb size60"><i></i><img src="<?php echo thumb($val, 60);?>"  onload="javascript:DrawImage(this,60,60);"></span></a>
              <p><span class="thumb size100"><i></i><img src="<?php echo thumb($val, 240);?>" onload="javascript:DrawImage(this,100,100);" title="<?php echo $val['goods_name']?>"><big></big><small></small></span></p>
            </dd>
            <dd class="price pngFix"><i>￥</i><?php echo ncPriceFormat($val['goods_promotion_price']);?></dd>
            <dd class="selled pngFix"><strong>已售<?php echo $val['goods_salenum'];?></strong></dd>
          </dl>
        </li>
        <?php }?>
      </ol>
      <?php }?>
    </div>
    <div id="hot_collect_list" class="feiwa-ss-top-panel hide">
      <?php if(is_array($output['hot_collect']) && !empty($output['hot_collect'])){?>
      <ol>
        <?php foreach($output['hot_collect'] as $val){?>
        <li>
          <dl>
            <dt><a href="<?php echo urlMall('goods', 'index', array('goods_id'=>$val['goods_id']));?>"><?php echo $val['goods_name']?></a></dt>
            <dd class="goods-pic"><a href="<?php echo urlMall('goods', 'index', array('goods_id'=>$val['goods_id']));?>" title=""><span class="thumb size60"><i></i> <img src="<?php echo thumb($val, 60);?>" onload="javascript:DrawImage(this,60,60);"></span></a>
              <p><span class="thumb size100"><i></i><img src="<?php echo thumb($val, 240);?>" onload="javascript:DrawImage(this,100,100);" title="<?php echo $val['goods_name']?>"><big></big><small></small></span></p>
            </dd>
            <dd class="price pngFix"><i>￥</i><?php echo ncPriceFormat($val['goods_promotion_price']);?></dd>
           <dd class="collection pngFix"><strong><?php echo $val['goods_collect'];?>人已收藏</strong></dd>
          </dl>
        </li>
        <?php }?>
      </ol>
      <?php }?>
    </div>
    <p><a href="<?php echo urlMall('show_store', 'goods_all', array('store_id' => $output['store_info']['store_id']));?>"><?php echo $lang['feiwa_look_more_store_goods'];?></a></p>
  </div>
</div>
<script type="text/javascript">
    $(document).ready(function(){
        //热销排行切换
        $('#hot_sales_tab').on('mouseenter', function() {
            $(this).addClass('current');
            $('#hot_collect_tab').removeClass('current');
            $('#hot_sales_list').removeClass('hide');
            $('#hot_collect_list').addClass('hide');
        });
        $('#hot_collect_tab').on('mouseenter', function() {
            $(this).addClass('current');
            $('#hot_sales_tab').removeClass('current');
            $('#hot_sales_list').addClass('hide');
            $('#hot_collect_list').removeClass('hide');
        });
    });
    /** left.php **/
    // 商品分类
    function class_list(obj){
    	var stc_id=$(obj).attr('span_id');
    	var span_class=$(obj).attr('class');
    	if(span_class=='ico-block') {
    		$("#stc_"+stc_id).show();
    		$(obj).html('<em>-</em>');
    		$(obj).attr('class','ico-none');
    	}else{
    		$("#stc_"+stc_id).hide();
    		$(obj).html('<em>+</em>');
    		$(obj).attr('class','ico-block');
    	}
    }
</script> 
