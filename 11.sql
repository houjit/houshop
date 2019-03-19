/*
SQLyog Ultimate v11.27 (32 bit)
MySQL - 5.7.15-log : Database - feiwa_dev
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


/*Table structure for table `feiwa_activity` */

DROP TABLE IF EXISTS `feiwa_activity`;

CREATE TABLE `feiwa_activity` (
  `activity_id` mediumint(9) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `activity_title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `activity_type` enum('1','2') DEFAULT NULL COMMENT '活动类型 1:商品 2:团购',
  `activity_banner` varchar(255) NOT NULL DEFAULT '' COMMENT '活动横幅大图片',
  `activity_style` varchar(255) NOT NULL DEFAULT '' COMMENT '活动页面模板样式标识码',
  `activity_desc` varchar(1000) DEFAULT NULL COMMENT '描述',
  `activity_start_date` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `activity_end_date` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `activity_sort` tinyint(1) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  `activity_state` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '活动状态 0为关闭 1为开启',
  PRIMARY KEY (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='活动表';

/*Data for the table `feiwa_activity` */

insert  into `feiwa_activity`(`activity_id`,`activity_title`,`activity_type`,`activity_banner`,`activity_style`,`activity_desc`,`activity_start_date`,`activity_end_date`,`activity_sort`,`activity_state`) values (1,'活动','1','05641586865430658.jpg','default_style','',1510761600,1512489600,0,1);

/*Table structure for table `feiwa_activity_detail` */

DROP TABLE IF EXISTS `feiwa_activity_detail`;

CREATE TABLE `feiwa_activity_detail` (
  `activity_detail_id` mediumint(9) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `activity_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '活动编号',
  `item_id` int(11) NOT NULL COMMENT '商品或团购的编号',
  `item_name` varchar(255) NOT NULL DEFAULT '' COMMENT '商品或团购名称',
  `store_id` int(11) NOT NULL COMMENT '店铺编号',
  `store_name` varchar(255) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `activity_detail_state` enum('0','1','2','3') NOT NULL DEFAULT '0' COMMENT '审核状态 0:(默认)待审核 1:通过 2:未通过 3:再次申请',
  `activity_detail_sort` tinyint(1) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  PRIMARY KEY (`activity_detail_id`),
  KEY `activity_id` (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='活动细节表';

/*Data for the table `feiwa_activity_detail` */

insert  into `feiwa_activity_detail`(`activity_detail_id`,`activity_id`,`item_id`,`item_name`,`store_id`,`store_name`,`activity_detail_state`,`activity_detail_sort`) values (1,1,100213,'华为 HUAWEI Mate 10 4GB+64GB',7,'feng店铺名称','1',255);

/*Table structure for table `feiwa_address` */

DROP TABLE IF EXISTS `feiwa_address`;

CREATE TABLE `feiwa_address` (
  `address_id` mediumint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '地址ID',
  `member_id` mediumint(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `true_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员姓名',
  `area_id` mediumint(10) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `city_id` mediumint(9) DEFAULT NULL COMMENT '市级ID',
  `area_info` varchar(255) NOT NULL DEFAULT '' COMMENT '地区内容',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '地址',
  `tel_phone` varchar(20) DEFAULT NULL COMMENT '座机电话',
  `mob_phone` varchar(15) DEFAULT NULL COMMENT '手机电话',
  `is_default` enum('0','1') NOT NULL DEFAULT '0' COMMENT '1默认收货地址',
  `dlyp_id` int(11) DEFAULT '0' COMMENT '自提点ID',
  PRIMARY KEY (`address_id`),
  KEY `member_id` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8 COMMENT='买家地址信息表';

/*Data for the table `feiwa_address` */

insert  into `feiwa_address`(`address_id`,`member_id`,`true_name`,`area_id`,`city_id`,`area_info`,`address`,`tel_phone`,`mob_phone`,`is_default`,`dlyp_id`) values (233,1043,'1111',37,36,'北京 北京市 东城区','北京','1234567','13561113344','0',0),(234,1043,'sh',143,39,'上海 上海市 黄浦区','sh','123456778','13561113346','0',0),(235,1043,'gyn',2134,175,'浙江 杭州市 上城区','hzhzhzhzhzhzhz','0571-85024138','13888888888','0',0),(236,1057,'王总',4671,438,'陕西 西安市 灞桥区','国际港务区澜博跨境购物中心','','17691164888','0',0),(237,1055,'admin111',37,36,'北京 北京市 东城区','测试','','13800000000','0',0),(238,1043,'Yang Yuqiang',3059,291,'广东 深圳市 宝安区','西乡街道','135*8*8*9*6','12312341234','1',0),(239,1067,'iuser_aaa',144,39,'上海 上海市 卢湾区','海淀路',NULL,'17091902132','0',0);

/*Table structure for table `feiwa_admin` */

DROP TABLE IF EXISTS `feiwa_admin`;

CREATE TABLE `feiwa_admin` (
  `admin_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `admin_name` varchar(20) NOT NULL DEFAULT '' COMMENT '管理员名称',
  `admin_avatar` varchar(100) DEFAULT NULL COMMENT '管理员头像',
  `admin_password` varchar(32) NOT NULL DEFAULT '' COMMENT '管理员密码',
  `admin_login_time` int(10) NOT NULL DEFAULT '0' COMMENT '登录时间',
  `admin_login_num` int(11) NOT NULL DEFAULT '0' COMMENT '登录次数',
  `admin_is_super` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否超级管理员',
  `admin_gid` smallint(6) DEFAULT '0' COMMENT '权限组ID',
  `admin_quick_link` varchar(400) DEFAULT NULL COMMENT '管理员常用操作',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='管理员表';

/*Data for the table `feiwa_admin` */

insert  into `feiwa_admin`(`admin_id`,`admin_name`,`admin_avatar`,`admin_password`,`admin_login_time`,`admin_login_num`,`admin_is_super`,`admin_gid`,`admin_quick_link`) values (1,'admin',NULL,'eef7943ad16bad59dfaf8ee6869169c5',1536298588,161,1,0,'system|admin,reads|reads_manage'),(2,'adminy',NULL,'a65a0cad3e35822c49835a7b1087e41d',1533276434,250,0,1,'mall|brand,mall|goods_class,mall|type'),(3,'admintest',NULL,'c8837b23ff8aaa8a2dde915473ce0991',1515138605,1,0,1,NULL),(4,'oray',NULL,'078917df7bd3dc8b7c7b6aafc0c1de43',1524809491,13,0,1,NULL),(5,'xyr',NULL,'9b91efc9a0cef23ac92f71f5fb222a9c',1516076216,2,0,1,NULL);

/*Table structure for table `feiwa_admin_log` */

DROP TABLE IF EXISTS `feiwa_admin_log`;

CREATE TABLE `feiwa_admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(50) NOT NULL DEFAULT '' COMMENT '操作内容',
  `createtime` int(10) unsigned DEFAULT NULL COMMENT '发生时间',
  `admin_name` char(20) NOT NULL DEFAULT '' COMMENT '管理员',
  `admin_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `ip` char(15) NOT NULL DEFAULT '' COMMENT 'IP',
  `url` varchar(50) NOT NULL DEFAULT '' COMMENT 'act&op',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1525 DEFAULT CHARSET=utf8 COMMENT='管理员操作日志';

/*Data for the table `feiwa_admin_log` */

insert  into `feiwa_admin_log`(`id`,`content`,`createtime`,`admin_name`,`admin_id`,`ip`,`url`) values (602,'登录',1510302224,'admin',1,'114.80.215.216','login&login'),(603,'登录',1510302251,'admin',1,'114.80.215.216','login&login'),(604,'编辑商城设置',1510302376,'admin',1,'114.80.215.216','setting&'),(605,'编辑商城设置',1510302384,'admin',1,'114.80.215.216','setting&'),(606,'编辑邮件设置',1510302467,'admin',1,'114.80.215.216','message&'),(607,'编辑文章成功[testmall火热销售中]',1510302655,'admin',1,'114.80.215.216','article&article_edit'),(608,'資訊管理保存失败',1510302950,'admin',1,'114.80.215.216','reads_manage&reads_manage_save'),(609,'设置手机端下载地址',1510303050,'admin',1,'114.80.215.216','mb_app&'),(610,'编辑运营控件',1510303126,'admin',1,'114.80.215.216','feiwa&'),(611,'编辑顶部广告',1510303356,'admin',1,'114.80.215.216','feiwa&banner'),(612,'修改抢购幻灯片设置',1510304013,'admin',1,'114.80.215.216','groupbuy&slider'),(613,'登录',1510304763,'admin',1,'114.80.215.216','login&login'),(614,'登录',1510305235,'admin',1,'114.80.215.216','login&login'),(615,'清理缓存',1510305421,'admin',1,'114.80.215.216','cache&'),(616,'编辑运营控件',1510307134,'admin',1,'114.80.215.216','feiwa&'),(617,'登录',1510307516,'admin',1,'114.80.215.216','login&login'),(618,'登录',1510322555,'admin',1,'114.80.153.110','login&login'),(619,'登录',1510540597,'admin',1,'114.80.215.216','login&login'),(620,'登录',1510541361,'admin',1,'114.80.215.216','login&login'),(621,'清理缓存',1510541628,'admin',1,'114.80.215.216','cache&'),(622,'清理缓存',1510541644,'admin',1,'114.80.215.216','cache&'),(623,'清理缓存',1510543722,'admin',1,'114.80.215.216','cache&'),(624,'登录',1510550029,'admin',1,'114.80.215.216','login&login'),(625,'登录',1510550343,'admin',1,'114.80.153.110','login&login'),(626,'登录',1510550424,'admin',1,'114.80.215.216','login&login'),(627,'编辑商城设置',1510550982,'admin',1,'114.80.153.110','setting&'),(628,'编辑商城设置',1510551094,'admin',1,'114.80.153.110','setting&'),(629,'資訊管理保存失败',1510551538,'admin',1,'114.80.153.110','reads_manage&reads_manage_save'),(630,'编辑商城设置',1510552258,'admin',1,'114.80.153.110','setting&'),(631,'資訊管理保存失败',1510552288,'admin',1,'114.80.153.110','reads_manage&reads_manage_save'),(632,'编辑商城设置',1510552370,'admin',1,'114.80.153.110','setting&base'),(633,'資訊首页模块编辑，模块编号19',1510552625,'admin',1,'114.80.153.110','reads_index&save_page_module'),(634,'清理缓存',1510552964,'admin',1,'114.80.153.110','cache&'),(635,'编辑商城设置',1510553281,'admin',1,'114.80.215.216','setting&'),(636,'广告信息修改成功[FeiWa购买]',1510553763,'admin',1,'114.80.153.110','adv&adv_edit'),(637,'清理缓存',1510554100,'admin',1,'114.80.153.110','cache&'),(638,'登录',1510554233,'admin',1,'101.226.179.113','login&login'),(639,'编辑规格[颜色]',1510554347,'admin',1,'114.80.153.110','spec&spec_edit'),(640,'清理缓存',1510554348,'admin',1,'101.226.179.113','cache&'),(641,'编辑规格[颜色]',1510554369,'admin',1,'114.80.153.110','spec&spec_edit'),(642,'資訊导航删除，导航编号1',1510554526,'admin',1,'114.80.153.110','reads_navigation&reads_navigation_drop'),(643,'資訊导航删除，导航编号2',1510554533,'admin',1,'114.80.153.110','reads_navigation&reads_navigation_drop'),(644,'資訊导航删除，导航编号3',1510554542,'admin',1,'114.80.153.110','reads_navigation&reads_navigation_drop'),(645,'資訊导航删除，导航编号4',1510554549,'admin',1,'114.80.153.110','reads_navigation&reads_navigation_drop'),(646,'清理缓存',1510556969,'admin',1,'114.80.153.110','cache&'),(647,'开启圈子',1510557197,'admin',1,'114.80.153.110','circle_setting&'),(648,'清理缓存',1510559351,'admin',1,'114.80.153.110','cache&'),(649,'登录',1510564426,'admin',1,'114.80.215.216','login&login'),(650,'编辑商城设置',1510564442,'admin',1,'114.80.215.216','setting&'),(651,'编辑商城设置',1510564476,'admin',1,'114.80.215.216','setting&'),(652,'编辑商城设置',1510564559,'admin',1,'114.80.215.216','setting&'),(653,'编辑商城设置',1510564573,'admin',1,'114.80.215.216','setting&'),(654,'编辑商城设置',1510565295,'admin',1,'114.80.215.216','setting&'),(655,'登录',1510622513,'admin',1,'101.226.179.113','login&login'),(656,'登录',1510623359,'admin',1,'114.80.215.216','login&login'),(657,'编辑商城设置',1510624772,'admin',1,'114.80.215.216','setting&'),(658,'编辑商城设置',1510624869,'admin',1,'114.80.215.216','setting&'),(659,'编辑商城设置',1510624905,'admin',1,'114.80.215.216','setting&'),(660,'資訊文章分类保存，分类编号7',1510625480,'admin',1,'114.80.215.216','reads_article_class&reads_article_class_save'),(661,'登录',1510626074,'admin',1,'114.80.153.110','login&login'),(662,'编辑会员[ID:1]',1510626118,'admin',1,'114.80.215.216','member&member_edit'),(663,'資訊文章分类保存，分类编号8',1510627302,'admin',1,'114.80.215.216','reads_article_class&reads_article_class_save'),(664,'编辑商城设置',1510627723,'admin',1,'114.80.153.110','setting&'),(665,'编辑',1510628100,'admin',1,'114.80.153.110','circle_adv&'),(666,'資訊管理保存失败',1510628794,'admin',1,'114.80.153.110','reads_manage&reads_manage_save'),(667,'登录',1510629871,'admin',1,'101.226.179.113','login&login'),(668,'编辑文章成功[testmall火热销售中11]',1510629969,'admin',1,'101.226.179.113','article&article_edit'),(669,'编辑文章成功[testmall火热销售中11]',1510629970,'admin',1,'101.226.179.113','article&article_edit'),(670,'编辑文章成功[s管理功能说明11]',1510629998,'admin',1,'101.226.179.113','article&article_edit'),(671,'编辑文章成功[s管理功能说明11]',1510630031,'admin',1,'101.226.179.113','article&article_edit'),(672,'编辑文章成功[testmall火热销售中11]',1510630063,'admin',1,'101.226.179.113','article&article_edit'),(673,'编辑文章成功[s管理功能说明11]',1510631740,'admin',1,'101.226.179.113','article&article_edit'),(674,'编辑文章成功[s管理功能说明1123]',1510631797,'admin',1,'101.226.179.113','article&article_edit'),(675,'登录',1510636406,'admin',1,'114.80.153.110','login&login'),(676,'登录',1510636493,'admin',1,'114.80.215.216','login&login'),(677,'板块设计[女装/男装/内衣]',1510637261,'admin',1,'114.80.153.110','web_config&web_edit'),(678,'新增商城频道，编号602',1510637430,'admin',1,'114.80.153.110','web_channel&add_channel'),(679,'编辑商城设置',1510638002,'admin',1,'114.80.153.110','setting&'),(680,'编辑文章成功[部分测试功能未开启]',1510638139,'admin',1,'114.80.215.216','article&article_edit'),(681,'编辑文章成功[部分测试功能未开启11]',1510638174,'admin',1,'114.80.215.216','article&article_edit'),(682,'编辑文章成功[部分测试功能未开启s]',1510638211,'admin',1,'114.80.215.216','article&article_edit'),(683,'编辑文章成功[部分测试功能未开启s]',1510638394,'admin',1,'114.80.215.216','article&article_edit'),(684,'编辑文章成功[部分测试功能未开启sw]',1510638551,'admin',1,'114.80.215.216','article&article_edit'),(685,'编辑文章成功[s管理功能说明#]',1510638665,'admin',1,'114.80.215.216','article&article_edit'),(686,'编辑商城频道模块，编号601',1510638853,'admin',1,'114.80.153.110','web_channel&edit_floor'),(687,'编辑商城频道模块，编号601',1510638876,'admin',1,'114.80.153.110','web_channel&edit_floor'),(688,'编辑文章成功[s管理功能说明#12]',1510639663,'admin',1,'114.80.215.216','article&article_edit'),(689,'编辑防灌水设置',1510641543,'admin',1,'114.80.153.110','setting&dump'),(690,'编辑防灌水设置',1510641565,'admin',1,'114.80.153.110','setting&dump'),(691,'编辑防灌水设置',1510641576,'admin',1,'114.80.153.110','setting&dump'),(692,'清理缓存',1510642760,'admin',1,'114.80.153.110','cache&'),(693,'编辑顶部广告',1510644133,'admin',1,'114.80.153.110','feiwa&banner'),(694,'清理缓存',1510645453,'admin',1,'114.80.215.216','cache&'),(695,'登录',1510645853,'admin',1,'101.226.179.113','login&login'),(696,'编辑分类导航，个护化妆',1510645902,'admin',1,'101.226.179.113','goods_class&nav_edit'),(697,'编辑运营促销设定',1510646062,'admin',1,'114.80.153.110','operation&'),(698,'新增111张充值卡（面额￥1000，批次标识“”）',1510648229,'admin',1,'114.80.153.110','rechargecard&add_card'),(699,'广告信息修改成功[FeiWa购买]',1510648395,'admin',1,'114.80.153.110','adv&adv_edit'),(700,'广告位信息修改成功[首页焦点联动广告1]',1510648458,'admin',1,'114.80.153.110','adv&ap_edit'),(701,'广告位信息修改成功[首页焦点联动广告2]',1510648499,'admin',1,'114.80.153.110','adv&ap_edit'),(702,'广告位信息修改成功[首页焦点联动广告3]',1510648542,'admin',1,'114.80.153.110','adv&ap_edit'),(703,'板块设计[红色]',1510648590,'admin',1,'114.80.215.216','web_config&web_edit'),(704,'板块设计[橘色]',1510648638,'admin',1,'114.80.215.216','web_config&web_edit'),(705,'板块设计[女装/男装/内衣]',1510648672,'admin',1,'114.80.215.216','web_config&web_edit'),(706,'板块设计[绿色]',1510649361,'admin',1,'114.80.153.110','web_config&web_edit'),(707,'板块设计[前台首页]',1510649414,'admin',1,'114.80.153.110','web_config&web_edit'),(708,'板块设计[前台首页]',1510649414,'admin',1,'114.80.153.110','web_config&web_edit'),(709,'板块设计[蓝色]',1510649698,'admin',1,'114.80.153.110','web_config&web_edit'),(710,'板块设计[紫色]',1510649709,'admin',1,'114.80.153.110','web_config&web_edit'),(711,'板块设计[褐色]',1510649730,'admin',1,'114.80.153.110','web_config&web_edit'),(712,'板块设计[默认]',1510649796,'admin',1,'114.80.153.110','web_config&web_edit'),(713,'清理缓存',1510649965,'admin',1,'114.80.153.110','cache&'),(714,'清理缓存',1510650139,'admin',1,'114.80.153.110','cache&'),(715,'清理缓存',1510650190,'admin',1,'114.80.153.110','cache&'),(716,'清理缓存',1510651754,'admin',1,'114.80.153.110','cache&'),(717,'添加推荐位[]',1510651974,'admin',1,'114.80.153.110','rec_position&rec_save'),(718,'编辑文章成功[testmall火热销售中11]',1510653851,'admin',1,'114.80.153.110','article&article_edit'),(719,'登录',1510711486,'admin',1,'114.80.153.110','login&login'),(720,'编辑店铺[商城]',1510712221,'admin',1,'114.80.153.110','store&store_edit'),(721,'审核新经营类目申请，店铺ID：6',1510712508,'admin',1,'114.80.153.110','store&store_bind_class_applay_check'),(722,'审核新经营类目申请，店铺ID：6',1510712515,'admin',1,'114.80.153.110','store&store_bind_class_applay_check'),(723,'审核新经营类目申请，店铺ID：6',1510712521,'admin',1,'114.80.153.110','store&store_bind_class_applay_check'),(724,'审核新经营类目申请，店铺ID：6',1510712528,'admin',1,'114.80.153.110','store&store_bind_class_applay_check'),(725,'审核新经营类目申请，店铺ID：6',1510712534,'admin',1,'114.80.153.110','store&store_bind_class_applay_check'),(726,'登录',1510723136,'admin',1,'114.80.153.110','login&login'),(727,'编辑商城设置',1510723157,'admin',1,'114.80.153.110','setting&'),(728,'清理缓存',1510723206,'admin',1,'114.80.153.110','cache&'),(729,'清理缓存',1510723236,'admin',1,'114.80.153.110','cache&'),(730,'清理缓存',1510724098,'admin',1,'114.80.153.110','cache&'),(731,'清理缓存',1510725094,'admin',1,'114.80.153.110','cache&'),(732,'清理缓存',1510726983,'admin',1,'114.80.153.110','cache&'),(733,'清理缓存',1510728727,'admin',1,'114.80.153.110','cache&'),(734,'删除商品[ID:100102]',1510728856,'admin',1,'114.80.153.110','goods&goods_del'),(735,'删除商品[ID:100101]',1510728894,'admin',1,'114.80.153.110','goods&goods_del'),(736,'删除商品[ID:100100]',1510728899,'admin',1,'114.80.153.110','goods&goods_del'),(737,'编辑文章成功[天府大件运营中心开仓公告]',1510729033,'admin',1,'114.80.153.110','article&article_edit'),(738,'清理缓存',1510729060,'admin',1,'114.80.153.110','cache&'),(739,'清理缓存',1510729132,'admin',1,'114.80.153.110','cache&'),(740,'删除文章成功。[ID:35]',1510729183,'admin',1,'114.80.153.110','article&delete'),(741,'清理缓存',1510729190,'admin',1,'114.80.153.110','cache&'),(742,'编辑文章成功[管理功能说明]',1510729229,'admin',1,'114.80.153.110','article&article_edit'),(743,'清理缓存',1510729238,'admin',1,'114.80.153.110','cache&'),(744,'编辑文章成功[天府大件运营中心开仓公告]',1510729293,'admin',1,'114.80.153.110','article&article_edit'),(745,'清理缓存',1510729300,'admin',1,'114.80.153.110','cache&'),(746,'编辑文章成功[天府大件运营中心开仓公告]',1510729337,'admin',1,'114.80.153.110','article&article_edit'),(747,'审核新经营类目申请，店铺ID：6',1510730290,'admin',1,'114.80.153.110','store&store_bind_class_applay_check'),(748,'审核新经营类目申请，店铺ID：6',1510730296,'admin',1,'114.80.153.110','store&store_bind_class_applay_check'),(749,'审核新经营类目申请，店铺ID：6',1510730302,'admin',1,'114.80.153.110','store&store_bind_class_applay_check'),(750,'清理缓存',1510737538,'admin',1,'114.80.153.110','cache&'),(751,'清理缓存',1510737635,'admin',1,'114.80.153.110','cache&'),(752,'登录',1510796521,'admin',1,'114.80.215.216','login&login'),(753,'添加权限组[管理员所有]',1510796633,'admin',1,'114.80.215.216','admin&gadmin_add'),(754,'添加管理员[adminy]',1510796658,'admin',1,'114.80.215.216','admin&admin_add'),(755,'登录',1510796860,'admin',1,'114.80.153.110','login&login'),(756,'登录',1510797164,'admin',1,'114.80.215.216','login&login'),(757,'编辑商城设置',1510797213,'admin',1,'114.80.215.216','setting&'),(758,'编辑会员[ID:1041]',1510797360,'admin',1,'114.80.215.216','member&member_edit'),(759,'编辑会员[ID:1041]',1510797451,'admin',1,'114.80.215.216','member&member_edit'),(760,'编辑会员[ID:1043]',1510797467,'admin',1,'114.80.215.216','member&member_edit'),(761,'编辑会员[ID:1041]',1510798264,'admin',1,'114.80.153.110','member&member_edit'),(762,'清理缓存',1510798480,'admin',1,'114.80.153.110','cache&'),(763,'登录',1510798694,'admin',1,'114.80.153.110','login&login'),(764,'开启圈子',1510798741,'admin',1,'114.80.153.110','circle_setting&'),(765,'登录',1510798787,'adminy',2,'114.80.215.216','login&login'),(766,'审核新经营类目申请，店铺ID：6',1510799428,'admin',1,'114.80.153.110','store&store_bind_class_applay_check'),(767,'审核新经营类目申请，店铺ID：6',1510799434,'admin',1,'114.80.153.110','store&store_bind_class_applay_check'),(768,'审核新经营类目申请，店铺ID：6',1510799440,'admin',1,'114.80.153.110','store&store_bind_class_applay_check'),(769,'审核新经营类目申请，店铺ID：6',1510799447,'admin',1,'114.80.153.110','store&store_bind_class_applay_check'),(770,'审核新经营类目申请，店铺ID：6',1510799453,'admin',1,'114.80.153.110','store&store_bind_class_applay_check'),(771,'广告信息修改成功[Few购买]',1510803022,'admin',1,'114.80.153.110','adv&adv_edit'),(772,'广告位信息修改成功[中部广告]',1510803069,'admin',1,'114.80.153.110','adv&ap_edit'),(773,'广告位信息修改成功[中部广告]',1510803145,'admin',1,'114.80.153.110','adv&ap_edit'),(774,'广告位信息修改成功[首页公告下方广告]',1510803229,'admin',1,'114.80.153.110','adv&ap_edit'),(775,'登录',1510807779,'admin',1,'114.80.215.216','login&login'),(776,'登录',1510809947,'admin',1,'114.80.153.110','login&login'),(777,'板块设计[紫色]',1510810162,'admin',1,'114.80.153.110','web_config&web_edit'),(778,'板块设计[褐色]',1510810171,'admin',1,'114.80.153.110','web_config&web_edit'),(779,'板块设计[默认]',1510810180,'admin',1,'114.80.153.110','web_config&web_edit'),(780,'登录',1510811514,'admin',1,'114.80.215.216','login&login'),(781,'板块设计[女装/男装/内衣]',1510811605,'admin',1,'114.80.153.110','web_config&web_edit'),(782,'板块设计[前台首页]',1510811614,'admin',1,'114.80.153.110','web_config&web_edit'),(783,'板块设计[绿色]',1510811624,'admin',1,'114.80.153.110','web_config&web_edit'),(784,'板块设计[蓝色]',1510811634,'admin',1,'114.80.153.110','web_config&web_edit'),(785,'板块设计[生活电器]',1510811685,'admin',1,'114.80.153.110','web_config&web_edit'),(786,'板块设计[运动健康]',1510811702,'admin',1,'114.80.153.110','web_config&web_edit'),(787,'板块设计[个护美妆]',1510811729,'admin',1,'114.80.153.110','web_config&web_edit'),(788,'板块设计[装备展示]',1510812311,'admin',1,'114.80.153.110','web_config&web_edit'),(789,'板块设计[数码产品]',1510813102,'admin',1,'114.80.153.110','web_config&web_edit'),(790,'审核新经营类目申请，店铺ID：6',1510813617,'admin',1,'114.80.153.110','store&store_bind_class_applay_check'),(791,'登录',1510813766,'admin',1,'114.80.215.216','login&login'),(792,'添加活动[活动]',1510814686,'admin',1,'114.80.215.216','activity&new'),(793,'通过抢购活动申请，抢购编号5',1510815065,'admin',1,'114.80.215.216','groupbuy&groupbuy_review_pass'),(794,'编辑活动[ID:1]',1510815279,'admin',1,'114.80.215.216','activity&deal'),(795,'通过抢购活动申请，抢购编号6',1510815790,'admin',1,'114.80.215.216','groupbuy&groupbuy_review_pass'),(796,'清理缓存',1510815856,'admin',1,'114.80.215.216','cache&'),(797,'编辑店铺等级模板',1510818603,'admin',1,'114.80.215.216','store_grade&store_grade_templates'),(798,'資訊专题保存，专题编号4',1510818730,'admin',1,'114.80.215.216','reads_special&reads_special_save'),(799,'資訊专题保存，专题编号4',1510818973,'admin',1,'114.80.215.216','reads_special&reads_special_save'),(800,'資訊专题保存，专题编号4',1510819063,'admin',1,'114.80.215.216','reads_special&reads_special_save'),(801,'資訊专题保存，专题编号4',1510819064,'admin',1,'114.80.215.216','reads_special&reads_special_save'),(802,'資訊专题保存，专题编号4',1510819107,'admin',1,'114.80.215.216','reads_special&reads_special_save'),(803,'資訊专题保存，专题编号4',1510819414,'admin',1,'114.80.215.216','reads_special&reads_special_save'),(804,'编辑商城设置',1510819416,'admin',1,'114.80.153.110','setting&'),(805,'登录',1510820691,'admin',1,'114.80.215.216','login&login'),(806,'資訊专题保存，专题编号4',1510820819,'admin',1,'114.80.215.216','reads_special&reads_special_save'),(807,'資訊专题保存，专题编号4',1510822932,'admin',1,'114.80.215.216','reads_special&reads_special_save'),(808,'資訊专题保存，专题编号4',1510823101,'admin',1,'114.80.215.216','reads_special&reads_special_save'),(809,'資訊专题保存，专题编号4',1510823239,'admin',1,'114.80.215.216','reads_special&reads_special_save'),(810,'資訊专题保存，专题编号4',1510823365,'admin',1,'114.80.215.216','reads_special&reads_special_save'),(811,'编辑商城设置',1510823899,'admin',1,'114.80.215.216','setting&'),(812,'登录',1510826052,'admin',1,'114.80.215.216','login&login'),(813,'编辑运营控件',1510826632,'admin',1,'114.80.215.216','feiwa&'),(814,'编辑运营控件',1510828073,'admin',1,'114.80.215.216','feiwa&'),(815,'登录',1510884620,'admin',1,'114.80.153.110','login&login'),(816,'清理缓存',1510885956,'admin',1,'114.80.153.110','cache&'),(817,'登录',1510890871,'admin',1,'114.80.215.216','login&login'),(818,'登录',1510891385,'admin',1,'114.80.153.110','login&login'),(819,'登录',1510895612,'admin',1,'114.80.153.110','login&login'),(820,'编辑顶部广告',1510899541,'admin',1,'114.80.153.110','feiwa&banner'),(821,'编辑商城设置',1510900767,'admin',1,'114.80.153.110','setting&'),(822,'登录',1510902198,'admin',1,'114.80.215.216','login&login'),(823,'登录',1510902232,'admin',1,'114.80.215.216','login&login'),(824,'审核通过店铺分销申请，店铺ID：',1510902564,'admin',1,'114.80.215.216','store&distribution_check'),(825,'登录',1510902641,'adminy',2,'114.80.153.110','login&login'),(826,'设置店铺代金券',1510905647,'admin',1,'114.80.153.110','voucher&setting'),(827,'添加添加面额[10]',1510905698,'admin',1,'114.80.153.110','voucher&priceadd'),(828,'登录',1510909376,'admin',1,'114.80.215.216','login&login'),(829,'清理缓存',1510913452,'admin',1,'114.80.215.216','cache&'),(830,'登录',1511149612,'admin',1,'114.80.153.110','login&login'),(831,'编辑商城设置',1511149928,'admin',1,'114.80.153.110','setting&'),(832,'登录',1511155695,'admin',1,'114.80.153.110','login&login'),(833,'登录',1511508631,'admin',1,'114.80.215.216','login&login'),(839,'登录',1511777152,'adminy',2,'14.153.236.127','login&login'),(840,'登录',1511779299,'adminy',2,'117.136.79.109','login&login'),(841,'登录',1512350941,'adminy',2,'113.110.140.107','login&login'),(842,'登录',1512443262,'admin',1,'203.156.222.82','login&login'),(843,'清理缓存',1512443289,'admin',1,'203.156.222.82','cache&'),(844,'登录',1512453271,'admin',1,'203.156.222.82','login&login'),(845,'编辑商城设置',1512453319,'admin',1,'203.156.222.82','setting&'),(846,'清理缓存',1512453326,'admin',1,'203.156.222.82','cache&'),(847,'登录',1513061352,'adminy',2,'110.189.91.98','login&login'),(848,'登录',1513221365,'adminy',2,'203.156.222.82','login&login'),(849,'登录',1513310310,'adminy',2,'114.80.153.110','login&login'),(850,'登录',1513310836,'adminy',2,'114.80.153.110','login&login'),(851,'登录',1513330118,'adminy',2,'113.89.237.53','login&login'),(852,'登录',1513590402,'adminy',2,'114.80.215.216','login&login'),(853,'登录',1513647528,'adminy',2,'114.80.153.110','login&login'),(854,'登录',1513660916,'adminy',2,'114.80.153.110','login&login'),(855,'登录',1513663578,'adminy',2,'203.156.222.82','login&login'),(856,'开启圈子',1513665151,'adminy',2,'114.80.153.110','circle_setting&'),(857,'清理缓存',1513665186,'adminy',2,'114.80.153.110','cache&'),(858,'首页静态文件更新',1513665715,'adminy',2,'114.80.153.110','reads_index&reads_index_build'),(859,'首页静态文件更新',1513666570,'adminy',2,'114.80.153.110','reads_index&reads_index_build'),(860,'添加页面导航成功[nihao]',1513666739,'adminy',2,'114.80.153.110','navigation&navigation_add'),(861,'编辑页面导航成功[nihao]',1513666786,'adminy',2,'114.80.153.110','navigation&navigation_edit'),(862,'编辑页面导航成功[nihao]',1513666789,'adminy',2,'114.80.153.110','navigation&navigation_edit'),(863,'清理缓存',1513666811,'adminy',2,'114.80.153.110','cache&'),(864,'登录',1513668841,'adminy',2,'203.156.222.82','login&login'),(865,'登录',1513676015,'adminy',2,'203.156.222.82','login&login'),(866,'登录',1513676019,'adminy',2,'125.119.255.241','login&login'),(867,'登录',1513676820,'adminy',2,'114.80.215.216','login&login'),(868,'生成手机端二维码',1513681834,'adminy',2,'114.80.153.110','mb_app&mb_qr'),(869,'设置手机端下载地址',1513681944,'adminy',2,'114.80.153.110','mb_app&mb_app'),(870,'登录',1513682495,'adminy',2,'203.156.222.82','login&login'),(871,'登录',1513700663,'adminy',2,'202.75.219.14','login&login'),(872,'更新店铺经营类目，类目编号:29',1513703144,'adminy',2,'202.75.219.14','store&store_bind_class_update'),(873,'审核通过店铺分销申请，店铺ID：',1513703204,'adminy',2,'202.75.219.14','store&distribution_check'),(874,'清理缓存',1513703590,'adminy',2,'202.75.219.14','cache&'),(875,'登录',1513738126,'adminy',2,'203.156.222.82','login&login'),(876,'登录',1513750823,'admin',1,'114.80.215.216','login&login'),(877,'编辑会员[ID:1043]',1513750859,'admin',1,'114.80.215.216','member&member_edit'),(878,'编辑会员[ID:1043]',1513750992,'admin',1,'114.80.215.216','member&member_edit'),(879,'登录',1513751584,'adminy',2,'114.80.153.110','login&login'),(880,'添加会员[ hztest]',1513751804,'adminy',2,'114.80.153.110','member&member_add'),(881,'登录',1513752108,'adminy',2,'114.80.153.110','login&login'),(882,'编辑会员[ID:1046]',1513752120,'adminy',2,'114.80.153.110','member&member_edit'),(883,'登录',1513752269,'adminy',2,'114.80.153.110','login&login'),(884,'登录',1513752585,'adminy',2,'114.80.215.216','login&login'),(885,'登录',1513752874,'admin',1,'203.156.222.82','login&login'),(886,'登录',1513752898,'adminy',2,'203.156.222.82','login&login'),(887,'登录',1513752936,'admin',1,'114.80.215.216','login&login'),(888,'登录',1513752940,'admin',1,'203.156.222.82','login&login'),(889,'登录',1513753331,'adminy',2,'114.80.215.216','login&login'),(890,'操作会员[hztest]预存款[增加]，金额为1000000,编号为9205670985262680',1513754526,'adminy',2,'114.80.153.110','member&predeposit_add'),(891,'登录',1513754897,'adminy',2,'203.156.222.82','login&login'),(892,'登录',1513756449,'adminy',2,'116.226.152.85','login&login'),(893,'登录',1513757608,'admin',1,'124.207.198.33','login&login'),(894,'登录',1513759694,'adminy',2,'114.80.153.110','login&login'),(895,'登录',1513815981,'adminy',2,'115.217.144.4','login&login'),(896,'登录',1513820227,'adminy',2,'203.156.222.82','login&login'),(897,'登录',1513826301,'admin',1,'124.207.198.33','login&login'),(898,'登录',1513827733,'adminy',2,'203.156.222.82','login&login'),(899,'登录',1513827816,'adminy',2,'203.156.222.82','login&login'),(900,'登录',1513828286,'admin',1,'114.80.153.110','login&login'),(901,'登录',1513828287,'admin',1,'202.75.219.14','login&login'),(902,'登录',1513833717,'admin',1,'202.75.219.14','login&login'),(903,'登录',1513833766,'adminy',2,'203.156.222.82','login&login'),(904,'登录',1513904237,'adminy',2,'114.80.153.110','login&login'),(905,'登录',1513904651,'admin',1,'114.80.153.110','login&login'),(906,'登录',1513906309,'admin',1,'114.80.153.110','login&login'),(907,'登录',1513906397,'adminy',2,'202.75.219.14','login&login'),(908,'登录',1513910147,'adminy',2,'114.80.153.110','login&login'),(909,'编辑二级域名',1513913943,'admin',1,'114.80.153.110','domain&store_domain_setting'),(910,'登录',1513922544,'adminy',2,'203.156.222.82','login&login'),(911,'新增5张充值卡（面额￥100，批次标识“”）',1513922577,'admin',1,'114.80.153.110','rechargecard&add_card'),(912,'登录',1513925216,'admin',1,'114.80.153.110','login&login'),(913,'登录',1513926929,'admin',1,'114.80.153.110','login&login'),(914,'登录',1513926973,'admin',1,'114.80.153.110','login&login'),(915,'登录',1513927710,'adminy',2,'203.156.222.82','login&login'),(916,'登录',1513929106,'admin',1,'124.207.198.33','login&login'),(917,'登录',1513931311,'admin',1,'114.80.153.110','login&login'),(918,'登录',1513931758,'adminy',2,'113.111.11.99','login&login'),(919,'登录',1513934255,'adminy',2,'114.80.153.110','login&login'),(920,'登录',1513942466,'adminy',2,'111.50.232.8','login&login'),(921,'登录',1514082237,'adminy',2,'218.98.33.10','login&login'),(922,'登录',1514164767,'admin',1,'114.80.153.110','login&login'),(923,'登录',1514165271,'adminy',2,'203.156.222.82','login&login'),(924,'登录',1514165571,'adminy',2,'203.156.222.82','login&login'),(925,'登录',1514167183,'admin',1,'114.80.153.110','login&login'),(926,'登录',1514179319,'admin',1,'114.80.153.110','login&login'),(927,'登录',1514183453,'admin',1,'124.207.198.33','login&login'),(928,'登录',1514183551,'admin',1,'114.80.153.110','login&login'),(929,'登录',1514184324,'admin',1,'124.207.198.33','login&login'),(930,'登录',1514186634,'adminy',2,'203.156.222.82','login&login'),(931,'登录',1514187577,'adminy',2,'203.156.222.82','login&login'),(932,'重置tag',1514188427,'adminy',2,'203.156.222.82','goods_class&tag_reset'),(933,'添加类型[衣服]',1514188979,'adminy',2,'203.156.222.82','type&type_add'),(934,'添加店铺等级[钻石]',1514190351,'adminy',2,'203.156.222.82','store_grade&store_grade_add'),(935,'编辑店铺帮助，编号101',1514193227,'adminy',2,'203.156.222.82','help_store&edit_help'),(936,'编辑防灌水设置',1514195205,'adminy',2,'203.156.222.82','setting&dump'),(937,'编辑防灌水设置',1514195274,'adminy',2,'203.156.222.82','setting&dump'),(938,'登录',1514195401,'admin',1,'113.111.10.55','login&login'),(939,'登录',1514196574,'admin',1,'124.207.198.33','login&login'),(940,'登录',1514255215,'adminy',2,'114.80.153.110','login&login'),(941,'登录',1514257739,'adminy',2,'114.80.153.110','login&login'),(942,'登录',1514276010,'adminy',2,'203.156.222.82','login&login'),(943,'登录',1514279229,'adminy',2,'203.156.222.82','login&login'),(944,'登录',1514339398,'admin',1,'113.111.10.101','login&login'),(945,'登录',1514340005,'adminy',2,'203.156.222.82','login&login'),(946,'登录',1514344913,'admin',1,'113.111.10.101','login&login'),(947,'登录',1514353986,'adminy',2,'203.156.222.82','login&login'),(948,'登录',1514358979,'adminy',2,'39.65.91.224','login&login'),(949,'登录',1514363355,'adminy',2,'203.156.222.82','login&login'),(950,'登录',1514364624,'admin',1,'113.65.206.195','login&login'),(951,'编辑登录主题图片',1514365667,'adminy',2,'203.156.222.82','setting&login'),(952,'编辑登录主题图片',1514365864,'adminy',2,'203.156.222.82','setting&login'),(953,'登录',1514366000,'admin',1,'203.156.222.82','login&login'),(954,'登录',1514425122,'adminy',2,'203.156.222.82','login&login'),(955,'登录',1514436700,'adminy',2,'115.192.55.199','login&login'),(956,'登录',1514442052,'adminy',2,'114.80.153.110','login&login'),(957,'登录',1514443722,'adminy',2,'113.87.182.51','login&login'),(958,'登录',1514444097,'adminy',2,'114.80.153.110','login&login'),(959,'添加推荐位[abc]',1514447306,'adminy',2,'114.80.153.110','rec_position&rec_save'),(960,'登录',1514447915,'adminy',2,'203.156.222.82','login&login'),(961,'登录',1514448322,'adminy',2,'39.65.91.224','login&login'),(962,'广告信息修改成功[Few购买]',1514452298,'adminy',2,'203.156.222.82','adv&adv_edit'),(963,'广告位添加成功[新广告]',1514452421,'adminy',2,'203.156.222.82','adv&ap_add'),(964,'编辑商城设置',1514453007,'adminy',2,'203.156.222.82','setting&'),(965,'编辑快递公司状态[ID:1]',1514453652,'adminy',2,'203.156.222.82','express&ajax'),(966,'编辑快递公司状态[ID:1]',1514453662,'adminy',2,'203.156.222.82','express&ajax'),(967,'板块设计[个护美妆]',1514453861,'adminy',2,'203.156.222.82','web_config&web_edit'),(968,'登录',1514539031,'adminy',2,'203.156.222.82','login&login'),(969,'登录',1514541357,'adminy',2,'203.156.222.82','login&login'),(970,'登录',1514877963,'adminy',2,'114.80.215.216','login&login'),(971,'清理缓存',1514877998,'adminy',2,'114.80.215.216','cache&'),(972,'登录',1514879244,'adminy',2,'36.25.58.63','login&login'),(973,'登录',1514879298,'adminy',2,'36.25.58.63','login&login'),(974,'登录',1514880431,'adminy',2,'203.156.222.82','login&login'),(975,'登录',1514882493,'adminy',2,'203.156.222.82','login&login'),(976,'登录',1514958760,'adminy',2,'202.75.219.14','login&login'),(977,'登录',1514991516,'adminy',2,'27.225.156.150','login&login'),(978,'登录',1514991565,'adminy',2,'27.225.156.150','login&login'),(979,'登录',1515035815,'adminy',2,'203.156.222.82','login&login'),(980,'登录',1515038049,'adminy',2,'203.156.222.82','login&login'),(981,'登录',1515050691,'adminy',2,'203.156.222.82','login&login'),(982,'添加会员标签[潮人]',1515052102,'adminy',2,'203.156.222.82','sns_member&tag_add'),(983,'编辑会员标签[潮人]',1515052236,'adminy',2,'203.156.222.82','sns_member&tag_edit'),(984,'添加会员标签[123]',1515052351,'adminy',2,'203.156.222.82','sns_member&tag_add'),(985,'登录',1515137240,'admin',1,'113.65.204.190','login&login'),(986,'登录',1515137493,'admin',1,'113.65.204.190','login&login'),(987,'資訊首页模块编辑，模块编号28',1515138119,'admin',1,'113.65.204.190','reads_index&save_page_module'),(988,'登录',1515138401,'admin',1,'113.65.204.190','login&login'),(989,'添加管理员[admintest]',1515138577,'admin',1,'113.65.204.190','admin&admin_add'),(990,'登录',1515138605,'admintest',3,'113.65.204.190','login&login'),(991,'登录',1515141114,'admin',1,'113.65.204.190','login&login'),(992,'编辑会员[ID:1049]',1515142282,'admin',1,'113.65.204.190','member&member_edit'),(993,'登录',1515292007,'adminy',2,'59.63.206.82','login&login'),(994,'登录',1515307964,'admin',1,'114.80.153.110','login&login'),(995,'資訊画报分类保存，分类编号1',1515308476,'admin',1,'114.80.153.110','reads_picture_class&reads_picture_class_save'),(996,'新增自营店铺: 天河店',1515311233,'admin',1,'114.80.153.110','ownmall&add'),(997,'登录',1515337569,'adminy',2,'222.82.236.102','login&login'),(998,'编辑商城设置',1515337652,'adminy',2,'222.82.236.102','setting&'),(999,'登录',1515420114,'adminy',2,'223.167.90.220','login&login'),(1000,'登录',1515468247,'adminy',2,'203.156.222.82','login&login'),(1001,'登录',1515469424,'adminy',2,'203.156.222.82','login&login'),(1002,'登录',1515474978,'adminy',2,'203.156.222.82','login&login'),(1003,'登录',1515480311,'admin',1,'124.207.198.33','login&login'),(1004,'登录',1515481081,'admin',1,'113.111.11.253','login&login'),(1005,'添加管理员[oray]',1515481129,'admin',1,'113.111.11.253','admin&admin_add'),(1006,'登录',1515481192,'oray',4,'113.111.11.253','login&login'),(1007,'登录',1515483299,'oray',4,'113.111.11.253','login&login'),(1008,'登录',1515483601,'oray',4,'59.42.206.50','login&login'),(1009,'登录',1515483866,'oray',4,'116.226.47.53','login&login'),(1010,'登录',1515484821,'oray',4,'116.20.115.67','login&login'),(1011,'登录',1515485037,'oray',4,'116.226.47.53','login&login'),(1012,'登录',1515486642,'admin',1,'113.111.11.253','login&login'),(1013,'登录',1515486959,'admin',1,'113.111.11.253','login&login'),(1014,'登录',1515493757,'adminy',2,'203.156.222.82','login&login'),(1015,'登录',1515501801,'adminy',2,'183.192.14.23','login&login'),(1016,'登录',1515545438,'admin',1,'124.207.198.33','login&login'),(1017,'登录',1515546029,'adminy',2,'203.156.222.82','login&login'),(1018,'广告位信息修改成功[新广告]',1515547538,'adminy',2,'203.156.222.82','adv&ap_edit'),(1019,'编辑账号同步，手机短信设置',1515547648,'adminy',2,'203.156.222.82','account&sms'),(1020,'新增文章成功。[元旦通告]',1515548183,'adminy',2,'203.156.222.82','article&article_add'),(1021,'登录',1515550490,'adminy',2,'116.25.146.51','login&login'),(1022,'登录',1515550842,'adminy',2,'203.156.222.82','login&login'),(1023,'資訊文章分类保存，分类编号9',1515552477,'adminy',2,'203.156.222.82','reads_article_class&reads_article_class_save'),(1024,'資訊管理保存失败',1515553343,'adminy',2,'203.156.222.82','reads_manage&reads_manage_save'),(1025,'编辑商城设置',1515553443,'adminy',2,'203.156.222.82','setting&'),(1026,'编辑防灌水设置',1515553982,'adminy',2,'203.156.222.82','setting&dump'),(1027,'登录',1515554790,'adminy',2,'101.81.249.167','login&login'),(1028,'登录',1515559427,'adminy',2,'203.156.222.82','login&login'),(1029,'登录',1515563837,'adminy',2,'203.156.222.82','login&login'),(1030,'编辑店铺等级[系统默认]',1515564027,'adminy',2,'203.156.222.82','store_grade&store_grade_edit'),(1031,'登录',1515564906,'adminy',2,'203.156.222.82','login&login'),(1032,'登录',1515565151,'adminy',2,'203.156.222.82','login&login'),(1033,'添加文章分类[ID:8]',1515566198,'adminy',2,'203.156.222.82','article_class&article_class_del'),(1034,'登录',1515567339,'adminy',2,'203.156.222.82','login&login'),(1035,'板块设计[个护美妆]',1515570631,'adminy',2,'203.156.222.82','web_config&web_edit'),(1036,'登录',1515571703,'adminy',2,'203.156.222.82','login&login'),(1037,'编辑评论',1515572013,'adminy',2,'203.156.222.82','sns_strace&strace_edit'),(1038,'编辑评论',1515572017,'adminy',2,'203.156.222.82','sns_strace&strace_edit'),(1039,'登录',1515572890,'adminy',2,'101.81.249.167','login&login'),(1040,'資訊首页模块编辑，模块编号19',1515574087,'adminy',2,'203.156.222.82','reads_index&save_page_module'),(1041,'首页静态文件更新',1515574184,'adminy',2,'203.156.222.82','reads_index&reads_index_build'),(1042,'取消订单,订单号:1000000000000801',1515574969,'adminy',2,'203.156.222.82','order&change_state'),(1043,'编辑商城设置',1515577862,'adminy',2,'203.156.222.82','setting&'),(1044,'编辑商城设置',1515577884,'adminy',2,'203.156.222.82','setting&'),(1045,'登录',1515578236,'adminy',2,'203.156.222.82','login&login'),(1046,'编辑商城设置',1515579413,'adminy',2,'203.156.222.82','setting&'),(1047,'编辑商城设置',1515579433,'adminy',2,'203.156.222.82','setting&'),(1048,'编辑商城设置',1515579509,'adminy',2,'203.156.222.82','setting&'),(1049,'编辑商城设置',1515579531,'adminy',2,'203.156.222.82','setting&'),(1050,'编辑防灌水设置',1515579560,'adminy',2,'203.156.222.82','setting&dump'),(1051,'编辑防灌水设置',1515579609,'adminy',2,'203.156.222.82','setting&dump'),(1052,'添加文章分类[测试]',1515580213,'adminy',2,'203.156.222.82','article_class&article_class_add'),(1053,'添加文章分类[测试1]',1515580264,'adminy',2,'203.156.222.82','article_class&article_class_add'),(1054,'登录',1515580286,'adminy',2,'203.156.222.82','login&login'),(1055,'板块设计[个护美妆]',1515581137,'adminy',2,'203.156.222.82','web_config&web_edit'),(1056,'登录',1515632368,'admin',1,'113.65.204.163','login&login'),(1057,'登录',1515636019,'admin',1,'113.65.204.163','login&login'),(1058,'登录',1515652743,'admin',1,'114.80.153.110','login&login'),(1059,'登录',1515653688,'adminy',2,'203.156.222.82','login&login'),(1060,'登录',1515663891,'adminy',2,'203.156.222.82','login&login'),(1061,'登录',1515689725,'adminy',2,'183.192.14.23','login&login'),(1062,'登录',1515722752,'admin',1,'203.156.222.82','login&login'),(1063,'登录',1515742837,'admin',1,'203.156.222.82','login&login'),(1064,'登录',1515752401,'adminy',2,'203.156.222.82','login&login'),(1065,'审核通过店铺分销申请，店铺ID：',1515752914,'adminy',2,'203.156.222.82','store&distribution_check'),(1066,'登录',1516029500,'adminy',2,'101.86.53.223','login&login'),(1067,'登录',1516033644,'adminy',2,'101.86.53.223','login&login'),(1068,'登录',1516066569,'adminy',2,'111.73.131.108','login&login'),(1069,'生成手机端二维码',1516066661,'adminy',2,'111.73.131.108','mb_app&mb_qr'),(1070,'编辑运营促销设定',1516069359,'adminy',2,'111.73.131.108','operation&'),(1071,'登录',1516069381,'adminy',2,'203.156.222.82','login&login'),(1072,'更新店铺经营类目，类目编号:22',1516070312,'adminy',2,'111.73.131.108','store&store_bind_class_update'),(1073,'登录',1516071313,'admin',1,'113.111.9.135','login&login'),(1074,'添加管理员[xyr]',1516071701,'admin',1,'113.111.9.135','admin&admin_add'),(1075,'编辑会员[ID:1055]',1516072051,'adminy',2,'111.73.131.108','member&member_edit'),(1076,'消费者保障服务申请[ID：5]审核状态修改为审核通过，待支付保证金',1516072443,'adminy',2,'111.73.131.108','contract&applyedit'),(1077,'登录',1516073776,'xyr',5,'117.136.79.37','login&login'),(1078,'登录',1516076216,'xyr',5,'218.20.5.100','login&login'),(1079,'登录',1516079595,'adminy',2,'203.156.222.82','login&login'),(1080,'添加手机专题[ID:1]',1516088696,'adminy',2,'203.156.222.82','mb_special&special_save'),(1081,'登录',1516088912,'admin',1,'203.156.222.82','login&login'),(1082,'登录',1516091555,'admin',1,'113.111.9.135','login&login'),(1083,'登录',1516097634,'adminy',2,'203.156.222.82','login&login'),(1084,'取消订单,订单号:9000000000000401',1516097832,'adminy',2,'203.156.222.82','order&change_state'),(1085,'登录',1516161172,'adminy',2,'39.65.91.224','login&login'),(1086,'登录',1516163817,'adminy',2,'125.70.231.10','login&login'),(1087,'登录',1516179408,'adminy',2,'203.156.222.82','login&login'),(1088,'登录',1516179593,'admin',1,'124.207.198.33','login&login'),(1089,'登录',1516182091,'admin',1,'124.207.198.33','login&login'),(1090,'登录',1516246178,'admin',1,'183.129.211.50','login&login'),(1091,'登录',1516247039,'admin',1,'202.75.219.14','login&login'),(1092,'登录',1516252960,'admin',1,'183.129.211.50','login&login'),(1093,'登录',1516263253,'adminy',2,'203.156.222.82','login&login'),(1094,'登录',1516264245,'admin',1,'114.80.153.110','login&login'),(1095,'登录',1516327057,'admin',1,'124.207.198.33','login&login'),(1096,'登录',1516327156,'admin',1,'124.207.198.33','login&login'),(1097,'登录',1516342184,'adminy',2,'116.25.147.88','login&login'),(1098,'编辑运营促销设定',1516343567,'adminy',2,'116.25.147.88','operation&'),(1099,'编辑运营促销设定',1516343574,'adminy',2,'116.25.147.88','operation&'),(1100,'编辑运营促销设定',1516343887,'adminy',2,'116.25.147.88','operation&'),(1101,'登录',1516347643,'admin',1,'124.207.198.33','login&login'),(1102,'登录',1516352194,'adminy',2,'116.25.147.88','login&login'),(1103,'取消订单,订单号:9000000000000301',1516355210,'adminy',2,'116.25.147.88','order&change_state'),(1104,'登录',1516585493,'admin',1,'183.129.211.50','login&login'),(1105,'登录',1516585740,'adminy',2,'203.156.222.82','login&login'),(1106,'登录',1516591632,'adminy',2,'203.156.222.82','login&login'),(1107,'登录',1516591780,'adminy',2,'203.156.222.82','login&login'),(1108,'登录',1516591969,'adminy',2,'203.156.222.82','login&login'),(1109,'登录',1516591999,'adminy',2,'116.8.56.146','login&login'),(1110,'登录',1516592212,'adminy',2,'203.156.222.82','login&login'),(1111,'登录',1516667405,'adminy',2,'39.65.91.224','login&login'),(1112,'登录',1516671627,'admin',1,'124.207.198.33','login&login'),(1113,'登录',1516677285,'admin',1,'39.65.91.224','login&login'),(1114,'登录',1516689890,'admin',1,'125.112.235.37','login&login'),(1115,'登录',1516691135,'admin',1,'124.207.198.33','login&login'),(1116,'登录',1516954076,'adminy',2,'203.156.222.82','login&login'),(1117,'登录',1516954163,'adminy',2,'203.156.222.82','login&login'),(1118,'登录',1517110283,'admin',1,'218.60.71.117','login&login'),(1119,'添加商品分类管理[虚拟产品]',1517110565,'admin',1,'218.60.71.117','goods_class&goods_class_add'),(1120,'编辑分类导航，虚拟产品',1517111046,'admin',1,'218.60.71.117','goods_class&nav_edit'),(1121,'删除店铺经营类目，类目编号:36,店铺编号:8',1517111894,'admin',1,'218.60.71.117','store&store_bind_class_add'),(1122,'登录',1517361599,'admin',1,'124.207.198.33','login&login'),(1123,'登录',1517383099,'admin',1,'124.207.198.33','login&login'),(1124,'登录',1517466934,'admin',1,'183.129.211.50','login&login'),(1125,'登录',1517476109,'admin',1,'183.129.211.50','login&login'),(1126,'登录',1517548859,'adminy',2,'183.199.184.217','login&login'),(1127,'添加手机专题[ID:2]',1517553054,'adminy',2,'183.199.184.217','mb_special&special_save'),(1128,'生成手机端二维码',1517555640,'adminy',2,'183.199.184.217','mb_app&mb_qr'),(1129,'登录',1517557135,'adminy',2,'203.156.222.82','login&login'),(1130,'登录',1517571957,'adminy',2,'203.156.222.82','login&login'),(1131,'登录',1517580356,'adminy',2,'106.115.93.66','login&login'),(1132,'資訊首页模块编辑，模块编号19',1517581893,'adminy',2,'106.115.93.66','reads_index&save_page_module'),(1133,'登录',1517802764,'adminy',2,'114.80.153.110','login&login'),(1134,'登录',1517816719,'adminy',2,'203.156.222.82','login&login'),(1135,'登录',1517817973,'adminy',2,'203.156.222.82','login&login'),(1136,'登录',1517823462,'adminy',2,'203.156.222.82','login&login'),(1137,'登录',1517888491,'adminy',2,'117.35.158.214','login&login'),(1138,'清理缓存',1517888868,'adminy',2,'117.35.158.214','cache&'),(1139,'新增自营店铺: dearbaby小寨店',1517889255,'adminy',2,'117.35.158.214','ownmall&add'),(1140,'编辑自营店铺: dearbaby小寨店',1517889272,'adminy',2,'117.35.158.214','ownmall&edit'),(1141,'登录',1517900149,'adminy',2,'117.35.158.214','login&login'),(1142,'板块设计[紫色]',1517901253,'adminy',2,'117.35.158.214','web_config&web_edit'),(1143,'板块设计[褐色]',1517901285,'adminy',2,'117.35.158.214','web_config&web_edit'),(1144,'板块设计[默认]',1517901293,'adminy',2,'117.35.158.214','web_config&web_edit'),(1145,'板块设计[个护美妆]',1517901350,'adminy',2,'117.35.158.214','web_config&web_edit'),(1146,'登录',1518057773,'admin',1,'113.111.8.226','login&login'),(1147,'登录',1519009845,'admin',1,'119.117.196.41','login&login'),(1148,'登录',1519022815,'admin',1,'114.80.153.110','login&login'),(1149,'登录',1519298808,'adminy',2,'117.91.48.38','login&login'),(1150,'登录',1519310658,'adminy',2,'180.113.163.164','login&login'),(1151,'登录',1519539819,'admin',1,'60.187.144.185','login&login'),(1152,'登录',1519805781,'adminy',2,'203.156.222.82','login&login'),(1153,'登录',1519869156,'adminy',2,'203.156.222.82','login&login'),(1154,'登录',1519897969,'adminy',2,'1.82.129.232','login&login'),(1155,'登录',1519955795,'admin',1,'114.80.153.110','login&login'),(1156,'登录',1519960233,'adminy',2,'203.156.222.82','login&login'),(1157,'登录',1520053883,'adminy',2,'124.114.50.170','login&login'),(1158,'登录',1520054761,'adminy',2,'124.114.50.170','login&login'),(1159,'登录',1520317859,'adminy',2,'203.156.222.82','login&login'),(1160,'登录',1520318824,'adminy',2,'222.65.188.61','login&login'),(1161,'登录',1520392663,'admin',1,'113.111.10.87','login&login'),(1162,'登录',1520499239,'adminy',2,'118.144.131.160','login&login'),(1163,'登录',1520500228,'adminy',2,'118.144.131.160','login&login'),(1164,'登录',1520581118,'admin',1,'113.65.205.174','login&login'),(1165,'登录',1520825433,'admin',1,'114.80.215.216','login&login'),(1166,'登录',1520825631,'admin',1,'124.207.198.33','login&login'),(1167,'登录',1520825753,'admin',1,'124.207.198.33','login&login'),(1168,'登录',1520833182,'adminy',2,'139.226.74.216','login&login'),(1169,'登录',1520849573,'admin',1,'124.207.198.33','login&login'),(1170,'登录',1520909923,'adminy',2,'58.214.190.79','login&login'),(1171,'清理缓存',1520910265,'adminy',2,'58.214.190.79','cache&'),(1172,'登录',1520910964,'adminy',2,'203.156.222.82','login&login'),(1173,'登录',1521005141,'admin',1,'221.221.161.38','login&login'),(1174,'登录',1521024615,'oray',4,'113.65.205.204','login&login'),(1175,'登录',1521024748,'oray',4,'114.80.153.110','login&login'),(1176,'登录',1521025088,'oray',4,'61.152.96.99','login&login'),(1177,'登录',1521075234,'oray',4,'14.18.29.115','login&login'),(1178,'登录',1521089227,'admin',1,'114.249.232.123','login&login'),(1179,'登录',1521094751,'adminy',2,'49.83.111.3','login&login'),(1180,'登录',1521096502,'adminy',2,'183.160.71.133','login&login'),(1181,'登录',1521099376,'adminy',2,'203.156.222.82','login&login'),(1182,'登录',1521099557,'adminy',2,'203.156.222.82','login&login'),(1183,'登录',1521175908,'adminy',2,'114.236.146.173','login&login'),(1184,'登录',1521187619,'admin',1,'114.80.153.110','login&login'),(1185,'登录',1521355405,'adminy',2,'117.136.79.151','login&login'),(1186,'登录',1521355585,'adminy',2,'117.136.79.151','login&login'),(1187,'登录',1521376545,'adminy',2,'1.197.240.246','login&login'),(1188,'登录',1521393717,'adminy',2,'1.82.229.203','login&login'),(1189,'登录',1521418191,'adminy',2,'223.91.130.21','login&login'),(1190,'编辑商城设置',1521418326,'adminy',2,'223.91.130.21','setting&'),(1191,'登录',1521440934,'adminy',2,'223.91.130.42','login&login'),(1192,'登录',1521447147,'adminy',2,'223.91.130.42','login&login'),(1193,'登录',1521552940,'admin',1,'117.35.88.57','login&login'),(1194,'登录',1521595867,'adminy',2,'203.156.222.82','login&login'),(1195,'登录',1521596852,'admin',1,'58.56.159.78','login&login'),(1196,'登录',1521802024,'admin',1,'114.80.153.110','login&login'),(1197,'登录',1521981271,'adminy',2,'58.60.2.91','login&login'),(1198,'登录',1522030688,'adminy',2,'144.255.35.174','login&login'),(1199,'登录',1522032695,'adminy',2,'117.40.114.226','login&login'),(1200,'编辑会员[ID:1055]',1522033991,'adminy',2,'117.40.114.226','member&member_edit'),(1201,'设置店铺结算周期[商城]',1522036410,'adminy',2,'117.40.114.226','store&bill_cycle_edit'),(1202,'登录',1522121030,'adminy',2,'116.52.136.58','login&login'),(1203,'登录',1522122635,'adminy',2,'116.52.136.58','login&login'),(1204,'登录',1522133238,'adminy',2,'116.249.24.58','login&login'),(1205,'登录',1522133459,'adminy',2,'39.130.123.19','login&login'),(1206,'登录',1522212449,'adminy',2,'220.178.225.24','login&login'),(1207,'登录',1522288581,'admin',1,'203.156.222.82','login&login'),(1208,'登录',1522467030,'adminy',2,'182.42.64.189','login&login'),(1209,'登录',1522637900,'admin',1,'203.156.222.82','login&login'),(1210,'登录',1522639935,'admin',1,'221.221.152.197','login&login'),(1211,'登录',1522640580,'admin',1,'27.210.114.165','login&login'),(1212,'登录',1522644141,'admin',1,'114.80.153.110','login&login'),(1213,'登录',1522646543,'adminy',2,'203.156.222.82','login&login'),(1214,'登录',1522647641,'adminy',2,'203.156.222.82','login&login'),(1215,'登录',1522648136,'adminy',2,'171.221.148.229','login&login'),(1216,'登录',1522649840,'adminy',2,'114.235.146.38','login&login'),(1217,'登录',1522650288,'adminy',2,'114.235.146.38','login&login'),(1218,'登录',1522652759,'adminy',2,'171.221.148.229','login&login'),(1219,'登录',1522655137,'admin',1,'182.40.65.72','login&login'),(1220,'登录',1522655164,'adminy',2,'117.91.55.77','login&login'),(1221,'登录',1522661902,'admin',1,'182.40.65.72','login&login'),(1222,'登录',1522727933,'admin',1,'221.221.152.197','login&login'),(1223,'登录',1522742861,'adminy',2,'223.166.144.139','login&login'),(1224,'更新店铺经营类目，类目编号:22',1522745816,'adminy',2,'223.166.144.139','store&store_bind_class_update'),(1225,'更新店铺经营类目，类目编号:36',1522745824,'adminy',2,'223.166.144.139','store&store_bind_class_update'),(1226,'删除店铺经营类目，类目编号:37,店铺编号:8',1522745838,'adminy',2,'223.166.144.139','store&store_bind_class_add'),(1227,'登录',1522750327,'adminy',2,'223.166.144.139','login&login'),(1228,'删除店铺经营类目，类目编号:38,店铺编号:8',1522753059,'adminy',2,'223.166.144.139','store&store_bind_class_add'),(1229,'登录',1522761626,'adminy',2,'117.91.53.61','login&login'),(1230,'登录',1522805745,'admin',1,'114.80.215.216','login&login'),(1231,'登录',1522822265,'admin',1,'203.156.222.82','login&login'),(1232,'登录',1522824197,'admin',1,'183.130.12.167','login&login'),(1233,'登录',1522828784,'admin',1,'61.140.62.94','login&login'),(1234,'登录',1522830272,'admin',1,'183.130.12.167','login&login'),(1235,'登录',1522847169,'adminy',2,'1.183.87.79','login&login'),(1236,'登录',1522913416,'adminy',2,'61.166.173.96','login&login'),(1237,'登录',1523068696,'adminy',2,'117.136.72.23','login&login'),(1238,'登录',1523175504,'adminy',2,'203.156.222.82','login&login'),(1239,'登录',1523176265,'adminy',2,'113.89.237.217','login&login'),(1240,'登录',1523176967,'adminy',2,'113.64.195.16','login&login'),(1241,'登录',1523177741,'adminy',2,'114.80.153.110','login&login'),(1242,'登录',1523178188,'adminy',2,'113.89.249.218','login&login'),(1243,'登录',1523182261,'admin',1,'222.128.177.174','login&login'),(1244,'登录',1523257147,'adminy',2,'203.156.222.82','login&login'),(1245,'登录',1523259108,'admin',1,'125.120.212.75','login&login'),(1246,'登录',1523323983,'admin',1,'125.119.247.55','login&login'),(1247,'登录',1523327758,'admin',1,'125.119.247.55','login&login'),(1248,'登录',1523343514,'adminy',2,'203.156.222.82','login&login'),(1249,'登录',1523344339,'admin',1,'124.207.198.33','login&login'),(1250,'登录',1523429481,'adminy',2,'221.195.22.103','login&login'),(1251,'登录',1523587382,'admin',1,'114.80.153.110','login&login'),(1252,'登录',1523587436,'admin',1,'218.72.49.175','login&login'),(1253,'登录',1523589583,'admin',1,'114.80.153.110','login&login'),(1254,'登录',1523603497,'adminy',2,'113.89.249.228','login&login'),(1255,'登录',1523668025,'adminy',2,'182.242.103.79','login&login'),(1256,'登录',1523668255,'adminy',2,'182.242.103.79','login&login'),(1257,'导入商品分类管理失败',1523677799,'adminy',2,'182.242.103.79','goods_class&goods_class_import'),(1258,'登录',1523781157,'admin',1,'114.80.153.110','login&login'),(1259,'编辑商城设置',1523781174,'admin',1,'114.80.153.110','setting&'),(1260,'登录',1523865817,'oray',4,'14.18.29.115','login&login'),(1261,'登录',1523865859,'oray',4,'59.42.207.134','login&login'),(1262,'登录',1523865900,'admin',1,'113.65.204.23','login&login'),(1263,'登录',1523866919,'adminy',2,'117.91.49.220','login&login'),(1264,'登录',1523867744,'adminy',2,'117.91.49.220','login&login'),(1265,'登录',1523951172,'admin',1,'114.80.153.110','login&login'),(1266,'登录',1523952640,'admin',1,'183.128.223.252','login&login'),(1267,'登录',1524205884,'adminy',2,'183.162.9.132','login&login'),(1268,'登录',1524211050,'admin',1,'58.56.159.78','login&login'),(1269,'登录',1524478205,'adminy',2,'203.156.222.82','login&login'),(1270,'登录',1524809491,'oray',4,'14.18.29.112','login&login'),(1271,'登录',1524820805,'admin',1,'113.111.10.122','login&login'),(1272,'登录',1525142530,'adminy',2,'42.243.14.196','login&login'),(1273,'登录',1525307143,'adminy',2,'223.91.130.150','login&login'),(1274,'登录',1525313284,'adminy',2,'223.91.130.150','login&login'),(1275,'登录',1525336277,'adminy',2,'114.247.201.129','login&login'),(1276,'登录',1525336345,'adminy',2,'114.247.201.129','login&login'),(1277,'登录',1525338598,'adminy',2,'111.121.61.19','login&login'),(1278,'登录',1525343547,'adminy',2,'183.140.16.187','login&login'),(1279,'登录',1525397638,'adminy',2,'203.156.222.82','login&login'),(1280,'清理缓存',1525397655,'adminy',2,'203.156.222.82','cache&'),(1281,'审核新经营类目申请，店铺ID：8',1525397891,'adminy',2,'203.156.222.82','store&store_bind_class_applay_check'),(1282,'编辑页面导航成功[自提站管理]',1525398087,'adminy',2,'203.156.222.82','navigation&navigation_edit'),(1283,'登录',1525403820,'adminy',2,'203.156.222.82','login&login'),(1284,'清理缓存',1525404611,'adminy',2,'203.156.222.82','cache&'),(1285,'清理缓存',1525404661,'adminy',2,'203.156.222.82','cache&'),(1286,'板块设计[生活电器1]',1525404738,'adminy',2,'203.156.222.82','web_config&web_edit'),(1287,'清理缓存',1525404858,'adminy',2,'203.156.222.82','cache&'),(1288,'登录',1525404963,'adminy',2,'203.156.222.82','login&login'),(1289,'板块设计[个护美妆eee]',1525405329,'adminy',2,'203.156.222.82','web_config&web_edit'),(1290,'清理缓存',1525405353,'adminy',2,'203.156.222.82','cache&'),(1291,'板块设计[个护美妆]',1525405409,'adminy',2,'203.156.222.82','web_config&web_edit'),(1292,'板块设计[默认]',1525405493,'adminy',2,'203.156.222.82','web_config&web_edit'),(1293,'板块设计[褐色]',1525405502,'adminy',2,'203.156.222.82','web_config&web_edit'),(1294,'板块设计[紫色]',1525405507,'adminy',2,'203.156.222.82','web_config&web_edit'),(1295,'板块设计[数码产品]',1525405515,'adminy',2,'203.156.222.82','web_config&web_edit'),(1296,'登录',1525656076,'adminy',2,'203.156.222.82','login&login'),(1297,'清理缓存',1525656089,'adminy',2,'203.156.222.82','cache&'),(1298,'登录',1525672569,'adminy',2,'203.156.222.82','login&login'),(1299,'商品分类管理[ID:1057]',1525674194,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1300,'编辑商品分类管理[奶粉]',1525674266,'adminy',2,'203.156.222.82','goods_class&goods_class_edit'),(1301,'商品分类管理[ID:480]',1525674814,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1302,'商品分类管理[ID:481]',1525674817,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1303,'商品分类管理[ID:482]',1525674820,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1304,'商品分类管理[ID:483]',1525674823,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1305,'商品分类管理[ID:484]',1525674827,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1306,'商品分类管理[ID:485]',1525674830,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1307,'商品分类管理[ID:472]',1525674897,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1308,'商品分类管理[ID:473]',1525674899,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1309,'商品分类管理[ID:474]',1525674902,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1310,'商品分类管理[ID:475]',1525674904,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1311,'商品分类管理[ID:476]',1525674907,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1312,'商品分类管理[ID:528]',1525674990,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1313,'商品分类管理[ID:529]',1525674993,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1314,'商品分类管理[ID:4]',1525675057,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1315,'商品分类管理[ID:5]',1525675071,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1316,'商品分类管理[ID:6]',1525675074,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1317,'商品分类管理[ID:7]',1525675077,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1318,'编辑分类导航，奶粉',1525675152,'adminy',2,'203.156.222.82','goods_class&nav_edit'),(1319,'编辑分类导航，奶粉',1525675173,'adminy',2,'203.156.222.82','goods_class&nav_edit'),(1320,'编辑分类导航，奶粉',1525675192,'adminy',2,'203.156.222.82','goods_class&nav_edit'),(1321,'编辑分类导航，奶粉',1525675201,'adminy',2,'203.156.222.82','goods_class&nav_edit'),(1322,'编辑分类导航，奶粉',1525675292,'adminy',2,'203.156.222.82','goods_class&nav_edit'),(1323,'商品分类管理[ID:11]',1525675387,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1324,'商品分类管理[ID:90]',1525675421,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1325,'商品分类管理[ID:91,92,93,94,95,96,97,98,99,100]',1525675430,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1326,'商品分类管理[ID:104,105,106]',1525675459,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1327,'商品分类管理[ID:107,108,109,110,111,112,113,114,115]',1525675481,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1328,'商品分类管理[ID:119,120,121,122,123,124,125,126,127,128,',1525675526,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1329,'商品分类管理[ID:153,154,155]',1525675634,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1330,'商品分类管理[ID:165]',1525675706,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1331,'商品分类管理[ID:202,203,204,205]',1525675734,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1332,'商品分类管理[ID:212,213,214,215,216,217]',1525675794,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1333,'商品分类管理[ID:221,222,223,224,225,226,227]',1525675832,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1334,'商品分类管理[ID:258,259,260,261,390,391,392,393,394]',1525675893,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1335,'商品分类管理[ID:452,453,454,455,456,457,458,459,460,461,',1525675928,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1336,'添加商品分类管理[理发器]',1525675984,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1337,'添加商品分类管理[婴儿口腔清洁]',1525675997,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1338,'添加商品分类管理[驱蚊防晒]',1525676006,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1339,'编辑商品分类管理[驱蚊防晒]',1525676026,'adminy',2,'203.156.222.82','goods_class&goods_class_edit'),(1340,'编辑商品分类管理[婴儿口腔清洁]',1525676047,'adminy',2,'203.156.222.82','goods_class&goods_class_edit'),(1341,'编辑商品分类管理[理发器]',1525676057,'adminy',2,'203.156.222.82','goods_class&goods_class_edit'),(1342,'商品分类管理[ID:313]',1525676132,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1343,'商品分类管理[ID:315,316,317,318,319,320,321,322,323,324,',1525676173,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1344,'商品分类管理[ID:329,330,331,332,333,334,335,336,337,338,',1525676206,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1345,'商品分类管理[ID:341,342,343,344,345,346]',1525676228,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1346,'商品分类管理[ID:341,342,343,344,345,346]',1525676228,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1347,'商品分类管理[ID:350,351,352,353,354,355,356,357]',1525676264,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1348,'商品分类管理[ID:358,359,360,361,362]',1525676278,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1349,'商品分类管理[ID:369,370,371,372]',1525676320,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1350,'商品分类管理[ID:531,532,533,534,535,536,537]',1525676464,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1351,'添加商品分类管理[婴童床单/床褥]',1525676528,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1352,'添加商品分类管理[婴童床围]',1525676536,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1353,'添加商品分类管理[婴童床品套件]',1525676545,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1354,'商品分类管理[ID:589,590,591,592]',1525676614,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1355,'商品分类管理[ID:599,600,601,602,603]',1525676721,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1356,'商品分类管理[ID:611,612,613,614,615]',1525676768,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1357,'商品分类管理[ID:618,619,620,621]',1525676789,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1358,'商品分类管理[ID:624,625,626,627]',1525676811,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1359,'添加商品分类管理[名族管弦乐器]',1525676865,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1360,'添加商品分类管理[乐器配件]',1525676875,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1361,'商品分类管理[ID:663,664,665,666,667,668,669]',1525677117,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1362,'添加商品分类管理[胎心仪]',1525677203,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1363,'添加商品分类管理[孕妇马桶垫]',1525677211,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1364,'添加商品分类管理[其它]',1525677219,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1365,'商品分类管理[ID:731,732,733,734,735,736,737]',1525677283,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1366,'添加商品分类管理[孕妇夏装]',1525677330,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1367,'添加商品分类管理[月子服]',1525677342,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1368,'添加商品分类管理[孕妇托腹裤]',1525677353,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1369,'添加商品分类管理[孕妇牛仔裤]',1525677362,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1370,'添加商品分类管理[哺乳文胸]',1525677371,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1371,'添加商品分类管理[孕妇内裤]',1525677380,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1372,'添加商品分类管理[孕妇鞋]',1525677388,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1373,'添加商品分类管理[孕妇袜子]',1525677397,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1374,'商品分类管理[ID:826,827,828,829,830,831,832,833,834,835,',1525677543,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1375,'商品分类管理[ID:877,878,879,880,881,882,883]',1525677573,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1376,'商品分类管理[ID:890,891,892,893,935]',1525677630,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1377,'商品分类管理[ID:895,896,897,898,899,900]',1525677656,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1378,'商品分类管理[ID:960,961,962,963,964,965,966]',1525677791,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1379,'商品分类管理[ID:1031,1032,1033]',1525677842,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1380,'商品分类管理[ID:1041,1042]',1525677865,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1381,'添加商品分类管理[其他]',1525677932,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1382,'编辑会员[ID:1041]',1525680315,'adminy',2,'203.156.222.82','member&member_edit'),(1383,'登录',1525680449,'adminy',2,'203.156.222.82','login&login'),(1384,'编辑会员[ID:1041]',1525680964,'adminy',2,'203.156.222.82','member&member_edit'),(1385,'编辑会员[ID:1041]',1525680994,'adminy',2,'203.156.222.82','member&member_edit'),(1386,'清理缓存',1525682531,'adminy',2,'203.156.222.82','cache&'),(1387,'登录',1525743006,'adminy',2,'203.156.222.82','login&login'),(1388,'登录',1525746584,'adminy',2,'203.156.222.82','login&login'),(1389,'取消抢购活动，抢购编号6',1525748576,'adminy',2,'203.156.222.82','groupbuy&groupbuy_cancel'),(1390,'清理缓存',1525749192,'adminy',2,'203.156.222.82','cache&'),(1391,'清理缓存',1525749978,'adminy',2,'203.156.222.82','cache&'),(1392,'清理缓存',1525750267,'adminy',2,'203.156.222.82','cache&'),(1393,'登录',1525757214,'adminy',2,'203.156.222.82','login&login'),(1394,'成功删除分类推荐商品',1525760576,'adminy',2,'203.156.222.82','goods_recommend&delete'),(1395,'[ID:14]',1525761366,'adminy',2,'203.156.222.82','navigation&navigation_del'),(1396,'添加商品分类管理[玩具]',1525761725,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1397,'添加商品分类管理[箱包]',1525761732,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1398,'添加商品分类管理[腰带]',1525761739,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1399,'添加商品分类管理[玉器]',1525761745,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1400,'添加商品分类管理[头饰]',1525761756,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1401,'添加商品分类管理[花卉]',1525761796,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1402,'添加商品分类管理[工艺品]',1525761805,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1403,'添加商品分类管理[十字绣]',1525761814,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1404,'添加商品分类管理[钟表]',1525761821,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1405,'添加商品分类管理[雨具泳具]',1525761831,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1406,'添加商品分类管理[化妆品]',1525761839,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1407,'添加商品分类管理[假发]',1525761847,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1408,'添加商品分类管理[帽子]',1525761854,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1409,'添加商品分类管理[围巾]',1525761863,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1410,'添加商品分类管理[文体]',1525761871,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1411,'添加商品分类管理[办公用品]',1525761881,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1412,'添加商品分类管理[塑料制品]',1525761890,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1413,'添加商品分类管理[家居饰品]',1525761899,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1414,'添加商品分类管理[服装]',1525762058,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1415,'商品分类管理[ID:1096]',1525762130,'adminy',2,'203.156.222.82','goods_class&goods_class_del'),(1416,'添加商品分类管理[服装]',1525762145,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1417,'添加商品分类管理[童鞋]',1525762153,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1418,'添加商品分类管理[成人鞋]',1525762161,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1419,'添加商品分类管理[内衣]',1525762169,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1420,'添加商品分类管理[袜子]',1525762176,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1421,'删除抢购活动，抢购编号6',1525762714,'adminy',2,'203.156.222.82','groupbuy&groupbuy_del'),(1422,'删除抢购活动，抢购编号5',1525762717,'adminy',2,'203.156.222.82','groupbuy&groupbuy_del'),(1423,'資訊画报分类删除，分类编号1',1525762758,'adminy',2,'203.156.222.82','reads_picture_class&reads_picture_class_drop'),(1424,'資訊文章分类删除，分类编号9',1525762763,'adminy',2,'203.156.222.82','reads_article_class&reads_article_class_drop'),(1425,'資訊文章分类删除，分类编号8',1525762767,'adminy',2,'203.156.222.82','reads_article_class&reads_article_class_drop'),(1426,'資訊文章分类删除，分类编号7',1525762770,'adminy',2,'203.156.222.82','reads_article_class&reads_article_class_drop'),(1427,'資訊专题删除，专题编号4',1525762774,'adminy',2,'203.156.222.82','reads_special&reads_special_drop'),(1428,'添加商品分类管理[童装]',1525764113,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1429,'添加商品分类管理[育婴用品]',1525764125,'adminy',2,'203.156.222.82','goods_class&goods_class_add'),(1430,'板块设计[装备展示]',1525766003,'adminy',2,'203.156.222.82','web_config&web_edit'),(1431,'清理缓存',1525766170,'adminy',2,'203.156.222.82','cache&'),(1432,'登录',1525769136,'adminy',2,'203.156.222.82','login&login'),(1433,'广告信息修改成功[sss购买]',1525769201,'adminy',2,'203.156.222.82','adv&adv_edit'),(1434,'广告信息修改成功[sss购买]',1525769288,'adminy',2,'203.156.222.82','adv&adv_edit'),(1435,'清理缓存',1525769316,'adminy',2,'203.156.222.82','cache&'),(1436,'广告位信息修改成功[首页公告下方广告]',1525769634,'adminy',2,'203.156.222.82','adv&ap_edit'),(1437,'广告位信息修改成功[首页公告下方广告]',1525769739,'adminy',2,'203.156.222.82','adv&ap_edit'),(1438,'資訊管理保存失败',1525770227,'adminy',2,'203.156.222.82','reads_manage&reads_manage_save'),(1439,'编辑商城设置',1525771530,'adminy',2,'203.156.222.82','setting&'),(1440,'清理缓存',1525771613,'adminy',2,'203.156.222.82','cache&'),(1441,'登录',1525857519,'adminy',2,'203.156.222.82','login&login'),(1442,'新增礼品[礼品名称]',1525858848,'adminy',2,'203.156.222.82','pointprod&prod_add'),(1443,'审核新经营类目申请，店铺ID：6',1525859818,'adminy',2,'203.156.222.82','store&store_bind_class_applay_check'),(1444,'登录',1526457503,'adminy',2,'203.156.222.82','login&login'),(1445,'添加页面导航成功[信息反馈]',1526457790,'adminy',2,'203.156.222.82','navigation&navigation_add'),(1446,'编辑页面导航成功[信息反馈]',1526458516,'adminy',2,'203.156.222.82','navigation&navigation_edit'),(1447,'登录',1526539605,'adminy',2,'203.156.222.82','login&login'),(1448,'登录',1526608519,'adminy',2,'203.156.222.82','login&login'),(1449,'登录',1527058355,'adminy',2,'203.156.222.82','login&login'),(1450,'添加品牌管理[惠氏（Wyeth）]',1527059099,'adminy',2,'203.156.222.82','brand&brand_add'),(1451,'添加品牌管理[贝因美（Beingmate）]',1527059206,'adminy',2,'203.156.222.82','brand&brand_add'),(1452,'添加类型[奶粉]',1527059395,'adminy',2,'203.156.222.82','type&type_add'),(1453,'编辑商品分类管理[奶粉]',1527059433,'adminy',2,'203.156.222.82','goods_class&goods_class_edit'),(1454,'编辑类型[奶粉]',1527059507,'adminy',2,'203.156.222.82','type&type_edit'),(1455,'添加类型[3333]',1527059567,'adminy',2,'203.156.222.82','type&type_add'),(1456,'编辑商品分类管理[奶粉]',1527059653,'adminy',2,'203.156.222.82','goods_class&goods_class_edit'),(1457,'编辑商品分类管理[奶粉]',1527059677,'adminy',2,'203.156.222.82','goods_class&goods_class_edit'),(1458,'编辑类型[3333]',1527059742,'adminy',2,'203.156.222.82','type&type_edit'),(1459,'清理缓存',1527059760,'adminy',2,'203.156.222.82','cache&'),(1460,'类型[ID:2]',1527059789,'adminy',2,'203.156.222.82','type&type_del'),(1461,'编辑商品分类管理[奶粉]',1527059846,'adminy',2,'203.156.222.82','goods_class&goods_class_edit'),(1462,'编辑属性[分类]',1527059912,'adminy',2,'203.156.222.82','type&attr_edit'),(1463,'编辑属性[国产/进口]',1527059956,'adminy',2,'203.156.222.82','type&attr_edit'),(1464,'编辑类型[3333]',1527060007,'adminy',2,'203.156.222.82','type&type_edit'),(1465,'编辑类型[奶粉]',1527060049,'adminy',2,'203.156.222.82','type&type_edit'),(1466,'登录',1527132500,'adminy',2,'114.80.215.216','login&login'),(1467,'编辑规格[颜色]',1527132580,'adminy',2,'114.80.215.216','spec&spec_edit'),(1468,'添加规格[选择段位]',1527132775,'adminy',2,'114.80.215.216','spec&spec_add'),(1469,'编辑规格[颜色]',1527132813,'adminy',2,'114.80.215.216','spec&spec_edit'),(1470,'编辑类型[奶粉]',1527132836,'adminy',2,'114.80.215.216','type&type_edit'),(1471,'登录',1527146276,'adminy',2,'114.80.215.216','login&login'),(1472,'清理缓存',1527146294,'adminy',2,'114.80.215.216','cache&'),(1473,'登录',1527218474,'adminy',2,'123.234.138.216','login&login'),(1474,'登录',1527224756,'adminy',2,'123.234.138.216','login&login'),(1475,'登录',1527317586,'adminy',2,'119.167.22.11','login&login'),(1476,'登录',1527321216,'adminy',2,'119.167.22.11','login&login'),(1477,'编辑商品分类管理[奶粉/]',1527321842,'adminy',2,'119.167.22.11','goods_class&goods_class_edit'),(1478,'编辑商品分类管理[奶粉/玩具/用品]',1527321893,'adminy',2,'119.167.22.11','goods_class&goods_class_edit'),(1479,'登录',1527488832,'adminy',2,'119.167.22.11','login&login'),(1480,'登录',1527489192,'adminy',2,'114.80.215.216','login&login'),(1481,'清理缓存',1527489611,'adminy',2,'114.80.215.216','cache&'),(1482,'清理缓存',1527490418,'adminy',2,'114.80.215.216','cache&'),(1483,'[无用图片清理ID:76]',1527492056,'adminy',2,'114.80.215.216','clearpic&'),(1484,'',1527558919,'adminy',2,'114.80.215.216','login&login'),(1485,'商品分类管理[1段a]',1527560203,'adminy',2,'114.80.215.216','goods_class&goods_class_edit'),(1486,'',1527562481,'adminy',2,'203.156.222.82','login&login'),(1487,'',1527571789,'adminy',2,'203.156.222.82','login&login'),(1488,'',1528178384,'adminy',2,'119.167.22.11','login&login'),(1489,'',1528188611,'adminy',2,'119.167.22.11','login&login'),(1490,'编辑账号同步，手机短信设置',1528188832,'adminy',2,'119.167.22.11','account&sms'),(1491,'',1528191486,'adminy',2,'114.80.215.216','login&login'),(1492,'',1528280504,'adminy',2,'119.167.22.11','login&login'),(1493,'',1528365599,'adminy',2,'114.80.215.216','login&login'),(1494,'',1528794399,'adminy',2,'203.156.222.82','login&login'),(1495,'',1528795998,'adminy',2,'203.156.222.82','operation&'),(1496,'',1528860949,'adminy',2,'203.156.222.82','login&login'),(1497,'',1528869712,'adminy',2,'203.156.222.82','login&login'),(1498,'',1528875617,'adminy',2,'203.156.222.82','login&login'),(1499,'短信设置',1528875651,'adminy',2,'203.156.222.82','feiwa&webchat'),(1500,'编辑账号同步，WAP微信登录设置',1528877527,'adminy',2,'203.156.222.82','mb_connect&wap_wx'),(1501,'编辑账号同步，微信登录设置',1528877540,'adminy',2,'203.156.222.82','mb_connect&wx'),(1502,'',1529033629,'adminy',2,'203.156.222.82','login&login'),(1503,'',1530092557,'adminy',2,'203.156.222.82','login&login'),(1504,'',1530092609,'adminy',2,'203.156.222.82','login&login'),(1505,'',1530092834,'admin',1,'203.156.222.82','login&login'),(1506,'',1530092922,'admin',1,'203.156.222.82','login&login'),(1507,'',1530092993,'admin',1,'203.156.222.82','login&login'),(1508,'',1531373471,'adminy',2,'114.80.215.216','login&login'),(1509,'',1532050888,'adminy',2,'114.80.215.216','login&login'),(1510,'',1532081235,'adminy',2,'203.156.222.82','login&login'),(1511,'',1532081296,'adminy',2,'203.156.222.82','login&login'),(1512,'清理缓存',1532081512,'adminy',2,'203.156.222.82','cache&'),(1513,'',1532082045,'adminy',2,'','login&login'),(1514,'',1532082351,'adminy',2,'221.13.1.176','login&login'),(1515,'',1532082889,'adminy',2,'221.13.1.176','login&login'),(1516,'',1533276434,'adminy',2,'119.167.17.30','login&login'),(1517,'快递公司状态[ID:1]',1533276910,'adminy',2,'119.167.17.30','express&'),(1518,'快递公司状态[ID:1]',1533276914,'adminy',2,'119.167.17.30','express&'),(1519,'',1536057257,'admin',1,'114.80.215.216','login&login'),(1520,'',1536114794,'admin',1,'203.156.222.82','login&login'),(1521,'',1536134041,'admin',1,'114.80.215.216','login&login'),(1522,'会员[ID:1041]',1536137090,'admin',1,'114.80.215.216','member&member_edit'),(1523,'',1536298449,'admin',1,'203.156.222.82','login&login'),(1524,'',1536298588,'admin',1,'203.156.222.82','login&login');

/*Table structure for table `feiwa_adv` */

DROP TABLE IF EXISTS `feiwa_adv`;

CREATE TABLE `feiwa_adv` (
  `adv_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '广告自增标识编号',
  `ap_id` mediumint(8) unsigned NOT NULL COMMENT '广告位id',
  `adv_title` varchar(255) NOT NULL DEFAULT '' COMMENT '广告内容描述',
  `adv_content` varchar(1000) NOT NULL DEFAULT '' COMMENT '广告内容',
  `adv_start_date` int(10) DEFAULT NULL COMMENT '广告开始时间',
  `adv_end_date` int(10) DEFAULT NULL COMMENT '广告结束时间',
  `slide_sort` int(10) unsigned NOT NULL COMMENT '幻灯片排序',
  `member_id` int(11) NOT NULL COMMENT '会员ID',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员用户名',
  `click_num` int(10) unsigned NOT NULL COMMENT '广告点击率',
  `is_allow` smallint(1) unsigned NOT NULL COMMENT '会员购买的广告是否通过审核0未审核1审核已通过2审核未通过',
  `buy_style` varchar(10) NOT NULL DEFAULT '' COMMENT '购买方式',
  `goldpay` int(10) unsigned NOT NULL COMMENT '购买所支付的金币',
  PRIMARY KEY (`adv_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='广告表';

/*Data for the table `feiwa_adv` */

insert  into `feiwa_adv`(`adv_id`,`ap_id`,`adv_title`,`adv_content`,`adv_start_date`,`adv_end_date`,`slide_sort`,`member_id`,`member_name`,`click_num`,`is_allow`,`buy_style`,`goldpay`) values (15,9,'闪购特卖！狂喜','a:2:{s:7:\"adv_pic\";s:21:\"05392843812641728.jpg\";s:11:\"adv_pic_url\";s:34:\"http://www.demo.feiwa.org/mall/tm.html\";}',1388505600,1577721600,0,0,'',0,1,'',0),(16,38,'sss购买','a:2:{s:7:\"adv_pic\";s:21:\"05791132884942128.jpg\";s:11:\"adv_pic_url\";s:0:\"\";}',1453737600,1483632000,0,0,'',0,1,'',0);

/*Table structure for table `feiwa_adv_position` */

DROP TABLE IF EXISTS `feiwa_adv_position`;

CREATE TABLE `feiwa_adv_position` (
  `ap_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '广告位置id',
  `ap_name` varchar(100) NOT NULL DEFAULT '' COMMENT '广告位置名',
  `ap_class` smallint(1) unsigned NOT NULL COMMENT '广告类别：0图片1文字2幻灯3Flash',
  `ap_display` smallint(1) unsigned NOT NULL COMMENT '广告展示方式：0幻灯片1多广告展示2单广告展示',
  `is_use` smallint(1) unsigned NOT NULL COMMENT '广告位是否启用：0不启用1启用',
  `ap_width` int(10) NOT NULL COMMENT '广告位宽度',
  `ap_height` int(10) NOT NULL COMMENT '广告位高度',
  `adv_num` int(10) unsigned NOT NULL COMMENT '拥有的广告数',
  `click_num` int(10) unsigned NOT NULL COMMENT '广告位点击率',
  `default_content` varchar(100) NOT NULL DEFAULT '' COMMENT '广告位默认内容',
  PRIMARY KEY (`ap_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='广告位表';

/*Data for the table `feiwa_adv_position` */

insert  into `feiwa_adv_position`(`ap_id`,`ap_name`,`ap_class`,`ap_display`,`is_use`,`ap_width`,`ap_height`,`adv_num`,`click_num`,`default_content`) values (9,'首页底部通栏图片广告',0,2,1,1200,100,1,0,'04418235791378401.jpg'),(11,'首页焦点大图广告1',0,2,1,1920,481,0,0,'11.jpg'),(12,'首页焦点大图广告2',0,2,1,1920,481,0,0,'12.jpg'),(21,'首页焦点联动广告1',0,2,1,259,180,0,0,'05639924587693134.jpg'),(22,'首页焦点联动广告2',0,2,1,259,180,0,0,'05639924994972174.jpg'),(23,'首页焦点联动广告3',0,2,1,259,180,0,0,'05639925422257638.jpg'),(35,'积分列表页中部广告位',0,2,1,900,368,0,0,'04606336969591517.jpg'),(37,'商品列表页左侧广告位',0,1,1,1200,100,0,0,'05070762113432516.jpg'),(38,'首页公告下方广告',0,1,1,1200,200,1,0,'05791137395849474.jpg'),(39,'新广告',0,2,1,800,200,0,0,'05677964211283878.jpg');

/*Table structure for table `feiwa_album_class` */

DROP TABLE IF EXISTS `feiwa_album_class`;

CREATE TABLE `feiwa_album_class` (
  `aclass_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '相册id',
  `aclass_name` varchar(100) NOT NULL DEFAULT '' COMMENT '相册名称',
  `store_id` int(10) unsigned NOT NULL COMMENT '所属店铺id',
  `aclass_des` varchar(255) NOT NULL DEFAULT '' COMMENT '相册描述',
  `aclass_sort` tinyint(3) unsigned NOT NULL COMMENT '排序',
  `aclass_cover` varchar(255) NOT NULL DEFAULT '' COMMENT '相册封面',
  `upload_time` int(10) unsigned NOT NULL COMMENT '图片上传时间',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为默认相册,1代表默认',
  PRIMARY KEY (`aclass_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='相册表';

/*Data for the table `feiwa_album_class` */

insert  into `feiwa_album_class`(`aclass_id`,`aclass_name`,`store_id`,`aclass_des`,`aclass_sort`,`aclass_cover`,`upload_time`,`is_default`) values (1,'默认相册',1,'',255,'',1387942806,1),(6,'默认相册',6,'',255,'',1510651303,1),(7,'默认相册',7,'',255,'',1510652284,1),(8,'默认相册',8,'',255,'',1510797064,1),(9,'默认相册',9,'',255,'',1513701645,1),(10,'默认相册',10,'',255,'',1515311234,1),(11,'默认相册',11,'',255,'',1515565480,1),(12,'默认相册',12,'',255,'',1516071763,1),(13,'默认相册',13,'',255,'',1517889256,1),(14,'默认相册',14,'',255,'',1523952685,1);

/*Table structure for table `feiwa_album_pic` */

DROP TABLE IF EXISTS `feiwa_album_pic`;

CREATE TABLE `feiwa_album_pic` (
  `apic_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '相册图片表id',
  `apic_name` varchar(100) NOT NULL DEFAULT '' COMMENT '图片名称',
  `apic_tag` varchar(255) DEFAULT '' COMMENT '图片标签',
  `aclass_id` int(10) unsigned NOT NULL COMMENT '相册id',
  `apic_cover` varchar(255) NOT NULL DEFAULT '' COMMENT '图片路径',
  `apic_size` int(10) unsigned NOT NULL COMMENT '图片大小',
  `apic_spec` varchar(100) NOT NULL DEFAULT '' COMMENT '图片规格',
  `store_id` int(10) unsigned NOT NULL COMMENT '所属店铺id',
  `upload_time` int(10) unsigned NOT NULL COMMENT '图片上传时间',
  PRIMARY KEY (`apic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8 COMMENT='相册图片表';

/*Data for the table `feiwa_album_pic` */

insert  into `feiwa_album_pic`(`apic_id`,`apic_name`,`apic_tag`,`aclass_id`,`apic_cover`,`apic_size`,`apic_spec`,`store_id`,`upload_time`) values (23,'web-101-101-1','',1,'1_05639910231634000.jpg',178388,'770x455',1,1510647022),(24,'web-101-101-5','',1,'1_05639910662042030.jpg',158360,'750x442',1,1510647065),(25,'123','',7,'7_05639963552390024.jpg',30371,'800x212',7,1510652354),(26,'web-101-101-5','',6,'6_05639976863165981.jpg',158360,'750x442',6,1510653685),(27,'shouji_1','',6,'6_05640694365288450.jpg',35935,'1000x1000',6,1510725435),(28,'shouji_2','',6,'6_05640694718977558.jpg',54655,'1000x1000',6,1510725470),(29,'shouji_2','',6,'6_05640695266621049.jpg',54655,'1000x1000',6,1510725525),(30,'shouji_3','',6,'6_05640695864902071.jpg',72075,'1000x1000',6,1510725585),(31,'shouji_4','',6,'6_05640696533875501.jpg',53657,'1000x1000',6,1510725652),(32,'shouji_5','',6,'6_05640697399523971.jpg',36423,'1000x1000',6,1510725738),(33,'Nb_1','',6,'6_05640701117675913.jpg',28690,'220x220',6,1510726110),(34,'Nb_2','',6,'6_05640702410924353.jpg',7471,'220x220',6,1510726239),(35,'Nb_3','',6,'6_05640702750694344.jpg',12286,'220x220',6,1510726273),(36,'Nb_4','',6,'6_05640703397122161.jpg',32562,'220x220',6,1510726338),(37,'Nb_5','',6,'6_05640704145854307.jpg',7745,'220x220',6,1510726413),(38,'75622_1','',6,'6_05640706682104814.jpg',14441,'220x220',6,1510726667),(39,'75622_2','',6,'6_05640707445145727.jpg',14151,'220x220',6,1510726743),(40,'75622_3','',6,'6_05640708105633162.jpg',26448,'220x220',6,1510726809),(41,'75622_4','',6,'6_05640708739178533.jpg',33403,'220x220',6,1510726872),(42,'75622_5','',6,'6_05640709301872887.jpg',26394,'220x220',6,1510726929),(43,'tj_1','',6,'6_05640792936907844.jpg',13615,'160x160',6,1510735292),(44,'tj_2','',6,'6_05640793744330114.jpg',5425,'160x160',6,1510735373),(45,'tj_3','',6,'6_05640794283389144.jpg',10592,'160x160',6,1510735427),(46,'tj_4','',6,'6_05640794886906212.jpg',12201,'160x160',6,1510735487),(47,'tj_5','',6,'6_05640795461732053.jpg',37432,'160x160',6,1510735545),(48,'tj_6','',6,'6_05640795991736857.jpg',14820,'160x160',6,1510735598),(49,'tj_7','',6,'6_05640796519363861.jpg',13812,'160x160',6,1510735650),(50,'tj_8','',6,'6_05640797074821655.jpg',25711,'160x160',6,1510735706),(51,'579f23ccN5e22e48f','',6,'6_05641435623916568.jpg',23058,'300x400',6,1510799561),(52,'598b0e3dNfe88e451','',6,'6_05641436407392527.jpg',42700,'400x400',6,1510799639),(53,'bxb_j5ya','',6,'6_05641438523967786.jpg',17342,'400x400',6,1510799851),(54,'xyjc_ekim','',6,'6_05641439309632665.jpg',47938,'400x400',6,1510799929),(55,'xwj_ipyv','',6,'6_05641439958259293.jpg',50220,'400x400',6,1510799994),(56,'dja_xxnp','',6,'6_05641440651622711.jpg',54762,'350x350',6,1510800064),(57,'dkx_5ise','',6,'6_05641441327776257.jpg',59322,'400x400',6,1510800131),(58,'ms_03_xayq','',6,'6_05641442090378971.jpg',23838,'228x229',6,1510800207),(59,'yifu_1','',6,'6_05641550053590931.jpg',26960,'360x320',6,1510811004),(60,'yifu_2','',6,'6_05641550724034275.jpg',19667,'360x320',6,1510811071),(61,'yifu_3','',6,'6_05641551508115677.jpg',21114,'360x320',6,1510811149),(62,'yifu_4','',6,'6_05641551995810917.jpg',19155,'360x320',6,1510811198),(63,'yifu_5','',6,'6_05641552507107177.jpg',9221,'360x320',6,1510811249),(64,'yifu_6','',6,'6_05641553057045658.jpg',23596,'360x320',6,1510811304),(65,'yifu_7','',6,'6_05641553603227234.jpg',43067,'360x320',6,1510811359),(66,'yifu_9','',6,'6_05641554160867861.jpg',33404,'360x320',6,1510811415),(67,'yifu_15','',6,'6_05641565630344137.jpg',53194,'360x320',6,1510812561),(68,'yifu_14','',6,'6_05641566209296142.jpg',48010,'400x300',6,1510812619),(69,'yifu_10','',6,'6_05641566843466734.jpg',38038,'360x320',6,1510812683),(70,'yifu_11','',6,'6_05641567266828474.jpg',78097,'360x320',6,1510812725),(71,'yifu_12','',6,'6_05641567819547594.jpg',57525,'360x320',6,1510812780),(72,'yifu_16','',6,'6_05641568388466262.jpg',66377,'360x320',6,1510812837),(73,'yifu_17','',6,'6_05641568866716301.jpg',30328,'360x320',6,1510812885),(74,'yifu_18','',6,'6_05641569264724588.jpg',33182,'360x320',6,1510812925),(75,'yifu_19','',6,'6_05641569704639166.jpg',49245,'360x320',6,1510812969),(76,'59ddfcb1Nc3edb8f1','',7,'7_05641584812484484.jpg',79016,'450x450',7,1510814480),(77,'sheying_1','',6,'6_05641603045751101.jpg',38748,'400x400',6,1510816303),(78,'sheying_2','',6,'6_05641604498445569.jpg',53757,'400x400',6,1510816448),(79,'sheying_3','',6,'6_05641604980372834.jpg',39527,'400x400',6,1510816496),(80,'sheying_4','',6,'6_05641605425045738.jpg',38391,'400x400',6,1510816541),(81,'sheying_5','',6,'6_05641605782639771.jpg',58213,'400x400',6,1510816577),(82,'sheying_6','',6,'6_05641606281269303.jpg',41255,'400x400',6,1510816627),(83,'sheying_7','',6,'6_05641606730414492.jpg',34469,'400x400',6,1510816671),(84,'sheying_8','',6,'6_05641607118761159.jpg',43745,'400x400',6,1510816710),(85,'weixing--','',9,'9_05670473063184516.jpg',36533,'150x150',9,1513703306),(86,'Chrysanthemum','',8,'8_05671682277834917.jpg',879394,'1024x768',8,1513824227),(87,'111','',8,'8_05675349300770679.jpg',219207,'1080x1920',8,1514190929),(88,'111','',8,'8_05675387995058942.jpg',219207,'1080x1920',8,1514194799),(89,'0aab10_fafa5efeaf3cbe3b23b2748d13e629a1','',8,'8_05690878192014201.jpg',56028,'533x400',8,1515743818),(90,'111','',11,'11_05690970455241560.jpg',219207,'1080x1920',11,1515753045),(91,'111','',11,'11_05690971118436916.jpg',219207,'1080x1920',11,1515753111),(92,'t017ec7d54dabcb4392','',8,'8_05704559485578983.png',86462,'450x450',8,1517111948),(93,'1279063618','',8,'8_05711617715353625.jpg',51425,'278x1111',8,1517817770),(94,'545450x740_dzob','',8,'8_05760892357437364.jpg',143275,'1236x740',8,1522745235),(95,'1TWhEoStRBK8xpGrPV41nw','',8,'8_05760962657313319.jpg',35798,'600x300',8,1522752265),(96,'d2','',8,'8_05784145611803975.jpg',216186,'1920x1080',8,1525070560),(97,'d5','',8,'8_05784145755325374.jpg',107799,'1920x1200',8,1525070575),(98,'d5','',8,'8_05784146073876340.jpg',107799,'1920x1200',8,1525070607),(99,'d3','',8,'8_05784146101647698.jpg',304767,'1920x1080',8,1525070607),(100,'d4','',8,'8_05784146124104191.jpg',368152,'1920x1080',8,1525070608),(101,'d1','',8,'8_05784146689444857.jpg',359908,'1920x1080',8,1525070668),(102,'5aaa66acN86fedd63','',6,'6_05790921603381392.jpg',96796,'350x350',6,1525748160),(103,'5a6703aaN6e22083c','',6,'6_05790922898189834.jpg',35764,'220x220',6,1525748289),(104,'5a8faf80Nb4f398c7','',6,'6_05790923464771946.jpg',59528,'350x350',6,1525748346),(105,'5aaa48c3N6038d0ff','',6,'6_05790925897757083.jpg',48901,'220x220',6,1525748589),(106,'5aaa48c3N6038d0ff','',6,'6_05790932976710308.jpg',48901,'220x220',6,1525749297),(107,'5aaa66acN86fedd63','',6,'6_05790933754067864.jpg',96796,'350x350',6,1525749375),(108,'5aa77c38N88eb32db','',6,'6_05790934806131704.jpg',98678,'350x350',6,1525749480),(109,'5a6703aaN6e22083c','',6,'6_05790935383331355.jpg',35764,'220x220',6,1525749538),(110,'5aaa48c3N6038d0ff','',6,'6_05790941501653463.jpg',48901,'220x220',6,1525750150),(111,'5aaa48c3N6038d0ff','',6,'6_05790941959199387.jpg',48901,'220x220',6,1525750195),(112,'5aa77c38N88eb32db','',6,'6_05790943837909567.jpg',98678,'350x350',6,1525750383),(113,'5aa77c38N88eb32db','',6,'6_05790944176111788.jpg',98678,'350x350',6,1525750417),(114,'5a6703aaN6e22083c','',6,'6_05790945323496971.jpg',35764,'220x220',6,1525750532),(115,'5a8faf80Nb4f398c7','',6,'6_05790945572317285.jpg',59528,'350x350',6,1525750557),(116,'5aaa48c3N6038d0ff','',6,'6_05790945924710882.jpg',48901,'220x220',6,1525750592),(117,'5aa77c38N88eb32db','',6,'6_05790954343413037.jpg',98678,'350x350',6,1525751434),(118,'2','',6,'6_05790955563332956.jpg',35048,'350x350',6,1525751556),(119,'586374f3N2bb26692','',6,'6_05790956423059031.jpg',103671,'350x350',6,1525751642),(120,'5aaa48c3N6038d0ff','',6,'6_05790956949555934.jpg',48901,'220x220',6,1525751694),(121,'5aaa66acN86fedd63','',6,'6_05790958149971269.jpg',96796,'350x350',6,1525751814),(122,'5acb2d57Ne10ccdb5 (1)','',6,'6_05790959077707398.jpg',28692,'220x220',6,1525751907),(123,'5a8faf80Nb4f398c7','',6,'6_05790959867376758.jpg',59528,'350x350',6,1525751986),(124,'5a6703aaN6e22083c','',6,'6_05790960461426775.jpg',35764,'220x220',6,1525752045),(125,'5acb5b8bNe9d3d11d','',6,'6_05790961092598660.jpg',18761,'220x220',6,1525752109),(126,'5a6703aaN6e22083c','',6,'6_05791011612577193.jpg',35764,'220x220',6,1525757161),(127,'5acb5d40N20b87bed','',6,'6_05791013859287600.jpg',19218,'220x220',6,1525757385),(128,'5ad99a6aN5db5f5ac','',6,'6_05791014397640936.jpg',29638,'220x220',6,1525757439),(129,'56eb9761Ne50af850','',6,'6_05791014867519451.jpg',14832,'220x220',6,1525757486),(130,'5ab0cf8bN60f6e2fd','',6,'6_05791015324909804.jpg',23962,'220x220',6,1525757532),(131,'5aba199fN0b3d011b','',6,'6_05791015808970258.jpg',21532,'220x220',6,1525757580),(132,'5aa261ecN4096ac73','',6,'6_05791016254193023.jpg',46954,'220x220',6,1525757625),(133,'5924daeeN93d2ae97','',6,'6_05791016835295791.jpg',18272,'220x220',6,1525757683),(134,'5a5437b6N1d3b7d7d','',6,'6_05791017279899925.jpg',19088,'220x220',6,1525757727),(135,'5adda59aNe990e230','',6,'6_05791017752734288.jpg',13543,'220x220',6,1525757775),(136,'59353429N65b3cff7','',6,'6_05791018360977876.jpg',24741,'220x220',6,1525757835),(137,'59353429N65b3cff7','',6,'6_05791018889975263.jpg',24741,'220x220',6,1525757888),(138,'59cde250Nc76ff1ca','',6,'6_05791019367334995.jpg',67984,'220x220',6,1525757936),(139,'5a7921f3Nefd713ba','',6,'6_05791019767315044.jpg',52515,'220x220',6,1525757976),(140,'56a19bdfN8e0ec860','',6,'6_05791020286171638.jpg',7891,'220x220',6,1525758028),(141,'5ad6e03dNe040cc2d','',6,'6_05791020695050816.jpg',42011,'220x220',6,1525758069),(142,'57ba9694Nba42dcd2','',6,'6_05791021083025823.jpg',8499,'220x220',6,1525758108),(143,'55532ff7Ncba3a8a1','',6,'6_05791021557730356.jpg',9488,'220x220',6,1525758155),(144,'55544779N3af03531','',6,'6_05791021959746394.jpg',20773,'220x220',6,1525758195),(145,'58e23e3aN95cf7cb6','',6,'6_05791022372517357.jpg',19852,'220x220',6,1525758237),(146,'5ac2e89dNb1ae68d4','',6,'6_05791022845352222.jpg',25618,'220x220',6,1525758284),(147,'58f5de97Nd844677a','',6,'6_05791023313047855.jpg',30153,'220x220',6,1525758331),(148,'5ae969c9Ne1b8baab','',6,'6_05791023787756095.jpg',11221,'220x220',6,1525758378),(149,'58d4d8e9Nbc7fb127','',6,'6_05791024153887525.jpg',27763,'220x220',6,1525758415),(150,'5954930aN99d2155f','',6,'6_05791024667273344.jpg',26603,'220x220',6,1525758466),(151,'5530d4cdN92bfb3c4','',6,'6_05791025042772560.jpg',9382,'220x220',6,1525758504),(152,'5935fed1Nd81d5ba0','',6,'6_05791025690171066.jpg',33277,'220x220',6,1525758568),(153,'55532f1cNd367a820','',6,'6_05791026144289680.jpg',14435,'220x220',6,1525758614),(154,'573924feN68b98d68','',6,'6_05791026636468776.jpg',43384,'220x220',6,1525758663),(155,'5ae3d9abN43eece35','',6,'6_05791027257195652.jpg',42436,'220x220',6,1525758725),(156,'rBEIDE_tEIgIAAAAAACkatXUxXMAADbXACNQd0AAKSC598','',6,'6_05791027630963566.jpg',7927,'220x220',6,1525758762),(157,'5addaf53N50ee3889','',6,'6_05791028034696755.jpg',36811,'220x220',6,1525758803),(158,'56c3ef92Nd944095a','',6,'6_05791028521571841.jpg',32613,'220x220',6,1525758852),(159,'5aaf35c1Nb705e6cd','',6,'6_05791029019677006.jpg',16071,'220x220',6,1525758901),(160,'5abf3e76N82b52471 (1)','',6,'6_05791069315571320.jpg',49740,'350x350',6,1525762931),(161,'587c2d73N38f13b33','',6,'6_05791071572119235.jpg',14432,'350x350',6,1525763157),(162,'5abdaeedN79796667','',6,'6_05791071936832202.jpg',15643,'220x220',6,1525763193),(163,'5ad84f8dN26086029','',6,'6_05791072669576301.jpg',16090,'220x220',6,1525763266),(164,'5ae41858N84361faa','',6,'6_05791073806963100.jpg',18418,'220x220',6,1525763380),(165,'5a9e358fNfa06127c','',6,'6_05791074892100454.jpg',19145,'350x350',6,1525763489),(166,'5a73168aN1f467544','',6,'6_05791075928721239.jpg',67544,'350x350',6,1525763592),(167,'592e5de1N83b1a925','',6,'6_05791076612318931.jpg',89291,'350x350',6,1525763661),(168,'5abf3572N935a5979','',6,'6_05791093527085243.jpg',51264,'350x350',6,1525765352),(169,'59f96abcN35c13ec0','',6,'6_05791094837636994.jpg',128224,'350x350',6,1525765483),(170,'1600sport_1020','',6,'6_05791146713722862.jpg',267702,'1600x1200',6,1525770671),(171,'583bf1ddN29604759','',6,'6_05804049290836782.jpg',19571,'220x220',6,1527060928),(172,'5a8fb688N953c5bea','',6,'6_05804051868241314.jpg',14097,'220x220',6,1527061186);

/*Table structure for table `feiwa_apiseccode` */

DROP TABLE IF EXISTS `feiwa_apiseccode`;

CREATE TABLE `feiwa_apiseccode` (
  `sec_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `sec_key` varchar(50) NOT NULL DEFAULT '' COMMENT '验证码标识',
  `sec_val` varchar(100) NOT NULL DEFAULT '' COMMENT '验证码值',
  `sec_addtime` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`sec_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `feiwa_apiseccode` */

/*Table structure for table `feiwa_area` */

DROP TABLE IF EXISTS `feiwa_area`;

CREATE TABLE `feiwa_area` (
  `area_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引ID',
  `area_name` varchar(50) NOT NULL DEFAULT '' COMMENT '地区名称',
  `area_parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '地区父ID',
  `area_sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `area_deep` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '地区深度，从1开始',
  `area_region` varchar(3) DEFAULT NULL COMMENT '大区名称',
  PRIMARY KEY (`area_id`),
  KEY `area_parent_id` (`area_parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45057 DEFAULT CHARSET=utf8 COMMENT='地区表';

/*Data for the table `feiwa_area` */

insert  into `feiwa_area`(`area_id`,`area_name`,`area_parent_id`,`area_sort`,`area_deep`,`area_region`) values (1,'北京',0,0,1,'华北'),(2,'天津',0,0,1,'华北'),(3,'河北',0,0,1,'华北'),(4,'山西',0,0,1,'华北'),(5,'内蒙古',0,0,1,'华北'),(6,'辽宁',0,0,1,'东北'),(7,'吉林',0,0,1,'东北'),(8,'黑龙江',0,0,1,'东北'),(9,'上海',0,0,1,'华东'),(10,'江苏',0,0,1,'华东'),(11,'浙江',0,0,1,'华东'),(12,'安徽',0,0,1,'华东'),(13,'福建',0,0,1,'华南'),(14,'江西',0,0,1,'华东'),(15,'山东',0,0,1,'华东'),(16,'河南',0,0,1,'华中'),(17,'湖北',0,0,1,'华中'),(18,'湖南',0,0,1,'华中'),(19,'广东',0,0,1,'华南'),(20,'广西',0,0,1,'华南'),(21,'海南',0,0,1,'华南'),(22,'重庆',0,0,1,'西南'),(23,'四川',0,0,1,'西南'),(24,'贵州',0,0,1,'西南'),(25,'云南',0,0,1,'西南'),(26,'西藏',0,0,1,'西南'),(27,'陕西',0,0,1,'西北'),(28,'甘肃',0,0,1,'西北'),(29,'青海',0,0,1,'西北'),(30,'宁夏',0,0,1,'西北'),(31,'新疆',0,0,1,'西北'),(32,'台湾',0,0,1,'港澳台'),(33,'香港',0,0,1,'港澳台'),(34,'澳门',0,0,1,'港澳台'),(35,'海外',0,0,1,'海外'),(36,'北京市',1,0,2,''),(37,'东城区',36,0,3,NULL),(38,'西城区',36,0,3,NULL),(39,'上海市',9,0,2,NULL),(40,'天津市',2,0,2,NULL),(41,'朝阳区',36,0,3,NULL),(42,'丰台区',36,0,3,NULL),(43,'石景山区',36,0,3,NULL),(44,'海淀区',36,0,3,NULL),(45,'门头沟区',36,0,3,NULL),(46,'房山区',36,0,3,NULL),(47,'通州区',36,0,3,NULL),(48,'顺义区',36,0,3,NULL),(49,'昌平区',36,0,3,NULL),(50,'大兴区',36,0,3,NULL),(51,'怀柔区',36,0,3,NULL),(52,'平谷区',36,0,3,NULL),(53,'密云县',36,0,3,NULL),(54,'延庆县',36,0,3,NULL),(55,'和平区',40,0,3,NULL),(56,'河东区',40,0,3,NULL),(57,'河西区',40,0,3,NULL),(58,'南开区',40,0,3,NULL),(59,'河北区',40,0,3,NULL),(60,'红桥区',40,0,3,NULL),(61,'塘沽区',40,0,3,NULL),(62,'重庆市',22,0,2,NULL),(64,'东丽区',40,0,3,NULL),(65,'西青区',40,0,3,NULL),(66,'津南区',40,0,3,NULL),(67,'北辰区',40,0,3,NULL),(68,'武清区',40,0,3,NULL),(69,'宝坻区',40,0,3,NULL),(70,'宁河县',40,0,3,NULL),(71,'静海县',40,0,3,NULL),(72,'蓟县',40,0,3,NULL),(73,'石家庄市',3,0,2,NULL),(74,'唐山市',3,0,2,NULL),(75,'秦皇岛市',3,0,2,NULL),(76,'邯郸市',3,0,2,NULL),(77,'邢台市',3,0,2,NULL),(78,'保定市',3,0,2,NULL),(79,'张家口市',3,0,2,NULL),(80,'承德市',3,0,2,NULL),(81,'衡水市',3,0,2,NULL),(82,'廊坊市',3,0,2,NULL),(83,'沧州市',3,0,2,NULL),(84,'太原市',4,0,2,NULL),(85,'大同市',4,0,2,NULL),(86,'阳泉市',4,0,2,NULL),(87,'长治市',4,0,2,NULL),(88,'晋城市',4,0,2,NULL),(89,'朔州市',4,0,2,NULL),(90,'晋中市',4,0,2,NULL),(91,'运城市',4,0,2,NULL),(92,'忻州市',4,0,2,NULL),(93,'临汾市',4,0,2,NULL),(94,'吕梁市',4,0,2,NULL),(95,'呼和浩特市',5,0,2,NULL),(96,'包头市',5,0,2,NULL),(97,'乌海市',5,0,2,NULL),(98,'赤峰市',5,0,2,NULL),(99,'通辽市',5,0,2,NULL),(100,'鄂尔多斯市',5,0,2,NULL),(101,'呼伦贝尔市',5,0,2,NULL),(102,'巴彦淖尔市',5,0,2,NULL),(103,'乌兰察布市',5,0,2,NULL),(104,'兴安盟',5,0,2,NULL),(105,'锡林郭勒盟',5,0,2,NULL),(106,'阿拉善盟',5,0,2,NULL),(107,'沈阳市',6,0,2,NULL),(108,'大连市',6,0,2,NULL),(109,'鞍山市',6,0,2,NULL),(110,'抚顺市',6,0,2,NULL),(111,'本溪市',6,0,2,NULL),(112,'丹东市',6,0,2,NULL),(113,'锦州市',6,0,2,NULL),(114,'营口市',6,0,2,NULL),(115,'阜新市',6,0,2,NULL),(116,'辽阳市',6,0,2,NULL),(117,'盘锦市',6,0,2,NULL),(118,'铁岭市',6,0,2,NULL),(119,'朝阳市',6,0,2,NULL),(120,'葫芦岛市',6,0,2,NULL),(121,'长春市',7,0,2,NULL),(122,'吉林市',7,0,2,NULL),(123,'四平市',7,0,2,NULL),(124,'辽源市',7,0,2,NULL),(125,'通化市',7,0,2,NULL),(126,'白山市',7,0,2,NULL),(127,'松原市',7,0,2,NULL),(128,'白城市',7,0,2,NULL),(129,'延边朝鲜族自治州',7,0,2,NULL),(130,'哈尔滨市',8,0,2,NULL),(131,'齐齐哈尔市',8,0,2,NULL),(132,'鸡西市',8,0,2,NULL),(133,'鹤岗市',8,0,2,NULL),(134,'双鸭山市',8,0,2,NULL),(135,'大庆市',8,0,2,NULL),(136,'伊春市',8,0,2,NULL),(137,'佳木斯市',8,0,2,NULL),(138,'七台河市',8,0,2,NULL),(139,'牡丹江市',8,0,2,NULL),(140,'黑河市',8,0,2,NULL),(141,'绥化市',8,0,2,NULL),(142,'大兴安岭地区',8,0,2,NULL),(143,'黄浦区',39,0,3,NULL),(144,'卢湾区',39,0,3,NULL),(145,'徐汇区',39,0,3,NULL),(146,'长宁区',39,0,3,NULL),(147,'静安区',39,0,3,NULL),(148,'普陀区',39,0,3,NULL),(149,'闸北区',39,0,3,NULL),(150,'虹口区',39,0,3,NULL),(151,'杨浦区',39,0,3,NULL),(152,'闵行区',39,0,3,NULL),(153,'宝山区',39,0,3,NULL),(154,'嘉定区',39,0,3,NULL),(155,'浦东新区',39,0,3,NULL),(156,'金山区',39,0,3,NULL),(157,'松江区',39,0,3,NULL),(158,'青浦区',39,0,3,NULL),(159,'南汇区',39,0,3,NULL),(160,'奉贤区',39,0,3,NULL),(161,'崇明县',39,0,3,NULL),(162,'南京市',10,0,2,NULL),(163,'无锡市',10,0,2,NULL),(164,'徐州市',10,0,2,NULL),(165,'常州市',10,0,2,NULL),(166,'苏州市',10,0,2,NULL),(167,'南通市',10,0,2,NULL),(168,'连云港市',10,0,2,NULL),(169,'淮安市',10,0,2,NULL),(170,'盐城市',10,0,2,NULL),(171,'扬州市',10,0,2,NULL),(172,'镇江市',10,0,2,NULL),(173,'泰州市',10,0,2,NULL),(174,'宿迁市',10,0,2,NULL),(175,'杭州市',11,0,2,NULL),(176,'宁波市',11,0,2,NULL),(177,'温州市',11,0,2,NULL),(178,'嘉兴市',11,0,2,NULL),(179,'湖州市',11,0,2,NULL),(180,'绍兴市',11,0,2,NULL),(181,'舟山市',11,0,2,NULL),(182,'衢州市',11,0,2,NULL),(183,'金华市',11,0,2,NULL),(184,'台州市',11,0,2,NULL),(185,'丽水市',11,0,2,NULL),(186,'合肥市',12,0,2,NULL),(187,'芜湖市',12,0,2,NULL),(188,'蚌埠市',12,0,2,NULL),(189,'淮南市',12,0,2,NULL),(190,'马鞍山市',12,0,2,NULL),(191,'淮北市',12,0,2,NULL),(192,'铜陵市',12,0,2,NULL),(193,'安庆市',12,0,2,NULL),(194,'黄山市',12,0,2,NULL),(195,'滁州市',12,0,2,NULL),(196,'阜阳市',12,0,2,NULL),(197,'宿州市',12,0,2,NULL),(198,'巢湖市',12,0,2,NULL),(199,'六安市',12,0,2,NULL),(200,'亳州市',12,0,2,NULL),(201,'池州市',12,0,2,NULL),(202,'宣城市',12,0,2,NULL),(203,'福州市',13,0,2,NULL),(204,'厦门市',13,0,2,NULL),(205,'莆田市',13,0,2,NULL),(206,'三明市',13,0,2,NULL),(207,'泉州市',13,0,2,NULL),(208,'漳州市',13,0,2,NULL),(209,'南平市',13,0,2,NULL),(210,'龙岩市',13,0,2,NULL),(211,'宁德市',13,0,2,NULL),(212,'南昌市',14,0,2,NULL),(213,'景德镇市',14,0,2,NULL),(214,'萍乡市',14,0,2,NULL),(215,'九江市',14,0,2,NULL),(216,'新余市',14,0,2,NULL),(217,'鹰潭市',14,0,2,NULL),(218,'赣州市',14,0,2,NULL),(219,'吉安市',14,0,2,NULL),(220,'宜春市',14,0,2,NULL),(221,'抚州市',14,0,2,NULL),(222,'上饶市',14,0,2,NULL),(223,'济南市',15,0,2,NULL),(224,'青岛市',15,0,2,NULL),(225,'淄博市',15,0,2,NULL),(226,'枣庄市',15,0,2,NULL),(227,'东营市',15,0,2,NULL),(228,'烟台市',15,0,2,NULL),(229,'潍坊市',15,0,2,NULL),(230,'济宁市',15,0,2,NULL),(231,'泰安市',15,0,2,NULL),(232,'威海市',15,0,2,NULL),(233,'日照市',15,0,2,NULL),(234,'莱芜市',15,0,2,NULL),(235,'临沂市',15,0,2,NULL),(236,'德州市',15,0,2,NULL),(237,'聊城市',15,0,2,NULL),(238,'滨州市',15,0,2,NULL),(239,'菏泽市',15,0,2,NULL),(240,'郑州市',16,0,2,NULL),(241,'开封市',16,0,2,NULL),(242,'洛阳市',16,0,2,NULL),(243,'平顶山市',16,0,2,NULL),(244,'安阳市',16,0,2,NULL),(245,'鹤壁市',16,0,2,NULL),(246,'新乡市',16,0,2,NULL),(247,'焦作市',16,0,2,NULL),(248,'濮阳市',16,0,2,NULL),(249,'许昌市',16,0,2,NULL),(250,'漯河市',16,0,2,NULL),(251,'三门峡市',16,0,2,NULL),(252,'南阳市',16,0,2,NULL),(253,'商丘市',16,0,2,NULL),(254,'信阳市',16,0,2,NULL),(255,'周口市',16,0,2,NULL),(256,'驻马店市',16,0,2,NULL),(257,'济源市',16,0,2,NULL),(258,'武汉市',17,0,2,NULL),(259,'黄石市',17,0,2,NULL),(260,'十堰市',17,0,2,NULL),(261,'宜昌市',17,0,2,NULL),(262,'襄樊市',17,0,2,NULL),(263,'鄂州市',17,0,2,NULL),(264,'荆门市',17,0,2,NULL),(265,'孝感市',17,0,2,NULL),(266,'荆州市',17,0,2,NULL),(267,'黄冈市',17,0,2,NULL),(268,'咸宁市',17,0,2,NULL),(269,'随州市',17,0,2,NULL),(270,'恩施土家族苗族自治州',17,0,2,NULL),(271,'仙桃市',17,0,2,NULL),(272,'潜江市',17,0,2,NULL),(273,'天门市',17,0,2,NULL),(274,'神农架林区',17,0,2,NULL),(275,'长沙市',18,0,2,NULL),(276,'株洲市',18,0,2,NULL),(277,'湘潭市',18,0,2,NULL),(278,'衡阳市',18,0,2,NULL),(279,'邵阳市',18,0,2,NULL),(280,'岳阳市',18,0,2,NULL),(281,'常德市',18,0,2,NULL),(282,'张家界市',18,0,2,NULL),(283,'益阳市',18,0,2,NULL),(284,'郴州市',18,0,2,NULL),(285,'永州市',18,0,2,NULL),(286,'怀化市',18,0,2,NULL),(287,'娄底市',18,0,2,NULL),(288,'湘西土家族苗族自治州',18,0,2,NULL),(289,'广州市',19,0,2,NULL),(290,'韶关市',19,0,2,NULL),(291,'深圳市',19,0,2,NULL),(292,'珠海市',19,0,2,NULL),(293,'汕头市',19,0,2,NULL),(294,'佛山市',19,0,2,NULL),(295,'江门市',19,0,2,NULL),(296,'湛江市',19,0,2,NULL),(297,'茂名市',19,0,2,NULL),(298,'肇庆市',19,0,2,NULL),(299,'惠州市',19,0,2,NULL),(300,'梅州市',19,0,2,NULL),(301,'汕尾市',19,0,2,NULL),(302,'河源市',19,0,2,NULL),(303,'阳江市',19,0,2,NULL),(304,'清远市',19,0,2,NULL),(305,'东莞市',19,0,2,NULL),(306,'中山市',19,0,2,NULL),(307,'潮州市',19,0,2,NULL),(308,'揭阳市',19,0,2,NULL),(309,'云浮市',19,0,2,NULL),(310,'南宁市',20,0,2,NULL),(311,'柳州市',20,0,2,NULL),(312,'桂林市',20,0,2,NULL),(313,'梧州市',20,0,2,NULL),(314,'北海市',20,0,2,NULL),(315,'防城港市',20,0,2,NULL),(316,'钦州市',20,0,2,NULL),(317,'贵港市',20,0,2,NULL),(318,'玉林市',20,0,2,NULL),(319,'百色市',20,0,2,NULL),(320,'贺州市',20,0,2,NULL),(321,'河池市',20,0,2,NULL),(322,'来宾市',20,0,2,NULL),(323,'崇左市',20,0,2,NULL),(324,'海口市',21,0,2,NULL),(325,'三亚市',21,0,2,NULL),(326,'五指山市',21,0,2,NULL),(327,'琼海市',21,0,2,NULL),(328,'儋州市',21,0,2,NULL),(329,'文昌市',21,0,2,NULL),(330,'万宁市',21,0,2,NULL),(331,'东方市',21,0,2,NULL),(332,'定安县',21,0,2,NULL),(333,'屯昌县',21,0,2,NULL),(334,'澄迈县',21,0,2,NULL),(335,'临高县',21,0,2,NULL),(336,'白沙黎族自治县',21,0,2,NULL),(337,'昌江黎族自治县',21,0,2,NULL),(338,'乐东黎族自治县',21,0,2,NULL),(339,'陵水黎族自治县',21,0,2,NULL),(340,'保亭黎族苗族自治县',21,0,2,NULL),(341,'琼中黎族苗族自治县',21,0,2,NULL),(342,'西沙群岛',21,0,2,NULL),(343,'南沙群岛',21,0,2,NULL),(344,'中沙群岛的岛礁及其海域',21,0,2,NULL),(345,'万州区',62,0,3,NULL),(346,'涪陵区',62,0,3,NULL),(347,'渝中区',62,0,3,NULL),(348,'大渡口区',62,0,3,NULL),(349,'江北区',62,0,3,NULL),(350,'沙坪坝区',62,0,3,NULL),(351,'九龙坡区',62,0,3,NULL),(352,'南岸区',62,0,3,NULL),(353,'北碚区',62,0,3,NULL),(354,'双桥区',62,0,3,NULL),(355,'万盛区',62,0,3,NULL),(356,'渝北区',62,0,3,NULL),(357,'巴南区',62,0,3,NULL),(358,'黔江区',62,0,3,NULL),(359,'长寿区',62,0,3,NULL),(360,'綦江县',62,0,3,NULL),(361,'潼南县',62,0,3,NULL),(362,'铜梁县',62,0,3,NULL),(363,'大足县',62,0,3,NULL),(364,'荣昌县',62,0,3,NULL),(365,'璧山县',62,0,3,NULL),(366,'梁平县',62,0,3,NULL),(367,'城口县',62,0,3,NULL),(368,'丰都县',62,0,3,NULL),(369,'垫江县',62,0,3,NULL),(370,'武隆县',62,0,3,NULL),(371,'忠县',62,0,3,NULL),(372,'开县',62,0,3,NULL),(373,'云阳县',62,0,3,NULL),(374,'奉节县',62,0,3,NULL),(375,'巫山县',62,0,3,NULL),(376,'巫溪县',62,0,3,NULL),(377,'石柱土家族自治县',62,0,3,NULL),(378,'秀山土家族苗族自治县',62,0,3,NULL),(379,'酉阳土家族苗族自治县',62,0,3,NULL),(380,'彭水苗族土家族自治县',62,0,3,NULL),(381,'江津市',62,0,3,NULL),(382,'合川市',62,0,3,NULL),(383,'永川市',62,0,3,NULL),(384,'南川市',62,0,3,NULL),(385,'成都市',23,0,2,NULL),(386,'自贡市',23,0,2,NULL),(387,'攀枝花市',23,0,2,NULL),(388,'泸州市',23,0,2,NULL),(389,'德阳市',23,0,2,NULL),(390,'绵阳市',23,0,2,NULL),(391,'广元市',23,0,2,NULL),(392,'遂宁市',23,0,2,NULL),(393,'内江市',23,0,2,NULL),(394,'乐山市',23,0,2,NULL),(395,'南充市',23,0,2,NULL),(396,'眉山市',23,0,2,NULL),(397,'宜宾市',23,0,2,NULL),(398,'广安市',23,0,2,NULL),(399,'达州市',23,0,2,NULL),(400,'雅安市',23,0,2,NULL),(401,'巴中市',23,0,2,NULL),(402,'资阳市',23,0,2,NULL),(403,'阿坝藏族羌族自治州',23,0,2,NULL),(404,'甘孜藏族自治州',23,0,2,NULL),(405,'凉山彝族自治州',23,0,2,NULL),(406,'贵阳市',24,0,2,NULL),(407,'六盘水市',24,0,2,NULL),(408,'遵义市',24,0,2,NULL),(409,'安顺市',24,0,2,NULL),(410,'铜仁地区',24,0,2,NULL),(411,'黔西南布依族苗族自治州',24,0,2,NULL),(412,'毕节地区',24,0,2,NULL),(413,'黔东南苗族侗族自治州',24,0,2,NULL),(414,'黔南布依族苗族自治州',24,0,2,NULL),(415,'昆明市',25,0,2,NULL),(416,'曲靖市',25,0,2,NULL),(417,'玉溪市',25,0,2,NULL),(418,'保山市',25,0,2,NULL),(419,'昭通市',25,0,2,NULL),(420,'丽江市',25,0,2,NULL),(421,'思茅市',25,0,2,NULL),(422,'临沧市',25,0,2,NULL),(423,'楚雄彝族自治州',25,0,2,NULL),(424,'红河哈尼族彝族自治州',25,0,2,NULL),(425,'文山壮族苗族自治州',25,0,2,NULL),(426,'西双版纳傣族自治州',25,0,2,NULL),(427,'大理白族自治州',25,0,2,NULL),(428,'德宏傣族景颇族自治州',25,0,2,NULL),(429,'怒江傈僳族自治州',25,0,2,NULL),(430,'迪庆藏族自治州',25,0,2,NULL),(431,'拉萨市',26,0,2,NULL),(432,'昌都地区',26,0,2,NULL),(433,'山南地区',26,0,2,NULL),(434,'日喀则地区',26,0,2,NULL),(435,'那曲地区',26,0,2,NULL),(436,'阿里地区',26,0,2,NULL),(437,'林芝地区',26,0,2,NULL),(438,'西安市',27,0,2,NULL),(439,'铜川市',27,0,2,NULL),(440,'宝鸡市',27,0,2,NULL),(441,'咸阳市',27,0,2,NULL),(442,'渭南市',27,0,2,NULL),(443,'延安市',27,0,2,NULL),(444,'汉中市',27,0,2,NULL),(445,'榆林市',27,0,2,NULL),(446,'安康市',27,0,2,NULL),(447,'商洛市',27,0,2,NULL),(448,'兰州市',28,0,2,NULL),(449,'嘉峪关市',28,0,2,NULL),(450,'金昌市',28,0,2,NULL),(451,'白银市',28,0,2,NULL),(452,'天水市',28,0,2,NULL),(453,'武威市',28,0,2,NULL),(454,'张掖市',28,0,2,NULL),(455,'平凉市',28,0,2,NULL),(456,'酒泉市',28,0,2,NULL),(457,'庆阳市',28,0,2,NULL),(458,'定西市',28,0,2,NULL),(459,'陇南市',28,0,2,NULL),(460,'临夏回族自治州',28,0,2,NULL),(461,'甘南藏族自治州',28,0,2,NULL),(462,'西宁市',29,0,2,NULL),(463,'海东地区',29,0,2,NULL),(464,'海北藏族自治州',29,0,2,NULL),(465,'黄南藏族自治州',29,0,2,NULL),(466,'海南藏族自治州',29,0,2,NULL),(467,'果洛藏族自治州',29,0,2,NULL),(468,'玉树藏族自治州',29,0,2,NULL),(469,'海西蒙古族藏族自治州',29,0,2,NULL),(470,'银川市',30,0,2,NULL),(471,'石嘴山市',30,0,2,NULL),(472,'吴忠市',30,0,2,NULL),(473,'固原市',30,0,2,NULL),(474,'中卫市',30,0,2,NULL),(475,'乌鲁木齐市',31,0,2,NULL),(476,'克拉玛依市',31,0,2,NULL),(477,'吐鲁番地区',31,0,2,NULL),(478,'哈密地区',31,0,2,NULL),(479,'昌吉回族自治州',31,0,2,NULL),(480,'博尔塔拉蒙古自治州',31,0,2,NULL),(481,'巴音郭楞蒙古自治州',31,0,2,NULL),(482,'阿克苏地区',31,0,2,NULL),(483,'克孜勒苏柯尔克孜自治州',31,0,2,NULL),(484,'喀什地区',31,0,2,NULL),(485,'和田地区',31,0,2,NULL),(486,'伊犁哈萨克自治州',31,0,2,NULL),(487,'塔城地区',31,0,2,NULL),(488,'阿勒泰地区',31,0,2,NULL),(489,'石河子市',31,0,2,NULL),(490,'阿拉尔市',31,0,2,NULL),(491,'图木舒克市',31,0,2,NULL),(492,'五家渠市',31,0,2,NULL),(493,'台北市',32,0,2,NULL),(494,'高雄市',32,0,2,NULL),(495,'基隆市',32,0,2,NULL),(496,'台中市',32,0,2,NULL),(497,'台南市',32,0,2,NULL),(498,'新竹市',32,0,2,NULL),(499,'嘉义市',32,0,2,NULL),(500,'台北县',32,0,2,NULL),(501,'宜兰县',32,0,2,NULL),(502,'桃园县',32,0,2,NULL),(503,'新竹县',32,0,2,NULL),(504,'苗栗县',32,0,2,NULL),(505,'台中县',32,0,2,NULL),(506,'彰化县',32,0,2,NULL),(507,'南投县',32,0,2,NULL),(508,'云林县',32,0,2,NULL),(509,'嘉义县',32,0,2,NULL),(510,'台南县',32,0,2,NULL),(511,'高雄县',32,0,2,NULL),(512,'屏东县',32,0,2,NULL),(513,'澎湖县',32,0,2,NULL),(514,'台东县',32,0,2,NULL),(515,'花莲县',32,0,2,NULL),(516,'中西区',33,0,2,NULL),(517,'东区',33,0,2,NULL),(518,'九龙城区',33,0,2,NULL),(519,'观塘区',33,0,2,NULL),(520,'南区',33,0,2,NULL),(521,'深水埗区',33,0,2,NULL),(522,'黄大仙区',33,0,2,NULL),(523,'湾仔区',33,0,2,NULL),(524,'油尖旺区',33,0,2,NULL),(525,'离岛区',33,0,2,NULL),(526,'葵青区',33,0,2,NULL),(527,'北区',33,0,2,NULL),(528,'西贡区',33,0,2,NULL),(529,'沙田区',33,0,2,NULL),(530,'屯门区',33,0,2,NULL),(531,'大埔区',33,0,2,NULL),(532,'荃湾区',33,0,2,NULL),(533,'元朗区',33,0,2,NULL),(534,'澳门特别行政区',34,0,2,NULL),(535,'美国',45055,0,3,NULL),(536,'加拿大',45055,0,3,NULL),(537,'澳大利亚',45055,0,3,NULL),(538,'新西兰',45055,0,3,NULL),(539,'英国',45055,0,3,NULL),(540,'法国',45055,0,3,NULL),(541,'德国',45055,0,3,NULL),(542,'捷克',45055,0,3,NULL),(543,'荷兰',45055,0,3,NULL),(544,'瑞士',45055,0,3,NULL),(545,'希腊',45055,0,3,NULL),(546,'挪威',45055,0,3,NULL),(547,'瑞典',45055,0,3,NULL),(548,'丹麦',45055,0,3,NULL),(549,'芬兰',45055,0,3,NULL),(550,'爱尔兰',45055,0,3,NULL),(551,'奥地利',45055,0,3,NULL),(552,'意大利',45055,0,3,NULL),(553,'乌克兰',45055,0,3,NULL),(554,'俄罗斯',45055,0,3,NULL),(555,'西班牙',45055,0,3,NULL),(556,'韩国',45055,0,3,NULL),(557,'新加坡',45055,0,3,NULL),(558,'马来西亚',45055,0,3,NULL),(559,'印度',45055,0,3,NULL),(560,'泰国',45055,0,3,NULL),(561,'日本',45055,0,3,NULL),(562,'巴西',45055,0,3,NULL),(563,'阿根廷',45055,0,3,NULL),(564,'南非',45055,0,3,NULL),(565,'埃及',45055,0,3,NULL),(566,'其他',36,0,3,NULL),(1126,'井陉县',73,0,3,NULL),(1127,'井陉矿区',73,0,3,NULL),(1128,'元氏县',73,0,3,NULL),(1129,'平山县',73,0,3,NULL),(1130,'新乐市',73,0,3,NULL),(1131,'新华区',73,0,3,NULL),(1132,'无极县',73,0,3,NULL),(1133,'晋州市',73,0,3,NULL),(1134,'栾城县',73,0,3,NULL),(1135,'桥东区',73,0,3,NULL),(1136,'桥西区',73,0,3,NULL),(1137,'正定县',73,0,3,NULL),(1138,'深泽县',73,0,3,NULL),(1139,'灵寿县',73,0,3,NULL),(1140,'藁城市',73,0,3,NULL),(1141,'行唐县',73,0,3,NULL),(1142,'裕华区',73,0,3,NULL),(1143,'赞皇县',73,0,3,NULL),(1144,'赵县',73,0,3,NULL),(1145,'辛集市',73,0,3,NULL),(1146,'长安区',73,0,3,NULL),(1147,'高邑县',73,0,3,NULL),(1148,'鹿泉市',73,0,3,NULL),(1149,'丰南区',74,0,3,NULL),(1150,'丰润区',74,0,3,NULL),(1151,'乐亭县',74,0,3,NULL),(1152,'古冶区',74,0,3,NULL),(1153,'唐海县',74,0,3,NULL),(1154,'开平区',74,0,3,NULL),(1155,'滦南县',74,0,3,NULL),(1156,'滦县',74,0,3,NULL),(1157,'玉田县',74,0,3,NULL),(1158,'路北区',74,0,3,NULL),(1159,'路南区',74,0,3,NULL),(1160,'迁安市',74,0,3,NULL),(1161,'迁西县',74,0,3,NULL),(1162,'遵化市',74,0,3,NULL),(1163,'北戴河区',75,0,3,NULL),(1164,'卢龙县',75,0,3,NULL),(1165,'山海关区',75,0,3,NULL),(1166,'抚宁县',75,0,3,NULL),(1167,'昌黎县',75,0,3,NULL),(1168,'海港区',75,0,3,NULL),(1169,'青龙满族自治县',75,0,3,NULL),(1170,'丛台区',76,0,3,NULL),(1171,'临漳县',76,0,3,NULL),(1172,'复兴区',76,0,3,NULL),(1173,'大名县',76,0,3,NULL),(1174,'峰峰矿区',76,0,3,NULL),(1175,'广平县',76,0,3,NULL),(1176,'成安县',76,0,3,NULL),(1177,'曲周县',76,0,3,NULL),(1178,'武安市',76,0,3,NULL),(1179,'永年县',76,0,3,NULL),(1180,'涉县',76,0,3,NULL),(1181,'磁县',76,0,3,NULL),(1182,'肥乡县',76,0,3,NULL),(1183,'邯山区',76,0,3,NULL),(1184,'邯郸县',76,0,3,NULL),(1185,'邱县',76,0,3,NULL),(1186,'馆陶县',76,0,3,NULL),(1187,'魏县',76,0,3,NULL),(1188,'鸡泽县',76,0,3,NULL),(1189,'临城县',77,0,3,NULL),(1190,'临西县',77,0,3,NULL),(1191,'任县',77,0,3,NULL),(1192,'内丘县',77,0,3,NULL),(1193,'南和县',77,0,3,NULL),(1194,'南宫市',77,0,3,NULL),(1195,'威县',77,0,3,NULL),(1196,'宁晋县',77,0,3,NULL),(1197,'巨鹿县',77,0,3,NULL),(1198,'平乡县',77,0,3,NULL),(1199,'广宗县',77,0,3,NULL),(1200,'新河县',77,0,3,NULL),(1201,'柏乡县',77,0,3,NULL),(1202,'桥东区',77,0,3,NULL),(1203,'桥西区',77,0,3,NULL),(1204,'沙河市',77,0,3,NULL),(1205,'清河县',77,0,3,NULL),(1206,'邢台县',77,0,3,NULL),(1207,'隆尧县',77,0,3,NULL),(1208,'北市区',78,0,3,NULL),(1209,'南市区',78,0,3,NULL),(1210,'博野县',78,0,3,NULL),(1211,'唐县',78,0,3,NULL),(1212,'安国市',78,0,3,NULL),(1213,'安新县',78,0,3,NULL),(1214,'定兴县',78,0,3,NULL),(1215,'定州市',78,0,3,NULL),(1216,'容城县',78,0,3,NULL),(1217,'徐水县',78,0,3,NULL),(1218,'新市区',78,0,3,NULL),(1219,'易县',78,0,3,NULL),(1220,'曲阳县',78,0,3,NULL),(1221,'望都县',78,0,3,NULL),(1222,'涞水县',78,0,3,NULL),(1223,'涞源县',78,0,3,NULL),(1224,'涿州市',78,0,3,NULL),(1225,'清苑县',78,0,3,NULL),(1226,'满城县',78,0,3,NULL),(1227,'蠡县',78,0,3,NULL),(1228,'阜平县',78,0,3,NULL),(1229,'雄县',78,0,3,NULL),(1230,'顺平县',78,0,3,NULL),(1231,'高碑店市',78,0,3,NULL),(1232,'高阳县',78,0,3,NULL),(1233,'万全县',79,0,3,NULL),(1234,'下花园区',79,0,3,NULL),(1235,'宣化区',79,0,3,NULL),(1236,'宣化县',79,0,3,NULL),(1237,'尚义县',79,0,3,NULL),(1238,'崇礼县',79,0,3,NULL),(1239,'康保县',79,0,3,NULL),(1240,'张北县',79,0,3,NULL),(1241,'怀安县',79,0,3,NULL),(1242,'怀来县',79,0,3,NULL),(1243,'桥东区',79,0,3,NULL),(1244,'桥西区',79,0,3,NULL),(1245,'沽源县',79,0,3,NULL),(1246,'涿鹿县',79,0,3,NULL),(1247,'蔚县',79,0,3,NULL),(1248,'赤城县',79,0,3,NULL),(1249,'阳原县',79,0,3,NULL),(1250,'丰宁满族自治县',80,0,3,NULL),(1251,'兴隆县',80,0,3,NULL),(1252,'双桥区',80,0,3,NULL),(1253,'双滦区',80,0,3,NULL),(1254,'围场满族蒙古族自治县',80,0,3,NULL),(1255,'宽城满族自治县',80,0,3,NULL),(1256,'平泉县',80,0,3,NULL),(1257,'承德县',80,0,3,NULL),(1258,'滦平县',80,0,3,NULL),(1259,'隆化县',80,0,3,NULL),(1260,'鹰手营子矿区',80,0,3,NULL),(1261,'冀州市',81,0,3,NULL),(1262,'安平县',81,0,3,NULL),(1263,'故城县',81,0,3,NULL),(1264,'景县',81,0,3,NULL),(1265,'枣强县',81,0,3,NULL),(1266,'桃城区',81,0,3,NULL),(1267,'武强县',81,0,3,NULL),(1268,'武邑县',81,0,3,NULL),(1269,'深州市',81,0,3,NULL),(1270,'阜城县',81,0,3,NULL),(1271,'饶阳县',81,0,3,NULL),(1272,'三河市',82,0,3,NULL),(1273,'固安县',82,0,3,NULL),(1274,'大厂回族自治县',82,0,3,NULL),(1275,'大城县',82,0,3,NULL),(1276,'安次区',82,0,3,NULL),(1277,'广阳区',82,0,3,NULL),(1278,'文安县',82,0,3,NULL),(1279,'永清县',82,0,3,NULL),(1280,'霸州市',82,0,3,NULL),(1281,'香河县',82,0,3,NULL),(1282,'东光县',83,0,3,NULL),(1283,'任丘市',83,0,3,NULL),(1284,'南皮县',83,0,3,NULL),(1285,'吴桥县',83,0,3,NULL),(1286,'孟村回族自治县',83,0,3,NULL),(1287,'新华区',83,0,3,NULL),(1288,'沧县',83,0,3,NULL),(1289,'河间市',83,0,3,NULL),(1290,'泊头市',83,0,3,NULL),(1291,'海兴县',83,0,3,NULL),(1292,'献县',83,0,3,NULL),(1293,'盐山县',83,0,3,NULL),(1294,'肃宁县',83,0,3,NULL),(1295,'运河区',83,0,3,NULL),(1296,'青县',83,0,3,NULL),(1297,'黄骅市',83,0,3,NULL),(1298,'万柏林区',84,0,3,NULL),(1299,'古交市',84,0,3,NULL),(1300,'娄烦县',84,0,3,NULL),(1301,'小店区',84,0,3,NULL),(1302,'尖草坪区',84,0,3,NULL),(1303,'晋源区',84,0,3,NULL),(1304,'杏花岭区',84,0,3,NULL),(1305,'清徐县',84,0,3,NULL),(1306,'迎泽区',84,0,3,NULL),(1307,'阳曲县',84,0,3,NULL),(1308,'南郊区',85,0,3,NULL),(1309,'城区',85,0,3,NULL),(1310,'大同县',85,0,3,NULL),(1311,'天镇县',85,0,3,NULL),(1312,'左云县',85,0,3,NULL),(1313,'广灵县',85,0,3,NULL),(1314,'新荣区',85,0,3,NULL),(1315,'浑源县',85,0,3,NULL),(1316,'灵丘县',85,0,3,NULL),(1317,'矿区',85,0,3,NULL),(1318,'阳高县',85,0,3,NULL),(1319,'城区',86,0,3,NULL),(1320,'平定县',86,0,3,NULL),(1321,'盂县',86,0,3,NULL),(1322,'矿区',86,0,3,NULL),(1323,'郊区',86,0,3,NULL),(1324,'城区',87,0,3,NULL),(1325,'壶关县',87,0,3,NULL),(1326,'屯留县',87,0,3,NULL),(1327,'平顺县',87,0,3,NULL),(1328,'武乡县',87,0,3,NULL),(1329,'沁县',87,0,3,NULL),(1330,'沁源县',87,0,3,NULL),(1331,'潞城市',87,0,3,NULL),(1332,'襄垣县',87,0,3,NULL),(1333,'郊区',87,0,3,NULL),(1334,'长子县',87,0,3,NULL),(1335,'长治县',87,0,3,NULL),(1336,'黎城县',87,0,3,NULL),(1337,'城区',88,0,3,NULL),(1338,'沁水县',88,0,3,NULL),(1339,'泽州县',88,0,3,NULL),(1340,'阳城县',88,0,3,NULL),(1341,'陵川县',88,0,3,NULL),(1342,'高平市',88,0,3,NULL),(1343,'右玉县',89,0,3,NULL),(1344,'山阴县',89,0,3,NULL),(1345,'平鲁区',89,0,3,NULL),(1346,'应县',89,0,3,NULL),(1347,'怀仁县',89,0,3,NULL),(1348,'朔城区',89,0,3,NULL),(1349,'介休市',90,0,3,NULL),(1350,'和顺县',90,0,3,NULL),(1351,'太谷县',90,0,3,NULL),(1352,'寿阳县',90,0,3,NULL),(1353,'左权县',90,0,3,NULL),(1354,'平遥县',90,0,3,NULL),(1355,'昔阳县',90,0,3,NULL),(1356,'榆次区',90,0,3,NULL),(1357,'榆社县',90,0,3,NULL),(1358,'灵石县',90,0,3,NULL),(1359,'祁县',90,0,3,NULL),(1360,'万荣县',91,0,3,NULL),(1361,'临猗县',91,0,3,NULL),(1362,'垣曲县',91,0,3,NULL),(1363,'夏县',91,0,3,NULL),(1364,'平陆县',91,0,3,NULL),(1365,'新绛县',91,0,3,NULL),(1366,'永济市',91,0,3,NULL),(1367,'河津市',91,0,3,NULL),(1368,'盐湖区',91,0,3,NULL),(1369,'稷山县',91,0,3,NULL),(1370,'绛县',91,0,3,NULL),(1371,'芮城县',91,0,3,NULL),(1372,'闻喜县',91,0,3,NULL),(1373,'五台县',92,0,3,NULL),(1374,'五寨县',92,0,3,NULL),(1375,'代县',92,0,3,NULL),(1376,'保德县',92,0,3,NULL),(1377,'偏关县',92,0,3,NULL),(1378,'原平市',92,0,3,NULL),(1379,'宁武县',92,0,3,NULL),(1380,'定襄县',92,0,3,NULL),(1381,'岢岚县',92,0,3,NULL),(1382,'忻府区',92,0,3,NULL),(1383,'河曲县',92,0,3,NULL),(1384,'神池县',92,0,3,NULL),(1385,'繁峙县',92,0,3,NULL),(1386,'静乐县',92,0,3,NULL),(1387,'乡宁县',93,0,3,NULL),(1388,'侯马市',93,0,3,NULL),(1389,'古县',93,0,3,NULL),(1390,'吉县',93,0,3,NULL),(1391,'大宁县',93,0,3,NULL),(1392,'安泽县',93,0,3,NULL),(1393,'尧都区',93,0,3,NULL),(1394,'曲沃县',93,0,3,NULL),(1395,'永和县',93,0,3,NULL),(1396,'汾西县',93,0,3,NULL),(1397,'洪洞县',93,0,3,NULL),(1398,'浮山县',93,0,3,NULL),(1399,'翼城县',93,0,3,NULL),(1400,'蒲县',93,0,3,NULL),(1401,'襄汾县',93,0,3,NULL),(1402,'隰县',93,0,3,NULL),(1403,'霍州市',93,0,3,NULL),(1404,'中阳县',94,0,3,NULL),(1405,'临县',94,0,3,NULL),(1406,'交口县',94,0,3,NULL),(1407,'交城县',94,0,3,NULL),(1408,'兴县',94,0,3,NULL),(1409,'孝义市',94,0,3,NULL),(1410,'岚县',94,0,3,NULL),(1411,'文水县',94,0,3,NULL),(1412,'方山县',94,0,3,NULL),(1413,'柳林县',94,0,3,NULL),(1414,'汾阳市',94,0,3,NULL),(1415,'石楼县',94,0,3,NULL),(1416,'离石区',94,0,3,NULL),(1417,'和林格尔县',95,0,3,NULL),(1418,'回民区',95,0,3,NULL),(1419,'土默特左旗',95,0,3,NULL),(1420,'托克托县',95,0,3,NULL),(1421,'新城区',95,0,3,NULL),(1422,'武川县',95,0,3,NULL),(1423,'清水河县',95,0,3,NULL),(1424,'玉泉区',95,0,3,NULL),(1425,'赛罕区',95,0,3,NULL),(1426,'东河区',96,0,3,NULL),(1427,'九原区',96,0,3,NULL),(1428,'固阳县',96,0,3,NULL),(1429,'土默特右旗',96,0,3,NULL),(1430,'昆都仑区',96,0,3,NULL),(1431,'白云矿区',96,0,3,NULL),(1432,'石拐区',96,0,3,NULL),(1433,'达尔罕茂明安联合旗',96,0,3,NULL),(1434,'青山区',96,0,3,NULL),(1435,'乌达区',97,0,3,NULL),(1436,'海勃湾区',97,0,3,NULL),(1437,'海南区',97,0,3,NULL),(1438,'元宝山区',98,0,3,NULL),(1439,'克什克腾旗',98,0,3,NULL),(1440,'喀喇沁旗',98,0,3,NULL),(1441,'宁城县',98,0,3,NULL),(1442,'巴林右旗',98,0,3,NULL),(1443,'巴林左旗',98,0,3,NULL),(1444,'敖汉旗',98,0,3,NULL),(1445,'松山区',98,0,3,NULL),(1446,'林西县',98,0,3,NULL),(1447,'红山区',98,0,3,NULL),(1448,'翁牛特旗',98,0,3,NULL),(1449,'阿鲁科尔沁旗',98,0,3,NULL),(1450,'奈曼旗',99,0,3,NULL),(1451,'库伦旗',99,0,3,NULL),(1452,'开鲁县',99,0,3,NULL),(1453,'扎鲁特旗',99,0,3,NULL),(1454,'科尔沁区',99,0,3,NULL),(1455,'科尔沁左翼中旗',99,0,3,NULL),(1456,'科尔沁左翼后旗',99,0,3,NULL),(1457,'霍林郭勒市',99,0,3,NULL),(1458,'东胜区',100,0,3,NULL),(1459,'乌审旗',100,0,3,NULL),(1460,'伊金霍洛旗',100,0,3,NULL),(1461,'准格尔旗',100,0,3,NULL),(1462,'杭锦旗',100,0,3,NULL),(1463,'达拉特旗',100,0,3,NULL),(1464,'鄂东胜区',100,0,3,NULL),(1465,'鄂托克前旗',100,0,3,NULL),(1466,'鄂托克旗',100,0,3,NULL),(1467,'扎兰屯市',101,0,3,NULL),(1468,'新巴尔虎右旗',101,0,3,NULL),(1469,'新巴尔虎左旗',101,0,3,NULL),(1470,'根河市',101,0,3,NULL),(1471,'海拉尔区',101,0,3,NULL),(1472,'满洲里市',101,0,3,NULL),(1473,'牙克石市',101,0,3,NULL),(1474,'莫力达瓦达斡尔族自治旗',101,0,3,NULL),(1475,'鄂伦春自治旗',101,0,3,NULL),(1476,'鄂温克族自治旗',101,0,3,NULL),(1477,'阿荣旗',101,0,3,NULL),(1478,'陈巴尔虎旗',101,0,3,NULL),(1479,'额尔古纳市',101,0,3,NULL),(1480,'临河区',102,0,3,NULL),(1481,'乌拉特中旗',102,0,3,NULL),(1482,'乌拉特前旗',102,0,3,NULL),(1483,'乌拉特后旗',102,0,3,NULL),(1484,'五原县',102,0,3,NULL),(1485,'杭锦后旗',102,0,3,NULL),(1486,'磴口县',102,0,3,NULL),(1487,'丰镇市',103,0,3,NULL),(1488,'兴和县',103,0,3,NULL),(1489,'凉城县',103,0,3,NULL),(1490,'化德县',103,0,3,NULL),(1491,'卓资县',103,0,3,NULL),(1492,'商都县',103,0,3,NULL),(1493,'四子王旗',103,0,3,NULL),(1494,'察哈尔右翼中旗',103,0,3,NULL),(1495,'察哈尔右翼前旗',103,0,3,NULL),(1496,'察哈尔右翼后旗',103,0,3,NULL),(1497,'集宁区',103,0,3,NULL),(1498,'乌兰浩特市',104,0,3,NULL),(1499,'扎赉特旗',104,0,3,NULL),(1500,'科尔沁右翼中旗',104,0,3,NULL),(1501,'科尔沁右翼前旗',104,0,3,NULL),(1502,'突泉县',104,0,3,NULL),(1503,'阿尔山市',104,0,3,NULL),(1504,'东乌珠穆沁旗',105,0,3,NULL),(1505,'二连浩特市',105,0,3,NULL),(1506,'多伦县',105,0,3,NULL),(1507,'太仆寺旗',105,0,3,NULL),(1508,'正蓝旗',105,0,3,NULL),(1509,'正镶白旗',105,0,3,NULL),(1510,'苏尼特右旗',105,0,3,NULL),(1511,'苏尼特左旗',105,0,3,NULL),(1512,'西乌珠穆沁旗',105,0,3,NULL),(1513,'锡林浩特市',105,0,3,NULL),(1514,'镶黄旗',105,0,3,NULL),(1515,'阿巴嘎旗',105,0,3,NULL),(1516,'阿拉善右旗',106,0,3,NULL),(1517,'阿拉善左旗',106,0,3,NULL),(1518,'额济纳旗',106,0,3,NULL),(1519,'东陵区',107,0,3,NULL),(1520,'于洪区',107,0,3,NULL),(1521,'和平区',107,0,3,NULL),(1522,'大东区',107,0,3,NULL),(1523,'康平县',107,0,3,NULL),(1524,'新民市',107,0,3,NULL),(1525,'沈北新区',107,0,3,NULL),(1526,'沈河区',107,0,3,NULL),(1527,'法库县',107,0,3,NULL),(1528,'皇姑区',107,0,3,NULL),(1529,'苏家屯区',107,0,3,NULL),(1530,'辽中县',107,0,3,NULL),(1531,'铁西区',107,0,3,NULL),(1532,'中山区',108,0,3,NULL),(1533,'庄河市',108,0,3,NULL),(1534,'旅顺口区',108,0,3,NULL),(1535,'普兰店市',108,0,3,NULL),(1536,'沙河口区',108,0,3,NULL),(1537,'瓦房店市',108,0,3,NULL),(1538,'甘井子区',108,0,3,NULL),(1539,'西岗区',108,0,3,NULL),(1540,'金州区',108,0,3,NULL),(1541,'长海县',108,0,3,NULL),(1542,'千山区',109,0,3,NULL),(1543,'台安县',109,0,3,NULL),(1544,'岫岩满族自治县',109,0,3,NULL),(1545,'海城市',109,0,3,NULL),(1546,'立山区',109,0,3,NULL),(1547,'铁东区',109,0,3,NULL),(1548,'铁西区',109,0,3,NULL),(1549,'东洲区',110,0,3,NULL),(1550,'抚顺县',110,0,3,NULL),(1551,'新宾满族自治县',110,0,3,NULL),(1552,'新抚区',110,0,3,NULL),(1553,'望花区',110,0,3,NULL),(1554,'清原满族自治县',110,0,3,NULL),(1555,'顺城区',110,0,3,NULL),(1556,'南芬区',111,0,3,NULL),(1557,'平山区',111,0,3,NULL),(1558,'明山区',111,0,3,NULL),(1559,'本溪满族自治县',111,0,3,NULL),(1560,'桓仁满族自治县',111,0,3,NULL),(1561,'溪湖区',111,0,3,NULL),(1562,'东港市',112,0,3,NULL),(1563,'元宝区',112,0,3,NULL),(1564,'凤城市',112,0,3,NULL),(1565,'宽甸满族自治县',112,0,3,NULL),(1566,'振兴区',112,0,3,NULL),(1567,'振安区',112,0,3,NULL),(1568,'义县',113,0,3,NULL),(1569,'凌河区',113,0,3,NULL),(1570,'凌海市',113,0,3,NULL),(1571,'北镇市',113,0,3,NULL),(1572,'古塔区',113,0,3,NULL),(1573,'太和区',113,0,3,NULL),(1574,'黑山县',113,0,3,NULL),(1575,'大石桥市',114,0,3,NULL),(1576,'盖州市',114,0,3,NULL),(1577,'站前区',114,0,3,NULL),(1578,'老边区',114,0,3,NULL),(1579,'西市区',114,0,3,NULL),(1580,'鲅鱼圈区',114,0,3,NULL),(1581,'太平区',115,0,3,NULL),(1582,'彰武县',115,0,3,NULL),(1583,'新邱区',115,0,3,NULL),(1584,'海州区',115,0,3,NULL),(1585,'清河门区',115,0,3,NULL),(1586,'细河区',115,0,3,NULL),(1587,'蒙古族自治县',115,0,3,NULL),(1588,'太子河区',116,0,3,NULL),(1589,'宏伟区',116,0,3,NULL),(1590,'弓长岭区',116,0,3,NULL),(1591,'文圣区',116,0,3,NULL),(1592,'灯塔市',116,0,3,NULL),(1593,'白塔区',116,0,3,NULL),(1594,'辽阳县',116,0,3,NULL),(1595,'兴隆台区',117,0,3,NULL),(1596,'双台子区',117,0,3,NULL),(1597,'大洼县',117,0,3,NULL),(1598,'盘山县',117,0,3,NULL),(1599,'开原市',118,0,3,NULL),(1600,'昌图县',118,0,3,NULL),(1601,'清河区',118,0,3,NULL),(1602,'西丰县',118,0,3,NULL),(1603,'调兵山市',118,0,3,NULL),(1604,'铁岭县',118,0,3,NULL),(1605,'银州区',118,0,3,NULL),(1606,'凌源市',119,0,3,NULL),(1607,'北票市',119,0,3,NULL),(1608,'双塔区',119,0,3,NULL),(1609,'喀喇沁左翼蒙古族自治县',119,0,3,NULL),(1610,'建平县',119,0,3,NULL),(1611,'朝阳县',119,0,3,NULL),(1612,'龙城区',119,0,3,NULL),(1613,'兴城市',120,0,3,NULL),(1614,'南票区',120,0,3,NULL),(1615,'建昌县',120,0,3,NULL),(1616,'绥中县',120,0,3,NULL),(1617,'连山区',120,0,3,NULL),(1618,'龙港区',120,0,3,NULL),(1619,'九台市',121,0,3,NULL),(1620,'二道区',121,0,3,NULL),(1621,'农安县',121,0,3,NULL),(1622,'南关区',121,0,3,NULL),(1623,'双阳区',121,0,3,NULL),(1624,'宽城区',121,0,3,NULL),(1625,'德惠市',121,0,3,NULL),(1626,'朝阳区',121,0,3,NULL),(1627,'榆树市',121,0,3,NULL),(1628,'绿园区',121,0,3,NULL),(1629,'丰满区',122,0,3,NULL),(1630,'昌邑区',122,0,3,NULL),(1631,'桦甸市',122,0,3,NULL),(1632,'永吉县',122,0,3,NULL),(1633,'磐石市',122,0,3,NULL),(1634,'舒兰市',122,0,3,NULL),(1635,'船营区',122,0,3,NULL),(1636,'蛟河市',122,0,3,NULL),(1637,'龙潭区',122,0,3,NULL),(1638,'伊通满族自治县',123,0,3,NULL),(1639,'公主岭市',123,0,3,NULL),(1640,'双辽市',123,0,3,NULL),(1641,'梨树县',123,0,3,NULL),(1642,'铁东区',123,0,3,NULL),(1643,'铁西区',123,0,3,NULL),(1644,'东丰县',124,0,3,NULL),(1645,'东辽县',124,0,3,NULL),(1646,'西安区',124,0,3,NULL),(1647,'龙山区',124,0,3,NULL),(1648,'东昌区',125,0,3,NULL),(1649,'二道江区',125,0,3,NULL),(1650,'柳河县',125,0,3,NULL),(1651,'梅河口市',125,0,3,NULL),(1652,'辉南县',125,0,3,NULL),(1653,'通化县',125,0,3,NULL),(1654,'集安市',125,0,3,NULL),(1655,'临江市',126,0,3,NULL),(1656,'八道江区',126,0,3,NULL),(1657,'抚松县',126,0,3,NULL),(1658,'江源区',126,0,3,NULL),(1659,'长白朝鲜族自治县',126,0,3,NULL),(1660,'靖宇县',126,0,3,NULL),(1661,'干安县',127,0,3,NULL),(1662,'前郭尔罗斯蒙古族自治县',127,0,3,NULL),(1663,'宁江区',127,0,3,NULL),(1664,'扶余县',127,0,3,NULL),(1665,'长岭县',127,0,3,NULL),(1666,'大安市',128,0,3,NULL),(1667,'洮北区',128,0,3,NULL),(1668,'洮南市',128,0,3,NULL),(1669,'通榆县',128,0,3,NULL),(1670,'镇赉县',128,0,3,NULL),(1671,'和龙市',129,0,3,NULL),(1672,'图们市',129,0,3,NULL),(1673,'安图县',129,0,3,NULL),(1674,'延吉市',129,0,3,NULL),(1675,'敦化市',129,0,3,NULL),(1676,'汪清县',129,0,3,NULL),(1677,'珲春市',129,0,3,NULL),(1678,'龙井市',129,0,3,NULL),(1679,'五常市',130,0,3,NULL),(1680,'依兰县',130,0,3,NULL),(1681,'南岗区',130,0,3,NULL),(1682,'双城市',130,0,3,NULL),(1683,'呼兰区',130,0,3,NULL),(1684,'哈尔滨市道里区',130,0,3,NULL),(1685,'宾县',130,0,3,NULL),(1686,'尚志市',130,0,3,NULL),(1687,'巴彦县',130,0,3,NULL),(1688,'平房区',130,0,3,NULL),(1689,'延寿县',130,0,3,NULL),(1690,'方正县',130,0,3,NULL),(1691,'木兰县',130,0,3,NULL),(1692,'松北区',130,0,3,NULL),(1693,'通河县',130,0,3,NULL),(1694,'道外区',130,0,3,NULL),(1695,'阿城区',130,0,3,NULL),(1696,'香坊区',130,0,3,NULL),(1697,'依安县',131,0,3,NULL),(1698,'克东县',131,0,3,NULL),(1699,'克山县',131,0,3,NULL),(1700,'富拉尔基区',131,0,3,NULL),(1701,'富裕县',131,0,3,NULL),(1702,'建华区',131,0,3,NULL),(1703,'拜泉县',131,0,3,NULL),(1704,'昂昂溪区',131,0,3,NULL),(1705,'梅里斯达斡尔族区',131,0,3,NULL),(1706,'泰来县',131,0,3,NULL),(1707,'甘南县',131,0,3,NULL),(1708,'碾子山区',131,0,3,NULL),(1709,'讷河市',131,0,3,NULL),(1710,'铁锋区',131,0,3,NULL),(1711,'龙江县',131,0,3,NULL),(1712,'龙沙区',131,0,3,NULL),(1713,'城子河区',132,0,3,NULL),(1714,'密山市',132,0,3,NULL),(1715,'恒山区',132,0,3,NULL),(1716,'梨树区',132,0,3,NULL),(1717,'滴道区',132,0,3,NULL),(1718,'虎林市',132,0,3,NULL),(1719,'鸡东县',132,0,3,NULL),(1720,'鸡冠区',132,0,3,NULL),(1721,'麻山区',132,0,3,NULL),(1722,'东山区',133,0,3,NULL),(1723,'兴安区',133,0,3,NULL),(1724,'兴山区',133,0,3,NULL),(1725,'南山区',133,0,3,NULL),(1726,'向阳区',133,0,3,NULL),(1727,'工农区',133,0,3,NULL),(1728,'绥滨县',133,0,3,NULL),(1729,'萝北县',133,0,3,NULL),(1730,'友谊县',134,0,3,NULL),(1731,'四方台区',134,0,3,NULL),(1732,'宝山区',134,0,3,NULL),(1733,'宝清县',134,0,3,NULL),(1734,'尖山区',134,0,3,NULL),(1735,'岭东区',134,0,3,NULL),(1736,'集贤县',134,0,3,NULL),(1737,'饶河县',134,0,3,NULL),(1738,'大同区',135,0,3,NULL),(1739,'杜尔伯特蒙古族自治县',135,0,3,NULL),(1740,'林甸县',135,0,3,NULL),(1741,'红岗区',135,0,3,NULL),(1742,'肇州县',135,0,3,NULL),(1743,'肇源县',135,0,3,NULL),(1744,'胡路区',135,0,3,NULL),(1745,'萨尔图区',135,0,3,NULL),(1746,'龙凤区',135,0,3,NULL),(1747,'上甘岭区',136,0,3,NULL),(1748,'乌伊岭区',136,0,3,NULL),(1749,'乌马河区',136,0,3,NULL),(1750,'五营区',136,0,3,NULL),(1751,'伊春区',136,0,3,NULL),(1752,'南岔区',136,0,3,NULL),(1753,'友好区',136,0,3,NULL),(1754,'嘉荫县',136,0,3,NULL),(1755,'带岭区',136,0,3,NULL),(1756,'新青区',136,0,3,NULL),(1757,'汤旺河区',136,0,3,NULL),(1758,'红星区',136,0,3,NULL),(1759,'美溪区',136,0,3,NULL),(1760,'翠峦区',136,0,3,NULL),(1761,'西林区',136,0,3,NULL),(1762,'金山屯区',136,0,3,NULL),(1763,'铁力市',136,0,3,NULL),(1764,'东风区',137,0,3,NULL),(1765,'前进区',137,0,3,NULL),(1766,'同江市',137,0,3,NULL),(1767,'向阳区',137,0,3,NULL),(1768,'富锦市',137,0,3,NULL),(1769,'抚远县',137,0,3,NULL),(1770,'桦南县',137,0,3,NULL),(1771,'桦川县',137,0,3,NULL),(1772,'汤原县',137,0,3,NULL),(1773,'郊区',137,0,3,NULL),(1774,'勃利县',138,0,3,NULL),(1775,'新兴区',138,0,3,NULL),(1776,'桃山区',138,0,3,NULL),(1777,'茄子河区',138,0,3,NULL),(1778,'东宁县',139,0,3,NULL),(1779,'东安区',139,0,3,NULL),(1780,'宁安市',139,0,3,NULL),(1781,'林口县',139,0,3,NULL),(1782,'海林市',139,0,3,NULL),(1783,'爱民区',139,0,3,NULL),(1784,'穆棱市',139,0,3,NULL),(1785,'绥芬河市',139,0,3,NULL),(1786,'西安区',139,0,3,NULL),(1787,'阳明区',139,0,3,NULL),(1788,'五大连池市',140,0,3,NULL),(1789,'北安市',140,0,3,NULL),(1790,'嫩江县',140,0,3,NULL),(1791,'孙吴县',140,0,3,NULL),(1792,'爱辉区',140,0,3,NULL),(1793,'车逊克县',140,0,3,NULL),(1794,'逊克县',140,0,3,NULL),(1795,'兰西县',141,0,3,NULL),(1796,'安达市',141,0,3,NULL),(1797,'庆安县',141,0,3,NULL),(1798,'明水县',141,0,3,NULL),(1799,'望奎县',141,0,3,NULL),(1800,'海伦市',141,0,3,NULL),(1801,'绥化市北林区',141,0,3,NULL),(1802,'绥棱县',141,0,3,NULL),(1803,'肇东市',141,0,3,NULL),(1804,'青冈县',141,0,3,NULL),(1805,'呼玛县',142,0,3,NULL),(1806,'塔河县',142,0,3,NULL),(1807,'大兴安岭地区加格达奇区',142,0,3,NULL),(1808,'大兴安岭地区呼中区',142,0,3,NULL),(1809,'大兴安岭地区新林区',142,0,3,NULL),(1810,'大兴安岭地区松岭区',142,0,3,NULL),(1811,'漠河县',142,0,3,NULL),(2027,'下关区',162,0,3,NULL),(2028,'六合区',162,0,3,NULL),(2029,'建邺区',162,0,3,NULL),(2030,'栖霞区',162,0,3,NULL),(2031,'江宁区',162,0,3,NULL),(2032,'浦口区',162,0,3,NULL),(2033,'溧水县',162,0,3,NULL),(2034,'玄武区',162,0,3,NULL),(2035,'白下区',162,0,3,NULL),(2036,'秦淮区',162,0,3,NULL),(2037,'雨花台区',162,0,3,NULL),(2038,'高淳县',162,0,3,NULL),(2039,'鼓楼区',162,0,3,NULL),(2040,'北塘区',163,0,3,NULL),(2041,'南长区',163,0,3,NULL),(2042,'宜兴市',163,0,3,NULL),(2043,'崇安区',163,0,3,NULL),(2044,'惠山区',163,0,3,NULL),(2045,'江阴市',163,0,3,NULL),(2046,'滨湖区',163,0,3,NULL),(2047,'锡山区',163,0,3,NULL),(2048,'丰县',164,0,3,NULL),(2049,'九里区',164,0,3,NULL),(2050,'云龙区',164,0,3,NULL),(2051,'新沂市',164,0,3,NULL),(2052,'沛县',164,0,3,NULL),(2053,'泉山区',164,0,3,NULL),(2054,'睢宁县',164,0,3,NULL),(2055,'贾汪区',164,0,3,NULL),(2056,'邳州市',164,0,3,NULL),(2057,'铜山县',164,0,3,NULL),(2058,'鼓楼区',164,0,3,NULL),(2059,'天宁区',165,0,3,NULL),(2060,'戚墅堰区',165,0,3,NULL),(2061,'新北区',165,0,3,NULL),(2062,'武进区',165,0,3,NULL),(2063,'溧阳市',165,0,3,NULL),(2064,'金坛市',165,0,3,NULL),(2065,'钟楼区',165,0,3,NULL),(2066,'吴中区',166,0,3,NULL),(2067,'吴江市',166,0,3,NULL),(2068,'太仓市',166,0,3,NULL),(2069,'常熟市',166,0,3,NULL),(2070,'平江区',166,0,3,NULL),(2071,'张家港市',166,0,3,NULL),(2072,'昆山市',166,0,3,NULL),(2073,'沧浪区',166,0,3,NULL),(2074,'相城区',166,0,3,NULL),(2075,'苏州工业园区',166,0,3,NULL),(2076,'虎丘区',166,0,3,NULL),(2077,'金阊区',166,0,3,NULL),(2078,'启东市',167,0,3,NULL),(2079,'如东县',167,0,3,NULL),(2080,'如皋市',167,0,3,NULL),(2081,'崇川区',167,0,3,NULL),(2082,'海安县',167,0,3,NULL),(2083,'海门市',167,0,3,NULL),(2084,'港闸区',167,0,3,NULL),(2085,'通州市',167,0,3,NULL),(2086,'东海县',168,0,3,NULL),(2087,'新浦区',168,0,3,NULL),(2088,'海州区',168,0,3,NULL),(2089,'灌云县',168,0,3,NULL),(2090,'灌南县',168,0,3,NULL),(2091,'赣榆县',168,0,3,NULL),(2092,'连云区',168,0,3,NULL),(2093,'楚州区',169,0,3,NULL),(2094,'洪泽县',169,0,3,NULL),(2095,'涟水县',169,0,3,NULL),(2096,'淮阴区',169,0,3,NULL),(2097,'清河区',169,0,3,NULL),(2098,'清浦区',169,0,3,NULL),(2099,'盱眙县',169,0,3,NULL),(2100,'金湖县',169,0,3,NULL),(2101,'东台市',170,0,3,NULL),(2102,'亭湖区',170,0,3,NULL),(2103,'响水县',170,0,3,NULL),(2104,'大丰市',170,0,3,NULL),(2105,'射阳县',170,0,3,NULL),(2106,'建湖县',170,0,3,NULL),(2107,'滨海县',170,0,3,NULL),(2108,'盐都区',170,0,3,NULL),(2109,'阜宁县',170,0,3,NULL),(2110,'仪征市',171,0,3,NULL),(2111,'宝应县',171,0,3,NULL),(2112,'广陵区',171,0,3,NULL),(2113,'江都市',171,0,3,NULL),(2114,'维扬区',171,0,3,NULL),(2115,'邗江区',171,0,3,NULL),(2116,'高邮市',171,0,3,NULL),(2117,'丹徒区',172,0,3,NULL),(2118,'丹阳市',172,0,3,NULL),(2119,'京口区',172,0,3,NULL),(2120,'句容市',172,0,3,NULL),(2121,'扬中市',172,0,3,NULL),(2122,'润州区',172,0,3,NULL),(2123,'兴化市',173,0,3,NULL),(2124,'姜堰市',173,0,3,NULL),(2125,'泰兴市',173,0,3,NULL),(2126,'海陵区',173,0,3,NULL),(2127,'靖江市',173,0,3,NULL),(2128,'高港区',173,0,3,NULL),(2129,'宿城区',174,0,3,NULL),(2130,'宿豫区',174,0,3,NULL),(2131,'沭阳县',174,0,3,NULL),(2132,'泗洪县',174,0,3,NULL),(2133,'泗阳县',174,0,3,NULL),(2134,'上城区',175,0,3,NULL),(2135,'下城区',175,0,3,NULL),(2136,'临安市',175,0,3,NULL),(2137,'余杭区',175,0,3,NULL),(2138,'富阳市',175,0,3,NULL),(2139,'建德市',175,0,3,NULL),(2140,'拱墅区',175,0,3,NULL),(2141,'桐庐县',175,0,3,NULL),(2142,'江干区',175,0,3,NULL),(2143,'淳安县',175,0,3,NULL),(2144,'滨江区',175,0,3,NULL),(2145,'萧山区',175,0,3,NULL),(2146,'西湖区',175,0,3,NULL),(2147,'余姚市',176,0,3,NULL),(2148,'北仑区',176,0,3,NULL),(2149,'奉化市',176,0,3,NULL),(2150,'宁海县',176,0,3,NULL),(2151,'慈溪市',176,0,3,NULL),(2152,'江东区',176,0,3,NULL),(2153,'江北区',176,0,3,NULL),(2154,'海曙区',176,0,3,NULL),(2155,'象山县',176,0,3,NULL),(2156,'鄞州区',176,0,3,NULL),(2157,'镇海区',176,0,3,NULL),(2158,'乐清市',177,0,3,NULL),(2159,'平阳县',177,0,3,NULL),(2160,'文成县',177,0,3,NULL),(2161,'永嘉县',177,0,3,NULL),(2162,'泰顺县',177,0,3,NULL),(2163,'洞头县',177,0,3,NULL),(2164,'瑞安市',177,0,3,NULL),(2165,'瓯海区',177,0,3,NULL),(2166,'苍南县',177,0,3,NULL),(2167,'鹿城区',177,0,3,NULL),(2168,'龙湾区',177,0,3,NULL),(2169,'南湖区',178,0,3,NULL),(2170,'嘉善县',178,0,3,NULL),(2171,'平湖市',178,0,3,NULL),(2172,'桐乡市',178,0,3,NULL),(2173,'海宁市',178,0,3,NULL),(2174,'海盐县',178,0,3,NULL),(2175,'秀洲区',178,0,3,NULL),(2176,'南浔区',179,0,3,NULL),(2177,'吴兴区',179,0,3,NULL),(2178,'安吉县',179,0,3,NULL),(2179,'德清县',179,0,3,NULL),(2180,'长兴县',179,0,3,NULL),(2181,'上虞市',180,0,3,NULL),(2182,'嵊州市',180,0,3,NULL),(2183,'新昌县',180,0,3,NULL),(2184,'绍兴县',180,0,3,NULL),(2185,'诸暨市',180,0,3,NULL),(2186,'越城区',180,0,3,NULL),(2187,'定海区',181,0,3,NULL),(2188,'岱山县',181,0,3,NULL),(2189,'嵊泗县',181,0,3,NULL),(2190,'普陀区',181,0,3,NULL),(2191,'常山县',182,0,3,NULL),(2192,'开化县',182,0,3,NULL),(2193,'柯城区',182,0,3,NULL),(2194,'江山市',182,0,3,NULL),(2195,'衢江区',182,0,3,NULL),(2196,'龙游县',182,0,3,NULL),(2197,'东阳市',183,0,3,NULL),(2198,'义乌市',183,0,3,NULL),(2199,'兰溪市',183,0,3,NULL),(2200,'婺城区',183,0,3,NULL),(2201,'武义县',183,0,3,NULL),(2202,'永康市',183,0,3,NULL),(2203,'浦江县',183,0,3,NULL),(2204,'磐安县',183,0,3,NULL),(2205,'金东区',183,0,3,NULL),(2206,'三门县',184,0,3,NULL),(2207,'临海市',184,0,3,NULL),(2208,'仙居县',184,0,3,NULL),(2209,'天台县',184,0,3,NULL),(2210,'椒江区',184,0,3,NULL),(2211,'温岭市',184,0,3,NULL),(2212,'玉环县',184,0,3,NULL),(2213,'路桥区',184,0,3,NULL),(2214,'黄岩区',184,0,3,NULL),(2215,'云和县',185,0,3,NULL),(2216,'庆元县',185,0,3,NULL),(2217,'景宁畲族自治县',185,0,3,NULL),(2218,'松阳县',185,0,3,NULL),(2219,'缙云县',185,0,3,NULL),(2220,'莲都区',185,0,3,NULL),(2221,'遂昌县',185,0,3,NULL),(2222,'青田县',185,0,3,NULL),(2223,'龙泉市',185,0,3,NULL),(2224,'包河区',186,0,3,NULL),(2225,'庐阳区',186,0,3,NULL),(2226,'瑶海区',186,0,3,NULL),(2227,'肥东县',186,0,3,NULL),(2228,'肥西县',186,0,3,NULL),(2229,'蜀山区',186,0,3,NULL),(2230,'长丰县',186,0,3,NULL),(2231,'三山区',187,0,3,NULL),(2232,'南陵县',187,0,3,NULL),(2233,'弋江区',187,0,3,NULL),(2234,'繁昌县',187,0,3,NULL),(2235,'芜湖县',187,0,3,NULL),(2236,'镜湖区',187,0,3,NULL),(2237,'鸠江区',187,0,3,NULL),(2238,'五河县',188,0,3,NULL),(2239,'固镇县',188,0,3,NULL),(2240,'怀远县',188,0,3,NULL),(2241,'淮上区',188,0,3,NULL),(2242,'禹会区',188,0,3,NULL),(2243,'蚌山区',188,0,3,NULL),(2244,'龙子湖区',188,0,3,NULL),(2245,'八公山区',189,0,3,NULL),(2246,'凤台县',189,0,3,NULL),(2247,'大通区',189,0,3,NULL),(2248,'潘集区',189,0,3,NULL),(2249,'田家庵区',189,0,3,NULL),(2250,'谢家集区',189,0,3,NULL),(2251,'当涂县',190,0,3,NULL),(2252,'花山区',190,0,3,NULL),(2253,'金家庄区',190,0,3,NULL),(2254,'雨山区',190,0,3,NULL),(2255,'杜集区',191,0,3,NULL),(2256,'濉溪县',191,0,3,NULL),(2257,'烈山区',191,0,3,NULL),(2258,'相山区',191,0,3,NULL),(2259,'狮子山区',192,0,3,NULL),(2260,'郊区',192,0,3,NULL),(2261,'铜官山区',192,0,3,NULL),(2262,'铜陵县',192,0,3,NULL),(2263,'大观区',193,0,3,NULL),(2264,'太湖县',193,0,3,NULL),(2265,'宜秀区',193,0,3,NULL),(2266,'宿松县',193,0,3,NULL),(2267,'岳西县',193,0,3,NULL),(2268,'怀宁县',193,0,3,NULL),(2269,'望江县',193,0,3,NULL),(2270,'枞阳县',193,0,3,NULL),(2271,'桐城市',193,0,3,NULL),(2272,'潜山县',193,0,3,NULL),(2273,'迎江区',193,0,3,NULL),(2274,'休宁县',194,0,3,NULL),(2275,'屯溪区',194,0,3,NULL),(2276,'徽州区',194,0,3,NULL),(2277,'歙县',194,0,3,NULL),(2278,'祁门县',194,0,3,NULL),(2279,'黄山区',194,0,3,NULL),(2280,'黟县',194,0,3,NULL),(2281,'全椒县',195,0,3,NULL),(2282,'凤阳县',195,0,3,NULL),(2283,'南谯区',195,0,3,NULL),(2284,'天长市',195,0,3,NULL),(2285,'定远县',195,0,3,NULL),(2286,'明光市',195,0,3,NULL),(2287,'来安县',195,0,3,NULL),(2288,'琅玡区',195,0,3,NULL),(2289,'临泉县',196,0,3,NULL),(2290,'太和县',196,0,3,NULL),(2291,'界首市',196,0,3,NULL),(2292,'阜南县',196,0,3,NULL),(2293,'颍东区',196,0,3,NULL),(2294,'颍州区',196,0,3,NULL),(2295,'颍泉区',196,0,3,NULL),(2296,'颖上县',196,0,3,NULL),(2297,'埇桥区',197,0,3,NULL),(2298,'泗县辖',197,0,3,NULL),(2299,'灵璧县',197,0,3,NULL),(2300,'砀山县',197,0,3,NULL),(2301,'萧县',197,0,3,NULL),(2302,'含山县',198,0,3,NULL),(2303,'和县',198,0,3,NULL),(2304,'居巢区',198,0,3,NULL),(2305,'庐江县',198,0,3,NULL),(2306,'无为县',198,0,3,NULL),(2307,'寿县',199,0,3,NULL),(2308,'舒城县',199,0,3,NULL),(2309,'裕安区',199,0,3,NULL),(2310,'金安区',199,0,3,NULL),(2311,'金寨县',199,0,3,NULL),(2312,'霍山县',199,0,3,NULL),(2313,'霍邱县',199,0,3,NULL),(2314,'利辛县',200,0,3,NULL),(2315,'涡阳县',200,0,3,NULL),(2316,'蒙城县',200,0,3,NULL),(2317,'谯城区',200,0,3,NULL),(2318,'东至县',201,0,3,NULL),(2319,'石台县',201,0,3,NULL),(2320,'贵池区',201,0,3,NULL),(2321,'青阳县',201,0,3,NULL),(2322,'宁国市',202,0,3,NULL),(2323,'宣州区',202,0,3,NULL),(2324,'广德县',202,0,3,NULL),(2325,'旌德县',202,0,3,NULL),(2326,'泾县',202,0,3,NULL),(2327,'绩溪县',202,0,3,NULL),(2328,'郎溪县',202,0,3,NULL),(2329,'仓山区',203,0,3,NULL),(2330,'台江区',203,0,3,NULL),(2331,'平潭县',203,0,3,NULL),(2332,'晋安区',203,0,3,NULL),(2333,'永泰县',203,0,3,NULL),(2334,'福清市',203,0,3,NULL),(2335,'罗源县',203,0,3,NULL),(2336,'连江县',203,0,3,NULL),(2337,'长乐市',203,0,3,NULL),(2338,'闽侯县',203,0,3,NULL),(2339,'闽清县',203,0,3,NULL),(2340,'马尾区',203,0,3,NULL),(2341,'鼓楼区',203,0,3,NULL),(2342,'同安区',204,0,3,NULL),(2343,'思明区',204,0,3,NULL),(2344,'海沧区',204,0,3,NULL),(2345,'湖里区',204,0,3,NULL),(2346,'翔安区',204,0,3,NULL),(2347,'集美区',204,0,3,NULL),(2348,'仙游县',205,0,3,NULL),(2349,'城厢区',205,0,3,NULL),(2350,'涵江区',205,0,3,NULL),(2351,'秀屿区',205,0,3,NULL),(2352,'荔城区',205,0,3,NULL),(2353,'三元区',206,0,3,NULL),(2354,'大田县',206,0,3,NULL),(2355,'宁化县',206,0,3,NULL),(2356,'将乐县',206,0,3,NULL),(2357,'尤溪县',206,0,3,NULL),(2358,'建宁县',206,0,3,NULL),(2359,'明溪县',206,0,3,NULL),(2360,'梅列区',206,0,3,NULL),(2361,'永安市',206,0,3,NULL),(2362,'沙县',206,0,3,NULL),(2363,'泰宁县',206,0,3,NULL),(2364,'清流县',206,0,3,NULL),(2365,'丰泽区',207,0,3,NULL),(2366,'南安市',207,0,3,NULL),(2367,'安溪县',207,0,3,NULL),(2368,'德化县',207,0,3,NULL),(2369,'惠安县',207,0,3,NULL),(2370,'晋江市',207,0,3,NULL),(2371,'永春县',207,0,3,NULL),(2372,'泉港区',207,0,3,NULL),(2373,'洛江区',207,0,3,NULL),(2374,'石狮市',207,0,3,NULL),(2375,'金门县',207,0,3,NULL),(2376,'鲤城区',207,0,3,NULL),(2377,'东山县',208,0,3,NULL),(2378,'云霄县',208,0,3,NULL),(2379,'华安县',208,0,3,NULL),(2380,'南靖县',208,0,3,NULL),(2381,'平和县',208,0,3,NULL),(2382,'漳浦县',208,0,3,NULL),(2383,'芗城区',208,0,3,NULL),(2384,'诏安县',208,0,3,NULL),(2385,'长泰县',208,0,3,NULL),(2386,'龙文区',208,0,3,NULL),(2387,'龙海市',208,0,3,NULL),(2388,'光泽县',209,0,3,NULL),(2389,'延平区',209,0,3,NULL),(2390,'建瓯市',209,0,3,NULL),(2391,'建阳市',209,0,3,NULL),(2392,'政和县',209,0,3,NULL),(2393,'松溪县',209,0,3,NULL),(2394,'武夷山市',209,0,3,NULL),(2395,'浦城县',209,0,3,NULL),(2396,'邵武市',209,0,3,NULL),(2397,'顺昌县',209,0,3,NULL),(2398,'上杭县',210,0,3,NULL),(2399,'新罗区',210,0,3,NULL),(2400,'武平县',210,0,3,NULL),(2401,'永定县',210,0,3,NULL),(2402,'漳平市',210,0,3,NULL),(2403,'连城县',210,0,3,NULL),(2404,'长汀县',210,0,3,NULL),(2405,'古田县',211,0,3,NULL),(2406,'周宁县',211,0,3,NULL),(2407,'寿宁县',211,0,3,NULL),(2408,'屏南县',211,0,3,NULL),(2409,'柘荣县',211,0,3,NULL),(2410,'福安市',211,0,3,NULL),(2411,'福鼎市',211,0,3,NULL),(2412,'蕉城区',211,0,3,NULL),(2413,'霞浦县',211,0,3,NULL),(2414,'东湖区',212,0,3,NULL),(2415,'南昌县',212,0,3,NULL),(2416,'安义县',212,0,3,NULL),(2417,'新建县',212,0,3,NULL),(2418,'湾里区',212,0,3,NULL),(2419,'西湖区',212,0,3,NULL),(2420,'进贤县',212,0,3,NULL),(2421,'青云谱区',212,0,3,NULL),(2422,'青山湖区',212,0,3,NULL),(2423,'乐平市',213,0,3,NULL),(2424,'昌江区',213,0,3,NULL),(2425,'浮梁县',213,0,3,NULL),(2426,'珠山区',213,0,3,NULL),(2427,'上栗县',214,0,3,NULL),(2428,'安源区',214,0,3,NULL),(2429,'湘东区',214,0,3,NULL),(2430,'芦溪县',214,0,3,NULL),(2431,'莲花县',214,0,3,NULL),(2432,'九江县',215,0,3,NULL),(2433,'修水县',215,0,3,NULL),(2434,'庐山区',215,0,3,NULL),(2435,'彭泽县',215,0,3,NULL),(2436,'德安县',215,0,3,NULL),(2437,'星子县',215,0,3,NULL),(2438,'武宁县',215,0,3,NULL),(2439,'永修县',215,0,3,NULL),(2440,'浔阳区',215,0,3,NULL),(2441,'湖口县',215,0,3,NULL),(2442,'瑞昌市',215,0,3,NULL),(2443,'都昌县',215,0,3,NULL),(2444,'分宜县',216,0,3,NULL),(2445,'渝水区',216,0,3,NULL),(2446,'余江县',217,0,3,NULL),(2447,'月湖区',217,0,3,NULL),(2448,'贵溪市',217,0,3,NULL),(2449,'上犹县',218,0,3,NULL),(2450,'于都县',218,0,3,NULL),(2451,'会昌县',218,0,3,NULL),(2452,'信丰县',218,0,3,NULL),(2453,'全南县',218,0,3,NULL),(2454,'兴国县',218,0,3,NULL),(2455,'南康市',218,0,3,NULL),(2456,'大余县',218,0,3,NULL),(2457,'宁都县',218,0,3,NULL),(2458,'安远县',218,0,3,NULL),(2459,'定南县',218,0,3,NULL),(2460,'寻乌县',218,0,3,NULL),(2461,'崇义县',218,0,3,NULL),(2462,'瑞金市',218,0,3,NULL),(2463,'石城县',218,0,3,NULL),(2464,'章贡区',218,0,3,NULL),(2465,'赣县',218,0,3,NULL),(2466,'龙南县',218,0,3,NULL),(2467,'万安县',219,0,3,NULL),(2468,'井冈山市',219,0,3,NULL),(2469,'吉安县',219,0,3,NULL),(2470,'吉州区',219,0,3,NULL),(2471,'吉水县',219,0,3,NULL),(2472,'安福县',219,0,3,NULL),(2473,'峡江县',219,0,3,NULL),(2474,'新干县',219,0,3,NULL),(2475,'永丰县',219,0,3,NULL),(2476,'永新县',219,0,3,NULL),(2477,'泰和县',219,0,3,NULL),(2478,'遂川县',219,0,3,NULL),(2479,'青原区',219,0,3,NULL),(2480,'万载县',220,0,3,NULL),(2481,'上高县',220,0,3,NULL),(2482,'丰城市',220,0,3,NULL),(2483,'奉新县',220,0,3,NULL),(2484,'宜丰县',220,0,3,NULL),(2485,'樟树市',220,0,3,NULL),(2486,'袁州区',220,0,3,NULL),(2487,'铜鼓县',220,0,3,NULL),(2488,'靖安县',220,0,3,NULL),(2489,'高安市',220,0,3,NULL),(2490,'东乡县',221,0,3,NULL),(2491,'临川区',221,0,3,NULL),(2492,'乐安县',221,0,3,NULL),(2493,'南丰县',221,0,3,NULL),(2494,'南城县',221,0,3,NULL),(2495,'宜黄县',221,0,3,NULL),(2496,'崇仁县',221,0,3,NULL),(2497,'广昌县',221,0,3,NULL),(2498,'资溪县',221,0,3,NULL),(2499,'金溪县',221,0,3,NULL),(2500,'黎川县',221,0,3,NULL),(2501,'万年县',222,0,3,NULL),(2502,'上饶县',222,0,3,NULL),(2503,'余干县',222,0,3,NULL),(2504,'信州区',222,0,3,NULL),(2505,'婺源县',222,0,3,NULL),(2506,'广丰县',222,0,3,NULL),(2507,'弋阳县',222,0,3,NULL),(2508,'德兴市',222,0,3,NULL),(2509,'横峰县',222,0,3,NULL),(2510,'玉山县',222,0,3,NULL),(2511,'鄱阳县',222,0,3,NULL),(2512,'铅山县',222,0,3,NULL),(2513,'历下区',223,0,3,NULL),(2514,'历城区',223,0,3,NULL),(2515,'商河县',223,0,3,NULL),(2516,'天桥区',223,0,3,NULL),(2517,'市中区',223,0,3,NULL),(2518,'平阴县',223,0,3,NULL),(2519,'槐荫区',223,0,3,NULL),(2520,'济阳县',223,0,3,NULL),(2521,'章丘市',223,0,3,NULL),(2522,'长清区',223,0,3,NULL),(2523,'即墨市',224,0,3,NULL),(2524,'四方区',224,0,3,NULL),(2525,'城阳区',224,0,3,NULL),(2526,'崂山区',224,0,3,NULL),(2527,'市北区',224,0,3,NULL),(2528,'市南区',224,0,3,NULL),(2529,'平度市',224,0,3,NULL),(2530,'李沧区',224,0,3,NULL),(2531,'胶南市',224,0,3,NULL),(2532,'胶州市',224,0,3,NULL),(2533,'莱西市',224,0,3,NULL),(2534,'黄岛区',224,0,3,NULL),(2535,'临淄区',225,0,3,NULL),(2536,'博山区',225,0,3,NULL),(2537,'周村区',225,0,3,NULL),(2538,'张店区',225,0,3,NULL),(2539,'桓台县',225,0,3,NULL),(2540,'沂源县',225,0,3,NULL),(2541,'淄川区',225,0,3,NULL),(2542,'高青县',225,0,3,NULL),(2543,'台儿庄区',226,0,3,NULL),(2544,'山亭区',226,0,3,NULL),(2545,'峄城区',226,0,3,NULL),(2546,'市中区',226,0,3,NULL),(2547,'滕州市',226,0,3,NULL),(2548,'薛城区',226,0,3,NULL),(2549,'东营区',227,0,3,NULL),(2550,'利津县',227,0,3,NULL),(2551,'垦利县',227,0,3,NULL),(2552,'广饶县',227,0,3,NULL),(2553,'河口区',227,0,3,NULL),(2554,'招远市',228,0,3,NULL),(2555,'栖霞市',228,0,3,NULL),(2556,'海阳市',228,0,3,NULL),(2557,'牟平区',228,0,3,NULL),(2558,'福山区',228,0,3,NULL),(2559,'芝罘区',228,0,3,NULL),(2560,'莱山区',228,0,3,NULL),(2561,'莱州市',228,0,3,NULL),(2562,'莱阳市',228,0,3,NULL),(2563,'蓬莱市',228,0,3,NULL),(2564,'长岛县',228,0,3,NULL),(2565,'龙口市',228,0,3,NULL),(2566,'临朐县',229,0,3,NULL),(2567,'坊子区',229,0,3,NULL),(2568,'奎文区',229,0,3,NULL),(2569,'安丘市',229,0,3,NULL),(2570,'寒亭区',229,0,3,NULL),(2571,'寿光市',229,0,3,NULL),(2572,'昌乐县',229,0,3,NULL),(2573,'昌邑市',229,0,3,NULL),(2574,'潍城区',229,0,3,NULL),(2575,'诸城市',229,0,3,NULL),(2576,'青州市',229,0,3,NULL),(2577,'高密市',229,0,3,NULL),(2578,'任城区',230,0,3,NULL),(2579,'兖州市',230,0,3,NULL),(2580,'嘉祥县',230,0,3,NULL),(2581,'市中区',230,0,3,NULL),(2582,'微山县',230,0,3,NULL),(2583,'曲阜市',230,0,3,NULL),(2584,'梁山县',230,0,3,NULL),(2585,'汶上县',230,0,3,NULL),(2586,'泗水县',230,0,3,NULL),(2587,'邹城市',230,0,3,NULL),(2588,'金乡县',230,0,3,NULL),(2589,'鱼台县',230,0,3,NULL),(2590,'东平县',231,0,3,NULL),(2591,'宁阳县',231,0,3,NULL),(2592,'岱岳区',231,0,3,NULL),(2593,'新泰市',231,0,3,NULL),(2594,'泰山区',231,0,3,NULL),(2595,'肥城市',231,0,3,NULL),(2596,'乳山市',232,0,3,NULL),(2597,'文登市',232,0,3,NULL),(2598,'环翠区',232,0,3,NULL),(2599,'荣成市',232,0,3,NULL),(2600,'东港区',233,0,3,NULL),(2601,'五莲县',233,0,3,NULL),(2602,'岚山区',233,0,3,NULL),(2603,'莒县',233,0,3,NULL),(2604,'莱城区',234,0,3,NULL),(2605,'钢城区',234,0,3,NULL),(2606,'临沭县',235,0,3,NULL),(2607,'兰山区',235,0,3,NULL),(2608,'平邑县',235,0,3,NULL),(2609,'沂南县',235,0,3,NULL),(2610,'沂水县',235,0,3,NULL),(2611,'河东区',235,0,3,NULL),(2612,'罗庄区',235,0,3,NULL),(2613,'苍山县',235,0,3,NULL),(2614,'莒南县',235,0,3,NULL),(2615,'蒙阴县',235,0,3,NULL),(2616,'费县',235,0,3,NULL),(2617,'郯城县',235,0,3,NULL),(2618,'临邑县',236,0,3,NULL),(2619,'乐陵市',236,0,3,NULL),(2620,'夏津县',236,0,3,NULL),(2621,'宁津县',236,0,3,NULL),(2622,'平原县',236,0,3,NULL),(2623,'庆云县',236,0,3,NULL),(2624,'德城区',236,0,3,NULL),(2625,'武城县',236,0,3,NULL),(2626,'禹城市',236,0,3,NULL),(2627,'陵县',236,0,3,NULL),(2628,'齐河县',236,0,3,NULL),(2629,'东昌府区',237,0,3,NULL),(2630,'东阿县',237,0,3,NULL),(2631,'临清市',237,0,3,NULL),(2632,'冠县',237,0,3,NULL),(2633,'茌平县',237,0,3,NULL),(2634,'莘县',237,0,3,NULL),(2635,'阳谷县',237,0,3,NULL),(2636,'高唐县',237,0,3,NULL),(2637,'博兴县',238,0,3,NULL),(2638,'惠民县',238,0,3,NULL),(2639,'无棣县',238,0,3,NULL),(2640,'沾化县',238,0,3,NULL),(2641,'滨城区',238,0,3,NULL),(2642,'邹平县',238,0,3,NULL),(2643,'阳信县',238,0,3,NULL),(2644,'东明县',239,0,3,NULL),(2645,'单县',239,0,3,NULL),(2646,'定陶县',239,0,3,NULL),(2647,'巨野县',239,0,3,NULL),(2648,'成武县',239,0,3,NULL),(2649,'曹县',239,0,3,NULL),(2650,'牡丹区',239,0,3,NULL),(2651,'郓城县',239,0,3,NULL),(2652,'鄄城县',239,0,3,NULL),(2653,'上街区',240,0,3,NULL),(2654,'中原区',240,0,3,NULL),(2655,'中牟县',240,0,3,NULL),(2656,'二七区',240,0,3,NULL),(2657,'巩义市',240,0,3,NULL),(2658,'惠济区',240,0,3,NULL),(2659,'新密市',240,0,3,NULL),(2660,'新郑市',240,0,3,NULL),(2661,'登封市',240,0,3,NULL),(2662,'管城回族区',240,0,3,NULL),(2663,'荥阳市',240,0,3,NULL),(2664,'金水区',240,0,3,NULL),(2665,'兰考县',241,0,3,NULL),(2666,'尉氏县',241,0,3,NULL),(2667,'开封县',241,0,3,NULL),(2668,'杞县',241,0,3,NULL),(2669,'禹王台区',241,0,3,NULL),(2670,'通许县',241,0,3,NULL),(2671,'金明区',241,0,3,NULL),(2672,'顺河回族区',241,0,3,NULL),(2673,'鼓楼区',241,0,3,NULL),(2674,'龙亭区',241,0,3,NULL),(2675,'伊川县',242,0,3,NULL),(2676,'偃师市',242,0,3,NULL),(2677,'吉利区',242,0,3,NULL),(2678,'孟津县',242,0,3,NULL),(2679,'宜阳县',242,0,3,NULL),(2680,'嵩县',242,0,3,NULL),(2681,'新安县',242,0,3,NULL),(2682,'栾川县',242,0,3,NULL),(2683,'汝阳县',242,0,3,NULL),(2684,'洛宁县',242,0,3,NULL),(2685,'洛龙区',242,0,3,NULL),(2686,'涧西区',242,0,3,NULL),(2687,'瀍河回族区',242,0,3,NULL),(2688,'老城区',242,0,3,NULL),(2689,'西工区',242,0,3,NULL),(2690,'卫东区',243,0,3,NULL),(2691,'叶县',243,0,3,NULL),(2692,'宝丰县',243,0,3,NULL),(2693,'新华区',243,0,3,NULL),(2694,'汝州市',243,0,3,NULL),(2695,'湛河区',243,0,3,NULL),(2696,'石龙区',243,0,3,NULL),(2697,'舞钢市',243,0,3,NULL),(2698,'郏县',243,0,3,NULL),(2699,'鲁山县',243,0,3,NULL),(2700,'内黄县',244,0,3,NULL),(2701,'北关区',244,0,3,NULL),(2702,'安阳县',244,0,3,NULL),(2703,'文峰区',244,0,3,NULL),(2704,'林州市',244,0,3,NULL),(2705,'殷都区',244,0,3,NULL),(2706,'汤阴县',244,0,3,NULL),(2707,'滑县',244,0,3,NULL),(2708,'龙安区',244,0,3,NULL),(2709,'山城区',245,0,3,NULL),(2710,'浚县',245,0,3,NULL),(2711,'淇县',245,0,3,NULL),(2712,'淇滨区',245,0,3,NULL),(2713,'鹤山区',245,0,3,NULL),(2714,'凤泉区',246,0,3,NULL),(2715,'卫滨区',246,0,3,NULL),(2716,'卫辉市',246,0,3,NULL),(2717,'原阳县',246,0,3,NULL),(2718,'封丘县',246,0,3,NULL),(2719,'延津县',246,0,3,NULL),(2720,'新乡县',246,0,3,NULL),(2721,'牧野区',246,0,3,NULL),(2722,'红旗区',246,0,3,NULL),(2723,'获嘉县',246,0,3,NULL),(2724,'辉县市',246,0,3,NULL),(2725,'长垣县',246,0,3,NULL),(2726,'中站区',247,0,3,NULL),(2727,'修武县',247,0,3,NULL),(2728,'博爱县',247,0,3,NULL),(2729,'孟州市',247,0,3,NULL),(2730,'山阳区',247,0,3,NULL),(2731,'武陟县',247,0,3,NULL),(2732,'沁阳市',247,0,3,NULL),(2733,'温县',247,0,3,NULL),(2734,'解放区',247,0,3,NULL),(2735,'马村区',247,0,3,NULL),(2736,'华龙区',248,0,3,NULL),(2737,'南乐县',248,0,3,NULL),(2738,'台前县',248,0,3,NULL),(2739,'清丰县',248,0,3,NULL),(2740,'濮阳县',248,0,3,NULL),(2741,'范县',248,0,3,NULL),(2742,'禹州市',249,0,3,NULL),(2743,'襄城县',249,0,3,NULL),(2744,'许昌县',249,0,3,NULL),(2745,'鄢陵县',249,0,3,NULL),(2746,'长葛市',249,0,3,NULL),(2747,'魏都区',249,0,3,NULL),(2748,'临颍县',250,0,3,NULL),(2749,'召陵区',250,0,3,NULL),(2750,'源汇区',250,0,3,NULL),(2751,'舞阳县',250,0,3,NULL),(2752,'郾城区',250,0,3,NULL),(2753,'义马市',251,0,3,NULL),(2754,'卢氏县',251,0,3,NULL),(2755,'渑池县',251,0,3,NULL),(2756,'湖滨区',251,0,3,NULL),(2757,'灵宝市',251,0,3,NULL),(2758,'陕县',251,0,3,NULL),(2759,'内乡县',252,0,3,NULL),(2760,'南召县',252,0,3,NULL),(2761,'卧龙区',252,0,3,NULL),(2762,'唐河县',252,0,3,NULL),(2763,'宛城区',252,0,3,NULL),(2764,'新野县',252,0,3,NULL),(2765,'方城县',252,0,3,NULL),(2766,'桐柏县',252,0,3,NULL),(2767,'淅川县',252,0,3,NULL),(2768,'社旗县',252,0,3,NULL),(2769,'西峡县',252,0,3,NULL),(2770,'邓州市',252,0,3,NULL),(2771,'镇平县',252,0,3,NULL),(2772,'夏邑县',253,0,3,NULL),(2773,'宁陵县',253,0,3,NULL),(2774,'柘城县',253,0,3,NULL),(2775,'民权县',253,0,3,NULL),(2776,'永城市',253,0,3,NULL),(2777,'睢县',253,0,3,NULL),(2778,'睢阳区',253,0,3,NULL),(2779,'粱园区',253,0,3,NULL),(2780,'虞城县',253,0,3,NULL),(2781,'光山县',254,0,3,NULL),(2782,'商城县',254,0,3,NULL),(2783,'固始县',254,0,3,NULL),(2784,'平桥区',254,0,3,NULL),(2785,'息县',254,0,3,NULL),(2786,'新县',254,0,3,NULL),(2787,'浉河区',254,0,3,NULL),(2788,'淮滨县',254,0,3,NULL),(2789,'潢川县',254,0,3,NULL),(2790,'罗山县',254,0,3,NULL),(2791,'商水县',255,0,3,NULL),(2792,'太康县',255,0,3,NULL),(2793,'川汇区',255,0,3,NULL),(2794,'扶沟县',255,0,3,NULL),(2795,'沈丘县',255,0,3,NULL),(2796,'淮阳县',255,0,3,NULL),(2797,'西华县',255,0,3,NULL),(2798,'郸城县',255,0,3,NULL),(2799,'项城市',255,0,3,NULL),(2800,'鹿邑县',255,0,3,NULL),(2801,'上蔡县',256,0,3,NULL),(2802,'平舆县',256,0,3,NULL),(2803,'新蔡县',256,0,3,NULL),(2804,'正阳县',256,0,3,NULL),(2805,'汝南县',256,0,3,NULL),(2806,'泌阳县',256,0,3,NULL),(2807,'确山县',256,0,3,NULL),(2808,'西平县',256,0,3,NULL),(2809,'遂平县',256,0,3,NULL),(2810,'驿城区',256,0,3,NULL),(2811,'济源市',257,0,3,NULL),(2812,'东西湖区',258,0,3,NULL),(2813,'新洲区',258,0,3,NULL),(2814,'武昌区',258,0,3,NULL),(2815,'汉南区',258,0,3,NULL),(2816,'汉阳区',258,0,3,NULL),(2817,'江夏区',258,0,3,NULL),(2818,'江岸区',258,0,3,NULL),(2819,'江汉区',258,0,3,NULL),(2820,'洪山区',258,0,3,NULL),(2821,'硚口区',258,0,3,NULL),(2822,'蔡甸区',258,0,3,NULL),(2823,'青山区',258,0,3,NULL),(2824,'黄陂区',258,0,3,NULL),(2825,'下陆区',259,0,3,NULL),(2826,'大冶市',259,0,3,NULL),(2827,'西塞山区',259,0,3,NULL),(2828,'铁山区',259,0,3,NULL),(2829,'阳新县',259,0,3,NULL),(2830,'黄石港区',259,0,3,NULL),(2831,'丹江口市',260,0,3,NULL),(2832,'张湾区',260,0,3,NULL),(2833,'房县',260,0,3,NULL),(2834,'竹山县',260,0,3,NULL),(2835,'竹溪县',260,0,3,NULL),(2836,'茅箭区',260,0,3,NULL),(2837,'郧县',260,0,3,NULL),(2838,'郧西县',260,0,3,NULL),(2839,'五峰土家族自治县',261,0,3,NULL),(2840,'伍家岗区',261,0,3,NULL),(2841,'兴山县',261,0,3,NULL),(2842,'夷陵区',261,0,3,NULL),(2843,'宜都市',261,0,3,NULL),(2844,'当阳市',261,0,3,NULL),(2845,'枝江市',261,0,3,NULL),(2846,'点军区',261,0,3,NULL),(2847,'秭归县',261,0,3,NULL),(2848,'虢亭区',261,0,3,NULL),(2849,'西陵区',261,0,3,NULL),(2850,'远安县',261,0,3,NULL),(2851,'长阳土家族自治县',261,0,3,NULL),(2852,'保康县',262,0,3,NULL),(2853,'南漳县',262,0,3,NULL),(2854,'宜城市',262,0,3,NULL),(2855,'枣阳市',262,0,3,NULL),(2856,'樊城区',262,0,3,NULL),(2857,'老河口市',262,0,3,NULL),(2858,'襄城区',262,0,3,NULL),(2859,'襄阳区',262,0,3,NULL),(2860,'谷城县',262,0,3,NULL),(2861,'华容区',263,0,3,NULL),(2862,'粱子湖',263,0,3,NULL),(2863,'鄂城区',263,0,3,NULL),(2864,'东宝区',264,0,3,NULL),(2865,'京山县',264,0,3,NULL),(2866,'掇刀区',264,0,3,NULL),(2867,'沙洋县',264,0,3,NULL),(2868,'钟祥市',264,0,3,NULL),(2869,'云梦县',265,0,3,NULL),(2870,'大悟县',265,0,3,NULL),(2871,'孝南区',265,0,3,NULL),(2872,'孝昌县',265,0,3,NULL),(2873,'安陆市',265,0,3,NULL),(2874,'应城市',265,0,3,NULL),(2875,'汉川市',265,0,3,NULL),(2876,'公安县',266,0,3,NULL),(2877,'松滋市',266,0,3,NULL),(2878,'江陵县',266,0,3,NULL),(2879,'沙市区',266,0,3,NULL),(2880,'洪湖市',266,0,3,NULL),(2881,'监利县',266,0,3,NULL),(2882,'石首市',266,0,3,NULL),(2883,'荆州区',266,0,3,NULL),(2884,'团风县',267,0,3,NULL),(2885,'武穴市',267,0,3,NULL),(2886,'浠水县',267,0,3,NULL),(2887,'红安县',267,0,3,NULL),(2888,'罗田县',267,0,3,NULL),(2889,'英山县',267,0,3,NULL),(2890,'蕲春县',267,0,3,NULL),(2891,'麻城市',267,0,3,NULL),(2892,'黄州区',267,0,3,NULL),(2893,'黄梅县',267,0,3,NULL),(2894,'咸安区',268,0,3,NULL),(2895,'嘉鱼县',268,0,3,NULL),(2896,'崇阳县',268,0,3,NULL),(2897,'赤壁市',268,0,3,NULL),(2898,'通城县',268,0,3,NULL),(2899,'通山县',268,0,3,NULL),(2900,'广水市',269,0,3,NULL),(2901,'曾都区',269,0,3,NULL),(2902,'利川市',270,0,3,NULL),(2903,'咸丰县',270,0,3,NULL),(2904,'宣恩县',270,0,3,NULL),(2905,'巴东县',270,0,3,NULL),(2906,'建始县',270,0,3,NULL),(2907,'恩施市',270,0,3,NULL),(2908,'来凤县',270,0,3,NULL),(2909,'鹤峰县',270,0,3,NULL),(2910,'仙桃市',271,0,3,NULL),(2911,'潜江市',272,0,3,NULL),(2912,'天门市',273,0,3,NULL),(2913,'神农架林区',274,0,3,NULL),(2914,'天心区',275,0,3,NULL),(2915,'宁乡县',275,0,3,NULL),(2916,'岳麓区',275,0,3,NULL),(2917,'开福区',275,0,3,NULL),(2918,'望城县',275,0,3,NULL),(2919,'浏阳市',275,0,3,NULL),(2920,'芙蓉区',275,0,3,NULL),(2921,'长沙县',275,0,3,NULL),(2922,'雨花区',275,0,3,NULL),(2923,'天元区',276,0,3,NULL),(2924,'攸县',276,0,3,NULL),(2925,'株洲县',276,0,3,NULL),(2926,'炎陵县',276,0,3,NULL),(2927,'石峰区',276,0,3,NULL),(2928,'芦淞区',276,0,3,NULL),(2929,'茶陵县',276,0,3,NULL),(2930,'荷塘区',276,0,3,NULL),(2931,'醴陵市',276,0,3,NULL),(2932,'岳塘区',277,0,3,NULL),(2933,'湘乡市',277,0,3,NULL),(2934,'湘潭县',277,0,3,NULL),(2935,'雨湖区',277,0,3,NULL),(2936,'韶山市',277,0,3,NULL),(2937,'南岳区',278,0,3,NULL),(2938,'常宁市',278,0,3,NULL),(2939,'珠晖区',278,0,3,NULL),(2940,'石鼓区',278,0,3,NULL),(2941,'祁东县',278,0,3,NULL),(2942,'耒阳市',278,0,3,NULL),(2943,'蒸湘区',278,0,3,NULL),(2944,'衡东县',278,0,3,NULL),(2945,'衡南县',278,0,3,NULL),(2946,'衡山县',278,0,3,NULL),(2947,'衡阳县',278,0,3,NULL),(2948,'雁峰区',278,0,3,NULL),(2949,'北塔区',279,0,3,NULL),(2950,'双清区',279,0,3,NULL),(2951,'城步苗族自治县',279,0,3,NULL),(2952,'大祥区',279,0,3,NULL),(2953,'新宁县',279,0,3,NULL),(2954,'新邵县',279,0,3,NULL),(2955,'武冈市',279,0,3,NULL),(2956,'洞口县',279,0,3,NULL),(2957,'绥宁县',279,0,3,NULL),(2958,'邵东县',279,0,3,NULL),(2959,'邵阳县',279,0,3,NULL),(2960,'隆回县',279,0,3,NULL),(2961,'临湘市',280,0,3,NULL),(2962,'云溪区',280,0,3,NULL),(2963,'华容县',280,0,3,NULL),(2964,'君山区',280,0,3,NULL),(2965,'岳阳县',280,0,3,NULL),(2966,'岳阳楼区',280,0,3,NULL),(2967,'平江县',280,0,3,NULL),(2968,'汨罗市',280,0,3,NULL),(2969,'湘阴县',280,0,3,NULL),(2970,'临澧县',281,0,3,NULL),(2971,'安乡县',281,0,3,NULL),(2972,'桃源县',281,0,3,NULL),(2973,'武陵区',281,0,3,NULL),(2974,'汉寿县',281,0,3,NULL),(2975,'津市市',281,0,3,NULL),(2976,'澧县',281,0,3,NULL),(2977,'石门县',281,0,3,NULL),(2978,'鼎城区',281,0,3,NULL),(2979,'慈利县',282,0,3,NULL),(2980,'桑植县',282,0,3,NULL),(2981,'武陵源区',282,0,3,NULL),(2982,'永定区',282,0,3,NULL),(2983,'南县',283,0,3,NULL),(2984,'安化县',283,0,3,NULL),(2985,'桃江县',283,0,3,NULL),(2986,'沅江市',283,0,3,NULL),(2987,'资阳区',283,0,3,NULL),(2988,'赫山区',283,0,3,NULL),(2989,'临武县',284,0,3,NULL),(2990,'北湖区',284,0,3,NULL),(2991,'嘉禾县',284,0,3,NULL),(2992,'安仁县',284,0,3,NULL),(2993,'宜章县',284,0,3,NULL),(2994,'桂东县',284,0,3,NULL),(2995,'桂阳县',284,0,3,NULL),(2996,'永兴县',284,0,3,NULL),(2997,'汝城县',284,0,3,NULL),(2998,'苏仙区',284,0,3,NULL),(2999,'资兴市',284,0,3,NULL),(3000,'东安县',285,0,3,NULL),(3001,'冷水滩区',285,0,3,NULL),(3002,'双牌县',285,0,3,NULL),(3003,'宁远县',285,0,3,NULL),(3004,'新田县',285,0,3,NULL),(3005,'江华瑶族自治县',285,0,3,NULL),(3006,'江永县',285,0,3,NULL),(3007,'祁阳县',285,0,3,NULL),(3008,'蓝山县',285,0,3,NULL),(3009,'道县',285,0,3,NULL),(3010,'零陵区',285,0,3,NULL),(3011,'中方县',286,0,3,NULL),(3012,'会同县',286,0,3,NULL),(3013,'新晃侗族自治县',286,0,3,NULL),(3014,'沅陵县',286,0,3,NULL),(3015,'洪江市/洪江区',286,0,3,NULL),(3016,'溆浦县',286,0,3,NULL),(3017,'芷江侗族自治县',286,0,3,NULL),(3018,'辰溪县',286,0,3,NULL),(3019,'通道侗族自治县',286,0,3,NULL),(3020,'靖州苗族侗族自治县',286,0,3,NULL),(3021,'鹤城区',286,0,3,NULL),(3022,'麻阳苗族自治县',286,0,3,NULL),(3023,'冷水江市',287,0,3,NULL),(3024,'双峰县',287,0,3,NULL),(3025,'娄星区',287,0,3,NULL),(3026,'新化县',287,0,3,NULL),(3027,'涟源市',287,0,3,NULL),(3028,'保靖县',288,0,3,NULL),(3029,'凤凰县',288,0,3,NULL),(3030,'古丈县',288,0,3,NULL),(3031,'吉首市',288,0,3,NULL),(3032,'永顺县',288,0,3,NULL),(3033,'泸溪县',288,0,3,NULL),(3034,'花垣县',288,0,3,NULL),(3035,'龙山县',288,0,3,NULL),(3036,'萝岗区',289,0,3,NULL),(3037,'南沙区',289,0,3,NULL),(3038,'从化市',289,0,3,NULL),(3039,'增城市',289,0,3,NULL),(3040,'天河区',289,0,3,NULL),(3041,'海珠区',289,0,3,NULL),(3042,'番禺区',289,0,3,NULL),(3043,'白云区',289,0,3,NULL),(3044,'花都区',289,0,3,NULL),(3045,'荔湾区',289,0,3,NULL),(3046,'越秀区',289,0,3,NULL),(3047,'黄埔区',289,0,3,NULL),(3048,'乐昌市',290,0,3,NULL),(3049,'乳源瑶族自治县',290,0,3,NULL),(3050,'仁化县',290,0,3,NULL),(3051,'南雄市',290,0,3,NULL),(3052,'始兴县',290,0,3,NULL),(3053,'新丰县',290,0,3,NULL),(3054,'曲江区',290,0,3,NULL),(3055,'武江区',290,0,3,NULL),(3056,'浈江区',290,0,3,NULL),(3057,'翁源县',290,0,3,NULL),(3058,'南山区',291,0,3,NULL),(3059,'宝安区',291,0,3,NULL),(3060,'盐田区',291,0,3,NULL),(3061,'福田区',291,0,3,NULL),(3062,'罗湖区',291,0,3,NULL),(3063,'龙岗区',291,0,3,NULL),(3064,'斗门区',292,0,3,NULL),(3065,'金湾区',292,0,3,NULL),(3066,'香洲区',292,0,3,NULL),(3067,'南澳县',293,0,3,NULL),(3068,'潮南区',293,0,3,NULL),(3069,'潮阳区',293,0,3,NULL),(3070,'澄海区',293,0,3,NULL),(3071,'濠江区',293,0,3,NULL),(3072,'金平区',293,0,3,NULL),(3073,'龙湖区',293,0,3,NULL),(3074,'三水区',294,0,3,NULL),(3075,'南海区',294,0,3,NULL),(3076,'禅城区',294,0,3,NULL),(3077,'顺德区',294,0,3,NULL),(3078,'高明区',294,0,3,NULL),(3079,'台山市',295,0,3,NULL),(3080,'开平市',295,0,3,NULL),(3081,'恩平市',295,0,3,NULL),(3082,'新会区',295,0,3,NULL),(3083,'江海区',295,0,3,NULL),(3084,'蓬江区',295,0,3,NULL),(3085,'鹤山市',295,0,3,NULL),(3086,'吴川市',296,0,3,NULL),(3087,'坡头区',296,0,3,NULL),(3088,'廉江市',296,0,3,NULL),(3089,'徐闻县',296,0,3,NULL),(3090,'赤坎区',296,0,3,NULL),(3091,'遂溪县',296,0,3,NULL),(3092,'雷州市',296,0,3,NULL),(3093,'霞山区',296,0,3,NULL),(3094,'麻章区',296,0,3,NULL),(3095,'信宜市',297,0,3,NULL),(3096,'化州市',297,0,3,NULL),(3097,'电白县',297,0,3,NULL),(3098,'茂南区',297,0,3,NULL),(3099,'茂港区',297,0,3,NULL),(3100,'高州市',297,0,3,NULL),(3101,'四会市',298,0,3,NULL),(3102,'封开县',298,0,3,NULL),(3103,'广宁县',298,0,3,NULL),(3104,'德庆县',298,0,3,NULL),(3105,'怀集县',298,0,3,NULL),(3106,'端州区',298,0,3,NULL),(3107,'高要市',298,0,3,NULL),(3108,'鼎湖区',298,0,3,NULL),(3109,'博罗县',299,0,3,NULL),(3110,'惠东县',299,0,3,NULL),(3111,'惠城区',299,0,3,NULL),(3112,'惠阳区',299,0,3,NULL),(3113,'龙门县',299,0,3,NULL),(3114,'丰顺县',300,0,3,NULL),(3115,'五华县',300,0,3,NULL),(3116,'兴宁市',300,0,3,NULL),(3117,'大埔县',300,0,3,NULL),(3118,'平远县',300,0,3,NULL),(3119,'梅县',300,0,3,NULL),(3120,'梅江区',300,0,3,NULL),(3121,'蕉岭县',300,0,3,NULL),(3122,'城区',301,0,3,NULL),(3123,'海丰县',301,0,3,NULL),(3124,'陆丰市',301,0,3,NULL),(3125,'陆河县',301,0,3,NULL),(3126,'东源县',302,0,3,NULL),(3127,'和平县',302,0,3,NULL),(3128,'源城区',302,0,3,NULL),(3129,'紫金县',302,0,3,NULL),(3130,'连平县',302,0,3,NULL),(3131,'龙川县',302,0,3,NULL),(3132,'江城区',303,0,3,NULL),(3133,'阳东县',303,0,3,NULL),(3134,'阳春市',303,0,3,NULL),(3135,'阳西县',303,0,3,NULL),(3136,'佛冈县',304,0,3,NULL),(3137,'清城区',304,0,3,NULL),(3138,'清新县',304,0,3,NULL),(3139,'英德市',304,0,3,NULL),(3140,'连南瑶族自治县',304,0,3,NULL),(3141,'连山壮族瑶族自治县',304,0,3,NULL),(3142,'连州市',304,0,3,NULL),(3143,'阳山县',304,0,3,NULL),(3144,'东莞市',305,0,3,NULL),(3145,'中山市',306,0,3,NULL),(3146,'湘桥区',307,0,3,NULL),(3147,'潮安县',307,0,3,NULL),(3148,'饶平县',307,0,3,NULL),(3149,'惠来县',308,0,3,NULL),(3150,'揭东县',308,0,3,NULL),(3151,'揭西县',308,0,3,NULL),(3152,'普宁市',308,0,3,NULL),(3153,'榕城区',308,0,3,NULL),(3154,'云城区',309,0,3,NULL),(3155,'云安县',309,0,3,NULL),(3156,'新兴县',309,0,3,NULL),(3157,'罗定市',309,0,3,NULL),(3158,'郁南县',309,0,3,NULL),(3159,'上林县',310,0,3,NULL),(3160,'兴宁区',310,0,3,NULL),(3161,'宾阳县',310,0,3,NULL),(3162,'横县',310,0,3,NULL),(3163,'武鸣县',310,0,3,NULL),(3164,'江南区',310,0,3,NULL),(3165,'良庆区',310,0,3,NULL),(3166,'西乡塘区',310,0,3,NULL),(3167,'邕宁区',310,0,3,NULL),(3168,'隆安县',310,0,3,NULL),(3169,'青秀区',310,0,3,NULL),(3170,'马山县',310,0,3,NULL),(3171,'三江侗族自治县',311,0,3,NULL),(3172,'城中区',311,0,3,NULL),(3173,'柳北区',311,0,3,NULL),(3174,'柳南区',311,0,3,NULL),(3175,'柳城县',311,0,3,NULL),(3176,'柳江县',311,0,3,NULL),(3177,'融安县',311,0,3,NULL),(3178,'融水苗族自治县',311,0,3,NULL),(3179,'鱼峰区',311,0,3,NULL),(3180,'鹿寨县',311,0,3,NULL),(3181,'七星区',312,0,3,NULL),(3182,'临桂县',312,0,3,NULL),(3183,'全州县',312,0,3,NULL),(3184,'兴安县',312,0,3,NULL),(3185,'叠彩区',312,0,3,NULL),(3186,'平乐县',312,0,3,NULL),(3187,'恭城瑶族自治县',312,0,3,NULL),(3188,'永福县',312,0,3,NULL),(3189,'灌阳县',312,0,3,NULL),(3190,'灵川县',312,0,3,NULL),(3191,'秀峰区',312,0,3,NULL),(3192,'荔浦县',312,0,3,NULL),(3193,'象山区',312,0,3,NULL),(3194,'资源县',312,0,3,NULL),(3195,'阳朔县',312,0,3,NULL),(3196,'雁山区',312,0,3,NULL),(3197,'龙胜各族自治县',312,0,3,NULL),(3198,'万秀区',313,0,3,NULL),(3199,'岑溪市',313,0,3,NULL),(3200,'苍梧县',313,0,3,NULL),(3201,'蒙山县',313,0,3,NULL),(3202,'藤县',313,0,3,NULL),(3203,'蝶山区',313,0,3,NULL),(3204,'长洲区',313,0,3,NULL),(3205,'合浦县',314,0,3,NULL),(3206,'海城区',314,0,3,NULL),(3207,'铁山港区',314,0,3,NULL),(3208,'银海区',314,0,3,NULL),(3209,'上思县',315,0,3,NULL),(3210,'东兴市',315,0,3,NULL),(3211,'港口区',315,0,3,NULL),(3212,'防城区',315,0,3,NULL),(3213,'浦北县',316,0,3,NULL),(3214,'灵山县',316,0,3,NULL),(3215,'钦北区',316,0,3,NULL),(3216,'钦南区',316,0,3,NULL),(3217,'平南县',317,0,3,NULL),(3218,'桂平市',317,0,3,NULL),(3219,'港北区',317,0,3,NULL),(3220,'港南区',317,0,3,NULL),(3221,'覃塘区',317,0,3,NULL),(3222,'兴业县',318,0,3,NULL),(3223,'北流市',318,0,3,NULL),(3224,'博白县',318,0,3,NULL),(3225,'容县',318,0,3,NULL),(3226,'玉州区',318,0,3,NULL),(3227,'陆川县',318,0,3,NULL),(3228,'乐业县',319,0,3,NULL),(3229,'凌云县',319,0,3,NULL),(3230,'右江区',319,0,3,NULL),(3231,'平果县',319,0,3,NULL),(3232,'德保县',319,0,3,NULL),(3233,'田东县',319,0,3,NULL),(3234,'田林县',319,0,3,NULL),(3235,'田阳县',319,0,3,NULL),(3236,'西林县',319,0,3,NULL),(3237,'那坡县',319,0,3,NULL),(3238,'隆林各族自治县',319,0,3,NULL),(3239,'靖西县',319,0,3,NULL),(3240,'八步区',320,0,3,NULL),(3241,'富川瑶族自治县',320,0,3,NULL),(3242,'昭平县',320,0,3,NULL),(3243,'钟山县',320,0,3,NULL),(3244,'东兰县',321,0,3,NULL),(3245,'凤山县',321,0,3,NULL),(3246,'南丹县',321,0,3,NULL),(3247,'大化瑶族自治县',321,0,3,NULL),(3248,'天峨县',321,0,3,NULL),(3249,'宜州市',321,0,3,NULL),(3250,'巴马瑶族自治县',321,0,3,NULL),(3251,'环江毛南族自治县',321,0,3,NULL),(3252,'罗城仫佬族自治县',321,0,3,NULL),(3253,'都安瑶族自治县',321,0,3,NULL),(3254,'金城江区',321,0,3,NULL),(3255,'兴宾区',322,0,3,NULL),(3256,'合山市',322,0,3,NULL),(3257,'忻城县',322,0,3,NULL),(3258,'武宣县',322,0,3,NULL),(3259,'象州县',322,0,3,NULL),(3260,'金秀瑶族自治县',322,0,3,NULL),(3261,'凭祥市',323,0,3,NULL),(3262,'大新县',323,0,3,NULL),(3263,'天等县',323,0,3,NULL),(3264,'宁明县',323,0,3,NULL),(3265,'扶绥县',323,0,3,NULL),(3266,'江州区',323,0,3,NULL),(3267,'龙州县',323,0,3,NULL),(3268,'琼山区',324,0,3,NULL),(3269,'秀英区',324,0,3,NULL),(3270,'美兰区',324,0,3,NULL),(3271,'龙华区',324,0,3,NULL),(3272,'三亚市',325,0,3,NULL),(3273,'五指山市',326,0,3,NULL),(3274,'琼海市',327,0,3,NULL),(3275,'儋州市',328,0,3,NULL),(3276,'文昌市',329,0,3,NULL),(3277,'万宁市',330,0,3,NULL),(3278,'东方市',331,0,3,NULL),(3279,'定安县',332,0,3,NULL),(3280,'屯昌县',333,0,3,NULL),(3281,'澄迈县',334,0,3,NULL),(3282,'临高县',335,0,3,NULL),(3283,'白沙黎族自治县',336,0,3,NULL),(3284,'昌江黎族自治县',337,0,3,NULL),(3285,'乐东黎族自治县',338,0,3,NULL),(3286,'陵水黎族自治县',339,0,3,NULL),(3287,'保亭黎族苗族自治县',340,0,3,NULL),(3288,'琼中黎族苗族自治县',341,0,3,NULL),(4209,'双流县',385,0,3,NULL),(4210,'大邑县',385,0,3,NULL),(4211,'崇州市',385,0,3,NULL),(4212,'彭州市',385,0,3,NULL),(4213,'成华区',385,0,3,NULL),(4214,'新津县',385,0,3,NULL),(4215,'新都区',385,0,3,NULL),(4216,'武侯区',385,0,3,NULL),(4217,'温江区',385,0,3,NULL),(4218,'蒲江县',385,0,3,NULL),(4219,'邛崃市',385,0,3,NULL),(4220,'郫县',385,0,3,NULL),(4221,'都江堰市',385,0,3,NULL),(4222,'金堂县',385,0,3,NULL),(4223,'金牛区',385,0,3,NULL),(4224,'锦江区',385,0,3,NULL),(4225,'青白江区',385,0,3,NULL),(4226,'青羊区',385,0,3,NULL),(4227,'龙泉驿区',385,0,3,NULL),(4228,'大安区',386,0,3,NULL),(4229,'富顺县',386,0,3,NULL),(4230,'沿滩区',386,0,3,NULL),(4231,'自流井区',386,0,3,NULL),(4232,'荣县',386,0,3,NULL),(4233,'贡井区',386,0,3,NULL),(4234,'东区',387,0,3,NULL),(4235,'仁和区',387,0,3,NULL),(4236,'盐边县',387,0,3,NULL),(4237,'米易县',387,0,3,NULL),(4238,'西区',387,0,3,NULL),(4239,'叙永县',388,0,3,NULL),(4240,'古蔺县',388,0,3,NULL),(4241,'合江县',388,0,3,NULL),(4242,'江阳区',388,0,3,NULL),(4243,'泸县',388,0,3,NULL),(4244,'纳溪区',388,0,3,NULL),(4245,'龙马潭区',388,0,3,NULL),(4246,'中江县',389,0,3,NULL),(4247,'什邡市',389,0,3,NULL),(4248,'广汉市',389,0,3,NULL),(4249,'旌阳区',389,0,3,NULL),(4250,'绵竹市',389,0,3,NULL),(4251,'罗江县',389,0,3,NULL),(4252,'三台县',390,0,3,NULL),(4253,'北川羌族自治县',390,0,3,NULL),(4254,'安县',390,0,3,NULL),(4255,'平武县',390,0,3,NULL),(4256,'梓潼县',390,0,3,NULL),(4257,'江油市',390,0,3,NULL),(4258,'涪城区',390,0,3,NULL),(4259,'游仙区',390,0,3,NULL),(4260,'盐亭县',390,0,3,NULL),(4261,'元坝区',391,0,3,NULL),(4262,'利州区',391,0,3,NULL),(4263,'剑阁县',391,0,3,NULL),(4264,'旺苍县',391,0,3,NULL),(4265,'朝天区',391,0,3,NULL),(4266,'苍溪县',391,0,3,NULL),(4267,'青川县',391,0,3,NULL),(4268,'大英县',392,0,3,NULL),(4269,'安居区',392,0,3,NULL),(4270,'射洪县',392,0,3,NULL),(4271,'船山区',392,0,3,NULL),(4272,'蓬溪县',392,0,3,NULL),(4273,'东兴区',393,0,3,NULL),(4274,'威远县',393,0,3,NULL),(4275,'市中区',393,0,3,NULL),(4276,'资中县',393,0,3,NULL),(4277,'隆昌县',393,0,3,NULL),(4278,'五通桥区',394,0,3,NULL),(4279,'井研县',394,0,3,NULL),(4280,'夹江县',394,0,3,NULL),(4281,'峨眉山市',394,0,3,NULL),(4282,'峨边彝族自治县',394,0,3,NULL),(4283,'市中区',394,0,3,NULL),(4284,'沐川县',394,0,3,NULL),(4285,'沙湾区',394,0,3,NULL),(4286,'犍为县',394,0,3,NULL),(4287,'金口河区',394,0,3,NULL),(4288,'马边彝族自治县',394,0,3,NULL),(4289,'仪陇县',395,0,3,NULL),(4290,'南充市嘉陵区',395,0,3,NULL),(4291,'南部县',395,0,3,NULL),(4292,'嘉陵区',395,0,3,NULL),(4293,'营山县',395,0,3,NULL),(4294,'蓬安县',395,0,3,NULL),(4295,'西充县',395,0,3,NULL),(4296,'阆中市',395,0,3,NULL),(4297,'顺庆区',395,0,3,NULL),(4298,'高坪区',395,0,3,NULL),(4299,'东坡区',396,0,3,NULL),(4300,'丹棱县',396,0,3,NULL),(4301,'仁寿县',396,0,3,NULL),(4302,'彭山县',396,0,3,NULL),(4303,'洪雅县',396,0,3,NULL),(4304,'青神县',396,0,3,NULL),(4305,'兴文县',397,0,3,NULL),(4306,'南溪县',397,0,3,NULL),(4307,'宜宾县',397,0,3,NULL),(4308,'屏山县',397,0,3,NULL),(4309,'江安县',397,0,3,NULL),(4310,'珙县',397,0,3,NULL),(4311,'筠连县',397,0,3,NULL),(4312,'翠屏区',397,0,3,NULL),(4313,'长宁县',397,0,3,NULL),(4314,'高县',397,0,3,NULL),(4315,'华蓥市',398,0,3,NULL),(4316,'岳池县',398,0,3,NULL),(4317,'广安区',398,0,3,NULL),(4318,'武胜县',398,0,3,NULL),(4319,'邻水县',398,0,3,NULL),(4320,'万源市',399,0,3,NULL),(4321,'大竹县',399,0,3,NULL),(4322,'宣汉县',399,0,3,NULL),(4323,'开江县',399,0,3,NULL),(4324,'渠县',399,0,3,NULL),(4325,'达县',399,0,3,NULL),(4326,'通川区',399,0,3,NULL),(4327,'名山县',400,0,3,NULL),(4328,'天全县',400,0,3,NULL),(4329,'宝兴县',400,0,3,NULL),(4330,'汉源县',400,0,3,NULL),(4331,'石棉县',400,0,3,NULL),(4332,'芦山县',400,0,3,NULL),(4333,'荥经县',400,0,3,NULL),(4334,'雨城区',400,0,3,NULL),(4335,'南江县',401,0,3,NULL),(4336,'巴州区',401,0,3,NULL),(4337,'平昌县',401,0,3,NULL),(4338,'通江县',401,0,3,NULL),(4339,'乐至县',402,0,3,NULL),(4340,'安岳县',402,0,3,NULL),(4341,'简阳市',402,0,3,NULL),(4342,'雁江区',402,0,3,NULL),(4343,'九寨沟县',403,0,3,NULL),(4344,'壤塘县',403,0,3,NULL),(4345,'小金县',403,0,3,NULL),(4346,'松潘县',403,0,3,NULL),(4347,'汶川县',403,0,3,NULL),(4348,'理县',403,0,3,NULL),(4349,'红原县',403,0,3,NULL),(4350,'若尔盖县',403,0,3,NULL),(4351,'茂县',403,0,3,NULL),(4352,'金川县',403,0,3,NULL),(4353,'阿坝县',403,0,3,NULL),(4354,'马尔康县',403,0,3,NULL),(4355,'黑水县',403,0,3,NULL),(4356,'丹巴县',404,0,3,NULL),(4357,'乡城县',404,0,3,NULL),(4358,'巴塘县',404,0,3,NULL),(4359,'康定县',404,0,3,NULL),(4360,'得荣县',404,0,3,NULL),(4361,'德格县',404,0,3,NULL),(4362,'新龙县',404,0,3,NULL),(4363,'泸定县',404,0,3,NULL),(4364,'炉霍县',404,0,3,NULL),(4365,'理塘县',404,0,3,NULL),(4366,'甘孜县',404,0,3,NULL),(4367,'白玉县',404,0,3,NULL),(4368,'石渠县',404,0,3,NULL),(4369,'稻城县',404,0,3,NULL),(4370,'色达县',404,0,3,NULL),(4371,'道孚县',404,0,3,NULL),(4372,'雅江县',404,0,3,NULL),(4373,'会东县',405,0,3,NULL),(4374,'会理县',405,0,3,NULL),(4375,'冕宁县',405,0,3,NULL),(4376,'喜德县',405,0,3,NULL),(4377,'宁南县',405,0,3,NULL),(4378,'布拖县',405,0,3,NULL),(4379,'德昌县',405,0,3,NULL),(4380,'昭觉县',405,0,3,NULL),(4381,'普格县',405,0,3,NULL),(4382,'木里藏族自治县',405,0,3,NULL),(4383,'甘洛县',405,0,3,NULL),(4384,'盐源县',405,0,3,NULL),(4385,'美姑县',405,0,3,NULL),(4386,'西昌',405,0,3,NULL),(4387,'越西县',405,0,3,NULL),(4388,'金阳县',405,0,3,NULL),(4389,'雷波县',405,0,3,NULL),(4390,'乌当区',406,0,3,NULL),(4391,'云岩区',406,0,3,NULL),(4392,'修文县',406,0,3,NULL),(4393,'南明区',406,0,3,NULL),(4394,'小河区',406,0,3,NULL),(4395,'开阳县',406,0,3,NULL),(4396,'息烽县',406,0,3,NULL),(4397,'清镇市',406,0,3,NULL),(4398,'白云区',406,0,3,NULL),(4399,'花溪区',406,0,3,NULL),(4400,'六枝特区',407,0,3,NULL),(4401,'水城县',407,0,3,NULL),(4402,'盘县',407,0,3,NULL),(4403,'钟山区',407,0,3,NULL),(4404,'习水县',408,0,3,NULL),(4405,'仁怀市',408,0,3,NULL),(4406,'余庆县',408,0,3,NULL),(4407,'凤冈县',408,0,3,NULL),(4408,'务川仡佬族苗族自治县',408,0,3,NULL),(4409,'桐梓县',408,0,3,NULL),(4410,'正安县',408,0,3,NULL),(4411,'汇川区',408,0,3,NULL),(4412,'湄潭县',408,0,3,NULL),(4413,'红花岗区',408,0,3,NULL),(4414,'绥阳县',408,0,3,NULL),(4415,'赤水市',408,0,3,NULL),(4416,'道真仡佬族苗族自治县',408,0,3,NULL),(4417,'遵义县',408,0,3,NULL),(4418,'关岭布依族苗族自治县',409,0,3,NULL),(4419,'平坝县',409,0,3,NULL),(4420,'普定县',409,0,3,NULL),(4421,'紫云苗族布依族自治县',409,0,3,NULL),(4422,'西秀区',409,0,3,NULL),(4423,'镇宁布依族苗族自治县',409,0,3,NULL),(4424,'万山特区',410,0,3,NULL),(4425,'印江土家族苗族自治县',410,0,3,NULL),(4426,'德江县',410,0,3,NULL),(4427,'思南县',410,0,3,NULL),(4428,'松桃苗族自治县',410,0,3,NULL),(4429,'江口县',410,0,3,NULL),(4430,'沿河土家族自治县',410,0,3,NULL),(4431,'玉屏侗族自治县',410,0,3,NULL),(4432,'石阡县',410,0,3,NULL),(4433,'铜仁市',410,0,3,NULL),(4434,'兴义市',411,0,3,NULL),(4435,'兴仁县',411,0,3,NULL),(4436,'册亨县',411,0,3,NULL),(4437,'安龙县',411,0,3,NULL),(4438,'普安县',411,0,3,NULL),(4439,'晴隆县',411,0,3,NULL),(4440,'望谟县',411,0,3,NULL),(4441,'贞丰县',411,0,3,NULL),(4442,'大方县',412,0,3,NULL),(4443,'威宁彝族回族苗族自治县',412,0,3,NULL),(4444,'毕节市',412,0,3,NULL),(4445,'纳雍县',412,0,3,NULL),(4446,'织金县',412,0,3,NULL),(4447,'赫章县',412,0,3,NULL),(4448,'金沙县',412,0,3,NULL),(4449,'黔西县',412,0,3,NULL),(4450,'三穗县',413,0,3,NULL),(4451,'丹寨县',413,0,3,NULL),(4452,'从江县',413,0,3,NULL),(4453,'凯里市',413,0,3,NULL),(4454,'剑河县',413,0,3,NULL),(4455,'台江县',413,0,3,NULL),(4456,'天柱县',413,0,3,NULL),(4457,'岑巩县',413,0,3,NULL),(4458,'施秉县',413,0,3,NULL),(4459,'榕江县',413,0,3,NULL),(4460,'锦屏县',413,0,3,NULL),(4461,'镇远县',413,0,3,NULL),(4462,'雷山县',413,0,3,NULL),(4463,'麻江县',413,0,3,NULL),(4464,'黄平县',413,0,3,NULL),(4465,'黎平县',413,0,3,NULL),(4466,'三都水族自治县',414,0,3,NULL),(4467,'平塘县',414,0,3,NULL),(4468,'惠水县',414,0,3,NULL),(4469,'独山县',414,0,3,NULL),(4470,'瓮安县',414,0,3,NULL),(4471,'福泉市',414,0,3,NULL),(4472,'罗甸县',414,0,3,NULL),(4473,'荔波县',414,0,3,NULL),(4474,'贵定县',414,0,3,NULL),(4475,'都匀市',414,0,3,NULL),(4476,'长顺县',414,0,3,NULL),(4477,'龙里县',414,0,3,NULL),(4478,'东川区',415,0,3,NULL),(4479,'五华区',415,0,3,NULL),(4480,'呈贡县',415,0,3,NULL),(4481,'安宁市',415,0,3,NULL),(4482,'官渡区',415,0,3,NULL),(4483,'宜良县',415,0,3,NULL),(4484,'富民县',415,0,3,NULL),(4485,'寻甸回族彝族自治县',415,0,3,NULL),(4486,'嵩明县',415,0,3,NULL),(4487,'晋宁县',415,0,3,NULL),(4488,'盘龙区',415,0,3,NULL),(4489,'石林彝族自治县',415,0,3,NULL),(4490,'禄劝彝族苗族自治县',415,0,3,NULL),(4491,'西山区',415,0,3,NULL),(4492,'会泽县',416,0,3,NULL),(4493,'宣威市',416,0,3,NULL),(4494,'富源县',416,0,3,NULL),(4495,'师宗县',416,0,3,NULL),(4496,'沾益县',416,0,3,NULL),(4497,'罗平县',416,0,3,NULL),(4498,'陆良县',416,0,3,NULL),(4499,'马龙县',416,0,3,NULL),(4500,'麒麟区',416,0,3,NULL),(4501,'元江哈尼族彝族傣族自治县',417,0,3,NULL),(4502,'华宁县',417,0,3,NULL),(4503,'峨山彝族自治县',417,0,3,NULL),(4504,'新平彝族傣族自治县',417,0,3,NULL),(4505,'易门县',417,0,3,NULL),(4506,'江川县',417,0,3,NULL),(4507,'澄江县',417,0,3,NULL),(4508,'红塔区',417,0,3,NULL),(4509,'通海县',417,0,3,NULL),(4510,'施甸县',418,0,3,NULL),(4511,'昌宁县',418,0,3,NULL),(4512,'腾冲县',418,0,3,NULL),(4513,'隆阳区',418,0,3,NULL),(4514,'龙陵县',418,0,3,NULL),(4515,'大关县',419,0,3,NULL),(4516,'威信县',419,0,3,NULL),(4517,'巧家县',419,0,3,NULL),(4518,'彝良县',419,0,3,NULL),(4519,'昭阳区',419,0,3,NULL),(4520,'水富县',419,0,3,NULL),(4521,'永善县',419,0,3,NULL),(4522,'盐津县',419,0,3,NULL),(4523,'绥江县',419,0,3,NULL),(4524,'镇雄县',419,0,3,NULL),(4525,'鲁甸县',419,0,3,NULL),(4526,'华坪县',420,0,3,NULL),(4527,'古城区',420,0,3,NULL),(4528,'宁蒗彝族自治县',420,0,3,NULL),(4529,'永胜县',420,0,3,NULL),(4530,'玉龙纳西族自治县',420,0,3,NULL),(4531,'临翔区',422,0,3,NULL),(4532,'云县',422,0,3,NULL),(4533,'凤庆县',422,0,3,NULL),(4534,'双江拉祜族佤族布朗族傣族自治县',422,0,3,NULL),(4535,'永德县',422,0,3,NULL),(4536,'沧源佤族自治县',422,0,3,NULL),(4537,'耿马傣族佤族自治县',422,0,3,NULL),(4538,'镇康县',422,0,3,NULL),(4539,'元谋县',423,0,3,NULL),(4540,'南华县',423,0,3,NULL),(4541,'双柏县',423,0,3,NULL),(4542,'大姚县',423,0,3,NULL),(4543,'姚安县',423,0,3,NULL),(4544,'楚雄市',423,0,3,NULL),(4545,'武定县',423,0,3,NULL),(4546,'永仁县',423,0,3,NULL),(4547,'牟定县',423,0,3,NULL),(4548,'禄丰县',423,0,3,NULL),(4549,'个旧市',424,0,3,NULL),(4550,'元阳县',424,0,3,NULL),(4551,'屏边苗族自治县',424,0,3,NULL),(4552,'建水县',424,0,3,NULL),(4553,'开远市',424,0,3,NULL),(4554,'弥勒县',424,0,3,NULL),(4555,'河口瑶族自治县',424,0,3,NULL),(4556,'泸西县',424,0,3,NULL),(4557,'石屏县',424,0,3,NULL),(4558,'红河县',424,0,3,NULL),(4559,'绿春县',424,0,3,NULL),(4560,'蒙自县',424,0,3,NULL),(4561,'金平苗族瑶族傣族自治县',424,0,3,NULL),(4562,'丘北县',425,0,3,NULL),(4563,'富宁县',425,0,3,NULL),(4564,'广南县',425,0,3,NULL),(4565,'文山县',425,0,3,NULL),(4566,'砚山县',425,0,3,NULL),(4567,'西畴县',425,0,3,NULL),(4568,'马关县',425,0,3,NULL),(4569,'麻栗坡县',425,0,3,NULL),(4570,'勐海县',426,0,3,NULL),(4571,'勐腊县',426,0,3,NULL),(4572,'景洪市',426,0,3,NULL),(4573,'云龙县',427,0,3,NULL),(4574,'剑川县',427,0,3,NULL),(4575,'南涧彝族自治县',427,0,3,NULL),(4576,'大理市',427,0,3,NULL),(4577,'宾川县',427,0,3,NULL),(4578,'巍山彝族回族自治县',427,0,3,NULL),(4579,'弥渡县',427,0,3,NULL),(4580,'永平县',427,0,3,NULL),(4581,'洱源县',427,0,3,NULL),(4582,'漾濞彝族自治县',427,0,3,NULL),(4583,'祥云县',427,0,3,NULL),(4584,'鹤庆县',427,0,3,NULL),(4585,'梁河县',428,0,3,NULL),(4586,'潞西市',428,0,3,NULL),(4587,'瑞丽市',428,0,3,NULL),(4588,'盈江县',428,0,3,NULL),(4589,'陇川县',428,0,3,NULL),(4590,'德钦县',430,0,3,NULL),(4591,'维西傈僳族自治县',430,0,3,NULL),(4592,'香格里拉县',430,0,3,NULL),(4593,'城关区',431,0,3,NULL),(4594,'堆龙德庆县',431,0,3,NULL),(4595,'墨竹工卡县',431,0,3,NULL),(4596,'尼木县',431,0,3,NULL),(4597,'当雄县',431,0,3,NULL),(4598,'曲水县',431,0,3,NULL),(4599,'林周县',431,0,3,NULL),(4600,'达孜县',431,0,3,NULL),(4601,'丁青县',432,0,3,NULL),(4602,'八宿县',432,0,3,NULL),(4603,'察雅县',432,0,3,NULL),(4604,'左贡县',432,0,3,NULL),(4605,'昌都县',432,0,3,NULL),(4606,'江达县',432,0,3,NULL),(4607,'洛隆县',432,0,3,NULL),(4608,'类乌齐县',432,0,3,NULL),(4609,'芒康县',432,0,3,NULL),(4610,'贡觉县',432,0,3,NULL),(4611,'边坝县',432,0,3,NULL),(4612,'乃东县',433,0,3,NULL),(4613,'加查县',433,0,3,NULL),(4614,'扎囊县',433,0,3,NULL),(4615,'措美县',433,0,3,NULL),(4616,'曲松县',433,0,3,NULL),(4617,'桑日县',433,0,3,NULL),(4618,'洛扎县',433,0,3,NULL),(4619,'浪卡子县',433,0,3,NULL),(4620,'琼结县',433,0,3,NULL),(4621,'贡嘎县',433,0,3,NULL),(4622,'错那县',433,0,3,NULL),(4623,'隆子县',433,0,3,NULL),(4624,'亚东县',434,0,3,NULL),(4625,'仁布县',434,0,3,NULL),(4626,'仲巴县',434,0,3,NULL),(4627,'南木林县',434,0,3,NULL),(4628,'吉隆县',434,0,3,NULL),(4629,'定日县',434,0,3,NULL),(4630,'定结县',434,0,3,NULL),(4631,'岗巴县',434,0,3,NULL),(4632,'康马县',434,0,3,NULL),(4633,'拉孜县',434,0,3,NULL),(4634,'日喀则市',434,0,3,NULL),(4635,'昂仁县',434,0,3,NULL),(4636,'江孜县',434,0,3,NULL),(4637,'白朗县',434,0,3,NULL),(4638,'聂拉木县',434,0,3,NULL),(4639,'萨嘎县',434,0,3,NULL),(4640,'萨迦县',434,0,3,NULL),(4641,'谢通门县',434,0,3,NULL),(4642,'嘉黎县',435,0,3,NULL),(4643,'安多县',435,0,3,NULL),(4644,'尼玛县',435,0,3,NULL),(4645,'巴青县',435,0,3,NULL),(4646,'比如县',435,0,3,NULL),(4647,'班戈县',435,0,3,NULL),(4648,'申扎县',435,0,3,NULL),(4649,'索县',435,0,3,NULL),(4650,'聂荣县',435,0,3,NULL),(4651,'那曲县',435,0,3,NULL),(4652,'噶尔县',436,0,3,NULL),(4653,'措勤县',436,0,3,NULL),(4654,'改则县',436,0,3,NULL),(4655,'日土县',436,0,3,NULL),(4656,'普兰县',436,0,3,NULL),(4657,'札达县',436,0,3,NULL),(4658,'革吉县',436,0,3,NULL),(4659,'墨脱县',437,0,3,NULL),(4660,'察隅县',437,0,3,NULL),(4661,'工布江达县',437,0,3,NULL),(4662,'朗县',437,0,3,NULL),(4663,'林芝县',437,0,3,NULL),(4664,'波密县',437,0,3,NULL),(4665,'米林县',437,0,3,NULL),(4666,'临潼区',438,0,3,NULL),(4667,'周至县',438,0,3,NULL),(4668,'户县',438,0,3,NULL),(4669,'新城区',438,0,3,NULL),(4670,'未央区',438,0,3,NULL),(4671,'灞桥区',438,0,3,NULL),(4672,'碑林区',438,0,3,NULL),(4673,'莲湖区',438,0,3,NULL),(4674,'蓝田县',438,0,3,NULL),(4675,'长安区',438,0,3,NULL),(4676,'阎良区',438,0,3,NULL),(4677,'雁塔区',438,0,3,NULL),(4678,'高陵县',438,0,3,NULL),(4679,'印台区',439,0,3,NULL),(4680,'宜君县',439,0,3,NULL),(4681,'王益区',439,0,3,NULL),(4682,'耀州区',439,0,3,NULL),(4683,'凤县',440,0,3,NULL),(4684,'凤翔县',440,0,3,NULL),(4685,'千阳县',440,0,3,NULL),(4686,'太白县',440,0,3,NULL),(4687,'岐山县',440,0,3,NULL),(4688,'扶风县',440,0,3,NULL),(4689,'渭滨区',440,0,3,NULL),(4690,'眉县',440,0,3,NULL),(4691,'金台区',440,0,3,NULL),(4692,'陇县',440,0,3,NULL),(4693,'陈仓区',440,0,3,NULL),(4694,'麟游县',440,0,3,NULL),(4695,'三原县',441,0,3,NULL),(4696,'干县',441,0,3,NULL),(4697,'兴平市',441,0,3,NULL),(4698,'彬县',441,0,3,NULL),(4699,'旬邑县',441,0,3,NULL),(4700,'杨陵区',441,0,3,NULL),(4701,'武功县',441,0,3,NULL),(4702,'永寿县',441,0,3,NULL),(4703,'泾阳县',441,0,3,NULL),(4704,'淳化县',441,0,3,NULL),(4705,'渭城区',441,0,3,NULL),(4706,'礼泉县',441,0,3,NULL),(4707,'秦都区',441,0,3,NULL),(4708,'长武县',441,0,3,NULL),(4709,'临渭区',442,0,3,NULL),(4710,'华县',442,0,3,NULL),(4711,'华阴市',442,0,3,NULL),(4712,'合阳县',442,0,3,NULL),(4713,'大荔县',442,0,3,NULL),(4714,'富平县',442,0,3,NULL),(4715,'潼关县',442,0,3,NULL),(4716,'澄城县',442,0,3,NULL),(4717,'白水县',442,0,3,NULL),(4718,'蒲城县',442,0,3,NULL),(4719,'韩城市',442,0,3,NULL),(4720,'吴起县',443,0,3,NULL),(4721,'子长县',443,0,3,NULL),(4722,'安塞县',443,0,3,NULL),(4723,'宜川县',443,0,3,NULL),(4724,'宝塔区',443,0,3,NULL),(4725,'富县',443,0,3,NULL),(4726,'延川县',443,0,3,NULL),(4727,'延长县',443,0,3,NULL),(4728,'志丹县',443,0,3,NULL),(4729,'洛川县',443,0,3,NULL),(4730,'甘泉县',443,0,3,NULL),(4731,'黄陵县',443,0,3,NULL),(4732,'黄龙县',443,0,3,NULL),(4733,'佛坪县',444,0,3,NULL),(4734,'勉县',444,0,3,NULL),(4735,'南郑县',444,0,3,NULL),(4736,'城固县',444,0,3,NULL),(4737,'宁强县',444,0,3,NULL),(4738,'汉台区',444,0,3,NULL),(4739,'洋县',444,0,3,NULL),(4740,'留坝县',444,0,3,NULL),(4741,'略阳县',444,0,3,NULL),(4742,'西乡县',444,0,3,NULL),(4743,'镇巴县',444,0,3,NULL),(4744,'佳县',445,0,3,NULL),(4745,'吴堡县',445,0,3,NULL),(4746,'子洲县',445,0,3,NULL),(4747,'定边县',445,0,3,NULL),(4748,'府谷县',445,0,3,NULL),(4749,'榆林市榆阳区',445,0,3,NULL),(4750,'横山县',445,0,3,NULL),(4751,'清涧县',445,0,3,NULL),(4752,'神木县',445,0,3,NULL),(4753,'米脂县',445,0,3,NULL),(4754,'绥德县',445,0,3,NULL),(4755,'靖边县',445,0,3,NULL),(4756,'宁陕县',446,0,3,NULL),(4757,'岚皋县',446,0,3,NULL),(4758,'平利县',446,0,3,NULL),(4759,'旬阳县',446,0,3,NULL),(4760,'汉滨区',446,0,3,NULL),(4761,'汉阴县',446,0,3,NULL),(4762,'白河县',446,0,3,NULL),(4763,'石泉县',446,0,3,NULL),(4764,'紫阳县',446,0,3,NULL),(4765,'镇坪县',446,0,3,NULL),(4766,'丹凤县',447,0,3,NULL),(4767,'商南县',447,0,3,NULL),(4768,'商州区',447,0,3,NULL),(4769,'山阳县',447,0,3,NULL),(4770,'柞水县',447,0,3,NULL),(4771,'洛南县',447,0,3,NULL),(4772,'镇安县',447,0,3,NULL),(4773,'七里河区',448,0,3,NULL),(4774,'城关区',448,0,3,NULL),(4775,'安宁区',448,0,3,NULL),(4776,'榆中县',448,0,3,NULL),(4777,'永登县',448,0,3,NULL),(4778,'皋兰县',448,0,3,NULL),(4779,'红古区',448,0,3,NULL),(4780,'西固区',448,0,3,NULL),(4781,'嘉峪关市',449,0,3,NULL),(4782,'永昌县',450,0,3,NULL),(4783,'金川区',450,0,3,NULL),(4784,'会宁县',451,0,3,NULL),(4785,'平川区',451,0,3,NULL),(4786,'景泰县',451,0,3,NULL),(4787,'白银区',451,0,3,NULL),(4788,'靖远县',451,0,3,NULL),(4789,'张家川回族自治县',452,0,3,NULL),(4790,'武山县',452,0,3,NULL),(4791,'清水县',452,0,3,NULL),(4792,'甘谷县',452,0,3,NULL),(4793,'秦安县',452,0,3,NULL),(4794,'秦州区',452,0,3,NULL),(4795,'麦积区',452,0,3,NULL),(4796,'凉州区',453,0,3,NULL),(4797,'古浪县',453,0,3,NULL),(4798,'天祝藏族自治县',453,0,3,NULL),(4799,'民勤县',453,0,3,NULL),(4800,'临泽县',454,0,3,NULL),(4801,'山丹县',454,0,3,NULL),(4802,'民乐县',454,0,3,NULL),(4803,'甘州区',454,0,3,NULL),(4804,'肃南裕固族自治县',454,0,3,NULL),(4805,'高台县',454,0,3,NULL),(4806,'华亭县',455,0,3,NULL),(4807,'崆峒区',455,0,3,NULL),(4808,'崇信县',455,0,3,NULL),(4809,'庄浪县',455,0,3,NULL),(4810,'泾川县',455,0,3,NULL),(4811,'灵台县',455,0,3,NULL),(4812,'静宁县',455,0,3,NULL),(4813,'敦煌市',456,0,3,NULL),(4814,'玉门市',456,0,3,NULL),(4815,'瓜州县（原安西县）',456,0,3,NULL),(4816,'肃北蒙古族自治县',456,0,3,NULL),(4817,'肃州区',456,0,3,NULL),(4818,'金塔县',456,0,3,NULL),(4819,'阿克塞哈萨克族自治县',456,0,3,NULL),(4820,'华池县',457,0,3,NULL),(4821,'合水县',457,0,3,NULL),(4822,'宁县',457,0,3,NULL),(4823,'庆城县',457,0,3,NULL),(4824,'正宁县',457,0,3,NULL),(4825,'环县',457,0,3,NULL),(4826,'西峰区',457,0,3,NULL),(4827,'镇原县',457,0,3,NULL),(4828,'临洮县',458,0,3,NULL),(4829,'安定区',458,0,3,NULL),(4830,'岷县',458,0,3,NULL),(4831,'渭源县',458,0,3,NULL),(4832,'漳县',458,0,3,NULL),(4833,'通渭县',458,0,3,NULL),(4834,'陇西县',458,0,3,NULL),(4835,'两当县',459,0,3,NULL),(4836,'宕昌县',459,0,3,NULL),(4837,'康县',459,0,3,NULL),(4838,'徽县',459,0,3,NULL),(4839,'成县',459,0,3,NULL),(4840,'文县',459,0,3,NULL),(4841,'武都区',459,0,3,NULL),(4842,'礼县',459,0,3,NULL),(4843,'西和县',459,0,3,NULL),(4844,'东乡族自治县',460,0,3,NULL),(4845,'临夏县',460,0,3,NULL),(4846,'临夏市',460,0,3,NULL),(4847,'和政县',460,0,3,NULL),(4848,'广河县',460,0,3,NULL),(4849,'康乐县',460,0,3,NULL),(4850,'永靖县',460,0,3,NULL),(4851,'积石山保安族东乡族撒拉族自治县',460,0,3,NULL),(4852,'临潭县',461,0,3,NULL),(4853,'卓尼县',461,0,3,NULL),(4854,'合作市',461,0,3,NULL),(4855,'夏河县',461,0,3,NULL),(4856,'玛曲县',461,0,3,NULL),(4857,'碌曲县',461,0,3,NULL),(4858,'舟曲县',461,0,3,NULL),(4859,'迭部县',461,0,3,NULL),(4860,'城东区',462,0,3,NULL),(4861,'城中区',462,0,3,NULL),(4862,'城北区',462,0,3,NULL),(4863,'城西区',462,0,3,NULL),(4864,'大通回族土族自治县',462,0,3,NULL),(4865,'湟中县',462,0,3,NULL),(4866,'湟源县',462,0,3,NULL),(4867,'乐都县',463,0,3,NULL),(4868,'互助土族自治县',463,0,3,NULL),(4869,'化隆回族自治县',463,0,3,NULL),(4870,'平安县',463,0,3,NULL),(4871,'循化撒拉族自治县',463,0,3,NULL),(4872,'民和回族土族自治县',463,0,3,NULL),(4873,'刚察县',464,0,3,NULL),(4874,'海晏县',464,0,3,NULL),(4875,'祁连县',464,0,3,NULL),(4876,'门源回族自治县',464,0,3,NULL),(4877,'同仁县',465,0,3,NULL),(4878,'尖扎县',465,0,3,NULL),(4879,'河南蒙古族自治县',465,0,3,NULL),(4880,'泽库县',465,0,3,NULL),(4881,'共和县',466,0,3,NULL),(4882,'兴海县',466,0,3,NULL),(4883,'同德县',466,0,3,NULL),(4884,'贵南县',466,0,3,NULL),(4885,'贵德县',466,0,3,NULL),(4886,'久治县',467,0,3,NULL),(4887,'玛多县',467,0,3,NULL),(4888,'玛沁县',467,0,3,NULL),(4889,'班玛县',467,0,3,NULL),(4890,'甘德县',467,0,3,NULL),(4891,'达日县',467,0,3,NULL),(4892,'囊谦县',468,0,3,NULL),(4893,'曲麻莱县',468,0,3,NULL),(4894,'杂多县',468,0,3,NULL),(4895,'治多县',468,0,3,NULL),(4896,'玉树县',468,0,3,NULL),(4897,'称多县',468,0,3,NULL),(4898,'乌兰县',469,0,3,NULL),(4899,'冷湖行委',469,0,3,NULL),(4900,'大柴旦行委',469,0,3,NULL),(4901,'天峻县',469,0,3,NULL),(4902,'德令哈市',469,0,3,NULL),(4903,'格尔木市',469,0,3,NULL),(4904,'茫崖行委',469,0,3,NULL),(4905,'都兰县',469,0,3,NULL),(4906,'兴庆区',470,0,3,NULL),(4907,'永宁县',470,0,3,NULL),(4908,'灵武市',470,0,3,NULL),(4909,'西夏区',470,0,3,NULL),(4910,'贺兰县',470,0,3,NULL),(4911,'金凤区',470,0,3,NULL),(4912,'大武口区',471,0,3,NULL),(4913,'平罗县',471,0,3,NULL),(4914,'惠农区',471,0,3,NULL),(4915,'利通区',472,0,3,NULL),(4916,'同心县',472,0,3,NULL),(4917,'盐池县',472,0,3,NULL),(4918,'青铜峡市',472,0,3,NULL),(4919,'原州区',473,0,3,NULL),(4920,'彭阳县',473,0,3,NULL),(4921,'泾源县',473,0,3,NULL),(4922,'西吉县',473,0,3,NULL),(4923,'隆德县',473,0,3,NULL),(4924,'中宁县',474,0,3,NULL),(4925,'沙坡头区',474,0,3,NULL),(4926,'海原县',474,0,3,NULL),(4927,'东山区',475,0,3,NULL),(4928,'乌鲁木齐县',475,0,3,NULL),(4929,'天山区',475,0,3,NULL),(4930,'头屯河区',475,0,3,NULL),(4931,'新市区',475,0,3,NULL),(4932,'水磨沟区',475,0,3,NULL),(4933,'沙依巴克区',475,0,3,NULL),(4934,'达坂城区',475,0,3,NULL),(4935,'乌尔禾区',476,0,3,NULL),(4936,'克拉玛依区',476,0,3,NULL),(4937,'独山子区',476,0,3,NULL),(4938,'白碱滩区',476,0,3,NULL),(4939,'吐鲁番市',477,0,3,NULL),(4940,'托克逊县',477,0,3,NULL),(4941,'鄯善县',477,0,3,NULL),(4942,'伊吾县',478,0,3,NULL),(4943,'哈密市',478,0,3,NULL),(4944,'巴里坤哈萨克自治县',478,0,3,NULL),(4945,'吉木萨尔县',479,0,3,NULL),(4946,'呼图壁县',479,0,3,NULL),(4947,'奇台县',479,0,3,NULL),(4948,'昌吉市',479,0,3,NULL),(4949,'木垒哈萨克自治县',479,0,3,NULL),(4950,'玛纳斯县',479,0,3,NULL),(4951,'米泉市',479,0,3,NULL),(4952,'阜康市',479,0,3,NULL),(4953,'博乐市',480,0,3,NULL),(4954,'温泉县',480,0,3,NULL),(4955,'精河县',480,0,3,NULL),(4956,'博湖县',481,0,3,NULL),(4957,'和硕县',481,0,3,NULL),(4958,'和静县',481,0,3,NULL),(4959,'尉犁县',481,0,3,NULL),(4960,'库尔勒市',481,0,3,NULL),(4961,'焉耆回族自治县',481,0,3,NULL),(4962,'若羌县',481,0,3,NULL),(4963,'轮台县',481,0,3,NULL),(4964,'乌什县',482,0,3,NULL),(4965,'库车县',482,0,3,NULL),(4966,'拜城县',482,0,3,NULL),(4967,'新和县',482,0,3,NULL),(4968,'柯坪县',482,0,3,NULL),(4969,'沙雅县',482,0,3,NULL),(4970,'温宿县',482,0,3,NULL),(4971,'阿克苏市',482,0,3,NULL),(4972,'阿瓦提县',482,0,3,NULL),(4973,'乌恰县',483,0,3,NULL),(4974,'阿克陶县',483,0,3,NULL),(4975,'阿合奇县',483,0,3,NULL),(4976,'阿图什市',483,0,3,NULL),(4977,'伽师县',484,0,3,NULL),(4978,'叶城县',484,0,3,NULL),(4979,'喀什市',484,0,3,NULL),(4980,'塔什库尔干塔吉克自治县',484,0,3,NULL),(4981,'岳普湖县',484,0,3,NULL),(4982,'巴楚县',484,0,3,NULL),(4983,'泽普县',484,0,3,NULL),(4984,'疏勒县',484,0,3,NULL),(4985,'疏附县',484,0,3,NULL),(4986,'英吉沙县',484,0,3,NULL),(4987,'莎车县',484,0,3,NULL),(4988,'麦盖提县',484,0,3,NULL),(4989,'于田县',485,0,3,NULL),(4990,'和田县',485,0,3,NULL),(4991,'和田市',485,0,3,NULL),(4992,'墨玉县',485,0,3,NULL),(4993,'民丰县',485,0,3,NULL),(4994,'洛浦县',485,0,3,NULL),(4995,'皮山县',485,0,3,NULL),(4996,'策勒县',485,0,3,NULL),(4997,'伊宁县',486,0,3,NULL),(4998,'伊宁市',486,0,3,NULL),(4999,'奎屯市',486,0,3,NULL),(5000,'察布查尔锡伯自治县',486,0,3,NULL),(5001,'尼勒克县',486,0,3,NULL),(5002,'巩留县',486,0,3,NULL),(5003,'新源县',486,0,3,NULL),(5004,'昭苏县',486,0,3,NULL),(5005,'特克斯县',486,0,3,NULL),(5006,'霍城县',486,0,3,NULL),(5007,'乌苏市',487,0,3,NULL),(5008,'和布克赛尔蒙古自治县',487,0,3,NULL),(5009,'塔城市',487,0,3,NULL),(5010,'托里县',487,0,3,NULL),(5011,'沙湾县',487,0,3,NULL),(5012,'裕民县',487,0,3,NULL),(5013,'额敏县',487,0,3,NULL),(5014,'吉木乃县',488,0,3,NULL),(5015,'哈巴河县',488,0,3,NULL),(5016,'富蕴县',488,0,3,NULL),(5017,'布尔津县',488,0,3,NULL),(5018,'福海县',488,0,3,NULL),(5019,'阿勒泰市',488,0,3,NULL),(5020,'青河县',488,0,3,NULL),(5021,'石河子市',489,0,3,NULL),(5022,'阿拉尔市',490,0,3,NULL),(5023,'图木舒克市',491,0,3,NULL),(5024,'五家渠市',492,0,3,NULL),(45055,'海外',35,0,2,NULL),(45056,'江浙沪',0,0,1,'华东');

/*Table structure for table `feiwa_arrival_notice` */

DROP TABLE IF EXISTS `feiwa_arrival_notice`;

CREATE TABLE `feiwa_arrival_notice` (
  `an_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '通知id',
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品id',
  `goods_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品名称',
  `member_id` int(10) unsigned NOT NULL COMMENT '会员id',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺id',
  `an_addtime` int(10) unsigned NOT NULL COMMENT '添加时间',
  `an_email` varchar(100) NOT NULL DEFAULT '' COMMENT '邮箱',
  `an_mobile` varchar(11) NOT NULL DEFAULT '' COMMENT '手机号',
  `an_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态 1到货通知，2预售',
  PRIMARY KEY (`an_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品到货通知表';

/*Data for the table `feiwa_arrival_notice` */

/*Table structure for table `feiwa_article` */

DROP TABLE IF EXISTS `feiwa_article`;

CREATE TABLE `feiwa_article` (
  `article_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引id',
  `ac_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '分类id',
  `article_url` varchar(100) DEFAULT NULL COMMENT '跳转链接',
  `article_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示，0为否，1为是，默认为1',
  `article_position` tinyint(4) NOT NULL DEFAULT '1' COMMENT '显示位置:1默认网站前台,2买家,3卖家,4全站',
  `article_sort` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  `article_title` varchar(100) DEFAULT NULL COMMENT '标题',
  `article_content` text COMMENT '内容',
  `article_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布时间',
  PRIMARY KEY (`article_id`),
  KEY `ac_id` (`ac_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='文章表';

/*Data for the table `feiwa_article` */

insert  into `feiwa_article`(`article_id`,`ac_id`,`article_url`,`article_show`,`article_position`,`article_sort`,`article_title`,`article_content`,`article_time`) values (6,2,'',1,1,255,'如何注册成为会员','如何注册成为会员',1449242303),(7,2,'',1,1,255,'如何搜索','如何搜索',1449242303),(8,2,'',1,1,255,'忘记密码','忘记密码',1449242303),(9,2,'',1,1,255,'我要买','我要买',1449242303),(10,2,'',1,1,255,'查看已购买商品','查看已购买商品',1449242303),(11,3,'',1,1,255,'如何管理店铺','如何管理店铺',1449242303),(12,3,'',1,1,255,'查看售出商品','查看售出商品',1449242303),(13,3,'',1,1,255,'如何发货','如何发货',1449242303),(14,3,'',1,1,255,'商城商品推荐','商城商品推荐',1449242303),(15,3,'',1,1,255,'如何申请开店','如何申请开店',1449242303),(16,4,'',1,1,255,'如何注册支付宝','如何注册支付宝',1449242303),(17,4,'',1,1,255,'在线支付','在线支付',1449242303),(18,6,'',1,1,255,'会员修改密码','会员修改密码',1449242303),(19,6,'',1,1,255,'会员修改个人资料','会员修改个人资料',1449242303),(20,6,'',1,1,255,'商品发布','商品发布',1449242303),(21,6,'',1,1,255,'修改收货地址','修改收货地址',1449242303),(22,7,'',1,1,255,'关于我们','我们',1449242303),(23,7,'',1,1,255,'联系我们','<p>欢迎您对我们的站点、工作、产品和服务提出自己宝贵的意见或建议。我们将给予您及时答复。同时也欢迎您到我们公司来洽商业务。</p>\r\n<p><br />\r\n',1449242303),(24,7,'',1,1,255,'招聘英才','<dl> <h3>PHP程序员</h3>\r\n<dt>职位要求： <dd>熟悉PHP5开发语言；<br />\r\n熟悉MySQL5数据库，同时熟悉sqlserver，orac',1449242303),(25,7,'',1,1,255,'合作及洽谈','<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xxx希望与服务代理商、合作伙伴并肩合作，携手开拓日益广阔的网络购物软件市场。如果您拥有好的建议，拥有丰富渠道资源、拥有众多目标客户、拥有相应的市场资源，并希望与xxxx进行深度业务合作， 欢迎成为xxxx业务合作伙伴，请联系。</p>\r\n<p>&nbsp;</p>\r\n<p><strong>公司名称</strong>： xx官方 <br />\r\n<strong>通信地址</strong>： xxxx <br />\r\n<strong>邮政编码</strong>： xxxx <br />\r\n<strong>客服QQ</strong>： xxxx <br />\r\n<strong>商务洽谈</strong>： xxxx <br />\r\n</p>',1449242303),(26,5,'',1,1,255,'联系卖家','联系卖家',1449242303),(28,4,'',1,1,255,'分期付款','分期付款<br />',1449242303),(29,4,'',1,1,255,'邮局汇款','邮局汇款<br />',1449242303),(30,4,'',1,1,255,'公司转账','公司转账<br />',1449242303),(31,5,'',1,1,255,'退换货政策','退换货政策',1449242303),(32,5,'',1,1,255,'退换货流程','退换货流程',1449242303),(33,5,'',1,1,255,'返修/退换货','返修/退换货',1449242303),(34,5,'',1,1,255,'退款申请','退款申请',1449242303),(36,1,'',1,1,255,'管理功能说明','管理功能说明22333',1449242303),(37,1,'',1,1,255,'如何扩充水印字体库','<p>\r\n	水印应该如何扩充？\r\n</p>\r\n<p>\r\n	下面根据我的节奏来告诉你，如何正确的使用水印扩充\r\n</p>',1449242303),(38,1,'',1,1,255,'提示信息','提示信息',1449242303),(39,2,'',1,1,255,'积分细则','积分细则积分细则',1449242303),(40,2,'',1,1,255,'积分兑换说明','积分兑换说明',1449242303),(41,1,'',1,1,255,'功能使用说明','功能使用说明',1449242303),(42,1,'',1,1,254,'天府大件运营中心开仓公告','天府大件运营中心开仓公告',1455626442),(43,3,'',1,1,255,'元旦通告','元旦促销<span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span><span>元旦促销</span>',1515548183);

/*Table structure for table `feiwa_article_class` */

DROP TABLE IF EXISTS `feiwa_article_class`;

CREATE TABLE `feiwa_article_class` (
  `ac_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引ID',
  `ac_code` varchar(20) DEFAULT NULL COMMENT '分类标识码',
  `ac_name` varchar(100) NOT NULL DEFAULT '' COMMENT '分类名称',
  `ac_parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `ac_sort` tinyint(1) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  PRIMARY KEY (`ac_id`),
  KEY `ac_parent_id` (`ac_parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='文章分类表';

/*Data for the table `feiwa_article_class` */

insert  into `feiwa_article_class`(`ac_id`,`ac_code`,`ac_name`,`ac_parent_id`,`ac_sort`) values (1,'notice','商城公告',0,1),(2,'member','新手指南',0,2),(3,'store','商家中心',0,3),(4,'payment','支付方式',0,4),(5,'sold','售后服务',0,5),(6,'service','购物指南',0,6),(7,'about','关于我们',0,7),(9,NULL,'测试',2,255),(10,NULL,'测试1',0,255);

/*Table structure for table `feiwa_attribute` */

DROP TABLE IF EXISTS `feiwa_attribute`;

CREATE TABLE `feiwa_attribute` (
  `attr_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '属性id',
  `attr_name` varchar(100) NOT NULL DEFAULT '' COMMENT '属性名称',
  `type_id` int(10) unsigned NOT NULL COMMENT '所属类型id',
  `attr_value` text NOT NULL COMMENT '属性值列',
  `attr_show` tinyint(1) unsigned NOT NULL COMMENT '是否显示。0为不显示、1为显示',
  `attr_sort` tinyint(1) unsigned NOT NULL COMMENT '排序',
  PRIMARY KEY (`attr_id`),
  KEY `attr_id` (`attr_id`,`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='商品属性表';

/*Data for the table `feiwa_attribute` */

insert  into `feiwa_attribute`(`attr_id`,`attr_name`,`type_id`,`attr_value`,`attr_show`,`attr_sort`) values (3,'分类',3,'牛奶粉,羊奶粉,其它',1,0),(4,'国产/进口',3,'国产,进口',1,0),(5,'包装',3,'袋装,盒装,瓶装',1,0);

/*Table structure for table `feiwa_attribute_value` */

DROP TABLE IF EXISTS `feiwa_attribute_value`;

CREATE TABLE `feiwa_attribute_value` (
  `attr_value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '属性值id',
  `attr_value_name` varchar(100) DEFAULT '' COMMENT '属性值名称',
  `attr_id` int(10) unsigned NOT NULL COMMENT '所属属性id',
  `type_id` int(10) unsigned NOT NULL COMMENT '类型id',
  `attr_value_sort` tinyint(1) unsigned NOT NULL COMMENT '属性值排序',
  PRIMARY KEY (`attr_value_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='商品属性值表';

/*Data for the table `feiwa_attribute_value` */

insert  into `feiwa_attribute_value`(`attr_value_id`,`attr_value_name`,`attr_id`,`type_id`,`attr_value_sort`) values (3,'牛奶粉',3,3,0),(4,'羊奶粉',3,3,0),(5,'其它',3,3,0),(7,'国产',4,3,0),(8,'进口',4,3,0),(11,'袋装',5,3,0),(12,'盒装',5,3,0),(13,'瓶装',5,3,0);

/*Table structure for table `feiwa_brand` */

DROP TABLE IF EXISTS `feiwa_brand`;

CREATE TABLE `feiwa_brand` (
  `brand_id` mediumint(11) NOT NULL AUTO_INCREMENT COMMENT '索引ID',
  `brand_name` varchar(100) DEFAULT NULL COMMENT '品牌名称',
  `brand_initial` varchar(1) NOT NULL DEFAULT '' COMMENT '品牌首字母',
  `brand_class` varchar(50) DEFAULT NULL COMMENT '类别名称',
  `brand_pic` varchar(100) DEFAULT NULL COMMENT '图片',
  `brand_sort` tinyint(3) unsigned DEFAULT '0' COMMENT '排序',
  `brand_recommend` tinyint(1) DEFAULT '0' COMMENT '推荐，0为否，1为是，默认为0',
  `store_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `brand_apply` tinyint(1) NOT NULL DEFAULT '1' COMMENT '品牌申请，0为申请中，1为通过，默认为1，申请功能是会员使用，系统后台默认为1',
  `class_id` int(10) unsigned DEFAULT '0' COMMENT '所属分类id',
  `show_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '品牌展示类型 0表示图片 1表示文字 ',
  `brand_bgpic` varchar(100) DEFAULT '/data/upload/mall/editor/brand_default_max.jpg',
  `brand_xbgpic` varchar(100) DEFAULT '/data/upload/mall/editor/brand_default_small.jpg',
  `brand_tjstore` varchar(100) DEFAULT '请于品牌管理里编辑我',
  `brand_introduction` varchar(100) DEFAULT 'FeiWa提醒您：你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改',
  PRIMARY KEY (`brand_id`)
) ENGINE=InnoDB AUTO_INCREMENT=367 DEFAULT CHARSET=utf8 COMMENT='品牌表';

/*Data for the table `feiwa_brand` */

insert  into `feiwa_brand`(`brand_id`,`brand_name`,`brand_initial`,`brand_class`,`brand_pic`,`brand_sort`,`brand_recommend`,`store_id`,`brand_apply`,`class_id`,`show_type`,`brand_bgpic`,`brand_xbgpic`,`brand_tjstore`,`brand_introduction`) values (79,'justyle','J','服饰鞋帽','04397468710494742_sm.jpg',0,0,0,1,1,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(80,'享爱.','H','服饰鞋帽','04397468934349942_sm.jpg',0,0,0,1,1,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(81,'派丽蒙','P','女装','04397469152627878_sm.jpg',0,0,0,1,4,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(82,'康妮雅','K','女装','04397471448679692_sm.jpg',0,0,0,1,4,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(83,'秀秀美','X','女装','04397471716977022_sm.jpg',0,0,0,1,4,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(84,'阿迪达斯','A','服饰鞋帽','04397471910652190_sm.jpg',0,1,0,1,1,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(85,'猫人','M','内衣','04397472152849925_sm.jpg',0,0,0,1,6,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(86,'茵曼（INMAN）','Y','T恤','04397472336312422_sm.jpg',0,0,0,1,12,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(87,'Hanes恒适','H','服饰鞋帽','04397472577467506_sm.jpg',0,0,0,1,1,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(88,'缪诗','M','休闲鞋','04397472716852803_sm.jpg',0,0,0,1,74,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(89,'真维斯','Z','服饰鞋帽','04397472838086984_sm.jpg',0,1,0,1,1,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(90,'金利来','J','西服','04397473042647991_sm.jpg',0,0,0,1,47,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(91,'其乐','Q','休闲鞋','04397473331842699_sm.jpg',0,1,0,1,109,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(92,'Newbalance','N','功能鞋','04397473633585549_sm.jpg',0,1,0,1,112,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(93,'百丽','B','女鞋','04398088925179484_sm.png',0,1,0,1,8,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(94,'七匹狼','Q','服饰鞋帽','04398089136939537_sm.jpg',0,1,0,1,1,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(95,'李宁','L','运动','04398089270610035_sm.jpg',0,0,0,1,7,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(96,'佐丹奴','Z','服饰鞋帽','04398089412399747_sm.jpg',0,1,0,1,1,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(97,'百思图','B','休闲鞋','04398089574801901_sm.jpg',0,0,0,1,93,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(98,'斯波帝卡','S','男装','04398089726299223_sm.jpg',0,0,0,1,5,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(99,'梦特娇','M','男装','04398089942879365_sm.jpg',0,1,0,1,5,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(100,'宝姿','B','服饰鞋帽','04398090061006740_sm.jpg',0,1,0,1,1,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(101,'爱帝','A','服饰鞋帽','04398090218578648_sm.jpg',0,0,0,1,1,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(102,'她他/tata','T','高跟鞋','04398090459092275_sm.jpg',0,0,0,1,91,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(103,'ELLE HOME','E','服饰鞋帽','04398090611386532_sm.jpg',0,1,0,1,1,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(104,'esprit','E','女装','04398090828687339_sm.jpg',0,1,0,1,4,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(105,'westside','W','服饰鞋帽','04398090975832253_sm.jpg',0,0,0,1,1,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(106,'RDK','P','睡衣','04398091763582415_sm.jpg',0,0,0,1,62,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(107,'皮尔卡丹','P','风衣','04398091877500105_sm.jpg',0,0,0,1,43,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(108,'挪巍','N','服饰鞋帽','04398091973797599_sm.jpg',0,0,0,1,1,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(113,'波斯顿','B','个护化妆','04398099293923325_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(114,'薇姿','W','个护化妆','04398099463167230_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(115,'相宜本草','X','个护化妆','04398099611242673_sm.jpg',0,1,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(116,'Dior','D','个护化妆','04398099738566948_sm.jpg',0,1,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(117,'苏菲','S','个护化妆','04398099870651075_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(118,'faceshop','F','个护化妆','04398100051941493_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(119,'芙丽芳丝','F','个护化妆','04398100178308363_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(120,'娇爽','J','个护化妆','04398100362129645_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(121,'卡尼尔','K','个护化妆','04398100483927289_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(122,'纪梵希','J','个护化妆','04398100614445814_sm.jpg',0,1,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(123,'护舒宝','H','个护化妆','04398100738554064_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(124,'兰蔻','L','个护化妆','04398100899214207_sm.jpg',0,1,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(125,'娇兰','J','个护化妆','04398101035858820_sm.jpg',0,1,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(126,'高丝洁','G','个护化妆','04398101363358081_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(127,'妮维雅','N','个护化妆','04398101539246004_sm.jpg',0,1,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(128,'高丝','G','个护化妆','04398101708424765_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(129,'狮王','S','个护化妆','04398101929845854_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(130,'雅顿','Y','个护化妆','04398102086535787_sm.jpg',0,1,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(131,'M.A.C','M','个护化妆','04398102231196519_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(132,'李施德林','L','个护化妆','04398102411008632_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(133,'雅诗兰黛','Y','个护化妆','04398102581821577_sm.jpg',0,1,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(134,'MISS FACE','M','个护化妆','04398102756025036_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(135,'佳洁士','J','个护化妆','04398102918746492_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(136,'资生堂','X','个护化妆','04398103163925153_sm.jpg',0,1,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(137,'倩碧','Q','个护化妆','04398103335196758_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(138,'benefit','B','个护化妆','04398103525876196_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(139,'SISLEY','S','个护化妆','04398103731155516_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(140,'爱丽','A','个护化妆','04398103883736888_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(141,'BOBBI BROWN','B','个护化妆','04398104034802420_sm.jpg',0,0,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(142,'SK-ll','S','个护化妆','04398104206717960_sm.jpg',0,1,0,1,470,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(143,'施华洛世奇','S','珠宝手表','04398116735872287_sm.jpg',0,1,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(144,'万宝龙','W','珠宝手表','04398116855649611_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(145,'CK','C','珠宝手表','04398116986166995_sm.jpg',0,1,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(146,'Disney','D','珠宝手表','04398117134560677_sm.jpg',0,1,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(147,'佐卡伊','Z','珠宝手表','04398117259027285_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(148,'ZIPPO','Z','','04398117390207814_sm.gif',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(149,'梅花','M','珠宝手表','04398117504203345_sm.jpg',0,1,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(150,'高仕','G','珠宝手表','04398117735732690_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(151,'宝玑','B','珠宝手表','04398117910949174_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(152,'一生一石','Y','珠宝手表','04398118118206423_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(153,'IDee','I','珠宝手表','04398118344918440_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(154,'elle','E','珠宝手表','04398118494505137_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(155,'卡西欧','K','珠宝手表','04398118617326698_sm.jpg',0,1,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(156,'爱卡','A','珠宝手表','04398118792328978_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(157,'帝舵','D','珠宝手表','04398118894311290_sm.jpg',0,1,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(158,'新秀','X','珠宝手表','04398119032319322_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(159,'九钻','J','珠宝手表','04398119151718735_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(160,'卡地亚','K','珠宝手表','04398119311706852_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(161,'蓝色多瑙河','L','珠宝手表','04398119501897486_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(162,'浪琴','L','珠宝手表','04398119677440904_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(163,'百利恒','B','珠宝手表','04398119859319840_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(164,'欧米茄','O','珠宝手表','04398119996858692_sm.jpg',0,1,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(165,'tissot','T','珠宝手表','04398120131178815_sm.jpg',0,1,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(166,'新光饰品','X','珠宝手表','04398120247306694_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(167,'英雄','Y','珠宝手表','04398120419590838_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(168,'瑞士军刀','R','珠宝手表','04398120584040229_sm.gif',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(169,'斯沃琪','S','珠宝手表','04398121090096799_sm.jpg',0,1,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(170,'阿玛尼','A','珠宝手表','04398121209932680_sm.jpg',0,1,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(171,'亨得利','H','珠宝手表','04398125089603514_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(172,'lux-women','L','珠宝手表','04398125296052150_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(173,'ooh Dear','O','珠宝手表','04398125473712411_sm.jpg',0,0,0,1,530,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(174,'acer','A','数码办公','04398155389308089_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(175,'清华同方','Q','数码办公','04398155613517981_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(176,'富士通','F','数码办公','04398155751072786_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(177,'微软','W','数码办公','04398155862912765_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(178,'得力','D','数码办公','04398156045665837_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(179,'DELL','D','数码办公','04398156232757027_sm.jpg',0,1,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(180,'ThinkPad','T','数码办公','04398156358858442_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(181,'联想打印机','L','数码办公','04398156503421310_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(182,'金士顿','J','数码办公','04398156705753579_sm.jpg',0,1,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(183,'TP-LINK','T','数码办公','04398156873572761_sm.jpg',0,1,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(184,'华硕','H','数码办公','04398157012150899_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(185,'罗技','L','数码办公','04398157235673753_sm.jpg',0,1,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(186,'D-Link','D','数码办公','04398157356404105_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(187,'雷蛇','L','数码办公','04398157472174891_sm.jpg',0,1,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(188,'IT-CEO','I','数码办公','04398157595321784_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(189,'hyundri','H','数码办公','04398157712394024_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(190,'惠普','H','数码办公','04398157881561725_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(191,'迈乐','M','数码办公','04398158065769057_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(192,'爱普生','A','数码办公','04398158266047493_sm.jpg',0,1,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(193,'三木','S','数码办公','04398158379932048_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(194,'忆捷','Y','数码办公','04398158508475720_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(195,'佰科','B','数码办公','04398158666713881_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(196,'飞利浦','F','数码办公','04398158808225051_sm.jpg',0,1,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(197,'雷柏','L','数码办公','04398158987559915_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(198,'双飞燕','S','数码办公','04398159147857437_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(199,'网件','W','数码办公','04398159314915358_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(200,'山泽','S','数码办公','04398159479959395_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(201,'松下','S','数码办公','04398159595550035_sm.jpg',0,1,0,1,256,0,'/data/upload/mall/editor/20160203110827_40003.jpg','/data/upload/mall/editor/20160203110816_22733.jpg','女神颜值 工匠品质','Panasonic（松下电器产业株式会社），著名的日本电子产品制造商。自1918年松下幸之助创业，发展品牌产品涉及家电、数码视听电子、办公产品、航空等诸多领域而享誉全球。2006年度《世界品牌500强'),(202,'TPOS','T','数码办公','04398159795526441_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(203,'富勒','F','数码办公','04398159927301628_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(204,'北通','B','数码办公','04398160061664664_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(205,'romoss','R','数码办公','04398160187629402_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(206,'索爱','S','数码办公','04398160348310562_sm.gif',0,1,0,1,256,0,'/data/upload/mall/editor/20160203111547_89189.jpg','/data/upload/mall/editor/20160203111537_67222.jpg','高颜值也高音质','beats by dr. dre是由欧美传奇HIPHOP制作人Dr. Dre创办的多媒体公司，它与Monster公司合作的Beats，在音乐爱好者中享有相当高的声誉，一改许多人对于高端专业视听产品冷冰'),(207,'台电','T','数码办公','04398160575221477_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(208,'SAMSUNG 三星','S','数码办公','04398160720944823_sm.jpg',0,1,0,1,256,0,'/data/upload/mall/editor/20160203111150_31104.jpg','/data/upload/mall/editor/20160203111140_85333.jpg','韩国人的国民神器','SAMSUNG诞生于韩国的国际一流企业集团，在电子领域有不可小觑的地位，旗下商品涵盖生活的各个方面。本着为消费者带去便利的宗旨不断研发新产品。支撑三星电子快速发展的是先导尖端技术趋势的设计，三星自上世'),(209,'理光','L','数码办公','04398160857676307_sm.gif',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(210,'飞毛腿','F','数码办公','04398161023292593_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(211,'阿尔卡特','A','数码办公','04398161143888870_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(212,'诺基亚','N','数码办公','04398161259006857_sm.gif',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(213,'摩托罗拉','M','数码办公','04398161410885588_sm.gif',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(214,'苹果','P','数码办公','04398168923750202_sm.png',0,1,0,1,256,0,'/data/upload/mall/editor/20160203113133_14847.jpg','/data/upload/mall/editor/20160203113111_92968.jpg','数码创新的次元产品','Apple 凭借 iPhone、iPad、Mac、Apple Watch、iOS、OS X、watchOS 等产品引领了全球创新'),(215,'HTC','H','数码办公','04398169850955399_sm.jpg',0,0,0,1,256,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(216,'九阳','J','家用电器','04399844516657174_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(217,'索尼','S','家用电器','04399833099806870_sm.gif',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(218,'格力','G','家用电器','04399833262328490_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(219,'夏普','H','家用电器','04399833425234004_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(220,'美的','M','家用电器','04399833601121412_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(221,'博朗','B','家用电器','04399833768343488_sm.gif',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(222,'TCL','T','家用电器','04399833953558287_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(223,'欧姆龙','O','家用电器','04399834117653152_sm.gif',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(224,'苏泊尔','S','家用电器','04399834427362760_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(225,'伊莱克斯','Y','家用电器','04399834676870929_sm.gif',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(226,'艾力斯特','A','家用电器','04399835435836906_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(227,'西门子','X','家用电器','04399835594337307_sm.gif',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(228,'三菱电机','S','家用电器','04399835807315767_sm.gif',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(229,'奔腾','S','家用电器','04399836030618924_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(230,'三洋','S','家用电器','04399836185660687_sm.gif',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(231,'大金','D','家用电器','04399836403301996_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(232,'三星电器','S','家用电器','04399836619819860_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(233,'海尔','H','家用电器','04399837024444210_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(234,'格兰仕','G','家用电器','04399837873721609_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(235,'海信','H','家用电器','04399838032416433_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(236,'博世','B','家用电器','04399838243363042_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(237,'老板','L','家用电器','04399838473427197_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(238,'奥克斯','A','家用电器','04399838633002147_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(239,'LG','L','家用电器','04399838782976323_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(240,'创维','C','家用电器','04399839110204841_sm.jpg',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(241,'松下电器','S','家用电器','04399839604098052_sm.gif',0,0,0,1,308,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(242,'中国联通','Z','虚拟充值','04399847297781057_sm.jpg',0,0,0,1,1037,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(243,'中国电信','Z','虚拟充值','04399847472066981_sm.jpg',0,0,0,1,1037,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(244,'中国移动','Z','虚拟充值','04399847612667714_sm.jpg',0,0,0,1,1037,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(245,'一品玉','Y','食品饮料','04399854316938195_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(246,'金奥力','J','食品饮料','04399854503149255_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(247,'北大荒','B','食品饮料','04399854638913791_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(248,'健安喜','J','食品饮料','04399854806939714_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(249,'屯河','T','食品饮料','04399854945115195_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(250,'养生堂','Y','食品饮料','04399855140966866_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(251,'同庆和堂','T','食品饮料','04399855332734276_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(252,'黄飞红','H','食品饮料','04399855513686549_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(253,'乐力','L','食品饮料','04399855699218750_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(254,'汤臣倍健','T','食品饮料','04399855941379731_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(255,'康比特','K','食品饮料','04399856135110739_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(256,'喜瑞','X','食品饮料','04399856323294870_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(257,'同仁堂','T','食品饮料','04399856454919811_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(258,'白兰氏','B','食品饮料','04399856638765013_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(259,'Lumi','L','食品饮料','04399856804968818_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(260,'新西兰十一坊','X','食品饮料','04399856948519746_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(261,'自然之宝','Z','食品饮料','04399857092677752_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(262,'善存','S','食品饮料','04399857246559825_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(263,'长城葡萄酒','C','食品饮料','04399857399887704_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(264,'凯镛','K','食品饮料','04399857579422195_sm.jpg',0,0,0,1,593,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(267,'惠氏','H','母婴用品','04399878077210018_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(268,'lala布书','L','母婴用品','04399878481448839_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(269,'美赞臣','M','母婴用品','04399878617014779_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(270,'好奇','H','母婴用品','04399878791943342_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(271,'多美','D','母婴用品','04399878980307860_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(272,'嘉宝','J','母婴用品','04399879383821119_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(273,'孩之宝','H','母婴用品','04399879573077116_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(274,'嗳呵','A','母婴用品','04399879712252398_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(275,'美斯特伦','M','母婴用品','04399879861821747_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(276,'乐高','L','母婴用品','04399880083330972_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(277,'芭比','B','母婴用品','04399880244694286_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(278,'NUK','N','母婴用品','04399880420786755_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(279,'魔法玉米','M','母婴用品','04399880604749242_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(280,'宝贝第一','B','母婴用品','04399880757446523_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(281,'强生','Q','母婴用品','04399880892528550_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(282,'澳优','A','母婴用品','04399881087936122_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(283,'木马智慧','M','母婴用品','04399881246572965_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(284,'百立乐','B','母婴用品','04399881709264364_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(285,'雀巢','Q','母婴用品','04399881950170970_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(286,'帮宝适','B','母婴用品','04399882134949479_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(287,'万代','W','母婴用品','04399882291234767_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(288,'亲贝','Q','母婴用品','04399882442124015_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(289,'十月天使','S','母婴用品','04399882581513663_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(290,'多美滋','D','母婴用品','04399882826616164_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(291,'星辉','X','母婴用品','04399882966084988_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(292,'布朗博士','B','母婴用品','04399883157641690_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(293,'新安怡','X','母婴用品','04399883297614786_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(294,'费雪','F','母婴用品','04399883534332035_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(295,'Hipp','H','母婴用品','04399883690219411_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(296,'新大王','X','母婴用品','04399883855598553_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(297,'雅培','Y','母婴用品','04399884035362889_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(298,'亨氏','H','母婴用品','04399884182772511_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(299,'十月妈咪','S','母婴用品','04399884360526483_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(300,'好孩子','H','母婴用品','04399884512865285_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(301,'婴姿坊','Y','母婴用品','04399884644632532_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(302,'妈咪宝贝','M','母婴用品','04399884799920935_sm.jpg',0,0,0,1,959,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(303,'直觉','Z','运动健康','04399889262024650_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(304,'世达球','S','运动健康','04399889410183423_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(305,'悠度','Y','运动健康','04399889744222357_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(306,'威尔胜','W','运动健康','04399889941968796_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(307,'远洋瑜伽','Y','运动健康','04399890266352034_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(308,'信乐','X','运动健康','04399890429362085_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(309,'诺可文','N','运动健康','04399890643925803_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(310,'艾威','A','运动健康','04399890796771131_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(311,'LELO','L','运动健康','04399890952734102_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(312,'乔山','Q','运动健康','04399891122713199_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(313,'皮克朋','P','运动健康','04399891285897466_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(314,'捷安特','J','运动健康','04399891438458842_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(315,'开普特','K','运动健康','04399891598799644_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(316,'火枫','H','运动健康','04399891771381530_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(317,'INDEED','I','运动健康','04399891911058029_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(318,'欧亚马','O','运动健康','04399892067310657_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(319,'李斯特','L','运动健康','04399892199751417_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(320,'乐美福','L','运动健康','04399892359082323_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(321,'以比赞','Y','运动健康','04399892526357198_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(322,'皮尔瑜伽','P','运动健康','04399893307910546_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(323,'以诗萜','Y','运动健康','04399893452531024_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(324,'斯伯丁','S','运动健康','04399893596931049_sm.jpg',0,0,0,1,662,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(326,'玛克','M','','04399902137097199_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(327,'美好家','M','','04399902244747580_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(328,'溢彩年华','Y','','04399902391635130_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(329,'欧司朗','O','','04399902537418591_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(330,'世家洁具','S','','04399902668760247_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(331,'天堂伞','T','','04399902780394855_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(332,'慧乐家','H','','04399902896835151_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(333,'希格','X','','04399903024936544_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(334,'生活诚品','S','','04399903153847612_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(335,'爱仕达','A','','04399903259361371_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(336,'罗莱','L','','04399903404912119_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(337,'索客','S','','04399903541756673_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(338,'好事达','H','','04399903715622158_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(339,'安睡宝','A','','04399903832203331_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(340,'博洋家纺','B','','04399903956723469_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(341,'空间大师','K','','04399904058344749_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(342,'富安娜','F','','04399904168163421_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(343,'三光云彩','S','','04399904279499345_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(344,'乔曼帝','Q','','04399904423386126_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(345,'乐扣乐扣','L','','04399904614221217_sm.jpg',0,0,0,1,0,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(348,'奥唯嘉（Ovega）','A','文胸','04431812331259168_sm.jpg',0,0,0,1,58,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(351,'曼妮芬（ManniForm）','M','内衣','04431810033957836_sm.jpg',0,0,0,1,6,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(352,'婷美（TINGMEI）','T','内衣','04431809546541815_sm.png',0,0,0,1,6,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(353,'古今','G','内衣','04431807497959652_sm.jpg',0,0,0,1,6,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(358,'金史密斯（KINGSMITH）','J','健身器械','04420592440315393_small.gif',0,0,4,1,691,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(359,'周大福','Z','纯金K金饰品','04420650490304114_sm.jpg',0,0,0,1,532,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(360,'周生生','Z','纯金K金饰品','04420650201635924_sm.jpg',0,0,0,1,532,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(364,'BH (必艾奇)','B','运动器械','04420633630909218_small.jpg',0,0,4,1,665,0,'/data/upload/mall/editor/brand_default_max.jpg','/data/upload/mall/editor/brand_default_small.jpg','请于品牌管理里编辑我','很抱歉，你当前的品牌介绍并没有填写！使用默认的这些会出现在你的眼前，请于后台进行修改'),(365,'惠氏（Wyeth）','H','奶粉','05804030845913347_sm.jpg',0,0,0,1,470,0,'','','',''),(366,'贝因美（Beingmate）','B','奶粉','05804031757914360_sm.png',0,0,0,1,470,0,'','','','贝因美（Beingmate）');

/*Table structure for table `feiwa_cart` */

DROP TABLE IF EXISTS `feiwa_cart`;

CREATE TABLE `feiwa_cart` (
  `cart_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '购物车id',
  `buyer_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '买家id',
  `store_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '店铺id',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `goods_name` varchar(100) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品价格',
  `goods_num` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT '购买商品数量',
  `goods_image` varchar(100) NOT NULL DEFAULT '' COMMENT '商品图片',
  `bl_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '组合套装ID',
  PRIMARY KEY (`cart_id`),
  KEY `member_id` (`buyer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='购物车数据表';

/*Data for the table `feiwa_cart` */

insert  into `feiwa_cart`(`cart_id`,`buyer_id`,`store_id`,`store_name`,`goods_id`,`goods_name`,`goods_price`,`goods_num`,`goods_image`,`bl_id`) values (1,1,6,'商城',100220,'运动摄像机','4666.00',3,'6_05641606730414492.jpg',0),(2,1,6,'商城',100199,'户外休闲鞋厚底运动鞋','229.00',3,'6_05641551995810917.jpg',0);

/*Table structure for table `feiwa_chain` */

DROP TABLE IF EXISTS `feiwa_chain`;

CREATE TABLE `feiwa_chain` (
  `chain_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '门店id',
  `store_id` int(10) unsigned NOT NULL COMMENT '所属店铺id',
  `chain_user` varchar(50) NOT NULL DEFAULT '' COMMENT '登录名',
  `chain_pwd` char(32) NOT NULL DEFAULT '' COMMENT '登录密码',
  `chain_name` varchar(50) NOT NULL DEFAULT '' COMMENT '门店名称',
  `chain_img` varchar(50) NOT NULL DEFAULT '' COMMENT '门店图片',
  `area_id_1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '一级地区id',
  `area_id_2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '二级地区id',
  `area_id_3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '三级地区id',
  `area_id_4` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '四级地区id',
  `area_id` int(10) unsigned NOT NULL COMMENT '地区id',
  `area_info` varchar(50) NOT NULL DEFAULT '' COMMENT '地区详情',
  `chain_address` varchar(50) NOT NULL DEFAULT '' COMMENT '详细地址',
  `chain_phone` varchar(100) NOT NULL DEFAULT '' COMMENT '联系方式',
  `chain_opening_hours` varchar(100) NOT NULL DEFAULT '' COMMENT '营业时间',
  `chain_traffic_line` varchar(100) NOT NULL DEFAULT '' COMMENT '交通线路',
  PRIMARY KEY (`chain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='店铺门店表';

/*Data for the table `feiwa_chain` */

insert  into `feiwa_chain`(`chain_id`,`store_id`,`chain_user`,`chain_pwd`,`chain_name`,`chain_img`,`area_id_1`,`area_id_2`,`area_id_3`,`area_id_4`,`area_id`,`area_info`,`chain_address`,`chain_phone`,`chain_opening_hours`,`chain_traffic_line`) values (2,1,'seller_dian1','d8bbc2121fa8e1b9738aa71480d58c44','seller门店1','05639716010995413.jpg',9,39,157,0,157,'上海 上海市 松江区','荣东路','31313131','9-5',''),(3,10,'tianhe1','d042bf849816a37fbf3e2945cfa0f29a','天河林和西点','05686554704671520.jpg',19,289,3040,0,3040,'广东 广州市 天河区','林和西路耀中广场','020-11111111','9：00-18:00','');

/*Table structure for table `feiwa_chain_stock` */

DROP TABLE IF EXISTS `feiwa_chain_stock`;

CREATE TABLE `feiwa_chain_stock` (
  `chain_id` int(10) unsigned NOT NULL COMMENT '门店id',
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品id',
  `goods_commonid` int(10) unsigned NOT NULL COMMENT '商品SPU',
  `stock` int(10) NOT NULL COMMENT '库存',
  PRIMARY KEY (`chain_id`,`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='门店商品库存表';

/*Data for the table `feiwa_chain_stock` */

/*Table structure for table `feiwa_chat_log` */

DROP TABLE IF EXISTS `feiwa_chat_log`;

CREATE TABLE `feiwa_chat_log` (
  `m_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `f_id` int(10) unsigned NOT NULL COMMENT '会员ID',
  `f_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员名',
  `f_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '发自IP',
  `t_id` int(10) unsigned NOT NULL COMMENT '接收会员ID',
  `t_name` varchar(50) NOT NULL DEFAULT '' COMMENT '接收会员名',
  `t_msg` varchar(300) DEFAULT NULL COMMENT '消息内容',
  `add_time` int(10) unsigned DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`m_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息记录表';

/*Data for the table `feiwa_chat_log` */

/*Table structure for table `feiwa_chat_msg` */

DROP TABLE IF EXISTS `feiwa_chat_msg`;

CREATE TABLE `feiwa_chat_msg` (
  `m_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `f_id` int(10) unsigned NOT NULL COMMENT '会员ID',
  `f_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员名',
  `f_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '发自IP',
  `t_id` int(10) unsigned NOT NULL COMMENT '接收会员ID',
  `t_name` varchar(50) NOT NULL DEFAULT '' COMMENT '接收会员名',
  `t_msg` varchar(300) DEFAULT NULL COMMENT '消息内容',
  `r_state` tinyint(1) unsigned DEFAULT '2' COMMENT '状态:1为已读,2为未读,默认为2',
  `add_time` int(10) unsigned DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`m_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息表';

/*Data for the table `feiwa_chat_msg` */

/*Table structure for table `feiwa_circle` */

DROP TABLE IF EXISTS `feiwa_circle`;

CREATE TABLE `feiwa_circle` (
  `circle_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '圈子id',
  `circle_name` varchar(12) NOT NULL DEFAULT '' COMMENT '圈子名称',
  `circle_desc` varchar(255) DEFAULT NULL COMMENT '圈子描述',
  `circle_masterid` int(11) unsigned NOT NULL COMMENT '圈主id',
  `circle_mastername` varchar(50) NOT NULL DEFAULT '' COMMENT '圈主名称',
  `circle_img` varchar(50) DEFAULT NULL COMMENT '圈子图片',
  `class_id` int(11) unsigned NOT NULL COMMENT '圈子分类',
  `circle_mcount` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '圈子成员数',
  `circle_thcount` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '圈子主题数',
  `circle_gcount` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '圈子商品数',
  `circle_pursuereason` varchar(255) DEFAULT NULL COMMENT '圈子申请理由',
  `circle_notice` varchar(255) DEFAULT NULL COMMENT '圈子公告',
  `circle_status` tinyint(3) unsigned NOT NULL COMMENT '圈子状态，0关闭，1开启，2审核中，3审核失败',
  `circle_statusinfo` varchar(255) DEFAULT NULL COMMENT '关闭或审核失败原因',
  `circle_joinaudit` tinyint(3) unsigned NOT NULL COMMENT '加入圈子时候需要审核，0不需要，1需要',
  `circle_addtime` varchar(10) NOT NULL DEFAULT '' COMMENT '圈子创建时间',
  `circle_noticetime` varchar(10) DEFAULT NULL COMMENT '圈子公告更新时间',
  `is_recommend` tinyint(3) unsigned NOT NULL COMMENT '是否推荐 0未推荐，1已推荐',
  `is_hot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否为热门圈子 1是 0否',
  `circle_tag` varchar(60) DEFAULT NULL COMMENT '圈子标签',
  `new_verifycount` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '等待审核成员数',
  `new_informcount` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '等待处理举报数',
  `mapply_open` tinyint(4) NOT NULL DEFAULT '0' COMMENT '申请管理是否开启 0关闭，1开启',
  `mapply_ml` tinyint(4) NOT NULL DEFAULT '0' COMMENT '成员级别',
  `new_mapplycount` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '管理申请数量',
  PRIMARY KEY (`circle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='圈子表';

/*Data for the table `feiwa_circle` */

/*Table structure for table `feiwa_circle_affix` */

DROP TABLE IF EXISTS `feiwa_circle_affix`;

CREATE TABLE `feiwa_circle_affix` (
  `affix_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '附件id',
  `affix_filename` varchar(100) NOT NULL DEFAULT '' COMMENT '文件名称',
  `affix_filethumb` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图名称',
  `affix_filesize` int(10) unsigned NOT NULL COMMENT '文件大小，单位字节',
  `affix_addtime` varchar(10) NOT NULL DEFAULT '' COMMENT '上传时间',
  `affix_type` tinyint(3) unsigned NOT NULL COMMENT '文件类型 0无 1主题 2评论',
  `member_id` int(11) unsigned NOT NULL COMMENT '会员id',
  `theme_id` int(11) unsigned NOT NULL COMMENT '主题id',
  `reply_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评论id',
  `circle_id` int(11) unsigned NOT NULL COMMENT '圈子id',
  PRIMARY KEY (`affix_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件表';

/*Data for the table `feiwa_circle_affix` */

/*Table structure for table `feiwa_circle_class` */

DROP TABLE IF EXISTS `feiwa_circle_class`;

CREATE TABLE `feiwa_circle_class` (
  `class_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '圈子分类id',
  `class_name` varchar(50) NOT NULL DEFAULT '' COMMENT '圈子分类名称',
  `class_addtime` varchar(10) NOT NULL DEFAULT '' COMMENT '圈子分类创建时间',
  `class_sort` tinyint(3) unsigned NOT NULL COMMENT '圈子分类排序',
  `class_status` tinyint(3) unsigned NOT NULL COMMENT '圈子分类状态 0不显示，1显示',
  `is_recommend` tinyint(3) unsigned NOT NULL COMMENT '是否推荐 0未推荐，1已推荐',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='圈子分类表';

/*Data for the table `feiwa_circle_class` */

insert  into `feiwa_circle_class`(`class_id`,`class_name`,`class_addtime`,`class_sort`,`class_status`,`is_recommend`) values (1,'购物券','1515308565',0,0,1);

/*Table structure for table `feiwa_circle_explog` */

DROP TABLE IF EXISTS `feiwa_circle_explog`;

CREATE TABLE `feiwa_circle_explog` (
  `el_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '经验日志id',
  `circle_id` int(11) unsigned NOT NULL COMMENT '圈子id',
  `member_id` int(11) unsigned NOT NULL COMMENT '成员id',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '成员名称',
  `el_exp` int(10) NOT NULL COMMENT '获得经验',
  `el_time` varchar(10) NOT NULL DEFAULT '' COMMENT '获得时间',
  `el_type` tinyint(3) unsigned NOT NULL COMMENT '类型 1管理员操作 2发表话题 3发表回复 4话题被回复 5话题被删除 6回复被删除',
  `el_itemid` varchar(100) NOT NULL DEFAULT '' COMMENT '信息id',
  `el_desc` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`el_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='经验日志表';

/*Data for the table `feiwa_circle_explog` */

/*Table structure for table `feiwa_circle_expmember` */

DROP TABLE IF EXISTS `feiwa_circle_expmember`;

CREATE TABLE `feiwa_circle_expmember` (
  `member_id` int(11) NOT NULL COMMENT '成员id',
  `circle_id` int(11) unsigned NOT NULL COMMENT '圈子id',
  `em_exp` int(10) NOT NULL COMMENT '获得经验',
  `em_time` varchar(10) NOT NULL DEFAULT '' COMMENT '获得时间',
  PRIMARY KEY (`member_id`,`circle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='成员每天获得经验表';

/*Data for the table `feiwa_circle_expmember` */

/*Table structure for table `feiwa_circle_exptheme` */

DROP TABLE IF EXISTS `feiwa_circle_exptheme`;

CREATE TABLE `feiwa_circle_exptheme` (
  `theme_id` int(11) unsigned NOT NULL COMMENT '主题id',
  `et_exp` int(10) NOT NULL COMMENT '获得经验',
  `et_time` varchar(10) NOT NULL DEFAULT '' COMMENT '获得时间',
  PRIMARY KEY (`theme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主题每天获得经验表';

/*Data for the table `feiwa_circle_exptheme` */

/*Table structure for table `feiwa_circle_fs` */

DROP TABLE IF EXISTS `feiwa_circle_fs`;

CREATE TABLE `feiwa_circle_fs` (
  `circle_id` int(11) unsigned NOT NULL COMMENT '圈子id',
  `friendship_id` int(11) unsigned NOT NULL COMMENT '友情圈子id',
  `friendship_name` varchar(11) NOT NULL DEFAULT '' COMMENT '友情圈子名称',
  `friendship_sort` tinyint(4) unsigned NOT NULL COMMENT '友情圈子排序',
  `friendship_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '友情圈子名称 1显示 0隐藏',
  PRIMARY KEY (`circle_id`,`friendship_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='友情圈子表';

/*Data for the table `feiwa_circle_fs` */

/*Table structure for table `feiwa_circle_inform` */

DROP TABLE IF EXISTS `feiwa_circle_inform`;

CREATE TABLE `feiwa_circle_inform` (
  `inform_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '举报id',
  `circle_id` int(11) unsigned NOT NULL COMMENT '圈子id',
  `circle_name` varchar(12) NOT NULL DEFAULT '' COMMENT '圈子名称',
  `theme_id` int(11) unsigned NOT NULL COMMENT '话题id',
  `theme_name` varchar(50) NOT NULL DEFAULT '' COMMENT '主题名称',
  `reply_id` int(11) unsigned NOT NULL COMMENT '回复id',
  `member_id` int(11) unsigned NOT NULL COMMENT '会员id',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员名称',
  `inform_content` varchar(255) NOT NULL DEFAULT '' COMMENT '举报内容',
  `inform_time` varchar(10) NOT NULL DEFAULT '' COMMENT '举报时间',
  `inform_type` tinyint(4) NOT NULL COMMENT '类型 0话题、1回复',
  `inform_state` tinyint(4) NOT NULL COMMENT '状态 0未处理、1已处理',
  `inform_opid` int(11) unsigned DEFAULT '0' COMMENT '操作人id',
  `inform_opname` varchar(50) DEFAULT '' COMMENT '操作人名称',
  `inform_opexp` tinyint(4) DEFAULT '0' COMMENT '操作经验',
  `inform_opresult` varchar(255) DEFAULT '' COMMENT '处理结果',
  PRIMARY KEY (`inform_id`),
  KEY `circle_id` (`circle_id`,`theme_id`,`reply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='圈子举报表';

/*Data for the table `feiwa_circle_inform` */

/*Table structure for table `feiwa_circle_like` */

DROP TABLE IF EXISTS `feiwa_circle_like`;

CREATE TABLE `feiwa_circle_like` (
  `theme_id` int(11) unsigned NOT NULL COMMENT '主题id',
  `member_id` int(11) unsigned NOT NULL COMMENT '会员id',
  `circle_id` int(11) unsigned NOT NULL COMMENT '圈子id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主题赞表';

/*Data for the table `feiwa_circle_like` */

/*Table structure for table `feiwa_circle_mapply` */

DROP TABLE IF EXISTS `feiwa_circle_mapply`;

CREATE TABLE `feiwa_circle_mapply` (
  `mapply_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '申请id',
  `circle_id` int(11) unsigned NOT NULL COMMENT '圈子id',
  `member_id` int(11) unsigned NOT NULL COMMENT '成员id',
  `mapply_reason` varchar(255) NOT NULL DEFAULT '' COMMENT '申请理由',
  `mapply_time` varchar(10) NOT NULL DEFAULT '' COMMENT '申请时间',
  PRIMARY KEY (`mapply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='申请管理表';

/*Data for the table `feiwa_circle_mapply` */

/*Table structure for table `feiwa_circle_member` */

DROP TABLE IF EXISTS `feiwa_circle_member`;

CREATE TABLE `feiwa_circle_member` (
  `member_id` int(11) unsigned NOT NULL COMMENT '会员id',
  `circle_id` int(11) unsigned NOT NULL COMMENT '圈子id',
  `circle_name` varchar(12) DEFAULT NULL COMMENT '圈子名称',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员名称',
  `cm_applycontent` varchar(255) DEFAULT '' COMMENT '申请内容',
  `cm_applytime` varchar(10) DEFAULT NULL COMMENT '申请时间',
  `cm_state` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态 0申请中 1通过 2未通过',
  `cm_intro` varchar(255) DEFAULT '' COMMENT '自我介绍',
  `cm_jointime` varchar(10) NOT NULL DEFAULT '' COMMENT '加入时间',
  `cm_level` int(11) NOT NULL DEFAULT '1' COMMENT '成员级别',
  `cm_levelname` varchar(10) NOT NULL DEFAULT '初级粉丝' COMMENT '成员头衔',
  `cm_exp` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '会员经验',
  `cm_nextexp` int(10) NOT NULL DEFAULT '5' COMMENT '下一级所需经验',
  `is_identity` tinyint(3) unsigned DEFAULT NULL COMMENT '1圈主 2管理 3成员',
  `is_allowspeak` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否允许发言 1允许 0禁止',
  `is_star` tinyint(4) NOT NULL DEFAULT '0' COMMENT '明星成员 1是 0否',
  `cm_thcount` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '主题数',
  `cm_comcount` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '回复数',
  `cm_lastspeaktime` varchar(10) DEFAULT '' COMMENT '最后发言时间',
  `is_recommend` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否推荐 1是 0否',
  PRIMARY KEY (`member_id`,`circle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='圈子会员表';

/*Data for the table `feiwa_circle_member` */

/*Table structure for table `feiwa_circle_ml` */

DROP TABLE IF EXISTS `feiwa_circle_ml`;

CREATE TABLE `feiwa_circle_ml` (
  `circle_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '圈子id',
  `mlref_id` int(10) DEFAULT NULL COMMENT '参考头衔id 0为默认 null为自定义',
  `ml_1` varchar(10) NOT NULL DEFAULT '' COMMENT '1级头衔名称',
  `ml_2` varchar(10) NOT NULL DEFAULT '' COMMENT '2级头衔名称',
  `ml_3` varchar(10) NOT NULL DEFAULT '' COMMENT '3级头衔名称',
  `ml_4` varchar(10) NOT NULL DEFAULT '' COMMENT '4级头衔名称',
  `ml_5` varchar(10) NOT NULL DEFAULT '' COMMENT '5级头衔名称',
  `ml_6` varchar(10) NOT NULL DEFAULT '' COMMENT '6级头衔名称',
  `ml_7` varchar(10) NOT NULL DEFAULT '' COMMENT '7级头衔名称',
  `ml_8` varchar(10) NOT NULL DEFAULT '' COMMENT '8级头衔名称',
  `ml_9` varchar(10) NOT NULL DEFAULT '' COMMENT '9级头衔名称',
  `ml_10` varchar(10) NOT NULL DEFAULT '' COMMENT '10级头衔名称',
  `ml_11` varchar(10) NOT NULL DEFAULT '' COMMENT '11级头衔名称',
  `ml_12` varchar(10) NOT NULL DEFAULT '' COMMENT '12级头衔名称',
  `ml_13` varchar(10) NOT NULL DEFAULT '' COMMENT '13级头衔名称',
  `ml_14` varchar(10) NOT NULL DEFAULT '' COMMENT '14级头衔名称',
  `ml_15` varchar(10) NOT NULL DEFAULT '' COMMENT '15级头衔名称',
  `ml_16` varchar(10) NOT NULL DEFAULT '' COMMENT '16级头衔名称',
  PRIMARY KEY (`circle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员头衔表';

/*Data for the table `feiwa_circle_ml` */

/*Table structure for table `feiwa_circle_mldefault` */

DROP TABLE IF EXISTS `feiwa_circle_mldefault`;

CREATE TABLE `feiwa_circle_mldefault` (
  `mld_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '头衔等级',
  `mld_name` varchar(10) NOT NULL DEFAULT '' COMMENT '头衔名称',
  `mld_exp` int(10) NOT NULL COMMENT '所需经验值',
  PRIMARY KEY (`mld_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='成员头衔默认设置表';

/*Data for the table `feiwa_circle_mldefault` */

insert  into `feiwa_circle_mldefault`(`mld_id`,`mld_name`,`mld_exp`) values (1,'初级粉丝',1),(2,'中级粉丝',5),(3,'高级粉丝',15),(4,'正式会员',30),(5,'正式会员',50),(6,'核心会员',100),(7,'核心会员',200),(8,'铁杆会员',500),(9,'铁杆会员',1000),(10,'知名人士',2000),(11,'知名人士',3000),(12,'人气楷模',6000),(13,'人气楷模',10000),(14,'意见领袖',18000),(15,'资深元老',30000),(16,'荣耀元老',60000);

/*Table structure for table `feiwa_circle_mlref` */

DROP TABLE IF EXISTS `feiwa_circle_mlref`;

CREATE TABLE `feiwa_circle_mlref` (
  `mlref_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '参考头衔id',
  `mlref_name` varchar(10) NOT NULL DEFAULT '' COMMENT '参考头衔名称',
  `mlref_addtime` varchar(10) NOT NULL DEFAULT '' COMMENT '创建时间',
  `mlref_status` tinyint(3) unsigned NOT NULL COMMENT '状态',
  `mlref_1` varchar(10) NOT NULL DEFAULT '' COMMENT '1级头衔名称',
  `mlref_2` varchar(10) NOT NULL DEFAULT '' COMMENT '2级头衔名称',
  `mlref_3` varchar(10) NOT NULL DEFAULT '' COMMENT '3级头衔名称',
  `mlref_4` varchar(10) NOT NULL DEFAULT '' COMMENT '4级头衔名称',
  `mlref_5` varchar(10) NOT NULL DEFAULT '' COMMENT '5级头衔名称',
  `mlref_6` varchar(10) NOT NULL DEFAULT '' COMMENT '6级头衔名称',
  `mlref_7` varchar(10) NOT NULL DEFAULT '' COMMENT '7级头衔名称',
  `mlref_8` varchar(10) NOT NULL DEFAULT '' COMMENT '8级头衔名称',
  `mlref_9` varchar(10) NOT NULL DEFAULT '' COMMENT '9级头衔名称',
  `mlref_10` varchar(10) NOT NULL DEFAULT '' COMMENT '10级头衔名称',
  `mlref_11` varchar(10) NOT NULL DEFAULT '' COMMENT '11级头衔名称',
  `mlref_12` varchar(10) NOT NULL DEFAULT '' COMMENT '12级头衔名称',
  `mlref_13` varchar(10) NOT NULL DEFAULT '' COMMENT '13级头衔名称',
  `mlref_14` varchar(10) NOT NULL DEFAULT '' COMMENT '14级头衔名称',
  `mlref_15` varchar(10) NOT NULL DEFAULT '' COMMENT '15级头衔名称',
  `mlref_16` varchar(10) NOT NULL DEFAULT '' COMMENT '16级头衔名称',
  PRIMARY KEY (`mlref_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='会员参考头衔表';

/*Data for the table `feiwa_circle_mlref` */

insert  into `feiwa_circle_mlref`(`mlref_id`,`mlref_name`,`mlref_addtime`,`mlref_status`,`mlref_1`,`mlref_2`,`mlref_3`,`mlref_4`,`mlref_5`,`mlref_6`,`mlref_7`,`mlref_8`,`mlref_9`,`mlref_10`,`mlref_11`,`mlref_12`,`mlref_13`,`mlref_14`,`mlref_15`,`mlref_16`) values (1,'校园系列','1371784037',1,'托儿所','幼儿园','学前班','一年级','二年级','三年级','四年级','五年级','六年级','初一','初二','初三','高一','高二','高三','大学'),(2,'名气系列','1371797598',1,'默默无闻','崭露头角','锋芒毕露','小有名气','小有美名','颇具名气','颇具盛名','富有名气','富有美誉','远近闻名','崭露头角','声名远扬','赫赫有名','大名鼎鼎','如雷贯耳','名扬四海'),(3,'内涵系列','1371884423',1,'1L喂熊','抢个沙发','自带板凳','路人甲君','打酱油的','华丽飘过','前来围观','我勒个去','亮了瞎了','兰州烧饼','鸭梨山大','笑而不语','内牛满面','虎躯一震','霸气外露','此贴必火'),(4,'军衔系列','1371884788',1,'下士','中士','上士','少尉','中尉','上尉','大尉','少校','中校','上校','大校','少将','中将','上将','大将','元帅'),(5,'书生系列','1371884953',1,'白丁','童生','秀才','举人','举人','贡士','进士','进士','进士','探花','探花','榜眼','榜眼','状元','状元','圣贤'),(6,'武侠系列','1371885047',1,'初涉江湖','无名之辈','仗剑天涯','人海孤鸿','四方游侠','江湖少侠','后起之秀','武林新贵','武林高手','英雄豪杰','人中龙凤','自成一派','名震江湖','武林盟主','一代宗师','笑傲江湖');

/*Table structure for table `feiwa_circle_recycle` */

DROP TABLE IF EXISTS `feiwa_circle_recycle`;

CREATE TABLE `feiwa_circle_recycle` (
  `recycle_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '回收站id',
  `member_id` int(11) NOT NULL COMMENT '会员id',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员名称',
  `circle_id` int(11) unsigned NOT NULL COMMENT '圈子id',
  `circle_name` varchar(12) NOT NULL DEFAULT '' COMMENT '圈子名称',
  `theme_name` varchar(50) NOT NULL DEFAULT '' COMMENT '主题名称',
  `recycle_content` text NOT NULL COMMENT '内容',
  `recycle_opid` int(11) unsigned NOT NULL COMMENT '操作人id',
  `recycle_opname` varchar(50) NOT NULL DEFAULT '' COMMENT '操作人名称',
  `recycle_type` tinyint(3) unsigned NOT NULL COMMENT '类型 1话题，2回复',
  `recycle_time` varchar(10) NOT NULL DEFAULT '' COMMENT '操作时间',
  PRIMARY KEY (`recycle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='圈子回收站表';

/*Data for the table `feiwa_circle_recycle` */

/*Table structure for table `feiwa_circle_thclass` */

DROP TABLE IF EXISTS `feiwa_circle_thclass`;

CREATE TABLE `feiwa_circle_thclass` (
  `thclass_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主题分类id',
  `thclass_name` varchar(20) NOT NULL DEFAULT '' COMMENT '主题名称',
  `thclass_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '主题状态 1开启，0关闭',
  `is_moderator` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '管理专属 1是，0否',
  `thclass_sort` tinyint(3) unsigned NOT NULL COMMENT '分类排序',
  `circle_id` int(11) unsigned NOT NULL COMMENT '所属圈子id',
  PRIMARY KEY (`thclass_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='圈子主题分类表';

/*Data for the table `feiwa_circle_thclass` */

/*Table structure for table `feiwa_circle_theme` */

DROP TABLE IF EXISTS `feiwa_circle_theme`;

CREATE TABLE `feiwa_circle_theme` (
  `theme_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主题id',
  `theme_name` varchar(50) NOT NULL DEFAULT '' COMMENT '主题名称',
  `theme_content` text NOT NULL COMMENT '主题内容',
  `circle_id` int(11) unsigned NOT NULL COMMENT '圈子id',
  `circle_name` varchar(12) NOT NULL DEFAULT '' COMMENT '圈子名称',
  `thclass_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '主题分类id',
  `thclass_name` varchar(20) DEFAULT '' COMMENT '主题分类名称',
  `member_id` int(11) unsigned NOT NULL COMMENT '会员id',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员名称',
  `is_identity` tinyint(3) unsigned NOT NULL COMMENT '1圈主 2管理 3成员',
  `theme_addtime` varchar(10) NOT NULL DEFAULT '' COMMENT '主题发表时间',
  `theme_editname` varchar(50) DEFAULT NULL COMMENT '编辑人名称',
  `theme_edittime` varchar(10) DEFAULT NULL COMMENT '主题编辑时间',
  `theme_likecount` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '喜欢数量',
  `theme_commentcount` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评论数量',
  `theme_browsecount` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '浏览数量',
  `theme_sharecount` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分享数量',
  `is_stick` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶 1是  0否',
  `is_digest` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否加精 1是 0否',
  `lastspeak_id` int(11) unsigned DEFAULT NULL COMMENT '最后发言人id',
  `lastspeak_name` varchar(50) DEFAULT NULL COMMENT '最后发言人名称',
  `lastspeak_time` varchar(10) DEFAULT NULL COMMENT '最后发言时间',
  `has_goods` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '商品标记 1是 0否',
  `has_affix` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件标记 1是 0 否',
  `is_closed` tinyint(4) NOT NULL DEFAULT '0' COMMENT '屏蔽 1是 0否',
  `is_recommend` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否推荐 1是 0否',
  `is_shut` tinyint(4) NOT NULL DEFAULT '0' COMMENT '主题是否关闭 1是 0否',
  `theme_exp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '获得经验',
  `theme_readperm` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '阅读权限',
  `theme_special` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '特殊话题 0普通 1投票',
  PRIMARY KEY (`theme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='圈子主题表';

/*Data for the table `feiwa_circle_theme` */

/*Table structure for table `feiwa_circle_thg` */

DROP TABLE IF EXISTS `feiwa_circle_thg`;

CREATE TABLE `feiwa_circle_thg` (
  `themegoods_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主题商品id',
  `theme_id` int(11) NOT NULL COMMENT '主题id',
  `reply_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '回复id',
  `circle_id` int(11) unsigned NOT NULL COMMENT '圈子id',
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  `goods_name` varchar(100) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_price` decimal(10,2) NOT NULL COMMENT '商品价格',
  `goods_image` varchar(1000) NOT NULL DEFAULT '' COMMENT '商品图片',
  `store_id` int(11) NOT NULL COMMENT '店铺id',
  `thg_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '商品类型 0为本商城、1为淘宝 默认为0',
  `thg_url` varchar(1000) DEFAULT NULL COMMENT '商品链接',
  PRIMARY KEY (`themegoods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主题商品表';

/*Data for the table `feiwa_circle_thg` */

/*Table structure for table `feiwa_circle_thpoll` */

DROP TABLE IF EXISTS `feiwa_circle_thpoll`;

CREATE TABLE `feiwa_circle_thpoll` (
  `theme_id` int(11) unsigned NOT NULL COMMENT '话题id',
  `poll_multiple` tinyint(3) unsigned NOT NULL COMMENT '单/多选 0单选、1多选',
  `poll_startime` varchar(10) NOT NULL DEFAULT '' COMMENT '开始时间',
  `poll_endtime` varchar(10) NOT NULL DEFAULT '' COMMENT '结束时间',
  `poll_days` tinyint(3) unsigned NOT NULL COMMENT '投票天数',
  `poll_voters` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '投票参与人数',
  PRIMARY KEY (`theme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投票表';

/*Data for the table `feiwa_circle_thpoll` */

/*Table structure for table `feiwa_circle_thpolloption` */

DROP TABLE IF EXISTS `feiwa_circle_thpolloption`;

CREATE TABLE `feiwa_circle_thpolloption` (
  `pollop_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '投票选项id',
  `theme_id` int(11) unsigned NOT NULL COMMENT '话题id',
  `pollop_option` varchar(80) NOT NULL DEFAULT '' COMMENT '投票选项',
  `pollop_votes` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '得票数',
  `pollop_sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `pollop_votername` mediumtext COMMENT '投票者名称',
  PRIMARY KEY (`pollop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投票选项表';

/*Data for the table `feiwa_circle_thpolloption` */

/*Table structure for table `feiwa_circle_thpollvoter` */

DROP TABLE IF EXISTS `feiwa_circle_thpollvoter`;

CREATE TABLE `feiwa_circle_thpollvoter` (
  `theme_id` int(11) unsigned NOT NULL COMMENT '话题id',
  `member_id` int(11) unsigned NOT NULL COMMENT '成员id',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '成员名称',
  `pollvo_options` mediumtext NOT NULL COMMENT '投票选项',
  `pollvo_time` varchar(10) NOT NULL DEFAULT '' COMMENT '投票选项',
  KEY `theme_id` (`theme_id`,`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='成员投票信息表';

/*Data for the table `feiwa_circle_thpollvoter` */

/*Table structure for table `feiwa_circle_threply` */

DROP TABLE IF EXISTS `feiwa_circle_threply`;

CREATE TABLE `feiwa_circle_threply` (
  `theme_id` int(11) unsigned NOT NULL COMMENT '主题id',
  `reply_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `circle_id` int(11) unsigned NOT NULL COMMENT '圈子id',
  `member_id` int(11) unsigned NOT NULL COMMENT '会员id',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员名称',
  `reply_content` text NOT NULL COMMENT '评论内容',
  `reply_addtime` varchar(10) NOT NULL DEFAULT '' COMMENT '发表时间',
  `reply_replyid` int(11) unsigned DEFAULT NULL COMMENT '回复楼层id',
  `reply_replyname` varchar(50) DEFAULT NULL COMMENT '回复楼层会员名称',
  `is_closed` tinyint(4) NOT NULL DEFAULT '0' COMMENT '屏蔽 1是 0否',
  `reply_exp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '获得经验',
  PRIMARY KEY (`theme_id`,`reply_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='主题评论表';

/*Data for the table `feiwa_circle_threply` */

/*Table structure for table `feiwa_complain` */

DROP TABLE IF EXISTS `feiwa_complain`;

CREATE TABLE `feiwa_complain` (
  `complain_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '投诉id',
  `order_id` int(11) NOT NULL COMMENT '订单id',
  `order_goods_id` int(10) unsigned DEFAULT '0' COMMENT '订单商品ID',
  `accuser_id` int(11) NOT NULL COMMENT '原告id',
  `accuser_name` varchar(50) NOT NULL DEFAULT '' COMMENT '原告名称',
  `accused_id` int(11) NOT NULL COMMENT '被告id',
  `accused_name` varchar(50) NOT NULL DEFAULT '' COMMENT '被告名称',
  `complain_subject_content` varchar(50) NOT NULL DEFAULT '' COMMENT '投诉主题',
  `complain_subject_id` int(11) NOT NULL COMMENT '投诉主题id',
  `complain_content` varchar(255) DEFAULT NULL COMMENT '投诉内容',
  `complain_pic1` varchar(100) DEFAULT NULL COMMENT '投诉图片1',
  `complain_pic2` varchar(100) DEFAULT NULL COMMENT '投诉图片2',
  `complain_pic3` varchar(100) DEFAULT NULL COMMENT '投诉图片3',
  `complain_datetime` int(11) NOT NULL COMMENT '投诉时间',
  `complain_handle_datetime` int(11) DEFAULT NULL COMMENT '投诉处理时间',
  `complain_handle_member_id` int(11) DEFAULT NULL COMMENT '投诉处理人id',
  `appeal_message` varchar(255) DEFAULT NULL COMMENT '申诉内容',
  `appeal_datetime` int(11) DEFAULT NULL COMMENT '申诉时间',
  `appeal_pic1` varchar(100) DEFAULT NULL COMMENT '申诉图片1',
  `appeal_pic2` varchar(100) DEFAULT NULL COMMENT '申诉图片2',
  `appeal_pic3` varchar(100) DEFAULT NULL COMMENT '申诉图片3',
  `final_handle_message` varchar(255) DEFAULT NULL COMMENT '最终处理意见',
  `final_handle_datetime` int(11) DEFAULT NULL COMMENT '最终处理时间',
  `final_handle_member_id` int(11) DEFAULT NULL COMMENT '最终处理人id',
  `complain_state` tinyint(4) NOT NULL COMMENT '投诉状态(10-新投诉/20-投诉通过转给被投诉人/30-被投诉人已申诉/40-提交仲裁/99-已关闭)',
  `complain_active` tinyint(4) NOT NULL DEFAULT '1' COMMENT '投诉是否通过平台审批(1未通过/2通过)',
  PRIMARY KEY (`complain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投诉表';

/*Data for the table `feiwa_complain` */

/*Table structure for table `feiwa_complain_subject` */

DROP TABLE IF EXISTS `feiwa_complain_subject`;

CREATE TABLE `feiwa_complain_subject` (
  `complain_subject_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '投诉主题id',
  `complain_subject_content` varchar(50) NOT NULL DEFAULT '' COMMENT '投诉主题',
  `complain_subject_desc` varchar(100) NOT NULL DEFAULT '' COMMENT '投诉主题描述',
  `complain_subject_state` tinyint(4) NOT NULL COMMENT '投诉主题状态(1-有效/2-失效)',
  PRIMARY KEY (`complain_subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='投诉主题表';

/*Data for the table `feiwa_complain_subject` */

insert  into `feiwa_complain_subject`(`complain_subject_id`,`complain_subject_content`,`complain_subject_desc`,`complain_subject_state`) values (1,'商家不同意退款','买家申请退款被拒绝。',2),(2,'未收到货','交易成功，未收到货，钱已经付给商家，可进行维权。',1),(3,'售后保障服务','交易完成后30天内，在使用商品过程中，发现商品有质量问题或无法正常使用，可进行维权。',1);

/*Table structure for table `feiwa_complain_talk` */

DROP TABLE IF EXISTS `feiwa_complain_talk`;

CREATE TABLE `feiwa_complain_talk` (
  `talk_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '投诉对话id',
  `complain_id` int(11) NOT NULL COMMENT '投诉id',
  `talk_member_id` int(11) NOT NULL COMMENT '发言人id',
  `talk_member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '发言人名称',
  `talk_member_type` varchar(10) NOT NULL DEFAULT '' COMMENT '发言人类型(1-投诉人/2-被投诉人/3-平台)',
  `talk_content` varchar(255) NOT NULL DEFAULT '' COMMENT '发言内容',
  `talk_state` tinyint(4) NOT NULL COMMENT '发言状态(1-显示/2-不显示)',
  `talk_admin` int(11) NOT NULL DEFAULT '0' COMMENT '对话管理员，屏蔽对话人的id',
  `talk_datetime` int(11) NOT NULL COMMENT '对话发表时间',
  PRIMARY KEY (`talk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投诉对话表';

/*Data for the table `feiwa_complain_talk` */

/*Table structure for table `feiwa_consult` */

DROP TABLE IF EXISTS `feiwa_consult`;

CREATE TABLE `feiwa_consult` (
  `consult_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '咨询编号',
  `goods_id` int(11) unsigned DEFAULT '0' COMMENT '商品编号',
  `goods_name` varchar(100) NOT NULL DEFAULT '' COMMENT '商品名称',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '咨询发布者会员编号(0：游客)',
  `member_name` varchar(100) DEFAULT NULL COMMENT '会员名称',
  `store_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '店铺编号',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `ct_id` int(10) unsigned NOT NULL COMMENT '咨询类型',
  `consult_content` varchar(255) DEFAULT NULL COMMENT '咨询内容',
  `consult_addtime` int(10) DEFAULT NULL COMMENT '咨询发布时间',
  `consult_reply` varchar(255) DEFAULT '' COMMENT '咨询回复内容',
  `consult_reply_time` int(10) DEFAULT NULL COMMENT '咨询回复时间',
  `isanonymous` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0表示不匿名 1表示匿名',
  PRIMARY KEY (`consult_id`),
  KEY `goods_id` (`goods_id`),
  KEY `seller_id` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='产品咨询表';

/*Data for the table `feiwa_consult` */

insert  into `feiwa_consult`(`consult_id`,`goods_id`,`goods_name`,`member_id`,`member_name`,`store_id`,`store_name`,`ct_id`,`consult_content`,`consult_addtime`,`consult_reply`,`consult_reply_time`,`isanonymous`) values (1,100221,'运动摄像机',0,'',6,'商城',1,'jnijk njn',1513681113,'',NULL,0),(2,100186,'樱花保湿嫩肤水500ml',0,'',6,'商城',1,'123',1514194600,'',NULL,0),(3,100223,'asdsad',0,'',8,'adminy',1,'02046513',1515568471,'',NULL,0);

/*Table structure for table `feiwa_consult_type` */

DROP TABLE IF EXISTS `feiwa_consult_type`;

CREATE TABLE `feiwa_consult_type` (
  `ct_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '咨询类型id',
  `ct_name` varchar(10) NOT NULL DEFAULT '' COMMENT '咨询类型名称',
  `ct_introduce` text NOT NULL COMMENT '咨询类型详细介绍',
  `ct_sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '咨询类型排序',
  PRIMARY KEY (`ct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='咨询类型表';

/*Data for the table `feiwa_consult_type` */

insert  into `feiwa_consult_type`(`ct_id`,`ct_name`,`ct_introduce`,`ct_sort`) values (1,'商品咨询','&lt;strong&gt;商城承诺&lt;/strong&gt;：商品均为原装正品行货，自带机打发票，严格执行国家三包政策，享受全国联保服务。&lt;br /&gt;\r\n&lt;strong&gt;功能咨询&lt;/strong&gt;：咨询商品功能建议您拨打各品牌的官方客服电话，以便获得更准确的信息。',1),(2,'支付问题','&lt;strong&gt;大额支付&lt;/strong&gt;：线上支付中的招行、工行、建行、农行、广发支持大额支付，最高单笔一次支付10000元。&lt;br /&gt;\r\n&lt;strong&gt;货到付款&lt;/strong&gt;：只有官方店铺支持货到付款功能。&lt;br /&gt;',2),(3,'发票及保修','&lt;strong&gt;商城承诺&lt;/strong&gt;：商品均为原装正品行货，自带机打发票，严格执行国家三包政策，享受全国联保服务。&lt;br /&gt;\r\n&lt;strong&gt;发票类型&lt;/strong&gt;：商城所售商品均自带机打发票，在提供相关企业资料证明后，可申请开取增值税发票。&lt;br /&gt;\r\n&lt;strong&gt;退 换 货&lt;/strong&gt;：商城为您提供完善的退换货服务。',3),(4,'促销及赠品','',4);

/*Table structure for table `feiwa_consume` */

DROP TABLE IF EXISTS `feiwa_consume`;

CREATE TABLE `feiwa_consume` (
  `consume_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '消费表',
  `member_id` int(10) unsigned NOT NULL COMMENT '会员id',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员名称',
  `consume_amount` decimal(10,2) NOT NULL COMMENT '金额',
  `consume_time` int(10) unsigned NOT NULL COMMENT '时间',
  `consume_remark` varchar(200) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`consume_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='消费记录';

/*Data for the table `feiwa_consume` */

insert  into `feiwa_consume`(`consume_id`,`member_id`,`member_name`,`consume_amount`,`consume_time`,`consume_remark`) values (19,1043,'adminy','89.00',1510890629,'下单，支付预存款，订单号: 9000000000000201'),(20,1046,'hztest','1000000.00',1513754526,'管理员调节预存款【增加】，充值单号: 920567098526268000'),(21,1043,'adminy','2100.00',1515550264,'下单，使用充值卡余额，订单号: 1000000000000601'),(22,1043,'adminy','938.00',1515550925,'下单，使用充值卡余额，订单号: 1000000000000701'),(23,1043,'adminy','2100.00',1525748438,'下单，支付预存款，订单号: 1000000000001001'),(24,1043,'adminy','2100.00',1525748472,'下单，支付预存款，订单号: 1000000000001101');

/*Table structure for table `feiwa_contract` */

DROP TABLE IF EXISTS `feiwa_contract`;

CREATE TABLE `feiwa_contract` (
  `ct_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `ct_storeid` int(11) NOT NULL COMMENT '店铺ID',
  `ct_storename` varchar(500) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `ct_itemid` int(11) NOT NULL COMMENT '服务项目ID',
  `ct_auditstate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '申请审核状态0未审核1审核通过2审核失败3已支付保证金4保证金审核通过5保证金审核失败',
  `ct_joinstate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '加入状态 0未申请 1已申请 2已加入',
  `ct_cost` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '保证金余额',
  `ct_closestate` tinyint(1) NOT NULL DEFAULT '1' COMMENT '永久关闭 0永久关闭 1开启',
  `ct_quitstate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '退出申请状态0未申请 1已申请 2申请失败',
  PRIMARY KEY (`ct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='店铺消费者保障服务加入情况表';

/*Data for the table `feiwa_contract` */

insert  into `feiwa_contract`(`ct_id`,`ct_storeid`,`ct_storename`,`ct_itemid`,`ct_auditstate`,`ct_joinstate`,`ct_cost`,`ct_closestate`,`ct_quitstate`) values (1,8,'adminy',1,0,1,'0.00',1,0),(2,8,'adminy',2,0,1,'0.00',1,0),(3,8,'adminy',3,0,1,'0.00',1,0),(4,8,'adminy',4,0,1,'0.00',1,0),(5,12,'123456',1,1,1,'0.00',1,0);

/*Table structure for table `feiwa_contract_apply` */

DROP TABLE IF EXISTS `feiwa_contract_apply`;

CREATE TABLE `feiwa_contract_apply` (
  `cta_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '申请ID',
  `cta_itemid` int(11) NOT NULL COMMENT '保障项目ID',
  `cta_storeid` int(11) NOT NULL COMMENT '店铺ID',
  `cta_storename` varchar(500) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `cta_addtime` int(11) NOT NULL COMMENT '申请时间',
  `cta_auditstate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '审核状态 0未审核 1审核通过 2审核失败 3保证金待审核 4保证金审核通过 5保证金审核失败',
  `cta_cost` decimal(10,2) DEFAULT '0.00' COMMENT '保证金金额',
  `cta_costimg` varchar(500) DEFAULT NULL COMMENT '保证金付款凭证图片',
  PRIMARY KEY (`cta_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='店铺加入消费者保障服务申请表';

/*Data for the table `feiwa_contract_apply` */

insert  into `feiwa_contract_apply`(`cta_id`,`cta_itemid`,`cta_storeid`,`cta_storename`,`cta_addtime`,`cta_auditstate`,`cta_cost`,`cta_costimg`) values (1,1,8,'adminy',1513696984,0,'0.00',NULL),(2,2,8,'adminy',1513827428,0,'0.00',NULL),(3,3,8,'adminy',1513827430,0,'0.00',NULL),(4,4,8,'adminy',1513827431,0,'0.00',NULL),(5,1,12,'123456',1516072420,1,'0.00',NULL);

/*Table structure for table `feiwa_contract_costlog` */

DROP TABLE IF EXISTS `feiwa_contract_costlog`;

CREATE TABLE `feiwa_contract_costlog` (
  `clog_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `clog_itemid` int(11) NOT NULL COMMENT '保障项目ID',
  `clog_itemname` varchar(100) NOT NULL DEFAULT '' COMMENT '保障项目名称',
  `clog_storeid` int(11) NOT NULL COMMENT '店铺ID',
  `clog_storename` varchar(500) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `clog_adminid` int(11) DEFAULT NULL COMMENT '操作管理员ID',
  `clog_adminname` varchar(200) DEFAULT NULL COMMENT '操作管理员名称',
  `clog_price` decimal(10,2) NOT NULL COMMENT '金额',
  `clog_addtime` int(11) NOT NULL COMMENT '添加时间',
  `clog_desc` varchar(2000) NOT NULL DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`clog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺消费者保障服务保证金日志表';

/*Data for the table `feiwa_contract_costlog` */

/*Table structure for table `feiwa_contract_item` */

DROP TABLE IF EXISTS `feiwa_contract_item`;

CREATE TABLE `feiwa_contract_item` (
  `cti_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `cti_name` varchar(100) NOT NULL DEFAULT '' COMMENT '保障项目名称',
  `cti_describe` varchar(2000) NOT NULL DEFAULT '' COMMENT '保障项目描述',
  `cti_cost` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '保证金',
  `cti_icon` varchar(500) NOT NULL DEFAULT '' COMMENT '图标',
  `cti_descurl` varchar(500) DEFAULT NULL COMMENT '内容介绍文章地址',
  `cti_state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 0关闭 1开启',
  `cti_sort` int(11) DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`cti_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='消费者保障服务项目表';

/*Data for the table `feiwa_contract_item` */

insert  into `feiwa_contract_item`(`cti_id`,`cti_name`,`cti_describe`,`cti_cost`,`cti_icon`,`cti_descurl`,`cti_state`,`cti_sort`) values (1,'7天退货','卖家就该商品退货服务向买家作出承诺，自商品签收之日起至卖家承诺保障时间内，商品符合卖家约定状态的情况下，如买家对购买的商品不满意可无理由申请退货。','1000.00','7day.gif','',1,1),(2,'品质承诺','卖家就该商品品质向买家作出承诺，承诺商品为正品。','1000.00','pz.gif','',1,2),(3,'破损补寄','卖家就该商品签收状态作出承诺，自商品签收之日起至卖家承诺保障时间内，如发现商品在运输途中出现破损，买家可申请破损部分商品补寄。','1000.00','psbf.gif','',1,3),(4,'急速物流','与优秀快递公司合作，快速送达买家手中，保障买家良好的购物物流体验。','1000.00','jswl.gif','',1,4),(5,'','','0.00','','',0,0),(6,'','','0.00','','',0,0),(7,'','','0.00','','',0,0),(8,'','','0.00','','',0,0),(9,'','','0.00','','',0,0),(10,'','','0.00','','',0,0);

/*Table structure for table `feiwa_contract_log` */

DROP TABLE IF EXISTS `feiwa_contract_log`;

CREATE TABLE `feiwa_contract_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `log_storeid` int(11) NOT NULL COMMENT '店铺ID',
  `log_storename` varchar(500) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `log_itemid` int(11) NOT NULL COMMENT '服务项目ID',
  `log_itemname` varchar(100) NOT NULL DEFAULT '' COMMENT '服务项目名称',
  `log_msg` varchar(1000) NOT NULL DEFAULT '' COMMENT '操作描述',
  `log_addtime` int(11) NOT NULL COMMENT '添加时间',
  `log_role` varchar(100) NOT NULL DEFAULT '' COMMENT '操作者角色 管理员为admin 商家为seller',
  `log_userid` int(11) NOT NULL COMMENT '操作者ID',
  `log_username` varchar(200) NOT NULL DEFAULT '' COMMENT '操作者名称',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='店铺消费者保障服务日志表';

/*Data for the table `feiwa_contract_log` */

insert  into `feiwa_contract_log`(`log_id`,`log_storeid`,`log_storename`,`log_itemid`,`log_itemname`,`log_msg`,`log_addtime`,`log_role`,`log_userid`,`log_username`) values (1,8,'adminy',1,'7天退货','店铺申请加入保障服务',1513696984,'seller',1043,'adminy'),(2,8,'adminy',2,'品质承诺','店铺申请加入保障服务',1513827428,'seller',1043,'adminy'),(3,8,'adminy',3,'破损补寄','店铺申请加入保障服务',1513827430,'seller',1043,'adminy'),(4,8,'adminy',4,'急速物流','店铺申请加入保障服务',1513827431,'seller',1043,'adminy'),(5,12,'123456',1,'7天退货','店铺申请加入保障服务',1516072420,'seller',1055,'admin111'),(6,12,'123456',1,'7天退货','审核通过，待支付保证金',1516072443,'admin',2,'adminy');

/*Table structure for table `feiwa_contract_quitapply` */

DROP TABLE IF EXISTS `feiwa_contract_quitapply`;

CREATE TABLE `feiwa_contract_quitapply` (
  `ctq_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '退出申请ID',
  `ctq_itemid` int(11) NOT NULL COMMENT '项目ID',
  `ctq_itemname` varchar(200) NOT NULL DEFAULT '' COMMENT '项目名称',
  `ctq_storeid` int(11) NOT NULL COMMENT '店铺ID',
  `ctq_storename` varchar(500) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `ctq_addtime` int(11) NOT NULL COMMENT '添加时间',
  `ctq_auditstate` tinyint(4) NOT NULL COMMENT '审核状态0未审核1审核通过2审核失败',
  PRIMARY KEY (`ctq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺消费者保障服务退出申请表';

/*Data for the table `feiwa_contract_quitapply` */

/*Table structure for table `feiwa_cron` */

DROP TABLE IF EXISTS `feiwa_cron`;

CREATE TABLE `feiwa_cron` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) unsigned DEFAULT NULL COMMENT '任务类型 1商品上架 2根据商品id更新商品促销价格 3优惠套装过期 4推荐展位过期 5团购开始更新商品促销价格 6团购过期 7限时折扣过期 8加价购过期 9商品消费者保障服务开启状态更新 10手机专享过期',
  `exeid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联任务的ID[如商品ID,会员ID]',
  `exetime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '执行时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=172 DEFAULT CHARSET=utf8 COMMENT='任务队列表';

/*Data for the table `feiwa_cron` */

insert  into `feiwa_cron`(`id`,`type`,`exeid`,`exetime`) values (38,9,100100,1510647058),(39,9,100101,1510647495),(40,9,100102,1510652390),(41,9,100103,1510653691),(42,9,100104,1510725462),(43,9,100105,1510725532),(44,9,100106,1510725591),(45,9,100107,1510725602),(46,9,100108,1510725656),(47,9,100109,1510725743),(48,9,100110,1510726115),(49,9,100111,1510726244),(50,9,100112,1510726311),(51,9,100113,1510726385),(52,9,100114,1510726453),(53,9,100115,1510726672),(54,9,100116,1510726752),(55,9,100117,1510726814),(56,9,100118,1510726876),(57,9,100119,1510726937),(58,9,100120,1510735302),(59,9,100121,1510735376),(60,9,100122,1510735436),(61,9,100123,1510735491),(62,9,100124,1510735548),(63,9,100125,1510735601),(64,9,100126,1510735654),(65,9,100127,1510735709),(66,9,100128,1510799565),(67,9,100129,1510799644),(68,9,100130,1510799855),(69,9,100131,1510799935),(70,9,100132,1510800004),(71,9,100133,1510800068),(72,9,100134,1510800135),(73,9,100135,1510800212),(74,9,100136,1510811008),(75,9,100137,1510811078),(76,9,100138,1510811154),(77,9,100139,1510811202),(78,9,100140,1510811253),(79,9,100141,1510811310),(80,9,100142,1510811363),(81,9,100143,1510811419),(82,9,100144,1510812565),(83,9,100145,1510812623),(84,9,100146,1510812688),(85,9,100147,1510812729),(86,9,100148,1510812784),(87,9,100149,1510812841),(88,9,100150,1510812889),(89,9,100151,1510812929),(90,9,100152,1510812972),(91,9,100153,1510814548),(92,5,100153,1510822800),(93,6,100153,1514304000),(94,4,7,1515999142),(95,5,100108,1510815900),(96,6,100108,1514649600),(97,4,6,1515999906),(98,9,100154,1510816306),(99,9,100155,1510816457),(100,9,100156,1510816499),(101,9,100157,1510816545),(102,9,100158,1510816581),(103,9,100159,1510816630),(104,9,100160,1510816675),(105,9,100161,1510816714),(106,9,100162,1513703351),(107,9,100163,1513824233),(108,9,100164,1514195067),(109,9,100166,1515743840),(110,9,100167,1515753090),(111,9,100168,1517112005),(112,9,100169,1517821382),(113,9,100170,1522752383),(114,9,100171,1525070658),(115,9,100172,1525751447),(116,9,100173,1525751561),(117,9,100174,1525751645),(118,9,100175,1525751698),(119,9,100176,1525751839),(120,9,100177,1525751912),(121,9,100178,1525751990),(122,9,100179,1525752049),(123,9,100180,1525752112),(124,9,100181,1525757164),(125,9,100182,1525757388),(126,9,100183,1525757442),(127,9,100184,1525757489),(128,9,100185,1525757535),(129,9,100186,1525757583),(130,9,100187,1525757627),(131,9,100188,1525757686),(132,9,100189,1525757730),(133,9,100190,1525757780),(134,9,100191,1525757838),(135,9,100192,1525757892),(136,9,100193,1525757939),(137,9,100194,1525757984),(138,9,100195,1525758031),(139,9,100196,1525758072),(140,9,100197,1525758110),(141,9,100198,1525758158),(142,9,100199,1525758198),(143,9,100200,1525758240),(144,9,100201,1525758287),(145,9,100202,1525758334),(146,9,100203,1525758381),(147,9,100204,1525758425),(148,9,100205,1525758469),(149,9,100206,1525758506),(150,9,100207,1525758571),(151,9,100208,1525758617),(152,9,100209,1525758666),(153,9,100210,1525758727),(154,9,100211,1525758766),(155,9,100212,1525758806),(156,9,100213,1525758854),(157,9,100214,1525758904),(158,9,100215,1525762934),(159,9,100216,1525763160),(160,9,100217,1525763196),(161,9,100218,1525763269),(162,9,100219,1525763388),(163,9,100220,1525763491),(164,9,100221,1525763595),(165,9,100222,1525763663),(166,9,100223,1525765355),(167,9,100224,1525765486),(169,9,100225,1527061008),(170,9,100226,1527061216),(171,8,1,1538236800);

/*Table structure for table `feiwa_daddress` */

DROP TABLE IF EXISTS `feiwa_daddress`;

CREATE TABLE `feiwa_daddress` (
  `address_id` mediumint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '地址ID',
  `store_id` mediumint(10) unsigned NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `seller_name` varchar(50) NOT NULL DEFAULT '' COMMENT '联系人',
  `area_id` mediumint(10) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `city_id` mediumint(9) DEFAULT NULL COMMENT '市级ID',
  `area_info` varchar(100) DEFAULT NULL COMMENT '省市县',
  `address` varchar(100) NOT NULL DEFAULT '' COMMENT '地址',
  `telphone` varchar(40) DEFAULT NULL COMMENT '电话',
  `company` varchar(50) DEFAULT '' COMMENT '公司',
  `is_default` enum('0','1') NOT NULL DEFAULT '0' COMMENT '是否默认1是',
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='卖家发货地址信息表';

/*Data for the table `feiwa_daddress` */

insert  into `feiwa_daddress`(`address_id`,`store_id`,`seller_name`,`area_id`,`city_id`,`area_info`,`address`,`telphone`,`company`,`is_default`) values (1,6,'zxx',143,39,'上海 上海市 黄浦区','zxx','13916230000','zxx_seller','0');

/*Table structure for table `feiwa_delivery_order` */

DROP TABLE IF EXISTS `feiwa_delivery_order`;

CREATE TABLE `feiwa_delivery_order` (
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `addtime` int(11) DEFAULT '0' COMMENT '订单生成时间',
  `order_sn` bigint(20) DEFAULT NULL COMMENT '订单号',
  `dlyp_id` int(11) DEFAULT NULL COMMENT '自提点ID',
  `shipping_code` varchar(50) DEFAULT NULL COMMENT '物流单号',
  `express_code` varchar(30) DEFAULT NULL COMMENT '快递公司编码',
  `express_name` varchar(30) DEFAULT NULL COMMENT '快递公司名称',
  `reciver_name` varchar(20) DEFAULT NULL COMMENT '收货人',
  `reciver_telphone` varchar(20) DEFAULT NULL COMMENT '电话',
  `reciver_mobphone` varchar(11) DEFAULT NULL COMMENT '手机',
  `dlyo_state` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '订单状态 10(默认)未到站，20已到站，30已提取',
  `dlyo_pickup_code` varchar(6) DEFAULT NULL COMMENT '提货码',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单自提点表';

/*Data for the table `feiwa_delivery_order` */

/*Table structure for table `feiwa_delivery_point` */

DROP TABLE IF EXISTS `feiwa_delivery_point`;

CREATE TABLE `feiwa_delivery_point` (
  `dlyp_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '提货站id',
  `dlyp_name` varchar(50) NOT NULL DEFAULT '' COMMENT '提货站登录名',
  `dlyp_passwd` varchar(32) NOT NULL DEFAULT '' COMMENT '提货站登录密码',
  `dlyp_truename` varchar(20) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `dlyp_mobile` varchar(11) DEFAULT '' COMMENT '手机号码',
  `dlyp_telephony` varchar(20) DEFAULT '' COMMENT '座机号码',
  `dlyp_address_name` varchar(20) NOT NULL DEFAULT '' COMMENT '服务站名称',
  `dlyp_area_1` int(10) unsigned NOT NULL COMMENT '一级地区id',
  `dlyp_area_2` int(10) unsigned NOT NULL COMMENT '二级地区id',
  `dlyp_area_3` int(10) unsigned NOT NULL COMMENT '三级地区id',
  `dlyp_area_4` int(10) unsigned NOT NULL COMMENT '四级地区id',
  `dlyp_area` int(10) unsigned NOT NULL COMMENT '地区id',
  `dlyp_area_info` varchar(255) NOT NULL DEFAULT '' COMMENT '地区内容',
  `dlyp_address` varchar(255) NOT NULL DEFAULT '' COMMENT '详细地址',
  `dlyp_idcard` varchar(18) NOT NULL DEFAULT '' COMMENT '身份证号码',
  `dlyp_idcard_image` varchar(255) NOT NULL DEFAULT '' COMMENT '身份证照片',
  `dlyp_addtime` int(10) unsigned NOT NULL COMMENT '添加时间',
  `dlyp_state` tinyint(3) unsigned NOT NULL COMMENT '提货站状态 0关闭，1开启，10等待审核, 20审核失败',
  `dlyp_fail_reason` varchar(255) DEFAULT NULL COMMENT '失败原因',
  PRIMARY KEY (`dlyp_id`),
  UNIQUE KEY `dlyp_name` (`dlyp_name`),
  UNIQUE KEY `dlyp_idcard` (`dlyp_idcard`),
  UNIQUE KEY `dlyp_mobile` (`dlyp_mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='提货站表';

/*Data for the table `feiwa_delivery_point` */

/*Table structure for table `feiwa_document` */

DROP TABLE IF EXISTS `feiwa_document`;

CREATE TABLE `feiwa_document` (
  `doc_id` mediumint(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `doc_code` varchar(255) NOT NULL DEFAULT '' COMMENT '调用标识码',
  `doc_title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `doc_content` text NOT NULL COMMENT '内容',
  `doc_time` int(10) unsigned NOT NULL COMMENT '添加时间/修改时间',
  PRIMARY KEY (`doc_id`),
  UNIQUE KEY `doc_code` (`doc_code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='系统文章表';

/*Data for the table `feiwa_document` */

insert  into `feiwa_document`(`doc_id`,`doc_code`,`doc_title`,`doc_content`,`doc_time`) values (1,'agreement','用户服务协议','<p>特别提醒用户认真阅读本《用户服务协议》(下称《协议》) 中各条款。除非您接受本《协议》条款，否则您无权使用本网站提供的相关服务。您的使用行为将视为对本《协议》的接受，并同意接受本《协议》各项条款的约束。 <br /> <br /> <strong>一、定义</strong><br /></p>\r\n<ol>\r\n<li>\"用户\"指符合本协议所规定的条件，同意遵守本网站各种规则、条款（包括但不限于本协议），并使用本网站的个人或机构。</li>\r\n<li>\"卖家\"是指在本网站上出售物品的用户。\"买家\"是指在本网站购买物品的用户。</li>\r\n<li>\"成交\"指买家根据卖家所刊登的交易要求，在特定时间内提出最优的交易条件，因而取得依其提出的条件购买该交易物品的权利。</li>\r\n</ol>\r\n<p><br /> <br /> <strong>二、用户资格</strong><br /> <br /> 只有符合下列条件之一的人员或实体才能申请成为本网站用户，可以使用本网站的服务。</p>\r\n<ol>\r\n<li>年满十八岁，并具有民事权利能力和民事行为能力的自然人；</li>\r\n<li>未满十八岁，但监护人（包括但不仅限于父母）予以书面同意的自然人；</li>\r\n<li>根据中国法律或设立地法律、法规和/或规章成立并合法存在的公司、企事业单位、社团组织和其他组织。</li>\r\n</ol>\r\n<p><br /> 无民事行为能力人、限制民事行为能力人以及无经营或特定经营资格的组织不当注册为本网站用户或超过其民事权利或行为能力范围从事交易的，其与本网站之间的协议自始无效，本网站一经发现，有权立即注销该用户，并追究其使用本网站\"服务\"的一切法律责任。<br /> <br /> <strong>三.用户的权利和义务</strong><br /></p>\r\n<ol>\r\n<li>用户有权根据本协议的规定及本网站发布的相关规则，利用本网站网上交易平台登录物品、发布交易信息、查询物品信息、购买物品、与其他用户订立物品买卖合同、在本网站社区发帖、参加本网站的有关活动及有权享受本网站提供的其他的有关资讯及信息服务。</li>\r\n<li>用户有权根据需要更改密码和交易密码。用户应对以该用户名进行的所有活动和事件负全部责任。</li>\r\n<li>用户有义务确保向本网站提供的任何资料、注册信息真实准确，包括但不限于真实姓名、身份证号、联系电话、地址、邮政编码等。保证本网站及其他用户可以通过上述联系方式与自己进行联系。同时，用户也有义务在相关资料实际变更时及时更新有关注册资料。</li>\r\n<li>用户不得以任何形式擅自转让或授权他人使用自己在本网站的用户账号。</li>\r\n<li>用户有义务确保在本网站网上交易平台上登录物品、发布的交易信息真实、准确，无误导性。</li>\r\n<li>用户不得在本网站网上交易平台买卖国家禁止销售的或限制销售的物品、不得买卖侵犯他人知识产权或其他合法权益的物品，也不得买卖违背社会公共利益或公共道德的物品。</li>\r\n<li>用户不得在本网站发布各类违法或违规信息。包括但不限于物品信息、交易信息、社区帖子、物品留言，店铺留言，评价内容等。</li>\r\n<li>用户在本网站交易中应当遵守诚实信用原则，不得以干预或操纵物品价格等不正当竞争方式扰乱网上交易秩序，不得从事与网上交易无关的不当行为，不得在交易平台上发布任何违法信息。</li>\r\n<li>用户不应采取不正当手段（包括但不限于虚假交易、互换好评等方式）提高自身或他人信用度，或采用不正当手段恶意评价其他用户，降低其他用户信用度。</li>\r\n<li>用户承诺自己在使用本网站网上交易平台实施的所有行为遵守国家法律、法规和本网站的相关规定以及各种社会公共利益或公共道德。对于任何法律后果的发生，用户将以自己的名义独立承担所有相应的法律责任。</li>\r\n<li>用户在本网站网上交易过程中如与其他用户因交易产生纠纷，可以请求本网站从中予以协调。用户如发现其他用户有违法或违反本协议的行为，可以向本网站举报。如用户因网上交易与其他用户产生诉讼的，用户有权通过司法部门要求本网站提供相关资料。</li>\r\n<li>用户应自行承担因交易产生的相关费用，并依法纳税。</li>\r\n<li>未经本网站书面允许，用户不得将本网站资料以及在交易平台上所展示的任何信息以复制、修改、翻译等形式制作衍生作品、分发或公开展示。</li>\r\n<li>用户同意接收来自本网站的信息，包括但不限于活动信息、交易信息、促销信息等。</li>\r\n</ol>\r\n<p><br /> <br /> <strong>四、 本网站的权利和义务</strong><br /></p>\r\n<ol>\r\n<li>本网站不是传统意义上的\"拍卖商\"，仅为用户提供一个信息交流、进行物品买卖的平台，充当买卖双方之间的交流媒介，而非买主或卖主的代理商、合伙  人、雇员或雇主等经营关系人。公布在本网站上的交易物品是用户自行上传进行交易的物品，并非本网站所有。对于用户刊登物品、提供的信息或参与竞标的过程，  本网站均不加以监视或控制，亦不介入物品的交易过程，包括运送、付款、退款、瑕疵担保及其它交易事项，且不承担因交易物品存在品质、权利上的瑕疵以及交易  方履行交易协议的能力而产生的任何责任，对于出现在拍卖上的物品品质、安全性或合法性，本网站均不予保证。</li>\r\n<li>本网站有义务在现有技术水平的基础上努力确保整个网上交易平台的正常运行，尽力避免服务中断或将中断时间限制在最短时间内，保证用户网上交易活动的顺利进行。</li>\r\n<li>本网站有义务对用户在注册使用本网站网上交易平台中所遇到的问题及反映的情况及时作出回复。 </li>\r\n<li>本网站有权对用户的注册资料进行查阅，对存在任何问题或怀疑的注册资料，本网站有权发出通知询问用户并要求用户做出解释、改正，或直接做出处罚、删除等处理。</li>\r\n<li>用  户因在本网站网上交易与其他用户产生纠纷的，用户通过司法部门或行政部门依照法定程序要求本网站提供相关资料，本网站将积极配合并提供有关资料；用户将纠  纷告知本网站，或本网站知悉纠纷情况的，经审核后，本网站有权通过电子邮件及电话联系向纠纷双方了解纠纷情况，并将所了解的情况通过电子邮件互相通知对  方。 </li>\r\n<li>因网上交易平台的特殊性，本网站没有义务对所有用户的注册资料、所有的交易行为以及与交易有关的其他事项进行事先审查，但如发生以下情形，本网站有权限制用户的活动、向用户核实有关资料、发出警告通知、暂时中止、无限期地中止及拒绝向该用户提供服务：         \r\n<ul>\r\n<li>用户违反本协议或因被提及而纳入本协议的文件；</li>\r\n<li>存在用户或其他第三方通知本网站，认为某个用户或具体交易事项存在违法或不当行为，并提供相关证据，而本网站无法联系到该用户核证或验证该用户向本网站提供的任何资料；</li>\r\n<li>存在用户或其他第三方通知本网站，认为某个用户或具体交易事项存在违法或不当行为，并提供相关证据。本网站以普通非专业交易者的知识水平标准对相关内容进行判别，可以明显认为这些内容或行为可能对本网站用户或本网站造成财务损失或法律责任。 </li>\r\n</ul>\r\n</li>\r\n<li>在反网络欺诈行动中，本着保护广大用户利益的原则，当用户举报自己交易可能存在欺诈而产生交易争议时，本网站有权通过表面判断暂时冻结相关用户账号，并有权核对当事人身份资料及要求提供交易相关证明材料。</li>\r\n<li>根据国家法律法规、本协议的内容和本网站所掌握的事实依据，可以认定用户存在违法或违反本协议行为以及在本网站交易平台上的其他不当行为，本网站有权在本网站交易平台及所在网站上以网络发布形式公布用户的违法行为，并有权随时作出删除相关信息，而无须征得用户的同意。</li>\r\n<li>本  网站有权在不通知用户的前提下删除或采取其他限制性措施处理下列信息：包括但不限于以规避费用为目的；以炒作信用为目的；存在欺诈等恶意或虚假内容；与网  上交易无关或不是以交易为目的；存在恶意竞价或其他试图扰乱正常交易秩序因素；该信息违反公共利益或可能严重损害本网站和其他用户合法利益的。</li>\r\n<li>用  户授予本网站独家的、全球通用的、永久的、免费的信息许可使用权利，本网站有权对该权利进行再授权，依此授权本网站有权(全部或部份地)  使用、复制、修订、改写、发布、翻译、分发、执行和展示用户公示于网站的各类信息或制作其派生作品，以现在已知或日后开发的任何形式、媒体或技术，将上述  信息纳入其他作品内。</li>\r\n</ol>\r\n<p><br /> <br /> <strong>五、服务的中断和终止</strong><br /></p>\r\n<ol>\r\n<li>在  本网站未向用户收取相关服务费用的情况下，本网站可自行全权决定以任何理由  (包括但不限于本网站认为用户已违反本协议的字面意义和精神，或用户在超过180天内未登录本网站等)  终止对用户的服务，并不再保存用户在本网站的全部资料（包括但不限于用户信息、商品信息、交易信息等）。同时本网站可自行全权决定，在发出通知或不发出通  知的情况下，随时停止提供全部或部分服务。服务终止后，本网站没有义务为用户保留原用户资料或与之相关的任何信息，或转发任何未曾阅读或发送的信息给用户  或第三方。此外，本网站不就终止对用户的服务而对用户或任何第三方承担任何责任。 </li>\r\n<li>如用户向本网站提出注销本网站注册用户身份，需经本网站审核同意，由本网站注销该注册用户，用户即解除与本网站的协议关系，但本网站仍保留下列权利：         \r\n<ul>\r\n<li>用户注销后，本网站有权保留该用户的资料,包括但不限于以前的用户资料、店铺资料、商品资料和交易记录等。 </li>\r\n<li>用户注销后，如用户在注销前在本网站交易平台上存在违法行为或违反本协议的行为，本网站仍可行使本协议所规定的权利。 </li>\r\n</ul>\r\n</li>\r\n<li>如存在下列情况，本网站可以通过注销用户的方式终止服务：         \r\n<ul>\r\n<li>在用户违反本协议相关规定时，本网站有权终止向该用户提供服务。本网站将在中断服务时通知用户。但如该用户在被本网站终止提供服务后，再一次直接或间接或以他人名义注册为本网站用户的，本网站有权再次单方面终止为该用户提供服务；</li>\r\n<li>一旦本网站发现用户注册资料中主要内容是虚假的，本网站有权随时终止为该用户提供服务； </li>\r\n<li>本协议终止或更新时，用户未确认新的协议的。 </li>\r\n<li>其它本网站认为需终止服务的情况。 </li>\r\n</ul>\r\n</li>\r\n<li>因用户违反相关法律法规或者违反本协议规定等原因而致使本网站中断、终止对用户服务的，对于服务中断、终止之前用户交易行为依下列原则处理：         \r\n<ul>\r\n<li>本网站有权决定是否在中断、终止对用户服务前将用户被中断或终止服务的情况和原因通知用户交易关系方，包括但不限于对该交易有意向但尚未达成交易的用户,参与该交易竞价的用户，已达成交易要约用户。</li>\r\n<li>服务中断、终止之前，用户已经上传至本网站的物品尚未交易或交易尚未完成的，本网站有权在中断、终止服务的同时删除此项物品的相关信息。 </li>\r\n<li>服务中断、终止之前，用户已经就其他用户出售的具体物品作出要约，但交易尚未结束，本网站有权在中断或终止服务的同时删除该用户的相关要约和信息。</li>\r\n</ul>\r\n</li>\r\n<li>本网站若因用户的行为（包括但不限于刊登的商品、在本网站社区发帖等）侵害了第三方的权利或违反了相关规定，而受到第三方的追偿或受到主管机关的处分时，用户应赔偿本网站因此所产生的一切损失及费用。</li>\r\n<li>对违反相关法律法规或者违反本协议规定，且情节严重的用户，本网站有权终止该用户的其它服务。</li>\r\n</ol>\r\n<p><br /> <br /> <strong>六、协议的修订</strong><br /> <br /> 本协议可由本网站随时修订，并将修订后的协议公告于本网站之上，修订后的条款内容自公告时起生效，并成为本协议的一部分。用户若在本协议修改之后，仍继续使用本网站，则视为用户接受和自愿遵守修订后的协议。本网站行使修改或中断服务时，不需对任何第三方负责。<br /> <br /> <strong>七、 本网站的责任范围 </strong><br /> <br /> 当用户接受该协议时，用户应明确了解并同意∶</p>\r\n<ol>\r\n<li>是否经由本网站下载或取得任何资料，由用户自行考虑、衡量并且自负风险，因下载任何资料而导致用户电脑系统的任何损坏或资料流失，用户应负完全责任。</li>\r\n<li>用户经由本网站取得的建议和资讯，无论其形式或表现，绝不构成本协议未明示规定的任何保证。</li>\r\n<li>基于以下原因而造成的利润、商誉、使用、资料损失或其它无形损失，本网站不承担任何直接、间接、附带、特别、衍生性或惩罚性赔偿（即使本网站已被告知前款赔偿的可能性）：         \r\n<ul>\r\n<li>本网站的使用或无法使用。</li>\r\n<li>经由或通过本网站购买或取得的任何物品，或接收之信息，或进行交易所随之产生的替代物品及服务的购买成本。</li>\r\n<li>用户的传输或资料遭到未获授权的存取或变更。</li>\r\n<li>本网站中任何第三方之声明或行为。</li>\r\n<li>本网站其它相关事宜。</li>\r\n</ul>\r\n</li>\r\n<li>本网站只是为用户提供一个交易的平台，对于用户所刊登的交易物品的合法性、真实性及其品质，以及用户履行交易的能力等，本网站一律不负任何担保责任。用户如果因使用本网站，或因购买刊登于本网站的任何物品，而受有损害时，本网站不负任何补偿或赔偿责任。</li>\r\n<li>本  网站提供与其它互联网上的网站或资源的链接，用户可能会因此连结至其它运营商经营的网站，但不表示本网站与这些运营商有任何关系。其它运营商经营的网站均  由各经营者自行负责，不属于本网站控制及负责范围之内。对于存在或来源于此类网站或资源的任何内容、广告、产品或其它资料，本网站亦不予保证或负责。因使  用或依赖任何此类网站或资源发布的或经由此类网站或资源获得的任何内容、物品或服务所产生的任何损害或损失，本网站不负任何直接或间接的责任。</li>\r\n</ol>\r\n<p><br /> <br /> <strong>八.、不可抗力</strong><br /> <br /> 因不可抗力或者其他意外事件，使得本协议的履行不可能、不必要或者无意义的，双方均不承担责任。本合同所称之不可抗力意指不能预见、不能避免并不能克服的  客观情况，包括但不限于战争、台风、水灾、火灾、雷击或地震、罢工、暴动、法定疾病、黑客攻击、网络病毒、电信部门技术管制、政府行为或任何其它自然或人  为造成的灾难等客观情况。<br /> <br /> <strong>九、争议解决方式</strong><br /></p>\r\n<ol>\r\n<li>本协议及其修订本的有效性、履行和与本协议及其修订本效力有关的所有事宜，将受中华人民共和国法律管辖，任何争议仅适用中华人民共和国法律。</li>\r\n<li>因  使用本网站服务所引起与本网站的任何争议，均应提交深圳仲裁委员会按照该会届时有效的仲裁规则进行仲裁。相关争议应单独仲裁，不得与任何其它方的争议在任  何仲裁中合并处理，该仲裁裁决是终局，对各方均有约束力。如果所涉及的争议不适于仲裁解决，用户同意一切争议由人民法院管辖。</li>\r\n</ol>',1449242303),(4,'open_store','开店协议','<p>使用本公司服务所须遵守的条款和条件。<br /><br />1.用户资格<br />本公司的服务仅向适用法律下能够签订具有法律约束力的合同的个人提供并仅由其使用。在不限制前述规定的前提下，本公司的服务不向18周岁以下或被临时或无限期中止的用户提供。如您不合资格，请勿使用本公司的服务。此外，您的账户（包括信用评价）和用户名不得向其他方转让或出售。另外，本公司保留根据其意愿中止或终止您的账户的权利。<br /><br />2.您的资料（包括但不限于所添加的任何商品）不得：<br />*具有欺诈性、虚假、不准确或具误导性；<br />*侵犯任何第三方著作权、专利权、商标权、商业秘密或其他专有权利或发表权或隐私权；<br />*违反任何适用的法律或法规（包括但不限于有关出口管制、消费者保护、不正当竞争、刑法、反歧视或贸易惯例/公平贸易法律的法律或法规）；<br />*有侮辱或者诽谤他人，侵害他人合法权益的内容；<br />*有淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的内容；<br />*包含可能破坏、改变、删除、不利影响、秘密截取、未经授权而接触或征用任何系统、数据或个人资料的任何病毒、特洛依木马、蠕虫、定时炸弹、删除蝇、复活节彩蛋、间谍软件或其他电脑程序；<br /><br />3.违约<br />如发生以下情形，本公司可能限制您的活动、立即删除您的商品、向本公司社区发出有关您的行为的警告、发出警告通知、暂时中止、无限期地中止或终止您的用户资格及拒绝向您提供服务：<br />(a)您违反本协议或纳入本协议的文件；<br />(b)本公司无法核证或验证您向本公司提供的任何资料；<br />(c)本公司相信您的行为可能对您、本公司用户或本公司造成损失或法律责任。<br /><br />4.责任限制<br />本公司、本公司的关联公司和相关实体或本公司的供应商在任何情况下均不就因本公司的网站、本公司的服务或本协议而产生或与之有关的利润损失或任何特别、间接或后果性的损害（无论以何种方式产生，包括疏忽）承担任何责任。您同意您就您自身行为之合法性单独承担责任。您同意，本公司和本公司的所有关联公司和相关实体对本公司用户的行为的合法性及产生的任何结果不承担责任。<br /><br />5.无代理关系<br />用户和本公司是独立的合同方，本协议无意建立也没有创立任何代理、合伙、合营、雇员与雇主或特许经营关系。本公司也不对任何用户及其网上交易行为做出明示或默许的推荐、承诺或担保。<br /><br />6.一般规定<br />本协议在所有方面均受中华人民共和国法律管辖。本协议的规定是可分割的，如本协议任何规定被裁定为无效或不可执行，该规定可被删除而其余条款应予以执行。</p>',1449242303),(5,'groupbuy','团购活动协议','<p>\r\n  一、团购的所有权和运作权归本公司。\r\n</p>\r\n<p>\r\n    二、本公司有权在必要时修改本协议，本协议一旦发生变更，将会在相关页面上公布。如果您不同意所改动的内容，您应主动停止使用团购服务。如果您继续使用服务，则视为接受本协议的变更。\r\n</p>\r\n<p>\r\n   三、如发生下列任何一种情形，本公司有权中断或终止向您提供的服务而无需通知您：\r\n</p>\r\n1、 您提供的个人资料不真实；<br />\r\n2、您违反本协议的规定；<br />\r\n3、 按照政府主管部门的监管要求；<br />\r\n4、本公司认为您的行为违反团购服务性质或需求的特殊情形。\r\n<p>\r\n 四、尽管本协议可能另有其他规定，本公司仍然可以随时终止本协议。\r\n</p>\r\n<p>\r\n  五、本公司终止本协议的权利不会妨害本公司可能拥有的在本协议终止前因您违反本协议或本公司本应享有的任何其他权利。\r\n</p>\r\n<p>\r\n  六、您理解并完全接受，本公司有权自行对团购资源作下线处理。\r\n</p>',1449242303),(6,'create_circle','圈子使用须知','&nbsp;&nbsp; 请您仔细阅读本须知的全部内容（特别是以<strong><span style=\"text-decoration:underline;\">粗体下划线</span></strong>标注的内容）。如果您不同意本须知的任意内容，您应当停止使用本产品。\r\n<p>\r\n  1、“圈子”是本公司开设的一个供商城用户（以下简称“用户”或“您”）交流购物体验等信息的网络社区。<strong><span style=\"text-decoration:underline;\">您使用“圈子”产品需遵守本须知，并遵守本公司公布的操作流程和规则。</span></strong>\r\n</p>\r\n<p>\r\n  2、“圈子”产品的功能和产品提供方式由本公司自行决定，后续本公司可能调整产品名称和产品运行的域名等。<strong><span style=\"text-decoration:underline;\">本须知适用于“圈子”产品的调整、改进版本和附加功能。</span></strong>\r\n</p>\r\n<p>\r\n    3、您可以通过本产品创建网络关系圈子，其他感兴趣的用户可以加入您创建的圈子。您应当遵守任何适用的法律之规定，并自觉尊重和维护其他参与者的合法权利。您不得以任何形式开展违法活动、侵犯他人合法权益、损害本公司或其他公司的合法利益，否则您需为此自行承担法律责任。<strong><span style=\"text-decoration:underline;\">您同意本公司无需为产品使用者的违法或侵权等行为承担任何责任。</span></strong>\r\n</p>\r\n<p>\r\n  4、您同意并保证通过本产品上传、发布的文字、图片等全部信息素材符合相关法律的规定。您保证素材内容以及素材所含链接指向的内容的合法性和正当性，不侵犯他人的肖像权、名誉权、知识产权、隐私权等合法权益，也不会侵犯法人或其他团体的商业秘密等合法权益。\r\n</p>\r\n<p>\r\n    5、<strong><span style=\"text-decoration:underline;\">您使用本产品可能需要提供关于您的个人资料、肖像、联系方式等个人信息。您了解并同意，在使用本产品过程中关于您的个人信息可能会通过网络等渠道进行传播。</span></strong>\r\n</p>\r\n<p>\r\n 6、您通过本产品上传、发布素材，即意味着<strong><span style=\"text-decoration:underline;\">您同意向本公司提供免费的、永久性的、不可撤销的权利和许可，使本公司可以在全球范围内复制、发行、展示、演绎和通过信息网络等渠道使用您上传的素材和信息</span></strong>，例如将您提供的图片发布于活动页面或平面媒体中。\r\n</p>\r\n<p>\r\n   7、本公司无法事先了解您上传素材的真实性和合法性。如您上传的素材被发现不适宜展示或遭受他人举报或投诉的，本公司有权立即删除或进行屏蔽从而停止该素材的继续传播。<strong><span style=\"text-decoration:underline;\">如果您违反本须知的内容、有关协议或规则等的，本公司有权删除相关素材并有权拒绝您继续使用产品，届时您无权要求本公司进行补偿或赔偿。</span></strong>\r\n</p>\r\n<p>\r\n 8、您使用本产品应同时遵守《用户服务协议》、本公司公布的各项规则以及本公司发布的关于本产品的特别规则和制度。\r\n</p>\r\n<p>\r\n   9、第三方可能通过分公司其他产品或本产品知悉并使用您上传的素材、个人信息或进而侵犯您的合法权利。<strong><span style=\"text-decoration:underline;\">本公司提醒您注意和谨防网络诈骗以及其他可能对您不利的行动和信息，但本公司对第三方的侵权、违法等行为不承担赔偿等法律责任。</span></strong>您承诺合法使用并善待其他用户上传的素材和信息。\r\n</p>\r\n<p>\r\n 10、您应自行对上传的素材进行备份。本公司可能按照本须知删除或屏蔽素材，相关系统亦可能遭受网络攻击或网络故障，类似或其他情况均可能使您上传的素材丢失或故障，对此本公司将尽力避免但不做任何保证。\r\n</p>\r\n<p>\r\n 11、<strong><span style=\"text-decoration:underline;\">如您因使用本产品与本公司发生纠纷的，您同意由本公司住所地人民法院管辖审理。</span></strong> \r\n</p>\r\n<p>\r\n   12、<strong><span style=\"text-decoration:underline;\">本公司有权更新、修改本须知以及有关规则、流程等相关文件的内容，本公司在法律允许的范围内负责对本须知进行说明和解释</span></strong>。如您对修改存有异议，您有权选择不再继续使用本产品，但您在此前的行为仍受本须知以及相关文件最新的修改版本的约束。\r\n</p>',1449242303);

/*Table structure for table `feiwa_evaluate_goods` */

DROP TABLE IF EXISTS `feiwa_evaluate_goods`;

CREATE TABLE `feiwa_evaluate_goods` (
  `geval_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `geval_orderid` int(11) NOT NULL COMMENT '订单表自增ID',
  `geval_orderno` bigint(20) unsigned NOT NULL COMMENT '订单编号',
  `geval_ordergoodsid` int(11) NOT NULL COMMENT '订单商品表编号',
  `geval_goodsid` int(11) NOT NULL COMMENT '商品表编号',
  `geval_goodsname` varchar(100) NOT NULL DEFAULT '' COMMENT '商品名称',
  `geval_goodsprice` decimal(10,2) DEFAULT NULL COMMENT '商品价格',
  `geval_goodsimage` varchar(255) DEFAULT NULL COMMENT '商品图片',
  `geval_scores` tinyint(1) NOT NULL COMMENT '1-5分',
  `geval_content` varchar(255) DEFAULT NULL COMMENT '信誉评价内容',
  `geval_isanonymous` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0表示不是 1表示是匿名评价',
  `geval_addtime` int(11) NOT NULL COMMENT '评价时间',
  `geval_storeid` int(11) NOT NULL COMMENT '店铺编号',
  `geval_storename` varchar(100) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `geval_frommemberid` int(11) NOT NULL COMMENT '评价人编号',
  `geval_frommembername` varchar(100) NOT NULL DEFAULT '' COMMENT '评价人名称',
  `geval_explain` varchar(255) DEFAULT NULL COMMENT '解释内容',
  `geval_image` varchar(255) DEFAULT NULL COMMENT '晒单图片',
  `geval_content_again` varchar(255) NOT NULL DEFAULT '' COMMENT '追加评价内容',
  `geval_addtime_again` int(10) unsigned NOT NULL COMMENT '追加评价时间',
  `geval_image_again` varchar(255) NOT NULL DEFAULT '' COMMENT '追加评价图片',
  `geval_explain_again` varchar(255) NOT NULL DEFAULT '' COMMENT '追加解释内容',
  PRIMARY KEY (`geval_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='信誉评价表';

/*Data for the table `feiwa_evaluate_goods` */

insert  into `feiwa_evaluate_goods`(`geval_id`,`geval_orderid`,`geval_orderno`,`geval_ordergoodsid`,`geval_goodsid`,`geval_goodsname`,`geval_goodsprice`,`geval_goodsimage`,`geval_scores`,`geval_content`,`geval_isanonymous`,`geval_addtime`,`geval_storeid`,`geval_storename`,`geval_frommemberid`,`geval_frommembername`,`geval_explain`,`geval_image`,`geval_content_again`,`geval_addtime_again`,`geval_image_again`,`geval_explain_again`) values (23,2,9000000000000201,2,100186,'樱花保湿嫩肤水500ml','89.00','6_05640796519363861.jpg',3,'樱花保湿嫩肤水500ml评价',0,1510911880,6,'商城',1043,'adminy',NULL,'1043_05642558562412513.jpg','',0,'','');

/*Table structure for table `feiwa_evaluate_store` */

DROP TABLE IF EXISTS `feiwa_evaluate_store`;

CREATE TABLE `feiwa_evaluate_store` (
  `seval_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `seval_orderid` int(11) unsigned NOT NULL COMMENT '订单ID',
  `seval_orderno` varchar(100) NOT NULL DEFAULT '' COMMENT '订单编号',
  `seval_addtime` int(11) unsigned NOT NULL COMMENT '评价时间',
  `seval_storeid` int(11) unsigned NOT NULL COMMENT '店铺编号',
  `seval_storename` varchar(100) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `seval_memberid` int(11) unsigned NOT NULL COMMENT '买家编号',
  `seval_membername` varchar(100) NOT NULL DEFAULT '' COMMENT '买家名称',
  `seval_desccredit` tinyint(1) unsigned NOT NULL DEFAULT '5' COMMENT '描述相符评分',
  `seval_servicecredit` tinyint(1) unsigned NOT NULL DEFAULT '5' COMMENT '服务态度评分',
  `seval_deliverycredit` tinyint(1) unsigned NOT NULL DEFAULT '5' COMMENT '发货速度评分',
  PRIMARY KEY (`seval_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='店铺评分表';

/*Data for the table `feiwa_evaluate_store` */

insert  into `feiwa_evaluate_store`(`seval_id`,`seval_orderid`,`seval_orderno`,`seval_addtime`,`seval_storeid`,`seval_storename`,`seval_memberid`,`seval_membername`,`seval_desccredit`,`seval_servicecredit`,`seval_deliverycredit`) values (22,2,'9000000000000201',1510911881,6,'商城',1043,'adminy',3,3,3);

/*Table structure for table `feiwa_exppoints_log` */

DROP TABLE IF EXISTS `feiwa_exppoints_log`;

CREATE TABLE `feiwa_exppoints_log` (
  `exp_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '经验值日志编号',
  `exp_memberid` int(11) NOT NULL COMMENT '会员编号',
  `exp_membername` varchar(100) NOT NULL DEFAULT '' COMMENT '会员名称',
  `exp_points` int(11) NOT NULL DEFAULT '0' COMMENT '经验值负数表示扣除',
  `exp_addtime` int(11) NOT NULL COMMENT '添加时间',
  `exp_desc` varchar(100) NOT NULL DEFAULT '' COMMENT '操作描述',
  `exp_stage` varchar(50) NOT NULL DEFAULT '' COMMENT '操作阶段',
  PRIMARY KEY (`exp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8 COMMENT='经验值日志表';

/*Data for the table `feiwa_exppoints_log` */

insert  into `feiwa_exppoints_log`(`exp_id`,`exp_memberid`,`exp_membername`,`exp_points`,`exp_addtime`,`exp_desc`,`exp_stage`) values (229,1042,'fengfeng',5,1510813896,'会员登录','login'),(230,1043,'adminy',5,1510885148,'会员登录','login'),(231,1041,'zxx1cndns',5,1510890988,'会员登录','login'),(232,1043,'adminy',89,1510911809,'订单9000000000000201购物消费','order'),(233,1043,'adminy',10,1510911881,'评论商品','comments'),(234,1043,'adminy',5,1511156634,'会员登录','login'),(235,1041,'zxx1cndns',5,1511508696,'会员登录','login'),(236,1043,'adminy',5,1511508786,'会员登录','login'),(237,1043,'adminy',5,1511777078,'会员登录','login'),(238,1043,'adminy',5,1513221583,'会员登录','login'),(239,1043,'adminy',5,1513695775,'会员登录','login'),(240,1043,'adminy',5,1513751238,'会员登录','login'),(241,1043,'adminy',5,1513929456,'会员登录','login'),(242,1043,'adminy',5,1514194250,'会员登录','login'),(243,1043,'adminy',5,1514368414,'会员登录','login'),(244,1043,'adminy',5,1514424822,'会员登录','login'),(245,1043,'adminy',5,1514515479,'会员登录','login'),(246,1043,'adminy',5,1515046724,'会员登录','login'),(247,1043,'adminy',5,1515309361,'会员登录','login'),(248,1043,'adminy',5,1515545505,'会员登录','login'),(249,1043,'adminy',5,1515655182,'会员登录','login'),(250,1043,'adminy',5,1516069443,'会员登录','login'),(251,1043,'adminy',5,1516161127,'会员登录','login'),(252,1043,'adminy',5,1516253596,'会员登录','login'),(253,1043,'adminy',5,1516327248,'会员登录','login'),(254,1043,'adminy',5,1516585619,'会员登录','login'),(255,1043,'adminy',5,1516690074,'会员登录','login'),(256,1043,'adminy',5,1517112192,'会员登录','login'),(257,1043,'adminy',5,1517192388,'会员登录','login'),(258,1043,'adminy',5,1517382710,'会员登录','login'),(259,1043,'adminy',5,1517459832,'会员登录','login'),(260,1043,'adminy',5,1517544008,'会员登录','login'),(261,1043,'adminy',5,1517821919,'会员登录','login'),(262,1043,'adminy',5,1517906700,'会员登录','login'),(263,1043,'adminy',5,1519207656,'会员登录','login'),(264,1043,'adminy',5,1519997574,'会员登录','login'),(265,1043,'adminy',5,1520392898,'会员登录','login'),(266,1043,'adminy',5,1521175784,'会员登录','login'),(267,1055,'admin111',5,1522034002,'会员登录','login'),(268,1060,'test1111',5,1522113252,'会员登录','login'),(269,1060,'test1111',5,1522281272,'会员登录','login'),(270,1060,'test1111',5,1522386246,'会员登录','login'),(271,1043,'adminy',5,1522649962,'会员登录','login'),(272,1043,'adminy',5,1523259579,'会员登录','login'),(273,1,'member',5,1523583781,'会员登录','login'),(274,1043,'adminy',5,1525748063,'会员登录','login'),(275,1043,'adminy',5,1525860455,'会员登录','login'),(276,1041,'zxx1cndns',5,1525860530,'会员登录','login'),(277,1,'member',5,1528193311,'会员登录','login'),(278,1043,'adminy',5,1536132932,'会员登录','login'),(279,1,'member',5,1536134664,'会员登录','login'),(280,1067,'iuser_aaa',300,1536138314,'订单1000000000002301购物消费','order'),(281,1,'member',5,1536715029,'会员登录','login');

/*Table structure for table `feiwa_express` */

DROP TABLE IF EXISTS `feiwa_express`;

CREATE TABLE `feiwa_express` (
  `id` tinyint(1) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引ID',
  `e_name` varchar(50) NOT NULL DEFAULT '' COMMENT '公司名称',
  `e_state` enum('0','1') NOT NULL DEFAULT '1' COMMENT '状态',
  `e_code` varchar(50) NOT NULL DEFAULT '' COMMENT '编号',
  `e_letter` char(1) NOT NULL DEFAULT '' COMMENT '首字母',
  `e_order` enum('1','2') NOT NULL DEFAULT '2' COMMENT '1常用2不常用',
  `e_url` varchar(100) NOT NULL DEFAULT '' COMMENT '公司网址',
  `e_zt_state` tinyint(4) DEFAULT '0' COMMENT '是否支持服务站配送0否1是',
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='快递公司';

/*Data for the table `feiwa_express` */

insert  into `feiwa_express`(`id`,`e_name`,`e_state`,`e_code`,`e_letter`,`e_order`,`e_url`,`e_zt_state`) values (1,'安信达','1','anxindakuaixi','A','2','http://www.anxinda.com',1),(2,'包裹平邮','1','youzhengguonei','B','2','http://yjcx.chinapost.com.cn',0),(3,'CCES','1','cces','C','2','http://www.cces.com.cn',0),(4,'传喜物流','1','chuanxiwuliu','C','2','http://www.cxcod.com',0),(5,'DHL快递','1','dhl','D','2','http://www.cn.dhl.com',0),(6,'大田物流','1','datianwuliu','D','2','http://www.dtw.com.cn',0),(7,'德邦物流','1','debangwuliu','D','2','http://www.deppon.com',0),(8,'EMS','1','ems','E','2','http://www.ems.com.cn',0),(9,'EMS国际','1','emsguoji','E','2','###',0),(10,'飞康达','1','feikangda','F','2','http://www.fkd.com.cn',0),(11,'FedEx(国际)','1','fedex','F','2','http://fedex.com/cn',0),(12,'凡客如风达','1','rufengda','F','2','http://www.rufengda.com',0),(13,'港中能达','1','ganzhongnengda','G','2','http://www.nd56.com',0),(14,'挂号信','1','youzhengguonei','G','2','http://yjcx.chinapost.com.cn',0),(15,'共速达','1','gongsuda','G','2','http://www.gongsuda.com/mall/Search.aspx',0),(16,'汇通快递','1','huitongkuaidi','H','2','http://www.htky365.com',0),(17,'华宇物流','1','tiandihuayu','H','2','http://www.hoau.net',0),(18,'佳吉快运','1','jiajiwuliu','J','2','http://www.jiaji.com',0),(19,'佳怡物流','1','jiayiwuliu','J','2','http://www.jiayi56.com',0),(20,'急先达','1','jixianda','J','2','http://www.joust.cn',0),(21,'快捷速递','1','kuaijiesudi','K','2','http://www.fastexpress.com.cn',0),(22,'龙邦快递','1','longbanwuliu','L','2','http://www.lbex.com.cn',0),(23,'联邦快递','1','lianbangkuaidi','L','2','http://cndxp.apac.fedex.com/dxp.html',0),(24,'联昊通','1','lianhaowuliu','L','2','http://www.lhtex.com.cn',0),(25,'全一快递','1','quanyikuaidi','Q','2','http://www.apex100.com',0),(26,'全峰快递','1','quanfengkuaidi','Q','2','http://www.qfkd.com.cn',0),(27,'全日通','1','quanritongkuaidi','Q','2','http://www.at-express.com',0),(28,'申通快递','1','shentong','S','2','http://www.sto.cn',0),(29,'顺丰快递','1','shunfeng','S','1','http://www.sf-express.com',0),(30,'速尔快递','1','suer','S','2','http://www.sure56.com',0),(31,'TNT快递','1','tnt','T','2','http://www.tnt.com.cn',0),(32,'天天快递','1','tiantian','T','2','http://www.ttkdex.com',0),(33,'天地华宇','1','tiandihuayu','T','2','http://www.hoau.net',0),(34,'UPS快递','1','ups','U','2','http://www.ups.com/cn',0),(35,'USPS','1','usps','U','2','http://www.kuaidi100.com/all/usps.shtml',0),(36,'新邦物流','1','xinbangwuliu','X','2','http://www.xbwl.cn',0),(37,'信丰物流','1','xinfengwuliu','X','2','http://www.xf-express.com.cn',0),(38,'希伊艾斯','1','cces','X','2','http://www.cces.com.cn',0),(39,'新蛋物流','1','neweggozzo','X','2','http://www.ozzo.com.cn',0),(40,'圆通快递','1','yuantong','Y','1','http://www.yto.net.cn',0),(41,'韵达快递','1','yunda','Y','1','http://www.yundaex.com',0),(42,'邮政包裹','1','youzhengguonei','Y','2','http://yjcx.chinapost.com.cn',0),(43,'优速快递','1','youshuwuliu','Y','2','http://www.uc56.com',0),(44,'中通快递','1','zhongtong','Z','1','http://www.zto.cn',0),(45,'中铁快运','1','zhongtiewuliu','Z','2','http://www.cre.cn',0),(46,'宅急送','1','zhaijisong','Z','2','http://www.zjs.com.cn',0),(47,'中邮物流','1','zhongyouwuliu','Z','2','http://www.cnpl.com.cn',0);

/*Table structure for table `feiwa_favorites` */

DROP TABLE IF EXISTS `feiwa_favorites`;

CREATE TABLE `feiwa_favorites` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `member_id` int(10) unsigned NOT NULL COMMENT '会员ID',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员名',
  `fav_id` int(10) unsigned NOT NULL COMMENT '商品或店铺ID',
  `fav_type` char(5) NOT NULL DEFAULT 'goods' COMMENT '类型:goods为商品,store为店铺,默认为商品',
  `fav_time` int(10) unsigned NOT NULL COMMENT '收藏时间',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺ID',
  `store_name` varchar(20) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `sc_id` int(10) unsigned DEFAULT '0' COMMENT '店铺分类ID',
  `goods_name` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `goods_image` varchar(100) DEFAULT NULL COMMENT '商品图片',
  `gc_id` int(10) unsigned DEFAULT '0' COMMENT '商品分类ID',
  `log_price` decimal(10,2) DEFAULT '0.00' COMMENT '商品收藏时价格',
  `log_msg` varchar(20) DEFAULT NULL COMMENT '收藏备注',
  PRIMARY KEY (`log_id`),
  KEY `member_id` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COMMENT='收藏表';

/*Data for the table `feiwa_favorites` */

insert  into `feiwa_favorites`(`log_id`,`member_id`,`member_name`,`fav_id`,`fav_type`,`fav_time`,`store_id`,`store_name`,`sc_id`,`goods_name`,`goods_image`,`gc_id`,`log_price`,`log_msg`) values (69,1041,'zxx1cndns',1,'store',1510655097,1,'店铺名称',0,NULL,NULL,0,'0.00',NULL),(70,1043,'adminy',6,'store',1510912060,6,'商城',2,NULL,NULL,0,'0.00',NULL),(73,1043,'adminy',7,'store',1510912265,7,'feng店铺名称',2,NULL,NULL,0,'0.00',NULL),(74,1043,'adminy',9,'store',1517552771,9,'杭州服务中心',8,NULL,NULL,0,'0.00',NULL),(76,1057,'xiaozhai',1,'store',1517901603,1,'店铺名称',0,NULL,NULL,0,'0.00',NULL),(77,1043,'adminy',100251,'goods',1525861770,6,'商城',2,'花王（Merries）纸尿裤 S82片 小号尿不湿（4-8kg）','6_05791018360977876.jpg',1035,'95.00','95.00');

/*Table structure for table `feiwa_flowstat` */

DROP TABLE IF EXISTS `feiwa_flowstat`;

CREATE TABLE `feiwa_flowstat` (
  `stattime` int(11) unsigned NOT NULL COMMENT '访问日期',
  `clicknum` int(11) unsigned NOT NULL COMMENT '访问量',
  `store_id` int(11) unsigned NOT NULL COMMENT '店铺ID',
  `type` varchar(10) NOT NULL DEFAULT '' COMMENT '类型',
  `goods_id` int(11) unsigned NOT NULL COMMENT '商品ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='访问量统计表';

/*Data for the table `feiwa_flowstat` */

insert  into `feiwa_flowstat`(`stattime`,`clicknum`,`store_id`,`type`,`goods_id`) values (1510761600,17,6,'sum',0),(1510848000,23,6,'sum',0),(1511107200,2,6,'sum',0),(1513180800,1,6,'sum',0),(1513267200,7,6,'sum',0),(1513612800,7,6,'sum',0),(1513699200,7,6,'sum',0),(1513785600,18,6,'sum',0),(1513872000,4,6,'sum',0),(1514131200,10,6,'sum',0),(1514217600,1,6,'sum',0),(1514390400,1,6,'sum',0),(1514995200,2,6,'sum',0),(1515081600,2,6,'sum',0),(1515427200,5,6,'sum',0),(1515513600,19,6,'sum',0),(1515600000,5,6,'sum',0),(1515686400,1,6,'sum',0),(1515772800,1,6,'sum',0),(1515945600,1,6,'sum',0),(1516032000,5,6,'sum',0),(1516032000,1,9,'sum',0),(1516118400,2,6,'sum',0),(1516204800,6,6,'sum',0),(1516636800,1,6,'sum',0),(1516723200,2,6,'sum',0),(1516896000,2,6,'sum',0),(1517155200,1,6,'sum',0),(1517328000,2,6,'sum',0),(1517414400,1,6,'sum',0),(1517500800,7,6,'sum',0),(1517500800,1,9,'sum',0),(1517673600,1,6,'sum',0),(1517760000,1,6,'sum',0),(1517846400,10,6,'sum',0),(1518278400,1,6,'sum',0),(1519142400,2,6,'sum',0),(1519660800,1,6,'sum',0),(1519920000,1,6,'sum',0),(1520438400,5,6,'sum',0),(1520697600,2,6,'sum',0),(1520784000,3,6,'sum',0),(1521129600,2,6,'sum',0),(1521388800,1,6,'sum',0),(1521993600,3,6,'sum',0),(1522080000,5,6,'sum',0),(1522339200,2,6,'sum',0),(1522598400,6,6,'sum',0),(1523116800,1,6,'sum',0),(1523203200,1,6,'sum',0),(1523376000,1,6,'sum',0),(1523548800,6,6,'sum',0),(1523894400,6,6,'sum',0),(1524067200,2,6,'sum',0),(1525276800,2,6,'sum',0),(1525363200,1,6,'sum',0),(1525622400,2,6,'sum',0),(1525708800,3,6,'sum',0),(1525795200,1,6,'sum',0),(1526227200,1,6,'sum',0),(1526572800,1,6,'sum',0),(1527091200,1,6,'sum',0),(1527436800,3,6,'sum',0),(1527523200,2,6,'sum',0),(1527696000,2,6,'sum',0),(1528128000,1,6,'sum',0),(1528214400,1,6,'sum',0),(1528992000,1,6,'sum',0),(1529510400,5,6,'sum',0),(1532016000,2,6,'sum',0),(1533225600,26,6,'sum',0),(1536076800,4,6,'sum',0),(1536249600,1,6,'sum',0);

/*Table structure for table `feiwa_flowstat_1` */

DROP TABLE IF EXISTS `feiwa_flowstat_1`;

CREATE TABLE `feiwa_flowstat_1` (
  `stattime` int(11) unsigned NOT NULL COMMENT '访问日期',
  `clicknum` int(11) unsigned NOT NULL COMMENT '访问量',
  `store_id` int(11) unsigned NOT NULL COMMENT '店铺ID',
  `type` varchar(10) NOT NULL DEFAULT '' COMMENT '类型',
  `goods_id` int(11) unsigned NOT NULL COMMENT '商品ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='访问量统计表';

/*Data for the table `feiwa_flowstat_1` */

insert  into `feiwa_flowstat_1`(`stattime`,`clicknum`,`store_id`,`type`,`goods_id`) values (1510588800,1,7,'sum',0),(1510588800,2,1,'sum',0),(1510675200,1,1,'sum',0),(1510675200,1,7,'sum',0),(1513180800,2,7,'sum',0),(1513785600,1,7,'sum',0),(1515945600,1,11,'sum',0),(1516032000,3,11,'sum',0),(1516032000,1,7,'sum',0),(1516204800,1,11,'sum',0),(1516550400,1,7,'sum',0),(1517500800,1,11,'sum',0),(1517760000,3,11,'sum',0),(1521993600,1,11,'sum',0),(1522252800,2,11,'sum',0),(1522684800,1,11,'sum',0),(1523203200,1,11,'sum',0),(1525017600,1,11,'sum',0);

/*Table structure for table `feiwa_flowstat_2` */

DROP TABLE IF EXISTS `feiwa_flowstat_2`;

CREATE TABLE `feiwa_flowstat_2` (
  `stattime` int(11) unsigned NOT NULL COMMENT '访问日期',
  `clicknum` int(11) unsigned NOT NULL COMMENT '访问量',
  `store_id` int(11) unsigned NOT NULL COMMENT '店铺ID',
  `type` varchar(10) NOT NULL DEFAULT '' COMMENT '类型',
  `goods_id` int(11) unsigned NOT NULL COMMENT '商品ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='访问量统计表';

/*Data for the table `feiwa_flowstat_2` */

insert  into `feiwa_flowstat_2`(`stattime`,`clicknum`,`store_id`,`type`,`goods_id`) values (1513699200,2,8,'sum',0),(1514304000,1,8,'sum',0),(1515513600,12,8,'sum',0),(1515686400,4,8,'sum',0),(1516032000,2,8,'sum',0),(1516723200,2,8,'sum',0),(1517500800,1,8,'sum',0),(1517760000,1,8,'sum',0),(1519833600,1,8,'sum',0),(1520784000,2,8,'sum',0),(1521993600,1,8,'sum',0),(1522771200,2,8,'sum',0),(1523289600,1,8,'sum',0),(1523548800,2,8,'sum',0),(1523635200,3,8,'sum',0),(1525276800,2,8,'sum',0),(1525622400,1,8,'sum',0),(1528128000,13,8,'sum',0),(1529164800,1,8,'sum',0),(1529596800,1,8,'sum',0),(1535990400,1,8,'sum',0);

/*Table structure for table `feiwa_gadmin` */

DROP TABLE IF EXISTS `feiwa_gadmin`;

CREATE TABLE `feiwa_gadmin` (
  `gid` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `gname` varchar(50) DEFAULT NULL COMMENT '组名',
  `limits` text COMMENT '权限内容',
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='权限组';

/*Data for the table `feiwa_gadmin` */

insert  into `feiwa_gadmin`(`gid`,`gname`,`limits`) values (1,'管理员所有','7GaiJJfr9oG0gJovnRUbsNqSrKprUM8T0ha5HzLUsT9WKlLtwb-ou8Zma9RTIlIKXlXc8Z4obqLW2Bfkno9VPmZM0hIb-jLpWAPUsl9WirFs4XM87iWpGoRnjs7mzkLpHi-n31VJvobH8RHKHaFpwb-o-8Zma_RTITI57aYrAeL7KjLpWAQEsl9WWrFsIkJbyjLpWAQUsl9WarFsQTI7PmFWfvRUbtLmuoLoMTI77waJr6LUsb9WmsZ5rj84WjVK76dHMeIIDUYMIlM328XGa_RoLs8muTVdMmKb7tWF6BdEnj72zkLpjs4r_wVqHzcH4m3WzaLpHj-867JGyALX4TMZrYVdUbL7mjLpWAPEHtLmukLoMTJMGjLpWAPELtLmuiJprUMrDkUqz1fnkmJJDfFpwvM4W1LV7zbHwe3WzSLpfn-sbqLWyBfknp9VPkWdUmKbnoFWfvRUDtLmunLoMnMLfwVJCMoRnjs7WzkLpbs4s7mVK7pdzHtJGukL9Ps84WjZpH1LUsb9WWsZ5rp-n3uWK_5bHcX3WzaLpXtM4W4LV72bIkfIJ_lFpwb-oG8Zma9RTIXN6HjWdQl4obqLWOBfknp9VPoVdoUKbftFWfvRUftLmuiJJrUN7DjUp_1eXYbIlOsXZrr-867JG2ALYcXHYDUXMIgLrDtFWfvRUDi9qSrKZrUJ7rwW6-oRnjs7GKsZ5rj8YWjWpv1c4MRHp3SZ9PU-7S7JG6Bfknn9VPTZsIgJH28XGa3Pksl9WWrFtUrMLCjLpWAPEPtLmulLoMlMLDkFWfvRUDn9qSrJZHs4rLwYpD5anEeHabeFpwb-oy3Lq-APETs3ZjgY8UlH83mVpvzeHUgI1OsXZrj94b0LWGALYMmKqPWFpwb-oy5Lq-APEDs3aTlY9MXH7LzVJDrLUsb9WKqL9Ps8Yy7Fa_6eoIXGpTdVdQl4obqLW62RoLs8WuTWMAfIbTvFWfvRUHj9qSrJZDs4s7vZov5g4ITHpaTL8ns8o28Zma3P0nUJ5bdZLAlNLrzWF6BdEnk7mzkLpHk-n30a5v4cG8cKprfXc7U-7S7JWCBfknp9VPga88fIbftFWfvRUHn9qSrKprULbDuVZH4LUsb9WOnL9Ps8Yu7FZnreHIXLYDWbNDU-7S7JWOBfkno9VPhY8ogNM6jLpWAPUftLmuiKprUM7n0Uq_ubIIXLpblaMogJ328XGa4REsl9WKhLoMlLs7gYJ3ybYUf3WzaLpPi-867L2aofn4lM6PSV8XU-7S7Jm2Bfknj72uTZ88lH7jmYJ7rfTHtJGukJpwl-oyxLV72fXUWIKHgZ8om4obqLW-5RoLs92uTV8kTNKrtYpOoRnjs7mWsZ5rq-n3zWJ3yeXEfIFOsXZrl9Yb0LWGALX8kI5bjFpwb-o63Lq-AR0nUMaPQY9MWJc2jLpWAPkbtLmunLoMkJbH2YZCoRnjs7mmsZ5ro-n3zWKD7fX3U9pqrJ5ntM4W6LV78fW8kIJfmYsTU-7S7K2yBfknj72uTV8AgM8Dta5X0cjHtJGulJZwl-oG7FZX0cX8kKFOsXZrm8ob0LWSALXUoHJ3mVdUX4obqLWC5RoLs92uTV8AfMLfiXJqoRnjs82WsZ5rr-n3wZ5H4bIQbKZiTL8ns9IC8Zma6RTIUJJ3dFpwb-o-3Lq-AQknUMaPQVsoeLH28XGa6Qksl9WKjLoMfIbftUp_1eYMnK6WTL8ns9IO8Zma3PUnULZbUXMIkJ7DkVK7qLUsb9WWqL9Ps-IWjW5HydIYXLaqTL8ns9Yu8Zma-RTIVKp_lZsIVNH28XGa7PEsl9WqrFsAiJc3ia5X1eTHtJGumJpwl-oO7FZP4eoUiHabqFpwb-oC0Lq-APEDs3afjU8gkL8DxVaH_LUsb9WalL9Ps8Y67Faz4en0hM5rgYrAVL8CjLpWAQETtLmuiK5rUMM3wYJv6dH8gGqnaVc8lKLSjLpWAQEXtLmuiK5rUMM3wYJv6dH8gGp7SYtQhLrKjLpWAQEbtLmuiLJrUMM3wYJv6dH8gGpPmYsUeKbnoFWfvRUTq9qSrJZXs4svzYpn1g3khKYDTY8AmKH28XGa7REsl9WKlLoMiMrruYqDven4RHZDgX4LtKYW3J2f5RUDn9VPhZsAfL8_qYprlcXMhI5aTL8ns9oy8Zma3QEnUL6PgYcAmKbrvUp_1eHIh3WzaLpbk-867JGCALYAkKp7gaMohLqr0YpjrLUsb9WekL9Ps-YWjZ5vveYQiLZDVFpwb-oG1Lq-AQknUMZDmV8kXMn28XGa8QEsl9WqrFtMXJMviVpfrgzHtJGunKpwl-oO7FZ3pg3koJKXqFpwb-oG4Lq-APEHs3aTlVdURJ7DvWK7nezHtJGunLJwl-oy0LV75g3EmGprfWNYlNM36FWfvRUXr9qSrJZHs4s71VKDleHUfHZbjFpwb-oKxLq-APE_s3aTlVdURM8_wZZGoRnjs8mKsZ5rj8IWjZqDng28mLZLVWYLtKYW4JWf5RUDi9VPkaMImH7LwYpD5LUsb9WikL9Ps8Y-7Fa_6bIQRKJLjX8YmKbnoFWfvRUbm9qSrJZTs4s71VKDlbHYmIKPkVc0X4ob-Zma7RTIkIJLVZ4LtIYWyJ2bBdEni9qSrJZLs4s3mVJD5an0TKZLYWYLtKYWyLq-APEDs3aPWVcUlH7TvW5H-LUsb9WOsZ5rj9oWjZZHnc4MRKZLnXcgTNLTwYV6BdEnl9qSrLZrUMrDiW6_lg3EZ3WzaLpTtM4WyJmaofXUTI6TQV8AfLbDva16BdEnn9qSrJZPs4s3mVJD5aoMiIJTaVczU-7S7KWf5RUDr9VPjWcIWM6riZaDvbnwXGpTdVdQl4obqLWOBfknj7muTZsYTJM7gVK76dHMeIFOsXZrq-867JGWALYIXHJXkU9EbI8_2ZZHlbnwTLqSTL8ns-Yb0LW25RTIkIJLVZ7AiKb71aK7rLUsvLmunLoMVKc3kY5GoRnDs92vsXZri-867JGCALXMbLZTdWbAlJc_1XJrtLUsb9WKsZ5rj8IWjVpX4bnwXGpLVaoLtKYWzLq-APELs3ZTaZsQeJaruWJnocIHU9pqrJ5wl-oy5LV7pdIIVK5bQYcYfIrDzY5H8cHvU9pqrKJwl-oy0LV7pdIIVK5bQYcIgIbLmFWfvRUTtLmuiJprUI7TzVpjranMeHKTkFpwb-oG8Zma3PUnUHprjV80XH8_pWJnrLUsb9WisZ5rj84WjVpX4bnwXGprfWsAkLX28cK-AREnULpnSZsYlKLr4FWfnRUfsNpqrJJwl-oG7FZnneXEZIFOsXZrj-867Kmaobn8fKJbfaILtKYWzLq-APknUHJXnFpwb-o68Zma7RTIZKpDVZ4LtKYW1Lq-APEDs3ZjgY8UlH77tVK_5LUsb9WasZ5rq-n3xWK75en4TK1OsXZro-867JGCALYAXLaTgYsIeH77tVK_5LUsb9WisZ5rn-n30a5v4cDHtOKSrKprULbrjXJjrLUsT9Wmrb8ns8Ib0LW22RTIfHYDkWdUmKbnoFWfvRUDtLmuiJJrULb3gZqzrbnkTK1OsXZrk-867JG2ALX0UGpTSaMYZL836FWfvRULtLmunLoMfIqriZ6yoRnjs82zkLpHj-n3uVYvscHUWHZLUX4LtKYW2Lq-APE_s3Z7TU9ETObjmYaCoRnjs8WzkLpXs4rjjUqP-LUsb9WisZ5rj8IWjYJ7lbn8gKZbUaILtPc67KGaocXUbMpKTL8Hs9oX8XGa2RoLs82uTYMogK328XGa3RoLs8GuTWsYbN7yjLpWAPUsl9WarFsghL7_0FWfvRULtLmujLoMWIn28XGa6RoLs8GuTZ9UhMrCjLpWAQEsl9WerFs4XLb3mZV6BiIzy');

/*Table structure for table `feiwa_goods` */

DROP TABLE IF EXISTS `feiwa_goods`;

CREATE TABLE `feiwa_goods` (
  `goods_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品id(SKU)',
  `goods_commonid` int(10) unsigned NOT NULL COMMENT '商品公共表id',
  `goods_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品名称（+规格名称）',
  `goods_jingle` varchar(150) DEFAULT '' COMMENT '商品广告词',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺id',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `gc_id` int(10) unsigned NOT NULL COMMENT '商品分类id',
  `gc_id_1` int(10) unsigned NOT NULL COMMENT '一级分类id',
  `gc_id_2` int(10) unsigned NOT NULL COMMENT '二级分类id',
  `gc_id_3` int(10) unsigned NOT NULL COMMENT '三级分类id',
  `brand_id` int(10) unsigned DEFAULT '0' COMMENT '品牌id',
  `goods_price` decimal(10,2) NOT NULL COMMENT '商品价格',
  `goods_promotion_price` decimal(10,2) NOT NULL COMMENT '商品促销价格',
  `goods_promotion_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '促销类型 0无促销，1团购，2限时折扣',
  `goods_marketprice` decimal(10,2) NOT NULL COMMENT '市场价',
  `goods_serial` varchar(50) DEFAULT '' COMMENT '商品货号',
  `goods_storage_alarm` tinyint(3) unsigned NOT NULL COMMENT '库存报警值',
  `goods_barcode` varchar(20) DEFAULT '' COMMENT '商品条形码',
  `goods_click` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品点击数量',
  `goods_salenum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '销售数量',
  `goods_collect` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数量',
  `spec_name` varchar(255) NOT NULL DEFAULT '' COMMENT '规格名称',
  `goods_spec` text NOT NULL COMMENT '商品规格序列化',
  `goods_storage` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品库存',
  `goods_image` varchar(100) NOT NULL DEFAULT '' COMMENT '商品主图',
  `goods_body` text NOT NULL COMMENT '商品描述',
  `mobile_body` text NOT NULL COMMENT '手机端商品描述',
  `goods_state` tinyint(3) unsigned NOT NULL COMMENT '商品状态 0下架，1正常，10违规（禁售）',
  `goods_verify` tinyint(3) unsigned NOT NULL COMMENT '商品审核 1通过，0未通过，10审核中',
  `goods_addtime` int(10) unsigned NOT NULL COMMENT '商品添加时间',
  `goods_edittime` int(10) unsigned NOT NULL COMMENT '商品编辑时间',
  `areaid_1` int(10) unsigned NOT NULL COMMENT '一级地区id',
  `areaid_2` int(10) unsigned NOT NULL COMMENT '二级地区id',
  `color_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '颜色规格id',
  `transport_id` mediumint(8) unsigned NOT NULL COMMENT '运费模板id',
  `goods_freight` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '运费 0为免运费',
  `goods_vat` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否开具增值税发票 1是，0否',
  `goods_commend` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '商品推荐 1是，0否 默认0',
  `goods_stcids` varchar(255) DEFAULT '' COMMENT '店铺分类id 首尾用,隔开',
  `evaluation_good_star` tinyint(3) unsigned NOT NULL DEFAULT '5' COMMENT '好评星级',
  `evaluation_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价数',
  `is_virtual` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为虚拟商品 1是，0否',
  `virtual_indate` int(10) unsigned NOT NULL COMMENT '虚拟商品有效期',
  `virtual_limit` tinyint(3) unsigned NOT NULL COMMENT '虚拟商品购买上限',
  `virtual_invalid_refund` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否允许过期退款， 1是，0否',
  `is_fcode` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否为F码商品 1是，0否',
  `is_presell` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是预售商品 1是，0否',
  `presell_deliverdate` int(11) NOT NULL DEFAULT '0' COMMENT '预售商品发货时间',
  `is_book` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否为预定商品，1是，0否',
  `book_down_payment` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '定金金额',
  `book_final_payment` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '尾款金额',
  `book_down_time` int(11) NOT NULL DEFAULT '0' COMMENT '预定结束时间',
  `book_buyers` mediumint(9) DEFAULT '0' COMMENT '预定人数',
  `have_gift` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否拥有赠品',
  `is_own_mall` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为平台自营',
  `contract_1` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消费者保障服务状态 0关闭 1开启',
  `contract_2` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消费者保障服务状态 0关闭 1开启',
  `contract_3` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消费者保障服务状态 0关闭 1开启',
  `contract_4` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消费者保障服务状态 0关闭 1开启',
  `contract_5` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消费者保障服务状态 0关闭 1开启',
  `contract_6` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消费者保障服务状态 0关闭 1开启',
  `contract_7` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消费者保障服务状态 0关闭 1开启',
  `contract_8` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消费者保障服务状态 0关闭 1开启',
  `contract_9` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消费者保障服务状态 0关闭 1开启',
  `contract_10` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消费者保障服务状态 0关闭 1开启',
  `is_chain` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为门店商品 1是，0否',
  `invite_rate` decimal(10,2) DEFAULT '0.00' COMMENT '分销佣金',
  `is_pf` tinyint(3) unsigned DEFAULT '0' COMMENT '是否为批发模式 1是，0否',
  `is_vip` tinyint(3) unsigned DEFAULT '0' COMMENT '是否为批发模式 1是，0否',
  `pf_num1` int(11) unsigned DEFAULT '0' COMMENT '批发模式阶梯1的数量',
  `pf_num2` int(11) unsigned DEFAULT '0' COMMENT '批发模式阶梯2的数量',
  `pf_num3` int(11) unsigned DEFAULT '0' COMMENT '批发模式阶梯3的数量',
  `pf_price1` decimal(10,2) DEFAULT '0.00' COMMENT '批发阶梯价格1',
  `pf_price2` decimal(10,2) DEFAULT '0.00' COMMENT '批发阶梯价格2',
  `pf_price3` decimal(10,2) DEFAULT '0.00' COMMENT '批发阶梯价格3',
  `pf_poinst1` int(11) unsigned DEFAULT '0' COMMENT '批发模式阶梯1的赠送积分',
  `pf_poinst2` int(11) unsigned DEFAULT '0' COMMENT '批发模式阶梯2的赠送积分',
  `pf_poinst3` int(11) unsigned DEFAULT '0' COMMENT '批发模式阶梯3的赠送积分',
  `goods_unit` varchar(255) DEFAULT '件' COMMENT '单位字段',
  `ifpf` int(2) NOT NULL DEFAULT '0' COMMENT '是否批发',
  `pf` text NOT NULL COMMENT '批发',
  PRIMARY KEY (`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100290 DEFAULT CHARSET=utf8 COMMENT='商品表';

/*Data for the table `feiwa_goods` */

insert  into `feiwa_goods`(`goods_id`,`goods_commonid`,`goods_name`,`goods_jingle`,`store_id`,`store_name`,`gc_id`,`gc_id_1`,`gc_id_2`,`gc_id_3`,`brand_id`,`goods_price`,`goods_promotion_price`,`goods_promotion_type`,`goods_marketprice`,`goods_serial`,`goods_storage_alarm`,`goods_barcode`,`goods_click`,`goods_salenum`,`goods_collect`,`spec_name`,`goods_spec`,`goods_storage`,`goods_image`,`goods_body`,`mobile_body`,`goods_state`,`goods_verify`,`goods_addtime`,`goods_edittime`,`areaid_1`,`areaid_2`,`color_id`,`transport_id`,`goods_freight`,`goods_vat`,`goods_commend`,`goods_stcids`,`evaluation_good_star`,`evaluation_count`,`is_virtual`,`virtual_indate`,`virtual_limit`,`virtual_invalid_refund`,`is_fcode`,`is_presell`,`presell_deliverdate`,`is_book`,`book_down_payment`,`book_final_payment`,`book_down_time`,`book_buyers`,`have_gift`,`is_own_mall`,`contract_1`,`contract_2`,`contract_3`,`contract_4`,`contract_5`,`contract_6`,`contract_7`,`contract_8`,`contract_9`,`contract_10`,`is_chain`,`invite_rate`,`is_pf`,`is_vip`,`pf_num1`,`pf_num2`,`pf_num3`,`pf_price1`,`pf_price2`,`pf_price3`,`pf_poinst1`,`pf_poinst2`,`pf_poinst3`,`goods_unit`,`ifpf`,`pf`) values (100213,100153,'华为 HUAWEI Mate 10 4GB+64GB','',7,'feng店铺名称',1035,256,1034,1035,184,'3999.00','3999.00',0,'3999.00','',111,'',10,0,0,'N;','N;',3999,'7_05641584812484484.jpg','','',1,1,1510814548,1529990426,1,36,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100222,100162,'二手汽车','',9,'杭州服务中心',1056,730,1054,1056,223,'400000.00','400000.00',0,'500000.00','',0,'',5,0,0,'N;','N;',999,'9_05670473063184516.jpg','','',1,1,1513703351,1517556130,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100223,100163,'asdsad','',8,'adminy',1035,256,1034,1035,0,'100.00','100.00',0,'120.00','',0,'',12,0,0,'N;','N;',999999999,'8_05671682277834917.jpg','','',1,1,1513824233,1515690855,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100224,100164,'小米note','是肯定会发生地方',8,'adminy',1035,256,1034,1035,83,'2090.00','2090.00',0,'2900.00','',0,'',28,0,0,'N;','N;',45,'8_05675387995058942.jpg','','',1,1,1514195067,1533187922,9,39,0,0,'20.00',1,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100225,100165,'2017冬季加绒女靴新款真皮女鞋尖头高跟短靴裸色细跟裸靴及踝靴女','',8,'adminy',1035,1035,0,0,0,'229.00','229.00',0,'458.00','Y16G1108',0,'',9,0,0,'','',9999,'','','',1,1,1514367356,1517582162,0,0,0,0,'0.00',0,0,'',5,0,0,0,0,1,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,'件',0,''),(100226,100166,'测试添加商品','',8,'adminy',1035,256,1034,1035,0,'1980.00','1980.00',0,'2800.00','',0,'',11,0,0,'N;','N;',99999,'8_05690878192014201.jpg','','',1,1,1515743840,1536057376,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100227,100167,'123','',11,'测试',12,1,4,12,0,'50.00','50.00',0,'50.00','',0,'',21,1,0,'N;','N;',19,'11_05690970455241560.jpg','','',10,1,1515753090,1525675057,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100228,100168,'充值卡','',8,'adminy',1057,1057,0,0,0,'100.00','100.00',0,'100.00','',0,'',8,0,0,'N;','N;',99,'8_05704559485578983.png','','',10,1,1517112005,1525674194,1,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100229,100169,'1111','',8,'adminy',1035,256,1034,1035,0,'1.00','1.00',0,'1.00','',0,'',6,0,0,'N;','N;',111,'8_05690878192014201.jpg','','',1,1,1517821382,1528985060,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100230,100170,'男士衬衫','2018新款男士衬衫',8,'adminy',1057,1057,0,0,221,'100.00','100.00',0,'300.00','',10,'',5,0,0,'N;','N;',99999,'8_05760962657313319.jpg','','',10,1,1522752383,1525674194,9,39,0,0,'10.00',0,1,',8,',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,1,'a:6:{s:2:\"q1\";s:2:\"10\";s:2:\"f1\";s:2:\"50\";s:2:\"q2\";s:2:\"10\";s:2:\"f2\";s:2:\"40\";s:2:\"q3\";s:2:\"10\";s:2:\"f3\";s:2:\"30\";}'),(100231,100171,'dfddfd dfdfdf','dfdfdf',8,'adminy',12,1,4,12,282,'38.00','38.00',0,'48.00','3434343344',2,'3432343434',2,0,0,'N;','N;',222,'8_05784145755325374.jpg','','',10,1,1525070658,1525675057,19,291,0,0,'0.00',0,1,',9,',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,1,'a:6:{s:2:\"q1\";s:2:\"23\";s:2:\"f1\";s:2:\"28\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100232,100172,'美素力（frisolac）金装婴儿配方奶粉 1段（0-6个月婴儿适用）','',6,'商城',478,470,471,478,0,'400.00','400.00',0,'420.00','',0,'',10,0,0,'N;','N;',1000,'6_05790954343413037.jpg','','',1,1,1525751447,1536566352,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100233,100173,'美素佳儿（Friso Prestige) 皇家较大婴儿配方奶粉 2段 （6-12个月婴幼儿适用）','美素佳儿（Friso Prestige) 皇家较大婴儿配方奶粉 2段 （6-12个月婴幼儿适用）',6,'商城',479,470,471,479,0,'380.00','380.00',0,'400.00','',0,'',1,0,0,'N;','N;',400,'6_05790955563332956.jpg','','',1,1,1525751561,1532078555,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100234,100174,'爱他美卓萃幼儿配方奶粉（12—36月龄，3段）900g','爱他美卓萃幼儿配方奶粉（12—36月龄，3段）900g',6,'商城',486,470,471,486,0,'400.00','400.00',0,'420.00','',0,'',2,0,0,'N;','N;',100,'6_05790956423059031.jpg','','',1,1,1525751645,1532081775,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100235,100175,'爱他美卓萃儿童配方调制乳粉（36—72月龄，4段）','爱他美卓萃儿童配方调制乳粉（36—72月龄，4段）',6,'商城',478,470,471,478,0,'400.00','400.00',0,'450.00','',0,'',20,0,0,'N;','N;',100,'6_05790956949555934.jpg','','',1,1,1525751698,1536117160,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100236,100176,'安满（Anmum）智孕宝 孕妇配方奶粉800克（新西兰原装进口）','安满（Anmum）智孕宝 孕妇配方奶粉800克（新西兰原装进口）',6,'商城',478,470,471,478,0,'188.00','188.00',0,'200.00','',0,'',0,0,0,'N;','N;',100,'6_05790958149971269.jpg','','',1,1,1525751839,1525751841,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100237,100177,'雅培(Abbott)亲护较大婴儿配方奶粉 2段820克','雅培(Abbott)亲护较大婴儿配方奶粉 2段820克',6,'商城',478,470,471,478,0,'222.00','222.00',0,'240.00','',0,'',5,0,0,'N;','N;',100,'6_05790959077707398.jpg','','',1,1,1525751912,1532086517,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100238,100178,'惠氏启赋（Wyeth illuma）3段奶粉','惠氏启赋（Wyeth illuma）3段奶粉',6,'商城',486,470,471,486,0,'300.00','300.00',0,'320.00','',0,'',0,0,0,'N;','N;',100,'6_05790959867376758.jpg','','',1,1,1525751990,1525751991,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100239,100179,'嘉宝(Gerber ) 婴幼儿米粉 宝宝辅食 原味营养米粉一段','嘉宝(Gerber ) 婴幼儿米粉 宝宝辅食 原味营养米粉一段',6,'商城',478,470,471,478,0,'48.00','48.00',0,'55.00','',0,'',0,0,0,'N;','N;',100,'6_05790960461426775.jpg','','',1,1,1525752049,1525752051,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100240,100180,'亨氏 (Heinz) 宝宝辅食 婴儿面条 金装粒粒面－猪肝枸杞 320g','亨氏 (Heinz) 宝宝辅食 婴儿面条 金装粒粒面－猪肝枸杞 320g',6,'商城',479,470,471,479,0,'39.00','39.00',0,'42.00','',0,'',5,0,0,'N;','N;',100,'6_05790961092598660.jpg','','',1,1,1525752112,1536137360,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100242,100182,'亨氏 (Heinz) 宝宝零食 婴儿肉泥 安心肉泥套餐—优惠套装E','亨氏 (Heinz) 宝宝零食 婴儿肉泥 安心肉泥套餐—优惠套装E',6,'商城',478,470,471,478,0,'300.00','300.00',0,'340.00','',0,'',2,6,0,'N;','N;',94,'6_05791013859287600.jpg','','',1,1,1525757388,1536137785,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100243,100183,'合生元（BIOSTIME）儿童益生菌冲剂(益生元)26袋装','合生元（BIOSTIME）儿童益生菌冲剂(益生元)26袋装',6,'商城',478,470,471,478,0,'161.00','161.00',0,'180.00','',0,'',0,0,0,'N;','N;',100,'6_05791014397640936.jpg','','',1,1,1525757442,1525757444,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100244,100184,'拉杜蓝乔（latourangelle）核桃油（婴幼儿）','拉杜蓝乔（latourangelle）核桃油（婴幼儿）',6,'商城',478,470,471,478,0,'168.00','168.00',0,'175.00','',0,'',1,0,0,'N;','N;',100,'6_05791014867519451.jpg','','',1,1,1525757489,1532079705,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100245,100185,'美国童年时光CHILDLIFE钙镁锌婴儿幼儿童补钙宝宝补锌液体钙 6个月以上','美国童年时光CHILDLIFE钙镁锌婴儿幼儿童补钙宝宝补锌液体钙 6个月以上',6,'商城',478,470,471,478,0,'168.00','168.00',0,'178.00','',0,'',0,0,0,'N;','N;',100,'6_05791015324909804.jpg','','',1,1,1525757535,1525757536,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100246,100186,'方广 儿童零食 肉松 钙铁锌猪肉酥肉粉松 100g','方广 儿童零食 肉松 钙铁锌猪肉酥肉粉松 100g',6,'商城',478,470,471,478,0,'33.00','33.00',0,'36.00','',0,'',2,0,0,'N;','N;',100,'6_05791015808970258.jpg','','',1,1,1525757583,1532082674,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100247,100187,'衍生小儿七星茶固体饮料（经典装）','衍生小儿七星茶固体饮料（经典装）',6,'商城',478,470,471,478,0,'75.00','75.00',0,'80.00','',0,'',0,0,0,'N;','N;',100,'6_05791016254193023.jpg','','',1,1,1525757627,1525757629,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100248,100188,'花王（Merries）纸尿裤 L54片 大号尿不湿（9-14kg）','花王（Merries）纸尿裤 L54片 大号尿不湿（9-14kg）',6,'商城',1035,256,1034,1035,0,'99.00','99.00',0,'120.00','',0,'',0,0,0,'N;','N;',100,'6_05791016835295791.jpg','','',1,1,1525757686,1525757688,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100249,100189,'花王（Merries）纸尿裤 M64片 中号尿不湿（6-11kg）','花王（Merries）纸尿裤 M64片 中号尿不湿（6-11kg）',6,'商城',1035,256,1034,1035,0,'95.00','95.00',0,'100.00','',0,'',1,0,0,'N;','N;',100,'6_05791017279899925.jpg','','',1,1,1525757730,1533275044,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100250,100190,'王（Merries）纸尿裤 XL44片 加大号尿不湿（12-20kg）','王（Merries）纸尿裤 XL44片 加大号尿不湿（12-20kg）',6,'商城',1035,256,1034,1035,0,'119.00','119.00',0,'125.00','',0,'',6,0,0,'N;','N;',100,'6_05791017752734288.jpg','','',1,1,1525757780,1532080949,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100251,100191,'花王（Merries）纸尿裤 S82片 小号尿不湿（4-8kg）','花王（Merries）纸尿裤 S82片 小号尿不湿（4-8kg）',6,'商城',1035,256,1034,1035,0,'95.00','95.00',0,'100.00','',0,'',6,0,1,'N;','N;',100,'6_05791018360977876.jpg','','',1,1,1525757838,1535725269,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100252,100192,'花王（Merries）拉拉裤 XL38片 加大号学步裤（12-17kg）','花王（Merries）拉拉裤 XL38片 加大号学步裤（12-17kg）',6,'商城',1035,256,1034,1035,0,'105.00','105.00',0,'120.00','',0,'',1,0,0,'N;','N;',100,'6_05791018889975263.jpg','','',1,1,1525757892,1532078417,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100253,100193,'可靠 吸收宝 成人纸尿裤 老年人产妇尿裤M-L号10片*8包','可靠 吸收宝 成人纸尿裤 老年人产妇尿裤M-L号10片*8包',6,'商城',1035,256,1034,1035,0,'130.00','130.00',0,'150.00','',0,'',1,0,0,'N;','N;',100,'6_05791019367334995.jpg','','',1,1,1525757939,1533275065,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100254,100194,'五羊（FIVERAMS）婴儿护肤柔湿巾80片×3包宝宝湿纸巾带盖抽纸湿巾','五羊（FIVERAMS）婴儿护肤柔湿巾80片×3包宝宝湿纸巾带盖抽纸湿巾',6,'商城',1035,256,1034,1035,0,'19.00','19.00',0,'21.00','',0,'',0,0,0,'N;','N;',100,'6_05791019767315044.jpg','','',1,1,1525757984,1525757986,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100255,100195,'贝亲（Pigeon）宽口径玻璃奶瓶 160ml AA72','贝亲（Pigeon）宽口径玻璃奶瓶 160ml AA72',6,'商城',1035,256,1034,1035,0,'93.00','93.00',0,'100.00','',0,'',0,0,0,'N;','N;',100,'6_05791020286171638.jpg','','',1,1,1525758031,1525758033,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100256,100196,'飞利浦新安怡 英国进口 AVENT 时尚安抚奶嘴6-18个月','飞利浦新安怡 英国进口 AVENT 时尚安抚奶嘴6-18个月',6,'商城',1035,256,1034,1035,0,'56.00','56.00',0,'60.00','',0,'',2,0,0,'N;','N;',100,'6_05791020695050816.jpg','','',1,1,1525758072,1533275158,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100257,100197,'小白熊 便携奶粉储存盒 婴儿独立可拆奶粉格','小白熊 便携奶粉储存盒 婴儿独立可拆奶粉格',6,'商城',1035,256,1034,1035,0,'13.90','13.90',0,'15.00','',0,'',0,0,0,'N;','N;',100,'6_05791021083025823.jpg','','',1,1,1525758110,1525758112,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100258,100198,'贝亲（Pigeon）独立开口三层奶粉盒 CA07','贝亲（Pigeon）独立开口三层奶粉盒 CA07',6,'商城',1035,256,1034,1035,0,'54.60','54.60',0,'62.00','',0,'',2,0,0,'N;','N;',100,'6_05791021557730356.jpg','','',1,1,1525758158,1533275154,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100259,100199,'象宝宝（elepbaby）宝宝吃饭罩衣 婴儿围兜','象宝宝（elepbaby）宝宝吃饭罩衣 婴儿围兜',6,'商城',1035,256,1034,1035,0,'29.00','29.00',0,'32.00','',0,'',2,0,0,'N;','N;',100,'6_05791021959746394.jpg','','',1,1,1525758198,1533275162,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100260,100200,'飞利浦 新安怡（AVENT）七安士卡通吸管杯','飞利浦 新安怡（AVENT）七安士卡通吸管杯',6,'商城',1035,256,1034,1035,0,'59.00','59.00',0,'65.00','',0,'',2,0,0,'N;','N;',100,'6_05791022372517357.jpg','','',1,1,1525758240,1532082509,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100261,100201,'小白熊 (Snow Bear) 婴儿奶瓶蒸汽消毒器带烘干','小白熊 (Snow Bear) 婴儿奶瓶蒸汽消毒器带烘干',6,'商城',1035,256,1034,1035,0,'269.00','269.00',0,'288.00','',0,'',1,0,0,'N;','N;',100,'6_05791022845352222.jpg','','',1,1,1525758287,1533275042,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100262,100202,'小白熊 （Snow Bear）婴儿辅食机','小白熊 （Snow Bear）婴儿辅食机',6,'商城',1035,256,1034,1035,0,'299.00','299.00',0,'310.00','',0,'',2,0,0,'N;','N;',100,'6_05791023313047855.jpg','','',1,1,1525758334,1533275075,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100263,100203,'新贝 电动吸奶器','新贝 电动吸奶器',6,'商城',1035,256,1034,1035,0,'225.00','225.00',0,'230.00','',0,'',1,0,0,'N;','N;',100,'6_05791023787756095.jpg','','',1,1,1525758381,1532079586,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100264,100204,'强生(Johnson) 婴儿牛奶沐浴露1000ml','强生(Johnson) 婴儿牛奶沐浴露1000ml',6,'商城',1035,256,1034,1035,0,'57.00','57.00',0,'62.00','',0,'',0,0,0,'N;','N;',100,'6_05791024153887525.jpg','','',1,1,1525758425,1525758426,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100265,100205,'日康婴儿浴盆 洗澡盆 大号带躺板','日康婴儿浴盆 洗澡盆 大号带躺板',6,'商城',1035,256,1034,1035,0,'96.00','96.00',0,'100.00','',0,'',5,0,0,'N;','N;',100,'6_05791024667273344.jpg','','',1,1,1525758469,1533275151,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100266,100206,'贝亲（Pigeon）婴儿多效洗衣液','贝亲（Pigeon）婴儿多效洗衣液',6,'商城',1035,256,1034,1035,0,'41.00','41.00',0,'45.00','',0,'',0,0,0,'N;','N;',100,'6_05791025042772560.jpg','','',1,1,1525758506,1525758506,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100267,100207,'世纪宝贝babyhood 淘气鸭儿童坐便器','世纪宝贝babyhood 淘气鸭儿童坐便器',6,'商城',1035,256,1034,1035,0,'68.00','68.00',0,'72.00','',0,'',4,0,0,'N;','N;',100,'6_05791025690171066.jpg','','',1,1,1525758571,1533275344,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100268,100208,'贝亲（Pigeon）婴儿护臀膏 35g IA149','贝亲（Pigeon）婴儿护臀膏 35g IA149',6,'商城',1035,256,1034,1035,0,'29.00','29.00',0,'32.00','',0,'',1,0,0,'N;','N;',100,'6_05791026144289680.jpg','','',1,1,1525758617,1532079327,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100269,100209,'好孩子橄榄滋养婴儿卫生湿巾80片','好孩子橄榄滋养婴儿卫生湿巾80片',6,'商城',1035,256,1034,1035,0,'57.00','57.00',0,'60.00','',0,'',1,0,0,'N;','N;',100,'6_05791026636468776.jpg','','',1,1,1525758666,1533275072,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100270,100210,'易简（yijian)婴儿童理发器 宝宝剃头器','易简（yijian)婴儿童理发器 宝宝剃头器',6,'商城',1035,256,1034,1035,0,'99.00','99.00',0,'129.00','',0,'',4,0,0,'N;','N;',100,'6_05791027257195652.jpg','','',1,1,1525758727,1533275080,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100271,100211,'贝亲（Pigeon）婴儿训练牙刷三阶段-绿色+黄色','贝亲（Pigeon）婴儿训练牙刷三阶段-绿色+黄色',6,'商城',1035,256,1034,1035,0,'39.00','39.00',0,'40.00','',0,'',8,0,0,'N;','N;',100,'6_05791027630963566.jpg','','',1,1,1525758766,1535322472,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100272,100212,'润本（RUNBEN）电热蚊香液套装','润本（RUNBEN）电热蚊香液套装',6,'商城',1035,256,1034,1035,0,'48.00','48.00',0,'54.00','',0,'',0,0,0,'N;','N;',100,'6_05791028034696755.jpg','','',1,1,1525758806,1525758808,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100273,100213,'好孩子多功能婴儿推车A513-B-L148 蓝色','好孩子多功能婴儿推车A513-B-L148 蓝色',6,'商城',1035,256,1034,1035,0,'479.00','479.00',0,'500.00','',0,'',1,0,0,'N;','N;',100,'6_05791028521571841.jpg','','',1,1,1525758854,1532082221,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100274,100214,'宝宝汽车儿童安全座椅isofix接口','宝宝汽车儿童安全座椅isofix接口',6,'商城',1035,256,1034,1035,0,'2880.00','2880.00',0,'3000.00','',0,'',2,0,0,'N;','N;',100,'6_05791029019677006.jpg','','',1,1,1525758904,1533275073,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100275,100215,'婧麒 JOYNCLEON 防辐射服吊带','婧麒 JOYNCLEON 防辐射服吊带',6,'商城',1035,256,1034,1035,0,'458.00','458.00',0,'500.00','',0,'',3,0,0,'N;','N;',100,'6_05791069315571320.jpg','','',1,1,1525762934,1532078103,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100276,100216,'婧麒孕妇防辐射服孕妇装银纤维吊带四季款','婧麒孕妇防辐射服孕妇装银纤维吊带四季款',6,'商城',1035,256,1034,1035,0,'418.00','418.00',0,'428.00','',0,'',2,0,0,'N;','N;',100,'6_05791071572119235.jpg','','',1,1,1525763160,1532082387,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100277,100217,'婧麒（JOYNCLEON） 防辐射服春夏季吊带银纤维马甲孕妇','婧麒（JOYNCLEON） 防辐射服春夏季吊带银纤维马甲孕妇',6,'商城',1035,256,1034,1035,0,'428.00','428.00',0,'438.00','',0,'',2,0,0,'N;','N;',100,'6_05791071936832202.jpg','','',1,1,1525763196,1533275039,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100278,100218,'孩子多功能环保实木摇篮婴儿床','孩子多功能环保实木摇篮婴儿床',6,'商城',314,308,309,314,0,'638.00','638.00',0,'658.00','',0,'',1,0,0,'N;','N;',100,'6_05791072669576301.jpg','','',1,1,1525763269,1533275058,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100279,100219,'婴儿脚包学步脚包新生儿四季护脚鞋','婴儿脚包学步脚包新生儿四季护脚鞋',6,'商城',1035,256,1034,1035,0,'29.00','29.00',0,'32.00','',0,'',1,0,0,'N;','N;',100,'6_05791073806963100.jpg','','',1,1,1525763388,1532082650,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100280,100220,'小红豆女童吊带背心棉夏季薄款','小红豆女童吊带背心棉夏季薄款',6,'商城',1035,256,1034,1035,0,'25.00','25.00',0,'28.00','',0,'',3,0,0,'N;','N;',100,'6_05791074892100454.jpg','','',1,1,1525763491,1533275254,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100281,100221,'儿童内裤纯棉平角男女童内裤4条装','儿童内裤纯棉平角男女童内裤4条装',6,'商城',1035,256,1034,1035,0,'46.00','46.00',0,'58.00','',0,'',0,0,0,'N;','N;',100,'6_05791075928721239.jpg','','',1,1,1525763595,1525763597,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100282,100222,'男短袜春夏季防脱运动船袜男士纯棉','男短袜春夏季防脱运动船袜男士纯棉',6,'商城',1035,256,1034,1035,0,'29.00','29.00',0,'32.00','',0,'',1,0,0,'N;','N;',100,'6_05791076612318931.jpg','','',1,1,1525763663,1529561160,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100283,100223,'夏季男女童防晒透气轻薄连帽儿童皮肤衣','',6,'商城',1035,256,1034,1035,0,'99.00','99.00',0,'100.00','',0,'',18,0,0,'N;','N;',100,'6_05791093527085243.jpg','','',1,1,1525765355,1534238228,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100284,100224,'毛毛虫儿童运动鞋 海浪蓝','毛毛虫儿童运动鞋 海浪蓝',6,'商城',1035,256,1034,1035,0,'129.00','129.00',0,'136.00','',0,'',8,0,0,'N;','N;',100,'6_05791094837636994.jpg','','',1,1,1525765486,1535633226,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100285,100225,'贝因美（Beingmate）冠军宝贝 幼儿配方奶粉','',6,'商城',478,470,471,478,366,'175.00','175.00',0,'175.00','',11,'',7,0,0,'N;','N;',175175,'6_05804049290836782.jpg','','',1,1,1527061008,1531461676,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100287,100226,'惠氏（Wyeth）S-26爱儿乐奶粉1段 400克罐装','',6,'商城',478,470,471,478,365,'175.00','175.00',0,'175.00','',0,'',6,0,0,'a:1:{i:2;s:12:\"选择段位\";}','a:1:{i:1;s:12:\"400克罐装\";}',2222,'6_05804051868241314.jpg','','',1,1,1527133237,1536138592,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100288,100226,'惠氏（Wyeth）S-26爱儿乐奶粉1段 900克罐装','',6,'商城',478,470,471,478,365,'235.00','235.00',0,'235.00','',0,'',4,0,0,'a:1:{i:2;s:12:\"选择段位\";}','a:1:{i:2;s:12:\"900克罐装\";}',2222,'6_05804051868241314.jpg','','',1,1,1527133237,1527139009,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100289,100226,'惠氏（Wyeth）S-26爱儿乐奶粉1段 1200克盒装','',6,'商城',478,470,471,478,365,'308.00','308.00',0,'308.00','',0,'',13,0,0,'a:1:{i:2;s:12:\"选择段位\";}','a:1:{i:3;s:13:\"1200克盒装\";}',2222,'6_05804051868241314.jpg','','',1,1,1527133237,1536955684,0,0,0,0,'0.00',0,1,'',5,0,0,0,0,0,0,0,0,0,'0.00','0.00',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00',0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,0,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}');

/*Table structure for table `feiwa_goods_attr_index` */

DROP TABLE IF EXISTS `feiwa_goods_attr_index`;

CREATE TABLE `feiwa_goods_attr_index` (
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品id',
  `goods_commonid` int(10) unsigned NOT NULL COMMENT '商品公共表id',
  `gc_id` int(10) unsigned NOT NULL COMMENT '商品分类id',
  `type_id` int(10) unsigned NOT NULL COMMENT '类型id',
  `attr_id` int(10) unsigned NOT NULL COMMENT '属性id',
  `attr_value_id` int(10) unsigned NOT NULL COMMENT '属性值id',
  PRIMARY KEY (`goods_id`,`gc_id`,`attr_value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品与属性对应表';

/*Data for the table `feiwa_goods_attr_index` */

insert  into `feiwa_goods_attr_index`(`goods_id`,`goods_commonid`,`gc_id`,`type_id`,`attr_id`,`attr_value_id`) values (100285,100225,478,3,3,3),(100285,100225,478,3,4,7),(100285,100225,478,3,5,13),(100287,100226,478,3,3,3),(100287,100226,478,3,4,7),(100287,100226,478,3,5,13),(100288,100226,478,3,3,3),(100288,100226,478,3,4,7),(100288,100226,478,3,5,13),(100289,100226,478,3,3,3),(100289,100226,478,3,4,7),(100289,100226,478,3,5,13);

/*Table structure for table `feiwa_goods_browse` */

DROP TABLE IF EXISTS `feiwa_goods_browse`;

CREATE TABLE `feiwa_goods_browse` (
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `member_id` int(11) NOT NULL COMMENT '会员ID',
  `browsetime` int(11) NOT NULL COMMENT '浏览时间',
  `gc_id` int(11) NOT NULL COMMENT '商品分类',
  `gc_id_1` int(11) NOT NULL COMMENT '商品一级分类',
  `gc_id_2` int(11) NOT NULL COMMENT '商品二级分类',
  `gc_id_3` int(11) NOT NULL COMMENT '商品三级分类',
  PRIMARY KEY (`goods_id`,`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品浏览历史表';

/*Data for the table `feiwa_goods_browse` */

insert  into `feiwa_goods_browse`(`goods_id`,`member_id`,`browsetime`,`gc_id`,`gc_id_1`,`gc_id_2`,`gc_id_3`) values (100222,1043,1517556134,1056,730,1054,1056),(100224,1053,1515555678,1035,256,1034,1035),(100225,1052,1515573675,1035,1035,0,0),(100227,1043,1525071010,12,1,4,12),(100232,1,1536137040,478,470,471,478),(100240,1043,1529558900,479,470,471,479),(100251,1043,1525861761,1035,256,1034,1035),(100275,1043,1529561153,1035,256,1034,1035),(100282,1043,1529561163,1035,256,1034,1035),(100289,1043,1536114895,478,470,471,478);

/*Table structure for table `feiwa_goods_class` */

DROP TABLE IF EXISTS `feiwa_goods_class`;

CREATE TABLE `feiwa_goods_class` (
  `gc_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引ID',
  `gc_name` varchar(100) NOT NULL DEFAULT '' COMMENT '分类名称',
  `type_id` int(10) unsigned DEFAULT '0' COMMENT '类型id',
  `type_name` varchar(100) DEFAULT '' COMMENT '类型名称',
  `gc_parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `commis_rate` float unsigned NOT NULL DEFAULT '0' COMMENT '佣金比例',
  `gc_sort` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `gc_virtual` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布虚拟商品，1是，0否',
  `gc_title` varchar(200) DEFAULT '' COMMENT '名称',
  `gc_keywords` varchar(255) DEFAULT '' COMMENT '关键词',
  `gc_description` varchar(255) DEFAULT '' COMMENT '描述',
  `show_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '商品展示方式，1按颜色，2按SPU',
  PRIMARY KEY (`gc_id`),
  KEY `store_id` (`gc_parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1104 DEFAULT CHARSET=utf8 COMMENT='商品分类表';

/*Data for the table `feiwa_goods_class` */

insert  into `feiwa_goods_class`(`gc_id`,`gc_name`,`type_id`,`type_name`,`gc_parent_id`,`commis_rate`,`gc_sort`,`gc_virtual`,`gc_title`,`gc_keywords`,`gc_description`,`show_type`) values (1,'营养辅食',0,'',0,0,255,1,'','','',1),(2,'尿裤湿巾',0,'',0,0,255,0,'','','',1),(3,'喂养用品',0,'',0,0,255,0,'','','',1),(8,'辅食',0,'',1,0,255,1,'','','',1),(9,'营养品',0,'',1,0,255,1,'','','',1),(10,'零食',0,'',1,0,255,1,'','','',1),(101,'米粉/菜粉',0,'',8,0,255,1,'','','',1),(102,'面条/粥',0,'',8,0,255,1,'','','',1),(103,'果汁/果泥',0,'',8,0,255,1,'','','',1),(116,'益生菌/初乳',0,'',9,0,255,1,'','','',1),(117,'DHA',0,'',9,0,255,1,'','','',1),(118,'钙铁锌/维生素',0,'',9,0,255,1,'','','',1),(135,'宝宝零食',0,'',10,0,255,1,'','','',1),(136,'清火/开胃',0,'',10,0,255,1,'','','',1),(151,'按型号',0,'',2,0,255,0,'','','',1),(152,'按类型',0,'',2,0,255,0,'','','',1),(156,'NB',0,'',151,0,255,0,'','','',1),(157,'S',0,'',151,0,255,0,'','','',1),(158,'M',0,'',151,0,255,0,'','','',1),(159,'L',0,'',151,0,255,0,'','','',1),(160,'XL',0,'',151,0,255,0,'','','',1),(161,'XXL',0,'',151,0,255,0,'','','',1),(162,'拉拉裤',0,'',152,0,255,0,'','','',1),(163,'成人尿裤',0,'',152,0,255,0,'','','',1),(164,'婴儿湿巾',0,'',152,0,255,0,'','','',1),(200,'喂养类',0,'',3,0,255,0,'','','',1),(201,'电器类',0,'',3,0,255,0,'','','',1),(206,'奶瓶奶嘴',0,'',200,0,255,0,'','','',1),(207,'牙胶安抚',0,'',200,0,255,0,'','','',1),(208,'食物存储',0,'',200,0,255,0,'','','',1),(209,'儿童餐具',0,'',200,0,255,0,'','','',1),(210,'围兜/防溅衣',0,'',200,0,255,0,'','','',1),(211,'水壶/水杯',0,'',200,0,255,0,'','','',1),(218,'暖奶消毒',0,'',201,0,255,0,'','','',1),(219,'辅食料理机',0,'',201,0,255,0,'','','',1),(220,'吸奶器',0,'',201,0,255,0,'','','',1),(256,'洗护用品',0,'',0,0,255,0,'','','',1),(262,'手机',0,'',257,0,255,0,'','','',1),(263,'对讲机',0,'',257,0,255,0,'','','',1),(308,'童车童床',0,'',0,0,255,0,'','','',1),(309,'婴儿推车',0,'',308,0,255,0,'','','',1),(310,'安全座椅',0,'',308,0,255,0,'','','',1),(311,'婴儿床',0,'',308,0,255,0,'','','',1),(312,'童乐车',0,'',308,0,255,0,'','','',1),(314,'婴儿推车',0,'',309,0,255,0,'','','',1),(326,'安全座椅',0,'',310,0,255,0,'','','',1),(327,'提篮式',0,'',310,0,255,0,'','','',1),(328,'增高垫',0,'',310,0,255,0,'','','',1),(347,'婴儿床',0,'',311,0,255,0,'','','',1),(348,'婴儿床垫',0,'',311,0,255,0,'','','',1),(349,'餐椅摇椅',0,'',311,0,255,0,'','','',1),(363,'电动车',0,'',312,0,255,0,'','','',1),(364,'自行车',0,'',312,0,255,0,'','','',1),(365,'三轮车',0,'',312,0,255,0,'','','',1),(366,'滑板车',0,'',312,0,255,0,'','','',1),(367,'扭扭车',0,'',312,0,255,0,'','','',1),(368,'学步车',0,'',312,0,255,0,'','','',1),(395,'洗浴类',0,'',256,0,255,0,'','','',1),(466,'洗发沐浴',0,'',395,0,255,0,'','','',1),(467,'洗澡用具',0,'',395,0,255,0,'','','',1),(468,'洗衣液/皂',0,'',395,0,255,0,'','','',1),(469,'座便器',0,'',395,0,255,0,'','','',1),(470,'奶粉',3,'3333',0,5,254,0,'','','',1),(471,'按段数',3,'3333',470,5,255,0,'','','',1),(477,'按类型',3,'3333',470,5,255,0,'','','',1),(478,'1段a',3,'3333',471,5,255,0,'','','',1),(479,'2段',3,'3333',471,5,255,0,'','','',1),(486,'3段',3,'3333',471,5,255,0,'','','',1),(487,'4段',3,'3333',471,5,255,0,'','','',1),(525,'孕妈奶粉',3,'3333',477,5,255,0,'','','',1),(526,'特殊配方奶粉',3,'3333',477,5,255,0,'','','',1),(527,'有机奶粉',3,'3333',477,5,255,0,'','','',1),(530,'婴童寝居',0,'',0,0,255,0,'','','',1),(538,'家纺床品',0,'',530,0,255,0,'','','',1),(539,'家居棉品',0,'',530,0,255,0,'','','',1),(540,'宝宝防护',0,'',530,0,255,0,'','','',1),(577,'婴童睡袋/抱被',0,'',538,0,255,0,'','','',1),(578,'婴童枕芯/枕套',0,'',538,0,255,0,'','','',1),(579,'婴童被子/被套',0,'',538,0,255,0,'','','',1),(580,'婴童凉席/蚊帐',0,'',538,0,255,0,'','','',1),(581,'婴童隔尿垫/巾',0,'',539,0,255,0,'','','',1),(582,'婴童浴巾/浴衣',0,'',539,0,255,0,'','','',1),(583,'婴童毛巾/口水巾',0,'',539,0,255,0,'','','',1),(584,'婴童布尿裤/尿布',0,'',539,0,255,0,'','','',1),(585,'吸汗巾/垫背巾',0,'',539,0,255,0,'','','',1),(586,'婴儿鞋帽袜',0,'',539,0,255,0,'','','',1),(587,'安全防护',0,'',540,0,255,0,'','','',1),(588,'爬行垫',0,'',540,0,255,0,'','','',1),(593,'玩具乐器',0,'',0,0,255,0,'','','',1),(594,'益智早教',0,'',593,0,255,0,'','','',1),(595,'遥控户外',0,'',593,0,255,0,'','','',1),(596,'动漫模型',0,'',593,0,255,0,'','','',1),(597,'毛绒娃娃',0,'',593,0,255,0,'','','',1),(598,'乐器',0,'',593,0,255,0,'','','',1),(604,'适用年龄',0,'',594,0,255,0,'','','',1),(605,'益智玩具',0,'',594,0,255,0,'','','',1),(606,'积木拼插',0,'',594,0,255,0,'','','',1),(607,'DIY玩具',0,'',594,0,255,0,'','','',1),(608,'创意减压',0,'',594,0,255,0,'','','',1),(609,'遥控/电动',0,'',595,0,255,0,'','','',1),(610,'健身玩具',0,'',595,0,255,0,'','','',1),(616,'动漫玩具',0,'',596,0,255,0,'','','',1),(617,'模型玩具',0,'',596,0,255,0,'','','',1),(622,'毛绒布艺',0,'',597,0,255,0,'','','',1),(623,'娃娃玩具',0,'',597,0,255,0,'','','',1),(628,'钢琴',0,'',598,0,255,0,'','','',1),(629,'电子琴/电钢琴',0,'',598,0,255,0,'','','',1),(630,'吉他/尤克里里',0,'',598,0,255,0,'','','',1),(631,'打击乐器',0,'',598,0,255,0,'','','',1),(632,'西洋管弦',0,'',598,0,255,0,'','','',1),(662,'临产待产',0,'',0,0,255,0,'','','',1),(670,'临产待产',0,'',662,0,255,0,'','','',1),(721,'防溢乳垫',0,'',670,0,255,0,'','','',1),(722,'待产包',0,'',670,0,255,0,'','','',1),(723,'产妇卫生巾',0,'',670,0,255,0,'','','',1),(724,'产妇湿巾',0,'',670,0,255,0,'','','',1),(725,'产妇护垫',0,'',670,0,255,0,'','','',1),(726,'产检裤/生理裤',0,'',670,0,255,0,'','','',1),(727,'产妇清洁棉',0,'',670,0,255,0,'','','',1),(728,'产妇帽',0,'',670,0,255,0,'','','',1),(729,'早孕检测',0,'',670,0,255,0,'','','',1),(730,'孕妈穿着',0,'',0,0,255,0,'','','',1),(825,'孕妇护肤',0,'',0,0,255,0,'','','',1),(837,'孕妇护肤',0,'',825,0,255,0,'','','',1),(884,'身体护理',0,'',837,0,255,0,'','','',1),(885,'口腔护理',0,'',837,0,255,0,'','','',1),(886,'孕妈彩妆',0,'',837,0,255,0,'','','',1),(887,'其他',0,'',837,0,255,0,'','','',1),(888,'孕妇必备',0,'',0,0,255,0,'','','',1),(889,'孕妇必备',0,'',888,0,255,0,'','','',1),(901,'学步带',0,'',889,0,255,0,'','','',1),(902,'哺乳枕',0,'',889,0,255,0,'','','',1),(903,'护腰枕',0,'',889,0,255,0,'','','',1),(904,'乳房保护',0,'',889,0,255,0,'','','',1),(959,'产后纤瘦',0,'',0,0,255,0,'','','',1),(967,'产后纤瘦',0,'',959,0,255,0,'','','',1),(1026,'束腹带',0,'',967,0,255,0,'','','',1),(1027,'盆骨带',0,'',967,0,255,0,'','','',1),(1028,'塑身裤',0,'',967,0,255,0,'','','',1),(1029,'收胃带',0,'',967,0,255,0,'','','',1),(1030,'塑身套装',0,'',967,0,255,0,'','','',1),(1034,'护理类',0,'',256,0,255,0,'','','',1),(1035,'宝宝护肤',0,'',1034,0,255,0,'','','',1),(1036,'日常护理',0,'',1034,0,255,0,'','','',1),(1037,'孕妇补品',0,'',0,0,255,1,'','','',1),(1043,'孕妇补品',0,'',1037,0,255,1,'','','',1),(1047,'月子餐',0,'',1043,0,255,1,'','','',1),(1048,'钙铁锌',0,'',1043,0,255,1,'','','',1),(1049,'维生素',0,'',1043,0,255,1,'','','',1),(1050,'月乃汤',0,'',1043,0,255,1,'','','',1),(1051,'月子米酒',0,'',1043,0,255,1,'','','',1),(1052,'月子食用油',0,'',1043,0,255,1,'','','',1),(1054,'孕妈穿着',0,'',730,0,255,0,'','','',1),(1055,'防辐射吊带',0,'',1054,0,255,0,'','','',1),(1056,'防辐射肚兜',0,'',1054,0,255,0,'','','',1),(1058,'理发器',0,'',1034,0,0,0,'','','',1),(1059,'婴儿口腔清洁',0,'',1034,0,0,0,'','','',1),(1060,'驱蚊防晒',0,'',1034,0,0,0,'','','',1),(1061,'婴童床单/床褥',0,'',538,0,0,0,'','','',1),(1062,'婴童床围',0,'',538,0,0,0,'','','',1),(1063,'婴童床品套件',0,'',538,0,0,0,'','','',1),(1064,'名族管弦乐器',0,'',598,0,0,0,'','','',1),(1065,'乐器配件',0,'',598,0,0,0,'','','',1),(1066,'胎心仪',0,'',670,0,255,0,'','','',1),(1067,'孕妇马桶垫',0,'',670,0,255,0,'','','',1),(1068,'其它',0,'',670,0,255,0,'','','',1),(1069,'孕妇夏装',0,'',1054,0,255,0,'','','',1),(1070,'月子服',0,'',1054,0,255,0,'','','',1),(1071,'孕妇托腹裤',0,'',1054,0,255,0,'','','',1),(1072,'孕妇牛仔裤',0,'',1054,0,255,0,'','','',1),(1073,'哺乳文胸',0,'',1054,0,255,0,'','','',1),(1074,'孕妇内裤',0,'',1054,0,255,0,'','','',1),(1075,'孕妇鞋',0,'',1054,0,255,0,'','','',1),(1076,'孕妇袜子',0,'',1054,0,255,0,'','','',1),(1077,'其他',0,'',1043,0,255,0,'','','',1),(1078,'玩具',0,'',837,0,255,0,'','','',1),(1079,'箱包',0,'',837,0,255,0,'','','',1),(1080,'腰带',0,'',837,0,255,0,'','','',1),(1081,'玉器',0,'',837,0,255,0,'','','',1),(1082,'头饰',0,'',837,0,255,0,'','','',1),(1083,'花卉',0,'',837,0,255,0,'','','',1),(1084,'工艺品',0,'',837,0,255,0,'','','',1),(1085,'十字绣',0,'',837,0,255,0,'','','',1),(1086,'钟表',0,'',837,0,255,0,'','','',1),(1087,'雨具泳具',0,'',837,0,255,0,'','','',1),(1088,'化妆品',0,'',837,0,255,0,'','','',1),(1089,'假发',0,'',837,0,255,0,'','','',1),(1090,'帽子',0,'',837,0,255,0,'','','',1),(1091,'围巾',0,'',837,0,255,0,'','','',1),(1092,'文体',0,'',837,0,255,0,'','','',1),(1093,'办公用品',0,'',837,0,255,0,'','','',1),(1094,'塑料制品',0,'',837,0,255,0,'','','',1),(1095,'家居饰品',0,'',837,0,255,0,'','','',1),(1097,'服装',0,'',889,0,255,0,'','','',1),(1098,'童鞋',0,'',889,0,255,0,'','','',1),(1099,'成人鞋',0,'',889,0,255,0,'','','',1),(1100,'内衣',0,'',889,0,255,0,'','','',1),(1101,'袜子',0,'',889,0,255,0,'','','',1),(1102,'童装',0,'',967,0,255,0,'','','',1),(1103,'育婴用品',0,'',967,0,255,0,'','','',1);

/*Table structure for table `feiwa_goods_class_nav` */

DROP TABLE IF EXISTS `feiwa_goods_class_nav`;

CREATE TABLE `feiwa_goods_class_nav` (
  `cn_adv2_link` varchar(100) NOT NULL DEFAULT '' COMMENT '广告2链接',
  `gc_id` int(10) unsigned NOT NULL COMMENT '商品分类id',
  `cn_alias` varchar(100) DEFAULT '' COMMENT '商品分类别名',
  `cn_classids` varchar(100) DEFAULT '' COMMENT '推荐子级分类',
  `cn_brandids` varchar(100) DEFAULT '' COMMENT '推荐的品牌',
  `cn_pic` varchar(100) DEFAULT '' COMMENT '分类图片',
  `cn_adv1` varchar(100) DEFAULT '' COMMENT '广告图1',
  `cn_adv1_link` varchar(100) DEFAULT '' COMMENT '广告1链接',
  `cn_adv2` varchar(100) DEFAULT '' COMMENT '广告图2',
  PRIMARY KEY (`gc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分类导航表';

/*Data for the table `feiwa_goods_class_nav` */

insert  into `feiwa_goods_class_nav`(`cn_adv2_link`,`gc_id`,`cn_alias`,`cn_classids`,`cn_brandids`,`cn_pic`,`cn_adv1`,`cn_adv1_link`,`cn_adv2`) values ('',1,'','12,19,26,33,35,42,49,56','108,105,101,96,89,80,83,352','04849343852775378.png','04849383096194771.jpg','','04849383096284687.jpg'),('',2,'','156,163,168,170,186,192,193,198','342,341,336,335,334,330,329,328','04849344505821846.png','04849386427434184.jpg','','04849386427492123.jpg'),('',3,'','206,210,213,216,220,227,231','344,342,341,338,336,335,330,329','04849345975757419.png','04849387912371887.jpg','','04849387912422255.jpg'),('',256,'','278,279,398,399,437,1035,1036','215,214,208,202,196,190,184','04849346415545755.png','04849389240497918.jpg','','04849389240540796.jpg'),('',308,'','314,317,318,321,326,327,328,329','241,240,235,234,229,228,223,217','04849346837120218.png','04849391321812920.jpg','','04849391321877848.jpg'),('',470,'','478,479,486,487','130','04849347515759481.png','04849392722316549.jpg','','04849392722363907.jpg'),('',530,'','557,563,566,567,570,571,572,575,576','171,165,159,153,152,146,360,359','04849347913383394.png','04849399151585529.jpg','','04849399151680886.jpg'),('',593,'','605,617,623,629,630,632,636,637','264,263,258,257,252,251,246,245','04849348133390475.png','04849400285934568.jpg','','04849400285991819.jpg'),('',662,'','671,675,676,677,681,682,683,684,690','324,323,318,317,312,311,306,305','04849348436546686.png','04849401365781256.jpg','','04849401365834473.jpg'),('',730,'','738,740,744,746,752,753,754','241,240,234,228,227,222,221,216','04849348664379344.png','04849404510419498.jpg','','04849404510472921.jpg'),('',825,'','844,847,848,849,850,851,855,857','344,343,338,337,332,331,326,148','04849352366294406.png','04849405508671552.jpg','','04849405508723529.jpg'),('',888,'','895,902,918,936,939,942,943','322,321,316,315,310,309,304,303','04849352648636017.png','04849408123501895.jpg','','04849408123559604.jpg'),('',959,'','968,970,975,981,982,986,994,996','302,301,296,295,290,284,278,272','04849353182209090.png','04849409796241200.jpg','','04849409796289293.jpg'),('',1037,'','1044,1047,1048,1049,1050,1051,1052','244,243,242','04849353042725089.png','04849412911666956.jpg','','04849412911723098.jpg'),('',1057,'','','244,243,242','','','','');

/*Table structure for table `feiwa_goods_class_staple` */

DROP TABLE IF EXISTS `feiwa_goods_class_staple`;

CREATE TABLE `feiwa_goods_class_staple` (
  `staple_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '常用分类id',
  `staple_name` varchar(255) NOT NULL DEFAULT '' COMMENT '常用分类名称',
  `gc_id_1` int(10) unsigned NOT NULL COMMENT '一级分类id',
  `gc_id_2` int(10) unsigned NOT NULL COMMENT '二级商品分类',
  `gc_id_3` int(10) unsigned NOT NULL COMMENT '三级商品分类',
  `type_id` int(10) unsigned NOT NULL COMMENT '类型id',
  `member_id` int(10) unsigned NOT NULL COMMENT '会员id',
  `counter` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '计数器',
  PRIMARY KEY (`staple_id`),
  KEY `store_id` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='店铺常用分类表';

/*Data for the table `feiwa_goods_class_staple` */

insert  into `feiwa_goods_class_staple`(`staple_id`,`staple_name`,`gc_id_1`,`gc_id_2`,`gc_id_3`,`type_id`,`member_id`,`counter`) values (6,'个护化妆 >面部护理 >洁面乳',470,471,478,1,1,2),(8,'数码办公 >手机通讯 >手机',256,1034,1035,0,1042,3),(25,'汽车用品 >整车 >二手车',730,1054,1056,0,1044,2),(28,'数码办公 >手机通讯 >手机',256,1034,1035,0,1043,3),(31,'洗护用品 >护理类 >宝宝护肤',256,1034,1035,0,1041,38),(32,'奶粉 >按段数 >2段',470,471,479,1,1041,8),(33,'奶粉 >按段数 >3段',470,471,486,1,1041,4),(34,'奶粉 >按段数 >1段',470,471,478,1,1041,14),(35,'童车童床 >婴儿推车 >婴儿推车',308,309,314,0,1041,1),(36,'奶粉 >按段数 >2段',470,471,479,3,1,1);

/*Table structure for table `feiwa_goods_class_tag` */

DROP TABLE IF EXISTS `feiwa_goods_class_tag`;

CREATE TABLE `feiwa_goods_class_tag` (
  `gc_tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'TAGid',
  `gc_id_1` int(10) unsigned NOT NULL COMMENT '一级分类id',
  `gc_id_2` int(10) unsigned NOT NULL COMMENT '二级分类id',
  `gc_id_3` int(10) unsigned NOT NULL COMMENT '三级分类id',
  `gc_tag_name` varchar(255) NOT NULL DEFAULT '' COMMENT '分类TAG名称',
  `gc_tag_value` text NOT NULL COMMENT '分类TAG值',
  `gc_id` int(10) unsigned NOT NULL COMMENT '商品分类id',
  `type_id` int(10) unsigned NOT NULL COMMENT '类型id',
  PRIMARY KEY (`gc_tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=902 DEFAULT CHARSET=utf8 COMMENT='商品分类TAG表';

/*Data for the table `feiwa_goods_class_tag` */

insert  into `feiwa_goods_class_tag`(`gc_tag_id`,`gc_id_1`,`gc_id_2`,`gc_id_3`,`gc_tag_name`,`gc_tag_value`,`gc_id`,`type_id`) values (1,470,471,478,'个护化妆123123&nbsp;&gt;&nbsp;面部护理&nbsp;&gt;&nbsp;洁面乳','个护化妆123123,面部护理,洁面乳',478,1),(2,470,471,479,'个护化妆123123&nbsp;&gt;&nbsp;面部护理&nbsp;&gt;&nbsp;爽肤水','个护化妆123123,面部护理,爽肤水',479,1),(9,470,471,486,'个护化妆123123&nbsp;&gt;&nbsp;面部护理&nbsp;&gt;&nbsp;护肤套装','个护化妆123123,面部护理,护肤套装',486,1),(10,470,471,487,'个护化妆123123&nbsp;&gt;&nbsp;面部护理&nbsp;&gt;&nbsp;防晒隔离','个护化妆123123,面部护理,防晒隔离',487,1),(48,470,477,525,'个护化妆123123&nbsp;&gt;&nbsp;香水SPA&nbsp;&gt;&nbsp;女士香水','个护化妆123123,香水SPA,女士香水',525,1),(49,470,477,526,'个护化妆123123&nbsp;&gt;&nbsp;香水SPA&nbsp;&gt;&nbsp;男士香水','个护化妆123123,香水SPA,男士香水',526,1),(50,470,477,527,'个护化妆123123&nbsp;&gt;&nbsp;香水SPA&nbsp;&gt;&nbsp;组合套装','个护化妆123123,香水SPA,组合套装',527,1),(143,1,8,101,'服饰鞋帽&nbsp;&gt;&nbsp;女鞋&nbsp;&gt;&nbsp;雨鞋／雨靴','服饰鞋帽,女鞋,雨鞋／雨靴',101,0),(144,1,8,102,'服饰鞋帽&nbsp;&gt;&nbsp;女鞋&nbsp;&gt;&nbsp;妈妈鞋','服饰鞋帽,女鞋,妈妈鞋',102,0),(145,1,8,103,'服饰鞋帽&nbsp;&gt;&nbsp;女鞋&nbsp;&gt;&nbsp;鞋配件','服饰鞋帽,女鞋,鞋配件',103,0),(158,1,9,116,'服饰鞋帽&nbsp;&gt;&nbsp;男鞋&nbsp;&gt;&nbsp;帆布鞋','服饰鞋帽,男鞋,帆布鞋',116,0),(159,1,9,117,'服饰鞋帽&nbsp;&gt;&nbsp;男鞋&nbsp;&gt;&nbsp;豆豆鞋','服饰鞋帽,男鞋,豆豆鞋',117,0),(160,1,9,118,'服饰鞋帽&nbsp;&gt;&nbsp;男鞋&nbsp;&gt;&nbsp;驾车鞋','服饰鞋帽,男鞋,驾车鞋',118,0),(177,1,10,135,'服饰鞋帽&nbsp;&gt;&nbsp;配饰&nbsp;&gt;&nbsp;防紫外线手套','服饰鞋帽,配饰,防紫外线手套',135,0),(178,1,10,136,'服饰鞋帽&nbsp;&gt;&nbsp;配饰&nbsp;&gt;&nbsp;草帽','服饰鞋帽,配饰,草帽',136,0),(193,2,151,156,'礼品箱包&nbsp;&gt;&nbsp;潮流女包&nbsp;&gt;&nbsp;钱包/卡包','礼品箱包,潮流女包,钱包/卡包',156,0),(194,2,151,157,'礼品箱包&nbsp;&gt;&nbsp;潮流女包&nbsp;&gt;&nbsp;手拿包','礼品箱包,潮流女包,手拿包',157,0),(195,2,151,158,'礼品箱包&nbsp;&gt;&nbsp;潮流女包&nbsp;&gt;&nbsp;单肩包','礼品箱包,潮流女包,单肩包',158,0),(196,2,151,159,'礼品箱包&nbsp;&gt;&nbsp;潮流女包&nbsp;&gt;&nbsp;双肩包','礼品箱包,潮流女包,双肩包',159,0),(197,2,151,160,'礼品箱包&nbsp;&gt;&nbsp;潮流女包&nbsp;&gt;&nbsp;手提包','礼品箱包,潮流女包,手提包',160,0),(198,2,151,161,'礼品箱包&nbsp;&gt;&nbsp;潮流女包&nbsp;&gt;&nbsp;斜挎包','礼品箱包,潮流女包,斜挎包',161,0),(199,2,152,162,'礼品箱包&nbsp;&gt;&nbsp;时尚男包&nbsp;&gt;&nbsp;钱包/卡包','礼品箱包,时尚男包,钱包/卡包',162,0),(200,2,152,163,'礼品箱包&nbsp;&gt;&nbsp;时尚男包&nbsp;&gt;&nbsp;男士手包','礼品箱包,时尚男包,男士手包',163,0),(201,2,152,164,'礼品箱包&nbsp;&gt;&nbsp;时尚男包&nbsp;&gt;&nbsp;腰带／礼盒','礼品箱包,时尚男包,腰带／礼盒',164,0),(236,3,200,206,'家居家装&nbsp;&gt;&nbsp;家纺&nbsp;&gt;&nbsp;床品件套','家居家装,家纺,床品件套',206,0),(237,3,200,207,'家居家装&nbsp;&gt;&nbsp;家纺&nbsp;&gt;&nbsp;被子','家居家装,家纺,被子',207,0),(238,3,200,208,'家居家装&nbsp;&gt;&nbsp;家纺&nbsp;&gt;&nbsp;枕芯枕套','家居家装,家纺,枕芯枕套',208,0),(239,3,200,209,'家居家装&nbsp;&gt;&nbsp;家纺&nbsp;&gt;&nbsp;床单被罩','家居家装,家纺,床单被罩',209,0),(240,3,200,210,'家居家装&nbsp;&gt;&nbsp;家纺&nbsp;&gt;&nbsp;毛巾被/毯','家居家装,家纺,毛巾被/毯',210,0),(241,3,200,211,'家居家装&nbsp;&gt;&nbsp;家纺&nbsp;&gt;&nbsp;床垫/床褥','家居家装,家纺,床垫/床褥',211,0),(248,3,201,218,'家居家装&nbsp;&gt;&nbsp;灯具&nbsp;&gt;&nbsp;台灯','家居家装,灯具,台灯',218,0),(249,3,201,219,'家居家装&nbsp;&gt;&nbsp;灯具&nbsp;&gt;&nbsp;节能灯','家居家装,灯具,节能灯',219,0),(250,3,201,220,'家居家装&nbsp;&gt;&nbsp;灯具&nbsp;&gt;&nbsp;装饰灯','家居家装,灯具,装饰灯',220,0),(398,256,395,466,'数码办公&nbsp;&gt;&nbsp;办公文仪&nbsp;&gt;&nbsp;安防监控','数码办公,办公文仪,安防监控',466,0),(399,256,395,467,'数码办公&nbsp;&gt;&nbsp;办公文仪&nbsp;&gt;&nbsp;呼叫/会议设备','数码办公,办公文仪,呼叫/会议设备',467,0),(400,256,395,468,'数码办公&nbsp;&gt;&nbsp;办公文仪&nbsp;&gt;&nbsp;保险柜','数码办公,办公文仪,保险柜',468,0),(401,256,395,469,'数码办公&nbsp;&gt;&nbsp;办公文仪&nbsp;&gt;&nbsp;办公家具','数码办公,办公文仪,办公家具',469,0),(402,256,1034,1035,'数码办公&nbsp;&gt;&nbsp;手机通讯&nbsp;&gt;&nbsp;手机','数码办公,手机通讯,手机',1035,0),(403,256,1034,1036,'数码办公&nbsp;&gt;&nbsp;手机通讯&nbsp;&gt;&nbsp;对讲机','数码办公,手机通讯,对讲机',1036,0),(404,308,309,314,'家用电器&nbsp;&gt;&nbsp;大家电&nbsp;&gt;&nbsp;平板电视','家用电器,大家电,平板电视',314,0),(416,308,310,326,'家用电器&nbsp;&gt;&nbsp;生活电器&nbsp;&gt;&nbsp;净化器','家用电器,生活电器,净化器',326,0),(417,308,310,327,'家用电器&nbsp;&gt;&nbsp;生活电器&nbsp;&gt;&nbsp;电风扇','家用电器,生活电器,电风扇',327,0),(418,308,310,328,'家用电器&nbsp;&gt;&nbsp;生活电器&nbsp;&gt;&nbsp;吸尘器','家用电器,生活电器,吸尘器',328,0),(437,308,311,347,'家用电器&nbsp;&gt;&nbsp;厨房电器&nbsp;&gt;&nbsp;微波炉','家用电器,厨房电器,微波炉',347,0),(438,308,311,348,'家用电器&nbsp;&gt;&nbsp;厨房电器&nbsp;&gt;&nbsp;电烤箱','家用电器,厨房电器,电烤箱',348,0),(439,308,311,349,'家用电器&nbsp;&gt;&nbsp;厨房电器&nbsp;&gt;&nbsp;电磁炉','家用电器,厨房电器,电磁炉',349,0),(453,308,312,363,'家用电器&nbsp;&gt;&nbsp;个护健康&nbsp;&gt;&nbsp;美发器','家用电器,个护健康,美发器',363,0),(454,308,312,364,'家用电器&nbsp;&gt;&nbsp;个护健康&nbsp;&gt;&nbsp;按摩椅','家用电器,个护健康,按摩椅',364,0),(455,308,312,365,'家用电器&nbsp;&gt;&nbsp;个护健康&nbsp;&gt;&nbsp;按摩器','家用电器,个护健康,按摩器',365,0),(456,308,312,366,'家用电器&nbsp;&gt;&nbsp;个护健康&nbsp;&gt;&nbsp;足浴盆','家用电器,个护健康,足浴盆',366,0),(457,308,312,367,'家用电器&nbsp;&gt;&nbsp;个护健康&nbsp;&gt;&nbsp;血压计','家用电器,个护健康,血压计',367,0),(458,308,312,368,'家用电器&nbsp;&gt;&nbsp;个护健康&nbsp;&gt;&nbsp;健康秤/厨房秤','家用电器,个护健康,健康秤/厨房秤',368,0),(515,530,538,577,'珠宝手表&nbsp;&gt;&nbsp;宝石珍珠&nbsp;&gt;&nbsp;项链/吊坠','珠宝手表,宝石珍珠,项链/吊坠',577,0),(516,530,538,578,'珠宝手表&nbsp;&gt;&nbsp;宝石珍珠&nbsp;&gt;&nbsp;耳饰','珠宝手表,宝石珍珠,耳饰',578,0),(517,530,538,579,'珠宝手表&nbsp;&gt;&nbsp;宝石珍珠&nbsp;&gt;&nbsp;手镯/手链','珠宝手表,宝石珍珠,手镯/手链',579,0),(518,530,538,580,'珠宝手表&nbsp;&gt;&nbsp;宝石珍珠&nbsp;&gt;&nbsp;戒指','珠宝手表,宝石珍珠,戒指',580,0),(519,530,539,581,'珠宝手表&nbsp;&gt;&nbsp;婚庆&nbsp;&gt;&nbsp;婚嫁首饰','珠宝手表,婚庆,婚嫁首饰',581,0),(520,530,539,582,'珠宝手表&nbsp;&gt;&nbsp;婚庆&nbsp;&gt;&nbsp;婚纱摄影','珠宝手表,婚庆,婚纱摄影',582,0),(521,530,539,583,'珠宝手表&nbsp;&gt;&nbsp;婚庆&nbsp;&gt;&nbsp;婚纱礼服','珠宝手表,婚庆,婚纱礼服',583,0),(522,530,539,584,'珠宝手表&nbsp;&gt;&nbsp;婚庆&nbsp;&gt;&nbsp;婚庆服务','珠宝手表,婚庆,婚庆服务',584,0),(523,530,539,585,'珠宝手表&nbsp;&gt;&nbsp;婚庆&nbsp;&gt;&nbsp;婚庆礼品/用品','珠宝手表,婚庆,婚庆礼品/用品',585,0),(524,530,539,586,'珠宝手表&nbsp;&gt;&nbsp;婚庆&nbsp;&gt;&nbsp;婚宴','珠宝手表,婚庆,婚宴',586,0),(525,530,540,587,'珠宝手表&nbsp;&gt;&nbsp;钟表手表&nbsp;&gt;&nbsp;瑞士品牌','珠宝手表,钟表手表,瑞士品牌',587,0),(526,530,540,588,'珠宝手表&nbsp;&gt;&nbsp;钟表手表&nbsp;&gt;&nbsp;国产品牌','珠宝手表,钟表手表,国产品牌',588,0),(531,593,594,604,'食品饮料&nbsp;&gt;&nbsp;进口食品&nbsp;&gt;&nbsp;饼干蛋糕','食品饮料,进口食品,饼干蛋糕',604,0),(532,593,594,605,'食品饮料&nbsp;&gt;&nbsp;进口食品&nbsp;&gt;&nbsp;糖果巧克力','食品饮料,进口食品,糖果巧克力',605,0),(533,593,594,606,'食品饮料&nbsp;&gt;&nbsp;进口食品&nbsp;&gt;&nbsp;休闲零食','食品饮料,进口食品,休闲零食',606,0),(534,593,594,607,'食品饮料&nbsp;&gt;&nbsp;进口食品&nbsp;&gt;&nbsp;冲调饮品','食品饮料,进口食品,冲调饮品',607,0),(535,593,594,608,'食品饮料&nbsp;&gt;&nbsp;进口食品&nbsp;&gt;&nbsp;粮油调味','食品饮料,进口食品,粮油调味',608,0),(536,593,595,609,'食品饮料&nbsp;&gt;&nbsp;地方特产&nbsp;&gt;&nbsp;华北','食品饮料,地方特产,华北',609,0),(537,593,595,610,'食品饮料&nbsp;&gt;&nbsp;地方特产&nbsp;&gt;&nbsp;西北','食品饮料,地方特产,西北',610,0),(543,593,596,616,'食品饮料&nbsp;&gt;&nbsp;休闲食品&nbsp;&gt;&nbsp;休闲零食','食品饮料,休闲食品,休闲零食',616,0),(544,593,596,617,'食品饮料&nbsp;&gt;&nbsp;休闲食品&nbsp;&gt;&nbsp;坚果炒货','食品饮料,休闲食品,坚果炒货',617,0),(549,593,597,622,'食品饮料&nbsp;&gt;&nbsp;粮油调味&nbsp;&gt;&nbsp;米面杂粮','食品饮料,粮油调味,米面杂粮',622,0),(550,593,597,623,'食品饮料&nbsp;&gt;&nbsp;粮油调味&nbsp;&gt;&nbsp;食用油','食品饮料,粮油调味,食用油',623,0),(555,593,598,628,'食品饮料&nbsp;&gt;&nbsp;中外名酒&nbsp;&gt;&nbsp;白酒','食品饮料,中外名酒,白酒',628,0),(556,593,598,629,'食品饮料&nbsp;&gt;&nbsp;中外名酒&nbsp;&gt;&nbsp;洋酒','食品饮料,中外名酒,洋酒',629,0),(557,593,598,630,'食品饮料&nbsp;&gt;&nbsp;中外名酒&nbsp;&gt;&nbsp;葡萄酒','食品饮料,中外名酒,葡萄酒',630,0),(558,593,598,631,'食品饮料&nbsp;&gt;&nbsp;中外名酒&nbsp;&gt;&nbsp;啤酒','食品饮料,中外名酒,啤酒',631,0),(559,593,598,632,'食品饮料&nbsp;&gt;&nbsp;中外名酒&nbsp;&gt;&nbsp;黄酒','食品饮料,中外名酒,黄酒',632,0),(639,662,670,721,'运动健康&nbsp;&gt;&nbsp;急救卫生&nbsp;&gt;&nbsp;跌打损伤','运动健康,急救卫生,跌打损伤',721,0),(640,662,670,722,'运动健康&nbsp;&gt;&nbsp;急救卫生&nbsp;&gt;&nbsp;烫伤止痒','运动健康,急救卫生,烫伤止痒',722,0),(641,662,670,723,'运动健康&nbsp;&gt;&nbsp;急救卫生&nbsp;&gt;&nbsp;防裂抗冻','运动健康,急救卫生,防裂抗冻',723,0),(642,662,670,724,'运动健康&nbsp;&gt;&nbsp;急救卫生&nbsp;&gt;&nbsp;口腔咽部','运动健康,急救卫生,口腔咽部',724,0),(643,662,670,725,'运动健康&nbsp;&gt;&nbsp;急救卫生&nbsp;&gt;&nbsp;眼部保健','运动健康,急救卫生,眼部保健',725,0),(644,662,670,726,'运动健康&nbsp;&gt;&nbsp;急救卫生&nbsp;&gt;&nbsp;鼻炎健康','运动健康,急救卫生,鼻炎健康',726,0),(645,662,670,727,'运动健康&nbsp;&gt;&nbsp;急救卫生&nbsp;&gt;&nbsp;风湿骨痛','运动健康,急救卫生,风湿骨痛',727,0),(646,662,670,728,'运动健康&nbsp;&gt;&nbsp;急救卫生&nbsp;&gt;&nbsp;生殖泌尿','运动健康,急救卫生,生殖泌尿',728,0),(647,662,670,729,'运动健康&nbsp;&gt;&nbsp;急救卫生&nbsp;&gt;&nbsp;美体塑身','运动健康,急救卫生,美体塑身',729,0),(735,730,1054,1055,'汽车用品&nbsp;&gt;&nbsp;整车&nbsp;&gt;&nbsp;新车','汽车用品,整车,新车',1055,0),(736,730,1054,1056,'汽车用品&nbsp;&gt;&nbsp;整车&nbsp;&gt;&nbsp;二手车','汽车用品,整车,二手车',1056,0),(783,825,837,884,'玩具乐器&nbsp;&gt;&nbsp;乐器相关&nbsp;&gt;&nbsp;西洋打击乐器','玩具乐器,乐器相关,西洋打击乐器',884,0),(784,825,837,885,'玩具乐器&nbsp;&gt;&nbsp;乐器相关&nbsp;&gt;&nbsp;各式乐器配件','玩具乐器,乐器相关,各式乐器配件',885,0),(785,825,837,886,'玩具乐器&nbsp;&gt;&nbsp;乐器相关&nbsp;&gt;&nbsp;电脑音乐','玩具乐器,乐器相关,电脑音乐',886,0),(786,825,837,887,'玩具乐器&nbsp;&gt;&nbsp;乐器相关&nbsp;&gt;&nbsp;工艺礼品乐器','玩具乐器,乐器相关,工艺礼品乐器',887,0),(793,888,889,901,'厨具&nbsp;&gt;&nbsp;烹饪锅具&nbsp;&gt;&nbsp;套锅','厨具,烹饪锅具,套锅',901,0),(794,888,889,902,'厨具&nbsp;&gt;&nbsp;烹饪锅具&nbsp;&gt;&nbsp;煲类','厨具,烹饪锅具,煲类',902,0),(795,888,889,903,'厨具&nbsp;&gt;&nbsp;烹饪锅具&nbsp;&gt;&nbsp;水壶','厨具,烹饪锅具,水壶',903,0),(796,888,889,904,'厨具&nbsp;&gt;&nbsp;烹饪锅具&nbsp;&gt;&nbsp;厨用杂件','厨具,烹饪锅具,厨用杂件',904,0),(885,959,967,1026,'母婴用品&nbsp;&gt;&nbsp;妈妈专区&nbsp;&gt;&nbsp;包/背婴带','母婴用品,妈妈专区,包/背婴带',1026,0),(886,959,967,1027,'母婴用品&nbsp;&gt;&nbsp;妈妈专区&nbsp;&gt;&nbsp;妈妈护理','母婴用品,妈妈专区,妈妈护理',1027,0),(887,959,967,1028,'母婴用品&nbsp;&gt;&nbsp;妈妈专区&nbsp;&gt;&nbsp;产后塑身','母婴用品,妈妈专区,产后塑身',1028,0),(888,959,967,1029,'母婴用品&nbsp;&gt;&nbsp;妈妈专区&nbsp;&gt;&nbsp;孕妇内衣','母婴用品,妈妈专区,孕妇内衣',1029,0),(889,959,967,1030,'母婴用品&nbsp;&gt;&nbsp;妈妈专区&nbsp;&gt;&nbsp;防辐射服','母婴用品,妈妈专区,防辐射服',1030,0),(896,1037,1043,1047,'虚拟充值&nbsp;&gt;&nbsp;票务&nbsp;&gt;&nbsp;电影票','虚拟充值,票务,电影票',1047,0),(897,1037,1043,1048,'虚拟充值&nbsp;&gt;&nbsp;票务&nbsp;&gt;&nbsp;演唱会','虚拟充值,票务,演唱会',1048,0),(898,1037,1043,1049,'虚拟充值&nbsp;&gt;&nbsp;票务&nbsp;&gt;&nbsp;话剧/歌剧/音乐剧','虚拟充值,票务,话剧/歌剧/音乐剧',1049,0),(899,1037,1043,1050,'虚拟充值&nbsp;&gt;&nbsp;票务&nbsp;&gt;&nbsp;体育赛事','虚拟充值,票务,体育赛事',1050,0),(900,1037,1043,1051,'虚拟充值&nbsp;&gt;&nbsp;票务&nbsp;&gt;&nbsp;舞蹈芭蕾','虚拟充值,票务,舞蹈芭蕾',1051,0),(901,1037,1043,1052,'虚拟充值&nbsp;&gt;&nbsp;票务&nbsp;&gt;&nbsp;戏曲综艺','虚拟充值,票务,戏曲综艺',1052,0);

/*Table structure for table `feiwa_goods_common` */

DROP TABLE IF EXISTS `feiwa_goods_common`;

CREATE TABLE `feiwa_goods_common` (
  `goods_commonid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品公共表id',
  `goods_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_jingle` varchar(150) DEFAULT '' COMMENT '商品广告词',
  `gc_id` int(10) unsigned NOT NULL COMMENT '商品分类',
  `gc_id_1` int(10) unsigned NOT NULL COMMENT '一级分类id',
  `gc_id_2` int(10) unsigned NOT NULL COMMENT '二级分类id',
  `gc_id_3` int(10) unsigned NOT NULL COMMENT '三级分类id',
  `gc_name` varchar(200) NOT NULL DEFAULT '' COMMENT '商品分类',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺id',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `spec_name` varchar(255) NOT NULL DEFAULT '' COMMENT '规格名称',
  `spec_value` text NOT NULL COMMENT '规格值',
  `brand_id` int(10) unsigned DEFAULT '0' COMMENT '品牌id',
  `brand_name` varchar(100) DEFAULT '' COMMENT '品牌名称',
  `type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '类型id',
  `goods_image` varchar(100) NOT NULL DEFAULT '' COMMENT '商品主图',
  `goods_attr` text NOT NULL COMMENT '商品属性',
  `goods_custom` text NOT NULL COMMENT '商品自定义属性',
  `goods_body` text NOT NULL COMMENT '商品内容',
  `mobile_body` text NOT NULL COMMENT '手机端商品描述',
  `goods_state` tinyint(3) unsigned NOT NULL COMMENT '商品状态 0下架，1正常，10违规（禁售）',
  `goods_stateremark` varchar(255) DEFAULT NULL COMMENT '违规原因',
  `goods_verify` tinyint(3) unsigned NOT NULL COMMENT '商品审核 1通过，0未通过，10审核中',
  `goods_verifyremark` varchar(255) DEFAULT NULL COMMENT '审核失败原因',
  `goods_lock` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '商品锁定 0未锁，1已锁',
  `goods_addtime` int(10) unsigned NOT NULL COMMENT '商品添加时间',
  `goods_selltime` int(10) unsigned NOT NULL COMMENT '上架时间',
  `goods_price` decimal(10,2) NOT NULL COMMENT '商品价格',
  `goods_marketprice` decimal(10,2) NOT NULL COMMENT '市场价',
  `goods_costprice` decimal(10,2) NOT NULL COMMENT '成本价',
  `goods_discount` float unsigned NOT NULL COMMENT '折扣',
  `goods_serial` varchar(50) DEFAULT '' COMMENT '商品货号',
  `goods_storage_alarm` tinyint(3) unsigned NOT NULL COMMENT '库存报警值',
  `goods_barcode` varchar(20) DEFAULT '' COMMENT '商品条形码',
  `transport_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '运费模板',
  `transport_title` varchar(60) DEFAULT '' COMMENT '运费模板名称',
  `goods_commend` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '商品推荐 1是，0否，默认为0',
  `goods_freight` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '运费 0为免运费',
  `goods_vat` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否开具增值税发票 1是，0否',
  `areaid_1` int(10) unsigned NOT NULL COMMENT '一级地区id',
  `areaid_2` int(10) unsigned NOT NULL COMMENT '二级地区id',
  `goods_stcids` varchar(255) DEFAULT '' COMMENT '店铺分类id 首尾用,隔开',
  `plateid_top` int(10) unsigned DEFAULT NULL COMMENT '顶部关联板式',
  `plateid_bottom` int(10) unsigned DEFAULT NULL COMMENT '底部关联板式',
  `is_virtual` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为虚拟商品 1是，0否',
  `virtual_indate` int(10) unsigned DEFAULT NULL COMMENT '虚拟商品有效期',
  `virtual_limit` tinyint(3) unsigned DEFAULT NULL COMMENT '虚拟商品购买上限',
  `virtual_invalid_refund` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否允许过期退款， 1是，0否',
  `sup_id` int(11) NOT NULL COMMENT '供应商id',
  `is_own_mall` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为平台自营',
  `is_pf` tinyint(3) unsigned DEFAULT '0' COMMENT '是否为批发模式 1是，0否',
  `is_vip` tinyint(3) unsigned DEFAULT '0' COMMENT '是否为批发模式 1是，0否',
  `pf_num1` int(11) unsigned DEFAULT '0' COMMENT '批发模式阶梯1的数量',
  `pf_num2` int(11) unsigned DEFAULT '0' COMMENT '批发模式阶梯2的数量',
  `pf_num3` int(11) unsigned DEFAULT '0' COMMENT '批发模式阶梯3的数量',
  `pf_price1` decimal(10,2) DEFAULT '0.00' COMMENT '批发阶梯价格1',
  `pf_price2` decimal(10,2) DEFAULT '0.00' COMMENT '批发阶梯价格2',
  `pf_price3` decimal(10,2) DEFAULT '0.00' COMMENT '批发阶梯价格3',
  `pf_poinst1` int(11) unsigned DEFAULT '0' COMMENT '批发模式阶梯1的赠送积分',
  `pf_poinst2` int(11) unsigned DEFAULT '0' COMMENT '批发模式阶梯2的赠送积分',
  `pf_poinst3` int(11) unsigned DEFAULT '0' COMMENT '批发模式阶梯3的赠送积分',
  `goods_unit` varchar(255) DEFAULT '件' COMMENT '单位字段',
  `pfs` text NOT NULL COMMENT '批发',
  PRIMARY KEY (`goods_commonid`)
) ENGINE=InnoDB AUTO_INCREMENT=100227 DEFAULT CHARSET=utf8 COMMENT='商品公共内容表';

/*Data for the table `feiwa_goods_common` */

insert  into `feiwa_goods_common`(`goods_commonid`,`goods_name`,`goods_jingle`,`gc_id`,`gc_id_1`,`gc_id_2`,`gc_id_3`,`gc_name`,`store_id`,`store_name`,`spec_name`,`spec_value`,`brand_id`,`brand_name`,`type_id`,`goods_image`,`goods_attr`,`goods_custom`,`goods_body`,`mobile_body`,`goods_state`,`goods_stateremark`,`goods_verify`,`goods_verifyremark`,`goods_lock`,`goods_addtime`,`goods_selltime`,`goods_price`,`goods_marketprice`,`goods_costprice`,`goods_discount`,`goods_serial`,`goods_storage_alarm`,`goods_barcode`,`transport_id`,`transport_title`,`goods_commend`,`goods_freight`,`goods_vat`,`areaid_1`,`areaid_2`,`goods_stcids`,`plateid_top`,`plateid_bottom`,`is_virtual`,`virtual_indate`,`virtual_limit`,`virtual_invalid_refund`,`sup_id`,`is_own_mall`,`is_pf`,`is_vip`,`pf_num1`,`pf_num2`,`pf_num3`,`pf_price1`,`pf_price2`,`pf_price3`,`pf_poinst1`,`pf_poinst2`,`pf_poinst3`,`goods_unit`,`pfs`) values (100153,'华为 HUAWEI Mate 10 4GB+64GB','',1035,256,1034,1035,'数码办公 &gt;手机通讯 &gt;手机',7,'feng店铺名称','N;','N;',184,'华硕',0,'7_05641584812484484.jpg','N;','N;','<ul id=\"parameter-brand\" class=\"p-parameter-list\" style=\"color:#666666;font-family:tahoma, arial, &quot;background-color:#FFFFFF;\">\r\n	<li>\r\n		品牌：&nbsp;<a href=\"https://list.jd.com/list.html?cat=9987,653,655&amp;ev=exbrand_8557\" target=\"_blank\">华为（HUAWEI）</a>\r\n	</li>\r\n</ul>\r\n<ul class=\"parameter2 p-parameter-list\" style=\"color:#666666;font-family:tahoma, arial, &quot;background-color:#FFFFFF;\">\r\n	<li>\r\n		商品名称：华为Mate 10\r\n	</li>\r\n	<li>\r\n		商品编号：5284273\r\n	</li>\r\n	<li>\r\n		商品毛重：0.58kg\r\n	</li>\r\n	<li>\r\n		商品产地：中国大陆\r\n	</li>\r\n	<li>\r\n		系统：安卓（Android）\r\n	</li>\r\n	<li>\r\n		运行内存：4GB\r\n	</li>\r\n	<li>\r\n		前置摄像头像素：800万-1599万\r\n	</li>\r\n	<li>\r\n		后置摄像头像素：2000万及以上，1200万-1999万\r\n	</li>\r\n	<li>\r\n		电池容量：4000mAh-5999mAh\r\n	</li>\r\n	<li>\r\n		机身内存：64GB\r\n	</li>\r\n	<li>\r\n		热点：全面屏，双卡双待，指纹识别\r\n	</li>\r\n</ul>','',1,NULL,1,NULL,0,1510814548,0,'3999.00','3999.00','3999.00',100,'',111,'',0,'',1,'0.00',0,1,36,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100162,'二手汽车','',1056,730,1054,1056,'汽车用品 &gt;整车 &gt;二手车',9,'杭州服务中心','N;','N;',223,'欧姆龙',0,'9_05670473063184516.jpg','N;','N;','1231212312','',1,NULL,1,NULL,0,1513703351,0,'400000.00','500000.00','0.00',80,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100163,'asdsad','',1035,256,1034,1035,'数码办公 &gt;手机通讯 &gt;手机',8,'adminy','N;','N;',0,'',0,'8_05671682277834917.jpg','N;','N;','','',1,NULL,1,NULL,0,1513824233,0,'100.00','120.00','0.00',83,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100164,'小米note','是肯定会发生地方',1035,256,1034,1035,'数码办公 &gt;手机通讯 &gt;手机',8,'adminy','N;','N;',83,'秀秀美',0,'8_05675387995058942.jpg','N;','N;','好几个房间很干净看就看','',1,NULL,1,NULL,0,1514195067,0,'2090.00','2900.00','0.00',72,'',0,'',0,'',1,'20.00',1,9,39,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100165,'2017冬季加绒女靴新款真皮女鞋尖头高跟短靴裸色细跟裸靴及踝靴女','',1035,0,0,0,'',8,'adminy','','',0,'',0,'','','','<img class=\"desc_anchor\" id=\"desc-module-1\" src=\"//assets.alicdn.com/kissy/1.0.0/build/imglazyload/spaceball.gif\"><p style=\"text-align:center;\">货号：G1108</p> <p style=\"text-align:center;\">此款鞋子裸色的偏灰一些，因为拍摄灯光的原因呈现出裸粉色，亲亲，已收到的实物为准哦！<img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i3/583672804/TB2o641c.dnpuFjSZPhXXbChpXa_!!583672804.jpg\" size=\"790x980\" /></p> <p style=\"text-align:center;\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i2/583672804/TB2VxTHcEgQMeJjy0FeXXXOEVXa_!!583672804.jpg\" size=\"790x870\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i4/583672804/TB2D8hwg22H8KJjy0FcXXaDlFXa_!!583672804.jpg\" size=\"790x744\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i3/583672804/TB2QCxXanJ_SKJjSZPiXXb3LpXa_!!583672804.png\" size=\"790x739\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i4/583672804/TB2r5V1eC3PL1JjSZPcXXcQgpXa_!!583672804.jpg\" size=\"790x756\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i2/583672804/TB2nVrLcwMPMeJjy1XbXXcwxVXa_!!583672804.jpg\" size=\"790x900\" /></p><img class=\"desc_anchor\" id=\"desc-module-2\" src=\"//assets.alicdn.com/kissy/1.0.0/build/imglazyload/spaceball.gif\"><p><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i4/583672804/TB2mP0Vbgb.PuJjSZFpXXbuFpXa_!!583672804.jpg\" size=\"790x930\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i1/583672804/TB2yk_rayoaPuJjSsplXXbg7XXa_!!583672804.jpg\" size=\"790x990\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i4/583672804/TB2zcAnX0qUQKJjSZFIXXcOkFXa_!!583672804.jpg\" size=\"790x924\" /></p><img class=\"desc_anchor\" id=\"desc-module-3\" src=\"//assets.alicdn.com/kissy/1.0.0/build/imglazyload/spaceball.gif\"><p><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i1/583672804/TB2Gzx4d.FWMKJjSZFvXXaenFXa_!!583672804.jpg\" size=\"790x1044\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i4/583672804/TB2rUiIeuEJL1JjSZFGXXa6OXXa_!!583672804.jpg\" size=\"790x1014\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i2/583672804/TB2Dr1WezoIL1JjSZFyXXbFBpXa_!!583672804.jpg\" size=\"790x816\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i4/583672804/TB2VBWCeC3PL1JjSZFxXXcBBVXa_!!583672804.jpg\" size=\"790x1002\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i4/583672804/TB2lyeFeEEIL1JjSZFFXXc5kVXa_!!583672804.jpg\" size=\"790x642\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i1/583672804/TB2kJjDcBUSMeJjSszeXXcKgpXa_!!583672804.jpg\" size=\"790x828\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i4/583672804/TB2qYMlal0kpuFjSsziXXa.oVXa_!!583672804.jpg\" size=\"790x1239\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i4/583672804/TB2zmPLaEhnpuFjSZFEXXX0PFXa_!!583672804.jpg\" size=\"790x1196\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i1/583672804/TB2rqfGatBopuFjSZPcXXc9EpXa_!!583672804.jpg\" size=\"790x1196\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i1/583672804/TB2Zywlal0kpuFjy1zdXXXuUVXa_!!583672804.jpg\" size=\"790x1247\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i3/583672804/TB2uGDLaEhnpuFjSZFpXXcpuXXa_!!583672804.jpg\" size=\"790x1189\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i4/583672804/TB2Frwnal8lpuFjy0FnXXcZyXXa_!!583672804.jpg\" size=\"790x1201\" /></p><img class=\"desc_anchor\" id=\"desc-module-4\" src=\"//assets.alicdn.com/kissy/1.0.0/build/imglazyload/spaceball.gif\"><p><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i4/583672804/TB2xLHGcrsTMeJjy1zcXXXAgXXa_!!583672804.jpg\" size=\"790x810\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i2/583672804/TB2uWwxcotWMKJjy0FaXXcCDpXa_!!583672804.jpg\" size=\"790x906\" /></p><img class=\"desc_anchor\" id=\"desc-module-5\" src=\"//assets.alicdn.com/kissy/1.0.0/build/imglazyload/spaceball.gif\"><p><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i2/583672804/TB233fKcwoQMeJjy1XaXXcSsFXa_!!583672804.jpg\" size=\"790x1194\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i3/583672804/TB2OobPcwMPMeJjy1XcXXXpppXa_!!583672804.jpg\" size=\"790x714\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i4/583672804/TB2AMnKcwoQMeJjy1XaXXcSsFXa_!!583672804.jpg\" size=\"790x594\"><img align=\"absmiddle\" src=\"//img.alicdn.com/imgextra/i2/583672804/TB24EfPcwMPMeJjy1XcXXXpppXa_!!583672804.jpg\" size=\"790x648\" /></p>','',1,NULL,1,NULL,0,1514367356,0,'229.00','458.00','0.00',0,'Y16G1108',0,'',0,'',1,'0.00',0,0,0,'',NULL,NULL,0,NULL,NULL,1,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,'件',''),(100166,'测试添加商品','',1035,256,1034,1035,'数码办公 &gt;手机通讯 &gt;手机',8,'adminy','N;','N;',0,'',0,'8_05690878192014201.jpg','N;','N;','11是的第三方','a:1:{i:0;a:2:{s:4:\"type\";s:4:\"text\";s:5:\"value\";s:6:\"112121\";}}',1,NULL,1,NULL,0,1516254485,0,'1980.00','2800.00','1200.00',70,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100167,'123','',12,1,4,12,'服饰鞋帽 &gt;女装 &gt;T恤',11,'测试','N;','N;',0,'',0,'11_05690970455241560.jpg','N;','N;','','',10,'商品分类被删除，需要重新选择分类',1,NULL,0,1515753090,0,'50.00','50.00','0.00',100,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100168,'充值卡','',1057,1057,0,0,'虚拟产品',8,'adminy','N;','N;',0,'',0,'8_05704559485578983.png','N;','N;','','',10,'商品分类被删除，需要重新选择分类',1,NULL,0,1517112005,0,'100.00','100.00','0.00',100,'',0,'',0,'',1,'0.00',0,1,0,'',0,0,0,0,0,0,1,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100169,'1111','',1035,256,1034,1035,'数码办公 &gt;手机通讯 &gt;手机',8,'adminy','N;','N;',0,'',0,'8_05704559485578983.png','N;','N;','','',1,NULL,1,NULL,0,1522753565,0,'1.00','1.00','0.00',100,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100170,'男士衬衫','2018新款男士衬衫',1057,1057,0,0,'虚拟产品',8,'adminy','N;','N;',221,'博朗',0,'8_05760962657313319.jpg','N;','N;','电脑端商品描述','a:1:{i:0;a:2:{s:4:\"type\";s:4:\"text\";s:5:\"value\";s:21:\"电脑端商品描述\";}}',10,'商品分类被删除，需要重新选择分类',1,NULL,0,1522752383,0,'100.00','300.00','25.00',33,'',10,'',0,'',1,'10.00',0,9,39,',8,',0,0,0,0,0,0,1,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:2:\"10\";s:2:\"f1\";s:2:\"50\";s:2:\"q2\";s:2:\"10\";s:2:\"f2\";s:2:\"40\";s:2:\"q3\";s:2:\"10\";s:2:\"f3\";s:2:\"30\";}'),(100171,'dfddfd dfdfdf','dfdfdf',12,1,4,12,'服饰鞋帽 &gt;女装 &gt;T恤',8,'adminy','N;','N;',282,'澳优',0,'8_05784145755325374.jpg','N;','N;','<img src=\"http://865284.ichengyun.net/data/upload/mall/store/goods/8/8_05784146124104191_1280.jpg\" alt=\"image\" /><img src=\"http://865284.ichengyun.net/data/upload/mall/store/goods/8/8_05784146101647698_1280.jpg\" alt=\"image\" /><img src=\"http://865284.ichengyun.net/data/upload/mall/store/goods/8/8_05784146073876340_1280.jpg\" alt=\"image\" /><img src=\"http://865284.ichengyun.net/data/upload/mall/store/goods/8/8_05784145755325374_1280.jpg\" alt=\"image\" /><img src=\"http://865284.ichengyun.net/data/upload/mall/store/goods/8/8_05784145611803975_1280.jpg\" alt=\"image\" />','',10,'商品分类被删除，需要重新选择分类',1,NULL,0,1525070658,0,'38.00','48.00','22.00',79,'3434343344',2,'3432343434',0,'',1,'0.00',0,19,291,',9,',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:2:\"23\";s:2:\"f1\";s:2:\"28\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100172,'美素力（frisolac）金装婴儿配方奶粉 1段（0-6个月婴儿适用）','',478,470,471,478,'奶粉 &gt;按段数 &gt;1段',6,'商城','N;','N;',0,'',1,'6_05790954343413037.jpg','N;','N;','','',1,NULL,1,NULL,0,1525751478,0,'400.00','420.00','0.00',95,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100173,'美素佳儿（Friso Prestige) 皇家较大婴儿配方奶粉 2段 （6-12个月婴幼儿适用）','美素佳儿（Friso Prestige) 皇家较大婴儿配方奶粉 2段 （6-12个月婴幼儿适用）',479,470,471,479,'奶粉 &gt;按段数 &gt;2段',6,'商城','N;','N;',0,'',1,'6_05790955563332956.jpg','N;','N;','','',1,NULL,1,NULL,0,1525751561,0,'380.00','400.00','0.00',95,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100174,'爱他美卓萃幼儿配方奶粉（12—36月龄，3段）900g','爱他美卓萃幼儿配方奶粉（12—36月龄，3段）900g',486,470,471,486,'奶粉 &gt;按段数 &gt;3段',6,'商城','N;','N;',0,'',1,'6_05790956423059031.jpg','N;','N;','','',1,NULL,1,NULL,0,1525751645,0,'400.00','420.00','0.00',95,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100175,'爱他美卓萃儿童配方调制乳粉（36—72月龄，4段）','爱他美卓萃儿童配方调制乳粉（36—72月龄，4段）',478,470,471,478,'奶粉 &gt;按段数 &gt;1段',6,'商城','N;','N;',0,'',1,'6_05790956949555934.jpg','N;','N;','','',1,NULL,1,NULL,0,1525751698,0,'400.00','450.00','0.00',88,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100176,'安满（Anmum）智孕宝 孕妇配方奶粉800克（新西兰原装进口）','安满（Anmum）智孕宝 孕妇配方奶粉800克（新西兰原装进口）',478,470,471,478,'奶粉 &gt;按段数 &gt;1段',6,'商城','N;','N;',0,'',1,'6_05790958149971269.jpg','N;','N;','','',1,NULL,1,NULL,0,1525751839,0,'188.00','200.00','188.00',94,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100177,'雅培(Abbott)亲护较大婴儿配方奶粉 2段820克','雅培(Abbott)亲护较大婴儿配方奶粉 2段820克',478,470,471,478,'奶粉 &gt;按段数 &gt;1段',6,'商城','N;','N;',0,'',1,'6_05790959077707398.jpg','N;','N;','','',1,NULL,1,NULL,0,1525751912,0,'222.00','240.00','0.00',92,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100178,'惠氏启赋（Wyeth illuma）3段奶粉','惠氏启赋（Wyeth illuma）3段奶粉',486,470,471,486,'奶粉 &gt;按段数 &gt;3段',6,'商城','N;','N;',0,'',1,'6_05790959867376758.jpg','N;','N;','','',1,NULL,1,NULL,0,1525751990,0,'300.00','320.00','0.00',93,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100179,'嘉宝(Gerber ) 婴幼儿米粉 宝宝辅食 原味营养米粉一段','嘉宝(Gerber ) 婴幼儿米粉 宝宝辅食 原味营养米粉一段',478,470,471,478,'奶粉 &gt;按段数 &gt;1段',6,'商城','N;','N;',0,'',1,'6_05790960461426775.jpg','N;','N;','','',1,NULL,1,NULL,0,1525752049,0,'48.00','55.00','0.00',87,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100180,'亨氏 (Heinz) 宝宝辅食 婴儿面条 金装粒粒面－猪肝枸杞 320g','亨氏 (Heinz) 宝宝辅食 婴儿面条 金装粒粒面－猪肝枸杞 320g',479,470,471,479,'奶粉 &gt;按段数 &gt;2段',6,'商城','N;','N;',0,'',1,'6_05790961092598660.jpg','N;','N;','','',1,NULL,1,NULL,0,1525752112,0,'39.00','42.00','0.00',92,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100182,'亨氏 (Heinz) 宝宝零食 婴儿肉泥 安心肉泥套餐—优惠套装E','亨氏 (Heinz) 宝宝零食 婴儿肉泥 安心肉泥套餐—优惠套装E',478,470,471,478,'奶粉 &gt;按段数 &gt;1段',6,'商城','N;','N;',0,'',1,'6_05791013859287600.jpg','N;','N;','','',1,NULL,1,NULL,0,1525757388,0,'300.00','340.00','0.00',88,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100183,'合生元（BIOSTIME）儿童益生菌冲剂(益生元)26袋装','合生元（BIOSTIME）儿童益生菌冲剂(益生元)26袋装',478,470,471,478,'奶粉 &gt;按段数 &gt;1段',6,'商城','N;','N;',0,'',1,'6_05791014397640936.jpg','N;','N;','','',1,NULL,1,NULL,0,1525757442,0,'161.00','180.00','0.00',89,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100184,'拉杜蓝乔（latourangelle）核桃油（婴幼儿）','拉杜蓝乔（latourangelle）核桃油（婴幼儿）',478,470,471,478,'奶粉 &gt;按段数 &gt;1段',6,'商城','N;','N;',0,'',1,'6_05791014867519451.jpg','N;','N;','','',1,NULL,1,NULL,0,1525757489,0,'168.00','175.00','0.00',96,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100185,'美国童年时光CHILDLIFE钙镁锌婴儿幼儿童补钙宝宝补锌液体钙 6个月以上','美国童年时光CHILDLIFE钙镁锌婴儿幼儿童补钙宝宝补锌液体钙 6个月以上',478,470,471,478,'奶粉 &gt;按段数 &gt;1段',6,'商城','N;','N;',0,'',1,'6_05791015324909804.jpg','N;','N;','','',1,NULL,1,NULL,0,1525757535,0,'168.00','178.00','0.00',94,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100186,'方广 儿童零食 肉松 钙铁锌猪肉酥肉粉松 100g','方广 儿童零食 肉松 钙铁锌猪肉酥肉粉松 100g',478,470,471,478,'奶粉 &gt;按段数 &gt;1段',6,'商城','N;','N;',0,'',1,'6_05791015808970258.jpg','N;','N;','','',1,NULL,1,NULL,0,1525757583,0,'33.00','36.00','0.00',91,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100187,'衍生小儿七星茶固体饮料（经典装）','衍生小儿七星茶固体饮料（经典装）',478,470,471,478,'奶粉 &gt;按段数 &gt;1段',6,'商城','N;','N;',0,'',1,'6_05791016254193023.jpg','N;','N;','','',1,NULL,1,NULL,0,1525757627,0,'75.00','80.00','0.00',93,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100188,'花王（Merries）纸尿裤 L54片 大号尿不湿（9-14kg）','花王（Merries）纸尿裤 L54片 大号尿不湿（9-14kg）',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791016835295791.jpg','N;','N;','','',1,NULL,1,NULL,0,1525757686,0,'99.00','120.00','0.00',82,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100189,'花王（Merries）纸尿裤 M64片 中号尿不湿（6-11kg）','花王（Merries）纸尿裤 M64片 中号尿不湿（6-11kg）',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791017279899925.jpg','N;','N;','','',1,NULL,1,NULL,0,1525757730,0,'95.00','100.00','0.00',95,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100190,'王（Merries）纸尿裤 XL44片 加大号尿不湿（12-20kg）','王（Merries）纸尿裤 XL44片 加大号尿不湿（12-20kg）',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791017752734288.jpg','N;','N;','','',1,NULL,1,NULL,0,1525757780,0,'119.00','125.00','0.00',95,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100191,'花王（Merries）纸尿裤 S82片 小号尿不湿（4-8kg）','花王（Merries）纸尿裤 S82片 小号尿不湿（4-8kg）',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791018360977876.jpg','N;','N;','','',1,NULL,1,NULL,0,1525757838,0,'95.00','100.00','0.00',95,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100192,'花王（Merries）拉拉裤 XL38片 加大号学步裤（12-17kg）','花王（Merries）拉拉裤 XL38片 加大号学步裤（12-17kg）',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791018889975263.jpg','N;','N;','','',1,NULL,1,NULL,0,1525757892,0,'105.00','120.00','0.00',87,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100193,'可靠 吸收宝 成人纸尿裤 老年人产妇尿裤M-L号10片*8包','可靠 吸收宝 成人纸尿裤 老年人产妇尿裤M-L号10片*8包',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791019367334995.jpg','N;','N;','','',1,NULL,1,NULL,0,1525757939,0,'130.00','150.00','0.00',86,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100194,'五羊（FIVERAMS）婴儿护肤柔湿巾80片×3包宝宝湿纸巾带盖抽纸湿巾','五羊（FIVERAMS）婴儿护肤柔湿巾80片×3包宝宝湿纸巾带盖抽纸湿巾',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791019767315044.jpg','N;','N;','','',1,NULL,1,NULL,0,1525757984,0,'19.00','21.00','0.00',90,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100195,'贝亲（Pigeon）宽口径玻璃奶瓶 160ml AA72','贝亲（Pigeon）宽口径玻璃奶瓶 160ml AA72',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791020286171638.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758031,0,'93.00','100.00','0.00',93,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100196,'飞利浦新安怡 英国进口 AVENT 时尚安抚奶嘴6-18个月','飞利浦新安怡 英国进口 AVENT 时尚安抚奶嘴6-18个月',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791020695050816.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758072,0,'56.00','60.00','0.00',93,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100197,'小白熊 便携奶粉储存盒 婴儿独立可拆奶粉格','小白熊 便携奶粉储存盒 婴儿独立可拆奶粉格',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791021083025823.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758110,0,'13.90','15.00','0.00',92,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100198,'贝亲（Pigeon）独立开口三层奶粉盒 CA07','贝亲（Pigeon）独立开口三层奶粉盒 CA07',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791021557730356.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758158,0,'54.60','62.00','0.00',88,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100199,'象宝宝（elepbaby）宝宝吃饭罩衣 婴儿围兜','象宝宝（elepbaby）宝宝吃饭罩衣 婴儿围兜',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791021959746394.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758198,0,'29.00','32.00','0.00',90,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100200,'飞利浦 新安怡（AVENT）七安士卡通吸管杯','飞利浦 新安怡（AVENT）七安士卡通吸管杯',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791022372517357.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758240,0,'59.00','65.00','0.00',90,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100201,'小白熊 (Snow Bear) 婴儿奶瓶蒸汽消毒器带烘干','小白熊 (Snow Bear) 婴儿奶瓶蒸汽消毒器带烘干',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791022845352222.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758287,0,'269.00','288.00','0.00',93,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100202,'小白熊 （Snow Bear）婴儿辅食机','小白熊 （Snow Bear）婴儿辅食机',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791023313047855.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758334,0,'299.00','310.00','0.00',96,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100203,'新贝 电动吸奶器','新贝 电动吸奶器',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791023787756095.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758381,0,'225.00','230.00','0.00',97,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100204,'强生(Johnson) 婴儿牛奶沐浴露1000ml','强生(Johnson) 婴儿牛奶沐浴露1000ml',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791024153887525.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758425,0,'57.00','62.00','0.00',91,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100205,'日康婴儿浴盆 洗澡盆 大号带躺板','日康婴儿浴盆 洗澡盆 大号带躺板',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791024667273344.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758469,0,'96.00','100.00','0.00',96,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100206,'贝亲（Pigeon）婴儿多效洗衣液','贝亲（Pigeon）婴儿多效洗衣液',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791025042772560.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758506,0,'41.00','45.00','0.00',91,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100207,'世纪宝贝babyhood 淘气鸭儿童坐便器','世纪宝贝babyhood 淘气鸭儿童坐便器',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791025690171066.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758571,0,'68.00','72.00','0.00',94,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100208,'贝亲（Pigeon）婴儿护臀膏 35g IA149','贝亲（Pigeon）婴儿护臀膏 35g IA149',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791026144289680.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758617,0,'29.00','32.00','0.00',90,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100209,'好孩子橄榄滋养婴儿卫生湿巾80片','好孩子橄榄滋养婴儿卫生湿巾80片',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791026636468776.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758666,0,'57.00','60.00','0.00',95,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100210,'易简（yijian)婴儿童理发器 宝宝剃头器','易简（yijian)婴儿童理发器 宝宝剃头器',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791027257195652.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758727,0,'99.00','129.00','0.00',76,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100211,'贝亲（Pigeon）婴儿训练牙刷三阶段-绿色+黄色','贝亲（Pigeon）婴儿训练牙刷三阶段-绿色+黄色',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791027630963566.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758766,0,'39.00','40.00','0.00',97,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100212,'润本（RUNBEN）电热蚊香液套装','润本（RUNBEN）电热蚊香液套装',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791028034696755.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758806,0,'48.00','54.00','0.00',88,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100213,'好孩子多功能婴儿推车A513-B-L148 蓝色','好孩子多功能婴儿推车A513-B-L148 蓝色',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791028521571841.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758854,0,'479.00','500.00','0.00',95,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100214,'宝宝汽车儿童安全座椅isofix接口','宝宝汽车儿童安全座椅isofix接口',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791029019677006.jpg','N;','N;','','',1,NULL,1,NULL,0,1525758904,0,'2880.00','3000.00','0.00',96,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100215,'婧麒 JOYNCLEON 防辐射服吊带','婧麒 JOYNCLEON 防辐射服吊带',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791069315571320.jpg','N;','N;','','',1,NULL,1,NULL,0,1525762934,0,'458.00','500.00','0.00',91,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100216,'婧麒孕妇防辐射服孕妇装银纤维吊带四季款','婧麒孕妇防辐射服孕妇装银纤维吊带四季款',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791071572119235.jpg','N;','N;','','',1,NULL,1,NULL,0,1525763160,0,'418.00','428.00','0.00',97,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100217,'婧麒（JOYNCLEON） 防辐射服春夏季吊带银纤维马甲孕妇','婧麒（JOYNCLEON） 防辐射服春夏季吊带银纤维马甲孕妇',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791071936832202.jpg','N;','N;','','',1,NULL,1,NULL,0,1525763196,0,'428.00','438.00','0.00',97,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100218,'孩子多功能环保实木摇篮婴儿床','孩子多功能环保实木摇篮婴儿床',314,308,309,314,'童车童床 &gt;婴儿推车 &gt;婴儿推车',6,'商城','N;','N;',0,'',0,'6_05791072669576301.jpg','N;','N;','','',1,NULL,1,NULL,0,1525763269,0,'638.00','658.00','0.00',96,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100219,'婴儿脚包学步脚包新生儿四季护脚鞋','婴儿脚包学步脚包新生儿四季护脚鞋',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791073806963100.jpg','N;','N;','','',1,NULL,1,NULL,0,1525763388,0,'29.00','32.00','0.00',90,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100220,'小红豆女童吊带背心棉夏季薄款','小红豆女童吊带背心棉夏季薄款',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791074892100454.jpg','N;','N;','','',1,NULL,1,NULL,0,1525763491,0,'25.00','28.00','0.00',89,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100221,'儿童内裤纯棉平角男女童内裤4条装','儿童内裤纯棉平角男女童内裤4条装',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791075928721239.jpg','N;','N;','','',1,NULL,1,NULL,0,1525763595,0,'46.00','58.00','0.00',79,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100222,'男短袜春夏季防脱运动船袜男士纯棉','男短袜春夏季防脱运动船袜男士纯棉',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791076612318931.jpg','N;','N;','','',1,NULL,1,NULL,0,1525763663,0,'29.00','32.00','0.00',90,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100223,'夏季男女童防晒透气轻薄连帽儿童皮肤衣','',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791093527085243.jpg','N;','N;','','',1,NULL,1,NULL,0,1525765355,0,'99.00','100.00','0.00',99,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100224,'毛毛虫儿童运动鞋 海浪蓝','毛毛虫儿童运动鞋 海浪蓝',1035,256,1034,1035,'洗护用品 &gt;护理类 &gt;宝宝护肤',6,'商城','N;','N;',0,'',0,'6_05791094837636994.jpg','N;','N;','','',1,NULL,1,NULL,0,1525765486,0,'129.00','136.00','0.00',94,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100225,'贝因美（Beingmate）冠军宝贝 幼儿配方奶粉','',478,470,471,478,'奶粉 &gt;按段数 &gt;1段',6,'商城','N;','N;',366,'贝因美（Beingmate）',3,'6_05804049290836782.jpg','a:3:{i:3;a:2:{s:4:\"name\";s:6:\"分类\";i:3;s:9:\"牛奶粉\";}i:4;a:2:{s:4:\"name\";s:13:\"国产/进口\";i:7;s:6:\"国产\";}i:5;a:2:{s:4:\"name\";s:6:\"包装\";i:13;s:6:\"瓶装\";}}','N;','贝因美（Beingmate）冠军宝贝 幼儿配方奶粉','',1,NULL,1,NULL,0,1527061453,0,'175.00','175.00','175.00',100,'',11,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}'),(100226,'惠氏（Wyeth）S-26爱儿乐奶粉1段','',478,470,471,478,'奶粉 &gt;按段数 &gt;1段',6,'商城','a:1:{i:2;s:12:\"选择段位\";}','a:1:{i:2;a:3:{i:1;s:12:\"400克罐装\";i:2;s:12:\"900克罐装\";i:3;s:13:\"1200克盒装\";}}',365,'惠氏（Wyeth）',3,'6_05804051868241314.jpg','a:3:{i:3;a:2:{s:4:\"name\";s:6:\"分类\";i:3;s:9:\"牛奶粉\";}i:4;a:2:{s:4:\"name\";s:13:\"国产/进口\";i:7;s:6:\"国产\";}i:5;a:2:{s:4:\"name\";s:6:\"包装\";i:13;s:6:\"瓶装\";}}','N;','<span style=\"color:#E4393C;font-family:;\">惠氏（Wyeth）S-26爱儿乐奶粉1段</span>','',1,NULL,1,NULL,0,1527133237,0,'175.00','235.00','235.00',74,'',0,'',0,'',1,'0.00',0,0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,'0.00','0.00','0.00',0,0,0,NULL,'a:6:{s:2:\"q1\";s:0:\"\";s:2:\"f1\";s:0:\"\";s:2:\"q2\";s:0:\"\";s:2:\"f2\";s:0:\"\";s:2:\"q3\";s:0:\"\";s:2:\"f3\";s:0:\"\";}');

/*Table structure for table `feiwa_goods_fcode` */

DROP TABLE IF EXISTS `feiwa_goods_fcode`;

CREATE TABLE `feiwa_goods_fcode` (
  `fc_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'F码id',
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品sku',
  `fc_code` varchar(20) NOT NULL DEFAULT '' COMMENT 'F码',
  `fc_state` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态 0未使用，1已使用',
  PRIMARY KEY (`fc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品F码';

/*Data for the table `feiwa_goods_fcode` */

/*Table structure for table `feiwa_goods_gift` */

DROP TABLE IF EXISTS `feiwa_goods_gift`;

CREATE TABLE `feiwa_goods_gift` (
  `gift_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠品id ',
  `goods_id` int(10) unsigned NOT NULL COMMENT '主商品id',
  `goods_commonid` int(10) unsigned NOT NULL COMMENT '主商品公共id',
  `gift_goodsid` int(10) unsigned NOT NULL COMMENT '赠品商品id ',
  `gift_goodsname` varchar(50) NOT NULL DEFAULT '' COMMENT '主商品名称',
  `gift_goodsimage` varchar(100) NOT NULL DEFAULT '' COMMENT '主商品图片',
  `gift_amount` tinyint(3) unsigned NOT NULL COMMENT '赠品数量',
  PRIMARY KEY (`gift_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品赠品表';

/*Data for the table `feiwa_goods_gift` */

/*Table structure for table `feiwa_goods_images` */

DROP TABLE IF EXISTS `feiwa_goods_images`;

CREATE TABLE `feiwa_goods_images` (
  `goods_image_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品图片id',
  `goods_commonid` int(10) unsigned NOT NULL COMMENT '商品公共内容id',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺id',
  `color_id` int(10) unsigned NOT NULL COMMENT '颜色规格值id',
  `goods_image` varchar(1000) NOT NULL DEFAULT '' COMMENT '商品图片',
  `goods_image_sort` tinyint(3) unsigned NOT NULL COMMENT '排序',
  `is_default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '默认主题，1是，0否',
  PRIMARY KEY (`goods_image_id`)
) ENGINE=InnoDB AUTO_INCREMENT=639 DEFAULT CHARSET=utf8 COMMENT='商品图片';

/*Data for the table `feiwa_goods_images` */

insert  into `feiwa_goods_images`(`goods_image_id`,`goods_commonid`,`store_id`,`color_id`,`goods_image`,`goods_image_sort`,`is_default`) values (544,100153,7,0,'7_05641584812484484.jpg',0,1),(553,100162,9,0,'9_05670473063184516.jpg',0,1),(554,100163,8,0,'8_05671682277834917.jpg',0,1),(555,100164,8,0,'8_05675387995058942.jpg',0,1),(556,100165,8,0,'',0,1),(557,100165,8,0,'',0,0),(558,100165,8,0,'',0,0),(559,100165,8,0,'',0,0),(560,100165,8,0,'',0,0),(561,100166,8,0,'8_05690878192014201.jpg',0,1),(562,100167,11,0,'11_05690970455241560.jpg',0,1),(563,100167,11,0,'11_05690971118436916.jpg',0,0),(564,100168,8,0,'8_05704559485578983.png',0,1),(565,100169,8,0,'8_05690878192014201.jpg',0,0),(566,100169,8,0,'8_05690878192014201.jpg',0,1),(567,100169,8,0,'8_05675387995058942.jpg',0,0),(568,100169,8,0,'8_05675349300770679.jpg',0,0),(569,100170,8,0,'8_05760962657313319.jpg',0,1),(570,100170,8,0,'8_05760892357437364.jpg',0,0),(571,100170,8,0,'8_05704559485578983.png',0,0),(572,100170,8,0,'8_05690878192014201.jpg',0,0),(573,100170,8,0,'8_05675387995058942.jpg',0,0),(574,100171,8,0,'8_05784145755325374.jpg',0,1),(575,100171,8,0,'8_05784146689444857.jpg',0,0),(584,100172,6,0,'6_05790954343413037.jpg',0,1),(585,100173,6,0,'6_05790955563332956.jpg',0,1),(586,100174,6,0,'6_05790956423059031.jpg',0,1),(587,100175,6,0,'6_05790956949555934.jpg',0,1),(588,100176,6,0,'6_05790958149971269.jpg',0,1),(589,100177,6,0,'6_05790959077707398.jpg',0,1),(590,100178,6,0,'6_05790959867376758.jpg',0,1),(591,100179,6,0,'6_05790960461426775.jpg',0,1),(592,100180,6,0,'6_05790961092598660.jpg',0,1),(594,100182,6,0,'6_05791013859287600.jpg',0,1),(595,100183,6,0,'6_05791014397640936.jpg',0,1),(596,100184,6,0,'6_05791014867519451.jpg',0,1),(597,100185,6,0,'6_05791015324909804.jpg',0,1),(598,100186,6,0,'6_05791015808970258.jpg',0,1),(599,100187,6,0,'6_05791016254193023.jpg',0,1),(600,100188,6,0,'6_05791016835295791.jpg',0,1),(601,100189,6,0,'6_05791017279899925.jpg',0,1),(602,100190,6,0,'6_05791017752734288.jpg',0,1),(603,100191,6,0,'6_05791018360977876.jpg',0,1),(604,100192,6,0,'6_05791018889975263.jpg',0,1),(605,100193,6,0,'6_05791019367334995.jpg',0,1),(606,100194,6,0,'6_05791019767315044.jpg',0,1),(607,100195,6,0,'6_05791020286171638.jpg',0,1),(608,100196,6,0,'6_05791020695050816.jpg',0,1),(609,100197,6,0,'6_05791021083025823.jpg',0,1),(610,100198,6,0,'6_05791021557730356.jpg',0,1),(611,100199,6,0,'6_05791021959746394.jpg',0,1),(612,100200,6,0,'6_05791022372517357.jpg',0,1),(613,100201,6,0,'6_05791022845352222.jpg',0,1),(614,100202,6,0,'6_05791023313047855.jpg',0,1),(615,100203,6,0,'6_05791023787756095.jpg',0,1),(616,100204,6,0,'6_05791024153887525.jpg',0,1),(617,100205,6,0,'6_05791024667273344.jpg',0,1),(618,100207,6,0,'6_05791025690171066.jpg',0,1),(619,100208,6,0,'6_05791026144289680.jpg',0,1),(620,100209,6,0,'6_05791026636468776.jpg',0,1),(621,100210,6,0,'6_05791027257195652.jpg',0,1),(622,100211,6,0,'6_05791027630963566.jpg',0,1),(623,100212,6,0,'6_05791028034696755.jpg',0,1),(624,100213,6,0,'6_05791028521571841.jpg',0,1),(625,100214,6,0,'6_05791029019677006.jpg',0,1),(626,100215,6,0,'6_05791069315571320.jpg',0,1),(627,100216,6,0,'6_05791071572119235.jpg',0,1),(628,100217,6,0,'6_05791071936832202.jpg',0,1),(629,100218,6,0,'6_05791072669576301.jpg',0,1),(630,100219,6,0,'6_05791073806963100.jpg',0,1),(631,100220,6,0,'6_05791074892100454.jpg',0,1),(632,100221,6,0,'6_05791075928721239.jpg',0,1),(633,100222,6,0,'6_05791076612318931.jpg',0,1),(634,100223,6,0,'6_05791093527085243.jpg',0,1),(635,100224,6,0,'6_05791094837636994.jpg',0,1),(636,100225,6,0,'6_05804049290836782.jpg',0,1),(637,100226,6,0,'6_05804051868241314.jpg',0,1),(638,100226,6,0,'6_05804051868241314.jpg',0,0);

/*Table structure for table `feiwa_goods_recommend` */

DROP TABLE IF EXISTS `feiwa_goods_recommend`;

CREATE TABLE `feiwa_goods_recommend` (
  `rec_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rec_gc_id` mediumint(9) DEFAULT NULL COMMENT '最底级商品分类ID',
  `rec_goods_id` int(11) DEFAULT NULL COMMENT '商品goods_id',
  `rec_gc_name` varchar(150) DEFAULT NULL COMMENT '商品分类名称',
  PRIMARY KEY (`rec_id`),
  KEY `rec_gc_id` (`rec_gc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品推荐表';

/*Data for the table `feiwa_goods_recommend` */

/*Table structure for table `feiwa_groupbuy` */

DROP TABLE IF EXISTS `feiwa_groupbuy`;

CREATE TABLE `feiwa_groupbuy` (
  `groupbuy_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '团购ID',
  `groupbuy_name` varchar(255) NOT NULL DEFAULT '' COMMENT '活动名称',
  `start_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `goods_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品ID',
  `goods_commonid` int(10) unsigned NOT NULL COMMENT '商品公共表ID',
  `goods_name` varchar(200) NOT NULL DEFAULT '' COMMENT '商品名称',
  `store_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `goods_price` decimal(10,2) NOT NULL COMMENT '商品原价',
  `groupbuy_price` decimal(10,2) NOT NULL COMMENT '团购价格',
  `groupbuy_rebate` decimal(10,2) NOT NULL COMMENT '折扣',
  `virtual_quantity` int(10) unsigned NOT NULL COMMENT '虚拟购买数量',
  `upper_limit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买上限',
  `buyer_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已购买人数',
  `buy_quantity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买数量',
  `groupbuy_intro` text COMMENT '本团介绍',
  `state` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '团购状态 10-审核中 20-正常 30-审核失败 31-管理员关闭 32-已结束',
  `recommended` tinyint(1) unsigned NOT NULL COMMENT '是否推荐 0.未推荐 1.已推荐',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '查看次数',
  `class_id` int(10) unsigned NOT NULL COMMENT '团购类别编号',
  `s_class_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '团购2级分类id',
  `groupbuy_image` varchar(100) NOT NULL DEFAULT '' COMMENT '团购图片',
  `groupbuy_image1` varchar(100) DEFAULT NULL COMMENT '团购图片1',
  `remark` varchar(255) DEFAULT '' COMMENT '备注',
  `is_vr` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否虚拟团购 1是0否',
  `vr_city_id` int(11) DEFAULT NULL COMMENT '虚拟团购城市id',
  `vr_area_id` int(11) DEFAULT NULL COMMENT '虚拟团购区域id',
  `vr_mall_id` int(11) DEFAULT NULL COMMENT '虚拟团购商区id',
  `vr_class_id` int(11) DEFAULT NULL COMMENT '虚拟团购大分类id',
  `vr_s_class_id` int(11) DEFAULT NULL COMMENT '虚拟团购小分类id',
  PRIMARY KEY (`groupbuy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='团购商品表';

/*Data for the table `feiwa_groupbuy` */

/*Table structure for table `feiwa_groupbuy_class` */

DROP TABLE IF EXISTS `feiwa_groupbuy_class`;

CREATE TABLE `feiwa_groupbuy_class` (
  `class_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '类别编号',
  `class_name` varchar(20) NOT NULL DEFAULT '' COMMENT '类别名称',
  `class_parent_id` int(10) unsigned NOT NULL COMMENT '父类别编号',
  `sort` tinyint(1) unsigned NOT NULL COMMENT '排序',
  `deep` tinyint(1) unsigned DEFAULT '0' COMMENT '深度',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='团购类别表';

/*Data for the table `feiwa_groupbuy_class` */

/*Table structure for table `feiwa_groupbuy_price_range` */

DROP TABLE IF EXISTS `feiwa_groupbuy_price_range`;

CREATE TABLE `feiwa_groupbuy_price_range` (
  `range_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '价格区间编号',
  `range_name` varchar(20) NOT NULL DEFAULT '' COMMENT '区间名称',
  `range_start` int(10) unsigned NOT NULL COMMENT '区间下限',
  `range_end` int(10) unsigned NOT NULL COMMENT '区间上限',
  PRIMARY KEY (`range_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='团购价格区间表';

/*Data for the table `feiwa_groupbuy_price_range` */

/*Table structure for table `feiwa_groupbuy_quota` */

DROP TABLE IF EXISTS `feiwa_groupbuy_quota`;

CREATE TABLE `feiwa_groupbuy_quota` (
  `quota_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '团购套餐编号',
  `member_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺编号',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `start_time` int(10) unsigned NOT NULL COMMENT '套餐开始时间',
  `end_time` int(10) unsigned NOT NULL COMMENT '套餐结束时间',
  PRIMARY KEY (`quota_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='团购套餐表';

/*Data for the table `feiwa_groupbuy_quota` */

insert  into `feiwa_groupbuy_quota`(`quota_id`,`member_id`,`store_id`,`member_name`,`store_name`,`start_time`,`end_time`) values (1,1042,7,'fengfeng','feng店铺名称',1510814164,1515998164),(2,1041,6,'zxx1cndns','商城',1510815594,1515999594),(3,1043,8,'adminy','adminy',1513696037,1516288037),(4,1043,8,'adminy','adminy',1517548677,1525324677),(5,1043,8,'adminy','adminy',1536134349,1769414349);

/*Table structure for table `feiwa_help` */

DROP TABLE IF EXISTS `feiwa_help`;

CREATE TABLE `feiwa_help` (
  `help_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '帮助ID',
  `help_sort` tinyint(1) unsigned DEFAULT '255' COMMENT '排序',
  `help_title` varchar(100) NOT NULL DEFAULT '' COMMENT '标题',
  `help_info` text COMMENT '帮助内容',
  `help_url` varchar(100) DEFAULT '' COMMENT '跳转链接',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `type_id` int(10) unsigned NOT NULL COMMENT '帮助类型',
  `page_show` tinyint(1) unsigned DEFAULT '1' COMMENT '页面类型:1为店铺,2为会员,默认为1',
  PRIMARY KEY (`help_id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8 COMMENT='帮助内容表';

/*Data for the table `feiwa_help` */

insert  into `feiwa_help`(`help_id`,`help_sort`,`help_title`,`help_info`,`help_url`,`update_time`,`type_id`,`page_show`) values (96,1,'入驻流程','<div class=\"right\">\r\n	<ul class=\"right-top\">\r\n		<li class=\"single\">\r\n			<p class=\"first\">\r\n				了解入驻相关要求\r\n			</p>\r\n		</li>\r\n		<li class=\"double\">\r\n			<span>入驻标准</span> \r\n		</li>\r\n		<li class=\"single\">\r\n			<p>\r\n				入驻申请\r\n			</p>\r\n		</li>\r\n		<li class=\"double\">\r\n			<span>马上入驻</span> \r\n		</li>\r\n		<li class=\"single\">\r\n			<p>\r\n				等待审核\r\n			</p>\r\n		</li>\r\n		<li class=\"double\">\r\n			<span>查看审核进度</span> \r\n		</li>\r\n		<li class=\"single\">\r\n			<p>\r\n				入驻成功\r\n			</p>\r\n		</li>\r\n	</ul>\r\n	<div class=\"t-1\">\r\n		<p class=\"title\">\r\n			注册本站账号\r\n		</p>\r\n		<p>\r\n			点击网站右上方的“免费注册”按钮进行注册，成为本站会员\r\n		</p>\r\n	</div>\r\n	<div class=\"bg-icon\">\r\n	</div>\r\n	<div class=\"t-2\">\r\n		<p class=\"title\">\r\n			基本资料填写\r\n		</p>\r\n		<p>\r\n			进入“商家中心”，点击“立即入驻”即可进行资料填写\r\n		</p>\r\n	</div>\r\n	<div class=\"bg-icon\">\r\n	</div>\r\n	<div class=\"t-3\">\r\n		<p class=\"title\">\r\n			资质证明上传\r\n		</p>\r\n		<p>\r\n			将营业执照原件的彩色扫描件（或彩照形式）及盖公章的申请人身份证正反面复印件上传\r\n		</p>\r\n	</div>\r\n	<div class=\"bg-icon\">\r\n	</div>\r\n	<div class=\"t-4\">\r\n		<p class=\"title\">\r\n			等候审核\r\n		</p>\r\n		<p>\r\n			本站会在3个工作日内审核您的入驻申请\r\n		</p>\r\n	</div>\r\n	<div class=\"bg-icon\">\r\n	</div>\r\n	<div class=\"t-5\">\r\n		<p class=\"title\">\r\n			签署协议\r\n		</p>\r\n		<p>\r\n			审核通过后即可在线签署《神爸入驻合同》\r\n		</p>\r\n	</div>\r\n	<div class=\"bg-icon\">\r\n	</div>\r\n	<div class=\"t-6\">\r\n		<p class=\"title\">\r\n			提交保证金\r\n		</p>\r\n		<p>\r\n			商家在活动上线前须交纳 ¥10000 元商品质量和服务保证金\r\n		</p>\r\n		<p>\r\n			数码类目商家保证金为 ¥50000（等其他类目\r\n		</p>\r\n		<p>\r\n			$8500，手续费需自行承担）\r\n		</p>\r\n	</div>\r\n</div>','',1455697950,1,1),(97,2,'招商标准','<div class=\"text\">\r\n	<p>\r\n		<span>1</span>商家需具有一般纳税人或者小额纳税人资质；注册资本50万元及以上。\r\n	</p>\r\n</div>\r\n<div class=\"text\">\r\n	<p class=\"more\">\r\n		<span>2</span>我们接受各行业有一定知名度的品牌入驻，入驻企业须是品牌所有者或授权渠道商，并且确保所提供的商品\r\n          为品牌正品，价格足够有竞争力。\r\n	</p>\r\n</div>\r\n<div class=\"text\">\r\n	<span>3</span>入驻商家经营类目需是以下类目的一种或几种 <span class=\"sign\">箱包</span> <span class=\"sign\">服饰</span> <span class=\"sign\">电器</span> <span class=\"sign\">家居</span> <span class=\"sign\">办公</span> \r\n</div>\r\n<div class=\"text last-text\">\r\n	<p>\r\n		<span>4</span>入驻商家成立时间需大于1年，即商家营业执照有效期起始时间至商家提交入驻审核时间大于1年。\r\n	</p>\r\n</div>\r\n<div class=\"c-request\">\r\n	<div class=\"title\">\r\n		<span></span>公司资质要求\r\n	</div>\r\n	<table>\r\n		<tbody>\r\n			<tr>\r\n				<td class=\"col1\">\r\n					证件名称\r\n				</td>\r\n				<td>\r\n					资质要求\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n		<tbody>\r\n			<tr>\r\n				<td class=\"col1\">\r\n					1.营业执照\r\n				</td>\r\n				<td>\r\n					必须具有法人资格，如为分支机构不具有法人资格的需提供总公司营业执照及其授权书；\r\n                    完成有效年检，复印件需加盖公司公章。<a href=\"denied:javascript:;\" class=\"showImg\">查看样例&gt;</a> \r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td class=\"col1\">\r\n					2.税务登记证\r\n				</td>\r\n				<td>\r\n					国税、地税均可，复印件需加盖公司公章。<a class=\"showImg\" href=\"denied:javascript:;\">查看样例&gt;</a> \r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td class=\"col1\">\r\n					3.组织机构代码证\r\n				</td>\r\n				<td>\r\n					复印件需加盖公司公章。<a class=\"showImg\" href=\"denied:javascript:;\">查看样例&gt;</a> \r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td class=\"col1\">\r\n					4.法人身份证\r\n				</td>\r\n				<td>\r\n					需提供法人正反面身份证扫描件或复印件，并加盖公司公章。<a class=\"showImg\" href=\"denied:javascript:;\">查看样例&gt;</a> \r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n</div>\r\n<div class=\"b-request\">\r\n	<div class=\"title\">\r\n		<span></span>品牌资质要求\r\n	</div>\r\n	<table>\r\n		<tbody>\r\n			<tr>\r\n				<td class=\"col1\">\r\n					证件名称\r\n				</td>\r\n				<td>\r\n					资质要求\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n		<tbody>\r\n			<tr>\r\n				<td class=\"col1\">\r\n					1.商标注册证\r\n				</td>\r\n				<td>\r\n					需提供有效期内的商标注册证，仅接受R标。\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td class=\"col1\">\r\n					2.品牌授权书\r\n				</td>\r\n				<td>\r\n					若品牌申请人为代理商，需提供满足以下条件的品牌授权书：\r\n					<p>\r\n						(1) 需授权在本站销售\r\n					</p>\r\n					<p>\r\n						(2) 授权书需注明授权期限、落款\r\n					</p>\r\n					<p>\r\n						(3) 若商标注册人是个人，需提供商标注册人身份证正反面复印件\r\n					</p>\r\n					<p>\r\n						(4) 需要确保授权链条的完整，即申请入驻企业拿到的授权能够逐级逆推回品牌商。\r\n					</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td class=\"col1\">\r\n					3.质检报告或3C认证证书\r\n				</td>\r\n				<td>\r\n					每个品牌须提供一份由权威质检机构出具的最近2年内的质检报告\r\n或者有效期内的3C认证证书。<a class=\"showImg\" href=\"denied:javascript:;\">查看详细说明&gt;</a> \r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td class=\"col1\">\r\n					4.报关单和检验检疫证明\r\n				</td>\r\n				<td>\r\n					若为进口产品，须提交近一年内海关进口报关单和检验检疫合格证明\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n</div>','',1455697979,1,1),(98,3,'合作细则','<div class=\"fee\">\r\n	<div class=\"title\">\r\n		<span></span>收费标准\r\n	</div>\r\n	<p>\r\n		*本站于2015年2月1日起，邀请部分品牌商家体验平台合作，暂时不收佣金。\r\n	</p>\r\n	<p>\r\n		*本站有权根据市场情况及自身经营情况调整佣金比例，但调整需至少提前30天通知商家。\r\n	</p>\r\n</div>\r\n<div class=\"fee-rule\">\r\n	<div class=\"title\">\r\n		<span></span>保证金\r\n	</div>\r\n	<p>\r\n		*商家在本站参与特卖活动必须交商品质量服务保证金（保证金主要用于保证商家按照神爸网的规则进行特卖活动，并且在商家有违规行为时\r\n根据相关规则用于向本站及消费者支付违约金）。\r\n	</p>\r\n	<p>\r\n		*商家在申请入驻获得批准时需一次性缴纳保证金，统一为人民币壹万元，食品类目商家、海外购国内商家为伍万元人民币（海外购国外商家需\r\n缴纳捌仟伍佰元美元，手续费需自行承担）\r\n	</p>\r\n	<p>\r\n		*本站有权根据商家的业务变化及实际违约赔付情况通知商家调整保证金金额，商家应在收到本站通知后的10天内补足保证金，如果没有及\r\n时补足保证金金额的，本站有权中止合作。\r\n	</p>\r\n	<p>\r\n		*由于保证金并非本站收取的费用，一直存在于您的本站企业账户中做冻结，所以不提供收据或发票，敬请谅解。\r\n	</p>\r\n	<p>\r\n		*商家如果要退出本站，终止合作，可以向本站提出保证金退还申请，本站审核通过后会在1个月内将保证金解冻至商家的本站账户内。\r\n商家同意该保证金不计算利息。\r\n	</p>\r\n	<p>\r\n		*商家有违规行为时，如根据相关规则需从已冻结保证金中支付违约金的，本站根据商家申请，按照商家实际支付金额向商家开具合法票据。\r\n开具日期为商家提交申请后的15个工作日内。\r\n	</p>\r\n	<p>\r\n		*因资质造假被清退的商家将不返还保证金，因违规行为扣取的保证金不返还，具体保证金扣取情况参见《本站合作商家违规处罚管理规定》。\r\n	</p>\r\n	<p>\r\n		*本站将根据国家经济情况、市场状况及神爸网经营情况适时适当调整保证金制度。保证金制度的调整会提前1个月公布并通知所有商家。\r\n	</p>\r\n</div>\r\n<div class=\"fee services\">\r\n	<div class=\"title\">\r\n		<span></span>48小时发货服务\r\n	</div>\r\n	<p>\r\n		*您的订单将在付款后48小时内发货。\r\n	</p>\r\n</div>\r\n<div class=\"fee baoyou\">\r\n	<div class=\"title\">\r\n		<span></span>全场包邮\r\n	</div>\r\n	<p>\r\n		*配送：本站支持偏远地区除外的下单即包邮（偏远地区包括新疆、西藏、内蒙古、宁夏、青海），特定地区按每笔最小订单加收25元运费，\r\n部分类目（一般指大件商品）因供应商原因不支持包邮送货。\r\n	</p>\r\n</div>\r\n<div class=\"fee qianshou\">\r\n	<div class=\"title\">\r\n		<span></span>验货签收\r\n	</div>\r\n	<p>\r\n		*货物当面交付的，收货人接受货物后，视为对表面一致的确认；\r\n收货人不能亲自签收，委托第三人签收时，第三人应当提供收货人的授权文件并出示收货人及第三人本人身份证原件。\r\n	</p>\r\n	<p>\r\n		对于需要先签收再打开包装查看的货物，收货人应当要求承运人当场监督并打开包装查看。如发现表面不一致，应当直接退货或者要求在签收单\r\n（收货人联和承运人联）上加注详细情况并让承运人签字确认。\r\n	</p>\r\n	<p>\r\n		收货人签字确认表面一致后，不得就表面一致的问题提出异议并要求退款。但如收货人能够提供相关证据，如物流公司证明商品签收时即存在表面\r\n一致问题的除外。\r\n	</p>\r\n	<p>\r\n		表面一致的定义：表面一致指凭肉眼或简单计量工具即可判断所收到的货物表面状况良好且与网页上的商品图片或者文字描述一致。表面一致的判\r\n断范围可参考但不限于货物的形状、大小、重量、颜色、型号、新旧程度。\r\n	</p>\r\n</div>\r\n<div class=\"fee meiliyou\">\r\n	<div class=\"title\">\r\n		<span></span>15天无理由退货服务\r\n	</div>\r\n	<h3>\r\n		一、15天无理由退货\r\n	</h3>\r\n	<p>\r\n		*本站郑重承诺：如商品未经使用或穿着，商品及外包装保持出售时的原状，商品吊牌及配件齐全，将享受15天无理由退货服务。即如果您对商\r\n品不满意，在不影响二次销售的前提下，可在收货后15天之内申请无理由退货。退回运费由您自行承担。\r\n退货金额将在供应商确认收货1个工作日内退至您的本站账户\r\n	</p>\r\n	<p>\r\n		*温馨提示：以下情况均不享受15天无理由退货服务\r\n	</p>\r\n	<p>\r\n		1、任何非本站出售的商品；\r\n	</p>\r\n	<p>\r\n		2、申请退货日期距商品签收日期超过7天的；\r\n	</p>\r\n	<p>\r\n		3、任何因非正常使用、保管或买家个人原因造成商品损坏的，包括但不限于自行修改尺寸，洗涤，皮具表面刮花、打油，刺绣，水洗、碰酸、碱、\r\n     油或者触硬物，雨天穿着，长时间穿着等；\r\n	</p>\r\n	<p>\r\n		4、未经网上申请，自行寄回至本站或供应商仓库的；\r\n	</p>\r\n	<p>\r\n		5、使用快递到付、平邮或未将商品寄至正确地址的；\r\n	</p>\r\n	<p>\r\n		6、鉴于食品安全问题，食品类商品不支持无理由退货；\r\n	</p>\r\n	<p>\r\n		7、海外购某些特殊情况不办理退货的，但仍可与商家协商；\r\n	</p>\r\n	<h3>\r\n		二、退货运费条款\r\n	</h3>\r\n	<p>\r\n		（一）15天无理由退货产生的运费由买家承担\r\n	</p>\r\n	<p>\r\n		（二）由于商品问题导致的退货，本站将提供运费补贴。同省补贴不超过10元，非同省不超过20元，特定地区不超过25元（特定地区指：新疆、\r\n          西藏、内蒙古、宁夏、青海）。\r\n	</p>\r\n	<p>\r\n		（三）、本站是限时特卖模式，商品在线时间均不超过7天，不支持换货。\r\n	</p>\r\n</div>\r\n<div class=\"fee tuihuo\">\r\n	<div class=\"title\">\r\n		<span></span>退货流程\r\n	</div>\r\n	<p>\r\n		第一步，申请退货：进入“我的神爸—我的订单”找到对应的订单，点击“售后”，填写及上传相关的信息提交退货申请。\r\n	</p>\r\n	<p>\r\n		第二步，本站审核：退货申请提交后，本站将对售后理由、图片凭证进行审核。\r\n	</p>\r\n	<p>\r\n		第三步，寄回商品：审核通过后，根据页面的退货地址退货商品，并填写有效的退货物流单号（部分退货原因无需此操作）\r\n	</p>\r\n	<p>\r\n		第四步，供应商签收：供应商签收商品后，同意退款申请。\r\n	</p>\r\n	<p>\r\n		第五步，退款完成：退款款项将在1个工作日内打款至神爸网账户。\r\n	</p>\r\n</div>\r\n<div class=\"fee peifu\">\r\n	<div class=\"title\">\r\n		<span></span>非正品赔付\r\n	</div>\r\n	<p>\r\n		本站承诺，在线销售的所有商品均为品牌正品。您在本站购买的每件商品，均由中国人民财产保险公司（PICC）承保。如您对商品是否正品\r\n存在怀疑，可到品牌专柜或有资质的机构进行鉴定，并及时通知神爸网。如鉴定结果为非正品，请提供相关证明，并在收件后90天内申请赔付。\r\n本站将按商品实付金额的三倍进行赔偿。\r\n	</p>\r\n</div>','',1455698005,1,1),(99,4,'合作品牌','<div class=\"brand_img\">\r\n	<img src=\"/data/upload/mall/article/help_store_05090420267966612.png\" alt=\"image\" />\r\n</div>','',1455698067,1,1),(101,155,'签署入驻协议','1234567890','',1514193227,99,1),(102,156,'商家信息提交','商家信息提交','',1392949961,99,1),(103,157,'平台审核资质','平台审核资质','',1392949991,99,1),(104,158,'商家缴纳费用','商家缴纳费用','',1392950031,99,1),(105,159,'店铺开通','店铺开通','',1392950076,99,1),(106,255,'商品发布规则','商品发布规则','',1392950396,91,1),(107,255,'商品规格及属性','商品规格及属性','',1392950481,92,1),(108,255,'限时折扣说明','限时折扣说明','',1392950523,93,1),(109,255,'订单商品退款','订单商品退款','',1392950670,94,1),(110,255,'续约流程及费用','续约流程及费用','',1392950739,95,1);

/*Table structure for table `feiwa_help_type` */

DROP TABLE IF EXISTS `feiwa_help_type`;

CREATE TABLE `feiwa_help_type` (
  `type_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '类型ID',
  `type_name` varchar(50) NOT NULL DEFAULT '' COMMENT '类型名称',
  `type_sort` tinyint(1) unsigned DEFAULT '255' COMMENT '排序',
  `help_code` varchar(10) DEFAULT 'auto' COMMENT '调用编号(auto的可删除)',
  `help_show` tinyint(1) unsigned DEFAULT '1' COMMENT '是否显示,0为否,1为是,默认为1',
  `page_show` tinyint(1) unsigned DEFAULT '1' COMMENT '页面类型:1为店铺,2为会员,默认为1',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COMMENT='帮助类型表';

/*Data for the table `feiwa_help_type` */

insert  into `feiwa_help_type`(`type_id`,`type_name`,`type_sort`,`help_code`,`help_show`,`page_show`) values (91,'规则体系',91,'sys_rules',1,1),(92,'商品管理',92,'sys_goods',1,1),(93,'促销方式',93,'sys_sales',1,1),(94,'订单及售后',94,'sys_order',1,1),(95,'店铺续约',95,'sys_renew',1,1),(99,'入驻流程',99,'store_in',1,1);

/*Table structure for table `feiwa_inform` */

DROP TABLE IF EXISTS `feiwa_inform`;

CREATE TABLE `feiwa_inform` (
  `inform_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '举报id',
  `inform_member_id` int(11) NOT NULL COMMENT '举报人id',
  `inform_member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '举报人会员名',
  `inform_goods_id` int(11) NOT NULL COMMENT '被举报的商品id',
  `inform_goods_name` varchar(100) NOT NULL DEFAULT '' COMMENT '被举报的商品名称',
  `inform_subject_id` int(11) NOT NULL COMMENT '举报主题id',
  `inform_subject_content` varchar(50) NOT NULL DEFAULT '' COMMENT '举报主题',
  `inform_content` varchar(100) NOT NULL DEFAULT '' COMMENT '举报信息',
  `inform_pic1` varchar(100) DEFAULT NULL COMMENT '图片1',
  `inform_pic2` varchar(100) DEFAULT NULL COMMENT '图片2',
  `inform_pic3` varchar(100) DEFAULT NULL COMMENT '图片3',
  `inform_datetime` int(11) NOT NULL COMMENT '举报时间',
  `inform_store_id` int(11) NOT NULL COMMENT '被举报商品的店铺id',
  `inform_state` tinyint(4) NOT NULL COMMENT '举报状态(1未处理/2已处理)',
  `inform_handle_type` tinyint(4) NOT NULL COMMENT '举报处理结果(1无效举报/2恶意举报/3有效举报)',
  `inform_handle_message` varchar(100) DEFAULT '' COMMENT '举报处理信息',
  `inform_handle_datetime` int(11) DEFAULT '0' COMMENT '举报处理时间',
  `inform_handle_member_id` int(11) DEFAULT '0' COMMENT '管理员id',
  `inform_goods_image` varchar(150) DEFAULT NULL COMMENT '商品图',
  `inform_store_name` varchar(100) DEFAULT NULL COMMENT '店铺名',
  PRIMARY KEY (`inform_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='举报表';

/*Data for the table `feiwa_inform` */

/*Table structure for table `feiwa_inform_subject` */

DROP TABLE IF EXISTS `feiwa_inform_subject`;

CREATE TABLE `feiwa_inform_subject` (
  `inform_subject_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '举报主题id',
  `inform_subject_content` varchar(100) NOT NULL DEFAULT '' COMMENT '举报主题内容',
  `inform_subject_type_id` int(11) NOT NULL COMMENT '举报类型id',
  `inform_subject_type_name` varchar(50) NOT NULL DEFAULT '' COMMENT '举报类型名称 ',
  `inform_subject_state` tinyint(11) NOT NULL COMMENT '举报主题状态(1可用/2失效)',
  PRIMARY KEY (`inform_subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='举报主题表';

/*Data for the table `feiwa_inform_subject` */

insert  into `feiwa_inform_subject`(`inform_subject_id`,`inform_subject_content`,`inform_subject_type_id`,`inform_subject_type_name`,`inform_subject_state`) values (1,'管制刀具、弓弩类、其他武器等',1,'出售禁售品',1),(2,'赌博用具类',1,'出售禁售品',1),(3,'枪支弹药',1,'出售禁售品',1),(4,'毒品及吸毒工具',1,'出售禁售品',1),(5,'色差大，质量差。',2,'产品质量问题',1);

/*Table structure for table `feiwa_inform_subject_type` */

DROP TABLE IF EXISTS `feiwa_inform_subject_type`;

CREATE TABLE `feiwa_inform_subject_type` (
  `inform_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '举报类型id',
  `inform_type_name` varchar(50) NOT NULL DEFAULT '' COMMENT '举报类型名称 ',
  `inform_type_desc` varchar(100) NOT NULL DEFAULT '' COMMENT '举报类型描述',
  `inform_type_state` tinyint(4) NOT NULL COMMENT '举报类型状态(1有效/2失效)',
  PRIMARY KEY (`inform_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='举报类型表';

/*Data for the table `feiwa_inform_subject_type` */

insert  into `feiwa_inform_subject_type`(`inform_type_id`,`inform_type_name`,`inform_type_desc`,`inform_type_state`) values (1,'出售禁售品','销售商城禁止和限制交易规则下所规定的所有商品。',1),(2,'产品质量问题','产品质量差，与描述严重不相符。',1);

/*Table structure for table `feiwa_invoice` */

DROP TABLE IF EXISTS `feiwa_invoice`;

CREATE TABLE `feiwa_invoice` (
  `inv_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引id',
  `member_id` int(10) unsigned NOT NULL COMMENT '会员ID',
  `inv_state` enum('1','2') DEFAULT NULL COMMENT '1普通发票2增值税发票',
  `inv_title` varchar(50) DEFAULT '' COMMENT '发票抬头[普通发票]',
  `inv_content` varchar(10) DEFAULT '' COMMENT '发票内容[普通发票]',
  `inv_company` varchar(50) DEFAULT '' COMMENT '单位名称',
  `inv_code` varchar(50) DEFAULT '' COMMENT '纳税人识别号',
  `inv_reg_addr` varchar(50) DEFAULT '' COMMENT '注册地址',
  `inv_reg_phone` varchar(30) DEFAULT '' COMMENT '注册电话',
  `inv_reg_bname` varchar(30) DEFAULT '' COMMENT '开户银行',
  `inv_reg_baccount` varchar(30) DEFAULT '' COMMENT '银行账户',
  `inv_rec_name` varchar(20) DEFAULT '' COMMENT '收票人姓名',
  `inv_rec_mobphone` varchar(15) DEFAULT '' COMMENT '收票人手机号',
  `inv_rec_province` varchar(30) DEFAULT '' COMMENT '收票人省份',
  `inv_goto_addr` varchar(50) DEFAULT '' COMMENT '送票地址',
  PRIMARY KEY (`inv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='买家发票信息表';

/*Data for the table `feiwa_invoice` */

/*Table structure for table `feiwa_link` */

DROP TABLE IF EXISTS `feiwa_link`;

CREATE TABLE `feiwa_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引id',
  `link_title` varchar(100) DEFAULT NULL COMMENT '标题',
  `link_url` varchar(100) DEFAULT NULL COMMENT '链接',
  `link_pic` varchar(100) DEFAULT NULL COMMENT '图片',
  `link_sort` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  PRIMARY KEY (`link_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='合作伙伴表';

/*Data for the table `feiwa_link` */

insert  into `feiwa_link`(`link_id`,`link_title`,`link_url`,`link_pic`,`link_sort`) values (1,'test','http://www.test.com','04639165739281622.jpg',0),(2,'QQ211111','http://www.test.com','04639165739281622.jpg',8),(39,'交流中心','http://www.test.com','',9);

/*Table structure for table `feiwa_lock` */

DROP TABLE IF EXISTS `feiwa_lock`;

CREATE TABLE `feiwa_lock` (
  `pid` bigint(20) unsigned NOT NULL COMMENT 'IP+TYPE',
  `pvalue` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '次数',
  `expiretime` int(11) NOT NULL DEFAULT '0' COMMENT '锁定截止时间',
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='防灌水表';

/*Data for the table `feiwa_lock` */

insert  into `feiwa_lock`(`pid`,`pvalue`,`expiretime`) values (16998264785,1,1523182667),(16998711433,2,1515555049),(18670887483,2,1516071827),(19001376623,2,1515142220),(19017186681,1,1513221760),(19017188371,1,1513303097),(19178847822,1,1513681713),(19178847823,1,1523953378),(19178847825,1,1524706704),(19179007603,1,1536136947),(20309642713,2,1522030662),(20309642791,1,1522031150),(20531229933,1,1514001772),(20642337605,3,1522486886),(20878588583,2,1520055510),(20909163971,3,1519869527),(20939914573,2,1516692267),(21307064333,2,1536136582),(30266560001,1,1515473579),(30266560003,2,1515473610),(30731855663,2,1515681177),(30786764763,2,1523952115),(33939689103,2,1513701874),(34160553782,1,1515569071),(34160553783,1,1536137245),(36996403075,1,1524729678),(60429505505,2,1513927567),(82641386803,1,1520911083),(191788478203,1,1523953378),(306119501401,1,1524602693);

/*Table structure for table `feiwa_mail_cron` */

DROP TABLE IF EXISTS `feiwa_mail_cron`;

CREATE TABLE `feiwa_mail_cron` (
  `mail_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息任务计划id',
  `mail` varchar(100) NOT NULL DEFAULT '' COMMENT '邮箱地址',
  `subject` varchar(255) NOT NULL DEFAULT '' COMMENT '邮件标题',
  `contnet` text NOT NULL COMMENT '邮件内容',
  PRIMARY KEY (`mail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='邮件任务计划表';

/*Data for the table `feiwa_mail_cron` */

/*Table structure for table `feiwa_mail_msg_temlates` */

DROP TABLE IF EXISTS `feiwa_mail_msg_temlates`;

CREATE TABLE `feiwa_mail_msg_temlates` (
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '模板名称',
  `title` varchar(100) DEFAULT NULL COMMENT '模板标题',
  `code` varchar(30) NOT NULL DEFAULT '' COMMENT '模板调用代码',
  `content` text NOT NULL COMMENT '模板内容',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='邮件模板表';

/*Data for the table `feiwa_mail_msg_temlates` */

insert  into `feiwa_mail_msg_temlates`(`name`,`title`,`code`,`content`) values ('<strong>[用户]</strong>身份验证通知','账户安全认证 - {$site_name}','authenticate','【{$site_name}】您于{$send_time}提交账户安全验证，验证码是：{$verify_code}。'),('<strong>[用户]</strong>邮箱验证通知','邮箱验证通知 - {$site_name}','bind_email','<p>您好！</p>\r\n<p>请在24小时内点击以下链接完成邮箱验证</p>\r\n<p><a href=\"{$verify_url}\" target=\"_blank\">马上验证</a></p>\r\n<p>如果您不能点击上面链接，还可以将以下链接复制到浏览器地址栏中访问</p>\r\n<p>{$verify_url}</p>'),('<strong>[用户]</strong>手机验证通知','手机验证通知 - {$site_name}','modify_mobile','【{$site_name}】您于{$send_time}绑定手机号，验证码是：{$verify_code}。'),('<strong>[用户]</strong>重置密码通知','重置密码通知 - {$site_name}','reset_pwd','<p>您好！</p>\r\n<p>您刚才在{$site_name}重置了密码，新密码为：{$new_password}。</p>\r\n<p>请尽快登录 <a href=\"{$site_url}\" target=\"_blank\">{$site_url}</a> 修改密码。</p>'),('<strong>[用户]</strong>门店提货通知','门店提货通知 - {$site_name}','send_chain_code','【{$site_name}】您已成功下单，订单号：{$order_sn}，提货码：{$chain_code}，请持以上信息及时到门店取货。'),('<strong>[用户]</strong>自提通知','用户自提通知 - {$site_name}','send_pickup_code','【{$site_name}】您的订单已到达自提点，请上门取货！提货时请提供手机号/订单号/运单号及提货码：{$pickup_code}。'),('<strong>[用户]</strong>虚拟兑换码通知','虚拟兑换码通知 - {$site_name}','send_vr_code','【{$site_name}】您的虚拟兑换码是：{$vr_code}。');

/*Table structure for table `feiwa_mall_consult` */

DROP TABLE IF EXISTS `feiwa_mall_consult`;

CREATE TABLE `feiwa_mall_consult` (
  `mc_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '平台客服咨询id',
  `mct_id` int(10) unsigned NOT NULL COMMENT '咨询类型id',
  `member_id` int(10) unsigned NOT NULL COMMENT '会员id',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员名称',
  `mc_content` varchar(500) NOT NULL DEFAULT '' COMMENT '咨询内容',
  `mc_addtime` int(10) unsigned NOT NULL COMMENT '咨询时间',
  `is_reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否回复，1是，0否，默认0',
  `mc_reply` varchar(500) DEFAULT '' COMMENT '回复内容',
  `mc_reply_time` int(10) unsigned DEFAULT '0' COMMENT '回复时间',
  `admin_id` int(10) unsigned DEFAULT '0' COMMENT '管理员id',
  `admin_name` varchar(50) DEFAULT '' COMMENT '管理员名称',
  PRIMARY KEY (`mc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='平台客服咨询表';

/*Data for the table `feiwa_mall_consult` */

insert  into `feiwa_mall_consult`(`mc_id`,`mct_id`,`member_id`,`member_name`,`mc_content`,`mc_addtime`,`is_reply`,`mc_reply`,`mc_reply_time`,`admin_id`,`admin_name`) values (1,1,1043,'adminy','hjghkjhlk',1513757322,1,'123',1513922123,1,'admin');

/*Table structure for table `feiwa_mall_consult_type` */

DROP TABLE IF EXISTS `feiwa_mall_consult_type`;

CREATE TABLE `feiwa_mall_consult_type` (
  `mct_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '平台客服咨询类型id',
  `mct_name` varchar(50) NOT NULL DEFAULT '' COMMENT '咨询类型名称',
  `mct_introduce` text NOT NULL COMMENT '平台客服咨询类型备注',
  `mct_sort` tinyint(3) unsigned DEFAULT '255' COMMENT '咨询类型排序',
  PRIMARY KEY (`mct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='平台客服咨询类型表';

/*Data for the table `feiwa_mall_consult_type` */

insert  into `feiwa_mall_consult_type`(`mct_id`,`mct_name`,`mct_introduce`,`mct_sort`) values (1,'商品咨询','&lt;p&gt;\r\n  请写明商品链接，或平台货号。\r\n&lt;/p&gt;\r\n&lt;p&gt;\r\n   如果您对商品规格、介绍等有疑问，可以在商品详情页“购买咨询”处发起咨询，会得到及时专业的回复。\r\n&lt;/p&gt;',255),(2,'订单咨询','&lt;p&gt;\r\n  请写明要咨询的订单编号。\r\n&lt;/p&gt;\r\n&lt;p&gt;\r\n 如需处理交易中产生的纠纷，请选择投诉。\r\n&lt;/p&gt;',255);

/*Table structure for table `feiwa_mb_category` */

DROP TABLE IF EXISTS `feiwa_mb_category`;

CREATE TABLE `feiwa_mb_category` (
  `gc_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '商城系统的分类ID',
  `gc_thumb` varchar(150) DEFAULT NULL COMMENT '缩略图',
  PRIMARY KEY (`gc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='一级分类缩略图[手机端]';

/*Data for the table `feiwa_mb_category` */

insert  into `feiwa_mb_category`(`gc_id`,`gc_thumb`) values (1,'05809158116634623.png'),(2,'05809158244559841.png'),(3,'05809158461273916.png'),(256,'05809158576871354.png'),(308,'05809159056346809.png'),(470,'05809158817150647.png'),(530,'05809158952896321.png'),(593,'05809159173027211.png'),(662,'05809159239197020.png'),(730,'05809159462617289.png'),(825,'05809159812896343.png'),(888,'05809159919762662.png'),(959,'05809160002446234.png'),(1037,'05809160140408262.png');

/*Table structure for table `feiwa_mb_delivery_token` */

DROP TABLE IF EXISTS `feiwa_mb_delivery_token`;

CREATE TABLE `feiwa_mb_delivery_token` (
  `token_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '令牌编号',
  `dlyp_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `dlyp_name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `token` varchar(50) NOT NULL DEFAULT '' COMMENT '登录令牌',
  `openid` varchar(50) DEFAULT NULL COMMENT '微信支付jsapi的openid缓存',
  `login_time` int(10) unsigned NOT NULL COMMENT '登录时间',
  `client_type` varchar(10) NOT NULL DEFAULT '' COMMENT '客户端类型 windows',
  PRIMARY KEY (`token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户端商家登录令牌表';

/*Data for the table `feiwa_mb_delivery_token` */

/*Table structure for table `feiwa_mb_feedback` */

DROP TABLE IF EXISTS `feiwa_mb_feedback`;

CREATE TABLE `feiwa_mb_feedback` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `type` varchar(50) DEFAULT NULL COMMENT '1来自手机端2来自PC端',
  `ftime` int(11) unsigned NOT NULL COMMENT '反馈时间',
  `member_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `member_name` varchar(100) NOT NULL COMMENT '用户名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='意见反馈';

/*Data for the table `feiwa_mb_feedback` */

insert  into `feiwa_mb_feedback`(`id`,`title`,`content`,`type`,`ftime`,`member_id`,`member_name`) values (1,NULL,'用户反馈用户反馈mob','wap',1536138431,1066,'iuser');

/*Table structure for table `feiwa_mb_payment` */

DROP TABLE IF EXISTS `feiwa_mb_payment`;

CREATE TABLE `feiwa_mb_payment` (
  `payment_id` tinyint(1) unsigned NOT NULL COMMENT '支付索引id',
  `payment_code` varchar(15) NOT NULL DEFAULT '' COMMENT '支付代码名称',
  `payment_name` char(10) NOT NULL DEFAULT '' COMMENT '支付名称',
  `payment_config` varchar(2000) DEFAULT NULL COMMENT '支付接口配置信息',
  `payment_state` enum('0','1') NOT NULL DEFAULT '0' COMMENT '接口状态0禁用1启用',
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机支付方式表';

/*Data for the table `feiwa_mb_payment` */

insert  into `feiwa_mb_payment`(`payment_id`,`payment_code`,`payment_name`,`payment_config`,`payment_state`) values (1,'alipay','支付宝','a:3:{s:14:\"alipay_account\";s:21:\"gzhuayu2008@gmail.com\";s:10:\"alipay_key\";s:16:\"2088002671005445\";s:14:\"alipay_partner\";s:32:\"v83dw3yhbpzkv2l72hyoamoj9ylwik4w\";}','1'),(2,'wxpay','微信支付','','0'),(3,'wxpay_jsapi','微信支付JSAPI','','0'),(4,'alipay_native','支付宝移动支付','','0');

/*Table structure for table `feiwa_mb_seller_token` */

DROP TABLE IF EXISTS `feiwa_mb_seller_token`;

CREATE TABLE `feiwa_mb_seller_token` (
  `token_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '令牌编号',
  `seller_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `seller_name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `token` varchar(50) NOT NULL DEFAULT '' COMMENT '登录令牌',
  `login_time` int(10) unsigned NOT NULL COMMENT '登录时间',
  `client_type` varchar(10) NOT NULL DEFAULT '' COMMENT '客户端类型 windows',
  PRIMARY KEY (`token_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='客户端商家登录令牌表';

/*Data for the table `feiwa_mb_seller_token` */

insert  into `feiwa_mb_seller_token`(`token_id`,`seller_id`,`seller_name`,`token`,`login_time`,`client_type`) values (2,8,'adminy','0149f9fe8b306aeb99199b92ffa9ca80',1510810879,'wap');

/*Table structure for table `feiwa_mb_special` */

DROP TABLE IF EXISTS `feiwa_mb_special`;

CREATE TABLE `feiwa_mb_special` (
  `special_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '专题编号',
  `special_desc` varchar(20) NOT NULL DEFAULT '' COMMENT '专题描述',
  PRIMARY KEY (`special_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='手机专题表';

/*Data for the table `feiwa_mb_special` */

insert  into `feiwa_mb_special`(`special_id`,`special_desc`) values (1,'0001'),(2,'123');

/*Table structure for table `feiwa_mb_special_item` */

DROP TABLE IF EXISTS `feiwa_mb_special_item`;

CREATE TABLE `feiwa_mb_special_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '专题项目编号',
  `special_id` int(10) unsigned NOT NULL COMMENT '专题编号',
  `item_type` varchar(50) NOT NULL DEFAULT '' COMMENT '项目类型',
  `item_data` varchar(2000) DEFAULT '' COMMENT '项目内容',
  `item_usable` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '项目是否可用 0-不可用 1-可用',
  `item_sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '项目排序',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='手机专题项目表';

/*Data for the table `feiwa_mb_special_item` */

insert  into `feiwa_mb_special_item`(`item_id`,`special_id`,`item_type`,`item_data`,`item_usable`,`item_sort`) values (2,0,'goods2','a:1:{s:5:\"title\";s:12:\"限时团购\";}',1,2),(3,0,'home1','',1,3),(4,0,'home1','a:4:{s:5:\"title\";s:0:\"\";s:5:\"image\";s:24:\"s0_05708970104003113.png\";s:4:\"type\";s:7:\"keyword\";s:4:\"data\";s:3:\"123\";}',1,0),(5,0,'home2','',1,4),(6,0,'adv_list','',1,1),(7,0,'home1','',1,6),(9,1,'adv_list','',0,255),(10,1,'home1','',0,255),(11,0,'goods','a:2:{s:5:\"title\";s:0:\"\";s:4:\"item\";a:4:{i:0;s:6:\"100224\";i:1;s:6:\"100213\";i:2;s:6:\"100213\";i:3;s:6:\"100178\";}}',1,5),(12,0,'home2','',1,7),(13,0,'home1','',1,10),(14,0,'goods1','',1,9),(15,0,'home4','',0,8),(16,0,'home1','',0,255),(17,0,'home2','',0,255);

/*Table structure for table `feiwa_mb_user_token` */

DROP TABLE IF EXISTS `feiwa_mb_user_token`;

CREATE TABLE `feiwa_mb_user_token` (
  `token_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '令牌编号',
  `member_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `token` varchar(50) NOT NULL DEFAULT '' COMMENT '登录令牌',
  `login_time` int(10) unsigned NOT NULL COMMENT '登录时间',
  `client_type` varchar(10) NOT NULL DEFAULT '' COMMENT '客户端类型 android wap',
  `openid` varchar(50) DEFAULT NULL COMMENT '微信支付jsapi的openid缓存',
  PRIMARY KEY (`token_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='移动端登录令牌表';

/*Data for the table `feiwa_mb_user_token` */

insert  into `feiwa_mb_user_token`(`token_id`,`member_id`,`member_name`,`token`,`login_time`,`client_type`,`openid`) values (1,1043,'adminy','4b76e0157008086e162a050658d47aec',1510810561,'wap',NULL),(2,1043,'adminy','6c248d433754d3974e860e0300f15938',1510810799,'wap',NULL),(3,1043,'adminy','7ee604a34d62d52c212cd3b7846b1052',1510810879,'wap',NULL),(4,1048,'a491945489','35bbb9f841d89250328b1003ff9629d8',1514001172,'wap',NULL),(5,1048,'a491945489','ba5e13ca73113a2a48b29835da6883be',1514001617,'wap',NULL),(6,1059,'我的普罗旺斯','97fd32e3ae895e8018dca752edf498ec',1520910483,'wap',NULL),(7,1055,'admin111','93036b6f71dff711937e5b14e388a336',1522035780,'wap',NULL),(8,1060,'test1111','1888558db72e183e9051410cf89ce4ef',1522386244,'wap',NULL),(9,1060,'test1111','532d3aac05fef34e508953f462bf810e',1522386497,'wap',NULL),(10,1,'member','59e4b0d800c0e9c6ed9e9b596927a353',1528193311,'wap',NULL),(11,1043,'adminy','8463ffae82729ef0bd9374770c296747',1536132931,'wap',NULL),(12,1,'member','e8cfec73265f25876ee0e09c737ad1b4',1536134664,'wap',NULL),(13,1043,'adminy','9e4bd9d1a49f910ab13ca4855bfbfc5b',1536134809,'wap',NULL),(14,1066,'iuser','5113ada1c0a421974fdf09cf9692d8c4',1536136251,'wap',NULL),(15,1067,'iuser_aaa','14f40371c9b7a7e2109dc0c1edabbce7',1536136347,'wap',NULL),(16,1066,'iuser','e2346cb714d6d25984dbe2b31dc2d92d',1536136411,'wap',NULL),(17,1068,'caozhiqiang','0cab129dcaaa5ef61476e9956342740a',1536136645,'wap',NULL),(18,1,'member','c5a5486e80e8d8148a70d5cf0041eafa',1536715029,'wap',NULL),(19,1,'member','8ee881d131a1a06fb027dec972e3ee60',1536715035,'wap',NULL);

/*Table structure for table `feiwa_member` */

DROP TABLE IF EXISTS `feiwa_member`;

CREATE TABLE `feiwa_member` (
  `member_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '会员id',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员名称',
  `member_truename` varchar(20) DEFAULT NULL COMMENT '真实姓名',
  `member_avatar` varchar(50) DEFAULT NULL COMMENT '会员头像',
  `member_sex` tinyint(1) DEFAULT NULL COMMENT '会员性别',
  `member_birthday` date DEFAULT NULL COMMENT '生日',
  `member_passwd` varchar(32) NOT NULL DEFAULT '' COMMENT '会员密码',
  `member_paypwd` char(32) DEFAULT NULL COMMENT '支付密码',
  `member_email` varchar(100) NOT NULL DEFAULT '' COMMENT '会员邮箱',
  `member_email_bind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未绑定1已绑定',
  `member_mobile` varchar(11) DEFAULT NULL COMMENT '手机号',
  `member_mobile_bind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未绑定1已绑定',
  `member_qq` varchar(100) DEFAULT NULL COMMENT 'qq',
  `member_ww` varchar(100) DEFAULT NULL COMMENT '阿里旺旺',
  `member_login_num` int(11) NOT NULL DEFAULT '1' COMMENT '登录次数',
  `member_time` varchar(10) NOT NULL DEFAULT '' COMMENT '会员注册时间',
  `member_login_time` varchar(10) NOT NULL DEFAULT '' COMMENT '当前登录时间',
  `member_old_login_time` varchar(10) NOT NULL DEFAULT '' COMMENT '上次登录时间',
  `member_login_ip` varchar(20) DEFAULT NULL COMMENT '当前登录ip',
  `member_old_login_ip` varchar(20) DEFAULT NULL COMMENT '上次登录ip',
  `member_qqopenid` varchar(100) DEFAULT NULL COMMENT 'qq互联id',
  `member_qqinfo` text COMMENT 'qq账号相关信息',
  `member_sinaopenid` varchar(100) DEFAULT NULL COMMENT '新浪微博登录id',
  `member_sinainfo` text COMMENT '新浪账号相关信息序列化值',
  `weixin_unionid` varchar(50) DEFAULT NULL COMMENT '微信用户统一标识',
  `weixin_info` varchar(255) DEFAULT NULL COMMENT '微信用户相关信息',
  `available_predeposit` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '预存款可用金额',
  `freeze_predeposit` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '预存款冻结金额',
  `available_rc_balance` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '可用充值卡余额',
  `freeze_rc_balance` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '冻结充值卡余额',
  `inform_allow` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否允许举报(1可以/2不可以)',
  `is_buy` tinyint(1) NOT NULL DEFAULT '1' COMMENT '会员是否有购买权限 1为开启 0为关闭',
  `is_allowtalk` tinyint(1) NOT NULL DEFAULT '1' COMMENT '会员是否有咨询和发送站内信的权限 1为开启 0为关闭',
  `member_state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '会员的开启状态 1为开启 0为关闭',
  `member_snsvisitnum` int(11) NOT NULL DEFAULT '0' COMMENT 'sns空间访问次数',
  `member_areaid` int(11) DEFAULT NULL COMMENT '地区ID',
  `member_cityid` int(11) DEFAULT NULL COMMENT '城市ID',
  `member_provinceid` int(11) DEFAULT NULL COMMENT '省份ID',
  `member_areainfo` varchar(255) DEFAULT NULL COMMENT '地区内容',
  `member_privacy` text COMMENT '隐私设定',
  `member_points` int(11) NOT NULL DEFAULT '0' COMMENT '会员积分',
  `member_exppoints` int(11) NOT NULL DEFAULT '0' COMMENT '会员经验值',
  `inviter_id` int(11) DEFAULT NULL COMMENT '邀请人ID',
  `invite_one` int(10) DEFAULT '0' COMMENT '一级会员',
  `invite_two` int(10) DEFAULT '0' COMMENT '二级会员',
  `invite_three` int(10) DEFAULT '0' COMMENT '三级会员',
  `real_check` tinyint(1) DEFAULT '0' COMMENT '实名认证状态，0为未认证，1为已认证，2为审核中，3为审核失败',
  `real_text` text COMMENT '实名认证备注',
  `real_name` varchar(50) DEFAULT NULL COMMENT '实名认证真实姓名',
  `real_cardnumber` varchar(50) DEFAULT NULL COMMENT '实名认证身份证号',
  `real_birthday` int(11) DEFAULT NULL COMMENT '实名认证出生日期',
  `real_sex` varchar(5) DEFAULT NULL COMMENT '实名认证性别',
  `real_minzu` varchar(5) DEFAULT NULL COMMENT '实名认证民族',
  `real_address` varchar(255) DEFAULT NULL COMMENT '实名认证证件住址',
  `real_jiguan` varchar(255) DEFAULT NULL COMMENT '实名认证发证机关',
  `real_timestart` int(11) DEFAULT NULL COMMENT '实名认证有效期限开始',
  `real_timeend` int(11) DEFAULT NULL COMMENT '实名认证有效期限结束',
  `real_card_zheng` varchar(255) DEFAULT NULL COMMENT '实名认证身份证证明照片',
  `real_card_fan` varchar(255) DEFAULT NULL COMMENT '实名认证身份证反面照片',
  `real_card_shou` varchar(255) DEFAULT NULL COMMENT '实名认证身份证手持照片',
  PRIMARY KEY (`member_id`),
  KEY `member_name` (`member_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1069 DEFAULT CHARSET=utf8 COMMENT='会员表';

/*Data for the table `feiwa_member` */

insert  into `feiwa_member`(`member_id`,`member_name`,`member_truename`,`member_avatar`,`member_sex`,`member_birthday`,`member_passwd`,`member_paypwd`,`member_email`,`member_email_bind`,`member_mobile`,`member_mobile_bind`,`member_qq`,`member_ww`,`member_login_num`,`member_time`,`member_login_time`,`member_old_login_time`,`member_login_ip`,`member_old_login_ip`,`member_qqopenid`,`member_qqinfo`,`member_sinaopenid`,`member_sinainfo`,`weixin_unionid`,`weixin_info`,`available_predeposit`,`freeze_predeposit`,`available_rc_balance`,`freeze_rc_balance`,`inform_allow`,`is_buy`,`is_allowtalk`,`member_state`,`member_snsvisitnum`,`member_areaid`,`member_cityid`,`member_provinceid`,`member_areainfo`,`member_privacy`,`member_points`,`member_exppoints`,`inviter_id`,`invite_one`,`invite_two`,`invite_three`,`real_check`,`real_text`,`real_name`,`real_cardnumber`,`real_birthday`,`real_sex`,`real_minzu`,`real_address`,`real_jiguan`,`real_timestart`,`real_timeend`,`real_card_zheng`,`real_card_fan`,`real_card_shou`) values (1,'member','',NULL,0,NULL,'e10adc3949ba59abbe56e057f20f883e',NULL,'123456@a.a',0,NULL,0,'','',6,'1510298830','1536715035','1536715029','203.156.222.82','203.156.222.82',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,2,NULL,NULL,NULL,NULL,NULL,120,20,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1041,'zxx1cndns','zxx',NULL,1,'2017-11-16','8dbb3adb6f67b7c915bd2b34c3e36cff',NULL,'zxx@a.com',0,NULL,0,'111111','221',7,'1510650410','1525860530','1511508695','203.156.222.82','114.80.215.216',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,0,0,0,'上海','a:7:{s:5:\"email\";s:1:\"0\";s:8:\"truename\";s:1:\"0\";s:3:\"sex\";s:1:\"0\";s:8:\"birthday\";s:1:\"0\";s:4:\"area\";s:1:\"0\";s:2:\"qq\";s:1:\"0\";s:2:\"ww\";s:1:\"0\";}',110,15,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1042,'fengfeng',NULL,NULL,NULL,NULL,'13bfce0dfa154327c03d0acc06c2f323',NULL,'feng@feng.com',0,NULL,0,NULL,NULL,2,'1510651780','1510813895','1510651780','114.80.215.216','114.80.215.216',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,50,5,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1043,'adminy','','avatar_1043.jpg',0,NULL,'a65a0cad3e35822c49835a7b1087e41d','e10adc3949ba59abbe56e057f20f883e','adminy@a.com',1,NULL,0,'','',72,'1510796770','1536134809','1536132931','114.80.215.216','114.80.215.216',NULL,NULL,NULL,NULL,NULL,NULL,'95711.00','0.00','96962.00','0.00',1,1,1,1,23,NULL,NULL,NULL,NULL,NULL,1214,289,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1044,'cliffgyn',NULL,NULL,NULL,NULL,'0a3ce9ac404098203ab60be031e7799f',NULL,'41112820@qq.com',0,NULL,0,NULL,NULL,2,'1513701274','1513701306','1513701274','202.75.219.14','202.75.219.14',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,20,0,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1045,'register',NULL,NULL,NULL,NULL,'9de4a97425678c5b1288aa70c1669a64',NULL,'ss@dd.com',0,NULL,0,NULL,NULL,1,'1513751143','1513751143','1513751143','114.80.215.216','114.80.215.216',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,20,0,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1046,'hztest','',NULL,0,NULL,'566c7df71050dd23562a4a69e3a43ca3',NULL,'hzidc@cndns.com',0,NULL,0,'','',1,'1513751804','1513751804','1513751804','114.80.153.110','114.80.153.110',NULL,NULL,NULL,NULL,NULL,NULL,'1000000.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,20,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1047,'adssse',NULL,NULL,NULL,NULL,'a65a0cad3e35822c49835a7b1087e41d',NULL,'adminy@cnssdns.com',0,NULL,0,NULL,NULL,1,'1513752446','1513752446','1513752446','114.80.215.216','114.80.215.216',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,20,0,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1048,'a491945489',NULL,NULL,NULL,NULL,'57962dc83a39851d4428fd4e25280fa8',NULL,'hsjdjf@qq.com',0,NULL,0,NULL,NULL,3,'1514001172','1514017673','1514001617','','',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,20,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1049,'orayadminabc','',NULL,0,NULL,'208c81cf5fddeea397171ade1cb7c68e',NULL,'sfasfsfsqqcomsdfsfsf@qq.com',0,NULL,0,'','',3,'1515141620','1515143336','1515142803','113.65.204.190','113.65.204.190',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,20,0,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1050,'tianhe',NULL,NULL,NULL,NULL,'07f0fc428d5e1dd75e24c2706115d935',NULL,'',0,NULL,0,NULL,NULL,1,'1515311233','1515311233','1515311233','114.80.153.110','114.80.153.110',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,20,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1051,'123456abc',NULL,NULL,NULL,NULL,'df10ef8509dc176d733d59549e7dbfaf',NULL,'972087996@qq.com',0,NULL,0,NULL,NULL,1,'1515473010','1515473010','1515473010','1.205.212.192','1.205.212.192',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,20,0,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1052,'leitao',NULL,NULL,NULL,NULL,'c7470bffc14c9981d1bc0a9bbdd358c0',NULL,'3173644049@qq.com',0,NULL,0,NULL,NULL,6,'1515548961','1515571532','1515566637','203.156.222.82','203.156.222.82',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,20,0,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1053,'joor2017',NULL,NULL,NULL,NULL,'131e2ab4c3d5b41f31a737c8c911b4e9',NULL,'496689456@qq.com',0,NULL,0,NULL,NULL,1,'1515554449','1515554449','1515554449','101.81.249.167','101.81.249.167',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,20,0,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1054,'ssencn',NULL,NULL,NULL,NULL,'25d55ad283aa400af464c76d713c07ad',NULL,'lonwu@163.com',0,NULL,0,NULL,NULL,2,'1515680577','1515680669','1515680577','183.45.23.30','183.45.23.30',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,20,0,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1055,'admin111','',NULL,0,NULL,'bbad8d72c1fac1d081727158807a8798',NULL,'764759168@qq.com',0,NULL,0,'','',4,'1516071227','1522036111','1522035780','117.40.114.226','223.104.170.43',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,1,NULL,NULL,NULL,NULL,NULL,50,5,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1056,'19716305wanlu',NULL,NULL,NULL,NULL,'e99af73b3c55ef4cc599a30324963c54',NULL,'19716305@qq.com',0,NULL,0,NULL,NULL,1,'1516691667','1516691667','1516691667','124.207.198.33','124.207.198.33',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,20,0,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1057,'xiaozhai',NULL,NULL,NULL,NULL,'afb77e779f07b4521bb572632a32de52',NULL,'',0,NULL,0,NULL,NULL,1,'1517889255','1517889255','1517889255','117.35.158.214','117.35.158.214',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,1,NULL,NULL,NULL,NULL,NULL,20,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1058,'test123456',NULL,NULL,NULL,NULL,'47ec2dd791e31e2ef2076caf64ed9b3d',NULL,'test123456@163.com',0,NULL,0,NULL,NULL,1,'1520054910','1520054910','1520054910','124.114.50.170','124.114.50.170',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,1,NULL,NULL,NULL,NULL,NULL,20,0,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1059,'我的普罗旺斯',NULL,NULL,NULL,NULL,'39b89f0e92eccb52e9e8c6c950d01eb3',NULL,'366899657@qq.com',0,NULL,0,NULL,NULL,1,'1520910483','1520910483','1520910483','49.66.19.44','49.66.19.44',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,20,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1060,'test1111','',NULL,3,NULL,'51ce84a6db96daaa7081869fd38c517a',NULL,'hshun@139.com',0,NULL,0,'','',39,'1522030062','1522394535','1522386497','117.182.203.220','117.182.203.220',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,0,0,0,'','a:7:{s:5:\"email\";s:1:\"2\";s:8:\"truename\";s:1:\"0\";s:3:\"sex\";s:1:\"0\";s:8:\"birthday\";s:1:\"0\";s:4:\"area\";s:1:\"0\";s:2:\"qq\";s:1:\"0\";s:2:\"ww\";s:1:\"0\";}',110,15,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1061,'hzyuandun',NULL,NULL,NULL,NULL,'e9d79992eb6f7781d8b9fbfb531900db',NULL,'18958133771@189.cn',0,NULL,0,NULL,NULL,1,'1523951515','1523951515','1523951515','183.128.223.252','183.128.223.252',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,20,0,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1062,'cliffgyn11111',NULL,NULL,NULL,NULL,'e10adc3949ba59abbe56e057f20f883e',NULL,'11111@qq.com',0,NULL,0,NULL,NULL,1,'1523952717','1523952717','1523952717','114.80.153.110','114.80.153.110',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,2,NULL,NULL,NULL,NULL,NULL,20,0,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1063,'sannianzhihou',NULL,NULL,NULL,NULL,'a837ce8a31012e09718924eb14819110',NULL,'2077932338@qq.com',0,NULL,0,NULL,NULL,1,'1523952778','1523952778','1523952778','114.80.153.110','114.80.153.110',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,1,NULL,NULL,NULL,NULL,NULL,20,0,NULL,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1066,'iuser',NULL,NULL,NULL,NULL,'e10adc3949ba59abbe56e057f20f883e',NULL,'xqfdafeng@163.com',0,NULL,0,NULL,NULL,5,'1536135982','1536136411','1536136251','114.80.215.216','114.80.215.216',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,20,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1067,'iuser_aaa',NULL,NULL,NULL,NULL,'bc928d3fb560701c8e0a8fb9138a0685',NULL,'a@afd.com',0,NULL,0,NULL,NULL,1,'1536136347','1536136347','1536136347','114.80.215.216','114.80.215.216',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,35,300,NULL,1066,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1068,'caozhiqiang',NULL,NULL,NULL,NULL,'670b14728ad9902aecba32e22fa4f6bd',NULL,'1121514095@qq.com',0,NULL,0,NULL,NULL,1,'1536136645','1536136645','1536136645','203.156.222.82','203.156.222.82',NULL,NULL,NULL,NULL,NULL,NULL,'0.00','0.00','0.00','0.00',1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,20,0,NULL,1066,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `feiwa_member_common` */

DROP TABLE IF EXISTS `feiwa_member_common`;

CREATE TABLE `feiwa_member_common` (
  `member_id` int(11) NOT NULL COMMENT '会员ID',
  `auth_code` char(6) DEFAULT NULL COMMENT '短信/邮件验证码',
  `send_acode_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '短信/邮件验证码发送时间',
  `send_mb_time` int(11) DEFAULT NULL COMMENT '发送短信验证码时间',
  `send_email_time` int(11) DEFAULT NULL COMMENT '发送邮件验证码时间',
  `send_mb_times` tinyint(4) NOT NULL DEFAULT '0' COMMENT '发送手机验证码次数',
  `send_acode_times` tinyint(4) NOT NULL DEFAULT '0' COMMENT '发送验证码次数',
  `auth_code_check_times` tinyint(4) NOT NULL DEFAULT '0' COMMENT '验证码验证次数[目前wap使用]',
  `auth_modify_pwd_time` int(11) NOT NULL DEFAULT '0' COMMENT '修改密码授权时间[目前wap使用]',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员扩展表';

/*Data for the table `feiwa_member_common` */

insert  into `feiwa_member_common`(`member_id`,`auth_code`,`send_acode_time`,`send_mb_time`,`send_email_time`,`send_mb_times`,`send_acode_times`,`auth_code_check_times`,`auth_modify_pwd_time`) values (1,NULL,0,NULL,NULL,0,0,0,0),(1041,NULL,0,NULL,NULL,0,0,0,0),(1042,NULL,0,NULL,NULL,0,0,0,0),(1043,NULL,0,NULL,NULL,0,0,0,0),(1044,NULL,0,NULL,NULL,0,0,0,0),(1045,NULL,0,NULL,NULL,0,0,0,0),(1046,NULL,0,NULL,NULL,0,0,0,0),(1047,NULL,0,NULL,NULL,0,0,0,0),(1048,NULL,0,NULL,NULL,0,0,0,0),(1049,NULL,0,NULL,NULL,0,0,0,0),(1050,NULL,0,NULL,NULL,0,0,0,0),(1051,NULL,0,NULL,NULL,0,0,0,0),(1052,NULL,0,NULL,NULL,0,0,0,0),(1053,NULL,0,NULL,NULL,0,0,0,0),(1054,NULL,0,NULL,NULL,0,0,0,0),(1055,NULL,0,NULL,NULL,0,0,0,0),(1056,NULL,0,NULL,NULL,0,0,0,0),(1057,NULL,0,NULL,NULL,0,0,0,0),(1058,NULL,0,NULL,NULL,0,0,0,0),(1059,NULL,0,NULL,NULL,0,0,0,0),(1060,NULL,0,NULL,NULL,0,0,0,0),(1061,NULL,0,NULL,NULL,0,0,0,0),(1062,NULL,0,NULL,NULL,0,0,0,0),(1063,NULL,0,NULL,NULL,0,0,0,0),(1064,NULL,0,NULL,NULL,0,0,0,0),(1067,NULL,0,NULL,NULL,0,0,0,0),(1068,NULL,0,NULL,NULL,0,0,0,0);

/*Table structure for table `feiwa_member_msg_setting` */

DROP TABLE IF EXISTS `feiwa_member_msg_setting`;

CREATE TABLE `feiwa_member_msg_setting` (
  `mmt_code` varchar(50) NOT NULL DEFAULT '' COMMENT '用户消息模板编号',
  `member_id` int(10) unsigned NOT NULL COMMENT '会员id',
  `is_receive` tinyint(3) unsigned NOT NULL COMMENT '是否接收 1是，0否',
  PRIMARY KEY (`mmt_code`,`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户消息接收设置表';

/*Data for the table `feiwa_member_msg_setting` */

/*Table structure for table `feiwa_member_msg_tpl` */

DROP TABLE IF EXISTS `feiwa_member_msg_tpl`;

CREATE TABLE `feiwa_member_msg_tpl` (
  `mmt_code` varchar(50) NOT NULL DEFAULT '' COMMENT '用户消息模板编号',
  `mmt_name` varchar(50) NOT NULL DEFAULT '' COMMENT '模板名称',
  `mmt_message_switch` tinyint(3) unsigned NOT NULL COMMENT '站内信接收开关',
  `mmt_message_content` varchar(255) NOT NULL DEFAULT '' COMMENT '站内信消息内容',
  `mmt_short_switch` tinyint(3) unsigned NOT NULL COMMENT '短信接收开关',
  `mmt_short_content` varchar(255) NOT NULL DEFAULT '' COMMENT '短信接收内容',
  `mmt_mail_switch` tinyint(3) unsigned NOT NULL COMMENT '邮件接收开关',
  `mmt_mail_subject` varchar(255) NOT NULL DEFAULT '' COMMENT '邮件标题',
  `mmt_mail_content` text NOT NULL COMMENT '邮件内容',
  PRIMARY KEY (`mmt_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户消息模板';

/*Data for the table `feiwa_member_msg_tpl` */

insert  into `feiwa_member_msg_tpl`(`mmt_code`,`mmt_name`,`mmt_message_switch`,`mmt_message_content`,`mmt_short_switch`,`mmt_short_content`,`mmt_mail_switch`,`mmt_mail_subject`,`mmt_mail_content`) values ('arrival_notice','到货通知提醒',1,'您关注的商品 “{$goods_name}” 已经到货。<a href=\"{$goods_url}\" target=\"_blank\">点击查看商品</a>',0,'【{$site_name}】您关注的商品 “{$goods_name}” 已经到货。',0,'{$site_name}提醒：您关注的商品  “{$goods_name}” 已经到货。','<p>\r\n   {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您关注的商品 “{$goods_name}” 已经到货。\r\n</p>\r\n<p>\r\n <a href=\"{$goods_url}\" target=\"_blank\">点击查看商品</a> \r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>'),('consult_goods_reply','商品咨询回复提醒',1,'您关于商品 “{$goods_name}”的咨询，商家已经回复。<a href=\"{$consult_url}\" target=\"_blank\">点击查看回复</a>',0,'【{$site_name}】您关于商品 “{$goods_name}” 的咨询，商家已经回复。',0,'{$site_name}提醒：您关于商品 “{$goods_name}”的咨询，商家已经回复。','<p>\r\n  {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您关注的商品“{$goods_name}” 已经到货。\r\n</p>\r\n<p>\r\n  <a href=\"{$consult_url}\" target=\"_blank\">点击查看回复</a> \r\n</p>\r\n<p>\r\n <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>\r\n<br />\r\n<div class=\"firebugResetStyles firebugBlockBackgroundColor\">\r\n <div style=\"background-color:transparent ! important;\" class=\"firebugResetStyles\">\r\n  </div>\r\n</div>'),('consult_mall_reply','平台客服回复提醒',1,'您的平台客服咨询已经回复。<a href=\"{$consult_url}\" target=\"_blank\">点击查看回复</a>',0,'【{$site_name}】您的平台客服咨询已经回复。',0,'{$site_name}提醒：您的平台客服咨询已经回复。','<p>\r\n {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您的平台客服咨询已经回复。\r\n</p>\r\n<p>\r\n    <a href=\"{$consult_url}\" target=\"_blank\">点击查看回复</a> \r\n</p>\r\n<p>\r\n <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>'),('order_book_end_pay','预定订单尾款支付提醒',1,'您的订单已经进入支付尾款时间。<a href=\"{$order_url}\" target=\"_blank\">点击支付尾款</a>',0,'【{$site_name}】您的订单已经进入支付尾款时间。订单编号 {$order_sn}。',0,'{$site_name}提醒：您的订单已经进入支付尾款时间。订单编号 {$order_sn}。','<p>\r\n    {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您的订单已经进入支付尾款时间。订单编号 {$order_sn}。<br />\r\n<a href=\"{$order_url}\" target=\"_blank\">点击支付尾款</a>\r\n</p>\r\n<p>\r\n    <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>\r\n<br />'),('order_deliver_success','商品出库提醒',1,'您的订单已经出库。<a href=\"{$order_url}\" target=\"_blank\">点击查看订单</a>',0,'【{$site_name}】您的订单已经出库。订单编号 {$order_sn}。',0,'{$site_name}提醒：您的订单已经出库。订单编号 {$order_sn}。','<p>\r\n    {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您的订单已经出库。订单编号 {$order_sn}。<br />\r\n<a href=\"{$order_url}\" target=\"_blank\">点击查看订单</a>\r\n</p>\r\n<p>\r\n    <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>\r\n<br />'),('order_payment_success','付款成功提醒',1,'关于订单：{$order_sn}的款项已经收到，请留意出库通知。<a href=\"{$order_url}\" target=\"_blank\">点击查看订单详情</a>',0,'【{$site_name}】{$order_sn}的款项已经收到，请留意出库通知。',0,'{$site_name}提醒：{$order_sn}的款项已经收到，请留意出库通知。','<p>\r\n {$site_name}提醒：\r\n</p>\r\n<p>\r\n  {$order_sn}的款项已经收到，请留意出库通知。\r\n</p>\r\n<p>\r\n  <a href=\"{$order_url}\" target=\"_blank\">点击查看订单详情</a>\r\n</p>\r\n<p>\r\n  <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>\r\n<br />'),('predeposit_change','余额变动提醒',1,'你的账户于 {$time} 账户资金有变化，描述：{$desc}，可用金额变化 ：{$av_amount}元，冻结金额变化：{$freeze_amount}元。<a href=\"{$pd_url}\" target=\"_blank\">点击查看余额</a>',0,'【{$site_name}】你的账户于 {$time} 账户资金有变化，描述：{$desc}，可用金额变化： {$av_amount}元，冻结金额变化：{$freeze_amount}元。',0,'{$site_name}提醒：你的账户于 {$time} 账户资金有变化，描述：{$desc}，可用金额变化： {$av_amount}元，冻结金额变化：{$freeze_amount}元。','<p>\r\n    {$site_name}提醒：\r\n</p>\r\n<p>\r\n  你的账户于 {$time} 账户资金有变化，描述：{$desc}，可用金额变化：{$av_amount}元，冻结金额变化：{$freeze_amount}元。\r\n</p>\r\n<p>\r\n  <a href=\"{$pd_url}\" target=\"_blank\">点击查看余额</a> \r\n</p>\r\n<p>\r\n  <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>'),('recharge_card_balance_change','充值卡余额变动提醒',1,'你的账户于 {$time} 充值卡余额有变化，描述：{$description}，可用充值卡余额变化 ：{$available_amount}元，冻结充值卡余额变化：{$freeze_amount}元。<a href=\"{$url}\" target=\"_blank\">点击查看充值卡余额</a>',0,'【{$site_name}】你的账户于 {$time} 充值卡余额有变化，描述：{$description}，可用充值卡余额变化： {$available_amount}元，冻结充值卡余额变化：{$freeze_amount}元。',0,'{$site_name}提醒：你的账户于 {$time} 充值卡余额有变化，描述：{$description}，可用充值卡余额变化： {$available_amount}元，冻结充值卡余额变化：{$freeze_amount}元。','<p>\r\n    {$site_name}提醒：\r\n</p>\r\n<p>\r\n  你的账户于 {$time} 充值卡余额有变化，描述：{$description}，可用充值卡余额变化：{$available_amount}元，冻结充值卡余额变化：{$freeze_amount}元。\r\n</p>\r\n<p>\r\n  <a href=\"{$url}\" target=\"_blank\">点击查看余额</a> \r\n</p>\r\n<p>\r\n  <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>'),('refund_return_notice','退款退货提醒',1,'您的退款退货单有了变化。<a href=\"{$refund_url}\" target=\"_blank\">点击查看</a>',0,'【{$site_name}】您的退款退货单有了变化。退款退货单编号：{$refund_sn}。',0,'{$site_name}提醒：您的退款退货单有了变化。','<p>\r\n  {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您的退款退货单有了变化。退款退货单编号：{$refund_sn}。\r\n</p>\r\n<p>\r\n    &lt;a href=\"{$refund_url}\" target=\"_blank\"&gt;点击查看&lt;/a&gt;\r\n</p>\r\n<p>\r\n <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>\r\n<br />'),('rpt_use','红包使用提醒',1,'您有红包已经使用，编号：{$rpacket_code}。<a href=\"{$rpacket_url}\" target=\"_blank\">点击查看</a>',0,'【{$site_name}】您有红包已经使用，编号：{$rpacket_code}。',0,'{$site_name}提醒：您有红包已经使用，编号：{$rpacket_code}。','<p>\n  {$site_name}提醒：\n</p>\n<p>\n  您有红包已经使用，编号：{$rpacket_code}。\n</p>\n<p>\n &lt;a href=\"{$rpacket_url}\" target=\"_blank\"&gt;点击查看&lt;/a&gt;\n</p>\n<p>\n    <br />\n</p>\n<p>\n   <br />\n</p>\n<p>\n   <br />\n</p>\n<p style=\"text-align:right;\">\n {$site_name}\n</p>\n<p style=\"text-align:right;\">\n   {$mail_send_time}\n</p>\n<p>\n    <br />\n</p>\n<p>\n   <br />\n</p>'),('voucher_use','代金券使用提醒',1,'您有代金券已经使用，代金券编号：{$voucher_code}。<a href=\"{$voucher_url}\" target=\"_blank\">点击查看</a>',0,'【{$site_name}】您有代金券已经使用，代金券编号：{$voucher_code}。',0,'{$site_name}提醒：您有代金券已经使用，代金券编号：{$voucher_code}。','<p>\r\n  {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您有代金券已经使用，代金券编号：{$voucher_code}。\r\n</p>\r\n<p>\r\n &lt;a href=\"{$voucher_url}\" target=\"_blank\"&gt;点击查看&lt;/a&gt;\r\n</p>\r\n<p>\r\n    <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>\r\n<p>\r\n    <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>'),('voucher_will_expire','代金券即将到期提醒',1,'您有一个代金券即将在{$indate}过期，请记得使用。<a href=\"{$voucher_url}\" target=\"_blank\">点击查看</a>',0,'【{$site_name}】您有一个代金券即将在{$indate}过期，请记得使用。',0,'{$site_name}提醒：您有一个代金券即将在{$indate}过期，请记得使用。','<p>\r\n	{$site_name}提醒：\r\n</p>\r\n<p>\r\n	您有一个代金券即将在{$indate}过期，请记得使用。\r\n</p>\r\n<p>\r\n	<a href=\"{$voucher_url}\" target=\"_blank\">点击查看</a> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n	{$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n	{$mail_send_time}\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>'),('vr_code_will_expire','兑换码即将到期提醒',1,'您有一组兑换码即将在{$indate}过期，请记得使用。<a href=\"{$vr_order_url}\" target=\"_blank\">点击查看</a>',0,'【{$site_name}】您有一组兑换码即将在{$indate}过期，请记得使用。',0,'{$site_name}提醒：您有一组兑换码即将在{$indate}过期，请记得使用。','<p>\r\n	{$site_name}提醒：\r\n</p>\r\n<p>\r\n	您有一组兑换码即将在{$indate}过期，请记得使用。\r\n</p>\r\n<p>\r\n	&lt;a href=\"{$vr_order_url}\" target=\"_blank\"&gt;点击查看&lt;/a&gt;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n	{$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n	{$mail_send_time}\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>');

/*Table structure for table `feiwa_mes_feedback` */

DROP TABLE IF EXISTS `feiwa_mes_feedback`;

CREATE TABLE `feiwa_mes_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引id',
  `member_id` int(11) DEFAULT NULL,
  `member_name` varchar(100) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL COMMENT '发送人',
  `addtime` varchar(11) NOT NULL COMMENT '发送时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短消息';

/*Data for the table `feiwa_mes_feedback` */

/*Table structure for table `feiwa_message` */

DROP TABLE IF EXISTS `feiwa_message`;

CREATE TABLE `feiwa_message` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '短消息索引id',
  `message_parent_id` int(11) NOT NULL COMMENT '回复短消息message_id',
  `from_member_id` int(11) NOT NULL COMMENT '短消息发送人',
  `to_member_id` varchar(1000) NOT NULL DEFAULT '' COMMENT '短消息接收人',
  `is_level` varchar(20) DEFAULT NULL,
  `message_title` varchar(50) DEFAULT NULL COMMENT '短消息标题',
  `message_body` varchar(255) NOT NULL DEFAULT '' COMMENT '短消息内容',
  `message_time` varchar(10) NOT NULL DEFAULT '' COMMENT '短消息发送时间',
  `message_update_time` varchar(10) DEFAULT NULL COMMENT '短消息回复更新时间',
  `message_open` tinyint(1) NOT NULL DEFAULT '0' COMMENT '短消息打开状态',
  `message_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '短消息状态，0为正常状态，1为发送人删除状态，2为接收人删除状态',
  `message_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0为私信、1为系统消息、2为留言',
  `read_member_id` varchar(1000) DEFAULT NULL COMMENT '已经读过该消息的会员id',
  `del_member_id` varchar(1000) DEFAULT NULL COMMENT '已经删除该消息的会员id',
  `message_ismore` tinyint(1) NOT NULL DEFAULT '0' COMMENT '站内信是否为一条发给多个用户 0为否 1为多条 ',
  `from_member_name` varchar(100) DEFAULT NULL COMMENT '发信息人用户名',
  `to_member_name` varchar(100) DEFAULT NULL COMMENT '接收人用户名',
  PRIMARY KEY (`message_id`),
  KEY `from_member_id` (`from_member_id`),
  KEY `to_member_id` (`to_member_id`(255)),
  KEY `message_ismore` (`message_ismore`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='短消息';

/*Data for the table `feiwa_message` */

insert  into `feiwa_message`(`message_id`,`message_parent_id`,`from_member_id`,`to_member_id`,`is_level`,`message_title`,`message_body`,`message_time`,`message_update_time`,`message_open`,`message_state`,`message_type`,`read_member_id`,`del_member_id`,`message_ismore`,`from_member_name`,`to_member_name`) values (28,0,0,'1043',NULL,NULL,'你的账户于 2017-11-17 11:50:29 账户资金有变化，描述：下单，支付预存款，订单号: 9000000000000201，可用金额变化 ：-89.00元，冻结金额变化：0.00元。<a href=\"http://101.226.179.113/member/index.php?app=predeposit&feiwa=pd_log_list\" target=\"_blank\">点击查看余额</a>','1510890629','1510890629',0,0,1,'','',0,'',''),(29,0,0,'1043',NULL,NULL,'您的订单已经出库。<a href=\"http://101.226.179.113/mall/index.php?app=member_order&feiwa=show_order&order_id=2\" target=\"_blank\">点击查看订单</a>','1510905497','1510905497',0,0,1,'','',0,'',''),(30,0,0,'1046',NULL,NULL,'你的账户于 2017-12-20 15:22:06 账户资金有变化，描述：管理员调节预存款【增加】，充值单号: 920567098526268000，可用金额变化 ：1000000.00元，冻结金额变化：0.00元。<a href=\"http://865284.ichengyun.net/member/index.php?app=predeposit&feiwa=pd_log_list\" target=\"_blank\">点击查看余额</a>','1513754526','1513754526',0,0,1,'','',0,'',''),(31,0,0,'1043',NULL,NULL,'您的平台客服咨询已经回复。<a href=\"http://865284.ichengyun.net/mall/index.php?app=member_mallconsult&feiwa=mallconsult_info&id=1\" target=\"_blank\">点击查看回复</a>','1513828325','1513828325',0,0,1,'','',0,'',''),(32,0,0,'1043',NULL,NULL,'您的平台客服咨询已经回复。<a href=\"http://865284.ichengyun.net/mall/index.php?app=member_mallconsult&feiwa=mallconsult_info&id=1\" target=\"_blank\">点击查看回复</a>','1513922123','1513922123',0,0,1,'','',0,'',''),(33,0,0,'1043',NULL,NULL,'你的账户于 2018-01-10 10:11:04 充值卡余额有变化，描述：下单，使用充值卡余额，订单号: 1000000000000601，可用充值卡余额变化 ：-2100.00元，冻结充值卡余额变化：0.00元。<a href=\"http://865284.ichengyun.net/member/index.php?app=predeposit&feiwa=rcb_log_list\" target=\"_blank\">点击查看充值卡余额</a>','1515550264','1515550264',0,0,1,'','',0,'',''),(34,0,0,'1043',NULL,NULL,'你的账户于 2018-01-10 10:22:05 充值卡余额有变化，描述：下单，使用充值卡余额，订单号: 1000000000000701，可用充值卡余额变化 ：-938.00元，冻结充值卡余额变化：0.00元。<a href=\"http://865284.ichengyun.net/member/index.php?app=predeposit&feiwa=rcb_log_list\" target=\"_blank\">点击查看充值卡余额</a>','1515550925','1515550925',0,0,1,'','',0,'',''),(35,0,1063,'1062',NULL,NULL,'你好','1523953062','1523953062',0,0,2,'','',0,'sannianzhihou','cliffgyn11111'),(36,0,0,'1043',NULL,NULL,'您的订单已经出库。<a href=\"http://malltest.mywopop.com/mall/index.php?app=member_order&feiwa=show_order&order_id=6\" target=\"_blank\">点击查看订单</a>','1525747989','1525747989',0,0,1,'','',0,'',''),(37,0,0,'1043',NULL,NULL,'您的订单已经出库。<a href=\"http://malltest.mywopop.com/mall/index.php?app=member_order&feiwa=show_order&order_id=7\" target=\"_blank\">点击查看订单</a>','1525748321','1525748321',0,0,1,'','',0,'',''),(38,0,0,'1043',NULL,NULL,'你的账户于 2018-05-08 11:00:38 账户资金有变化，描述：下单，支付预存款，订单号: 1000000000001001，可用金额变化 ：-2100.00元，冻结金额变化：0.00元。<a href=\"http://malltest.mywopop.com/member/index.php?app=predeposit&feiwa=pd_log_list\" target=\"_blank\">点击查看余额</a>','1525748438','1525748438',0,0,1,'','',0,'',''),(39,0,0,'1043',NULL,NULL,'你的账户于 2018-05-08 11:01:12 账户资金有变化，描述：下单，支付预存款，订单号: 1000000000001101，可用金额变化 ：-2100.00元，冻结金额变化：0.00元。<a href=\"http://malltest.mywopop.com/member/index.php?app=predeposit&feiwa=pd_log_list\" target=\"_blank\">点击查看余额</a>','1525748472','1525748472',0,0,1,'','',0,'',''),(40,0,1043,'1041',NULL,NULL,'zxx1cndns zxx1cndns','1525860498','1525860498',0,0,0,'','',0,'adminy','zxx1cndns'),(41,0,0,'1067','',NULL,'您的订单已经出库。<a href=\"http://malltest.mywopop.com/mall/index.php?app=member_order&ops=show_order&order_id=23\" target=\"_blank\">点击查看订单</a>','1536138238','1536138238',0,0,1,'','',0,'','');

/*Table structure for table `feiwa_micro_adv` */

DROP TABLE IF EXISTS `feiwa_micro_adv`;

CREATE TABLE `feiwa_micro_adv` (
  `adv_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '广告编号',
  `adv_type` varchar(50) DEFAULT '' COMMENT '广告类型',
  `adv_name` varchar(255) DEFAULT '' COMMENT '广告名称',
  `adv_image` varchar(255) NOT NULL DEFAULT '' COMMENT '广告图片',
  `adv_url` varchar(255) DEFAULT '' COMMENT '广告链接',
  `adv_sort` tinyint(1) unsigned NOT NULL DEFAULT '255' COMMENT '广告排序',
  PRIMARY KEY (`adv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分享秀广告表';

/*Data for the table `feiwa_micro_adv` */

/*Table structure for table `feiwa_micro_comment` */

DROP TABLE IF EXISTS `feiwa_micro_comment`;

CREATE TABLE `feiwa_micro_comment` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '评论编号',
  `comment_type` tinyint(1) NOT NULL COMMENT '评论类型编号',
  `comment_object_id` int(10) unsigned NOT NULL COMMENT '推荐商品编号',
  `comment_message` varchar(255) NOT NULL DEFAULT '' COMMENT '评论内容',
  `comment_member_id` int(10) unsigned NOT NULL COMMENT '评论人编号',
  `comment_time` int(10) unsigned NOT NULL COMMENT '评论时间',
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='分享秀商品评论表';

/*Data for the table `feiwa_micro_comment` */

insert  into `feiwa_micro_comment`(`comment_id`,`comment_type`,`comment_object_id`,`comment_message`,`comment_member_id`,`comment_time`) values (1,2,4,'1234567890-',1043,1513665585),(2,2,4,':biggrin:',1043,1513665639),(3,2,4,'test:huffy:',1043,1515550390);

/*Table structure for table `feiwa_micro_goods` */

DROP TABLE IF EXISTS `feiwa_micro_goods`;

CREATE TABLE `feiwa_micro_goods` (
  `commend_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '推荐编号',
  `commend_member_id` int(10) unsigned NOT NULL COMMENT '推荐人用户编号',
  `commend_goods_id` int(10) unsigned NOT NULL COMMENT '推荐商品编号',
  `commend_goods_commonid` int(10) unsigned NOT NULL COMMENT '商品公共表id',
  `commend_goods_store_id` int(10) unsigned NOT NULL COMMENT '推荐商品店铺编号',
  `commend_goods_name` varchar(100) NOT NULL DEFAULT '' COMMENT '推荐商品名称',
  `commend_goods_price` decimal(11,2) NOT NULL COMMENT '推荐商品价格',
  `commend_goods_image` varchar(100) NOT NULL DEFAULT '' COMMENT '推荐商品图片',
  `commend_message` varchar(1000) NOT NULL DEFAULT '' COMMENT '推荐信息',
  `commend_time` int(10) unsigned NOT NULL COMMENT '推荐时间',
  `class_id` int(10) unsigned NOT NULL,
  `like_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '喜欢数',
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `click_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点击数',
  `microshop_commend` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '首页推荐 0-否 1-推荐',
  `microshop_sort` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  `shareshow_commend` varchar(255) DEFAULT NULL,
  `shareshow_sort` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`commend_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='分享秀推荐商品表随心看';

/*Data for the table `feiwa_micro_goods` */

insert  into `feiwa_micro_goods`(`commend_id`,`commend_member_id`,`commend_goods_id`,`commend_goods_commonid`,`commend_goods_store_id`,`commend_goods_name`,`commend_goods_price`,`commend_goods_image`,`commend_message`,`commend_time`,`class_id`,`like_count`,`comment_count`,`click_count`,`microshop_commend`,`microshop_sort`,`shareshow_commend`,`shareshow_sort`) values (1,1043,100187,100127,6,'天然海藻面膜','18.00','6_05640797074821655.jpg','aaaa',1511508826,2,0,0,3,0,255,'0','255'),(2,1043,100186,100126,6,'樱花保湿嫩肤水500ml','89.00','6_05640796519363861.jpg','随心看2',1511508880,2,0,0,4,0,255,'1','255');

/*Table structure for table `feiwa_micro_goods_class` */

DROP TABLE IF EXISTS `feiwa_micro_goods_class`;

CREATE TABLE `feiwa_micro_goods_class` (
  `class_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类编号 ',
  `class_name` varchar(50) NOT NULL DEFAULT '' COMMENT '分类名称',
  `class_parent_id` int(11) unsigned DEFAULT '0' COMMENT '父级分类编号',
  `class_sort` tinyint(4) unsigned NOT NULL COMMENT '排序',
  `class_keyword` varchar(500) DEFAULT '' COMMENT '分类关键字',
  `class_image` varchar(100) DEFAULT '' COMMENT '分类图片',
  `class_commend` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '推荐标志0-不推荐 1-推荐到首页',
  `class_default` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '默认标志，0-非默认 1-默认',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='分享秀商品随心看分类表';

/*Data for the table `feiwa_micro_goods_class` */

insert  into `feiwa_micro_goods_class`(`class_id`,`class_name`,`class_parent_id`,`class_sort`,`class_keyword`,`class_image`,`class_commend`,`class_default`) values (1,'心看',0,255,'','',1,0),(2,'心看aa',1,255,'分类关键字','',0,1);

/*Table structure for table `feiwa_micro_goods_relation` */

DROP TABLE IF EXISTS `feiwa_micro_goods_relation`;

CREATE TABLE `feiwa_micro_goods_relation` (
  `relation_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '关系编号',
  `class_id` int(10) unsigned NOT NULL COMMENT '分享秀商品分类编号',
  `shop_class_id` int(10) unsigned NOT NULL COMMENT '商城商品分类编号',
  `mall_class_id` int(10) unsigned NOT NULL COMMENT '商城商品分类编号',
  PRIMARY KEY (`relation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分享秀商品分类和商城商品分类对应关系';

/*Data for the table `feiwa_micro_goods_relation` */

/*Table structure for table `feiwa_micro_like` */

DROP TABLE IF EXISTS `feiwa_micro_like`;

CREATE TABLE `feiwa_micro_like` (
  `like_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '喜欢编号',
  `like_type` tinyint(1) NOT NULL COMMENT '喜欢类型编号',
  `like_object_id` int(10) unsigned NOT NULL COMMENT '喜欢对象编号',
  `like_member_id` int(10) unsigned NOT NULL COMMENT '喜欢人编号',
  `like_time` int(10) unsigned NOT NULL COMMENT '喜欢时间',
  PRIMARY KEY (`like_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='分享秀喜欢表';

/*Data for the table `feiwa_micro_like` */

insert  into `feiwa_micro_like`(`like_id`,`like_type`,`like_object_id`,`like_member_id`,`like_time`) values (3,4,4,1043,1510895998);

/*Table structure for table `feiwa_micro_member_info` */

DROP TABLE IF EXISTS `feiwa_micro_member_info`;

CREATE TABLE `feiwa_micro_member_info` (
  `member_id` int(11) unsigned NOT NULL COMMENT '用户编号',
  `visit_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '个人中心访问计数',
  `personal_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '已发布个人秀数量',
  `goods_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '已发布随心看数量',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分享秀用户信息表';

/*Data for the table `feiwa_micro_member_info` */

insert  into `feiwa_micro_member_info`(`member_id`,`visit_count`,`personal_count`,`goods_count`) values (1041,7,1,0),(1043,36,2,2);

/*Table structure for table `feiwa_micro_personal` */

DROP TABLE IF EXISTS `feiwa_micro_personal`;

CREATE TABLE `feiwa_micro_personal` (
  `personal_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '推荐编号',
  `commend_member_id` int(10) unsigned NOT NULL COMMENT '推荐人用户编号',
  `commend_image` text NOT NULL COMMENT '推荐图片',
  `commend_buy` text NOT NULL COMMENT '购买信息',
  `commend_message` varchar(1000) NOT NULL DEFAULT '' COMMENT '推荐信息',
  `commend_time` int(10) unsigned NOT NULL COMMENT '推荐时间',
  `class_id` int(10) unsigned NOT NULL,
  `like_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '喜欢数',
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `click_count` int(10) unsigned NOT NULL DEFAULT '0',
  `shareshow_commend` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '首页推荐 0-否 1-推荐',
  `shareshow_sort` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  PRIMARY KEY (`personal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='分享秀个人秀表';

/*Data for the table `feiwa_micro_personal` */

insert  into `feiwa_micro_personal`(`personal_id`,`commend_member_id`,`commend_image`,`commend_buy`,`commend_message`,`commend_time`,`class_id`,`like_count`,`comment_count`,`click_count`,`shareshow_commend`,`shareshow_sort`) values (4,1043,'05642566514641445.jpg','a:0:{}','我的搭配还不错吧^-^',1510912653,1,0,3,16,1,255),(5,1041,'05648527426455905.png','a:0:{}','我的个人秀zx',1511508750,1,0,0,1,0,255),(6,1043,'05670109266250647.jpg','a:0:{}','我的搭配还不错吧^-^',1513666929,1,0,0,4,0,255);

/*Table structure for table `feiwa_micro_personal_class` */

DROP TABLE IF EXISTS `feiwa_micro_personal_class`;

CREATE TABLE `feiwa_micro_personal_class` (
  `class_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类编号 ',
  `class_name` varchar(50) NOT NULL DEFAULT '' COMMENT '分类名称',
  `class_sort` tinyint(4) unsigned NOT NULL COMMENT '排序',
  `class_image` varchar(100) DEFAULT '' COMMENT '分类图片',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='分享秀个人秀分类表';

/*Data for the table `feiwa_micro_personal_class` */

insert  into `feiwa_micro_personal_class`(`class_id`,`class_name`,`class_sort`,`class_image`) values (1,'个人秀adminy',1,'');

/*Table structure for table `feiwa_micro_store` */

DROP TABLE IF EXISTS `feiwa_micro_store`;

CREATE TABLE `feiwa_micro_store` (
  `shareshow_store_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '店铺街店铺编号',
  `mall_store_id` int(11) unsigned NOT NULL COMMENT '商城店铺编号',
  `shareshow_sort` tinyint(1) unsigned DEFAULT '255' COMMENT '排序',
  `shareshow_commend` tinyint(1) unsigned DEFAULT '1' COMMENT '推荐首页标志 1-正常 2-推荐',
  `like_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '喜欢数',
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `click_count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`shareshow_store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='分享秀店铺街表';

/*Data for the table `feiwa_micro_store` */

insert  into `feiwa_micro_store`(`shareshow_store_id`,`mall_store_id`,`shareshow_sort`,`shareshow_commend`,`like_count`,`comment_count`,`click_count`) values (4,6,255,0,1,0,1);

/*Table structure for table `feiwa_navigation` */

DROP TABLE IF EXISTS `feiwa_navigation`;

CREATE TABLE `feiwa_navigation` (
  `nav_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引ID',
  `nav_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类别，0自定义导航，1商品分类，2文章导航，3活动导航，默认为0',
  `nav_title` varchar(100) DEFAULT NULL COMMENT '导航标题',
  `nav_url` varchar(255) DEFAULT NULL COMMENT '导航链接',
  `nav_location` tinyint(1) NOT NULL DEFAULT '0' COMMENT '导航位置，0头部，1中部，2底部，默认为0',
  `nav_new_open` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否以新窗口打开，0为否，1为是，默认为0',
  `nav_sort` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  `item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '类别ID，对应着nav_type中的内容，默认为0',
  PRIMARY KEY (`nav_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='页面导航表';

/*Data for the table `feiwa_navigation` */

insert  into `feiwa_navigation`(`nav_id`,`nav_type`,`nav_title`,`nav_url`,`nav_location`,`nav_new_open`,`nav_sort`,`item_id`) values (6,0,'关于我们','http://malltest.mywopop.com/member/index.php?app=article&article_id=22',2,0,255,0),(7,0,'联系我们','http://malltest.mywopop.com/member/index.php?app=article&article_id=23',2,0,240,0),(8,0,'合作及洽谈','http://malltest.mywopop.com/member/index.php?app=article&article_id=25',2,0,220,0),(9,0,'招聘英才','http://malltest.mywopop.com/member/index.php?app=article&article_id=24',2,0,210,0),(11,0,'商家管理','http://malltest.mywopop.com/mall/index.php?app=seller_login',2,0,255,0),(12,0,'门店管理','http://malltest.mywopop.com/chain/index.php?app=login',2,0,255,0),(13,0,'自提站管理','http://malltest.mywopop.com/delivery/index.php?app=login',2,0,255,0),(15,0,'信息反馈','http://malltest.mywopop.com/mall/index.php?app=member_feedback&amp;ops=add',2,1,255,0);

/*Table structure for table `feiwa_offpay_area` */

DROP TABLE IF EXISTS `feiwa_offpay_area`;

CREATE TABLE `feiwa_offpay_area` (
  `store_id` int(8) unsigned NOT NULL COMMENT '商家ID',
  `area_id` text COMMENT '县ID组合',
  PRIMARY KEY (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='货到付款支持地区表';

/*Data for the table `feiwa_offpay_area` */

/*Table structure for table `feiwa_order_bill` */

DROP TABLE IF EXISTS `feiwa_order_bill`;

CREATE TABLE `feiwa_order_bill` (
  `ob_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID作为新结算单编号',
  `ob_no` int(11) DEFAULT '0' COMMENT '结算单编号(年月店铺ID)',
  `ob_start_date` int(11) NOT NULL COMMENT '开始日期',
  `ob_end_date` int(11) NOT NULL COMMENT '结束日期',
  `ob_order_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单金额',
  `ob_shipping_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '运费',
  `ob_order_return_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '退单金额',
  `ob_commis_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '佣金金额',
  `ob_commis_return_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '退还佣金',
  `ob_store_cost_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '店铺促销活动费用',
  `ob_result_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '应结金额',
  `ob_create_date` int(11) DEFAULT '0' COMMENT '生成结算单日期',
  `os_month` mediumint(6) unsigned DEFAULT NULL COMMENT '出账单应结时间,ob_end_date+1所在月(年月份)',
  `ob_state` enum('1','2','3','4') DEFAULT '1' COMMENT '1默认2店家已确认3平台已审核4结算完成',
  `ob_pay_date` int(11) DEFAULT '0' COMMENT '付款日期',
  `ob_pay_content` varchar(200) DEFAULT '' COMMENT '支付备注',
  `ob_store_id` int(11) NOT NULL COMMENT '店铺ID',
  `ob_store_name` varchar(50) DEFAULT NULL COMMENT '店铺名',
  `ob_order_book_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '被关闭的预定订单的实收总金额',
  `ob_rpt_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '下单时使用的红包值',
  `ob_rf_rpt_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '全部退款时红包值',
  PRIMARY KEY (`ob_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='结算表';

/*Data for the table `feiwa_order_bill` */

/*Table structure for table `feiwa_order_book` */

DROP TABLE IF EXISTS `feiwa_order_book`;

CREATE TABLE `feiwa_order_book` (
  `book_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `book_order_id` int(11) DEFAULT NULL COMMENT '订单ID',
  `book_step` tinyint(4) DEFAULT NULL COMMENT '预定时段,值为1 or 2,0为不分时段，全款支付',
  `book_amount` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '定金or尾款金额',
  `book_pd_amount` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '预存款支付金额',
  `book_rcb_amount` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '充值卡支付金额',
  `book_pay_name` varchar(10) DEFAULT NULL COMMENT '支付方式(文字)',
  `book_trade_no` varchar(40) DEFAULT NULL COMMENT '第三方平台交易号',
  `book_pay_time` int(11) DEFAULT '0' COMMENT '支付时间',
  `book_end_time` int(11) DEFAULT '0' COMMENT '时段1:订单自动取消时间,时段2:时段结束时间',
  `book_buyer_phone` bigint(20) DEFAULT NULL COMMENT '买家接收尾款交款通知的手机,只在第2时段有值即可',
  `book_deposit_amount` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '定金金额,只在全款支付时有值即可',
  `book_pay_notice` tinyint(4) DEFAULT '0' COMMENT '0未通知1已通知,该字段只对尾款时段有效',
  `book_real_pay` decimal(10,2) DEFAULT '0.00' COMMENT '订单被取消后最终支付金额（平台收款金额）',
  `book_cancel_time` int(11) DEFAULT '0' COMMENT '订单被取消时间,结算用,只有book_step是0或1时有值',
  `book_store_id` int(11) DEFAULT '0' COMMENT '商家 ID,只有book_step是0或1时有值即可',
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预定订单时段详细内容表';

/*Data for the table `feiwa_order_book` */

/*Table structure for table `feiwa_order_common` */

DROP TABLE IF EXISTS `feiwa_order_common`;

CREATE TABLE `feiwa_order_common` (
  `order_id` int(11) NOT NULL COMMENT '订单索引id',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺ID',
  `shipping_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '配送时间',
  `shipping_express_id` tinyint(1) NOT NULL DEFAULT '0' COMMENT '配送公司ID',
  `evaluation_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价时间',
  `evalseller_time` int(10) unsigned DEFAULT NULL COMMENT '卖家评价买家的时间',
  `order_message` varchar(300) DEFAULT NULL COMMENT '订单留言',
  `order_pointscount` int(11) NOT NULL DEFAULT '0' COMMENT '订单赠送积分',
  `voucher_price` int(11) DEFAULT NULL COMMENT '代金券面额',
  `voucher_code` varchar(32) DEFAULT NULL COMMENT '代金券编码',
  `deliver_explain` text COMMENT '发货备注',
  `daddress_id` mediumint(9) NOT NULL DEFAULT '0' COMMENT '发货地址ID',
  `reciver_name` varchar(50) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `reciver_info` varchar(500) NOT NULL DEFAULT '' COMMENT '收货人其它信息',
  `reciver_province_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '收货人省级ID',
  `reciver_city_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '收货人市级ID',
  `invoice_info` varchar(500) DEFAULT '' COMMENT '发票信息',
  `promotion_info` varchar(800) DEFAULT '' COMMENT '促销信息备注',
  `dlyo_pickup_code` varchar(6) DEFAULT NULL COMMENT '提货码',
  `promotion_total` decimal(10,2) DEFAULT '0.00' COMMENT '订单总优惠金额（代金券，满减，平台红包）',
  `discount` tinyint(4) DEFAULT '0' COMMENT '会员折扣x%',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单信息扩展表';

/*Data for the table `feiwa_order_common` */

insert  into `feiwa_order_common`(`order_id`,`store_id`,`shipping_time`,`shipping_express_id`,`evaluation_time`,`evalseller_time`,`order_message`,`order_pointscount`,`voucher_price`,`voucher_code`,`deliver_explain`,`daddress_id`,`reciver_name`,`reciver_info`,`reciver_province_id`,`reciver_city_id`,`invoice_info`,`promotion_info`,`dlyo_pickup_code`,`promotion_total`,`discount`) values (1,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'sh','a:6:{s:5:\"phone\";s:21:\"13561113346,123456778\";s:9:\"mob_phone\";s:11:\"13561113346\";s:9:\"tel_phone\";s:9:\"123456778\";s:7:\"address\";s:29:\"上海 上海市 黄浦区 sh\";s:4:\"area\";s:26:\"上海 上海市 黄浦区\";s:6:\"street\";s:2:\"sh\";}',0,39,'a:0:{}','',NULL,'0.00',0),(2,6,1510905496,0,1510911880,NULL,'',4,NULL,NULL,'',0,'sh','a:7:{s:7:\"address\";s:29:\"上海 上海市 黄浦区 sh\";s:5:\"phone\";s:21:\"13561113346,123456778\";s:4:\"area\";s:26:\"上海 上海市 黄浦区\";s:6:\"street\";s:2:\"sh\";s:9:\"mob_phone\";s:11:\"13561113346\";s:9:\"tel_phone\";s:9:\"123456778\";s:4:\"dlyp\";s:0:\"\";}',0,39,'a:0:{}','',NULL,'0.00',0),(3,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'sh','a:6:{s:5:\"phone\";s:21:\"13561113346,123456778\";s:9:\"mob_phone\";s:11:\"13561113346\";s:9:\"tel_phone\";s:9:\"123456778\";s:7:\"address\";s:29:\"上海 上海市 黄浦区 sh\";s:4:\"area\";s:26:\"上海 上海市 黄浦区\";s:6:\"street\";s:2:\"sh\";}',0,39,'a:0:{}','',NULL,'0.00',0),(4,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'gyn','a:6:{s:5:\"phone\";s:25:\"13888888888,0571-85024138\";s:9:\"mob_phone\";s:11:\"13888888888\";s:9:\"tel_phone\";s:13:\"0571-85024138\";s:7:\"address\";s:41:\"浙江 杭州市 上城区 hzhzhzhzhzhzhz\";s:4:\"area\";s:26:\"浙江 杭州市 上城区\";s:6:\"street\";s:14:\"hzhzhzhzhzhzhz\";}',0,175,'a:0:{}','',NULL,'0.00',0),(5,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'gyn','a:6:{s:5:\"phone\";s:25:\"13888888888,0571-85024138\";s:9:\"mob_phone\";s:11:\"13888888888\";s:9:\"tel_phone\";s:13:\"0571-85024138\";s:7:\"address\";s:41:\"浙江 杭州市 上城区 hzhzhzhzhzhzhz\";s:4:\"area\";s:26:\"浙江 杭州市 上城区\";s:6:\"street\";s:14:\"hzhzhzhzhzhzhz\";}',0,175,'a:0:{}','',NULL,'0.00',0),(6,6,1525747989,0,0,NULL,'',0,NULL,NULL,'',0,'gyn','a:7:{s:7:\"address\";s:41:\"浙江 杭州市 上城区 hzhzhzhzhzhzhz\";s:5:\"phone\";s:25:\"13888888888,0571-85024138\";s:4:\"area\";s:26:\"浙江 杭州市 上城区\";s:6:\"street\";s:14:\"hzhzhzhzhzhzhz\";s:9:\"mob_phone\";s:11:\"13888888888\";s:9:\"tel_phone\";s:13:\"0571-85024138\";s:4:\"dlyp\";s:0:\"\";}',0,175,'a:0:{}','',NULL,'0.00',0),(7,6,1525748321,0,0,NULL,'',0,NULL,NULL,'',0,'gyn','a:7:{s:7:\"address\";s:41:\"浙江 杭州市 上城区 hzhzhzhzhzhzhz\";s:5:\"phone\";s:25:\"13888888888,0571-85024138\";s:4:\"area\";s:26:\"浙江 杭州市 上城区\";s:6:\"street\";s:14:\"hzhzhzhzhzhzhz\";s:9:\"mob_phone\";s:11:\"13888888888\";s:9:\"tel_phone\";s:13:\"0571-85024138\";s:4:\"dlyp\";s:0:\"\";}',0,175,'a:0:{}','',NULL,'0.00',0),(8,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'gyn','a:6:{s:5:\"phone\";s:25:\"13888888888,0571-85024138\";s:9:\"mob_phone\";s:11:\"13888888888\";s:9:\"tel_phone\";s:13:\"0571-85024138\";s:7:\"address\";s:41:\"浙江 杭州市 上城区 hzhzhzhzhzhzhz\";s:4:\"area\";s:26:\"浙江 杭州市 上城区\";s:6:\"street\";s:14:\"hzhzhzhzhzhzhz\";}',0,175,'a:0:{}','',NULL,'0.00',0),(9,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'gyn','a:6:{s:5:\"phone\";s:25:\"13888888888,0571-85024138\";s:9:\"mob_phone\";s:11:\"13888888888\";s:9:\"tel_phone\";s:13:\"0571-85024138\";s:7:\"address\";s:41:\"浙江 杭州市 上城区 hzhzhzhzhzhzhz\";s:4:\"area\";s:26:\"浙江 杭州市 上城区\";s:6:\"street\";s:14:\"hzhzhzhzhzhzhz\";}',0,175,'a:0:{}','',NULL,'0.00',0),(10,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'gyn','a:6:{s:5:\"phone\";s:25:\"13888888888,0571-85024138\";s:9:\"mob_phone\";s:11:\"13888888888\";s:9:\"tel_phone\";s:13:\"0571-85024138\";s:7:\"address\";s:41:\"浙江 杭州市 上城区 hzhzhzhzhzhzhz\";s:4:\"area\";s:26:\"浙江 杭州市 上城区\";s:6:\"street\";s:14:\"hzhzhzhzhzhzhz\";}',0,175,'a:0:{}','',NULL,'0.00',0),(11,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'gyn','a:6:{s:5:\"phone\";s:25:\"13888888888,0571-85024138\";s:9:\"mob_phone\";s:11:\"13888888888\";s:9:\"tel_phone\";s:13:\"0571-85024138\";s:7:\"address\";s:41:\"浙江 杭州市 上城区 hzhzhzhzhzhzhz\";s:4:\"area\";s:26:\"浙江 杭州市 上城区\";s:6:\"street\";s:14:\"hzhzhzhzhzhzhz\";}',0,175,'a:0:{}','',NULL,'0.00',0),(12,11,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'gyn','a:6:{s:5:\"phone\";s:25:\"13888888888,0571-85024138\";s:9:\"mob_phone\";s:11:\"13888888888\";s:9:\"tel_phone\";s:13:\"0571-85024138\";s:7:\"address\";s:41:\"浙江 杭州市 上城区 hzhzhzhzhzhzhz\";s:4:\"area\";s:26:\"浙江 杭州市 上城区\";s:6:\"street\";s:14:\"hzhzhzhzhzhzhz\";}',0,175,'a:0:{}','',NULL,'0.00',0),(13,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'王总','a:6:{s:5:\"phone\";s:11:\"17691164888\";s:9:\"mob_phone\";s:11:\"17691164888\";s:9:\"tel_phone\";s:0:\"\";s:7:\"address\";s:66:\"陕西 西安市 灞桥区 国际港务区澜博跨境购物中心\";s:4:\"area\";s:26:\"陕西 西安市 灞桥区\";s:6:\"street\";s:39:\"国际港务区澜博跨境购物中心\";}',0,438,'a:0:{}','',NULL,'0.00',0),(14,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'gyn','a:6:{s:5:\"phone\";s:25:\"13888888888,0571-85024138\";s:9:\"mob_phone\";s:11:\"13888888888\";s:9:\"tel_phone\";s:13:\"0571-85024138\";s:7:\"address\";s:41:\"浙江 杭州市 上城区 hzhzhzhzhzhzhz\";s:4:\"area\";s:26:\"浙江 杭州市 上城区\";s:6:\"street\";s:14:\"hzhzhzhzhzhzhz\";}',0,175,'a:0:{}','',NULL,'0.00',0),(15,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'admin111','a:6:{s:5:\"phone\";s:11:\"13800000000\";s:9:\"mob_phone\";s:11:\"13800000000\";s:9:\"tel_phone\";s:0:\"\";s:7:\"address\";s:33:\"北京 北京市 东城区 测试\";s:4:\"area\";s:26:\"北京 北京市 东城区\";s:6:\"street\";s:6:\"测试\";}',0,36,'a:0:{}','',NULL,'0.00',0),(16,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'gyn','a:6:{s:5:\"phone\";s:25:\"13888888888,0571-85024138\";s:9:\"mob_phone\";s:11:\"13888888888\";s:9:\"tel_phone\";s:13:\"0571-85024138\";s:7:\"address\";s:41:\"浙江 杭州市 上城区 hzhzhzhzhzhzhz\";s:4:\"area\";s:26:\"浙江 杭州市 上城区\";s:6:\"street\";s:14:\"hzhzhzhzhzhzhz\";}',0,175,'a:0:{}','',NULL,'0.00',0),(17,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'Yang Yuqiang','a:6:{s:5:\"phone\";s:23:\"12312341234,135*8*8*9*6\";s:9:\"mob_phone\";s:11:\"12312341234\";s:9:\"tel_phone\";s:11:\"135*8*8*9*6\";s:7:\"address\";s:39:\"广东 深圳市 宝安区 西乡街道\";s:4:\"area\";s:26:\"广东 深圳市 宝安区\";s:6:\"street\";s:12:\"西乡街道\";}',0,291,'a:0:{}','',NULL,'0.00',0),(18,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'iuser_aaa','a:6:{s:5:\"phone\";s:11:\"17091902132\";s:9:\"mob_phone\";s:11:\"17091902132\";s:9:\"tel_phone\";N;s:7:\"address\";s:36:\"上海 上海市 卢湾区 海淀路\";s:4:\"area\";s:26:\"上海 上海市 卢湾区\";s:6:\"street\";s:9:\"海淀路\";}',0,39,'a:0:{}','',NULL,'0.00',0),(19,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'iuser_aaa','a:6:{s:5:\"phone\";s:11:\"17091902132\";s:9:\"mob_phone\";s:11:\"17091902132\";s:9:\"tel_phone\";N;s:7:\"address\";s:36:\"上海 上海市 卢湾区 海淀路\";s:4:\"area\";s:26:\"上海 上海市 卢湾区\";s:6:\"street\";s:9:\"海淀路\";}',0,39,'a:0:{}','',NULL,'0.00',0),(20,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'iuser_aaa','a:6:{s:5:\"phone\";s:11:\"17091902132\";s:9:\"mob_phone\";s:11:\"17091902132\";s:9:\"tel_phone\";N;s:7:\"address\";s:36:\"上海 上海市 卢湾区 海淀路\";s:4:\"area\";s:26:\"上海 上海市 卢湾区\";s:6:\"street\";s:9:\"海淀路\";}',0,39,'a:0:{}','',NULL,'0.00',0),(21,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'iuser_aaa','a:6:{s:5:\"phone\";s:11:\"17091902132\";s:9:\"mob_phone\";s:11:\"17091902132\";s:9:\"tel_phone\";N;s:7:\"address\";s:36:\"上海 上海市 卢湾区 海淀路\";s:4:\"area\";s:26:\"上海 上海市 卢湾区\";s:6:\"street\";s:9:\"海淀路\";}',0,39,'a:0:{}','',NULL,'0.00',0),(22,6,0,0,0,NULL,'',0,NULL,NULL,NULL,0,'iuser_aaa','a:6:{s:5:\"phone\";s:11:\"17091902132\";s:9:\"mob_phone\";s:11:\"17091902132\";s:9:\"tel_phone\";N;s:7:\"address\";s:36:\"上海 上海市 卢湾区 海淀路\";s:4:\"area\";s:26:\"上海 上海市 卢湾区\";s:6:\"street\";s:9:\"海淀路\";}',0,39,'a:0:{}','',NULL,'0.00',0),(23,6,1536138237,29,0,NULL,'',15,NULL,NULL,'发货iuser_aaa',1,'iuser_aaa','a:7:{s:7:\"address\";s:36:\"上海 上海市 卢湾区 海淀路\";s:5:\"phone\";s:11:\"17091902132\";s:4:\"area\";s:26:\"上海 上海市 卢湾区\";s:6:\"street\";s:9:\"海淀路\";s:9:\"mob_phone\";s:11:\"17091902132\";s:9:\"tel_phone\";s:0:\"\";s:4:\"dlyp\";s:0:\"\";}',0,39,'a:0:{}','',NULL,'0.00',0);

/*Table structure for table `feiwa_order_goods` */

DROP TABLE IF EXISTS `feiwa_order_goods`;

CREATE TABLE `feiwa_order_goods` (
  `rec_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单商品表索引id',
  `order_id` int(11) NOT NULL COMMENT '订单id',
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  `goods_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_price` decimal(10,2) NOT NULL COMMENT '商品价格',
  `goods_num` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT '商品数量',
  `goods_image` varchar(100) DEFAULT NULL COMMENT '商品图片',
  `goods_pay_price` decimal(10,2) unsigned NOT NULL COMMENT '商品实际成交价',
  `store_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `buyer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '买家ID',
  `goods_type` char(1) NOT NULL DEFAULT '1' COMMENT '1默认2团购商品3限时折扣商品4组合套装5赠品8加价购活动商品9加价购换购商品',
  `promotions_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '促销活动ID（团购ID/限时折扣ID/优惠套装ID）与goods_type搭配使用',
  `commis_rate` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '佣金比例',
  `gc_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品最底级分类ID',
  `goods_spec` varchar(255) DEFAULT NULL COMMENT '商品规格',
  `goods_contractid` varchar(100) DEFAULT NULL COMMENT '商品开启的消费者保障服务id',
  `invite_rates` smallint(5) DEFAULT '0' COMMENT '分销佣金',
  PRIMARY KEY (`rec_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='订单商品表';

/*Data for the table `feiwa_order_goods` */

insert  into `feiwa_order_goods`(`rec_id`,`order_id`,`goods_id`,`goods_name`,`goods_price`,`goods_num`,`goods_image`,`goods_pay_price`,`store_id`,`buyer_id`,`goods_type`,`promotions_id`,`commis_rate`,`gc_id`,`goods_spec`,`goods_contractid`,`invite_rates`) values (1,1,100221,'运动摄像机','6000.00',1,'6_05641607118761159.jpg','6000.00',6,1043,'1',0,200,276,NULL,'',0),(2,2,100186,'樱花保湿嫩肤水500ml','89.00',1,'6_05640796519363861.jpg','89.00',6,1043,'1',0,200,479,NULL,'',0),(3,3,100187,'天然海藻面膜','18.00',1,'6_05640797074821655.jpg','18.00',6,1043,'1',0,200,486,NULL,'',0),(4,4,100186,'樱花保湿嫩肤水500ml','89.00',1,'6_05640796519363861.jpg','89.00',6,1043,'1',0,200,479,NULL,'',0),(5,5,100168,'女性音乐手机','2100.00',2,'6_05640696533875501.jpg','4200.00',6,1043,'1',0,200,1035,NULL,'',0),(6,5,100167,'儿童智能手机','1500.00',4,'6_05640695864902071.jpg','6000.00',6,1043,'1',0,200,1035,NULL,'',0),(7,6,100168,'女性音乐手机','2100.00',1,'6_05640696533875501.jpg','2100.00',6,1043,'1',0,200,1035,NULL,'',0),(8,7,100196,'男款满版印花针织棒球','709.00',1,'6_05641550053590931.jpg','709.00',6,1043,'1',0,200,671,NULL,'',0),(9,7,100199,'户外休闲鞋厚底运动鞋','229.00',1,'6_05641551995810917.jpg','229.00',6,1043,'1',0,200,672,NULL,'',0),(10,8,100167,'儿童智能手机','1500.00',1,'6_05640695864902071.jpg','1500.00',6,1043,'1',0,200,1035,NULL,'',0),(11,9,100164,'智能音乐手机','1500.00',1,'6_05640694365288450.jpg','1500.00',6,1043,'1',0,200,1035,NULL,'',0),(12,10,100168,'女性音乐手机','2100.00',1,'6_05640696533875501.jpg','2100.00',6,1043,'1',0,200,1035,NULL,'',0),(13,11,100168,'女性音乐手机','2100.00',1,'6_05640696533875501.jpg','2100.00',6,1043,'1',0,200,1035,NULL,'',0),(14,12,100227,'123','50.00',1,'11_05690970455241560.jpg','50.00',11,1043,'1',0,200,12,NULL,'',0),(15,13,100165,'双摄像头手机','1800.00',1,'6_05640695266621049.jpg','1800.00',6,1057,'1',0,200,1035,NULL,'',0),(16,14,100165,'双摄像头手机','1800.00',1,'6_05640695266621049.jpg','1800.00',6,1043,'1',0,200,1035,NULL,'',0),(17,15,100165,'双摄像头手机','1800.00',1,'6_05640695266621049.jpg','1800.00',6,1055,'1',0,200,1035,NULL,'',0),(18,16,100165,'双摄像头手机','1800.00',1,'6_05640695266621049.jpg','1800.00',6,1043,'1',0,200,1035,NULL,'',0),(19,17,100195,'多功能专业家用电烤箱 38升','400.00',1,'6_05641442090378971.jpg','400.00',6,1043,'1',0,200,340,NULL,'',0),(20,18,100242,'亨氏 (Heinz) 宝宝零食 婴儿肉泥 安心肉泥套餐—优惠套装E','300.00',1,'6_05791013859287600.jpg','300.00',6,1067,'1',0,200,478,NULL,'',0),(21,19,100242,'亨氏 (Heinz) 宝宝零食 婴儿肉泥 安心肉泥套餐—优惠套装E','300.00',1,'6_05791013859287600.jpg','300.00',6,1067,'1',0,200,478,NULL,'',0),(22,20,100242,'亨氏 (Heinz) 宝宝零食 婴儿肉泥 安心肉泥套餐—优惠套装E','300.00',1,'6_05791013859287600.jpg','300.00',6,1067,'1',0,200,478,NULL,'',0),(23,21,100242,'亨氏 (Heinz) 宝宝零食 婴儿肉泥 安心肉泥套餐—优惠套装E','300.00',1,'6_05791013859287600.jpg','300.00',6,1067,'1',0,200,478,NULL,'',0),(24,22,100242,'亨氏 (Heinz) 宝宝零食 婴儿肉泥 安心肉泥套餐—优惠套装E','300.00',1,'6_05791013859287600.jpg','300.00',6,1067,'1',0,200,478,NULL,'',0),(25,23,100242,'亨氏 (Heinz) 宝宝零食 婴儿肉泥 安心肉泥套餐—优惠套装E','300.00',1,'6_05791013859287600.jpg','300.00',6,1067,'1',0,200,478,NULL,'',0);

/*Table structure for table `feiwa_order_log` */

DROP TABLE IF EXISTS `feiwa_order_log`;

CREATE TABLE `feiwa_order_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` int(11) NOT NULL COMMENT '订单id',
  `log_msg` varchar(150) DEFAULT '' COMMENT '文字描述',
  `log_time` int(10) unsigned NOT NULL COMMENT '处理时间',
  `log_role` varchar(10) NOT NULL DEFAULT '' COMMENT '操作角色',
  `log_user` varchar(30) DEFAULT '' COMMENT '操作人',
  `log_orderstate` enum('0','10','20','30','40') DEFAULT NULL COMMENT '订单状态：0(已取消)10:未付款;20:已付款;30:已发货;40:已收货;',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8 COMMENT='订单处理历史表';

/*Data for the table `feiwa_order_log` */

insert  into `feiwa_order_log`(`log_id`,`order_id`,`log_msg`,`log_time`,`log_role`,`log_user`,`log_orderstate`) values (108,1,'生成订单',1510885289,'买家','adminy','10'),(109,2,'生成订单',1510890313,'买家','adminy','10'),(110,1,'取消了订单 ( 改买其他商品 )',1510890599,'买家','adminy','0'),(111,2,'支付订单',1510890628,'买家','','20'),(112,3,'生成订单',1510890674,'买家','adminy','10'),(113,2,'发出货物(编辑信息)',1510905496,'商家','zxx2cndns','30'),(114,2,'签收了货物',1510911808,'买家','adminy','40'),(115,2,'评价交易',1510911880,'买家','',NULL),(116,4,'生成订单',1513753149,'买家','adminy','10'),(117,5,'生成订单',1515046922,'买家','adminy','10'),(118,6,'生成订单',1515550026,'买家','adminy','10'),(119,6,'支付订单',1515550264,'买家','','20'),(120,7,'生成订单',1515550903,'买家','adminy','10'),(121,7,'支付订单',1515550925,'买家','','20'),(122,5,'取消了订单 ( 改买其他商品 )',1515551118,'买家','adminy','0'),(123,8,'生成订单',1515553115,'买家','adminy','10'),(124,8,'取消了订单',1515574969,'管理员','adminy','0'),(125,4,'取消了订单',1516097832,'管理员','adminy','0'),(126,3,'取消了订单',1516355210,'管理员','adminy','0'),(127,9,'生成订单',1516954560,'买家','adminy','10'),(128,10,'生成订单',1517544098,'买家','adminy','10'),(129,11,'生成订单',1517545283,'买家','adminy','10'),(130,12,'生成订单',1517821658,'买家','adminy','10'),(131,13,'生成订单',1517900807,'买家','xiaozhai','10'),(132,14,'生成订单',1521176000,'买家','adminy','10'),(133,15,'生成订单',1522034116,'买家','admin111','10'),(134,16,'生成订单',1522640422,'买家','adminy','10'),(135,17,'生成订单',1523179649,'买家','adminy','10'),(136,6,'发出货物(编辑信息)',1525747989,'商家','zxx2cndns','30'),(137,7,'发出货物(编辑信息)',1525748321,'商家','zxx2cndns','30'),(138,10,'修改了价格( 2100.00 )',1525748386,'商家','zxx1cndns','10'),(139,10,'支付订单',1525748437,'买家','','20'),(140,11,'支付订单',1525748471,'买家','','20'),(141,17,'取消了订单 ( 无法备齐货物 )',1525766104,'商家','zxx2cndns','0'),(142,18,'生成订单',1536137496,'买家','iuser_aaa','10'),(143,19,'生成订单',1536137503,'买家','iuser_aaa','10'),(144,20,'生成订单',1536137653,'买家','iuser_aaa','10'),(145,21,'生成订单',1536137703,'买家','iuser_aaa','10'),(146,22,'生成订单',1536137737,'买家','iuser_aaa','10'),(147,23,'生成订单',1536137776,'买家','iuser_aaa','10'),(148,23,'发出货物(编辑信息)',1536138237,'商家','zxx2cndns','30'),(149,23,'签收了货物',1536138314,'买家','iuser_aaa','40');

/*Table structure for table `feiwa_order_pay` */

DROP TABLE IF EXISTS `feiwa_order_pay`;

CREATE TABLE `feiwa_order_pay` (
  `pay_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pay_sn` bigint(20) unsigned NOT NULL COMMENT '支付单号',
  `buyer_id` int(10) unsigned NOT NULL COMMENT '买家ID',
  `api_pay_state` enum('0','1') DEFAULT '0' COMMENT '0默认未支付1已支付(只有第三方支付接口通知到时才会更改此状态)',
  PRIMARY KEY (`pay_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='订单支付表';

/*Data for the table `feiwa_order_pay` */

insert  into `feiwa_order_pay`(`pay_id`,`pay_sn`,`buyer_id`,`api_pay_state`) values (1,560564229290261043,1043,'0'),(2,810564234314769043,1043,'0'),(3,930564234675781043,1043,'0'),(4,210567097150278043,1043,'0'),(5,460568390922534043,1043,'0'),(6,910568894027087043,1043,'0'),(7,330568894904103043,1043,'0'),(8,230568897115371043,1043,'0'),(9,950570298560657043,1043,'0'),(10,640570888099456043,1043,'0'),(11,760570889283659043,1043,'0'),(12,680571165658358043,1043,'0'),(13,610571244807912057,1057,'0'),(14,600574520001045043,1043,'0'),(15,120575378116664055,1055,'0'),(16,420575984423614043,1043,'0'),(17,420576523649680043,1043,'0'),(18,880589481496891067,1067,'0'),(19,240589481503346067,1067,'0'),(20,880589481653819067,1067,'0'),(21,670589481703285067,1067,'0'),(22,480589481738020067,1067,'0'),(23,650589481776390067,1067,'0');

/*Table structure for table `feiwa_order_snapshot` */

DROP TABLE IF EXISTS `feiwa_order_snapshot`;

CREATE TABLE `feiwa_order_snapshot` (
  `rec_id` int(11) NOT NULL COMMENT '主键',
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `create_time` int(11) NOT NULL COMMENT '生成时间',
  `goods_attr` text COMMENT '属性',
  `goods_body` text COMMENT '详情',
  `plate_top` text COMMENT '顶部关联版式',
  `plate_bottom` text COMMENT '底部关联版式',
  PRIMARY KEY (`rec_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单快照表';

/*Data for the table `feiwa_order_snapshot` */

insert  into `feiwa_order_snapshot`(`rec_id`,`goods_id`,`create_time`,`goods_attr`,`goods_body`,`plate_top`,`plate_bottom`) values (1,100221,1510885290,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(2,100186,1510890314,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(3,100187,1510890675,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(4,100186,1513753150,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(5,100168,1515046923,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(6,100167,1515046923,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(7,100168,1515550027,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(8,100196,1515550904,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(9,100199,1515550904,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(10,100167,1515553115,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(11,100164,1516954561,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(12,100168,1517544101,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(13,100168,1517545284,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(14,100227,1517821659,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(15,100165,1517900808,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(16,100165,1521176001,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(17,100165,1522034117,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(18,100165,1522640424,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(19,100195,1523179650,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(20,100242,1536137497,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(21,100242,1536137503,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(22,100242,1536137654,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(23,100242,1536137703,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(24,100242,1536137738,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL),(25,100242,1536137776,'a:2:{s:6:\"货号\";s:0:\"\";s:6:\"品牌\";s:0:\"\";}','',NULL,NULL);

/*Table structure for table `feiwa_order_statis` */

DROP TABLE IF EXISTS `feiwa_order_statis`;

CREATE TABLE `feiwa_order_statis` (
  `os_month` mediumint(9) unsigned NOT NULL DEFAULT '0' COMMENT '统计编号(年月)',
  `os_year` smallint(6) DEFAULT '0' COMMENT '年',
  `os_start_date` int(11) NOT NULL COMMENT '开始日期',
  `os_end_date` int(11) NOT NULL COMMENT '结束日期',
  `os_order_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单金额',
  `os_shipping_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '运费',
  `os_order_return_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '退单金额',
  `os_commis_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '佣金金额',
  `os_commis_return_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '退还佣金',
  `os_store_cost_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '店铺促销活动费用',
  `os_result_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '本期应结',
  `os_create_date` int(11) DEFAULT NULL COMMENT '创建记录日期',
  `os_order_book_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '被关闭的预定订单的实收总金额',
  PRIMARY KEY (`os_month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='月销量统计表';

/*Data for the table `feiwa_order_statis` */

/*Table structure for table `feiwa_orders` */

DROP TABLE IF EXISTS `feiwa_orders`;

CREATE TABLE `feiwa_orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单索引id',
  `order_sn` bigint(20) unsigned NOT NULL COMMENT '订单编号',
  `pay_sn` bigint(20) unsigned NOT NULL COMMENT '支付单号',
  `store_id` int(11) unsigned NOT NULL COMMENT '卖家店铺id',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '卖家店铺名称',
  `buyer_id` int(11) unsigned NOT NULL COMMENT '买家id',
  `buyer_name` varchar(50) NOT NULL DEFAULT '' COMMENT '买家姓名',
  `buyer_email` varchar(80) DEFAULT NULL COMMENT '买家电子邮箱',
  `buyer_phone` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '买家手机',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单生成时间',
  `payment_code` char(10) NOT NULL DEFAULT '' COMMENT '支付方式名称代码',
  `payment_time` int(10) unsigned DEFAULT '0' COMMENT '支付(付款)时间',
  `finnshed_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单完成时间',
  `goods_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品总价格',
  `order_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单总价格',
  `rcb_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '充值卡支付金额',
  `pd_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '预存款支付金额',
  `shipping_fee` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '运费',
  `evaluation_state` tinyint(4) DEFAULT '0' COMMENT '评价状态 0未评价，1已评价，2已过期未评价',
  `evaluation_again_state` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '追加评价状态 0未评价，1已评价，2已过期未评价',
  `order_state` tinyint(4) NOT NULL DEFAULT '10' COMMENT '订单状态：0(已取消)10(默认):未付款;20:已付款;30:已发货;40:已收货;',
  `refund_state` tinyint(4) unsigned DEFAULT '0' COMMENT '退款状态:0是无退款,1是部分退款,2是全部退款',
  `lock_state` tinyint(4) unsigned DEFAULT '0' COMMENT '锁定状态:0是正常,大于0是锁定,默认是0',
  `delete_state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除状态0未删除1放入回收站2彻底删除',
  `refund_amount` decimal(10,2) DEFAULT '0.00' COMMENT '退款金额',
  `delay_time` int(10) unsigned DEFAULT '0' COMMENT '延迟时间,默认为0',
  `order_from` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1WEB2mobile',
  `shipping_code` varchar(50) DEFAULT '' COMMENT '物流单号',
  `order_type` tinyint(4) DEFAULT '1' COMMENT '订单类型1普通订单(默认),2预定订单,3门店自提订单',
  `api_pay_time` int(10) unsigned DEFAULT '0' COMMENT '在线支付动作时间,只要向第三方支付平台提交就会更新',
  `chain_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '自提门店ID',
  `chain_code` mediumint(6) unsigned NOT NULL DEFAULT '0' COMMENT '门店提货码',
  `rpt_amount` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '红包值',
  `trade_no` varchar(50) DEFAULT NULL COMMENT '外部交易订单号',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='订单表';

/*Data for the table `feiwa_orders` */

insert  into `feiwa_orders`(`order_id`,`order_sn`,`pay_sn`,`store_id`,`store_name`,`buyer_id`,`buyer_name`,`buyer_email`,`buyer_phone`,`add_time`,`payment_code`,`payment_time`,`finnshed_time`,`goods_amount`,`order_amount`,`rcb_amount`,`pd_amount`,`shipping_fee`,`evaluation_state`,`evaluation_again_state`,`order_state`,`refund_state`,`lock_state`,`delete_state`,`refund_amount`,`delay_time`,`order_from`,`shipping_code`,`order_type`,`api_pay_time`,`chain_id`,`chain_code`,`rpt_amount`,`trade_no`) values (1,9000000000000101,560564229290261043,6,'商城',1043,'adminy','adminy@a.com',13561113346,1510885289,'online',0,0,'6000.00','6000.00','0.00','0.00','0.00',0,0,0,0,0,0,'0.00',0,1,'',1,0,0,0,'0.00',NULL),(2,9000000000000201,810564234314769043,6,'商城',1043,'adminy','adminy@a.com',13561113346,1510890313,'predeposit',1510890628,1510911808,'89.00','89.00','0.00','89.00','0.00',1,0,40,0,0,0,'0.00',1510905496,1,NULL,1,0,0,0,'0.00',NULL),(3,9000000000000301,930564234675781043,6,'商城',1043,'adminy','adminy@a.com',13561113346,1510890674,'online',0,0,'18.00','18.00','0.00','0.00','0.00',0,0,0,0,0,0,'0.00',0,1,'',1,0,0,0,'0.00',NULL),(4,9000000000000401,210567097150278043,6,'商城',1043,'adminy','adminy@a.com',13888888888,1513753149,'online',0,0,'89.00','89.00','0.00','0.00','0.00',0,0,0,0,0,0,'0.00',0,1,'',1,0,0,0,'0.00',NULL),(5,1000000000000501,460568390922534043,6,'商城',1043,'adminy','adminy@a.com',13888888888,1515046922,'online',0,0,'10200.00','10200.00','0.00','0.00','0.00',0,0,0,0,0,0,'0.00',0,1,'',1,1515046928,0,0,'0.00',NULL),(6,1000000000000601,910568894027087043,6,'商城',1043,'adminy','adminy@a.com',13888888888,1515550026,'predeposit',1515550264,0,'2100.00','2100.00','2100.00','0.00','0.00',0,0,30,0,0,0,'0.00',1525747989,1,NULL,1,0,0,0,'0.00',NULL),(7,1000000000000701,330568894904103043,6,'商城',1043,'adminy','adminy@a.com',13888888888,1515550903,'predeposit',1515550925,0,'938.00','938.00','938.00','0.00','0.00',0,0,30,0,0,0,'0.00',1525748321,1,NULL,1,0,0,0,'0.00',NULL),(8,1000000000000801,230568897115371043,6,'商城',1043,'adminy','adminy@a.com',13888888888,1515553115,'online',0,0,'1500.00','1500.00','0.00','0.00','0.00',0,0,0,0,0,0,'0.00',0,1,'',1,0,0,0,'0.00',NULL),(9,1000000000000901,950570298560657043,6,'商城',1043,'adminy','adminy@a.com',13888888888,1516954560,'online',0,0,'1500.00','1500.00','0.00','0.00','0.00',0,0,10,0,0,0,'0.00',0,1,'',1,1516954570,0,0,'0.00',NULL),(10,1000000000001001,640570888099456043,6,'商城',1043,'adminy','adminy@a.com',13888888888,1517544098,'predeposit',1525748437,0,'2100.00','2100.00','0.00','2100.00','0.00',0,0,20,0,0,0,'0.00',0,1,'',1,0,0,0,'0.00',NULL),(11,1000000000001101,760570889283659043,6,'商城',1043,'adminy','adminy@a.com',13888888888,1517545283,'predeposit',1525748471,0,'2100.00','2100.00','0.00','2100.00','0.00',0,0,20,0,0,0,'0.00',0,1,'',1,0,0,0,'0.00',NULL),(12,1000000000001201,680571165658358043,11,'测试',1043,'adminy','adminy@a.com',13888888888,1517821658,'online',0,0,'50.00','50.00','0.00','0.00','0.00',0,0,10,0,0,0,'0.00',0,1,'',1,1517822370,0,0,'0.00',NULL),(13,1000000000001301,610571244807912057,6,'商城',1057,'xiaozhai','',17691164888,1517900807,'online',0,0,'1800.00','1800.00','0.00','0.00','0.00',0,0,10,0,0,0,'0.00',0,1,'',1,1517900815,0,0,'0.00',NULL),(14,1000000000001401,600574520001045043,6,'商城',1043,'adminy','adminy@a.com',13888888888,1521176000,'online',0,0,'1800.00','1800.00','0.00','0.00','0.00',0,0,10,0,0,0,'0.00',0,1,'',1,0,0,0,'0.00',NULL),(15,1000000000001501,120575378116664055,6,'商城',1055,'admin111','764759168@qq.com',13800000000,1522034116,'online',0,0,'1800.00','1800.00','0.00','0.00','0.00',0,0,10,0,0,0,'0.00',0,1,'',1,1522034145,0,0,'0.00',NULL),(16,1000000000001601,420575984423614043,6,'商城',1043,'adminy','adminy@a.com',13888888888,1522640422,'online',0,0,'1800.00','1800.00','0.00','0.00','0.00',0,0,10,0,0,0,'0.00',0,1,'',1,0,0,0,'0.00',NULL),(17,1000000000001701,420576523649680043,6,'商城',1043,'adminy','adminy@a.com',12312341234,1523179649,'online',0,0,'400.00','400.00','0.00','0.00','0.00',0,0,0,0,0,0,'0.00',0,1,'',1,0,0,0,'0.00',NULL),(18,1000000000001801,880589481496891067,6,'商城',1067,'iuser_aaa','a@afd.com',17091902132,1536137496,'online',0,0,'300.00','300.00','0.00','0.00','0.00',0,0,10,0,0,0,'0.00',0,2,'',1,0,0,0,'0.00',NULL),(19,1000000000001901,240589481503346067,6,'商城',1067,'iuser_aaa','a@afd.com',17091902132,1536137503,'online',0,0,'300.00','300.00','0.00','0.00','0.00',0,0,10,0,0,0,'0.00',0,2,'',1,0,0,0,'0.00',NULL),(20,1000000000002001,880589481653819067,6,'商城',1067,'iuser_aaa','a@afd.com',17091902132,1536137653,'online',0,0,'300.00','300.00','0.00','0.00','0.00',0,0,10,0,0,0,'0.00',0,2,'',1,0,0,0,'0.00',NULL),(21,1000000000002101,670589481703285067,6,'商城',1067,'iuser_aaa','a@afd.com',17091902132,1536137703,'online',0,0,'300.00','300.00','0.00','0.00','0.00',0,0,10,0,0,0,'0.00',0,2,'',1,0,0,0,'0.00',NULL),(22,1000000000002201,480589481738020067,6,'商城',1067,'iuser_aaa','a@afd.com',17091902132,1536137737,'online',0,0,'300.00','300.00','0.00','0.00','0.00',0,0,10,0,0,0,'0.00',0,2,'',1,1536137743,0,0,'0.00',NULL),(23,1000000000002301,650589481776390067,6,'商城',1067,'iuser_aaa','a@afd.com',17091902132,1536137776,'online',0,1536138314,'300.00','300.00','0.00','0.00','0.00',0,0,40,0,0,0,'0.00',1536138237,2,'sf1234567',1,1536137778,0,0,'0.00',NULL);

/*Table structure for table `feiwa_p_book_quota` */

DROP TABLE IF EXISTS `feiwa_p_book_quota`;

CREATE TABLE `feiwa_p_book_quota` (
  `bkq_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '预定套餐id',
  `store_id` int(11) NOT NULL COMMENT '店铺id',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `bkq_starttime` int(11) NOT NULL COMMENT '套餐开始时间',
  `bkq_endtime` int(11) NOT NULL COMMENT '套餐结束时间',
  PRIMARY KEY (`bkq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预定商品套餐表';

/*Data for the table `feiwa_p_book_quota` */

/*Table structure for table `feiwa_p_booth_goods` */

DROP TABLE IF EXISTS `feiwa_p_booth_goods`;

CREATE TABLE `feiwa_p_booth_goods` (
  `booth_goods_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '套餐商品id',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺id',
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品id',
  `gc_id` int(10) unsigned NOT NULL COMMENT '商品分类id',
  `booth_state` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '套餐状态 1开启 0关闭 默认1',
  PRIMARY KEY (`booth_goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='展位商品表';

/*Data for the table `feiwa_p_booth_goods` */

/*Table structure for table `feiwa_p_booth_quota` */

DROP TABLE IF EXISTS `feiwa_p_booth_quota`;

CREATE TABLE `feiwa_p_booth_quota` (
  `booth_quota_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '套餐id',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺id',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `booth_quota_starttime` int(10) unsigned NOT NULL COMMENT '开始时间',
  `booth_quota_endtime` int(10) unsigned NOT NULL COMMENT '结束时间',
  `booth_state` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '套餐状态 1开启 0关闭 默认1',
  PRIMARY KEY (`booth_quota_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='展位套餐表';

/*Data for the table `feiwa_p_booth_quota` */

insert  into `feiwa_p_booth_quota`(`booth_quota_id`,`store_id`,`store_name`,`booth_quota_starttime`,`booth_quota_endtime`,`booth_state`) values (1,7,'feng店铺名称',1510815142,1515999142,1),(2,6,'商城',1510815906,1515999906,0);

/*Table structure for table `feiwa_p_bundling` */

DROP TABLE IF EXISTS `feiwa_p_bundling`;

CREATE TABLE `feiwa_p_bundling` (
  `bl_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '组合ID',
  `bl_name` varchar(50) NOT NULL DEFAULT '' COMMENT '组合名称',
  `store_id` int(11) NOT NULL COMMENT '店铺名称',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `bl_discount_price` decimal(10,2) NOT NULL COMMENT '组合价格',
  `bl_freight_choose` tinyint(1) NOT NULL COMMENT '运费承担方式',
  `bl_freight` decimal(10,2) DEFAULT '0.00' COMMENT '运费',
  `bl_state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '组合状态 0-关闭/1-开启',
  PRIMARY KEY (`bl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组合销售活动表';

/*Data for the table `feiwa_p_bundling` */

/*Table structure for table `feiwa_p_bundling_goods` */

DROP TABLE IF EXISTS `feiwa_p_bundling_goods`;

CREATE TABLE `feiwa_p_bundling_goods` (
  `bl_goods_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '组合商品id',
  `bl_id` int(11) NOT NULL COMMENT '组合id',
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品id',
  `goods_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_image` varchar(100) NOT NULL DEFAULT '' COMMENT '商品图片',
  `bl_goods_price` decimal(10,2) NOT NULL COMMENT '商品价格',
  `bl_appoint` tinyint(3) unsigned NOT NULL COMMENT '指定商品 1是，0否',
  PRIMARY KEY (`bl_goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组合销售活动商品表';

/*Data for the table `feiwa_p_bundling_goods` */

/*Table structure for table `feiwa_p_bundling_quota` */

DROP TABLE IF EXISTS `feiwa_p_bundling_quota`;

CREATE TABLE `feiwa_p_bundling_quota` (
  `bl_quota_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '套餐ID',
  `store_id` int(11) NOT NULL COMMENT '店铺id',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `member_id` int(11) NOT NULL COMMENT '会员id',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员名称',
  `bl_quota_month` tinyint(3) unsigned NOT NULL COMMENT '购买数量（单位月）',
  `bl_quota_starttime` varchar(10) NOT NULL DEFAULT '' COMMENT '套餐开始时间',
  `bl_quota_endtime` varchar(10) NOT NULL DEFAULT '' COMMENT '套餐结束时间',
  `bl_state` tinyint(1) unsigned NOT NULL COMMENT '套餐状态：0关闭，1开启。默认为 1',
  PRIMARY KEY (`bl_quota_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组合销售套餐表';

/*Data for the table `feiwa_p_bundling_quota` */

/*Table structure for table `feiwa_p_combo_goods` */

DROP TABLE IF EXISTS `feiwa_p_combo_goods`;

CREATE TABLE `feiwa_p_combo_goods` (
  `cg_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '推荐组合id ',
  `cg_class` varchar(10) NOT NULL DEFAULT '' COMMENT '推荐组合名称',
  `goods_id` int(10) unsigned NOT NULL COMMENT '主商品id',
  `goods_commonid` int(10) unsigned NOT NULL COMMENT '主商品公共id',
  `store_id` int(10) unsigned NOT NULL COMMENT '所属店铺id',
  `combo_goodsid` int(10) unsigned NOT NULL COMMENT '推荐组合商品id',
  PRIMARY KEY (`cg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品推荐组合表';

/*Data for the table `feiwa_p_combo_goods` */

/*Table structure for table `feiwa_p_combo_quota` */

DROP TABLE IF EXISTS `feiwa_p_combo_quota`;

CREATE TABLE `feiwa_p_combo_quota` (
  `cq_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '推荐组合套餐id',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺id',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `cq_starttime` int(10) unsigned NOT NULL COMMENT '套餐开始时间',
  `cq_endtime` int(10) unsigned NOT NULL COMMENT '套餐结束时间',
  PRIMARY KEY (`cq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='推荐组合套餐表';

/*Data for the table `feiwa_p_combo_quota` */

/*Table structure for table `feiwa_p_cou` */

DROP TABLE IF EXISTS `feiwa_p_cou`;

CREATE TABLE `feiwa_p_cou` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `store_id` int(11) NOT NULL COMMENT '店铺ID',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `quota_id` int(11) NOT NULL COMMENT '套餐ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `tstart` int(10) unsigned NOT NULL COMMENT '开始时间',
  `tend` int(10) unsigned NOT NULL COMMENT '结束时间',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态 1正常2结束3平台关闭',
  PRIMARY KEY (`id`),
  KEY `store_id` (`store_id`),
  KEY `quota_id` (`quota_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='加价购';

/*Data for the table `feiwa_p_cou` */

insert  into `feiwa_p_cou`(`id`,`store_id`,`store_name`,`quota_id`,`name`,`tstart`,`tend`,`state`) values (1,8,'adminy',3,'adminy的加价购',1536138000,1538236800,1);

/*Table structure for table `feiwa_p_cou_level` */

DROP TABLE IF EXISTS `feiwa_p_cou_level`;

CREATE TABLE `feiwa_p_cou_level` (
  `cou_id` int(11) NOT NULL COMMENT '加价购ID',
  `xlevel` tinyint(3) unsigned NOT NULL COMMENT '等级',
  `mincost` decimal(10,2) NOT NULL COMMENT '最低消费金额',
  `maxcou` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大可凑单数',
  PRIMARY KEY (`cou_id`,`xlevel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='加价购活动规则';

/*Data for the table `feiwa_p_cou_level` */

/*Table structure for table `feiwa_p_cou_level_sku` */

DROP TABLE IF EXISTS `feiwa_p_cou_level_sku`;

CREATE TABLE `feiwa_p_cou_level_sku` (
  `cou_id` int(11) NOT NULL COMMENT '加价购ID',
  `xlevel` tinyint(3) unsigned NOT NULL COMMENT '等级',
  `sku_id` int(11) NOT NULL COMMENT '商品条目ID',
  `price` decimal(10,2) NOT NULL COMMENT '价格',
  PRIMARY KEY (`cou_id`,`xlevel`,`sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='加价购活动换购商品';

/*Data for the table `feiwa_p_cou_level_sku` */

/*Table structure for table `feiwa_p_cou_quota` */

DROP TABLE IF EXISTS `feiwa_p_cou_quota`;

CREATE TABLE `feiwa_p_cou_quota` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `store_id` int(11) NOT NULL COMMENT '店铺ID',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `tstart` int(10) unsigned NOT NULL COMMENT '开始时间',
  `tend` int(10) unsigned NOT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`),
  KEY `store_id` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='加价购套餐';

/*Data for the table `feiwa_p_cou_quota` */

insert  into `feiwa_p_cou_quota`(`id`,`store_id`,`store_name`,`tstart`,`tend`) values (2,6,'商城',1510884810,1536804810),(3,8,'adminy',1536115056,1538707056);

/*Table structure for table `feiwa_p_cou_sku` */

DROP TABLE IF EXISTS `feiwa_p_cou_sku`;

CREATE TABLE `feiwa_p_cou_sku` (
  `sku_id` int(11) NOT NULL COMMENT '商品条目ID',
  `cou_id` int(11) NOT NULL COMMENT '加价购ID',
  `tstart` int(10) unsigned NOT NULL COMMENT '开始时间',
  `tend` int(10) unsigned NOT NULL COMMENT '结束时间',
  PRIMARY KEY (`sku_id`,`cou_id`),
  KEY `cou_id` (`cou_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='加价购活动商品';

/*Data for the table `feiwa_p_cou_sku` */

/*Table structure for table `feiwa_p_fcode_quota` */

DROP TABLE IF EXISTS `feiwa_p_fcode_quota`;

CREATE TABLE `feiwa_p_fcode_quota` (
  `fcq_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'F码套餐id',
  `store_id` int(11) NOT NULL COMMENT '店铺id',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `fcq_starttime` int(11) NOT NULL COMMENT '套餐开始时间',
  `fcq_endtime` int(11) NOT NULL COMMENT '套餐结束时间',
  PRIMARY KEY (`fcq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='F码商品套餐表';

/*Data for the table `feiwa_p_fcode_quota` */

/*Table structure for table `feiwa_p_mansong` */

DROP TABLE IF EXISTS `feiwa_p_mansong`;

CREATE TABLE `feiwa_p_mansong` (
  `mansong_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '满送活动编号',
  `mansong_name` varchar(50) NOT NULL DEFAULT '' COMMENT '活动名称',
  `quota_id` int(10) unsigned NOT NULL COMMENT '套餐编号',
  `start_time` int(10) unsigned NOT NULL COMMENT '活动开始时间',
  `end_time` int(10) unsigned NOT NULL COMMENT '活动结束时间',
  `member_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺编号',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `state` tinyint(1) unsigned NOT NULL COMMENT '活动状态(1-未发布/2-正常/3-取消/4-失效/5-结束)',
  `remark` varchar(200) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`mansong_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='满就送活动表';

/*Data for the table `feiwa_p_mansong` */

/*Table structure for table `feiwa_p_mansong_quota` */

DROP TABLE IF EXISTS `feiwa_p_mansong_quota`;

CREATE TABLE `feiwa_p_mansong_quota` (
  `quota_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '满就送套餐编号',
  `member_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺编号',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `start_time` int(10) unsigned NOT NULL COMMENT '开始时间',
  `end_time` int(10) unsigned NOT NULL COMMENT '结束时间',
  `state` tinyint(1) unsigned DEFAULT '0' COMMENT '配额状态(1-可用/2-取消/3-结束)',
  PRIMARY KEY (`quota_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='满就送套餐表';

/*Data for the table `feiwa_p_mansong_quota` */

insert  into `feiwa_p_mansong_quota`(`quota_id`,`member_id`,`store_id`,`member_name`,`store_name`,`start_time`,`end_time`,`state`) values (1,1041,6,'zxx1cndns','商城',1510908607,1542012607,0);

/*Table structure for table `feiwa_p_mansong_rule` */

DROP TABLE IF EXISTS `feiwa_p_mansong_rule`;

CREATE TABLE `feiwa_p_mansong_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则编号',
  `mansong_id` int(10) unsigned NOT NULL COMMENT '活动编号',
  `price` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '级别价格',
  `discount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '减现金优惠金额',
  `mansong_goods_name` varchar(50) DEFAULT '' COMMENT '礼品名称',
  `goods_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品编号',
  PRIMARY KEY (`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='满就送活动规则表';

/*Data for the table `feiwa_p_mansong_rule` */

/*Table structure for table `feiwa_p_sole_goods` */

DROP TABLE IF EXISTS `feiwa_p_sole_goods`;

CREATE TABLE `feiwa_p_sole_goods` (
  `sole_goods_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '手机专享商品id',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺id',
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品id',
  `sole_price` decimal(10,2) NOT NULL COMMENT '专享价格',
  `gc_id` int(10) unsigned NOT NULL COMMENT '商品分类id',
  `sole_state` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '套餐状态 1开启 0关闭 默认1',
  PRIMARY KEY (`sole_goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机专享商品表';

/*Data for the table `feiwa_p_sole_goods` */

/*Table structure for table `feiwa_p_sole_quota` */

DROP TABLE IF EXISTS `feiwa_p_sole_quota`;

CREATE TABLE `feiwa_p_sole_quota` (
  `sole_quota_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '套餐id',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺id',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `sole_quota_starttime` int(10) unsigned NOT NULL COMMENT '开始时间',
  `sole_quota_endtime` int(10) unsigned NOT NULL COMMENT '结束时间',
  `sole_state` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '套餐状态 1开启 0关闭 默认1',
  PRIMARY KEY (`sole_quota_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机专享套餐表';

/*Data for the table `feiwa_p_sole_quota` */

/*Table structure for table `feiwa_p_xianshi` */

DROP TABLE IF EXISTS `feiwa_p_xianshi`;

CREATE TABLE `feiwa_p_xianshi` (
  `xianshi_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '限时编号',
  `xianshi_name` varchar(50) NOT NULL DEFAULT '' COMMENT '活动名称',
  `xianshi_title` varchar(10) DEFAULT NULL COMMENT '活动标题',
  `xianshi_explain` varchar(50) DEFAULT NULL COMMENT '活动说明',
  `quota_id` int(10) unsigned NOT NULL COMMENT '套餐编号',
  `start_time` int(10) unsigned NOT NULL COMMENT '活动开始时间',
  `end_time` int(10) unsigned NOT NULL COMMENT '活动结束时间',
  `member_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺编号',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `lower_limit` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '购买下限，1为不限制',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态，0-取消 1-正常',
  `xianshi_image` varchar(100) DEFAULT NULL COMMENT '淘特卖图片',
  `xianshi_image1` varchar(100) DEFAULT NULL COMMENT '淘特卖图片1',
  `class_id` int(10) NOT NULL COMMENT '淘特卖分类',
  `xianshi_intro` text COMMENT '自定义页面',
  `xianshi_image2` varchar(100) DEFAULT NULL COMMENT '品牌图',
  `recommended` tinyint(1) unsigned zerofill DEFAULT '0' COMMENT '是否推荐 0.未推荐 1.已推荐',
  PRIMARY KEY (`xianshi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='限时折扣活动表';

/*Data for the table `feiwa_p_xianshi` */

/*Table structure for table `feiwa_p_xianshi_class` */

DROP TABLE IF EXISTS `feiwa_p_xianshi_class`;

CREATE TABLE `feiwa_p_xianshi_class` (
  `class_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '类别编号',
  `class_name` varchar(20) NOT NULL DEFAULT '' COMMENT '类别名称',
  `class_parent_id` int(10) unsigned NOT NULL COMMENT '父类别编号',
  `sort` tinyint(1) unsigned NOT NULL COMMENT '排序',
  `deep` tinyint(1) unsigned DEFAULT '0' COMMENT '深度',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `feiwa_p_xianshi_class` */

/*Table structure for table `feiwa_p_xianshi_goods` */

DROP TABLE IF EXISTS `feiwa_p_xianshi_goods`;

CREATE TABLE `feiwa_p_xianshi_goods` (
  `xianshi_goods_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '限时折扣商品表',
  `xianshi_id` int(10) unsigned NOT NULL COMMENT '限时活动编号',
  `xianshi_name` varchar(50) NOT NULL DEFAULT '' COMMENT '活动名称',
  `xianshi_title` varchar(10) DEFAULT NULL COMMENT '活动标题',
  `xianshi_explain` varchar(50) DEFAULT NULL COMMENT '活动说明',
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品编号',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺编号',
  `goods_name` varchar(100) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_price` decimal(10,2) NOT NULL COMMENT '店铺价格',
  `xianshi_price` decimal(10,2) NOT NULL COMMENT '限时折扣价格',
  `goods_image` varchar(100) NOT NULL DEFAULT '' COMMENT '商品图片',
  `start_time` int(10) unsigned NOT NULL COMMENT '开始时间',
  `end_time` int(10) unsigned NOT NULL COMMENT '结束时间',
  `lower_limit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买下限，0为不限制',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态，0-取消 1-正常',
  `xianshi_recommend` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '推荐标志 0-未推荐 1-已推荐',
  `gc_id_1` mediumint(9) DEFAULT '0' COMMENT '商品分类一级ID',
  PRIMARY KEY (`xianshi_goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='限时折扣商品表';

/*Data for the table `feiwa_p_xianshi_goods` */

/*Table structure for table `feiwa_p_xianshi_quota` */

DROP TABLE IF EXISTS `feiwa_p_xianshi_quota`;

CREATE TABLE `feiwa_p_xianshi_quota` (
  `quota_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '限时折扣套餐编号',
  `member_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺编号',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `start_time` int(10) unsigned NOT NULL COMMENT '套餐开始时间',
  `end_time` int(10) unsigned NOT NULL COMMENT '套餐结束时间',
  PRIMARY KEY (`quota_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='限时折扣套餐表';

/*Data for the table `feiwa_p_xianshi_quota` */

insert  into `feiwa_p_xianshi_quota`(`quota_id`,`member_id`,`store_id`,`member_name`,`store_name`,`start_time`,`end_time`) values (1,1041,6,'zxx1cndns','商城',1510884826,1536804826);

/*Table structure for table `feiwa_payment` */

DROP TABLE IF EXISTS `feiwa_payment`;

CREATE TABLE `feiwa_payment` (
  `payment_id` tinyint(1) unsigned NOT NULL COMMENT '支付索引id',
  `payment_code` char(10) NOT NULL DEFAULT '' COMMENT '支付代码名称',
  `payment_name` char(10) NOT NULL DEFAULT '' COMMENT '支付名称',
  `payment_config` text COMMENT '支付接口配置信息',
  `payment_state` enum('0','1') NOT NULL DEFAULT '0' COMMENT '接口状态0禁用1启用',
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='支付方式表';

/*Data for the table `feiwa_payment` */

insert  into `feiwa_payment`(`payment_id`,`payment_code`,`payment_name`,`payment_config`,`payment_state`) values (1,'offline','货到付款','a:1:{s:0:\"\";s:0:\"\";}','0'),(2,'alipay','支付宝','a:4:{s:14:\"alipay_service\";s:25:\"create_direct_pay_by_user\";s:14:\"alipay_account\";s:21:\"gzhuayu2008@gmail.com\";s:10:\"alipay_key\";s:16:\"2088002671005445\";s:14:\"alipay_partner\";s:32:\"v83dw3yhbpzkv2l72hyoamoj9ylwik4w\";}','1'),(3,'tenpay','财付通','a:2:{s:14:\"tenpay_account\";s:0:\"\";s:10:\"tenpay_key\";s:0:\"\";}','0'),(4,'chinabank','网银在线','a:2:{s:17:\"chinabank_account\";s:0:\"\";s:13:\"chinabank_key\";s:0:\"\";}','0'),(5,'predeposit','站内余额支付','a:1:{s:0:\"\";s:0:\"\";}','1'),(6,'wxpay','微信支付','a:3:{s:5:\"appid\";s:0:\"\";s:5:\"mchid\";s:0:\"\";s:3:\"key\";s:0:\"\";}','0');

/*Table structure for table `feiwa_pd_cash` */

DROP TABLE IF EXISTS `feiwa_pd_cash`;

CREATE TABLE `feiwa_pd_cash` (
  `pdc_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增编号',
  `pdc_sn` bigint(20) NOT NULL COMMENT '记录唯一标示',
  `pdc_member_id` int(11) NOT NULL COMMENT '会员编号',
  `pdc_member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员名称',
  `pdc_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `pdc_bank_name` varchar(40) NOT NULL DEFAULT '' COMMENT '收款银行',
  `pdc_bank_no` varchar(30) DEFAULT NULL COMMENT '收款账号',
  `pdc_bank_user` varchar(10) DEFAULT NULL COMMENT '开户人姓名',
  `pdc_add_time` int(11) NOT NULL COMMENT '添加时间',
  `pdc_payment_time` int(11) DEFAULT NULL COMMENT '付款时间',
  `pdc_payment_state` enum('0','1') NOT NULL DEFAULT '0' COMMENT '提现支付状态 0默认1支付完成',
  `pdc_payment_admin` varchar(30) DEFAULT NULL COMMENT '支付管理员',
  PRIMARY KEY (`pdc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预存款提现记录表';

/*Data for the table `feiwa_pd_cash` */

/*Table structure for table `feiwa_pd_log` */

DROP TABLE IF EXISTS `feiwa_pd_log`;

CREATE TABLE `feiwa_pd_log` (
  `lg_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增编号',
  `lg_member_id` int(11) NOT NULL COMMENT '会员编号',
  `lg_member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员名称',
  `lg_admin_name` varchar(50) DEFAULT NULL COMMENT '管理员名称',
  `lg_type` varchar(15) NOT NULL DEFAULT '' COMMENT 'order_pay下单支付预存款,order_freeze下单冻结预存款,order_cancel取消订单解冻预存款,order_comb_pay下单支付被冻结的预存款,recharge充值,cash_apply申请提现冻结预存款,cash_pay提现成功,cash_del取消提现申请，解冻预存款,refund退款',
  `lg_av_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '可用金额变更0表示未变更',
  `lg_freeze_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '冻结金额变更0表示未变更',
  `lg_add_time` int(11) NOT NULL COMMENT '添加时间',
  `lg_desc` varchar(150) DEFAULT NULL COMMENT '描述',
  `lg_invite_member_id` int(11) DEFAULT '0' COMMENT '原始会员编号',
  PRIMARY KEY (`lg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='预存款变更日志表';

/*Data for the table `feiwa_pd_log` */

insert  into `feiwa_pd_log`(`lg_id`,`lg_member_id`,`lg_member_name`,`lg_admin_name`,`lg_type`,`lg_av_amount`,`lg_freeze_amount`,`lg_add_time`,`lg_desc`,`lg_invite_member_id`) values (19,1043,'adminy',NULL,'order_pay','-89.00','0.00',1510890628,'下单，支付预存款，订单号: 9000000000000201',NULL),(20,1046,'hztest','adminy','sys_add_money','1000000.00','0.00',1513754526,'管理员调节预存款【增加】，充值单号: 920567098526268000',NULL),(21,1043,'adminy',NULL,'order_pay','-2100.00','0.00',1525748437,'下单，支付预存款，订单号: 1000000000001001',NULL),(22,1043,'adminy',NULL,'order_pay','-2100.00','0.00',1525748471,'下单，支付预存款，订单号: 1000000000001101',NULL);

/*Table structure for table `feiwa_pd_recharge` */

DROP TABLE IF EXISTS `feiwa_pd_recharge`;

CREATE TABLE `feiwa_pd_recharge` (
  `pdr_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增编号',
  `pdr_sn` bigint(20) unsigned NOT NULL COMMENT '记录唯一标示',
  `pdr_member_id` int(11) NOT NULL COMMENT '会员编号',
  `pdr_member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员名称',
  `pdr_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '充值金额',
  `pdr_payment_code` varchar(20) DEFAULT '' COMMENT '支付方式',
  `pdr_payment_name` varchar(15) DEFAULT '' COMMENT '支付方式',
  `pdr_trade_sn` varchar(50) DEFAULT '' COMMENT '第三方支付接口交易号',
  `pdr_add_time` int(11) NOT NULL COMMENT '添加时间',
  `pdr_payment_state` enum('0','1') NOT NULL DEFAULT '0' COMMENT '支付状态 0未支付1支付',
  `pdr_payment_time` int(11) NOT NULL DEFAULT '0' COMMENT '支付时间',
  `pdr_admin` varchar(30) DEFAULT '' COMMENT '管理员名',
  PRIMARY KEY (`pdr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='预存款充值表';

/*Data for the table `feiwa_pd_recharge` */

insert  into `feiwa_pd_recharge`(`pdr_id`,`pdr_sn`,`pdr_member_id`,`pdr_member_name`,`pdr_amount`,`pdr_payment_code`,`pdr_payment_name`,`pdr_trade_sn`,`pdr_add_time`,`pdr_payment_state`,`pdr_payment_time`,`pdr_admin`) values (28,810564229313961043,1043,'adminy','1000000.00','','','',1510885312,'0',0,''),(29,470568895256093043,1043,'adminy','10000000.00','','','',1515551255,'0',0,''),(30,470575379498464043,1043,'adminy','1000.00','','','',1522035498,'0',0,'');

/*Table structure for table `feiwa_points_cart` */

DROP TABLE IF EXISTS `feiwa_points_cart`;

CREATE TABLE `feiwa_points_cart` (
  `pcart_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `pmember_id` int(11) NOT NULL COMMENT '会员编号',
  `pgoods_id` int(11) NOT NULL COMMENT '积分礼品序号',
  `pgoods_name` varchar(100) NOT NULL DEFAULT '' COMMENT '积分礼品名称',
  `pgoods_points` int(11) NOT NULL COMMENT '积分礼品兑换积分',
  `pgoods_choosenum` int(11) NOT NULL COMMENT '选择积分礼品数量',
  `pgoods_image` varchar(100) DEFAULT NULL COMMENT '积分礼品图片',
  PRIMARY KEY (`pcart_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分礼品兑换购物车';

/*Data for the table `feiwa_points_cart` */

/*Table structure for table `feiwa_points_goods` */

DROP TABLE IF EXISTS `feiwa_points_goods`;

CREATE TABLE `feiwa_points_goods` (
  `pgoods_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '积分礼品索引id',
  `pgoods_name` varchar(100) NOT NULL DEFAULT '' COMMENT '积分礼品名称',
  `pgoods_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '积分礼品原价',
  `pgoods_points` int(11) NOT NULL COMMENT '积分礼品兑换所需积分',
  `pgoods_image` varchar(100) DEFAULT '' COMMENT '积分礼品默认封面图片',
  `pgoods_tag` varchar(100) DEFAULT '' COMMENT '积分礼品标签',
  `pgoods_serial` varchar(50) NOT NULL DEFAULT '' COMMENT '积分礼品货号',
  `pgoods_storage` int(11) NOT NULL DEFAULT '0' COMMENT '积分礼品库存数',
  `pgoods_show` tinyint(1) NOT NULL COMMENT '积分礼品上架 0表示下架 1表示上架',
  `pgoods_commend` tinyint(1) NOT NULL COMMENT '积分礼品推荐',
  `pgoods_add_time` int(11) NOT NULL COMMENT '积分礼品添加时间',
  `pgoods_keywords` varchar(100) DEFAULT NULL COMMENT '积分礼品关键字',
  `pgoods_description` varchar(200) DEFAULT NULL COMMENT '积分礼品描述',
  `pgoods_body` text NOT NULL COMMENT '积分礼品详细内容',
  `pgoods_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '积分礼品状态，0开启，1禁售',
  `pgoods_close_reason` varchar(255) DEFAULT NULL COMMENT '积分礼品禁售原因',
  `pgoods_salenum` int(11) NOT NULL DEFAULT '0' COMMENT '积分礼品售出数量',
  `pgoods_view` int(11) NOT NULL DEFAULT '0' COMMENT '积分商品浏览次数',
  `pgoods_islimit` tinyint(1) NOT NULL COMMENT '是否限制每会员兑换数量',
  `pgoods_limitnum` int(11) DEFAULT NULL COMMENT '每会员限制兑换数量',
  `pgoods_islimittime` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否限制兑换时间 0为不限制 1为限制',
  `pgoods_limitmgrade` int(11) NOT NULL DEFAULT '0' COMMENT '限制参与兑换的会员级别',
  `pgoods_starttime` int(11) DEFAULT NULL COMMENT '兑换开始时间',
  `pgoods_endtime` int(11) DEFAULT NULL COMMENT '兑换结束时间',
  `pgoods_sort` int(11) NOT NULL DEFAULT '0' COMMENT '礼品排序',
  PRIMARY KEY (`pgoods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='积分礼品表';

/*Data for the table `feiwa_points_goods` */

insert  into `feiwa_points_goods`(`pgoods_id`,`pgoods_name`,`pgoods_price`,`pgoods_points`,`pgoods_image`,`pgoods_tag`,`pgoods_serial`,`pgoods_storage`,`pgoods_show`,`pgoods_commend`,`pgoods_add_time`,`pgoods_keywords`,`pgoods_description`,`pgoods_body`,`pgoods_state`,`pgoods_close_reason`,`pgoods_salenum`,`pgoods_view`,`pgoods_islimit`,`pgoods_limitnum`,`pgoods_islimittime`,`pgoods_limitmgrade`,`pgoods_starttime`,`pgoods_endtime`,`pgoods_sort`) values (1,'礼品名称','100.00',80,'05792028485247398.jpg','','SFAJIWF89FASDKL',10,1,1,1525858848,'','','礼品描述',0,'',0,0,0,0,0,0,0,0,0);

/*Table structure for table `feiwa_points_log` */

DROP TABLE IF EXISTS `feiwa_points_log`;

CREATE TABLE `feiwa_points_log` (
  `pl_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '积分日志编号',
  `pl_memberid` int(11) NOT NULL COMMENT '会员编号',
  `pl_membername` varchar(100) NOT NULL DEFAULT '' COMMENT '会员名称',
  `pl_adminid` int(11) DEFAULT NULL COMMENT '管理员编号',
  `pl_adminname` varchar(100) DEFAULT NULL COMMENT '管理员名称',
  `pl_points` int(11) NOT NULL DEFAULT '0' COMMENT '积分数负数表示扣除',
  `pl_addtime` int(11) NOT NULL COMMENT '添加时间',
  `pl_desc` varchar(100) NOT NULL DEFAULT '' COMMENT '操作描述',
  `pl_stage` varchar(50) NOT NULL DEFAULT '' COMMENT '操作阶段',
  PRIMARY KEY (`pl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1453 DEFAULT CHARSET=utf8 COMMENT='会员积分日志表';

/*Data for the table `feiwa_points_log` */

insert  into `feiwa_points_log`(`pl_id`,`pl_memberid`,`pl_membername`,`pl_adminid`,`pl_adminname`,`pl_points`,`pl_addtime`,`pl_desc`,`pl_stage`) values (1374,1041,'zxx1cndns',NULL,NULL,20,1510650411,'注册会员','regist'),(1375,1042,'fengfeng',NULL,NULL,20,1510651781,'注册会员','regist'),(1376,1043,'adminy',NULL,NULL,20,1510796771,'注册会员','regist'),(1377,1042,'fengfeng',NULL,NULL,30,1510813896,'会员登录','login'),(1378,1043,'adminy',NULL,NULL,30,1510885148,'会员登录','login'),(1379,1041,'zxx1cndns',NULL,NULL,30,1510890988,'会员登录','login'),(1380,1043,'adminy',NULL,NULL,4,1510911809,'订单9000000000000201购物消费','order'),(1381,1043,'adminy',NULL,NULL,50,1510911881,'评论商品','comments'),(1382,1043,'adminy',NULL,NULL,30,1511156633,'会员登录','login'),(1383,1041,'zxx1cndns',NULL,NULL,30,1511508696,'会员登录','login'),(1384,1043,'adminy',NULL,NULL,30,1511508786,'会员登录','login'),(1385,1043,'adminy',NULL,NULL,30,1511777078,'会员登录','login'),(1386,1043,'adminy',NULL,NULL,30,1513221583,'会员登录','login'),(1387,1043,'adminy',NULL,NULL,30,1513695775,'会员登录','login'),(1388,1044,'cliffgyn',NULL,NULL,20,1513701274,'注册会员','regist'),(1389,1045,'register',NULL,NULL,20,1513751144,'注册会员','regist'),(1390,1043,'adminy',NULL,NULL,30,1513751238,'会员登录','login'),(1391,1046,'hztest',NULL,NULL,20,1513751805,'注册会员','regist'),(1392,1047,'adssse',NULL,NULL,20,1513752446,'注册会员','regist'),(1393,1043,'adminy',NULL,NULL,30,1513929456,'会员登录','login'),(1394,1048,'a491945489',NULL,NULL,20,1514001172,'注册会员','regist'),(1395,1043,'adminy',NULL,NULL,30,1514194250,'会员登录','login'),(1396,1043,'adminy',NULL,NULL,30,1514368414,'会员登录','login'),(1397,1043,'adminy',NULL,NULL,30,1514424822,'会员登录','login'),(1398,1043,'adminy',NULL,NULL,30,1514515479,'会员登录','login'),(1399,1043,'adminy',NULL,NULL,30,1515046724,'会员登录','login'),(1400,1049,'orayadminabc',NULL,NULL,20,1515141621,'注册会员','regist'),(1401,1043,'adminy',NULL,NULL,30,1515309361,'会员登录','login'),(1402,1050,'tianhe',NULL,NULL,20,1515311234,'注册会员','regist'),(1403,1051,'123456abc',NULL,NULL,20,1515473011,'注册会员','regist'),(1404,1043,'adminy',NULL,NULL,30,1515545505,'会员登录','login'),(1405,1052,'leitao',NULL,NULL,20,1515548962,'注册会员','regist'),(1406,1053,'joor2017',NULL,NULL,20,1515554449,'注册会员','regist'),(1407,1043,'adminy',NULL,NULL,30,1515655182,'会员登录','login'),(1408,1054,'ssencn',NULL,NULL,20,1515680578,'注册会员','regist'),(1409,1043,'adminy',NULL,NULL,30,1516069443,'会员登录','login'),(1410,1055,'admin111',NULL,NULL,20,1516071228,'注册会员','regist'),(1411,1043,'adminy',NULL,NULL,30,1516161127,'会员登录','login'),(1412,1043,'adminy',NULL,NULL,30,1516253595,'会员登录','login'),(1413,1043,'adminy',NULL,NULL,30,1516327248,'会员登录','login'),(1414,1043,'adminy',NULL,NULL,30,1516585619,'会员登录','login'),(1415,1043,'adminy',NULL,NULL,30,1516690073,'会员登录','login'),(1416,1056,'19716305wanlu',NULL,NULL,20,1516691668,'注册会员','regist'),(1417,1043,'adminy',NULL,NULL,30,1517112192,'会员登录','login'),(1418,1043,'adminy',NULL,NULL,30,1517192388,'会员登录','login'),(1419,1043,'adminy',NULL,NULL,30,1517382710,'会员登录','login'),(1420,1043,'adminy',NULL,NULL,30,1517459831,'会员登录','login'),(1421,1043,'adminy',NULL,NULL,30,1517544007,'会员登录','login'),(1422,1043,'adminy',NULL,NULL,30,1517821919,'会员登录','login'),(1423,1057,'xiaozhai',NULL,NULL,20,1517889256,'注册会员','regist'),(1424,1043,'adminy',NULL,NULL,30,1517906699,'会员登录','login'),(1425,1043,'adminy',NULL,NULL,30,1519207656,'会员登录','login'),(1426,1043,'adminy',NULL,NULL,30,1519997574,'会员登录','login'),(1427,1058,'test123456',NULL,NULL,20,1520054912,'注册会员','regist'),(1428,1043,'adminy',NULL,NULL,30,1520392897,'会员登录','login'),(1429,1059,'我的普罗旺斯',NULL,NULL,20,1520910484,'注册会员','regist'),(1430,1043,'adminy',NULL,NULL,30,1521175784,'会员登录','login'),(1431,1060,'test1111',NULL,NULL,20,1522030065,'注册会员','regist'),(1432,1055,'admin111',NULL,NULL,30,1522034002,'会员登录','login'),(1433,1060,'test1111',NULL,NULL,30,1522113251,'会员登录','login'),(1434,1060,'test1111',NULL,NULL,30,1522281271,'会员登录','login'),(1435,1060,'test1111',NULL,NULL,30,1522386245,'会员登录','login'),(1436,1043,'adminy',NULL,NULL,30,1522649962,'会员登录','login'),(1437,1043,'adminy',NULL,NULL,30,1523259578,'会员登录','login'),(1438,1,'member',NULL,NULL,30,1523583781,'会员登录','login'),(1439,1061,'hzyuandun',NULL,NULL,20,1523951516,'注册会员','regist'),(1440,1062,'cliffgyn11111',NULL,NULL,20,1523952717,'注册会员','regist'),(1441,1063,'sannianzhihou',NULL,NULL,20,1523952778,'注册会员','regist'),(1442,1043,'adminy',NULL,NULL,30,1525748063,'会员登录','login'),(1443,1043,'adminy',NULL,NULL,30,1525860454,'会员登录','login'),(1444,1041,'zxx1cndns',NULL,NULL,30,1525860530,'会员登录','login'),(1445,1,'member',NULL,NULL,30,1528193311,'会员登录','login'),(1446,1043,'adminy',NULL,NULL,30,1536132931,'会员登录','login'),(1447,1,'member',NULL,NULL,30,1536134664,'会员登录','login'),(1448,1064,'iuseruser',NULL,NULL,20,1536135982,'注册会员','regist'),(1449,1067,'iuser_aaa',NULL,NULL,20,1536136347,'注册会员','regist'),(1450,1068,'caozhiqiang',NULL,NULL,20,1536136645,'注册会员','regist'),(1451,1067,'iuser_aaa',NULL,NULL,15,1536138314,'订单1000000000002301购物消费','order'),(1452,1,'member',NULL,NULL,30,1536715029,'会员登录','login');

/*Table structure for table `feiwa_points_order` */

DROP TABLE IF EXISTS `feiwa_points_order`;

CREATE TABLE `feiwa_points_order` (
  `point_orderid` int(11) NOT NULL AUTO_INCREMENT COMMENT '兑换订单编号',
  `point_ordersn` varchar(20) NOT NULL DEFAULT '' COMMENT '兑换订单编号',
  `point_buyerid` int(11) NOT NULL COMMENT '兑换会员id',
  `point_buyername` varchar(50) NOT NULL DEFAULT '' COMMENT '兑换会员姓名',
  `point_buyeremail` varchar(100) NOT NULL DEFAULT '' COMMENT '兑换会员email',
  `point_addtime` int(11) NOT NULL COMMENT '兑换订单生成时间',
  `point_shippingtime` int(11) DEFAULT NULL COMMENT '配送时间',
  `point_shippingcode` varchar(50) DEFAULT NULL COMMENT '物流单号',
  `point_shipping_ecode` varchar(30) DEFAULT NULL COMMENT '物流公司编码',
  `point_finnshedtime` int(11) DEFAULT NULL COMMENT '订单完成时间',
  `point_allpoint` int(11) NOT NULL DEFAULT '0' COMMENT '兑换总积分',
  `point_ordermessage` varchar(300) DEFAULT NULL COMMENT '订单留言',
  `point_orderstate` int(11) NOT NULL DEFAULT '20' COMMENT '订单状态：20(默认):已兑换并扣除积分;30:已发货;40:已收货;50已完成;2已取消',
  PRIMARY KEY (`point_orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='兑换订单表';

/*Data for the table `feiwa_points_order` */

/*Table structure for table `feiwa_points_orderaddress` */

DROP TABLE IF EXISTS `feiwa_points_orderaddress`;

CREATE TABLE `feiwa_points_orderaddress` (
  `point_oaid` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `point_orderid` int(11) NOT NULL COMMENT '订单id',
  `point_truename` varchar(50) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `point_areaid` int(11) NOT NULL COMMENT '地区id',
  `point_areainfo` varchar(100) NOT NULL DEFAULT '' COMMENT '地区内容',
  `point_address` varchar(200) NOT NULL DEFAULT '' COMMENT '详细地址',
  `point_telphone` varchar(20) DEFAULT '' COMMENT '电话号码',
  `point_mobphone` varchar(20) DEFAULT '' COMMENT '手机号码',
  PRIMARY KEY (`point_oaid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='兑换订单地址表';

/*Data for the table `feiwa_points_orderaddress` */

/*Table structure for table `feiwa_points_ordergoods` */

DROP TABLE IF EXISTS `feiwa_points_ordergoods`;

CREATE TABLE `feiwa_points_ordergoods` (
  `point_recid` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单礼品表索引',
  `point_orderid` int(11) NOT NULL COMMENT '订单id',
  `point_goodsid` int(11) NOT NULL COMMENT '礼品id',
  `point_goodsname` varchar(100) NOT NULL DEFAULT '' COMMENT '礼品名称',
  `point_goodspoints` int(11) NOT NULL COMMENT '礼品兑换积分',
  `point_goodsnum` int(11) NOT NULL COMMENT '礼品数量',
  `point_goodsimage` varchar(100) DEFAULT NULL COMMENT '礼品图片',
  PRIMARY KEY (`point_recid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='兑换订单商品表';

/*Data for the table `feiwa_points_ordergoods` */

/*Table structure for table `feiwa_rcb_log` */

DROP TABLE IF EXISTS `feiwa_rcb_log`;

CREATE TABLE `feiwa_rcb_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增编号',
  `member_id` int(11) NOT NULL COMMENT '会员编号',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员名称',
  `type` varchar(15) NOT NULL DEFAULT '' COMMENT 'order_pay下单使用 order_freeze下单冻结 order_cancel取消订单解冻 order_comb_pay下单扣除被冻结 recharge平台充值卡充值 refund确认退款 vr_refund虚拟兑码退款',
  `add_time` int(11) NOT NULL COMMENT '添加时间',
  `available_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '可用充值卡余额变更 0表示未变更',
  `freeze_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '冻结充值卡余额变更 0表示未变更',
  `description` varchar(150) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='充值卡余额变更日志表';

/*Data for the table `feiwa_rcb_log` */

insert  into `feiwa_rcb_log`(`id`,`member_id`,`member_name`,`type`,`add_time`,`available_amount`,`freeze_amount`,`description`) values (1,1043,'adminy','order_pay',1515550264,'-2100.00','0.00','下单，使用充值卡余额，订单号: 1000000000000601'),(2,1043,'adminy','order_pay',1515550925,'-938.00','0.00','下单，使用充值卡余额，订单号: 1000000000000701');

/*Table structure for table `feiwa_reads_article` */

DROP TABLE IF EXISTS `feiwa_reads_article`;

CREATE TABLE `feiwa_reads_article` (
  `article_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章编号',
  `article_title` varchar(50) NOT NULL DEFAULT '' COMMENT '文章标题',
  `article_class_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章分类编号',
  `article_origin` varchar(50) DEFAULT NULL COMMENT '文章来源',
  `article_origin_address` varchar(255) DEFAULT NULL COMMENT '文章来源链接',
  `article_author` varchar(50) NOT NULL DEFAULT '' COMMENT '文章作者',
  `article_abstract` varchar(140) DEFAULT NULL COMMENT '文章摘要',
  `article_content` text COMMENT '文章正文',
  `article_image` varchar(255) DEFAULT NULL COMMENT '文章图片',
  `article_keyword` varchar(255) DEFAULT NULL COMMENT '文章关键字',
  `article_link` varchar(255) DEFAULT NULL COMMENT '相关文章',
  `article_goods` text COMMENT '相关商品',
  `article_start_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章有效期开始时间',
  `article_end_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章有效期结束时间',
  `article_publish_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章发布时间',
  `article_click` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章点击量',
  `article_sort` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '文章排序0-255',
  `article_commend_flag` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '文章推荐标志0-未推荐，1-已推荐',
  `article_comment_flag` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '文章是否允许评论1-允许，0-不允许',
  `article_verify_admin` varchar(50) DEFAULT NULL COMMENT '文章审核管理员',
  `article_verify_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章审核时间',
  `article_state` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1-草稿、2-待审核、3-已发布、4-回收站',
  `article_publisher_name` varchar(50) NOT NULL DEFAULT '' COMMENT '发布者用户名 ',
  `article_publisher_id` int(10) unsigned NOT NULL COMMENT '发布者编号',
  `article_type` tinyint(1) unsigned NOT NULL COMMENT '文章类型1-管理员发布，2-用户投稿',
  `article_attachment_path` varchar(50) NOT NULL DEFAULT '' COMMENT '文章附件路径',
  `article_image_all` text COMMENT '文章全部图片',
  `article_modify_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章修改时间',
  `article_tag` varchar(255) DEFAULT NULL COMMENT '文章标签',
  `article_comment_count` int(10) unsigned DEFAULT '0' COMMENT '文章评论数',
  `article_attitude_1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章心情1',
  `article_attitude_2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章心情2',
  `article_attitude_3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章心情3',
  `article_attitude_4` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章心情4',
  `article_attitude_5` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章心情5',
  `article_attitude_6` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章心情6',
  `article_title_short` varchar(50) NOT NULL DEFAULT '' COMMENT '文章短标题',
  `article_attitude_flag` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '文章态度开关1-允许，0-不允许',
  `article_commend_image_flag` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '文章推荐标志(图文)',
  `article_share_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章分享数',
  `article_verify_reason` varchar(255) DEFAULT NULL COMMENT '审核失败原因',
  PRIMARY KEY (`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='CMS文章表';

/*Data for the table `feiwa_reads_article` */

insert  into `feiwa_reads_article`(`article_id`,`article_title`,`article_class_id`,`article_origin`,`article_origin_address`,`article_author`,`article_abstract`,`article_content`,`article_image`,`article_keyword`,`article_link`,`article_goods`,`article_start_time`,`article_end_time`,`article_publish_time`,`article_click`,`article_sort`,`article_commend_flag`,`article_comment_flag`,`article_verify_admin`,`article_verify_time`,`article_state`,`article_publisher_name`,`article_publisher_id`,`article_type`,`article_attachment_path`,`article_image_all`,`article_modify_time`,`article_tag`,`article_comment_count`,`article_attitude_1`,`article_attitude_2`,`article_attitude_3`,`article_attitude_4`,`article_attitude_5`,`article_attitude_6`,`article_title_short`,`article_attitude_flag`,`article_commend_image_flag`,`article_share_count`,`article_verify_reason`) values (4,'member文章1',7,'','','member','member文章1','member文章1',NULL,'','',NULL,0,0,1510588800,8,255,1,1,NULL,0,3,'member',1,1,'1',NULL,1510627174,'',0,0,0,0,0,0,0,'member文章1',1,0,0,NULL),(5,'0110',9,'','','adminy','疲于标普ibl','乐居预告；iyhvblhjb，就j.bh,',NULL,'小米，note','','a:3:{i:0;a:5:{s:3:\"url\";s:80:\"http://865284.ichengyun.net/mall/index.php?app=goods&feiwa=index&goods_id=100224\";s:5:\"title\";s:10:\"小米note\";s:5:\"image\";s:86:\"http://865284.ichengyun.net/data/upload/mall/store/goods/8/8_05675387995058942_240.jpg\";s:5:\"price\";s:7:\"2090.00\";s:4:\"type\";s:5:\"store\";}i:1;a:5:{s:3:\"url\";s:72:\"http://865284.ichengyun.net/mall/index.php?app=goods&amp;goods_id=100224\";s:5:\"title\";s:10:\"小米note\";s:5:\"image\";s:86:\"http://865284.ichengyun.net/data/upload/mall/store/goods/8/8_05675387995058942_240.jpg\";s:5:\"price\";s:7:\"2090.00\";s:4:\"type\";s:5:\"store\";}i:2;a:5:{s:3:\"url\";s:72:\"http://865284.ichengyun.net/mall/index.php?app=goods&amp;goods_id=100177\";s:5:\"title\";s:21:\"小米Note3 全网通\";s:5:\"image\";s:86:\"http://865284.ichengyun.net/data/upload/mall/store/goods/6/6_05640708105633162_240.jpg\";s:5:\"price\";s:7:\"2299.00\";s:4:\"type\";s:5:\"store\";}}',0,0,1515513600,5,255,0,1,NULL,0,3,'adminy',1043,1,'1043',NULL,1515553050,'',0,0,1,0,0,0,0,'00000',1,0,0,NULL);

/*Table structure for table `feiwa_reads_article_attitude` */

DROP TABLE IF EXISTS `feiwa_reads_article_attitude`;

CREATE TABLE `feiwa_reads_article_attitude` (
  `attitude_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '心情编号',
  `attitude_article_id` int(10) unsigned NOT NULL COMMENT '文章编号',
  `attitude_member_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `attitude_time` int(10) unsigned NOT NULL COMMENT '发布心情时间',
  PRIMARY KEY (`attitude_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS文章心情表';

/*Data for the table `feiwa_reads_article_attitude` */

insert  into `feiwa_reads_article_attitude`(`attitude_id`,`attitude_article_id`,`attitude_member_id`,`attitude_time`) values (1,5,1043,1515574757);

/*Table structure for table `feiwa_reads_article_class` */

DROP TABLE IF EXISTS `feiwa_reads_article_class`;

CREATE TABLE `feiwa_reads_article_class` (
  `class_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类编号 ',
  `class_name` varchar(50) NOT NULL DEFAULT '' COMMENT '分类名称',
  `class_sort` tinyint(1) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='cms文章分类表';

/*Data for the table `feiwa_reads_article_class` */

/*Table structure for table `feiwa_reads_comment` */

DROP TABLE IF EXISTS `feiwa_reads_comment`;

CREATE TABLE `feiwa_reads_comment` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '评论编号',
  `comment_type` tinyint(1) NOT NULL COMMENT '评论类型编号',
  `comment_object_id` int(10) unsigned NOT NULL COMMENT '推荐商品编号',
  `comment_message` varchar(2000) NOT NULL DEFAULT '' COMMENT '评论内容',
  `comment_member_id` int(10) unsigned NOT NULL COMMENT '评论人编号',
  `comment_time` int(10) unsigned NOT NULL COMMENT '评论时间',
  `comment_quote` varchar(255) DEFAULT NULL COMMENT '评论引用',
  `comment_up` int(10) unsigned DEFAULT '0' COMMENT '顶数量',
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS评论表';

/*Data for the table `feiwa_reads_comment` */

/*Table structure for table `feiwa_reads_comment_up` */

DROP TABLE IF EXISTS `feiwa_reads_comment_up`;

CREATE TABLE `feiwa_reads_comment_up` (
  `up_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '顶编号',
  `comment_id` int(10) unsigned NOT NULL COMMENT '评论编号',
  `up_member_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `up_time` int(10) unsigned NOT NULL COMMENT '评论时间',
  PRIMARY KEY (`up_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS评论顶表';

/*Data for the table `feiwa_reads_comment_up` */

/*Table structure for table `feiwa_reads_index_module` */

DROP TABLE IF EXISTS `feiwa_reads_index_module`;

CREATE TABLE `feiwa_reads_index_module` (
  `module_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模块编号',
  `module_title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT '模板名称',
  `module_type` varchar(50) DEFAULT '' COMMENT '模块类型，index-固定内容、article1-文章模块1、article2-文章模块2、micro-分享秀、adv-通栏广告',
  `module_sort` tinyint(1) unsigned DEFAULT '255' COMMENT '排序',
  `module_state` tinyint(1) unsigned DEFAULT '1' COMMENT '状态1-显示、0-不显示',
  `module_content` text COMMENT '模块内容',
  `module_style` varchar(50) NOT NULL DEFAULT 'style1' COMMENT '模块主题',
  `module_view` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '后台列表显示样式 1-展开 2-折叠',
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='CMS首页模块表';

/*Data for the table `feiwa_reads_index_module` */

insert  into `feiwa_reads_index_module`(`module_id`,`module_title`,`module_name`,`module_type`,`module_sort`,`module_state`,`module_content`,`module_style`,`module_view`) values (19,'分享秀模块','micro','micro',0,1,'YToxOntzOjEzOiJtaWNyb19jb250ZW50IjtzOjMxMTc6IiZsdDtkaXYgY2xhc3M9JnF1b3Q7cmVhZHMtbW9kdWxlLW1pY3JvLWxlZnQmcXVvdDsmZ3Q7Jmx0O2RpdiBjbGFzcz0mcXVvdDt0aXRsZS1iYXImcXVvdDsmZ3Q7Jmx0O2RpdiBjbGFzcz0mcXVvdDttaWNyby1hcGktdGl0bGUmcXVvdDsmZ3Q75YiG5Lqr56eAJmx0Oy9kaXYmZ3Q7Jmx0O2RpdiBjbGFzcz0mcXVvdDttaWNyby1hcGktcGVyc29uYWwtY2xhc3MmcXVvdDsmZ3Q7Jmx0O3VsJmd0OyAgICAgICAgICAgICZsdDtsaSZndDsgICAgJmx0O2EgaHJlZj0mcXVvdDtodHRwOi8vODY1Mjg0LmljaGVuZ3l1bi5uZXQvc2hhcmVzaG93L2luZGV4LnBocD9hcHA9cGVyc29uYWwmYW1wO2NsYXNzX2lkPTEmcXVvdDsgdGFyZ2V0PSZxdW90O19ibGFuayZxdW90OyZndDvkuKrkurrnp4BhZG1pbnkmbHQ7L2EmZ3Q7ICAgICZsdDsvbGkmZ3Q7ICAgICAgICAmbHQ7L3VsJmd0OyZsdDsvZGl2Jmd0OyZsdDtkaXYgY2xhc3M9JnF1b3Q7dGl0bGUtbW9yZSZxdW90OyZndDsmbHQ7YSBjbGFzcz0mcXVvdDttb3JlJnF1b3Q7IGhyZWY9JnF1b3Q7aHR0cDovLzg2NTI4NC5pY2hlbmd5dW4ubmV0L3NoYXJlc2hvdyZxdW90OyB0YXJnZXQ9JnF1b3Q7X2JsYW5rJnF1b3Q7Jmd0O+abtOWkmiZsdDsvYSZndDsmbHQ7L2RpdiZndDsmbHQ7L2RpdiZndDsmbHQ7ZGl2IGNsYXNzPSZxdW90O21pY3JvLWFwaS1wZXJzb25hbC1saXN0JnF1b3Q7Jmd0OyZsdDshLS3mjqjojZDkuKrkurrnp4Dpg6jliIYtLSZndDsmbHQ7ZGl2IGNsYXNzPSZxdW90O3RpdGxlJnF1b3Q7Jmd0OyAgICAmbHQ7aDMmZ3Q75Lya5ZGY5o6o6I2QJmx0O2VtJmd0O+S4quS6uuengCZsdDsvZW0mZ3Q7Jmx0Oy9oMyZndDsmbHQ7L2RpdiZndDsmbHQ7dWwgY2xhc3M9JnF1b3Q7amNhcm91c2VsLXNraW4tcGVyc29uYWwmcXVvdDsgaWQ9JnF1b3Q7aW5kZXhQZXJzb25hbCZxdW90OyZndDsgICAgICAgICAgICAgICAgJmx0O2xpJmd0OyAgICAmbHQ7ZGl2IGNsYXNzPSZxdW90O3JlYWRzLXRodW1iJnF1b3Q7Jmd0OyZsdDthIGhyZWY9JnF1b3Q7aHR0cDovLzg2NTI4NC5pY2hlbmd5dW4ubmV0L3NoYXJlc2hvdy9pbmRleC5waHA/YXBwPXBlcnNvbmFsJmFtcDtmZWl3YT1kZXRhaWwmYW1wO3BlcnNvbmFsX2lkPTQmcXVvdDsmZ3Q7ICAgICAgICAmbHQ7aW1nIGNsYXNzPSZxdW90O3QtaW1nJnF1b3Q7IGFsdD0mcXVvdDsmcXVvdDsgc3JjPSZxdW90O2h0dHA6Ly84NjUyODQuaWNoZW5neXVuLm5ldC9kYXRhL3VwbG9hZC9zaGFyZXNob3cvMTA0My8wNTY0MjU2NjUxNDY0MTQ0NV9saXN0LmpwZyZxdW90OyZndDsgICAgJmx0Oy9hJmd0OyZsdDsvZGl2Jmd0OyAgICAmbHQ7ZGwmZ3Q7ICAgICAgICAmbHQ7ZHQgY2xhc3M9JnF1b3Q7bWVtYmVyLWF2YXRhciZxdW90OyZndDsmbHQ7aW1nIHNyYz0mcXVvdDtodHRwOi8vODY1Mjg0LmljaGVuZ3l1bi5uZXQvZGF0YS91cGxvYWQvbWFsbC9hdmF0YXIvYXZhdGFyXzEwNDMuanBnJnF1b3Q7Jmd0OyZsdDsvZHQmZ3Q7ICAgICAgICAmbHQ7ZGQgY2xhc3M9JnF1b3Q7bWVtYmVyLWlkJnF1b3Q7Jmd0OyZsdDthIGhyZWY9JnF1b3Q7aHR0cDovLzg2NTI4NC5pY2hlbmd5dW4ubmV0L3NoYXJlc2hvdy9pbmRleC5waHA/YXBwPWhvbWUmYW1wO21lbWJlcl9pZD0xMDQzJnF1b3Q7Jmd0OyBhZG1pbnkmbHQ7L2EmZ3Q7Jmx0Oy9kZCZndDsgICAgICAgICZsdDtkZCBjbGFzcz0mcXVvdDtjb21tZW5kLXRpbWUmcXVvdDsmZ3Q7MjAxNy0xMS0xNyZsdDsvZGQmZ3Q7ICAgICAgICAmbHQ7ZGQgY2xhc3M9JnF1b3Q7Y29tbWVuZC1tZXNzYWdlJnF1b3Q7Jmd0O+aIkeeahOaQremFjei/mOS4jemUmeWQp14tXiZsdDsvZGQmZ3Q7ICAgICAgICAmbHQ7ZGQgY2xhc3M9JnF1b3Q7bGlrZSZxdW90OyZndDsmbHQ7aSZndDsmbHQ7L2kmZ3Q75Zac5qyiJmx0O2VtJmd0OzAmbHQ7L2VtJmd0OyZsdDsvZGQmZ3Q7ICAgICZsdDsvZGwmZ3Q7ICAgICZsdDsvbGkmZ3Q7ICAgICAgICAmbHQ7L3VsJmd0OyZsdDsvZGl2Jmd0OyZsdDsvZGl2Jmd0OyZsdDtkaXYgY2xhc3M9JnF1b3Q7bWljcm8tYXBpLXN0b3JlLWxpc3QmcXVvdDsmZ3Q7Jmx0OyEtLeW6l+mTuuihl+aOqOiNkOaOkuihjC0tJmd0OyZsdDtkaXYgY2xhc3M9JnF1b3Q7dGl0bGUtYmFyJnF1b3Q7Jmd0OyAgJmx0O2gzJmd0O+W6l+mTuuihlyZsdDsvaDMmZ3Q7ICAmbHQ7YSBjbGFzcz0mcXVvdDttb3JlJnF1b3Q7IGhyZWY9JnF1b3Q7aHR0cDovLzg2NTI4NC5pY2hlbmd5dW4ubmV0L3NoYXJlc2hvdy9pbmRleC5waHA/YXBwPXN0b3JlJnF1b3Q7IHRhcmdldD0mcXVvdDtfYmxhbmsmcXVvdDsmZ3Q75pu05aSaJmx0Oy9hJmd0OyAmbHQ7L2RpdiZndDsmbHQ7ZGl2IGNsYXNzPSZxdW90O2NvbnRuZXQtYm94JnF1b3Q7Jmd0OyAgJmx0O29sIGNsYXNzPSZxdW90O3NoYXJlc2hvdy1zdG9yZS1saXN0JnF1b3Q7IGZlaXdhX3R5cGU9JnF1b3Q7aW5kZXhfc3RvcmUmcXVvdDsmZ3Q7ICAgICAgICAgICAgICAgICAgJmx0O2xpIGNsYXNzPSZxdW90O292ZXJhbGwmcXVvdDsgc3R5bGU9JnF1b3Q7ZGlzcGxheTogbm9uZTsmcXVvdDsmZ3Q7Jmx0O2kmZ3Q7MSZsdDsvaSZndDsgICAgICAmbHQ7ZGwgY2xhc3M9JnF1b3Q7c3RvcmUtaW50cm8mcXVvdDsmZ3Q7ICAgICAgICAmbHQ7ZHQmZ3Q75ZWG5Z+OJmx0Oy9kdCZndDsgICAgICAgICZsdDtkZCZndDvllYblk4HvvJombHQ7ZW0mZ3Q7NTMmbHQ7L2VtJmd0O+S7tiZsdDsvZGQmZ3Q7ICAgICAgICAmbHQ7ZGQmZ3Q7Jmx0O2EgaHJlZj0mcXVvdDtodHRwOi8vODY1Mjg0LmljaGVuZ3l1bi5uZXQvc2hhcmVzaG93L2luZGV4LnBocD9hcHA9c3RvcmUmYW1wO2ZlaXdhPWRldGFpbCZhbXA7c3RvcmVfaWQ9NCZxdW90OyB0YXJnZXQ9JnF1b3Q7X2JsYW5rJnF1b3Q7Jmd0O+WOu+W6l+mTuuihl+afpeeci+ivpeW6lyZsdDsvYSZndDsmbHQ7L2RkJmd0OyAgICAgICZsdDsvZGwmZ3Q7ICAgICZsdDsvbGkmZ3Q7ICAgICZsdDtsaSBjbGFzcz0mcXVvdDtzaW1wbGUmcXVvdDsmZ3Q7Jmx0O2kmZ3Q7MSZsdDsvaSZndDsmbHQ7YSBocmVmPSZxdW90OyZxdW90OyZndDvllYbln44mbHQ7L2EmZ3Q7Jmx0Oy9saSZndDsgICAgICAgICAgJmx0Oy9vbCZndDsmbHQ7L2RpdiZndDsmbHQ7L2RpdiZndDsmbHQ7ZGl2IGNsYXNzPSZxdW90O2NsZWFyJnF1b3Q7Jmd0OyZsdDsvZGl2Jmd0OyI7fQ==','style1',1),(20,'通栏广告模块','adv','adv',1,1,NULL,'style2',1),(21,'文章模块2','article2','article2',3,1,NULL,'style1',1),(22,'文章模块1','article1','article1',6,1,NULL,'style1',1),(24,'文章模块1','article1','article1',2,1,NULL,'style1',1),(25,'分享秀模块','micro','micro',4,1,NULL,'style1',1),(27,'通栏广告模块','adv','adv',5,1,NULL,'style1',1),(28,'分享秀模块','micro','micro',7,1,'YToxOntzOjEzOiJtaWNyb19jb250ZW50IjtzOjA6IiI7fQ==','style1',1);

/*Table structure for table `feiwa_reads_module` */

DROP TABLE IF EXISTS `feiwa_reads_module`;

CREATE TABLE `feiwa_reads_module` (
  `module_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模板模块编号',
  `module_title` varchar(50) NOT NULL DEFAULT '' COMMENT '模板模块标题',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT '模板名称',
  `module_type` varchar(50) NOT NULL DEFAULT '' COMMENT '模板模块类型，index-固定内容、article1-文章模块1、article2-文章模块2、micro-分享秀、adv-通栏广告',
  `module_class` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '模板模块种类1-系统自带 2-用户自定义',
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='CMS模板模块表';

/*Data for the table `feiwa_reads_module` */

insert  into `feiwa_reads_module`(`module_id`,`module_title`,`module_name`,`module_type`,`module_class`) values (1,'综合模块','index','index',1),(2,'分享秀模块','micro','micro',1),(3,'文章模块1','article1','article1',1),(4,'文章模块2','article2','article2',1),(5,'通栏广告模块','adv','adv',1),(6,'自定义模块','model1515138104','1_4',2);

/*Table structure for table `feiwa_reads_module_assembly` */

DROP TABLE IF EXISTS `feiwa_reads_module_assembly`;

CREATE TABLE `feiwa_reads_module_assembly` (
  `assembly_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '组件编号',
  `assembly_title` varchar(50) NOT NULL DEFAULT '' COMMENT '组件标题',
  `assembly_name` varchar(50) NOT NULL DEFAULT '' COMMENT '组件名称',
  `assembly_explain` varchar(255) NOT NULL DEFAULT '' COMMENT '组件说明',
  PRIMARY KEY (`assembly_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='cms模块组件表';

/*Data for the table `feiwa_reads_module_assembly` */

insert  into `feiwa_reads_module_assembly`(`assembly_id`,`assembly_title`,`assembly_name`,`assembly_explain`) values (1,'文章','article','文章组件'),(2,'图片','picture','图片组件'),(3,'商品','goods','商品组件'),(4,'品牌','brand','品牌组件'),(5,'图文','article_image','图文'),(6,'店铺','store','店铺'),(7,'会员','member','会员'),(8,'FLASH','flash','FLASH'),(9,'自定义','html','自定义');

/*Table structure for table `feiwa_reads_module_frame` */

DROP TABLE IF EXISTS `feiwa_reads_module_frame`;

CREATE TABLE `feiwa_reads_module_frame` (
  `frame_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '框架编号',
  `frame_title` varchar(50) NOT NULL DEFAULT '' COMMENT '框架标题',
  `frame_name` varchar(50) NOT NULL DEFAULT '' COMMENT '框架名称',
  `frame_explain` varchar(255) NOT NULL DEFAULT '' COMMENT '框架说明',
  `frame_structure` varchar(255) NOT NULL DEFAULT '' COMMENT '框架结构',
  PRIMARY KEY (`frame_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='cms模块框架表';

/*Data for the table `feiwa_reads_module_frame` */

insert  into `feiwa_reads_module_frame`(`frame_id`,`frame_title`,`frame_name`,`frame_explain`,`frame_structure`) values (1,'右边栏三列结构','2_2_1','右边栏三列结构','{\"block1\":{\"type\":\"block\",\"name\":\"w2\"},\"block2\":{\"type\":\"block\",\"name\":\"w2\"},\"block3\":{\"type\":\"block\",\"name\":\"w1\"}}'),(2,'左边栏三列结构','1_2_2','左边栏三列结构','{\"block1\":{\"type\":\"block\",\"name\":\"w1\"},\"block2\":{\"type\":\"block\",\"name\":\"w2\"},\"block3\":{\"type\":\"block\",\"name\":\"w2\"}}'),(3,'左右宽边栏结构','2_1_2','左右宽边栏结构','{\"block1\":{\"type\":\"block\",\"name\":\"w2\"},\"block2\":{\"type\":\"block\",\"name\":\"w1\"},\"block3\":{\"type\":\"block\",\"name\":\"w2\"}}'),(4,'左边栏两列结构','1_4','左边栏两列结构','{\"block1\":{\"type\":\"block\",\"name\":\"w1\"},\"block2\":{\"type\":\"block\",\"name\":\"w4\"}} '),(5,'右边栏两列结构','4_1','右边栏两列结构','{\"block1\":{\"type\":\"block\",\"name\":\"w4\"},\"block2\":{\"type\":\"block\",\"name\":\"w1\"}} '),(6,'右边栏混合结构','2x2_2_1','右边栏混合结构','{\"block1\":{\"type\":\"content\",\"name\":\"w2\",\"child\":{\"block2\":{\"type\":\"block\",\"name\":\"w22\"},\"block3\":{\"type\":\"block\",\"name\":\"w22\"}}},\"block4\":{\"type\":\"block\",\"name\":\"w2\"},\"block5\":{\"type\":\"block\",\"name\":\"w1\"}} '),(7,'左边栏混合结构','1_2_2x2','左边栏混合结构','{\"block1\":{\"type\":\"block\",\"name\":\"w1\"},\"block2\":{\"type\":\"block\",\"name\":\"w2\"},\"block3\":{\"type\":\"content\",\"name\":\"w2\",\"child\":{\"block4\":{\"type\":\"block\",\"name\":\"w22\"},\"block5\":{\"type\":\"block\",\"name\":\"w22\"}}}}'),(8,'一体化结构','1','一体化结构','{\"block1\":{\"type\":\"block\",\"name\":\"w5\"}}');

/*Table structure for table `feiwa_reads_navigation` */

DROP TABLE IF EXISTS `feiwa_reads_navigation`;

CREATE TABLE `feiwa_reads_navigation` (
  `navigation_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '导航编号',
  `navigation_title` varchar(50) NOT NULL DEFAULT '' COMMENT '导航标题',
  `navigation_link` varchar(255) NOT NULL DEFAULT '' COMMENT '导航链接',
  `navigation_sort` tinyint(1) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  `navigation_open_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '导航打开方式1-本页打开，2-新页打开',
  PRIMARY KEY (`navigation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS导航表';

/*Data for the table `feiwa_reads_navigation` */

/*Table structure for table `feiwa_reads_picture` */

DROP TABLE IF EXISTS `feiwa_reads_picture`;

CREATE TABLE `feiwa_reads_picture` (
  `picture_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '画报编号',
  `picture_title` varchar(50) NOT NULL DEFAULT '' COMMENT '画报标题',
  `picture_class_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '画报分类编号',
  `picture_author` varchar(50) NOT NULL DEFAULT '' COMMENT '画报作者',
  `picture_abstract` varchar(140) DEFAULT NULL COMMENT '画报摘要',
  `picture_image` varchar(255) DEFAULT NULL COMMENT '画报图片',
  `picture_keyword` varchar(255) DEFAULT NULL COMMENT '画报关键字',
  `picture_publish_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '画报发布时间',
  `picture_click` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '画报点击量',
  `picture_sort` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '画报排序0-255',
  `picture_commend_flag` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '画报推荐标志1-未推荐，2-已推荐',
  `picture_comment_flag` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '画报是否允许评论1-允许，2-不允许',
  `picture_verify_admin` varchar(50) DEFAULT NULL COMMENT '画报审核管理员',
  `picture_verify_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '画报审核时间',
  `picture_state` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1-草稿、2-待审核、3-已发布、4-回收站、5-已关闭',
  `picture_publisher_name` varchar(50) NOT NULL DEFAULT '' COMMENT '发布人用户名',
  `picture_publisher_id` int(10) unsigned NOT NULL COMMENT '发布人编号',
  `picture_type` tinyint(1) unsigned NOT NULL COMMENT '画报类型1-管理员发布，2-用户投稿',
  `picture_attachment_path` varchar(50) NOT NULL DEFAULT '',
  `picture_modify_time` int(10) unsigned NOT NULL COMMENT '画报修改时间',
  `picture_tag` varchar(255) DEFAULT NULL COMMENT '画报标签',
  `picture_comment_count` int(10) unsigned DEFAULT '0' COMMENT '画报评论数',
  `picture_title_short` varchar(50) DEFAULT '' COMMENT '画报短标题',
  `picture_image_count` tinyint(1) unsigned DEFAULT '0' COMMENT '画报图片总数',
  `picture_share_count` int(10) unsigned DEFAULT '0' COMMENT '画报分享数',
  `picture_verify_reason` varchar(255) DEFAULT NULL COMMENT '审核失败原因',
  PRIMARY KEY (`picture_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS画报表';

/*Data for the table `feiwa_reads_picture` */

/*Table structure for table `feiwa_reads_picture_class` */

DROP TABLE IF EXISTS `feiwa_reads_picture_class`;

CREATE TABLE `feiwa_reads_picture_class` (
  `class_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类编号 ',
  `class_name` varchar(50) NOT NULL DEFAULT '' COMMENT '分类名称',
  `class_sort` tinyint(1) unsigned NOT NULL DEFAULT '255' COMMENT '排序',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='cms画报分类表';

/*Data for the table `feiwa_reads_picture_class` */

/*Table structure for table `feiwa_reads_picture_image` */

DROP TABLE IF EXISTS `feiwa_reads_picture_image`;

CREATE TABLE `feiwa_reads_picture_image` (
  `image_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '图片编号',
  `image_name` varchar(255) NOT NULL DEFAULT '' COMMENT '图片地址',
  `image_abstract` varchar(200) DEFAULT NULL COMMENT '图片摘要',
  `image_goods` text COMMENT '相关商品',
  `image_store` varchar(255) DEFAULT NULL COMMENT '相关店铺',
  `image_width` int(10) unsigned DEFAULT NULL COMMENT '图片宽度',
  `image_height` int(10) unsigned DEFAULT NULL COMMENT '图片高度',
  `image_picture_id` int(10) unsigned NOT NULL COMMENT '画报编号',
  `image_path` varchar(50) DEFAULT NULL COMMENT '图片路径',
  PRIMARY KEY (`image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS画报图片表';

/*Data for the table `feiwa_reads_picture_image` */

/*Table structure for table `feiwa_reads_special` */

DROP TABLE IF EXISTS `feiwa_reads_special`;

CREATE TABLE `feiwa_reads_special` (
  `special_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '专题编号',
  `special_title` varchar(50) NOT NULL DEFAULT '' COMMENT '专题标题',
  `special_stitle` varchar(200) NOT NULL DEFAULT '' COMMENT '专题副标题',
  `special_margin_top` int(10) DEFAULT '0' COMMENT '正文距顶部距离',
  `special_background` varchar(255) DEFAULT NULL COMMENT '专题背景',
  `special_image` varchar(255) DEFAULT NULL COMMENT '专题封面图',
  `special_image_all` text COMMENT '专题图片',
  `special_content` text COMMENT '专题内容',
  `special_modify_time` int(10) unsigned NOT NULL COMMENT '专题修改时间',
  `special_publish_id` int(10) unsigned NOT NULL COMMENT '专题发布者编号',
  `special_state` tinyint(1) unsigned NOT NULL COMMENT '专题状态1-草稿、2-已发布',
  `special_background_color` varchar(10) NOT NULL DEFAULT '#FFFFFF' COMMENT '专题背景色',
  `special_repeat` varchar(10) NOT NULL DEFAULT 'no-repeat' COMMENT '背景重复方式',
  `special_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '专题类型(1-cms专题 2-商城专题)',
  PRIMARY KEY (`special_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS专题表';

/*Data for the table `feiwa_reads_special` */

/*Table structure for table `feiwa_reads_tag` */

DROP TABLE IF EXISTS `feiwa_reads_tag`;

CREATE TABLE `feiwa_reads_tag` (
  `tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '标签编号',
  `tag_name` varchar(50) NOT NULL DEFAULT '' COMMENT '标签名称',
  `tag_sort` tinyint(1) unsigned NOT NULL COMMENT '标签排序',
  `tag_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '标签使用计数',
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS标签表';

/*Data for the table `feiwa_reads_tag` */

/*Table structure for table `feiwa_reads_tag_relation` */

DROP TABLE IF EXISTS `feiwa_reads_tag_relation`;

CREATE TABLE `feiwa_reads_tag_relation` (
  `relation_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '关系编号',
  `relation_type` tinyint(1) unsigned NOT NULL COMMENT '关系类型1-文章，2-画报',
  `relation_tag_id` int(10) unsigned NOT NULL COMMENT '标签编号',
  `relation_object_id` int(10) unsigned NOT NULL COMMENT '对象编号',
  PRIMARY KEY (`relation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS标签关系表';

/*Data for the table `feiwa_reads_tag_relation` */

/*Table structure for table `feiwa_rec_position` */

DROP TABLE IF EXISTS `feiwa_rec_position`;

CREATE TABLE `feiwa_rec_position` (
  `rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `pic_type` enum('1','2','0') NOT NULL DEFAULT '1' COMMENT '0文字1本地图片2远程',
  `title` varchar(200) DEFAULT '' COMMENT '标题',
  `content` text NOT NULL COMMENT '序列化推荐位内容',
  PRIMARY KEY (`rec_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='推荐位';

/*Data for the table `feiwa_rec_position` */

insert  into `feiwa_rec_position`(`rec_id`,`pic_type`,`title`,`content`) values (3,'1','','a:4:{s:4:\"body\";a:1:{i:0;a:2:{s:5:\"title\";s:42:\"mall/rec_position/45d89a8a46c138e32560.jpg\";s:3:\"url\";s:0:\"\";}}s:5:\"width\";s:0:\"\";s:6:\"height\";s:0:\"\";s:6:\"target\";i:1;}'),(4,'1','abc','a:4:{s:4:\"body\";a:1:{i:0;a:2:{s:5:\"title\";s:42:\"mall/rec_position/4e18fa6f494325877220.jpg\";s:3:\"url\";s:20:\"http://www.baidu.com\";}}s:5:\"width\";s:0:\"\";s:6:\"height\";s:0:\"\";s:6:\"target\";i:1;}');

/*Table structure for table `feiwa_rechargecard` */

DROP TABLE IF EXISTS `feiwa_rechargecard`;

CREATE TABLE `feiwa_rechargecard` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `sn` varchar(50) NOT NULL DEFAULT '' COMMENT '卡号',
  `denomination` decimal(10,2) NOT NULL COMMENT '面额',
  `batchflag` varchar(20) DEFAULT '' COMMENT '批次标识',
  `admin_name` varchar(50) DEFAULT NULL COMMENT '创建者名称',
  `tscreated` int(10) unsigned NOT NULL COMMENT '创建时间',
  `tsused` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用时间',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态 0可用 1已用 2已删',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '使用者会员ID',
  `member_name` varchar(50) DEFAULT NULL COMMENT '使用者会员名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8 COMMENT='平台充值卡';

/*Data for the table `feiwa_rechargecard` */

insert  into `feiwa_rechargecard`(`id`,`sn`,`denomination`,`batchflag`,`admin_name`,`tscreated`,`tsused`,`state`,`member_id`,`member_name`) values (101,'11111111a8cf687e5acc440fbd29b24a05a5cf27','1000.00','','admin',1510648230,0,0,0,NULL),(102,'1111111157be0bde0190e0aae94afca634a2f700','1000.00','','admin',1510648230,0,0,0,NULL),(103,'11111111e4ff949524e1447b97386695964f573f','1000.00','','admin',1510648230,0,0,0,NULL),(104,'111111116a8dff2164dd47a61111780ce84a5ed6','1000.00','','admin',1510648230,0,0,0,NULL),(105,'111111113ed2cc2c56fec762a018ee0c2a19fd20','1000.00','','admin',1510648230,0,0,0,NULL),(106,'11111111e8f7222446b1fe2c3a1327153a6bd424','1000.00','','admin',1510648230,0,0,0,NULL),(107,'11111111f1951ea8ef67fa7a150d39a2f9b0892f','1000.00','','admin',1510648230,0,0,0,NULL),(108,'111111117f1c17274ecc220531f63174f1bad9fb','1000.00','','admin',1510648230,0,0,0,NULL),(109,'1111111157adeeeee2f1d23f6529c73833e472ca','1000.00','','admin',1510648230,0,0,0,NULL),(110,'11111111ccc83c8463b97f521769206b3bc24e57','1000.00','','admin',1510648230,0,0,0,NULL),(111,'111111111422206d5b3495652885cd69890f92bd','1000.00','','admin',1510648230,0,0,0,NULL),(112,'111111115c421a1a58c8cece972aa649a09b8b59','1000.00','','admin',1510648230,0,0,0,NULL),(113,'11111111a4d98d08b65c3738a8f18197e6cb0da1','1000.00','','admin',1510648230,0,0,0,NULL),(114,'1111111174e9aaaf7f877b5368799abf0ac53a9e','1000.00','','admin',1510648230,0,0,0,NULL),(115,'11111111f5797195fc7924e214866737730a2e5a','1000.00','','admin',1510648230,0,0,0,NULL),(116,'111111110999f0d65e08863379d207e5b8c0daa2','1000.00','','admin',1510648230,0,0,0,NULL),(117,'11111111a81595c81d313e123aa6c11da2dc7055','1000.00','','admin',1510648230,0,0,0,NULL),(118,'111111114fbd0d185a3bf01642f29a1f5eef4f8c','1000.00','','admin',1510648230,0,0,0,NULL),(119,'1111111145c09e3db0464964b1e044d5659ff94b','1000.00','','admin',1510648230,0,0,0,NULL),(120,'11111111c4c22f9f0b8d4eed6add43c6c93d3f28','1000.00','','admin',1510648230,0,0,0,NULL),(121,'111111110c95da6a9583b1b48d13cff1979c9d77','1000.00','','admin',1510648230,0,0,0,NULL),(122,'11111111b2c3bcea0bebe34c1f2e1fd6208e7e24','1000.00','','admin',1510648230,0,0,0,NULL),(123,'11111111bfb07acc6f905785a00dca9fd9199ce1','1000.00','','admin',1510648230,0,0,0,NULL),(124,'11111111f08f299a60b8b854d7abfde19de43288','1000.00','','admin',1510648230,0,0,0,NULL),(125,'11111111839aab39725a8d1199be00379cde156c','1000.00','','admin',1510648230,0,0,0,NULL),(126,'111111111a32d237074b46ea60e4864ddb782f3f','1000.00','','admin',1510648230,0,0,0,NULL),(127,'111111118ef900dd7f70a2cfb53a2f55330f445b','1000.00','','admin',1510648230,0,0,0,NULL),(128,'111111118599f901082e794a97fc71d5ecf08950','1000.00','','admin',1510648230,0,0,0,NULL),(129,'11111111b0bf3db98e124afe9274539f6f1ea60f','1000.00','','admin',1510648230,0,0,0,NULL),(130,'11111111099f96b92f307ff14ce930d8e3e0f4cd','1000.00','','admin',1510648230,0,0,0,NULL),(131,'111111115cd0c9d562602bec5c1a0b601c58d9fa','1000.00','','admin',1510648230,0,0,0,NULL),(132,'11111111ee0325dcbdd6ca6c36f3fd0afd2c5b2c','1000.00','','admin',1510648230,0,0,0,NULL),(133,'11111111f70ca67e75325d855078dc1d155769fd','1000.00','','admin',1510648230,0,0,0,NULL),(134,'11111111246e8b40b25fbc315cc276074ec9525e','1000.00','','admin',1510648230,0,0,0,NULL),(135,'11111111c3274ad5aa46b892cad893bb88db90f7','1000.00','','admin',1510648230,0,0,0,NULL),(136,'1111111197f948972fd8deb650fb188179d0db38','1000.00','','admin',1510648230,0,0,0,NULL),(137,'1111111146c482bbdcaa6bc891fe34c27732de18','1000.00','','admin',1510648230,0,0,0,NULL),(138,'11111111dfb49484cb19463427371aafc791307a','1000.00','','admin',1510648230,0,0,0,NULL),(139,'1111111161f87382e72895a069ec93387987a2cb','1000.00','','admin',1510648230,0,0,0,NULL),(140,'11111111c803533226367879da7d30a7b3c9fc74','1000.00','','admin',1510648230,0,0,0,NULL),(141,'1111111148b274afd910aefcc9b0d45171437d85','1000.00','','admin',1510648230,0,0,0,NULL),(142,'11111111a1fac8871531b85b61e156793de34338','1000.00','','admin',1510648230,0,0,0,NULL),(143,'1111111187cb65a2546ef1734667378c60b0f9e0','1000.00','','admin',1510648230,0,0,0,NULL),(144,'11111111429d3a245b726af8370d7f040244b272','1000.00','','admin',1510648230,0,0,0,NULL),(145,'111111110c82d586929367218450e90720da0048','1000.00','','admin',1510648230,0,0,0,NULL),(146,'111111112ac35afba3aca9a5ee8e8a4a56438f4d','1000.00','','admin',1510648230,0,0,0,NULL),(147,'11111111ad8a02516c159dc894bd82216c72b19d','1000.00','','admin',1510648230,0,0,0,NULL),(148,'111111111eca61e1b4b71649ad3cf2dfd3a9022e','1000.00','','admin',1510648230,0,0,0,NULL),(149,'111111115d7c812de4795e4202305739f2530189','1000.00','','admin',1510648230,0,0,0,NULL),(150,'111111116437bc41fdcab271d1954e0ccdbc268f','1000.00','','admin',1510648230,0,0,0,NULL),(151,'111111119904b4f07bc25b05601dd666a6adf9f7','1000.00','','admin',1510648230,0,0,0,NULL),(152,'11111111d6e6ac7e0ee64bc366ad00d7193b7b4f','1000.00','','admin',1510648230,0,0,0,NULL),(153,'11111111c1646eacc1133903b3b2678d9840ea6d','1000.00','','admin',1510648230,0,0,0,NULL),(154,'11111111a9c725fe5cfc83966e4b2ec3c6832efa','1000.00','','admin',1510648230,0,0,0,NULL),(155,'11111111044892269c8e065c933bf78d670fe6ee','1000.00','','admin',1510648230,0,0,0,NULL),(156,'111111113de546314b8852c0e43e2bdef060ee71','1000.00','','admin',1510648230,0,0,0,NULL),(157,'11111111c662dbcbdb7ef1bb64f58b092d8689e4','1000.00','','admin',1510648230,0,0,0,NULL),(158,'1111111160fbd508284073ad6b1659c61a5505cc','1000.00','','admin',1510648230,0,0,0,NULL),(159,'111111119eb676609f970bb7fee3d49f8b371bbd','1000.00','','admin',1510648230,0,0,0,NULL),(160,'11111111d47f13de55902de8f2199b1155a6f53a','1000.00','','admin',1510648230,0,0,0,NULL),(161,'111111117eb9ca81f6949d9796c9d275d3eea190','1000.00','','admin',1510648230,0,0,0,NULL),(162,'1111111150364e20be09d433e203c471da0ca0e8','1000.00','','admin',1510648230,0,0,0,NULL),(163,'11111111bb2b8b909f3df14692af6afbd7e71541','1000.00','','admin',1510648230,0,0,0,NULL),(164,'1111111109d69e873ece4af5761904a84fc2c28a','1000.00','','admin',1510648230,0,0,0,NULL),(165,'111111115fe4f5ef2feb1947d35eb108414deedc','1000.00','','admin',1510648230,0,0,0,NULL),(166,'11111111b39010b9b56d976d404d77486882c030','1000.00','','admin',1510648230,0,0,0,NULL),(167,'11111111340ec66a3416c88c5fb1d2fa3916860f','1000.00','','admin',1510648230,0,0,0,NULL),(168,'11111111464c9c67eb5886ce27d071a395029301','1000.00','','admin',1510648230,0,0,0,NULL),(169,'1111111148150e34e4071404b19e2d06c1804422','1000.00','','admin',1510648230,0,0,0,NULL),(170,'1111111171b71f2186a6764ede58e6ef14fd1089','1000.00','','admin',1510648230,0,0,0,NULL),(171,'11111111f7a8131cf4db83719e11756839b66ad6','1000.00','','admin',1510648230,0,0,0,NULL),(172,'111111117d3e78fe6c10b8453f12f3a80edc5ae5','1000.00','','admin',1510648230,0,0,0,NULL),(173,'111111117117f7b12741b57d34dc02044048e204','1000.00','','admin',1510648230,0,0,0,NULL),(174,'111111114c638eb63220b4158f636b8d0c9bfbd4','1000.00','','admin',1510648230,0,0,0,NULL),(175,'11111111d1f57ab203506bd1d0d9d9cea482e73c','1000.00','','admin',1510648230,0,0,0,NULL),(176,'111111114a541b468a43ce33bd716b6fd5982592','1000.00','','admin',1510648230,0,0,0,NULL),(177,'111111118440322b39983a84d61850ea7b8705e9','1000.00','','admin',1510648230,0,0,0,NULL),(178,'1111111150560ea4f2d59e4f6b12d4d6a3e6bf34','1000.00','','admin',1510648230,0,0,0,NULL),(179,'11111111ed5d550413d16503b070e8438ad40911','1000.00','','admin',1510648230,0,0,0,NULL),(180,'11111111b4d771d2d50250c2e32f53065ff256ad','1000.00','','admin',1510648230,0,0,0,NULL),(181,'111111110e9d0eb326a56cc7232dd167b84b1fe3','1000.00','','admin',1510648230,0,0,0,NULL),(182,'111111110d57cb9a25e1d031ce028f23daab3134','1000.00','','admin',1510648230,0,0,0,NULL),(183,'11111111389fc1c7423a4fcbf4451364699f4f12','1000.00','','admin',1510648230,0,0,0,NULL),(184,'11111111b1973262e16ca28f74a387e62b70d168','1000.00','','admin',1510648230,0,0,0,NULL),(185,'11111111d664bf76dc2c6498f379e2973206749f','1000.00','','admin',1510648230,0,0,0,NULL),(186,'1111111180ee84d47ebacf29407c8888bc7a79d0','1000.00','','admin',1510648230,0,0,0,NULL),(187,'11111111cd0f2c6718e1ee67dc3288459c514a83','1000.00','','admin',1510648230,0,0,0,NULL),(188,'11111111bb90a0e3f993e76f076869da67ff0bb7','1000.00','','admin',1510648230,0,0,0,NULL),(189,'11111111f5a9cf651016b4029f55454011f69baf','1000.00','','admin',1510648230,0,0,0,NULL),(190,'11111111accc08425c4ea0dcd64db4ce5e7b1a8f','1000.00','','admin',1510648230,0,0,0,NULL),(191,'11111111457ddf906fb1256c529ecf35d875c8f8','1000.00','','admin',1510648230,0,0,0,NULL),(192,'1111111196471372ca735df0dabe5d4cc4583014','1000.00','','admin',1510648230,0,0,0,NULL),(193,'11111111fb94d04388a57fd49321748b55037a14','1000.00','','admin',1510648230,0,0,0,NULL),(194,'11111111c16d32a8472fd60c916fa70d6998690f','1000.00','','admin',1510648230,0,0,0,NULL),(195,'1111111195f8f29018d86a888bffae057c62ac85','1000.00','','admin',1510648230,0,0,0,NULL),(196,'11111111842532317e64a523262d7ab78fcbb896','1000.00','','admin',1510648230,0,0,0,NULL),(197,'11111111402064dcd35b4509cdd85373d81a3142','1000.00','','admin',1510648230,0,0,0,NULL),(198,'111111118b7887231f9eb827a1db0ee0af697c72','1000.00','','admin',1510648230,0,0,0,NULL),(199,'11111111744c0907ff09481ee580cf6c28cd3eb7','1000.00','','admin',1510648230,0,0,0,NULL),(200,'1111111110e381e98aa20452dac5f82ff776d04a','1000.00','','admin',1510648230,0,0,0,NULL),(201,'11111111554e59089f7f73254f3faf4ec23147fb','1000.00','','admin',1510648230,0,0,0,NULL),(202,'1111111120788dbad4774b6b2abea6442d637f9e','1000.00','','admin',1510648230,0,0,0,NULL),(203,'11111111ed27b75945cbd8c16e6ac8a7b827c5f0','1000.00','','admin',1510648230,0,0,0,NULL),(204,'1111111121296576f54eebb276215215a48ca029','1000.00','','admin',1510648230,0,0,0,NULL),(205,'1111111106c75c3cf3b40711f52dbaa4513a525f','1000.00','','admin',1510648230,0,0,0,NULL),(206,'11111111e7bd8546d295ed27be90c5abdb5811de','1000.00','','admin',1510648230,0,0,0,NULL),(207,'111111113c3046b393ab6b82acde48841b88b2d0','1000.00','','admin',1510648230,0,0,0,NULL),(208,'11111111216e33f342c6b5f180b5b98b419f4069','1000.00','','admin',1510648230,0,0,0,NULL),(209,'11111111f0251d6c433949d248a23d15271e975b','1000.00','','admin',1510648230,0,0,0,NULL),(210,'1111111121444eb8a841a7441333cb15e264054f','1000.00','','admin',1510648230,0,0,0,NULL),(211,'1111111108783b68c3d53b021353606a054e4d4c','1000.00','','admin',1510648230,0,0,0,NULL),(212,'3333320cfb571468e6e856c2674af75e4db0a','100.00','','admin',1513922577,0,0,0,NULL),(213,'33333e12d7bb2ff1a3202048c7ca8aa9350ab','100.00','','admin',1513922577,0,0,0,NULL),(214,'33333f56a613a9f1c1b7a6fd1ac50289a0890','100.00','','admin',1513922577,0,0,0,NULL),(215,'3333370fd5e37b13ff2db48957ac6cb630e1c','100.00','','admin',1513922577,0,0,0,NULL),(216,'333339030f4b58a6cef32ddf015fbb19b5e7d','100.00','','admin',1513922577,0,0,0,NULL);

/*Table structure for table `feiwa_redpacket` */

DROP TABLE IF EXISTS `feiwa_redpacket`;

CREATE TABLE `feiwa_redpacket` (
  `rpacket_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '红包编号',
  `rpacket_code` varchar(32) NOT NULL DEFAULT '' COMMENT '红包编码',
  `rpacket_t_id` int(11) NOT NULL COMMENT '红包模版编号',
  `rpacket_title` varchar(50) NOT NULL DEFAULT '' COMMENT '红包标题',
  `rpacket_desc` varchar(255) NOT NULL DEFAULT '' COMMENT '红包描述',
  `rpacket_start_date` int(11) NOT NULL COMMENT '红包有效期开始时间',
  `rpacket_end_date` int(11) NOT NULL COMMENT '红包有效期结束时间',
  `rpacket_price` int(11) NOT NULL COMMENT '红包面额',
  `rpacket_limit` decimal(10,2) NOT NULL COMMENT '红包使用时的订单限额',
  `rpacket_state` tinyint(4) NOT NULL COMMENT '红包状态(1-未用,2-已用,3-过期)',
  `rpacket_active_date` int(11) NOT NULL COMMENT '红包发放日期',
  `rpacket_owner_id` int(11) NOT NULL COMMENT '红包所有者id',
  `rpacket_owner_name` varchar(50) NOT NULL DEFAULT '' COMMENT '红包所有者名称',
  `rpacket_order_id` bigint(20) DEFAULT NULL COMMENT '使用该红包的订单支付单号',
  `rpacket_pwd` varchar(100) DEFAULT NULL COMMENT '红包卡密',
  `rpacket_pwd2` varchar(100) DEFAULT NULL COMMENT '红包卡密2',
  `rpacket_customimg` varchar(1000) DEFAULT NULL COMMENT '红包自定义图片',
  PRIMARY KEY (`rpacket_id`),
  UNIQUE KEY `rpacket_pwd` (`rpacket_pwd`),
  UNIQUE KEY `rpacket_pwd2` (`rpacket_pwd2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='红包表';

/*Data for the table `feiwa_redpacket` */

/*Table structure for table `feiwa_redpacket_template` */

DROP TABLE IF EXISTS `feiwa_redpacket_template`;

CREATE TABLE `feiwa_redpacket_template` (
  `rpacket_t_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '红包模版编号',
  `rpacket_t_title` varchar(50) NOT NULL DEFAULT '' COMMENT '红包模版名称',
  `rpacket_t_desc` varchar(255) NOT NULL DEFAULT '' COMMENT '红包模版描述',
  `rpacket_t_start_date` int(11) NOT NULL COMMENT '红包模版有效期开始时间',
  `rpacket_t_end_date` int(11) NOT NULL COMMENT '红包模版有效期结束时间',
  `rpacket_t_price` decimal(10,2) NOT NULL COMMENT '红包模版面额',
  `rpacket_t_limit` decimal(10,2) NOT NULL COMMENT '红包使用时的订单限额',
  `rpacket_t_adminid` int(11) NOT NULL COMMENT '修改管理员ID',
  `rpacket_t_state` tinyint(4) NOT NULL COMMENT '模版状态(1-有效,2-失效)',
  `rpacket_t_total` int(11) NOT NULL COMMENT '模版可发放的红包总数',
  `rpacket_t_giveout` int(11) NOT NULL COMMENT '模版已发放的红包数量',
  `rpacket_t_used` int(11) NOT NULL COMMENT '模版已经使用过的红包数量',
  `rpacket_t_updatetime` int(11) NOT NULL COMMENT '模版的创建时间',
  `rpacket_t_points` int(11) NOT NULL DEFAULT '0' COMMENT '兑换所需积分',
  `rpacket_t_eachlimit` int(11) NOT NULL DEFAULT '1' COMMENT '每人限领张数',
  `rpacket_t_customimg` varchar(200) DEFAULT NULL COMMENT '自定义模板图片',
  `rpacket_t_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐 0不推荐 1推荐',
  `rpacket_t_gettype` tinyint(1) NOT NULL DEFAULT '1' COMMENT '领取方式 1积分兑换 2卡密兑换 3免费领取',
  `rpacket_t_isbuild` tinyint(1) NOT NULL DEFAULT '0' COMMENT '领取方式为卡密兑换是否已经生成下属红包 0未生成 1已生成',
  `rpacket_t_mgradelimit` tinyint(2) NOT NULL DEFAULT '0' COMMENT '领取限制的会员等级',
  PRIMARY KEY (`rpacket_t_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='红包模版表';

/*Data for the table `feiwa_redpacket_template` */

/*Table structure for table `feiwa_refund_detail` */

DROP TABLE IF EXISTS `feiwa_refund_detail`;

CREATE TABLE `feiwa_refund_detail` (
  `refund_id` int(10) unsigned NOT NULL COMMENT '记录ID',
  `order_id` int(10) unsigned NOT NULL COMMENT '订单ID',
  `batch_no` varchar(32) NOT NULL DEFAULT '' COMMENT '批次号',
  `refund_amount` decimal(10,2) DEFAULT '0.00' COMMENT '退款金额',
  `pay_amount` decimal(10,2) DEFAULT '0.00' COMMENT '在线退款金额',
  `pd_amount` decimal(10,2) DEFAULT '0.00' COMMENT '预存款金额',
  `rcb_amount` decimal(10,2) DEFAULT '0.00' COMMENT '充值卡金额',
  `refund_code` char(10) NOT NULL DEFAULT 'predeposit' COMMENT '退款支付代码',
  `refund_state` tinyint(1) unsigned DEFAULT '1' COMMENT '退款状态:1为处理中,2为已完成,默认为1',
  `add_time` int(10) unsigned NOT NULL COMMENT '添加时间',
  `pay_time` int(10) unsigned DEFAULT '0' COMMENT '在线退款完成时间,默认为0',
  PRIMARY KEY (`refund_id`),
  KEY `batch_no` (`batch_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退款详细表';

/*Data for the table `feiwa_refund_detail` */

/*Table structure for table `feiwa_refund_reason` */

DROP TABLE IF EXISTS `feiwa_refund_reason`;

CREATE TABLE `feiwa_refund_reason` (
  `reason_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '原因ID',
  `reason_info` varchar(50) NOT NULL DEFAULT '' COMMENT '原因内容',
  `sort` tinyint(1) unsigned DEFAULT '255' COMMENT '排序',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`reason_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COMMENT='退款退货原因表';

/*Data for the table `feiwa_refund_reason` */

insert  into `feiwa_refund_reason`(`reason_id`,`reason_info`,`sort`,`update_time`) values (95,'效果不好不喜欢',123,1393480261),(96,'商品破损、有污渍',123,1393480261),(97,'保质期不符',123,1393480261),(98,'认为是假货',123,1393480261),(99,'不能按时发货',123,1393480261);

/*Table structure for table `feiwa_refund_return` */

DROP TABLE IF EXISTS `feiwa_refund_return`;

CREATE TABLE `feiwa_refund_return` (
  `refund_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `order_id` int(10) unsigned NOT NULL COMMENT '订单ID',
  `order_sn` varchar(50) NOT NULL DEFAULT '' COMMENT '订单编号',
  `refund_sn` varchar(50) NOT NULL DEFAULT '' COMMENT '申请编号',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺ID',
  `store_name` varchar(20) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `buyer_id` int(10) unsigned NOT NULL COMMENT '买家ID',
  `buyer_name` varchar(50) NOT NULL DEFAULT '' COMMENT '买家会员名',
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品ID,全部退款是0',
  `order_goods_id` int(10) unsigned DEFAULT '0' COMMENT '订单商品ID,全部退款是0',
  `goods_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_num` int(10) unsigned DEFAULT '1' COMMENT '商品数量',
  `refund_amount` decimal(10,2) DEFAULT '0.00' COMMENT '退款金额',
  `goods_image` varchar(100) DEFAULT NULL COMMENT '商品图片',
  `order_goods_type` tinyint(1) unsigned DEFAULT '1' COMMENT '订单商品类型:1默认2团购商品3限时折扣商品4组合套装',
  `refund_type` tinyint(1) unsigned DEFAULT '1' COMMENT '申请类型:1为退款,2为退货,默认为1',
  `seller_state` tinyint(1) unsigned DEFAULT '1' COMMENT '卖家处理状态:1为待审核,2为同意,3为不同意,默认为1',
  `refund_state` tinyint(1) unsigned DEFAULT '1' COMMENT '申请状态:1为处理中,2为待管理员处理,3为已完成,默认为1',
  `return_type` tinyint(1) unsigned DEFAULT '1' COMMENT '退货类型:1为不用退货,2为需要退货,默认为1',
  `order_lock` tinyint(1) unsigned DEFAULT '1' COMMENT '订单锁定类型:1为不用锁定,2为需要锁定,默认为1',
  `goods_state` tinyint(1) unsigned DEFAULT '1' COMMENT '物流状态:1为待发货,2为待收货,3为未收到,4为已收货,默认为1',
  `add_time` int(10) unsigned NOT NULL COMMENT '添加时间',
  `seller_time` int(10) unsigned DEFAULT '0' COMMENT '卖家处理时间',
  `admin_time` int(10) unsigned DEFAULT '0' COMMENT '管理员处理时间,默认为0',
  `reason_id` int(10) unsigned DEFAULT '0' COMMENT '原因ID:0为其它',
  `reason_info` varchar(300) DEFAULT '' COMMENT '原因内容',
  `pic_info` varchar(300) DEFAULT '' COMMENT '图片',
  `buyer_message` varchar(300) DEFAULT NULL COMMENT '申请原因',
  `seller_message` varchar(300) DEFAULT NULL COMMENT '卖家备注',
  `admin_message` varchar(300) DEFAULT NULL COMMENT '管理员备注',
  `express_id` tinyint(1) unsigned DEFAULT '0' COMMENT '物流公司编号',
  `invoice_no` varchar(50) DEFAULT NULL COMMENT '物流单号',
  `ship_time` int(10) unsigned DEFAULT '0' COMMENT '发货时间,默认为0',
  `delay_time` int(10) unsigned DEFAULT '0' COMMENT '收货延迟时间,默认为0',
  `receive_time` int(10) unsigned DEFAULT '0' COMMENT '收货时间,默认为0',
  `receive_message` varchar(300) DEFAULT NULL COMMENT '收货备注',
  `commis_rate` smallint(6) DEFAULT '0' COMMENT '佣金比例',
  `rpt_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '退款红包值，默认0，只有全部退款时才把该订单使用的红包金额写到此处',
  PRIMARY KEY (`refund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退款退货表';

/*Data for the table `feiwa_refund_return` */

/*Table structure for table `feiwa_seller` */

DROP TABLE IF EXISTS `feiwa_seller`;

CREATE TABLE `feiwa_seller` (
  `seller_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '卖家编号',
  `seller_name` varchar(50) NOT NULL DEFAULT '' COMMENT '卖家用户名',
  `member_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `seller_group_id` int(10) unsigned NOT NULL COMMENT '卖家组编号',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺编号',
  `is_admin` tinyint(3) unsigned NOT NULL COMMENT '是否管理员(0-不是 1-是)',
  `seller_quicklink` varchar(255) DEFAULT NULL COMMENT '卖家快捷操作',
  `last_login_time` int(10) unsigned DEFAULT NULL COMMENT '最后登录时间',
  `is_client` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否客户端用户 0-否 1-是',
  PRIMARY KEY (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='卖家用户表';

/*Data for the table `feiwa_seller` */

insert  into `feiwa_seller`(`seller_id`,`seller_name`,`member_id`,`seller_group_id`,`store_id`,`is_admin`,`seller_quicklink`,`last_login_time`,`is_client`) values (1,'seller',1,0,1,1,NULL,1536136541,0),(6,'zxx2cndns',1041,0,6,1,NULL,1536137254,0),(7,'fengfeng',1042,0,7,1,NULL,1510813922,0),(8,'adminy',1043,0,8,1,NULL,1536818044,0),(9,'cliffgyn',1044,0,9,1,NULL,1513702029,0),(10,'tianhe',1050,0,10,1,NULL,1515311279,0),(11,'12345',1052,0,11,1,NULL,1515752693,0),(12,'123456',1055,0,12,1,NULL,1516072178,0),(13,'xiaozhaidian',1057,0,13,1,NULL,1517890541,0),(14,'诶我俄文问',1061,0,14,1,NULL,NULL,0);

/*Table structure for table `feiwa_seller_group` */

DROP TABLE IF EXISTS `feiwa_seller_group`;

CREATE TABLE `feiwa_seller_group` (
  `group_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '卖家组编号',
  `group_name` varchar(50) NOT NULL DEFAULT '' COMMENT '组名',
  `limits` text NOT NULL COMMENT '权限',
  `smt_limits` text COMMENT '消息权限范围',
  `gc_limits` tinyint(3) unsigned DEFAULT '1' COMMENT '1拥有所有分类权限，0拥有部分分类权限',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺编号',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='卖家用户组表';

/*Data for the table `feiwa_seller_group` */

insert  into `feiwa_seller_group`(`group_id`,`group_name`,`limits`,`smt_limits`,`gc_limits`,`store_id`) values (1,'admin','store_goods_add,store_goods_online,store_goods_offline,store_appoint,store_plate,store_spec,store_album,store_order,store_vr_order,store_deliver,store_deliver_set,store_waybill,store_evaluate,store_transport,order_call,store_groupbuy,store_promotion_cou,store_promotion_xianshi,store_promotion_mansong,store_promotion_bundling,store_promotion_booth,store_promotion_book,store_promotion_fcode,store_promotion_combo,store_promotion_sole,store_voucher,store_activity,store_setting,store_decoration,store_navigation,store_sns,store_info,store_goods_class,store_brand,store_supplier,store_map,store_contract,store_consult,store_complain,store_refund,store_return,statistics_general,statistics_goods,statistics_sale,statistics_industry,statistics_flow,store_bill,store_vr_bill,taobao_caiji,taobao_import,store_callcenter,store_msg,store_im,store_account,store_account_group,seller_log,store_cost,store_chain','complain,goods_storage_alarm,goods_verify,goods_violation,new_order,refund,refund_auto_process,return,return_auto_process,return_auto_receipt,store_bill_affirm,store_bill_gathering,store_cost,store_expire',1,8);

/*Table structure for table `feiwa_seller_group_bclass` */

DROP TABLE IF EXISTS `feiwa_seller_group_bclass`;

CREATE TABLE `feiwa_seller_group_bclass` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(11) unsigned DEFAULT '0' COMMENT '权限组ID',
  `class_1` mediumint(9) unsigned DEFAULT '0' COMMENT '一级分类',
  `class_2` mediumint(9) unsigned DEFAULT '0' COMMENT '二级分类',
  `class_3` mediumint(9) unsigned DEFAULT '0' COMMENT '三级分类',
  `gc_id` mediumint(9) unsigned DEFAULT '0' COMMENT '最底级分类',
  PRIMARY KEY (`bid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家内部组商品类目表';

/*Data for the table `feiwa_seller_group_bclass` */

/*Table structure for table `feiwa_seller_log` */

DROP TABLE IF EXISTS `feiwa_seller_log`;

CREATE TABLE `feiwa_seller_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '日志编号',
  `log_content` varchar(500) NOT NULL DEFAULT '' COMMENT '日志内容',
  `log_time` int(10) unsigned NOT NULL COMMENT '日志时间',
  `log_seller_id` int(10) unsigned NOT NULL COMMENT '卖家编号',
  `log_seller_name` varchar(50) NOT NULL DEFAULT '' COMMENT '卖家账号',
  `log_store_id` int(10) unsigned NOT NULL COMMENT '店铺编号',
  `log_seller_ip` varchar(50) NOT NULL DEFAULT '' COMMENT '卖家ip',
  `log_url` varchar(50) NOT NULL DEFAULT '' COMMENT '日志url',
  `log_state` tinyint(3) unsigned NOT NULL COMMENT '日志状态(0-失败 1-成功)',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=678 DEFAULT CHARSET=utf8 COMMENT='卖家日志表';

/*Data for the table `feiwa_seller_log` */

insert  into `feiwa_seller_log`(`log_id`,`log_content`,`log_time`,`log_seller_id`,`log_seller_name`,`log_store_id`,`log_seller_ip`,`log_url`,`log_state`) values (234,'登录成功',1510544226,1,'seller',1,'114.80.215.216','seller_login&login',1),(235,'注销成功',1510544722,1,'seller',1,'114.80.215.216','seller_logout&logout',1),(236,'登录成功',1510625531,1,'seller',1,'114.80.215.216','seller_login&login',1),(237,'注销成功',1510625589,1,'seller',1,'114.80.215.216','seller_logout&logout',1),(238,'登录成功',1510626017,1,'seller',1,'114.80.215.216','seller_login&login',1),(239,'登录成功',1510646926,1,'seller',1,'114.80.153.110','seller_login&login',1),(240,'添加商品，SPU:100100',1510647058,1,'seller',1,'114.80.153.110','goodsLogic&saveGoods',1),(241,'添加商品，SPU:100101',1510647495,1,'seller',1,'114.80.153.110','goodsLogic&saveGoods',1),(242,'注销成功',1510650313,1,'seller',1,'114.80.153.110','seller_logout&logout',1),(243,'登录成功',1510651339,6,'zxx2cndns',6,'114.80.153.110','seller_login&login',1),(244,'登录成功',1510652311,7,'fengfeng',7,'114.80.215.216','seller_login&login',1),(245,'添加商品，SPU:100102',1510652390,7,'fengfeng',7,'114.80.215.216','goodsLogic&saveGoods',1),(246,'添加商品，SPU:100103',1510653691,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(247,'删除商品，SPU：100103',1510725342,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(248,'删除商品，SPU：100103',1510725342,6,'zxx2cndns',6,'114.80.153.110','store_goods_online&drop_goods',1),(249,'添加商品，SPU:100104',1510725462,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(250,'添加商品，SPU:100105',1510725532,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(251,'添加商品，SPU:100106',1510725591,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(252,'添加商品，SPU:100107',1510725602,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(253,'添加商品，SPU:100108',1510725656,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(254,'添加商品，SPU:100109',1510725743,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(255,'删除商品，SPU：100106',1510725808,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(256,'删除商品，SPU：100106',1510725808,6,'zxx2cndns',6,'114.80.153.110','store_goods_online&drop_goods',1),(257,'添加商品，SPU:100110',1510726115,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(258,'添加商品，SPU:100111',1510726244,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(259,'添加商品，SPU:100112',1510726311,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(260,'添加商品，SPU:100113',1510726385,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(261,'添加商品，SPU:100114',1510726453,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(262,'添加商品，SPU:100115',1510726672,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(263,'添加商品，SPU:100116',1510726752,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(264,'添加商品，SPU:100117',1510726814,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(265,'添加商品，SPU:100118',1510726876,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(266,'添加商品，SPU:100119',1510726937,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(267,'编辑商品，SPU:100109',1510728710,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(268,'添加商品，SPU:100120',1510735302,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(269,'添加商品，SPU:100121',1510735376,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(270,'添加商品，SPU:100122',1510735436,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(271,'添加商品，SPU:100123',1510735491,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(272,'添加商品，SPU:100124',1510735548,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(273,'添加商品，SPU:100125',1510735601,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(274,'添加商品，SPU:100126',1510735654,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(275,'添加商品，SPU:100127',1510735709,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(276,'登录成功',1510797077,8,'adminy',8,'114.80.215.216','seller_login&login',1),(277,'注销成功',1510797401,8,'adminy',8,'114.80.215.216','seller_logout&logout',1),(278,'添加商品，SPU:100128',1510799565,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(279,'添加商品，SPU:100129',1510799644,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(280,'添加商品，SPU:100130',1510799855,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(281,'添加商品，SPU:100131',1510799935,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(282,'添加商品，SPU:100132',1510800004,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(283,'添加商品，SPU:100133',1510800068,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(284,'添加商品，SPU:100134',1510800135,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(285,'添加商品，SPU:100135',1510800212,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(286,'添加商品，SPU:100136',1510811008,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(287,'添加商品，SPU:100137',1510811078,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(288,'添加商品，SPU:100138',1510811154,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(289,'添加商品，SPU:100139',1510811202,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(290,'添加商品，SPU:100140',1510811253,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(291,'添加商品，SPU:100141',1510811310,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(292,'添加商品，SPU:100142',1510811363,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(293,'添加商品，SPU:100143',1510811419,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(294,'添加商品，SPU:100144',1510812565,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(295,'添加商品，SPU:100145',1510812623,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(296,'添加商品，SPU:100146',1510812688,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(297,'添加商品，SPU:100147',1510812729,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(298,'添加商品，SPU:100148',1510812784,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(299,'添加商品，SPU:100149',1510812841,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(300,'添加商品，SPU:100150',1510812889,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(301,'添加商品，SPU:100151',1510812929,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(302,'添加商品，SPU:100152',1510812972,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(303,'登录成功',1510813922,7,'fengfeng',7,'114.80.215.216','seller_login&login',1),(304,'购买2份团购套餐，单价10元',1510814164,7,'fengfeng',7,'114.80.215.216','store_groupbuy&groupbuy_quota_add_save',1),(305,'添加商品，SPU:100153',1510814548,7,'fengfeng',7,'114.80.215.216','goodsLogic&saveGoods',1),(306,'发布团购活动，团购名称：名称，商品名称：华为 HUAWEI Mate 10 4GB+64GB',1510814987,7,'fengfeng',7,'114.80.215.216','store_groupbuy&groupbuy_save',1),(307,'购买2套推荐展位，单价20元',1510815142,7,'fengfeng',7,'114.80.215.216','store_promotion_booth&booth_quota_add',1),(308,'注销成功',1510815341,7,'fengfeng',7,'114.80.215.216','seller_logout&logout',1),(309,'登录成功',1510815572,6,'zxx2cndns',6,'114.80.215.216','seller_login&login',1),(310,'购买2份团购套餐，单价10元',1510815594,6,'zxx2cndns',6,'114.80.215.216','store_groupbuy&groupbuy_quota_add_save',1),(311,'发布团购活动，团购名称：抢购手机，商品名称：女性音乐手机',1510815751,6,'zxx2cndns',6,'114.80.215.216','store_groupbuy&groupbuy_save',1),(312,'购买2套推荐展位，单价20元',1510815906,6,'zxx2cndns',6,'114.80.215.216','store_promotion_booth&booth_quota_add',1),(313,'添加推荐展位商品，商品id：100210',1510815927,6,'zxx2cndns',6,'114.80.215.216','store_promotion_booth&choosed_goods',1),(314,'添加推荐展位商品，商品id：100209',1510815929,6,'zxx2cndns',6,'114.80.215.216','store_promotion_booth&choosed_goods',1),(315,'添加推荐展位商品，商品id：100205',1510815935,6,'zxx2cndns',6,'114.80.215.216','store_promotion_booth&choosed_goods',1),(316,'添加商品，SPU:100154',1510816306,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(317,'添加商品，SPU:100155',1510816457,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(318,'添加商品，SPU:100156',1510816499,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(319,'添加商品，SPU:100157',1510816545,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(320,'添加商品，SPU:100158',1510816581,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(321,'添加商品，SPU:100159',1510816630,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(322,'添加商品，SPU:100160',1510816675,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(323,'添加商品，SPU:100161',1510816714,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(324,'购买10份加价购套餐，单价20',1510884810,6,'zxx2cndns',6,'114.80.153.110','store_promotion_cou&cou_quota_add_save',1),(325,'购买10份限时折扣套餐，单价11',1510884826,6,'zxx2cndns',6,'114.80.153.110','store_promotion_xianshi&xianshi_quota_add_save',1),(326,'编辑商品，SPU:100161',1510885002,6,'zxx2cndns',6,'114.80.153.110','goodsLogic&saveGoods',1),(327,'登录成功',1510891048,6,'zxx2cndns',6,'114.80.215.216','seller_login&login',1),(328,'登录成功',1510900535,6,'zxx2cndns',6,'114.80.153.110','seller_login&login',1),(329,'登录成功',1510901910,8,'adminy',8,'114.80.153.110','seller_login&login',1),(330,'登录成功',1510902291,8,'adminy',8,'114.80.215.216','seller_login&login',1),(331,'购买12份满即送套餐，单价20元',1510908607,6,'zxx2cndns',6,'114.80.153.110','store_promotion_mansong&mansong_quota_add_save',1),(332,'登录成功',1511156656,8,'adminy',8,'114.80.215.216','seller_login&login',1),(333,'添加组成功，组编号1',1511156695,8,'adminy',8,'114.80.215.216','store_account_group&group_save',1),(334,'注销成功',1511157059,8,'adminy',8,'114.80.215.216','seller_logout&logout',1),(342,'登录成功',1512526966,8,'adminy',8,'114.80.153.110','seller_login&login',1),(343,'登录成功',1513218192,8,'adminy',8,'114.80.215.216','seller_login&login',1),(344,'登录成功',1513218273,8,'adminy',8,'203.156.222.82','seller_login&login',1),(345,'登录成功',1513323524,8,'adminy',8,'114.80.153.110','seller_login&login',1),(346,'登录成功',1513648156,8,'adminy',8,'114.80.153.110','seller_login&login',1),(347,'登录成功',1513649264,8,'adminy',8,'114.80.153.110','seller_login&login',1),(348,'登录成功',1513661651,8,'adminy',8,'203.156.222.82','seller_login&login',1),(349,'登录成功',1513676115,8,'adminy',8,'203.156.222.82','seller_login&login',1),(350,'登录成功',1513682690,8,'adminy',8,'203.156.222.82','seller_login&login',1),(351,'注销成功',1513682730,8,'adminy',8,'203.156.222.82','seller_logout&logout',1),(352,'登录成功',1513682775,8,'adminy',8,'203.156.222.82','seller_login&login',1),(353,'登录成功',1513696022,8,'adminy',8,'60.176.87.10','seller_login&login',1),(354,'购买1份团购套餐，单价10元',1513696037,8,'adminy',8,'60.176.87.10','store_groupbuy&groupbuy_quota_add_save',1),(355,'新增店铺导航，导航编号1',1513696652,8,'adminy',8,'60.176.87.10','store_navigation&navigation_save',1),(356,'新增店铺导航，导航编号2',1513696665,8,'adminy',8,'60.176.87.10','store_navigation&navigation_save',1),(357,'注销成功',1513697917,8,'adminy',8,'60.176.87.10','seller_logout&logout',1),(358,'登录成功',1513702029,9,'cliffgyn',9,'202.75.219.14','seller_login&login',1),(359,'添加商品，SPU:100162',1513703351,9,'cliffgyn',9,'202.75.219.14','goodsLogic&saveGoods',1),(360,'登录成功',1513751294,8,'adminy',8,'114.80.215.216','seller_login&login',1),(361,'注销成功',1513751492,8,'adminy',8,'114.80.215.216','seller_logout&logout',1),(362,'登录成功',1513751515,1,'seller',1,'114.80.215.216','seller_login&login',1),(363,'注销成功',1513751693,1,'seller',1,'114.80.215.216','seller_logout&logout',1),(364,'登录成功',1513751715,1,'seller',1,'114.80.215.216','seller_login&login',1),(365,'登录成功',1513751898,8,'adminy',8,'114.80.215.216','seller_login&login',1),(366,'登录成功',1513752692,8,'adminy',8,'203.156.222.82','seller_login&login',1),(367,'登录成功',1513756687,8,'adminy',8,'116.226.152.85','seller_login&login',1),(368,'登录成功',1513764087,8,'adminy',8,'203.156.222.82','seller_login&login',1),(369,'登录成功',1513820048,8,'adminy',8,'203.156.222.82','seller_login&login',1),(370,'登录成功',1513820302,8,'adminy',8,'203.156.222.82','seller_login&login',1),(371,'添加商品，SPU:100163',1513824233,8,'adminy',8,'203.156.222.82','goodsLogic&saveGoods',1),(372,'登录成功',1513827586,8,'adminy',8,'203.156.222.82','seller_login&login',1),(373,'登录成功',1513836076,8,'adminy',8,'203.156.222.82','seller_login&login',1),(374,'登录成功',1513838941,8,'adminy',8,'114.80.153.110','seller_login&login',1),(375,'登录成功',1513864009,8,'adminy',8,'173.68.200.146','seller_login&login',1),(376,'登录成功',1513917063,8,'adminy',8,'203.156.222.82','seller_login&login',1),(377,'登录成功',1513920376,8,'adminy',8,'14.204.0.231','seller_login&login',1),(378,'登录成功',1513942672,8,'adminy',8,'111.50.232.8','seller_login&login',1),(379,'登录成功',1514165082,8,'adminy',8,'203.156.222.82','seller_login&login',1),(380,'登录成功',1514190905,8,'adminy',8,'203.156.222.82','seller_login&login',1),(381,'登录成功',1514194192,8,'adminy',8,'203.156.222.82','seller_login&login',1),(382,'登录成功',1514194687,8,'adminy',8,'203.156.222.82','seller_login&login',1),(383,'添加商品，SPU:100164',1514195067,8,'adminy',8,'203.156.222.82','goodsLogic&saveGoods',1),(384,'登录成功',1514197268,8,'adminy',8,'124.207.198.33','seller_login&login',1),(385,'登录成功',1514276044,8,'adminy',8,'203.156.222.82','seller_login&login',1),(386,'登录成功',1514346559,8,'adminy',8,'114.80.153.110','seller_login&login',1),(387,'登录成功',1514354680,8,'adminy',8,'203.156.222.82','seller_login&login',1),(388,'登录成功',1514358572,8,'adminy',8,'113.65.206.195','seller_login&login',1),(389,'登录成功',1514358683,8,'adminy',8,'39.65.91.224','seller_login&login',1),(390,'登录成功',1514363413,8,'adminy',8,'203.156.222.82','seller_login&login',1),(391,'登录成功',1514366120,8,'adminy',8,'203.156.222.82','seller_login&login',1),(392,'登录成功',1514367089,8,'adminy',8,'203.156.222.82','seller_login&login',1),(393,'登录成功',1514368669,8,'adminy',8,'203.156.222.82','seller_login&login',1),(394,'登录成功',1514424815,8,'adminy',8,'73.142.74.169','seller_login&login',1),(395,'登录成功',1514424838,8,'adminy',8,'74.72.7.50','seller_login&login',1),(396,'登录成功',1514437482,8,'adminy',8,'39.65.91.224','seller_login&login',1),(397,'登录成功',1514443797,8,'adminy',8,'113.87.182.51','seller_login&login',1),(398,'登录成功',1514447502,8,'adminy',8,'203.156.222.82','seller_login&login',1),(399,'登录成功',1514515801,8,'adminy',8,'139.170.69.14','seller_login&login',1),(400,'登录成功',1514538932,8,'adminy',8,'203.156.222.82','seller_login&login',1),(401,'登录成功',1514880914,8,'adminy',8,'203.156.222.82','seller_login&login',1),(402,'登录成功',1514882605,8,'adminy',8,'203.156.222.82','seller_login&login',1),(403,'登录成功',1514968453,8,'adminy',8,'111.50.93.103','seller_login&login',1),(404,'登录成功',1515023725,8,'adminy',8,'112.65.188.191','seller_login&login',1),(405,'登录成功',1515038103,8,'adminy',8,'203.156.222.82','seller_login&login',1),(406,'登录成功',1515047026,8,'adminy',8,'116.227.226.36','seller_login&login',1),(407,'购买2份代金券套餐，单价20元',1515047153,8,'adminy',8,'116.227.226.36','store_voucher&quotaadd',1),(408,'登录成功',1515143203,8,'adminy',8,'113.65.204.190','seller_login&login',1),(409,'登录成功',1515143582,8,'adminy',8,'113.65.204.190','seller_login&login',1),(410,'登录成功',1515143984,8,'adminy',8,'114.80.153.110','seller_login&login',1),(411,'登录成功',1515162216,8,'adminy',8,'58.40.237.181','seller_login&login',1),(412,'登录成功',1515309903,8,'adminy',8,'114.80.153.110','seller_login&login',1),(413,'注销成功',1515311264,8,'adminy',8,'114.80.153.110','seller_logout&logout',1),(414,'登录成功',1515311279,10,'tianhe',10,'114.80.153.110','seller_login&login',1),(415,'登录成功',1515337753,8,'adminy',8,'222.82.236.102','seller_login&login',1),(416,'登录成功',1515480296,8,'adminy',8,'114.80.153.110','seller_login&login',1),(417,'登录成功',1515547004,8,'adminy',8,'203.156.222.82','seller_login&login',1),(418,'登录成功',1515547925,8,'adminy',8,'203.156.222.82','seller_login&login',1),(419,'登录成功',1515550124,8,'adminy',8,'116.25.146.51','seller_login&login',1),(420,'登录成功',1515550348,8,'adminy',8,'203.156.222.82','seller_login&login',1),(421,'登录成功',1515555908,8,'adminy',8,'101.81.249.167','seller_login&login',1),(422,'添加组成功，组编号2',1515562595,8,'adminy',8,'203.156.222.82','store_account_group&group_save',1),(423,'删除组成功，组编号2',1515562603,8,'adminy',8,'203.156.222.82','store_account_group&group_del',1),(424,'登录成功',1515566432,8,'adminy',8,'203.156.222.82','seller_login&login',1),(425,'登录成功',1515567071,11,'12345',11,'203.156.222.82','seller_login&login',1),(426,'删除店铺导航，导航编号1',1515567404,8,'adminy',8,'203.156.222.82','store_navigation&navigation_del',1),(427,'删除店铺导航，导航编号2',1515567407,8,'adminy',8,'203.156.222.82','store_navigation&navigation_del',1),(428,'新增店铺导航，导航编号3',1515567435,8,'adminy',8,'203.156.222.82','store_navigation&navigation_save',1),(429,'新增店铺导航，导航编号4',1515567445,8,'adminy',8,'203.156.222.82','store_navigation&navigation_save',1),(430,'登录成功',1515571480,8,'adminy',8,'203.156.222.82','seller_login&login',1),(431,'登录成功',1515575986,8,'adminy',8,'203.156.222.82','seller_login&login',1),(432,'登录成功',1515576212,8,'adminy',8,'58.16.187.173','seller_login&login',1),(433,'登录成功',1515578265,8,'adminy',8,'203.156.222.82','seller_login&login',1),(434,'登录成功',1515631667,8,'adminy',8,'113.65.204.163','seller_login&login',1),(435,'商品上架，SPU:100165',1515632255,8,'adminy',8,'113.65.204.163','goodsLogic&saveGoods',1),(436,'注销成功',1515632275,8,'adminy',8,'113.65.204.163','seller_logout&logout',1),(437,'登录成功',1515655937,8,'adminy',8,'203.156.222.82','seller_login&login',1),(438,'登录成功',1515722842,8,'adminy',8,'203.156.222.82','seller_login&login',1),(439,'登录成功',1515723937,8,'adminy',8,'203.156.222.82','seller_login&login',1),(440,'添加商品，SPU:100166',1515743840,8,'adminy',8,'203.156.222.82','goodsLogic&saveGoods',1),(441,'登录成功',1515752638,8,'adminy',8,'203.156.222.82','seller_login&login',1),(442,'注销成功',1515752672,8,'adminy',8,'203.156.222.82','seller_logout&logout',1),(443,'登录成功',1515752693,11,'12345',11,'203.156.222.82','seller_login&login',1),(444,'添加商品，SPU:100167',1515753090,11,'12345',11,'203.156.222.82','goodsLogic&saveGoods',1),(445,'登录成功',1516008461,8,'adminy',8,'223.166.186.121','seller_login&login',1),(446,'登录成功',1516067383,8,'adminy',8,'111.73.131.108','seller_login&login',1),(447,'登录成功',1516068115,8,'adminy',8,'114.80.153.110','seller_login&login',1),(448,'登录成功',1516069980,8,'adminy',8,'111.73.131.108','seller_login&login',1),(449,'注销成功',1516070869,8,'adminy',8,'111.73.131.108','seller_logout&logout',1),(450,'登录成功',1516072178,12,'123456',12,'111.73.131.108','seller_login&login',1),(451,'登录成功',1516091866,8,'adminy',8,'113.111.9.135','seller_login&login',1),(452,'登录成功',1516179134,8,'adminy',8,'203.156.222.82','seller_login&login',1),(453,'登录成功',1516179210,8,'adminy',8,'203.156.222.82','seller_login&login',1),(454,'登录成功',1516245512,8,'adminy',8,'203.156.222.82','seller_login&login',1),(455,'登录成功',1516254225,8,'adminy',8,'183.129.211.50','seller_login&login',1),(456,'编辑商品，SPU:100166',1516254485,8,'adminy',8,'183.129.211.50','goodsLogic&saveGoods',1),(457,'登录成功',1516269964,8,'adminy',8,'203.156.222.82','seller_login&login',1),(458,'登录成功',1516327343,8,'adminy',8,'124.207.198.33','seller_login&login',1),(459,'登录成功',1516343732,8,'adminy',8,'116.25.147.88','seller_login&login',1),(460,'登录成功',1516585637,8,'adminy',8,'183.129.211.50','seller_login&login',1),(461,'登录成功',1516585833,8,'adminy',8,'139.226.74.67','seller_login&login',1),(462,'注销成功',1516586947,8,'adminy',8,'139.226.74.67','seller_logout&logout',1),(463,'登录成功',1516666779,8,'adminy',8,'39.65.91.224','seller_login&login',1),(464,'登录成功',1516954430,8,'adminy',8,'139.170.124.131','seller_login&login',1),(465,'登录成功',1517110833,8,'adminy',8,'218.60.71.117','seller_login&login',1),(466,'添加商品，SPU:100168',1517112005,8,'adminy',8,'218.60.71.117','goodsLogic&saveGoods',1),(467,'登录成功',1517467481,8,'adminy',8,'183.129.211.50','seller_login&login',1),(468,'登录成功',1517535645,8,'adminy',8,'183.129.211.50','seller_login&login',1),(469,'登录成功',1517544430,8,'adminy',8,'183.199.184.217','seller_login&login',1),(470,'购买1份团购套餐，单价10元',1517548677,8,'adminy',8,'183.199.184.217','store_groupbuy&groupbuy_quota_add_save',1),(471,'登录成功',1517557493,8,'adminy',8,'203.156.222.82','seller_login&login',1),(472,'登录成功',1517572115,8,'adminy',8,'203.156.222.82','seller_login&login',1),(473,'登录成功',1517714890,8,'adminy',8,'124.207.198.33','seller_login&login',1),(474,'登录成功',1517817720,8,'adminy',8,'203.156.222.82','seller_login&login',1),(475,'登录成功',1517821244,8,'adminy',8,'223.104.210.203','seller_login&login',1),(476,'添加商品，SPU:100169',1517821382,8,'adminy',8,'223.104.210.203','goodsLogic&saveGoods',1),(477,'登录成功',1517843057,8,'adminy',8,'1.197.29.99','seller_login&login',1),(478,'登录成功',1517843794,8,'adminy',8,'1.197.29.99','seller_login&login',1),(479,'登录成功',1517844419,8,'adminy',8,'59.63.206.82','seller_login&login',1),(480,'登录成功',1517889301,13,'xiaozhaidian',13,'117.35.158.214','seller_login&login',1),(481,'登录成功',1517890541,13,'xiaozhaidian',13,'117.35.158.214','seller_login&login',1),(482,'登录成功',1517983315,8,'adminy',8,'','seller_login&login',1),(483,'登录成功',1518002218,8,'adminy',8,'180.168.82.62','seller_login&login',1),(484,'登录成功',1519870038,8,'adminy',8,'203.156.222.82','seller_login&login',1),(485,'登录成功',1519955918,8,'adminy',8,'114.80.153.110','seller_login&login',1),(486,'登录成功',1520317961,8,'adminy',8,'203.156.222.82','seller_login&login',1),(487,'登录成功',1520320193,8,'adminy',8,'222.65.188.61','seller_login&login',1),(488,'登录成功',1520320314,8,'adminy',8,'222.65.188.61','seller_login&login',1),(489,'登录成功',1520402548,8,'adminy',8,'113.87.181.146','seller_login&login',1),(490,'登录成功',1520402887,8,'adminy',8,'113.87.181.146','seller_login&login',1),(491,'登录成功',1520500679,8,'adminy',8,'118.144.131.160','seller_login&login',1),(492,'登录成功',1521094783,8,'adminy',8,'49.83.111.3','seller_login&login',1),(493,'登录成功',1521103755,8,'adminy',8,'113.87.183.131','seller_login&login',1),(494,'登录成功',1521103920,8,'adminy',8,'114.80.153.110','seller_login&login',1),(495,'登录成功',1521175835,8,'adminy',8,'114.236.146.173','seller_login&login',1),(496,'注销成功',1521175874,8,'adminy',8,'114.236.146.173','seller_logout&logout',1),(497,'登录成功',1521187399,8,'adminy',8,'114.80.153.110','seller_login&login',1),(498,'登录成功',1521376840,8,'adminy',8,'1.197.240.246','seller_login&login',1),(499,'登录成功',1521393966,8,'adminy',8,'1.82.229.203','seller_login&login',1),(500,'登录成功',1521437447,8,'adminy',8,'113.89.238.238','seller_login&login',1),(501,'登录成功',1521438640,8,'adminy',8,'114.80.153.110','seller_login&login',1),(502,'登录成功',1521596478,8,'adminy',8,'58.56.159.78','seller_login&login',1),(503,'登录成功',1521620477,8,'adminy',8,'27.38.56.117','seller_login&login',1),(504,'登录成功',1521620494,8,'adminy',8,'27.38.56.117','seller_login&login',1),(505,'登录成功',1521620746,8,'adminy',8,'211.159.154.193','seller_login&login',1),(506,'登录成功',1521622854,8,'adminy',8,'27.38.56.117','seller_login&login',1),(507,'登录成功',1521718847,8,'adminy',8,'113.89.250.109','seller_login&login',1),(508,'登录成功',1521803244,8,'adminy',8,'114.80.153.110','seller_login&login',1),(509,'登录成功',1521929992,8,'adminy',8,'59.63.206.215','seller_login&login',1),(510,'登录成功',1522034907,8,'adminy',8,'117.40.114.226','seller_login&login',1),(511,'登录成功',1522035353,8,'adminy',8,'117.40.114.226','seller_login&login',1),(512,'登录成功',1522212550,8,'adminy',8,'220.178.225.24','seller_login&login',1),(513,'登录成功',1522485934,8,'adminy',8,'117.141.142.51','seller_login&login',1),(514,'登录成功',1522640009,8,'adminy',8,'27.210.114.165','seller_login&login',1),(515,'登录成功',1522648192,8,'adminy',8,'203.156.222.82','seller_login&login',1),(516,'登录成功',1522649994,8,'adminy',8,'114.235.146.38','seller_login&login',1),(517,'登录成功',1522652429,8,'adminy',8,'171.221.148.229','seller_login&login',1),(518,'登录成功',1522743749,8,'adminy',8,'223.166.144.139','seller_login&login',1),(519,'新增店铺导航，导航编号5',1522745404,8,'adminy',8,'223.166.144.139','store_navigation&navigation_save',1),(520,'新增店铺导航，导航编号6',1522745421,8,'adminy',8,'223.166.144.139','store_navigation&navigation_save',1),(521,'新增店铺导航，导航编号7',1522745430,8,'adminy',8,'223.166.144.139','store_navigation&navigation_save',1),(522,'新增店铺导航，导航编号8',1522745438,8,'adminy',8,'223.166.144.139','store_navigation&navigation_save',1),(523,'新增店铺导航，导航编号9',1522745450,8,'adminy',8,'223.166.144.139','store_navigation&navigation_save',1),(524,'删除店铺导航，导航编号9',1522745520,8,'adminy',8,'223.166.144.139','store_navigation&navigation_del',1),(525,'删除店铺导航，导航编号9',1522745522,8,'adminy',8,'223.166.144.139','store_navigation&navigation_del',1),(526,'删除店铺导航，导航编号8',1522745527,8,'adminy',8,'223.166.144.139','store_navigation&navigation_del',1),(527,'添加商品，SPU:100170',1522752383,8,'adminy',8,'223.166.144.139','goodsLogic&saveGoods',1),(528,'编辑商品，SPU:100169',1522753565,8,'adminy',8,'223.166.144.139','goodsLogic&saveGoods',1),(529,'登录成功',1522806114,8,'adminy',8,'114.80.215.216','seller_login&login',1),(530,'登录成功',1523161011,8,'adminy',8,'114.80.153.110','seller_login&login',1),(531,'登录成功',1523169399,8,'adminy',8,'113.89.237.217','seller_login&login',1),(532,'登录成功',1523174394,8,'adminy',8,'113.64.195.16','seller_login&login',1),(533,'登录成功',1523175420,8,'adminy',8,'114.80.215.216','seller_login&login',1),(534,'登录成功',1523240128,8,'adminy',8,'113.111.10.228','seller_login&login',1),(535,'登录成功',1523259928,8,'adminy',8,'125.120.212.75','seller_login&login',1),(536,'登录成功',1523328180,8,'adminy',8,'125.119.247.55','seller_login&login',1),(537,'登录成功',1523603730,1,'seller',1,'113.89.249.228','seller_login&login',1),(538,'登录成功',1523614039,1,'seller',1,'113.89.249.228','seller_login&login',1),(539,'登录成功',1523848764,8,'adminy',8,'114.80.153.110','seller_login&login',1),(540,'登录成功',1523956590,8,'adminy',8,'114.80.153.110','seller_login&login',1),(541,'登录成功',1523956621,8,'adminy',8,'183.128.223.252','seller_login&login',1),(542,'登录成功',1524557509,8,'adminy',8,'139.170.125.85','seller_login&login',1),(543,'登录成功',1524705695,8,'adminy',8,'114.80.153.110','seller_login&login',1),(544,'登录成功',1525064185,8,'adminy',8,'114.80.153.110','seller_login&login',1),(545,'登录成功',1525064230,8,'adminy',8,'113.89.71.148','seller_login&login',1),(546,'添加商品，SPU:100171',1525070658,8,'adminy',8,'113.89.71.148','goodsLogic&saveGoods',1),(547,'登录成功',1525346813,8,'adminy',8,'183.140.16.187','seller_login&login',1),(548,'登录成功',1525402831,8,'adminy',8,'203.156.222.82','seller_login&login',1),(549,'登录成功',1525679499,8,'adminy',8,'203.156.222.82','seller_login&login',1),(550,'注销成功',1525680328,8,'adminy',8,'203.156.222.82','seller_logout&logout',1),(551,'登录成功',1525681150,6,'zxx2cndns',6,'203.156.222.82','seller_login&login',1),(552,'登录成功',1525747214,6,'zxx2cndns',6,'203.156.222.82','seller_login&login',1),(553,'登录成功',1525747704,6,'zxx2cndns',6,'203.156.222.82','seller_login&login',1),(554,'删除商品，SPU：100161,100160,100159,100158,100157,100156,100155,100154,100152,100151',1525747781,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(555,'删除商品，SPU：100161,100160,100159,100158,100157,100156,100155,100154,100152,100151',1525747781,6,'zxx2cndns',6,'203.156.222.82','store_goods_online&drop_goods',1),(556,'删除商品，SPU：100150,100149,100148,100147,100146,100145,100144,100143,100142,100141',1525747798,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(557,'删除商品，SPU：100150,100149,100148,100147,100146,100145,100144,100143,100142,100141',1525747798,6,'zxx2cndns',6,'203.156.222.82','store_goods_online&drop_goods',1),(558,'删除商品，SPU：100140,100139,100138,100137,100136,100135,100134,100133,100132,100131',1525747805,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(559,'删除商品，SPU：100140,100139,100138,100137,100136,100135,100134,100133,100132,100131',1525747805,6,'zxx2cndns',6,'203.156.222.82','store_goods_online&drop_goods',1),(560,'删除商品，SPU：100130,100129,100128,100124,100114,100113,100112,100111,100110',1525747811,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(561,'删除商品，SPU：100130,100129,100128,100124,100114,100113,100112,100111,100110',1525747811,6,'zxx2cndns',6,'203.156.222.82','store_goods_online&drop_goods',1),(562,'编辑商品，SPU:100107',1525748190,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(563,'编辑商品，SPU:100105',1525748295,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(564,'编辑商品，SPU:100104',1525748350,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(565,'编辑商品，SPU:100109',1525748594,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(566,'编辑商品，SPU:100108',1525749309,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(567,'编辑商品，SPU:100115',1525749378,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(568,'编辑商品，SPU:100116',1525749483,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(569,'编辑商品，SPU:100117',1525749541,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(570,'编辑商品，SPU:100107',1525750114,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(571,'商品图片编辑，SPU:100107',1525750197,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(572,'商品图片编辑，SPU:100107',1525750226,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(573,'编辑商品，SPU:100107',1525750398,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(574,'商品图片编辑，SPU:100107',1525750419,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(575,'编辑商品，SPU:100107',1525750442,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(576,'编辑商品，SPU:100105',1525750512,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(577,'商品图片编辑，SPU:100105',1525750533,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(578,'商品图片编辑，SPU:100104',1525750558,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(579,'商品图片编辑，SPU:100108',1525750595,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(580,'编辑商品，SPU:100109',1525750661,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(581,'商品图片编辑，SPU:100107',1525751200,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(582,'删除商品，SPU：100116,100115,100109,100108,100107,100105,100104',1525751351,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(583,'删除商品，SPU：100116,100115,100109,100108,100107,100105,100104',1525751351,6,'zxx2cndns',6,'203.156.222.82','store_goods_online&drop_goods',1),(584,'删除商品，SPU：100127,100126,100125,100123,100122,100121,100120,100119,100118,100117',1525751360,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(585,'删除商品，SPU：100127,100126,100125,100123,100122,100121,100120,100119,100118,100117',1525751360,6,'zxx2cndns',6,'203.156.222.82','store_goods_online&drop_goods',1),(586,'添加商品，SPU:100172',1525751447,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(587,'编辑商品，SPU:100172',1525751478,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(588,'添加商品，SPU:100173',1525751561,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(589,'添加商品，SPU:100174',1525751645,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(590,'添加商品，SPU:100175',1525751698,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(591,'添加商品，SPU:100176',1525751839,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(592,'添加商品，SPU:100177',1525751912,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(593,'添加商品，SPU:100178',1525751990,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(594,'添加商品，SPU:100179',1525752049,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(595,'添加商品，SPU:100180',1525752112,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(596,'添加商品，SPU:100181',1525757164,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(597,'删除商品，SPU：100181',1525757181,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(598,'删除商品，SPU：100181',1525757181,6,'zxx2cndns',6,'203.156.222.82','store_goods_online&drop_goods',1),(599,'添加商品，SPU:100182',1525757388,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(600,'添加商品，SPU:100183',1525757442,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(601,'添加商品，SPU:100184',1525757489,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(602,'添加商品，SPU:100185',1525757535,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(603,'添加商品，SPU:100186',1525757583,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(604,'添加商品，SPU:100187',1525757627,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(605,'添加商品，SPU:100188',1525757686,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(606,'添加商品，SPU:100189',1525757730,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(607,'添加商品，SPU:100190',1525757780,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(608,'添加商品，SPU:100191',1525757838,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(609,'添加商品，SPU:100192',1525757892,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(610,'添加商品，SPU:100193',1525757939,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(611,'添加商品，SPU:100194',1525757984,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(612,'添加商品，SPU:100195',1525758031,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(613,'添加商品，SPU:100196',1525758072,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(614,'添加商品，SPU:100197',1525758110,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(615,'添加商品，SPU:100198',1525758158,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(616,'添加商品，SPU:100199',1525758198,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(617,'添加商品，SPU:100200',1525758240,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(618,'添加商品，SPU:100201',1525758287,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(619,'添加商品，SPU:100202',1525758334,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(620,'添加商品，SPU:100203',1525758381,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(621,'添加商品，SPU:100204',1525758425,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(622,'添加商品，SPU:100205',1525758469,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(623,'添加商品，SPU:100206',1525758506,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(624,'添加商品，SPU:100207',1525758571,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(625,'添加商品，SPU:100208',1525758617,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(626,'添加商品，SPU:100209',1525758666,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(627,'添加商品，SPU:100210',1525758727,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(628,'添加商品，SPU:100211',1525758766,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(629,'添加商品，SPU:100212',1525758806,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(630,'添加商品，SPU:100213',1525758854,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(631,'添加商品，SPU:100214',1525758904,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(632,'添加商品，SPU:100215',1525762934,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(633,'添加商品，SPU:100216',1525763160,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(634,'添加商品，SPU:100217',1525763196,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(635,'添加商品，SPU:100218',1525763269,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(636,'添加商品，SPU:100219',1525763388,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(637,'添加商品，SPU:100220',1525763491,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(638,'添加商品，SPU:100221',1525763595,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(639,'添加商品，SPU:100222',1525763663,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(640,'添加商品，SPU:100223',1525765355,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(641,'添加商品，SPU:100224',1525765486,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(642,'添加商品，SPU:100225',1525770689,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(643,'删除商品，SPU：100225',1525771338,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(644,'删除商品，SPU：100225',1525771338,6,'zxx2cndns',6,'203.156.222.82','store_goods_online&drop_goods',1),(645,'登录成功',1525858145,6,'zxx2cndns',6,'203.156.222.82','seller_login&login',1),(646,'登录成功',1527045489,6,'zxx2cndns',6,'203.156.222.82','seller_login&login',1),(647,'添加商品，SPU:100225',1527061008,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(648,'添加商品，SPU:100226',1527061216,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(649,'编辑商品，SPU:100225',1527061453,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(650,'编辑商品，SPU:100226',1527061613,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(651,'编辑商品，SPU:100226',1527061684,6,'zxx2cndns',6,'203.156.222.82','goodsLogic&saveGoods',1),(652,'登录成功',1527132457,8,'adminy',8,'114.80.215.216','seller_login&login',1),(653,'注销成功',1527132873,8,'adminy',8,'114.80.215.216','seller_logout&logout',1),(654,'登录成功',1527132930,6,'zxx2cndns',6,'114.80.215.216','seller_login&login',1),(655,'编辑商品，SPU:100226',1527133237,6,'zxx2cndns',6,'114.80.215.216','goodsLogic&saveGoods',1),(656,'商品图片编辑，SPU:100226',1527133364,6,'zxx2cndns',6,'114.80.215.216','goodsLogic&saveGoods',1),(657,'登录成功',1527323103,1,'seller',1,'119.167.22.11','seller_login&login',1),(658,'登录成功',1528178578,1,'seller',1,'119.167.22.11','seller_login&login',1),(659,'登录成功',1528179676,1,'seller',1,'114.80.215.216','seller_login&login',1),(660,'登录成功',1528280485,1,'seller',1,'119.167.22.11','seller_login&login',1),(661,'登录成功',1529558772,8,'adminy',8,'27.219.158.220','seller_login&login',1),(662,'登录成功',1531373736,8,'adminy',8,'114.80.215.216','seller_login&login',1),(663,'注销成功',1531373776,8,'adminy',8,'114.80.215.216','seller_logout&index',1),(664,'登录成功',1531373841,1,'seller',1,'114.80.215.216','seller_login&login',1),(665,'登录成功',1536057182,8,'adminy',8,'114.80.215.216','seller_login&login',1),(666,'登录成功',1536057281,8,'adminy',8,'203.156.222.82','seller_login&login',1),(667,'购买1份加价购套餐，单价20',1536115056,8,'adminy',8,'203.156.222.82','store_promotion_cou&cou_quota_add_save',1),(668,'添加加价购活动，活动名称：adminy的加价购，活动编号：1',1536115235,8,'adminy',8,'203.156.222.82','store_promotion_cou&cou_add_save',1),(669,'登录成功',1536126712,8,'adminy',8,'114.80.215.216','seller_login&login',1),(670,'登录成功',1536134223,8,'adminy',8,'114.80.215.216','seller_login&login',1),(671,'购买90份团购套餐，单价10元',1536134349,8,'adminy',8,'114.80.215.216','store_groupbuy&index',1),(672,'注销成功',1536134471,8,'adminy',8,'114.80.215.216','seller_logout&index',1),(673,'登录成功',1536134514,1,'seller',1,'114.80.215.216','seller_login&login',1),(674,'登录成功',1536136541,1,'seller',1,'114.80.215.216','seller_login&login',1),(675,'注销成功',1536137096,1,'seller',1,'114.80.215.216','seller_logout&index',1),(676,'登录成功',1536137254,6,'zxx2cndns',6,'114.80.215.216','seller_login&login',1),(677,'登录成功',1536818044,8,'adminy',8,'203.156.222.82','seller_login&login',1);

/*Table structure for table `feiwa_seo` */

DROP TABLE IF EXISTS `feiwa_seo`;

CREATE TABLE `feiwa_seo` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键词',
  `description` text NOT NULL COMMENT '描述',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '类型',
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='SEO信息存放表';

/*Data for the table `feiwa_seo` */

insert  into `feiwa_seo`(`id`,`title`,`keywords`,`description`,`type`) values (1,'{sitename}','{sitename}','{sitename}咨询电话：021','index'),(2,'{sitename} - 团购','testmall,{sitename}','testmall专注于研发符合时代发展需要的电子商务商城系统，以专业化的服务水平为企业级用户提供B(2B)2C【B2B2C】电子商务平台解决方案，全力打造电商平台专项ERP(CRM)系统、ERP(RFID)系统等，引领中国电子商务行业企业级需求的发展方向。咨询电话：021','group'),(3,'{sitename} - {name}','testmall,{name},{sitename}','testmall,{name},{sitename}','group_content'),(4,'{sitename} - 品牌','testmall,{sitename}','testmall,{sitename}','brand'),(5,'{sitename} - {name}','testmall,{sitename},{name}','testmall,{sitename},{name}','brand_list'),(7,'{sitename} - {name}','feiwa,{sitename},{name}','feiwa,{sitename},{name}','coupon_content'),(8,'{sitename} - 积分商城','testmall,{sitename}','testmall,{sitename}','point'),(9,'{sitename} - {name}','testmall,{sitename},{key}','testmall,{sitename},{description}','point_content'),(10,'{sitename} - {article_class}','testmall,{sitename}','testmall,{sitename}','article'),(11,'{sitename} - {name}','testmall,{sitename},{key}','testmall,{sitename},{description}','article_content'),(12,'{sitename} - {shopname}','feiwa,{sitename},{key}','feiwa,{sitename},{description}','shop'),(13,'{name} - {sitename}','testmall,{sitename}','testmall,{sitename}','product'),(14,'看{name}怎么淘到好的宝贝-{sitename}','testmall,{name}','testmall,{name}','sns');

/*Table structure for table `feiwa_setting` */

DROP TABLE IF EXISTS `feiwa_setting`;

CREATE TABLE `feiwa_setting` (
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `value` text COMMENT '值',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统设置表';

/*Data for the table `feiwa_setting` */

insert  into `feiwa_setting`(`name`,`value`) values ('',NULL),('app_qq_akey',''),('app_qq_isuse','0'),('app_qq_skey',''),('app_sina_akey',''),('app_sina_isuse','0'),('app_sina_skey',''),('app_weixin_appid','wx0a2a504b2e162f81'),('app_weixin_isuse','0'),('app_weixin_secret','aa0377f754ffb84f26e0caa5ab0c32e4'),('captcha_status_goodsqa',''),('captcha_status_login',''),('captcha_status_register',''),('cb_isuse','1'),('cb_logo','05131015736444649.jpg'),('cb_seo_dis','速度'),('cb_seo_key','是'),('cb_seo_title','跨境电商频道'),('circle_contentleast','10'),('circle_createsum','6'),('circle_exprelease','2'),('circle_expreleasemax','10'),('circle_expreplied','3'),('circle_exprepliedmax','1000'),('circle_expreply','1'),('circle_intervaltime','1'),('circle_iscreate','1'),('circle_istalk','1'),('circle_isuse','1'),('circle_joinsum','12'),('circle_loginpic','a:2:{i:1;a:2:{s:3:\"pic\";s:5:\"1.jpg\";s:3:\"url\";s:0:\"\";}i:2;a:2:{s:3:\"pic\";s:5:\"2.jpg\";s:3:\"url\";s:0:\"\";}}'),('circle_logo','05641427415696262.png'),('circle_managesum','4'),('circle_name','杭州分圈'),('circle_seodescription','发现精彩：圈子是买家们自己创建的私属领地，我们排斥广告分子，我们热爱真实分享！'),('circle_seokeywords','圈子,帮派,讨论小组,购物,生活,分享,show,秀,商品,电子商务,社区,消费者社区,论坛,资讯,热门话题,朋友'),('circle_seotitle','发现精彩 - testmall淘友圈'),('circle_wordfilter',''),('closed_reason','今天演示到此结束！'),('complain_time_limit','2592000'),('consult_prompt','因厂家更改商品包装、场地、附配件等不做提前通知，且每位咨询者购买、提问时间等不同。为此，客服给到的回复仅对提问者3天内有效，其他网友仅供参考！给您带来的不变还请谅解，谢谢！'),('contract_allow','1'),('default_goods_image','default_goods_image.gif'),('default_store_avatar','default_store_avatar.gif'),('default_store_logo','default_store_logo.gif'),('default_user_portrait','default_user_portrait.gif'),('delivery_isuse','1'),('deliver_region','1,36,37'),('email_addr','test@163.com'),('email_host','smtp.163.com'),('email_id','1@163.com'),('email_pass','000000'),('email_port','25'),('email_type','1'),('enabled_subdomain','1'),('exppoints_rule','a:4:{s:9:\"exp_login\";s:1:\"5\";s:12:\"exp_comments\";s:2:\"10\";s:13:\"exp_orderrate\";s:1:\"1\";s:12:\"exp_ordermax\";s:3:\"500\";}'),('feiwa_city','a:2:{i:0;a:3:{s:4:\"name\";s:6:\"全国\";s:5:\"value\";s:1:\"3\";s:4:\"curl\";s:17:\"index.php?act=cms\";}i:1;a:3:{s:4:\"name\";s:6:\"上海\";s:5:\"value\";s:1:\"2\";s:4:\"curl\";s:32:\"index.php?act=index&amp;op=index\";}}'),('feiwa_crontab','a:3:{i:0;a:3:{s:4:\"name\";s:3:\"600\";s:5:\"value\";s:27:\"/crontab/index.php?app=date\";s:10:\"crontab_is\";s:1:\"2\";}i:1;a:3:{s:4:\"name\";s:3:\"600\";s:5:\"value\";s:27:\"/crontab/index.php?app=hour\";s:10:\"crontab_is\";s:1:\"2\";}i:2;a:3:{s:4:\"name\";s:3:\"600\";s:5:\"value\";s:30:\"/crontab/index.php?app=minutes\";s:10:\"crontab_is\";s:1:\"2\";}}'),('feiwa_default_city','上海'),('feiwa_index_brand','256,257,259,258,260,261,262,263,264,267,268,269,270,271'),('feiwa_index_goods','100092,100093,100094,100095,100096'),('feiwa_index_store','6,7,8'),('feiwa_invite2','80'),('feiwa_invite3','70'),('feiwa_lc','a:0:{}'),('feiwa_phone','021-099999'),('feiwa_rc','a:12:{i:0;a:3:{s:4:\"name\";s:6:\"分销\";s:5:\"value\";s:20:\"http://www.demo.feiwa.org\";s:7:\"is_blod\";s:1:\"2\";}i:1;a:3:{s:4:\"name\";s:14:\"FeiWa购买\";s:5:\"value\";s:22:\"http://www.feiwa.org\";s:7:\"is_blod\";s:1:\"1\";}i:2;a:3:{s:4:\"name\";s:17:\"闪购(未上线)\";s:5:\"value\";s:20:\"http://www.demo.feiwa.org\";s:7:\"is_blod\";s:1:\"2\";}i:3;a:3:{s:4:\"name\";s:17:\"拍卖(未上线)\";s:5:\"value\";s:20:\"http://www.demo.feiwa.org\";s:7:\"is_blod\";s:1:\"2\";}i:4;a:3:{s:4:\"name\";s:17:\"秒杀(未上线)\";s:5:\"value\";s:20:\"http://www.demo.feiwa.org\";s:7:\"is_blod\";s:1:\"2\";}i:5;a:3:{s:4:\"name\";s:12:\"汽车用品\";s:5:\"value\";s:55:\"http://www.demo.feiwa.org/mall/cate-730-0-0-0-0-0-0-0-0.html\";s:7:\"is_blod\";s:1:\"2\";}i:6;a:3:{s:4:\"name\";s:12:\"珠宝手表\";s:5:\"value\";s:55:\"http://www.demo.feiwa.org/mall/cate-530-0-0-0-0-0-0-0-0.html\";s:7:\"is_blod\";s:1:\"1\";}i:7;a:3:{s:4:\"name\";s:12:\"数码电子\";s:5:\"value\";s:55:\"http://www.demo.feiwa.org/mall/cate-256-0-0-0-0-0-0-0-0.html\";s:7:\"is_blod\";s:1:\"2\";}i:8;a:3:{s:4:\"name\";s:12:\"礼品箱包\";s:5:\"value\";s:53:\"http://www.demo.feiwa.org/mall/cate-2-0-0-0-0-0-0-0-0.html\";s:7:\"is_blod\";s:1:\"2\";}i:9;a:3:{s:4:\"name\";s:12:\"服饰鞋帽\";s:5:\"value\";s:53:\"http://www.demo.feiwa.org/mall/cate-1-0-0-0-0-0-0-0-0.html\";s:7:\"is_blod\";s:1:\"2\";}i:10;a:3:{s:4:\"name\";s:12:\"个护化妆\";s:5:\"value\";s:42:\"http://www.demo.feiwa.org/mall/channel-601.html\";s:7:\"is_blod\";s:1:\"2\";}i:11;a:3:{s:4:\"name\";s:12:\"全新设置\";s:5:\"value\";s:26:\"http://www.demo.feiwa.org/mall/\";s:7:\"is_blod\";s:1:\"2\";}}'),('feiwa_sms_bz',''),('feiwa_sms_key','0cc5f92800ab0768c6d070ebc47bd5a7'),('feiwa_sms_pw',''),('feiwa_sms_signature','FeiWa'),('feiwa_sms_tgs','网络'),('feiwa_sms_type','2'),('feiwa_sms_zh',''),('feiwa_stitle','版本好·售后快·价格低'),('feiwa_time','08:00-22:30(周一至周日)'),('feiwa_top_banner_color','#a8d801'),('feiwa_top_banner_name','顶部广告管理'),('feiwa_top_banner_pic','05639881333622870.jpg'),('feiwa_top_banner_status','0'),('feiwa_top_banner_url','http://www.test.com'),('feiwa_webchat_appid','wx0a2a504b2e162f81'),('feiwa_webchat_appsecret','aa0377f754ffb84f26e0caa5ab0c32e4'),('goods_verify','0'),('grbankname','12321321321'),('grlianhanghao','2131232'),('grname','21312321321'),('grnumber','3213213'),('groupbuy_allow','1'),('groupbuy_price','10'),('groupbuy_review_day','0'),('guest_comment','1'),('hetong','3213213'),('hot_search','玩具,童装童,尿裤湿巾,奶粉,童车,辅食宝宝,用品玩具'),('icp_number',''),('image_allow_ext','gif,jpg,jpeg,bmp,png,swf'),('image_dir_type','1'),('image_max_filesize','1024'),('join_email','admin@po1.com'),('live_color1','#04bc80'),('live_color2','#fe8407'),('live_color3','#fff'),('live_color4','#fff'),('live_link1','http://www.test.com'),('live_link2','http://www.test.com'),('live_link3',''),('live_link4',''),('live_pic1','04525999367706292.jpg'),('live_pic2','04525999367951893.jpg'),('live_pic3',''),('live_pic4',''),('login_pic','a:4:{i:0;s:5:\"1.jpg\";i:1;s:5:\"2.jpg\";i:2;s:5:\"3.jpg\";i:3;s:5:\"4.jpg\";}'),('malbum_max_sum','200'),('md5_key','6d2ab8ee1edd5d7576b798ef5f302655'),('member_grade','a:4:{i:0;a:3:{s:5:\"level\";i:0;s:10:\"level_name\";s:2:\"V0\";s:9:\"exppoints\";i:0;}i:1;a:3:{s:5:\"level\";i:1;s:10:\"level_name\";s:2:\"V1\";s:9:\"exppoints\";i:1000;}i:2;a:3:{s:5:\"level\";i:2;s:10:\"level_name\";s:2:\"V2\";s:9:\"exppoints\";i:10000;}i:3;a:3:{s:5:\"level\";i:3;s:10:\"level_name\";s:2:\"V3\";s:9:\"exppoints\";i:20000;}}'),('member_logo','05644939282455089.png'),('mobile_apk','http://www.test.com'),('mobile_apk_version','3.0'),('mobile_app','mb_app.png'),('mobile_ios','http://www.test.com'),('mobile_isuse','1'),('mobile_wx','05641701529102002.png'),('pointmall_isuse','1'),('pointprod_isuse','1'),('points_comments','50'),('points_invite','100'),('points_isuse','1'),('points_login','30'),('points_ordermax','800'),('points_orderrate','20'),('points_reg','20'),('points_signin','10'),('promotion_allow','1'),('promotion_book_price','20'),('promotion_booth_goods_sum','10'),('promotion_booth_price','20'),('promotion_bundling_goods_sum','5'),('promotion_bundling_price','20'),('promotion_bundling_sum','50'),('promotion_combo_price','20'),('promotion_cou_price','20'),('promotion_fcode_price','20'),('promotion_mansong_price','20'),('promotion_sole_price','20'),('promotion_voucher_buyertimes_limit','5'),('promotion_voucher_default_styleimg','default_voucher.jpg'),('promotion_voucher_price','20'),('promotion_voucher_storetimes_limit','20'),('promotion_xianshi_price','11'),('promotion_xspic','a:3:{i:1;a:2:{s:3:\"pic\";s:6:\"p1.jpg\";s:3:\"url\";s:0:\"\";}i:2;a:2:{s:3:\"pic\";s:6:\"p2.jpg\";s:3:\"url\";s:0:\"\";}i:3;a:2:{s:3:\"pic\";s:6:\"p3.jpg\";s:3:\"url\";s:0:\"\";}}'),('qq_appcode','&lt;meta property=&quot;qc:admins&quot; content=&quot;45504403430707716375&quot; /&gt;'),('qq_appid','101278314'),('qq_appkey','3e7d096bef52bb580d10f3796fecccc5'),('qq_isuse','1'),('qybankname','213213'),('qylianhanghao','213123'),('qyname','213213'),('qynumber','213213123'),('reads_attitude_flag','1'),('reads_comment_flag','1'),('reads_isuse','1'),('reads_logo','05791142271773480.jpg'),('reads_seo_description','testmall,资讯,画报'),('reads_seo_keywords','testmall,资讯,画报'),('reads_seo_title','testmall淘资讯频道'),('reads_submit_flag','1'),('reads_submit_verify_flag','1'),('rec_search','a:6:{i:0;a:2:{s:4:\"name\";s:12:\"用品玩具\";s:5:\"value\";s:12:\"用品玩具\";}i:1;a:2:{s:4:\"name\";s:12:\"辅食宝宝\";s:5:\"value\";s:12:\"辅食宝宝\";}i:2;a:2:{s:4:\"name\";s:12:\"奶粉童车\";s:5:\"value\";s:12:\"奶粉童车\";}i:3;a:2:{s:4:\"name\";s:12:\"奶粉童车\";s:5:\"value\";s:12:\"奶粉童车\";}i:4;a:2:{s:4:\"name\";s:6:\"童装\";s:5:\"value\";s:6:\"童装\";}i:5;a:2:{s:4:\"name\";s:12:\"尿裤湿巾\";s:5:\"value\";s:12:\"尿裤湿巾\";}}'),('redpacket_allow','1'),('seller_center_logo','05642447674252092.png'),('shareshow_goods_default_class','0'),('shareshow_header_pic',''),('shareshow_isuse','1'),('shareshow_logo','05644997068878264.png'),('shareshow_personal_limit','50'),('shareshow_seo_description','testmall商城系统,分享秀,随心看,个人秀,店铺街'),('shareshow_seo_keywords','testmall商城系统,分享秀,随心看,个人秀,店铺街,网上购物'),('shareshow_store_banner',''),('shareshow_style','你好，我是测试'),('share_isuse','1'),('share_qqweibo_appid',''),('share_qqweibo_appkey',''),('share_qqweibo_isuse','0'),('share_sinaweibo_appcode',''),('share_sinaweibo_appid',''),('share_sinaweibo_appkey',''),('share_sinaweibo_isuse','0'),('signin_isuse','1'),('sina_appcode','&lt;meta property=&quot;wb:webmaster&quot; content=&quot;208d92b53c51f6df&quot; /&gt;'),('sina_isuse','1'),('sina_wb_akey','529518630'),('sina_wb_skey','d62a7dc2cafe85bafc28115e1db9ced6'),('site_bank_account','银行:中国银行,币种:人民币,账号:xxxxxxxxxxx,姓名开户行:中国银行天津分行'),('site_email','1@1.com'),('site_logo','05641634168911276.png'),('site_name','威海路妇女儿童用品'),('site_phone','23456789,8899778844!@#bbscccrrs'),('site_status','1'),('sms_login','1'),('sms_password','1'),('sms_register','1'),('spike_allow','1'),('sqm','692d29fe1f7843b9b689321ecfa71811'),('statistics_code',''),('stat_orderpricerange',''),('stat_pricerange',''),('store_joinin_pic','a:2:{s:8:\"show_txt\";s:387:\"商家可直接使用助手工具在PC端发布商品， 商品分类及各项规格、属性、库存、价格与网上商城保持一致，商品介绍可视化编辑，图片直接本地添加。\r\n编辑完毕后选择立即发布并保存可上传至网上服务器并更新商品数据库，更新店铺商品内容； 也可以选择保存到本地仓库以后批量上传发布。\";s:3:\"pic\";a:3:{i:1;s:18:\"store_joinin_1.jpg\";i:2;s:0:\"\";i:3;s:0:\"\";}}'),('subdomain_edit','0'),('subdomain_length','3-12'),('subdomain_reserved','www'),('subdomain_times','3'),('taobao_api_isuse','1'),('taobao_app_key','sdsdsd'),('taobao_secret_key','sdsdsd'),('time_zone','Asia/Shanghai'),('ucenter_app_id','1'),('ucenter_app_key',''),('ucenter_connect_type',''),('ucenter_ip',''),('ucenter_mysql_name','feiwa'),('ucenter_mysql_passwd',''),('ucenter_mysql_pre','pre_ucenter_'),('ucenter_mysql_server','localhost'),('ucenter_mysql_username','root'),('ucenter_status','0'),('ucenter_type','discuz'),('ucenter_url',''),('voucher_allow','1'),('wap_weixin_appid','wx0a2a504b2e162f81'),('wap_weixin_isuse','1'),('wap_weixin_secret','aa0377f754ffb84f26e0caa5ab0c32e4'),('weixin_appid','wx2d8ec7998682d3a4'),('weixin_isuse','1'),('weixin_secret','d4624c36b6795d1d99dcf0547af5443d');

/*Table structure for table `feiwa_signin` */

DROP TABLE IF EXISTS `feiwa_signin`;

CREATE TABLE `feiwa_signin` (
  `sl_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `sl_memberid` int(11) NOT NULL COMMENT '会员ID',
  `sl_membername` varchar(100) NOT NULL DEFAULT '' COMMENT '会员名称',
  `sl_addtime` int(11) NOT NULL COMMENT '签到时间',
  `sl_points` int(11) NOT NULL COMMENT '获得积分数',
  PRIMARY KEY (`sl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `feiwa_signin` */

/*Table structure for table `feiwa_sms_log` */

DROP TABLE IF EXISTS `feiwa_sms_log`;

CREATE TABLE `feiwa_sms_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `log_phone` char(11) NOT NULL DEFAULT '' COMMENT '手机号',
  `log_captcha` char(6) NOT NULL DEFAULT '' COMMENT '短信动态码',
  `log_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '请求IP',
  `log_msg` varchar(300) NOT NULL DEFAULT '' COMMENT '短信内容',
  `log_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '短信类型:1为注册,2为登录,3为找回密码,默认为1',
  `add_time` int(10) unsigned NOT NULL COMMENT '添加时间',
  `member_id` int(10) unsigned DEFAULT '0' COMMENT '会员ID,注册为0',
  `member_name` varchar(50) DEFAULT '' COMMENT '会员名',
  PRIMARY KEY (`log_id`),
  KEY `log_phone` (`log_phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机短信记录表';

/*Data for the table `feiwa_sms_log` */

/*Table structure for table `feiwa_sns_albumclass` */

DROP TABLE IF EXISTS `feiwa_sns_albumclass`;

CREATE TABLE `feiwa_sns_albumclass` (
  `ac_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '相册id',
  `ac_name` varchar(100) NOT NULL DEFAULT '' COMMENT '相册名称',
  `member_id` int(10) unsigned NOT NULL COMMENT '所属会员id',
  `ac_des` varchar(255) DEFAULT '' COMMENT '相册描述',
  `ac_sort` tinyint(3) unsigned NOT NULL COMMENT '排序',
  `ac_cover` varchar(255) DEFAULT NULL COMMENT '相册封面',
  `upload_time` int(10) unsigned NOT NULL COMMENT '图片上传时间',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为买家秀相册  1为是,0为否',
  PRIMARY KEY (`ac_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1067 DEFAULT CHARSET=utf8 COMMENT='相册表';

/*Data for the table `feiwa_sns_albumclass` */

insert  into `feiwa_sns_albumclass`(`ac_id`,`ac_name`,`member_id`,`ac_des`,`ac_sort`,`ac_cover`,`upload_time`,`is_default`) values (1041,'买家秀',1041,'买家秀默认相册',1,NULL,1510650410,1),(1042,'买家秀',1042,'买家秀默认相册',1,NULL,1510651780,1),(1043,'买家秀',1043,'买家秀默认相册',1,NULL,1510796770,1),(1044,'买家秀',1044,'买家秀默认相册',1,NULL,1513701274,1),(1045,'买家秀',1045,'买家秀默认相册',1,NULL,1513751143,1),(1046,'买家秀',1046,'买家秀默认相册',1,NULL,1513751804,1),(1047,'买家秀',1047,'买家秀默认相册',1,NULL,1513752446,1),(1048,'买家秀',1048,'买家秀默认相册',1,NULL,1514001172,1),(1049,'买家秀',1049,'买家秀默认相册',1,NULL,1515141620,1),(1050,'买家秀',1050,'买家秀默认相册',1,NULL,1515311233,1),(1051,'买家秀',1051,'买家秀默认相册',1,NULL,1515473010,1),(1052,'买家秀',1052,'买家秀默认相册',1,NULL,1515548961,1),(1053,'买家秀',1053,'买家秀默认相册',1,NULL,1515554449,1),(1054,'买家秀',1054,'买家秀默认相册',1,NULL,1515680577,1),(1055,'买家秀',1055,'买家秀默认相册',1,NULL,1516071227,1),(1056,'买家秀',1056,'买家秀默认相册',1,NULL,1516691667,1),(1057,'买家秀',1057,'买家秀默认相册',1,NULL,1517889255,1),(1058,'买家秀',1058,'买家秀默认相册',1,NULL,1520054910,1),(1059,'买家秀',1059,'买家秀默认相册',1,NULL,1520910483,1),(1060,'买家秀',1060,'买家秀默认相册',1,NULL,1522030062,1),(1061,'买家秀',1061,'买家秀默认相册',1,NULL,1523951515,1),(1062,'买家秀',1062,'买家秀默认相册',1,NULL,1523952717,1),(1063,'买家秀',1063,'买家秀默认相册',1,NULL,1523952778,1),(1064,'买家秀',1064,'买家秀默认相册',1,NULL,1536135982,1),(1065,'买家秀',1067,'买家秀默认相册',1,NULL,1536136347,1),(1066,'买家秀',1068,'买家秀默认相册',1,NULL,1536136645,1);

/*Table structure for table `feiwa_sns_albumpic` */

DROP TABLE IF EXISTS `feiwa_sns_albumpic`;

CREATE TABLE `feiwa_sns_albumpic` (
  `ap_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '相册图片表id',
  `ap_name` varchar(100) NOT NULL DEFAULT '' COMMENT '图片名称',
  `ac_id` int(10) unsigned NOT NULL COMMENT '相册id',
  `ap_cover` varchar(255) NOT NULL DEFAULT '' COMMENT '图片路径',
  `ap_size` int(10) unsigned NOT NULL COMMENT '图片大小',
  `ap_spec` varchar(100) NOT NULL DEFAULT '' COMMENT '图片规格',
  `member_id` int(10) unsigned NOT NULL COMMENT '所属店铺id',
  `upload_time` int(10) unsigned NOT NULL COMMENT '图片上传时间',
  `ap_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '图片类型，0为无、1为买家秀',
  `item_id` tinyint(4) NOT NULL DEFAULT '0' COMMENT '信息ID',
  PRIMARY KEY (`ap_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='相册图片表';

/*Data for the table `feiwa_sns_albumpic` */

insert  into `feiwa_sns_albumpic`(`ap_id`,`ap_name`,`ac_id`,`ap_cover`,`ap_size`,`ap_spec`,`member_id`,`upload_time`,`ap_type`,`item_id`) values (7,'05435727318367918',1043,'1043_05642558562412513.jpg',14478,'319x208',1043,1510911856,0,0),(8,'05435727318367918',1043,'1043_05642559459523204.jpg',14478,'319x208',1043,1510911946,0,0);

/*Table structure for table `feiwa_sns_binding` */

DROP TABLE IF EXISTS `feiwa_sns_binding`;

CREATE TABLE `feiwa_sns_binding` (
  `snsbind_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `snsbind_memberid` int(11) NOT NULL COMMENT '会员编号',
  `snsbind_membername` varchar(100) NOT NULL DEFAULT '' COMMENT '会员名称',
  `snsbind_appsign` varchar(50) NOT NULL DEFAULT '' COMMENT '应用标志',
  `snsbind_updatetime` int(11) NOT NULL COMMENT '绑定更新时间',
  `snsbind_openid` varchar(100) NOT NULL DEFAULT '' COMMENT '应用用户编号',
  `snsbind_openinfo` text COMMENT '应用用户信息',
  `snsbind_accesstoken` varchar(100) NOT NULL DEFAULT '' COMMENT '访问第三方资源的凭证',
  `snsbind_expiresin` int(11) NOT NULL COMMENT 'accesstoken过期时间，以返回的时间的准，单位为秒，注意过期时提醒用户重新授权',
  `snsbind_refreshtoken` varchar(100) DEFAULT NULL COMMENT '刷新token',
  PRIMARY KEY (`snsbind_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分享应用用户绑定记录表';

/*Data for the table `feiwa_sns_binding` */

/*Table structure for table `feiwa_sns_comment` */

DROP TABLE IF EXISTS `feiwa_sns_comment`;

CREATE TABLE `feiwa_sns_comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `comment_memberid` int(11) NOT NULL COMMENT '会员ID',
  `comment_membername` varchar(100) NOT NULL DEFAULT '' COMMENT '会员名称',
  `comment_memberavatar` varchar(100) DEFAULT NULL COMMENT '会员头像',
  `comment_originalid` int(11) NOT NULL COMMENT '原帖ID',
  `comment_originaltype` tinyint(1) NOT NULL DEFAULT '0' COMMENT '原帖类型 0表示动态信息 1表示分享商品 默认为0',
  `comment_content` varchar(500) NOT NULL DEFAULT '' COMMENT '评论内容',
  `comment_addtime` int(11) NOT NULL COMMENT '添加时间',
  `comment_ip` varchar(50) NOT NULL DEFAULT '' COMMENT '来源IP',
  `comment_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0正常 1屏蔽',
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';

/*Data for the table `feiwa_sns_comment` */

/*Table structure for table `feiwa_sns_friend` */

DROP TABLE IF EXISTS `feiwa_sns_friend`;

CREATE TABLE `feiwa_sns_friend` (
  `friend_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id值',
  `friend_frommid` int(11) NOT NULL COMMENT '会员id',
  `friend_frommname` varchar(100) DEFAULT NULL COMMENT '会员名称',
  `friend_frommavatar` varchar(100) DEFAULT NULL COMMENT '会员头像',
  `friend_tomid` int(11) NOT NULL COMMENT '朋友id',
  `friend_tomname` varchar(100) NOT NULL DEFAULT '' COMMENT '好友会员名称',
  `friend_tomavatar` varchar(100) DEFAULT NULL COMMENT '朋友头像',
  `friend_addtime` int(11) NOT NULL COMMENT '添加时间',
  `friend_followstate` tinyint(1) NOT NULL DEFAULT '1' COMMENT '关注状态 1为单方关注 2为双方关注',
  PRIMARY KEY (`friend_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COMMENT='好友数据表';

/*Data for the table `feiwa_sns_friend` */

insert  into `feiwa_sns_friend`(`friend_id`,`friend_frommid`,`friend_frommname`,`friend_frommavatar`,`friend_tomid`,`friend_tomname`,`friend_tomavatar`,`friend_addtime`,`friend_followstate`) values (55,1063,'sannianzhihou','',1062,'cliffgyn11111','',1523953037,1),(57,0,'','',1043,'adminy','avatar_1043.jpg',1524601733,1);

/*Table structure for table `feiwa_sns_goods` */

DROP TABLE IF EXISTS `feiwa_sns_goods`;

CREATE TABLE `feiwa_sns_goods` (
  `snsgoods_goodsid` int(11) NOT NULL COMMENT '商品ID',
  `snsgoods_goodsname` varchar(100) NOT NULL DEFAULT '' COMMENT '商品名称',
  `snsgoods_goodsimage` varchar(100) DEFAULT NULL COMMENT '商品图片',
  `snsgoods_goodsprice` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品价格',
  `snsgoods_storeid` int(11) NOT NULL COMMENT '店铺ID',
  `snsgoods_storename` varchar(100) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `snsgoods_addtime` int(11) NOT NULL COMMENT '添加时间',
  `snsgoods_likenum` int(11) NOT NULL DEFAULT '0' COMMENT '喜欢数',
  `snsgoods_likemember` text COMMENT '喜欢过的会员ID，用逗号分隔',
  `snsgoods_sharenum` int(11) NOT NULL DEFAULT '0' COMMENT '分享数',
  UNIQUE KEY `snsgoods_goodsid` (`snsgoods_goodsid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SNS商品表';

/*Data for the table `feiwa_sns_goods` */

insert  into `feiwa_sns_goods`(`snsgoods_goodsid`,`snsgoods_goodsname`,`snsgoods_goodsimage`,`snsgoods_goodsprice`,`snsgoods_storeid`,`snsgoods_storename`,`snsgoods_addtime`,`snsgoods_likenum`,`snsgoods_likemember`,`snsgoods_sharenum`) values (100215,'运动摄像机','6_05641604498445569.jpg','5200.00',6,'商城',1510912474,0,NULL,1),(100221,'运动摄像机','6_05641607118761159.jpg','6000.00',6,'商城',1510912100,0,NULL,2);

/*Table structure for table `feiwa_sns_membertag` */

DROP TABLE IF EXISTS `feiwa_sns_membertag`;

CREATE TABLE `feiwa_sns_membertag` (
  `mtag_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '会员标签id',
  `mtag_name` varchar(20) NOT NULL DEFAULT '' COMMENT '会员标签名称',
  `mtag_sort` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员标签排序',
  `mtag_recommend` tinyint(4) NOT NULL DEFAULT '0' COMMENT '标签推荐 0未推荐（默认），1为已推荐',
  `mtag_desc` varchar(50) DEFAULT '' COMMENT '标签描述',
  `mtag_img` varchar(50) DEFAULT NULL COMMENT '标签图片',
  PRIMARY KEY (`mtag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='会员标签表';

/*Data for the table `feiwa_sns_membertag` */

insert  into `feiwa_sns_membertag`(`mtag_id`,`mtag_name`,`mtag_sort`,`mtag_recommend`,`mtag_desc`,`mtag_img`) values (1,'潮人',0,1,'123435','05683961031066592.jpg'),(2,'123',0,1,'绝对是个刺客','05683963528683962.png');

/*Table structure for table `feiwa_sns_mtagmember` */

DROP TABLE IF EXISTS `feiwa_sns_mtagmember`;

CREATE TABLE `feiwa_sns_mtagmember` (
  `mtag_id` int(11) NOT NULL COMMENT '会员标签表id',
  `member_id` int(11) NOT NULL COMMENT '会员id',
  `recommend` tinyint(4) NOT NULL DEFAULT '0' COMMENT '推荐，默认为0',
  PRIMARY KEY (`mtag_id`,`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员标签会员对照表';

/*Data for the table `feiwa_sns_mtagmember` */

/*Table structure for table `feiwa_sns_setting` */

DROP TABLE IF EXISTS `feiwa_sns_setting`;

CREATE TABLE `feiwa_sns_setting` (
  `member_id` int(11) NOT NULL COMMENT '会员id',
  `setting_skin` varchar(50) DEFAULT NULL COMMENT '皮肤',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='个人中心设置表';

/*Data for the table `feiwa_sns_setting` */

/*Table structure for table `feiwa_sns_sharegoods` */

DROP TABLE IF EXISTS `feiwa_sns_sharegoods`;

CREATE TABLE `feiwa_sns_sharegoods` (
  `share_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `share_goodsid` int(11) NOT NULL COMMENT '商品ID',
  `share_memberid` int(11) NOT NULL COMMENT '所属会员ID',
  `share_membername` varchar(100) NOT NULL DEFAULT '' COMMENT '会员名称',
  `share_content` varchar(500) DEFAULT NULL COMMENT '描述内容',
  `share_addtime` int(11) NOT NULL DEFAULT '0' COMMENT '分享操作时间',
  `share_likeaddtime` int(11) NOT NULL DEFAULT '0' COMMENT '喜欢操作时间',
  `share_privacy` tinyint(1) NOT NULL DEFAULT '0' COMMENT '隐私可见度 0所有人可见 1好友可见 2仅自己可见',
  `share_commentcount` int(11) NOT NULL DEFAULT '0' COMMENT '评论数',
  `share_isshare` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否分享 0为未分享 1为分享',
  `share_islike` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否喜欢 0为未喜欢 1为喜欢',
  PRIMARY KEY (`share_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='共享商品表';

/*Data for the table `feiwa_sns_sharegoods` */

insert  into `feiwa_sns_sharegoods`(`share_id`,`share_goodsid`,`share_memberid`,`share_membername`,`share_content`,`share_addtime`,`share_likeaddtime`,`share_privacy`,`share_commentcount`,`share_isshare`,`share_islike`) values (3,100221,1043,'adminy','分享摄像机',1510912209,0,0,0,1,0),(4,100215,1043,'adminy','xxxxxx, xxxxxx,rrrrrrrrrr',1510912474,0,0,0,1,0);

/*Table structure for table `feiwa_sns_sharestore` */

DROP TABLE IF EXISTS `feiwa_sns_sharestore`;

CREATE TABLE `feiwa_sns_sharestore` (
  `share_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `share_storeid` int(11) NOT NULL COMMENT '店铺编号',
  `share_storename` varchar(100) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `share_memberid` int(11) NOT NULL COMMENT '所属会员ID',
  `share_membername` varchar(100) NOT NULL DEFAULT '' COMMENT '所属会员名称',
  `share_content` varchar(500) DEFAULT NULL COMMENT '描述内容',
  `share_addtime` int(11) NOT NULL COMMENT '添加时间',
  `share_privacy` tinyint(1) NOT NULL DEFAULT '0' COMMENT '隐私可见度 0所有人可见 1好友可见 2仅自己可见',
  PRIMARY KEY (`share_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='共享店铺表';

/*Data for the table `feiwa_sns_sharestore` */

/*Table structure for table `feiwa_sns_tracelog` */

DROP TABLE IF EXISTS `feiwa_sns_tracelog`;

CREATE TABLE `feiwa_sns_tracelog` (
  `trace_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `trace_originalid` int(11) NOT NULL DEFAULT '0' COMMENT '原动态ID 默认为0',
  `trace_originalmemberid` int(11) NOT NULL DEFAULT '0' COMMENT '原帖会员编号',
  `trace_originalstate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '原帖的删除状态 0为正常 1为删除',
  `trace_memberid` int(11) NOT NULL COMMENT '会员ID',
  `trace_membername` varchar(100) NOT NULL DEFAULT '' COMMENT '会员名称',
  `trace_memberavatar` varchar(100) DEFAULT NULL COMMENT '会员头像',
  `trace_title` varchar(500) DEFAULT NULL COMMENT '动态标题',
  `trace_content` text NOT NULL COMMENT '动态内容',
  `trace_addtime` int(11) NOT NULL COMMENT '添加时间',
  `trace_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态  0正常 1为禁止显示 默认为0',
  `trace_privacy` tinyint(1) NOT NULL DEFAULT '0' COMMENT '隐私可见度 0所有人可见 1好友可见 2仅自己可见',
  `trace_commentcount` int(11) NOT NULL DEFAULT '0' COMMENT '评论数',
  `trace_copycount` int(11) NOT NULL DEFAULT '0' COMMENT '转发数',
  `trace_orgcommentcount` int(11) NOT NULL DEFAULT '0' COMMENT '原帖评论次数',
  `trace_orgcopycount` int(11) NOT NULL DEFAULT '0' COMMENT '原帖转帖次数',
  `trace_from` tinyint(4) DEFAULT '1' COMMENT '来源 1=shop 2=storetracelog 3=microshop 4=cms 5=circle',
  PRIMARY KEY (`trace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='动态信息表';

/*Data for the table `feiwa_sns_tracelog` */

insert  into `feiwa_sns_tracelog`(`trace_id`,`trace_originalid`,`trace_originalmemberid`,`trace_originalstate`,`trace_memberid`,`trace_membername`,`trace_memberavatar`,`trace_title`,`trace_content`,`trace_addtime`,`trace_state`,`trace_privacy`,`trace_commentcount`,`trace_copycount`,`trace_orgcommentcount`,`trace_orgcopycount`,`trace_from`) values (18,0,0,0,1043,'adminy','','分享的新鲜事','',1510911971,0,0,0,0,0,0,1),(19,0,0,0,1043,'adminy','','运动摄像机_adminyt','<div class=\"fd-media\">\r\n                    <div class=\"goodsimg\"><a target=\"_blank\" href=\"http://101.226.179.113/mall/index.php?app=goods&feiwa=index&goods_id=100221\"><img src=\"http://101.226.179.113/data/upload/mall/store/goods/6/6_05641607118761159_240.jpg\" onload=\"javascript:DrawImage(this,120,120);\" alt=\"运动摄像机\"></a></div>\r\n                    <div class=\"goodsinfo\">\r\n                        <dl>\r\n                            <dt><a target=\"_blank\" href=\"http://101.226.179.113/mall/index.php?app=goods&feiwa=index&goods_id=100221\">运动摄像机</a></dt>\r\n                            <dd>价&nbsp;&nbsp;格：&yen;6000.00</dd>\r\n                            <dd>运&nbsp;&nbsp;费：&yen;0.00</dd>\r\n                            <dd nctype=\"collectbtn_100221\"><a href=\"javascript:void(0);\" onclick=\"javascript:collect_goods(\'100221\',\'succ\',\'collectbtn_100221\');\">收藏该宝贝</a></dd>\r\n                        </dl>\r\n                      </div>\r\n                 </div>',1510912100,0,0,0,0,0,0,1),(20,0,0,0,1043,'adminy','','分享摄像机','<div class=\"fd-media\">\r\n                    <div class=\"goodsimg\"><a target=\"_blank\" href=\"http://101.226.179.113/mall/index.php?app=goods&feiwa=index&goods_id=100221\"><img src=\"http://101.226.179.113/data/upload/mall/store/goods/6/6_05641607118761159_240.jpg\" onload=\"javascript:DrawImage(this,120,120);\" alt=\"运动摄像机\"></a></div>\r\n                    <div class=\"goodsinfo\">\r\n                        <dl>\r\n                            <dt><a target=\"_blank\" href=\"http://101.226.179.113/mall/index.php?app=goods&feiwa=index&goods_id=100221\">运动摄像机</a></dt>\r\n                            <dd>价&nbsp;&nbsp;格：&yen;6000.00</dd>\r\n                            <dd>运&nbsp;&nbsp;费：&yen;0.00</dd>\r\n                            <dd nctype=\"collectbtn_100221\"><a href=\"javascript:void(0);\" onclick=\"javascript:collect_goods(\'100221\',\'succ\',\'collectbtn_100221\');\">收藏该宝贝</a></dd>\r\n                        </dl>\r\n                      </div>\r\n                 </div>',1510912209,0,0,0,0,0,0,1),(21,0,0,0,1043,'adminy','','xxxxxx, xxxxxx,rrrrrrrrrr','<div class=\"fd-media\">\r\n                    <div class=\"goodsimg\"><a target=\"_blank\" href=\"http://101.226.179.113/mall/index.php?app=goods&feiwa=index&goods_id=100215\"><img src=\"http://101.226.179.113/data/upload/mall/store/goods/6/6_05641604498445569_240.jpg\" onload=\"javascript:DrawImage(this,120,120);\" alt=\"运动摄像机\"></a></div>\r\n                    <div class=\"goodsinfo\">\r\n                        <dl>\r\n                            <dt><a target=\"_blank\" href=\"http://101.226.179.113/mall/index.php?app=goods&feiwa=index&goods_id=100215\">运动摄像机</a></dt>\r\n                            <dd>价&nbsp;&nbsp;格：&yen;5200.00</dd>\r\n                            <dd>运&nbsp;&nbsp;费：&yen;0.00</dd>\r\n                            <dd nctype=\"collectbtn_100215\"><a href=\"javascript:void(0);\" onclick=\"javascript:collect_goods(\'100215\',\'succ\',\'collectbtn_100215\');\">收藏该宝贝</a></dd>\r\n                        </dl>\r\n                      </div>\r\n                 </div>',1510912474,0,0,0,0,0,0,1),(22,0,0,0,1043,'adminy','','我的搭配还不错吧^-^','\r\n            <div class=\'fd-media\'>\r\n            <div class=\'goodsimg\'><a target=\"_blank\" href=\"http://101.226.179.113/shareshow/index.php?app=personal&feiwa=detail&personal_id=4\"><img src=\"http://101.226.179.113/data/upload/shareshow/1043/05642566514641445_list.jpg\" onload=\"javascript:DrawImage(this,120,120);\"></a></div>\r\n            <div class=\'goodsinfo\'>\r\n            <ul>\r\n            </ul><p>\'adminy\'在分享秀推荐了个人秀的展示<a target=\"_blank\" href=\"http://101.226.179.113/shareshow/index.php?app=personal&feiwa=detail&personal_id=4\">去看看</a></p>\r\n            </div>\r\n            </div>\r\n            ',1510912653,0,0,0,0,0,0,3),(23,0,0,0,1041,'zxx1cndns','','我的个人秀zx','\r\n            <div class=\'fd-media\'>\r\n            <div class=\'goodsimg\'><a target=\"_blank\" href=\"http://101.226.179.113/shareshow/index.php?app=personal&feiwa=detail&personal_id=5\"><img src=\"http://101.226.179.113/data/upload/shareshow/1041/05648527426455905_list.png\" onload=\"javascript:DrawImage(this,120,120);\"></a></div>\r\n            <div class=\'goodsinfo\'>\r\n            <ul>\r\n            </ul><p>\'zxx1cndns\'在分享秀推荐了个人秀的展示<a target=\"_blank\" href=\"http://101.226.179.113/shareshow/index.php?app=personal&feiwa=detail&personal_id=5\">去看看</a></p>\r\n            </div>\r\n            </div>\r\n            ',1511508750,0,0,0,0,0,0,3),(24,0,0,0,1043,'adminy','','aaaa','\r\n            <div class=\'fd-media\'>\r\n            <div class=\'goodsimg\'><a target=\"_blank\" href=\"http://101.226.179.113/shareshow/index.php?app=goods&feiwa=detail&goods_id=1\"><img src=\"http://101.226.179.113/data/upload/mall/store/goods/6/6_05640797074821655_240.jpg\" onload=\"javascript:DrawImage(this,120,120);\" title=\"天然海藻面膜\" alt=\"天然海藻面膜\"></a></div>\r\n            <div class=\'goodsinfo\'>\r\n            <dl>\r\n            <dt><a target=\"_blank\" href=\"http://101.226.179.113/shareshow/index.php?app=goods&feiwa=detail&goods_id=1\">天然海藻面膜</a></dt>\r\n            <dd>价格：￥18.00</dd>\r\n            <dd>\'adminy\'在分享秀推荐了随心看的商品<a target=\"_blank\" href=\"http://101.226.179.113/shareshow/index.php?app=goods&feiwa=detail&goods_id=1\">去看看</a></dd>\r\n            </dl>\r\n            </div>\r\n            </div>\r\n            ',1511508826,0,0,0,0,0,0,3),(25,0,0,0,1043,'adminy','','随心看2','\r\n            <div class=\'fd-media\'>\r\n            <div class=\'goodsimg\'><a target=\"_blank\" href=\"http://101.226.179.113/shareshow/index.php?app=goods&feiwa=detail&goods_id=2\"><img src=\"http://101.226.179.113/data/upload/mall/store/goods/6/6_05640796519363861_240.jpg\" onload=\"javascript:DrawImage(this,120,120);\" title=\"樱花保湿嫩肤水500ml\" alt=\"樱花保湿嫩肤水500ml\"></a></div>\r\n            <div class=\'goodsinfo\'>\r\n            <dl>\r\n            <dt><a target=\"_blank\" href=\"http://101.226.179.113/shareshow/index.php?app=goods&feiwa=detail&goods_id=2\">樱花保湿嫩肤水500ml</a></dt>\r\n            <dd>价格：￥89.00</dd>\r\n            <dd>\'adminy\'在分享秀推荐了随心看的商品<a target=\"_blank\" href=\"http://101.226.179.113/shareshow/index.php?app=goods&feiwa=detail&goods_id=2\">去看看</a></dd>\r\n            </dl>\r\n            </div>\r\n            </div>\r\n            ',1511508880,0,0,0,0,0,0,3),(26,0,0,0,1043,'adminy','','1234567890-','\r\n            <div class=\'fd-media\'>\r\n            <div class=\'goodsimg\'><a target=\"_blank\" href=\"http://865284.ichengyun.net/shareshow/index.php?app=personal&feiwa=detail&personal_id=4#widgetcommenttitle\"><img src=\"http://865284.ichengyun.net/data/upload/shareshow/1043/05642566514641445_list.jpg\" onload=\"javascript:DrawImage(this,120,120);\"></a></div>\r\n            <div class=\'goodsinfo\'>\r\n            <ul>\r\n            </ul><p>\'adminy\'在分享秀评论了个人秀的展示<a target=\"_blank\" href=\"http://865284.ichengyun.net/shareshow/index.php?app=personal&feiwa=detail&personal_id=4#widgetcommenttitle\">去看看</a></p>\r\n            </div>\r\n            </div>\r\n            ',1513665585,0,0,0,0,0,0,3),(27,0,0,0,1043,'adminy','',':biggrin:','\r\n            <div class=\'fd-media\'>\r\n            <div class=\'goodsimg\'><a target=\"_blank\" href=\"http://865284.ichengyun.net/shareshow/index.php?app=personal&feiwa=detail&personal_id=4#widgetcommenttitle\"><img src=\"http://865284.ichengyun.net/data/upload/shareshow/1043/05642566514641445_list.jpg\" onload=\"javascript:DrawImage(this,120,120);\"></a></div>\r\n            <div class=\'goodsinfo\'>\r\n            <ul>\r\n            </ul><p>\'adminy\'在分享秀评论了个人秀的展示<a target=\"_blank\" href=\"http://865284.ichengyun.net/shareshow/index.php?app=personal&feiwa=detail&personal_id=4#widgetcommenttitle\">去看看</a></p>\r\n            </div>\r\n            </div>\r\n            ',1513665639,0,0,0,0,0,0,3),(28,0,0,0,1043,'adminy','','我的搭配还不错吧^-^','\r\n            <div class=\'fd-media\'>\r\n            <div class=\'goodsimg\'><a target=\"_blank\" href=\"http://865284.ichengyun.net/shareshow/index.php?app=personal&feiwa=detail&personal_id=6\"><img src=\"http://865284.ichengyun.net/data/upload/shareshow/1043/05670109266250647_list.jpg\" onload=\"javascript:DrawImage(this,120,120);\"></a></div>\r\n            <div class=\'goodsinfo\'>\r\n            <ul>\r\n            </ul><p>\'adminy\'在分享秀推荐了个人秀的展示<a target=\"_blank\" href=\"http://865284.ichengyun.net/shareshow/index.php?app=personal&feiwa=detail&personal_id=6\">去看看</a></p>\r\n            </div>\r\n            </div>\r\n            ',1513666929,0,0,0,0,0,0,3),(29,0,0,0,1043,'adminy','','test:huffy:','\r\n            <div class=\'fd-media\'>\r\n            <div class=\'goodsimg\'><a target=\"_blank\" href=\"http://865284.ichengyun.net/shareshow/index.php?app=personal&feiwa=detail&personal_id=4#widgetcommenttitle\"><img src=\"http://865284.ichengyun.net/data/upload/shareshow/1043/05642566514641445_list.jpg\" onload=\"javascript:DrawImage(this,120,120);\"></a></div>\r\n            <div class=\'goodsinfo\'>\r\n            <ul>\r\n            </ul><p>\'adminy\'在分享秀评论了个人秀的展示<a target=\"_blank\" href=\"http://865284.ichengyun.net/shareshow/index.php?app=personal&feiwa=detail&personal_id=4#widgetcommenttitle\">去看看</a></p>\r\n            </div>\r\n            </div>\r\n            ',1515550390,0,0,0,0,0,0,3);

/*Table structure for table `feiwa_sns_visitor` */

DROP TABLE IF EXISTS `feiwa_sns_visitor`;

CREATE TABLE `feiwa_sns_visitor` (
  `v_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `v_mid` int(11) NOT NULL COMMENT '访客会员ID',
  `v_mname` varchar(100) NOT NULL DEFAULT '' COMMENT '访客会员名称',
  `v_mavatar` varchar(100) DEFAULT NULL COMMENT '访客会员头像',
  `v_ownermid` int(11) NOT NULL COMMENT '主人会员ID',
  `v_ownermname` varchar(100) NOT NULL DEFAULT '' COMMENT '主人会员名称',
  `v_ownermavatar` varchar(100) DEFAULT NULL COMMENT '主人会员头像',
  `v_addtime` int(11) NOT NULL COMMENT '访问时间',
  PRIMARY KEY (`v_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='sns访客表';

/*Data for the table `feiwa_sns_visitor` */

/*Table structure for table `feiwa_spec` */

DROP TABLE IF EXISTS `feiwa_spec`;

CREATE TABLE `feiwa_spec` (
  `sp_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '规格id',
  `sp_name` varchar(100) NOT NULL DEFAULT '' COMMENT '规格名称',
  `sp_sort` tinyint(1) unsigned NOT NULL COMMENT '排序',
  `class_id` int(10) unsigned DEFAULT '0' COMMENT '所属分类id',
  `class_name` varchar(100) DEFAULT NULL COMMENT '所属分类名称',
  PRIMARY KEY (`sp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='商品规格表';

/*Data for the table `feiwa_spec` */

insert  into `feiwa_spec`(`sp_id`,`sp_name`,`sp_sort`,`class_id`,`class_name`) values (1,'颜色',0,256,'洗护用品'),(2,'选择段位',0,470,'奶粉');

/*Table structure for table `feiwa_spec_value` */

DROP TABLE IF EXISTS `feiwa_spec_value`;

CREATE TABLE `feiwa_spec_value` (
  `sp_value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '规格值id',
  `sp_value_name` varchar(100) NOT NULL DEFAULT '' COMMENT '规格值名称',
  `sp_id` int(10) unsigned NOT NULL COMMENT '所属规格id',
  `gc_id` int(10) unsigned NOT NULL COMMENT '分类id',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺id',
  `sp_value_color` varchar(10) DEFAULT NULL COMMENT '规格颜色',
  `sp_value_sort` tinyint(1) unsigned NOT NULL COMMENT '排序',
  PRIMARY KEY (`sp_value_id`),
  KEY `store_id` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='商品规格值表';

/*Data for the table `feiwa_spec_value` */

insert  into `feiwa_spec_value`(`sp_value_id`,`sp_value_name`,`sp_id`,`gc_id`,`store_id`,`sp_value_color`,`sp_value_sort`) values (1,'aaaa',2,478,6,NULL,0),(2,'900克罐装',2,478,6,NULL,0),(3,'1200克盒装',2,478,6,NULL,0);

/*Table structure for table `feiwa_stat_member` */

DROP TABLE IF EXISTS `feiwa_stat_member`;

CREATE TABLE `feiwa_stat_member` (
  `statm_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `statm_memberid` int(11) NOT NULL COMMENT '会员ID',
  `statm_membername` varchar(100) NOT NULL DEFAULT '' COMMENT '会员名称',
  `statm_time` int(11) NOT NULL COMMENT '统计时间，当前按照最小时间单位为天',
  `statm_ordernum` int(11) NOT NULL DEFAULT '0' COMMENT '下单量',
  `statm_orderamount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '下单金额',
  `statm_goodsnum` int(11) NOT NULL DEFAULT '0' COMMENT '下单商品件数',
  `statm_predincrease` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '预存款增加额',
  `statm_predreduce` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '预存款减少额',
  `statm_pointsincrease` int(11) NOT NULL DEFAULT '0' COMMENT '积分增加额',
  `statm_pointsreduce` int(11) NOT NULL DEFAULT '0' COMMENT '积分减少额',
  `statm_updatetime` int(11) NOT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`statm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员相关数据统计';

/*Data for the table `feiwa_stat_member` */

/*Table structure for table `feiwa_stat_order` */

DROP TABLE IF EXISTS `feiwa_stat_order`;

CREATE TABLE `feiwa_stat_order` (
  `order_id` int(11) NOT NULL COMMENT '订单id',
  `order_sn` bigint(20) unsigned NOT NULL COMMENT '订单编号',
  `order_add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单生成时间',
  `payment_code` char(10) DEFAULT '' COMMENT '支付方式',
  `order_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单总价格',
  `shipping_fee` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '运费',
  `evaluation_state` enum('0','1') DEFAULT '0' COMMENT '评价状态 0未评价，1已评价',
  `order_state` enum('0','10','20','30','40') NOT NULL DEFAULT '10' COMMENT '订单状态：0(已取消)10(默认):未付款;20:已付款;30:已发货;40:已收货;',
  `refund_state` tinyint(1) unsigned DEFAULT '0' COMMENT '退款状态:0是无退款,1是部分退款,2是全部退款',
  `refund_amount` decimal(10,2) DEFAULT '0.00' COMMENT '退款金额',
  `order_from` enum('1','2') NOT NULL DEFAULT '1' COMMENT '1WEB2mobile',
  `order_isvalid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为计入统计的有效订单，0为无效 1为有效',
  `reciver_province_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '收货人省级ID',
  `store_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '卖家店铺名称',
  `grade_id` int(11) DEFAULT '0' COMMENT '店铺等级',
  `sc_id` int(11) DEFAULT '0' COMMENT '店铺分类',
  `buyer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '买家ID',
  `buyer_name` varchar(50) NOT NULL DEFAULT '' COMMENT '买家姓名',
  UNIQUE KEY `order_id` (`order_id`),
  KEY `order_add_time` (`order_add_time`),
  KEY `order_isvalid` (`order_isvalid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='统计功能订单缓存表';

/*Data for the table `feiwa_stat_order` */

/*Table structure for table `feiwa_stat_ordergoods` */

DROP TABLE IF EXISTS `feiwa_stat_ordergoods`;

CREATE TABLE `feiwa_stat_ordergoods` (
  `rec_id` int(11) NOT NULL COMMENT '订单商品表索引id',
  `stat_updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '缓存生成时间',
  `order_id` int(11) NOT NULL COMMENT '订单id',
  `order_sn` bigint(20) unsigned NOT NULL COMMENT '订单编号',
  `order_add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单生成时间',
  `payment_code` char(10) DEFAULT '' COMMENT '支付方式',
  `order_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单总价格',
  `shipping_fee` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '运费',
  `evaluation_state` enum('0','1') DEFAULT '0' COMMENT '评价状态 0未评价，1已评价',
  `order_state` enum('0','10','20','30','40') NOT NULL DEFAULT '10' COMMENT '订单状态：0(已取消)10(默认):未付款;20:已付款;30:已发货;40:已收货;',
  `refund_state` tinyint(1) unsigned DEFAULT '0' COMMENT '退款状态:0是无退款,1是部分退款,2是全部退款',
  `refund_amount` decimal(10,2) DEFAULT '0.00' COMMENT '退款金额',
  `order_from` enum('1','2') NOT NULL DEFAULT '1' COMMENT '1WEB2mobile',
  `order_isvalid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为计入统计的有效订单，0为无效 1为有效',
  `reciver_province_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '收货人省级ID',
  `store_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '卖家店铺名称',
  `grade_id` int(11) DEFAULT '0' COMMENT '店铺等级',
  `sc_id` int(11) DEFAULT '0' COMMENT '店铺分类',
  `buyer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '买家ID',
  `buyer_name` varchar(50) NOT NULL DEFAULT '' COMMENT '买家姓名',
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  `goods_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品名称(+规格)',
  `goods_commonid` int(10) unsigned NOT NULL COMMENT '商品公共表id',
  `goods_commonname` varchar(50) DEFAULT '' COMMENT '商品公共表中商品名称',
  `gc_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品最底级分类ID',
  `gc_parentid_1` int(11) DEFAULT '0' COMMENT '一级父类ID',
  `gc_parentid_2` int(11) DEFAULT '0' COMMENT '二级父类ID',
  `gc_parentid_3` int(11) DEFAULT '0' COMMENT '三级父类ID',
  `brand_id` int(10) unsigned DEFAULT '0' COMMENT '品牌id',
  `brand_name` varchar(100) DEFAULT '' COMMENT '品牌名称',
  `goods_serial` varchar(50) DEFAULT '' COMMENT '商家编号',
  `goods_price` decimal(10,2) NOT NULL COMMENT '商品价格',
  `goods_num` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT '商品数量',
  `goods_image` varchar(100) DEFAULT NULL COMMENT '商品图片',
  `goods_pay_price` decimal(10,2) unsigned NOT NULL COMMENT '商品实际成交价',
  `goods_type` enum('1','2','3','4','5') NOT NULL DEFAULT '1' COMMENT '1默认2团购商品3限时折扣商品4优惠套装5赠品',
  `promotions_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '促销活动ID（团购ID/限时折扣ID/优惠套装ID）与goods_type搭配使用',
  `commis_rate` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '佣金比例',
  UNIQUE KEY `rec_id` (`rec_id`),
  KEY `order_id` (`order_id`),
  KEY `order_add_time` (`order_add_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='统计功能订单商品缓存表';

/*Data for the table `feiwa_stat_ordergoods` */

/*Table structure for table `feiwa_store` */

DROP TABLE IF EXISTS `feiwa_store`;

CREATE TABLE `feiwa_store` (
  `store_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '店铺索引id',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `grade_id` int(11) NOT NULL COMMENT '店铺等级',
  `member_id` int(11) NOT NULL COMMENT '会员id',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '会员名称',
  `seller_name` varchar(50) DEFAULT NULL COMMENT '店主卖家用户名',
  `sc_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺分类',
  `store_company_name` varchar(50) DEFAULT NULL COMMENT '店铺公司名称',
  `province_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '店铺所在省份ID',
  `area_info` varchar(100) NOT NULL DEFAULT '' COMMENT '地区内容，冗余数据',
  `store_address` varchar(100) NOT NULL DEFAULT '' COMMENT '详细地区',
  `store_zip` varchar(10) NOT NULL DEFAULT '' COMMENT '邮政编码',
  `store_state` tinyint(1) NOT NULL DEFAULT '2' COMMENT '店铺状态，0关闭，1开启，2审核中',
  `store_close_info` varchar(255) DEFAULT NULL COMMENT '店铺关闭原因',
  `store_sort` int(11) NOT NULL DEFAULT '0' COMMENT '店铺排序',
  `store_time` varchar(10) NOT NULL DEFAULT '' COMMENT '店铺时间',
  `store_end_time` varchar(10) DEFAULT NULL COMMENT '店铺关闭时间',
  `store_label` varchar(255) DEFAULT NULL COMMENT '店铺logo',
  `store_banner` varchar(255) DEFAULT NULL COMMENT '店铺横幅',
  `store_avatar` varchar(150) DEFAULT NULL COMMENT '店铺头像',
  `store_keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '店铺seo关键字',
  `store_description` varchar(255) NOT NULL DEFAULT '' COMMENT '店铺seo描述',
  `store_qq` varchar(50) DEFAULT NULL COMMENT 'QQ',
  `store_ww` varchar(50) DEFAULT NULL COMMENT '阿里旺旺',
  `store_phone` varchar(20) DEFAULT NULL COMMENT '商家电话',
  `store_zy` text COMMENT '主营商品',
  `store_domain` varchar(50) DEFAULT NULL COMMENT '店铺二级域名',
  `store_domain_times` tinyint(1) unsigned DEFAULT '0' COMMENT '二级域名修改次数',
  `store_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐，0为否，1为是，默认为0',
  `store_theme` varchar(50) NOT NULL DEFAULT 'default' COMMENT '店铺当前主题',
  `store_credit` int(10) NOT NULL DEFAULT '0' COMMENT '店铺信用',
  `store_desccredit` float NOT NULL DEFAULT '0' COMMENT '描述相符度分数',
  `store_servicecredit` float NOT NULL DEFAULT '0' COMMENT '服务态度分数',
  `store_deliverycredit` float NOT NULL DEFAULT '0' COMMENT '发货速度分数',
  `store_collect` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '店铺收藏数量',
  `store_slide` text COMMENT '店铺幻灯片',
  `store_slide_url` text COMMENT '店铺幻灯片链接',
  `store_stamp` varchar(200) DEFAULT NULL COMMENT '店铺印章',
  `store_printdesc` varchar(500) DEFAULT NULL COMMENT '打印订单页面下方说明文字',
  `store_sales` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '店铺销量',
  `store_presales` text COMMENT '售前客服',
  `store_aftersales` text COMMENT '售后客服',
  `store_workingtime` varchar(100) DEFAULT NULL COMMENT '工作时间',
  `store_free_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '超出该金额免运费，大于0才表示该值有效',
  `store_decoration_switch` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '店铺装修开关(0-关闭 装修编号-开启)',
  `store_decoration_only` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '开启店铺装修时，仅显示店铺装修(1-是 0-否',
  `store_decoration_image_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '店铺装修相册图片数量',
  `is_own_mall` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否自营店铺 1是 0否',
  `bind_all_gc` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '自营店是否绑定全部分类 0否1是',
  `store_vrcode_prefix` char(3) DEFAULT NULL COMMENT '商家兑换码前缀',
  `mb_title_img` varchar(150) DEFAULT NULL COMMENT '手机店铺 页头背景图',
  `mb_sliders` text COMMENT '手机店铺 轮播图链接地址',
  `left_bar_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '店铺商品页面左侧显示类型 1默认 2商城相关分类品牌商品推荐',
  `deliver_region` varchar(50) DEFAULT NULL COMMENT '店铺默认配送区域',
  `is_distribution` int(10) DEFAULT '0' COMMENT '是否分销店铺(0-否，1-是）',
  PRIMARY KEY (`store_id`),
  KEY `store_name` (`store_name`),
  KEY `sc_id` (`sc_id`),
  KEY `store_state` (`store_state`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='店铺数据表';

/*Data for the table `feiwa_store` */

insert  into `feiwa_store`(`store_id`,`store_name`,`grade_id`,`member_id`,`member_name`,`seller_name`,`sc_id`,`store_company_name`,`province_id`,`area_info`,`store_address`,`store_zip`,`store_state`,`store_close_info`,`store_sort`,`store_time`,`store_end_time`,`store_label`,`store_banner`,`store_avatar`,`store_keywords`,`store_description`,`store_qq`,`store_ww`,`store_phone`,`store_zy`,`store_domain`,`store_domain_times`,`store_recommend`,`store_theme`,`store_credit`,`store_desccredit`,`store_servicecredit`,`store_deliverycredit`,`store_collect`,`store_slide`,`store_slide_url`,`store_stamp`,`store_printdesc`,`store_sales`,`store_presales`,`store_aftersales`,`store_workingtime`,`store_free_price`,`store_decoration_switch`,`store_decoration_only`,`store_decoration_image_count`,`is_own_mall`,`bind_all_gc`,`store_vrcode_prefix`,`mb_title_img`,`mb_sliders`,`left_bar_type`,`deliver_region`,`is_distribution`) values (1,'店铺名称',0,1,'member','seller',0,NULL,0,'','','',1,NULL,0,'1510298830',NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,0,0,'default',0,0,0,0,2,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'0.00',0,0,0,1,1,NULL,NULL,NULL,1,NULL,0),(6,'商城',3,1041,'zxx1cndns','zxx2cndns',2,'zxx',0,'上海 上海市 黄浦区','上海市','',1,'',0,'1510651303','1542211200','05642351277883625.jpg','05642351277881251.jpg',NULL,'','','','','','zxx店铺',NULL,0,1,'default',0,0,0,0,1,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'100.00',0,0,0,0,0,NULL,NULL,NULL,1,'1 36 37|北京 北京市 东城区',0),(7,'feng店铺名称',2,1042,'fengfeng','fengfeng',2,'fengfeng',0,'上海 上海市 黄浦区','sh','',1,NULL,0,'1510652284','1542297599',NULL,NULL,NULL,'','',NULL,NULL,NULL,'',NULL,0,1,'default',0,0,0,0,1,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'0.00',0,0,0,0,0,NULL,NULL,NULL,1,NULL,0),(8,'adminy',3,1043,'adminy','adminy',3,'adminy',0,'上海 上海市 黄浦区','adminy','',1,NULL,0,'1510797064','1574006399','05689106037941461.jpg','05689107265442456.png','05689105940914312_sm.jpg','','','','','','店铺设计',NULL,0,1,'default',0,0,0,0,0,'05760944506006651.jpg,,,,','http://,http://,http://,http://,http://',NULL,NULL,0,NULL,NULL,NULL,'0.00',4,1,4,0,0,NULL,NULL,NULL,1,'|',1),(9,'杭州服务中心',1,1044,'cliffgyn','cliffgyn',8,'杭州服务中心',0,'浙江 杭州市 西湖区','文三路478号华星时代广场A903室','',1,NULL,0,'1513701645','1545407999',NULL,NULL,NULL,'','',NULL,NULL,NULL,'',NULL,0,0,'default',0,0,0,0,1,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'0.00',0,0,0,0,0,NULL,NULL,NULL,1,NULL,1),(10,'天河店',0,1050,'tianhe','tianhe',0,NULL,0,'','','',1,NULL,0,'1515311234',NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,0,0,'default',0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'0.00',0,0,0,1,1,NULL,NULL,NULL,1,NULL,0),(11,'测试',2,1052,'leitao','12345',2,'123',0,'上海','上海黄浦区局门路','',1,NULL,0,'1515565480','1578758399',NULL,NULL,NULL,'','',NULL,NULL,NULL,'',NULL,0,0,'default',0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'0.00',0,0,0,0,0,NULL,NULL,NULL,1,NULL,1),(12,'123456',3,1055,'admin111','123456',6,'75272',0,'天津 天津市 河东区','2727','',1,NULL,0,'1516071763','1579276799',NULL,NULL,NULL,'','',NULL,NULL,NULL,'',NULL,0,0,'default',0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'0.00',0,0,0,0,0,NULL,NULL,NULL,1,NULL,0),(13,'dearbaby小寨店',0,1057,'xiaozhai','xiaozhaidian',0,NULL,0,'','','',1,'',0,'1517889256',NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,0,0,'default',0,0,0,0,0,NULL,NULL,NULL,NULL,0,'a:1:{i:0;a:3:{s:4:\"name\";s:7:\"售前1\";s:4:\"type\";i:1;s:3:\"num\";s:9:\"113184063\";}}','a:1:{i:0;a:3:{s:4:\"name\";s:7:\"售后1\";s:4:\"type\";i:1;s:3:\"num\";s:10:\"1831400316\";}}','','0.00',0,0,0,1,1,NULL,NULL,NULL,1,NULL,0),(14,'问温柔而然',1,1061,'hzyuandun','诶我俄文问',3,'杭州源盾信息科技有限公司',11,'浙江 杭州市 滨江区','滨文路158号','',1,NULL,0,'1523952685','1555603199',NULL,NULL,NULL,'','',NULL,NULL,NULL,'',NULL,0,0,'default',0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'0.00',0,0,0,0,0,NULL,NULL,NULL,1,NULL,0);

/*Table structure for table `feiwa_store_bind_class` */

DROP TABLE IF EXISTS `feiwa_store_bind_class`;

CREATE TABLE `feiwa_store_bind_class` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `store_id` int(11) unsigned DEFAULT '0' COMMENT '店铺ID',
  `commis_rate` tinyint(4) unsigned DEFAULT '0' COMMENT '佣金比例',
  `class_1` mediumint(9) unsigned DEFAULT '0' COMMENT '一级分类',
  `class_2` mediumint(9) unsigned DEFAULT '0' COMMENT '二级分类',
  `class_3` mediumint(9) unsigned DEFAULT '0' COMMENT '三级分类',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态0审核中1已审核 2平台自营店铺',
  PRIMARY KEY (`bid`),
  KEY `store_id` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='店铺可发布商品类目表';

/*Data for the table `feiwa_store_bind_class` */

insert  into `feiwa_store_bind_class`(`bid`,`store_id`,`commis_rate`,`class_1`,`class_2`,`class_3`,`state`) values (5,6,5,470,0,NULL,1),(6,6,5,470,471,478,1),(8,6,1,256,1034,1035,1),(9,7,5,470,471,478,1),(11,7,1,256,1034,1035,1),(19,6,5,470,471,479,1),(21,6,5,470,471,486,1),(22,8,0,256,1034,1035,1),(26,6,0,308,309,314,1),(29,9,0,730,1054,1056,1),(37,8,1,2,152,162,1),(40,14,0,1,0,NULL,1),(42,8,0,2,151,157,1),(43,6,0,1,8,101,1);

/*Table structure for table `feiwa_store_class` */

DROP TABLE IF EXISTS `feiwa_store_class`;

CREATE TABLE `feiwa_store_class` (
  `sc_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引ID',
  `sc_name` varchar(50) NOT NULL DEFAULT '' COMMENT '分类名称',
  `sc_bail` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '保证金数额',
  `sc_sort` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`sc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='店铺分类表';

/*Data for the table `feiwa_store_class` */

insert  into `feiwa_store_class`(`sc_id`,`sc_name`,`sc_bail`,`sc_sort`) values (1,'珠宝/首饰',0,8),(2,'服装鞋包',0,1),(3,'3C数码',0,2),(4,'美容护理',0,3),(5,'家居用品',0,4),(6,'食品/保健',0,5),(7,'母婴用品',0,6),(8,'文体/汽车',0,7),(9,'收藏/爱好',0,9),(10,'生活/服务',0,10);

/*Table structure for table `feiwa_store_cost` */

DROP TABLE IF EXISTS `feiwa_store_cost`;

CREATE TABLE `feiwa_store_cost` (
  `cost_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '费用编号',
  `cost_store_id` int(10) unsigned NOT NULL COMMENT '店铺编号',
  `cost_seller_id` int(10) unsigned NOT NULL COMMENT '卖家编号',
  `cost_price` int(10) unsigned NOT NULL COMMENT '价格',
  `cost_remark` varchar(255) NOT NULL DEFAULT '' COMMENT '费用备注',
  `cost_state` tinyint(3) unsigned NOT NULL COMMENT '费用状态(0-未结算 1-已结算)',
  `cost_time` int(10) unsigned NOT NULL COMMENT '费用发生时间',
  PRIMARY KEY (`cost_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='店铺费用表';

/*Data for the table `feiwa_store_cost` */

insert  into `feiwa_store_cost`(`cost_id`,`cost_store_id`,`cost_seller_id`,`cost_price`,`cost_remark`,`cost_state`,`cost_time`) values (3,7,7,20,'购买团购',0,1510814164),(4,7,7,40,'购买推荐展位',0,1510815142),(5,6,6,20,'购买团购',0,1510815594),(6,6,6,40,'购买推荐展位',0,1510815906),(7,6,6,200,'购买加价购',0,1510884810),(8,6,6,110,'购买限时折扣',0,1510884826),(9,6,6,240,'购买满即送',0,1510908607),(10,8,8,10,'购买团购',0,1513696037),(11,8,8,40,'购买代金券套餐',0,1515047153),(12,8,8,10,'购买团购',0,1517548677),(13,8,8,10,'购买团购',0,1517548682),(14,8,8,10,'购买团购',0,1517548700),(15,8,8,20,'购买加价购',0,1536115056),(16,8,8,900,'购买团购',0,1536134349);

/*Table structure for table `feiwa_store_decoration` */

DROP TABLE IF EXISTS `feiwa_store_decoration`;

CREATE TABLE `feiwa_store_decoration` (
  `decoration_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '装修编号',
  `decoration_name` varchar(50) NOT NULL DEFAULT '' COMMENT '装修名称',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺编号',
  `decoration_setting` varchar(500) DEFAULT NULL COMMENT '装修整体设置(背景、边距等)',
  `decoration_nav` varchar(5000) DEFAULT NULL COMMENT '装修导航',
  `decoration_banner` varchar(255) DEFAULT NULL COMMENT '装修头部banner',
  PRIMARY KEY (`decoration_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='店铺装修表';

/*Data for the table `feiwa_store_decoration` */

insert  into `feiwa_store_decoration`(`decoration_id`,`decoration_name`,`store_id`,`decoration_setting`,`decoration_nav`,`decoration_banner`) values (3,'默认装修',6,NULL,NULL,NULL),(4,'默认装修',8,'a:6:{s:16:\"background_color\";s:0:\"\";s:16:\"background_image\";s:0:\"\";s:23:\"background_image_repeat\";s:9:\"no-repeat\";s:21:\"background_position_x\";s:0:\"\";s:21:\"background_position_y\";s:0:\"\";s:21:\"background_attachment\";s:7:\"#000000\";}','a:2:{s:7:\"display\";s:4:\"true\";s:5:\"style\";s:491:\".feiwa-ss-nav { background-color: #D93600; border: 1px solid #B22D00; height: 38px; overflow: hidden; width: 998px; }.feiwa-ss-nav ul { white-space: nowrap; display: block; width: 999px; height: 38px; margin-left: -1px; overflow: hidden;}.feiwa-ss-nav li a span { font-size: 14px; font-weight: 600; line-height: 20px; text-overflow: ellipsis; white-space: nowrap; max-width:160px; color: #FFF; float: left; height: 20px; padding: 9px 15px; margin-left: 4px; overflow:hidden; cursor:pointer;}\";}','a:2:{s:7:\"display\";s:5:\"false\";s:5:\"image\";s:23:\"8_05760945824281289.jpg\";}'),(5,'默认装修',9,NULL,NULL,NULL),(6,'默认装修',12,NULL,NULL,NULL),(7,'默认装修',13,'a:6:{s:16:\"background_color\";s:0:\"\";s:16:\"background_image\";s:24:\"13_05712333808331106.png\";s:23:\"background_image_repeat\";s:9:\"no-repeat\";s:21:\"background_position_x\";s:0:\"\";s:21:\"background_position_y\";s:0:\"\";s:21:\"background_attachment\";s:0:\"\";}',NULL,NULL),(8,'默认装修',1,NULL,'a:2:{s:7:\"display\";s:4:\"true\";s:5:\"style\";s:491:\".feiwa-ss-nav { background-color: #D93600; border: 1px solid #B22D00; height: 38px; overflow: hidden; width: 998px; }.feiwa-ss-nav ul { white-space: nowrap; display: block; width: 999px; height: 38px; margin-left: -1px; overflow: hidden;}.feiwa-ss-nav li a span { font-size: 14px; font-weight: 600; line-height: 20px; text-overflow: ellipsis; white-space: nowrap; max-width:160px; color: #FFF; float: left; height: 20px; padding: 9px 15px; margin-left: 4px; overflow:hidden; cursor:pointer;}\";}',NULL);

/*Table structure for table `feiwa_store_decoration_album` */

DROP TABLE IF EXISTS `feiwa_store_decoration_album`;

CREATE TABLE `feiwa_store_decoration_album` (
  `image_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '图片编号',
  `image_name` varchar(50) NOT NULL DEFAULT '' COMMENT '图片名称',
  `image_origin_name` varchar(50) NOT NULL DEFAULT '' COMMENT '图片原始名称',
  `image_width` int(10) unsigned NOT NULL COMMENT '图片宽度',
  `image_height` int(10) unsigned NOT NULL COMMENT '图片高度',
  `image_size` int(10) unsigned NOT NULL COMMENT '图片大小',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺编号',
  `upload_time` int(10) unsigned NOT NULL COMMENT '上传时间',
  PRIMARY KEY (`image_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='店铺装修相册表';

/*Data for the table `feiwa_store_decoration_album` */

insert  into `feiwa_store_decoration_album`(`image_id`,`image_name`,`image_origin_name`,`image_width`,`image_height`,`image_size`,`store_id`,`upload_time`) values (2,'8_05760945824281289.jpg','87523606862bf30a9aff882b6052b15e',1920,768,236304,8,1522750582),(3,'8_05760952447441897.jpg','87523606862bf30a9aff882b6052b15e',1920,768,236304,8,1522751244),(4,'8_05760952583944058.jpg','87523606862bf30a9aff882b6052b15e',1920,768,236304,8,1522751258),(5,'8_05760957616670358.jpg','87523606862bf30a9aff882b6052b15e',1920,768,236304,8,1522751761);

/*Table structure for table `feiwa_store_decoration_block` */

DROP TABLE IF EXISTS `feiwa_store_decoration_block`;

CREATE TABLE `feiwa_store_decoration_block` (
  `block_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '装修块编号',
  `decoration_id` int(10) unsigned NOT NULL COMMENT '装修编号',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺编号',
  `block_layout` varchar(50) NOT NULL DEFAULT '' COMMENT '块布局',
  `block_content` text COMMENT '块内容',
  `block_module_type` varchar(50) DEFAULT NULL COMMENT '装修块模块类型',
  `block_full_width` tinyint(3) unsigned DEFAULT NULL COMMENT '是否100%宽度(0-否 1-是)',
  `block_sort` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '块排序',
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='店铺装修块表';

/*Data for the table `feiwa_store_decoration_block` */

insert  into `feiwa_store_decoration_block`(`block_id`,`decoration_id`,`store_id`,`block_layout`,`block_content`,`block_module_type`,`block_full_width`,`block_sort`) values (7,5,9,'block_1','N;','goods',0,1),(14,4,8,'block_1','a:2:{s:6:\"height\";s:3:\"400\";s:6:\"images\";a:2:{i:0;a:2:{s:10:\"image_name\";s:23:\"8_05760952447441897.jpg\";s:10:\"image_link\";s:0:\"\";}i:1;a:2:{s:10:\"image_name\";s:23:\"8_05760952583944058.jpg\";s:10:\"image_link\";s:0:\"\";}}}','slide',1,1),(15,4,8,'block_1','a:6:{i:0;a:4:{s:8:\"goods_id\";s:6:\"100229\";s:10:\"goods_name\";s:4:\"1111\";s:11:\"goods_price\";s:4:\"1.00\";s:11:\"goods_image\";s:23:\"8_05690878192014201.jpg\";}i:1;a:4:{s:8:\"goods_id\";s:6:\"100228\";s:10:\"goods_name\";s:9:\"充值卡\";s:11:\"goods_price\";s:6:\"100.00\";s:11:\"goods_image\";s:23:\"8_05704559485578983.png\";}i:2;a:4:{s:8:\"goods_id\";s:6:\"100226\";s:10:\"goods_name\";s:18:\"测试添加商品\";s:11:\"goods_price\";s:7:\"1980.00\";s:11:\"goods_image\";s:23:\"8_05690878192014201.jpg\";}i:3;a:4:{s:8:\"goods_id\";s:6:\"100225\";s:10:\"goods_name\";s:88:\"2017冬季加绒女靴新款真皮女鞋尖头高跟短靴裸色细跟裸靴及踝靴女\";s:11:\"goods_price\";s:6:\"229.00\";s:11:\"goods_image\";s:0:\"\";}i:4;a:4:{s:8:\"goods_id\";s:6:\"100224\";s:10:\"goods_name\";s:10:\"小米note\";s:11:\"goods_price\";s:7:\"2090.00\";s:11:\"goods_image\";s:23:\"8_05675387995058942.jpg\";}i:5;a:4:{s:8:\"goods_id\";s:6:\"100223\";s:10:\"goods_name\";s:6:\"asdsad\";s:11:\"goods_price\";s:6:\"100.00\";s:11:\"goods_image\";s:23:\"8_05671682277834917.jpg\";}}','goods',0,2),(16,4,8,'block_1',NULL,NULL,NULL,3),(17,8,1,'block_1',NULL,NULL,NULL,1),(18,8,1,'block_1',NULL,NULL,NULL,2),(19,8,1,'block_1',NULL,NULL,NULL,3),(20,4,8,'block_1',NULL,NULL,NULL,4),(21,4,8,'block_1',NULL,NULL,NULL,5);

/*Table structure for table `feiwa_store_distribution` */

DROP TABLE IF EXISTS `feiwa_store_distribution`;

CREATE TABLE `feiwa_store_distribution` (
  `distri_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `distri_store_id` int(11) NOT NULL,
  `distri_store_name` varchar(255) NOT NULL DEFAULT '',
  `distri_seller_name` varchar(255) NOT NULL DEFAULT '',
  `distri_state` int(11) NOT NULL,
  `distri_create_time` int(11) NOT NULL,
  PRIMARY KEY (`distri_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='三级分销商家申请表';

/*Data for the table `feiwa_store_distribution` */

insert  into `feiwa_store_distribution`(`distri_id`,`distri_store_id`,`distri_store_name`,`distri_seller_name`,`distri_state`,`distri_create_time`) values (3,8,'adminy','adminy',1,1510902299),(4,9,'杭州服务中心','cliffgyn',1,1513702033),(5,11,'测试','12345',1,1515567138),(6,12,'123456','123456',0,1516072208),(7,13,'dearbaby小寨店','xiaozhaidian',0,1517890565),(8,1,'店铺名称','seller',0,1528283331);

/*Table structure for table `feiwa_store_extend` */

DROP TABLE IF EXISTS `feiwa_store_extend`;

CREATE TABLE `feiwa_store_extend` (
  `store_id` mediumint(8) unsigned NOT NULL COMMENT '店铺ID',
  `express` text COMMENT '快递公司ID的组合',
  `pricerange` text COMMENT '店铺统计设置的商品价格区间',
  `orderpricerange` text COMMENT '店铺统计设置的订单价格区间',
  `bill_cycle` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '结算周期，单位天，默认0表示未设置，还是按月结算',
  PRIMARY KEY (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺信息扩展表';

/*Data for the table `feiwa_store_extend` */

insert  into `feiwa_store_extend`(`store_id`,`express`,`pricerange`,`orderpricerange`,`bill_cycle`) values (1,NULL,NULL,NULL,0),(6,'29,41,40,44,1,2,3,4',NULL,NULL,15),(7,NULL,NULL,NULL,0),(8,'29,41',NULL,NULL,0),(9,NULL,NULL,NULL,0),(10,NULL,NULL,NULL,0),(11,NULL,NULL,NULL,0),(12,NULL,NULL,NULL,0),(13,NULL,NULL,NULL,0),(14,NULL,NULL,NULL,0);

/*Table structure for table `feiwa_store_goods_class` */

DROP TABLE IF EXISTS `feiwa_store_goods_class`;

CREATE TABLE `feiwa_store_goods_class` (
  `stc_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引ID',
  `stc_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺商品分类名称',
  `stc_parent_id` int(11) NOT NULL COMMENT '父级id',
  `stc_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '店铺商品分类状态',
  `store_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `stc_sort` int(11) NOT NULL DEFAULT '0' COMMENT '商品分类排序',
  PRIMARY KEY (`stc_id`),
  KEY `stc_parent_id` (`stc_parent_id`,`stc_sort`),
  KEY `store_id` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='店铺商品分类表';

/*Data for the table `feiwa_store_goods_class` */

insert  into `feiwa_store_goods_class`(`stc_id`,`stc_name`,`stc_parent_id`,`stc_state`,`store_id`,`stc_sort`) values (8,'虚拟产品',0,1,8,0),(9,'PC电脑',0,1,8,0),(10,'手机',0,1,8,0),(11,'MAC',0,1,8,0),(12,'华为手机',0,1,8,0),(13,'华为MAC',0,1,8,0),(14,'华为PC',0,1,8,0),(15,'华为P10',12,1,8,0);

/*Table structure for table `feiwa_store_grade` */

DROP TABLE IF EXISTS `feiwa_store_grade`;

CREATE TABLE `feiwa_store_grade` (
  `sg_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引ID',
  `sg_name` char(50) DEFAULT NULL COMMENT '等级名称',
  `sg_goods_limit` mediumint(10) unsigned NOT NULL DEFAULT '0' COMMENT '允许发布的商品数量',
  `sg_album_limit` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '允许上传图片数量',
  `sg_space_limit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传空间大小，单位MB',
  `sg_template_number` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '选择店铺模板套数',
  `sg_template` varchar(255) DEFAULT NULL COMMENT '模板内容',
  `sg_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '开店费用(元/年)',
  `sg_description` text COMMENT '申请说明',
  `sg_function` varchar(255) DEFAULT NULL COMMENT '附加功能',
  `sg_sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '级别，数目越大级别越高',
  PRIMARY KEY (`sg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='店铺等级表';

/*Data for the table `feiwa_store_grade` */

insert  into `feiwa_store_grade`(`sg_id`,`sg_name`,`sg_goods_limit`,`sg_album_limit`,`sg_space_limit`,`sg_template_number`,`sg_template`,`sg_price`,`sg_description`,`sg_function`,`sg_sort`) values (1,'系统默认',100,500,100,6,'default|style1|style2|style3|style4|style5','0.00','用户选择“默认等级”，可以立即开通。','',0),(2,'白金店铺',200,1000,100,6,'default|style1|style2|style3|style4|style5','200.00','享受更多特权','editor_multimedia',2),(3,'钻石店铺',0,1000,100,6,'default|style1|style2|style3|style4|style5','1000.00','','editor_multimedia',100),(4,'钻石',50,1000,100,0,'default','500.00','','editor_multimedia',10);

/*Table structure for table `feiwa_store_joinin` */

DROP TABLE IF EXISTS `feiwa_store_joinin`;

CREATE TABLE `feiwa_store_joinin` (
  `member_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `member_name` varchar(50) DEFAULT NULL COMMENT '店主用户名',
  `company_name` varchar(50) DEFAULT NULL COMMENT '公司名称',
  `company_province_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '所在地省ID',
  `company_address` varchar(50) DEFAULT NULL COMMENT '公司地址',
  `company_address_detail` varchar(50) DEFAULT NULL COMMENT '公司详细地址',
  `company_phone` varchar(20) DEFAULT NULL COMMENT '公司电话',
  `company_employee_count` int(10) unsigned DEFAULT NULL COMMENT '员工总数',
  `company_registered_capital` int(10) unsigned DEFAULT NULL COMMENT '注册资金',
  `contacts_name` varchar(50) DEFAULT NULL COMMENT '联系人姓名',
  `contacts_phone` varchar(20) DEFAULT NULL COMMENT '联系人电话',
  `contacts_email` varchar(50) DEFAULT NULL COMMENT '联系人邮箱',
  `business_licence_number` varchar(50) DEFAULT NULL COMMENT '营业执照号',
  `business_licence_address` varchar(50) DEFAULT NULL COMMENT '营业执所在地',
  `business_licence_start` date DEFAULT NULL COMMENT '营业执照有效期开始',
  `business_licence_end` date DEFAULT NULL COMMENT '营业执照有效期结束',
  `business_sphere` varchar(1000) DEFAULT NULL COMMENT '法定经营范围',
  `business_licence_number_elc` varchar(50) DEFAULT NULL COMMENT '营业执照电子版',
  `organization_code` varchar(50) DEFAULT NULL COMMENT '组织机构代码',
  `organization_code_electronic` varchar(50) DEFAULT NULL COMMENT '组织机构代码电子版',
  `general_taxpayer` varchar(50) DEFAULT NULL COMMENT '一般纳税人证明',
  `bank_account_name` varchar(50) DEFAULT NULL COMMENT '银行开户名',
  `bank_account_number` varchar(50) DEFAULT NULL COMMENT '公司银行账号',
  `bank_name` varchar(50) DEFAULT NULL COMMENT '开户银行支行名称',
  `bank_code` varchar(50) DEFAULT NULL COMMENT '支行联行号',
  `bank_address` varchar(50) DEFAULT NULL COMMENT '开户银行所在地',
  `bank_licence_electronic` varchar(50) DEFAULT NULL COMMENT '开户银行许可证电子版',
  `is_settlement_account` tinyint(1) DEFAULT NULL COMMENT '开户行账号是否为结算账号 1-开户行就是结算账号 2-独立的计算账号',
  `settlement_bank_account_name` varchar(50) DEFAULT NULL COMMENT '结算银行开户名',
  `settlement_bank_account_number` varchar(50) DEFAULT NULL COMMENT '结算公司银行账号',
  `settlement_bank_name` varchar(50) DEFAULT NULL COMMENT '结算开户银行支行名称',
  `settlement_bank_code` varchar(50) DEFAULT NULL COMMENT '结算支行联行号',
  `settlement_bank_address` varchar(50) DEFAULT NULL COMMENT '结算开户银行所在地',
  `tax_registration_certificate` varchar(50) DEFAULT NULL COMMENT '税务登记证号',
  `taxpayer_id` varchar(50) DEFAULT NULL COMMENT '纳税人识别号',
  `tax_registration_certif_elc` varchar(50) DEFAULT NULL COMMENT '税务登记证号电子版',
  `seller_name` varchar(50) DEFAULT NULL COMMENT '卖家账号',
  `store_name` varchar(50) DEFAULT NULL COMMENT '店铺名称',
  `store_class_ids` varchar(1000) DEFAULT NULL COMMENT '店铺分类编号集合',
  `store_class_names` varchar(1000) DEFAULT NULL COMMENT '店铺分类名称集合',
  `joinin_state` varchar(50) DEFAULT NULL COMMENT '申请状态 10-已提交申请 11-缴费完成  20-审核成功 30-审核失败 31-缴费审核失败 40-审核通过开店',
  `joinin_message` varchar(200) DEFAULT NULL COMMENT '管理员审核信息',
  `joinin_year` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '开店时长(年)',
  `sg_name` varchar(50) DEFAULT NULL COMMENT '店铺等级名称',
  `sg_id` int(10) unsigned DEFAULT NULL COMMENT '店铺等级编号',
  `sg_info` varchar(200) DEFAULT NULL COMMENT '店铺等级下的收费等信息',
  `sc_name` varchar(50) DEFAULT NULL COMMENT '店铺分类名称',
  `sc_id` int(10) unsigned DEFAULT NULL COMMENT '店铺分类编号',
  `sc_bail` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '店铺分类保证金',
  `store_class_commis_rates` varchar(200) DEFAULT NULL COMMENT '分类佣金比例',
  `paying_money_certificate` varchar(50) DEFAULT NULL COMMENT '付款凭证',
  `paying_money_certif_exp` varchar(200) DEFAULT NULL COMMENT '付款凭证说明',
  `paying_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '付款金额',
  `hetong` text NOT NULL COMMENT '合同',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺入住表';

/*Data for the table `feiwa_store_joinin` */

insert  into `feiwa_store_joinin`(`member_id`,`member_name`,`company_name`,`company_province_id`,`company_address`,`company_address_detail`,`company_phone`,`company_employee_count`,`company_registered_capital`,`contacts_name`,`contacts_phone`,`contacts_email`,`business_licence_number`,`business_licence_address`,`business_licence_start`,`business_licence_end`,`business_sphere`,`business_licence_number_elc`,`organization_code`,`organization_code_electronic`,`general_taxpayer`,`bank_account_name`,`bank_account_number`,`bank_name`,`bank_code`,`bank_address`,`bank_licence_electronic`,`is_settlement_account`,`settlement_bank_account_name`,`settlement_bank_account_number`,`settlement_bank_name`,`settlement_bank_code`,`settlement_bank_address`,`tax_registration_certificate`,`taxpayer_id`,`tax_registration_certif_elc`,`seller_name`,`store_name`,`store_class_ids`,`store_class_names`,`joinin_state`,`joinin_message`,`joinin_year`,`sg_name`,`sg_id`,`sg_info`,`sc_name`,`sc_id`,`sc_bail`,`store_class_commis_rates`,`paying_money_certificate`,`paying_money_certif_exp`,`paying_amount`,`hetong`) values (1041,'zxx1cndns','zxx',0,'上海 上海市 黄浦区','上海市',NULL,NULL,NULL,'赵','11111123','zxx@cndns.com','111112374',NULL,NULL,NULL,'赵新新','05639949131211982.jpg',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'招行','6225881219057386','上海','','上海 上海市 黄浦区',NULL,NULL,NULL,'zxx2cndns','商城','a:4:{i:0;s:4:\"470,\";i:1;s:2:\"1,\";i:2;s:2:\"2,\";i:3;s:2:\"3,\";}','a:4:{i:0;s:13:\"个护化妆,\";i:1;s:13:\"服饰鞋帽,\";i:2;s:13:\"礼品箱包,\";i:3;s:13:\"家居家装,\";}','40','7777',1,'系统默认',1,'a:1:{s:8:\"sg_price\";s:6:\"100.00\";}','服装鞋包',2,0,'5,0,0,0','05639952674361972.jpg','2qaqqdf','100.00','05639952674386139.jpg|05639952674432726.jpg|05639952674463868.jpg|||'),(1042,'fengfeng','fengfeng',0,'上海 上海市 黄浦区','sh',NULL,NULL,NULL,'feng','13916230000','xqf@cndns.com','331232198090000033',NULL,NULL,NULL,'feng','05639958924641487.jpeg',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'招商','6225008129703622','上海','','上海 上海市 黄浦区',NULL,NULL,NULL,'fengfeng','feng店铺名称','a:4:{i:0;s:12:\"470,471,478,\";i:1;s:12:\"256,258,264,\";i:2;s:14:\"256,1034,1035,\";i:3;s:12:\"256,390,398,\";}','a:4:{i:0;s:36:\"个护化妆,面部护理,洁面乳,\";i:1;s:39:\"数码办公,手机配件,手机电池,\";i:2;s:33:\"数码办公,手机通讯,手机,\";i:3;s:36:\"数码办公,电脑整机,笔记本,\";}','40','',1,'白金店铺',2,'a:1:{s:8:\"sg_price\";s:6:\"200.00\";}','服装鞋包',2,0,'5,1,1,1','05639962583454397.jpg','','200.00','05639962583515681.jpg|05639962583537318.jpg|05639962583553757.jpg|||'),(1043,'adminy','adminy',0,'上海 上海市 黄浦区','adminy',NULL,NULL,NULL,'adminy','adminy','adminy@a.com','adminy',NULL,NULL,NULL,'adminy','05641408957820155.jpg',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'adminy','66666669292','adminy','','上海 上海市 奉贤区',NULL,NULL,NULL,'adminy','adminy','a:1:{i:0;s:14:\"256,1034,1035,\";}','a:1:{i:0;s:33:\"数码办公,手机通讯,手机,\";}','40','',2,'钻石店铺',3,'a:1:{s:8:\"sg_price\";s:7:\"1000.00\";}','3C数码',3,0,'0','05641410219983180.jpg','','2000.00','05641410220063142.jpg|05641410220064939.jpg|05641410220068513.jpg|||'),(1044,'cliffgyn','杭州服务中心',0,'浙江 杭州市 西湖区','文三路478号华星时代广场A903室',NULL,NULL,NULL,'gaoyanan','13888888888','41111111@qq.com','330105199999999999',NULL,NULL,NULL,'gyn','05670453844478096.jpg',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'3333333','3333','33333','333','浙江 杭州市 上城区',NULL,NULL,NULL,'cliffgyn','杭州服务中心','a:1:{i:0;s:14:\"730,1054,1056,\";}','a:1:{i:0;s:30:\"汽车用品,整车,二手车,\";}','40','',1,'系统默认',1,'a:1:{s:8:\"sg_price\";s:6:\"100.00\";}','文体/汽车',8,0,'0','05670456211917952.jpg','','100.00','05670456211919287.jpg|05670456212227636.jpg|05670456212227314.jpg|||'),(1052,'leitao','123',0,'上海','上海黄浦区局门路',NULL,NULL,NULL,'蕾蕾','15216815291','3173644049@qq.com','5002341989121011',NULL,NULL,NULL,'雷雷','05688984284407229.jpg',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'7843648736469845','中国银行','中国银行局门支行','','上海 上海市 黄浦区',NULL,NULL,NULL,'12345','测试','a:5:{i:0;s:12:\"530,536,566,\";i:1;s:7:\"1,4,12,\";i:2;s:7:\"1,4,13,\";i:3;s:7:\"1,5,37,\";i:4;s:7:\"1,5,39,\";}','a:5:{i:0;s:40:\"珠宝手表,翡翠玉石,项链/吊坠,\";i:1;s:25:\"服饰鞋帽,女装,T恤,\";i:2;s:27:\"服饰鞋帽,女装,衬衫,\";i:3;s:28:\"服饰鞋帽,男装,POLO衫,\";i:4;s:30:\"服饰鞋帽,男装,羊绒衫,\";}','40','',2,'白金店铺',2,'a:1:{s:8:\"sg_price\";s:6:\"200.00\";}','服装鞋包',2,0,'0,0,0,0,0','05689094225410488.jpg','','400.00','05689094225419091.jpg|05689094225564732.jpg|05689094225566817.jpg|05689094225726816.jpg|05689094225728906.jpg|'),(1055,'admin111','75272',0,'天津 天津市 河东区','2727',NULL,NULL,NULL,'87678','6786786378','764759168@qq.com','87578578',NULL,NULL,NULL,'778','05694154770107527.jpg',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2727','27827275272','752752752','72752752','天津 天津市 和平区',NULL,NULL,NULL,'123456','123456','a:1:{i:0;s:12:\"959,961,978,\";}','a:1:{i:0;s:33:\"母婴用品,营养辅食,初乳,\";}','40','',2,'钻石店铺',3,'a:1:{s:8:\"sg_price\";s:7:\"1000.00\";}','食品/保健',6,0,'0','05694157436741462.jpg','','2000.00','05694157436743636.jpg|05694157436900202.jpg|05694157436904502.jpg|||'),(1061,'hzyuandun','杭州源盾信息科技有限公司',11,'浙江 杭州市 滨江区','滨文路158号','18958133771',20,300,'王志远','18958133771','18958133771@189.cn','91330108MA27XCWK7X','浙江 杭州市 滨江区','2017-04-13','2028-04-07','eqwr er er ra sdr re ra','05772962862741381.jpg','','','','杭州源盾信息科技有限公司','为请问AWE WE QWE WQ','E WQE QWE','问请问而且AWEA请问亲','内蒙古 乌海市 海勃湾区','05772963344683689.jpg',2,'为娃儿安慰','安慰安慰呃啊诶我','额哇爱情为','问安慰我亲爱','云南 曲靖市 富源县','','','','诶我俄文问','问温柔而然','a:3:{i:0;s:8:\"256,259,\";i:1;s:2:\"1,\";i:2;s:12:\"256,261,299,\";}','a:3:{i:0;s:26:\"数码办公,摄影摄像,\";i:1;s:13:\"服饰鞋帽,\";i:2;s:36:\"数码办公,时尚影音,电子书,\";}','40','',1,'系统默认',1,'a:1:{s:8:\"sg_price\";s:4:\"0.00\";}','3C数码',3,0,'0,0,0',NULL,NULL,'0.00','');

/*Table structure for table `feiwa_store_map` */

DROP TABLE IF EXISTS `feiwa_store_map`;

CREATE TABLE `feiwa_store_map` (
  `map_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '地图ID',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺ID',
  `sc_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '店铺分类ID',
  `store_name` varchar(20) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `name_info` varchar(20) NOT NULL DEFAULT '' COMMENT '详细名称',
  `address_info` varchar(30) NOT NULL DEFAULT '' COMMENT '详细地址',
  `phone_info` varchar(50) DEFAULT '' COMMENT '电话信息',
  `bus_info` varchar(250) DEFAULT '' COMMENT '公交信息',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `baidu_lng` float NOT NULL DEFAULT '0' COMMENT '百度经度',
  `baidu_lat` float NOT NULL DEFAULT '0' COMMENT '百度纬度',
  `baidu_province` varchar(15) NOT NULL DEFAULT '' COMMENT '百度省份',
  `baidu_city` varchar(15) NOT NULL DEFAULT '' COMMENT '百度城市',
  `baidu_district` varchar(15) NOT NULL DEFAULT '' COMMENT '百度区县',
  `baidu_street` varchar(15) DEFAULT '' COMMENT '百度街道',
  PRIMARY KEY (`map_id`),
  KEY `store_id` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='店铺百度地图表';

/*Data for the table `feiwa_store_map` */

insert  into `feiwa_store_map`(`map_id`,`store_id`,`sc_id`,`store_name`,`name_info`,`address_info`,`phone_info`,`bus_info`,`update_time`,`baidu_lng`,`baidu_lat`,`baidu_province`,`baidu_city`,`baidu_district`,`baidu_street`) values (5,1,0,'店铺名称','上海','上海市复兴东路河南南路','','',1510626310,121.496,31.2273,'上海市','上海市','黄浦区','复兴东路');

/*Table structure for table `feiwa_store_msg` */

DROP TABLE IF EXISTS `feiwa_store_msg`;

CREATE TABLE `feiwa_store_msg` (
  `sm_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '店铺消息id',
  `smt_code` varchar(100) NOT NULL DEFAULT '' COMMENT '模板编码',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺id',
  `sm_content` varchar(255) NOT NULL DEFAULT '' COMMENT '消息内容',
  `sm_addtime` int(10) unsigned NOT NULL COMMENT '发送时间',
  `sm_readids` varchar(255) DEFAULT '' COMMENT '已读卖家id',
  PRIMARY KEY (`sm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8 COMMENT='店铺消息表';

/*Data for the table `feiwa_store_msg` */

insert  into `feiwa_store_msg`(`sm_id`,`smt_code`,`store_id`,`sm_content`,`sm_addtime`,`sm_readids`) values (26,'goods_violation',7,'您的商品被违规下架，原因：“df”。SPU：100102。',1510654420,''),(27,'goods_violation',1,'您的商品被违规下架，原因：“”。SPU：100101。',1510728876,''),(28,'goods_violation',1,'您的商品被违规下架，原因：“”。SPU：100100。',1510728883,''),(29,'store_cost',7,'您有一条新的店铺消费记录，金额：20，操作人：fengfeng，备注：购买团购。',1510814165,''),(30,'store_cost',7,'您有一条新的店铺消费记录，金额：40，操作人：fengfeng，备注：购买推荐展位。',1510815143,''),(31,'store_cost',6,'您有一条新的店铺消费记录，金额：20，操作人：zxx2cndns，备注：购买团购。',1510815595,''),(32,'store_cost',6,'您有一条新的店铺消费记录，金额：40，操作人：zxx2cndns，备注：购买推荐展位。',1510815907,''),(33,'store_cost',6,'您有一条新的店铺消费记录，金额：200，操作人：zxx2cndns，备注：购买加价购。',1510884811,''),(34,'store_cost',6,'您有一条新的店铺消费记录，金额：110，操作人：zxx2cndns，备注：购买限时折扣。',1510884827,''),(35,'new_order',6,'您有订单需要处理，订单编号：9000000000000201。',1510890629,''),(36,'store_cost',6,'您有一条新的店铺消费记录，金额：240，操作人：zxx2cndns，备注：购买满即送。',1510908608,''),(37,'goods_violation',6,'您的商品被违规下架，原因：“暂时下架”。SPU：100146。',1513330414,''),(38,'goods_violation',6,'您的商品被违规下架，原因：“暂时下架”。SPU：100146。',1513330424,''),(39,'goods_violation',6,'您的商品被违规下架，原因：“暂时下架一个星期”。SPU：100146。',1513330445,''),(40,'goods_violation',6,'您的商品被违规下架，原因：“暂时下架一个星期”。SPU：100146。',1513330466,''),(41,'goods_violation',6,'您的商品被违规下架，原因：“暂时下架一个星期”。SPU：100146。',1513330487,''),(42,'goods_violation',6,'您的商品被违规下架，原因：“暂时下架一个星期”。SPU：100146。',1513330508,''),(43,'goods_violation',6,'您的商品被违规下架，原因：“暂时下架一个星期”。SPU：100146。',1513330529,''),(44,'goods_violation',6,'您的商品被违规下架，原因：“”。SPU：100152。',1513330589,''),(45,'goods_violation',6,'您的商品被违规下架，原因：“”。SPU：100152。',1513330610,''),(46,'goods_violation',6,'您的商品被违规下架，原因：“123”。SPU：100152。',1513330631,''),(47,'store_cost',8,'您有一条新的店铺消费记录，金额：10，操作人：adminy，备注：购买团购。',1513696038,',8,'),(48,'goods_violation',6,'您的商品被违规下架，原因：“123”。SPU：100161。',1513701178,''),(49,'goods_violation',6,'您的商品被违规下架，原因：“123”。SPU：100161。',1513701199,''),(51,'new_order',6,'您有订单需要处理，订单编号：1000000000000601。',1515550265,''),(52,'new_order',6,'您有订单需要处理，订单编号：1000000000000701。',1515550925,''),(53,'store_cost',8,'您有一条新的店铺消费记录，金额：10，操作人：adminy，备注：购买团购。',1517548678,''),(54,'store_cost',8,'您有一条新的店铺消费记录，金额：10，操作人：adminy，备注：购买团购。',1517548700,''),(55,'store_cost',8,'您有一条新的店铺消费记录，金额：10，操作人：adminy，备注：购买团购。',1517548719,''),(56,'goods_violation',8,'您的商品被违规下架，原因：“”。SPU：100171。',1525674095,''),(57,'goods_violation',8,'您的商品被违规下架，原因：“”。SPU：100171。',1525674103,''),(58,'goods_violation',8,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100170。',1525674195,''),(59,'goods_violation',8,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100168。',1525674195,''),(60,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100124。',1525674820,''),(61,'goods_violation',8,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100171。',1525675057,''),(62,'goods_violation',11,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100167。',1525675057,''),(63,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100161。',1525675894,''),(64,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100160。',1525675894,''),(65,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100159。',1525675894,''),(66,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100158。',1525675894,''),(67,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100157。',1525675894,''),(68,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100156。',1525675894,''),(69,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100155。',1525675894,''),(70,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100154。',1525675894,''),(71,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100114。',1525675894,''),(72,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100113。',1525675894,''),(73,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100112。',1525675894,''),(74,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100111。',1525675894,''),(75,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100110。',1525675894,''),(76,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100132。',1525676173,''),(77,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100130。',1525676173,''),(78,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100129。',1525676173,''),(79,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100128。',1525676173,''),(80,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100135。',1525676206,''),(81,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100134。',1525676206,''),(82,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100133。',1525676206,''),(83,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100131。',1525676206,''),(84,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100152。',1525677117,''),(85,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100151。',1525677117,''),(86,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100150。',1525677117,''),(87,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100149。',1525677117,''),(88,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100148。',1525677117,''),(89,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100147。',1525677117,''),(90,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100146。',1525677117,''),(91,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100145。',1525677117,''),(92,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100144。',1525677117,''),(93,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100143。',1525677117,''),(94,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100142。',1525677117,''),(95,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100141。',1525677117,''),(96,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100140。',1525677117,''),(97,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100139。',1525677117,''),(98,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100138。',1525677117,''),(99,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100137。',1525677117,''),(100,'goods_violation',6,'您的商品被违规下架，原因：“商品分类被删除，需要重新选择分类”。SPU：100136。',1525677117,''),(101,'new_order',6,'您有订单需要处理，订单编号：1000000000001001。',1525748438,''),(102,'new_order',6,'您有订单需要处理，订单编号：1000000000001101。',1525748472,''),(103,'store_cost',8,'您有一条新的店铺消费记录，金额：20，操作人：adminy，备注：购买加价购。',1536115056,''),(104,'store_cost',8,'您有一条新的店铺消费记录，金额：900，操作人：adminy，备注：购买团购。',1536134349,'');

/*Table structure for table `feiwa_store_msg_read` */

DROP TABLE IF EXISTS `feiwa_store_msg_read`;

CREATE TABLE `feiwa_store_msg_read` (
  `sm_id` int(11) NOT NULL COMMENT '店铺消息id',
  `seller_id` int(11) NOT NULL COMMENT '卖家id',
  `read_time` int(11) NOT NULL COMMENT '阅读时间',
  PRIMARY KEY (`sm_id`,`seller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺消息阅读表';

/*Data for the table `feiwa_store_msg_read` */

insert  into `feiwa_store_msg_read`(`sm_id`,`seller_id`,`read_time`) values (47,8,1515562270);

/*Table structure for table `feiwa_store_msg_setting` */

DROP TABLE IF EXISTS `feiwa_store_msg_setting`;

CREATE TABLE `feiwa_store_msg_setting` (
  `smt_code` varchar(100) NOT NULL DEFAULT '' COMMENT '模板编码',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺id',
  `sms_message_switch` tinyint(3) unsigned NOT NULL COMMENT '站内信接收开关，0关闭，1开启',
  `sms_short_switch` tinyint(3) unsigned NOT NULL COMMENT '短消息接收开关，0关闭，1开启',
  `sms_mail_switch` tinyint(3) unsigned NOT NULL COMMENT '邮件接收开关，0关闭，1开启',
  `sms_short_number` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sms_mail_number` varchar(100) DEFAULT '' COMMENT '邮箱号码',
  PRIMARY KEY (`smt_code`,`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺消息接收设置';

/*Data for the table `feiwa_store_msg_setting` */

insert  into `feiwa_store_msg_setting`(`smt_code`,`store_id`,`sms_message_switch`,`sms_short_switch`,`sms_mail_switch`,`sms_short_number`,`sms_mail_number`) values ('complain',8,1,0,0,'','');

/*Table structure for table `feiwa_store_msg_tpl` */

DROP TABLE IF EXISTS `feiwa_store_msg_tpl`;

CREATE TABLE `feiwa_store_msg_tpl` (
  `smt_code` varchar(100) NOT NULL DEFAULT '' COMMENT '模板编码',
  `smt_name` varchar(100) NOT NULL DEFAULT '' COMMENT '模板名称',
  `smt_message_switch` tinyint(3) unsigned NOT NULL COMMENT '站内信默认开关，0关，1开',
  `smt_message_content` varchar(255) NOT NULL DEFAULT '' COMMENT '站内信内容',
  `smt_message_forced` tinyint(3) unsigned NOT NULL COMMENT '站内信强制接收，0否，1是',
  `smt_short_switch` tinyint(3) unsigned NOT NULL COMMENT '短信默认开关，0关，1开',
  `smt_short_content` varchar(255) NOT NULL DEFAULT '' COMMENT '短信内容',
  `smt_short_forced` tinyint(3) unsigned NOT NULL COMMENT '短信强制接收，0否，1是',
  `smt_mail_switch` tinyint(3) unsigned NOT NULL COMMENT '邮件默认开，0关，1开',
  `smt_mail_subject` varchar(255) NOT NULL DEFAULT '' COMMENT '邮件标题',
  `smt_mail_content` text NOT NULL COMMENT '邮件内容',
  `smt_mail_forced` tinyint(3) unsigned NOT NULL COMMENT '邮件强制接收，0否，1是',
  PRIMARY KEY (`smt_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家消息模板';

/*Data for the table `feiwa_store_msg_tpl` */

insert  into `feiwa_store_msg_tpl`(`smt_code`,`smt_name`,`smt_message_switch`,`smt_message_content`,`smt_message_forced`,`smt_short_switch`,`smt_short_content`,`smt_short_forced`,`smt_mail_switch`,`smt_mail_subject`,`smt_mail_content`,`smt_mail_forced`) values ('complain','商品被投诉提醒',1,'您售出的商品被投诉，等待商家申诉。投诉单编号：{$complain_id}。',1,0,'【{$site_name}】您售出的商品被投诉，等待商家申诉。投诉单编号：{$complain_id}。',0,0,'{$site_name}提醒：您售出的商品被投诉，等待商家申诉。投诉单编号：{$complain_id}。','<p>\r\n  {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您售出的商品被投诉，等待商家申诉。投诉单编号：{$complain_id}。\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>\r\n<p>\r\n    <br />\r\n</p>',0),('goods_storage_alarm','商品库存预警',1,'您的商品库存不足，请及时补货。SPU：{$common_id}，SKU：{$sku_id}。',1,0,'【{$site_name}】您的商品库存不足，请及时补货。SPU：{$common_id}，SKU：{$sku_id}。',0,0,'{$site_name}提醒：您的商品库存不足，请及时补货。','<p>\r\n {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您的商品库存不足，请及时补货。SPU：{$common_id}，SKU：{$sku_id}。\r\n</p>\r\n<p>\r\n  点击下面链接查看商品详细信息\r\n</p>\r\n<p>\r\n   <a href=\"http://{$shop_site_url}/index.php?act=goods&amp;op=index&amp;goods_id={$sku_id}\" target=\"_blank\">http://{$shop_site_url}/index.php?act=goods&amp;op=index&amp;goods_id={$sku_id}</a> \r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>\r\n<p>\r\n    <br />\r\n</p>\r\n<br />',0),('goods_verify','商品审核失败提醒',1,'您的商品没有通过管理员审核，原因：“{$remark}”。SPU：{$common_id}。',1,0,'【{$site_name}】您的商品没有通过管理员审核，原因：“{$remark}”。SPU：{$common_id}。',0,0,'{$site_name}提醒：您的商品没有通过管理员审核。','<p>\r\n   {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您的商品没有通过管理员审核，原因：“{$remark}”。SPU：{$common_id}。\r\n </p><p>\r\n     <br />\r\n  </p>\r\n    <p>\r\n     <br />\r\n  </p>\r\n    <p style=\"text-align:right;\">\r\n       {$site_name}\r\n    </p>\r\n    <p style=\"text-align:right;\">\r\n       {$mail_send_time}\r\n   </p>',0),('goods_violation','商品违规被下架',1,'您的商品被违规下架，原因：“{$remark}”。SPU：{$common_id}。',1,0,'【{$site_name}】您的商品被违规下架，原因：“{$remark}”。SPU：{$common_id}。',0,0,'{$site_name}提醒：您的商品被违规下架。','<p>\r\n {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您的商品被违规下架。，原因：“{$remark}”。SPU：{$common_id}。\r\n</p>\r\n<p>\r\n <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>\r\n<p>\r\n    <br />\r\n</p>',0),('new_order','新订单提醒',1,'您有订单需要处理，订单编号：{$order_sn}。',1,0,'【{$site_name}】您有订单需要处理，订单编号：{$order_sn}。',0,0,'{$site_name}提醒：您有订单需要处理。','<p>\r\n    {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您有订单需要处理，订单编号：{$order_sn}。\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>\r\n<br />',0),('refund','退款提醒',1,'您有一个{$type}退款单需要处理，退款编号：{$refund_sn}。',1,0,'【{$site_name}】您有一个{$type}退款单需要处理，退款编号：{$refund_sn}。',1,0,'{$site_name}提醒：您有一个{$type}退款单需要处理，退款编号：{$refund_sn}。','<p>\r\n  {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您有一个{$type}退款单需要处理，退款编号：{$refund_sn}。\r\n</p>\r\n<p>\r\n    <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>\r\n<p>\r\n    <br />\r\n</p>',1),('refund_auto_process','退款自动处理提醒',1,'您的{$type}退款单超期未处理，已自动同意买家退款申请。退款单编号：{$refund_sn}。',1,0,'【{$site_name}】您的{$type}退款单超期未处理，已自动同意买家退款申请。退款单编号：{$refund_sn}。',0,0,'{site_name}提醒：您的{$type}退款单超期未处理，已自动同意买家退款申请。退款单编号：{$refund_sn}。','<p>\r\n  {site_name}提醒：\r\n</p>\r\n<p>\r\n   您的{$type}退款单超期未处理，已自动同意买家退款申请。退款单编号：{$refund_sn}。\r\n</p>\r\n<p>\r\n    <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>\r\n<p>\r\n    <br />\r\n</p>',0),('return','退货提醒',1,'您有一个{$type}退货单需要处理。退货编号：{$refund_sn}。',1,0,'【{site_name}】您有一个{$type}退货单需要处理。退货编号：{$refund_sn}。',0,0,'{$site_name}提醒：您有一个{$type}退货单需要处理。退货编号：{$refund_sn}。','<p>\r\n   {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您有一个{$type}退货单需要处理。退货编号：{$refund_sn}。\r\n</p>\r\n<p>\r\n    <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>\r\n<p>\r\n    <br />\r\n</p>\r\n<br />',0),('return_auto_process','退货自动处理提醒',1,'您的{$type}退货单超期未处理，已自动同意买家退货申请（弃货）。退货单编号：{$refund_sn}。',1,0,'【{$site_name}】您的{$type}退货单超期未处理，已自动同意买家退货申请（弃货）。退货单编号：{$refund_sn}。',0,0,'{$site_name}提醒：您的{$type}退货单超期未处理，已自动同意买家退货申请（弃货）。退货单编号：{$refund_sn}。','<p>\r\n {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您的{$type}退货单超期未处理，已自动同意买家退货申请（弃货）。退货单编号：{$refund_sn}。\r\n</p>\r\n<p>\r\n    <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>',0),('return_auto_receipt','退货未收货自动处理提醒',1,'您的{$type}退货单不处理收货超期未处理，已自动按弃货处理。退货单编号：{$refund_sn}。',1,0,'【{$site_name}】您的{$type}退货单不处理收货超期未处理，已自动按弃货处理。退货单编号：{$refund_sn}。',0,0,'{$site_name}提醒：您的{$type}退货单超期未处理，已自动同意买家退货申请（弃货）。退货单编号：{$refund_sn}。','<p>\r\n  {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您的{$type}退货单超期未处理，已自动同意买家退货申请（弃货）。退货单编号：{$refund_sn}。\r\n</p>\r\n<p>\r\n    <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>\r\n<p>\r\n    <br />\r\n</p>',0),('store_bill_affirm','结算单等待确认提醒',1,'您有新的结算单等待确认，开始时间：{$state_time}，结束时间：{$end_time}，结算单号：{$bill_no}。',1,0,'【{$site_name}】您有新的结算单等待确认，开始时间：{$state_time}，结束时间：{$end_time}，结算单号：{$bill_no}。',0,0,'{$site_name}提醒：您有新的结算单等待确认。','<p>\r\n {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您有新的结算单等待确认，起止时间：开始时间：{$state_time}，结束时间：{$end_time}，结算单号：{$bill_no}。\r\n</p>\r\n<p>\r\n    <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>\r\n<p>\r\n    <br />\r\n</p>',0),('store_bill_gathering','结算单已经付款提醒',1,'您的结算单平台已付款，请注意查收，结算单编号：{$bill_no}。',1,0,'【{$site_name}】您的结算单平台已付款，请注意查收，结算单编号：{$bill_no}。',0,0,'{$site_name}提醒：您的结算单平台已付款，请注意查收。','<p>\r\n </p><p>\r\n     {$site_name}提醒：\r\n </p>\r\n\r\n<p>\r\n 您的结算单平台已付款，请注意查收，结算单编号：{$bill_no}。\r\n  </p><p>\r\n     <br />\r\n  </p>\r\n    <p>\r\n     <br />\r\n  </p>\r\n    <p>\r\n     <br />\r\n  </p>\r\n    <p style=\"text-align:right;\">\r\n       {$site_name}\r\n    </p>\r\n    <p style=\"text-align:right;\">\r\n       {$mail_send_time}\r\n   </p>\r\n\r\n<br />',0),('store_cost','店铺消费提醒',1,'您有一条新的店铺消费记录，金额：{$price}，操作人：{$seller_name}，备注：{$remark}。',1,0,'【{$site_name}】您有一条新的店铺消费记录，金额：{$price}，操作人：{$seller_name}，备注：{$remark}。',0,0,'{$site_name}提醒：您有一条新的店铺消费记录。','<p>\r\n    {$site_name}提醒：\r\n</p>\r\n<p>\r\n  您有一条新的店铺消费记录，金额：{$price}，操作人：{$seller_name}，备注：{$remark}。\r\n</p>\r\n<p>\r\n    <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>',0),('store_expire','店铺到期提醒',1,'你的店铺即将到期，请及时续期。',1,0,'【{$site_name}】你的店铺即将到期，请及时续期。',0,0,'{$site_name}提醒：你的店铺即将到期，请及时续期。','<p>\r\n    {$site_name}提醒：\r\n</p>\r\n<p>\r\n  你的店铺即将到期，请及时续期。\r\n</p>\r\n<p>\r\n  <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style=\"text-align:right;\">\r\n {$site_name}\r\n</p>\r\n<p style=\"text-align:right;\">\r\n   {$mail_send_time}\r\n</p>\r\n<p>\r\n    <br />\r\n</p>',0);

/*Table structure for table `feiwa_store_navigation` */

DROP TABLE IF EXISTS `feiwa_store_navigation`;

CREATE TABLE `feiwa_store_navigation` (
  `sn_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '导航ID',
  `sn_title` varchar(50) NOT NULL DEFAULT '' COMMENT '导航名称',
  `sn_store_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '卖家店铺ID',
  `sn_content` text COMMENT '导航内容',
  `sn_sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `sn_if_show` tinyint(1) NOT NULL DEFAULT '0' COMMENT '导航是否显示',
  `sn_add_time` int(10) NOT NULL COMMENT '导航',
  `sn_url` varchar(255) DEFAULT NULL COMMENT '店铺导航的外链URL',
  `sn_new_open` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '店铺导航外链是否在新窗口打开：0不开新窗口1开新窗口，默认是0',
  PRIMARY KEY (`sn_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='卖家店铺导航信息表';

/*Data for the table `feiwa_store_navigation` */

insert  into `feiwa_store_navigation`(`sn_id`,`sn_title`,`sn_store_id`,`sn_content`,`sn_sort`,`sn_if_show`,`sn_add_time`,`sn_url`,`sn_new_open`) values (3,'商品',8,'',255,1,1515567435,'',1),(4,'口碑',8,'',255,1,1515567445,'',1),(5,'商家入驻',8,'',255,1,1522745404,'',1),(6,'导航1',8,'',255,1,1522745421,'',1),(7,'导航2',8,'',255,1,1522745430,'',1);

/*Table structure for table `feiwa_store_plate` */

DROP TABLE IF EXISTS `feiwa_store_plate`;

CREATE TABLE `feiwa_store_plate` (
  `plate_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '关联板式id',
  `plate_name` varchar(10) NOT NULL DEFAULT '' COMMENT '关联板式名称',
  `plate_position` tinyint(3) unsigned NOT NULL COMMENT '关联板式位置 1顶部，0底部',
  `plate_content` text NOT NULL COMMENT '关联板式内容',
  `store_id` int(10) unsigned NOT NULL COMMENT '所属店铺id',
  PRIMARY KEY (`plate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='关联板式表';

/*Data for the table `feiwa_store_plate` */

/*Table structure for table `feiwa_store_reopen` */

DROP TABLE IF EXISTS `feiwa_store_reopen`;

CREATE TABLE `feiwa_store_reopen` (
  `re_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `re_grade_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '店铺等级ID',
  `re_grade_name` varchar(30) DEFAULT NULL COMMENT '等级名称',
  `re_grade_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '等级收费(元/年)',
  `re_year` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '续签时长(年)',
  `re_pay_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '应付总金额',
  `re_store_name` varchar(50) DEFAULT NULL COMMENT '店铺名字',
  `re_store_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `re_state` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态0默认，未上传凭证1审核中2审核通过',
  `re_start_time` int(10) unsigned DEFAULT NULL COMMENT '有效期开始时间',
  `re_end_time` int(10) unsigned DEFAULT NULL COMMENT '有效期结束时间',
  `re_create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '记录创建时间',
  `re_pay_cert` varchar(50) DEFAULT NULL COMMENT '付款凭证',
  `re_pay_cert_explain` varchar(200) DEFAULT NULL COMMENT '付款凭证说明',
  PRIMARY KEY (`re_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='续签内容表';

/*Data for the table `feiwa_store_reopen` */

/*Table structure for table `feiwa_store_sns_comment` */

DROP TABLE IF EXISTS `feiwa_store_sns_comment`;

CREATE TABLE `feiwa_store_sns_comment` (
  `scomm_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '店铺动态评论id',
  `strace_id` int(11) NOT NULL COMMENT '店铺动态id',
  `scomm_content` varchar(150) DEFAULT NULL COMMENT '评论内容',
  `scomm_memberid` int(11) DEFAULT NULL COMMENT '会员id',
  `scomm_membername` varchar(45) DEFAULT NULL COMMENT '会员名称',
  `scomm_memberavatar` varchar(50) DEFAULT NULL COMMENT '会员头像',
  `scomm_time` varchar(11) DEFAULT NULL COMMENT '评论时间',
  `scomm_state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '评论状态 1正常，0屏蔽',
  PRIMARY KEY (`scomm_id`),
  UNIQUE KEY `scomm_id` (`scomm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺动态评论表';

/*Data for the table `feiwa_store_sns_comment` */

/*Table structure for table `feiwa_store_sns_setting` */

DROP TABLE IF EXISTS `feiwa_store_sns_setting`;

CREATE TABLE `feiwa_store_sns_setting` (
  `sauto_storeid` int(11) NOT NULL COMMENT '店铺id',
  `sauto_new` tinyint(4) NOT NULL DEFAULT '1' COMMENT '新品,0为关闭/1为开启',
  `sauto_newtitle` varchar(150) DEFAULT '' COMMENT '新品内容',
  `sauto_coupon` tinyint(4) NOT NULL DEFAULT '1' COMMENT '优惠券,0为关闭/1为开启',
  `sauto_coupontitle` varchar(150) DEFAULT '' COMMENT '优惠券内容',
  `sauto_xianshi` tinyint(4) NOT NULL DEFAULT '1' COMMENT '限时折扣,0为关闭/1为开启',
  `sauto_xianshititle` varchar(150) DEFAULT '' COMMENT '限时折扣内容',
  `sauto_mansong` tinyint(4) NOT NULL DEFAULT '1' COMMENT '满即送,0为关闭/1为开启',
  `sauto_mansongtitle` varchar(150) DEFAULT '' COMMENT '满即送内容',
  `sauto_bundling` tinyint(4) NOT NULL DEFAULT '1' COMMENT '组合销售,0为关闭/1为开启',
  `sauto_bundlingtitle` varchar(150) DEFAULT '' COMMENT '组合销售内容',
  `sauto_groupbuy` tinyint(4) NOT NULL DEFAULT '1' COMMENT '团购,0为关闭/1为开启',
  `sauto_groupbuytitle` varchar(150) DEFAULT '' COMMENT '团购内容',
  PRIMARY KEY (`sauto_storeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺自动发布动态设置表';

/*Data for the table `feiwa_store_sns_setting` */

/*Table structure for table `feiwa_store_sns_tracelog` */

DROP TABLE IF EXISTS `feiwa_store_sns_tracelog`;

CREATE TABLE `feiwa_store_sns_tracelog` (
  `strace_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '店铺动态id',
  `strace_storeid` int(11) DEFAULT NULL COMMENT '店铺id',
  `strace_storename` varchar(100) DEFAULT NULL COMMENT '店铺名称',
  `strace_storelogo` varchar(255) DEFAULT '' COMMENT '店标',
  `strace_title` varchar(150) DEFAULT NULL COMMENT '动态标题',
  `strace_content` text COMMENT '发表内容',
  `strace_time` varchar(11) DEFAULT NULL COMMENT '发表时间',
  `strace_cool` int(11) DEFAULT '0' COMMENT '赞数量',
  `strace_spread` int(11) DEFAULT '0' COMMENT '转播数量',
  `strace_comment` int(11) DEFAULT '0' COMMENT '评论数量',
  `strace_type` tinyint(4) DEFAULT '1' COMMENT '1=relay,2=normal,3=new,4=coupon,5=xianshi,6=mansong,7=bundling,8=groupbuy,9=recommend,10=hotsell',
  `strace_goodsdata` text COMMENT '商品信息',
  `strace_state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '动态状态 1正常，0屏蔽',
  PRIMARY KEY (`strace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='店铺动态表';

/*Data for the table `feiwa_store_sns_tracelog` */

insert  into `feiwa_store_sns_tracelog`(`strace_id`,`strace_storeid`,`strace_storename`,`strace_storelogo`,`strace_title`,`strace_content`,`strace_time`,`strace_cool`,`strace_spread`,`strace_comment`,`strace_type`,`strace_goodsdata`,`strace_state`) values (1,8,'adminy','','了山东黄金；我今晚破二姐夫请问平均分；偶就发票','<div class=\"fd-media\">\r\n                                    <div class=\"thumb-image\"><a href=\"javascript:void(0);\" feiwa_type=\"thumb-image\"><img src=\"http://865284.ichengyun.net/data/upload/mall/store/goods/8/8_05675349300770679_240.jpg\" /><i></i></a></div>\r\n                                    <div class=\"origin-image\"><a href=\"javascript:void(0);\" feiwa_type=\"origin-image\"></a></div>\r\n                                </div>','1514190942',0,0,0,2,'',1),(2,8,'adminy','','爽肤水','','1514192488',0,0,0,9,'{\"goods_id\":\"100186\",\"goods_commonid\":\"100126\",\"goods_name\":\"\\u6a31\\u82b1\\u4fdd\\u6e7f\\u5ae9\\u80a4\\u6c34500ml\",\"goods_jingle\":\"\\u6a31\\u82b1\\u7cbe\\u534e \\u6c34\\u6da6\\u6ecb\\u6da6 \\u8865\\u6c34\\u4fdd\\u6e7f\\u5316\\u5986\\u6c34\\u723d\\u80a4\\u6c34\",\"store_id\":\"6\",\"store_name\":\"\\u5546\\u57ce\",\"gc_id\":\"479\",\"gc_id_1\":\"470\",\"gc_id_2\":\"471\",\"gc_id_3\":\"479\",\"brand_id\":\"0\",\"goods_price\":\"89.00\",\"goods_promotion_price\":\"89.00\",\"goods_promotion_type\":\"0\",\"goods_marketprice\":\"100.00\",\"goods_serial\":\"\",\"goods_storage_alarm\":\"0\",\"goods_barcode\":\"\",\"goods_click\":\"7\",\"goods_salenum\":\"2\",\"goods_collect\":\"0\",\"spec_name\":\"N;\",\"goods_spec\":\"N;\",\"goods_storage\":\"98\",\"goods_image\":\"6_05640796519363861.jpg\",\"goods_body\":\"\",\"mobile_body\":\"\",\"goods_state\":\"1\",\"goods_verify\":\"1\",\"goods_addtime\":\"1510735654\",\"goods_edittime\":\"1514192442\",\"areaid_1\":\"0\",\"areaid_2\":\"0\",\"color_id\":\"0\",\"transport_id\":\"0\",\"goods_freight\":\"0.00\",\"goods_vat\":\"0\",\"goods_commend\":\"1\",\"goods_stcids\":\"\",\"evaluation_good_star\":\"3\",\"evaluation_count\":\"1\",\"is_virtual\":\"0\",\"virtual_indate\":\"0\",\"virtual_limit\":\"0\",\"virtual_invalid_refund\":\"0\",\"is_fcode\":\"0\",\"is_presell\":\"0\",\"presell_deliverdate\":\"0\",\"is_book\":\"0\",\"book_down_payment\":\"0.00\",\"book_final_payment\":\"0.00\",\"book_down_time\":\"0\",\"book_buyers\":\"0\",\"have_gift\":\"0\",\"is_own_mall\":\"0\",\"contract_1\":\"0\",\"contract_2\":\"0\",\"contract_3\":\"0\",\"contract_4\":\"0\",\"contract_5\":\"0\",\"contract_6\":\"0\",\"contract_7\":\"0\",\"contract_8\":\"0\",\"contract_9\":\"0\",\"contract_10\":\"0\",\"is_chain\":\"0\",\"invite_rate\":\"0.00\",\"is_pf\":\"0\",\"is_vip\":\"0\",\"pf_num1\":\"0\",\"pf_num2\":\"0\",\"pf_num3\":\"0\",\"pf_price1\":\"0.00\",\"pf_price2\":\"0.00\",\"pf_price3\":\"0.00\",\"pf_poinst1\":\"0\",\"pf_poinst2\":\"0\",\"pf_poinst3\":\"0\",\"goods_unit\":null,\"ifpf\":\"0\",\"pf\":\"a:6:{s:2:\\\"q1\\\";s:0:\\\"\\\";s:2:\\\"f1\\\";s:0:\\\"\\\";s:2:\\\"q2\\\";s:0:\\\"\\\";s:2:\\\"f2\\\";s:0:\\\"\\\";s:2:\\\"q3\\\";s:0:\\\"\\\";s:2:\\\"f3\\\";s:0:\\\"\\\";}\"}',1),(3,8,'adminy','05689105940914312_sm.jpg','动态新鲜事','<div class=\"fd-media\">\r\n                                    <div class=\"thumb-image\"><a href=\"javascript:void(0);\" feiwa_type=\"thumb-image\"><img src=\"http://865284.ichengyun.net/data/upload/mall/store/goods/8/8_05760892357437364_240.jpg\" /><i></i></a></div>\r\n                                    <div class=\"origin-image\"><a href=\"javascript:void(0);\" feiwa_type=\"origin-image\"></a></div>\r\n                                </div>','1522745254',0,0,0,2,'',1),(4,8,'adminy','05689105940914312_sm.jpg','热销商品','','1522745348',0,0,0,10,'{\"goods_id\":\"100223\",\"store_id\":\"8\",\"goods_name\":\"asdsad\",\"goods_image\":\"8_05671682277834917.jpg\",\"goods_price\":\"100.00\",\"goods_freight\":\"0.00\"}',1),(5,8,'adminy','05689105940914312_sm.jpg','热销商品','','1522745348',0,0,0,10,'{\"goods_id\":\"100224\",\"store_id\":\"8\",\"goods_name\":\"\\u5c0f\\u7c73note\",\"goods_image\":\"8_05675387995058942.jpg\",\"goods_price\":\"2090.00\",\"goods_freight\":\"20.00\"}',1),(6,8,'adminy','05689105940914312_sm.jpg','最新商品','','1522745367',0,0,0,3,'{\"goods_id\":\"100226\",\"store_id\":\"8\",\"goods_name\":\"\\u6d4b\\u8bd5\\u6dfb\\u52a0\\u5546\\u54c1\",\"goods_image\":\"8_05690878192014201.jpg\",\"goods_price\":\"1980.00\",\"goods_freight\":\"0.00\"}',1);

/*Table structure for table `feiwa_store_supplier` */

DROP TABLE IF EXISTS `feiwa_store_supplier`;

CREATE TABLE `feiwa_store_supplier` (
  `sup_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sup_store_id` int(11) DEFAULT NULL COMMENT '商家ID',
  `sup_store_name` varchar(50) DEFAULT NULL COMMENT '商家名称',
  `sup_name` varchar(50) DEFAULT NULL COMMENT '供货商名称',
  `sup_desc` varchar(200) DEFAULT NULL COMMENT '备注',
  `sup_man` varchar(30) DEFAULT NULL COMMENT '联系人',
  `sup_phone` varchar(30) DEFAULT NULL COMMENT '联系电话',
  PRIMARY KEY (`sup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='供货商表';

/*Data for the table `feiwa_store_supplier` */

insert  into `feiwa_store_supplier`(`sup_id`,`sup_store_id`,`sup_store_name`,`sup_name`,`sup_desc`,`sup_man`,`sup_phone`) values (1,8,'adminy','中国移动','','','');

/*Table structure for table `feiwa_store_vip_item` */

DROP TABLE IF EXISTS `feiwa_store_vip_item`;

CREATE TABLE `feiwa_store_vip_item` (
  `svip_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `svip_name` varchar(100) NOT NULL DEFAULT '' COMMENT '店铺会员等级名称',
  PRIMARY KEY (`svip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消费者保障服务项目表';

/*Data for the table `feiwa_store_vip_item` */

/*Table structure for table `feiwa_store_vip_list` */

DROP TABLE IF EXISTS `feiwa_store_vip_list`;

CREATE TABLE `feiwa_store_vip_list` (
  `ls_svipid` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `svip_id` varchar(100) NOT NULL DEFAULT '' COMMENT '店铺会员等级id',
  `store_id` int(11) DEFAULT NULL COMMENT '店铺ID',
  `order_price` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `order_num` int(11) DEFAULT NULL COMMENT '订单数量',
  `order_c` tinyint(4) DEFAULT NULL COMMENT '折扣',
  `is_state` int(11) DEFAULT NULL COMMENT '是否启用',
  PRIMARY KEY (`ls_svipid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消费者保障服务项目表';

/*Data for the table `feiwa_store_vip_list` */

/*Table structure for table `feiwa_store_vip_member` */

DROP TABLE IF EXISTS `feiwa_store_vip_member`;

CREATE TABLE `feiwa_store_vip_member` (
  `vip_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '类型id',
  `store_id` int(10) NOT NULL COMMENT '类型名称',
  `member_id` int(10) NOT NULL COMMENT '会员ID',
  `member_commit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员折扣',
  `member_name` varchar(100) DEFAULT '' COMMENT '会员名称',
  `member_vipcard` varchar(100) DEFAULT '青铜会员' COMMENT '会员等级名称',
  `vip_state` int(3) NOT NULL,
  PRIMARY KEY (`vip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品类型表';

/*Data for the table `feiwa_store_vip_member` */

/*Table structure for table `feiwa_store_watermark` */

DROP TABLE IF EXISTS `feiwa_store_watermark`;

CREATE TABLE `feiwa_store_watermark` (
  `wm_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '水印id',
  `jpeg_quality` int(3) NOT NULL DEFAULT '90' COMMENT 'jpeg图片质量',
  `wm_image_name` varchar(255) DEFAULT NULL COMMENT '水印图片的路径以及文件名',
  `wm_image_pos` tinyint(1) NOT NULL DEFAULT '1' COMMENT '水印图片放置的位置',
  `wm_image_transition` int(3) NOT NULL DEFAULT '20' COMMENT '水印图片与原图片的融合度 ',
  `wm_text` text COMMENT '水印文字',
  `wm_text_size` int(3) NOT NULL DEFAULT '20' COMMENT '水印文字大小',
  `wm_text_angle` tinyint(1) NOT NULL DEFAULT '4' COMMENT '水印文字角度',
  `wm_text_pos` tinyint(1) NOT NULL DEFAULT '3' COMMENT '水印文字放置位置',
  `wm_text_font` varchar(50) DEFAULT NULL COMMENT '水印文字的字体',
  `wm_text_color` varchar(7) NOT NULL DEFAULT '#CCCCCC' COMMENT '水印字体的颜色值',
  `wm_is_open` tinyint(1) NOT NULL DEFAULT '0' COMMENT '水印是否开启 0关闭 1开启',
  `store_id` int(11) DEFAULT NULL COMMENT '店铺id',
  PRIMARY KEY (`wm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='店铺水印图片表';

/*Data for the table `feiwa_store_watermark` */

insert  into `feiwa_store_watermark`(`wm_id`,`jpeg_quality`,`wm_image_name`,`wm_image_pos`,`wm_image_transition`,`wm_text`,`wm_text_size`,`wm_text_angle`,`wm_text_pos`,`wm_text_font`,`wm_text_color`,`wm_is_open`,`store_id`) values (1,90,NULL,1,20,NULL,20,4,3,'default','#CCCCCC',0,8),(2,90,NULL,1,20,NULL,20,4,3,'default','#CCCCCC',0,6);

/*Table structure for table `feiwa_store_waybill` */

DROP TABLE IF EXISTS `feiwa_store_waybill`;

CREATE TABLE `feiwa_store_waybill` (
  `store_waybill_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '店铺运单模板编号',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺编号',
  `express_id` int(10) unsigned NOT NULL COMMENT '物流公司编号',
  `waybill_id` int(10) unsigned NOT NULL COMMENT '运单模板编号',
  `waybill_name` varchar(50) NOT NULL DEFAULT '' COMMENT '运单模板名称',
  `store_waybill_data` varchar(2000) DEFAULT NULL COMMENT '店铺自定义设置',
  `is_default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否默认模板',
  `store_waybill_left` int(11) NOT NULL DEFAULT '0' COMMENT '店铺运单左偏移',
  `store_waybill_top` int(11) NOT NULL DEFAULT '0' COMMENT '店铺运单上偏移',
  PRIMARY KEY (`store_waybill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='店铺运单模板表';

/*Data for the table `feiwa_store_waybill` */

insert  into `feiwa_store_waybill`(`store_waybill_id`,`store_id`,`express_id`,`waybill_id`,`waybill_name`,`store_waybill_data`,`is_default`,`store_waybill_left`,`store_waybill_top`) values (1,8,29,3,'顺风','a:10:{s:10:\"buyer_name\";a:2:{s:9:\"item_text\";s:9:\"收货人\";s:4:\"show\";b:1;}s:10:\"buyer_area\";a:2:{s:9:\"item_text\";s:15:\"收货人地区\";s:4:\"show\";b:1;}s:13:\"buyer_address\";a:2:{s:9:\"item_text\";s:15:\"收货人地址\";s:4:\"show\";b:1;}s:12:\"buyer_mobile\";a:2:{s:9:\"item_text\";s:15:\"收货人手机\";s:4:\"show\";b:1;}s:11:\"buyer_phone\";a:2:{s:9:\"item_text\";s:15:\"收货人电话\";s:4:\"show\";b:1;}s:11:\"seller_name\";a:2:{s:9:\"item_text\";s:9:\"发货人\";s:4:\"show\";b:1;}s:11:\"seller_area\";a:2:{s:9:\"item_text\";s:15:\"发货人地区\";s:4:\"show\";b:1;}s:14:\"seller_address\";a:2:{s:9:\"item_text\";s:15:\"发货人地址\";s:4:\"show\";b:1;}s:12:\"seller_phone\";a:2:{s:9:\"item_text\";s:15:\"发货人电话\";s:4:\"show\";b:1;}s:14:\"seller_company\";a:2:{s:9:\"item_text\";s:15:\"发货人公司\";s:4:\"show\";b:1;}}',0,-5,-4);

/*Table structure for table `feiwa_transport` */

DROP TABLE IF EXISTS `feiwa_transport`;

CREATE TABLE `feiwa_transport` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '运费模板ID',
  `title` varchar(30) NOT NULL DEFAULT '' COMMENT '运费模板名称',
  `send_tpl_id` mediumint(8) unsigned DEFAULT NULL COMMENT '发货地区模板ID',
  `store_id` mediumint(8) unsigned NOT NULL COMMENT '店铺ID',
  `update_time` int(10) unsigned DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='运费模板';

/*Data for the table `feiwa_transport` */

insert  into `feiwa_transport`(`id`,`title`,`send_tpl_id`,`store_id`,`update_time`) values (1,'华中区',1,8,1514194993),(2,'华中区的副本',1,8,1516254383);

/*Table structure for table `feiwa_transport_extend` */

DROP TABLE IF EXISTS `feiwa_transport_extend`;

CREATE TABLE `feiwa_transport_extend` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '运费模板扩展ID',
  `area_id` text COMMENT '市级地区ID组成的串，以，隔开，两端也有，',
  `top_area_id` text COMMENT '省级地区ID组成的串，以，隔开，两端也有，',
  `area_name` text COMMENT '地区name组成的串，以，隔开',
  `sprice` decimal(10,2) DEFAULT '0.00' COMMENT '首件运费',
  `transport_id` mediumint(8) unsigned NOT NULL COMMENT '运费模板ID',
  `transport_title` varchar(60) DEFAULT NULL COMMENT '运费模板',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='运费模板扩展表';

/*Data for the table `feiwa_transport_extend` */

insert  into `feiwa_transport_extend`(`id`,`area_id`,`top_area_id`,`area_name`,`sprice`,`transport_id`,`transport_title`) values (1,',16,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,17,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,18,275,276,277,278,279,280,281,282,283,284,285,286,287,288,',',16,17,18,','河南,湖北,湖南','20.00',1,'华中区'),(2,',13,203,204,205,206,207,208,209,210,211,19,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,20,310,311,312,313,314,315,316,317,318,319,320,321,322,323,21,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,',',13,19,20,21,','福建,广东,广西,海南','10.00',1,'华中区'),(3,',16,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,17,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,18,275,276,277,278,279,280,281,282,283,284,285,286,287,288,',',16,17,18,','河南,湖北,湖南','20.00',2,'华中区'),(4,',13,203,204,205,206,207,208,209,210,211,19,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,20,310,311,312,313,314,315,316,317,318,319,320,321,322,323,21,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,',',13,19,20,21,','福建,广东,广西,海南','10.00',2,'华中区');

/*Table structure for table `feiwa_type` */

DROP TABLE IF EXISTS `feiwa_type`;

CREATE TABLE `feiwa_type` (
  `type_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '类型id',
  `type_name` varchar(100) NOT NULL DEFAULT '' COMMENT '类型名称',
  `type_sort` tinyint(1) unsigned NOT NULL COMMENT '排序',
  `class_id` int(10) unsigned DEFAULT '0' COMMENT '所属分类id',
  `class_name` varchar(100) DEFAULT '' COMMENT '所属分类名称',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='商品类型表';

/*Data for the table `feiwa_type` */

insert  into `feiwa_type`(`type_id`,`type_name`,`type_sort`,`class_id`,`class_name`) values (1,'衣服',0,12,'T恤'),(3,'奶粉',0,470,'奶粉');

/*Table structure for table `feiwa_type_brand` */

DROP TABLE IF EXISTS `feiwa_type_brand`;

CREATE TABLE `feiwa_type_brand` (
  `type_id` int(10) unsigned NOT NULL COMMENT '类型id',
  `brand_id` int(10) unsigned NOT NULL COMMENT '品牌id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品类型与品牌对应表';

/*Data for the table `feiwa_type_brand` */

insert  into `feiwa_type_brand`(`type_id`,`brand_id`) values (1,342),(1,94),(1,98),(1,90),(3,366),(3,365);

/*Table structure for table `feiwa_type_custom` */

DROP TABLE IF EXISTS `feiwa_type_custom`;

CREATE TABLE `feiwa_type_custom` (
  `custom_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自定义属性id',
  `custom_name` varchar(50) NOT NULL DEFAULT '' COMMENT '自定义属性名称',
  `type_id` int(10) unsigned NOT NULL COMMENT '类型id',
  PRIMARY KEY (`custom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自定义属性表';

/*Data for the table `feiwa_type_custom` */

/*Table structure for table `feiwa_type_spec` */

DROP TABLE IF EXISTS `feiwa_type_spec`;

CREATE TABLE `feiwa_type_spec` (
  `type_id` int(10) unsigned NOT NULL COMMENT '类型id',
  `sp_id` int(10) unsigned NOT NULL COMMENT '规格id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品类型与规格对应表';

/*Data for the table `feiwa_type_spec` */

insert  into `feiwa_type_spec`(`type_id`,`sp_id`) values (3,2);

/*Table structure for table `feiwa_upload` */

DROP TABLE IF EXISTS `feiwa_upload`;

CREATE TABLE `feiwa_upload` (
  `upload_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引ID',
  `file_name` varchar(100) DEFAULT NULL COMMENT '文件名',
  `file_thumb` varchar(100) DEFAULT NULL COMMENT '缩微图片',
  `file_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `upload_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '文件类别，0为无，1为文章图片，默认为0，2为帮助内容图片，3为店铺幻灯片，4为系统文章图片，5为积分礼品切换图片，6为积分礼品内容图片',
  `upload_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `item_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '信息ID',
  PRIMARY KEY (`upload_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='上传文件表';

/*Data for the table `feiwa_upload` */

insert  into `feiwa_upload`(`upload_id`,`file_name`,`file_thumb`,`file_size`,`upload_type`,`upload_time`,`item_id`) values (1,'help_store_05675372236571413.jpg',NULL,219207,2,1514193223,101),(2,'05688921798700631.jpg',NULL,49557,1,1515548179,43),(3,'05792028485247398.jpg','05792028485247398_small.jpg',509277,5,1525858849,1);

/*Table structure for table `feiwa_voucher` */

DROP TABLE IF EXISTS `feiwa_voucher`;

CREATE TABLE `feiwa_voucher` (
  `voucher_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '代金券编号',
  `voucher_code` varchar(32) NOT NULL DEFAULT '' COMMENT '代金券编码',
  `voucher_t_id` int(11) NOT NULL COMMENT '代金券模版编号',
  `voucher_title` varchar(50) NOT NULL DEFAULT '' COMMENT '代金券标题',
  `voucher_desc` varchar(255) NOT NULL DEFAULT '' COMMENT '代金券描述',
  `voucher_start_date` int(11) NOT NULL COMMENT '代金券有效期开始时间',
  `voucher_end_date` int(11) NOT NULL COMMENT '代金券有效期结束时间',
  `voucher_price` int(11) NOT NULL COMMENT '代金券面额',
  `voucher_limit` decimal(10,2) NOT NULL COMMENT '代金券使用时的订单限额',
  `voucher_store_id` int(11) NOT NULL COMMENT '代金券的店铺id',
  `voucher_state` tinyint(4) NOT NULL COMMENT '代金券状态(1-未用,2-已用,3-过期,4-收回)',
  `voucher_active_date` int(11) NOT NULL COMMENT '代金券发放日期',
  `voucher_type` tinyint(4) DEFAULT '0' COMMENT '代金券类别',
  `voucher_owner_id` int(11) NOT NULL COMMENT '代金券所有者id',
  `voucher_owner_name` varchar(50) NOT NULL DEFAULT '' COMMENT '代金券所有者名称',
  `voucher_order_id` int(11) DEFAULT NULL COMMENT '使用该代金券的订单编号',
  `voucher_pwd` varchar(100) DEFAULT NULL COMMENT '代金券卡密不可逆',
  `voucher_pwd2` varchar(100) DEFAULT NULL COMMENT '代金券卡密2可逆',
  PRIMARY KEY (`voucher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代金券表';

/*Data for the table `feiwa_voucher` */

/*Table structure for table `feiwa_voucher_price` */

DROP TABLE IF EXISTS `feiwa_voucher_price`;

CREATE TABLE `feiwa_voucher_price` (
  `voucher_price_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '代金券面值编号',
  `voucher_price_describe` varchar(255) NOT NULL DEFAULT '' COMMENT '代金券描述',
  `voucher_price` int(11) NOT NULL COMMENT '代金券面值',
  `voucher_defaultpoints` int(11) NOT NULL DEFAULT '0' COMMENT '代金劵默认的兑换所需积分可以为0',
  PRIMARY KEY (`voucher_price_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='代金券面额表';

/*Data for the table `feiwa_voucher_price` */

insert  into `feiwa_voucher_price`(`voucher_price_id`,`voucher_price_describe`,`voucher_price`,`voucher_defaultpoints`) values (4,'满百减十',10,50);

/*Table structure for table `feiwa_voucher_quota` */

DROP TABLE IF EXISTS `feiwa_voucher_quota`;

CREATE TABLE `feiwa_voucher_quota` (
  `quota_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '套餐编号',
  `quota_memberid` int(11) NOT NULL COMMENT '会员编号',
  `quota_membername` varchar(100) NOT NULL DEFAULT '' COMMENT '会员名称',
  `quota_storeid` int(11) NOT NULL COMMENT '店铺编号',
  `quota_storename` varchar(100) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `quota_starttime` int(11) NOT NULL COMMENT '开始时间',
  `quota_endtime` int(11) NOT NULL COMMENT '结束时间',
  `quota_state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态(1-可用/2-取消/3-结束)',
  PRIMARY KEY (`quota_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='代金券套餐表';

/*Data for the table `feiwa_voucher_quota` */

insert  into `feiwa_voucher_quota`(`quota_id`,`quota_memberid`,`quota_membername`,`quota_storeid`,`quota_storename`,`quota_starttime`,`quota_endtime`,`quota_state`) values (1,1043,'adminy',8,'adminy',1515047153,1520231153,1);

/*Table structure for table `feiwa_voucher_template` */

DROP TABLE IF EXISTS `feiwa_voucher_template`;

CREATE TABLE `feiwa_voucher_template` (
  `voucher_t_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '代金券模版编号',
  `voucher_t_title` varchar(50) NOT NULL DEFAULT '' COMMENT '代金券模版名称',
  `voucher_t_desc` varchar(255) NOT NULL DEFAULT '' COMMENT '代金券模版描述',
  `voucher_t_start_date` int(11) NOT NULL COMMENT '代金券模版有效期开始时间',
  `voucher_t_end_date` int(11) NOT NULL COMMENT '代金券模版有效期结束时间',
  `voucher_t_price` int(11) NOT NULL COMMENT '代金券模版面额',
  `voucher_t_limit` decimal(10,2) NOT NULL COMMENT '代金券使用时的订单限额',
  `voucher_t_store_id` int(11) NOT NULL COMMENT '代金券模版的店铺id',
  `voucher_t_storename` varchar(100) DEFAULT NULL COMMENT '店铺名称',
  `voucher_t_sc_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属店铺分类ID',
  `voucher_t_creator_id` int(11) NOT NULL COMMENT '代金券模版的创建者id',
  `voucher_t_state` tinyint(4) NOT NULL COMMENT '代金券模版状态(1-有效,2-失效)',
  `voucher_t_total` int(11) NOT NULL COMMENT '模版可发放的代金券总数',
  `voucher_t_giveout` int(11) NOT NULL COMMENT '模版已发放的代金券数量',
  `voucher_t_used` int(11) NOT NULL COMMENT '模版已经使用过的代金券',
  `voucher_t_add_date` int(11) NOT NULL COMMENT '模版的创建时间',
  `voucher_t_quotaid` int(11) NOT NULL COMMENT '套餐编号',
  `voucher_t_points` int(11) NOT NULL DEFAULT '0' COMMENT '兑换所需积分',
  `voucher_t_eachlimit` int(11) NOT NULL DEFAULT '1' COMMENT '每人限领张数',
  `voucher_t_styleimg` varchar(200) DEFAULT NULL COMMENT '样式模版图片',
  `voucher_t_customimg` varchar(200) DEFAULT NULL COMMENT '自定义代金券模板图片',
  `voucher_t_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐 0不推荐 1推荐',
  `voucher_t_gettype` tinyint(1) NOT NULL DEFAULT '1' COMMENT '领取方式 1积分兑换 2卡密兑换 3免费领取',
  `voucher_t_isbuild` tinyint(1) NOT NULL DEFAULT '0' COMMENT '领取方式为卡密兑换是否已经生成下属代金券 0未生成 1已生成',
  `voucher_t_mgradelimit` tinyint(2) NOT NULL DEFAULT '0' COMMENT '领取代金券限制的会员等级',
  PRIMARY KEY (`voucher_t_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代金券模版表';

/*Data for the table `feiwa_voucher_template` */

/*Table structure for table `feiwa_vr_groupbuy_area` */

DROP TABLE IF EXISTS `feiwa_vr_groupbuy_area`;

CREATE TABLE `feiwa_vr_groupbuy_area` (
  `area_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '区域id',
  `area_name` varchar(100) NOT NULL DEFAULT '' COMMENT '域区名称',
  `parent_area_id` int(11) NOT NULL COMMENT '域区id',
  `add_time` int(11) NOT NULL COMMENT '添加时间',
  `first_letter` char(1) NOT NULL DEFAULT '' COMMENT '首字母',
  `area_number` varchar(10) DEFAULT NULL COMMENT '区号',
  `post` varchar(10) DEFAULT NULL COMMENT '邮编',
  `hot_city` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0.否 1.是',
  `area_num` int(11) NOT NULL DEFAULT '0' COMMENT '数量',
  PRIMARY KEY (`area_id`)
) ENGINE=InnoDB AUTO_INCREMENT=382 DEFAULT CHARSET=utf8 COMMENT='虚拟团购区域表';

/*Data for the table `feiwa_vr_groupbuy_area` */

insert  into `feiwa_vr_groupbuy_area`(`area_id`,`area_name`,`parent_area_id`,`add_time`,`first_letter`,`area_number`,`post`,`hot_city`,`area_num`) values (1,'天津',0,1395277186,'T','022','30000',1,0),(2,'北京',0,1368172202,'B','010','0',1,0),(3,'南开区',1,1395277206,'A','','0',0,0),(5,'和平区',1,1363832792,'H',NULL,NULL,1,1),(6,'大悦城',3,1395286450,'D','','0',0,0),(7,'鞍山',0,1367830248,'A',NULL,NULL,0,0),(8,'安顺',0,1367830274,'A',NULL,NULL,0,0),(9,'阿坝',0,1367830293,'A',NULL,NULL,0,0),(10,'阿拉善',0,1367830301,'A',NULL,NULL,0,0),(12,'包头',0,1367830350,'B',NULL,NULL,0,0),(13,'保定',0,1367830358,'B',NULL,NULL,0,0),(14,'巴中',0,1367830379,'B',NULL,NULL,0,0),(15,'成都',0,1367830392,'C',NULL,NULL,0,0),(16,'重庆',0,1367830411,'C',NULL,NULL,1,0),(17,'常州',0,1367830422,'C',NULL,NULL,0,0),(18,'长沙',0,1367830434,'C',NULL,NULL,1,0),(19,'长春',0,1367830446,'C',NULL,NULL,0,0),(20,'东莞',0,1367830459,'D',NULL,NULL,0,0),(21,'大连',0,1367830469,'D',NULL,NULL,1,0),(22,'东营',0,1367830479,'C',NULL,NULL,0,0),(23,'大庆',0,1367830489,'C',NULL,NULL,0,0),(24,'大同',0,1367830498,'A',NULL,NULL,0,0),(25,'恩施',0,1367830508,'E',NULL,NULL,0,0),(26,'鄂州',0,1367830518,'E',NULL,NULL,0,0),(27,'鄂尔多斯',0,1367830530,'E',NULL,NULL,0,0),(28,'福州',0,1367830542,'F',NULL,NULL,0,0),(29,'佛山',0,1367830555,'F',NULL,NULL,0,0),(30,'抚顺',0,1367830566,'F',NULL,NULL,0,0),(31,'阜阳',0,1367830578,'F',NULL,NULL,0,0),(32,'抚州',0,1367830590,'F',NULL,NULL,0,0),(33,'广州',0,1367830602,'G',NULL,NULL,1,0),(34,'贵阳',0,1367830612,'G',NULL,NULL,0,0),(35,'桂林',0,1367830622,'G',NULL,NULL,0,0),(36,'赣州',0,1367830635,'G',NULL,NULL,0,0),(37,'广元',0,1367830646,'G',NULL,NULL,0,0),(38,'杭州',0,1367830659,'H',NULL,NULL,1,0),(39,'哈尔滨',0,1367830670,'H',NULL,NULL,0,0),(40,'合肥',0,1367830683,'H',NULL,NULL,0,0),(41,'邯郸',0,1367830694,'H',NULL,NULL,0,0),(42,'惠州',0,1367830706,'H',NULL,NULL,0,0),(43,'济南',0,1367830720,'J',NULL,NULL,1,0),(44,'济宁',0,1367830732,'J',NULL,NULL,0,0),(45,'嘉兴',0,1367830769,'J',NULL,NULL,0,0),(46,'昆明',0,1367830783,'K',NULL,NULL,0,0),(47,'昆山',0,1367830792,'K',NULL,NULL,0,0),(48,'喀什',0,1367830803,'K',NULL,NULL,0,0),(49,'克拉玛依',0,1367830814,'K',NULL,NULL,0,0),(50,'兰州',0,1367830827,'L',NULL,NULL,0,0),(51,'临沂',0,1367830836,'L',NULL,NULL,0,0),(52,'连云港',0,1367830846,'L',NULL,NULL,0,0),(53,'马鞍山',0,1367830858,'M',NULL,NULL,0,0),(54,'绵阳',0,1367830867,'M',NULL,NULL,0,0),(55,'茂名',0,1367830878,'M',NULL,NULL,0,0),(56,'南京',0,1367830891,'N',NULL,NULL,1,0),(57,'宁波',0,1367830902,'N',NULL,NULL,0,0),(58,'南通',0,1367830914,'N',NULL,NULL,0,0),(59,'萍乡',0,1367830930,'P',NULL,NULL,0,0),(60,'平顶山',0,1367830940,'P',NULL,NULL,0,0),(61,'莆田',0,1367830951,'P',NULL,NULL,0,0),(62,'青岛',0,1367830963,'Q',NULL,NULL,1,0),(63,'泉州',0,1367830973,'Q',NULL,NULL,0,0),(64,'秦皇岛',0,1367830983,'Q',NULL,NULL,0,0),(65,'日照',0,1367830998,'R',NULL,NULL,0,0),(66,'日喀则',0,1367831009,'R',NULL,NULL,0,0),(67,'上海',0,1367831021,'S',NULL,NULL,1,0),(68,'深圳',0,1367831032,'S',NULL,NULL,0,0),(69,'沈阳',0,1367831042,'S',NULL,NULL,0,0),(70,'太原',0,1367831057,'T',NULL,NULL,1,0),(71,'泰安',0,1367831068,'T',NULL,NULL,0,0),(72,'武汉',0,1367831089,'W',NULL,NULL,0,0),(73,'无锡',0,1367831100,'W',NULL,NULL,0,0),(74,'温州',0,1367831112,'W',NULL,NULL,0,0),(75,'西安',0,1367831123,'X',NULL,NULL,0,0),(76,'西安',0,1367831133,'X',NULL,NULL,0,0),(77,'徐州',0,1367831146,'X',NULL,NULL,0,0),(78,'扬州',0,1367831158,'Y',NULL,NULL,0,0),(79,'烟台',0,1367831168,'Y',NULL,NULL,0,0),(80,'盐城',0,1367831180,'Y',NULL,NULL,0,0),(81,'郑州',0,1367831190,'Z',NULL,NULL,0,0),(82,'镇江',0,1367831200,'Z',NULL,NULL,0,0),(83,'中山',0,1367831213,'Z',NULL,NULL,0,0),(84,'阿里',0,1376357672,'A','','0',0,0),(85,'安康',0,1367889614,'A',NULL,NULL,0,0),(86,'阿克苏',0,1367889622,'A',NULL,NULL,0,0),(87,'安庆',0,1367889629,'A',NULL,NULL,0,0),(88,'阿勒泰',0,1367889638,'A',NULL,NULL,0,0),(89,'安阳',0,1367889646,'A',NULL,NULL,0,0),(90,'澳门',0,1367889653,'A',NULL,NULL,0,0),(91,'巴州',0,1367889663,'B',NULL,NULL,0,0),(92,'亳州',0,1367889677,'B',NULL,NULL,0,0),(93,'滨州',0,1367889687,'B',NULL,NULL,0,0),(94,'博尔塔拉',0,1367889697,'B',NULL,NULL,0,0),(95,'毕节',0,1367889707,'B',NULL,NULL,0,0),(96,'保山',0,1367889719,'B',NULL,NULL,0,0),(97,'本溪',0,1367889728,'B',NULL,NULL,0,0),(98,'百色',0,1367889738,'B',NULL,NULL,0,0),(99,'宝鸡',0,1367889748,'B',NULL,NULL,0,0),(100,'巴彦淖尔',0,1367889757,'B',NULL,NULL,0,0),(101,'北海',0,1367889766,'B',NULL,NULL,0,0),(102,'北海',0,1367889775,'B',NULL,NULL,0,0),(103,'白城',0,1367889785,'B',NULL,NULL,0,0),(104,'白银',0,1367889797,'B',NULL,NULL,0,0),(105,'承德',0,1367889808,'C',NULL,NULL,0,0),(106,'池州',0,1367889817,'C',NULL,NULL,0,0),(107,'昌都',0,1367889826,'C',NULL,NULL,0,0),(108,'朝阳',0,1367889834,'C',NULL,NULL,0,0),(109,'滁州',0,1367889845,'C',NULL,NULL,0,0),(110,'常德',0,1367889856,'C',NULL,NULL,0,0),(111,'郴州',0,1367889865,'C',NULL,NULL,0,0),(112,'沧州',0,1367889875,'C',NULL,NULL,0,0),(113,'昌吉',0,1367889885,'C',NULL,NULL,0,0),(114,'潮州',0,1367889895,'C',NULL,NULL,0,0),(115,'崇左',0,1367889906,'C',NULL,NULL,0,0),(116,'巢湖',0,1367889915,'C',NULL,NULL,0,0),(117,'长治',0,1367889924,'C',NULL,NULL,0,0),(118,'楚雄',0,1367889936,'C',NULL,NULL,0,0),(119,'赤峰',0,1367889945,'C',NULL,NULL,0,0),(120,'定西',0,1367889956,'D',NULL,NULL,0,0),(121,'德宏',0,1367889965,'D',NULL,NULL,0,0),(122,'大兴安岭',0,1367889974,'D',NULL,NULL,0,0),(123,'丹东',0,1367889983,'D',NULL,NULL,0,0),(124,'德州',0,1367889992,'D',NULL,NULL,0,0),(125,'达州',0,1367890002,'D',NULL,NULL,0,0),(126,'迪庆',0,1367890012,'D',NULL,NULL,0,0),(127,'德阳',0,1367890022,'D',NULL,NULL,0,0),(128,'大理',0,1367890031,'D',NULL,NULL,0,0),(129,'阜新',0,1367890041,'E',NULL,NULL,0,0),(130,'防城港',0,1367890050,'E',NULL,NULL,0,0),(131,'抚州',0,1367890059,'E',NULL,NULL,0,0),(132,'阜阳',0,1367890088,'F',NULL,NULL,0,0),(133,'贵港',0,1367890101,'G',NULL,NULL,0,0),(134,'广安',0,1367890120,'G',NULL,NULL,0,0),(135,'甘孜',0,1367890130,'G',NULL,NULL,0,0),(136,'甘南',0,1367890139,'G',NULL,NULL,0,0),(137,'固原',0,1367890148,'G',NULL,NULL,0,0),(138,'果洛',0,1367890157,'G',NULL,NULL,0,0),(139,'广元',0,1367890172,'G',NULL,NULL,0,0),(140,'葫芦岛',0,1367890183,'H',NULL,NULL,0,0),(141,'鹤壁',0,1367890192,'H',NULL,NULL,0,0),(142,'黄石',0,1367890203,'G',NULL,NULL,0,0),(143,'黄冈',0,1367890214,'H',NULL,NULL,0,0),(144,'汉中',0,1367890224,'H',NULL,NULL,0,0),(145,'红河',0,1367890233,'H',NULL,NULL,0,0),(146,'河源',0,1367890243,'H',NULL,NULL,0,0),(147,'衡水',0,1367890253,'H',NULL,NULL,0,0),(148,'呼伦贝尔',0,1367890265,'H',NULL,NULL,0,0),(149,'河池',0,1367890275,'H',NULL,NULL,0,0),(150,'怀化',0,1367890284,'H',NULL,NULL,0,0),(151,'贺州',0,1367890294,'H',NULL,NULL,0,0),(152,'海西',0,1367890304,'H',NULL,NULL,0,0),(153,'黄山',0,1367890314,'H',NULL,NULL,0,0),(154,'淮南',0,1367890327,'H',NULL,NULL,0,0),(155,'淮安',0,1367890337,'H',NULL,NULL,0,0),(156,'哈密',0,1367890346,'H',NULL,NULL,0,0),(157,'和田',0,1367890355,'H',NULL,NULL,0,0),(158,'黑河',0,1367890367,'H',NULL,NULL,0,0),(159,'九江',0,1367890378,'J',NULL,NULL,0,0),(160,'荆门',0,1367890386,'J',NULL,NULL,0,0),(161,'晋中',0,1367890396,'J',NULL,NULL,0,0),(162,'揭阳',0,1367890406,'J',NULL,NULL,0,0),(163,'晋城',0,1367890421,'J',NULL,NULL,0,0),(164,'济源',0,1367890431,'J',NULL,NULL,0,0),(165,'鸡西',0,1367890440,'J',NULL,NULL,0,0),(166,'金昌',0,1367890448,'J',NULL,NULL,0,0),(167,'酒泉',0,1367890459,'J',NULL,NULL,0,0),(168,'佳木斯',0,1367890468,'J',NULL,NULL,0,0),(169,'吉安',0,1367890484,'J',NULL,NULL,0,0),(170,'景德镇',0,1367890496,'J',NULL,NULL,0,0),(171,'江门',0,1367890505,'J',NULL,NULL,0,0),(172,'锦州',0,1367890515,'J',NULL,NULL,0,0),(173,'吉林',0,1367890524,'J',NULL,NULL,0,0),(174,'荆州',0,1367890533,'J',NULL,NULL,0,0),(175,'克州',0,1367890545,'K',NULL,NULL,0,0),(176,'开封',0,1367890554,'K',NULL,NULL,0,0),(177,'乐山',0,1367890567,'L',NULL,NULL,0,0),(178,'泸州',0,1367890576,'L',NULL,NULL,0,0),(179,'来宾',0,1367890585,'L',NULL,NULL,0,0),(180,'娄底',0,1367890596,'L',NULL,NULL,0,0),(181,'林芝',0,1367890606,'L',NULL,NULL,0,0),(182,'临夏',0,1367890615,'L',NULL,NULL,0,0),(183,'丽水',0,1367890623,'L',NULL,NULL,0,0),(184,'吕梁',0,1367890633,'L',NULL,NULL,0,0),(185,'漯河',0,1367890642,'L',NULL,NULL,0,0),(186,'莱芜',0,1367890652,'L',NULL,NULL,0,0),(187,'辽阳',0,1367890661,'L',NULL,NULL,0,0),(188,'辽源',0,1367890672,'L',NULL,NULL,0,0),(189,'拉萨',0,1367890681,'L',NULL,NULL,0,0),(190,'陇南',0,1367890693,'L',NULL,NULL,0,0),(191,'临沧',0,1367890701,'L',NULL,NULL,0,0),(192,'丽江',0,1367890712,'L',NULL,NULL,0,0),(193,'六安',0,1367890721,'L',NULL,NULL,0,0),(194,'凉山',0,1367890730,'L',NULL,NULL,0,0),(195,'六盘水',0,1367890739,'L',NULL,NULL,0,0),(196,'龙岩',0,1367890749,'L',NULL,NULL,0,0),(197,'廊坊',0,1367890758,'L',NULL,NULL,0,0),(198,'眉山',0,1367890772,'M',NULL,NULL,0,0),(199,'梅州',0,1367890781,'M',NULL,NULL,0,0),(200,'牡丹江',0,1367890791,'M',NULL,NULL,0,0),(201,'那曲',0,1367890800,'N',NULL,NULL,0,0),(202,'南阳',0,1367890810,'N',NULL,NULL,0,0),(203,'南平',0,1367890819,'N',NULL,NULL,0,0),(204,'怒江',0,1367890828,'N',NULL,NULL,0,0),(205,'内江',0,1367890837,'N',NULL,NULL,0,0),(206,'宁德',0,1367890845,'N',NULL,NULL,0,0),(207,'南充',0,1367890854,'N',NULL,NULL,0,0),(208,'南昌',0,1367890863,'N',NULL,NULL,0,0),(209,'盘锦',0,1367890872,'P',NULL,NULL,0,0),(210,'普洱',0,1367890884,'P',NULL,NULL,0,0),(211,'平凉',0,1367890894,'P',NULL,NULL,0,0),(212,'攀枝花',0,1367890907,'P',NULL,NULL,0,0),(213,'濮阳',0,1367890915,'P',NULL,NULL,0,0),(214,'清远',0,1367890927,'Q',NULL,NULL,0,0),(215,'七台河',0,1367890937,'Q',NULL,NULL,0,0),(216,'黔东南',0,1367890946,'Q',NULL,NULL,0,0),(217,'曲靖',0,1367890960,'Q',NULL,NULL,0,0),(218,'黔南',0,1367890978,'Q',NULL,NULL,0,0),(219,'钦州',0,1367890986,'Q',NULL,NULL,0,0),(220,'黔西南',0,1367890995,'Q',NULL,NULL,0,0),(221,'衢州',0,1367891003,'Q',NULL,NULL,0,0),(222,'商洛',0,1367891022,'S',NULL,NULL,0,0),(223,'宿州',0,1367891034,'S',NULL,NULL,0,0),(224,'汕头',0,1367891044,'S',NULL,NULL,0,0),(225,'双鸭山',0,1367891053,'S',NULL,NULL,0,0),(226,'石嘴山',0,1367891063,'S',NULL,NULL,0,0),(227,'三明',0,1367891071,'S',NULL,NULL,0,0),(228,'宿迁',0,1367891080,'S',NULL,NULL,0,0),(229,'三峡',0,1367891089,'S',NULL,NULL,0,0),(230,'四平',0,1367891098,'S',NULL,NULL,0,0),(231,'汕尾',0,1367891107,'S',NULL,NULL,0,0),(232,'随州',0,1367891116,'S',NULL,NULL,0,0),(233,'朔州',0,1367891125,'S',NULL,NULL,0,0),(234,'商丘',0,1367891135,'S',NULL,NULL,0,0),(235,'遂宁',0,1367891144,'S',NULL,NULL,0,0),(236,'邵阳',0,1367891153,'S',NULL,NULL,0,0),(237,'山南',0,1367891161,'S',NULL,NULL,0,0),(238,'三门峡',0,1367891172,'S',NULL,NULL,0,0),(239,'十堰',0,1367891181,'S',NULL,NULL,0,0),(240,'上饶',0,1367891190,'S',NULL,NULL,0,0),(241,'松原',0,1367891199,'S',NULL,NULL,0,0),(242,'绥化',0,1367891208,'S',NULL,NULL,0,0),(243,'韶关',0,1367891218,'S',NULL,NULL,0,0),(244,'通化',0,1367891228,'T',NULL,NULL,0,0),(245,'铁岭',0,1367891236,'T',NULL,NULL,0,0),(246,'通辽',0,1367891246,'T',NULL,NULL,0,0),(247,'天水',0,1367891255,'T',NULL,NULL,0,0),(248,'吐鲁番',0,1367891264,'T',NULL,NULL,0,0),(249,'铜仁',0,1367891274,'T',NULL,NULL,0,0),(250,'台北',0,1367891282,'T',NULL,NULL,0,0),(251,'铜川',0,1367891291,'T',NULL,NULL,0,0),(252,'铜陵',0,1367891299,'T',NULL,NULL,0,0),(253,'塔城',0,1367891307,'T',NULL,NULL,0,0),(254,'泰州',0,1367891316,'T',NULL,NULL,0,0),(255,'乌海',0,1367891328,'W',NULL,NULL,0,0),(256,'文山',0,1367891345,'W',NULL,NULL,0,0),(257,'乌兰察布',0,1367891352,'A',NULL,NULL,0,0),(258,'渭南',0,1367891361,'W',NULL,NULL,0,0),(259,'武威',0,1367891370,'W',NULL,NULL,0,0),(260,'吴忠',0,1367891380,'W',NULL,NULL,0,0),(261,'梧州',0,1367891389,'W',NULL,NULL,0,0),(262,'乌鲁木齐',0,1367891398,'W',NULL,NULL,0,0),(263,'潍坊',0,1367891407,'W',NULL,NULL,0,0),(264,'威海',0,1367891416,'W',NULL,NULL,0,0),(265,'芜湖',0,1367891426,'W',NULL,NULL,0,0),(266,'许昌',0,1367891436,'X',NULL,NULL,0,0),(267,'咸宁',0,1367891449,'X',NULL,NULL,0,0),(268,'信阳',0,1367891458,'X',NULL,NULL,0,0),(269,'香港',0,1367891466,'X',NULL,NULL,0,0),(270,'宣城',0,1367891475,'X',NULL,NULL,0,0),(271,'咸阳',0,1367891485,'X',NULL,NULL,0,0),(272,'忻州',0,1367891496,'X',NULL,NULL,0,0),(273,'湘西',0,1367891520,'X',NULL,NULL,0,0),(274,'新乡',0,1367891532,'X',NULL,NULL,0,0),(275,'邢台',0,1367891541,'X',NULL,NULL,0,0),(276,'兴安',0,1367891550,'X',NULL,NULL,0,0),(277,'锡林郭勒',0,1367891560,'X',NULL,NULL,0,0),(278,'湘潭',0,1367891568,'X',NULL,NULL,0,0),(279,'新余',0,1367891578,'X',NULL,NULL,0,0),(280,'西双版纳',0,1367891588,'X',NULL,NULL,0,0),(281,'孝感',0,1367891600,'X',NULL,NULL,0,0),(282,'伊春',0,1367891610,'Y',NULL,NULL,0,0),(283,'阳江',0,1367891619,'Y',NULL,NULL,0,0),(284,'延边',0,1367891632,'Y',NULL,NULL,0,0),(285,'云浮',0,1367891643,'Y',NULL,NULL,0,0),(286,'榆林',0,1367891652,'Y',NULL,NULL,0,0),(287,'延安',0,1367891662,'Y',NULL,NULL,0,0),(288,'阳泉',0,1367891672,'Y',NULL,NULL,0,0),(289,'玉溪',0,1367891681,'Y',NULL,NULL,0,0),(290,'益阳',0,1367891690,'Y',NULL,NULL,0,0),(291,'宜宾',0,1367891699,'Y',NULL,NULL,0,0),(292,'永州',0,1367891708,'Y',NULL,NULL,0,0),(293,'营口',0,1367891719,'Y',NULL,NULL,0,0),(294,'宜春',0,1367891733,'Y',NULL,NULL,0,0),(295,'玉树',0,1367891742,'Y',NULL,NULL,0,0),(296,'伊犁',0,1367891752,'Y',NULL,NULL,0,0),(297,'雅安',0,1367891761,'Y',NULL,NULL,0,0),(298,'鹰潭',0,1367891770,'Y',NULL,NULL,0,0),(299,'银川',0,1367891780,'Y',NULL,NULL,0,0),(300,'枣庄',0,1367891790,'Z',NULL,NULL,0,0),(301,'中卫',0,1367891801,'Z',NULL,NULL,0,0),(302,'资阳',0,1367891810,'Z',NULL,NULL,0,0),(303,'张家口',0,1367891821,'Z',NULL,NULL,0,0),(304,'驻马店',0,1367891830,'Z',NULL,NULL,0,0),(305,'周口',0,1367891840,'Z',NULL,NULL,0,0),(306,'张家界',0,1367891849,'Z',NULL,NULL,0,0),(307,'昭通',0,1367891858,'Z',NULL,NULL,0,0),(308,'张掖',0,1367891866,'Z',NULL,NULL,0,0),(309,'肇庆',0,1367891878,'Z',NULL,NULL,0,0),(310,'湛江',0,1367891888,'Z',NULL,NULL,0,0),(314,'河西区',1,1367915137,'A',NULL,NULL,0,0),(315,'河东区',1,1367915221,'A',NULL,NULL,0,0),(316,'水游城',3,1367915892,'A',NULL,NULL,0,0),(317,'河北区',1,1367916777,'H',NULL,NULL,0,0),(318,'红桥区',1,1367916799,'H',NULL,NULL,0,0),(319,'滨海新区',1,1367916834,'B',NULL,NULL,0,0),(320,'老城厢/大悦城',3,1367916878,'L',NULL,NULL,0,0),(321,'白堤路/风荷园',3,1367916904,'B',NULL,NULL,0,0),(322,'王顶堤/华苑',3,1367916922,'A',NULL,NULL,0,0),(323,'水上/天塔',3,1367916942,'S',NULL,NULL,0,0),(324,'时代奥城',3,1367916960,'A',NULL,NULL,0,0),(325,'长虹公园',3,1367916985,'C',NULL,NULL,0,0),(326,'南开公园',3,1367917001,'A',NULL,NULL,0,0),(327,'南开大学/八里台',3,1367917020,'A',NULL,NULL,0,0),(328,'海光寺/六里台',3,1367917047,'A',NULL,NULL,0,0),(329,'天拖地区',3,1367917062,'A',NULL,NULL,0,0),(330,'鼓楼/七向街',3,1367917077,'A',NULL,NULL,0,0),(331,'鞍山西道',3,1367917100,'A',NULL,NULL,0,0),(332,'东马路/新世界百货',3,1367917114,'A',NULL,NULL,0,0),(333,'滨江道',5,1367917139,'A',NULL,NULL,0,1),(334,'和平路',5,1367917155,'A',NULL,NULL,0,0),(335,'小白楼',5,1367917169,'A',NULL,NULL,0,0),(336,'鞍山道沿线',5,1367917185,'A',NULL,NULL,0,0),(337,'南市',5,1367917201,'A',NULL,NULL,0,0),(338,'五大道',5,1367917216,'A',NULL,NULL,0,0),(339,'西康路沿线',5,1367917235,'A',NULL,NULL,0,0),(340,'津湾广场',5,1367917249,'A',NULL,NULL,0,0),(341,'荣业大街',5,1367917267,'A',NULL,NULL,0,0),(342,'土城',314,1367917309,'A',NULL,NULL,0,0),(343,'小海地',314,1367917326,'A',NULL,NULL,0,0),(344,'体院北',314,1367917341,'A',NULL,NULL,0,0),(345,'图书大厦',314,1367917357,'A',NULL,NULL,0,0),(346,'梅江',314,1367917373,'A',NULL,NULL,0,0),(347,'永安道',314,1367917388,'A',NULL,NULL,0,0),(348,'尖山',314,1367917401,'A',NULL,NULL,0,0),(349,'佟楼',314,1367917424,'A',NULL,NULL,0,0),(350,'乐园道',314,1367917440,'A',NULL,NULL,0,0),(351,'下瓦房',314,1367917457,'A',NULL,NULL,0,0),(352,'南楼',314,1367917471,'A',NULL,NULL,0,0),(353,'越秀路',314,1367917485,'A',NULL,NULL,0,0),(354,'天津站后广场',315,1367917503,'A',NULL,NULL,0,0),(355,'卫国道',315,1367917740,'A',NULL,NULL,0,0),(356,'二宫',3,1367917756,'A',NULL,NULL,0,0),(357,'河东万达广场',3,1367917775,'A',NULL,NULL,0,0),(358,'万新村',315,1367917791,'A',NULL,NULL,0,0),(359,'工业大学',315,1367917805,'A',NULL,NULL,0,0),(360,'大王庄',315,1367917819,'A',NULL,NULL,0,0),(361,'大直沽',315,1367917833,'A',NULL,NULL,0,0),(362,'中山门',315,1367917849,'A',NULL,NULL,0,0),(363,'金钟河大街',317,1367917874,'A',NULL,NULL,0,0),(364,'狮子林大街',317,1367917885,'A',NULL,NULL,0,0),(365,'天泰路/榆关道',317,1367917899,'A',NULL,NULL,0,0),(366,'意大利风情区/火车站',317,1367917913,'A',NULL,NULL,0,0),(367,'中山路',317,1367917924,'A',NULL,NULL,0,0),(368,'王串场/民权门',317,1367917939,'A',NULL,NULL,0,0),(369,'汉沽城区',319,1367917968,'A',NULL,NULL,0,0),(370,'大港城区',319,1367917982,'A',NULL,NULL,0,0),(371,'大港油田',319,1367917995,'A',NULL,NULL,0,0),(372,'经济开发区',319,1367918007,'A',NULL,NULL,0,0),(373,'塘沽城区',319,1367918020,'A',NULL,NULL,0,0),(374,'大胡同',318,1367918039,'A',NULL,NULL,0,0),(375,'天津西站',318,1367918053,'A',NULL,NULL,0,0),(376,'创意街/水木天成',318,1367918065,'A',NULL,NULL,0,0),(377,'凯莱赛',318,1367918077,'A',NULL,NULL,0,0),(378,'本溪路/丁字沽',318,1367918094,'A',NULL,NULL,0,0),(379,'芥园道/水游城',318,1367918107,'A',NULL,NULL,0,0),(380,'东城区',2,1367978117,'A',NULL,NULL,0,0),(381,'西城区',2,1367978125,'A',NULL,NULL,0,0);

/*Table structure for table `feiwa_vr_groupbuy_class` */

DROP TABLE IF EXISTS `feiwa_vr_groupbuy_class`;

CREATE TABLE `feiwa_vr_groupbuy_class` (
  `class_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `class_name` varchar(100) NOT NULL DEFAULT '' COMMENT '分类名称',
  `parent_class_id` int(11) NOT NULL COMMENT '父类class_id',
  `class_sort` tinyint(3) unsigned DEFAULT NULL COMMENT '分类排序',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COMMENT='虚拟团购分类表';

/*Data for the table `feiwa_vr_groupbuy_class` */

insert  into `feiwa_vr_groupbuy_class`(`class_id`,`class_name`,`parent_class_id`,`class_sort`) values (2,'餐饮美食',0,2),(3,'休闲娱乐',0,2),(7,'生活服务',0,3),(8,'小吃快餐',2,1),(9,'火锅',2,2),(10,'自助餐',2,3),(12,'川菜',2,5),(13,'甜品饮品',2,6),(14,'日本料理',2,7),(15,'韩国料理',2,8),(16,'主题餐厅',2,9),(17,'KTV',3,1),(18,'酒吧',3,2),(19,'电影院',3,3),(20,'公园景点',3,4),(21,'足浴按摩',3,5),(22,'运动健身',3,6),(23,'瑜伽馆',3,7),(24,'书店',3,8),(25,'电玩',3,9),(26,'电影演出',0,4),(27,'商场超市',0,5),(29,'婚庆摄像',7,1),(30,'母婴服务',7,2),(31,'银行',7,3),(32,'搬家',7,4),(33,'维修',7,5),(34,'家政保姆',7,6),(35,'开锁',7,7),(36,'宠物服务',7,8),(37,'洗衣店',7,9),(38,'电子通票',26,1),(39,'帮你代购',26,2),(40,'万达院线',26,3),(41,'金逸院线',26,4),(42,'嘉禾院线',26,5),(43,'博纳院线',26,6),(44,'UME院线',26,7),(45,'中影国际',26,8),(46,'耀莱国际',26,9),(47,'物美超市',27,1),(48,'超市卡',27,2),(49,'商场卡',27,3),(50,'水果券',27,4),(51,'购物券',27,5),(52,'食品券',27,6),(53,'网店优惠券',27,7),(54,'新世界',27,8),(55,'银泰',27,9),(56,'新一佳',27,10),(69,'电子优惠',0,6),(74,'俏江南',69,1),(75,'哈根达斯',69,2),(76,'银泰百货',69,3),(77,'阳澄湖',69,4),(78,'许留山',69,5),(79,'酷圣石',69,6),(80,'克丽缇娜',69,7),(81,'一兆韦德',69,8),(82,'宝岛眼镜',69,9),(83,'金钱豹',69,10),(84,'摄像写真',0,7),(85,'婚纱摄影',84,1),(86,'儿童摄影',84,2),(87,'写真摄影',84,3),(88,'商品摄影',84,4),(89,'个人写真',84,5),(94,'教育培训',0,8),(95,'语言培训',94,1),(96,'中小学教育',94,2),(97,'少儿培训',94,3),(98,'公务员培训',94,4),(99,'学历教育',94,5),(100,'职业资格认证',94,6);

/*Table structure for table `feiwa_vr_order` */

DROP TABLE IF EXISTS `feiwa_vr_order`;

CREATE TABLE `feiwa_vr_order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '虚拟订单索引id',
  `order_sn` bigint(20) unsigned NOT NULL COMMENT '订单编号',
  `store_id` int(11) unsigned NOT NULL COMMENT '卖家店铺id',
  `store_name` varchar(50) NOT NULL DEFAULT '' COMMENT '卖家店铺名称',
  `buyer_id` int(11) unsigned NOT NULL COMMENT '买家id',
  `buyer_name` varchar(50) NOT NULL DEFAULT '' COMMENT '买家登录名',
  `buyer_phone` varchar(11) NOT NULL DEFAULT '' COMMENT '买家手机',
  `add_time` int(10) unsigned NOT NULL COMMENT '订单生成时间',
  `payment_code` char(10) DEFAULT '' COMMENT '支付方式名称代码',
  `payment_time` int(10) unsigned DEFAULT '0' COMMENT '支付(付款)时间',
  `trade_no` varchar(35) DEFAULT NULL COMMENT '第三方平台交易号',
  `close_time` int(10) unsigned DEFAULT '0' COMMENT '关闭时间',
  `close_reason` varchar(50) DEFAULT NULL COMMENT '关闭原因',
  `finnshed_time` int(11) DEFAULT NULL COMMENT '完成时间',
  `order_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单总价格(支付金额)',
  `refund_amount` decimal(10,2) DEFAULT '0.00' COMMENT '退款金额',
  `rcb_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '充值卡支付金额',
  `pd_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '预存款支付金额',
  `order_state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '订单状态：0(已取消)10(默认):未付款;20:已付款;40:已完成;',
  `refund_state` tinyint(1) unsigned DEFAULT '0' COMMENT '退款状态:0是无退款,1是部分退款,2是全部退款',
  `buyer_msg` varchar(150) DEFAULT NULL COMMENT '买家留言',
  `delete_state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除状态0未删除1放入回收站2彻底删除',
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  `goods_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_price` decimal(10,2) NOT NULL COMMENT '商品价格',
  `goods_num` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT '商品数量',
  `goods_image` varchar(100) DEFAULT NULL COMMENT '商品图片',
  `commis_rate` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '佣金比例',
  `gc_id` mediumint(9) DEFAULT '0' COMMENT '商品最底级分类ID',
  `vr_indate` int(11) DEFAULT NULL COMMENT '有效期',
  `vr_send_times` tinyint(4) NOT NULL DEFAULT '0' COMMENT '兑换码发送次数',
  `vr_invalid_refund` tinyint(4) NOT NULL DEFAULT '1' COMMENT '允许过期退款1是0否',
  `order_promotion_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单参加的促销类型 0无促销1团购',
  `promotions_id` mediumint(9) DEFAULT '0' COMMENT '促销ID，与order_promotion_type配合使用',
  `order_from` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1WEB2mobile',
  `evaluation_state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '评价状态0默认1已评价2禁止评价',
  `evaluation_time` int(11) NOT NULL DEFAULT '0' COMMENT '评价时间',
  `use_state` tinyint(4) DEFAULT '0' COMMENT '使用状态0默认，未使用1已使用，有一个被使用即为1',
  `api_pay_time` int(10) unsigned DEFAULT '0' COMMENT '在线支付动作时间,只有站内+在线组合支付时记录',
  `goods_contractid` varchar(100) DEFAULT NULL COMMENT '商品开启的消费者保障服务id',
  `goods_spec` varchar(200) DEFAULT NULL COMMENT '规格',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='虚拟订单表';

/*Data for the table `feiwa_vr_order` */

/*Table structure for table `feiwa_vr_order_bill` */

DROP TABLE IF EXISTS `feiwa_vr_order_bill`;

CREATE TABLE `feiwa_vr_order_bill` (
  `ob_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键作为结算单号',
  `ob_no` int(11) DEFAULT '0' COMMENT '结算单编号(年月店铺ID)',
  `ob_start_date` int(11) NOT NULL COMMENT '开始日期',
  `ob_end_date` int(11) NOT NULL COMMENT '结束日期',
  `ob_order_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单金额',
  `ob_commis_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '佣金金额',
  `ob_result_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '应结金额',
  `ob_create_date` int(11) DEFAULT '0' COMMENT '生成结算单日期',
  `os_month` mediumint(6) unsigned DEFAULT NULL COMMENT '出账单应结时间,ob_end_date+1所在月(年月份)',
  `ob_state` enum('1','2','3','4') DEFAULT '1' COMMENT '1默认2店家已确认3平台已审核4结算完成',
  `ob_pay_date` int(11) DEFAULT '0' COMMENT '付款日期',
  `ob_pay_content` varchar(200) DEFAULT '' COMMENT '支付备注',
  `ob_store_id` int(11) NOT NULL COMMENT '店铺ID',
  `ob_store_name` varchar(50) DEFAULT NULL COMMENT '店铺名',
  PRIMARY KEY (`ob_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='虚拟订单结算表';

/*Data for the table `feiwa_vr_order_bill` */

/*Table structure for table `feiwa_vr_order_code` */

DROP TABLE IF EXISTS `feiwa_vr_order_code`;

CREATE TABLE `feiwa_vr_order_code` (
  `rec_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '兑换码表索引id',
  `order_id` int(11) NOT NULL COMMENT '虚拟订单id',
  `store_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `buyer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '买家ID',
  `vr_code` varchar(18) NOT NULL DEFAULT '' COMMENT '兑换码',
  `vr_state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '使用状态 0:(默认)未使用1:已使用2:已过期',
  `vr_usetime` int(11) DEFAULT NULL COMMENT '使用时间',
  `pay_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '实际支付金额(结算)',
  `vr_indate` int(11) DEFAULT NULL COMMENT '过期时间',
  `commis_rate` smallint(6) NOT NULL DEFAULT '0' COMMENT '佣金比例',
  `refund_lock` tinyint(1) unsigned DEFAULT '0' COMMENT '退款锁定状态:0为正常,1为锁定,2为同意,默认为0',
  `vr_invalid_refund` tinyint(4) NOT NULL DEFAULT '1' COMMENT '允许过期退款1是0否',
  PRIMARY KEY (`rec_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='兑换码表';

/*Data for the table `feiwa_vr_order_code` */

/*Table structure for table `feiwa_vr_order_snapshot` */

DROP TABLE IF EXISTS `feiwa_vr_order_snapshot`;

CREATE TABLE `feiwa_vr_order_snapshot` (
  `order_id` int(11) NOT NULL COMMENT '主键',
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `create_time` int(11) NOT NULL COMMENT '生成时间',
  `goods_attr` text COMMENT '属性',
  `goods_body` text COMMENT '详情',
  `plate_top` text COMMENT '顶部关联版式',
  `plate_bottom` text COMMENT '底部关联版式',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='虚拟订单快照表';

/*Data for the table `feiwa_vr_order_snapshot` */

/*Table structure for table `feiwa_vr_order_statis` */

DROP TABLE IF EXISTS `feiwa_vr_order_statis`;

CREATE TABLE `feiwa_vr_order_statis` (
  `os_month` mediumint(9) unsigned NOT NULL DEFAULT '0' COMMENT '统计编号(年月)',
  `os_year` smallint(6) DEFAULT '0' COMMENT '年',
  `os_start_date` int(11) NOT NULL COMMENT '开始日期',
  `os_end_date` int(11) NOT NULL COMMENT '结束日期',
  `os_order_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单金额',
  `os_commis_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '佣金金额',
  `os_result_totals` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '本期应结',
  `os_create_date` int(11) DEFAULT NULL COMMENT '创建记录日期',
  PRIMARY KEY (`os_month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='虚拟订单月销量统计表';

/*Data for the table `feiwa_vr_order_statis` */

/*Table structure for table `feiwa_vr_refund` */

DROP TABLE IF EXISTS `feiwa_vr_refund`;

CREATE TABLE `feiwa_vr_refund` (
  `refund_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `order_id` int(10) unsigned NOT NULL COMMENT '虚拟订单ID',
  `order_sn` varchar(50) NOT NULL DEFAULT '' COMMENT '虚拟订单编号',
  `refund_sn` varchar(50) NOT NULL DEFAULT '' COMMENT '申请编号',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺ID',
  `store_name` varchar(20) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `buyer_id` int(10) unsigned NOT NULL COMMENT '买家ID',
  `buyer_name` varchar(50) NOT NULL DEFAULT '' COMMENT '买家会员名',
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品ID',
  `goods_num` int(10) unsigned DEFAULT '1' COMMENT '退款商品数量',
  `goods_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_image` varchar(100) DEFAULT NULL COMMENT '商品图片',
  `code_sn` varchar(300) NOT NULL DEFAULT '' COMMENT '兑换码编号',
  `refund_amount` decimal(10,2) DEFAULT '0.00' COMMENT '退款金额',
  `admin_state` tinyint(1) unsigned DEFAULT '1' COMMENT '退款状态:1为待审核,2为同意,3为不同意,默认为1',
  `add_time` int(10) unsigned NOT NULL COMMENT '添加时间',
  `admin_time` int(10) unsigned DEFAULT '0' COMMENT '管理员处理时间,默认为0',
  `buyer_message` varchar(300) DEFAULT NULL COMMENT '申请原因',
  `admin_message` varchar(300) DEFAULT NULL COMMENT '管理员备注',
  `commis_rate` smallint(6) DEFAULT '0' COMMENT '佣金比例',
  PRIMARY KEY (`refund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='虚拟兑码退款表';

/*Data for the table `feiwa_vr_refund` */

/*Table structure for table `feiwa_vr_refund_detail` */

DROP TABLE IF EXISTS `feiwa_vr_refund_detail`;

CREATE TABLE `feiwa_vr_refund_detail` (
  `refund_id` int(10) unsigned NOT NULL COMMENT '记录ID',
  `order_id` int(10) unsigned NOT NULL COMMENT '订单ID',
  `batch_no` varchar(32) NOT NULL DEFAULT '' COMMENT '批次号',
  `refund_amount` decimal(10,2) DEFAULT '0.00' COMMENT '退款金额',
  `pay_amount` decimal(10,2) DEFAULT '0.00' COMMENT '在线退款金额',
  `pd_amount` decimal(10,2) DEFAULT '0.00' COMMENT '预存款金额',
  `rcb_amount` decimal(10,2) DEFAULT '0.00' COMMENT '充值卡金额',
  `refund_code` char(10) NOT NULL DEFAULT 'predeposit' COMMENT '退款支付代码',
  `refund_state` tinyint(1) unsigned DEFAULT '1' COMMENT '退款状态:1为处理中,2为已完成,默认为1',
  `add_time` int(10) unsigned NOT NULL COMMENT '添加时间',
  `pay_time` int(10) unsigned DEFAULT '0' COMMENT '在线退款完成时间,默认为0',
  PRIMARY KEY (`refund_id`),
  KEY `batch_no` (`batch_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='虚拟兑码退款详细表';

/*Data for the table `feiwa_vr_refund_detail` */

/*Table structure for table `feiwa_waybill` */

DROP TABLE IF EXISTS `feiwa_waybill`;

CREATE TABLE `feiwa_waybill` (
  `waybill_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `waybill_name` varchar(50) NOT NULL DEFAULT '',
  `waybill_image` varchar(50) NOT NULL DEFAULT '',
  `waybill_width` int(10) unsigned NOT NULL COMMENT '宽度',
  `waybill_height` int(10) unsigned NOT NULL COMMENT '高度',
  `waybill_data` varchar(2000) DEFAULT NULL COMMENT '打印位置数据',
  `waybill_usable` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否可用',
  `waybill_top` int(11) NOT NULL DEFAULT '0' COMMENT '上偏移量',
  `waybill_left` int(11) NOT NULL DEFAULT '0' COMMENT '左偏移量',
  `express_id` tinyint(1) unsigned NOT NULL COMMENT '快递公司编号',
  `express_name` varchar(50) NOT NULL DEFAULT '' COMMENT '快递公司名称',
  `store_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '店铺编号(0-代表系统模板)',
  PRIMARY KEY (`waybill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='快递单打印模板表';

/*Data for the table `feiwa_waybill` */

insert  into `feiwa_waybill`(`waybill_id`,`waybill_name`,`waybill_image`,`waybill_width`,`waybill_height`,`waybill_data`,`waybill_usable`,`waybill_top`,`waybill_left`,`express_id`,`express_name`,`store_id`) values (1,'百世汇通','04558238732336424.jpg',229,126,'a:10:{s:10:\"buyer_name\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"485\";s:3:\"top\";s:2:\"97\";s:5:\"width\";s:2:\"88\";s:6:\"height\";s:2:\"24\";}s:10:\"buyer_area\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"423\";s:3:\"top\";s:3:\"173\";s:5:\"width\";s:3:\"256\";s:6:\"height\";s:2:\"20\";}s:13:\"buyer_address\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"420\";s:3:\"top\";s:3:\"201\";s:5:\"width\";s:3:\"333\";s:6:\"height\";s:2:\"20\";}s:12:\"buyer_mobile\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"473\";s:3:\"top\";s:3:\"230\";s:5:\"width\";s:3:\"141\";s:6:\"height\";s:2:\"20\";}s:11:\"buyer_phone\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"671\";s:3:\"top\";s:3:\"227\";s:5:\"width\";s:3:\"100\";s:6:\"height\";s:2:\"20\";}s:11:\"seller_name\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"126\";s:3:\"top\";s:2:\"98\";s:5:\"width\";s:3:\"112\";s:6:\"height\";s:2:\"16\";}s:11:\"seller_area\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:2:\"72\";s:3:\"top\";s:3:\"174\";s:5:\"width\";s:3:\"227\";s:6:\"height\";s:2:\"20\";}s:14:\"seller_address\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:2:\"68\";s:3:\"top\";s:3:\"204\";s:5:\"width\";s:3:\"294\";s:6:\"height\";s:2:\"20\";}s:12:\"seller_phone\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"120\";s:3:\"top\";s:3:\"231\";s:5:\"width\";s:3:\"124\";s:6:\"height\";s:2:\"20\";}s:14:\"seller_company\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"116\";s:3:\"top\";s:3:\"124\";s:5:\"width\";s:3:\"184\";s:6:\"height\";s:2:\"20\";}}',1,-3,-5,16,'汇通快递',0),(2,'申通','04559833067248352.jpg',229,127,'a:10:{s:10:\"buyer_name\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"497\";s:3:\"top\";s:2:\"99\";s:5:\"width\";s:3:\"100\";s:6:\"height\";s:2:\"20\";}s:10:\"buyer_area\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"492\";s:3:\"top\";s:3:\"165\";s:5:\"width\";s:3:\"191\";s:6:\"height\";s:2:\"20\";}s:13:\"buyer_address\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"426\";s:3:\"top\";s:3:\"200\";s:5:\"width\";s:3:\"322\";s:6:\"height\";s:2:\"20\";}s:12:\"buyer_mobile\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"551\";s:3:\"top\";s:3:\"235\";s:5:\"width\";s:3:\"122\";s:6:\"height\";s:2:\"20\";}s:11:\"buyer_phone\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"688\";s:3:\"top\";s:3:\"236\";s:5:\"width\";s:3:\"100\";s:6:\"height\";s:2:\"20\";}s:11:\"seller_name\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"132\";s:3:\"top\";s:3:\"100\";s:5:\"width\";s:3:\"100\";s:6:\"height\";s:2:\"20\";}s:11:\"seller_area\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"125\";s:3:\"top\";s:3:\"169\";s:5:\"width\";s:3:\"218\";s:6:\"height\";s:2:\"20\";}s:14:\"seller_address\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:2:\"68\";s:3:\"top\";s:3:\"208\";s:5:\"width\";s:3:\"100\";s:6:\"height\";s:2:\"20\";}s:12:\"seller_phone\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"171\";s:3:\"top\";s:3:\"238\";s:5:\"width\";s:3:\"159\";s:6:\"height\";s:2:\"20\";}s:14:\"seller_company\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"140\";s:3:\"top\";s:3:\"136\";s:5:\"width\";s:3:\"217\";s:6:\"height\";s:2:\"20\";}}',1,-3,-5,28,'申通快递',0),(3,'顺风','04559894766651678.jpg',216,139,'a:10:{s:10:\"buyer_name\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"302\";s:3:\"top\";s:3:\"290\";s:5:\"width\";s:3:\"100\";s:6:\"height\";s:2:\"20\";}s:10:\"buyer_area\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"101\";s:3:\"top\";s:3:\"317\";s:5:\"width\";s:3:\"100\";s:6:\"height\";s:2:\"20\";}s:13:\"buyer_address\";a:4:{s:4:\"left\";s:1:\"0\";s:3:\"top\";s:1:\"0\";s:5:\"width\";s:1:\"0\";s:6:\"height\";s:1:\"0\";}s:12:\"buyer_mobile\";a:4:{s:4:\"left\";s:1:\"0\";s:3:\"top\";s:1:\"0\";s:5:\"width\";s:1:\"0\";s:6:\"height\";s:1:\"0\";}s:11:\"buyer_phone\";a:4:{s:4:\"left\";s:1:\"0\";s:3:\"top\";s:1:\"0\";s:5:\"width\";s:1:\"0\";s:6:\"height\";s:1:\"0\";}s:11:\"seller_name\";a:4:{s:4:\"left\";s:1:\"0\";s:3:\"top\";s:1:\"0\";s:5:\"width\";s:1:\"0\";s:6:\"height\";s:1:\"0\";}s:11:\"seller_area\";a:4:{s:4:\"left\";s:1:\"0\";s:3:\"top\";s:1:\"0\";s:5:\"width\";s:1:\"0\";s:6:\"height\";s:1:\"0\";}s:14:\"seller_address\";a:4:{s:4:\"left\";s:1:\"0\";s:3:\"top\";s:1:\"0\";s:5:\"width\";s:1:\"0\";s:6:\"height\";s:1:\"0\";}s:12:\"seller_phone\";a:4:{s:4:\"left\";s:1:\"0\";s:3:\"top\";s:1:\"0\";s:5:\"width\";s:1:\"0\";s:6:\"height\";s:1:\"0\";}s:14:\"seller_company\";a:4:{s:4:\"left\";s:1:\"0\";s:3:\"top\";s:1:\"0\";s:5:\"width\";s:1:\"0\";s:6:\"height\";s:1:\"0\";}}',1,-4,-5,29,'顺丰快递',0),(4,'圆通速递','04577145745163834.jpg',229,127,'a:10:{s:10:\"buyer_name\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"471\";s:3:\"top\";s:3:\"105\";s:5:\"width\";s:3:\"179\";s:6:\"height\";s:2:\"20\";}s:10:\"buyer_area\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"469\";s:3:\"top\";s:3:\"144\";s:5:\"width\";s:3:\"242\";s:6:\"height\";s:2:\"20\";}s:13:\"buyer_address\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"419\";s:3:\"top\";s:3:\"173\";s:5:\"width\";s:3:\"343\";s:6:\"height\";s:2:\"20\";}s:12:\"buyer_mobile\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"507\";s:3:\"top\";s:3:\"201\";s:5:\"width\";s:2:\"93\";s:6:\"height\";s:2:\"20\";}s:11:\"buyer_phone\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"613\";s:3:\"top\";s:3:\"198\";s:5:\"width\";s:3:\"109\";s:6:\"height\";s:2:\"20\";}s:11:\"seller_name\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"116\";s:3:\"top\";s:3:\"104\";s:5:\"width\";s:3:\"100\";s:6:\"height\";s:2:\"20\";}s:11:\"seller_area\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"110\";s:3:\"top\";s:3:\"144\";s:5:\"width\";s:3:\"148\";s:6:\"height\";s:2:\"20\";}s:14:\"seller_address\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:2:\"63\";s:3:\"top\";s:3:\"169\";s:5:\"width\";s:3:\"323\";s:6:\"height\";s:2:\"20\";}s:12:\"seller_phone\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"151\";s:3:\"top\";s:3:\"195\";s:5:\"width\";s:3:\"139\";s:6:\"height\";s:2:\"20\";}s:14:\"seller_company\";a:5:{s:5:\"check\";s:2:\"on\";s:4:\"left\";s:3:\"109\";s:3:\"top\";s:3:\"123\";s:5:\"width\";s:3:\"271\";s:6:\"height\";s:2:\"12\";}}',1,-3,-5,40,'圆通快递',0);

/*Table structure for table `feiwa_web` */

DROP TABLE IF EXISTS `feiwa_web`;

CREATE TABLE `feiwa_web` (
  `web_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模块ID',
  `web_name` varchar(20) DEFAULT '' COMMENT '模块名称',
  `style_name` varchar(20) DEFAULT 'orange' COMMENT '风格名称',
  `web_page` varchar(10) DEFAULT 'index' COMMENT '所在页面(暂时只有index)',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `web_sort` tinyint(1) unsigned DEFAULT '9' COMMENT '排序',
  `web_show` tinyint(1) unsigned DEFAULT '1' COMMENT '是否显示，0为否，1为是，默认为1',
  `web_html` text COMMENT '模块html代码',
  PRIMARY KEY (`web_id`)
) ENGINE=InnoDB AUTO_INCREMENT=611 DEFAULT CHARSET=utf8 COMMENT='页面模块表';

/*Data for the table `feiwa_web` */

insert  into `feiwa_web`(`web_id`,`web_name`,`style_name`,`web_page`,`update_time`,`web_sort`,`web_show`,`web_html`) values (1,'个护美妆','pink','index',1532081522,1,1,'<div class=\"wrapper zoom bodyParts hoverTab pink\"><div class=\"wrapper partTit\"><span><em class=\"ft31\"><a href=\"javascript:void(0)\" target=\"_blank\">婴儿用品</a></em><i class=\"eng\">2F</i></span><div class=\"tabCont\">   <a href=\"javascript:void(0)\" class=\"now\" target=\"_blank\">商品推荐</a>   </div></div>  <div class=\"floor-main\"><div class=\"side feiwa-left\"> <a class=\"side-img\" href=\"http://malltest.mywopop.com/mall\" target=\"_blank\" title=\"\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/editor/web-1-13.jpg?351\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></a> <ul class=\"entrances\">  <li> <a href=\"http://malltest.mywopop.com/mall\" target=\"_blank\" style=\"color:\"> <i class=\"ng-iconfont\"></i> <em>玩具</em>  </a> </li>  <li> <a href=\"http://malltest.mywopop.com/mall\" target=\"_blank\" style=\"color:\"> <i class=\"ng-iconfont\"></i> <em>塑料制品</em> </a> </li> <li>  <a href=\"http://malltest.mywopop.com/mall\" target=\"_blank\" style=\"color:\"> <i class=\"ng-iconfont\"></i> <em>家居饰品</em> </a> </li> </ul>  <div class=\"hot-word\"> <div>   <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1078\" title=\"玩具\" target=\"_blank\">玩具</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1079\" title=\"箱包\" target=\"_blank\">箱包</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1080\" title=\"腰带\" target=\"_blank\">腰带</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1081\" title=\"玉器\" target=\"_blank\">玉器</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1082\" title=\"头饰\" target=\"_blank\">头饰</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1083\" title=\"花卉\" target=\"_blank\">花卉</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1084\" title=\"工艺品\" target=\"_blank\">工艺品</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1085\" title=\"十字绣\" target=\"_blank\">十字绣</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1086\" title=\"钟表\" target=\"_blank\">钟表</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1087\" title=\"雨具泳具\" target=\"_blank\">雨具泳具</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1088\" title=\"化妆品\" target=\"_blank\">化妆品</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1089\" title=\"假发\" target=\"_blank\">假发</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1090\" title=\"帽子\" target=\"_blank\">帽子</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1091\" title=\"围巾\" target=\"_blank\">围巾</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1092\" title=\"文体\" target=\"_blank\">文体</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1093\" title=\"办公用品\" target=\"_blank\">办公用品</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1094\" title=\"塑料制品\" target=\"_blank\">塑料制品</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1095\" title=\"家居饰品\" target=\"_blank\">家居饰品</a>  </div> </div><div class=\"floor-brand\"><ul>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=302\" title=\"妈咪宝贝\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399884799920935_sm.jpg\" alt=\"妈咪宝贝\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=269\" title=\"美赞臣\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399878617014779_sm.jpg\" alt=\"美赞臣\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=286\" title=\"帮宝适\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399882134949479_sm.jpg\" alt=\"帮宝适\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=271\" title=\"多美\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399878980307860_sm.jpg\" alt=\"多美\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=300\" title=\"好孩子\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399884512865285_sm.jpg\" alt=\"好孩子\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=298\" title=\"亨氏\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399884182772511_sm.jpg\" alt=\"亨氏\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a> </li> 	</ul>   </div> </div>	  	 <div class=\"hoverCont\" style=\" display: block;\"> <ul class=\" boxItem1 \"> <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100271\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791027630963566_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"贝亲（Pigeon）婴儿训练牙刷三阶段-绿色+黄色\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100271\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">贝亲（Pigeon）婴儿训练牙刷三阶段-绿色+黄色</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;39.00</span>  <del>&yen;40.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 贝亲（Pigeon）婴儿训练牙刷三阶段-绿色+黄色</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100270\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791027257195652_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"易简（yijian)婴儿童理发器 宝宝剃头器\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100270\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">易简（yijian)婴儿童理发器 宝宝剃头器</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;99.00</span>  <del>&yen;129.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 易简（yijian)婴儿童理发器 宝宝剃头器</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100267\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791025690171066_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"世纪宝贝babyhood 淘气鸭儿童坐便器\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100267\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">世纪宝贝babyhood 淘气鸭儿童坐便器</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;68.00</span>  <del>&yen;72.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 世纪宝贝babyhood 淘气鸭儿童坐便器</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100263\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791023787756095_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"新贝 电动吸奶器\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100263\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">新贝 电动吸奶器</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;225.00</span>  <del>&yen;230.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 新贝 电动吸奶器</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100251\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791018360977876_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"花王（Merries）纸尿裤 S82片 小号尿不湿（4-8kg）\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100251\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">花王（Merries）纸尿裤 S82片 小号尿不湿（4-8kg）</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;95.00</span>  <del>&yen;100.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 花王（Merries）纸尿裤 S82片 小号尿不湿（4-8kg）</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100274\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791029019677006_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"宝宝汽车儿童安全座椅isofix接口\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100274\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">宝宝汽车儿童安全座椅isofix接口</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;2880.00</span>  <del>&yen;3000.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 宝宝汽车儿童安全座椅isofix接口</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100273\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791028521571841_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"好孩子多功能婴儿推车A513-B-L148 蓝色\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100273\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">好孩子多功能婴儿推车A513-B-L148 蓝色</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;479.00</span>  <del>&yen;500.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 好孩子多功能婴儿推车A513-B-L148 蓝色</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100268\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791026144289680_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"贝亲（Pigeon）婴儿护臀膏 35g IA149\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100268\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">贝亲（Pigeon）婴儿护臀膏 35g IA149</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;29.00</span>  <del>&yen;32.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 贝亲（Pigeon）婴儿护臀膏 35g IA149</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  </ul> </div>  </div>  \r\n        <!--floor-bottom--><div class=\"floor-bottom\">\r\n	  </div><!--floor-bottom-->\r\n        </div>'),(2,'生活电器1','pink','index',1532081522,2,1,'<div class=\"wrapper zoom bodyParts hoverTab pink\"><div class=\"wrapper partTit\"><span><em class=\"ft31\"><a href=\"javascript:void(0)\" target=\"_blank\">服装</a></em><i class=\"eng\">3F</i></span><div class=\"tabCont\">   <a href=\"javascript:void(0)\" class=\"now\" target=\"_blank\">商品推荐</a>   </div></div>  <div class=\"floor-main\"><div class=\"side feiwa-left\"> <a class=\"side-img\" href=\"http://101.226.179.113/mall\" target=\"_blank\" title=\"\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/editor/web-2-23.jpg?185\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></a> <ul class=\"entrances\">  <li> <a href=\"http://101.226.179.113/mall\" target=\"_blank\" style=\"color:\"> <i class=\"ng-iconfont\"></i> <em></em>  </a> </li>  <li> <a href=\"http://101.226.179.113/mall\" target=\"_blank\" style=\"color:\"> <i class=\"ng-iconfont\"></i> <em></em> </a> </li> <li>  <a href=\"\" target=\"_blank\" style=\"color:\"> <i class=\"ng-iconfont\"></i> <em></em> </a> </li> </ul>  <div class=\"hot-word\"> <div>   <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1097\" title=\"服装\" target=\"_blank\">服装</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1098\" title=\"童鞋\" target=\"_blank\">童鞋</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1099\" title=\"成人鞋\" target=\"_blank\">成人鞋</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1100\" title=\"内衣\" target=\"_blank\">内衣</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1101\" title=\"袜子\" target=\"_blank\">袜子</a>  </div> </div><div class=\"floor-brand\"><ul>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=302\" title=\"妈咪宝贝\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399884799920935_sm.jpg\" alt=\"妈咪宝贝\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=301\" title=\"婴姿坊\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399884644632532_sm.jpg\" alt=\"婴姿坊\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=300\" title=\"好孩子\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399884512865285_sm.jpg\" alt=\"好孩子\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=299\" title=\"十月妈咪\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399884360526483_sm.jpg\" alt=\"十月妈咪\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=286\" title=\"帮宝适\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399882134949479_sm.jpg\" alt=\"帮宝适\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=280\" title=\"宝贝第一\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399880757446523_sm.jpg\" alt=\"宝贝第一\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a> </li><li><a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=273\" title=\"孩之宝\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399879573077116_sm.jpg\" alt=\"孩之宝\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=271\" title=\"多美\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399878980307860_sm.jpg\" alt=\"多美\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=270\" title=\"好奇\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399878791943342_sm.jpg\" alt=\"好奇\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a> </li> 	</ul>   </div> </div>	  	 <div class=\"hoverCont\" style=\" display: block;\"> <ul class=\" boxItem1 \"> <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100275\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791069315571320_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"婧麒 JOYNCLEON 防辐射服吊带\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100275\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">婧麒 JOYNCLEON 防辐射服吊带</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;458.00</span>  <del>&yen;500.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 婧麒 JOYNCLEON 防辐射服吊带</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100277\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791071936832202_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"婧麒（JOYNCLEON） 防辐射服春夏季吊带银纤维马甲孕妇\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100277\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">婧麒（JOYNCLEON） 防辐射服春夏季吊带银纤维马甲孕妇</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;428.00</span>  <del>&yen;438.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 婧麒（JOYNCLEON） 防辐射服春夏季吊带银纤维马甲孕妇</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100276\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791071572119235_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"婧麒孕妇防辐射服孕妇装银纤维吊带四季款\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100276\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">婧麒孕妇防辐射服孕妇装银纤维吊带四季款</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;418.00</span>  <del>&yen;428.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 婧麒孕妇防辐射服孕妇装银纤维吊带四季款</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100279\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791073806963100_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"婴儿脚包学步脚包新生儿四季护脚鞋\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100279\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">婴儿脚包学步脚包新生儿四季护脚鞋</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;29.00</span>  <del>&yen;32.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 婴儿脚包学步脚包新生儿四季护脚鞋</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100280\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791074892100454_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"小红豆女童吊带背心棉夏季薄款\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100280\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">小红豆女童吊带背心棉夏季薄款</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;25.00</span>  <del>&yen;28.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 小红豆女童吊带背心棉夏季薄款</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100281\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791075928721239_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"儿童内裤纯棉平角男女童内裤4条装\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100281\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">儿童内裤纯棉平角男女童内裤4条装</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;46.00</span>  <del>&yen;58.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 儿童内裤纯棉平角男女童内裤4条装</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100282\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791076612318931_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"男短袜春夏季防脱运动船袜男士纯棉\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100282\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">男短袜春夏季防脱运动船袜男士纯棉</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;29.00</span>  <del>&yen;32.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 男短袜春夏季防脱运动船袜男士纯棉</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100284\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791094837636994_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"毛毛虫儿童运动鞋 海浪蓝\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100284\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">毛毛虫儿童运动鞋 海浪蓝</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;129.00</span>  <del>&yen;136.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 毛毛虫儿童运动鞋 海浪蓝</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  </ul> </div>  </div>  \r\n        <!--floor-bottom--><div class=\"floor-bottom\">\r\n	  </div><!--floor-bottom-->\r\n        </div>'),(3,'运动健康','pink','index',1532081522,3,1,'<div class=\"wrapper zoom bodyParts hoverTab pink\"><div class=\"wrapper partTit\"><span><em class=\"ft31\"><a href=\"javascript:void(0)\" target=\"_blank\">运动健康</a></em><i class=\"eng\">4F</i></span><div class=\"tabCont\">   <a href=\"javascript:void(0)\" class=\"now\" target=\"_blank\">商品推荐</a>   </div></div>  <div class=\"floor-main\"><div class=\"side feiwa-left\"> <a class=\"side-img\" href=\"http://101.226.179.113/mall\" target=\"_blank\" title=\"\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/editor/web-3-33.jpg?896\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></a> <ul class=\"entrances\">  <li> <a href=\"http://101.226.179.113/mall\" target=\"_blank\" style=\"color:\"> <i class=\"ng-iconfont\"></i> <em></em>  </a> </li>  <li> <a href=\"http://101.226.179.113/mall\" target=\"_blank\" style=\"color:\"> <i class=\"ng-iconfont\"></i> <em></em> </a> </li> <li>  <a href=\"\" target=\"_blank\" style=\"color:\"> <i class=\"ng-iconfont\"></i> <em></em> </a> </li> </ul>  <div class=\"hot-word\"> <div>   <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1102\" title=\"童装\" target=\"_blank\">童装</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&ops=index&cate_id=1103\" title=\"育婴用品\" target=\"_blank\">育婴用品</a>  </div> </div><div class=\"floor-brand\"><ul>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=268\" title=\"lala布书\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399878481448839_sm.jpg\" alt=\"lala布书\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=270\" title=\"好奇\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399878791943342_sm.jpg\" alt=\"好奇\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=274\" title=\"嗳呵\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399879712252398_sm.jpg\" alt=\"嗳呵\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=277\" title=\"芭比\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399880244694286_sm.jpg\" alt=\"芭比\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=280\" title=\"宝贝第一\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399880757446523_sm.jpg\" alt=\"宝贝第一\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=275\" title=\"美斯特伦\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399879861821747_sm.jpg\" alt=\"美斯特伦\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a> </li><li><a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=281\" title=\"强生\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399880892528550_sm.jpg\" alt=\"强生\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=286\" title=\"帮宝适\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399882134949479_sm.jpg\" alt=\"帮宝适\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=289\" title=\"十月天使\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399882581513663_sm.jpg\" alt=\"十月天使\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&ops=list&brand=292\" title=\"布朗博士\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399883157641690_sm.jpg\" alt=\"布朗博士\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a> </li> 	</ul>   </div> </div>	  	 <div class=\"hoverCont\" style=\" display: block;\"> <ul class=\" boxItem1 \"> <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100259\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791021959746394_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"象宝宝（elepbaby）宝宝吃饭罩衣 婴儿围兜\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100259\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">象宝宝（elepbaby）宝宝吃饭罩衣 婴儿围兜</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;29.00</span>  <del>&yen;32.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 象宝宝（elepbaby）宝宝吃饭罩衣 婴儿围兜</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100265\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791024667273344_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"日康婴儿浴盆 洗澡盆 大号带躺板\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100265\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">日康婴儿浴盆 洗澡盆 大号带躺板</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;96.00</span>  <del>&yen;100.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 日康婴儿浴盆 洗澡盆 大号带躺板</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100263\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791023787756095_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"新贝 电动吸奶器\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100263\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">新贝 电动吸奶器</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;225.00</span>  <del>&yen;230.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 新贝 电动吸奶器</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100262\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791023313047855_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"小白熊 （Snow Bear）婴儿辅食机\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100262\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">小白熊 （Snow Bear）婴儿辅食机</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;299.00</span>  <del>&yen;310.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 小白熊 （Snow Bear）婴儿辅食机</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100261\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791022845352222_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"小白熊 (Snow Bear) 婴儿奶瓶蒸汽消毒器带烘干\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100261\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">小白熊 (Snow Bear) 婴儿奶瓶蒸汽消毒器带烘干</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;269.00</span>  <del>&yen;288.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 小白熊 (Snow Bear) 婴儿奶瓶蒸汽消毒器带烘干</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100260\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791022372517357_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"飞利浦 新安怡（AVENT）七安士卡通吸管杯\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100260\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">飞利浦 新安怡（AVENT）七安士卡通吸管杯</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;59.00</span>  <del>&yen;65.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 飞利浦 新安怡（AVENT）七安士卡通吸管杯</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100258\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791021557730356_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"贝亲（Pigeon）独立开口三层奶粉盒 CA07\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100258\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">贝亲（Pigeon）独立开口三层奶粉盒 CA07</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;54.60</span>  <del>&yen;62.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 贝亲（Pigeon）独立开口三层奶粉盒 CA07</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100256\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791020695050816_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"飞利浦新安怡 英国进口 AVENT 时尚安抚奶嘴6-18个月\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100256\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">飞利浦新安怡 英国进口 AVENT 时尚安抚奶嘴6-18个月</p> <p class=\"infoTit2\"><span class=\"pink\">&yen;56.00</span>  <del>&yen;60.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 飞利浦新安怡 英国进口 AVENT 时尚安抚奶嘴6-18个月</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  </ul> </div>  </div>  \r\n        <!--floor-bottom--><div class=\"floor-bottom\">\r\n	  </div><!--floor-bottom-->\r\n        </div>'),(4,'装备展示','green','index',1525766003,4,0,'<div class=\"wrapper zoom bodyParts hoverTab green\"><div class=\"wrapper partTit\"><span><em class=\"ft31\"><a href=\"javascript:void(0)\" target=\"_blank\">家居用品</a></em><i class=\"eng\">4F</i></span><div class=\"tabCont\">   <a href=\"javascript:void(0)\" class=\"now\" target=\"_blank\">商品推荐</a>   </div></div>  <div class=\"floor-main\"><div class=\"side feiwa-left\"> <a class=\"side-img\" href=\"http://101.226.179.113/mall\" target=\"_blank\" title=\"\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/editor/web-4-43.jpg?335\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></a> <ul class=\"entrances\">  <li> <a href=\"http://101.226.179.113/mall\" target=\"_blank\" style=\"color:\"> <i class=\"ng-iconfont\"></i> <em></em>  </a> </li>  <li> <a href=\"http://101.226.179.113/mall\" target=\"_blank\" style=\"color:\"> <i class=\"ng-iconfont\"></i> <em></em> </a> </li> <li>  <a href=\"\" target=\"_blank\" style=\"color:\"> <i class=\"ng-iconfont\"></i> <em></em> </a> </li> </ul>  <div class=\"hot-word\"> <div>   <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=200\" title=\"家纺\" target=\"_blank\">家纺</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=201\" title=\"灯具\" target=\"_blank\">灯具</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=202\" title=\"生活日用\" target=\"_blank\">生活日用</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=203\" title=\"家装软饰\" target=\"_blank\">家装软饰</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=204\" title=\"清洁日用\" target=\"_blank\">清洁日用</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=205\" title=\"宠物生活\" target=\"_blank\">宠物生活</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=228\" title=\"收纳用品\" target=\"_blank\">收纳用品</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=229\" title=\"雨伞雨具\" target=\"_blank\">雨伞雨具</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=230\" title=\"浴室用品\" target=\"_blank\">浴室用品</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=231\" title=\"缝纫用品\" target=\"_blank\">缝纫用品</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=232\" title=\"洗晒用品\" target=\"_blank\">洗晒用品</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=233\" title=\"净化除味\" target=\"_blank\">净化除味</a>  </div> </div><div class=\"floor-brand\"><ul>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=313\" title=\"皮克朋\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399891285897466_sm.jpg\" alt=\"皮克朋\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=312\" title=\"乔山\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399891122713199_sm.jpg\" alt=\"乔山\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=314\" title=\"捷安特\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399891438458842_sm.jpg\" alt=\"捷安特\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=315\" title=\"开普特\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399891598799644_sm.jpg\" alt=\"开普特\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=305\" title=\"悠度\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399889744222357_sm.jpg\" alt=\"悠度\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=309\" title=\"诺可文\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399890643925803_sm.jpg\" alt=\"诺可文\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a> </li><li><a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=310\" title=\"艾威\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399890796771131_sm.jpg\" alt=\"艾威\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=307\" title=\"远洋瑜伽\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399890266352034_sm.jpg\" alt=\"远洋瑜伽\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=306\" title=\"威尔胜\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399889941968796_sm.jpg\" alt=\"威尔胜\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=304\" title=\"世达球\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399889410183423_sm.jpg\" alt=\"世达球\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a> </li> 	</ul>   </div> </div>	  	 <div class=\"hoverCont\" style=\" display: block;\"> <ul class=\" boxItem1 \"> <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100204\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05641565630344137_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"户外木炭烧烤架\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100204\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">户外木炭烧烤架</p> <p class=\"infoTit2\"><span class=\"pink\">￥239.00</span>  <del>￥258.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 户外专用 搪瓷烧烤架</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100205\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05641566209296142_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"防风防雨露营野营液压\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100205\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">防风防雨露营野营液压</p> <p class=\"infoTit2\"><span class=\"pink\">￥261.00</span>  <del>￥280.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 升级液压款 防水防晒</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100206\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05641566843466734_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"无烟碳 户外易燃碳\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100206\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">无烟碳 户外易燃碳</p> <p class=\"infoTit2\"><span class=\"pink\">￥40.00</span>  <del>￥48.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 无烟环保 持久耐烧 纯天然原</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100211\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05641569264724588_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"男女包 双肩包 背包\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100211\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">男女包 双肩包 背包</p> <p class=\"infoTit2\"><span class=\"pink\">￥159.00</span>  <del>￥168.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 双肩背包 运动包</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100210\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05641568866716301_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"背包旅行包 运动包正\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100210\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">背包旅行包 运动包正</p> <p class=\"infoTit2\"><span class=\"pink\">￥219.00</span>  <del>￥240.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 双拉链主袋 放15寸电脑 加厚肩</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100209\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05641568388466262_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"便携式户外折叠桌椅套\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100209\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">便携式户外折叠桌椅套</p> <p class=\"infoTit2\"><span class=\"pink\">￥188.00</span>  <del>￥200.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 灵活轻便 稳固耐用 收纳轻松</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100208\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05641567819547594_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"野营餐具套装 烧烤\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100208\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">野营餐具套装 烧烤</p> <p class=\"infoTit2\"><span class=\"pink\">￥231.00</span>  <del>￥248.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 源自德国 复古风野餐蓝 户外休</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100207\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05641567266828474_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"户外便携式火炉 防风\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100207\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">户外便携式火炉 防风</p> <p class=\"infoTit2\"><span class=\"pink\">￥396.00</span>  <del>￥420.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 纯蓝火焰 熄火保护 拒绝气体泄</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  </ul> </div>  </div>  \r\n        <!--floor-bottom--><div class=\"floor-bottom\">\r\n	  </div><!--floor-bottom-->\r\n        </div>'),(5,'数码产品','blue','index',1525405515,5,0,'<div class=\"wrapper zoom bodyParts hoverTab blue\"><div class=\"wrapper partTit\"><span><em class=\"ft31\"><a href=\"javascript:void(0)\" target=\"_blank\">数码产品</a></em><i class=\"eng\">5F</i></span><div class=\"tabCont\">   <a href=\"javascript:void(0)\" class=\"now\" target=\"_blank\">商品推荐</a>   </div></div>  <div class=\"floor-main\"><div class=\"side feiwa-left\"> <a class=\"side-img\" href=\"http://101.226.179.113/mall\" target=\"_blank\" title=\"\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/editor/web-5-53.jpg?354\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></a> <ul class=\"entrances\">  <li> <a href=\"http://101.226.179.113/mall\" target=\"_blank\" style=\"color:\"> <i class=\"ng-iconfont\"></i> <em></em>  </a> </li>  <li> <a href=\"http://101.226.179.113/mall\" target=\"_blank\" style=\"color:\"> <i class=\"ng-iconfont\"></i> <em></em> </a> </li> <li>  <a href=\"\" target=\"_blank\" style=\"color:\"> <i class=\"ng-iconfont\"></i> <em></em> </a> </li> </ul>  <div class=\"hot-word\"> <div>   <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=258\" title=\"手机配件\" target=\"_blank\">手机配件</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=259\" title=\"摄影摄像\" target=\"_blank\">摄影摄像</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=260\" title=\"数码配件\" target=\"_blank\">数码配件</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=261\" title=\"时尚影音\" target=\"_blank\">时尚影音</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=390\" title=\"电脑整机\" target=\"_blank\">电脑整机</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=391\" title=\"电脑配件\" target=\"_blank\">电脑配件</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=392\" title=\"外设产品\" target=\"_blank\">外设产品</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=393\" title=\"网络产品\" target=\"_blank\">网络产品</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=394\" title=\"办公打印\" target=\"_blank\">办公打印</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=395\" title=\"办公文仪\" target=\"_blank\">办公文仪</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=1034\" title=\"手机通讯\" target=\"_blank\">手机通讯</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=406\" title=\"CPU\" target=\"_blank\">CPU</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=407\" title=\"主板\" target=\"_blank\">主板</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=408\" title=\"显卡\" target=\"_blank\">显卡</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=409\" title=\"硬盘\" target=\"_blank\">硬盘</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=410\" title=\"SSD固态硬盘\" target=\"_blank\">SSD固态硬盘</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=411\" title=\"内存\" target=\"_blank\">内存</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=412\" title=\"机箱\" target=\"_blank\">机箱</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=413\" title=\"电源\" target=\"_blank\">电源</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=414\" title=\"显示器\" target=\"_blank\">显示器</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=415\" title=\"刻录机/光驱\" target=\"_blank\">刻录机/光驱</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=416\" title=\"散热器\" target=\"_blank\">散热器</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=417\" title=\"声卡/扩展卡\" target=\"_blank\">声卡/扩展卡</a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=search&feiwa=index&cate_id=418\" title=\"装机配件\" target=\"_blank\">装机配件</a>  </div> </div><div class=\"floor-brand\"><ul>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=239\" title=\"LG\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399838782976323_sm.jpg\" alt=\"LG\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=238\" title=\"奥克斯\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399838633002147_sm.jpg\" alt=\"奥克斯\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=237\" title=\"老板\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399838473427197_sm.jpg\" alt=\"老板\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=232\" title=\"三星电器\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399836619819860_sm.jpg\" alt=\"三星电器\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=236\" title=\"博世\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04399838243363042_sm.jpg\" alt=\"博世\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=209\" title=\"理光\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04398160857676307_sm.gif\" alt=\"理光\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a> </li><li><a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=211\" title=\"阿尔卡特\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04398161143888870_sm.jpg\" alt=\"阿尔卡特\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=201\" title=\"松下\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04398159595550035_sm.jpg\" alt=\"松下\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=205\" title=\"romoss\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04398160187629402_sm.jpg\" alt=\"romoss\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=brand&feiwa=list&brand=204\" title=\"北通\" target=\"_blank\"><img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/brand/04398160061664664_sm.jpg\" alt=\"北通\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"></a> </li> 	</ul>   </div> </div>	  	 <div class=\"hoverCont\" style=\" display: block;\"> <ul class=\" boxItem1 \"> <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100221\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05641607118761159_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"运动摄像机\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100221\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">运动摄像机</p> <p class=\"infoTit2\"><span class=\"pink\">￥6000.00</span>  <del>￥6200.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 运动摄像机</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100220\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05641606730414492_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"运动摄像机\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100220\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">运动摄像机</p> <p class=\"infoTit2\"><span class=\"pink\">￥4666.00</span>  <del>￥4999.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 运动摄像机</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100219\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05641606281269303_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"运动摄像机\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100219\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">运动摄像机</p> <p class=\"infoTit2\"><span class=\"pink\">￥4600.00</span>  <del>￥4800.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 运动摄像机</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100218\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05641605782639771_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"运动摄像机\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100218\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">运动摄像机</p> <p class=\"infoTit2\"><span class=\"pink\">￥5100.00</span>  <del>￥5200.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 运动摄像机</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100217\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05641605425045738_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"运动摄像机\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100217\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">运动摄像机</p> <p class=\"infoTit2\"><span class=\"pink\">￥4800.00</span>  <del>￥5000.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 运动摄像机</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100216\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05641604980372834_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"运动摄像机\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100216\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">运动摄像机</p> <p class=\"infoTit2\"><span class=\"pink\">￥5250.00</span>  <del>￥5500.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 运动摄像机</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100215\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05641604498445569_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"运动摄像机\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100215\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">运动摄像机</p> <p class=\"infoTit2\"><span class=\"pink\">￥5200.00</span>  <del>￥5400.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 运动摄像机</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  <li>  <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100214\" class=\"infoImg\" target=\"_blank\"> <img feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05641603045751101_240.jpg\" rel=\"lazy\" src=\"http://malltest.mywopop.com/mall/img/loading.gif\"  alt=\"运动相机\"> </a> <a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&feiwa=index&goods_id=100214\" class=\"infoTxt\" target=\"_blank\"> <div class=\"babyInfo\"> <p class=\"infoTit1\">运动相机</p> <p class=\"infoTit2\"><span class=\"pink\">￥4799.00</span>  <del>￥5000.00</del></p></div><div class=\"hosInfo\"> <p class=\"infoTit1\"> 又名：数字式相机。</p><p class=\"infoTit2 zoom\"> <span class=\"feiwa-right\">立即购买</span></p></div></a> </li>  </ul> </div>  </div>  \r\n        <!--floor-bottom--><div class=\"floor-bottom\">\r\n	  </div><!--floor-bottom-->\r\n        </div>'),(6,'紫色','purple','index',1525405508,6,0,'<div class=\"wrapper zoom bodyParts hoverTab purple\"><div class=\"wrapper partTit\">	<div class=\"pic-type\"><img src=\"http://malltest.mywopop.com/data/upload/\"/></div><div class=\"tabCont\">   </div></div>  <div class=\"floor-main\"><div class=\"side feiwa-left\">  <div class=\"hot-word\"> <div>  </div> </div><div class=\"floor-brand\"><ul> 	</ul>   </div> </div>	  </div>  \r\n        <!--floor-bottom--><div class=\"floor-bottom\">\r\n	  </div><!--floor-bottom-->\r\n        </div>'),(7,'褐色','brown','index',1525405502,7,0,'<div class=\"wrapper zoom bodyParts hoverTab brown\"><div class=\"wrapper partTit\">	<div class=\"pic-type\"><img src=\"http://malltest.mywopop.com/data/upload/\"/></div><div class=\"tabCont\">   </div></div>  <div class=\"floor-main\"><div class=\"side feiwa-left\">  <div class=\"hot-word\"> <div>  </div> </div><div class=\"floor-brand\"><ul> 	</ul>   </div> </div>	  </div>  \r\n        <!--floor-bottom--><div class=\"floor-bottom\">\r\n	  </div><!--floor-bottom-->\r\n        </div>'),(8,'默认','default','index',1525405494,8,0,'<div class=\"wrapper zoom bodyParts hoverTab default\"><div class=\"wrapper partTit\">	<div class=\"pic-type\"><img src=\"http://malltest.mywopop.com/data/upload/\"/></div><div class=\"tabCont\">   </div></div>  <div class=\"floor-main\"><div class=\"side feiwa-left\">  <div class=\"hot-word\"> <div>  </div> </div><div class=\"floor-brand\"><ul> 	</ul>   </div> </div>	  </div>  \r\n        <!--floor-bottom--><div class=\"floor-bottom\">\r\n	  </div><!--floor-bottom-->\r\n        </div>'),(101,'首页头部焦点图片','orange','index_pic',1532081522,100,1,'    <ul class=\"bannerImg inner\">\r\n    	                               <li style=\"display: block;; background: ;\" class=\"\">\r\n            <a href=\"\" target=\"_blank\"><img alt=\"\" feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/editor/web-101-101-2.jpg?841\" style=\"display:block\" rel=\'lazy\' src=\"http://malltest.mywopop.com/mall/img/loading.gif\" title=\"\"></a>\r\n                        	         </li>                              <li style=\"display: none;; background: ;\" class=\"\">\r\n            <a href=\"\" target=\"_blank\"><img alt=\"\" feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/editor/web-101-101-1.jpg?337\" style=\"display:block\" rel=\'lazy\' src=\"http://malltest.mywopop.com/mall/img/loading.gif\" title=\"\"></a>\r\n                        	         </li>                     \r\n            </ul>\r\n    <div class=\"tabIcon\">\r\n    	                           <span class=\"now\"></span>\r\n                          <span class=\"\"></span>\r\n                                </div>\r\n    <span class=\"feiwa-prev\" style=\"display: none;\"></span>\r\n    <span class=\"feiwa-next\" style=\"display: none;\"></span>\r\n    \r\n  </ul>\r\n  <div class=\"jfocus-trigeminy\">\r\n    <ul>\r\n                              <li>\r\n                                        <a href=\"\" target=\"_blank\" title=\"\">\r\n                <img src=\"http://malltest.mywopop.com/data/upload/mall/editor/web-101-102-2-1.jpg?204\" alt=\"\"></a>\r\n                          <a href=\"\" target=\"_blank\" title=\"\">\r\n                <img src=\"http://malltest.mywopop.com/data/upload/mall/editor/web-101-102-2-2.jpg?576\" alt=\"\"></a>\r\n                          <a href=\"\" target=\"_blank\" title=\"\">\r\n                <img src=\"http://malltest.mywopop.com/data/upload/mall/editor/web-101-102-2-3.jpg?551\" alt=\"\"></a>\r\n                          <a href=\"\" target=\"_blank\" title=\"\">\r\n                <img src=\"http://malltest.mywopop.com/data/upload/mall/editor/web-101-102-2-4.jpg?589\" alt=\"\"></a>\r\n                                      </li>\r\n                        </ul>\r\n  </div>\r\n<script type=\"text/javascript\">\r\n	update_screen_focus();\r\n</script>'),(121,'首页促销区','orange','index_sale',1532081522,120,1,'<div class=\"boxItem2 zoom hoverTab\"><div class=\"tabCont\"> <a target=\"_blank\" href=\"javascript:void(0)\" class=\"now\">品牌特卖</a>  <a target=\"_blank\" href=\"javascript:void(0)\" class=\"\">新品上架</a>  <a target=\"_blank\" href=\"javascript:void(0)\" class=\"\">热评商品</a> </div>  <ul style=\"display: block ;\" class=\"hoverCont \"> <li><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100232\" target=\"_blank\"><p class=\"infoImg\"><img alt=\"美素力（frisolac）金装婴儿配方奶粉 1段（0-6个月婴儿适用）\" feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05790954343413037_240.jpg\" rel=\'lazy\' src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></p> </a><div class=\"feiwa-rt\"><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100232\" target=\"_blank\">  </a><a target=\"_blank\" href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100232\" class=\"infoItem2\">美素力（frisolac）金装婴儿配方奶粉 1段（0-6个月婴儿适用）</a> <p class=\"infoItem3 c999\"></p><p class=\"price pink\"> <i class=\"ft18\">￥</i>  <b class=\"ft20\">400.00</b> </p> </div> </li><li><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100237\" target=\"_blank\"><p class=\"infoImg\"><img alt=\"雅培(Abbott)亲护较大婴儿配方奶粉 2段820克\" feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05790959077707398_240.jpg\" rel=\'lazy\' src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></p> </a><div class=\"feiwa-rt\"><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100237\" target=\"_blank\">  </a><a target=\"_blank\" href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100237\" class=\"infoItem2\">雅培(Abbott)亲护较大婴儿配方奶粉 2段820克</a> <p class=\"infoItem3 c999\">雅培(Abbott)亲护较大婴儿配方奶粉 2段820克</p><p class=\"price pink\"> <i class=\"ft18\">￥</i>  <b class=\"ft20\">222.00</b> </p> </div> </li><li><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100234\" target=\"_blank\"><p class=\"infoImg\"><img alt=\"爱他美卓萃幼儿配方奶粉（12—36月龄，3段）900g\" feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05790956423059031_240.jpg\" rel=\'lazy\' src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></p> </a><div class=\"feiwa-rt\"><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100234\" target=\"_blank\">  </a><a target=\"_blank\" href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100234\" class=\"infoItem2\">爱他美卓萃幼儿配方奶粉（12—36月龄，3段）900g</a> <p class=\"infoItem3 c999\">爱他美卓萃幼儿配方奶粉（12—36月龄，3段）900g</p><p class=\"price pink\"> <i class=\"ft18\">￥</i>  <b class=\"ft20\">400.00</b> </p> </div> </li><li><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100235\" target=\"_blank\"><p class=\"infoImg\"><img alt=\"爱他美卓萃儿童配方调制乳粉（36—72月龄，4段）\" feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05790956949555934_240.jpg\" rel=\'lazy\' src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></p> </a><div class=\"feiwa-rt\"><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100235\" target=\"_blank\">  </a><a target=\"_blank\" href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100235\" class=\"infoItem2\">爱他美卓萃儿童配方调制乳粉（36—72月龄，4段）</a> <p class=\"infoItem3 c999\">爱他美卓萃儿童配方调制乳粉（36—72月龄，4段）</p><p class=\"price pink\"> <i class=\"ft18\">￥</i>  <b class=\"ft20\">400.00</b> </p> </div> </li><li><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100240\" target=\"_blank\"><p class=\"infoImg\"><img alt=\"亨氏 (Heinz) 宝宝辅食 婴儿面条 金装粒粒面－猪肝枸杞 320g\" feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05790961092598660_240.jpg\" rel=\'lazy\' src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></p> </a><div class=\"feiwa-rt\"><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100240\" target=\"_blank\">  </a><a target=\"_blank\" href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100240\" class=\"infoItem2\">亨氏 (Heinz) 宝宝辅食 婴儿面条 金装粒粒面－猪肝枸杞 320g</a> <p class=\"infoItem3 c999\">亨氏 (Heinz) 宝宝辅食 婴儿面条 金装粒粒面－猪肝枸杞 320g</p><p class=\"price pink\"> <i class=\"ft18\">￥</i>  <b class=\"ft20\">39.00</b> </p> </div> </li> </ul> <ul style=\"display: none ;\" class=\"hoverCont \"> <li><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100247\" target=\"_blank\"><p class=\"infoImg\"><img alt=\"衍生小儿七星茶固体饮料（经典装）\" feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791016254193023_240.jpg\" rel=\'lazy\' src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></p> </a><div class=\"feiwa-rt\"><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100247\" target=\"_blank\">  </a><a target=\"_blank\" href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100247\" class=\"infoItem2\">衍生小儿七星茶固体饮料（经典装）</a> <p class=\"infoItem3 c999\">衍生小儿七星茶固体饮料（经典装）</p><p class=\"price pink\"> <i class=\"ft18\">￥</i>  <b class=\"ft20\">75.00</b> </p> </div> </li><li><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100246\" target=\"_blank\"><p class=\"infoImg\"><img alt=\"方广 儿童零食 肉松 钙铁锌猪肉酥肉粉松 100g\" feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791015808970258_240.jpg\" rel=\'lazy\' src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></p> </a><div class=\"feiwa-rt\"><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100246\" target=\"_blank\">  </a><a target=\"_blank\" href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100246\" class=\"infoItem2\">方广 儿童零食 肉松 钙铁锌猪肉酥肉粉松 100g</a> <p class=\"infoItem3 c999\">方广 儿童零食 肉松 钙铁锌猪肉酥肉粉松 100g</p><p class=\"price pink\"> <i class=\"ft18\">￥</i>  <b class=\"ft20\">33.00</b> </p> </div> </li><li><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100245\" target=\"_blank\"><p class=\"infoImg\"><img alt=\"美国童年时光CHILDLIFE钙镁锌婴儿幼儿童补钙宝宝补锌液体钙 6个月以上\" feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791015324909804_240.jpg\" rel=\'lazy\' src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></p> </a><div class=\"feiwa-rt\"><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100245\" target=\"_blank\">  </a><a target=\"_blank\" href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100245\" class=\"infoItem2\">美国童年时光CHILDLIFE钙镁锌婴儿幼儿童补钙宝宝补锌液体钙 6个月以上</a> <p class=\"infoItem3 c999\">美国童年时光CHILDLIFE钙镁锌婴儿幼儿童补钙宝宝补锌液体钙 6个月以上</p><p class=\"price pink\"> <i class=\"ft18\">￥</i>  <b class=\"ft20\">168.00</b> </p> </div> </li><li><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100243\" target=\"_blank\"><p class=\"infoImg\"><img alt=\"合生元（BIOSTIME）儿童益生菌冲剂(益生元)26袋装\" feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791014397640936_240.jpg\" rel=\'lazy\' src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></p> </a><div class=\"feiwa-rt\"><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100243\" target=\"_blank\">  </a><a target=\"_blank\" href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100243\" class=\"infoItem2\">合生元（BIOSTIME）儿童益生菌冲剂(益生元)26袋装</a> <p class=\"infoItem3 c999\">合生元（BIOSTIME）儿童益生菌冲剂(益生元)26袋装</p><p class=\"price pink\"> <i class=\"ft18\">￥</i>  <b class=\"ft20\">161.00</b> </p> </div> </li><li><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100244\" target=\"_blank\"><p class=\"infoImg\"><img alt=\"拉杜蓝乔（latourangelle）核桃油（婴幼儿）\" feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791014867519451_240.jpg\" rel=\'lazy\' src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></p> </a><div class=\"feiwa-rt\"><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100244\" target=\"_blank\">  </a><a target=\"_blank\" href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100244\" class=\"infoItem2\">拉杜蓝乔（latourangelle）核桃油（婴幼儿）</a> <p class=\"infoItem3 c999\">拉杜蓝乔（latourangelle）核桃油（婴幼儿）</p><p class=\"price pink\"> <i class=\"ft18\">￥</i>  <b class=\"ft20\">168.00</b> </p> </div> </li> </ul> <ul style=\"display: none ;\" class=\"hoverCont \"> <li><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100248\" target=\"_blank\"><p class=\"infoImg\"><img alt=\"花王（Merries）纸尿裤 L54片 大号尿不湿（9-14kg）\" feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791016835295791_240.jpg\" rel=\'lazy\' src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></p> </a><div class=\"feiwa-rt\"><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100248\" target=\"_blank\">  </a><a target=\"_blank\" href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100248\" class=\"infoItem2\">花王（Merries）纸尿裤 L54片 大号尿不湿（9-14kg）</a> <p class=\"infoItem3 c999\">花王（Merries）纸尿裤 L54片 大号尿不湿（9-14kg）</p><p class=\"price pink\"> <i class=\"ft18\">￥</i>  <b class=\"ft20\">99.00</b> </p> </div> </li><li><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100249\" target=\"_blank\"><p class=\"infoImg\"><img alt=\"花王（Merries）纸尿裤 M64片 中号尿不湿（6-11kg）\" feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791017279899925_240.jpg\" rel=\'lazy\' src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></p> </a><div class=\"feiwa-rt\"><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100249\" target=\"_blank\">  </a><a target=\"_blank\" href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100249\" class=\"infoItem2\">花王（Merries）纸尿裤 M64片 中号尿不湿（6-11kg）</a> <p class=\"infoItem3 c999\">花王（Merries）纸尿裤 M64片 中号尿不湿（6-11kg）</p><p class=\"price pink\"> <i class=\"ft18\">￥</i>  <b class=\"ft20\">95.00</b> </p> </div> </li><li><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100250\" target=\"_blank\"><p class=\"infoImg\"><img alt=\"王（Merries）纸尿裤 XL44片 加大号尿不湿（12-20kg）\" feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791017752734288_240.jpg\" rel=\'lazy\' src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></p> </a><div class=\"feiwa-rt\"><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100250\" target=\"_blank\">  </a><a target=\"_blank\" href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100250\" class=\"infoItem2\">王（Merries）纸尿裤 XL44片 加大号尿不湿（12-20kg）</a> <p class=\"infoItem3 c999\">王（Merries）纸尿裤 XL44片 加大号尿不湿（12-20kg）</p><p class=\"price pink\"> <i class=\"ft18\">￥</i>  <b class=\"ft20\">119.00</b> </p> </div> </li><li><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100252\" target=\"_blank\"><p class=\"infoImg\"><img alt=\"花王（Merries）拉拉裤 XL38片 加大号学步裤（12-17kg）\" feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791018889975263_240.jpg\" rel=\'lazy\' src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></p> </a><div class=\"feiwa-rt\"><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100252\" target=\"_blank\">  </a><a target=\"_blank\" href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100252\" class=\"infoItem2\">花王（Merries）拉拉裤 XL38片 加大号学步裤（12-17kg）</a> <p class=\"infoItem3 c999\">花王（Merries）拉拉裤 XL38片 加大号学步裤（12-17kg）</p><p class=\"price pink\"> <i class=\"ft18\">￥</i>  <b class=\"ft20\">105.00</b> </p> </div> </li><li><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100254\" target=\"_blank\"><p class=\"infoImg\"><img alt=\"五羊（FIVERAMS）婴儿护肤柔湿巾80片×3包宝宝湿纸巾带盖抽纸湿巾\" feiwa-url=\"http://malltest.mywopop.com/data/upload/mall/store/goods/6/6_05791019767315044_240.jpg\" rel=\'lazy\' src=\"http://malltest.mywopop.com/mall/img/loading.gif\" ></p> </a><div class=\"feiwa-rt\"><a href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100254\" target=\"_blank\">  </a><a target=\"_blank\" href=\"http://malltest.mywopop.com/mall/index.php?app=goods&ops=index&goods_id=100254\" class=\"infoItem2\">五羊（FIVERAMS）婴儿护肤柔湿巾80片×3包宝宝湿纸巾带盖抽纸湿巾</a> <p class=\"infoItem3 c999\">五羊（FIVERAMS）婴儿护肤柔湿巾80片×3包宝宝湿纸巾带盖抽纸湿巾</p><p class=\"price pink\"> <i class=\"ft18\">￥</i>  <b class=\"ft20\">19.00</b> </p> </div> </li> </ul> </div>'),(601,'演示频道--顶部','default','channel_tp',1510638877,255,1,''),(610,'演示频道--中部','default','channel_fl',1415167497,255,1,'');

/*Table structure for table `feiwa_web_channel` */

DROP TABLE IF EXISTS `feiwa_web_channel`;

CREATE TABLE `feiwa_web_channel` (
  `channel_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `channel_name` varchar(50) DEFAULT '' COMMENT '频道名称',
  `channel_style` varchar(20) DEFAULT '' COMMENT '颜色风格',
  `gc_id` int(10) unsigned DEFAULT '0' COMMENT '绑定分类ID',
  `gc_name` varchar(50) DEFAULT '' COMMENT '分类名称',
  `keywords` varchar(255) DEFAULT '' COMMENT '关键词',
  `description` varchar(255) DEFAULT '' COMMENT '描述',
  `top_id` int(10) unsigned DEFAULT '0' COMMENT '顶部楼层编号',
  `floor_ids` varchar(100) DEFAULT '' COMMENT '中部楼层编号',
  `update_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `channel_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '启用状态，0为否，1为是，默认为1',
  PRIMARY KEY (`channel_id`),
  KEY `gc_id` (`gc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=603 DEFAULT CHARSET=utf8 COMMENT='商城频道表';

/*Data for the table `feiwa_web_channel` */

insert  into `feiwa_web_channel`(`channel_id`,`channel_name`,`channel_style`,`gc_id`,`gc_name`,`keywords`,`description`,`top_id`,`floor_ids`,`update_time`,`channel_show`) values (602,'1111111','pink',0,'','','',0,'',1510637430,1);

/*Table structure for table `feiwa_web_code` */

DROP TABLE IF EXISTS `feiwa_web_code`;

CREATE TABLE `feiwa_web_code` (
  `code_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '内容ID',
  `web_id` int(10) unsigned NOT NULL COMMENT '模块ID',
  `code_type` varchar(10) NOT NULL DEFAULT 'array' COMMENT '数据类型:array,html,json',
  `var_name` varchar(20) NOT NULL DEFAULT '' COMMENT '变量名称',
  `code_info` text COMMENT '内容数据',
  `show_name` varchar(20) DEFAULT '' COMMENT '页面名称',
  PRIMARY KEY (`code_id`),
  KEY `web_id` (`web_id`)
) ENGINE=InnoDB AUTO_INCREMENT=620 DEFAULT CHARSET=utf8 COMMENT='模块内容表';

/*Data for the table `feiwa_web_code` */

insert  into `feiwa_web_code`(`code_id`,`web_id`,`code_type`,`var_name`,`code_info`,`show_name`) values (11,1,'array','tit','a:5:{s:3:\"pic\";s:0:\"\";s:3:\"url\";s:0:\"\";s:4:\"type\";s:3:\"txt\";s:5:\"floor\";s:2:\"2F\";s:5:\"title\";s:12:\"婴儿用品\";}','标题图片'),(12,1,'array','category_list','a:1:{s:11:\"goods_class\";a:18:{i:1078;a:2:{s:5:\"gc_id\";s:4:\"1078\";s:7:\"gc_name\";s:6:\"玩具\";}i:1079;a:2:{s:5:\"gc_id\";s:4:\"1079\";s:7:\"gc_name\";s:6:\"箱包\";}i:1080;a:2:{s:5:\"gc_id\";s:4:\"1080\";s:7:\"gc_name\";s:6:\"腰带\";}i:1081;a:2:{s:5:\"gc_id\";s:4:\"1081\";s:7:\"gc_name\";s:6:\"玉器\";}i:1082;a:2:{s:5:\"gc_id\";s:4:\"1082\";s:7:\"gc_name\";s:6:\"头饰\";}i:1083;a:2:{s:5:\"gc_id\";s:4:\"1083\";s:7:\"gc_name\";s:6:\"花卉\";}i:1084;a:2:{s:5:\"gc_id\";s:4:\"1084\";s:7:\"gc_name\";s:9:\"工艺品\";}i:1085;a:2:{s:5:\"gc_id\";s:4:\"1085\";s:7:\"gc_name\";s:9:\"十字绣\";}i:1086;a:2:{s:5:\"gc_id\";s:4:\"1086\";s:7:\"gc_name\";s:6:\"钟表\";}i:1087;a:2:{s:5:\"gc_id\";s:4:\"1087\";s:7:\"gc_name\";s:12:\"雨具泳具\";}i:1088;a:2:{s:5:\"gc_id\";s:4:\"1088\";s:7:\"gc_name\";s:9:\"化妆品\";}i:1089;a:2:{s:5:\"gc_id\";s:4:\"1089\";s:7:\"gc_name\";s:6:\"假发\";}i:1090;a:2:{s:5:\"gc_id\";s:4:\"1090\";s:7:\"gc_name\";s:6:\"帽子\";}i:1091;a:2:{s:5:\"gc_id\";s:4:\"1091\";s:7:\"gc_name\";s:6:\"围巾\";}i:1092;a:2:{s:5:\"gc_id\";s:4:\"1092\";s:7:\"gc_name\";s:6:\"文体\";}i:1093;a:2:{s:5:\"gc_id\";s:4:\"1093\";s:7:\"gc_name\";s:12:\"办公用品\";}i:1094;a:2:{s:5:\"gc_id\";s:4:\"1094\";s:7:\"gc_name\";s:12:\"塑料制品\";}i:1095;a:2:{s:5:\"gc_id\";s:4:\"1095\";s:7:\"gc_name\";s:12:\"家居饰品\";}}}','推荐分类'),(13,1,'array','act','a:10:{s:3:\"pic\";s:28:\"mall/editor/web-1-13.jpg?351\";s:4:\"type\";s:3:\"pic\";s:5:\"title\";s:0:\"\";s:3:\"url\";s:32:\"http://malltest.mywopop.com/mall\";s:6:\"titlea\";s:6:\"玩具\";s:4:\"urla\";s:32:\"http://malltest.mywopop.com/mall\";s:6:\"titleb\";s:12:\"塑料制品\";s:4:\"urlb\";s:32:\"http://malltest.mywopop.com/mall\";s:4:\"icoa\";s:12:\"家居饰品\";s:4:\"icob\";s:32:\"http://malltest.mywopop.com/mall\";}','活动图片'),(15,1,'array','recommend_list','a:1:{i:1;a:2:{s:9:\"recommend\";a:1:{s:4:\"name\";s:12:\"商品推荐\";}s:10:\"goods_list\";a:8:{i:100271;a:6:{s:8:\"goods_id\";s:6:\"100271\";s:12:\"market_price\";s:5:\"40.00\";s:10:\"goods_name\";s:59:\"贝亲（Pigeon）婴儿训练牙刷三阶段-绿色+黄色\";s:12:\"goods_jingle\";s:59:\"贝亲（Pigeon）婴儿训练牙刷三阶段-绿色+黄色\";s:11:\"goods_price\";s:5:\"39.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791027630963566_240.jpg\";}i:100270;a:6:{s:8:\"goods_id\";s:6:\"100270\";s:12:\"market_price\";s:6:\"129.00\";s:10:\"goods_name\";s:50:\"易简（yijian)婴儿童理发器 宝宝剃头器\";s:12:\"goods_jingle\";s:50:\"易简（yijian)婴儿童理发器 宝宝剃头器\";s:11:\"goods_price\";s:5:\"99.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791027257195652_240.jpg\";}i:100267;a:6:{s:8:\"goods_id\";s:6:\"100267\";s:12:\"market_price\";s:5:\"72.00\";s:10:\"goods_name\";s:45:\"世纪宝贝babyhood 淘气鸭儿童坐便器\";s:12:\"goods_jingle\";s:45:\"世纪宝贝babyhood 淘气鸭儿童坐便器\";s:11:\"goods_price\";s:5:\"68.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791025690171066_240.jpg\";}i:100263;a:6:{s:8:\"goods_id\";s:6:\"100263\";s:12:\"market_price\";s:6:\"230.00\";s:10:\"goods_name\";s:22:\"新贝 电动吸奶器\";s:12:\"goods_jingle\";s:22:\"新贝 电动吸奶器\";s:11:\"goods_price\";s:6:\"225.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791023787756095_240.jpg\";}i:100251;a:6:{s:8:\"goods_id\";s:6:\"100251\";s:12:\"market_price\";s:6:\"100.00\";s:10:\"goods_name\";s:62:\"花王（Merries）纸尿裤 S82片 小号尿不湿（4-8kg）\";s:12:\"goods_jingle\";s:62:\"花王（Merries）纸尿裤 S82片 小号尿不湿（4-8kg）\";s:11:\"goods_price\";s:5:\"95.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791018360977876_240.jpg\";}i:100274;a:6:{s:8:\"goods_id\";s:6:\"100274\";s:12:\"market_price\";s:7:\"3000.00\";s:10:\"goods_name\";s:42:\"宝宝汽车儿童安全座椅isofix接口\";s:12:\"goods_jingle\";s:42:\"宝宝汽车儿童安全座椅isofix接口\";s:11:\"goods_price\";s:7:\"2880.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791029019677006_240.jpg\";}i:100273;a:6:{s:8:\"goods_id\";s:6:\"100273\";s:12:\"market_price\";s:6:\"500.00\";s:10:\"goods_name\";s:48:\"好孩子多功能婴儿推车A513-B-L148 蓝色\";s:12:\"goods_jingle\";s:48:\"好孩子多功能婴儿推车A513-B-L148 蓝色\";s:11:\"goods_price\";s:6:\"479.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791028521571841_240.jpg\";}i:100268;a:6:{s:8:\"goods_id\";s:6:\"100268\";s:12:\"market_price\";s:5:\"32.00\";s:10:\"goods_name\";s:43:\"贝亲（Pigeon）婴儿护臀膏 35g IA149\";s:12:\"goods_jingle\";s:43:\"贝亲（Pigeon）婴儿护臀膏 35g IA149\";s:11:\"goods_price\";s:5:\"29.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791026144289680_240.jpg\";}}}}','商品推荐'),(18,1,'array','adv','a:0:{}','广告图片'),(19,1,'array','brand_list','a:6:{i:302;a:3:{s:8:\"brand_id\";s:3:\"302\";s:10:\"brand_name\";s:12:\"妈咪宝贝\";s:9:\"brand_pic\";s:35:\"mall/brand/04399884799920935_sm.jpg\";}i:269;a:3:{s:8:\"brand_id\";s:3:\"269\";s:10:\"brand_name\";s:9:\"美赞臣\";s:9:\"brand_pic\";s:35:\"mall/brand/04399878617014779_sm.jpg\";}i:286;a:3:{s:8:\"brand_id\";s:3:\"286\";s:10:\"brand_name\";s:9:\"帮宝适\";s:9:\"brand_pic\";s:35:\"mall/brand/04399882134949479_sm.jpg\";}i:271;a:3:{s:8:\"brand_id\";s:3:\"271\";s:10:\"brand_name\";s:6:\"多美\";s:9:\"brand_pic\";s:35:\"mall/brand/04399878980307860_sm.jpg\";}i:300;a:3:{s:8:\"brand_id\";s:3:\"300\";s:10:\"brand_name\";s:9:\"好孩子\";s:9:\"brand_pic\";s:35:\"mall/brand/04399884512865285_sm.jpg\";}i:298;a:3:{s:8:\"brand_id\";s:3:\"298\";s:10:\"brand_name\";s:6:\"亨氏\";s:9:\"brand_pic\";s:35:\"mall/brand/04399884182772511_sm.jpg\";}}','品牌推荐'),(21,2,'array','tit','a:5:{s:3:\"pic\";s:0:\"\";s:3:\"url\";s:0:\"\";s:4:\"type\";s:3:\"txt\";s:5:\"floor\";s:2:\"3F\";s:5:\"title\";s:6:\"服装\";}','标题图片'),(22,2,'array','category_list','a:1:{s:11:\"goods_class\";a:5:{i:1097;a:2:{s:5:\"gc_id\";s:4:\"1097\";s:7:\"gc_name\";s:6:\"服装\";}i:1098;a:2:{s:5:\"gc_id\";s:4:\"1098\";s:7:\"gc_name\";s:6:\"童鞋\";}i:1099;a:2:{s:5:\"gc_id\";s:4:\"1099\";s:7:\"gc_name\";s:9:\"成人鞋\";}i:1100;a:2:{s:5:\"gc_id\";s:4:\"1100\";s:7:\"gc_name\";s:6:\"内衣\";}i:1101;a:2:{s:5:\"gc_id\";s:4:\"1101\";s:7:\"gc_name\";s:6:\"袜子\";}}}','推荐分类'),(23,2,'array','act','a:10:{s:3:\"pic\";s:28:\"mall/editor/web-2-23.jpg?185\";s:4:\"type\";s:3:\"pic\";s:5:\"title\";s:0:\"\";s:3:\"url\";s:27:\"http://101.226.179.113/mall\";s:6:\"titlea\";s:0:\"\";s:4:\"urla\";s:27:\"http://101.226.179.113/mall\";s:6:\"titleb\";s:0:\"\";s:4:\"urlb\";s:27:\"http://101.226.179.113/mall\";s:4:\"icoa\";s:0:\"\";s:4:\"icob\";s:0:\"\";}','活动图片'),(25,2,'array','recommend_list','a:1:{i:2;a:2:{s:9:\"recommend\";a:1:{s:4:\"name\";s:12:\"商品推荐\";}s:10:\"goods_list\";a:8:{i:100275;a:6:{s:8:\"goods_id\";s:6:\"100275\";s:12:\"market_price\";s:6:\"500.00\";s:10:\"goods_name\";s:35:\"婧麒 JOYNCLEON 防辐射服吊带\";s:12:\"goods_jingle\";s:35:\"婧麒 JOYNCLEON 防辐射服吊带\";s:11:\"goods_price\";s:6:\"458.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791069315571320_240.jpg\";}i:100277;a:6:{s:8:\"goods_id\";s:6:\"100277\";s:12:\"market_price\";s:6:\"438.00\";s:10:\"goods_name\";s:70:\"婧麒（JOYNCLEON） 防辐射服春夏季吊带银纤维马甲孕妇\";s:12:\"goods_jingle\";s:70:\"婧麒（JOYNCLEON） 防辐射服春夏季吊带银纤维马甲孕妇\";s:11:\"goods_price\";s:6:\"428.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791071936832202_240.jpg\";}i:100276;a:6:{s:8:\"goods_id\";s:6:\"100276\";s:12:\"market_price\";s:6:\"428.00\";s:10:\"goods_name\";s:57:\"婧麒孕妇防辐射服孕妇装银纤维吊带四季款\";s:12:\"goods_jingle\";s:57:\"婧麒孕妇防辐射服孕妇装银纤维吊带四季款\";s:11:\"goods_price\";s:6:\"418.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791071572119235_240.jpg\";}i:100279;a:6:{s:8:\"goods_id\";s:6:\"100279\";s:12:\"market_price\";s:5:\"32.00\";s:10:\"goods_name\";s:48:\"婴儿脚包学步脚包新生儿四季护脚鞋\";s:12:\"goods_jingle\";s:48:\"婴儿脚包学步脚包新生儿四季护脚鞋\";s:11:\"goods_price\";s:5:\"29.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791073806963100_240.jpg\";}i:100280;a:6:{s:8:\"goods_id\";s:6:\"100280\";s:12:\"market_price\";s:5:\"28.00\";s:10:\"goods_name\";s:42:\"小红豆女童吊带背心棉夏季薄款\";s:12:\"goods_jingle\";s:42:\"小红豆女童吊带背心棉夏季薄款\";s:11:\"goods_price\";s:5:\"25.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791074892100454_240.jpg\";}i:100281;a:6:{s:8:\"goods_id\";s:6:\"100281\";s:12:\"market_price\";s:5:\"58.00\";s:10:\"goods_name\";s:46:\"儿童内裤纯棉平角男女童内裤4条装\";s:12:\"goods_jingle\";s:46:\"儿童内裤纯棉平角男女童内裤4条装\";s:11:\"goods_price\";s:5:\"46.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791075928721239_240.jpg\";}i:100282;a:6:{s:8:\"goods_id\";s:6:\"100282\";s:12:\"market_price\";s:5:\"32.00\";s:10:\"goods_name\";s:48:\"男短袜春夏季防脱运动船袜男士纯棉\";s:12:\"goods_jingle\";s:48:\"男短袜春夏季防脱运动船袜男士纯棉\";s:11:\"goods_price\";s:5:\"29.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791076612318931_240.jpg\";}i:100284;a:6:{s:8:\"goods_id\";s:6:\"100284\";s:12:\"market_price\";s:6:\"136.00\";s:12:\"goods_jingle\";s:34:\"毛毛虫儿童运动鞋 海浪蓝\";s:10:\"goods_name\";s:34:\"毛毛虫儿童运动鞋 海浪蓝\";s:11:\"goods_price\";s:6:\"129.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791094837636994_240.jpg\";}}}}','商品推荐'),(28,2,'array','adv','a:0:{}','广告图片'),(29,2,'array','brand_list','a:9:{i:302;a:3:{s:8:\"brand_id\";s:3:\"302\";s:10:\"brand_name\";s:12:\"妈咪宝贝\";s:9:\"brand_pic\";s:35:\"mall/brand/04399884799920935_sm.jpg\";}i:301;a:3:{s:8:\"brand_id\";s:3:\"301\";s:10:\"brand_name\";s:9:\"婴姿坊\";s:9:\"brand_pic\";s:35:\"mall/brand/04399884644632532_sm.jpg\";}i:300;a:3:{s:8:\"brand_id\";s:3:\"300\";s:10:\"brand_name\";s:9:\"好孩子\";s:9:\"brand_pic\";s:35:\"mall/brand/04399884512865285_sm.jpg\";}i:299;a:3:{s:8:\"brand_id\";s:3:\"299\";s:10:\"brand_name\";s:12:\"十月妈咪\";s:9:\"brand_pic\";s:35:\"mall/brand/04399884360526483_sm.jpg\";}i:286;a:3:{s:8:\"brand_id\";s:3:\"286\";s:10:\"brand_name\";s:9:\"帮宝适\";s:9:\"brand_pic\";s:35:\"mall/brand/04399882134949479_sm.jpg\";}i:280;a:3:{s:8:\"brand_id\";s:3:\"280\";s:10:\"brand_name\";s:12:\"宝贝第一\";s:9:\"brand_pic\";s:35:\"mall/brand/04399880757446523_sm.jpg\";}i:273;a:3:{s:8:\"brand_id\";s:3:\"273\";s:10:\"brand_name\";s:9:\"孩之宝\";s:9:\"brand_pic\";s:35:\"mall/brand/04399879573077116_sm.jpg\";}i:271;a:3:{s:8:\"brand_id\";s:3:\"271\";s:10:\"brand_name\";s:6:\"多美\";s:9:\"brand_pic\";s:35:\"mall/brand/04399878980307860_sm.jpg\";}i:270;a:3:{s:8:\"brand_id\";s:3:\"270\";s:10:\"brand_name\";s:6:\"好奇\";s:9:\"brand_pic\";s:35:\"mall/brand/04399878791943342_sm.jpg\";}}','品牌推荐'),(31,3,'array','tit','a:5:{s:3:\"pic\";s:28:\"mall/editor/web-3-31.jpg?104\";s:3:\"url\";s:0:\"\";s:4:\"type\";s:3:\"txt\";s:5:\"floor\";s:2:\"4F\";s:5:\"title\";s:12:\"运动健康\";}','标题图片'),(32,3,'array','category_list','a:1:{s:11:\"goods_class\";a:2:{i:1102;a:2:{s:5:\"gc_id\";s:4:\"1102\";s:7:\"gc_name\";s:6:\"童装\";}i:1103;a:2:{s:5:\"gc_id\";s:4:\"1103\";s:7:\"gc_name\";s:12:\"育婴用品\";}}}','推荐分类'),(33,3,'array','act','a:10:{s:3:\"pic\";s:28:\"mall/editor/web-3-33.jpg?896\";s:4:\"type\";s:3:\"pic\";s:5:\"title\";s:0:\"\";s:3:\"url\";s:27:\"http://101.226.179.113/mall\";s:6:\"titlea\";s:0:\"\";s:4:\"urla\";s:27:\"http://101.226.179.113/mall\";s:6:\"titleb\";s:0:\"\";s:4:\"urlb\";s:27:\"http://101.226.179.113/mall\";s:4:\"icoa\";s:0:\"\";s:4:\"icob\";s:0:\"\";}','活动图片'),(35,3,'array','recommend_list','a:1:{i:1;a:2:{s:9:\"recommend\";a:1:{s:4:\"name\";s:12:\"商品推荐\";}s:10:\"goods_list\";a:8:{i:100259;a:6:{s:8:\"goods_id\";s:6:\"100259\";s:12:\"market_price\";s:5:\"32.00\";s:12:\"goods_jingle\";s:54:\"象宝宝（elepbaby）宝宝吃饭罩衣 婴儿围兜\";s:10:\"goods_name\";s:54:\"象宝宝（elepbaby）宝宝吃饭罩衣 婴儿围兜\";s:11:\"goods_price\";s:5:\"29.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791021959746394_240.jpg\";}i:100265;a:6:{s:8:\"goods_id\";s:6:\"100265\";s:12:\"market_price\";s:6:\"100.00\";s:12:\"goods_jingle\";s:44:\"日康婴儿浴盆 洗澡盆 大号带躺板\";s:10:\"goods_name\";s:44:\"日康婴儿浴盆 洗澡盆 大号带躺板\";s:11:\"goods_price\";s:5:\"96.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791024667273344_240.jpg\";}i:100263;a:6:{s:8:\"goods_id\";s:6:\"100263\";s:12:\"market_price\";s:6:\"230.00\";s:12:\"goods_jingle\";s:22:\"新贝 电动吸奶器\";s:10:\"goods_name\";s:22:\"新贝 电动吸奶器\";s:11:\"goods_price\";s:6:\"225.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791023787756095_240.jpg\";}i:100262;a:6:{s:8:\"goods_id\";s:6:\"100262\";s:12:\"market_price\";s:6:\"310.00\";s:12:\"goods_jingle\";s:40:\"小白熊 （Snow Bear）婴儿辅食机\";s:10:\"goods_name\";s:40:\"小白熊 （Snow Bear）婴儿辅食机\";s:11:\"goods_price\";s:6:\"299.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791023313047855_240.jpg\";}i:100261;a:6:{s:8:\"goods_id\";s:6:\"100261\";s:12:\"market_price\";s:6:\"288.00\";s:12:\"goods_jingle\";s:58:\"小白熊 (Snow Bear) 婴儿奶瓶蒸汽消毒器带烘干\";s:10:\"goods_name\";s:58:\"小白熊 (Snow Bear) 婴儿奶瓶蒸汽消毒器带烘干\";s:11:\"goods_price\";s:6:\"269.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791022845352222_240.jpg\";}i:100260;a:6:{s:8:\"goods_id\";s:6:\"100260\";s:12:\"market_price\";s:5:\"65.00\";s:12:\"goods_jingle\";s:54:\"飞利浦 新安怡（AVENT）七安士卡通吸管杯\";s:10:\"goods_name\";s:54:\"飞利浦 新安怡（AVENT）七安士卡通吸管杯\";s:11:\"goods_price\";s:5:\"59.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791022372517357_240.jpg\";}i:100258;a:6:{s:8:\"goods_id\";s:6:\"100258\";s:12:\"market_price\";s:5:\"62.00\";s:12:\"goods_jingle\";s:50:\"贝亲（Pigeon）独立开口三层奶粉盒 CA07\";s:10:\"goods_name\";s:50:\"贝亲（Pigeon）独立开口三层奶粉盒 CA07\";s:11:\"goods_price\";s:5:\"54.60\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791021557730356_240.jpg\";}i:100256;a:6:{s:8:\"goods_id\";s:6:\"100256\";s:12:\"market_price\";s:5:\"60.00\";s:12:\"goods_jingle\";s:66:\"飞利浦新安怡 英国进口 AVENT 时尚安抚奶嘴6-18个月\";s:10:\"goods_name\";s:66:\"飞利浦新安怡 英国进口 AVENT 时尚安抚奶嘴6-18个月\";s:11:\"goods_price\";s:5:\"56.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791020695050816_240.jpg\";}}}}','商品推荐'),(38,3,'array','adv','a:0:{}','广告图片'),(39,3,'array','brand_list','a:10:{i:268;a:3:{s:8:\"brand_id\";s:3:\"268\";s:10:\"brand_name\";s:10:\"lala布书\";s:9:\"brand_pic\";s:35:\"mall/brand/04399878481448839_sm.jpg\";}i:270;a:3:{s:8:\"brand_id\";s:3:\"270\";s:10:\"brand_name\";s:6:\"好奇\";s:9:\"brand_pic\";s:35:\"mall/brand/04399878791943342_sm.jpg\";}i:274;a:3:{s:8:\"brand_id\";s:3:\"274\";s:10:\"brand_name\";s:6:\"嗳呵\";s:9:\"brand_pic\";s:35:\"mall/brand/04399879712252398_sm.jpg\";}i:277;a:3:{s:8:\"brand_id\";s:3:\"277\";s:10:\"brand_name\";s:6:\"芭比\";s:9:\"brand_pic\";s:35:\"mall/brand/04399880244694286_sm.jpg\";}i:280;a:3:{s:8:\"brand_id\";s:3:\"280\";s:10:\"brand_name\";s:12:\"宝贝第一\";s:9:\"brand_pic\";s:35:\"mall/brand/04399880757446523_sm.jpg\";}i:275;a:3:{s:8:\"brand_id\";s:3:\"275\";s:10:\"brand_name\";s:12:\"美斯特伦\";s:9:\"brand_pic\";s:35:\"mall/brand/04399879861821747_sm.jpg\";}i:281;a:3:{s:8:\"brand_id\";s:3:\"281\";s:10:\"brand_name\";s:6:\"强生\";s:9:\"brand_pic\";s:35:\"mall/brand/04399880892528550_sm.jpg\";}i:286;a:3:{s:8:\"brand_id\";s:3:\"286\";s:10:\"brand_name\";s:9:\"帮宝适\";s:9:\"brand_pic\";s:35:\"mall/brand/04399882134949479_sm.jpg\";}i:289;a:3:{s:8:\"brand_id\";s:3:\"289\";s:10:\"brand_name\";s:12:\"十月天使\";s:9:\"brand_pic\";s:35:\"mall/brand/04399882581513663_sm.jpg\";}i:292;a:3:{s:8:\"brand_id\";s:3:\"292\";s:10:\"brand_name\";s:12:\"布朗博士\";s:9:\"brand_pic\";s:35:\"mall/brand/04399883157641690_sm.jpg\";}}','品牌推荐'),(41,4,'array','tit','a:5:{s:3:\"pic\";s:0:\"\";s:3:\"url\";s:0:\"\";s:4:\"type\";s:3:\"txt\";s:5:\"floor\";s:2:\"4F\";s:5:\"title\";s:12:\"家居用品\";}','标题图片'),(42,4,'array','category_list','a:1:{s:11:\"goods_class\";a:12:{i:200;a:2:{s:5:\"gc_id\";s:3:\"200\";s:7:\"gc_name\";s:6:\"家纺\";}i:201;a:2:{s:5:\"gc_id\";s:3:\"201\";s:7:\"gc_name\";s:6:\"灯具\";}i:202;a:2:{s:5:\"gc_id\";s:3:\"202\";s:7:\"gc_name\";s:12:\"生活日用\";}i:203;a:2:{s:5:\"gc_id\";s:3:\"203\";s:7:\"gc_name\";s:12:\"家装软饰\";}i:204;a:2:{s:5:\"gc_id\";s:3:\"204\";s:7:\"gc_name\";s:12:\"清洁日用\";}i:205;a:2:{s:5:\"gc_id\";s:3:\"205\";s:7:\"gc_name\";s:12:\"宠物生活\";}i:228;a:2:{s:5:\"gc_id\";s:3:\"228\";s:7:\"gc_name\";s:12:\"收纳用品\";}i:229;a:2:{s:5:\"gc_id\";s:3:\"229\";s:7:\"gc_name\";s:12:\"雨伞雨具\";}i:230;a:2:{s:5:\"gc_id\";s:3:\"230\";s:7:\"gc_name\";s:12:\"浴室用品\";}i:231;a:2:{s:5:\"gc_id\";s:3:\"231\";s:7:\"gc_name\";s:12:\"缝纫用品\";}i:232;a:2:{s:5:\"gc_id\";s:3:\"232\";s:7:\"gc_name\";s:12:\"洗晒用品\";}i:233;a:2:{s:5:\"gc_id\";s:3:\"233\";s:7:\"gc_name\";s:12:\"净化除味\";}}}','推荐分类'),(43,4,'array','act','a:10:{s:3:\"pic\";s:28:\"mall/editor/web-4-43.jpg?335\";s:4:\"type\";s:3:\"pic\";s:5:\"title\";s:0:\"\";s:3:\"url\";s:27:\"http://101.226.179.113/mall\";s:6:\"titlea\";s:0:\"\";s:4:\"urla\";s:27:\"http://101.226.179.113/mall\";s:6:\"titleb\";s:0:\"\";s:4:\"urlb\";s:27:\"http://101.226.179.113/mall\";s:4:\"icoa\";s:0:\"\";s:4:\"icob\";s:0:\"\";}','活动图片'),(45,4,'array','recommend_list','a:1:{i:1;a:3:{s:9:\"recommend\";a:1:{s:4:\"name\";s:12:\"商品推荐\";}s:8:\"pic_list\";a:9:{i:14;a:5:{s:6:\"pic_id\";s:2:\"14\";s:8:\"pic_name\";s:18:\"超强家居阵容\";s:9:\"pic_sname\";s:31:\"品牌直促销 价格低到爆\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-4-45-1-14.jpg?289\";}i:11;a:5:{s:6:\"pic_id\";s:2:\"11\";s:8:\"pic_name\";s:25:\"美加华MB1821 座便器\";s:9:\"pic_sname\";s:28:\"自洁釉 虹吸式300坑距\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-4-45-1-11.jpg?493\";}i:21;a:5:{s:6:\"pic_id\";s:2:\"21\";s:8:\"pic_name\";s:19:\"万家乐 油烟机\";s:9:\"pic_sname\";s:31:\"爆炒风,排烟关键一分钟\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-4-45-1-21.jpg?877\";}i:31;a:5:{s:6:\"pic_id\";s:2:\"31\";s:8:\"pic_name\";s:32:\"苏泊尔（SUPOR）水槽单槽\";s:9:\"pic_sname\";s:19:\"单槽+厨房龙头\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-4-45-1-31.jpg?634\";}i:12;a:5:{s:6:\"pic_id\";s:2:\"12\";s:8:\"pic_name\";s:24:\"万家乐燃气热水器\";s:9:\"pic_sname\";s:26:\"智能浴,4大沐浴模式\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-4-45-1-12.jpg?208\";}i:24;a:5:{s:6:\"pic_id\";s:2:\"24\";s:8:\"pic_name\";s:19:\"精美吊灯 欧式\";s:9:\"pic_sname\";s:15:\"低至588元起\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-4-45-1-24.jpg?435\";}i:32;a:5:{s:6:\"pic_id\";s:2:\"32\";s:8:\"pic_name\";s:19:\"酷开 平板电视\";s:9:\"pic_sname\";s:26:\"43英寸智能网络液晶\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-4-45-1-32.jpg?810\";}i:33;a:5:{s:6:\"pic_id\";s:2:\"33\";s:8:\"pic_name\";s:0:\"\";s:9:\"pic_sname\";s:0:\"\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-4-45-1-33.jpg?302\";}i:34;a:5:{s:6:\"pic_id\";s:2:\"34\";s:8:\"pic_name\";s:0:\"\";s:9:\"pic_sname\";s:0:\"\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-4-45-1-34.jpg?438\";}}s:10:\"goods_list\";a:8:{i:100204;a:6:{s:8:\"goods_id\";s:6:\"100204\";s:12:\"market_price\";s:6:\"258.00\";s:12:\"goods_jingle\";s:28:\"户外专用 搪瓷烧烤架\";s:10:\"goods_name\";s:21:\"户外木炭烧烤架\";s:11:\"goods_price\";s:6:\"239.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05641565630344137_240.jpg\";}i:100205;a:6:{s:8:\"goods_id\";s:6:\"100205\";s:12:\"market_price\";s:6:\"280.00\";s:12:\"goods_jingle\";s:28:\"升级液压款 防水防晒\";s:10:\"goods_name\";s:30:\"防风防雨露营野营液压\";s:11:\"goods_price\";s:6:\"261.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05641566209296142_240.jpg\";}i:100206;a:6:{s:8:\"goods_id\";s:6:\"100206\";s:12:\"market_price\";s:5:\"48.00\";s:12:\"goods_jingle\";s:38:\"无烟环保 持久耐烧 纯天然原\";s:10:\"goods_name\";s:25:\"无烟碳 户外易燃碳\";s:11:\"goods_price\";s:5:\"40.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05641566843466734_240.jpg\";}i:100211;a:6:{s:8:\"goods_id\";s:6:\"100211\";s:12:\"market_price\";s:6:\"168.00\";s:12:\"goods_jingle\";s:22:\"双肩背包 运动包\";s:10:\"goods_name\";s:26:\"男女包 双肩包 背包\";s:11:\"goods_price\";s:6:\"159.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05641569264724588_240.jpg\";}i:100210;a:6:{s:8:\"goods_id\";s:6:\"100210\";s:12:\"market_price\";s:6:\"240.00\";s:12:\"goods_jingle\";s:40:\"双拉链主袋 放15寸电脑 加厚肩\";s:10:\"goods_name\";s:28:\"背包旅行包 运动包正\";s:11:\"goods_price\";s:6:\"219.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05641568866716301_240.jpg\";}i:100209;a:6:{s:8:\"goods_id\";s:6:\"100209\";s:12:\"market_price\";s:6:\"200.00\";s:12:\"goods_jingle\";s:38:\"灵活轻便 稳固耐用 收纳轻松\";s:10:\"goods_name\";s:30:\"便携式户外折叠桌椅套\";s:11:\"goods_price\";s:6:\"188.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05641568388466262_240.jpg\";}i:100208;a:6:{s:8:\"goods_id\";s:6:\"100208\";s:12:\"market_price\";s:6:\"248.00\";s:12:\"goods_jingle\";s:41:\"源自德国 复古风野餐蓝 户外休\";s:10:\"goods_name\";s:25:\"野营餐具套装 烧烤\";s:11:\"goods_price\";s:6:\"231.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05641567819547594_240.jpg\";}i:100207;a:6:{s:8:\"goods_id\";s:6:\"100207\";s:12:\"market_price\";s:6:\"420.00\";s:12:\"goods_jingle\";s:41:\"纯蓝火焰 熄火保护 拒绝气体泄\";s:10:\"goods_name\";s:28:\"户外便携式火炉 防风\";s:11:\"goods_price\";s:6:\"396.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05641567266828474_240.jpg\";}}}}','商品推荐'),(48,4,'array','adv','a:0:{}','广告图片'),(49,4,'array','brand_list','a:10:{i:313;a:3:{s:8:\"brand_id\";s:3:\"313\";s:10:\"brand_name\";s:9:\"皮克朋\";s:9:\"brand_pic\";s:35:\"mall/brand/04399891285897466_sm.jpg\";}i:312;a:3:{s:8:\"brand_id\";s:3:\"312\";s:10:\"brand_name\";s:6:\"乔山\";s:9:\"brand_pic\";s:35:\"mall/brand/04399891122713199_sm.jpg\";}i:314;a:3:{s:8:\"brand_id\";s:3:\"314\";s:10:\"brand_name\";s:9:\"捷安特\";s:9:\"brand_pic\";s:35:\"mall/brand/04399891438458842_sm.jpg\";}i:315;a:3:{s:8:\"brand_id\";s:3:\"315\";s:10:\"brand_name\";s:9:\"开普特\";s:9:\"brand_pic\";s:35:\"mall/brand/04399891598799644_sm.jpg\";}i:305;a:3:{s:8:\"brand_id\";s:3:\"305\";s:10:\"brand_name\";s:6:\"悠度\";s:9:\"brand_pic\";s:35:\"mall/brand/04399889744222357_sm.jpg\";}i:309;a:3:{s:8:\"brand_id\";s:3:\"309\";s:10:\"brand_name\";s:9:\"诺可文\";s:9:\"brand_pic\";s:35:\"mall/brand/04399890643925803_sm.jpg\";}i:310;a:3:{s:8:\"brand_id\";s:3:\"310\";s:10:\"brand_name\";s:6:\"艾威\";s:9:\"brand_pic\";s:35:\"mall/brand/04399890796771131_sm.jpg\";}i:307;a:3:{s:8:\"brand_id\";s:3:\"307\";s:10:\"brand_name\";s:12:\"远洋瑜伽\";s:9:\"brand_pic\";s:35:\"mall/brand/04399890266352034_sm.jpg\";}i:306;a:3:{s:8:\"brand_id\";s:3:\"306\";s:10:\"brand_name\";s:9:\"威尔胜\";s:9:\"brand_pic\";s:35:\"mall/brand/04399889941968796_sm.jpg\";}i:304;a:3:{s:8:\"brand_id\";s:3:\"304\";s:10:\"brand_name\";s:9:\"世达球\";s:9:\"brand_pic\";s:35:\"mall/brand/04399889410183423_sm.jpg\";}}','品牌推荐'),(51,5,'array','tit','a:5:{s:3:\"pic\";s:0:\"\";s:3:\"url\";s:0:\"\";s:4:\"type\";s:3:\"txt\";s:5:\"floor\";s:2:\"5F\";s:5:\"title\";s:12:\"数码产品\";}','标题图片'),(52,5,'array','category_list','a:1:{s:11:\"goods_class\";a:24:{i:258;a:2:{s:5:\"gc_id\";s:3:\"258\";s:7:\"gc_name\";s:12:\"手机配件\";}i:259;a:2:{s:5:\"gc_id\";s:3:\"259\";s:7:\"gc_name\";s:12:\"摄影摄像\";}i:260;a:2:{s:5:\"gc_id\";s:3:\"260\";s:7:\"gc_name\";s:12:\"数码配件\";}i:261;a:2:{s:5:\"gc_id\";s:3:\"261\";s:7:\"gc_name\";s:12:\"时尚影音\";}i:390;a:2:{s:5:\"gc_id\";s:3:\"390\";s:7:\"gc_name\";s:12:\"电脑整机\";}i:391;a:2:{s:5:\"gc_id\";s:3:\"391\";s:7:\"gc_name\";s:12:\"电脑配件\";}i:392;a:2:{s:5:\"gc_id\";s:3:\"392\";s:7:\"gc_name\";s:12:\"外设产品\";}i:393;a:2:{s:5:\"gc_id\";s:3:\"393\";s:7:\"gc_name\";s:12:\"网络产品\";}i:394;a:2:{s:5:\"gc_id\";s:3:\"394\";s:7:\"gc_name\";s:12:\"办公打印\";}i:395;a:2:{s:5:\"gc_id\";s:3:\"395\";s:7:\"gc_name\";s:12:\"办公文仪\";}i:1034;a:2:{s:5:\"gc_id\";s:4:\"1034\";s:7:\"gc_name\";s:12:\"手机通讯\";}i:406;a:2:{s:5:\"gc_id\";s:3:\"406\";s:7:\"gc_name\";s:3:\"CPU\";}i:407;a:2:{s:5:\"gc_id\";s:3:\"407\";s:7:\"gc_name\";s:6:\"主板\";}i:408;a:2:{s:5:\"gc_id\";s:3:\"408\";s:7:\"gc_name\";s:6:\"显卡\";}i:409;a:2:{s:5:\"gc_id\";s:3:\"409\";s:7:\"gc_name\";s:6:\"硬盘\";}i:410;a:2:{s:5:\"gc_id\";s:3:\"410\";s:7:\"gc_name\";s:15:\"SSD固态硬盘\";}i:411;a:2:{s:5:\"gc_id\";s:3:\"411\";s:7:\"gc_name\";s:6:\"内存\";}i:412;a:2:{s:5:\"gc_id\";s:3:\"412\";s:7:\"gc_name\";s:6:\"机箱\";}i:413;a:2:{s:5:\"gc_id\";s:3:\"413\";s:7:\"gc_name\";s:6:\"电源\";}i:414;a:2:{s:5:\"gc_id\";s:3:\"414\";s:7:\"gc_name\";s:9:\"显示器\";}i:415;a:2:{s:5:\"gc_id\";s:3:\"415\";s:7:\"gc_name\";s:16:\"刻录机/光驱\";}i:416;a:2:{s:5:\"gc_id\";s:3:\"416\";s:7:\"gc_name\";s:9:\"散热器\";}i:417;a:2:{s:5:\"gc_id\";s:3:\"417\";s:7:\"gc_name\";s:16:\"声卡/扩展卡\";}i:418;a:2:{s:5:\"gc_id\";s:3:\"418\";s:7:\"gc_name\";s:12:\"装机配件\";}}}','推荐分类'),(53,5,'array','act','a:10:{s:3:\"pic\";s:28:\"mall/editor/web-5-53.jpg?354\";s:4:\"type\";s:3:\"pic\";s:5:\"title\";s:0:\"\";s:3:\"url\";s:27:\"http://101.226.179.113/mall\";s:6:\"titlea\";s:0:\"\";s:4:\"urla\";s:27:\"http://101.226.179.113/mall\";s:6:\"titleb\";s:0:\"\";s:4:\"urlb\";s:27:\"http://101.226.179.113/mall\";s:4:\"icoa\";s:0:\"\";s:4:\"icob\";s:0:\"\";}','活动图片'),(55,5,'array','recommend_list','a:1:{i:1;a:3:{s:9:\"recommend\";a:1:{s:4:\"name\";s:12:\"商品推荐\";}s:8:\"pic_list\";a:9:{i:14;a:5:{s:6:\"pic_id\";s:2:\"14\";s:8:\"pic_name\";s:12:\"数码产品\";s:9:\"pic_sname\";s:25:\"超强性能 超高颜值\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-5-55-1-14.jpg?809\";}i:11;a:5:{s:6:\"pic_id\";s:2:\"11\";s:8:\"pic_name\";s:21:\"苹果 iPhone 6S Plus\";s:9:\"pic_sname\";s:28:\"三网通 移动联通电信\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-5-55-1-11.jpg?963\";}i:21;a:5:{s:6:\"pic_id\";s:2:\"21\";s:8:\"pic_name\";s:19:\"Lenovo/联想 A7-30\";s:9:\"pic_sname\";s:24:\"超性价比平板电脑\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-5-55-1-21.jpg?974\";}i:31;a:5:{s:6:\"pic_id\";s:2:\"31\";s:8:\"pic_name\";s:13:\"华硕 X450JB\";s:9:\"pic_sname\";s:30:\"I5 2G独显 办公音影游戏\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-5-55-1-31.jpg?622\";}i:12;a:5:{s:6:\"pic_id\";s:2:\"12\";s:8:\"pic_name\";s:21:\"华硕 BM1AE-I5B540W0\";s:9:\"pic_sname\";s:31:\"i5 4570四核处理器 4G内存\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-5-55-1-12.jpg?159\";}i:24;a:5:{s:6:\"pic_id\";s:2:\"24\";s:8:\"pic_name\";s:27:\"Sony 索尼 ILCE-6000套机\";s:9:\"pic_sname\";s:27:\"增强型混合自动对焦\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-5-55-1-24.jpg?293\";}i:32;a:5:{s:6:\"pic_id\";s:2:\"32\";s:8:\"pic_name\";s:33:\"乐心智能手环运动计步器\";s:9:\"pic_sname\";s:29:\"可穿戴设备ios安卓mambo\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-5-55-1-32.jpg?808\";}i:33;a:5:{s:6:\"pic_id\";s:2:\"33\";s:8:\"pic_name\";s:0:\"\";s:9:\"pic_sname\";s:0:\"\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-5-55-1-33.jpg?564\";}i:34;a:5:{s:6:\"pic_id\";s:2:\"34\";s:8:\"pic_name\";s:0:\"\";s:9:\"pic_sname\";s:0:\"\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-5-55-1-34.jpg?367\";}}s:10:\"goods_list\";a:8:{i:100221;a:6:{s:8:\"goods_id\";s:6:\"100221\";s:12:\"market_price\";s:7:\"6200.00\";s:12:\"goods_jingle\";s:15:\"运动摄像机\";s:10:\"goods_name\";s:15:\"运动摄像机\";s:11:\"goods_price\";s:7:\"6000.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05641607118761159_240.jpg\";}i:100220;a:6:{s:8:\"goods_id\";s:6:\"100220\";s:12:\"market_price\";s:7:\"4999.00\";s:12:\"goods_jingle\";s:15:\"运动摄像机\";s:10:\"goods_name\";s:15:\"运动摄像机\";s:11:\"goods_price\";s:7:\"4666.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05641606730414492_240.jpg\";}i:100219;a:6:{s:8:\"goods_id\";s:6:\"100219\";s:12:\"market_price\";s:7:\"4800.00\";s:12:\"goods_jingle\";s:15:\"运动摄像机\";s:10:\"goods_name\";s:15:\"运动摄像机\";s:11:\"goods_price\";s:7:\"4600.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05641606281269303_240.jpg\";}i:100218;a:6:{s:8:\"goods_id\";s:6:\"100218\";s:12:\"market_price\";s:7:\"5200.00\";s:12:\"goods_jingle\";s:15:\"运动摄像机\";s:10:\"goods_name\";s:15:\"运动摄像机\";s:11:\"goods_price\";s:7:\"5100.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05641605782639771_240.jpg\";}i:100217;a:6:{s:8:\"goods_id\";s:6:\"100217\";s:12:\"market_price\";s:7:\"5000.00\";s:12:\"goods_jingle\";s:15:\"运动摄像机\";s:10:\"goods_name\";s:15:\"运动摄像机\";s:11:\"goods_price\";s:7:\"4800.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05641605425045738_240.jpg\";}i:100216;a:6:{s:8:\"goods_id\";s:6:\"100216\";s:12:\"market_price\";s:7:\"5500.00\";s:12:\"goods_jingle\";s:15:\"运动摄像机\";s:10:\"goods_name\";s:15:\"运动摄像机\";s:11:\"goods_price\";s:7:\"5250.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05641604980372834_240.jpg\";}i:100215;a:6:{s:8:\"goods_id\";s:6:\"100215\";s:12:\"market_price\";s:7:\"5400.00\";s:12:\"goods_jingle\";s:15:\"运动摄像机\";s:10:\"goods_name\";s:15:\"运动摄像机\";s:11:\"goods_price\";s:7:\"5200.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05641604498445569_240.jpg\";}i:100214;a:6:{s:8:\"goods_id\";s:6:\"100214\";s:12:\"market_price\";s:7:\"5000.00\";s:12:\"goods_jingle\";s:27:\"又名：数字式相机。\";s:10:\"goods_name\";s:12:\"运动相机\";s:11:\"goods_price\";s:7:\"4799.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05641603045751101_240.jpg\";}}}}','商品推荐'),(58,5,'array','adv','a:0:{}','广告图片'),(59,5,'array','brand_list','a:10:{i:239;a:3:{s:8:\"brand_id\";s:3:\"239\";s:10:\"brand_name\";s:2:\"LG\";s:9:\"brand_pic\";s:35:\"mall/brand/04399838782976323_sm.jpg\";}i:238;a:3:{s:8:\"brand_id\";s:3:\"238\";s:10:\"brand_name\";s:9:\"奥克斯\";s:9:\"brand_pic\";s:35:\"mall/brand/04399838633002147_sm.jpg\";}i:237;a:3:{s:8:\"brand_id\";s:3:\"237\";s:10:\"brand_name\";s:6:\"老板\";s:9:\"brand_pic\";s:35:\"mall/brand/04399838473427197_sm.jpg\";}i:232;a:3:{s:8:\"brand_id\";s:3:\"232\";s:10:\"brand_name\";s:12:\"三星电器\";s:9:\"brand_pic\";s:35:\"mall/brand/04399836619819860_sm.jpg\";}i:236;a:3:{s:8:\"brand_id\";s:3:\"236\";s:10:\"brand_name\";s:6:\"博世\";s:9:\"brand_pic\";s:35:\"mall/brand/04399838243363042_sm.jpg\";}i:209;a:3:{s:8:\"brand_id\";s:3:\"209\";s:10:\"brand_name\";s:6:\"理光\";s:9:\"brand_pic\";s:35:\"mall/brand/04398160857676307_sm.gif\";}i:211;a:3:{s:8:\"brand_id\";s:3:\"211\";s:10:\"brand_name\";s:12:\"阿尔卡特\";s:9:\"brand_pic\";s:35:\"mall/brand/04398161143888870_sm.jpg\";}i:201;a:3:{s:8:\"brand_id\";s:3:\"201\";s:10:\"brand_name\";s:6:\"松下\";s:9:\"brand_pic\";s:35:\"mall/brand/04398159595550035_sm.jpg\";}i:205;a:3:{s:8:\"brand_id\";s:3:\"205\";s:10:\"brand_name\";s:6:\"romoss\";s:9:\"brand_pic\";s:35:\"mall/brand/04398160187629402_sm.jpg\";}i:204;a:3:{s:8:\"brand_id\";s:3:\"204\";s:10:\"brand_name\";s:6:\"北通\";s:9:\"brand_pic\";s:35:\"mall/brand/04398160061664664_sm.jpg\";}}','品牌推荐'),(61,6,'array','tit','','标题图片'),(62,6,'array','category_list','','活动图片'),(63,6,'array','act','','活动图片'),(65,6,'array','recommend_list','','商品推荐'),(68,6,'array','adv','','广告图片'),(69,6,'array','brand_list','','品牌推荐'),(71,7,'array','tit','','标题图片'),(72,7,'array','category_list','','推荐分类'),(73,7,'array','act','','活动图片'),(75,7,'array','recommend_list','','商品推荐'),(78,7,'array','adv','','广告图片'),(79,7,'array','brand_list','','品牌推荐'),(81,8,'array','tit','','标题图片'),(82,8,'array','category_list','','推荐分类'),(83,8,'array','act','','活动图片'),(85,8,'array','recommend_list','','商品推荐'),(88,8,'array','adv','','广告图片'),(89,8,'array','brand_list','','品牌推荐'),(101,101,'array','screen_list','a:2:{i:2;a:9:{s:8:\"pic_name\";s:0:\"\";s:7:\"pic_url\";s:0:\"\";s:8:\"pic_surl\";s:0:\"\";s:8:\"pic_simg\";s:0:\"\";s:8:\"pic_wurl\";s:0:\"\";s:8:\"pic_wimg\";s:0:\"\";s:5:\"color\";s:0:\"\";s:6:\"pic_id\";s:1:\"2\";s:7:\"pic_img\";s:33:\"mall/editor/web-101-101-2.jpg?841\";}i:1;a:9:{s:6:\"pic_id\";s:1:\"1\";s:8:\"pic_name\";s:0:\"\";s:7:\"pic_url\";s:0:\"\";s:8:\"pic_surl\";s:0:\"\";s:8:\"pic_wurl\";s:0:\"\";s:5:\"color\";s:0:\"\";s:7:\"pic_img\";s:33:\"mall/editor/web-101-101-1.jpg?337\";s:8:\"pic_simg\";s:0:\"\";s:8:\"pic_wimg\";s:0:\"\";}}','切换大图'),(102,101,'array','focus_list','a:1:{i:2;a:1:{s:8:\"pic_list\";a:4:{i:1;a:4:{s:6:\"pic_id\";s:1:\"1\";s:8:\"pic_name\";s:0:\"\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:35:\"mall/editor/web-101-102-2-1.jpg?204\";}i:2;a:4:{s:8:\"pic_name\";s:0:\"\";s:7:\"pic_url\";s:0:\"\";s:6:\"pic_id\";s:1:\"2\";s:7:\"pic_img\";s:35:\"mall/editor/web-101-102-2-2.jpg?576\";}i:3;a:4:{s:6:\"pic_id\";s:1:\"3\";s:8:\"pic_name\";s:0:\"\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:35:\"mall/editor/web-101-102-2-3.jpg?551\";}i:4;a:4:{s:6:\"pic_id\";s:1:\"4\";s:8:\"pic_name\";s:0:\"\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:35:\"mall/editor/web-101-102-2-4.jpg?589\";}}}}','切换小图'),(121,121,'array','sale_list','a:3:{i:1;a:2:{s:9:\"recommend\";a:1:{s:4:\"name\";s:12:\"品牌特卖\";}s:10:\"goods_list\";a:5:{i:100232;a:6:{s:8:\"goods_id\";s:6:\"100232\";s:12:\"market_price\";s:6:\"420.00\";s:10:\"goods_name\";s:79:\"美素力（frisolac）金装婴儿配方奶粉 1段（0-6个月婴儿适用）\";s:11:\"goods_price\";s:6:\"400.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05790954343413037_240.jpg\";s:12:\"goods_jingle\";s:0:\"\";}i:100237;a:6:{s:8:\"goods_id\";s:6:\"100237\";s:12:\"market_price\";s:6:\"240.00\";s:10:\"goods_name\";s:55:\"雅培(Abbott)亲护较大婴儿配方奶粉 2段820克\";s:11:\"goods_price\";s:6:\"222.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05790959077707398_240.jpg\";s:12:\"goods_jingle\";s:55:\"雅培(Abbott)亲护较大婴儿配方奶粉 2段820克\";}i:100234;a:6:{s:8:\"goods_id\";s:6:\"100234\";s:12:\"market_price\";s:6:\"420.00\";s:10:\"goods_name\";s:63:\"爱他美卓萃幼儿配方奶粉（12—36月龄，3段）900g\";s:11:\"goods_price\";s:6:\"400.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05790956423059031_240.jpg\";s:12:\"goods_jingle\";s:63:\"爱他美卓萃幼儿配方奶粉（12—36月龄，3段）900g\";}i:100235;a:6:{s:8:\"goods_id\";s:6:\"100235\";s:12:\"market_price\";s:6:\"450.00\";s:10:\"goods_name\";s:65:\"爱他美卓萃儿童配方调制乳粉（36—72月龄，4段）\";s:11:\"goods_price\";s:6:\"400.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05790956949555934_240.jpg\";s:12:\"goods_jingle\";s:65:\"爱他美卓萃儿童配方调制乳粉（36—72月龄，4段）\";}i:100240;a:6:{s:8:\"goods_id\";s:6:\"100240\";s:12:\"market_price\";s:5:\"42.00\";s:10:\"goods_name\";s:76:\"亨氏 (Heinz) 宝宝辅食 婴儿面条 金装粒粒面－猪肝枸杞 320g\";s:11:\"goods_price\";s:5:\"39.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05790961092598660_240.jpg\";s:12:\"goods_jingle\";s:76:\"亨氏 (Heinz) 宝宝辅食 婴儿面条 金装粒粒面－猪肝枸杞 320g\";}}}i:5;a:2:{s:9:\"recommend\";a:1:{s:4:\"name\";s:12:\"新品上架\";}s:10:\"goods_list\";a:5:{i:100247;a:6:{s:8:\"goods_id\";s:6:\"100247\";s:12:\"market_price\";s:5:\"80.00\";s:12:\"goods_jingle\";s:48:\"衍生小儿七星茶固体饮料（经典装）\";s:10:\"goods_name\";s:48:\"衍生小儿七星茶固体饮料（经典装）\";s:11:\"goods_price\";s:5:\"75.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791016254193023_240.jpg\";}i:100246;a:6:{s:8:\"goods_id\";s:6:\"100246\";s:12:\"market_price\";s:5:\"36.00\";s:12:\"goods_jingle\";s:59:\"方广 儿童零食 肉松 钙铁锌猪肉酥肉粉松 100g\";s:10:\"goods_name\";s:59:\"方广 儿童零食 肉松 钙铁锌猪肉酥肉粉松 100g\";s:11:\"goods_price\";s:5:\"33.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791015808970258_240.jpg\";}i:100245;a:6:{s:8:\"goods_id\";s:6:\"100245\";s:12:\"market_price\";s:6:\"178.00\";s:12:\"goods_jingle\";s:92:\"美国童年时光CHILDLIFE钙镁锌婴儿幼儿童补钙宝宝补锌液体钙 6个月以上\";s:10:\"goods_name\";s:92:\"美国童年时光CHILDLIFE钙镁锌婴儿幼儿童补钙宝宝补锌液体钙 6个月以上\";s:11:\"goods_price\";s:6:\"168.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791015324909804_240.jpg\";}i:100243;a:6:{s:8:\"goods_id\";s:6:\"100243\";s:12:\"market_price\";s:6:\"180.00\";s:12:\"goods_jingle\";s:63:\"合生元（BIOSTIME）儿童益生菌冲剂(益生元)26袋装\";s:10:\"goods_name\";s:63:\"合生元（BIOSTIME）儿童益生菌冲剂(益生元)26袋装\";s:11:\"goods_price\";s:6:\"161.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791014397640936_240.jpg\";}i:100244;a:6:{s:8:\"goods_id\";s:6:\"100244\";s:12:\"market_price\";s:6:\"175.00\";s:12:\"goods_jingle\";s:55:\"拉杜蓝乔（latourangelle）核桃油（婴幼儿）\";s:10:\"goods_name\";s:55:\"拉杜蓝乔（latourangelle）核桃油（婴幼儿）\";s:11:\"goods_price\";s:6:\"168.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791014867519451_240.jpg\";}}}i:4;a:2:{s:9:\"recommend\";a:1:{s:4:\"name\";s:12:\"热评商品\";}s:10:\"goods_list\";a:5:{i:100248;a:6:{s:8:\"goods_id\";s:6:\"100248\";s:12:\"market_price\";s:6:\"120.00\";s:12:\"goods_jingle\";s:63:\"花王（Merries）纸尿裤 L54片 大号尿不湿（9-14kg）\";s:10:\"goods_name\";s:63:\"花王（Merries）纸尿裤 L54片 大号尿不湿（9-14kg）\";s:11:\"goods_price\";s:5:\"99.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791016835295791_240.jpg\";}i:100249;a:6:{s:8:\"goods_id\";s:6:\"100249\";s:12:\"market_price\";s:6:\"100.00\";s:12:\"goods_jingle\";s:63:\"花王（Merries）纸尿裤 M64片 中号尿不湿（6-11kg）\";s:10:\"goods_name\";s:63:\"花王（Merries）纸尿裤 M64片 中号尿不湿（6-11kg）\";s:11:\"goods_price\";s:5:\"95.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791017279899925_240.jpg\";}i:100250;a:6:{s:8:\"goods_id\";s:6:\"100250\";s:12:\"market_price\";s:6:\"125.00\";s:12:\"goods_jingle\";s:65:\"王（Merries）纸尿裤 XL44片 加大号尿不湿（12-20kg）\";s:10:\"goods_name\";s:65:\"王（Merries）纸尿裤 XL44片 加大号尿不湿（12-20kg）\";s:11:\"goods_price\";s:6:\"119.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791017752734288_240.jpg\";}i:100252;a:6:{s:8:\"goods_id\";s:6:\"100252\";s:12:\"market_price\";s:6:\"120.00\";s:12:\"goods_jingle\";s:68:\"花王（Merries）拉拉裤 XL38片 加大号学步裤（12-17kg）\";s:10:\"goods_name\";s:68:\"花王（Merries）拉拉裤 XL38片 加大号学步裤（12-17kg）\";s:11:\"goods_price\";s:6:\"105.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791018889975263_240.jpg\";}i:100254;a:6:{s:8:\"goods_id\";s:6:\"100254\";s:12:\"market_price\";s:5:\"21.00\";s:12:\"goods_jingle\";s:85:\"五羊（FIVERAMS）婴儿护肤柔湿巾80片×3包宝宝湿纸巾带盖抽纸湿巾\";s:10:\"goods_name\";s:85:\"五羊（FIVERAMS）婴儿护肤柔湿巾80片×3包宝宝湿纸巾带盖抽纸湿巾\";s:11:\"goods_price\";s:5:\"19.00\";s:9:\"goods_pic\";s:46:\"mall/store/goods/6/6_05791019767315044_240.jpg\";}}}}','促销区'),(601,601,'array','channel_category','a:6:{i:470;a:2:{s:9:\"gc_parent\";a:3:{s:5:\"gc_id\";s:3:\"470\";s:7:\"gc_name\";s:12:\"个护化妆\";s:6:\"gc_pic\";s:0:\"\";}s:11:\"goods_class\";a:7:{i:471;a:2:{s:5:\"gc_id\";s:3:\"471\";s:7:\"gc_name\";s:12:\"面部护理\";}i:472;a:2:{s:5:\"gc_id\";s:3:\"472\";s:7:\"gc_name\";s:12:\"身体护理\";}i:473;a:2:{s:5:\"gc_id\";s:3:\"473\";s:7:\"gc_name\";s:12:\"口腔护理\";}i:474;a:2:{s:5:\"gc_id\";s:3:\"474\";s:7:\"gc_name\";s:12:\"女性护理\";}i:475;a:2:{s:5:\"gc_id\";s:3:\"475\";s:7:\"gc_name\";s:12:\"男士护理\";}i:476;a:2:{s:5:\"gc_id\";s:3:\"476\";s:7:\"gc_name\";s:12:\"魅力彩妆\";}i:477;a:2:{s:5:\"gc_id\";s:3:\"477\";s:7:\"gc_name\";s:9:\"香水SPA\";}}}i:471;a:2:{s:9:\"gc_parent\";a:3:{s:5:\"gc_id\";s:3:\"471\";s:7:\"gc_name\";s:12:\"面部护理\";s:6:\"gc_pic\";s:0:\"\";}s:11:\"goods_class\";a:10:{i:478;a:2:{s:5:\"gc_id\";s:3:\"478\";s:7:\"gc_name\";s:9:\"洁面乳\";}i:479;a:2:{s:5:\"gc_id\";s:3:\"479\";s:7:\"gc_name\";s:9:\"爽肤水\";}i:480;a:2:{s:5:\"gc_id\";s:3:\"480\";s:7:\"gc_name\";s:9:\"精华露\";}i:481;a:2:{s:5:\"gc_id\";s:3:\"481\";s:7:\"gc_name\";s:12:\"乳液面霜\";}i:482;a:2:{s:5:\"gc_id\";s:3:\"482\";s:7:\"gc_name\";s:12:\"面膜面贴\";}i:483;a:2:{s:5:\"gc_id\";s:3:\"483\";s:7:\"gc_name\";s:12:\"眼部护理\";}i:484;a:2:{s:5:\"gc_id\";s:3:\"484\";s:7:\"gc_name\";s:12:\"颈部护理\";}i:485;a:2:{s:5:\"gc_id\";s:3:\"485\";s:7:\"gc_name\";s:10:\"T区护理\";}i:486;a:2:{s:5:\"gc_id\";s:3:\"486\";s:7:\"gc_name\";s:12:\"护肤套装\";}i:487;a:2:{s:5:\"gc_id\";s:3:\"487\";s:7:\"gc_name\";s:12:\"防晒隔离\";}}}i:472;a:2:{s:9:\"gc_parent\";a:3:{s:5:\"gc_id\";s:3:\"472\";s:7:\"gc_name\";s:12:\"身体护理\";s:6:\"gc_pic\";s:0:\"\";}s:11:\"goods_class\";a:11:{i:488;a:2:{s:5:\"gc_id\";s:3:\"488\";s:7:\"gc_name\";s:12:\"洗发护发\";}i:489;a:2:{s:5:\"gc_id\";s:3:\"489\";s:7:\"gc_name\";s:13:\"染发/造型\";}i:490;a:2:{s:5:\"gc_id\";s:3:\"490\";s:7:\"gc_name\";s:6:\"沐浴\";}i:491;a:2:{s:5:\"gc_id\";s:3:\"491\";s:7:\"gc_name\";s:13:\"磨砂/浴盐\";}i:492;a:2:{s:5:\"gc_id\";s:3:\"492\";s:7:\"gc_name\";s:9:\"身体乳\";}i:493;a:2:{s:5:\"gc_id\";s:3:\"493\";s:7:\"gc_name\";s:13:\"手工/香皂\";}i:494;a:2:{s:5:\"gc_id\";s:3:\"494\";s:7:\"gc_name\";s:12:\"香薰精油\";}i:495;a:2:{s:5:\"gc_id\";s:3:\"495\";s:7:\"gc_name\";s:12:\"纤体瘦身\";}i:496;a:2:{s:5:\"gc_id\";s:3:\"496\";s:7:\"gc_name\";s:9:\"脱毛膏\";}i:497;a:2:{s:5:\"gc_id\";s:3:\"497\";s:7:\"gc_name\";s:12:\"手足护理\";}i:498;a:2:{s:5:\"gc_id\";s:3:\"498\";s:7:\"gc_name\";s:12:\"洗护套装\";}}}i:473;a:2:{s:9:\"gc_parent\";a:3:{s:5:\"gc_id\";s:3:\"473\";s:7:\"gc_name\";s:12:\"口腔护理\";s:6:\"gc_pic\";s:0:\"\";}s:11:\"goods_class\";a:3:{i:499;a:2:{s:5:\"gc_id\";s:3:\"499\";s:7:\"gc_name\";s:13:\"牙膏/牙粉\";}i:500;a:2:{s:5:\"gc_id\";s:3:\"500\";s:7:\"gc_name\";s:13:\"牙刷/牙线\";}i:501;a:2:{s:5:\"gc_id\";s:3:\"501\";s:7:\"gc_name\";s:9:\"漱口水\";}}}i:475;a:2:{s:9:\"gc_parent\";a:3:{s:5:\"gc_id\";s:3:\"475\";s:7:\"gc_name\";s:12:\"男士护理\";s:6:\"gc_pic\";s:0:\"\";}s:11:\"goods_class\";a:7:{i:507;a:2:{s:5:\"gc_id\";s:3:\"507\";s:7:\"gc_name\";s:12:\"脸部护理\";}i:508;a:2:{s:5:\"gc_id\";s:3:\"508\";s:7:\"gc_name\";s:12:\"眼部护理\";}i:509;a:2:{s:5:\"gc_id\";s:3:\"509\";s:7:\"gc_name\";s:12:\"身体护理\";}i:510;a:2:{s:5:\"gc_id\";s:3:\"510\";s:7:\"gc_name\";s:12:\"男士香水\";}i:511;a:2:{s:5:\"gc_id\";s:3:\"511\";s:7:\"gc_name\";s:12:\"剃须护理\";}i:512;a:2:{s:5:\"gc_id\";s:3:\"512\";s:7:\"gc_name\";s:12:\"防脱洗护\";}i:513;a:2:{s:5:\"gc_id\";s:3:\"513\";s:7:\"gc_name\";s:12:\"男士唇膏\";}}}i:476;a:2:{s:9:\"gc_parent\";a:3:{s:5:\"gc_id\";s:3:\"476\";s:7:\"gc_name\";s:12:\"魅力彩妆\";s:6:\"gc_pic\";s:0:\"\";}s:11:\"goods_class\";a:11:{i:514;a:2:{s:5:\"gc_id\";s:3:\"514\";s:7:\"gc_name\";s:13:\"粉底/遮瑕\";}i:515;a:2:{s:5:\"gc_id\";s:3:\"515\";s:7:\"gc_name\";s:6:\"腮红\";}i:516;a:2:{s:5:\"gc_id\";s:3:\"516\";s:7:\"gc_name\";s:13:\"眼影/眼线\";}i:517;a:2:{s:5:\"gc_id\";s:3:\"517\";s:7:\"gc_name\";s:6:\"眉笔\";}i:518;a:2:{s:5:\"gc_id\";s:3:\"518\";s:7:\"gc_name\";s:9:\"睫毛膏\";}i:519;a:2:{s:5:\"gc_id\";s:3:\"519\";s:7:\"gc_name\";s:12:\"唇膏唇彩\";}i:520;a:2:{s:5:\"gc_id\";s:3:\"520\";s:7:\"gc_name\";s:12:\"彩妆组合\";}i:521;a:2:{s:5:\"gc_id\";s:3:\"521\";s:7:\"gc_name\";s:6:\"卸妆\";}i:522;a:2:{s:5:\"gc_id\";s:3:\"522\";s:7:\"gc_name\";s:6:\"美甲\";}i:523;a:2:{s:5:\"gc_id\";s:3:\"523\";s:7:\"gc_name\";s:12:\"彩妆工具\";}i:524;a:2:{s:5:\"gc_id\";s:3:\"524\";s:7:\"gc_name\";s:6:\"假发\";}}}}','频道顶部分类'),(602,601,'array','channel_slide','a:1:{i:1;a:5:{s:5:\"color\";s:7:\"#fa0d45\";s:8:\"pic_name\";s:0:\"\";s:7:\"pic_url\";s:22:\"/mall\";s:6:\"pic_id\";s:1:\"1\";s:7:\"pic_img\";s:37:\"mall/editor/channel-601-602-1.jpg?238\";}}','频道顶部切换'),(603,601,'array','channel_adv','a:1:{i:1;a:1:{s:8:\"pic_list\";a:3:{i:1;a:4:{s:6:\"pic_id\";s:1:\"1\";s:8:\"pic_name\";s:0:\"\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:39:\"mall/editor/channel-601-603-1-1.jpg?650\";}i:2;a:4:{s:6:\"pic_id\";s:1:\"2\";s:8:\"pic_name\";s:0:\"\";s:7:\"pic_url\";s:0:\"\";s:7:\"pic_img\";s:39:\"mall/editor/channel-601-603-1-2.jpg?546\";}i:3;a:4:{s:8:\"pic_name\";s:0:\"\";s:7:\"pic_url\";s:0:\"\";s:6:\"pic_id\";s:1:\"3\";s:7:\"pic_img\";s:39:\"mall/editor/channel-601-603-1-3.jpg?445\";}}}}','频道顶部广告'),(611,610,'array','channel_tit','a:3:{s:3:\"pic\";s:0:\"\";s:3:\"url\";s:0:\"\";s:5:\"title\";s:12:\"面部护理\";}','频道中部标题'),(612,610,'array','channel_act','a:4:{s:3:\"pic\";s:35:\"mall/editor/channel-610-612.jpg?113\";s:4:\"type\";s:3:\"pic\";s:5:\"title\";s:0:\"\";s:3:\"url\";s:0:\"\";}','频道中部活动'),(613,610,'array','recommend_list','a:1:{i:1;a:2:{s:9:\"recommend\";a:1:{s:4:\"name\";s:12:\"商品推荐\";}s:10:\"goods_list\";a:8:{i:100139;a:5:{s:8:\"goods_id\";s:6:\"100139\";s:12:\"market_price\";s:5:\"98.00\";s:10:\"goods_name\";s:75:\"比姿 初学美妆裸妆淡妆化妆品 百搭彩妆4件套BB霜-小麦色\";s:11:\"goods_price\";s:5:\"98.00\";s:9:\"goods_pic\";s:57:\"mall/store/goods/1/1_000000000126091786_1_800x800_240.jpg\";}i:100138;a:5:{s:8:\"goods_id\";s:6:\"100138\";s:12:\"market_price\";s:5:\"58.00\";s:10:\"goods_name\";s:45:\"VOCE格调彩妆套装彩妆盘56.5g-2#防水\";s:11:\"goods_price\";s:5:\"58.00\";s:9:\"goods_pic\";s:57:\"mall/store/goods/1/1_000000000106321832_1_800x800_240.jpg\";}i:100137;a:5:{s:8:\"goods_id\";s:6:\"100137\";s:12:\"market_price\";s:5:\"48.00\";s:10:\"goods_name\";s:82:\"卡姿兰明星品美妆4件超值组（蜗牛BB霜5ml+浓卷丰1+2睫毛膏3g+焕\";s:11:\"goods_price\";s:5:\"48.00\";s:9:\"goods_pic\";s:57:\"mall/store/goods/1/1_000000000107916490_1_800x800_240.jpg\";}i:100141;a:5:{s:8:\"goods_id\";s:6:\"100141\";s:12:\"market_price\";s:5:\"98.00\";s:10:\"goods_name\";s:75:\"比姿 初学美妆裸妆淡妆化妆品 百搭彩妆4件套BB霜-象牙白\";s:11:\"goods_price\";s:5:\"98.00\";s:9:\"goods_pic\";s:57:\"mall/store/goods/1/1_000000000126092476_1_800x800_240.jpg\";}i:100128;a:5:{s:8:\"goods_id\";s:6:\"100128\";s:12:\"market_price\";s:5:\"49.00\";s:10:\"goods_name\";s:71:\"VOCE焦点彩妆套装全套组合3件套-美妆套装工具化妆盘1#\";s:11:\"goods_price\";s:5:\"49.00\";s:9:\"goods_pic\";s:57:\"mall/store/goods/1/1_000000000120770311_1_800x800_240.jpg\";}i:100127;a:5:{s:8:\"goods_id\";s:6:\"100127\";s:12:\"market_price\";s:5:\"69.00\";s:10:\"goods_name\";s:85:\"HEXZE/韩熙贞 彩妆经典四件套装初学美妆裸妆淡妆化妆品807高贵红\";s:11:\"goods_price\";s:5:\"69.00\";s:9:\"goods_pic\";s:57:\"mall/store/goods/1/1_000000000124788748_1_800x800_240.jpg\";}i:100126;a:5:{s:8:\"goods_id\";s:6:\"100126\";s:12:\"market_price\";s:6:\"159.00\";s:10:\"goods_name\";s:78:\"韩熙贞 彩妆套装全套组合 初学者裸妆淡妆化妆品套装 美妆\";s:11:\"goods_price\";s:6:\"159.00\";s:9:\"goods_pic\";s:57:\"mall/store/goods/1/1_000000000124815472_1_800x800_240.jpg\";}i:100125;a:5:{s:8:\"goods_id\";s:6:\"100125\";s:12:\"market_price\";s:5:\"98.00\";s:10:\"goods_name\";s:76:\"比姿 初学美妆裸妆淡妆化妆品 百搭彩妆4件套BB霜--浅紫色\";s:11:\"goods_price\";s:5:\"98.00\";s:9:\"goods_pic\";s:57:\"mall/store/goods/1/1_000000000126092196_1_800x800_240.jpg\";}}}}','频道中部商品'),(617,610,'array','adv_a','a:3:{s:8:\"pic_name\";s:0:\"\";s:3:\"pic\";s:35:\"mall/editor/channel-610-617.jpg?808\";s:7:\"pic_url\";s:0:\"\";}','频道中部广告1'),(618,610,'array','adv_b','a:3:{s:8:\"pic_name\";s:0:\"\";s:3:\"pic\";s:35:\"mall/editor/channel-610-618.jpg?629\";s:7:\"pic_url\";s:0:\"\";}','频道中部广告2'),(619,610,'array','adv_c','a:3:{s:8:\"pic_name\";s:0:\"\";s:3:\"pic\";s:35:\"mall/editor/channel-610-619.jpg?205\";s:7:\"pic_url\";s:0:\"\";}','频道中部广告3');

/*Table structure for table `feiwa_web_code_copy` */

DROP TABLE IF EXISTS `feiwa_web_code_copy`;

CREATE TABLE `feiwa_web_code_copy` (
  `code_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '内容ID',
  `web_id` int(10) unsigned NOT NULL COMMENT '模块ID',
  `code_type` varchar(10) NOT NULL DEFAULT 'array' COMMENT '数据类型:array,html,json',
  `var_name` varchar(20) NOT NULL DEFAULT '' COMMENT '变量名称',
  `code_info` text COMMENT '内容数据',
  `show_name` varchar(20) DEFAULT '' COMMENT '页面名称',
  PRIMARY KEY (`code_id`),
  KEY `web_id` (`web_id`)
) ENGINE=InnoDB AUTO_INCREMENT=620 DEFAULT CHARSET=utf8 COMMENT='模块内容表';

/*Data for the table `feiwa_web_code_copy` */

insert  into `feiwa_web_code_copy`(`code_id`,`web_id`,`code_type`,`var_name`,`code_info`,`show_name`) values (11,1,'array','tit','','标题图片'),(12,1,'array','category_list','','推荐分类'),(13,1,'array','act','','活动图片'),(15,1,'array','recommend_list','','商品推荐'),(18,1,'array','adv','','广告图片'),(19,1,'array','brand_list','','品牌推荐'),(21,2,'array','tit','','标题图片'),(22,2,'array','category_list','','推荐分类'),(23,2,'array','act','','活动图片'),(25,2,'array','recommend_list','','商品推荐'),(28,2,'array','adv','','广告图片'),(29,2,'array','brand_list','','品牌推荐'),(31,3,'array','tit','','标题图片'),(32,3,'array','category_list','','推荐分类'),(33,3,'array','act','','活动图片'),(35,3,'array','recommend_list','','商品推荐'),(38,3,'array','adv','','广告图片'),(39,3,'array','brand_list','','品牌推荐'),(41,4,'array','tit','','标题图片'),(42,4,'array','category_list','','推荐分类'),(43,4,'array','act','','活动图片'),(45,4,'array','recommend_list','','商品推荐'),(48,4,'array','adv','','广告图片'),(49,4,'array','brand_list','','品牌推荐'),(51,5,'array','tit','','标题图片'),(52,5,'array','category_list','','推荐分类'),(53,5,'array','act','','活动图片'),(55,5,'array','recommend_list','','商品推荐'),(58,5,'array','adv','','广告图片'),(59,5,'array','brand_list','','品牌推荐'),(61,6,'array','tit','','标题图片'),(62,6,'array','category_list','','活动图片'),(63,6,'array','act','','活动图片'),(65,6,'array','recommend_list','','商品推荐'),(68,6,'array','adv','','广告图片'),(69,6,'array','brand_list','','品牌推荐'),(71,7,'array','tit','','标题图片'),(72,7,'array','category_list','','推荐分类'),(73,7,'array','act','','活动图片'),(75,7,'array','recommend_list','','商品推荐'),(78,7,'array','adv','','广告图片'),(79,7,'array','brand_list','','品牌推荐'),(81,8,'array','tit','','标题图片'),(82,8,'array','category_list','','推荐分类'),(83,8,'array','act','','活动图片'),(85,8,'array','recommend_list','','商品推荐'),(88,8,'array','adv','','广告图片'),(89,8,'array','brand_list','','品牌推荐'),(101,101,'array','screen_list','','切换大图'),(102,101,'array','focus_list','','切换小图'),(121,121,'array','sale_list','','促销区'),(601,601,'array','channel_category','','频道顶部分类'),(602,601,'array','channel_slide','','频道顶部切换'),(603,601,'array','channel_adv','','频道顶部广告'),(611,610,'array','channel_tit','','频道中部标题'),(612,610,'array','channel_act','','频道中部活动'),(613,610,'array','recommend_list','','频道中部商品'),(617,610,'array','adv_a','','频道中部广告1'),(618,610,'array','adv_b','','频道中部广告2'),(619,610,'array','adv_c','','频道中部广告3');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
