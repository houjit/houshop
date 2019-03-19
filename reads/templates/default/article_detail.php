<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<script type="text/javascript" src="<?php echo READS_RESOURCE_SITE_URL;?>/js/waypoints.js"></script>
<script type="text/javascript">
 $(document).ready(function(){
	//侧边滚动上传图片列表
	 $('#articleTool-holder').waypoint(function(event, direction) {
        $(this).parent().parent().toggleClass('sticky', direction === "down");
        event.stopPropagation();
    }); 
});

//更改字体大小
var status0='';
var curfontsize=10;
var curlineheight=18;
function fontZoomA(){
  if(curfontsize>8){
    document.getElementById('text').style.fontSize=(--curfontsize)+'pt';
 document.getElementById('text').style.lineHeight=(--curlineheight)+'pt';
  }
}
function fontZoomB(){
  if(curfontsize<64){
    document.getElementById('text').style.fontSize=(++curfontsize)+'pt';
 document.getElementById('text').style.lineHeight=(++curlineheight)+'pt';
  }
}
</script>

<div class="warp-all article-layout-a">
  <div class="mainbox">
    <article class="article-detail-content">
      <header id="articleTool-holder">
        <h1 class="article-title"><?php echo $output['article_detail']['article_title'];?></h1>
        <p class="article-sub"> <span class="author"><?php echo $lang['reads_text_publisher'];?><?php echo $lang['feiwa_colon'];?><?php echo empty($output['article_detail']['article_author'])?$lang['reads_text_guest']:$output['article_detail']['article_author'];?></span> <span class="source"><?php echo $lang['reads_text_origin'];?><?php echo $lang['feiwa_colon'];?> <a href="<?php echo empty($output['article_detail']['article_origin_address'])?READS_SITE_URL:$output['article_detail']['article_origin_address'];?>" target="_blank"> <?php echo empty($output['article_detail']['article_origin'])?C('site_name'):$output['article_detail']['article_origin'];?> </a></span><span class="date"><?php echo date('Y-m-d',$output['article_detail']['article_publish_time']);?></span> <span class="PV" title="<?php echo $lang['reads_text_view_count'];?>"><i></i><?php echo $lang['reads_text_view'];?><em>(<b><?php echo $output['article_detail']['article_click'];?></b>)</em></span> <span id="btn_sns_share" data-title="<?php echo $output['article_detail']['article_title'];?>" data-image="<?php echo getREADSArticleImageUrl($output['article_detail']['article_attachment_path'], $output['article_detail']['article_image'], 'list');?>" data-publisher="<?php echo empty($output['article_detail']['article_author'])?$lang['reads_text_guest']:$output['article_detail']['article_author'];?>" data-origin="<?php echo empty($output['article_detail']['article_origin'])?C('site_name'):$output['article_detail']['article_origin'];?>" data-publish_time="<?php echo date('Y-m-d',$output['article_detail']['article_publish_time']);?>" data-abstract="<?php echo $output['article_detail']['article_abstract'];?>" class="reads-share" title="<?php echo $lang['reads_text_share_count'];?>"><i></i><font><?php echo $lang['reads_text_share'];?></font><em>(<b><?php echo $output['article_detail']['article_share_count'];?></b>)</em></span> </p>
        <ul class="article-toolbar" id="articleTool">
          <li><a href="javascript:fontZoomB()" class="zoomb" title="<?php echo $lang['font_zoom_b'];?>"><?php echo $lang['font_zoom_b'];?></a></li>
          <li><a href="javascript:fontZoomA()" class="zooma" title="<?php echo $lang['font_zoom_a'];?>"><?php echo $lang['font_zoom_a'];?></a></li>
          <li class="none"><a href="Javascript: void(0);" onmousedown="document.execCommand('saveAs');" title="<?php echo $lang['reads_text_saveas'];?>" class="saveas"><?php echo $lang['reads_text_saveas'];?></a></li>
          <li><a href="Javascript: void(0);" onmousedown="window.print();" class="print" title="<?php echo $lang['reads_text_print'];?>"><?php echo $lang['reads_text_print'];?></a></li>
          <li><a href="Javascript: void(0);" onmousedown="window.close();" class="close" title="<?php echo $lang['reads_text_close'];?>"><?php echo $lang['reads_text_close'];?></a></li>
        </ul>
      </header>
      <p class="article-preface"><?php echo $output['article_detail']['article_abstract'];?></p>
      <!-- 正文 -->
      <section class="article-body" id="text"><?php echo $output['article_detail']['article_content'];?>
        <?php if(!empty($output['article_goods_list'])) { ?>
        <div class="article-related-goods"> 
          <!-- 相关商品 -->
          <h3><?php echo $lang['reads_article_goods'];?></h3>
          <?php foreach($output['article_goods_list'] as $value) { ?>
          <dl>
            <dt class="goods-name"><a target="_blank" href="<?php echo $value['url']?>"> <?php echo $value['title'];?> </a> </dt>
            <dd class="goods-pic"><a target="_blank" href="<?php echo $value['url']?>"><img src="<?php echo $value['image'];?>" title="<?php echo $value['title'];?>"> </a></dd>
            <dd class="goods-price"><?php echo $lang['reads_price'];?><?php echo $lang['feiwa_colon'];?><em><?php echo $value['price'];?></em></dd>
            <dd class="goods-handle"><a target="_blank" href="<?php echo $value['url']?>"><?php echo $lang['reads_goods_detail'];?></a></dd>
          </dl>
          <?php } ?>
        </div>
        <?php } ?>
        <!-- 关键字 -->
        <div class="article-tag"><?php echo $lang['reads_keyword'];?><?php echo $lang['feiwa_colon'];?>
          <?php if(!empty($output['article_detail']['article_keyword'])) { ?>
          <?php $article_keyword_array = explode(',', $output['article_detail']['article_keyword']);?>
          <?php foreach ($article_keyword_array as $value) {?>
          <a href="<?php echo READS_SITE_URL.DS;?>index.php?app=article&feiwa=article_search&keyword=<?php echo $value;?>" target="_blank"><?php echo $value;?></a>
          <?php } ?>
          <?php } ?>
        </div>
      </section>
      <section class="article-related-articles"> 
        <!-- 相关文章 -->
          <?php if(!empty($output['article_link_list'])) { ?>
        <h3><?php echo $lang['reads_other_article'];?></h3>
        <ul>
          <?php foreach($output['article_link_list'] as $value) { ?>
          <li><a target="_blank" href="<?php echo getREADSArticleUrl($value['article_id']);?>"> <?php echo $value['article_title'];?> </a> </li>
          <?php } ?>
        </ul>
          <?php } ?>
      </section>
      <?php if(intval(C('reads_attitude_flag')) === 1 && intval($output['article_detail']['article_attitude_flag']) === 1) { ?>
      <section  class="article-attitude"> 
        <!-- 心情 -->
        <?php require('article_attitude.php');?>
      </section>
      <?php } ?>
      <?php if(intval(C('reads_comment_flag')) === 1 && intval($output['article_detail']['article_comment_flag']) === 1) { ?>
      <section class="article-comment"> 
        <!-- 评论 -->
        <?php require('comment.php');?>
      </section>
      <?php } ?>
    </article>
  </div>
  <div class="sidebar">
    <?php require('article_list.sidebar.php');?>
  </div>
</div>
<?php require('widget_sns_share.php');?>
