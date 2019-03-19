<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<style>.progress{height:13px;overflow:hidden;background-color:#f5f5f5;border-radius:7px;-webkit-box-shadow:inset 0 1px 2px rgba(0, 0, 0, .1);box-shadow:inset 0 1px 2px rgba(0, 0, 0, .1);}
.progress-bar{color:#fff;float:left;background-color:#0a0;display:inline-block;font-size:12px;line-height:14px;text-align:center;}
.progress-bar:after{content:"\3000";}
.progress .progress-bar:last-child{border-radius:0 1px 1px 0;}
.progress-big{height:26px;border-radius:13px;}
.progress-big .progress-bar{font-size:14px;line-height:26px;}
.progress-big .progress-bar:last-child{border-radius:0 13px 13px 0;}
.progress-small{height:5px;border-radius:3px;}
.progress-small .progress-bar{font-size:6px;line-height:6px;}
.progress-small .progress-bar:last-child{border-radius:0 3px 3px 0;}
.progress-bar.bg-back,.progress-bar.bg-mix,.progress-bar.bg-white{color:inherit;}
@-webkit-keyframes progress-bar-active{from{background-position:30px 0;}to{background-position:0 0;}}
@keyframes progress-bar-active{from{background-position:30px 0;}to{background-position:0 0;}}
.progress-striped .progress-bar{background-image:-webkit-linear-gradient(45deg, rgba(255, 255, 255, .25) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .25) 50%, rgba(255, 255, 255, .25) 75%, transparent 75%, transparent);background-image:linear-gradient(45deg, rgba(255, 255, 255, .25) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .25) 50%, rgba(255, 255, 255, .25) 75%, transparent 75%, transparent);background-size:30px 30px;}
.progress.active .progress-bar{-webkit-animation:progress-bar-active 2s linear infinite normal;animation:progress-bar-active 2s linear infinite normal;}

</style>
<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <div class="subject">
        <h3>计划任务设置</h3>
        <h5>当设置为自动的时候就会自动执行哦</h5>
      </div>
      <?php echo $output['top_link'];?> </div>
  </div>
  <div class="explanation" id="explanation">
    <div class="title" id="checkZoom"><i class="fa fa-lightbulb-o"></i>
      <h4 title="<?php echo $lang['sys_prompts_title'];?>"><?php echo $lang['sys_prompts'];?></h4>
      <span id="explanationZoom" title="<?php echo $lang['sys_prompts_span'];?>"></span> </div>
    <ul>
      <li>计划任务可在此手动执行。</li>
      <li>设置为自动执行时当有人访问网站就会自动执行的哦。</li>
    </ul>
  </div>
  <?php if($output['is_crontab']=='1'){?>
          <div class="progress progress-big progress-striped active">
          <div id="progress" class="progress-bar bg-blue" progress="20" style="width:20%;">进度：20%</div>
        </div>
  <?php }else{?>
    <table class="flex-table">
      <thead>
        <tr>
          <th width="24" align="center" class="sign"><i class="ico-check"></i></th>
          <th width="150" align="center" class="handle"><?php echo $lang['sys_handle'];?></th>
          <th width="100" align="left">间隔时间</th>
          <th width="300" align="left">任务链接</th>
          <th width="200" align="left">是否自动</th>
          <th width="200" align="left">手动执行</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <?php if(!empty($output['crontab_list']) && is_array($output['crontab_list'])){ ?>
        <?php foreach($output['crontab_list'] as $k => $v){ ?>
        <tr class="hover">
          <td class="sign"><i class="ico-check"></i></td>
          <td class="handle">
          <a class="btn red" href="index.php?app=feiwa&feiwa=crontab_del&id=<?php echo $k;?>" onclick="if(confirm('删除后将不能恢复，确认删除这  1 项吗？')){return true;} else {return false;}"><i class="fa fa-trash-o"></i>删除</a>
          <a class="btn blue" mff="sqde" href="index.php?app=feiwa&feiwa=crontab_edit&id=<?php echo $k; ?>"><i class="fa fa-pencil-square-o"></i>编辑</a>
          </td>
          <td><?php echo $v['name']; ?></td>
          <td><?php echo $v['value'];?></td>
          <td><?php echo $v['crontab_is']==2? '<span class="no"><i class="fa fa-ban"></i>否</span>' : '<span class="yes"><i class="fa fa-check-circle"></i>是</span>';?></td>
          <td><a class="btn red" href="<?php echo $v['value'];?>" onclick="if(confirm('你确定要手动执行这项吗？请耐心等待')){return true;} else {return false;}">手动执行</a></td>
          <td></td>
        </tr>
        <?php } ?>
        <?php }else { ?>
        <tr>
          <td class="no-data" colspan="100"><i class="fa fa-exclamation-triangle"></i><?php echo $lang['sys_no_record'];?></td>
        </tr>
        <?php } ?>
      </tbody>
    </table>
    <?php } ?>
</div>
<script>
<?php if($output['is_crontab']=='1'){?>
function install_progress(){

    var progress = parseInt($("#progress").attr('progress'))+10;
    $("#progress").attr("progress",progress);
    $("#progress").html("安装进度："+progress+"%");
    $("#progress").width(progress+"%");


    if (progress<100) {
        setTimeout('install_progress()',1500);
    }else{
        add();
    }
}

install_progress();

function add(){
	
	        $.getJSON('index.php?app=feiwa&feiwa=is_crontab', function(data) {
            if(data.result) {
                showSucc(data.message);
                window.location.reload();
            } else {
                showError(data.message);
            }
        });

}
<?php } ?>

$('.flex-table').flexigrid({	
	height:'auto',// 高度自动
	usepager: false,// 不翻页
	striped: true,// 使用斑马线
	resizable: false,// 不调节大小
	reload: false,// 不使用刷新
	columnControl: false,// 不使用列控制 
	title: '计划任务列表',
	buttons : [
               {display: '<i class="fa fa-plus"></i>新增数据', name : 'add', bclass : 'add', onpress : fg_operation }
           ]
	});

function fg_operation(name, grid) {
    if (name == 'add') {
        window.location.href = 'index.php?app=feiwa&feiwa=crontab_add';
    }
}
</script>