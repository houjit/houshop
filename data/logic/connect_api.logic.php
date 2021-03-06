<?php
// +----------------------------------------------------------------------
// | HOUCMS [ 厚典科技 专注建站 APP PC 微站 小程序 WAP ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2017 http://www.houjit.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: Amos <447107108@qq.com> http://www.houjit.com
// +----------------------------------------------------------------------
// | 后台控制器
// +----------------------------------------------------------------------
defined('INSYSVIEW') or exit('Access Invalid!');
class connect_apiLogic
{
    public function getStateInfo()
    {
        $state_array = array();
        $state_array['pc_qq'] = C('qq_isuse');
        $state_array['pc_sn'] = C('sina_isuse');
        $state_array['connect_qq'] = C('app_qq_isuse');
        $state_array['connect_sn'] = C('app_sina_isuse');
        $state_array['connect_wx'] = C('app_weixin_isuse');
        $state_array['connect_wap_wx'] = C('wap_weixin_isuse');
        $state_array['connect_sms_reg'] = C('sms_register');
        $state_array['connect_sms_lgn'] = C('sms_login');
        $state_array['connect_sms_psd'] = C('sms_password');
        return $state_array;
    }
    public function getWxOAuth2Url()
    {
        $weixin_appid = C('wap_weixin_appid');
        $api_url = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=' . $weixin_appid . '&redirect_uri=' . urlencode(MOBILE_SITE_URL . '/index.php?app=connect&feiwa=index') . '&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect';
        return $api_url;
    }
    public function sendCaptcha($phone, $log_type)
    {
        $model_sms_log = Model('sms_log');
        $state = true;
        $msg = '手机动态码发送成功';
        $sms_log = $this->ipCaptcha($log_type);
        if (!(empty($sms_log)) && ((TIMESTAMP - 60) < $sms_log['add_time']))
        {
            $state = false;
            $msg = '同一IP地址60秒内，请勿多次获取动态码！';
        }
        $condition = array();
        $condition['log_phone'] = $phone;
        $condition['log_type'] = $log_type;
        $sms_log = $model_sms_log->getSmsInfo($condition);
        if ($state && !(empty($sms_log)) && ((TIMESTAMP - 60) < $sms_log['add_time']))
        {
            $state = false;
            $msg = '同一手机号60秒内，请勿多次获取动态码！';
        }
        $time24 = TIMESTAMP - (60 * 60 * 24);
        $condition = array();
        $condition['log_phone'] = $phone;
        $condition['add_time'] = array('egt', $time24);
        $num = $model_sms_log->getSmsCount($condition);
        if ($state && (5 <= $num))
        {
            $state = false;
            $msg = '同一手机号24小时内，请勿多次获取动态码！';
        }
        $condition = array();
        $condition['log_ip'] = getIp();
        $condition['add_time'] = array('egt', $time24);
        $num = $model_sms_log->getSmsCount($condition);
        if ($state && (20 <= $num))
        {
            $state = false;
            $msg = '同一IP24小时内，请勿多次获取动态码！';
        }
        if ($state == true)
        {
            $log_array = array();
            $model_member = Model('member');
            $member = $model_member->getMemberInfo(array('member_mobile' => $phone));
            $captcha = rand(100000, 999999);
            $log_msg = '【' . C('site_name') . '】您于' . date('Y-m-d');
            switch ($log_type)
            {
                case '1': if (C('sms_register') != 1)
                {
                    $state = false;
                    $msg = '系统没有开启手机注册功能';
                }
                    if (!(empty($member)))
                    {
                        $state = false;
                        $msg = '当前手机号已被注册，请更换其他号码。';
                    }
                    $log_msg .= '申请注册会员，动态码：' . $captcha . '。';
                    break;
                case '2': if (C('sms_login') != 1)
                {
                    $state = false;
                    $msg = '系统没有开启手机登录功能';
                }
                    if (empty($member))
                    {
                        $state = false;
                        $msg = '当前手机号未注册，请检查号码是否正确。';
                    }
                    $log_msg .= '申请登录，动态码：' . $captcha . '。';
                    $log_array['member_id'] = $member['member_id'];
                    $log_array['member_name'] = $member['member_name'];
                    break;
                case '3': if (C('sms_password') != 1)
                {
                    $state = false;
                    $msg = '系统没有开启手机找回密码功能';
                }
                    if (empty($member))
                    {
                        $state = false;
                        $msg = '当前手机号未注册，请检查号码是否正确。';
                    }
                    $log_msg .= '申请重置登录密码，动态码：' . $captcha . '。';
                    $log_array['member_id'] = $member['member_id'];
                    $log_array['member_name'] = $member['member_name'];
                    break;
                default: $state = false;
                    $msg = '参数错误';
                    break;
            }
            if ($state == true)
            {
                $sms = new Sms();
                $result = $sms->send($phone, $log_msg);
                if ($result)
                {
                    $log_array['log_phone'] = $phone;
                    $log_array['log_captcha'] = $captcha;
                    $log_array['log_ip'] = getIp();
                    $log_array['log_msg'] = $log_msg;
                    $log_array['log_type'] = $log_type;
                    $log_array['add_time'] = TIMESTAMP;
                    $model_sms_log->addSms($log_array);
                }
                else
                {
                    $state = false;
                    $msg = '手机短信发送失败';
                }
            }
        }
        $state_data = array('state' => $state, 'sms_time' => 60, 'msg' => $msg);
        return $state_data;
    }
    public function smsRegister($phone, $captcha, $password, $client)
    {
        $state_data = $this->checkSmsCaptcha($phone, $captcha, 1);
        $state = $state_data['state'];
        if ($state == true)
        {
            $model_member = Model('member');
            $num = substr($phone, -4);
            $member_name = $this->getMemberName('mb', $num);
            $member = array();
            $member['member_name'] = $member_name;
            $member['member_passwd'] = $password;
            $member['member_email'] = '';
            $member['member_mobile'] = $phone;
            $member['member_mobile_bind'] = 1;
            $result = $model_member->addMember($member);
            if ($result)
            {
                $member = $model_member->getMemberInfo(array('member_name' => $member_name));
                $member_id = $member['member_id'];
                $token = $this->getUserToken($member, $client);
                if ($token)
                {
                    $state_data['key'] = $token;
                    $state_data['username'] = $member_name;
                    $state_data['userid'] = $member_id;
                }
                else
                {
                    $state_data['msg'] = '会员登录失败';
                }
            }
            else
            {
                $state_data['msg'] = '会员信息保存错误';
            }
        }
        return $state_data;
    }
    public function smsPassword($phone, $captcha, $password, $client)
    {
        $state_data = $this->checkSmsCaptcha($phone, $captcha, 3);
        $state = $state_data['state'];
        if ($state == true)
        {
            $model_member = Model('member');
            $member = $model_member->getMemberInfo(array('member_mobile' => $phone));
            if (!(empty($member)))
            {
                $new_password = md5($password);
                $model_member->editMember(array('member_id' => $member['member_id']), array('member_passwd' => $new_password));
                $member_id = $member['member_id'];
                $member_name = $member['member_name'];
                $token = $this->getUserToken($member, $client);
                if ($token)
                {
                    $state_data['key'] = $token;
                    $state_data['username'] = $member_name;
                    $state_data['userid'] = $member_id;
                }
                else
                {
                    $state_data['msg'] = '会员登录失败';
                }
            }
        }
        return $state_data;
    }
    public function checkSmsCaptcha($phone, $captcha, $log_type)
    {
        $state = true;
        $msg = '手机动态码验证成功';
        $sms_log = $this->getLogCaptcha($phone, $captcha, $log_type);
        if (empty($sms_log) || ($sms_log['add_time'] < (TIMESTAMP - 1800)))
        {
            $state = false;
            $msg = '动态码错误或已过期，重新输入';
        }
        $state_data = array('state' => $state, 'msg' => $msg);
        return $state_data;
    }
    public function getLogCaptcha($phone, $captcha, $log_type)
    {
        $condition = array();
        $condition['log_phone'] = $phone;
        $condition['log_captcha'] = $captcha;
        $condition['log_type'] = intval($log_type);
        $model_sms_log = Model('sms_log');
        $sms_log = $model_sms_log->getSmsInfo($condition);
        return $sms_log;
    }
    public function getUserToken($member, $client)
    {
        $model_mb_user_token = Model('mb_user_token');
        $mb_user_token_info = array();
        $token = md5($member['member_name'] . strval(TIMESTAMP) . strval(rand(0, 999999)));
        $mb_user_token_info['member_id'] = $member['member_id'];
        $mb_user_token_info['member_name'] = $member['member_name'];
        $mb_user_token_info['token'] = $token;
        $mb_user_token_info['login_time'] = TIMESTAMP;
        $mb_user_token_info['client_type'] = $client;
        $result = $model_mb_user_token->addMbUserToken($mb_user_token_info);
        if ($result)
        {
            $model_member = Model('member');
            $model_member->addPoint($member);
            $model_member->addExppoint($member);
            $update_info = array('member_login_num' => $member['member_login_num'] + 1, 'member_login_time' => TIMESTAMP, 'member_old_login_time' => $member['member_login_time'], 'member_login_ip' => getIp(), 'member_old_login_ip' => $member['member_login_ip']);
            $model_member->editMember(array('member_id' => $member['member_id']), $update_info);
            return $token;
        }
        return 0;
    }
    public function getMemberName($prefix = 'user_', $num = 0)
    {
        if ($num < 1)
        {
            $num = rand(100, 899);
        }
        if (strlen($prefix) < 3)
        {
            $member_name = $prefix . $num;
        }
        else
        {
            $member_name = $prefix;
        }
        $model_member = Model('member');
        if (strlen($member_name) < 6)
        {
            $member_name = $member_name . $num;
        }
        $member = $model_member->getMemberInfo(array('member_name' => $member_name));
        if (!(empty($member)))
        {
            $i = 1;
            while ($i < 999)
            {
                $num += $i;
                $member_name = $prefix . $num;
                if (strlen($member_name) < 6)
                {
                    $member_name = 'user_' . $member_name;
                }
                $member = $model_member->getMemberInfo(array('member_name' => $member_name));
                if (empty($member))
                {
                    break;
                }
                ++$i;
            }
        }
        return $member_name;
    }
    public function ipCaptcha($log_type = '')
    {
        $condition = array();
        $condition['log_ip'] = getIp();
        $log_type = intval($log_type);
        if (0 < $log_type)
        {
            $condition['log_type'] = $log_type;
        }
        $model_sms_log = Model('sms_log');
        $sms_log = $model_sms_log->getSmsInfo($condition);
        return $sms_log;
    }
    public function wxRegister($user_info, $client)
    {
        $state_data = array();
        $state_data['token'] = 0;
        $unionid = $user_info['unionid'];
        $nickname = $user_info['nickname'];
        $rand = rand(100, 899);
        $member_name = $this->getMemberName($nickname, $rand);
        $password = rand(100000, 999999);
        $member = array();
        $member['member_name'] = $member_name;
        $member['member_passwd'] = $password;
        $member['member_email'] = '';
        $member['weixin_unionid'] = $unionid;
        $member['weixin_info'] = $user_info['weixin_info'];
        $model_member = Model('member');
        $result = $model_member->addMember($member);
        if ($result)
        {
            $headimgurl = $user_info['headimgurl'];
            $headimgurl = substr($headimgurl, 0, -1) . '132';
            $avatar = @copy($headimgurl, BASE_UPLOAD_PATH . '/' . ATTACH_AVATAR . '/avatar_' . $result . '.jpg');
            if ($avatar)
            {
                $model_member->editMember(array('member_id' => $result), array('member_avatar' => 'avatar_' . $result . '.jpg'));
            }
            $member = $model_member->getMemberInfo(array('member_name' => $member_name));
            if ($client == 'www')
            {
                $member['password'] = $password;
                return $member;
            }
            $member_id = $member['member_id'];
            $token = $this->getUserToken($member, $client);
            if ($token)
            {
                $state_data['token'] = $token;
                $state_data['member']['member_name'] = $member_name;
                $state_data['member']['member_id'] = $member_id;
                $state_data['member']['member_passwd'] = $password;
            }
        }
        return $state_data;
    }
    public function getWxUserInfo($code, $api_type = '')
    {
        $weixin_appid = C('weixin_appid');
        $weixin_secret = C('weixin_secret');
        if ($api_type == 'api')
        {
            $weixin_appid = C('app_weixin_appid');
            $weixin_secret = C('app_weixin_secret');
        }
        if ($api_type == 'wap')
        {
            $weixin_appid = C('wap_weixin_appid');
            $weixin_secret = C('wap_weixin_secret');
        }
        $url = 'https://api.weixin.qq.com/sns/oauth2/access_token?appid=' . $weixin_appid . '&secret=' . $weixin_secret . '&code=' . $code . '&grant_type=authorization_code';
        $access_token = $this->getUrlContents($url);
        $code_info = json_decode($access_token, true);
        $user_info = array();
        if (!(empty($code_info['access_token'])))
        {
            $token = $code_info['access_token'];
            $openid = $code_info['openid'];
            $url = 'https://api.weixin.qq.com/sns/userinfo?access_token=' . $token . '&openid=' . $openid;
            $result = $this->getUrlContents($url);
            $user_info = json_decode($result, true);
            if (empty($user_info['unionid']))
            {
                $user_info['unionid'] = $user_info['openid'];
            }
            $weixin_info = array();
            $weixin_info['unionid'] = $user_info['unionid'];
            $weixin_info['nickname'] = $user_info['nickname'];
            $weixin_info['openid'] = $user_info['openid'];
            $user_info['weixin_info'] = serialize($weixin_info);
        }
        return $user_info;
    }
    public function getWxUserInfoUmeng($access_token, $openid)
    {
        $url = 'https://api.weixin.qq.com/sns/userinfo?access_token=' . $access_token . '&openid=' . $openid;
        $result = $this->getUrlContents($url);
        $user_info = json_decode($result, true);
        if (empty($user_info['unionid']))
        {
            $user_info['unionid'] = $user_info['openid'];
        }
        $weixin_info = array();
        $weixin_info['unionid'] = $user_info['unionid'];
        $weixin_info['nickname'] = $user_info['nickname'];
        $weixin_info['openid'] = $user_info['openid'];
        $user_info['weixin_info'] = serialize($weixin_info);
        return $user_info;
    }
    public function getSinaOAuth2Url($sina_type = '')
    {
        $client_id = C('sina_wb_akey');
        $client_secret = C('sina_wb_skey');
        require_once BASE_RESOURCE_PATH . DS . 'api' . DS . 'sina' . DS . 'saetv2.ex.class.php';
        $oauth2 = new SaeTOAuthV2($client_id, $client_secret);
        $api_url = RESOURCE_SITE_URL . '/api/sina/return_url.php';
        $sina_url = '';
        if ($sina_type == 'api')
        {
            $sina_url = $oauth2->getAuthorizeURL($api_url, 'code', 'api', 'mobile');
        }
        else
        {
            $sina_url = $oauth2->getAuthorizeURL($api_url);
        }
        return $sina_url;
    }
    public function getSinaUserInfo($code, $client = '', $token = array())
    {
        $client_id = C('sina_wb_akey');
        $client_secret = C('sina_wb_skey');
        if (($client == 'ios') || ($client == 'android'))
        {
            $client_id = C('app_sina_akey');
            $client_secret = C('app_sina_skey');
        }
        require_once BASE_RESOURCE_PATH . DS . 'api' . DS . 'sina' . DS . 'saetv2.ex.class.php';
        $oauth2 = new SaeTOAuthV2($client_id, $client_secret);
        if (!(empty($code)))
        {
            $api_url = RESOURCE_SITE_URL . '/api/sina/return_url.php';
            $params = array();
            $params['code'] = $code;
            $params['redirect_uri'] = $api_url;
            $token = $oauth2->getAccessToken('code', $params);
        }
        $oauth2->setToken($token['access_token']);
        $info = $oauth2->getUserById($token['uid']);
        return $info;
    }
    public function sinaRegister($user_info, $client)
    {
        $state_data = array();
        $state_data['token'] = 0;
        $openid = $user_info['id'];
        $nickname = $user_info['screen_name'];
        $sina_str = serialize($user_info);
        $rand = rand(100, 899);
        $member_name = $this->getMemberName($nickname, $rand);
        $password = rand(100000, 999999);
        $member = array();
        $member['member_name'] = $member_name;
        $member['member_passwd'] = $password;
        $member['member_email'] = '';
        $member['member_sinaopenid'] = $openid;
        $member['member_sinainfo'] = $sina_str;
        $model_member = Model('member');
        $result = $model_member->addMember($member);
        if ($result)
        {
            $avatar = @copy($user_info['avatar_large'], BASE_UPLOAD_PATH . '/' . ATTACH_AVATAR . '/avatar_' . $result . '.jpg');
            if ($avatar)
            {
                $model_member->editMember(array('member_id' => $result), array('member_avatar' => 'avatar_' . $result . '.jpg'));
            }
            $member = $model_member->getMemberInfo(array('member_name' => $member_name));
            if ($client == 'www')
            {
                $member['password'] = $password;
                return $member;
            }
            $member_id = $member['member_id'];
            $token = $this->getUserToken($member, $client);
            if ($token)
            {
                $state_data['token'] = $token;
                $state_data['member']['member_name'] = $member_name;
                $state_data['member']['member_id'] = $member_id;
                $state_data['member']['member_passwd'] = $password;
            }
        }
        return $state_data;
    }
    public function getQqOAuth2Url($qq_type = '')
    {
        $client_id = C('qq_appid');
        $client_secret = C('qq_appkey');
        require_once BASE_RESOURCE_PATH . DS . 'api' . DS . 'qq' . DS . 'oauth.qq.class.php';
        $oauth2 = new OauthQq($client_id, $client_secret);
        $api_url = RESOURCE_SITE_URL . '/api/qq/return_url.php';
        $qq_url = '';
        if ($qq_type == 'api')
        {
            $qq_url = $oauth2->qq_login($api_url, 'api', 'mobile');
        }
        else
        {
            $qq_url = $oauth2->qq_login($api_url);
        }
        return $qq_url;
    }
    public function getQqUserInfo($code, $client = '', $token = '')
    {
        $client_id = C('qq_appid');
        $client_secret = C('qq_appkey');
        if (($client == 'ios') || ($client == 'android'))
        {
            $client_id = C('app_qq_akey');
            $client_secret = C('app_qq_skey');
        }
        require_once BASE_RESOURCE_PATH . DS . 'api' . DS . 'qq' . DS . 'oauth.qq.class.php';
        $oauth2 = new OauthQq($client_id, $client_secret);
        $token = '';
        if (!(empty($code)))
        {
            $api_url = RESOURCE_SITE_URL . '/api/qq/return_url.php';
            $token = $oauth2->qq_callback($api_url, $code);
        }
        $openid = $oauth2->get_openid($token);
        $info = array();
        if (($client == 'ios') || ($client == 'android'))
        {
            $openid = $_GET['open_id'];
            $info = $oauth2->get_user_info_simple($token, $openid);
            if (empty($info['nickname']))
            {
                $openid = $_GET['open_id'];
                $info['openid'] = $openid;
                $info['nickname'] = 'qq';
                if (!(empty($_GET['nickname'])))
                {
                    $info['nickname'] = $_GET['nickname'];
                }
                if (!(empty($_GET['avatar'])))
                {
                    $info['figureurl_qq_2'] = $_GET['avatar'];
                }
            }
        }
        else
        {
            $info = $oauth2->get_user_info($token, $openid);
        }
        if (!(empty($info['nickname'])))
        {
            $info['openid'] = $openid;
        }
        return $info;
    }
    public function qqRegister($user_info, $client)
    {
        $state_data = array();
        $state_data['token'] = 0;
        $openid = $user_info['openid'];
        $nickname = $user_info['nickname'];
        $qq_str = serialize($user_info);
        $rand = rand(100, 899);
        $member_name = $this->getMemberName($nickname, $rand);
        $password = rand(100000, 999999);
        $member = array();
        $member['member_name'] = $member_name;
        $member['member_passwd'] = $password;
        $member['member_email'] = '';
        $member['member_qqopenid'] = $openid;
        $member['member_qqinfo'] = $qq_str;
        $model_member = Model('member');
        $result = $model_member->addMember($member);
        if ($result)
        {
            $avatar = @copy($user_info['figureurl_qq_2'], BASE_UPLOAD_PATH . '/' . ATTACH_AVATAR . '/avatar_' . $result . '.jpg');
            if ($avatar)
            {
                $model_member->editMember(array('member_id' => $result), array('member_avatar' => 'avatar_' . $result . '.jpg'));
            }
            $member = $model_member->getMemberInfo(array('member_name' => $member_name));
            if ($client == 'www')
            {
                $member['password'] = $password;
                return $member;
            }
            $member_id = $member['member_id'];
            $token = $this->getUserToken($member, $client);
            if ($token)
            {
                $state_data['token'] = $token;
                $state_data['member']['member_name'] = $member_name;
                $state_data['member']['member_id'] = $member_id;
                $state_data['member']['member_passwd'] = $password;
            }
        }
        return $state_data;
    }
    public function getUrlContents($url)
    {
        if (ini_get('allow_url_fopen') == '1')
        {
            return file_get_contents($url);
        }
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_URL, $url);
        $result = curl_exec($ch);
        curl_close($ch);
        return $result;
    }
}
?>