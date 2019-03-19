<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
	<div class="search-reads" id="searchREADS">
      <ul class="tab">
        <li <?php if($_GET['app'] != 'picture' ) echo 'class="current"'; ?> action="<?php echo READS_SITE_URL.DS;?>index.php" app="article" feiwa="article_search"><?php echo $lang['reads_article'];?><i></i></li>
        <li <?php if($_GET['app'] == 'picture' ) echo 'class="current"'; ?> action="<?php echo READS_SITE_URL.DS;?>index.php" app="picture" feiwa="picture_search"><?php echo $lang['reads_picture'];?><i></i></li>
        <li action="<?php echo MALL_SITE_URL.DS;?>index.php" app="search"><?php echo $lang['reads_goods'];?><i></i></li>
      </ul>
      <div class="form-box">
        <form id="form_search" method="get" action="" >
          <input id="app" name="app" type="hidden" />
          <input id="feiwa" name="feiwa" type="hidden" />
          <input id="keyword" name="keyword" type="text" class="input-text" value="<?php echo isset($_GET['keyword'])?$_GET['keyword']:'';?>" maxlength="60" x-webkit-speech="" lang="zh-CN" onwebkitspeechchange="foo()" x-webkit-grammar="builtin:search" />
          <input id="btn_search" type="submit" class="input-btn" value="搜">
        </form>
      </div>
    </div>
	<div class="block-style-one">
    <div class="title">
        <h3><?php echo $lang['reads_article_commend'];?></h3>
    </div>
    <div class="content">
        <?php if(!empty($output['article_commend_list']) && is_array($output['article_commend_list'])) {$i=0;?>
        <ul class="article-recommand-list">
            <?php $commend_count = 1;?>
            <?php foreach($output['article_commend_list'] as $value) {$i++;?>
            <li><a href="<?php echo getREADSArticleUrl($value['article_id']);?>"><?php echo $i;?>.<?php echo $value['article_title'];?></a></li>
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
<div class="block-style-one">
    <div class="title">
        <h3><?php echo $lang['reads_article_good'];?></h3>
    </div>
    <div class="content">
        <?php if(!empty($output['article_commend_image_list']) && is_array($output['article_commend_image_list'])) {?>
        <ol class="article-liked-top">
            <?php $commend_count = 1;?>
            <?php foreach($output['article_commend_image_list'] as $value) {?>
            <li>
            <div class="article-top"><em>0<?php echo $commend_count;?></em><span><i></i><?php echo $value['article_click'];?></span></div>
            <div class="article-cover" style=" background-image:url(<?php echo getREADSArticleImageUrl($value['article_attachment_path'], $value['article_image'], 'list');?>)"></div>
            <div class="article-title"><a href="<?php echo getREADSArticleUrl($value['article_id']);?>"><?php echo $value['article_title'];?></a></div>
            </li>
            <?php $commend_count++;?>
            <?php } ?>
        </ol>
        <?php } ?>
    </div>
</div>

    
    <div class="block-style-one">
    <div class="title">
        <h3>热门话题</h3>
    </div>
    <div class="content">
        <div class="tag-cloud">
            <?php if(!empty($output['reads_tag_list']) && is_array($output['reads_tag_list'])) {?>
            <?php foreach($output['reads_tag_list'] as $key=>$value) {?>
            <a href="<?php echo urlREADS('article','article_tag_search',array('tag_id'=>$value['tag_id']));?>"><?php echo $value['tag_name'];?></a>
            <?php } ?>
            <?php } ?>
        </div>
    </div>
</div>
