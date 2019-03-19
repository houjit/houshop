<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <div class="subject">
        <h3><?php echo '会员通知'; ?></h3>
        <h5><?php echo ''; ?></h5>
      </div>
      <ul class="tab-base nc-row">
        <li><a href="JavaScript:void(0);" class="current">发送通知</a></li>
      </ul>
    </div>
  </div>
<form id="notice_form" method="POST">
    <input type="hidden" name="form_submit" value="ok" />
    <div class="ncap-form-default">
      <dl class="row">
        <dt class="tit">
          <label><em>*</em>发送类型</label>
        </dt>
        <dd class="opt">
          <label><input type="radio" checked="" value="1" name="send_type"><?php echo $lang['notice_index_spec_member'];?></label>
          <label><input type="radio" value="2" name="send_type" /><?php echo $lang['notice_index_all_member'];?></label>
          <span class="member_grade">
            <select id="member_grade" name="member_grade">
                <option value="-1">所有</option>
                <?php foreach ($output['member_grade'] as $value) {
                    echo '<option value="'.$value['level'].'">'.$value['level_name'].'</option>';
                } ?>
            </select>
          </span>
          <span class="err"></span>
          <p class="notic"><?php echo $lang['member_index_name']?></p>
        </dd>
      </dl>
      <dl class="row" id="tr_memberinfo">
        <dt class="tit">符合条件的会员</dt>
        <dd class="opt" id="td_memberinfo"></dd>
      </dl>
<!--      <dl class="row">
        <dt class="tit">
          <label>ssss</label>
        </dt>
        <dd class="opt">
          <select id="operatetype" name="operatetype">
            <option value="all">所有</option>
            <?php foreach ($output['member_grade'] as $value) {
                echo '<option value="level'.$value['exppoints'].'">'.$value['level_name'].'</option>';
            } ?>
          </select>
          <span class="err"></span>
          <p class="notic"></p>
        </dd>
      </dl>-->
      <dl class="row memberList">
        <dt class="tit">
          <label><?php echo $lang['admin_points_pointsnum']; ?>会员列表</label>
        </dt>
        <dd class="opt">
          <textarea id="user_name" name="user_name" rows="6" class="tarea" ><?php echo base64_decode(str_replace(' ','+',$_GET['member_name'])); ?></textarea>
          <p class="notic">每行填写一个会员名</p>
          <span class="err"></span>
          <p class="notic"><?php echo $lang['member_index_email']?></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label><?php echo $lang['admin_points_pointsdesc']; ?>通知内容</label>
        </dt>
        <dd class="opt">
          <textarea name="content1" rows="6" class="tarea"></textarea>
          <span class="err"></span>
          <p class="notic"><?php echo $lang['admin_points_pointsdesc_notice'];?></p>
        </dd>
      </dl>
        <div class="bot" ><a href="JavaScript:void(0);" class="ncap-btn-big ncap-btn-green" id="submitBtn">提交</a></div>
    </div>
  </form>
</div>
<script type="text/javascript">
function checkmember(){
	var membername = $.trim($("#member_name").val());
	if(membername == ''){
		$("#member_id").val('0');
		alert(<?php echo $lang['admin_points_addmembername_error']; ?>);
		return false;
	}
	$.getJSON("index.php?app=points&feiwa=checkmember", {'name':membername}, function(data){
	        if (data)
	        {
		        $("#tr_memberinfo").show();
				var msg= "<?php echo $lang['admin_points_member_tip']; ?> "+ data.name + "<?php echo $lang['admin_points_member_tip_2']; ?>" + data.points;
				$("#member_name").val(data.name);
				$("#member_id").val(data.id);
		        $("#td_memberinfo").text(msg);
	        }
	        else
	        {
	        	$("#member_name").val('');
	        	$("#member_id").val('0');
		        alert("<?php echo $lang['admin_points_userrecord_error']; ?>");
	        }
	});
}

$(function(){
	$("#tr_memberinfo").hide();
	
    $("#submitBtn").click(function(){
        if($("#notice_form").valid()){
            $("#notice_form").submit();
        }
	});
	$('#notice_form').validate({
        errorPlacement: function(error, element){
			error.appendTo(element.parent().parent().prev().find('td:first'));
        },
        rules : {
            user_name : {
                required : false
            },
            content1 :{
            	required : false
            }
        },
        messages : {
            user_name :{
                required     : '<?php echo $lang['notice_index_member_error'];?>'
            },
            content1 :{
            	required : '<?php echo $lang['notice_index_content_null']; ?>'
            }
        },
		submitHandler: function(form) {
			form.submit();
		}
    });
    
    $('.member_grade').hide();
    $("input[name='send_type']").click(function(){
        var rs = $(this).val();
        $('.memberList').show();
        $('.member_grade').hide();
        switch(rs){
            case '1':
                $('#user_list').show();
                break;
            case '2':
                $('#user_list').hide();
                $('.memberList').hide();
                $('.member_grade').show();
                break;
        }
    });
});
</script>