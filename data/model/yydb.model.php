<?php
/**
 * 一元夺宝模型
 * * 
 
 * @
 *  
 */
defined('INSYSVIEW') or exit('Access Invalid!');
class yydbModel extends Model {
        
    private $templatestate_arr;
    private $yydb_state_arr;
    
    public function __construct(){
        parent::__construct();

        //夺宝模板状态
        $this->templatestate_arr = array('usable'=>array('sign'=>1,'name'=>'有效'),'disabled'=>array('sign'=>2,'name'=>'失效'));
        //夺宝状态
        $this->yydb_state_arr = array('unused'=>array('sign'=>1,'name'=>'未中奖'),'used'=>array('sign'=>2,'name'=>'已中奖'));
    }

    /**
     * 取得当前有效夺宝数量
     * @param int $member_id
     */
    public function getCurrentAvailableyydbCount($member_id) {
        $info = rcache($member_id, 'm_yydb', 'yydb_count');
        if (empty($info['yydb_count']) && $info['yydb_count'] !== 0) {
            $condition['yydb_owner_id'] = $member_id;
            $condition['yydb_end_date'] = array('gt',TIMESTAMP);
            $condition['yydb_state'] = 1;
            $yydb_count = $this->table('yydb')->where($condition)->count();
            $yydb_count = intval($yydb_count);
            wcache($member_id, array('yydb_count' => $yydb_count), 'm_yydb');
        } else {
            $yydb_count = intval($info['yydb_count']);
        }
        return $yydb_count;
    }

    /**
     * 获取夺宝模板状态数组
     */
    public function getTemplateState(){
        return $this->templatestate_arr;
    }
    /**
     * 获取夺宝状态数组
     */
    public function getYydbState(){
        return $this->yydb_state_arr;
    }
    /**
     * 返回夺宝领取方式数组
     * @return array
     */
    public function getGettypeArr() {
        return $this->gettype_arr;
    }
    /**
     * 新增夺宝模板
     */
    public function addydbTemplate($param){
        if(!$param){
        	return false;
        }
        return $this->table('yydb_template')->insert($param);
    }
    /**
     * 查询夺宝模板列表
     */
    public function getydbTemplateList($where, $field = '*', $limit = 0, $page = 0, $order = '', $group = '') {
        $list = array();
        if (is_array($page)){
            if ($page[1] > 0){
                $list = $this->table('yydb_template')->field($field)->where($where)->page($page[0],$page[1])->order($order)->group($group)->select();
            } else {
                $list = $this->table('yydb_template')->field($field)->where($where)->page($page[0])->order($order)->group($group)->select();
            }
        } else {
            $list = $this->table('yydb_template')->field($field)->where($where)->page($page)->order($order)->group($group)->select();
        }
        //会员级别
        $member_grade = Model('member')->getMemberGradeArr();
    
        if (!empty($list) && is_array($list)){
            foreach ($list as $k=>$v){
                if (!empty($v['yydb_t_customimg'])){
                    $v['yydb_t_customimg_url'] = UPLOAD_SITE_URL.DS.ATTACH_yydb.DS.$v['yydb_t_customimg'];
                }else{
                    $v['yydb_t_customimg_url'] = UPLOAD_SITE_URL.DS.defaultGoodsImage(240);
                }
                //领取方式
                if($v['yydb_t_gettype']){
                    foreach($this->gettype_arr as $gtype_k=>$gtype_v){
                        if($v['yydb_t_gettype'] == $gtype_v['sign']){
                            $v['yydb_t_gettype_key'] = $gtype_k;
                            $v['yydb_t_gettype_text'] = $gtype_v['name'];
                        }
                    }
                }
                //状态
                if($v['yydb_t_state']){
                    foreach($this->templatestate_arr as $tstate_k=>$tstate_v){
                        if($v['yydb_t_state'] == $tstate_v['sign']){
                            $v['yydb_t_state_text'] = $tstate_v['name'];
                        }
                    }
                }
                //会员等级
                $v['yydb_t_mgradelimittext'] = $member_grade[$v['yydb_t_mgradelimit']]['level_name'];
    
                $list[$k] = $v;
            }
        }
        return $list;
    }
    /**
     * 获得夺宝模板详情
     */
    public function getydbTemplateInfo($where = array(), $field = '*', $order = '',$group = '') {
        $info = $this->table('yydb_template')->where($where)->field($field)->order($order)->group($group)->find();
        if (!$info){
        	return array();
        }
        if($info['yydb_t_gettype']){
            foreach($this->gettype_arr as $k=>$v){
                if($info['yydb_t_gettype'] == $v['sign']){
                    $info['yydb_t_gettype_key'] = $k;
                    $info['yydb_t_gettype_text'] = $v['name'];
                }
            }
        }
        if($info['yydb_t_state']){
            foreach($this->templatestate_arr as $k=>$v){
                if($info['yydb_t_state'] == $v['sign']){
                    $info['yydb_t_state_text'] = $v['name'];
                }
            }
        }
        if (!empty($info['yydb_t_customimg'])){
            $info['yydb_t_customimg_url'] = UPLOAD_SITE_URL.DS.ATTACH_TTM.DS.$info['yydb_t_customimg'];
        }else{
            $info['yydb_t_customimg_url'] = UPLOAD_SITE_URL.DS.defaultGoodsImage(240);
        }
        //会员等级
        $member_grade = Model('member')->getMemberGradeArr();
        $info['yydb_t_mgradelimittext'] = $member_grade[$info['yydb_t_mgradelimit']]['level_name'];
        return $info;
    }
    
