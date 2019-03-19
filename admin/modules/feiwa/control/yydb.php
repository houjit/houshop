<?php
/**
 * 平台夺宝管理
 *  
 
 * @
 */


defined('INSYSVIEW') or exit('Access Invalid!');
class yydbControl extends SystemControl{
    //每次导出订单数量
    const EXPORT_SIZE = 1000;
    private $templatestate_arr;
    private $yydb_state_arr;
    private $member_grade_arr;
    
    public function __construct(){
        parent::__construct();
        if (C('yydb_allow') != 1){
            showDialog('需开启“一元夺宝”功能','index.php?app=operation','succ');
        }
        $model_yydb = Model('yydb');
        $this->templatestate_arr = $model_yydb->getTemplateState();
        $this->yydb_state_arr = $model_yydb->getYydbState();
        $this->member_grade_arr = Model('member')->getMemberGradeArr();
		
		//店铺分类
        $model_yydb_class = Model('yydb_class');
        $parent_list = $model_yydb_class->getYydbClassList(array(),'',false);
        Tpl::output('class_list',$parent_list);
    }

    /*
     * 默认操作列出夺宝模板
     */
    public function indexFeiwa(){
        $this->yydblistFeiwa();
    }
    /**
     * 新增夺宝
     */
    public function ydbaddFeiwa(){
        $upload_model = Model('upload');
        if (chksubmit()){
           $obj_validate = new Validate();
            $obj_validate->validateparam = array(
                    array("input"=>$_POST['ydb_title'], "require"=>"true","validator"=>"Length","min"=>"1","max"=>"50","message"=>'模版名称不能为空且小于50个字符'),
                    array("input"=>$_POST['ydb_total'], "require"=>"true","validator"=>"Number","min"=>"1","message"=>'可发放数量不能为空且为大于1的整数'),
                    array("input"=>$_POST['ydb_desc'], "require"=>"true","validator"=>"Length","min"=>"1","max"=>"200","message"=>'模版描述不能为空且小于200个字符')
            );
            $error = $obj_validate->validate();
            if ($error != ''){
                showDialog(L('error').$error,'','error');
            }
                $model_yydb = Model('yydb');
                $insert_arr = array();
                $insert_arr['yydb_t_title'] = trim($_POST['ydb_title']);
                $insert_arr['yydb_t_desc'] = trim($_POST['ydb_desc']);
                $insert_arr['yydb_t_adminid'] = $this->admin_info['id'];
                $insert_arr['yydb_t_state'] = $this->templatestate_arr['usable']['sign'];
                $insert_arr['yydb_t_total'] = intval($_POST['ydb_total']);
                $insert_arr['yydb_t_giveout'] = 0;
                $insert_arr['yydb_t_updatetime'] = time();
                $insert_arr['yydb_t_goodsid'] = intval($_POST['ydb_goodsid']);
                $insert_arr['yydb_t_recommend'] = 0;
                $insert_arr['yydb_t_class'] = intval($_POST['sc_id']);
				$insert_arr['yydb_t_dbody']   = trim($_POST['pgoods_body']);

            //添加夺宝代表图片
            $indeximg_succ = false;
            if (!empty($_FILES['goods_image']['name'])){
                $upload = new UploadFile();
                $upload->set('default_dir',ATTACH_TTM);
                $upload->set('thumb_width', '60,240');
                $upload->set('thumb_height','60,240');
                $upload->set('thumb_ext',   '_small,_mid');
                $result = $upload->upfile('goods_image');
                if ($result){
                    $indeximg_succ = true;
                    $insert_arr['yydb_t_customimg'] = $upload->file_name;
                }else {
                    showDialog($upload->error,'','error');
                }
            }
            $state = $model_yydb->addydbTemplate($insert_arr);
            if($state){
                //礼品代表图片数据入库
                if ($indeximg_succ){
                    $insert_array = array();
                    $insert_array['file_name'] = $upload->file_name;
                    $insert_array['file_thumb'] = $upload->thumb_image;
                    $insert_array['upload_type'] = 5;
                    $insert_array['file_size'] = filesize(BASE_UPLOAD_PATH.DS.ATTACH_TTM.DS.$upload->file_name);
                    $insert_array['item_id'] = $state;
                    $insert_array['upload_time'] = time();
                    $upload_model->add($insert_array);
                }
                //更新积分礼品描述图片
                $file_idstr = '';
                if (is_array($_POST['file_id']) && count($_POST['file_id'])>0){
                    $file_idstr = "'".implode("','",$_POST['file_id'])."'";
                }
                $upload_model->updatebywhere(array('item_id'=>$state),array('upload_type'=>6,'item_id'=>'0','upload_id_in'=>"{$file_idstr}"));
                $this->log('添加'.'['.$_POST['ydb_title'].']');
                showDialog(添加成功,'index.php?app=yydb&feiwa=index','succ');
            }
        }
        //模型实例化
        $where = array();
        $where['upload_type'] = '6';
        $where['item_id'] = '0';
        $file_upload = $upload_model->getUploadList($where);
        if (is_array($file_upload)){
            foreach ($file_upload as $k => $v){
                $file_upload[$k]['upload_path'] = UPLOAD_SITE_URL.DS.ATTACH_TTM.DS.$file_upload[$k]['file_name'];
            }
        }
        Tpl::output('file_upload',$file_upload);
        Tpl::output('PHPSESSID',session_id());
			Tpl::setDirquna('feiwa');
            Tpl::showpage('yydb.templateadd');
    }



