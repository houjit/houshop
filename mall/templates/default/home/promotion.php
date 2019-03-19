<?php defined('INSYSVIEW') or exit('Access Invalid!');?><link href="<?php echo MALL_TEMPLATES_URL;?>/css/layout.css" rel="stylesheet" type="text/css"><link href="<?php echo MALL_TEMPLATES_URL;?>/css/feiwa-main.css" rel="stylesheet" type="text/css"><script type="text/javascript" src="<?php echo MALL_RESOURCE_SITE_URL;?>/js/home_index.js" charset="utf-8"></script>
	<style>
		body{background: #f6f6f6;}
	</style>
<div class="banner-wrap">
	<div  class="wrapper">
        <div class="banner">
            <img src="<?php echo xsthumb($output['xs_info']['xianshi_image']);?>" alt="">
        </div></div>
</div>
<div class="wrapper">
	<div class="time-left">
        <div class="brand-logo">
            <img src="<?php echo xsthumb($output['xs_info']['xianshi_image2']);?>" width="150" height="35">
        </div>
        <div class="countdown">
            <div class="timer time-remain" count_down="<?php echo $output['xs_info']['end_time']-TIMESTAMP;?>">剩余<i></i><em time_id="d">0</em>天<em time_id="h">0</em>时<em time_id="m">0</em>分<em time_id="s">0</em>秒</p></div>
        </div>
        <div class="activity-name">
            <strong><?php echo $output['xs_info']['xianshi_explain'];?></strong>
							    														<span class="rebate">
						低至<?php echo $output['xs_info']['xianshi_discount'];?>折
					</span>
    			       </div>
    </div>
    <div class="brand-activity"><?php echo $output['xs_info']['xianshi_intro'];?></div>
</div>
<div class="nch-container wrapper">
	<div id="promotionGoods"> <?php require(BASE_TPL_PATH.'/home/promotion.item.php');?>  </div><div class="tc mt20 mb20"> <div class="pagination" id="page-nav"></div> </div></div>
<div id="page-more"><a href="index.php?app=promotion&gc_id=<?php echo $_GET['gc_id'];?>&curpage=2"></a></div>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.raty/jquery.raty.min.js"></script> 
<script src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.masonry.js" type="text/javascript"></script> 
<script src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.infinitescroll.js" type="text/javascript"></script>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/fly/jquery.fly.min.js" charset="utf-8"></script> 
<!--[if lt IE 10]>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/fly/requestAnimationFrame.js" charset="utf-8"></script>
<![endif]-->
<script>
var $container = $('#promotionGoods');
$container.masonry({
    columnWidth: 305,
    itemSelector: '.item'
});
$(function(){
	$container.infinitescroll({  
        navSelector : '#page-more',
        nextSelector : '#page-more a',
        itemSelector : '.item',
        loading: {
        	selector:'#page-nav',
            img: '<?php echo MALL_TEMPLATES_URL;?>/images/loading.gif',
            msgText:'努力加载中...',
            maxPage : <?php echo $output['total_page'];?>,
            finishedMsg : '没有记录了',
            finished : function() {
            	$('.raty').raty({
                    path: "<?php echo RESOURCE_SITE_URL;?>/js/jquery.raty/img",
                    readOnly: true,
                    width: 100,
                    score: function() {
                      return $(this).attr('data-score');
                    }
                });
            }
        }
    },function(newElements){
		var $newElems = $(newElements);
		$container.masonry('appended', $newElems, true);
	});

	$('.raty').raty({
        path: "<?php echo RESOURCE_SITE_URL;?>/js/jquery.raty/img",
        readOnly: true,
        width: 100,
        score: function() {
          return $(this).attr('data-score');
        }
    });
    // 加入购物车
    $(window).resize(function() {
        $('#promotionGoods').on('click', 'a[nctype="add_cart"]', function() {
            flyToCart($(this));
        });
    });
    $('#promotionGoods').on('click', 'a[nctype="add_cart"]', function() {
        flyToCart($(this));
    });
     function flyToCart($this) {
        var rtoolbar_offset_left = $("#rtoolbar_cart").offset().left;
        var rtoolbar_offset_top = $("#rtoolbar_cart").offset().top-$(document).scrollTop();
        var img = $this.parents('.scope:first').find('img:first').attr('src');
        var data_gid = $this.attr('data-gid');
        var flyer = $('<img class="u-flyer" src="'+img+'" style="z-index:999">');
        flyer.fly({
            start: {
                left: $this.offset().left,
                top: $this.offset().top-$(document).scrollTop()-450
            },
            end: {
                left: rtoolbar_offset_left,
                top: rtoolbar_offset_top,
                width: 0,
                height: 0
            },
            onEnd: function(){
                addcart(data_gid,1,'');
                flyer.remove();
            }
        });
     }
});
</script> 