    /**
     * 更新夺宝模板信息
     * @param array $data
     * @param array $condition
     */
    public function editydbTemplate($where,$data) {
        return $this->table('yydb_template')->where($where)->update($data);
    }
    
    /**
     * 删除夺宝模板信息
     * @param array $data
     * @param array $condition
     */
    public function dropydbTemplate($where) {
        $info = $this->getydbTemplateInfo($where);
        if (!$info){
        	return false;
        }
        $result = $this->table('yydb_template')->where($where)->delete($where);
        if ($result){
            //删除旧图片
            if ($info['yydb_t_customimg'] && is_file(BASE_UPLOAD_PATH . '/' . ATTACH_TTM . '/' . $info['yydb_t_customimg'])) {
                @unlink(BASE_UPLOAD_PATH . '/' . ATTACH_TTM . '/' . $info['yydb_t_customimg']);
                @unlink(BASE_UPLOAD_PATH . '/' . ATTACH_TTM . '/' . str_ireplace('.', '_small.', $info['yydb_t_customimg']));
            }
        }
        return $result;
    }
    
    /*
     * 获取夺宝编码
     * */
    public function get_ydb_code($member_id = 0){
        static $num = 1;
        $sign_arr = array();
        $sign_arr[] = sprintf('%02d',mt_rand(10,99));
        $sign_arr[] = sprintf('%03d', (float) microtime() * 1000);
        $sign_arr[] = sprintf('%010d',time() - 946656000);
        if($member_id){
            $sign_arr[] = sprintf('%03d', (int) $member_id % 1000);
        } else {
            //自增变量
            $tmpnum = 0;
            if ($num > 99){
                $tmpnum = substr($num, -1, 2);
            } else {
                $tmpnum = $num;
            }
            $sign_arr[] = sprintf('%02d',$tmpnum);
            $sign_arr[] = mt_rand(1,9);
        }
        $code = implode('',$sign_arr);
        $num += 1;
        return $code;
    }

