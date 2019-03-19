<?php
/**
 * 验证码
 * * 
 *
 * @
  
 */



defined('INSYSVIEW') or exit('Access Invalid!');

class seccodeControl{
    public function __construct(){
    }

    /**
     * 产生验证码
     *
     */
    public function makecodeFeiwa(){
        $refererhost = parse_url($_SERVER['HTTP_REFERER']);
        $refererhost['host'] .= !empty($refererhost['port']) ? (':'.$refererhost['port']) : '';

        $seccode = makeSeccode($_GET['nchash']);
        if(is_server_run){
            //包含config/config.ini.php文件验证不能使用
            //验证不能使用走以下次国逻辑
            $this->getCodeNew($seccode);exit;
        }

        @header("Expires: -1");
        @header("Cache-Control: no-store, private, post-check=0, pre-check=0, max-age=0", FALSE);
        @header("Pragma: no-cache");
        
        
       	$code = new seccode();
		$code->code = $seccode;
		$code->width = 90;
		$code->height = 26;
		$code->background = 1;
		$code->adulterate = 1;
		$code->scatter = '';
		$code->color = 1;
		$code->size = 1;
		$code->shadow = 1;
		$code->animator = 0;
		$code->datapath =  BASE_DATA_PATH.'/resource/seccode/';
		$code->display();
    }

    public function getCodeNew($seccode){
        //$seccode = strtolower($seccode);
        $code = $seccode;
        $w=80; $h=26;
        //创建图片，定义颜色值
        Header("Content-type: image/PNG");
        $im = imagecreate($w, $h);
        $black = imagecolorallocate($im, mt_rand(0, 200), mt_rand(0, 120), mt_rand(0, 120));
        $gray = imagecolorallocate($im, 118, 151, 199);
        $bgcolor = imagecolorallocate($im, 235, 236, 237);

        //画背景
        imagefilledrectangle($im, 0, 0, $w, $h, $bgcolor);
        //画边框
        imagerectangle($im, 0, 0, $w-1, $h-1, $gray);
        //imagefill($im, 0, 0, $bgcolor);

        //在画布上随机生成大量点，起干扰作用;
        for ($i = 0; $i < 80; $i++) {
            imagesetpixel($im, rand(0, $w), rand(0, $h), $black);
        }
        //将字符随机显示在画布上,字符的水平间距和位置都按一定波动范围随机生成
        $strx = rand(3, 8);
        $num = 4;
        for ($i = 0; $i < $num; $i++) {
            $strpos = rand(1, 6);
            imagestring($im, 5, $strx, $strpos, substr($code, $i, 1), $black);
            $strx += rand(8, 14);
        }
        imagepng($im);
        imagedestroy($im);
    }

    /**
     * AJAX验证
     *
     */
    public function checkFeiwa(){
        if (checkSeccode($_GET['nchash'],$_GET['captcha'])){
            exit('true');
        }else{
            exit('false');
        }
	}
}