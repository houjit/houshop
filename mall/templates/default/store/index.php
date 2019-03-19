<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<?php if(!$output['store_info']['store_decoration_switch']) {?>
<!--新的主页-->

<div class="wrap boxItem1">
        <p class="part-tit"><span>推荐商品</span></p>
<div class="content feiwa-ss-goods-list feiwa-new-cc">
        <?php if(!empty($output['recommended_goods_list']) && is_array($output['recommended_goods_list'])){?>
        <ul>
          <?php foreach($output['recommended_goods_list'] as $value){?>
          <li>
            <dl>
              <dt><a href="<?php echo urlMall('goods', 'index', array('goods_id'=>$value['goods_id']));?>" class="goods-thumb" target="_blank"><img src="<?php echo thumb($value, 240);?>" alt="<?php echo $value['goods_name'];?>"/></a>
                <ul class="goods-thumb-scroll-show">
                <?php if (is_array($value['image'])) { array_splice($value['image'], 5);?>
                  <?php $i=0;foreach ($value['image'] as $val) {$i++?>
                  <li<?php if($i==1) {?> class="selected"<?php }?>><a href="javascript:void(0);"><img src="<?php echo thumb($val, 60);?>"/></a></li>
                  <?php }?>
                <?php } else {?>
                  <li class="selected"><a href="javascript:void(0)"><img src="<?php echo thumb($value, 60);?>"></a></li>
                <?php }?>
                </ul>
              </dt>
              <dd class="goods-name"><a href="<?php echo urlMall('goods', 'index', array('goods_id'=>$value['goods_id']));?>" title="<?php echo $value['goods_name'];?>" target="_blank"><?php echo $value['goods_name']?></a></dd>
              <dd class="goods-info"><span class="price"><i><?php echo $lang['currency'];?></i> <?php echo ncPriceFormat($value['goods_promotion_price']);?> </span> <span class="goods-sold"><?php echo $lang['show_store_index_be_sold'];?><strong><?php echo $value['goods_salenum'];?></strong> <?php echo $lang['feiwa_jian'];?></span></dd>
              <?php if (C('groupbuy_allow') && $value['goods_promotion_type'] == 1) {?>
              <dd class="goods-promotion"><span>团购商品</span></dd>
              <?php } elseif (C('promotion_allow') && $value['goods_promotion_type'] == 2)  {?>
              <dd class="goods-promotion"><span>限时折扣</span></dd>
              <?php }?>
              </dl>
          </li>
          <?php }?>
        </ul>
        <?php }else{?>
        <div class="nothing">
          <p><?php echo $lang['show_store_index_no_record'];?></p>
        </div>
        <?php }?>
      </div>
        <div class="check-more">
            <a href="<?php echo urlMall('show_store', 'goods_all', array('store_id' => $output['store_info']['store_id']));?>">查看全部商品</a>
        </div>
    </div>
    
    
  <div class="wrap boxItem1">
        <p class="part-tit"><span>最新发布</span></p>
 <div class="content feiwa-ss-goods-list feiwa-new-cc">
        <?php if(!empty($output['new_goods_list']) && is_array($output['new_goods_list'])){?>
        <ul>
          <?php foreach($output['new_goods_list'] as $value){?>
          <li>
            <dl>
              <dt><a href="<?php echo urlMall('goods', 'index', array('goods_id'=>$value['goods_id']));?>" class="goods-thumb" target="_blank"><img src="<?php echo thumb($value, 240)?>" alt="<?php echo $value['goods_name'];?>"/></a>
                <ul class="goods-thumb-scroll-show">
                <?php if (is_array($value['image'])) { array_splice($value['image'], 5);?>
                  <?php $i=0;foreach ($value['image'] as $val) {$i++?>
                  <li<?php if($i==1) {?> class="selected"<?php }?>><a href="javascript:void(0);"><img src="<?php echo thumb($val, 60);?>"/></a></li>
                  <?php }?>
                <?php } else {?>
                  <li class="selected"><a href="javascript:void(0)"><img src="<?php echo thumb($value, 60);?>"></a></li>
                <?php }?>
                </ul>
              </dt>
              <dd class="goods-name"><a href="<?php echo urlMall('goods', 'index', array('goods_id'=>$value['goods_id']));?>" title="<?php echo $value['goods_name'];?>" target="_blank"><?php echo $value['goods_name'];?></a></dd>
              <dd class="goods-info"><span class="price"><i><?php echo $lang['currency'];?></i> <?php echo ncPriceFormat($value['goods_promotion_price']);?> </span> <span class="goods-sold"><?php echo $lang['show_store_index_be_sold'];?><strong><?php echo $value['goods_salenum'];?></strong> <?php echo $lang['feiwa_jian'];?></span></dd>
              <?php if (C('groupbuy_allow') && $value['goods_promotion_type'] == 1) {?>
              <dd class="goods-promotion"><span>团购商品</span></dd>
              <?php } elseif (C('promotion_allow') && $value['goods_promotion_type'] == 2)  {?>
              <dd class="goods-promotion"><span>限时折扣</span></dd>
              <?php }?>
              </dl>
          </li>
          <?php }?>
        </ul>
        <?php }else{?>
        <div class="nothing">
          <p><?php echo $lang['show_store_index_no_record'];?></p>
        </div>
        <?php }?>
      </div>
        <div class="check-more">
            <a href="<?php echo urlMall('show_store', 'goods_all', array('store_id' => $output['store_info']['store_id'], 'key' => '1', 'order' => '2'));?>">查看全部最新</a>
        </div>
    </div>  
    
 <div class="wrap judge" style="padding-bottom:40px ">
        <p class="part-tit"><span>用户口碑</span></p>
                    <div class="judge_lev">
                <div class="juge_info">
                    <div class="star">
                        <span></span>
                        <i style="width: <?php echo $output['store_info']['store_credit_percent'];?>%"></i>
                    </div>
                <span class="star_info"><b><?php echo $output['store_info']['store_credit_average'];?></b>分<i class="blue">来自<?php echo $output['store_info']['evaluate_goods_count'];?>人点评</i></span>
                </div>
            </div>
            <div class="juge_exp">
        <?php  foreach ($output['store_info']['store_credit'] as $value) {?>      
                <span><?php echo $value['text'];?>：<i><?php echo $value['credit'];?></i>分</span>
                <?php } ?>
                <p>点评来自用户用户购买后对购买商品进行的真实有效评价!<i></i></p>
            </div>
                <div class="boxItem5 cleartable">
            <div>
            	<?php if(!empty($output['goods_evaluate_info']) && is_array($output['goods_evaluate_info'])){?>
    	<?php foreach($output['goods_evaluate_info'] as $k=>$v){?>
                                                    <a target="_blank" href="<?php echo urlMall('goods','comments_list',array('goods_id'=> $v['geval_goodsid']));?>">
                                                                    <div class="info_cont left noImg1">
                            <div class="pos_rel">
                                <span class="infoImg2 posLeft"><img src="<?php echo strpos($v['goods_pic'],'http')===0 ? $v['goods_pic']:UPLOAD_SITE_URL."/".ATTACH_GOODS."/".$v['geval_storeid']."/".$v['geval_goodsimage'];?>" alt=""></span>
                                <span class="info_tit1"><?php echo str_cut($v['geval_frommembername'],2).'***';?></span>
                            </div>
                            <p class="info_tit2"><?php echo $v['geval_content'];?> </p>

                            <div class="info_link zoom">
                                <div class="left">
                                    <span><?php echo $v['geval_goodsprice'];?>元</span></div>
                                <span class="right zan">评分<i>(<?php echo $v['geval_scores'];?>)</i></span>
                            </div>
                        </div>
                    </a><?php }}?>
                                </div>
        </div>
        <div class="check-more">
            <a href="<?php echo urlMall('show_store', 'comments_goods', array('store_id' => $output['store_info']['store_id']));?>">查看全部口碑</a>
        </div>
    </div>   
    

<!--新的主页-->
<?php }else{ ?>
<?php 
//加载店铺装修静态页
if(isset($output['decoration_file'])) { 
        require($output['decoration_file']);
} 
?>

<?php if(!$output['store_decoration_only']) {?>
<div class="wrapper mt10">
  <div class="feiwa-ss-main">
    <div class="flexslider">
      <ul class="slides">
        <?php if(!empty($output['store_slide']) && is_array($output['store_slide'])){?>
        <?php for($i=0;$i<5;$i++){?>
        <?php if($output['store_slide'][$i] != ''){?>
        <li><a <?php if($output['store_slide_url'][$i] != '' && $output['store_slide_url'][$i] != 'http://'){?>href="<?php echo $output['store_slide_url'][$i];?>"<?php }?>><img src="<?php echo UPLOAD_SITE_URL.'/'.ATTACH_SLIDE.DS.$output['store_slide'][$i];?>"></a></li>
        <?php }?>
        <?php }?>
        <?php }else{?>
        <li><img src="<?php echo UPLOAD_SITE_URL.'/'.ATTACH_SLIDE.DS;?>f01.jpg"></li>
        <li><img src="<?php echo UPLOAD_SITE_URL.'/'.ATTACH_SLIDE.DS;?>f02.jpg"></li>
        <li><img src="<?php echo UPLOAD_SITE_URL.'/'.ATTACH_SLIDE.DS;?>f03.jpg"></li>
        <li><img src="<?php echo UPLOAD_SITE_URL.'/'.ATTACH_SLIDE.DS;?>f04.jpg"></li>
        <?php }?>
      </ul>
    </div>
    <div class="feiwa-ss-main-container">
      <div class="title"> <span><a href="<?php echo urlMall('show_store', 'goods_all', array('store_id' => $_GET['store_id']));?>" class="more"><?php echo $lang['feiwa_more'];?></a></span>
        <h4><?php echo $lang['show_store_index_recommend'];?></h4>
      </div>
      <div class="content feiwa-ss-goods-list">
        <?php if(!empty($output['recommended_goods_list']) && is_array($output['recommended_goods_list'])){?>
        <ul>
          <?php foreach($output['recommended_goods_list'] as $value){?>
          <li>
            <dl>
              <dt><a href="<?php echo urlMall('goods', 'index', array('goods_id'=>$value['goods_id']));?>" class="goods-thumb" target="_blank"><img src="<?php echo thumb($value, 240);?>" alt="<?php echo $value['goods_name'];?>"/></a>
                <ul class="goods-thumb-scroll-show">
                <?php if (is_array($value['image'])) { array_splice($value['image'], 5);?>
                  <?php $i=0;foreach ($value['image'] as $val) {$i++?>
                  <li<?php if($i==1) {?> class="selected"<?php }?>><a href="javascript:void(0);"><img src="<?php echo thumb($val, 60);?>"/></a></li>
                  <?php }?>
                <?php } else {?>
                  <li class="selected"><a href="javascript:void(0)"><img src="<?php echo thumb($value, 60);?>"></a></li>
                <?php }?>
                </ul>
              </dt>
              <dd class="goods-name"><a href="<?php echo urlMall('goods', 'index', array('goods_id'=>$value['goods_id']));?>" title="<?php echo $value['goods_name'];?>" target="_blank"><?php echo $value['goods_name']?></a></dd>
              <dd class="goods-info"><span class="price"><i><?php echo $lang['currency'];?></i> <?php echo ncPriceFormat($value['goods_promotion_price']);?> </span> <span class="goods-sold"><?php echo $lang['show_store_index_be_sold'];?><strong><?php echo $value['goods_salenum'];?></strong> <?php echo $lang['feiwa_jian'];?></span></dd>
              <?php if (C('groupbuy_allow') && $value['goods_promotion_type'] == 1) {?>
              <dd class="goods-promotion"><span>团购商品</span></dd>
              <?php } elseif (C('promotion_allow') && $value['goods_promotion_type'] == 2)  {?>
              <dd class="goods-promotion"><span>限时折扣</span></dd>
              <?php }?>
              </dl>
          </li>
          <?php }?>
        </ul>
        <?php }else{?>
        <div class="nothing">
          <p><?php echo $lang['show_store_index_no_record'];?></p>
        </div>
        <?php }?>
      </div>
    </div>
    <div class="feiwa-ss-main-container">
      <div class="title"><span><a href="<?php echo urlMall('show_store', 'goods_all', array('store_id' => $_GET['store_id']));?>" class="more"><?php echo $lang['feiwa_more'];?></a></span>
        <h4><?php echo $lang['show_store_index_new_goods'];?></h4>
      </div>
      <div class="content feiwa-ss-goods-list">
        <?php if(!empty($output['new_goods_list']) && is_array($output['new_goods_list'])){?>
        <ul>
          <?php foreach($output['new_goods_list'] as $value){?>
          <li>
            <dl>
              <dt><a href="<?php echo urlMall('goods', 'index', array('goods_id'=>$value['goods_id']));?>" class="goods-thumb" target="_blank"><img src="<?php echo thumb($value, 240)?>" alt="<?php echo $value['goods_name'];?>"/></a>
                <ul class="goods-thumb-scroll-show">
                <?php if (is_array($value['image'])) { array_splice($value['image'], 5);?>
                  <?php $i=0;foreach ($value['image'] as $val) {$i++?>
                  <li<?php if($i==1) {?> class="selected"<?php }?>><a href="javascript:void(0);"><img src="<?php echo thumb($val, 60);?>"/></a></li>
                  <?php }?>
                <?php } else {?>
                  <li class="selected"><a href="javascript:void(0)"><img src="<?php echo thumb($value, 60);?>"></a></li>
                <?php }?>
                </ul>
              </dt>
              <dd class="goods-name"><a href="<?php echo urlMall('goods', 'index', array('goods_id'=>$value['goods_id']));?>" title="<?php echo $value['goods_name'];?>" target="_blank"><?php echo $value['goods_name'];?></a></dd>
              <dd class="goods-info"><span class="price"><i><?php echo $lang['currency'];?></i> <?php echo ncPriceFormat($value['goods_promotion_price']);?> </span> <span class="goods-sold"><?php echo $lang['show_store_index_be_sold'];?><strong><?php echo $value['goods_salenum'];?></strong> <?php echo $lang['feiwa_jian'];?></span></dd>
              <?php if (C('groupbuy_allow') && $value['goods_promotion_type'] == 1) {?>
              <dd class="goods-promotion"><span>团购商品</span></dd>
              <?php } elseif (C('promotion_allow') && $value['goods_promotion_type'] == 2)  {?>
              <dd class="goods-promotion"><span>限时折扣</span></dd>
              <?php }?>
              </dl>
          </li>
          <?php }?>
        </ul>
        <?php }else{?>
        <div class="nothing">
          <p><?php echo $lang['show_store_index_no_record'];?></p>
        </div>
        <?php }?>
      </div>
    </div>
  </div>
  <div class="feiwa-ss-sidebar">
    <?php include template('store/left');?>
  </div>
</div>

<!-- 引入幻灯片JS --> 
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.flexslider-min.js"></script> 
<!-- 绑定幻灯片事件 --> 
<script type="text/javascript">
	$(window).load(function() {
		$('.flexslider').flexslider();


	    // 图片切换效果
	    $('.goods-thumb-scroll-show').find('a').mouseover(function(){
	        $(this).parents('li:first').addClass('selected').siblings().removeClass('selected');
	        var _src = $(this).find('img').attr('src');
	        _src = _src.replace('_60.', '_240.');
	        _src = _src.replace('-60', '-240');
	        $(this).parents('dt').find('.goods-thumb').find('img').attr('src', _src);
	    });
	});
</script>
<?php } ?><?php } ?>
