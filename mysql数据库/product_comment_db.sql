/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : product_comment_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2019-06-11 23:28:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_leaveword`
-- ----------------------------
DROP TABLE IF EXISTS `t_leaveword`;
CREATE TABLE `t_leaveword` (
  `leaveWordId` int(11) NOT NULL auto_increment COMMENT '留言id',
  `leaveTitle` varchar(80) NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000) NOT NULL COMMENT '留言内容',
  `userObj` varchar(30) NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20) default NULL COMMENT '留言时间',
  `replyContent` varchar(1000) default NULL COMMENT '管理回复',
  `replyTime` varchar(20) default NULL COMMENT '回复时间',
  PRIMARY KEY  (`leaveWordId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_leaveword_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_leaveword
-- ----------------------------
INSERT INTO `t_leaveword` VALUES ('1', '哇塞这个网站好好看', '这里好多的小说，我超喜欢看', 'user1', '2019-06-09 22:30:20', '你喜欢就行！', '2019-06-09 22:30:25');
INSERT INTO `t_leaveword` VALUES ('2', '管理我想看计算机书籍', '多上架一些计算机相关的书籍，好吗', 'user1', '2019-06-11 18:12:02', '--', '--');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL auto_increment COMMENT '公告id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `content` varchar(5000) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '图书书评网站平台开通了', '<p>在这里你可以看到你喜欢的图书，同时可以评论你的读书心得哦，你的评价是我们前进的动力哦！</p>', '2019-06-09 22:30:32');

