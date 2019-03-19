<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<script type="text/javascript">
$(document).ready(function(){
    //瀑布流
    $("#pinterest").masonry({
        // options 设置选项
        itemSelector : '.item',//class 选择器
            columnWidth : 252 ,//一列的宽度 Integer
            isAnimated:true,//使用jquery的布局变化  Boolean
            animationOptions:{queue: false, duration: 500 
            //jquery animate属性 渐变效果  Object { queue: false, duration: 500 }
            },
            gutterWidth:0,//列的间隙 Integer
            isFitWidth:true,// 适应宽度   Boolean
            isResizableL:true,// 是否可调整大小 Boolean
            isRTL:false//使用从右到左的布局 Boolean
    });

    $("img.lazy").shareshow_lazyload();

    $("[feiwa_type=shareshow_like]").shareshow_like({type:'goods'});

});
</script>
<?php if(!empty($output['list']) && is_array($output['list'])) {?>

<div class="commend-goods-list">
    <ul id="pinterest">
        <?php foreach($output['list'] as $key=>$value) {?>
        <li class="item">
        <?php if($output['owner_flag'] === TRUE){ ?>
        <?php if($_GET['feiwa'] == 'like_list') { ?>
        <!-- 喜欢删除按钮 -->
        <div class="del"><a feiwa_type="like_drop" like_id="<?php echo $value['like_id'];?>" href="javascript:void(0)"><?php echo $lang['feiwa_delete'];?></a></div>
        <?php } else { ?>
        <!-- 个人主页删除按钮 -->
        <div class="del"><a feiwa_type="home_drop" type="goods" item_id="<?php echo $value['commend_id'];?>" href="javascript:void(0)" title="<?php echo $lang['feiwa_delete'];?>"><?php echo $lang['feiwa_delete'];?></a></div>
        <?php } ?>
        <?php } ?>
        <div class="picture"> <a href="<?php echo SHARESHOW_SITE_URL;?>/index.php?app=goods&feiwa=detail&goods_id=<?php echo $value['commend_id'];?>" target="_blank">
                <?php $image_url = cthumb($value['commend_goods_image'], 240,$value['commend_goods_store_id']);?>
                <?php $size = getShareShowImageSize($image_url, 240);?>   
                <img class="lazy" height="<?php echo $size['height'];?>" width="<?php echo $size['width'];?>" src="<?php echo SHARESHOW_TEMPLATES_URL;?>/images/loading.gif" data-src="<?php echo $image_url;?>" title="<?php echo $value['commend_goods_name'];?>" alt="<?php echo $value['commend_goods_name'];?>" /> </a>
            <div class="price"> <?php echo $lang['currency'];?><strong><?php echo ncPriceFormat($value['commend_goods_price']);?></strong></div>
            
        </div>
        <div class="handle">
            <span class="like-btn"><a feiwa_type="shareshow_like" like_id="<?php echo $value['commend_id'];?>" href="javascript:void(0)"><i class="pngFix"></i><span><?php echo $lang['shareshow_text_like'];?></span><em><?php echo $value['like_count']<=999?$value['like_count']:'999+';?></em></a></span>
            <span class="comment"><a href="<?php echo SHARESHOW_SITE_URL;?>/index.php?app=goods&feiwa=detail&goods_id=<?php echo $value['commend_id'];?>" target="_blank"><i title="<?php echo $lang['shareshow_comment'];?>" class="pngFix">&nbsp;</i><em><?php echo $value['comment_count']<=999?$value['comment_count']:'999+';?></em></a></span>
        </div>
        <dl class="commentary">
            <dt><span class="thumb size30"><i></i><a href="<?php echo SHARESHOW_SITE_URL;?>/index.php?app=home&member_id=<?php echo $value['commend_member_id'];?>" target="_blank"> <img src="<?php echo getMemberAvatar($value['member_avatar']);?>" alt="<?php echo $value['member_name'];?>" onload="javascript:DrawImage(this,30,30);" /> </a></span></dt>
            <dd>
            <h4><a href="<?php echo SHARESHOW_SITE_URL;?>/index.php?app=home&member_id=<?php echo $value['commend_member_id'];?>" target="_blank"> <?php echo $value['member_name'];?> </a> </h4>
            <p> <a href="<?php echo SHARESHOW_SITE_URL;?>/index.php?app=goods&feiwa=detail&goods_id=<?php echo $value['commend_id'];?>" target="_blank"> <?php echo $value['commend_message'];?> </a> </p>
            </dd>
        </dl>
        </li>
        <?php } ?>
        <div class="clear"></div>
    </ul>
    <div class="clear"></div>
</div>
<div class="pagination"> <?php echo $output['show_page'];?> </div>
<?php } else { ?>
<div class="no-content"> <i class="goods pngFix"></i>
    <?php if($_GET['app'] == 'goods') { ?>
    <p><?php echo $lang['shareshow_goods_list_none'];?></p>
    <?php } else { ?>
        <?php if($_GET['feiwa'] == 'like_list') { ?>
            <?php if($output['owner_flag'] === TRUE){ ?>
            <p><?php echo $lang['shareshow_goods_like_list_none'];?></p>
            <?php } else { ?>
            <p><?php echo $lang['feiwa_quote1'];?><?php echo $output['member_info']['member_name'];?><?php echo $lang['feiwa_quote2'];?><?php echo $lang['shareshow_goods_like_list_none_owner'];?></p>
            <?php } ?>
        <?php } else { ?>
            <?php if($output['owner_flag'] === TRUE){ ?>
            <p><?php echo $lang['shareshow_goods_list_none_publish'];?></p>
            <a href="<?php echo SHARESHOW_SITE_URL.'/index.php?app=publish&feiwa=goods_buy';?>"><?php echo $lang['shareshow_goods_publish'];?></a>
            <?php } else { ?>
            <p><?php echo $lang['feiwa_quote1'];?><?php echo $output['member_info']['member_name'];?><?php echo $lang['feiwa_quote2'];?><?php echo $lang['shareshow_goods_list_none_publish_owner'];?></p>
            <?php } ?>
        <?php } ?>
    <?php } ?>
</div>
<?php } ?>
