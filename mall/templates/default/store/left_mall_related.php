<?php defined('INSYSVIEW') or exit('Access Invalid!'); ?>
<?php if ($output['mr_rel_gc']) { ?>

<div class="feiwa-ss-sidebar-container feiwa-ss-class-bar">
  <div class="title">
    <h4>相关分类</h4>
  </div>
  <div class="content">
    <ul class="feiwa-ss-mall-category-list">
      <?php foreach ((array) $output['mr_rel_gc'] as $v) { ?>
      <li><a href="<?php echo urlMall('search', 'index', array('cate_id'=> $v['gc_id'])); ?>" title="<?php echo $v['gc_name']; ?>"><?php echo $v['gc_name']; ?></a></li>
      <?php } ?>
    </ul>
  </div>
</div>
<?php } ?>
<?php if ($output['mr_rel_brand']) { ?>
<div class="feiwa-ss-sidebar-container feiwa-ss-class-bar">
  <div class="title">
    <h4>相关品牌</h4>
  </div>
  <div class="content">
    <ul class="feiwa-ss-mall-brand-list">
      <?php foreach ((array) $output['mr_rel_brand'] as $v) { ?>
      <li><a href="<?php echo urlMall('brand', 'list', array('brand'=> $v['brand_id'])); ?>" title="<?php echo $v['brand_name']; ?>"><?php echo $v['brand_name']; ?></a></li>
      <?php } ?>
    </ul>
  </div>
</div>
<?php } ?>
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
<?php if ($output['mr_hot_sales']) { ?>
<div class="feiwa-ss-sidebar-container feiwa-ss-top-bar">
  <div class="title">
    <h4><?php echo $output['mr_hot_sales_gc_name']; ?>热销排行榜</h4>
  </div>
  <div class="content">
    <div id="hot_sales_list" class="feiwa-ss-top-panel">
      <ol>
        <?php foreach ((array) $output['mr_hot_sales'] as $g) { ?>
        <li>
          <dl>
            <dt><a href="<?php echo urlMall('goods', 'index', array('goods_id' => $g['goods_id'])); ?>"><?php echo $g['goods_name']; ?></a></dt>
            <dd class="goods-pic"><a href="<?php echo urlMall('goods', 'index', array('goods_id' => $g['goods_id'])); ?>"><span class="thumb size60"><i></i><img src="<?php echo thumb($g, 60); ?>"  onload="javascript:DrawImage(this,60,60);"></span></a>
              <p><span class="thumb size100"><i></i><img src="<?php echo thumb($g, 240); ?>" onload="javascript:DrawImage(this,100,100);" title="<?php echo $g['goods_name']; ?>"><big></big><small></small></span></p>
            </dd>
            <dd class="price pngFix"><?php echo ncPriceFormat($g['goods_promotion_price']); ?></dd>
          </dl>
        </li>
        <?php } ?>
      </ol>
    </div>
  </div>
</div>
<?php } ?>
<?php if ($output['mr_rec_products']) { ?>
<div class="feiwa-ss-sidebar-container feiwa-ss-top-bar">
  <div class="title">
    <h4>推荐商品</h4>
  </div>
  <div id="hot_sales_list" class="content">
    <ul class="feiwa-ss-mall-booth-list">
      <?php foreach ((array) $output['mr_rec_products'] as $g) { ?>
      <li>
        <div class="goods-pic"><a href="<?php echo urlMall('goods', 'index', array('goods_id' => $g['goods_id'])); ?>"><img src="<?php echo thumb($g, 240); ?>"></a></div>
        <div class="goods-name"><a href="<?php echo urlMall('goods', 'index', array('goods_id' => $g['goods_id'])); ?>"><?php echo $g['goods_name']; ?></a></div>
        <div class="goods-price"><?php echo ncPriceFormat($g['goods_promotion_price']); ?></div>
      </li>
      <?php } ?>
    </ul>
  </div>
</div>
<?php } ?>
