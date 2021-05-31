/*
Navicat MySQL Data Transfer

Source Server         : MySql
Source Server Version : 50550
Source Host           : localhost:3306
Source Database       : shop

Target Server Type    : MYSQL
Target Server Version : 50550
File Encoding         : 65001

Date: 2021-05-21 21:23:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ausertable
-- ----------------------------
DROP TABLE IF EXISTS `ausertable`;
CREATE TABLE `ausertable` (
  `aname` varchar(50) NOT NULL COMMENT '管理员用户名',
  `apwd` varchar(50) NOT NULL COMMENT '管理员密码',
  PRIMARY KEY (`aname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员用户信息表';

-- ----------------------------
-- Records of ausertable
-- ----------------------------
INSERT INTO `ausertable` VALUES ('123456', '123456');
INSERT INTO `ausertable` VALUES ('admin', 'admin');

-- ----------------------------
-- Table structure for busertable
-- ----------------------------
DROP TABLE IF EXISTS `busertable`;
CREATE TABLE `busertable` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `bemail` varchar(50) NOT NULL COMMENT '用户邮箱',
  `bpwd` varchar(50) NOT NULL COMMENT '用户密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of busertable
-- ----------------------------

-- ----------------------------
-- Table structure for carttalbe
-- ----------------------------
DROP TABLE IF EXISTS `carttalbe`;
CREATE TABLE `carttalbe` (
  `id` int(11) NOT NULL COMMENT '购物车ID',
  `busertable_id` int(11) NOT NULL COMMENT '购物车用户ID',
  `goodstable_id` int(11) NOT NULL COMMENT '购物车商品编号',
  `shoppingnum` int(11) NOT NULL COMMENT '购买数量',
  PRIMARY KEY (`id`),
  KEY `cbu` (`busertable_id`),
  KEY `cg` (`goodstable_id`),
  CONSTRAINT `cg` FOREIGN KEY (`goodstable_id`) REFERENCES `goodstable` (`id`),
  CONSTRAINT `cbu` FOREIGN KEY (`busertable_id`) REFERENCES `busertable` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购物车信息表';

-- ----------------------------
-- Records of carttalbe
-- ----------------------------

-- ----------------------------
-- Table structure for focustable
-- ----------------------------
DROP TABLE IF EXISTS `focustable`;
CREATE TABLE `focustable` (
  `id` int(11) NOT NULL COMMENT '商品关注ID',
  `busertable_id` int(11) NOT NULL COMMENT '商品关注用户ID',
  `goodstable_id` int(11) NOT NULL COMMENT '商品关注商品编号',
  `focustime` date NOT NULL COMMENT '购买数量',
  PRIMARY KEY (`id`),
  KEY `cbu` (`busertable_id`),
  KEY `cg` (`goodstable_id`),
  CONSTRAINT `focustable_ibfk_1` FOREIGN KEY (`goodstable_id`) REFERENCES `goodstable` (`id`),
  CONSTRAINT `focustable_ibfk_2` FOREIGN KEY (`busertable_id`) REFERENCES `busertable` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of focustable
-- ----------------------------

-- ----------------------------
-- Table structure for goodstable
-- ----------------------------
DROP TABLE IF EXISTS `goodstable`;
CREATE TABLE `goodstable` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `gname` varchar(50) NOT NULL COMMENT '商品名称',
  `goprice` double NOT NULL COMMENT '商品原价',
  `grprice` double NOT NULL COMMENT '商品现价',
  `gstore` int(11) NOT NULL COMMENT '商品库存',
  `gpricture` varchar(50) DEFAULT NULL COMMENT '商品图片',
  `goodstype_id` int(11) NOT NULL COMMENT '商品类型',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `goodstype_id` (`goodstype_id`),
  CONSTRAINT `goodstable_ibfk_1` FOREIGN KEY (`goodstype_id`) REFERENCES `goodtype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品信息表';

-- ----------------------------
-- Records of goodstable
-- ----------------------------

-- ----------------------------
-- Table structure for goodtype
-- ----------------------------
DROP TABLE IF EXISTS `goodtype`;
CREATE TABLE `goodtype` (
  `id` int(11) NOT NULL,
  `typename` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goodtype
-- ----------------------------

-- ----------------------------
-- Table structure for noticetable
-- ----------------------------
DROP TABLE IF EXISTS `noticetable`;
CREATE TABLE `noticetable` (
  `id` int(11) NOT NULL COMMENT '公告ID',
  `ntile` varchar(100) NOT NULL COMMENT '公告标题',
  `ncontent` varchar(500) NOT NULL COMMENT '公告内容',
  `ntime` datetime DEFAULT NULL COMMENT '公告时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公告表';

-- ----------------------------
-- Records of noticetable
-- ----------------------------

-- ----------------------------
-- Table structure for orderbasetable
-- ----------------------------
DROP TABLE IF EXISTS `orderbasetable`;
CREATE TABLE `orderbasetable` (
  `id` int(11) NOT NULL COMMENT '订单ID',
  `busertable_id` int(11) NOT NULL COMMENT '用户ID',
  `amount` double NOT NULL COMMENT '订单金额',
  `status` tinyint(4) NOT NULL COMMENT '订单状态',
  `orderdate` datetime NOT NULL COMMENT '下单时间',
  PRIMARY KEY (`id`),
  KEY `busertable_id` (`busertable_id`),
  CONSTRAINT `orderbasetable_ibfk_1` FOREIGN KEY (`busertable_id`) REFERENCES `busertable` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单基础表';

-- ----------------------------
-- Records of orderbasetable
-- ----------------------------

-- ----------------------------
-- Table structure for orderdetail
-- ----------------------------
DROP TABLE IF EXISTS `orderdetail`;
CREATE TABLE `orderdetail` (
  `id` int(11) NOT NULL COMMENT '订单详情ID',
  `orderbasetable_id` int(11) NOT NULL COMMENT '订单编号',
  `goodtable_id` int(11) NOT NULL COMMENT '商品编号',
  `shoppingnum` int(11) NOT NULL COMMENT '购买数量',
  PRIMARY KEY (`id`),
  KEY `orderbasetable_id` (`orderbasetable_id`),
  KEY `goodtable_id` (`goodtable_id`),
  CONSTRAINT `orderdetail_ibfk_1` FOREIGN KEY (`orderbasetable_id`) REFERENCES `orderbasetable` (`id`),
  CONSTRAINT `orderdetail_ibfk_2` FOREIGN KEY (`goodtable_id`) REFERENCES `goodstable` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单详情表';

-- ----------------------------
-- Records of orderdetail
-- ----------------------------