    /**
     * 夺宝列表
     */
    public function yydblistFeiwa()
    {
        TPL::output('gettype_arr',$this->gettype_arr);
        TPL::output('templateState',$this->templatestate_arr);
		Tpl::setDirquna('feiwa');
        Tpl::showpage('yydb.templatelist');
    }

    /**
     * 夺宝模板列表XML
     */
    public function yydblist_xmlFeiwa()
    {
        $where = array();
        if ($_REQUEST['advanced']) {

            if (trim($_GET['sdate']) && trim($_GET['edate'])) {
                $sdate = strtotime($_GET['sdate']);
                $edate = strtotime($_GET['edate']);
                $where['yydb_t_updatetime'] = array('between', "$sdate,$edate");
            } elseif (trim($_GET['sdate'])) {
                $sdate = strtotime($_GET['sdate']);
                $where['yydb_t_updatetime'] = array('egt', $sdate);
            } elseif (trim($_GET['edate'])) {
                $edate = strtotime($_GET['edate']);
                $where['yydb_t_updatetime'] = array('elt', $edate);
            }

            $pdates = array();
            if (strlen($q = trim((string) $_REQUEST['pdate1'])) && ($q = strtotime($q . ' 00:00:00'))) {
                $pdates[] = "yydb_t_end_date >= {$q}";
            }
            if (strlen($q = trim((string) $_REQUEST['pdate2'])) && ($q = strtotime($q . ' 00:00:00'))) {
                $pdates[] = "yydb_t_start_date <= {$q}";
            }
            if ($pdates) {
                $where['pdates'] = array('exp',implode(' and ', $pdates));
            }
        } else {
            if (strlen($q = trim($_REQUEST['query']))) {
                switch ($_REQUEST['qtype']) {
                    case 'yydb_title':
                        $where['yydb_t_title'] = array('like', "%$q%");
                        break;
                }
            }
        }

        switch ($_REQUEST['sortname']) {
            case 'yydb_t_price':
            case 'yydb_t_class':
                $sort = $_REQUEST['sortname'];
                break;
            case 'yydb_t_mgradelimittext':
                $sort = 'yydb_t_mgradelimit';
                break;
            case 'yydb_t_updatetimetext':
                $sort = 'yydb_t_updatetime';
                break;
            case 'yydb_t_start_datetext':
                $sort = 'yydb_t_start_date';
                break;
            case 'yydb_t_end_datetext':
                $sort = 'yydb_t_end_date';
                break;
            case 'yydb_t_statetext':
                $sort = 'yydb_t_state';
                break;
            case 'yydb_t_recommend':
                $sort = 'yydb_t_recommend';
                break;
            default:
                $sort = 'yydb_t_id';
                break;
        }
        if ($_REQUEST['sortorder'] != 'asc') {
            $sort .= ' desc';
        }

        $model_yydb = Model('yydb');
        $list = $model_yydb->getydbTemplateList($where, '*', 0, $_REQUEST['rp'], $sort);
        
        $data = array();
        $data['now_page'] = $model_yydb->shownowpage();
        $data['total_num'] = $model_yydb->gettotalnum();
        foreach ($list as $val) {
            $o = '';
            if($val['yydb_t_giveout']<=0 ){
                $o .= '<a class="btn red" href="javascript:void(0);" onclick="fg_del('.$val['yydb_t_id'].')"><i class="fa fa-trash-o"></i>删除</a>';
            }            
            $o .= "<span class='btn'><em><i class='fa fa-cog'></i>设置 <i class='arrow'></i></em><ul>";
            $o .= "<li><a href='index.php?app=yydb&feiwa=ydbedit&tid=".$val['yydb_t_id']."'>编辑信息</a></li>";
            $o .= "<li><a href='index.php?app=yydb&feiwa=giveoutlist&tid=".$val['yydb_t_id']."'>查看详细</a></li>";
            $o .= "</ul>";
            
            $i = array();
            $i['operation'] = $o;
            $i['yydb_t_title'] = $val['yydb_t_title'];
            $i['yydb_t_total'] = $val['yydb_t_total'];
            $i['yydb_t_class'] = $val['yydb_t_class'];
            $i['yydb_t_end_datetext'] = date('Y-m-d H:i', $val['yydb_t_updatetime']);
			$i['yydb_t_giveout'] = $val['yydb_t_giveout'];
            $i['yydb_t_statetext'] = $val['yydb_t_state_text'];
            $i['yydb_t_recommendtext'] = $val['yydb_t_recommend'] == '1'
                ? '<span class="yes"><i class="fa fa-check-circle"></i>是</span>'
                : '<span class="no"><i class="fa fa-ban"></i>否</span>';

            $data['list'][$val['yydb_t_id']] = $i;
        }
        echo Tpl::flexigridXML($data);
        exit;
    }

