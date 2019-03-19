<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<link href="<?php echo MALL_TEMPLATES_URL;?>/css/feiwa-ht-brand.css" rel="stylesheet" type="text/css">
<script src="<?php echo MALL_SITE_URL;?>/img/masonry-docs.min.js"></script>
<div class="body" style="background:#0f0d1a url(<?php echo MALL_SITE_URL;?>/img/feiwa-ht-brand.jpg) no-repeat center top;">
  <header id="recomHeader" class="m-header m-recomHeader">
    <h3>今日主打</h3>
  </header>
  <?php if(!empty($output['brand_r'])){ $i=0?>
  <article class="m-recomBrand">
    <section class="rowOfFour clearfix">
      <?php foreach($output['brand_r'] as $key=>$brand_r){$i++; $i<5?>
      <?php if($i<5){?>
      <div class="brandWrap clearfix"><a class="brandImgLink f-fl" href="<?php echo urlMall('brand', 'list', array('brand'=>$brand_r['brand_id']));?>" target="_blank"><img class="brandImg img-lazyload"  feiwa-url="<?php echo $brand_r['brand_xbgpic'];?>"  rel='lazy' src="<?php echo MALL_SITE_URL;?>/img/loading.gif"  title="<?php echo $brand_r['brand_name'];?>" alt="<?php echo $brand_r['brand_name'];?>"></a> <a class="brandDesc f-fl" href="<?php echo urlMall('brand', 'list', array('brand'=>$brand_r['brand_id']));?>" target="_blank" style="top: 0px;"><img class="brandLogo"  feiwa-url="<?php echo brandImage($brand_r['brand_pic']);?>"  rel='lazy' src="<?php echo MALL_SITE_URL;?>/img/loading.gif"  title="<?php echo $brand_r['brand_name'];?>" alt="<?php echo $brand_r['brand_name'];?>" >
        <p class="brandName" title="<?php echo $brand_r['brand_name'];?>"><?php echo $brand_r['brand_name'];?></p>
        <p class="brandBenefit" title="<?php echo $brand_r['brand_tjstore'];?>"><?php echo $brand_r['brand_tjstore'];?></p>
        <span class="brandBtn">进入品牌</span></a></div>
      <?php }}?>
    </section>
  </article>
  <?php }?>
  <header id="streetHeader" class="m-header m-streetHeader">
    <h3>品牌逛不停</h3>
  </header>
  <nav id="staticnav" class="m-bsnav f-cb"><a class="tab <?php echo intval($_GET['gc_id']) <= 0?'app':'';?>" href="<?php echo urlMall('brand','index');?>" style="width:116.6px;"><span>全部</span></a>
    <?php foreach ($output['goods_class'] as $k=>$v){?>
    <b class="sp">/</b><a class="tab <?php echo intval($_GET['gc_id']) == $v['gc_id']?'app':'';?>" href="<?php echo urlMall('brand','index',array('gc_id'=>$v['gc_id']));?>" style="width:116.6px;"><span><?php echo $v['gc_name'];?></span></a>
    <?php } ?>
  </nav>
  <article id="brandstreet" class="m-recomBrand m-brandStreet">
    <section class="rowOfFour clearfix">
      <?php require(BASE_TPL_PATH.'/home/brand.item.php');?>
    </section>
  </article>
  <!--分页 by liuxuexin-->
  <div class="pagination"><?php echo $output['show_page']; ?></div>
  
</div>
<script>$(".brandWrap").hover(function(){$(this).find(".brandDesc").animate({top:"-50px"},400,"swing")},function(){$(this).find(".brandDesc").stop(!0,!1).animate({top:"0px"},400,"swing")});$(function(){var a=$("#brandstreet");a.imagesLoaded(function(){a.masonry({itemSelector:"#box",gutter:14,isAnimated:!0})})});</script>
</div>
