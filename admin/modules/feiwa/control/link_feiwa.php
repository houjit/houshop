<?php
/**
 * 在线更新
 *客服QQ：2116198029
 */
defined('INSYSVIEW') or exit('Access Invalid!');
class link_feiwaControl extends SystemControl{
	public function __construct(){
		parent::__construct();
		Language::read('link_feiwa');
	}
	    public function indexFeiwa() {
	    Tpl::setDirquna('feiwa');
		Tpl::showpage('link_feiwa.index');
	    	
		}
	
	
}