    /*
     * 夺宝模版编辑
     */
    public function ydbeditFeiwa(){
    	$upload_model = Model('upload');
        $t_id = intval($_GET['tid']);
        if ($t_id <= 0){
            $t_id = intval($_POST['tid']);
        }
        if ($t_id <= 0){
            showDialog(L('param_error'),'index.php?app=yydb&feiwa=ydblist');
        }
        $model_yydb = Model('yydb');
        //查询模板信息
        $where = array();
        $where['yydb_t_id'] = $t_id;
        $t_info = $model_yydb->getydbTemplateInfo($where);
        if (!$t_info){
            showDialog(L('param_error'),'index.php?app=yydb&feiwa=ydblist');
        }
        //判断模板详情是否能编辑
        if($t_info['yydb_t_giveout'] > 0 || $t_info['yydb_t_isbuild'] == 1){
            $t_info['ableedit'] = false;
        } else {
            $t_info['ableedit'] = true;
        } 
        if(chksubmit()){            
            if ($t_info['ableedit'] == true){
                $obj_validate = new Validate();
                $obj_validate->validateparam = array(
                        array("input"=>$_POST['ydb_title'], "require"=>"true","validator"=>"Length","min"=>"1","max"=>"50","message"=>'模版名称不能为空且小于50个字符'),
                        array("input"=>$_POST['ydb_desc'], "require"=>"true","validator"=>"Length","min"=>"1","max"=>"200","message"=>'模版描述不能为空且小于200个字符')
                );
                $error = $obj_validate->validate();

                if ($error){
                    showDialog($error, '', 'error');
                }
                $update_arr = array();
                $update_arr['yydb_t_title'] = trim($_POST['ydb_title']);
                $update_arr['yydb_t_desc'] = trim($_POST['ydb_desc']);
                $update_arr['yydb_t_adminid'] = $this->admin_info['id'];
                $update_arr['yydb_t_total'] = intval($_POST['ydb_total']);
                $update_arr['yydb_t_giveout'] = 0;
                $update_arr['yydb_t_class'] = intval($_POST['sc_id']);
				$update_arr['yydb_t_goodsid'] = intval($_POST['ydb_goodsid']);
				$update_arr['yydb_t_dbody']   = trim($_POST['pgoods_body']);
               //添加礼品代表图片
            $indeximg_succ = false;
            if (!empty($_FILES['goods_image']['name'])){
                $upload = new UploadFile();
                $upload->set('default_dir',ATTACH_TTM);
                $upload->set('thumb_width', '60,240');
                $upload->set('thumb_height','60,240');
                $upload->set('thumb_ext',   '_small,_mid');
                $result = $upload->upfile('goods_image');
                if ($result){
                    $indeximg_succ = true;
                    $update_arr['yydb_t_customimg'] = $upload->file_name;
                }else {
                    showDialog($upload->error,'','error');
                }
            }
            $rs = Model('yydb')->editydbTemplate(array('yydb_t_id'=>$t_id),$update_arr);
            if($rs){
            	//礼品代表图片数据入库
                if ($indeximg_succ){
                    //删除原有图片
                    $upload_list = $upload_model->getUploadList(array('upload_type'=>5,'item_id'=>$prod_info['pgoods_id']));

                    if (is_array($upload_list) && count($upload_list)>0){
                        $upload_idarr = array();
                        foreach ($upload_list as $v){
                            @unlink(BASE_UPLOAD_PATH.DS.ATTACH_TTM.DS.$v['file_name']);
                            @unlink(BASE_UPLOAD_PATH.DS.ATTACH_TTM.DS.$v['file_thumb']);
                            $upload_idarr[] = $v['upload_id'];
                        }
                        //删除图片
                        $upload_model->dropUploadById($upload_idarr);
                    }
                    $insert_array = array();
                    $insert_array['file_name'] = $upload->file_name;
                    $insert_array['file_thumb'] = $upload->thumb_image;
                    $insert_array['upload_type'] = 5;
                    $insert_array['file_size'] = filesize(BASE_UPLOAD_PATH.DS.DS.ATTACH_TTM.DS.$upload->file_name);
                    $insert_array['item_id'] = $prod_info['pgoods_id'];
                    $insert_array['upload_time'] = time();
                    $upload_model->add($insert_array);
                }
                //更新积分礼品描述图片
                $file_idstr = '';
                if (is_array($_POST['file_id']) && count($_POST['file_id'])>0){
                    $file_idstr = "'".implode("','",$_POST['file_id'])."'";
                }
               $upload_model->updatebywhere(array('item_id'=>$prod_info['pgoods_id']),array('upload_type'=>6,'item_id'=>'0','upload_id_in'=>"{$file_idstr}"));
                $this->log("编辑夺宝模板[ID：{$t_id}]成功");
                showDialog(L('feiwa_common_save_succ'),'index.php?app=yydb&feiwa=yydblist','succ');
            } else {
                showDialog(L('feiwa_common_save_fail'),'','error');
            }
            }
        }else{
            //查询最近修改的管理员
            $creator_info = Model('admin')->getOneAdmin($t_info['yydb_t_adminid']);
            $t_info['yydb_t_creator_name'] = $creator_info['admin_name'];
            $t_info['yydb_t_price'] = intval($t_info['yydb_t_price']);
            TPL::output('gettype_arr',$this->gettype_arr);
            TPL::output('member_grade',$this->member_grade_arr);
            TPL::output('templatestate_arr',$this->templatestate_arr);
            TPL::output('t_info',$t_info);
			Tpl::setDirquna('feiwa');
            Tpl::showpage('yydb.templateedit');
        }
    }



