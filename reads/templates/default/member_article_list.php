<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="reads-member-layout">
  <div class="reads-member-sidebar">
    <?php require('member_sidebar.php');?>
    <a href="<?php echo READS_SITE_URL.DS;?>index.php?app=publish&feiwa=publish_article" class="contribute-btn"><?php echo $lang['reads_article_publish'];?></a>
    <ul class="reads-member-menu">
      <li <?php echo $_GET['feiwa']=='article_list'?' class="current"':'';?>><a href="<?php echo READS_SITE_URL.DS;?>index.php?app=member_article&feiwa=article_list"><i class="a"></i><?php echo $lang['reads_my_article'];?></a></li>
      <li <?php echo $_GET['feiwa']=='draft_list'?' class="current"':'';?>><a href="<?php echo READS_SITE_URL.DS;?>index.php?app=member_article&feiwa=draft_list"><i class="b"></i><?php echo $lang['reads_text_draft'];?></a></li>
      <li <?php echo $_GET['feiwa']=='recycle_list'?' class="current"':'';?>><a href="<?php echo READS_SITE_URL.DS;?>index.php?app=member_article&feiwa=recycle_list"><i class="c"></i><?php echo $lang['reads_text_recycle'];?></a></li>
    </ul>
  </div>
  <div class="reads-member-main">
    <table class="reads-member-table">
      <thead>
        <tr>
          <th class="w30"><?php echo $lang['reads_text_id'];?></th>
          <th><?php echo $lang['reads_text_article'];?></th>
          <th class="w90"><?php echo $lang['reads_text_date'];?></th>
          <th class="w90"><?php echo $lang['reads_text_state'];?></th>
          <th class="w60"><?php echo $lang['reads_text_click_count'];?></th>
          <th class="w90"><?php echo $lang['reads_text_op'];?></th>
        </tr>
        <tr>
          <td colspan="10"><form action="" method="get">
              <input name="app" type="hidden" value="member_article" />
              <input name="feiwa" type="hidden" value="<?php echo $_GET['feiwa'];?>" />
              <?php if($_GET['feiwa'] == 'article_list') { ?>
              <select name="article_state">
                <option value=""><?php echo $lang['reads_text_all'];?></option>
                <option value="3" <?php echo $_GET['article_state'] == '3'?'selected':'';?>><?php echo $lang['reads_text_published'];?></option>
                <option value="2" <?php echo $_GET['article_state'] == '2'?'selected':'';?>><?php echo $lang['reads_text_verify'];?></option>
              </select>
              <?php } ?>
              <input name="keyword" type="text" value="<?php echo $_GET['keyword'];?>" placeholder="<?php echo $lang['reads_article_keyword'];?>" class="text" />
              <input type="submit" class="search-btn" value="<?php echo $lang['reads_text_search'];?>" />
            </form></td>
        </tr>
      </thead>
      <?php if(!empty($output['article_list']) && is_array($output['article_list'])) {?>
      <tbody>
        <?php foreach($output['article_list'] as $value) {?>
        <?php $article_url = getREADSArticleUrl($value['article_id']);?>
        <tr>
          <td><?php echo $value['article_id'];?></td>
          <td><dl class="article-info">
              <dt class="title" title="<?php echo $value['article_title'];?>"><a href="<?php echo $article_url;?>" target="_blank"><?php echo $value['article_title'];?></a></dt>
              <dd class="thumb" title="<?php echo $lang['reads_cover'];?>"><a href="<?php echo $article_url;?>" target="_blank"> <img src="<?php echo getREADSArticleImageUrl($value['article_attachment_path'], $value['article_image']);?>" alt="" class="t-img"/></a></dd>
              <dd class="abstract" title="<?php echo $lang['reads_article_abstract'];?><?php echo $lang['feiwa_colon'];?><?php echo $value['article_abstract'];?>"><?php echo $value['article_abstract'];?></dd>
            </dl></td>
          <td><?php echo date('Y-m-d',$value['article_publish_time']);?></td>
          <td><?php echo $output['article_state_list'][$value['article_state']];?></td>
          <td><?php echo $value['article_click'];?></td>
          <td class="handle">
            <?php if($value['article_state'] != '3') {?>
              <a href="<?php echo READS_SITE_URL.DS;?>index.php?app=article&feiwa=article_detail&article_id=<?php echo $value['article_id'];?>" target="_blank" style="color:#06C;"><?php echo $lang['reads_text_view'];?></a>
              <?php } else { ?>
              <a href="<?php echo $article_url;?>" target="_blank" style="color:#06C;"><?php echo $lang['reads_text_view'];?></a>
              <?php } ?>
            <?php if($_GET['feiwa'] == 'draft_list') {?>
            <a href="<?php echo READS_SITE_URL.DS;?>index.php?app=member_article&feiwa=article_publish&article_id=<?php echo $value['article_id'];?>" onclick="javascript:return confirm('<?php echo $lang['reads_publish_confirm'];?>')" style="color:#390;"><?php echo $lang['reads_text_publish'];?></a> <a href="<?php echo READS_SITE_URL.DS;?>index.php?app=member_article&feiwa=article_edit&article_id=<?php echo $value['article_id'];?>" style="color:#F90;" ><?php echo $lang['reads_text_edit'];?></a> <a href="<?php echo READS_SITE_URL.DS;?>index.php?app=member_article&feiwa=article_recycle&article_id=<?php echo $value['article_id'];?>" style="color:#F36;"><?php echo $lang['reads_text_remove'];?></a>
            <?php } ?>
            <?php if($_GET['feiwa'] == 'recycle_list') {?>
            <a href="<?php echo READS_SITE_URL.DS;?>index.php?app=member_article&feiwa=article_draft&article_id=<?php echo $value['article_id'];?>" style="color:#639;"><?php echo $lang['reads_text_back'];?></a> <a href="<?php echo READS_SITE_URL.DS;?>index.php?app=member_article&feiwa=article_drop&article_id=<?php echo $value['article_id'];?>" onclick="javascript:return confirm('<?php echo $lang['reads_delete_confirm'];?>')" style="color:#F00;"><?php echo $lang['reads_delete'];?></a>
            <?php } ?></td>
        </tr>
            <?php if($_GET['feiwa'] == 'draft_list') {?>
            <?php if(!empty($value['article_verify_reason'])) { ?>
            <tr>
                <td colspan="20"><strong class="fl" style="color: #F00;">审核结果：未通过平台审核，<?php echo $value['article_verify_reason'];?>。请根据审核意见进行修改编辑后再次提交。</strong></td>
            </tr>
            <?php } ?>
            <?php } ?>
        <?php } ?>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="20"><div class="pagination"> <?php echo $output['show_page'];?> </div></td>
        </tr>
      </tfoot>
      <?php } else { ?>
      <tbody>
        <tr>
          <td colspan="20"><div class="no-record"><i></i><?php echo $lang['no_record'];?></div></td>
        </tr>
      </tbody>
      <?php } ?>
    </table>
  </div>
</div>
<script type="text/javascript">
$(window).load(function() {
	$(".article-info .t-img").VMiddleImg({"width":40,"height":32});
});
</script> 
