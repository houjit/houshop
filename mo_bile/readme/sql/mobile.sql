INSERT INTO  `#__setting` (`name`, `value`) VALUES ('mobile_isuse', '1');
INSERT INTO  `#__setting` (`name`, `value`) VALUES ('mobile_app', 'mb_app.png');
INSERT INTO  `#__setting` (`name`, `value`) VALUES ('mobile_apk', '');
INSERT INTO  `#__setting` (`name`, `value`) VALUES ('mobile_apk_version', '3.0');
INSERT INTO  `#__setting` (`name`, `value`) VALUES ('mobile_ios', '');
INSERT INTO  `#__setting` (`name`, `value`) VALUES ('mobile_wx',NULL);

CREATE TABLE  `#__mb_category` (
  `gc_id` smallint(5) unsigned DEFAULT NULL COMMENT '商城系统的分类ID',
  `gc_thumb` varchar(150) DEFAULT NULL COMMENT '缩略图',
  PRIMARY KEY (`gc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='一级分类缩略图[手机端]';

INSERT INTO  `#__mb_category` VALUES 
(1, '04890563322151999.png'),
(2, '04890563422383990.png'),
(3, '04890563504528679.png'),
(256, '04890563696273833.png'),
(308, '04890563795020268.png'),
(470, '04890563899590392.png'),
(530, '04890564008326975.png'),
(593, '04890564117641665.png'),
(662, '04890564217197194.png'),
(730, '04890564337411152.png'),
(825, '04890564448947743.png'),
(888, '04890564563319438.png'),
(959, '04890564663651232.png'),
(1037, '04890564750587950.png');

CREATE TABLE  `#__mb_feedback` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(500) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL COMMENT '1来自手机端2来自PC端',
  `ftime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '反馈时间',
  `member_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `member_name` varchar(50) NOT NULL COMMENT '用户名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='意见反馈';

CREATE TABLE `#__mb_payment` (
  `payment_id` tinyint(1) unsigned NOT NULL COMMENT '支付索引id',
  `payment_code` varchar(15) NOT NULL COMMENT '支付代码名称',
  `payment_name` char(10) NOT NULL COMMENT '支付名称',
  `payment_config` varchar(2000) DEFAULT NULL COMMENT '支付接口配置信息',
  `payment_state` enum('0','1') NOT NULL DEFAULT '0' COMMENT '接口状态0禁用1启用',
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机支付方式表';

INSERT INTO `#__mb_payment` (`payment_id`, `payment_code`, `payment_name`, `payment_config`, `payment_state`) VALUES
(1, 'alipay', '支付宝', '', '0'),
(2, 'wxpay', '微信支付', '', '0'),
(3, 'wxpay_jsapi', '微信支付JSAPI', '', '0'),
(4, 'alipay_native', '支付宝移动支付', '', '0');

CREATE TABLE  `#__mb_seller_token` (
  `token_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '令牌编号',
  `seller_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `seller_name` varchar(50) NOT NULL COMMENT '用户名',
  `token` varchar(50) NOT NULL COMMENT '登录令牌',
  `login_time` int(10) unsigned NOT NULL COMMENT '登录时间',
  `client_type` varchar(10) NOT NULL COMMENT '客户端类型 windows',
  PRIMARY KEY (`token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户端商家登录令牌表';

CREATE TABLE  `#__mb_special` (
  `special_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '专题编号',
  `special_desc` varchar(20) NOT NULL COMMENT '专题描述',
  PRIMARY KEY (`special_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机专题表';

CREATE TABLE  `#__mb_special_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '专题项目编号',
  `special_id` int(10) unsigned NOT NULL COMMENT '专题编号',
  `item_type` varchar(50) NOT NULL COMMENT '项目类型',
  `item_data` varchar(2000) NULL DEFAULT '' COMMENT '项目内容',
  `item_usable` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '项目是否可用 0-不可用 1-可用',
  `item_sort` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '项目排序',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机专题项目表';

CREATE TABLE  `#__mb_user_token` (
  `token_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '令牌编号',
  `member_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `member_name` varchar(50) NOT NULL COMMENT '用户名',
  `token` varchar(50) NOT NULL COMMENT '登录令牌',
  `login_time` int(10) unsigned NOT NULL COMMENT '登录时间',
  `client_type` varchar(10) NOT NULL COMMENT '客户端类型 android wap',
  `openid` varchar(50) NULL COMMENT '微信支付jsapi的openid缓存',
  PRIMARY KEY (`token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='移动端登录令牌表';
