<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<!--看了又看 S-->

<div class="feiwa-look-slider">
    <div class="picScroll-top">
        <div class="slider_title">
            <h3>看了又看</h3>
            <span></span>
             </div>
        <div class="bd"><?php if(!empty($output['goods_rand_list']) && is_array($output['goods_rand_list']) && count($output['goods_rand_list'])>1){?>
            <ul class="picList da-thumbs" id="da-thumbs">
          <?php foreach ((array) $output['goods_rand_list'] as $g) { ?>
          <li>
            <dl>
              <dd class="goods-pic"><a href="<?php echo urlMall('goods', 'index', array('goods_id' => $g['goods_id'], )); ?>" target="_blank" title="<?php echo $goods_commend['goods_jingle'];?>"><img src="<?php echo cthumb($g['goods_image'], 240); ?>"/></a></dd>
              <dd class="goods-price"><?php echo $lang['currency'];?><?php echo ncPriceFormat($g['goods_promotion_price']); ?></dd>
            </dl>
          </li>
          <?php }?>
            </ul><?php }?>
        </div>
        <div class="hd">
                <a class="next"></a><a class="prev"></a></div>
    </div>
</div>