    /**
     * 返回当前可用的夺宝列表,每种类型(模板)的夺宝里取出一个夺宝(同一个模板所有码面额和到期时间都一样)
     * @param array $condition 条件
     * @param array $goods_total 商品总金额
     * @return string
     */
    public function getCurrentAvailableydb($condition = array(), $goods_total = 0) {
        $condition['yydb_end_date'] = array('egt',TIMESTAMP);
        $condition['yydb_start_date'] = array('elt',TIMESTAMP);
        $condition['yydb_state'] = 1;
        $ydb_list = $this->table('yydb')->field('yydb_id,yydb_end_date,yydb_price,yydb_limit,yydb_t_id,yydb_code,yydb_owner_id')->where($condition)->key('yydb_t_id')->select();
        foreach ($ydb_list as $key => $ydb) {
            if ($goods_total > 0 && $goods_total < $ydb['yydb_limit']) {
                unset($ydb_list[$key]);
            } else {
                $ydb_list[$key]['desc'] = sprintf('%s元夺宝 有效期至 %s',$ydb['yydb_price'],date('Y-m-d',$ydb['yydb_end_date']));
                if ($ydb['yydb_limit'] > 0) {
                    $ydb_list[$key]['desc'] .= sprintf(' 消费满%s可用',$ydb['yydb_limit']);
                }

            }
        }
        return $ydb_list;
    }

    /**
     * 生成夺宝卡密
     */
    public function create_ydb_pwd($t_id) {
        if($t_id <= 0){
            return false;
        }
        static $num = 1;
        $sign_arr = array();
        //时间戳
        $time_tmp = uniqid('', true);
        $time_tmp = explode('.',$time_tmp);
        $sign_arr[] = substr($time_tmp[0], -1, 4).$time_tmp[1];
        //自增变量
        $tmpnum = 0;
        if ($num > 999){
            $tmpnum = substr($num, -1, 3);
        } else {
            $tmpnum = $num;
        }
        $sign_arr[] = sprintf('%03d',$tmpnum);
        //夺宝模板ID
        if($t_id > 9999){
            $t_id = substr($num, -1, 4);
        }
        $sign_arr[] = sprintf('%04d',$t_id);
        //随机数
        $sign_arr[] = sprintf('%04d',rand(1,9999));
        $pwd = implode('',$sign_arr);
        $num += 1;
        return array(md5($pwd), encrypt($pwd));
    }
    /**
     * 获取夺宝卡密
     */
    public function get_ydb_pwd($pwd) {
        if (!$pwd){
            return '';
        }
        $pwd = decrypt($pwd);
        $pattern = "/^([0-9]{20})$/i";
        if (preg_match($pattern, $pwd)){
            return $pwd;
        } else {
            return '';
        }
    }
    /**
     * 批量增加夺宝
     */
    public function addyydbBatch($insert_arr){
        return $this->table('yydb')->insertAll($insert_arr);
    }
    /**
     * 增加夺宝
     */
    public function addyydb($insert_arr){
        return $this->table('yydb')->insert($insert_arr);
    }
    /**
     * 获得夺宝列表
     */
    public function getyydbList($where, $field = '*', $limit = 0, $page = 0, $order = '', $group = ''){
        $list = array();
        if (is_array($page)){
            if ($page[1] > 0){
                $list = $this->table('yydb')->field($field)->where($where)->limit($limit)->page($page[0],$page[1])->order($order)->group($group)->select();
            } else {
                $list = $this->table('yydb')->field($field)->where($where)->limit($limit)->page($page[0])->order($order)->group($group)->select();
            }
        } else {
            $list = $this->table('yydb')->field($field)->where($where)->limit($limit)->page($page)->order($order)->group($group)->select();
        }
        if (!empty($list) && is_array($list)){
            foreach ($list as $k=>$v){
                if (!empty($v['yydb_customimg'])){
                    $v['yydb_customimg_url'] = UPLOAD_SITE_URL.DS.ATTACH_yydb.DS.$v['yydb_customimg'];
                }else{
                    $v['yydb_customimg_url'] = UPLOAD_SITE_URL.DS.defaultGoodsImage(240);
                }
                foreach ($this->yydb_state_arr as $state_k=>$state_v){
                    if ($state_v['sign'] == $v['yydb_state']){
                    	$v['yydb_state_text'] = $state_v['name'];
                    	$v['yydb_state_key'] = $state_k;
                    }
                }
                $list[$k] = $v;
            }
        }
        return $list;
    }
    
