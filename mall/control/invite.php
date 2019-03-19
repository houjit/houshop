<?php
/**分享奖励
 * 
 * * 
 
 * @
  
 */



defined('INSYSVIEW') or exit('Access Invalid!');
class inviteControl extends BaseHomeControl {

    public function __construct() {
        parent::__construct();
        /**
         * 读取语言包
         */
        Language::read('member_member_points,member_pointorder');
        /**
         * 判断系统是否开启积分功能
         */
        if (C('points_isuse') != 1){
            showMessage(Language::get('points_unavailable'),urlMall('member', 'home'),'html','error');
        }
    }
	public function indexFeiwa(){
        $memberid = $_SESSION['member_id'];
        $this->_get_invite($memberid, $_GET['type'], 10);
        Tpl::showpage('feiwa_invite');
    }
	private function _get_invite($memberid, $type, $page) {
        $condition = array();
        switch ($type) {
            case '1':
                $condition['invite_one'] = $memberid ;
                Tpl::output('type', '1');
                break;
            case '2':
                $condition['invite_two'] = $memberid ;
                Tpl::output('type', '2');
                break;
            case '3':
               $condition['invite_three'] = $memberid ;
                Tpl::output('type', '3');
                break;
			default:
			 $condition['invite_one'] = $memberid ;
                Tpl::output('type', '1');
                break;
        }


        //查询佣金日志列表
		$member_model = Model('member');
        $list_log = $member_model->getMembersList($condition,$page);
		if($list_log){

		//计算用户的累计返利金额
		foreach($list_log as $key => $val)
		{
			//获取佣金订单数量
			$invite_num = $member_model->getOrderInviteCount($memberid,$val['member_id']);
			if($invite_num>0){
				$list_log[$key]['invite_num']=$invite_num;
			}else{
				$list_log[$key]['invite_num']=0;
					}
			//获取佣金总金额
		    $invite_amount = $member_model->getOrderInviteamount($memberid,$val['member_id']);
			if($invite_amount>0){
				$list_log[$key]['invite_amount']=$invite_amount;
			}else{
				$list_log[$key]['invite_amount']=0;
					}
		}}
        Tpl::output('show_page',Model('member')->showpage('5'));
        Tpl::output('list_log',$list_log);
    }
	
	public function codeFeiwa(){
        Tpl::showpage('feiwa_invite_code','null_layout');
    }
}