    /**
     * 删除夺宝模板 
     */
    public function ydbdelFeiwa() {
        $t_id = intval($_GET['tid']);
        if ($t_id <= 0){
            showDialog(L('param_error'));
        }
        $model_yydb = Model('yydb');
        //查询模板信息
        $where = array();
        $where['yydb_t_id'] = $t_id;
        $where['yydb_t_giveout'] = array('elt',0);
        $result = $model_yydb->dropydbTemplate($where);
        if ($result){
            $this->log("删除夺宝模板[ID：{$t_id}]成功");
            exit(json_encode(array('state'=>true,'msg'=>'删除成功')));
        } else {
            exit(json_encode(array('state'=>false,'msg'=>'删除失败')));
        }
    }



   /**
     * 夺宝期数列表
     */
    public function giveoutlistFeiwa()
    {
        TPL::output('gettype_arr',$this->gettype_arr);
        TPL::output('templateState',$this->templatestate_arr);
		Tpl::setDirquna('feiwa');
        Tpl::showpage('yydb.giveoutlist');
    }

    /**
     * 夺宝期数模板列表XML
     */
    public function giveoutlist_xmlFeiwa()
    {
        $where = array();
        if ($_REQUEST['advanced']) {

            if (trim($_GET['sdate']) && trim($_GET['edate'])) {
                $sdate = strtotime($_GET['sdate']);
                $edate = strtotime($_GET['edate']);
                $where['yydb_t_updatetime'] = array('between', "$sdate,$edate");
            } elseif (trim($_GET['sdate'])) {
                $sdate = strtotime($_GET['sdate']);
                $where['yydb_t_updatetime'] = array('egt', $sdate);
            } elseif (trim($_GET['edate'])) {
                $edate = strtotime($_GET['edate']);
                $where['yydb_t_updatetime'] = array('elt', $edate);
            }

            $pdates = array();
            if (strlen($q = trim((string) $_REQUEST['pdate1'])) && ($q = strtotime($q . ' 00:00:00'))) {
                $pdates[] = "yydb_t_end_date >= {$q}";
            }
            if (strlen($q = trim((string) $_REQUEST['pdate2'])) && ($q = strtotime($q . ' 00:00:00'))) {
                $pdates[] = "yydb_t_start_date <= {$q}";
            }
            if ($pdates) {
                $where['pdates'] = array('exp',implode(' and ', $pdates));
            }
        } else {
            if (strlen($q = trim($_REQUEST['query']))) {
                switch ($_REQUEST['qtype']) {
                    case 'yydb_title':
                        $where['yydb_t_title'] = array('like', "%$q%");
                        break;
                }
            }
        }

        switch ($_REQUEST['sortname']) {
            case 'yydb_t_price':
            case 'yydb_t_class':
                $sort = $_REQUEST['sortname'];
                break;
            case 'yydb_t_mgradelimittext':
                $sort = 'yydb_t_mgradelimit';
                break;
            case 'yydb_t_updatetimetext':
                $sort = 'yydb_t_updatetime';
                break;
            case 'yydb_t_start_datetext':
                $sort = 'yydb_t_start_date';
                break;
            case 'yydb_t_end_datetext':
                $sort = 'yydb_t_end_date';
                break;
            case 'yydb_t_statetext':
                $sort = 'yydb_t_state';
                break;
            case 'yydb_t_recommend':
                $sort = 'yydb_t_recommend';
                break;
            default:
                $sort = 'yydb_t_id';
                break;
        }
        if ($_REQUEST['sortorder'] != 'asc') {
            $sort .= ' desc';
        }

        $model_yydb = Model('yydb');
        $list = $model_yydb->getydbTemplateList($where, '*', 0, $_REQUEST['rp'], $sort);
        
        $data = array();
        $data['now_page'] = $model_yydb->shownowpage();
        $data['total_num'] = $model_yydb->gettotalnum();
        foreach ($list as $val) {
            $o = '';
            if($val['yydb_t_giveout']<=0 ){
                $o .= '<a class="btn red" href="javascript:void(0);" onclick="fg_del('.$val['yydb_t_id'].')"><i class="fa fa-trash-o"></i>删除</a>';
            }            
            $o .= "<span class='btn'><em><i class='fa fa-cog'></i>设置 <i class='arrow'></i></em><ul>";
            $o .= "<li><a href='index.php?app=yydb&feiwa=ydbedit&tid=".$val['yydb_t_id']."'>编辑信息</a></li>";
            $o .= "<li><a href='index.php?app=yydb&feiwa=ydbinfo&tid=".$val['yydb_t_id']."'>查看详细</a></li>";
            $o .= "</ul>";
            
            $i = array();
            $i['operation'] = $o;
            $i['yydb_t_title'] = $val['yydb_t_title'];
            $i['yydb_t_total'] = $val['yydb_t_total'];
            $i['yydb_t_class'] = $val['yydb_t_class'];
            $i['yydb_t_end_datetext'] = date('Y-m-d H:i', $val['yydb_t_updatetime']);
			$i['yydb_t_giveout'] = $val['yydb_t_giveout'];
            $i['yydb_t_statetext'] = $val['yydb_t_state_text'];
            $i['yydb_t_recommendtext'] = $val['yydb_t_recommend'] == '1'
                ? '<span class="yes"><i class="fa fa-check-circle"></i>是</span>'
                : '<span class="no"><i class="fa fa-ban"></i>否</span>';

            $data['list'][$val['yydb_t_id']] = $i;
        }
        echo Tpl::flexigridXML($data);
        exit;
    }






    
    /*
     * 夺宝模版编辑
    */
    public function ydbinfoFeiwa(){
        $t_id = intval($_GET['tid']);
        if ($t_id <= 0){
            $t_id = intval($_POST['tid']);
        }
        if ($t_id <= 0){
            showDialog(L('param_error'),'index.php?app=yydb&feiwa=ydblist');
        }
        $model_yydb = Model('yydb');
        //查询模板信息
        $where = array();
        $where['yydb_t_id'] = $t_id;
        $t_info = $model_yydb->getydbTemplateInfo($where);
        if (!$t_info){
            showDialog(L('param_error'),'index.php?app=yydb&feiwa=ydblist');
        }
        //查询最近修改的管理员
        $creator_info = Model('admin')->getOneAdmin($t_info['yydb_t_adminid']);
        $t_info['yydb_t_creator_name'] = $creator_info['admin_name'];
        $t_info['yydb_t_price'] = intval($t_info['yydb_t_price']);
        TPL::output('t_info',$t_info);
		Tpl::setDirquna('feiwa');
        Tpl::showpage('yydb.templateinfo');
    }
    /**
     * 夺宝列表XML
     */
    public function dblist_xmlFeiwa()
    {
        $t_id = intval($_GET['tid']);
        if ($t_id <= 0){
            echo Tpl::flexigridXML(array());
            exit;
        }
        $model_yydb = Model('yydb');
        $list = $model_yydb->getyydbList(array('yydb_t_id'=>$t_id), '*', 0, $_REQUEST['rp'], 'yydb_id desc');
        $data = array();
        $data['now_page'] = $model_yydb->shownowpage();
        $data['total_num'] = $model_yydb->gettotalnum();
        foreach ($list as $val) {
            $i = array();
            $i['yydb_code'] = $val['yydb_code'];
            if($_GET['gtype'] == 'pwd'){
                $i['yydb_pwd'] = $model_yydb->get_ydb_pwd($val['yydb_pwd2']);
            }
            foreach($this->yydb_state_arr as $rpstate_k=>$rpstate_v){
                if($val['yydb_state'] == $rpstate_v['sign']){
                    $i['yydb_statetext'] = $rpstate_v['name'];
                }
            }
            $i['yydb_owner_name'] = $val['yydb_owner_name']?$val['yydb_owner_name']:'未领取';
            $i['yydb_active_datetext'] = $val['yydb_owner_id']>0?date('Y-m-d H:i', $val['yydb_active_date']):'';
            $data['list'][$val['yydb_id']] = $i;
        }
        echo Tpl::flexigridXML($data);
        exit;
    }
    /**
     * 生成夺宝卡密 
     */
    public function rpbulidpwdFeiwa(){
        $t_id = intval($_GET['tid']);
        if ($t_id <= 0){
            showDialog('夺宝生成失败','','error');
        }
        //生成卡密夺宝队列
        QueueClient::push('build_pwdyydb', $t_id);
        showDialog('生成夺宝卡密任务已建立，稍后将生成','reload','succ');
    }
    