    /**
     * 获得夺宝详情
     */
    public function getyydbInfo($where = array(), $field = '*', $order = '',$group = '') {
        $info = $this->table('yydb')->where($where)->field($field)->order($order)->group($group)->find();
        if($info['yydb_state']){
            foreach ($this->yydb_state_arr as $state_k=>$state_v){
                if ($state_v['sign'] == $info['yydb_state']){
                    $info['yydb_state_text'] = $state_v['name'];
                    $info['yydb_state_key'] = $state_k;
                }
            }
            if (!empty($info['yydb_customimg'])){
                $info['yydb_customimg_url'] = UPLOAD_SITE_URL.DS.ATTACH_yydb.DS.$info['yydb_customimg'];
            }else{
                $info['yydb_customimg_url'] = UPLOAD_SITE_URL.DS.defaultGoodsImage(240);
            }
        }
        return $info;
    }
    /**
     * 更新过期夺宝状态
     */
    public function updateyydbExpire($member_id){
        $where = array();
        $where['yydb_owner_id'] = $member_id;
        $where['yydb_state'] = $this->yydb_state_arr['unused']['sign'];
        $where['yydb_end_date'] = array('lt', TIMESTAMP);
        $this->table('yydb')->where($where)->update(array('yydb_state'=>$this->yydb_state_arr['expire']['sign']));
        //清空缓存
        dcache($member_id, 'm_yydb');
    }
    
    /**
     * 获得推荐的夺宝列表
     * @param int $num 查询条数
     */
    public function getRecommendydb($num){
        //查询推荐的热门夺宝列表
        $where = array();
        $where['yydb_t_state'] = $this->templatestate_arr['usable']['sign'];
        //领取方式为积分兑换
        $where['yydb_t_gettype'] = $this->gettype_arr['points']['sign'];
        //$where['yydb_t_start_date'] = array('elt',time());
        $where['yydb_t_end_date'] = array('egt',time());
        $recommend_ydb = $this->getydbTemplateList($where, $field = '*', $num, 0, 'yydb_t_recommend desc,yydb_t_id desc');
        return $recommend_ydb;
    }
    /**
     * 获得夺宝总数量
     */
    public function getyydbCount($where, $group = ''){
        return $this->table('yydb')->where($where)->group($group)->count();
    }
    
    /**
     * 更新夺宝信息
     * @param array $data
     * @param array $condition
     */
    public function edityydb($where, $data, $member_id = 0) {
        $result = $this->table('yydb')->where($where)->update($data);
        if ($result && $member_id > 0){
            wcache($member_id, array('yydb_count' => null), 'm_yydb');
        }
        return $result;
    }
    
    /**
     * 查询可兑换夺宝模板详细信息
     */
    public function getCanChangeTemplateInfo($tid,$member_id){
        if ($tid <= 0 || $member_id <= 0){
            return array('state'=>false,'msg'=>'参数错误');
        }
        //查询可用夺宝模板
        $where = array();
        $where['yydb_t_id']          = $tid;
        $where['yydb_t_state']       = $this->templatestate_arr['usable']['sign'];
        //$where['yydb_t_start_date']  = array('elt',time());
        $where['yydb_t_end_date']    = array('egt',time());
        $template_info = $this->getydbTemplateInfo($where);
        if (empty($template_info) || $template_info['yydb_t_total']<=$template_info['yydb_t_giveout']){//夺宝不存在或者已兑换完
            return array('state'=>false,'msg'=>'夺宝已兑换完');
        }
        $model_member = Model('member');
        $member_info = $model_member->getMemberInfoByID($member_id);
        if (empty($member_info)){
            return array('state'=>false,'msg'=>'参数错误');
        }
        //验证会员积分是否足够
        if ($template_info['yydb_t_gettype'] == $this->gettype_arr['points']['sign'] && $template_info['yydb_t_points'] > 0){
            if (intval($member_info['member_points']) < intval($template_info['yydb_t_points'])){
                return array('state'=>false,'msg'=>'您的积分不足，暂时不能兑换该夺宝');
            }
        }
        //验证会员级别
        $member_currgrade = $model_member->getOneMemberGrade(intval($member_info['member_exppoints']));
        $member_info['member_currgrade'] = $member_currgrade?$member_currgrade['level']:0;
        if ($member_info['member_currgrade'] < intval($template_info['yydb_t_mgradelimit'])){
            return array('state'=>false,'msg'=>'您的会员级别不够，暂时不能兑换该夺宝');
        }
        //查询夺宝列表
        $where = array();
        $where['yydb_t_id']      = $tid;
        $where['yydb_owner_id']  = $member_id;
        $yydb_count = $this->getyydbCount($where);
        //同一张夺宝最多能兑换的次数
        if (intval($template_info['yydb_t_eachlimit']) > 0 && $yydb_count >= intval($template_info['yydb_t_eachlimit'])){
            $message = sprintf('该夺宝您已兑换%s次，不可再兑换了',$template_info['yydb_t_eachlimit']);
            return array('state'=>false,'msg'=>$message);
        }
        return array('state'=>true,'info'=>$template_info);
    }
    