-- ----------------------------
-- Table structure for `t_product`
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `productId` int(11) NOT NULL auto_increment COMMENT '图书id',
  `productClassObj` int(11) NOT NULL COMMENT '图书分类',
  `productName` varchar(20) NOT NULL COMMENT '图书名称',
  `productPhoto` varchar(60) NOT NULL COMMENT '图书图片',
  `author` varchar(20) NOT NULL COMMENT '作者',
  `publish` varchar(20) NOT NULL COMMENT '出版社',
  `publishDate` varchar(20) default NULL COMMENT '出版日期',
  `pageNum` int(11) NOT NULL COMMENT '页数',
  `wordNum` varchar(20) NOT NULL COMMENT '字数',
  `isbn` varchar(20) NOT NULL COMMENT 'ISBN',
  `productPrice` float NOT NULL COMMENT '图书定价',
  `productDesc` varchar(8000) NOT NULL COMMENT '图书简介',
  `productFile` varchar(60) NOT NULL COMMENT '图书文件',
  `recommandFlag` varchar(20) NOT NULL COMMENT '是否推荐',
  `productScore` float NOT NULL COMMENT '图书评分',
  `addTime` varchar(20) default NULL COMMENT '添加时间',
  PRIMARY KEY  (`productId`),
  KEY `productClassObj` (`productClassObj`),
  CONSTRAINT `t_product_ibfk_1` FOREIGN KEY (`productClassObj`) REFERENCES `t_productclass` (`productClassId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('1', '1', '天龙八部', 'upload/9a62fc0e-c857-406f-9652-8f056afc25b9.jpg', '河西', '人民教育出版社', '2019-06-09', '1092', '37000', '514156161515', '28.5', '<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; word-wrap: break-word; font-size: 14px; line-height: 24px; text-indent: 2em; min-height: 24px;\">“天龙八部”是佛经中常见的“护法神”。八部者，一天、二龙、三夜叉、四乾闼婆、五阿修罗、六迦楼罗、七紧那罗、八摩睺罗伽。诸天和龙神为八部众的上首，故称“天龙八部”。金庸先生写过一部风靡一时的小说就叫《天龙八部》，这部书则从佛教和神话学的角度重新审视这八种佛教护法神，分析他们的背景、成因和谱系源流。作者是不是佛教徒并不重要，会让读者感兴趣的除了佛教知识，还有弥漫于种种稀奇古怪的神话故事中的神秘主义。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; word-wrap: break-word; font-size: 14px; line-height: 24px; text-indent: 2em; min-height: 24px;\">一部博尔赫斯《想像中的动物》似的神怪研究著作，带你进入一个佛教与文学的奇幻世界。魑魅魍魉、牛鬼蛇神，佛陀慈悲、众生轮回，天龙八部，佛教的八大护法神，在漫长的历史长河中，发展着他们自己的传说。作者博览经书古籍，搜集神迹，结成此集，谈佛法、谈传奇、谈虚幻世界中的往生与幻灭。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; word-wrap: break-word; font-size: 14px; line-height: 24px; text-indent: 2em; min-height: 24px;\">河西，上海青年作家、学者，在《天涯》、《读书》、《花城》、《大家》、《山花》、《字花》（香港）等刊物上发表小说、评论、翻译、诗歌200余万字，有著作多部</p><p><br/></p>', 'upload/b7a3dbc9-3eba-431a-ac3b-981f8c7555fd.pdf', '是', '9', '2019-06-09 22:28:33');
INSERT INTO `t_product` VALUES ('2', '4', 'Python编程：从入门到实践', 'upload/6aafd8b6-903a-4769-a63f-7b9cfde51a28.jpg', '袁国忠', '人民邮电出版社', '2019-06-05', '325', '292000', '65141951415', '58.5', '<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; word-wrap: break-word; font-size: 14px; line-height: 24px; text-indent: 2em; min-height: 24px;\">本书是一本针对所有层次的Python读者而作的Python入门书。全书分两部分：第一部分介绍用Python编程所必须了解的基本概念，包括matplotlib、NumPy和Pygal等强大的Python库和工具介绍，以及列表、字典、if语句、类、文件与异常、代码测试等内容；第二部分将理论付诸实践，讲解如何开发三个项目，包括简单的Python 2D游戏开发如何利用数据生成交互式的信息图，以及创建和定制简单的Web应用，并帮读者解决常见编程问题和困惑。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; word-wrap: break-word; font-size: 14px; line-height: 24px; text-indent: 2em; min-height: 24px;\">Eric Matthes</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; word-wrap: break-word; font-size: 14px; line-height: 24px; text-indent: 2em; min-height: 24px;\">高中科学和数学老师，现居住在阿拉斯加，在当地讲授Python入门课程。他从5岁开始就一直在编写程序。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; word-wrap: break-word; font-size: 14px; line-height: 24px; text-indent: 2em; min-height: 24px;\">袁国忠</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; word-wrap: break-word; font-size: 14px; line-height: 24px; text-indent: 2em; min-height: 24px;\">自由译者；2000年起专事翻译，主译图书，偶译新闻稿、软文；出版译著40余部，其中包括《C++ Prime Plus中文版》《CCNA学习指南》《CCNP ROUTE学习指南》《面向模式的软件架构：模式系统》《Android应用UI设计模式》《风投的选择：谁是下一个十亿美元级公司》等，总计700余万字；专事翻译前，从事过三年化工产品分析和开发，做过两年杂志和图书编辑。</p><p><br/></p>', '', '是', '8', '2019-06-11 22:52:35');
INSERT INTO `t_product` VALUES ('3', '1', '追风筝的人', 'upload/30e6b3ff-26ea-48cc-96c7-06fe307d45c4.jpg', '李继宏', '上海人民出版社', '2019-06-07', '360', '约 195,000 字', '9787208061644', '29', '<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; word-wrap: break-word; font-size: 14px; line-height: 24px; text-indent: 2em; min-height: 24px;\">2013年，小说《追风筝的人》出版整整十年。书中那句“为你，千千万万遍”感动了无数中国读者。8月，胡赛尼暌违六年的新作《群山回唱》中文版即将问世。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; word-wrap: break-word; font-size: 14px; line-height: 24px; text-indent: 2em; min-height: 24px;\">★一个阿富汗作家的处女作</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; word-wrap: break-word; font-size: 14px; line-height: 24px; text-indent: 2em; min-height: 24px;\">★一部以史诗般的历史景观和荡气回肠的人性故事，深深地打动全世界各地亿万读者心的文学经典。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; word-wrap: break-word; font-size: 14px; line-height: 24px; text-indent: 2em; min-height: 24px;\">“许多年过去了，人们说陈年旧事可以被埋葬，然而我终于明白这是错的，因为往事会自行爬上来。回首前尘，我意识到在过去二十六年里，自己始终在窥视着那荒芜的小径。”</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; word-wrap: break-word; font-size: 14px; line-height: 24px; text-indent: 2em; min-height: 24px;\">12岁的阿富汗富家少爷阿米尔与仆人哈桑情同手足。然而，在一场风筝比赛后，发生了一件悲惨不堪的事，阿米尔为自己的懦弱感到自责和痛苦，逼走了哈桑，不久，自己也跟随父亲逃往美国。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; word-wrap: break-word; font-size: 14px; line-height: 24px; text-indent: 2em; min-height: 24px;\">成年后的阿米尔始终无法原谅自己当年对哈桑的背叛。为了赎罪，阿米尔再度踏上暌违二十多年的故乡，希望能为不幸的好友尽最后一点心力，却发现一个惊天谎言，儿时的噩梦再度重演，阿米尔该如何抉择？</p><p><br/></p>', '', '是', '9', '2019-06-11 22:57:20');
INSERT INTO `t_product` VALUES ('4', '1', '张大小姐', 'upload/7a2de023-ee24-4daa-a25e-1da4502e6b6b.jpg', '[美] 洪晃', '浙江文艺出版社', '2019-06-04', '283', '约 126,000 字', '6520184134862', '58', '<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; word-wrap: break-word; font-size: 14px; line-height: 24px; text-indent: 2em; min-height: 24px;\">张燕是京城名媛，家庭显赫，又嫁了首富，自己和大学好友的公关公司也赚得金银满盘。有一天，张大小姐接到警方一个电话，说在河北一个叫半挂坡的村庄附近发现一具被乱刀砍死的尸体，死者面部已经被砍烂了，无法辨认。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; word-wrap: break-word; font-size: 14px; line-height: 24px; text-indent: 2em; min-height: 24px;\">只是在他身上找到一个纸条，上面写着张燕的手机号码。出于好奇，张大小姐就去验尸了，她万万没想到死者是她在纽约留学时候的初恋情人。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; word-wrap: break-word; font-size: 14px; line-height: 24px; text-indent: 2em; min-height: 24px;\">洪晃，媒体人、出版人。写过专栏，当过CEO（首席执行官），开过服装店，还演过两个电影、主持过两个电视节目。算是一个专业的不务正业人士。但是写字还算上心，出过三本散文集《我的非正常生活》、《无目的美好生活》和《廉价哲学》。《张大小姐》为第一本小说。</p><p><br/></p>', '', '是', '9.5', '2019-06-11 23:03:32');

-- ----------------------------
-- Table structure for `t_productclass`
-- ----------------------------
DROP TABLE IF EXISTS `t_productclass`;
CREATE TABLE `t_productclass` (
  `productClassId` int(11) NOT NULL auto_increment COMMENT '图书分类id',
  `productName` varchar(20) NOT NULL COMMENT '图书分类名称',
  PRIMARY KEY  (`productClassId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_productclass
-- ----------------------------
INSERT INTO `t_productclass` VALUES ('1', '小说');
INSERT INTO `t_productclass` VALUES ('2', '文学');
INSERT INTO `t_productclass` VALUES ('3', '经济管理');
INSERT INTO `t_productclass` VALUES ('4', '计算机与互联网');
INSERT INTO `t_productclass` VALUES ('5', '人文社科');

-- ----------------------------
-- Table structure for `t_productcomment`
-- ----------------------------
DROP TABLE IF EXISTS `t_productcomment`;
CREATE TABLE `t_productcomment` (
  `commentId` int(11) NOT NULL auto_increment COMMENT '评论id',
  `productObj` int(11) NOT NULL COMMENT '被评图书',
  `commentScore` float NOT NULL COMMENT '用户评分',
  `content` varchar(1000) NOT NULL COMMENT '评论内容',
  `userObj` varchar(30) NOT NULL COMMENT '评论用户',
  `commentTime` varchar(20) default NULL COMMENT '评论时间',
  PRIMARY KEY  (`commentId`),
  KEY `productObj` (`productObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_productcomment_ibfk_1` FOREIGN KEY (`productObj`) REFERENCES `t_product` (`productId`),
  CONSTRAINT `t_productcomment_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_productcomment
-- ----------------------------
INSERT INTO `t_productcomment` VALUES ('1', '1', '8', '个人感觉还可以，可以看呢', 'user1', '2019-06-09 15:14:15');
INSERT INTO `t_productcomment` VALUES ('3', '1', '10', '非常好的一本书，推荐看~！', 'user2', '2019-06-11 20:43:00');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `regTime` varchar(20) default NULL COMMENT '注册时间',
  PRIMARY KEY  (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('user1', '123', '张新芬', '女', '2019-06-11', 'upload/7c5e1f75-a4e5-4951-9cb1-e557ccc7ffbd.jpg', '13958342342', 'dashen@163.com', '四川成都红星路13号', '2019-06-09 22:29:20');
INSERT INTO `t_userinfo` VALUES ('user2', '123', '李晓红', '女', '2019-06-07', 'upload/c12c2f8e-7f6e-428f-b644-cd5855059ccf.jpg', '13985009343', 'xiaohong@163.com', '四川南充飞机场路12号', '2019-06-11 20:40:44');
