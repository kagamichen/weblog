/*
 Navicat Premium Data Transfer

 Source Server         : chen_mac
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : weblog

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 22/03/2020 19:47:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `creationtime` date DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `column_id` int DEFAULT NULL,
  `body` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article
-- ----------------------------
BEGIN;
INSERT INTO `article` VALUES (1, 'Spring Boot', '2020-02-09', '陈登宝', 1, '<p>Spring Boot 测试</p>');
INSERT INTO `article` VALUES (2, 'test', '2020-02-19', 'chen', 1, '<p>test</p>');
INSERT INTO `article` VALUES (4, 'security开发跨域问题', '2020-02-19', '陈登宝', 1, '<p><span style=\"background-color: rgb(139, 170, 74);\">最好在vue开发环境中，否则可能会出现登陆之后其他api302（估计是session在跨域中丢失）</span></p><p><span style=\"background-color: rgb(139, 170, 74);\"><br></span></p><p>在package.json同级创建vue.config.js</p><p><br></p><div><span style=\"background-color: rgb(77, 128, 191);\"><span>let</span><span> </span><span>proxyobj</span><span>={};</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>proxyobj</span><span>[</span><span>\'/\'</span><span>]={</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>  </span><span>ws:</span><span>false</span><span> ,</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>  </span><span>target:</span><span>\'http://localhost:8090\'</span><span>,</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>  </span><span>changeOrigin:</span><span>true</span><span>,</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>  </span><span>pathRewrite:</span><span>{</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>     </span><span>\'^/\'</span><span>:</span><span>\'\'</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\">  }</span></div><div><span style=\"background-color: rgb(77, 128, 191);\">}</span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span> </span><span>module</span><span>.</span><span>exports</span><span>={</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>  </span><span>devServer:</span><span>{</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>    </span><span>host:</span><span>\'localhost\'</span><span>,</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>    </span><span>port:</span><span>8080</span><span>,</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>    </span><span>proxy:proxyobj</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\">  }</span></div><div><span style=\"background-color: rgb(77, 128, 191);\"> }</span></div><p><divcourier new\',=\"\" monospace;font-weight:=\"\" normal;font-size:=\"\" 14px;line-height:=\"\" 21px;white-space:=\"\" pre;\"=\"\"><br></divcourier></p>');
INSERT INTO `article` VALUES (6, 'Vue.js', '2020-03-09', 'chen', 1, '<p>前端工程管理框架</p>');
COMMIT;

-- ----------------------------
-- Table structure for article_column
-- ----------------------------
DROP TABLE IF EXISTS `article_column`;
CREATE TABLE `article_column` (
  `column` varchar(255) DEFAULT NULL,
  `cid` int NOT NULL AUTO_INCREMENT,
  `updatetime` date DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_column
-- ----------------------------
BEGIN;
INSERT INTO `article_column` VALUES ('技术分享', 1, '2020-02-09');
INSERT INTO `article_column` VALUES ('情感生活', 2, '2020-02-09');
COMMIT;

-- ----------------------------
-- Table structure for Comments
-- ----------------------------
DROP TABLE IF EXISTS `Comments`;
CREATE TABLE `Comments` (
  `pid` int NOT NULL AUTO_INCREMENT,
  `aid` int DEFAULT NULL,
  `Commenttime` date DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Comments
-- ----------------------------
BEGIN;
INSERT INTO `Comments` VALUES (1, 1, '2020-02-14', '666', 'test1');
COMMIT;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pattern` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
BEGIN;
INSERT INTO `menu` VALUES (1, '/home');
INSERT INTO `menu` VALUES (2, '/article/**');
INSERT INTO `menu` VALUES (3, '/column/**');
INSERT INTO `menu` VALUES (4, '/comment/**');
INSERT INTO `menu` VALUES (5, '/submit/**');
INSERT INTO `menu` VALUES (6, '/userset/**');
INSERT INTO `menu` VALUES (7, '/userRegister/**');
COMMIT;

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mid` int DEFAULT NULL,
  `rid` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu_role
-- ----------------------------
BEGIN;
INSERT INTO `menu_role` VALUES (10, 1, 3);
INSERT INTO `menu_role` VALUES (12, 5, 3);
INSERT INTO `menu_role` VALUES (13, 1, 1);
INSERT INTO `menu_role` VALUES (14, 2, 1);
INSERT INTO `menu_role` VALUES (15, 3, 1);
INSERT INTO `menu_role` VALUES (16, 4, 1);
INSERT INTO `menu_role` VALUES (17, 5, 1);
INSERT INTO `menu_role` VALUES (18, 6, 1);
INSERT INTO `menu_role` VALUES (19, 7, 1);
INSERT INTO `menu_role` VALUES (20, 1, 2);
INSERT INTO `menu_role` VALUES (21, 2, 2);
INSERT INTO `menu_role` VALUES (22, 3, 2);
INSERT INTO `menu_role` VALUES (23, 4, 2);
INSERT INTO `menu_role` VALUES (24, 5, 2);
INSERT INTO `menu_role` VALUES (25, 2, 3);
COMMIT;

-- ----------------------------
-- Table structure for Nav
-- ----------------------------
DROP TABLE IF EXISTS `Nav`;
CREATE TABLE `Nav` (
  `nav_id` int NOT NULL AUTO_INCREMENT,
  `nav_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`nav_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Nav
-- ----------------------------
BEGIN;
INSERT INTO `Nav` VALUES (1, '文章管理');
INSERT INTO `Nav` VALUES (2, '用户管理');
INSERT INTO `Nav` VALUES (3, '评论管理');
INSERT INTO `Nav` VALUES (4, '栏目管理');
COMMIT;

-- ----------------------------
-- Table structure for Nav_second
-- ----------------------------
DROP TABLE IF EXISTS `Nav_second`;
CREATE TABLE `Nav_second` (
  `nav_id` int NOT NULL,
  `nav_Second_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`nav_Second_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Nav_second
-- ----------------------------
BEGIN;
INSERT INTO `Nav_second` VALUES (1, '提交文章', 'publishedListOf');
INSERT INTO `Nav_second` VALUES (1, '文章列表', '/articleLists');
INSERT INTO `Nav_second` VALUES (4, '栏目相关', '/column');
INSERT INTO `Nav_second` VALUES (2, '用户注册', '/userRegister');
INSERT INTO `Nav_second` VALUES (2, '用户设置', '/userset');
INSERT INTO `Nav_second` VALUES (3, '评论列表', '/comment');
COMMIT;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `namezh` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO `role` VALUES (1, 'ROLE_root', '权限管理员');
INSERT INTO `role` VALUES (2, 'ROLE_admin', '普通管理员');
INSERT INTO `role` VALUES (3, 'ROLE_user', '用户');
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(32) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `locked` tinyint(1) DEFAULT NULL,
  `realname` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `phone` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, 'root', '123', 1, 0, '张剑锋', '123456');
INSERT INTO `user` VALUES (2, 'admin', '123', 1, 0, '张无忌', '98765');
INSERT INTO `user` VALUES (3, 'chen', '123', 1, 0, '陈登宝', '13003968261');
INSERT INTO `user` VALUES (16, 'igs', '123', 1, 0, 'haha', '13003968261');
INSERT INTO `user` VALUES (17, 'test1', '123', 1, 0, '张三丰', '13003968261');
INSERT INTO `user` VALUES (19, 'test2', '123', 1, 0, '张三丰', '13003968261');
INSERT INTO `user` VALUES (20, 'test3', '123', 1, 0, '张三丰', '13003968261');
INSERT INTO `user` VALUES (21, 'test4', '123', 1, 0, '张无忌', '13003968261');
INSERT INTO `user` VALUES (22, 'test5', '123', 1, 0, '张无忌', '13003968261');
INSERT INTO `user` VALUES (23, 'test6', '123', 1, 0, '张无忌', '13003968261');
INSERT INTO `user` VALUES (24, 'test8', '123', 1, 0, '张无忌', '13003968261');
COMMIT;

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL,
  `rid` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
BEGIN;
INSERT INTO `user_role` VALUES (1, 1, 1);
INSERT INTO `user_role` VALUES (2, 2, 2);
INSERT INTO `user_role` VALUES (3, 3, 3);
INSERT INTO `user_role` VALUES (11, 6, 3);
INSERT INTO `user_role` VALUES (14, 16, 3);
INSERT INTO `user_role` VALUES (15, 17, 2);
INSERT INTO `user_role` VALUES (16, 19, 2);
INSERT INTO `user_role` VALUES (17, 20, 2);
INSERT INTO `user_role` VALUES (18, 21, 3);
INSERT INTO `user_role` VALUES (19, 22, 3);
INSERT INTO `user_role` VALUES (20, 23, 3);
INSERT INTO `user_role` VALUES (21, 24, 3);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