    /**
     * 积分兑换夺宝
     */
    public function exchangeyydb($template_info, $member_id, $member_name = ''){
        if (intval($member_id) <= 0 || empty($template_info)){
            return array('state'=>false,'msg'=>'参数错误');
        }
        //查询会员信息
        if (!$member_name){
            $member_info = Model('member')->getMemberInfoByID($member_id);
            if (empty($template_info)){
                return array('state'=>false,'msg'=>'参数错误');
            }
            $member_name = $member_info['member_name'];
        }
        //添加夺宝信息
        $insert_arr = array();
        $insert_arr['yydb_code'] = $this->get_ydb_code($member_id);
        $insert_arr['yydb_t_id'] = $template_info['yydb_t_id'];
        $insert_arr['yydb_title'] = $template_info['yydb_t_title'];
        $insert_arr['yydb_desc'] = $template_info['yydb_t_desc'];
        $insert_arr['yydb_start_date'] = $template_info['yydb_t_start_date'];
        $insert_arr['yydb_end_date'] = $template_info['yydb_t_end_date'];
        $insert_arr['yydb_price'] = $template_info['yydb_t_price'];
        $insert_arr['yydb_limit'] = $template_info['yydb_t_limit'];
        $insert_arr['yydb_state'] = $this->yydb_state_arr['unused']['sign'];
        $insert_arr['yydb_active_date'] = time();
        $insert_arr['yydb_owner_id'] = $member_id;
        $insert_arr['yydb_owner_name'] = $member_name;
        $insert_arr['yydb_customimg'] = $template_info['yydb_t_customimg'];
        $result = $this->addyydb($insert_arr);
        if (!$result){
            return array('state'=>false,'msg'=>'兑换失败');
        }
        //扣除会员积分
        if ($template_info['yydb_t_points'] > 0 && $template_info['yydb_t_gettype'] == $this->gettype_arr['points']['sign']){
            $points_arr['pl_memberid'] = $member_id;
            $points_arr['pl_membername'] = $member_name;
            $points_arr['pl_points'] = -$template_info['yydb_t_points'];
            $points_arr['pl_desc'] = '夺宝'.$insert_arr['yydb_code'].'消耗积分';
            $result = Model('points')->savePointsLog('app',$points_arr,true);
            if (!$result){
                return array('state'=>false,'msg'=>'兑换失败');
            }
        }
        if ($result){
            //夺宝模板的兑换数增加
            $result = $this->editydbTemplate(array('yydb_t_id'=>$template_info['yydb_t_id']), array('yydb_t_giveout'=>array('exp','yydb_t_giveout+1')));
            if (!$result){
                return array('state'=>false,'msg'=>'兑换失败');
            }
            wcache($member_id, array('yydb_count' => array('exp','yydb_count+1')), 'm_yydb');
            return array('state'=>true,'msg'=>'兑换成功');
        } else {
            return array('state'=>false,'msg'=>'兑换失败');
        }
    }
}