<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<!--推荐个人秀部分-->
<div class="title">
    <h3><?php echo $lang['shareshow_text_member_commend'];?><em><?php echo $lang['feiwa_shareshow_personal'];?></em></h3>
</div>
<ul id="indexPersonal" class="jcarousel-skin-personal">
    <?php if(!empty($output['personal_list']) && is_array($output['personal_list'])) {?>
    <?php foreach($output['personal_list'] as $key=>$value) {?>
    <?php $personal_image_array = getShareShowPersonalImageUrl($value,'list');?>
    <li>
    <div class="reads-thumb"><a href="<?php echo SHARESHOW_SITE_URL;?>/index.php?app=personal&feiwa=detail&personal_id=<?php echo $value['personal_id'];?>">
        <img src="<?php echo $personal_image_array[0];?>" alt="" class="t-img" />
    </a></div>
    <dl>
        <dt class="member-avatar"><img src="<?php echo getMemberAvatar($value['member_avatar']);?>"/></dt>
        <dd class="member-id"><a href="<?php echo SHARESHOW_SITE_URL;?>/index.php?app=home&member_id=<?php echo $value['commend_member_id'];?>"> <?php echo $value['member_name'];?></a></dd>
        <dd class="commend-time"><?php echo date('Y-m-d',$value['commend_time']);?></dd>
        <dd class="commend-message"><?php echo $value['commend_message'];?></dd>
        <dd class="like"><i></i><?php echo $lang['feiwa_shareshow_like'];?><em><?php echo $value['like_count'];?></em></dd>
    </dl>
    </li>
    <?php } ?>
    <?php } ?>
</ul>
