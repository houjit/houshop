<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<style type="text/css">
#box { background: #FFF; width: 238px; height: 410px; margin: -390px 0 0 0; display: block; border: solid 4px #D93600; position: absolute; z-index: 999; opacity: .5 }
.mallMenu { position: fixed; z-index: 1; right: 25%; top: 0; }
</style>
<div class="squares" feiwa_type="current_display_mode">
  <input type="hidden" id="lockcompare" value="unlock" />
  <?php if(!empty($output['goods_list']) && is_array($output['goods_list'])){?>
  <ul class="list_pic">
    <?php foreach($output['goods_list'] as $value){?>
    <li class="item">
      <div class="goods-content" nctype_goods=" <?php echo $value['goods_id'];?>" nctype_store="<?php echo $value['store_id'];?>">
        <div class="goods-pic"><a href="<?php echo urlMall('goods','index',array('goods_id'=>$value['goods_id']));?>" target="_blank" title="<?php echo $value['goods_name'];?>"><img feiwa-url="<?php echo cthumb($value['goods_image'], 360,$value['store_id']);?>"   rel='lazy' src="<?php echo MALL_SITE_URL;?>/img/loading.gif"  title="<?php echo $value['goods_name'];?>" alt="<?php echo $value['goods_name'];?>" /></a></div>
        <?php if (C('groupbuy_allow') && $value['goods_promotion_type'] == 1) {?>
        <div class="goods-promotion"><span>抢购</span></div>
        <?php } elseif (C('promotion_allow') && $value['goods_promotion_type'] == 2)  {?>
        <div class="goods-promotion"><span>限时</span></div>
        <?php }?>

                  <div class="goods-sub">
            <?php if ($value['is_virtual'] == 1) {?>
            <span class="virtual" title="虚拟兑换商品">虚拟兑换</span>
            <?php }?>
            <?php if ($value['is_fcode'] == 1) {?>
            <span class="fcode" title="F码优先购买商品">F码优先</span>
            <?php }?>
            <?php if ($value['is_book'] == 1) {?>
            <span class="book" title="支付定金预定商品">预定</span>
            <?php }?>
            <?php if ($value['is_presell'] == 1) {?>
            <span class="presell" title="预售购买商品">预售</span>
            <?php }?>
            <?php if ($value['have_gift'] == 1) {?>
            <span class="gift" title="捆绑赠品">赠品</span>
            <?php }?>
            <?php if ($value['ifpf']==1) {?>
            <span class="book" title="批发">批发</span>
            <?php }?>
            <span class="goods-compare" feiwa_type="compare_<?php echo $value['goods_id'];?>" data-param='{"gid":"<?php echo $value['goods_id'];?>"}'><i></i>加入对比</span> </div>
		<?php /*?> <div class="goods-pic-scroll-show">
            <ul>
              <?php if(!empty($value['image'])) { array_splice($value['image'], 5);?>
              <?php $i=0;foreach ($value['image'] as $val) {$i++?>
              <li<?php if($i==1) {?> class="selected"<?php }?>><a href="javascript:void(0);"><img src="<?php echo cthumb($val, 60,$value['store_id']);?>"/></a></li>
              <?php }?>
              <?php } else {?>
              <li class="selected"><a href="javascript:void(0);"><img src="<?php echo cthumb($value['goods_image'], 60,$value['store_id']);?>" /></a></li>
              <?php }?>
            </ul>
          </div><?php */?>
        <div class="goods-info clearfix">
                   <div class="goods-price"> <em class="sale-price" title="<?php echo $lang['goods_class_index_store_goods_price'].$lang['feiwa_colon'].$lang['currency'].ncPriceFormat($value['goods_promotion_price']);?>"><i><?php echo '¥';?> </i><?php echo ncPriceFormat($value['goods_promotion_price']);?></em> <em class="market-price" title="市场价：<?php echo $lang['currency'].$value['goods_marketprice'];?>"><?php echo ncPriceFormatForList($value['goods_marketprice']);?></em>
            <?php if($value["contractlist"]){?>
            <div class="goods-cti">
              <?php foreach($value["contractlist"] as $gcitem_k=>$gcitem_v){?>
              <span <?php if($gcitem_v['cti_descurl']){ ?>onclick="window.open('<?php echo $gcitem_v['cti_descurl'];?>');" style="cursor: pointer;"<?php }?> title="<?php echo $gcitem_v['cti_name']; ?>">
                <img src="<?php echo $gcitem_v['cti_icon_url_60'];?>"/>
              </span>
              <?php }?>
            </div>
            <?php }?>
            <!--<span class="raty" data-score="<?php echo $value['evaluation_good_star'];?>"></span>--> </div>
          <div class="goods-name"><a href="<?php echo urlMall('goods','index',array('goods_id'=>$value['goods_id']));?>" target="_blank" title="<?php echo $value['goods_jingle'];?>"><?php echo $value['goods_name_highlight'];?><em><?php echo $value['goods_jingle'];?></em></a></div>
           <div class="goodsinfo clearfix"><a href="<?php echo urlMall('goods', 'comments_list', array('goods_id' => $value['goods_id']));?>" target="_blank" class="goods-num"><em class="feiwa-icon"></em><?php echo $value['evaluation_count'];?></a><a href="<?php echo urlMall('show_store','index',array('store_id'=>$value['store_id']), $value['store_domain']);?>" title="<?php echo $value['store_name'];?>" class="seller-name"><em class="feiwa-icon"></em><?php echo $value['store_name'];?>&nbsp;</a></div>

         <?php
          if($value['ifpf']==1){
            $pf = unserialize($value['pf']);
            
        ?>
        <?php
          if($pf['q1']>0 && $pf['f1']>0){
        ?>
           <?php
            if($pf['q2']>0){
          ?>
          <div class="goods-price" style="margin-bottom:5px;"><em style="color: #F1C40F; font-size: 16px;max-width: 150px;float: left;overflow: hidden;">数量<?php echo $pf['q1']; ?>－<?php echo $pf['q2']; ?></em><em style="font-size: 14px;max-width: 110px;float: left;overflow: hidden;padding-left:10px;">&nbsp;</em><em style="font-size: 18px;font-weight: 600;text-overflow: ellipsis;white-space: nowrap; max-width: 110px;float: left;overflow: hidden;">价格：<i><?php echo '¥';?> </i><?php echo $pf['f1']; ?></em>
          </div>
          <?php
            }else{
          ?>
          <div class="goods-price" style="margin-bottom:5px;"><em style="color: #F1C40F; font-size: 16px;max-width: 150px;float: left;overflow: hidden;">数量≥<?php echo $pf['q1']; ?></em><em style="font-size: 14px;max-width: 110px;float: left;overflow: hidden;padding-left:10px;">&nbsp;</em><em style="font-size: 18px;font-weight: 600;text-overflow: ellipsis;white-space: nowrap; max-width: 110px;float: left;overflow: hidden;">价格：<i><?php echo '¥';?> </i><?php echo $pf['f1']; ?></em>
          </div>
          <?php
            }
          ?>
        <?php } ?>
        <?php
          if($pf['q2']>0 && $pf['f2']>0){
        ?>
        <?php
            if($pf['q3']>0){
          ?>
       <div class="goods-price" style="margin-bottom:5px;"><em style="color: #F1C40F; font-size: 16px;max-width: 150px;float: left;overflow: hidden;">数量<?php echo $pf['q2']; ?>－<?php echo $pf['q3']; ?></em><em style="font-size: 14px;max-width: 110px;float: left;overflow: hidden;padding-left:10px;">&nbsp;</em><em style="font-size: 18px;font-weight: 600;text-overflow: ellipsis;white-space: nowrap; max-width: 110px;float: left;overflow: hidden;">价格：<i><?php echo '¥';?> </i><?php echo $pf['f2']; ?></em>
          </div> 
        <?php
            }else{
          ?> 
          <div class="goods-price" style="margin-bottom:5px;"><em style="color: #F1C40F; font-size: 16px;max-width: 150px;float: left;overflow: hidden;">数量≥<?php echo $pf['q2']; ?></em><em style="font-size: 14px;max-width: 110px;float: left;overflow: hidden;padding-left:10px;">&nbsp;</em><em style="font-size: 18px;font-weight: 600;text-overflow: ellipsis;white-space: nowrap; max-width: 110px;float: left;overflow: hidden;">价格：<i><?php echo '¥';?> </i><?php echo $pf['f2']; ?></em>
          </div> 
        <?php }} ?>
        <?php
          if($pf['q3']>0 && $pf['f3']>0){
        ?>
      <div class="goods-price" style="margin-bottom:5px;"><em style="color: #F1C40F; font-size: 16px;max-width: 150px;float: left;overflow: hidden;">数量≥<?php echo $pf['q3']; ?></em><em style="font-size: 14px;max-width: 110px;float: left;overflow: hidden;padding-left:10px;">&nbsp;</em><em style="font-size: 18px;font-weight: 600;text-overflow: ellipsis;white-space: nowrap; max-width: 110px;float: left;overflow: hidden;">价格：<i><?php echo '¥';?> </i><?php echo $pf['f3']; ?></em>
          </div>  
      <?php }} ?>





           <div class="add-cart">
            <?php if ($value['goods_storage'] == 0) {?>
            <a href="javascript:void(0);" class="ct"  onclick="<?php if ($_SESSION['is_login'] !== '1'){?>login_dialog();<?php }else{?>ajax_form('arrival_notice', '到货通知', '<?php echo urlMall('goods', 'arrival_notice', array('goods_id' => $value['goods_id'], 'type' => 2));?>', 350);<?php }?>"><i class="icon-bullhorn"></i>到货通知</a>
            <?php } else {?>
            <?php if ($value['is_virtual'] == 1 || $value['is_fcode'] == 1 || $value['is_presell'] == 1 || $value['is_book'] == 1) {?>
            <a href="javascript:void(0);" nctype="buy_now" class="ct"  data-param="{goods_id:<?php echo $value['goods_id'];?>}"><i class="icon-mallping-cart"></i>
            <?php if ($value['is_fcode'] == 1) {
                echo 'F码购买';
            } else if ($value['is_book'] == 1) {
                echo '支付定金';
            } else if ($value['is_presell'] == 1) {
                echo '预售购买';
            } else {
                echo '立即购买'; 
            }?>
            </a>
            <?php } else {?>
            <a href="javascript:void(0);" nctype="add_cart" class="ct" data-gid="<?php echo $value['goods_id'];?>"><i class="icon-mallping-cart"></i>加入购物车</a>
            <?php }?>
            <?php }?>
            <em member_id="<?php echo $value['member_id'];?>">&nbsp;</em>
          </div>
<?php /*?> <div class="sell-stat">
            <ul>
              <li><a href="<?php echo urlMall('goods', 'index', array('goods_id' => $value['goods_id']));?>#ncGoodsRate" target="_blank" class="status"><?php echo $value['goods_salenum'];?></a>
                <p>商品销量</p>
              </li>
              <li><a href="<?php echo urlMall('goods', 'comments_list', array('goods_id' => $value['goods_id']));?>" target="_blank"><?php echo $value['evaluation_count'];?></a>
                <p>用户评论</p>
              </li>
              <li><em member_id="<?php echo $value['member_id'];?>">&nbsp;</em></li>
            </ul>
          </div><?php */?>
          
        </div>
      </div>
    </li>
    <?php }?>
    <div class="clear"></div>
  </ul>
  <?php }else{?>
  <div id="no_results" class="no-results"><i></i><?php echo $lang['index_no_record'];?></div>
  <?php }?>
</div>
<form id="buynow_form" method="post" action="<?php echo MALL_SITE_URL;?>/index.php" target="_blank">
  <input id="app" name="app" type="hidden" value="buy" />
  <input id="feiwa" name="feiwa" type="hidden" value="buy_step1" />
  <input id="goods_id" name="cart_id[]" type="hidden"/>
</form>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.raty/jquery.raty.min.js"></script> 
<script type="text/javascript">
    $(document).ready(function(){
        $('.raty').raty({
            path: "<?php echo RESOURCE_SITE_URL;?>/js/jquery.raty/img",
            readOnly: true,
            width: 80,
            score: function() {
              return $(this).attr('data-score');
            }
        });
      	//初始化对比按钮
    	initCompare();
    });
</script> 