    /**
     * 导出
     */
    public function export_step1Feiwa(){
        $model_yydb = Model('yydb');
        $t_id = intval($_GET['tid']);
        //查询夺宝模板
        $ydb_info = $model_yydb->getydbTemplateInfo(array('yydb_t_id'=>$t_id));
        if (!$ydb_info){
            showDialog(L('param_error'),'index.php?app=yydb&feiwa=ydblist');
        }
        $where  = array();
        $where['yydb_t_id'] = intval($_GET['tid']);
        if (preg_match('/^[\d,]+$/', $_GET['rid'])) {
            $_GET['rid'] = explode(',',trim($_GET['rid'],','));
            $where['yydb_id'] = array('in',$_GET['rid']);
        }
        $order = 'yydb_id desc';
        
        if (!is_numeric($_GET['curpage'])){
            $count = $model_yydb->getyydbCount($where);
            $array = array();
            if ($count > self::EXPORT_SIZE ){//显示下载链接
                $page = ceil($count/self::EXPORT_SIZE);
                for ($i=1;$i<=$page;$i++){
                    $limit1 = ($i-1)*self::EXPORT_SIZE + 1;
                    $limit2 = $i*self::EXPORT_SIZE > $count ? $count : $i*self::EXPORT_SIZE;
                    $array[$i] = $limit1.' ~ '.$limit2 ;
                }
                Tpl::output('list',$array);
                Tpl::output('murl','index.php?app=yydb&feiwa=ydbinfo&tid='.$t_id);
				Tpl::setDirquna('mall');
                Tpl::showpage('export.excel');
            }else{//如果数量小，直接下载
                $data = $model_yydb->getyydbList($where,'*',self::EXPORT_SIZE,0,$order);
                $this->createExcel($data,$ydb_info);
            }
        }else{//下载
            $limit1 = ($_GET['curpage']-1) * self::EXPORT_SIZE;
            $limit2 = self::EXPORT_SIZE;
            $data = $model_yydb->getyydbList($where,'*',"{$limit1},{$limit2}",0,$order);
            $this->createExcel($data,$ydb_info);
        }
    }
    
