<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<?php if($_GET['app'] === 'picture') { ?>
<?php $url_function = 'getREADSPictureUrl';?>
<?php } else { ?>
<?php $url_function = 'getREADSArticleUrl';?>
<?php } ?>

<div class="warp-all article-layout-a">
  <div class="mainbox">
    <div class="sitenav-bar">
      <div class="sitenav"><?php echo $lang['current_location'];?><?php echo $lang['feiwa_colon'];?> <a href="<?php echo READS_SITE_URL;?>"><?php echo $lang['reads_site_name'];?></a> > <a href="<?php echo READS_SITE_URL.DS.'index.php?app=article&feiwa=article_list';?>"><?php echo $lang['reads_article'];?></a></div>
    </div>
    <article class="article-detail-content">
      <header id="articleTool-holder">
        <h1 class="article-title"><a href="<?php echo $url_function($_GET[$_GET['app'].'_id']);?>"><?php echo $output[$_GET['app'].'_detail'][$_GET['app'].'_title'];?></a></h1>
        <p class="article-sub"> <span class="author"><?php echo $lang['reads_text_publisher'];?><?php echo $lang['feiwa_colon'];?><?php echo empty($output['article_detail']['article_author'])?$lang['reads_text_guest']:$output['article_detail']['article_author'];?></span> <span class="source"><?php echo $lang['reads_text_origin'];?><?php echo $lang['feiwa_colon'];?> <a href="<?php echo empty($output['article_detail']['article_origin_address'])?READS_SITE_URL:$output['article_detail']['article_origin_address'];?>" target="_blank"> <?php echo empty($output['article_detail']['article_origin'])?C('site_name'):$output['article_detail']['article_origin'];?> </a></span><span class="date"><?php echo date('Y-m-d',$output['article_detail']['article_publish_time']);?></span> </p>
      </header>
      <p class="article-preface"><?php echo $output['article_detail']['article_abstract'];?></p>
      <section class="article-comment">
        <?php require('comment.php');?>
      </section>
    </article>
  </div>
  <div class="sidebar">
    <div class="block-style-one">
      <div class="title">
        <h3>热门评论</h3>
      </div>
      <div class="content">
        <ul class="reads-hot-comment-list">
          <?php if(!empty($output['hot_comment']) && is_array($output['hot_comment'])) {?>
          <?php foreach($output['hot_comment'] as $key=>$value) {?>
          <li><em><?php echo $value[$_GET['app'].'_comment_count'];?></em><a href="<?php echo $url_function($value[$_GET['app'].'_id']);?>"><?php echo $value[$_GET['app'].'_title'];?></a></li>
          <?php } ?>
          <?php } ?>
        </ul>
      </div>
    </div>
    <div class="block-style-one">
      <div class="title">
        <h3><?php echo $lang['reads_article_commend'];?></h3>
      </div>
      <div class="content">
        <?php if(!empty($output['article_commend_list']) && is_array($output['article_commend_list'])) {?>
        <ul class="article-recommand-list">
          <?php $commend_count = 1;?>
          <?php foreach($output['article_commend_list'] as $value) {?>
          <li><a href="index.php?app=article&feiwa=article_list&class_id=<?php echo $value['class_id'];?>" class="class" target="_blank">[<?php echo $value['class_name'];?>]</a><a href="<?php echo getREADSArticleUrl($value['article_id']);?>"><?php echo $value['article_title'];?></a></li>
          <?php if($commend_count % 3 === 0 && $commend_count < 9) { ?>
          <li class="line"></li>
          <?php } ?>
          <?php $commend_count++;?>
          <?php } ?>
        </ul>
        <?php } ?>
        </ul>
      </div>
    </div>
  </div>
</div>
