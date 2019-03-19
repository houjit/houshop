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
class goodsLogic
{
    public function __construct()
    {
        Language::read('member_store_goods_index');
    }
    public function saveGoods($param, $store_id, $store_name, $store_state, $seller_id, $seller_name, $bind_all_gc)
    {
        $error = $this->_validParam($param);
        if ($error != '')
        {
            return callback(false, $error);
        }
        $gc_id = intval($param['cate_id']);
        $data = Model('goods_class')->getGoodsClassForCacheModel();
        if (!(isset($data[$gc_id])) || isset($data[$gc_id]['child']) || isset($data[$gc_id]['childchild']))
        {
            return callback(false, '您选择的分类不存在，或没有选择到最后一级，请重新选择分类。');
        }
        if (!(checkPlatformStoreBindingAllGoodsClass($store_id, $bind_all_gc)))
        {
            $where = array();
            $where['class_1|class_2|class_3'] = $gc_id;
            $where['store_id'] = $store_id;
            $rs = Model('store_bind_class')->getStoreBindClassInfo($where);
            if (empty($rs))
            {
                return callback(false, '您的店铺没有绑定该分类，请重新选择分类。');
            }
        }
        $model_goods = Model('goods');
        $common_array = $this->_initCommonGoodsByParam($param, $store_id, $store_name, $store_state);
        $common_id = $model_goods->addGoodsCommon($common_array);
        if (!($common_id))
        {
            return callback(false, '商品添加失败');
        }
        if (!(empty($param['image_all'])))
        {
            $this->_imageAll($common_id, $store_id, $param['image_all'], $common_array['goods_image']);
        }
        $goodsid_array = $this->_addGoods($param, $common_id, $common_array);
        if (!(empty($goodsid_array)))
        {
            QueueClient::push('createGoodsQRCode', array('store_id' => $store_id, 'goodsid_array' => $goodsid_array));
        }
        if (isset($param['starttime']))
        {
            $selltime = strtotime($param['starttime']) + (intval($param['starttime_H']) * 3600) + (intval($param['starttime_i']) * 60);
            if (TIMESTAMP < $selltime)
            {
                Model('cron')->addCron(array('exetime' => $selltime, 'exeid' => $common_id, 'type' => 1), true);
            }
        }
        Model('cron')->addCron(array('exetime' => TIMESTAMP, 'exeid' => $common_id, 'type' => 9), true);
        $this->_recordLog('添加商品，SPU:' . $common_id, $seller_id, $seller_name, $store_id);
        return callback(true, '', $common_id);
    }
    public function updateGoods($param, $store_id, $store_name, $store_state, $seller_id, $seller_name, $bind_all_gc)
    {
        $model_goods = Model('goods');
        $common_id = intval($param['commonid']);
        if ($common_id <= 0)
        {
            return callback(false, '商品编辑失败');
        }
        $error = $this->_validParam($param);
        if ($error != '')
        {
            return callback(false, $error);
        }
        $gc_id = intval($param['cate_id']);
        $data = Model('goods_class')->getGoodsClassForCacheModel();
        if (!(isset($data[$gc_id])) || isset($data[$gc_id]['child']) || isset($data[$gc_id]['childchild']))
        {
            return callback(false, '您选择的分类不存在，或没有选择到最后一级，请重新选择分类。');
        }
        if (!(checkPlatformStoreBindingAllGoodsClass($store_id, $bind_all_gc)))
        {
            $where = array();
            $where['class_1|class_2|class_3'] = $gc_id;
            $where['store_id'] = $store_id;
            $rs = Model('store_bind_class')->getStoreBindClassInfo($where);
            if (empty($rs))
            {
                return callback(false, '您的店铺没有绑定该分类，请重新选择分类。');
            }
        }
        $common_array = $this->_initCommonGoodsByParam($param, $store_id, $store_name, $store_state);
        if (APP_ID == 'mobile')
        {
            unset($common_array['brand_id'], $common_array['brand_name'], $common_array['mobile_body'], $common_array['plateid_top'], $common_array['plateid_bottom'], $common_array['sup_id']);
        }
        extract($this->_editGoods($param, $common_id, $common_array, $store_id));
        $model_goods->delGoods(array( 'goods_id' => array('not in', $goodsid_array), 'goods_commonid' => $common_id, 'store_id' => $store_id ));
        $model_goods->delGoodsImages(array( 'goods_commonid' => $common_id, 'color_id' => array('not in', $colorid_array) ));
        $default_image_list = $model_goods->getGoodsImageList(array('goods_commonid' => $common_id, 'is_default' => 1), 'color_id ,goods_image');
        if (!(empty($default_image_list)))
        {
            foreach ($default_image_list as $val )
            {
                $model_goods->editGoods(array('goods_image' => $val['goods_image']), array('goods_commonid' => $common_id, 'color_id' => $val['color_id']));
            }
        }
        if (isset($param['starttime']))
        {
            $selltime = strtotime($param['starttime']) + (intval($param['starttime_H']) * 3600) + (intval($param['starttime_i']) * 60);
            if (TIMESTAMP < $selltime)
            {
                Model('cron')->addCron(array('exetime' => $selltime, 'exeid' => $common_id, 'type' => 1), true);
            }
        }
        if ($common_array['is_virtual'] == 1)
        {
            QueueClient::push('clearSpecialGoodsPromotion', array('goods_commonid' => $common_id, 'goodsid_array' => $goodsid_array));
        }
        else
        {
            QueueClient::push('updateGoodsPromotionPriceByGoodsCommonId', $common_id);
        }
        $common_array['pfs'] = serialize($param['pfs']);
        $return = $model_goods->editGoodsCommon($common_array, array('goods_commonid' => $common_id, 'store_id' => $store_id));
        if (!($return))
        {
            return callback(false, '商品编辑失败');
        }
        if (!(empty($goodsid_array)))
        {
            QueueClient::push('createGoodsQRCode', array('store_id' => $store_id, 'goodsid_array' => $goodsid_array));
        }
        $this->_recordLog('编辑商品，SPU:' . $common_id, $seller_id, $seller_name, $store_id);
        return callback(true, '', $common_id);
    }
    private function _validParam($param)
    {
        $obj_validate = new Validate();
        $obj_validate->validateparam = array( array('input' => $param['g_name'], 'require' => 'true', 'message' => L('store_goods_index_goods_name_null')), array('input' => $param['g_price'], 'require' => 'true', 'validator' => 'Double', 'message' => L('store_goods_index_goods_price_null')) );
        return $obj_validate->validate();
    }
    private function _initCommonGoodsByParam($param, $store_id, $store_name, $store_state)
    {
        $goods_class = Model('goods_class')->getGoodsClassLineForTag(intval($param['cate_id']));
        $common_array = array();
        $common_array['goods_name'] = $param['g_name'];
        $common_array['goods_jingle'] = $param['g_jingle'];
        $common_array['gc_id'] = intval($param['cate_id']);
        $common_array['gc_id_1'] = intval($goods_class['gc_id_1']);
        $common_array['gc_id_2'] = intval($goods_class['gc_id_2']);
        $common_array['gc_id_3'] = intval($goods_class['gc_id_3']);
        $common_array['gc_name'] = $param['cate_name'];
        $common_array['brand_id'] = $param['b_id'];
        $common_array['brand_name'] = $param['b_name'];
        $common_array['type_id'] = intval($param['type_id']);
        $common_array['goods_image'] = $param['image_path'];
        $common_array['goods_price'] = floatval($param['g_price']);
        $common_array['goods_marketprice'] = floatval($param['g_marketprice']);
        $common_array['goods_costprice'] = floatval($param['g_costprice']);
        $common_array['goods_discount'] = floatval($param['g_discount']);
        $common_array['goods_serial'] = $param['g_serial'];
        $common_array['goods_storage_alarm'] = intval($param['g_alarm']);
        $common_array['goods_barcode'] = $param['g_barcode'];
        $common_array['goods_attr'] = serialize($param['attr']);
        $common_array['goods_custom'] = serialize($param['custom']);
        $common_array['goods_body'] = $param['g_body'];
        $common_array['mobile_body'] = $this->_getMobileBody($param['m_body']);
        $common_array['goods_commend'] = intval($param['g_commend']);
        $common_array['goods_state'] = (($store_state != 1 ? 0 : intval($param['g_state'])));
        $common_array['goods_addtime'] = TIMESTAMP;
        $common_array['goods_selltime'] = strtotime($param['starttime']) + (intval($param['starttime_H']) * 3600) + (intval($param['starttime_i']) * 60);
        $common_array['goods_verify'] = ((C('goods_verify') == 1 ? 10 : 1));
        $common_array['store_id'] = $store_id;
        $common_array['store_name'] = $store_name;
        $common_array['spec_name'] = ((is_array($param['spec']) ? serialize($param['sp_name']) : serialize(NULL)));
        $common_array['spec_value'] = ((is_array($param['spec']) ? serialize($param['sp_val']) : serialize(NULL)));
        $common_array['goods_vat'] = intval($param['g_vat']);
        $common_array['areaid_1'] = intval($param['province_id']);
        $common_array['areaid_2'] = intval($param['city_id']);
        $common_array['transport_id'] = (($param['freight'] == '0' ? '0' : intval($param['transport_id'])));
        $common_array['transport_title'] = $param['transport_title'];
        $common_array['goods_freight'] = floatval($param['g_freight']);
        $common_array['goods_stcids'] = $this->_getStoreClassArray($param['sgcate_id'], $store_id);
        $common_array['plateid_top'] = ((0 < intval($param['plate_top']) ? intval($param['plate_top']) : 0));
        $common_array['plateid_bottom'] = ((0 < intval($param['plate_bottom']) ? intval($param['plate_bottom']) : 0));
        $common_array['is_virtual'] = intval($param['is_gv']);
        $common_array['virtual_indate'] = ((!(empty($param['g_vindate'])) ? (strtotime($param['g_vindate']) + (24 * 60 * 60)) - 1 : 0));
        $common_array['virtual_limit'] = (((10 < intval($param['g_vlimit'])) || (intval($param['g_vlimit']) < 0) ? 10 : intval($param['g_vlimit'])));
        $common_array['virtual_invalid_refund'] = intval($param['g_vinvalidrefund']);
        $common_array['sup_id'] = $param['sup_id'];
        $common_array['is_own_mall'] = ((in_array($store_id, Model('store')->getOwnMallIds()) ? 1 : 0));
        $common_array['goods_unit'] = $param['goods_unit'];
        $common_array['is_vip'] = intval($param['g_vip']);
        $common_array['is_pf'] = intval($param['g_pf']);
        $common_array['pf_num1'] = intval($param['g_pfnum1']);
        $common_array['pf_num2'] = intval($param['g_pfnum2']);
        $common_array['pf_num3'] = intval($param['g_pfnum3']);
        $common_array['pf_price1'] = floatval($param['g_pfprice1']);
        $common_array['pf_price2'] = floatval($param['g_pfprice2']);
        $common_array['pf_price3'] = floatval($param['g_pfprice3']);
        $common_array['pf_poinst1'] = intval($param['g_poinst1']);
        $common_array['pf_poinst2'] = intval($param['g_poinst2']);
        $common_array['pf_poinst3'] = intval($param['g_poinst3']);
        $common_array['pfs'] = serialize($_POST['pfs']);
        return $common_array;
    }
    private function _getMobileBody($mobile_body)
    {
        if ($mobile_body != '')
        {
            $mobile_body = str_replace('&quot;', '"', $mobile_body);
            $mobile_body = json_decode($mobile_body, true);
            if (!(empty($mobile_body)))
            {
                return serialize($mobile_body);
            }
        }
        return '';
    }
    private function _getStoreClassArray($sgcate_id, $store_id)
    {
        $goods_stcids_arr = array();
        if (!(empty($sgcate_id)))
        {
            $sgcate_id_arr = array();
            foreach ($sgcate_id as $k => $v )
            {
                $sgcate_id_arr[] = intval($v);
            }
            $sgcate_id_arr = array_unique($sgcate_id_arr);
            $store_goods_class = Model('store_goods_class')->getStoreGoodsClassList(array( 'store_id' => $store_id, 'stc_id' => array('in', $sgcate_id_arr), 'stc_state' => '1' ));
            if (!(empty($store_goods_class)))
            {
                foreach ($store_goods_class as $k => $v )
                {
                    if (0 < $v['stc_id'])
                    {
                        $goods_stcids_arr[] = $v['stc_id'];
                    }
                    if (0 < $v['stc_parent_id'])
                    {
                        $goods_stcids_arr[] = $v['stc_parent_id'];
                    }
                }
                $goods_stcids_arr = array_unique($goods_stcids_arr);
                sort($goods_stcids_arr);
            }
        }
        if (empty($goods_stcids_arr))
        {
            return '';
        }
        return ',' . implode(',', $goods_stcids_arr) . ',';
    }
    private function _addGoods($param, $common_id, $common_array)
    {
        $goodsid_array = array();
        $model_goods = Model('goods');
        $model_type = Model('type');
        if (is_array($param['spec']))
        {
            foreach ($param['spec'] as $value )
            {
                $goods = $this->_initGoodsByCommonGoods($common_id, $common_array);
                $goods['goods_name'] = $common_array['goods_name'] . ' ' . implode(' ', $value['sp_value']);
                $goods['goods_price'] = $value['price'];
                $goods['goods_promotion_price'] = $value['price'];
                $goods['goods_marketprice'] = (($value['marketprice'] == 0 ? $common_array['goods_marketprice'] : $value['marketprice']));
                $goods['goods_serial'] = $value['sku'];
                $goods['goods_storage_alarm'] = intval($value['alarm']);
                $goods['goods_spec'] = serialize($value['sp_value']);
                $goods['goods_storage'] = $value['stock'];
                $goods['goods_barcode'] = $value['barcode'];
                $goods['color_id'] = intval($value['color']);
                $goods['pf'] = serialize($value['pf']);
                $goods['ifpf'] = ((0 < $value['pf']['f1'] ? 1 : 0));
                $goods_id = $model_goods->addGoods($goods);
                $model_type->addGoodsType($goods_id, $common_id, array('cate_id' => $param['cate_id'], 'type_id' => $param['type_id'], 'attr' => $param['attr']));
                $goodsid_array[] = $goods_id;
            }
        }
        else
        {
            $goods = $this->_initGoodsByCommonGoods($common_id, $common_array);
            $goods['goods_name'] = $common_array['goods_name'];
            $goods['goods_price'] = $common_array['goods_price'];
            $goods['goods_promotion_price'] = $common_array['goods_price'];
            $goods['goods_marketprice'] = $common_array['goods_marketprice'];
            $goods['goods_serial'] = $common_array['goods_serial'];
            $goods['goods_storage_alarm'] = $common_array['goods_storage_alarm'];
            $goods['goods_spec'] = serialize(NULL);
            $goods['goods_storage'] = intval($param['g_storage']);
            $goods['goods_barcode'] = $common_array['goods_barcode'];
            $goods['color_id'] = 0;
            $goods['pf'] = serialize($param['pfs']);
            $goods['ifpf'] = ((0 < $param['pfs']['f1'] ? 1 : 0));
            $goods_id = $model_goods->addGoods($goods);
            $model_type->addGoodsType($goods_id, $common_id, array('cate_id' => $param['cate_id'], 'type_id' => $param['type_id'], 'attr' => $param['attr']));
            $goodsid_array[] = $goods_id;
        }
        return $goodsid_array;
    }
    private function _editGoods($param, $common_id, $common_array, $store_id)
    {
        $goodsid_array = array();
        $colorid_array = array();
        $model_goods = Model('goods');
        $model_type = Model('type');
        $model_type->delGoodsAttr(array('goods_commonid' => $common_id));
        if (is_array($param['spec']))
        {
            foreach ($param['spec'] as $value )
            {
                $goods = $this->_initGoodsByCommonGoods($common_id, $common_array);
                $goods_info = $model_goods->getGoodsInfo(array('goods_id' => $value['goods_id'], 'goods_commonid' => $common_id, 'store_id' => $store_id), 'goods_id');
                if (!(empty($goods_info)))
                {
                    $goods_id = $goods_info['goods_id'];
                    $goods['goods_name'] = $common_array['goods_name'] . ' ' . implode(' ', $value['sp_value']);
                    $goods['goods_price'] = $value['price'];
                    $goods['goods_marketprice'] = (($value['marketprice'] == 0 ? $common_array['goods_marketprice'] : $value['marketprice']));
                    $goods['goods_serial'] = $value['sku'];
                    $goods['goods_storage_alarm'] = intval($value['alarm']);
                    $goods['goods_spec'] = serialize($value['sp_value']);
                    $goods['goods_storage'] = $value['stock'];
                    $goods['goods_barcode'] = $value['barcode'];
                    $goods['color_id'] = intval($value['color']);
                    if ($common_array['is_virtual'] == 1)
                    {
                        $goods['have_gift'] = 0;
                        Model('goods_gift')->delGoodsGift(array('goods_id' => $goods_id));
                        Model('goods_fcode')->delGoodsFCode(array('goods_id' => $goods_id));
                    }
                    unset($goods['goods_image'], $goods['goods_addtime']);
                    $goods['pf'] = serialize($value['pf']);
                    $goods['ifpf'] = ((0 < $value['pf']['f1'] ? 1 : 0));
                    $model_goods->editGoodsById($goods, $goods_id);
                }
                else
                {
                    $goods['goods_name'] = $common_array['goods_name'] . ' ' . implode(' ', $value['sp_value']);
                    $goods['goods_price'] = $value['price'];
                    $goods['goods_promotion_price'] = $value['price'];
                    $goods['goods_marketprice'] = (($value['marketprice'] == 0 ? $common_array['goods_marketprice'] : $value['marketprice']));
                    $goods['goods_serial'] = $value['sku'];
                    $goods['goods_storage_alarm'] = intval($value['alarm']);
                    $goods['goods_spec'] = serialize($value['sp_value']);
                    $goods['goods_storage'] = $value['stock'];
                    $goods['goods_barcode'] = $value['barcode'];
                    $goods['color_id'] = intval($value['color']);
                    $goods['pf'] = serialize($value['pf']);
                    $goods['ifpf'] = ((0 < $value['pf']['f1'] ? 1 : 0));
                    $rs = $goods_id = $model_goods->addGoods($goods);
                }
                $goodsid_array[] = intval($goods_id);
                $colorid_array[] = intval($value['color']);
                $model_type->addGoodsType($goods_id, $common_id, array('cate_id' => $param['cate_id'], 'type_id' => $param['type_id'], 'attr' => $param['attr']));
            }
        }
        else
        {
            if (C('dbdriver') == 'mysql')
            {
                $goods_spec_field_name = 'goods_spec';
            }
            else
            {
                $goods_spec_field_name = 'to_char(goods_spec)';
            }
            $goods = $this->_initGoodsByCommonGoods($common_id, $common_array);
            $goods_info = $model_goods->getGoodsInfo(array($goods_spec_field_name => serialize(NULL), 'goods_commonid' => $common_id, 'store_id' => $store_id), 'goods_id');
            if (!(empty($goods_info)))
            {
                $goods_id = $goods_info['goods_id'];
                $goods['goods_name'] = $common_array['goods_name'];
                $goods['goods_price'] = $common_array['goods_price'];
                $goods['goods_marketprice'] = $common_array['goods_marketprice'];
                $goods['goods_serial'] = $common_array['goods_serial'];
                $goods['goods_storage_alarm'] = $common_array['goods_storage_alarm'];
                $goods['goods_spec'] = serialize(NULL);
                $goods['goods_storage'] = intval($param['g_storage']);
                $goods['goods_barcode'] = $common_array['goods_barcode'];
                $goods['color_id'] = 0;
                if ($common_array['is_virtual'] == 1)
                {
                    $goods['have_gift'] = 0;
                    Model('goods_gift')->delGoodsGift(array('goods_id' => $goods_id));
                    Model('goods_fcode')->delGoodsFCode(array('goods_id' => $goods_id));
                }
                unset($goods['goods_image'], $goods['goods_addtime']);
                $goods['pf'] = $common_array['pfs'];
                $pf = unserialize($goods['pf']);
                $goods['ifpf'] = ((0 < $pf['f1'] ? 1 : 0));
                $model_goods->editGoodsById($goods, $goods_id);
            }
            else
            {
                $goods['goods_name'] = $common_array['goods_name'];
                $goods['goods_price'] = $common_array['goods_price'];
                $goods['goods_promotion_price'] = $common_array['goods_price'];
                $goods['goods_marketprice'] = $common_array['goods_marketprice'];
                $goods['goods_serial'] = $common_array['goods_serial'];
                $goods['goods_storage_alarm'] = $common_array['goods_storage_alarm'];
                $goods['goods_spec'] = serialize(NULL);
                $goods['goods_storage'] = intval($param['g_storage']);
                $goods['goods_barcode'] = $common_array['goods_barcode'];
                $goods['color_id'] = 0;
                $goods['pf'] = $common_array['pfs'];
                $pf = unserialize($goods['pf']);
                $goods['ifpf'] = ((0 < $pf['f1'] ? 1 : 0));
                $goods_id = $model_goods->addGoods($goods);
            }
            $goodsid_array[] = intval($goods_id);
            $colorid_array[] = 0;
            $model_type->addGoodsType($goods_id, $common_id, array('cate_id' => $param['cate_id'], 'type_id' => $param['type_id'], 'attr' => $param['attr']));
        }
        return array('goodsid_array' => $goodsid_array, 'colorid_array' => array_unique($colorid_array));
    }
    private function _initGoodsByCommonGoods($common_id, $common_array)
    {
        $goods = array();
        $goods['goods_commonid'] = $common_id;
        $goods['goods_jingle'] = $common_array['goods_jingle'];
        $goods['store_id'] = $common_array['store_id'];
        $goods['store_name'] = $common_array['store_name'];
        $goods['gc_id'] = $common_array['gc_id'];
        $goods['gc_id_1'] = $common_array['gc_id_1'];
        $goods['gc_id_2'] = $common_array['gc_id_2'];
        $goods['gc_id_3'] = $common_array['gc_id_3'];
        $goods['brand_id'] = $common_array['brand_id'];
        $goods['spec_name'] = $common_array['spec_name'];
        $goods['goods_image'] = $common_array['goods_image'];
        $goods['goods_state'] = $common_array['goods_state'];
        $goods['goods_verify'] = $common_array['goods_verify'];
        $goods['goods_addtime'] = TIMESTAMP;
        $goods['goods_edittime'] = TIMESTAMP;
        $goods['areaid_1'] = $common_array['areaid_1'];
        $goods['areaid_2'] = $common_array['areaid_2'];
        $goods['transport_id'] = $common_array['transport_id'];
        $goods['goods_freight'] = $common_array['goods_freight'];
        $goods['goods_vat'] = $common_array['goods_vat'];
        $goods['goods_commend'] = $common_array['goods_commend'];
        $goods['goods_stcids'] = $common_array['goods_stcids'];
        $goods['is_virtual'] = $common_array['is_virtual'];
        $goods['virtual_indate'] = $common_array['virtual_indate'];
        $goods['virtual_limit'] = $common_array['virtual_limit'];
        $goods['virtual_invalid_refund'] = $common_array['virtual_invalid_refund'];
        $goods['is_own_mall'] = $common_array['is_own_mall'];
        $goods['goods_unit'] = $common_array['goods_unit'];
        $goods['is_vip'] = $common_array['is_vip'];
        $goods['is_pf'] = $common_array['is_pf'];
        $goods['pf_num1'] = $common_array['pf_num1'];
        $goods['pf_num2'] = $common_array['pf_num2'];
        $goods['pf_num3'] = $common_array['pf_num3'];
        $goods['pf_price1'] = $common_array['pf_price1'];
        $goods['pf_price2'] = $common_array['pf_price2'];
        $goods['pf_price3'] = $common_array['pf_price3'];
        $goods['pf_poinst1'] = $common_array['pf_poinst1'];
        $goods['pf_poinst2'] = $common_array['pf_poinst2'];
        $goods['pf_poinst3'] = $common_array['pf_poinst3'];
        return $goods;
    }
    private function _imageAll($common_id, $store_id, $image_all, $image_main)
    {
        $model_goods = Model('goods');
        $image_array = explode(',', $image_all);
        $insert_array = array();
        foreach ($image_array as $value )
        {
            if (!(empty($value)))
            {
                $tmp_insert = array();
                $tmp_insert['goods_commonid'] = $common_id;
                $tmp_insert['store_id'] = $store_id;
                $tmp_insert['color_id'] = 0;
                $tmp_insert['goods_image'] = $value;
                $tmp_insert['goods_image_sort'] = 0;
                if ($value == $image_main)
                {
                    $tmp_insert['is_default'] = 1;
                }
                else
                {
                    $tmp_insert['is_default'] = 0;
                }
                $insert_array[] = $tmp_insert;
            }
        }
        $model_goods->addGoodsImagesAll($insert_array);
    }
    private function _recordLog($content = '', $seller_id, $seller_name, $store_id, $state = 1)
    {
        $log = array();
        $log['log_content'] = $content;
        $log['log_time'] = TIMESTAMP;
        $log['log_seller_id'] = $seller_id;
        $log['log_seller_name'] = $seller_name;
        $log['log_store_id'] = $store_id;
        $log['log_seller_ip'] = getIp();
        $log['log_url'] = 'goodsLogic&saveGoods';
        $log['log_state'] = $state;
        $model_seller_log = Model('seller_log');
        $model_seller_log->addSellerLog($log);
    }
    public function uploadGoodsImage($image_name, $store_id, $album_limit)
    {
        $model_album = Model('album');
        if (0 < $album_limit)
        {
            $album_count = $model_album->getCount(array('store_id' => $store_id));
            if ($album_limit <= $album_count)
            {
                return callback(false, L('store_goods_album_climit'));
            }
        }
        $class_info = $model_album->getOne(array('store_id' => $store_id, 'is_default' => 1), 'album_class');
        $upload = new UploadFile();
        $upload->set('default_dir', ATTACH_GOODS . DS . $store_id . DS . $upload->getSysSetPath());
        $upload->set('max_size', C('image_max_filesize'));
        $upload->set('thumb_width', GOODS_IMAGES_WIDTH);
        $upload->set('thumb_height', GOODS_IMAGES_HEIGHT);
        $upload->set('thumb_ext', GOODS_IMAGES_EXT);
        $upload->set('fprefix', $store_id);
        $upload->set('allow_type', array('gif', 'jpg', 'jpeg', 'png'));
        $result = $upload->upfile($image_name, true);
        if (!($result))
        {
            return callback(false, $upload->error);
        }
        $img_path = $upload->getSysSetPath() . $upload->file_name;
        if (!(C('oss.open')))
        {
            list($width, $height, $type, $attr) = getimagesize(BASE_UPLOAD_PATH . '/' . ATTACH_GOODS . '/' . $store_id . DS . $img_path);
        }
        else
        {
            list($width, $height, $type, $attr) = getimagesize(C('oss.img_url') . '/' . ATTACH_GOODS . '/' . $store_id . DS . $img_path);
        }
        $image = explode('.', $_FILES[$image_name]['name']);
        $insert_array = array();
        $insert_array['apic_name'] = $image[0];
        $insert_array['apic_tag'] = '';
        $insert_array['aclass_id'] = $class_info['aclass_id'];
        $insert_array['apic_cover'] = $img_path;
        $insert_array['apic_size'] = intval($_FILES[$image_name]['size']);
        $insert_array['apic_spec'] = $width . 'x' . $height;
        $insert_array['upload_time'] = TIMESTAMP;
        $insert_array['store_id'] = $store_id;
        $model_album->addPic($insert_array);
        $data = array();
        $data['thumb_name'] = cthumb($img_path, 240, $store_id);
        $data['name'] = $img_path;
        return callback(true, '', $data);
    }
    public function editSaveImage($img, $common_id, $store_id, $seller_id, $seller_name)
    {
        if (($common_id <= 0) || empty($_POST['img']))
        {
            return callback(false, '参数错误');
        }
        $model_goods = Model('goods');
        $model_goods->delGoodsImages(array('goods_commonid' => $common_id, 'store_id' => $store_id));
        $insert_array = array();
        foreach ($_POST['img'] as $key => $value )
        {
            $k = 0;
            foreach ($value as $v )
            {
                if ($v['name'] == '')
                {
                    continue;
                }
                $update_array = array();
                $update_where = array();
                $update_array['goods_image'] = $v['name'];
                $update_where['goods_commonid'] = $common_id;
                $update_where['store_id'] = $store_id;
                $update_where['color_id'] = $key;
                if (($k == 0) || ($v['default'] == 1))
                {
                    ++$k;
                    $update_array['goods_image'] = $v['name'];
                    $update_where['goods_commonid'] = $common_id;
                    $update_where['store_id'] = $store_id;
                    $update_where['color_id'] = $key;
                    $model_goods->editGoods($update_array, $update_where);
                }
                $tmp_insert = array();
                $tmp_insert['goods_commonid'] = $common_id;
                $tmp_insert['store_id'] = $store_id;
                $tmp_insert['color_id'] = $key;
                $tmp_insert['goods_image'] = $v['name'];
                $tmp_insert['goods_image_sort'] = (($v['default'] == 1 ? 0 : $v['sort']));
                $tmp_insert['is_default'] = $v['default'];
                $insert_array[] = $tmp_insert;
            }
        }
        $rs = $model_goods->addGoodsImagesAll($insert_array);
        if ($rs)
        {
            $this->_recordLog('商品图片编辑，SPU:' . $common_id, $seller_id, $seller_name, $store_id);
            return callback(true);
        }
        return callback(false, '商品图片编辑失败');
    }
    public function goodsShow($commonid_array, $store_id, $seller_id, $seller_name)
    {
        $return = Model('goods')->editProducesOnline(array( 'goods_commonid' => array('in', $commonid_array), 'store_id' => $store_id ));
        if ($return)
        {
            $this->_recordLog('商品上架，SPU:' . implode(',', $commonid_array), $seller_id, $seller_name, $store_id);
            return callback(true);
        }
        return callback(false, '商品上架失败');
    }
    public function goodsUnShow($commonid_array, $store_id, $seller_id, $seller_name)
    {
        $model_goods = Model('goods');
        $where = array();
        $where['goods_commonid'] = array('in', $commonid_array);
        $where['store_id'] = $store_id;
        $return = Model('goods')->editProducesOffline($where);
        if ($return)
        {
            $goods_list = $model_goods->getGoodsList($where, 'goods_id');
            if (!(empty($goods_list)))
            {
                $goodsid_array = array();
                foreach ($goods_list as $val )
                {
                    $goodsid_array[] = $val['goods_id'];
                }
                Model('p_bundling')->editBundlingCloseByGoodsIds(array( 'goods_id' => array('in', $goodsid_array) ));
            }
            $this->_recordLog('商品下架，SPU:' . implode(',', $commonid_array), $seller_id, $seller_name, $store_id);
            return callback(true);
        }
        return callback(false, '商品下架失败');
    }
    public function goodsDrop($commonid_array, $store_id, $seller_id, $seller_name)
    {
        $return = Model('goods')->delGoodsNoLock(array( 'goods_commonid' => array('in', $commonid_array), 'store_id' => $store_id ));
        if ($return)
        {
            $this->_recordLog('删除商品，SPU：' . implode(',', $commonid_array), $seller_id, $seller_name, $store_id);
            return callback(true);
        }
        return callback(false, '商品删除失败');
    }
}
?>