    /**
     * 生成excel
     *
     * @param array $data
     */
    private function createExcel($data = array(),$ydb_info){
        Language::read('export');
        import('libraries.excel');
        $excel_obj = new Excel();
        $excel_data = array();
        //设置样式
        $excel_obj->setStyle(array('id'=>'s_title','Font'=>array('FontName'=>'宋体','Size'=>'12','Bold'=>'1')));
        //header
        $excel_data[0][] = array('styleid'=>'s_title','data'=>'夺宝编码');
        if ($ydb_info['yydb_t_gettype_key'] == 'pwd'){
            $excel_data[0][] = array('styleid'=>'s_title','data'=>'卡密');
        }
        $excel_data[0][] = array('styleid'=>'s_title','data'=>'领取方式');
        $excel_data[0][] = array('styleid'=>'s_title','data'=>'有效期');
        $excel_data[0][] = array('styleid'=>'s_title','data'=>'面额');
        $excel_data[0][] = array('styleid'=>'s_title','data'=>'每人限领');
        $excel_data[0][] = array('styleid'=>'s_title','data'=>'消费限额');
        $excel_data[0][] = array('styleid'=>'s_title','data'=>'会员级别');
        $excel_data[0][] = array('styleid'=>'s_title','data'=>'状态');
        $excel_data[0][] = array('styleid'=>'s_title','data'=>'使用状态');
        $excel_data[0][] = array('styleid'=>'s_title','data'=>'所属会员');
        $excel_data[0][] = array('styleid'=>'s_title','data'=>'领取时间');
        //data
        $model_yydb = Model('yydb');
        foreach ((array)$data as $k=>$v){
            $list = array();
            $list['yydb_code'] = $v['yydb_code'];
            if ($ydb_info['yydb_t_gettype_key'] == 'pwd'){
                $list['yydb_pwd'] = $model_yydb->get_ydb_pwd($v['yydb_pwd2']);
            }
            $list['yydb_t_gettype_text'] = $ydb_info['yydb_t_gettype_text'];
            $list['yydb_expiry_date'] = @date('Y-m-d',$v['yydb_start_date']).'~'.@date('Y-m-d',$v['yydb_end_date']);
            $list['yydb_price'] = $v['yydb_price'];
            $list['yydb_t_eachlimit'] = $ydb_info['yydb_t_eachlimit']>0? $ydb_info['yydb_t_eachlimit'] : '不限';
            $list['yydb_limit'] = $v['yydb_limit'];
            $list['yydb_t_mgradelimittext'] = $ydb_info['yydb_t_mgradelimittext'];
            $list['yydb_t_state_text'] = $ydb_info['yydb_t_state_text'];
            $list['yydb_state_text'] = $v['yydb_state_text'];
            $list['yydb_owner_name'] = $v['yydb_owner_name']?$v['yydb_owner_name']:'未领取';
            $list['yydb_active_date'] = $v['yydb_owner_name']?@date('Y-m-d H:i:s',$v['yydb_active_date']):0;
            $tmp = array();
            $tmp[] = array('data'=>$list['yydb_code']);
            if ($ydb_info['yydb_t_gettype_key'] == 'pwd'){
                $tmp[] = array('data'=>$list['yydb_pwd']);
            }
            $tmp[] = array('data'=>$list['yydb_t_gettype_text']);
            $tmp[] = array('data'=>$list['yydb_expiry_date']);
            $tmp[] = array('data'=>$list['yydb_price']);
            $tmp[] = array('data'=>$list['yydb_t_eachlimit']);
            $tmp[] = array('data'=>$list['yydb_limit']);
            $tmp[] = array('data'=>$list['yydb_t_mgradelimittext']);
            $tmp[] = array('data'=>$list['yydb_t_state_text']);
            $tmp[] = array('data'=>$list['yydb_state_text']);
            $tmp[] = array('data'=>$list['yydb_owner_name']);
            $tmp[] = array('data'=>$list['yydb_active_date']);
            $excel_data[] = $tmp;
        }
        $excel_data = $excel_obj->charset($excel_data,CHARSET);
        $excel_obj->addArray($excel_data);
        $excel_obj->addWorksheet($excel_obj->charset('夺宝',CHARSET));
        $excel_obj->generateXML($ydb_info['yydb_t_title'].$_GET['curpage'].'-'.date('Y-m-d-H',time()));
    }

