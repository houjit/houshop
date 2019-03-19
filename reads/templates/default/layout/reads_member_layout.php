<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<?php require READS_BASE_TPL_PATH.'/layout/top.php';?>
<style type="text/css">
.search-reads { display: none !important;}
#topHeader .warp-all { height: 80px !important;}
#topHeader .reads-logo { top: 8px !important;}
</style>


<div class="reads-member-nav-bar"> 
  <!-- 资讯用户中心导航 -->
  <ul class="reads-member-nav">
    <li <?php echo $_GET['app']=='member_article'&&$_GET['feiwa']!='article_edit'?' class="current"':'';?>><a href="<?php echo READS_SITE_URL.DS;?>index.php?app=member_article&feiwa=article_list" ><i class="a"></i><?php echo $lang['reads_article_list'];?></a></li>
    <li <?php echo $_GET['feiwa']=='publish_article'?' class="current"':'';?>><a href="<?php echo READS_SITE_URL.DS;?>index.php?app=publish&feiwa=publish_article"><i class="b"></i><?php echo $lang['reads_article_publish'];?></a></li>
    <li <?php echo $_GET['app']=='member_picture'&&$_GET['feiwa']!='picture_edit'?' class="current"':'';?>><a href="<?php echo READS_SITE_URL.DS;?>index.php?app=member_picture&feiwa=picture_list"><i class="c"></i><?php echo $lang['reads_picture_list'];?></a></li>
    <li <?php echo $_GET['feiwa']=='publish_picture'?' class="current"':'';?>><a href="<?php echo READS_SITE_URL.DS;?>index.php?app=publish&feiwa=publish_picture"><i class="d"></i><?php echo $lang['reads_picture_publish'];?></a></li>
    <li><a href="<?php echo urlLogin('login', 'logout');?>"><i class="e"></i><?php echo $lang['reads_loginout'];?></a></li>
  </ul></div>
  <?php require_once($tpl_file);?>

<?php require READS_BASE_TPL_PATH.'/layout/footer.php';?>
