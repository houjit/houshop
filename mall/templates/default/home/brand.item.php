<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<?php foreach($output['brand_c'] as $key=>$brand_c){?>
<?php if ($brand_c['image']){ $i=0;?>
<?php foreach($brand_c['image'] as $key=>$brand){$i++?>
<?php if ($i==1){?>
<div class="clearfix brandWrap1" id="box"><img src="<?php echo MALL_SITE_URL;?>/img/ht-brand-<?php echo $_GET['gc_id'];?>.png" class="img" alt="大牌街氛围图"></div>
<div class="clearfix brandWrap1" id="box"><img src="<?php echo MALL_SITE_URL;?>/img/ht-brands-<?php echo $_GET['gc_id'];?>.png" class="img" alt="大牌街氛围图"></div>
<div class="clearfix brandWrap1" id="box"><img src="<?php echo MALL_SITE_URL;?>/img/ht-brand-<?php echo $_GET['gc_id'];?>.png" class="img" alt="大牌街氛围图"></div>
<div class="clearfix brandWrap1" id="box"><img src="<?php echo MALL_SITE_URL;?>/img/ht-brands-<?php echo $_GET['gc_id'];?>.png" class="img" alt="大牌街氛围图"></div>

<!--分页 by liuxuexin start-->

<?php }?>
<!--分页 by liuxuexin end-->

<div class="brandWrap clearfix" id="box"><a class="brandImgLink f-fl" href="<?php echo urlMall('brand', 'list', array('brand'=>$brand['brand_id']));?>" target="_blank"><img class="brandImg img-lazyload"  feiwa-url="<?php echo $brand['brand_xbgpic'];?>"  rel='lazy' src="<?php echo MALL_SITE_URL;?>/img/loading.gif" title="<?php echo $brand['brand_name'];?>" alt="<?php echo $brand['brand_name'];?>"></a> <a class="brandDesc f-fl" href="<?php echo urlMall('brand', 'list', array('brand'=>$brand['brand_id']));?>" target="_blank" style="top: 0px;"> <img class="brandLogo" feiwa-url="<?php echo brandImage($brand['brand_pic']);?>"  rel='lazy' src="<?php echo MALL_SITE_URL;?>/img/loading.gif"  title="<?php echo $brand['brand_name'];?>" alt="<?php echo $brand['brand_name'];?>">
  <p class="brandName" title="<?php echo $brand['brand_name'];?>"><?php echo $brand['brand_name'];?></p>
  <p class="brandBenefit" title="<?php echo $brand['brand_tjstore'];?>"><?php echo $brand['brand_tjstore'];?></p>
  <span class="brandBtn">进入品牌</span></a></div>
<?php } }?>
<?php if ($brand_c['text']){?>
<div class="barnd-list-text"><strong>更多品牌：</strong>
  <?php foreach($brand_c['text'] as $key=>$brand){ ?>
  <a href="<?php echo urlMall('brand', 'list', array('brand'=>$brand['brand_id']));?>"><?php echo $brand['brand_name'];?></a>
  <?php } ?>
</div>
<?php } }?>