    /**
     * 夺宝图片上传
     */
    public function yydb_pic_uploadFeiwa(){
        /**
         * 上传图片
         */
        $upload = new UploadFile();
        $upload->set('default_dir',ATTACH_TTM);

        $result = $upload->upfile('fileupload');
        if ($result){
            $_POST['pic'] = $upload->file_name;
        }else {
            echo 'error';exit;
        }
        /**
         * 模型实例化
         */
        $model_upload = Model('upload');
        /**
         * 图片数据入库
        */
        $insert_array = array();
        $insert_array['file_name'] = $_POST['pic'];
        $insert_array['upload_type'] = '6';
        $insert_array['file_size'] = $_FILES['fileupload']['size'];
        $insert_array['upload_time'] = time();
        $insert_array['item_id'] = intval($_POST['item_id']);
        $result = $model_upload->add($insert_array);
        if ($result){
            $data = array();
            $data['file_id'] = $result;
            $data['file_name'] = $_POST['pic'];
            $data['file_path'] = $_POST['pic'];
            /**
             * 整理为json格式
             */
            $output = json_encode($data);
            echo $output;
        }
    }
    /**
     * ajax操作删除已上传图片
     */
    public function ajaxdeluploadFeiwa(){
        //删除文章图片
        if (intval($_GET['file_id']) > 0){
            $model_upload = Model('upload');
            /**
             * 删除图片
             */
            $file_array = $model_upload->getOneUpload(intval($_GET['file_id']));
            @unlink(BASE_UPLOAD_PATH.DS.ATTACH_TTM.DS.$file_array['file_name']);
            /**
             * 删除信息
             */
            $model_upload->del(intval($_GET['file_id']));
            echo 'true';exit;
        }else {
            echo 'false';exit;
        }
    }



}
