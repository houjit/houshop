<?php
/**
 * 圈子分类管理
 *
 *
 *
 *
 *  
 
 * @
 */

//;

defined('INSYSVIEW') or exit('Access Invalid!');
class circle_classControl extends SystemControl{
    public function __construct(){
        parent::__construct();
        Language::read('circle');
    }

    public function indexFeiwa() {
        $this->class_listFeiwa();
    }
    /**
     * 圈子分类列表
     */
    public function class_listFeiwa(){
        $model = Model();
        $where = array();
        if(trim($_GET['searchname']) != ''){
            $where['class_name']        = array('like', '%'.trim($_GET['searchname']).'%');
        }
        if(trim($_GET['searchstatus']) != ''){
            $where['class_status']      = intval($_GET['searchstatus']);
        }
        $class_list = $model->table('circle_class')->where($where)->order('class_sort asc')->select();
        Tpl::output('class_list', $class_list);
         
Tpl::setDirquna('circle');
Tpl::showpage('circle_class.list');
    }
    /**
     * 圈子分类添加
     */
    public function class_addFeiwa(){
        $model = Model();
        if(chksubmit()){
            /**
             * 验证
             */
            $obj_validate = new Validate();
            $obj_validate->validateparam = array(
                    array("input"=>$_POST["class_name"], "require"=>"true", "message"=>L('circle_class_name_not_null')),
                    array("input"=>$_POST["class_sort"], "require"=>"true", 'validator'=>'Number', "message"=>L('circle_class_sort_is_number')),
            );
            $error = $obj_validate->validate();
            if($error != ''){
                showMessage($error);
            }else{
                $insert = array();
                $insert['class_name']       = trim($_POST['class_name']);
                $insert['class_sort']       = intval($_POST['class_sort']);
                $insert['class_status']     = intval($_POST['status']);
                $insert['is_recommend']     = intval($_POST['recommend']);
                $insert['class_addtime']    = time();
                $result = $model->table('circle_class')->insert($insert);
                if($result){
                    $url = array(
                        array(
                            'url'=>'index.php?app=circle_class&feiwa=class_add',
                            'msg'=>L('circle_continue_add'),
                        ),
                        array(
                            'url'=>'index.php?app=circle_class&feiwa=class_list',
                            'msg'=>L('circle_return_list'),
                        )
                    );
                    showMessage(L('feiwa_common_op_succ'),$url);
                }else{
                    showMessage(L('feiwa_common_op_fail'));
                }
            }
        }
        // 商品分类
        $gc_list = Model('goods_class')->getGoodsClassListByParentId(0);
        Tpl::output('gc_list', $gc_list);

         
Tpl::setDirquna('circle');
Tpl::showpage('circle_class.add');
    }
    /**
     * 圈子分类编辑
     */
    public function class_editFeiwa(){
        $model = Model();
        if(chksubmit()){
            /**
             * 验证
             */
            $obj_validate = new Validate();
            $obj_validate->validateparam = array(
                    array("input"=>$_POST["class_name"], "require"=>"true", "message"=>L('circle_class_name_not_null')),
                    array("input"=>$_POST["class_sort"], "require"=>"true", 'validator'=>'Number', "message"=>L(’circle_class_sort_is_number)),
            );
            $error = $obj_validate->validate();
            if($error != ''){
                showMessage($error);
            }else{
                $update = array();
                $update['class_name']   = trim($_POST['class_name']);
                $update['class_sort']   = intval($_POST['class_sort']);
                $update['class_status'] = intval($_POST['status']);
                $update['is_recommend'] = intval($_POST['recommend']);
                $result = $model->table('circle_class')->where(array('class_id'=>intval($_POST['class_id'])))->update($update);
                if($result){
                    showMessage(L('feiwa_common_op_succ'),'index.php?app=circle_class&feiwa=class_list');
                }else{
                    showMessage(L('feiwa_common_op_fail'));
                }
            }
        }
        $id = intval($_GET['classid']);
        if($id <= 0){
            showMessage(L('param_error'));
        }
        $class_info = $model->table('circle_class')->where(array('class_id'=>$id))->find();

        Tpl::output('class_info', $class_info);
        // 商品分类
        $gc_list = Model('goods_class')->getGoodsClassListByParentId(0);
        Tpl::output('gc_list', $gc_list);

         
Tpl::setDirquna('circle');
Tpl::showpage('circle_class.edit');
    }
    /**
     * 删除分类
     */
    public function class_delFeiwa(){
        $ids = explode(',', $_GET['id']);
        if (count($ids) == 0){
            exit(json_encode(array('state'=>false,'msg'=>L('wrong_argument'))));
        }
        Model()->table('circle_class')->where(array('class_id'=>array('in', $ids)))->delete();
        exit(json_encode(array('state'=>true,'msg'=>'删除成功')));
    }
    /**
     * ajax操作
     */
    public function ajaxFeiwa(){
        switch ($_GET['branch']){
            case 'recommend':
            case 'status':
            case 'sort':
            case 'name':
                $update = array(
                    $_GET['column']=>$_GET['value']
                );
                Model()->table('circle_class')->where(array('class_id'=>intval($_GET['id'])))->update($update);
                echo 'true';
                break;
        }
    }
}
