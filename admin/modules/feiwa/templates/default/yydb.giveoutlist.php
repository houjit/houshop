<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<div class="page">
  <!-- 页面导航 -->
  <div class="fixed-bar">
    <div class="item-title">
      <div class="subject">
        <h3>一元夺宝</h3>
        <h5>一元夺宝新增与管理</h5>
      </div>
    </div>
  </div>

  <!-- 操作说明 -->
  <div class="explanation" id="explanation">
    <div class="title" id="checkZoom"><i class="fa fa-lightbulb-o"></i>
      <h4 title="<?php echo $lang['sys_prompts_title'];?>"><?php echo $lang['sys_prompts'];?></h4>
      <span id="explanationZoom" title="<?php echo $lang['sys_prompts_span'];?>"></span> </div>
    <ul>
      <li>指定分类的当前期数结束之后才可以添加下一期商品</li>
      <li>已经结束的活动才可以进入下一期的商品出售</li>
    </ul>
  </div>

  <div id="flexigrid"></div>


</div>

<script>
$(function(){
    var flexUrl = 'index.php?app=yydb&feiwa=giveoutlist_xml';

    $("#flexigrid").flexigrid({
        url: flexUrl,
        colModel: [
            {display: '操作', name: 'operation', width: 150, sortable: false, align: 'center', className: 'handle'},
            {display: '当期', name: 'yydb_t_title', width: 200, sortable: false, align: 'left'},
            {display: '开始时间', name: 'yydb_t_price', width: 80, sortable: true, align: 'left'},
            {display: '结束时间', name: 'yydb_t_class', width: 80, sortable: true, align: 'left'},
            {display: '最近修改时间', name: 'yydb_t_updatetimetext', width: 120, sortable: true, align: 'center'},
            {display: '当前期数', name: 'yydb_t_giveout', width: 80, sortable: false, align: 'center'},
            {display: '状态', name: 'yydb_t_statetext', width: 80, sortable: false, align: 'center'},
            {display: '推荐', name: 'yydb_t_recommend', width: 80, sortable: false, align: 'center'}
        ],
        searchitems: [
            {display: '夺宝名称', name: 'yydb_title', isdefault: true}
        ],
        buttons : [
            {display: '<i class="fa fa-plus"></i>新增数据', name : 'add', bclass : 'add', title : '新增数据', onpress : fg_operate }
        ],
        sortname: "yydb_t_id",
        sortorder: "desc",
        title: '夺宝模板列表'
    });

    // 高级搜索提交
    $('#ncsubmit').click(function(){
        $("#flexigrid").flexOptions({url: flexUrl + '&' + $("#formSearch").serialize(),query:'',qtype:''}).flexReload();
    });

    // 高级搜索重置
    $('#ncreset').click(function(){
        $("#flexigrid").flexOptions({url: flexUrl}).flexReload();
        $("#formSearch")[0].reset();
    });

    $('[data-dp]').datepicker({dateFormat: 'yy-mm-dd'});

});

function fg_operate(name, bDiv) {
	if (name == 'add') {
		window.location.href = 'index.php?app=yydb&feiwa=ydbadd';
    }
}
function fg_del(id) {
    if(confirm('删除后将不能恢复，确认删除吗？')){
        $.getJSON('index.php?app=yydb&feiwa=ydbdel', {tid:id}, function(data){
            if (data.state) {
                $("#flexigrid").flexReload();
            } else {
                showError(data.msg);
            }
        });
    }
}
</script>
