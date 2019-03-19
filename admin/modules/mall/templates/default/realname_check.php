<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <div class="subject">
        <h3>会员认证</h3>
        <h5>管理认证</h5>
      </div>
      <ul class="tab-base nc-row">
        <li><a href="index.php?app=realname&feiwa=real_name">管理认证</a></li>
        <li><a href="JavaScript:void(0);" class="current">认证申请</a></li>
      </ul>
    </div>
  </div>
  <div id="flexigrid"></div>
</div>
<script type="text/javascript">
$(function(){
    $("#flexigrid").flexigrid({
        url: 'index.php?app=realname&feiwa=get_xml_check',
        colModel : [
            {display: '操作', name : 'operation', width : 150, sortable : false, align: 'center', className: 'handle'},
            {display: '会员ID', name : 'member_id', width : 40, sortable : true, align: 'center'},
            {display: '会员账号', name : 'member_name', width : 150, sortable : false, align: 'left'},
            {display: '真实姓名', name : 'real_name', width : 120, sortable : true, align: 'left'},
            {display: '身份证号', name : 'real_cardnumber', width : 180, sortable : false, align: 'left'},            
            ],
        searchitems : [
            {display: '会员ID', name : 'member_id', isdefault: true},
            {display: '会员账号', name : 'member_name'},
            {display: '身份证号', name : 'real_cardnumber'}
            ],
        sortname: "member_id",
        sortorder: "asc",
        title: '管理认证'
    });
});

</script>