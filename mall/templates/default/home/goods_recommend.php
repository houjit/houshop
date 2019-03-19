<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="s3-module">
  <div class="title">
    <h3><b>热销推荐</b>本站根据你浏览的分类刷选以下</h3>
  </div>
  <div class="content">
    <?php if(!empty($output['goods_list']) && is_array($output['goods_list'])){ ?>
    <ul class="feiwa-booth-list">
      <?php foreach($output['goods_list'] as $k=>$v){?>
      <li>
        <div class="goods-pic"> <a href="<?php echo urlMall('goods','index',array('goods_id'=>$v['goods_id']));?>" target="_blank"><img alt="" src="<?php echo cthumb($v['goods_image'], 240);?>"></a> </div>

          <div class="goods-name"><a href="<?php echo urlMall('goods','index',array('goods_id'=>$v['goods_id']));?>" title="<?php echo $v['goods_name'];?>" target="_blank">
            <?php if ($v['goods_promotion_type'] == 1){ ?>
            <span>团购</span>
            <?php } elseif ($v['goods_promotion_type'] == 2) { ?>
            
            <?php } ?><span>限时折扣</span>
            <?php echo $v['goods_name'];?></a></div>
          <dd class="goods-price">¥<?php echo ncPriceFormatForList($v['goods_promotion_price']);?><em class="buy-btn"><a href="<?php echo urlMall('goods','index',array('goods_id'=>$v['goods_id']));?>" target="_blank">立即抢购</a></em></dd>
          
        </dl>
      </li>
      <?php } ?>
    </ul>
    <?php } else { ?>
    <div class="noguess">暂无商品向您推荐</div>
    <?php }?>
  </div>
</div>
