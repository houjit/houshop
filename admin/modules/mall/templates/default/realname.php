<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <div class="subject">
        <h3>会员认证</h3>
        <h5>管理认证</h5>
      </div>
      <ul class="tab-base nc-row">
        <li><a href="JavaScript:void(0);" class="current">管理认证</a></li>
        <li><a href="index.php?app=realname&feiwa=real_name_check">认证申请</a></li>
      </ul>
    </div>
  </div>
  <div id="flexigrid"></div>
</div>
<script type="text/javascript">
$(function(){
    $("#flexigrid").flexigrid({
        url: 'index.php?app=realname&feiwa=get_xml',
        colModel : [
            {display: '操作', name : 'operation', width : 150, sortable : false, align: 'center', className: 'handle'},
            {display: '会员ID', name : 'member_id', width : 40, sortable : true, align: 'center'},
            {display: '会员账号', name : 'member_name', width : 150, sortable : false, align: 'left'},
            {display: '真实姓名', name : 'real_name', width : 120, sortable : true, align: 'left'},
            {display: '身份证号', name : 'real_cardnumber', width : 180, sortable : false, align: 'left'},
            {display: '出生日期', name : 'real_birthday', width : 120, sortable : true, align: 'left'},
            {display: '性别', name : 'real_sex', width : 120, sortable : true, align: 'left'},
            {display: '民族', name : 'real_minzu', width : 120, sortable : true, align: 'left'}, 
            {display: '证件地址', name : 'real_address', width : 120, sortable : true, align: 'left'},
            {display: '发证机关', name : 'real_jiguan', width : 120, sortable : true, align: 'left'},
            {display: '有效期限', name : 'real_youxiaoqi', width : 180, sortable : true, align: 'left'},
            ],
        searchitems : [
            {display: '会员ID', name : 'member_id', isdefault: true},
            {display: '会员账号', name : 'member_name'},
            {display: '真实姓名', name : 'real_name'},
            {display: '身份证号', name : 'real_cardnumber'},
            {display: '性别', name : 'real_sex'},
            {display: '证件地址', name : 'real_address'},
            {display: '发证机关', name : 'real_jiguan'}

            ],
        sortname: "member_id",
        sortorder: "asc",
        title: '管理认证'
    });
});

</script>