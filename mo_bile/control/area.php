<?php
/**
 * 地区
 *
 *
 *
 * 
 *
 * @link       #
 * @since      File available since Release v1.1
 */



defined('INSYSVIEW') or exit('Access Invalid!');
class areaControl extends mobileHomeControl{

    public function __construct() {
        parent::__construct();
    }

    public function indexFeiwa() {
        $this->area_listFeiwa();
    }

    /**
     * 地区列表
     */
    public function area_listFeiwa() {
        $area_id = intval($_GET['area_id']);

        $model_area = Model('area');

        $condition = array();
        if($area_id > 0) {
            $condition['area_parent_id'] = $area_id;
        } else {
            $condition['area_deep'] = 1;
        }
        $area_list = $model_area->getAreaList($condition, 'area_id,area_name');
        output_data(array('area_list' => $area_list));
    }

}
