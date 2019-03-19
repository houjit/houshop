<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title"><a class="back" href="index.php?app=store&feiwa=store_joinin" title="返回<?php echo $lang['pending'];?>列表"><i class="fa fa-arrow-circle-o-left"></i></a>
      <div class="subject">
        <h3>查看认证信息</h3>
      </div>
    </div>
  </div>
  <form id="form_realname" action="index.php?app=realname&feiwa=real_check" method="post">
  <table border="0" cellpadding="0" cellspacing="0" class="store-joinin">
    <thead>
      <tr>
        <th colspan="20">会员认证信息</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th class="w150">会员用户名：</th>
        <td colspan="20"><?php echo $output['member']['member_name'];?></td>
      </tr>
      <tr>
        <th>真实姓名：</th>
        <td><?php echo $output['member']['real_name'];?></td>
        <th>身份证号：</th>
        <td colspan="20"><?php echo $output['member']['real_cardnumber'];?></td>
      </tr>
      <tr>
        <th>出生日期：</th>
        <td><?php echo date("Y-m-d",$output['member']['real_birthday']);?></td>
        <th>个人性别：</th>
        <td><?php echo $output['member']['real_sex'];?></td>
        <th>所属民族：</th>
        <td><?php echo $output['member']['real_minzu'];?>&nbsp;万元 </td>
      </tr>
      <tr>
        <th>证件住址：</th>
        <td><?php echo $output['member']['real_address'];?></td>
        <th>发证机关：</th>
        <td><?php echo $output['member']['real_jiguan'];?></td>
        <th>有效期限：</th>
        <td><?php echo date("Y-m-d",$output['member']['real_timestart']).'至'.date("Y-m-d",$output['member']['real_timeend']);?></td>
      </tr>
      <tr>
        <th class="w150">身份证：</th>
        <td colspan="20">
        <a nctype="nyroModal"  href="/data/upload/member/realname/<?php echo $output['member']['real_card_zheng'];?>"> <img src="/data/upload/member/realname/<?php echo $output['member']['real_card_zheng'];?>" alt="" /> </a>
        <a nctype="nyroModal"  href="/data/upload/member/realname/<?php echo $output['member']['real_card_fan'];?>"> <img src="/data/upload/member/realname/<?php echo $output['member']['real_card_fan'];?>" alt="" /> </a>
        <a nctype="nyroModal"  href="/data/upload/member/realname/<?php echo $output['member']['real_card_shou'];?>"> <img src="/data/upload/member/realname/<?php echo $output['member']['real_card_shou'];?>" alt="" /> </a>
        </td>
      </tr>
      <tr>
        <th class="w150">审核状态：</th>
        <td colspan="20">
            <?php
                if($output['member']['real_check']==1){echo "审核通过";}
                if($output['member']['real_check']==2){echo "等待审核";}
                if($output['member']['real_check']==3){echo "审核未通过";}
            ?>
        </td>
      </tr>
      <tr>
        <th class="w150">操作：</th>
        <td colspan="20">
            <input type="radio" name="real_check" value="1" checked="checked">通过
            <input type="radio" name="real_check" value="3" >拒绝
            <input type="hidden" name="member_id" value="<?php echo $_GET['member_id']; ?>">
        </td>
      </tr>
      <tr>
        <th class="w150">备注：</th>
        <td colspan="20">
            <textarea name="real_text" id="real_text"><?php echo $output['member']['real_text']; ?></textarea>
            <div id="validation_message" style="color:red;display:none;"></div>
        </td>
      </tr>
    </tbody>
  </table>

    <div class="bottom"><a id="btn_pass" class="ncap-btn-big ncap-btn-green mr10" href="JavaScript:void(0);">提交</a></div>

  </form>
</div>
<script type="text/javascript" src="<?php echo ADMIN_RESOURCE_URL;?>/js/jquery.nyroModal.js"></script>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.poshytip.min.js" charset="utf-8"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $('a[nctype="nyroModal"]').nyroModal();

        $('#btn_pass').on('click', function() {
            if($('#real_text').val() == '') {
                $('#validation_message').text('请填写备注');
                $('#validation_message').show();
                return false;
            } else {
                $('#validation_message').hide();
            }
            if(confirm('确认提交？')) {
                $('#verify_type').val('fail');
                $('#form_realname').submit();
            }
        });
    });
</script>