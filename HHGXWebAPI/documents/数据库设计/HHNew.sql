/*
Navicat MySQL Data Transfer

Source Server         : 192.168.11.31
Source Server Version : 50704
Source Host           : 192.168.11.31:3306
Source Database       : hhnew

Target Server Type    : MYSQL
Target Server Version : 50704
File Encoding         : 65001

Date: 2017-08-28 17:21:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for alarmdata
-- ----------------------------
DROP TABLE IF EXISTS `alarmdata`;
CREATE TABLE `alarmdata` (
  `Firealarmid` char(36) NOT NULL,
  `cAlarmtype` varchar(10) DEFAULT NULL,
  `Gatewayaddress` varchar(30) DEFAULT NULL,
  `sysaddress` int(11) DEFAULT NULL,
  `systypeID` int(11) DEFAULT NULL,
  `deviceaddress` varchar(30) DEFAULT NULL,
  `idevicetype` int(11) DEFAULT NULL,
  `dFirstAlarmtime` datetime DEFAULT NULL,
  `faultdesc` varchar(300) DEFAULT NULL,
  `StateValue` int(11) DEFAULT NULL,
  `dRecentAlarmtime` datetime DEFAULT NULL,
  `dReceivetime` datetime DEFAULT NULL,
  `AlarmNum` int(11) DEFAULT NULL,
  `vAlarmsource` varchar(20) DEFAULT NULL,
  `checkresult` varchar(50) DEFAULT NULL,
  `checkdesc` varchar(1000) DEFAULT NULL,
  `chulidate` datetime DEFAULT NULL,
  `chuliren` varchar(100) DEFAULT NULL,
  `YnRequest` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Firealarmid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of alarmdata
-- ----------------------------

-- ----------------------------
-- Table structure for analogtype
-- ----------------------------
DROP TABLE IF EXISTS `analogtype`;
CREATE TABLE `analogtype` (
  `anlogTypeID` int(11) NOT NULL,
  `vanalogDesc` varchar(50) DEFAULT NULL,
  `vUnit` varchar(10) DEFAULT NULL,
  `minvalue` int(11) DEFAULT NULL,
  `maxvalue` int(11) DEFAULT NULL,
  `minUnit` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`anlogTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of analogtype
-- ----------------------------
INSERT INTO `analogtype` VALUES ('0', '未用', '', null, null, '');
INSERT INTO `analogtype` VALUES ('1', '事件计数', '件', '0', '32000', '1件');
INSERT INTO `analogtype` VALUES ('2', '高度', 'm', '0', '320', '0.01m');
INSERT INTO `analogtype` VALUES ('3', '温度', '°C', '-273', '3200', '0.1°C');
INSERT INTO `analogtype` VALUES ('4', '压力', 'MPa(兆帕)', '0', '3200', '0.1MPa(兆帕)');
INSERT INTO `analogtype` VALUES ('5', '压力', 'kPa(千帕)', '0', '3200', '0.1kPa(千帕)');
INSERT INTO `analogtype` VALUES ('6', '气体浓度', '%LEL', '0', '100', '0.1%LEL');
INSERT INTO `analogtype` VALUES ('7', '时间', 'S', '0', '32000', '1S');
INSERT INTO `analogtype` VALUES ('8', '电压', 'V', '0', '3200', '0.1V');
INSERT INTO `analogtype` VALUES ('9', '电流', 'A', '0', '3200', '0.1A');
INSERT INTO `analogtype` VALUES ('10', '流量', 'L/S', '0', '3200', '0.1L/S');
INSERT INTO `analogtype` VALUES ('11', '风量', 'm3/min', '0', '3200', '0.1m3/min');
INSERT INTO `analogtype` VALUES ('12', '风速', 'm/s', '0', '20', '1m/s');

-- ----------------------------
-- Table structure for analogvalue
-- ----------------------------
DROP TABLE IF EXISTS `analogvalue`;
CREATE TABLE `analogvalue` (
  `AnalogID` char(36) NOT NULL,
  `address` varchar(30) DEFAULT NULL,
  `Sysaddress` int(11) DEFAULT NULL,
  `tiSysType` int(11) DEFAULT NULL,
  `ivalue` int(11) DEFAULT NULL,
  `iAnalogType` int(11) DEFAULT NULL,
  `ValueTime` datetime DEFAULT NULL,
  `Gatewayaddress` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`AnalogID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of analogvalue
-- ----------------------------

-- ----------------------------
-- Table structure for anlogalarmsettings
-- ----------------------------
DROP TABLE IF EXISTS `anlogalarmsettings`;
CREATE TABLE `anlogalarmsettings` (
  `deviceaddress` varchar(30) NOT NULL,
  `Sysaddress` int(11) NOT NULL,
  `Gatewayaddress` varchar(30) NOT NULL,
  `LowValue` int(11) DEFAULT NULL,
  `UpValue` int(11) DEFAULT NULL,
  PRIMARY KEY (`deviceaddress`,`Sysaddress`,`Gatewayaddress`),
  CONSTRAINT `Refdevices112` FOREIGN KEY (`deviceaddress`, `Sysaddress`, `Gatewayaddress`) REFERENCES `devices` (`deviceaddress`, `Sysaddress`, `Gatewayaddress`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of anlogalarmsettings
-- ----------------------------

-- ----------------------------
-- Table structure for appearancepic
-- ----------------------------
DROP TABLE IF EXISTS `appearancepic`;
CREATE TABLE `appearancepic` (
  `iphotoID` char(15) NOT NULL,
  `vPhotoname` varchar(100) NOT NULL,
  `dRecordDate` datetime DEFAULT NULL,
  `Picpath` varchar(1000) DEFAULT NULL,
  `ExteriorInfo` text,
  `siteid` char(20) NOT NULL,
  PRIMARY KEY (`iphotoID`),
  KEY `Refsite18` (`siteid`),
  CONSTRAINT `Refsite18` FOREIGN KEY (`siteid`) REFERENCES `site` (`siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of appearancepic
-- ----------------------------

-- ----------------------------
-- Table structure for area
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `AreaId` char(6) NOT NULL,
  `AreaName` varchar(20) DEFAULT NULL,
  `Level` char(1) DEFAULT NULL,
  `ParentId` char(6) DEFAULT NULL,
  `ZipCode` char(6) DEFAULT '0',
  `Abbreviation` varchar(20) DEFAULT NULL,
  `Remarks` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`AreaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of area
-- ----------------------------
INSERT INTO `area` VALUES ('110000', '北京', '', '1', '', 'bj', 'BeiJing');
INSERT INTO `area` VALUES ('110100', '北京市', '', '110000', '100000', 'bjs', 'BeiJingShi');
INSERT INTO `area` VALUES ('110101', '东城区', '', '110100', '100010', 'dcq', 'DongChengQu');
INSERT INTO `area` VALUES ('110102', '西城区', '', '110100', '100032', 'xcq', 'XiChengQu');
INSERT INTO `area` VALUES ('110103', '崇文区', '', '110100', '100061', 'cwq', 'ChongWenQu');
INSERT INTO `area` VALUES ('110104', '宣武区', '', '110100', '100054', 'xwq', 'XuanWuQu');
INSERT INTO `area` VALUES ('110105', '朝阳区', '', '110100', '100011', 'cyq', 'ChaoYangQu');
INSERT INTO `area` VALUES ('110106', '丰台区', '', '110100', '100071', 'ftq', 'FengTaiQu');
INSERT INTO `area` VALUES ('110107', '石景山区', '', '110100', '100071', 'sjsq', 'ShiJingShanQu');
INSERT INTO `area` VALUES ('110108', '海淀区', '', '110100', '100091', 'hdq', 'HaiDianQu');
INSERT INTO `area` VALUES ('110109', '门头沟区', '', '110100', '102300', 'mtgq', 'MenTouGouQu');
INSERT INTO `area` VALUES ('110111', '房山区', '', '110100', '102488', 'fsq', 'FangShanQu');
INSERT INTO `area` VALUES ('110112', '通州区', '', '110100', '101100', 'tzq', 'TongZhouQu');
INSERT INTO `area` VALUES ('110113', '顺义区', '', '110100', '101300', 'syq', 'ShunYiQu');
INSERT INTO `area` VALUES ('110114', '昌平区', '', '110100', '102200', 'cpq', 'ChangPingQu');
INSERT INTO `area` VALUES ('110115', '大兴区', '', '110100', '102600', 'dxq', 'DaXingQu');
INSERT INTO `area` VALUES ('110116', '怀柔区', '', '110100', '101400', 'hrq', 'HuaiRouQu');
INSERT INTO `area` VALUES ('110117', '平谷区', '', '110100', '101200', 'pgq', 'PingGuQu');
INSERT INTO `area` VALUES ('110228', '密云县', '', '110100', '101500', 'myx', 'MiYunXian');
INSERT INTO `area` VALUES ('110229', '延庆县', '', '110100', '102100', 'yqx', 'YanQingXian');
INSERT INTO `area` VALUES ('110230', '其它区', '', '110100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('120000', '天津', '', '1', '', 'tj', 'TianJin');
INSERT INTO `area` VALUES ('120100', '天津市', '', '120000', '300000', 'tjs', 'TianJinShi');
INSERT INTO `area` VALUES ('120101', '和平区', '', '120100', '300041', 'hpq', 'HePingQu');
INSERT INTO `area` VALUES ('120102', '河东区', '', '120100', '300171', 'hdq', 'HeDongQu');
INSERT INTO `area` VALUES ('120103', '河西区', '', '120100', '300202', 'hxq', 'HeXiQu');
INSERT INTO `area` VALUES ('120104', '南开区', '', '120100', '300100', 'nkq', 'NanKaiQu');
INSERT INTO `area` VALUES ('120105', '河北区', '', '120100', '300143', 'hbq', 'HeBeiQu');
INSERT INTO `area` VALUES ('120106', '红桥区', '', '120100', '300131', 'hqq', 'HongQiaoQu');
INSERT INTO `area` VALUES ('120107', '塘沽区', '', '120100', '300450', 'tgq', 'TangGuQu');
INSERT INTO `area` VALUES ('120108', '汉沽区', '', '120100', '300480', 'hgq', 'HanGuQu');
INSERT INTO `area` VALUES ('120109', '大港区', '', '120100', '300270', 'dgq', 'DaGangQu');
INSERT INTO `area` VALUES ('120110', '东丽区', '', '120100', '300300', 'dlq', 'DongLiQu');
INSERT INTO `area` VALUES ('120111', '西青区', '', '120100', '300380', 'xqq', 'XiQingQu');
INSERT INTO `area` VALUES ('120112', '津南区', '', '120100', '300350', 'jnq', 'JinNanQu');
INSERT INTO `area` VALUES ('120113', '北辰区', '', '120100', '300400', 'bcq', 'BeiChenQu');
INSERT INTO `area` VALUES ('120114', '武清区', '', '120100', '301700', 'wqq', 'WuQingQu');
INSERT INTO `area` VALUES ('120115', '宝坻区', '', '120100', '301800', 'bdq', 'BaoZuoQu');
INSERT INTO `area` VALUES ('120116', '滨海新区', '', '120100', '300457', '', '');
INSERT INTO `area` VALUES ('120221', '宁河县', '', '120100', '301500', 'nhx', 'NingHeXian');
INSERT INTO `area` VALUES ('120223', '静海县', '', '120100', '301600', 'jhx', 'JingHaiXian');
INSERT INTO `area` VALUES ('120225', '蓟县', '', '120100', '301900', 'jx', 'JiXian');
INSERT INTO `area` VALUES ('120226', '其它区', '', '120100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('130000', '河北省', '', '1', '', 'hbs', 'HeBeiSheng');
INSERT INTO `area` VALUES ('130100', '石家庄市', '', '130000', '50000', 'sjzs', 'ShiJiaZhuangShi');
INSERT INTO `area` VALUES ('130102', '长安区', '', '130100', '50011', 'caq', 'ChangAnQu');
INSERT INTO `area` VALUES ('130103', '桥东区', '', '130100', '50011', 'qdq', 'QiaoDongQu');
INSERT INTO `area` VALUES ('130104', '桥西区', '', '130100', '50051', 'qxq', 'QiaoXiQu');
INSERT INTO `area` VALUES ('130105', '新华区', '', '130100', '50051', 'xhq', 'XinHuaQu');
INSERT INTO `area` VALUES ('130107', '井陉矿区', '', '130100', '50100', 'jjkq', 'JingZuoKuangQu');
INSERT INTO `area` VALUES ('130108', '裕华区', '', '130100', '50081', 'yhq', 'YuHuaQu');
INSERT INTO `area` VALUES ('130121', '井陉县', '', '130100', '50300', 'jjx', 'JingZuoXian');
INSERT INTO `area` VALUES ('130123', '正定县', '', '130100', '50800', 'zdx', 'ZhengDingXian');
INSERT INTO `area` VALUES ('130124', '栾城县', '', '130100', '51430', 'lcx', 'ZuoChengXian');
INSERT INTO `area` VALUES ('130125', '行唐县', '', '130100', '50600', 'xtx', 'XingTangXian');
INSERT INTO `area` VALUES ('130126', '灵寿县', '', '130100', '50500', 'lsx', 'LingShouXian');
INSERT INTO `area` VALUES ('130127', '高邑县', '', '130100', '51330', 'gyx', 'GaoYiXian');
INSERT INTO `area` VALUES ('130128', '深泽县', '', '130100', '52560', 'szx', 'ShenZeXian');
INSERT INTO `area` VALUES ('130129', '赞皇县', '', '130100', '51230', 'zhx', 'ZanHuangXian');
INSERT INTO `area` VALUES ('130130', '无极县', '', '130100', '52460', 'wjx', 'WuJiXian');
INSERT INTO `area` VALUES ('130131', '平山县', '', '130100', '50400', 'psx', 'PingShanXian');
INSERT INTO `area` VALUES ('130132', '元氏县', '', '130100', '51130', 'ysx', 'YuanShiXian');
INSERT INTO `area` VALUES ('130133', '赵县', '', '130100', '51530', 'zx', 'ZhaoXian');
INSERT INTO `area` VALUES ('130181', '辛集市', '', '130100', '52360', 'xjs', 'XinJiShi');
INSERT INTO `area` VALUES ('130182', '藁城市', '', '130100', '52160', 'gcs', 'ZuoChengShi');
INSERT INTO `area` VALUES ('130183', '晋州市', '', '130100', '52260', 'jzs', 'JinZhouShi');
INSERT INTO `area` VALUES ('130184', '新乐市', '', '130100', '50700', 'xls', 'XinLeShi');
INSERT INTO `area` VALUES ('130185', '鹿泉市', '', '130100', '50200', 'lqs', 'LuQuanShi');
INSERT INTO `area` VALUES ('130186', '其它区', '', '130100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('130200', '唐山市', '', '130000', '63000', 'tss', 'TangShanShi');
INSERT INTO `area` VALUES ('130202', '路南区', '', '130200', '63017', 'lnq', 'LuNanQu');
INSERT INTO `area` VALUES ('130203', '路北区', '', '130200', '63015', 'lbq', 'LuBeiQu');
INSERT INTO `area` VALUES ('130204', '古冶区', '', '130200', '63104', 'gyq', 'GuYeQu');
INSERT INTO `area` VALUES ('130205', '开平区', '', '130200', '63021', 'kpq', 'KaiPingQu');
INSERT INTO `area` VALUES ('130207', '丰南区', '', '130200', '63300', 'fnq', 'FengNanQu');
INSERT INTO `area` VALUES ('130208', '丰润区', '', '130200', '64000', 'frq', 'FengRunQu');
INSERT INTO `area` VALUES ('130223', '滦县', '', '130200', '63700', 'lx', 'LuanXian');
INSERT INTO `area` VALUES ('130224', '滦南县', '', '130200', '63500', 'lnx', 'LuanNanXian');
INSERT INTO `area` VALUES ('130225', '乐亭县', '', '130200', '63600', 'ltx', 'LeTingXian');
INSERT INTO `area` VALUES ('130227', '迁西县', '', '130200', '64300', 'qxx', 'QianXiXian');
INSERT INTO `area` VALUES ('130229', '玉田县', '', '130200', '64100', 'ytx', 'YuTianXian');
INSERT INTO `area` VALUES ('130230', '唐海县', '', '130200', '63200', 'thx', 'TangHaiXian');
INSERT INTO `area` VALUES ('130281', '遵化市', '', '130200', '64200', 'zhs', 'ZunHuaShi');
INSERT INTO `area` VALUES ('130283', '迁安市', '', '130200', '64400', 'qas', 'QianAnShi');
INSERT INTO `area` VALUES ('130284', '其它区', '', '130200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('130300', '秦皇岛市', '', '130000', '66000', 'qhds', 'QinHuangDaoShi');
INSERT INTO `area` VALUES ('130302', '海港区', '', '130300', '66000', 'hgq', 'HaiGangQu');
INSERT INTO `area` VALUES ('130303', '山海关区', '', '130300', '66200', 'shgq', 'ShanHaiGuanQu');
INSERT INTO `area` VALUES ('130304', '北戴河区', '', '130300', '66100', 'bdhq', 'BeiDaiHeQu');
INSERT INTO `area` VALUES ('130321', '青龙满族自治县', '', '130300', '66500', 'qlmzzzx', 'QingLongManZuZiZhiXian');
INSERT INTO `area` VALUES ('130322', '昌黎县', '', '130300', '66600', 'clx', 'ChangLiXian');
INSERT INTO `area` VALUES ('130323', '抚宁县', '', '130300', '66300', 'fnx', 'FuNingXian');
INSERT INTO `area` VALUES ('130324', '卢龙县', '', '130300', '66400', 'llx', 'LuLongXian');
INSERT INTO `area` VALUES ('130398', '其它区', '', '130300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('130399', '经济技术开发区', '', '130300', '', 'jjjskfq', 'JingJiJiShuKaiFaQu');
INSERT INTO `area` VALUES ('130400', '邯郸市', '', '130000', '56000', 'hds', 'HanDanShi');
INSERT INTO `area` VALUES ('130402', '邯山区', '', '130400', '56001', 'hsq', 'HanShanQu');
INSERT INTO `area` VALUES ('130403', '丛台区', '', '130400', '56004', 'ctq', 'CongTaiQu');
INSERT INTO `area` VALUES ('130404', '复兴区', '', '130400', '56003', 'fxq', 'FuXingQu');
INSERT INTO `area` VALUES ('130406', '峰峰矿区', '', '130400', '56200', 'ffkq', 'FengFengKuangQu');
INSERT INTO `area` VALUES ('130421', '邯郸县', '', '130400', '56105', 'hdx', 'HanDanXian');
INSERT INTO `area` VALUES ('130423', '临漳县', '', '130400', '56600', 'lzx', 'LinZhangXian');
INSERT INTO `area` VALUES ('130424', '成安县', '', '130400', '56700', 'cax', 'ChengAnXian');
INSERT INTO `area` VALUES ('130425', '大名县', '', '130400', '56900', 'dmx', 'DaMingXian');
INSERT INTO `area` VALUES ('130426', '涉县', '', '130400', '56400', 'sx', 'SheXian');
INSERT INTO `area` VALUES ('130427', '磁县', '', '130400', '56500', 'cx', 'CiXian');
INSERT INTO `area` VALUES ('130428', '肥乡县', '', '130400', '57550', 'fxx', 'FeiXiangXian');
INSERT INTO `area` VALUES ('130429', '永年县', '', '130400', '57150', 'ynx', 'YongNianXian');
INSERT INTO `area` VALUES ('130430', '邱县', '', '130400', '57450', 'qx', 'QiuXian');
INSERT INTO `area` VALUES ('130431', '鸡泽县', '', '130400', '57350', 'jzx', 'JiZeXian');
INSERT INTO `area` VALUES ('130432', '广平县', '', '130400', '57650', 'gpx', 'GuangPingXian');
INSERT INTO `area` VALUES ('130433', '馆陶县', '', '130400', '57750', 'gtx', 'GuanTaoXian');
INSERT INTO `area` VALUES ('130434', '魏县', '', '130400', '56800', 'wx', 'WeiXian');
INSERT INTO `area` VALUES ('130435', '曲周县', '', '130400', '57250', 'qzx', 'QuZhouXian');
INSERT INTO `area` VALUES ('130481', '武安市', '', '130400', '56300', 'was', 'WuAnShi');
INSERT INTO `area` VALUES ('130482', '其它区', '', '130400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('130500', '邢台市', '', '130000', '54000', 'xts', 'XingTaiShi');
INSERT INTO `area` VALUES ('130502', '桥东区', '', '130500', '54001', 'qdq', 'QiaoDongQu');
INSERT INTO `area` VALUES ('130503', '桥西区', '', '130500', '54000', 'qxq', 'QiaoXiQu');
INSERT INTO `area` VALUES ('130521', '邢台县', '', '130500', '54001', 'xtx', 'XingTaiXian');
INSERT INTO `area` VALUES ('130522', '临城县', '', '130500', '54300', 'lcx', 'LinChengXian');
INSERT INTO `area` VALUES ('130523', '内丘县', '', '130500', '54200', 'nqx', 'NeiQiuXian');
INSERT INTO `area` VALUES ('130524', '柏乡县', '', '130500', '55450', 'bxx', 'BaiXiangXian');
INSERT INTO `area` VALUES ('130525', '隆尧县', '', '130500', '55350', 'lyx', 'LongYaoXian');
INSERT INTO `area` VALUES ('130526', '任县', '', '130500', '55150', 'rx', 'RenXian');
INSERT INTO `area` VALUES ('130527', '南和县', '', '130500', '54400', 'nhx', 'NanHeXian');
INSERT INTO `area` VALUES ('130528', '宁晋县', '', '130500', '55550', 'njx', 'NingJinXian');
INSERT INTO `area` VALUES ('130529', '巨鹿县', '', '130500', '55250', 'jlx', 'JuLuXian');
INSERT INTO `area` VALUES ('130530', '新河县', '', '130500', '55650', 'xhx', 'XinHeXian');
INSERT INTO `area` VALUES ('130531', '广宗县', '', '130500', '54600', 'gzx', 'GuangZongXian');
INSERT INTO `area` VALUES ('130532', '平乡县', '', '130500', '54500', 'pxx', 'PingXiangXian');
INSERT INTO `area` VALUES ('130533', '威县', '', '130500', '54700', 'wx', 'WeiXian');
INSERT INTO `area` VALUES ('130534', '清河县', '', '130500', '54800', 'qhx', 'QingHeXian');
INSERT INTO `area` VALUES ('130535', '临西县', '', '130500', '54900', 'lxx', 'LinXiXian');
INSERT INTO `area` VALUES ('130581', '南宫市', '', '130500', '55750', 'ngs', 'NanGongShi');
INSERT INTO `area` VALUES ('130582', '沙河市', '', '130500', '54100', 'shs', 'ShaHeShi');
INSERT INTO `area` VALUES ('130583', '其它区', '', '130500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('130600', '保定市', '', '130000', '71000', 'bds', 'BaoDingShi');
INSERT INTO `area` VALUES ('130602', '新市区', '', '130600', '71052', 'xsq', 'XinShiQu');
INSERT INTO `area` VALUES ('130603', '北市区', '', '130600', '71000', 'bsq', 'BeiShiQu');
INSERT INTO `area` VALUES ('130604', '南市区', '', '130600', '71000', 'nsq', 'NanShiQu');
INSERT INTO `area` VALUES ('130621', '满城县', '', '130600', '72150', 'mcx', 'ManChengXian');
INSERT INTO `area` VALUES ('130622', '清苑县', '', '130600', '71100', 'qyx', 'QingYuanXian');
INSERT INTO `area` VALUES ('130623', '涞水县', '', '130600', '74100', 'lsx', 'ZuoShuiXian');
INSERT INTO `area` VALUES ('130624', '阜平县', '', '130600', '73200', 'fpx', 'FuPingXian');
INSERT INTO `area` VALUES ('130625', '徐水县', '', '130600', '72550', 'xsx', 'XuShuiXian');
INSERT INTO `area` VALUES ('130626', '定兴县', '', '130600', '72650', 'dxx', 'DingXingXian');
INSERT INTO `area` VALUES ('130627', '唐县', '', '130600', '72350', 'tx', 'TangXian');
INSERT INTO `area` VALUES ('130628', '高阳县', '', '130600', '71500', 'gyx', 'GaoYangXian');
INSERT INTO `area` VALUES ('130629', '容城县', '', '130600', '71700', 'rcx', 'RongChengXian');
INSERT INTO `area` VALUES ('130630', '涞源县', '', '130600', '74300', 'lyx', 'ZuoYuanXian');
INSERT INTO `area` VALUES ('130631', '望都县', '', '130600', '72450', 'wdx', 'WangDuXian');
INSERT INTO `area` VALUES ('130632', '安新县', '', '130600', '71600', 'axx', 'AnXinXian');
INSERT INTO `area` VALUES ('130633', '易县', '', '130600', '74200', 'yx', 'YiXian');
INSERT INTO `area` VALUES ('130634', '曲阳县', '', '130600', '73100', 'qyx', 'QuYangXian');
INSERT INTO `area` VALUES ('130635', '蠡县', '', '130600', '71400', 'lx', 'ZuoXian');
INSERT INTO `area` VALUES ('130636', '顺平县', '', '130600', '72250', 'spx', 'ShunPingXian');
INSERT INTO `area` VALUES ('130637', '博野县', '', '130600', '71300', 'byx', 'BoYeXian');
INSERT INTO `area` VALUES ('130638', '雄县', '', '130600', '71800', 'xx', 'XiongXian');
INSERT INTO `area` VALUES ('130681', '涿州市', '', '130600', '72750', 'zzs', 'ZuoZhouShi');
INSERT INTO `area` VALUES ('130682', '定州市', '', '130600', '73000', 'dzs', 'DingZhouShi');
INSERT INTO `area` VALUES ('130683', '安国市', '', '130600', '71200', 'ags', 'AnGuoShi');
INSERT INTO `area` VALUES ('130684', '高碑店市', '', '130600', '74000', 'gbds', 'GaoBeiDianShi');
INSERT INTO `area` VALUES ('130698', '高开区', '', '130600', '', 'gkq', 'GaoKaiQu');
INSERT INTO `area` VALUES ('130699', '其它区', '', '130600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('130700', '张家口市', '', '130000', '75000', 'zjks', 'ZhangJiaKouShi');
INSERT INTO `area` VALUES ('130702', '桥东区', '', '130700', '75000', 'qdq', 'QiaoDongQu');
INSERT INTO `area` VALUES ('130703', '桥西区', '', '130700', '75061', 'qxq', 'QiaoXiQu');
INSERT INTO `area` VALUES ('130705', '宣化区', '', '130700', '75100', 'xhq', 'XuanHuaQu');
INSERT INTO `area` VALUES ('130706', '下花园区', '', '130700', '75300', 'xhyq', 'XiaHuaYuanQu');
INSERT INTO `area` VALUES ('130721', '宣化县', '', '130700', '75100', 'xhx', 'XuanHuaXian');
INSERT INTO `area` VALUES ('130722', '张北县', '', '130700', '76450', 'zbx', 'ZhangBeiXian');
INSERT INTO `area` VALUES ('130723', '康保县', '', '130700', '76650', 'kbx', 'KangBaoXian');
INSERT INTO `area` VALUES ('130724', '沽源县', '', '130700', '76550', 'gyx', 'GuYuanXian');
INSERT INTO `area` VALUES ('130725', '尚义县', '', '130700', '76750', 'syx', 'ShangYiXian');
INSERT INTO `area` VALUES ('130726', '蔚县', '', '130700', '75700', 'wx', 'WeiXian');
INSERT INTO `area` VALUES ('130727', '阳原县', '', '130700', '75800', 'yyx', 'YangYuanXian');
INSERT INTO `area` VALUES ('130728', '怀安县', '', '130700', '76150', 'hax', 'HuaiAnXian');
INSERT INTO `area` VALUES ('130729', '万全县', '', '130700', '76250', 'wqx', 'WanQuanXian');
INSERT INTO `area` VALUES ('130730', '怀来县', '', '130700', '75400', 'hlx', 'HuaiLaiXian');
INSERT INTO `area` VALUES ('130731', '涿鹿县', '', '130700', '75600', 'zlx', 'ZuoLuXian');
INSERT INTO `area` VALUES ('130732', '赤城县', '', '130700', '75500', 'ccx', 'ChiChengXian');
INSERT INTO `area` VALUES ('130733', '崇礼县', '', '130700', '76350', 'clx', 'ChongLiXian');
INSERT INTO `area` VALUES ('130734', '其它区', '', '130700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('130800', '承德市', '', '130000', '67000', 'cds', 'ChengDeShi');
INSERT INTO `area` VALUES ('130802', '双桥区', '', '130800', '67000', 'sqq', 'ShuangQiaoQu');
INSERT INTO `area` VALUES ('130803', '双滦区', '', '130800', '67000', 'slq', 'ShuangLuanQu');
INSERT INTO `area` VALUES ('130804', '鹰手营子矿区', '', '130800', '67000', 'ysyzkq', 'YingShouYingZiKuangQu');
INSERT INTO `area` VALUES ('130821', '承德县', '', '130800', '67400', 'cdx', 'ChengDeXian');
INSERT INTO `area` VALUES ('130822', '兴隆县', '', '130800', '67300', 'xlx', 'XingLongXian');
INSERT INTO `area` VALUES ('130823', '平泉县', '', '130800', '67500', 'pqx', 'PingQuanXian');
INSERT INTO `area` VALUES ('130824', '滦平县', '', '130800', '68250', 'lpx', 'LuanPingXian');
INSERT INTO `area` VALUES ('130825', '隆化县', '', '130800', '68150', 'lhx', 'LongHuaXian');
INSERT INTO `area` VALUES ('130826', '丰宁满族自治县', '', '130800', '68350', 'fnmzzzx', 'FengNingManZuZiZhiXian');
INSERT INTO `area` VALUES ('130827', '宽城满族自治县', '', '130800', '67600', 'kcmzzzx', 'KuanChengManZuZiZhiXian');
INSERT INTO `area` VALUES ('130828', '围场满族蒙古族自治县', '', '130800', '68450', 'wcmzmgzzzx', 'WeiChangManZuMengGuZuZiZhiXian');
INSERT INTO `area` VALUES ('130829', '其它区', '', '130800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('130900', '沧州市', '', '130000', '61000', 'czs', 'CangZhouShi');
INSERT INTO `area` VALUES ('130902', '新华区', '', '130900', '61000', 'xhq', 'XinHuaQu');
INSERT INTO `area` VALUES ('130903', '运河区', '', '130900', '61000', 'yhq', 'YunHeQu');
INSERT INTO `area` VALUES ('130921', '沧县', '', '130900', '61035', 'cx', 'CangXian');
INSERT INTO `area` VALUES ('130922', '青县', '', '130900', '62650', 'qx', 'QingXian');
INSERT INTO `area` VALUES ('130923', '东光县', '', '130900', '61600', 'dgx', 'DongGuangXian');
INSERT INTO `area` VALUES ('130924', '海兴县', '', '130900', '61200', 'hxx', 'HaiXingXian');
INSERT INTO `area` VALUES ('130925', '盐山县', '', '130900', '61300', 'ysx', 'YanShanXian');
INSERT INTO `area` VALUES ('130926', '肃宁县', '', '130900', '62350', 'snx', 'SuNingXian');
INSERT INTO `area` VALUES ('130927', '南皮县', '', '130900', '61500', 'npx', 'NanPiXian');
INSERT INTO `area` VALUES ('130928', '吴桥县', '', '130900', '61800', 'wqx', 'WuQiaoXian');
INSERT INTO `area` VALUES ('130929', '献县', '', '130900', '62250', 'xx', 'XianXian');
INSERT INTO `area` VALUES ('130930', '孟村回族自治县', '', '130900', '61400', 'mchzzzx', 'MengCunHuiZuZiZhiXian');
INSERT INTO `area` VALUES ('130981', '泊头市', '', '130900', '62150', 'bts', 'BoTouShi');
INSERT INTO `area` VALUES ('130982', '任丘市', '', '130900', '62550', 'rqs', 'RenQiuShi');
INSERT INTO `area` VALUES ('130983', '黄骅市', '', '130900', '61100', 'hhs', 'HuangZuoShi');
INSERT INTO `area` VALUES ('130984', '河间市', '', '130900', '62450', 'hjs', 'HeJianShi');
INSERT INTO `area` VALUES ('130985', '其它区', '', '130900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('131000', '廊坊市', '', '130000', '65000', 'lfs', 'LangFangShi');
INSERT INTO `area` VALUES ('131002', '安次区', '', '131000', '65000', 'acq', 'AnCiQu');
INSERT INTO `area` VALUES ('131003', '广阳区', '', '131000', '65000', 'gyq', 'GuangYangQu');
INSERT INTO `area` VALUES ('131022', '固安县', '', '131000', '65500', 'gax', 'GuAnXian');
INSERT INTO `area` VALUES ('131023', '永清县', '', '131000', '65600', 'yqx', 'YongQingXian');
INSERT INTO `area` VALUES ('131024', '香河县', '', '131000', '65400', 'xhx', 'XiangHeXian');
INSERT INTO `area` VALUES ('131025', '大城县', '', '131000', '65900', 'dcx', 'DaChengXian');
INSERT INTO `area` VALUES ('131026', '文安县', '', '131000', '65800', 'wax', 'WenAnXian');
INSERT INTO `area` VALUES ('131028', '大厂回族自治县', '', '131000', '65300', 'dchzzzx', 'DaChangHuiZuZiZhiXian');
INSERT INTO `area` VALUES ('131051', '开发区', '', '131000', '', 'kfq', 'KaiFaQu');
INSERT INTO `area` VALUES ('131052', '燕郊经济技术开发区', '', '131000', '', 'yjjjjskfq', 'YanJiaoJingJiJiShuKaiFaQu');
INSERT INTO `area` VALUES ('131081', '霸州市', '', '131000', '65700', 'bzs', 'BaZhouShi');
INSERT INTO `area` VALUES ('131082', '三河市', '', '131000', '65200', 'shs', 'SanHeShi');
INSERT INTO `area` VALUES ('131083', '其它区', '', '131000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('131100', '衡水市', '', '130000', '53000', 'hss', 'HengShuiShi');
INSERT INTO `area` VALUES ('131102', '桃城区', '', '131100', '53000', 'tcq', 'TaoChengQu');
INSERT INTO `area` VALUES ('131121', '枣强县', '', '131100', '53100', 'zqx', 'ZaoQiangXian');
INSERT INTO `area` VALUES ('131122', '武邑县', '', '131100', '53400', 'wyx', 'WuYiXian');
INSERT INTO `area` VALUES ('131123', '武强县', '', '131100', '53300', 'wqx', 'WuQiangXian');
INSERT INTO `area` VALUES ('131124', '饶阳县', '', '131100', '53900', 'ryx', 'RaoYangXian');
INSERT INTO `area` VALUES ('131125', '安平县', '', '131100', '53600', 'apx', 'AnPingXian');
INSERT INTO `area` VALUES ('131126', '故城县', '', '131100', '253800', 'gcx', 'GuChengXian');
INSERT INTO `area` VALUES ('131127', '景县', '', '131100', '53500', 'jx', 'JingXian');
INSERT INTO `area` VALUES ('131128', '阜城县', '', '131100', '53700', 'fcx', 'FuChengXian');
INSERT INTO `area` VALUES ('131181', '冀州市', '', '131100', '53200', 'jzs', 'JiZhouShi');
INSERT INTO `area` VALUES ('131182', '深州市', '', '131100', '53800', 'szs', 'ShenZhouShi');
INSERT INTO `area` VALUES ('131183', '其它区', '', '131100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('140000', '山西省', '', '1', '', 'sxs', 'ShanXiSheng');
INSERT INTO `area` VALUES ('140100', '太原市', '', '140000', '30000', 'tys', 'TaiYuanShi');
INSERT INTO `area` VALUES ('140105', '小店区', '', '140100', '30032', 'xdq', 'XiaoDianQu');
INSERT INTO `area` VALUES ('140106', '迎泽区', '', '140100', '30024', 'yzq', 'YingZeQu');
INSERT INTO `area` VALUES ('140107', '杏花岭区', '', '140100', '30001', 'xhlq', 'XingHuaLingQu');
INSERT INTO `area` VALUES ('140108', '尖草坪区', '', '140100', '30003', 'jcpq', 'JianCaoPingQu');
INSERT INTO `area` VALUES ('140109', '万柏林区', '', '140100', '30027', 'wblq', 'WanBaiLinQu');
INSERT INTO `area` VALUES ('140110', '晋源区', '', '140100', '30025', 'jyq', 'JinYuanQu');
INSERT INTO `area` VALUES ('140121', '清徐县', '', '140100', '30400', 'qxx', 'QingXuXian');
INSERT INTO `area` VALUES ('140122', '阳曲县', '', '140100', '30100', 'yqx', 'YangQuXian');
INSERT INTO `area` VALUES ('140123', '娄烦县', '', '140100', '30300', 'lfx', 'LouFanXian');
INSERT INTO `area` VALUES ('140181', '古交市', '', '140100', '30200', 'gjs', 'GuJiaoShi');
INSERT INTO `area` VALUES ('140182', '其它区', '', '140100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('140200', '大同市', '', '140000', '37000', 'dts', 'DaTongShi');
INSERT INTO `area` VALUES ('140202', '城区', '', '140200', '37008', 'cq', 'ChengQu');
INSERT INTO `area` VALUES ('140203', '矿区', '', '140200', '37001', 'kq', 'KuangQu');
INSERT INTO `area` VALUES ('140211', '南郊区', '', '140200', '37001', 'njq', 'NanJiaoQu');
INSERT INTO `area` VALUES ('140212', '新荣区', '', '140200', '37002', 'xrq', 'XinRongQu');
INSERT INTO `area` VALUES ('140221', '阳高县', '', '140200', '38100', 'ygx', 'YangGaoXian');
INSERT INTO `area` VALUES ('140222', '天镇县', '', '140200', '38200', 'tzx', 'TianZhenXian');
INSERT INTO `area` VALUES ('140223', '广灵县', '', '140200', '37500', 'glx', 'GuangLingXian');
INSERT INTO `area` VALUES ('140224', '灵丘县', '', '140200', '34400', 'lqx', 'LingQiuXian');
INSERT INTO `area` VALUES ('140225', '浑源县', '', '140200', '37400', 'hyx', 'HunYuanXian');
INSERT INTO `area` VALUES ('140226', '左云县', '', '140200', '37100', 'zyx', 'ZuoYunXian');
INSERT INTO `area` VALUES ('140227', '大同县', '', '140200', '37300', 'dtx', 'DaTongXian');
INSERT INTO `area` VALUES ('140228', '其它区', '', '140200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('140300', '阳泉市', '', '140000', '45000', 'yqs', 'YangQuanShi');
INSERT INTO `area` VALUES ('140302', '城区', '', '140300', '45000', 'cq', 'ChengQu');
INSERT INTO `area` VALUES ('140303', '矿区', '', '140300', '45000', 'kq', 'KuangQu');
INSERT INTO `area` VALUES ('140311', '郊区', '', '140300', '45011', 'jq', 'JiaoQu');
INSERT INTO `area` VALUES ('140321', '平定县', '', '140300', '45200', 'pdx', 'PingDingXian');
INSERT INTO `area` VALUES ('140322', '盂县', '', '140300', '45100', 'yx', 'YuXian');
INSERT INTO `area` VALUES ('140323', '其它区', '', '140300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('140400', '长治市', '', '140000', '46000', 'czs', 'ChangZhiShi');
INSERT INTO `area` VALUES ('140421', '长治县', '', '140400', '47100', 'czx', 'ChangZhiXian');
INSERT INTO `area` VALUES ('140423', '襄垣县', '', '140400', '46200', 'xyx', 'XiangYuanXian');
INSERT INTO `area` VALUES ('140424', '屯留县', '', '140400', '46100', 'tlx', 'TunLiuXian');
INSERT INTO `area` VALUES ('140425', '平顺县', '', '140400', '47400', 'psx', 'PingShunXian');
INSERT INTO `area` VALUES ('140426', '黎城县', '', '140400', '47600', 'lcx', 'LiChengXian');
INSERT INTO `area` VALUES ('140427', '壶关县', '', '140400', '47300', 'hgx', 'HuGuanXian');
INSERT INTO `area` VALUES ('140428', '长子县', '', '140400', '46600', 'czx', 'ChangZiXian');
INSERT INTO `area` VALUES ('140429', '武乡县', '', '140400', '46300', 'wxx', 'WuXiangXian');
INSERT INTO `area` VALUES ('140430', '沁县', '', '140400', '46400', 'qx', 'QinXian');
INSERT INTO `area` VALUES ('140431', '沁源县', '', '140400', '46500', 'qyx', 'QinYuanXian');
INSERT INTO `area` VALUES ('140481', '潞城市', '', '140400', '47500', 'lcs', 'LuChengShi');
INSERT INTO `area` VALUES ('140482', '城区', '', '140400', '46011', 'cq', 'ChengQu');
INSERT INTO `area` VALUES ('140483', '郊区', '', '140400', '46011', 'jq', 'JiaoQu');
INSERT INTO `area` VALUES ('140484', '高新区', '', '140400', '', 'gxq', 'GaoXinQu');
INSERT INTO `area` VALUES ('140485', '其它区', '', '140400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('140500', '晋城市', '', '140000', '48000', 'jcs', 'JinChengShi');
INSERT INTO `area` VALUES ('140502', '城区', '', '140500', '48000', 'cq', 'ChengQu');
INSERT INTO `area` VALUES ('140521', '沁水县', '', '140500', '48200', 'qsx', 'QinShuiXian');
INSERT INTO `area` VALUES ('140522', '阳城县', '', '140500', '48100', 'ycx', 'YangChengXian');
INSERT INTO `area` VALUES ('140524', '陵川县', '', '140500', '48300', 'lcx', 'LingChuanXian');
INSERT INTO `area` VALUES ('140525', '泽州县', '', '140500', '48012', 'zzx', 'ZeZhouXian');
INSERT INTO `area` VALUES ('140581', '高平市', '', '140500', '48400', 'gps', 'GaoPingShi');
INSERT INTO `area` VALUES ('140582', '其它区', '', '140500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('140600', '朔州市', '', '140000', '36000', 'szs', 'ShuoZhouShi');
INSERT INTO `area` VALUES ('140602', '朔城区', '', '140600', '38500', 'scq', 'ShuoChengQu');
INSERT INTO `area` VALUES ('140603', '平鲁区', '', '140600', '38600', 'plq', 'PingLuQu');
INSERT INTO `area` VALUES ('140621', '山阴县', '', '140600', '36900', 'syx', 'ShanYinXian');
INSERT INTO `area` VALUES ('140622', '应县', '', '140600', '37600', 'yx', 'YingXian');
INSERT INTO `area` VALUES ('140623', '右玉县', '', '140600', '37200', 'yyx', 'YouYuXian');
INSERT INTO `area` VALUES ('140624', '怀仁县', '', '140600', '38300', 'hrx', 'HuaiRenXian');
INSERT INTO `area` VALUES ('140625', '其它区', '', '140600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('140700', '晋中市', '', '140000', '30600', 'jzs', 'JinZhongShi');
INSERT INTO `area` VALUES ('140702', '榆次区', '', '140700', '30600', 'ycq', 'YuCiQu');
INSERT INTO `area` VALUES ('140721', '榆社县', '', '140700', '31800', 'ysx', 'YuSheXian');
INSERT INTO `area` VALUES ('140722', '左权县', '', '140700', '32600', 'zqx', 'ZuoQuanXian');
INSERT INTO `area` VALUES ('140723', '和顺县', '', '140700', '32700', 'hsx', 'HeShunXian');
INSERT INTO `area` VALUES ('140724', '昔阳县', '', '140700', '45300', 'xyx', 'XiYangXian');
INSERT INTO `area` VALUES ('140725', '寿阳县', '', '140700', '45400', 'syx', 'ShouYangXian');
INSERT INTO `area` VALUES ('140726', '太谷县', '', '140700', '30800', 'tgx', 'TaiGuXian');
INSERT INTO `area` VALUES ('140727', '祁县', '', '140700', '30900', 'qx', 'QiXian');
INSERT INTO `area` VALUES ('140728', '平遥县', '', '140700', '31100', 'pyx', 'PingYaoXian');
INSERT INTO `area` VALUES ('140729', '灵石县', '', '140700', '31300', 'lsx', 'LingShiXian');
INSERT INTO `area` VALUES ('140781', '介休市', '', '140700', '32000', 'jxs', 'JieXiuShi');
INSERT INTO `area` VALUES ('140782', '其它区', '', '140700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('140800', '运城市', '', '140000', '44000', 'ycs', 'YunChengShi');
INSERT INTO `area` VALUES ('140802', '盐湖区', '', '140800', '44300', 'yhq', 'YanHuQu');
INSERT INTO `area` VALUES ('140821', '临猗县', '', '140800', '44100', 'lyx', 'LinZuoXian');
INSERT INTO `area` VALUES ('140822', '万荣县', '', '140800', '44200', 'wrx', 'WanRongXian');
INSERT INTO `area` VALUES ('140823', '闻喜县', '', '140800', '43800', 'wxx', 'WenXiXian');
INSERT INTO `area` VALUES ('140824', '稷山县', '', '140800', '43200', 'jsx', 'ZuoShanXian');
INSERT INTO `area` VALUES ('140825', '新绛县', '', '140800', '43100', 'xjx', 'XinZuoXian');
INSERT INTO `area` VALUES ('140826', '绛县', '', '140800', '43600', 'jx', 'ZuoXian');
INSERT INTO `area` VALUES ('140827', '垣曲县', '', '140800', '43700', 'yqx', 'YuanQuXian');
INSERT INTO `area` VALUES ('140828', '夏县', '', '140800', '44400', 'xx', 'XiaXian');
INSERT INTO `area` VALUES ('140829', '平陆县', '', '140800', '44300', 'plx', 'PingLuXian');
INSERT INTO `area` VALUES ('140830', '芮城县', '', '140800', '44600', 'jcx', 'ZuoChengXian');
INSERT INTO `area` VALUES ('140881', '永济市', '', '140800', '44500', 'yjs', 'YongJiShi');
INSERT INTO `area` VALUES ('140882', '河津市', '', '140800', '43300', 'hjs', 'HeJinShi');
INSERT INTO `area` VALUES ('140883', '其它区', '', '140800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('140900', '忻州市', '', '140000', '34000', 'xzs', 'XinZhouShi');
INSERT INTO `area` VALUES ('140902', '忻府区', '', '140900', '34000', 'xfq', 'XinFuQu');
INSERT INTO `area` VALUES ('140921', '定襄县', '', '140900', '35400', 'dxx', 'DingXiangXian');
INSERT INTO `area` VALUES ('140922', '五台县', '', '140900', '35500', 'wtx', 'WuTaiXian');
INSERT INTO `area` VALUES ('140923', '代县', '', '140900', '34200', 'dx', 'DaiXian');
INSERT INTO `area` VALUES ('140924', '繁峙县', '', '140900', '34300', 'fzx', 'FanZhiXian');
INSERT INTO `area` VALUES ('140925', '宁武县', '', '140900', '36700', 'nwx', 'NingWuXian');
INSERT INTO `area` VALUES ('140926', '静乐县', '', '140900', '35100', 'jlx', 'JingLeXian');
INSERT INTO `area` VALUES ('140927', '神池县', '', '140900', '36100', 'scx', 'ShenChiXian');
INSERT INTO `area` VALUES ('140928', '五寨县', '', '140900', '36100', 'wzx', 'WuZhaiXian');
INSERT INTO `area` VALUES ('140929', '岢岚县', '', '140900', '36300', 'klx', 'ZuoZuoXian');
INSERT INTO `area` VALUES ('140930', '河曲县', '', '140900', '36500', 'hqx', 'HeQuXian');
INSERT INTO `area` VALUES ('140931', '保德县', '', '140900', '36600', 'bdx', 'BaoDeXian');
INSERT INTO `area` VALUES ('140932', '偏关县', '', '140900', '36400', 'pgx', 'PianGuanXian');
INSERT INTO `area` VALUES ('140981', '原平市', '', '140900', '34100', 'yps', 'YuanPingShi');
INSERT INTO `area` VALUES ('140982', '其它区', '', '140900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('141000', '临汾市', '', '140000', '41000', 'lfs', 'LinFenShi');
INSERT INTO `area` VALUES ('141002', '尧都区', '', '141000', '41000', 'ydq', 'YaoDuQu');
INSERT INTO `area` VALUES ('141021', '曲沃县', '', '141000', '43400', 'qwx', 'QuWoXian');
INSERT INTO `area` VALUES ('141022', '翼城县', '', '141000', '43500', 'ycx', 'YiChengXian');
INSERT INTO `area` VALUES ('141023', '襄汾县', '', '141000', '41500', 'xfx', 'XiangFenXian');
INSERT INTO `area` VALUES ('141024', '洪洞县', '', '141000', '41600', 'hdx', 'HongDongXian');
INSERT INTO `area` VALUES ('141025', '古县', '', '141000', '42400', 'gx', 'GuXian');
INSERT INTO `area` VALUES ('141026', '安泽县', '', '141000', '42500', 'azx', 'AnZeXian');
INSERT INTO `area` VALUES ('141027', '浮山县', '', '141000', '42600', 'fsx', 'FuShanXian');
INSERT INTO `area` VALUES ('141028', '吉县', '', '141000', '42200', 'jx', 'JiXian');
INSERT INTO `area` VALUES ('141029', '乡宁县', '', '141000', '42100', 'xnx', 'XiangNingXian');
INSERT INTO `area` VALUES ('141030', '大宁县', '', '141000', '42300', 'dnx', 'DaNingXian');
INSERT INTO `area` VALUES ('141031', '隰县', '', '141000', '41300', 'xx', 'ZuoXian');
INSERT INTO `area` VALUES ('141032', '永和县', '', '141000', '41400', 'yhx', 'YongHeXian');
INSERT INTO `area` VALUES ('141033', '蒲县', '', '141000', '41200', 'px', 'PuXian');
INSERT INTO `area` VALUES ('141034', '汾西县', '', '141000', '31500', 'fxx', 'FenXiXian');
INSERT INTO `area` VALUES ('141081', '侯马市', '', '141000', '43000', 'hms', 'HouMaShi');
INSERT INTO `area` VALUES ('141082', '霍州市', '', '141000', '31400', 'hzs', 'HuoZhouShi');
INSERT INTO `area` VALUES ('141083', '其它区', '', '141000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('141100', '吕梁市', '', '140000', '33000', 'lls', 'LvLiangShi');
INSERT INTO `area` VALUES ('141102', '离石区', '', '141100', '33000', 'lsq', 'LiShiQu');
INSERT INTO `area` VALUES ('141121', '文水县', '', '141100', '32100', 'wsx', 'WenShuiXian');
INSERT INTO `area` VALUES ('141122', '交城县', '', '141100', '30500', 'jcx', 'JiaoChengXian');
INSERT INTO `area` VALUES ('141123', '兴县', '', '141100', '33601', 'xx', 'XingXian');
INSERT INTO `area` VALUES ('141124', '临县', '', '141100', '33200', 'lx', 'LinXian');
INSERT INTO `area` VALUES ('141125', '柳林县', '', '141100', '33300', 'llx', 'LiuLinXian');
INSERT INTO `area` VALUES ('141126', '石楼县', '', '141100', '32500', 'slx', 'ShiLouXian');
INSERT INTO `area` VALUES ('141127', '岚县', '', '141100', '33500', 'lx', 'ZuoXian');
INSERT INTO `area` VALUES ('141128', '方山县', '', '141100', '33100', 'fsx', 'FangShanXian');
INSERT INTO `area` VALUES ('141129', '中阳县', '', '141100', '33400', 'zyx', 'ZhongYangXian');
INSERT INTO `area` VALUES ('141130', '交口县', '', '141100', '32400', 'jkx', 'JiaoKouXian');
INSERT INTO `area` VALUES ('141181', '孝义市', '', '141100', '32208', 'xys', 'XiaoYiShi');
INSERT INTO `area` VALUES ('141182', '汾阳市', '', '141100', '32200', 'fys', 'FenYangShi');
INSERT INTO `area` VALUES ('141183', '其它区', '', '141100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('150000', '内蒙古自治区', '', '1', '', 'nmgzzq', 'NeiMengGuZiZhiQu');
INSERT INTO `area` VALUES ('150100', '呼和浩特市', '', '150000', '10000', 'hhhts', 'HuHeHaoTeShi');
INSERT INTO `area` VALUES ('150102', '新城区', '', '150100', '10050', 'xcq', 'XinChengQu');
INSERT INTO `area` VALUES ('150103', '回民区', '', '150100', '10030', 'hmq', 'HuiMinQu');
INSERT INTO `area` VALUES ('150104', '玉泉区', '', '150100', '10020', 'yqq', 'YuQuanQu');
INSERT INTO `area` VALUES ('150105', '赛罕区', '', '150100', '10020', 'shq', 'SaiHanQu');
INSERT INTO `area` VALUES ('150121', '土默特左旗', '', '150100', '10100', 'tmtzq', 'TuMoTeZuoQi');
INSERT INTO `area` VALUES ('150122', '托克托县', '', '150100', '10200', 'tktx', 'TuoKeTuoXian');
INSERT INTO `area` VALUES ('150123', '和林格尔县', '', '150100', '11500', 'hlgex', 'HeLinGeErXian');
INSERT INTO `area` VALUES ('150124', '清水河县', '', '150100', '11600', 'qshx', 'QingShuiHeXian');
INSERT INTO `area` VALUES ('150125', '武川县', '', '150100', '11700', 'wcx', 'WuChuanXian');
INSERT INTO `area` VALUES ('150126', '其它区', '', '150100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('150200', '包头市', '', '150000', '14000', 'bts', 'BaoTouShi');
INSERT INTO `area` VALUES ('150202', '东河区', '', '150200', '14040', 'dhq', 'DongHeQu');
INSERT INTO `area` VALUES ('150203', '昆都仑区', '', '150200', '14010', 'kdlq', 'KunDuLunQu');
INSERT INTO `area` VALUES ('150204', '青山区', '', '150200', '14030', 'qsq', 'QingShanQu');
INSERT INTO `area` VALUES ('150205', '石拐区', '', '150200', '14070', 'sgq', 'ShiGuaiQu');
INSERT INTO `area` VALUES ('150206', '白云矿区', '', '150200', '14080', 'bykq', 'BaiYunKuangQu');
INSERT INTO `area` VALUES ('150207', '九原区', '', '150200', '14060', 'jyq', 'JiuYuanQu');
INSERT INTO `area` VALUES ('150221', '土默特右旗', '', '150200', '14100', 'tmtyq', 'TuMoTeYouQi');
INSERT INTO `area` VALUES ('150222', '固阳县', '', '150200', '14200', 'gyx', 'GuYangXian');
INSERT INTO `area` VALUES ('150223', '达尔罕茂明安联合旗', '', '150200', '14500', 'dehmmalhq', 'DaErHanMaoMingAnLianHeQi');
INSERT INTO `area` VALUES ('150224', '其它区', '', '150200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('150300', '乌海市', '', '150000', '16000', 'whs', 'WuHaiShi');
INSERT INTO `area` VALUES ('150302', '海勃湾区', '', '150300', '16000', 'hbwq', 'HaiBoWanQu');
INSERT INTO `area` VALUES ('150303', '海南区', '', '150300', '16030', 'hnq', 'HaiNanQu');
INSERT INTO `area` VALUES ('150304', '乌达区', '', '150300', '16040', 'wdq', 'WuDaQu');
INSERT INTO `area` VALUES ('150305', '其它区', '', '150300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('150400', '赤峰市', '', '150000', '24000', 'cfs', 'ChiFengShi');
INSERT INTO `area` VALUES ('150402', '红山区', '', '150400', '24020', 'hsq', 'HongShanQu');
INSERT INTO `area` VALUES ('150403', '元宝山区', '', '150400', '24076', 'ybsq', 'YuanBaoShanQu');
INSERT INTO `area` VALUES ('150404', '松山区', '', '150400', '24005', 'ssq', 'SongShanQu');
INSERT INTO `area` VALUES ('150421', '阿鲁科尔沁旗', '', '150400', '25550', 'alkeqq', 'ALuKeErQinQi');
INSERT INTO `area` VALUES ('150422', '巴林左旗', '', '150400', '25450', 'blzq', 'BaLinZuoQi');
INSERT INTO `area` VALUES ('150423', '巴林右旗', '', '150400', '25150', 'blyq', 'BaLinYouQi');
INSERT INTO `area` VALUES ('150424', '林西县', '', '150400', '25250', 'lxx', 'LinXiXian');
INSERT INTO `area` VALUES ('150425', '克什克腾旗', '', '150400', '25350', 'ksktq', 'KeShiKeTengQi');
INSERT INTO `area` VALUES ('150426', '翁牛特旗', '', '150400', '24500', 'wntq', 'WengNiuTeQi');
INSERT INTO `area` VALUES ('150428', '喀喇沁旗', '', '150400', '24400', 'klqq', 'KaLaQinQi');
INSERT INTO `area` VALUES ('150429', '宁城县', '', '150400', '24200', 'ncx', 'NingChengXian');
INSERT INTO `area` VALUES ('150430', '敖汉旗', '', '150400', '24300', 'ahq', 'AoHanQi');
INSERT INTO `area` VALUES ('150431', '其它区', '', '150400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('150500', '通辽市', '', '150000', '28000', 'tls', 'TongLiaoShi');
INSERT INTO `area` VALUES ('150502', '科尔沁区', '', '150500', '28000', 'keqq', 'KeErQinQu');
INSERT INTO `area` VALUES ('150521', '科尔沁左翼中旗', '', '150500', '29300', 'keqzyzq', 'KeErQinZuoYiZhongQi');
INSERT INTO `area` VALUES ('150522', '科尔沁左翼后旗', '', '150500', '28100', 'keqzyhq', 'KeErQinZuoYiHouQi');
INSERT INTO `area` VALUES ('150523', '开鲁县', '', '150500', '28400', 'klx', 'KaiLuXian');
INSERT INTO `area` VALUES ('150524', '库伦旗', '', '150500', '28200', 'klq', 'KuLunQi');
INSERT INTO `area` VALUES ('150525', '奈曼旗', '', '150500', '28300', 'nmq', 'NaiManQi');
INSERT INTO `area` VALUES ('150526', '扎鲁特旗', '', '150500', '29100', 'zltq', 'ZhaLuTeQi');
INSERT INTO `area` VALUES ('150581', '霍林郭勒市', '', '150500', '29200', 'hlgls', 'HuoLinGuoLeShi');
INSERT INTO `area` VALUES ('150582', '其它区', '', '150500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('150600', '鄂尔多斯市', '', '150000', '17004', 'eedss', 'EErDuoSiShi');
INSERT INTO `area` VALUES ('150602', '东胜区', '', '150600', '17000', 'dsq', 'DongShengQu');
INSERT INTO `area` VALUES ('150621', '达拉特旗', '', '150600', '14300', 'dltq', 'DaLaTeQi');
INSERT INTO `area` VALUES ('150622', '准格尔旗', '', '150600', '17100', 'zgeq', 'ZhunGeErQi');
INSERT INTO `area` VALUES ('150623', '鄂托克前旗', '', '150600', '16200', 'etkqq', 'ETuoKeQianQi');
INSERT INTO `area` VALUES ('150624', '鄂托克旗', '', '150600', '16100', 'etkq', 'ETuoKeQi');
INSERT INTO `area` VALUES ('150625', '杭锦旗', '', '150600', '17400', 'hjq', 'HangJinQi');
INSERT INTO `area` VALUES ('150626', '乌审旗', '', '150600', '17300', 'wsq', 'WuShenQi');
INSERT INTO `area` VALUES ('150627', '伊金霍洛旗', '', '150600', '17200', 'yjhlq', 'YiJinHuoLuoQi');
INSERT INTO `area` VALUES ('150628', '其它区', '', '150600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('150700', '呼伦贝尔市', '', '150000', '21008', 'hlbes', 'HuLunBeiErShi');
INSERT INTO `area` VALUES ('150702', '海拉尔区', '', '150700', '21000', 'hleq', 'HaiLaErQu');
INSERT INTO `area` VALUES ('150721', '阿荣旗', '', '150700', '162750', 'arq', 'ARongQi');
INSERT INTO `area` VALUES ('150722', '莫力达瓦达斡尔族自治旗', '', '150700', '162850', 'mldwdwezzzq', 'MoLiDaWaDaWoErZuZiZhi');
INSERT INTO `area` VALUES ('150723', '鄂伦春自治旗', '', '150700', '165450', 'elczzq', 'ELunChunZiZhiQi');
INSERT INTO `area` VALUES ('150724', '鄂温克族自治旗', '', '150700', '21100', 'ewkzzzq', 'EWenKeZuZiZhiQi');
INSERT INTO `area` VALUES ('150725', '陈巴尔虎旗', '', '150700', '21500', 'cbehq', 'ChenBaErHuQi');
INSERT INTO `area` VALUES ('150726', '新巴尔虎左旗', '', '150700', '21200', 'xbehzq', 'XinBaErHuZuoQi');
INSERT INTO `area` VALUES ('150727', '新巴尔虎右旗', '', '150700', '21300', 'xbehyq', 'XinBaErHuYouQi');
INSERT INTO `area` VALUES ('150781', '满洲里市', '', '150700', '21400', 'mzls', 'ManZhouLiShi');
INSERT INTO `area` VALUES ('150782', '牙克石市', '', '150700', '162650', 'ykss', 'YaKeShiShi');
INSERT INTO `area` VALUES ('150783', '扎兰屯市', '', '150700', '162650', 'zlts', 'ZhaLanTunShi');
INSERT INTO `area` VALUES ('150784', '额尔古纳市', '', '150700', '22250', 'eegns', 'EErGuNaShi');
INSERT INTO `area` VALUES ('150785', '根河市', '', '150700', '22350', 'ghs', 'GenHeShi');
INSERT INTO `area` VALUES ('150786', '其它区', '', '150700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('150800', '巴彦淖尔市', '', '150000', '15001', 'bynes', 'BaYanNaoErShi');
INSERT INTO `area` VALUES ('150802', '临河区', '', '150800', '15001', 'lhq', 'LinHeQu');
INSERT INTO `area` VALUES ('150821', '五原县', '', '150800', '15100', 'wyx', 'WuYuanXian');
INSERT INTO `area` VALUES ('150822', '磴口县', '', '150800', '15200', 'dkx', 'ZuoKouXian');
INSERT INTO `area` VALUES ('150823', '乌拉特前旗', '', '150800', '15400', 'wltqq', 'WuLaTeQianQi');
INSERT INTO `area` VALUES ('150824', '乌拉特中旗', '', '150800', '15300', 'wltzq', 'WuLaTeZhongQi');
INSERT INTO `area` VALUES ('150825', '乌拉特后旗', '', '150800', '15500', 'wlthq', 'WuLaTeHouQi');
INSERT INTO `area` VALUES ('150826', '杭锦后旗', '', '150800', '15400', 'hjhq', 'HangJinHouQi');
INSERT INTO `area` VALUES ('150827', '其它区', '', '150800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('150900', '乌兰察布市', '', '150000', '12000', 'wlcbs', 'WuLanChaBuShi');
INSERT INTO `area` VALUES ('150902', '集宁区', '', '150900', '12000', 'jnq', 'JiNingQu');
INSERT INTO `area` VALUES ('150921', '卓资县', '', '150900', '12300', 'zzx', 'ZhuoZiXian');
INSERT INTO `area` VALUES ('150922', '化德县', '', '150900', '13350', 'hdx', 'HuaDeXian');
INSERT INTO `area` VALUES ('150923', '商都县', '', '150900', '13400', 'sdx', 'ShangDuXian');
INSERT INTO `area` VALUES ('150924', '兴和县', '', '150900', '13650', 'xhx', 'XingHeXian');
INSERT INTO `area` VALUES ('150925', '凉城县', '', '150900', '13750', 'lcx', 'LiangChengXian');
INSERT INTO `area` VALUES ('150926', '察哈尔右翼前旗', '', '150900', '12200', 'cheyyqq', 'ChaHaErYouYiQianQi');
INSERT INTO `area` VALUES ('150927', '察哈尔右翼中旗', '', '150900', '13550', 'cheyyzq', 'ChaHaErYouYiZhongQi');
INSERT INTO `area` VALUES ('150928', '察哈尔右翼后旗', '', '150900', '12400', 'cheyyhq', 'ChaHaErYouYiHouQi');
INSERT INTO `area` VALUES ('150929', '四子王旗', '', '150900', '11800', 'szwq', 'SiZiWangQi');
INSERT INTO `area` VALUES ('150981', '丰镇市', '', '150900', '12100', 'fzs', 'FengZhenShi');
INSERT INTO `area` VALUES ('150982', '其它区', '', '150900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('152200', '兴安盟', '', '150000', '137401', 'xam', 'XingAnMeng');
INSERT INTO `area` VALUES ('152201', '乌兰浩特市', '', '152200', '137400', 'wlhts', 'WuLanHaoTeShi');
INSERT INTO `area` VALUES ('152202', '阿尔山市', '', '152200', '137800', 'aess', 'AErShanShi');
INSERT INTO `area` VALUES ('152221', '科尔沁右翼前旗', '', '152200', '137400', 'keqyyqq', 'KeErQinYouYiQianQi');
INSERT INTO `area` VALUES ('152222', '科尔沁右翼中旗', '', '152200', '29400', 'keqyyzq', 'KeErQinYouYiZhongQi');
INSERT INTO `area` VALUES ('152223', '扎赉特旗', '', '152200', '137600', 'zltq', 'ZhaZuoTeQi');
INSERT INTO `area` VALUES ('152224', '突泉县', '', '152200', '137500', 'tqx', 'TuQuanXian');
INSERT INTO `area` VALUES ('152225', '其它区', '', '152200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('152500', '锡林郭勒盟', '', '150000', '26021', 'xlglm', 'XiLinGuoLeMeng');
INSERT INTO `area` VALUES ('152501', '二连浩特市', '', '152500', '11100', 'elhts', 'ErLianHaoTeShi');
INSERT INTO `area` VALUES ('152502', '锡林浩特市', '', '152500', '26000', 'xlhts', 'XiLinHaoTeShi');
INSERT INTO `area` VALUES ('152522', '阿巴嘎旗', '', '152500', '11400', 'abgq', 'ABaGaQi');
INSERT INTO `area` VALUES ('152523', '苏尼特左旗', '', '152500', '11300', 'sntzq', 'SuNiTeZuoQi');
INSERT INTO `area` VALUES ('152524', '苏尼特右旗', '', '152500', '11200', 'sntyq', 'SuNiTeYouQi');
INSERT INTO `area` VALUES ('152525', '东乌珠穆沁旗', '', '152500', '26300', 'dwzmqq', 'DongWuZhuMuQinQi');
INSERT INTO `area` VALUES ('152526', '西乌珠穆沁旗', '', '152500', '26200', 'xwzmqq', 'XiWuZhuMuQinQi');
INSERT INTO `area` VALUES ('152527', '太仆寺旗', '', '152500', '27000', 'tpsq', 'TaiPuSiQi');
INSERT INTO `area` VALUES ('152528', '镶黄旗', '', '152500', '13250', 'xhq', 'XiangHuangQi');
INSERT INTO `area` VALUES ('152529', '正镶白旗', '', '152500', '13800', 'zxbq', 'ZhengXiangBaiQi');
INSERT INTO `area` VALUES ('152530', '正蓝旗', '', '152500', '27200', 'zlq', 'ZhengLanQi');
INSERT INTO `area` VALUES ('152531', '多伦县', '', '152500', '27300', 'dlx', 'DuoLunXian');
INSERT INTO `area` VALUES ('152532', '其它区', '', '152500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('152900', '阿拉善盟', '', '150000', '750306', 'alsm', 'ALaShanMeng');
INSERT INTO `area` VALUES ('152921', '阿拉善左旗', '', '152900', '750300', 'alszq', 'ALaShanZuoQi');
INSERT INTO `area` VALUES ('152922', '阿拉善右旗', '', '152900', '737300', 'alsyq', 'ALaShanYouQi');
INSERT INTO `area` VALUES ('152923', '额济纳旗', '', '152900', '735400', 'ejnq', 'EJiNaQi');
INSERT INTO `area` VALUES ('152924', '其它区', '', '152900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('210000', '辽宁省', '', '1', '', 'lns', 'LiaoNingSheng');
INSERT INTO `area` VALUES ('210100', '沈阳市', '', '210000', '110000', 'sys', 'ShenYangShi');
INSERT INTO `area` VALUES ('210102', '和平区', '', '210100', '110002', 'hpq', 'HePingQu');
INSERT INTO `area` VALUES ('210103', '沈河区', '', '210100', '110013', 'shq', 'ShenHeQu');
INSERT INTO `area` VALUES ('210104', '大东区', '', '210100', '110044', 'ddq', 'DaDongQu');
INSERT INTO `area` VALUES ('210105', '皇姑区', '', '210100', '110031', 'hgq', 'HuangGuQu');
INSERT INTO `area` VALUES ('210106', '铁西区', '', '210100', '110023', 'txq', 'TieXiQu');
INSERT INTO `area` VALUES ('210111', '苏家屯区', '', '210100', '110102', 'sjtq', 'SuJiaTunQu');
INSERT INTO `area` VALUES ('210112', '东陵区', '', '210100', '110015', 'dlq', 'DongLingQu');
INSERT INTO `area` VALUES ('210113', '新城子区', '', '210100', '110121', 'xczq', 'XinChengZiQu');
INSERT INTO `area` VALUES ('210114', '于洪区', '', '210100', '110024', 'yhq', 'YuHongQu');
INSERT INTO `area` VALUES ('210122', '辽中县', '', '210100', '110200', 'lzx', 'LiaoZhongXian');
INSERT INTO `area` VALUES ('210123', '康平县', '', '210100', '110500', 'kpx', 'KangPingXian');
INSERT INTO `area` VALUES ('210124', '法库县', '', '210100', '110400', 'fkx', 'FaKuXian');
INSERT INTO `area` VALUES ('210181', '新民市', '', '210100', '110300', 'xms', 'XinMinShi');
INSERT INTO `area` VALUES ('210182', '浑南新区', '', '210100', '', 'hnxq', 'HunNanXinQu');
INSERT INTO `area` VALUES ('210183', '张士开发区', '', '210100', '', 'zskfq', 'ZhangShiKaiFaQu');
INSERT INTO `area` VALUES ('210184', '沈北新区', '', '210100', '', 'sbxq', 'ShenBeiXinQu');
INSERT INTO `area` VALUES ('210185', '其它区', '', '210100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('210200', '大连市', '', '210000', '116000', 'dls', 'DaLianShi');
INSERT INTO `area` VALUES ('210202', '中山区', '', '210200', '116001', 'zsq', 'ZhongShanQu');
INSERT INTO `area` VALUES ('210203', '西岗区', '', '210200', '116011', 'xgq', 'XiGangQu');
INSERT INTO `area` VALUES ('210204', '沙河口区', '', '210200', '116021', 'shkq', 'ShaHeKouQu');
INSERT INTO `area` VALUES ('210211', '甘井子区', '', '210200', '116033', 'gjzq', 'GanJingZiQu');
INSERT INTO `area` VALUES ('210212', '旅顺口区', '', '210200', '116041', 'lskq', 'LvShunKouQu');
INSERT INTO `area` VALUES ('210213', '金州区', '', '210200', '116100', 'jzq', 'JinZhouQu');
INSERT INTO `area` VALUES ('210224', '长海县', '', '210200', '116500', 'chx', 'ChangHaiXian');
INSERT INTO `area` VALUES ('210251', '开发区', '', '210200', '', 'kfq', 'KaiFaQu');
INSERT INTO `area` VALUES ('210281', '瓦房店市', '', '210200', '116300', 'wfds', 'WaFangDianShi');
INSERT INTO `area` VALUES ('210282', '普兰店市', '', '210200', '116200', 'plds', 'PuLanDianShi');
INSERT INTO `area` VALUES ('210283', '庄河市', '', '210200', '116400', 'zhs', 'ZhuangHeShi');
INSERT INTO `area` VALUES ('210297', '岭前区', '', '210200', '', 'lqq', 'LingQianQu');
INSERT INTO `area` VALUES ('210298', '其它区', '', '210200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('210300', '鞍山市', '', '210000', '114000', 'ass', 'AnShanShi');
INSERT INTO `area` VALUES ('210302', '铁东区', '', '210300', '114001', 'tdq', 'TieDongQu');
INSERT INTO `area` VALUES ('210303', '铁西区', '', '210300', '110023', 'txq', 'TieXiQu');
INSERT INTO `area` VALUES ('210304', '立山区', '', '210300', '114031', 'lsq', 'LiShanQu');
INSERT INTO `area` VALUES ('210311', '千山区', '', '210300', '114041', 'qsq', 'QianShanQu');
INSERT INTO `area` VALUES ('210321', '台安县', '', '210300', '114100', 'tax', 'TaiAnXian');
INSERT INTO `area` VALUES ('210323', '岫岩满族自治县', '', '210300', '114300', 'xymzzzx', 'ZuoYanManZuZiZhiXian');
INSERT INTO `area` VALUES ('210351', '高新区', '', '210300', '', 'gxq', 'GaoXinQu');
INSERT INTO `area` VALUES ('210381', '海城市', '', '210300', '114200', 'hcs', 'HaiChengShi');
INSERT INTO `area` VALUES ('210382', '其它区', '', '210300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('210400', '抚顺市', '', '210000', '113000', 'fss', 'FuShunShi');
INSERT INTO `area` VALUES ('210402', '新抚区', '', '210400', '113006', 'xfq', 'XinFuQu');
INSERT INTO `area` VALUES ('210403', '东洲区', '', '210400', '113003', 'dzq', 'DongZhouQu');
INSERT INTO `area` VALUES ('210404', '望花区', '', '210400', '113001', 'whq', 'WangHuaQu');
INSERT INTO `area` VALUES ('210411', '顺城区', '', '210400', '113006', 'scq', 'ShunChengQu');
INSERT INTO `area` VALUES ('210421', '抚顺县', '', '210400', '113100', 'fsx', 'FuShunXian');
INSERT INTO `area` VALUES ('210422', '新宾满族自治县', '', '210400', '113200', 'xbmzzzx', 'XinBinManZuZiZhiXian');
INSERT INTO `area` VALUES ('210423', '清原满族自治县', '', '210400', '113300', 'qymzzzx', 'QingYuanManZuZiZhiXian');
INSERT INTO `area` VALUES ('210424', '其它区', '', '210400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('210500', '本溪市', '', '210000', '117000', 'bxs', 'BenXiShi');
INSERT INTO `area` VALUES ('210502', '平山区', '', '210500', '117000', 'psq', 'PingShanQu');
INSERT INTO `area` VALUES ('210503', '溪湖区', '', '210500', '117002', 'xhq', 'XiHuQu');
INSERT INTO `area` VALUES ('210504', '明山区', '', '210500', '117021', 'msq', 'MingShanQu');
INSERT INTO `area` VALUES ('210505', '南芬区', '', '210500', '117014', 'nfq', 'NanFenQu');
INSERT INTO `area` VALUES ('210521', '本溪满族自治县', '', '210500', '117100', 'bxmzzzx', 'BenXiManZuZiZhiXian');
INSERT INTO `area` VALUES ('210522', '桓仁满族自治县', '', '210500', '117200', 'hrmzzzx', 'HuanRenManZuZiZhiXian');
INSERT INTO `area` VALUES ('210523', '其它区', '', '210500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('210600', '丹东市', '', '210000', '118000', 'dds', 'DanDongShi');
INSERT INTO `area` VALUES ('210602', '元宝区', '', '210600', '118000', 'ybq', 'YuanBaoQu');
INSERT INTO `area` VALUES ('210603', '振兴区', '', '210600', '118002', 'zxq', 'ZhenXingQu');
INSERT INTO `area` VALUES ('210604', '振安区', '', '210600', '118001', 'zaq', 'ZhenAnQu');
INSERT INTO `area` VALUES ('210624', '宽甸满族自治县', '', '210600', '118200', 'kdmzzzx', 'KuanDianManZuZiZhiXian');
INSERT INTO `area` VALUES ('210681', '东港市', '', '210600', '118300', 'dgs', 'DongGangShi');
INSERT INTO `area` VALUES ('210682', '凤城市', '', '210600', '118100', 'fcs', 'FengChengShi');
INSERT INTO `area` VALUES ('210683', '其它区', '', '210600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('210700', '锦州市', '', '210000', '121000', 'jzs', 'JinZhouShi');
INSERT INTO `area` VALUES ('210702', '古塔区', '', '210700', '121001', 'gtq', 'GuTaQu');
INSERT INTO `area` VALUES ('210703', '凌河区', '', '210700', '121000', 'lhq', 'LingHeQu');
INSERT INTO `area` VALUES ('210711', '太和区', '', '210700', '121011', 'thq', 'TaiHeQu');
INSERT INTO `area` VALUES ('210726', '黑山县', '', '210700', '121400', 'hsx', 'HeiShanXian');
INSERT INTO `area` VALUES ('210727', '义县', '', '210700', '121100', 'yx', 'YiXian');
INSERT INTO `area` VALUES ('210781', '凌海市', '', '210700', '121200', 'lhs', 'LingHaiShi');
INSERT INTO `area` VALUES ('210782', '北镇市', '', '210700', '121300', 'bzs', 'BeiZhenShi');
INSERT INTO `area` VALUES ('210783', '其它区', '', '210700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('210800', '营口市', '', '210000', '115000', 'yks', 'YingKouShi');
INSERT INTO `area` VALUES ('210802', '站前区', '', '210800', '115002', 'zqq', 'ZhanQianQu');
INSERT INTO `area` VALUES ('210803', '西市区', '', '210800', '115004', 'xsq', 'XiShiQu');
INSERT INTO `area` VALUES ('210804', '鲅鱼圈区', '', '210800', '115007', 'byqq', 'ZuoYuQuanQu');
INSERT INTO `area` VALUES ('210811', '老边区', '', '210800', '115005', 'lbq', 'LaoBianQu');
INSERT INTO `area` VALUES ('210881', '盖州市', '', '210800', '115200', 'gzs', 'GaiZhouShi');
INSERT INTO `area` VALUES ('210882', '大石桥市', '', '210800', '115100', 'dsqs', 'DaShiQiaoShi');
INSERT INTO `area` VALUES ('210883', '其它区', '', '210800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('210900', '阜新市', '', '210000', '123000', 'fxs', 'FuXinShi');
INSERT INTO `area` VALUES ('210902', '海州区', '', '210900', '123000', 'hzq', 'HaiZhouQu');
INSERT INTO `area` VALUES ('210903', '新邱区', '', '210900', '123005', 'xqq', 'XinQiuQu');
INSERT INTO `area` VALUES ('210904', '太平区', '', '210900', '123003', 'tpq', 'TaiPingQu');
INSERT INTO `area` VALUES ('210905', '清河门区', '', '210900', '123006', 'qhmq', 'QingHeMenQu');
INSERT INTO `area` VALUES ('210911', '细河区', '', '210900', '123000', 'xhq', 'XiHeQu');
INSERT INTO `area` VALUES ('210921', '阜新蒙古族自治县', '', '210900', '123100', 'fxmgzzzx', 'FuXinMengGuZuZiZhiXian');
INSERT INTO `area` VALUES ('210922', '彰武县', '', '210900', '123200', 'zwx', 'ZhangWuXian');
INSERT INTO `area` VALUES ('210923', '其它区', '', '210900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('211000', '辽阳市', '', '210000', '111000', 'lys', 'LiaoYangShi');
INSERT INTO `area` VALUES ('211002', '白塔区', '', '211000', '111000', 'btq', 'BaiTaQu');
INSERT INTO `area` VALUES ('211003', '文圣区', '', '211000', '111000', 'wsq', 'WenShengQu');
INSERT INTO `area` VALUES ('211004', '宏伟区', '', '211000', '111003', 'hwq', 'HongWeiQu');
INSERT INTO `area` VALUES ('211005', '弓长岭区', '', '211000', '111008', 'gclq', 'GongChangLingQu');
INSERT INTO `area` VALUES ('211011', '太子河区', '', '211000', '111000', 'tzhq', 'TaiZiHeQu');
INSERT INTO `area` VALUES ('211021', '辽阳县', '', '211000', '111200', 'lyx', 'LiaoYangXian');
INSERT INTO `area` VALUES ('211081', '灯塔市', '', '211000', '111300', 'dts', 'DengTaShi');
INSERT INTO `area` VALUES ('211082', '其它区', '', '211000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('211100', '盘锦市', '', '210000', '124000', 'pjs', 'PanJinShi');
INSERT INTO `area` VALUES ('211102', '双台子区', '', '211100', '124000', 'stzq', 'ShuangTaiZiQu');
INSERT INTO `area` VALUES ('211103', '兴隆台区', '', '211100', '124010', 'xltq', 'XingLongTaiQu');
INSERT INTO `area` VALUES ('211121', '大洼县', '', '211100', '124000', 'dwx', 'DaWaXian');
INSERT INTO `area` VALUES ('211122', '盘山县', '', '211100', '124100', 'psx', 'PanShanXian');
INSERT INTO `area` VALUES ('211123', '其它区', '', '211100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('211200', '铁岭市', '', '210000', '112000', 'tls', 'TieLingShi');
INSERT INTO `area` VALUES ('211202', '银州区', '', '211200', '112000', 'yzq', 'YinZhouQu');
INSERT INTO `area` VALUES ('211204', '清河区', '', '211200', '112003', 'qhq', 'QingHeQu');
INSERT INTO `area` VALUES ('211221', '铁岭县', '', '211200', '112600', 'tlx', 'TieLingXian');
INSERT INTO `area` VALUES ('211223', '西丰县', '', '211200', '112400', 'xfx', 'XiFengXian');
INSERT INTO `area` VALUES ('211224', '昌图县', '', '211200', '112500', 'ctx', 'ChangTuXian');
INSERT INTO `area` VALUES ('211281', '调兵山市', '', '211200', '112700', 'dbss', 'DiaoBingShanShi');
INSERT INTO `area` VALUES ('211282', '开原市', '', '211200', '112300', 'kys', 'KaiYuanShi');
INSERT INTO `area` VALUES ('211283', '其它区', '', '211200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('211300', '朝阳市', '', '210000', '122000', 'cys', 'ChaoYangShi');
INSERT INTO `area` VALUES ('211302', '双塔区', '', '211300', '122000', 'stq', 'ShuangTaQu');
INSERT INTO `area` VALUES ('211303', '龙城区', '', '211300', '122000', 'lcq', 'LongChengQu');
INSERT INTO `area` VALUES ('211321', '朝阳县', '', '211300', '122000', 'cyx', 'ChaoYangXian');
INSERT INTO `area` VALUES ('211322', '建平县', '', '211300', '122400', 'jpx', 'JianPingXian');
INSERT INTO `area` VALUES ('211324', '喀喇沁左翼蒙古族自治县', '', '211300', '122300', 'klqzymgzzzx', 'KaLaQinZuoYiMengGuZuZiZhi');
INSERT INTO `area` VALUES ('211381', '北票市', '', '211300', '122100', 'bps', 'BeiPiaoShi');
INSERT INTO `area` VALUES ('211382', '凌源市', '', '211300', '122500', 'lys', 'LingYuanShi');
INSERT INTO `area` VALUES ('211383', '其它区', '', '211300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('211400', '葫芦岛市', '', '210000', '125000', 'hlds', 'HuLuDaoShi');
INSERT INTO `area` VALUES ('211402', '连山区', '', '211400', '125001', 'lsq', 'LianShanQu');
INSERT INTO `area` VALUES ('211403', '龙港区', '', '211400', '125004', 'lgq', 'LongGangQu');
INSERT INTO `area` VALUES ('211404', '南票区', '', '211400', '125027', 'npq', 'NanPiaoQu');
INSERT INTO `area` VALUES ('211421', '绥中县', '', '211400', '125200', 'szx', 'SuiZhongXian');
INSERT INTO `area` VALUES ('211422', '建昌县', '', '211400', '125300', 'jcx', 'JianChangXian');
INSERT INTO `area` VALUES ('211481', '兴城市', '', '211400', '125100', 'xcs', 'XingChengShi');
INSERT INTO `area` VALUES ('211482', '其它区', '', '211400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('220000', '吉林省', '', '1', '', 'jls', 'JiLinSheng');
INSERT INTO `area` VALUES ('220100', '长春市', '', '220000', '130000', 'ccs', 'ChangChunShi');
INSERT INTO `area` VALUES ('220102', '南关区', '', '220100', '130022', 'ngq', 'NanGuanQu');
INSERT INTO `area` VALUES ('220103', '宽城区', '', '220100', '130051', 'kcq', 'KuanChengQu');
INSERT INTO `area` VALUES ('220104', '朝阳区', '', '220100', '130012', 'cyq', 'ChaoYangQu');
INSERT INTO `area` VALUES ('220105', '二道区', '', '220100', '130031', 'edq', 'ErDaoQu');
INSERT INTO `area` VALUES ('220106', '绿园区', '', '220100', '130062', 'lyq', 'LvYuanQu');
INSERT INTO `area` VALUES ('220112', '双阳区', '', '220100', '130600', 'syq', 'ShuangYangQu');
INSERT INTO `area` VALUES ('220122', '农安县', '', '220100', '130200', 'nax', 'NongAnXian');
INSERT INTO `area` VALUES ('220181', '九台市', '', '220100', '130500', 'jts', 'JiuTaiShi');
INSERT INTO `area` VALUES ('220182', '榆树市', '', '220100', '130400', 'yss', 'YuShuShi');
INSERT INTO `area` VALUES ('220183', '德惠市', '', '220100', '130300', 'dhs', 'DeHuiShi');
INSERT INTO `area` VALUES ('220184', '高新技术产业开发区', '', '220100', '', 'gxjscykfq', 'GaoXinJiShuChanYeKaiFaQu');
INSERT INTO `area` VALUES ('220185', '汽车产业开发区', '', '220100', '', 'qccykfq', 'QiCheChanYeKaiFaQu');
INSERT INTO `area` VALUES ('220186', '经济技术开发区', '', '220100', '', 'jjjskfq', 'JingJiJiShuKaiFaQu');
INSERT INTO `area` VALUES ('220187', '净月旅游开发区', '', '220100', '', 'jylykfq', 'JingYueLvYouKaiFaQu');
INSERT INTO `area` VALUES ('220188', '其它区', '', '220100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('220200', '吉林市', '', '220000', '132000', 'jls', 'JiLinShi');
INSERT INTO `area` VALUES ('220202', '昌邑区', '', '220200', '132002', 'cyq', 'ChangYiQu');
INSERT INTO `area` VALUES ('220203', '龙潭区', '', '220200', '132021', 'ltq', 'LongTanQu');
INSERT INTO `area` VALUES ('220204', '船营区', '', '220200', '132011', 'cyq', 'ChuanYingQu');
INSERT INTO `area` VALUES ('220211', '丰满区', '', '220200', '132113', 'fmq', 'FengManQu');
INSERT INTO `area` VALUES ('220221', '永吉县', '', '220200', '132100', 'yjx', 'YongJiXian');
INSERT INTO `area` VALUES ('220281', '蛟河市', '', '220200', '132500', 'jhs', 'ZuoHeShi');
INSERT INTO `area` VALUES ('220282', '桦甸市', '', '220200', '132400', 'hds', 'ZuoDianShi');
INSERT INTO `area` VALUES ('220283', '舒兰市', '', '220200', '132600', 'sls', 'ShuLanShi');
INSERT INTO `area` VALUES ('220284', '磐石市', '', '220200', '132300', 'pss', 'PanShiShi');
INSERT INTO `area` VALUES ('220285', '其它区', '', '220200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('220300', '四平市', '', '220000', '136000', 'sps', 'SiPingShi');
INSERT INTO `area` VALUES ('220302', '铁西区', '', '220300', '136000', 'txq', 'TieXiQu');
INSERT INTO `area` VALUES ('220303', '铁东区', '', '220300', '136001', 'tdq', 'TieDongQu');
INSERT INTO `area` VALUES ('220322', '梨树县', '', '220300', '136500', 'lsx', 'LiShuXian');
INSERT INTO `area` VALUES ('220323', '伊通满族自治县', '', '220300', '130700', 'ytmzzzx', 'YiTongManZuZiZhiXian');
INSERT INTO `area` VALUES ('220381', '公主岭市', '', '220300', '136100', 'gzls', 'GongZhuLingShi');
INSERT INTO `area` VALUES ('220382', '双辽市', '', '220300', '136400', 'sls', 'ShuangLiaoShi');
INSERT INTO `area` VALUES ('220383', '其它区', '', '220300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('220400', '辽源市', '', '220000', '136200', 'lys', 'LiaoYuanShi');
INSERT INTO `area` VALUES ('220402', '龙山区', '', '220400', '136200', 'lsq', 'LongShanQu');
INSERT INTO `area` VALUES ('220403', '西安区', '', '220400', '136201', 'xaq', 'XiAnQu');
INSERT INTO `area` VALUES ('220421', '东丰县', '', '220400', '136300', 'dfx', 'DongFengXian');
INSERT INTO `area` VALUES ('220422', '东辽县', '', '220400', '136600', 'dlx', 'DongLiaoXian');
INSERT INTO `area` VALUES ('220423', '其它区', '', '220400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('220500', '通化市', '', '220000', '134000', 'ths', 'TongHuaShi');
INSERT INTO `area` VALUES ('220502', '东昌区', '', '220500', '134001', 'dcq', 'DongChangQu');
INSERT INTO `area` VALUES ('220503', '二道江区', '', '220500', '134303', 'edjq', 'ErDaoJiangQu');
INSERT INTO `area` VALUES ('220521', '通化县', '', '220500', '134100', 'thx', 'TongHuaXian');
INSERT INTO `area` VALUES ('220523', '辉南县', '', '220500', '135100', 'hnx', 'HuiNanXian');
INSERT INTO `area` VALUES ('220524', '柳河县', '', '220500', '135300', 'lhx', 'LiuHeXian');
INSERT INTO `area` VALUES ('220581', '梅河口市', '', '220500', '135000', 'mhks', 'MeiHeKouShi');
INSERT INTO `area` VALUES ('220582', '集安市', '', '220500', '134200', 'jas', 'JiAnShi');
INSERT INTO `area` VALUES ('220583', '其它区', '', '220500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('220600', '白山市', '', '220000', '134300', 'bss', 'BaiShanShi');
INSERT INTO `area` VALUES ('220602', '八道江区', '', '220600', '134300', 'bdjq', 'BaDaoJiangQu');
INSERT INTO `area` VALUES ('220621', '抚松县', '', '220600', '134500', 'fsx', 'FuSongXian');
INSERT INTO `area` VALUES ('220622', '靖宇县', '', '220600', '135200', 'jyx', 'JingYuXian');
INSERT INTO `area` VALUES ('220623', '长白朝鲜族自治县', '', '220600', '134400', 'cbcxzzzx', 'ChangBaiChaoXianZuZiZhiXian');
INSERT INTO `area` VALUES ('220625', '江源县', '', '220600', '134700', 'jyx', 'JiangYuanXian');
INSERT INTO `area` VALUES ('220681', '临江市', '', '220600', '134600', 'ljs', 'LinJiangShi');
INSERT INTO `area` VALUES ('220682', '其它区', '', '220600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('220700', '松原市', '', '220000', '138000', 'sys', 'SongYuanShi');
INSERT INTO `area` VALUES ('220702', '宁江区', '', '220700', '138000', 'njq', 'NingJiangQu');
INSERT INTO `area` VALUES ('220721', '前郭尔罗斯蒙古族自治县', '', '220700', '131100', 'qgelsmgzzzx', 'QianGuoErLuoSiMengGuZuZiZhi');
INSERT INTO `area` VALUES ('220722', '长岭县', '', '220700', '131500', 'clx', 'ChangLingXian');
INSERT INTO `area` VALUES ('220723', '乾安县', '', '220700', '131400', 'qax', 'QianAnXian');
INSERT INTO `area` VALUES ('220724', '扶余县', '', '220700', '131200', 'fyx', 'FuYuXian');
INSERT INTO `area` VALUES ('220725', '其它区', '', '220700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('220800', '白城市', '', '220000', '137000', 'bcs', 'BaiChengShi');
INSERT INTO `area` VALUES ('220802', '洮北区', '', '220800', '137000', 'tbq', 'ZuoBeiQu');
INSERT INTO `area` VALUES ('220821', '镇赉县', '', '220800', '137300', 'zlx', 'ZhenZuoXian');
INSERT INTO `area` VALUES ('220822', '通榆县', '', '220800', '137200', 'tyx', 'TongYuXian');
INSERT INTO `area` VALUES ('220881', '洮南市', '', '220800', '137100', 'tns', 'ZuoNanShi');
INSERT INTO `area` VALUES ('220882', '大安市', '', '220800', '131300', 'das', 'DaAnShi');
INSERT INTO `area` VALUES ('220883', '其它区', '', '220800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('222400', '延边朝鲜族自治州', '', '220000', '133000', 'ybcxzzzz', 'YanBianChaoXianZuZiZhiZhou');
INSERT INTO `area` VALUES ('222401', '延吉市', '', '222400', '133000', 'yjs', 'YanJiShi');
INSERT INTO `area` VALUES ('222402', '图们市', '', '222400', '133100', 'tms', 'TuMenShi');
INSERT INTO `area` VALUES ('222403', '敦化市', '', '222400', '133700', 'dhs', 'DunHuaShi');
INSERT INTO `area` VALUES ('222404', '珲春市', '', '222400', '133300', 'hcs', 'ZuoChunShi');
INSERT INTO `area` VALUES ('222405', '龙井市', '', '222400', '133400', 'ljs', 'LongJingShi');
INSERT INTO `area` VALUES ('222406', '和龙市', '', '222400', '133500', 'hls', 'HeLongShi');
INSERT INTO `area` VALUES ('222424', '汪清县', '', '222400', '133200', 'wqx', 'WangQingXian');
INSERT INTO `area` VALUES ('222426', '安图县', '', '222400', '133600', 'atx', 'AnTuXian');
INSERT INTO `area` VALUES ('222427', '其它区', '', '222400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('230000', '黑龙江省', '', '1', '', 'hljs', 'HeiLongJiangSheng');
INSERT INTO `area` VALUES ('230100', '哈尔滨市', '', '230000', '150000', 'hebs', 'HaErBinShi');
INSERT INTO `area` VALUES ('230102', '道里区', '', '230100', '150010', 'dlq', 'DaoLiQu');
INSERT INTO `area` VALUES ('230103', '南岗区', '', '230100', '150006', 'ngq', 'NanGangQu');
INSERT INTO `area` VALUES ('230104', '道外区', '', '230100', '150026', 'dwq', 'DaoWaiQu');
INSERT INTO `area` VALUES ('230106', '香坊区', '', '230100', '150036', 'xfq', 'XiangFangQu');
INSERT INTO `area` VALUES ('230107', '动力区', '', '230100', '150040', 'dlq', 'DongLiQu');
INSERT INTO `area` VALUES ('230108', '平房区', '', '230100', '150060', 'pfq', 'PingFangQu');
INSERT INTO `area` VALUES ('230109', '松北区', '', '230100', '150028', 'sbq', 'SongBeiQu');
INSERT INTO `area` VALUES ('230111', '呼兰区', '', '230100', '150500', 'hlq', 'HuLanQu');
INSERT INTO `area` VALUES ('230123', '依兰县', '', '230100', '154800', 'ylx', 'YiLanXian');
INSERT INTO `area` VALUES ('230124', '方正县', '', '230100', '150800', 'fzx', 'FangZhengXian');
INSERT INTO `area` VALUES ('230125', '宾县', '', '230100', '150400', 'bx', 'BinXian');
INSERT INTO `area` VALUES ('230126', '巴彦县', '', '230100', '151800', 'byx', 'BaYanXian');
INSERT INTO `area` VALUES ('230127', '木兰县', '', '230100', '151900', 'mlx', 'MuLanXian');
INSERT INTO `area` VALUES ('230128', '通河县', '', '230100', '150900', 'thx', 'TongHeXian');
INSERT INTO `area` VALUES ('230129', '延寿县', '', '230100', '150700', 'ysx', 'YanShouXian');
INSERT INTO `area` VALUES ('230181', '阿城市', '', '230100', '150300', 'acs', 'AChengShi');
INSERT INTO `area` VALUES ('230182', '双城市', '', '230100', '150100', 'scs', 'ShuangChengShi');
INSERT INTO `area` VALUES ('230183', '尚志市', '', '230100', '150600', 'szs', 'ShangZhiShi');
INSERT INTO `area` VALUES ('230184', '五常市', '', '230100', '150200', 'wcs', 'WuChangShi');
INSERT INTO `area` VALUES ('230185', '阿城市', '', '230100', '150300', 'acs', 'AChengShi');
INSERT INTO `area` VALUES ('230186', '其它区', '', '230100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('230200', '齐齐哈尔市', '', '230000', '161000', 'qqhes', 'QiQiHaErShi');
INSERT INTO `area` VALUES ('230202', '龙沙区', '', '230200', '161000', 'lsq', 'LongShaQu');
INSERT INTO `area` VALUES ('230203', '建华区', '', '230200', '161006', 'jhq', 'JianHuaQu');
INSERT INTO `area` VALUES ('230204', '铁锋区', '', '230200', '161000', 'tfq', 'TieFengQu');
INSERT INTO `area` VALUES ('230205', '昂昂溪区', '', '230200', '161031', 'aaxq', 'AngAngXiQu');
INSERT INTO `area` VALUES ('230206', '富拉尔基区', '', '230200', '161041', 'flejq', 'FuLaErJiQu');
INSERT INTO `area` VALUES ('230207', '碾子山区', '', '230200', '161046', 'nzsq', 'NianZiShanQu');
INSERT INTO `area` VALUES ('230208', '梅里斯达斡尔族区', '', '230200', '161021', 'mlsdwezq', 'MeiLiSiDaWoErZuQu');
INSERT INTO `area` VALUES ('230221', '龙江县', '', '230200', '161100', 'ljx', 'LongJiangXian');
INSERT INTO `area` VALUES ('230223', '依安县', '', '230200', '161500', 'yax', 'YiAnXian');
INSERT INTO `area` VALUES ('230224', '泰来县', '', '230200', '162400', 'tlx', 'TaiLaiXian');
INSERT INTO `area` VALUES ('230225', '甘南县', '', '230200', '162100', 'gnx', 'GanNanXian');
INSERT INTO `area` VALUES ('230227', '富裕县', '', '230200', '161200', 'fyx', 'FuYuXian');
INSERT INTO `area` VALUES ('230229', '克山县', '', '230200', '161600', 'ksx', 'KeShanXian');
INSERT INTO `area` VALUES ('230230', '克东县', '', '230200', '164800', 'kdx', 'KeDongXian');
INSERT INTO `area` VALUES ('230231', '拜泉县', '', '230200', '164700', 'bqx', 'BaiQuanXian');
INSERT INTO `area` VALUES ('230281', '讷河市', '', '230200', '161300', 'nhs', 'ZuoHeShi');
INSERT INTO `area` VALUES ('230282', '其它区', '', '230200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('230300', '鸡西市', '', '230000', '158100', 'jxs', 'JiXiShi');
INSERT INTO `area` VALUES ('230302', '鸡冠区', '', '230300', '158100', 'jgq', 'JiGuanQu');
INSERT INTO `area` VALUES ('230303', '恒山区', '', '230300', '158130', 'hsq', 'HengShanQu');
INSERT INTO `area` VALUES ('230304', '滴道区', '', '230300', '158150', 'ddq', 'DiDaoQu');
INSERT INTO `area` VALUES ('230305', '梨树区', '', '230300', '158160', 'lsq', 'LiShuQu');
INSERT INTO `area` VALUES ('230306', '城子河区', '', '230300', '158170', 'czhq', 'ChengZiHeQu');
INSERT INTO `area` VALUES ('230307', '麻山区', '', '230300', '158180', 'msq', 'MaShanQu');
INSERT INTO `area` VALUES ('230321', '鸡东县', '', '230300', '158200', 'jdx', 'JiDongXian');
INSERT INTO `area` VALUES ('230381', '虎林市', '', '230300', '158400', 'hls', 'HuLinShi');
INSERT INTO `area` VALUES ('230382', '密山市', '', '230300', '158300', 'mss', 'MiShanShi');
INSERT INTO `area` VALUES ('230383', '其它区', '', '230300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('230400', '鹤岗市', '', '230000', '154100', 'hgs', 'HeGangShi');
INSERT INTO `area` VALUES ('230402', '向阳区', '', '230400', '154100', 'xyq', 'XiangYangQu');
INSERT INTO `area` VALUES ('230403', '工农区', '', '230400', '154101', 'gnq', 'GongNongQu');
INSERT INTO `area` VALUES ('230404', '南山区', '', '230400', '154104', 'nsq', 'NanShanQu');
INSERT INTO `area` VALUES ('230405', '兴安区', '', '230400', '154102', 'xaq', 'XingAnQu');
INSERT INTO `area` VALUES ('230406', '东山区', '', '230400', '154106', 'dsq', 'DongShanQu');
INSERT INTO `area` VALUES ('230407', '兴山区', '', '230400', '154105', 'xsq', 'XingShanQu');
INSERT INTO `area` VALUES ('230421', '萝北县', '', '230400', '154200', 'lbx', 'LuoBeiXian');
INSERT INTO `area` VALUES ('230422', '绥滨县', '', '230400', '156200', 'sbx', 'SuiBinXian');
INSERT INTO `area` VALUES ('230423', '其它区', '', '230400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('230500', '双鸭山市', '', '230000', '155100', 'syss', 'ShuangYaShanShi');
INSERT INTO `area` VALUES ('230502', '尖山区', '', '230500', '155100', 'jsq', 'JianShanQu');
INSERT INTO `area` VALUES ('230503', '岭东区', '', '230500', '155120', 'ldq', 'LingDongQu');
INSERT INTO `area` VALUES ('230505', '四方台区', '', '230500', '155130', 'sftq', 'SiFangTaiQu');
INSERT INTO `area` VALUES ('230506', '宝山区', '', '230500', '155131', 'bsq', 'BaoShanQu');
INSERT INTO `area` VALUES ('230521', '集贤县', '', '230500', '155900', 'jxx', 'JiXianXian');
INSERT INTO `area` VALUES ('230522', '友谊县', '', '230500', '155800', 'yyx', 'YouYiXian');
INSERT INTO `area` VALUES ('230523', '宝清县', '', '230500', '155600', 'bqx', 'BaoQingXian');
INSERT INTO `area` VALUES ('230524', '饶河县', '', '230500', '155700', 'rhx', 'RaoHeXian');
INSERT INTO `area` VALUES ('230525', '其它区', '', '230500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('230600', '大庆市', '', '230000', '163000', 'dqs', 'DaQingShi');
INSERT INTO `area` VALUES ('230602', '萨尔图区', '', '230600', '163311', 'setq', 'SaErTuQu');
INSERT INTO `area` VALUES ('230603', '龙凤区', '', '230600', '163711', 'lfq', 'LongFengQu');
INSERT INTO `area` VALUES ('230604', '让胡路区', '', '230600', '163453', 'rhlq', 'RangHuLuQu');
INSERT INTO `area` VALUES ('230605', '红岗区', '', '230600', '163512', 'hgq', 'HongGangQu');
INSERT INTO `area` VALUES ('230606', '大同区', '', '230600', '163814', 'dtq', 'DaTongQu');
INSERT INTO `area` VALUES ('230621', '肇州县', '', '230600', '166400', 'zzx', 'ZhaoZhouXian');
INSERT INTO `area` VALUES ('230622', '肇源县', '', '230600', '166500', 'zyx', 'ZhaoYuanXian');
INSERT INTO `area` VALUES ('230623', '林甸县', '', '230600', '166300', 'ldx', 'LinDianXian');
INSERT INTO `area` VALUES ('230624', '杜尔伯特蒙古族自治县', '', '230600', '166200', 'debtmgzzzx', 'DuErBoTeMengGuZuZiZhiXian');
INSERT INTO `area` VALUES ('230625', '其它区', '', '230600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('230700', '伊春市', '', '230000', '153000', 'ycs', 'YiChunShi');
INSERT INTO `area` VALUES ('230702', '伊春区', '', '230700', '153000', 'ycq', 'YiChunQu');
INSERT INTO `area` VALUES ('230703', '南岔区', '', '230700', '153100', 'ncq', 'NanChaQu');
INSERT INTO `area` VALUES ('230704', '友好区', '', '230700', '153031', 'yhq', 'YouHaoQu');
INSERT INTO `area` VALUES ('230705', '西林区', '', '230700', '153025', 'xlq', 'XiLinQu');
INSERT INTO `area` VALUES ('230706', '翠峦区', '', '230700', '153013', 'clq', 'CuiLuanQu');
INSERT INTO `area` VALUES ('230707', '新青区', '', '230700', '153036', 'xqq', 'XinQingQu');
INSERT INTO `area` VALUES ('230708', '美溪区', '', '230700', '153021', 'mxq', 'MeiXiQu');
INSERT INTO `area` VALUES ('230709', '金山屯区', '', '230700', '152026', 'jstq', 'JinShanTunQu');
INSERT INTO `area` VALUES ('230710', '五营区', '', '230700', '153033', 'wyq', 'WuYingQu');
INSERT INTO `area` VALUES ('230711', '乌马河区', '', '230700', '153011', 'wmhq', 'WuMaHeQu');
INSERT INTO `area` VALUES ('230712', '汤旺河区', '', '230700', '153037', 'twhq', 'TangWangHeQu');
INSERT INTO `area` VALUES ('230713', '带岭区', '', '230700', '153106', 'dlq', 'DaiLingQu');
INSERT INTO `area` VALUES ('230714', '乌伊岭区', '', '230700', '153038', 'wylq', 'WuYiLingQu');
INSERT INTO `area` VALUES ('230715', '红星区', '', '230700', '153035', 'hxq', 'HongXingQu');
INSERT INTO `area` VALUES ('230716', '上甘岭区', '', '230700', '153032', 'sglq', 'ShangGanLingQu');
INSERT INTO `area` VALUES ('230722', '嘉荫县', '', '230700', '153200', 'jyx', 'JiaYinXian');
INSERT INTO `area` VALUES ('230781', '铁力市', '', '230700', '152500', 'tls', 'TieLiShi');
INSERT INTO `area` VALUES ('230782', '其它区', '', '230700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('230800', '佳木斯市', '', '230000', '154000', 'jmss', 'JiaMuSiShi');
INSERT INTO `area` VALUES ('230802', '永红区', '', '230800', '154003', 'yhq', 'YongHongQu');
INSERT INTO `area` VALUES ('230803', '向阳区', '', '230800', '154002', 'xyq', 'XiangYangQu');
INSERT INTO `area` VALUES ('230804', '前进区', '', '230800', '154002', 'qjq', 'QianJinQu');
INSERT INTO `area` VALUES ('230805', '东风区', '', '230800', '154005', 'dfq', 'DongFengQu');
INSERT INTO `area` VALUES ('230811', '郊区', '', '230800', '154004', 'jq', 'JiaoQu');
INSERT INTO `area` VALUES ('230822', '桦南县', '', '230800', '154400', 'hnx', 'ZuoNanXian');
INSERT INTO `area` VALUES ('230826', '桦川县', '', '230800', '154300', 'hcx', 'ZuoChuanXian');
INSERT INTO `area` VALUES ('230828', '汤原县', '', '230800', '154700', 'tyx', 'TangYuanXian');
INSERT INTO `area` VALUES ('230833', '抚远县', '', '230800', '156500', 'fyx', 'FuYuanXian');
INSERT INTO `area` VALUES ('230881', '同江市', '', '230800', '156400', 'tjs', 'TongJiangShi');
INSERT INTO `area` VALUES ('230882', '富锦市', '', '230800', '156100', 'fjs', 'FuJinShi');
INSERT INTO `area` VALUES ('230883', '其它区', '', '230800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('230900', '七台河市', '', '230000', '154600', 'qths', 'QiTaiHeShi');
INSERT INTO `area` VALUES ('230902', '新兴区', '', '230900', '154604', 'xxq', 'XinXingQu');
INSERT INTO `area` VALUES ('230903', '桃山区', '', '230900', '154600', 'tsq', 'TaoShanQu');
INSERT INTO `area` VALUES ('230904', '茄子河区', '', '230900', '154622', 'qzhq', 'QieZiHeQu');
INSERT INTO `area` VALUES ('230921', '勃利县', '', '230900', '154500', 'blx', 'BoLiXian');
INSERT INTO `area` VALUES ('230922', '其它区', '', '230900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('231000', '牡丹江市', '', '230000', '157000', 'mdjs', 'MuDanJiangShi');
INSERT INTO `area` VALUES ('231002', '东安区', '', '231000', '157000', 'daq', 'DongAnQu');
INSERT INTO `area` VALUES ('231003', '阳明区', '', '231000', '157013', 'ymq', 'YangMingQu');
INSERT INTO `area` VALUES ('231004', '爱民区', '', '231000', '157009', 'amq', 'AiMinQu');
INSERT INTO `area` VALUES ('231005', '西安区', '', '231000', '157000', 'xaq', 'XiAnQu');
INSERT INTO `area` VALUES ('231024', '东宁县', '', '231000', '157200', 'dnx', 'DongNingXian');
INSERT INTO `area` VALUES ('231025', '林口县', '', '231000', '157600', 'lkx', 'LinKouXian');
INSERT INTO `area` VALUES ('231081', '绥芬河市', '', '231000', '157300', 'sfhs', 'SuiFenHeShi');
INSERT INTO `area` VALUES ('231083', '海林市', '', '231000', '157100', 'hls', 'HaiLinShi');
INSERT INTO `area` VALUES ('231084', '宁安市', '', '231000', '157400', 'nas', 'NingAnShi');
INSERT INTO `area` VALUES ('231085', '穆棱市', '', '231000', '157500', 'mls', 'MuLengShi');
INSERT INTO `area` VALUES ('231086', '其它区', '', '231000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('231100', '黑河市', '', '230000', '164300', 'hhs', 'HeiHeShi');
INSERT INTO `area` VALUES ('231102', '爱辉区', '', '231100', '164300', 'ahq', 'AiHuiQu');
INSERT INTO `area` VALUES ('231121', '嫩江县', '', '231100', '161400', 'njx', 'NenJiangXian');
INSERT INTO `area` VALUES ('231123', '逊克县', '', '231100', '164400', 'xkx', 'XunKeXian');
INSERT INTO `area` VALUES ('231124', '孙吴县', '', '231100', '164200', 'swx', 'SunWuXian');
INSERT INTO `area` VALUES ('231181', '北安市', '', '231100', '164000', 'bas', 'BeiAnShi');
INSERT INTO `area` VALUES ('231182', '五大连池市', '', '231100', '164100', 'wdlcs', 'WuDaLianChiShi');
INSERT INTO `area` VALUES ('231183', '其它区', '', '231100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('231200', '绥化市', '', '230000', '152000', 'shs', 'SuiHuaShi');
INSERT INTO `area` VALUES ('231202', '北林区', '', '231200', '152000', 'blq', 'BeiLinQu');
INSERT INTO `area` VALUES ('231221', '望奎县', '', '231200', '152100', 'wkx', 'WangKuiXian');
INSERT INTO `area` VALUES ('231222', '兰西县', '', '231200', '151500', 'lxx', 'LanXiXian');
INSERT INTO `area` VALUES ('231223', '青冈县', '', '231200', '151600', 'qgx', 'QingGangXian');
INSERT INTO `area` VALUES ('231224', '庆安县', '', '231200', '152400', 'qax', 'QingAnXian');
INSERT INTO `area` VALUES ('231225', '明水县', '', '231200', '151700', 'msx', 'MingShuiXian');
INSERT INTO `area` VALUES ('231226', '绥棱县', '', '231200', '152200', 'slx', 'SuiLengXian');
INSERT INTO `area` VALUES ('231281', '安达市', '', '231200', '151400', 'ads', 'AnDaShi');
INSERT INTO `area` VALUES ('231282', '肇东市', '', '231200', '151100', 'zds', 'ZhaoDongShi');
INSERT INTO `area` VALUES ('231283', '海伦市', '', '231200', '152300', 'hls', 'HaiLunShi');
INSERT INTO `area` VALUES ('231284', '其它区', '', '231200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('232700', '大兴安岭地区', '', '230000', '165000', 'dxaldq', 'DaXingAnLingDiQu');
INSERT INTO `area` VALUES ('232721', '呼玛县', '', '232700', '165100', 'hmx', 'HuMaXian');
INSERT INTO `area` VALUES ('232722', '塔河县', '', '232700', '165200', 'thx', 'TaHeXian');
INSERT INTO `area` VALUES ('232723', '漠河县', '', '232700', '165300', 'mhx', 'MoHeXian');
INSERT INTO `area` VALUES ('232724', '加格达奇区', '', '232700', '165300', 'jgdqq', 'JiaGeDaQiQu');
INSERT INTO `area` VALUES ('232725', '其它区', '', '232700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('310000', '上海', '', '1', '', 'sh', 'ShangHai');
INSERT INTO `area` VALUES ('310100', '上海市', '', '310000', '200000', 'shs', 'ShangHaiShi');
INSERT INTO `area` VALUES ('310101', '黄浦区', '', '310100', '200001', 'hpq', 'HuangPuQu');
INSERT INTO `area` VALUES ('310103', '卢湾区', '', '310100', '200020', 'lwq', 'LuWanQu');
INSERT INTO `area` VALUES ('310104', '徐汇区', '', '310100', '200030', 'xhq', 'XuHuiQu');
INSERT INTO `area` VALUES ('310105', '长宁区', '', '310100', '200050', 'cnq', 'ChangNingQu');
INSERT INTO `area` VALUES ('310106', '静安区', '', '310100', '200040', 'jaq', 'JingAnQu');
INSERT INTO `area` VALUES ('310107', '普陀区', '', '310100', '200062', 'ptq', 'PuTuoQu');
INSERT INTO `area` VALUES ('310108', '闸北区', '', '310100', '200070', 'zbq', 'ZhaBeiQu');
INSERT INTO `area` VALUES ('310109', '虹口区', '', '310100', '200080', 'hkq', 'HongKouQu');
INSERT INTO `area` VALUES ('310110', '杨浦区', '', '310100', '200082', 'ypq', 'YangPuQu');
INSERT INTO `area` VALUES ('310112', '闵行区', '', '310100', '201100', 'mxq', 'ZuoXingQu');
INSERT INTO `area` VALUES ('310113', '宝山区', '', '310100', '201900', 'bsq', 'BaoShanQu');
INSERT INTO `area` VALUES ('310114', '嘉定区', '', '310100', '201800', 'jdq', 'JiaDingQu');
INSERT INTO `area` VALUES ('310115', '浦东新区', '', '310100', '200120', 'pdxq', 'PuDongXinQu');
INSERT INTO `area` VALUES ('310116', '金山区', '', '310100', '201540', 'jsq', 'JinShanQu');
INSERT INTO `area` VALUES ('310117', '松江区', '', '310100', '201600', 'sjq', 'SongJiangQu');
INSERT INTO `area` VALUES ('310118', '青浦区', '', '310100', '201700', 'qpq', 'QingPuQu');
INSERT INTO `area` VALUES ('310119', '南汇区', '', '310100', '201300', 'nhq', 'NanHuiQu');
INSERT INTO `area` VALUES ('310120', '奉贤区', '', '310100', '201400', 'fxq', 'FengXianQu');
INSERT INTO `area` VALUES ('310152', '川沙区', '', '310100', '', 'csq', 'ChuanShaQu');
INSERT INTO `area` VALUES ('310230', '崇明县', '', '310100', '202150', 'cmx', 'ChongMingXian');
INSERT INTO `area` VALUES ('310231', '其它区', '', '310100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('320000', '江苏省', '', '1', '', 'jss', 'JiangSuSheng');
INSERT INTO `area` VALUES ('320100', '南京市', '', '320000', '210000', 'njs', 'NanJingShi');
INSERT INTO `area` VALUES ('320102', '玄武区', '', '320100', '210018', 'xwq', 'XuanWuQu');
INSERT INTO `area` VALUES ('320103', '白下区', '', '320100', '210002', 'bxq', 'BaiXiaQu');
INSERT INTO `area` VALUES ('320104', '秦淮区', '', '320100', '210001', 'qhq', 'QinHuaiQu');
INSERT INTO `area` VALUES ('320105', '建邺区', '', '320100', '210004', 'jyq', 'JianZuoQu');
INSERT INTO `area` VALUES ('320106', '鼓楼区', '', '320100', '210009', 'glq', 'GuLouQu');
INSERT INTO `area` VALUES ('320107', '下关区', '', '320100', '210011', 'xgq', 'XiaGuanQu');
INSERT INTO `area` VALUES ('320111', '浦口区', '', '320100', '211800', 'pkq', 'PuKouQu');
INSERT INTO `area` VALUES ('320113', '栖霞区', '', '320100', '210046', 'qxq', 'QiXiaQu');
INSERT INTO `area` VALUES ('320114', '雨花台区', '', '320100', '210012', 'yhtq', 'YuHuaTaiQu');
INSERT INTO `area` VALUES ('320115', '江宁区', '', '320100', '211100', 'jnq', 'JiangNingQu');
INSERT INTO `area` VALUES ('320116', '六合区', '', '320100', '211500', 'lhq', 'LiuHeQu');
INSERT INTO `area` VALUES ('320124', '溧水县', '', '320100', '211200', 'lsx', 'ZuoShuiXian');
INSERT INTO `area` VALUES ('320125', '高淳县', '', '320100', '211300', 'gcx', 'GaoChunXian');
INSERT INTO `area` VALUES ('320126', '其它区', '', '320100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('320200', '无锡市', '', '320000', '214000', 'wxs', 'WuXiShi');
INSERT INTO `area` VALUES ('320202', '崇安区', '', '320200', '214002', 'caq', 'ChongAnQu');
INSERT INTO `area` VALUES ('320203', '南长区', '', '320200', '214021', 'ncq', 'NanChangQu');
INSERT INTO `area` VALUES ('320204', '北塘区', '', '320200', '214044', 'btq', 'BeiTangQu');
INSERT INTO `area` VALUES ('320205', '锡山区', '', '320200', '214101', 'xsq', 'XiShanQu');
INSERT INTO `area` VALUES ('320206', '惠山区', '', '320200', '214187', 'hsq', 'HuiShanQu');
INSERT INTO `area` VALUES ('320211', '滨湖区', '', '320200', '214062', 'bhq', 'BinHuQu');
INSERT INTO `area` VALUES ('320281', '江阴市', '', '320200', '214400', 'jys', 'JiangYinShi');
INSERT INTO `area` VALUES ('320282', '宜兴市', '', '320200', '214200', 'yxs', 'YiXingShi');
INSERT INTO `area` VALUES ('320296', '新区', '', '320200', '', 'xq', 'XinQu');
INSERT INTO `area` VALUES ('320297', '其它区', '', '320200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('320300', '徐州市', '', '320000', '221000', 'xzs', 'XuZhouShi');
INSERT INTO `area` VALUES ('320302', '鼓楼区', '', '320300', '220005', 'glq', 'GuLouQu');
INSERT INTO `area` VALUES ('320303', '云龙区', '', '320300', '220009', 'ylq', 'YunLongQu');
INSERT INTO `area` VALUES ('320304', '九里区', '', '320300', '220040', 'jlq', 'JiuLiQu');
INSERT INTO `area` VALUES ('320305', '贾汪区', '', '320300', '220011', 'jwq', 'JiaWangQu');
INSERT INTO `area` VALUES ('320311', '泉山区', '', '320300', '220006', 'qsq', 'QuanShanQu');
INSERT INTO `area` VALUES ('320321', '丰县', '', '320300', '221700', 'fx', 'FengXian');
INSERT INTO `area` VALUES ('320322', '沛县', '', '320300', '221600', 'px', 'PeiXian');
INSERT INTO `area` VALUES ('320323', '铜山县', '', '320300', '221112', 'tsx', 'TongShanXian');
INSERT INTO `area` VALUES ('320324', '睢宁县', '', '320300', '221200', 'snx', 'ZuoNingXian');
INSERT INTO `area` VALUES ('320381', '新沂市', '', '320300', '221400', 'xys', 'XinYiShi');
INSERT INTO `area` VALUES ('320382', '邳州市', '', '320300', '221300', 'pzs', 'ZuoZhouShi');
INSERT INTO `area` VALUES ('320383', '其它区', '', '320300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('320400', '常州市', '', '320000', '213000', 'czs', 'ChangZhouShi');
INSERT INTO `area` VALUES ('320402', '天宁区', '', '320400', '213003', 'tnq', 'TianNingQu');
INSERT INTO `area` VALUES ('320404', '钟楼区', '', '320400', '213002', 'zlq', 'ZhongLouQu');
INSERT INTO `area` VALUES ('320405', '戚墅堰区', '', '320400', '213011', 'qsyq', 'QiShuYanQu');
INSERT INTO `area` VALUES ('320411', '新北区', '', '320400', '213001', 'xbq', 'XinBeiQu');
INSERT INTO `area` VALUES ('320412', '武进区', '', '320400', '213161', 'wjq', 'WuJinQu');
INSERT INTO `area` VALUES ('320481', '溧阳市', '', '320400', '213300', 'lys', 'ZuoYangShi');
INSERT INTO `area` VALUES ('320482', '金坛市', '', '320400', '213200', 'jts', 'JinTanShi');
INSERT INTO `area` VALUES ('320483', '其它区', '', '320400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('320500', '苏州市', '', '320000', '215000', 'szs', 'SuZhouShi');
INSERT INTO `area` VALUES ('320502', '沧浪区', '', '320500', '215006', 'clq', 'CangLangQu');
INSERT INTO `area` VALUES ('320503', '平江区', '', '320500', '215005', 'pjq', 'PingJiangQu');
INSERT INTO `area` VALUES ('320504', '金阊区', '', '320500', '215008', 'jcq', 'JinZuoQu');
INSERT INTO `area` VALUES ('320505', '虎丘区', '', '320500', '215004', 'hqq', 'HuQiuQu');
INSERT INTO `area` VALUES ('320506', '吴中区', '', '320500', '215128', 'wzq', 'WuZhongQu');
INSERT INTO `area` VALUES ('320507', '相城区', '', '320500', '215131', 'xcq', 'XiangChengQu');
INSERT INTO `area` VALUES ('320581', '常熟市', '', '320500', '215500', 'css', 'ChangShuShi');
INSERT INTO `area` VALUES ('320582', '张家港市', '', '320500', '215600', 'zjgs', 'ZhangJiaGangShi');
INSERT INTO `area` VALUES ('320583', '昆山市', '', '320500', '215300', 'kss', 'KunShanShi');
INSERT INTO `area` VALUES ('320584', '吴江市', '', '320500', '215200', 'wjs', 'WuJiangShi');
INSERT INTO `area` VALUES ('320585', '太仓市', '', '320500', '215400', 'tcs', 'TaiCangShi');
INSERT INTO `area` VALUES ('320594', '新区', '', '320500', '', 'xq', 'XinQu');
INSERT INTO `area` VALUES ('320595', '园区', '', '320500', '', 'yq', 'YuanQu');
INSERT INTO `area` VALUES ('320596', '其它区', '', '320500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('320600', '南通市', '', '320000', '226000', 'nts', 'NanTongShi');
INSERT INTO `area` VALUES ('320602', '崇川区', '', '320600', '226001', 'ccq', 'ChongChuanQu');
INSERT INTO `area` VALUES ('320611', '港闸区', '', '320600', '226001', 'gzq', 'GangZhaQu');
INSERT INTO `area` VALUES ('320612', '通州区', '', '320600', '226321', '', '');
INSERT INTO `area` VALUES ('320621', '海安县', '', '320600', '226600', 'hax', 'HaiAnXian');
INSERT INTO `area` VALUES ('320623', '如东县', '', '320600', '226400', 'rdx', 'RuDongXian');
INSERT INTO `area` VALUES ('320681', '启东市', '', '320600', '226200', 'qds', 'QiDongShi');
INSERT INTO `area` VALUES ('320682', '如皋市', '', '320600', '226500', 'rgs', 'RuGaoShi');
INSERT INTO `area` VALUES ('320683', '通州市', '', '320600', '226300', 'tzs', 'TongZhouShi');
INSERT INTO `area` VALUES ('320684', '海门市', '', '320600', '226100', 'hms', 'HaiMenShi');
INSERT INTO `area` VALUES ('320693', '开发区', '', '320600', '', 'kfq', 'KaiFaQu');
INSERT INTO `area` VALUES ('320694', '其它区', '', '320600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('320700', '连云港市', '', '320000', '222000', 'lygs', 'LianYunGangShi');
INSERT INTO `area` VALUES ('320703', '连云区', '', '320700', '222042', 'lyq', 'LianYunQu');
INSERT INTO `area` VALUES ('320705', '新浦区', '', '320700', '222003', 'xpq', 'XinPuQu');
INSERT INTO `area` VALUES ('320706', '海州区', '', '320700', '222023', 'hzq', 'HaiZhouQu');
INSERT INTO `area` VALUES ('320721', '赣榆县', '', '320700', '222100', 'gyx', 'GanYuXian');
INSERT INTO `area` VALUES ('320722', '东海县', '', '320700', '222300', 'dhx', 'DongHaiXian');
INSERT INTO `area` VALUES ('320723', '灌云县', '', '320700', '222200', 'gyx', 'GuanYunXian');
INSERT INTO `area` VALUES ('320724', '灌南县', '', '320700', '222500', 'gnx', 'GuanNanXian');
INSERT INTO `area` VALUES ('320725', '其它区', '', '320700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('320800', '淮安市', '', '320000', '223200', 'has', 'HuaiAnShi');
INSERT INTO `area` VALUES ('320802', '清河区', '', '320800', '223001', 'qhq', 'QingHeQu');
INSERT INTO `area` VALUES ('320803', '楚州区', '', '320800', '223200', 'czq', 'ChuZhouQu');
INSERT INTO `area` VALUES ('320804', '淮阴区', '', '320800', '223000', 'hyq', 'HuaiYinQu');
INSERT INTO `area` VALUES ('320811', '清浦区', '', '320800', '223002', 'qpq', 'QingPuQu');
INSERT INTO `area` VALUES ('320826', '涟水县', '', '320800', '223400', 'lsx', 'LianShuiXian');
INSERT INTO `area` VALUES ('320829', '洪泽县', '', '320800', '223100', 'hzx', 'HongZeXian');
INSERT INTO `area` VALUES ('320830', '盱眙县', '', '320800', '211700', 'xyx', 'ZuoZuoXian');
INSERT INTO `area` VALUES ('320831', '金湖县', '', '320800', '211600', 'jhx', 'JinHuXian');
INSERT INTO `area` VALUES ('320832', '其它区', '', '320800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('320900', '盐城市', '', '320000', '224000', 'ycs', 'YanChengShi');
INSERT INTO `area` VALUES ('320902', '亭湖区', '', '320900', '224005', 'thq', 'TingHuQu');
INSERT INTO `area` VALUES ('320903', '盐都区', '', '320900', '224055', 'ydq', 'YanDuQu');
INSERT INTO `area` VALUES ('320921', '响水县', '', '320900', '224600', 'xsx', 'XiangShuiXian');
INSERT INTO `area` VALUES ('320922', '滨海县', '', '320900', '224500', 'bhx', 'BinHaiXian');
INSERT INTO `area` VALUES ('320923', '阜宁县', '', '320900', '224400', 'fnx', 'FuNingXian');
INSERT INTO `area` VALUES ('320924', '射阳县', '', '320900', '224300', 'syx', 'SheYangXian');
INSERT INTO `area` VALUES ('320925', '建湖县', '', '320900', '224700', 'jhx', 'JianHuXian');
INSERT INTO `area` VALUES ('320981', '东台市', '', '320900', '224200', 'dts', 'DongTaiShi');
INSERT INTO `area` VALUES ('320982', '大丰市', '', '320900', '224100', 'dfs', 'DaFengShi');
INSERT INTO `area` VALUES ('320983', '其它区', '', '320900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('321000', '扬州市', '', '320000', '225000', 'yzs', 'YangZhouShi');
INSERT INTO `area` VALUES ('321002', '广陵区', '', '321000', '225002', 'glq', 'GuangLingQu');
INSERT INTO `area` VALUES ('321003', '邗江区', '', '321000', '225100', 'hjq', 'ZuoJiangQu');
INSERT INTO `area` VALUES ('321011', '维扬区', '', '321000', '225002', 'wyq', 'WeiYangQu');
INSERT INTO `area` VALUES ('321023', '宝应县', '', '321000', '225800', 'byx', 'BaoYingXian');
INSERT INTO `area` VALUES ('321081', '仪征市', '', '321000', '211400', 'yzs', 'YiZhengShi');
INSERT INTO `area` VALUES ('321084', '高邮市', '', '321000', '225600', 'gys', 'GaoYouShi');
INSERT INTO `area` VALUES ('321088', '江都市', '', '321000', '225200', 'jds', 'JiangDuShi');
INSERT INTO `area` VALUES ('321092', '经济开发区', '', '321000', '', 'jjkfq', 'JingJiKaiFaQu');
INSERT INTO `area` VALUES ('321093', '其它区', '', '321000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('321100', '镇江市', '', '320000', '212000', 'zjs', 'ZhenJiangShi');
INSERT INTO `area` VALUES ('321102', '京口区', '', '321100', '212001', 'jkq', 'JingKouQu');
INSERT INTO `area` VALUES ('321111', '润州区', '', '321100', '212004', 'rzq', 'RunZhouQu');
INSERT INTO `area` VALUES ('321112', '丹徒区', '', '321100', '212001', 'dtq', 'DanTuQu');
INSERT INTO `area` VALUES ('321181', '丹阳市', '', '321100', '212300', 'dys', 'DanYangShi');
INSERT INTO `area` VALUES ('321182', '扬中市', '', '321100', '212200', 'yzs', 'YangZhongShi');
INSERT INTO `area` VALUES ('321183', '句容市', '', '321100', '212400', 'jrs', 'JuRongShi');
INSERT INTO `area` VALUES ('321184', '其它区', '', '321100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('321200', '泰州市', '', '320000', '225300', 'tzs', 'TaiZhouShi');
INSERT INTO `area` VALUES ('321202', '海陵区', '', '321200', '225300', 'hlq', 'HaiLingQu');
INSERT INTO `area` VALUES ('321203', '高港区', '', '321200', '225321', 'ggq', 'GaoGangQu');
INSERT INTO `area` VALUES ('321281', '兴化市', '', '321200', '225700', 'xhs', 'XingHuaShi');
INSERT INTO `area` VALUES ('321282', '靖江市', '', '321200', '214500', 'jjs', 'JingJiangShi');
INSERT INTO `area` VALUES ('321283', '泰兴市', '', '321200', '225400', 'txs', 'TaiXingShi');
INSERT INTO `area` VALUES ('321284', '姜堰市', '', '321200', '225500', 'jys', 'JiangYanShi');
INSERT INTO `area` VALUES ('321285', '其它区', '', '321200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('321300', '宿迁市', '', '320000', '223800', 'sqs', 'SuQianShi');
INSERT INTO `area` VALUES ('321302', '宿城区', '', '321300', '223800', 'scq', 'SuChengQu');
INSERT INTO `area` VALUES ('321311', '宿豫区', '', '321300', '223800', 'syq', 'SuYuQu');
INSERT INTO `area` VALUES ('321322', '沭阳县', '', '321300', '223600', 'syx', 'ZuoYangXian');
INSERT INTO `area` VALUES ('321323', '泗阳县', '', '321300', '223700', 'syx', 'ZuoYangXian');
INSERT INTO `area` VALUES ('321324', '泗洪县', '', '321300', '223900', 'shx', 'ZuoHongXian');
INSERT INTO `area` VALUES ('321325', '其它区', '', '321300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('330000', '浙江省', '', '1', '', 'zjs', 'ZheJiangSheng');
INSERT INTO `area` VALUES ('330100', '杭州市', '', '330000', '310000', 'hzs', 'HangZhouShi');
INSERT INTO `area` VALUES ('330102', '上城区', '', '330100', '311500', 'scq', 'ShangChengQu');
INSERT INTO `area` VALUES ('330103', '下城区', '', '330100', '310006', 'xcq', 'XiaChengQu');
INSERT INTO `area` VALUES ('330104', '江干区', '', '330100', '310002', 'jgq', 'JiangGanQu');
INSERT INTO `area` VALUES ('330105', '拱墅区', '', '330100', '310011', 'gsq', 'GongShuQu');
INSERT INTO `area` VALUES ('330106', '西湖区', '', '330100', '310013', 'xhq', 'XiHuQu');
INSERT INTO `area` VALUES ('330108', '滨江区', '', '330100', '310051', 'bjq', 'BinJiangQu');
INSERT INTO `area` VALUES ('330109', '萧山区', '', '330100', '311200', 'xsq', 'XiaoShanQu');
INSERT INTO `area` VALUES ('330110', '余杭区', '', '330100', '311100', 'yhq', 'YuHangQu');
INSERT INTO `area` VALUES ('330122', '桐庐县', '', '330100', '311500', 'tlx', 'TongLuXian');
INSERT INTO `area` VALUES ('330127', '淳安县', '', '330100', '311700', 'cax', 'ChunAnXian');
INSERT INTO `area` VALUES ('330182', '建德市', '', '330100', '311600', 'jds', 'JianDeShi');
INSERT INTO `area` VALUES ('330183', '富阳市', '', '330100', '311400', 'fys', 'FuYangShi');
INSERT INTO `area` VALUES ('330185', '临安市', '', '330100', '311300', 'las', 'LinAnShi');
INSERT INTO `area` VALUES ('330186', '其它区', '', '330100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('330200', '宁波市', '', '330000', '315000', 'nbs', 'NingBoShi');
INSERT INTO `area` VALUES ('330203', '海曙区', '', '330200', '315000', 'hsq', 'HaiShuQu');
INSERT INTO `area` VALUES ('330204', '江东区', '', '330200', '315040', 'jdq', 'JiangDongQu');
INSERT INTO `area` VALUES ('330205', '江北区', '', '330200', '315020', 'jbq', 'JiangBeiQu');
INSERT INTO `area` VALUES ('330206', '北仑区', '', '330200', '315800', 'blq', 'BeiLunQu');
INSERT INTO `area` VALUES ('330211', '镇海区', '', '330200', '315200', 'zhq', 'ZhenHaiQu');
INSERT INTO `area` VALUES ('330212', '鄞州区', '', '330200', '315100', 'yzq', 'ZuoZhouQu');
INSERT INTO `area` VALUES ('330225', '象山县', '', '330200', '315700', 'xsx', 'XiangShanXian');
INSERT INTO `area` VALUES ('330226', '宁海县', '', '330200', '315600', 'nhx', 'NingHaiXian');
INSERT INTO `area` VALUES ('330281', '余姚市', '', '330200', '315400', 'yys', 'YuYaoShi');
INSERT INTO `area` VALUES ('330282', '慈溪市', '', '330200', '315300', 'cxs', 'CiXiShi');
INSERT INTO `area` VALUES ('330283', '奉化市', '', '330200', '315500', 'fhs', 'FengHuaShi');
INSERT INTO `area` VALUES ('330284', '其它区', '', '330200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('330300', '温州市', '', '330000', '325000', 'wzs', 'WenZhouShi');
INSERT INTO `area` VALUES ('330302', '鹿城区', '', '330300', '325000', 'lcq', 'LuChengQu');
INSERT INTO `area` VALUES ('330303', '龙湾区', '', '330300', '325024', 'lwq', 'LongWanQu');
INSERT INTO `area` VALUES ('330304', '瓯海区', '', '330300', '325005', 'ohq', 'ZuoHaiQu');
INSERT INTO `area` VALUES ('330322', '洞头县', '', '330300', '325700', 'dtx', 'DongTouXian');
INSERT INTO `area` VALUES ('330324', '永嘉县', '', '330300', '325100', 'yjx', 'YongJiaXian');
INSERT INTO `area` VALUES ('330326', '平阳县', '', '330300', '325400', 'pyx', 'PingYangXian');
INSERT INTO `area` VALUES ('330327', '苍南县', '', '330300', '325800', 'cnx', 'CangNanXian');
INSERT INTO `area` VALUES ('330328', '文成县', '', '330300', '325300', 'wcx', 'WenChengXian');
INSERT INTO `area` VALUES ('330329', '泰顺县', '', '330300', '325500', 'tsx', 'TaiShunXian');
INSERT INTO `area` VALUES ('330381', '瑞安市', '', '330300', '325200', 'ras', 'RuiAnShi');
INSERT INTO `area` VALUES ('330382', '乐清市', '', '330300', '325600', 'lqs', 'LeQingShi');
INSERT INTO `area` VALUES ('330383', '其它区', '', '330300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('330400', '嘉兴市', '', '330000', '314000', 'jxs', 'JiaXingShi');
INSERT INTO `area` VALUES ('330402', '南湖区', '', '330400', '314000', 'nhq', 'NanHuQu');
INSERT INTO `area` VALUES ('330411', '秀洲区', '', '330400', '314001', 'xzq', 'XiuZhouQu');
INSERT INTO `area` VALUES ('330421', '嘉善县', '', '330400', '314100', 'jsx', 'JiaShanXian');
INSERT INTO `area` VALUES ('330424', '海盐县', '', '330400', '314300', 'hyx', 'HaiYanXian');
INSERT INTO `area` VALUES ('330481', '海宁市', '', '330400', '314400', 'hns', 'HaiNingShi');
INSERT INTO `area` VALUES ('330482', '平湖市', '', '330400', '314200', 'phs', 'PingHuShi');
INSERT INTO `area` VALUES ('330483', '桐乡市', '', '330400', '314500', 'txs', 'TongXiangShi');
INSERT INTO `area` VALUES ('330484', '其它区', '', '330400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('330500', '湖州市', '', '330000', '313000', 'hzs', 'HuZhouShi');
INSERT INTO `area` VALUES ('330502', '吴兴区', '', '330500', '313000', 'wxq', 'WuXingQu');
INSERT INTO `area` VALUES ('330503', '南浔区', '', '330500', '313009', 'nxq', 'NanZuoQu');
INSERT INTO `area` VALUES ('330521', '德清县', '', '330500', '313200', 'dqx', 'DeQingXian');
INSERT INTO `area` VALUES ('330522', '长兴县', '', '330500', '313100', 'cxx', 'ChangXingXian');
INSERT INTO `area` VALUES ('330523', '安吉县', '', '330500', '313300', 'ajx', 'AnJiXian');
INSERT INTO `area` VALUES ('330524', '其它区', '', '330500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('330600', '绍兴市', '', '330000', '312000', 'sxs', 'ShaoXingShi');
INSERT INTO `area` VALUES ('330602', '越城区', '', '330600', '312000', 'ycq', 'YueChengQu');
INSERT INTO `area` VALUES ('330621', '绍兴县', '', '330600', '312000', 'sxx', 'ShaoXingXian');
INSERT INTO `area` VALUES ('330624', '新昌县', '', '330600', '312500', 'xcx', 'XinChangXian');
INSERT INTO `area` VALUES ('330681', '诸暨市', '', '330600', '311800', 'zjs', 'ZhuZuoShi');
INSERT INTO `area` VALUES ('330682', '上虞市', '', '330600', '312300', 'sys', 'ShangYuShi');
INSERT INTO `area` VALUES ('330683', '嵊州市', '', '330600', '312400', 'szs', 'ZuoZhouShi');
INSERT INTO `area` VALUES ('330684', '其它区', '', '330600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('330700', '金华市', '', '330000', '321000', 'jhs', 'JinHuaShi');
INSERT INTO `area` VALUES ('330702', '婺城区', '', '330700', '321051', 'wcq', 'ZuoChengQu');
INSERT INTO `area` VALUES ('330703', '金东区', '', '330700', '321002', 'jdq', 'JinDongQu');
INSERT INTO `area` VALUES ('330723', '武义县', '', '330700', '321200', 'wyx', 'WuYiXian');
INSERT INTO `area` VALUES ('330726', '浦江县', '', '330700', '322200', 'pjx', 'PuJiangXian');
INSERT INTO `area` VALUES ('330727', '磐安县', '', '330700', '322300', 'pax', 'PanAnXian');
INSERT INTO `area` VALUES ('330781', '兰溪市', '', '330700', '321100', 'lxs', 'LanXiShi');
INSERT INTO `area` VALUES ('330782', '义乌市', '', '330700', '322000', 'yws', 'YiWuShi');
INSERT INTO `area` VALUES ('330783', '东阳市', '', '330700', '322100', 'dys', 'DongYangShi');
INSERT INTO `area` VALUES ('330784', '永康市', '', '330700', '321300', 'yks', 'YongKangShi');
INSERT INTO `area` VALUES ('330785', '其它区', '', '330700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('330800', '衢州市', '', '330000', '324000', 'qzs', 'ZuoZhouShi');
INSERT INTO `area` VALUES ('330802', '柯城区', '', '330800', '324000', 'kcq', 'KeChengQu');
INSERT INTO `area` VALUES ('330803', '衢江区', '', '330800', '324000', 'qjq', 'ZuoJiangQu');
INSERT INTO `area` VALUES ('330822', '常山县', '', '330800', '324200', 'csx', 'ChangShanXian');
INSERT INTO `area` VALUES ('330824', '开化县', '', '330800', '324300', 'khx', 'KaiHuaXian');
INSERT INTO `area` VALUES ('330825', '龙游县', '', '330800', '324400', 'lyx', 'LongYouXian');
INSERT INTO `area` VALUES ('330881', '江山市', '', '330800', '324100', 'jss', 'JiangShanShi');
INSERT INTO `area` VALUES ('330882', '其它区', '', '330800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('330900', '舟山市', '', '330000', '316000', 'zss', 'ZhouShanShi');
INSERT INTO `area` VALUES ('330902', '定海区', '', '330900', '316000', 'dhq', 'DingHaiQu');
INSERT INTO `area` VALUES ('330903', '普陀区', '', '330900', '316100', 'ptq', 'PuTuoQu');
INSERT INTO `area` VALUES ('330921', '岱山县', '', '330900', '316200', 'dsx', 'ZuoShanXian');
INSERT INTO `area` VALUES ('330922', '嵊泗县', '', '330900', '202400', 'ssx', 'ZuoZuoXian');
INSERT INTO `area` VALUES ('330923', '其它区', '', '330900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('331000', '台州市', '', '330000', '318000', 'tzs', 'TaiZhouShi');
INSERT INTO `area` VALUES ('331002', '椒江区', '', '331000', '318000', 'jjq', 'JiaoJiangQu');
INSERT INTO `area` VALUES ('331003', '黄岩区', '', '331000', '318020', 'hyq', 'HuangYanQu');
INSERT INTO `area` VALUES ('331004', '路桥区', '', '331000', '318050', 'lqq', 'LuQiaoQu');
INSERT INTO `area` VALUES ('331021', '玉环县', '', '331000', '317600', 'yhx', 'YuHuanXian');
INSERT INTO `area` VALUES ('331022', '三门县', '', '331000', '317100', 'smx', 'SanMenXian');
INSERT INTO `area` VALUES ('331023', '天台县', '', '331000', '317200', 'ttx', 'TianTaiXian');
INSERT INTO `area` VALUES ('331024', '仙居县', '', '331000', '317300', 'xjx', 'XianJuXian');
INSERT INTO `area` VALUES ('331081', '温岭市', '', '331000', '317500', 'wls', 'WenLingShi');
INSERT INTO `area` VALUES ('331082', '临海市', '', '331000', '317000', 'lhs', 'LinHaiShi');
INSERT INTO `area` VALUES ('331083', '其它区', '', '331000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('331100', '丽水市', '', '330000', '323000', 'lss', 'LiShuiShi');
INSERT INTO `area` VALUES ('331102', '莲都区', '', '331100', '323000', 'ldq', 'LianDuQu');
INSERT INTO `area` VALUES ('331121', '青田县', '', '331100', '323900', 'qtx', 'QingTianXian');
INSERT INTO `area` VALUES ('331122', '缙云县', '', '331100', '321400', 'jyx', 'ZuoYunXian');
INSERT INTO `area` VALUES ('331123', '遂昌县', '', '331100', '323300', 'scx', 'SuiChangXian');
INSERT INTO `area` VALUES ('331124', '松阳县', '', '331100', '323400', 'syx', 'SongYangXian');
INSERT INTO `area` VALUES ('331125', '云和县', '', '331100', '323600', 'yhx', 'YunHeXian');
INSERT INTO `area` VALUES ('331126', '庆元县', '', '331100', '323800', 'qyx', 'QingYuanXian');
INSERT INTO `area` VALUES ('331127', '景宁畲族自治县', '', '331100', '323500', 'jnszzzx', 'JingNingZuoZuZiZhiXian');
INSERT INTO `area` VALUES ('331181', '龙泉市', '', '331100', '323700', 'lqs', 'LongQuanShi');
INSERT INTO `area` VALUES ('331182', '其它区', '', '331100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('340000', '安徽省', '', '1', '', 'ahs', 'AnHuiSheng');
INSERT INTO `area` VALUES ('340100', '合肥市', '', '340000', '230000', 'hfs', 'HeFeiShi');
INSERT INTO `area` VALUES ('340102', '瑶海区', '', '340100', '230011', 'yhq', 'YaoHaiQu');
INSERT INTO `area` VALUES ('340103', '庐阳区', '', '340100', '230001', 'lyq', 'LuYangQu');
INSERT INTO `area` VALUES ('340104', '蜀山区', '', '340100', '230061', 'ssq', 'ShuShanQu');
INSERT INTO `area` VALUES ('340111', '包河区', '', '340100', '230041', 'bhq', 'BaoHeQu');
INSERT INTO `area` VALUES ('340121', '长丰县', '', '340100', '231100', 'cfx', 'ChangFengXian');
INSERT INTO `area` VALUES ('340122', '肥东县', '', '340100', '231600', 'fdx', 'FeiDongXian');
INSERT INTO `area` VALUES ('340123', '肥西县', '', '340100', '231200', 'fxx', 'FeiXiXian');
INSERT INTO `area` VALUES ('340151', '高新区', '', '340100', '', 'gxq', 'GaoXinQu');
INSERT INTO `area` VALUES ('340191', '中区', '', '340100', '', 'zq', 'ZhongQu');
INSERT INTO `area` VALUES ('340192', '其它区', '', '340100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('340200', '芜湖市', '', '340000', '241000', 'whs', 'WuHuShi');
INSERT INTO `area` VALUES ('340202', '镜湖区', '', '340200', '241000', 'jhq', 'JingHuQu');
INSERT INTO `area` VALUES ('340203', '弋江区', '', '340200', '241000', 'yjq', 'ZuoJiangQu');
INSERT INTO `area` VALUES ('340207', '鸠江区', '', '340200', '241000', 'jjq', 'ZuoJiangQu');
INSERT INTO `area` VALUES ('340208', '三山区', '', '340200', '241000', 'ssq', 'SanShanQu');
INSERT INTO `area` VALUES ('340221', '芜湖县', '', '340200', '241100', 'whx', 'WuHuXian');
INSERT INTO `area` VALUES ('340222', '繁昌县', '', '340200', '241200', 'fcx', 'FanChangXian');
INSERT INTO `area` VALUES ('340223', '南陵县', '', '340200', '242400', 'nlx', 'NanLingXian');
INSERT INTO `area` VALUES ('340224', '其它区', '', '340200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('340300', '蚌埠市', '', '340000', '233000', 'bbs', 'BangBuShi');
INSERT INTO `area` VALUES ('340302', '龙子湖区', '', '340300', '233000', 'lzhq', 'LongZiHuQu');
INSERT INTO `area` VALUES ('340303', '蚌山区', '', '340300', '233000', 'bsq', 'BangShanQu');
INSERT INTO `area` VALUES ('340304', '禹会区', '', '340300', '233010', 'yhq', 'YuHuiQu');
INSERT INTO `area` VALUES ('340311', '淮上区', '', '340300', '233002', 'hsq', 'HuaiShangQu');
INSERT INTO `area` VALUES ('340321', '怀远县', '', '340300', '233400', 'hyx', 'HuaiYuanXian');
INSERT INTO `area` VALUES ('340322', '五河县', '', '340300', '233300', 'whx', 'WuHeXian');
INSERT INTO `area` VALUES ('340323', '固镇县', '', '340300', '233200', 'gzx', 'GuZhenXian');
INSERT INTO `area` VALUES ('340324', '其它区', '', '340300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('340400', '淮南市', '', '340000', '232000', 'hns', 'HuaiNanShi');
INSERT INTO `area` VALUES ('340402', '大通区', '', '340400', '232033', 'dtq', 'DaTongQu');
INSERT INTO `area` VALUES ('340403', '田家庵区', '', '340400', '232000', 'tjaq', 'TianJiaZuoQu');
INSERT INTO `area` VALUES ('340404', '谢家集区', '', '340400', '232052', 'xjjq', 'XieJiaJiQu');
INSERT INTO `area` VALUES ('340405', '八公山区', '', '340400', '232072', 'bgsq', 'BaGongShanQu');
INSERT INTO `area` VALUES ('340406', '潘集区', '', '340400', '232082', 'pjq', 'PanJiQu');
INSERT INTO `area` VALUES ('340421', '凤台县', '', '340400', '232100', 'ftx', 'FengTaiXian');
INSERT INTO `area` VALUES ('340422', '其它区', '', '340400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('340500', '马鞍山市', '', '340000', '243000', 'mass', 'MaAnShanShi');
INSERT INTO `area` VALUES ('340502', '金家庄区', '', '340500', '243021', 'jjzq', 'JinJiaZhuangQu');
INSERT INTO `area` VALUES ('340503', '花山区', '', '340500', '243000', 'hsq', 'HuaShanQu');
INSERT INTO `area` VALUES ('340504', '雨山区', '', '340500', '243071', 'ysq', 'YuShanQu');
INSERT INTO `area` VALUES ('340521', '当涂县', '', '340500', '243100', 'dtx', 'DangTuXian');
INSERT INTO `area` VALUES ('340522', '其它区', '', '340500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('340600', '淮北市', '', '340000', '235000', 'hbs', 'HuaiBeiShi');
INSERT INTO `area` VALUES ('340602', '杜集区', '', '340600', '235047', 'djq', 'DuJiQu');
INSERT INTO `area` VALUES ('340603', '相山区', '', '340600', '235000', 'xsq', 'XiangShanQu');
INSERT INTO `area` VALUES ('340604', '烈山区', '', '340600', '235025', 'lsq', 'LieShanQu');
INSERT INTO `area` VALUES ('340621', '濉溪县', '', '340600', '235100', 'sxx', 'ZuoXiXian');
INSERT INTO `area` VALUES ('340622', '其它区', '', '340600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('340700', '铜陵市', '', '340000', '244000', 'tls', 'TongLingShi');
INSERT INTO `area` VALUES ('340702', '铜官山区', '', '340700', '244000', 'tgsq', 'TongGuanShanQu');
INSERT INTO `area` VALUES ('340703', '狮子山区', '', '340700', '244031', 'szsq', 'ShiZiShanQu');
INSERT INTO `area` VALUES ('340711', '郊区', '', '340700', '244000', 'jq', 'JiaoQu');
INSERT INTO `area` VALUES ('340721', '铜陵县', '', '340700', '244100', 'tlx', 'TongLingXian');
INSERT INTO `area` VALUES ('340722', '其它区', '', '340700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('340800', '安庆市', '', '340000', '246000', 'aqs', 'AnQingShi');
INSERT INTO `area` VALUES ('340802', '迎江区', '', '340800', '246003', 'yjq', 'YingJiangQu');
INSERT INTO `area` VALUES ('340803', '大观区', '', '340800', '246004', 'dgq', 'DaGuanQu');
INSERT INTO `area` VALUES ('340811', '宜秀区', '', '340800', '246003', 'yxq', 'YiXiuQu');
INSERT INTO `area` VALUES ('340822', '怀宁县', '', '340800', '246100', 'hnx', 'HuaiNingXian');
INSERT INTO `area` VALUES ('340823', '枞阳县', '', '340800', '246700', 'cyx', 'ZuoYangXian');
INSERT INTO `area` VALUES ('340824', '潜山县', '', '340800', '246300', 'qsx', 'QianShanXian');
INSERT INTO `area` VALUES ('340825', '太湖县', '', '340800', '246400', 'thx', 'TaiHuXian');
INSERT INTO `area` VALUES ('340826', '宿松县', '', '340800', '246500', 'ssx', 'SuSongXian');
INSERT INTO `area` VALUES ('340827', '望江县', '', '340800', '246200', 'wjx', 'WangJiangXian');
INSERT INTO `area` VALUES ('340828', '岳西县', '', '340800', '246600', 'yxx', 'YueXiXian');
INSERT INTO `area` VALUES ('340881', '桐城市', '', '340800', '231400', 'tcs', 'TongChengShi');
INSERT INTO `area` VALUES ('340882', '其它区', '', '340800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('341000', '黄山市', '', '340000', '245000', 'hss', 'HuangShanShi');
INSERT INTO `area` VALUES ('341002', '屯溪区', '', '341000', '245000', 'txq', 'TunXiQu');
INSERT INTO `area` VALUES ('341003', '黄山区', '', '341000', '242700', 'hsq', 'HuangShanQu');
INSERT INTO `area` VALUES ('341004', '徽州区', '', '341000', '245061', 'hzq', 'HuiZhouQu');
INSERT INTO `area` VALUES ('341021', '歙县', '', '341000', '245200', 'sx', 'ZuoXian');
INSERT INTO `area` VALUES ('341022', '休宁县', '', '341000', '245400', 'xnx', 'XiuNingXian');
INSERT INTO `area` VALUES ('341023', '黟县', '', '341000', '245500', 'yx', 'ZuoXian');
INSERT INTO `area` VALUES ('341024', '祁门县', '', '341000', '245600', 'qmx', 'QiMenXian');
INSERT INTO `area` VALUES ('341025', '其它区', '', '341000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('341100', '滁州市', '', '340000', '239000', 'czs', 'ChuZhouShi');
INSERT INTO `area` VALUES ('341102', '琅琊区', '', '341100', '239000', 'lyq', 'LangZuoQu');
INSERT INTO `area` VALUES ('341103', '南谯区', '', '341100', '239000', 'nqq', 'NanZuoQu');
INSERT INTO `area` VALUES ('341122', '来安县', '', '341100', '239200', 'lax', 'LaiAnXian');
INSERT INTO `area` VALUES ('341124', '全椒县', '', '341100', '239500', 'qjx', 'QuanJiaoXian');
INSERT INTO `area` VALUES ('341125', '定远县', '', '341100', '233200', 'dyx', 'DingYuanXian');
INSERT INTO `area` VALUES ('341126', '凤阳县', '', '341100', '233100', 'fyx', 'FengYangXian');
INSERT INTO `area` VALUES ('341181', '天长市', '', '341100', '239300', 'tcs', 'TianChangShi');
INSERT INTO `area` VALUES ('341182', '明光市', '', '341100', '239400', 'mgs', 'MingGuangShi');
INSERT INTO `area` VALUES ('341183', '其它区', '', '341100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('341200', '阜阳市', '', '340000', '236000', 'fys', 'FuYangShi');
INSERT INTO `area` VALUES ('341202', '颍州区', '', '341200', '236001', 'yzq', 'ZuoZhouQu');
INSERT INTO `area` VALUES ('341203', '颍东区', '', '341200', '236058', 'ydq', 'ZuoDongQu');
INSERT INTO `area` VALUES ('341204', '颍泉区', '', '341200', '236045', 'yqq', 'ZuoQuanQu');
INSERT INTO `area` VALUES ('341221', '临泉县', '', '341200', '236400', 'lqx', 'LinQuanXian');
INSERT INTO `area` VALUES ('341222', '太和县', '', '341200', '236600', 'thx', 'TaiHeXian');
INSERT INTO `area` VALUES ('341225', '阜南县', '', '341200', '236300', 'fnx', 'FuNanXian');
INSERT INTO `area` VALUES ('341226', '颍上县', '', '341200', '236200', 'ysx', 'ZuoShangXian');
INSERT INTO `area` VALUES ('341282', '界首市', '', '341200', '236500', 'jss', 'JieShouShi');
INSERT INTO `area` VALUES ('341283', '其它区', '', '341200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('341300', '宿州市', '', '340000', '234000', 'szs', 'SuZhouShi');
INSERT INTO `area` VALUES ('341302', '埇桥区', '', '341300', '234000', 'yqq', 'QiaoQu');
INSERT INTO `area` VALUES ('341321', '砀山县', '', '341300', '235300', 'dsx', 'ZuoShanXian');
INSERT INTO `area` VALUES ('341322', '萧县', '', '341300', '235200', 'xx', 'XiaoXian');
INSERT INTO `area` VALUES ('341323', '灵璧县', '', '341300', '234200', 'lbx', 'LingZuoXian');
INSERT INTO `area` VALUES ('341324', '泗县', '', '341300', '234300', 'sx', 'ZuoXian');
INSERT INTO `area` VALUES ('341325', '其它区', '', '341300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('341400', '巢湖市', '', '340000', '238000', 'chs', 'ChaoHuShi');
INSERT INTO `area` VALUES ('341402', '居巢区', '', '341400', '238000', 'jcq', 'JuChaoQu');
INSERT INTO `area` VALUES ('341421', '庐江县', '', '341400', '231500', 'ljx', 'LuJiangXian');
INSERT INTO `area` VALUES ('341422', '无为县', '', '341400', '238300', 'wwx', 'WuWeiXian');
INSERT INTO `area` VALUES ('341423', '含山县', '', '341400', '238100', 'hsx', 'HanShanXian');
INSERT INTO `area` VALUES ('341424', '和县', '', '341400', '238200', 'hx', 'HeXian');
INSERT INTO `area` VALUES ('341425', '其它区', '', '341400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('341500', '六安市', '', '340000', '237000', 'las', 'LiuAnShi');
INSERT INTO `area` VALUES ('341502', '金安区', '', '341500', '237005', 'jaq', 'JinAnQu');
INSERT INTO `area` VALUES ('341503', '裕安区', '', '341500', '237010', 'yaq', 'YuAnQu');
INSERT INTO `area` VALUES ('341521', '寿县', '', '341500', '232200', 'sx', 'ShouXian');
INSERT INTO `area` VALUES ('341522', '霍邱县', '', '341500', '237400', 'hqx', 'HuoQiuXian');
INSERT INTO `area` VALUES ('341523', '舒城县', '', '341500', '231300', 'scx', 'ShuChengXian');
INSERT INTO `area` VALUES ('341524', '金寨县', '', '341500', '237300', 'jzx', 'JinZhaiXian');
INSERT INTO `area` VALUES ('341525', '霍山县', '', '341500', '237200', 'hsx', 'HuoShanXian');
INSERT INTO `area` VALUES ('341526', '其它区', '', '341500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('341600', '亳州市', '', '340000', '236800', 'bzs', 'ZuoZhouShi');
INSERT INTO `area` VALUES ('341602', '谯城区', '', '341600', '236800', 'qcq', 'ZuoChengQu');
INSERT INTO `area` VALUES ('341621', '涡阳县', '', '341600', '233600', 'wyx', 'WoYangXian');
INSERT INTO `area` VALUES ('341622', '蒙城县', '', '341600', '233500', 'mcx', 'MengChengXian');
INSERT INTO `area` VALUES ('341623', '利辛县', '', '341600', '236700', 'lxx', 'LiXinXian');
INSERT INTO `area` VALUES ('341624', '其它区', '', '341600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('341700', '池州市', '', '340000', '247000', 'czs', 'ChiZhouShi');
INSERT INTO `area` VALUES ('341702', '贵池区', '', '341700', '247100', 'gcq', 'GuiChiQu');
INSERT INTO `area` VALUES ('341721', '东至县', '', '341700', '247200', 'dzx', 'DongZhiXian');
INSERT INTO `area` VALUES ('341722', '石台县', '', '341700', '245100', 'stx', 'ShiTaiXian');
INSERT INTO `area` VALUES ('341723', '青阳县', '', '341700', '242800', 'qyx', 'QingYangXian');
INSERT INTO `area` VALUES ('341724', '其它区', '', '341700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('341800', '宣城市', '', '340000', '242000', 'xcs', 'XuanChengShi');
INSERT INTO `area` VALUES ('341802', '宣州区', '', '341800', '242000', 'xzq', 'XuanZhouQu');
INSERT INTO `area` VALUES ('341821', '郎溪县', '', '341800', '242100', 'lxx', 'LangXiXian');
INSERT INTO `area` VALUES ('341822', '广德县', '', '341800', '242200', 'gdx', 'GuangDeXian');
INSERT INTO `area` VALUES ('341823', '泾县', '', '341800', '242500', 'jx', 'ZuoXian');
INSERT INTO `area` VALUES ('341824', '绩溪县', '', '341800', '245300', 'jxx', 'JiXiXian');
INSERT INTO `area` VALUES ('341825', '旌德县', '', '341800', '242600', 'jdx', 'ZuoDeXian');
INSERT INTO `area` VALUES ('341881', '宁国市', '', '341800', '242300', 'ngs', 'NingGuoShi');
INSERT INTO `area` VALUES ('341882', '其它区', '', '341800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('350000', '福建省', '', '1', '', 'fjs', 'FuJianSheng');
INSERT INTO `area` VALUES ('350100', '福州市', '', '350000', '350000', 'fzs', 'FuZhouShi');
INSERT INTO `area` VALUES ('350102', '鼓楼区', '', '350100', '350001', 'glq', 'GuLouQu');
INSERT INTO `area` VALUES ('350103', '台江区', '', '350100', '350004', 'tjq', 'TaiJiangQu');
INSERT INTO `area` VALUES ('350104', '仓山区', '', '350100', '350007', 'csq', 'CangShanQu');
INSERT INTO `area` VALUES ('350105', '马尾区', '', '350100', '350015', 'mwq', 'MaWeiQu');
INSERT INTO `area` VALUES ('350111', '晋安区', '', '350100', '350011', 'jaq', 'JinAnQu');
INSERT INTO `area` VALUES ('350121', '闽侯县', '', '350100', '350100', 'mhx', 'MinHouXian');
INSERT INTO `area` VALUES ('350122', '连江县', '', '350100', '350500', 'ljx', 'LianJiangXian');
INSERT INTO `area` VALUES ('350123', '罗源县', '', '350100', '350600', 'lyx', 'LuoYuanXian');
INSERT INTO `area` VALUES ('350124', '闽清县', '', '350100', '350800', 'mqx', 'MinQingXian');
INSERT INTO `area` VALUES ('350125', '永泰县', '', '350100', '350700', 'ytx', 'YongTaiXian');
INSERT INTO `area` VALUES ('350128', '平潭县', '', '350100', '350400', 'ptx', 'PingTanXian');
INSERT INTO `area` VALUES ('350181', '福清市', '', '350100', '350300', 'fqs', 'FuQingShi');
INSERT INTO `area` VALUES ('350182', '长乐市', '', '350100', '350200', 'cls', 'ChangLeShi');
INSERT INTO `area` VALUES ('350183', '其它区', '', '350100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('350200', '厦门市', '', '350000', '361000', 'xms', 'XiaMenShi');
INSERT INTO `area` VALUES ('350203', '思明区', '', '350200', '361001', 'smq', 'SiMingQu');
INSERT INTO `area` VALUES ('350205', '海沧区', '', '350200', '361026', 'hcq', 'HaiCangQu');
INSERT INTO `area` VALUES ('350206', '湖里区', '', '350200', '361006', 'hlq', 'HuLiQu');
INSERT INTO `area` VALUES ('350211', '集美区', '', '350200', '361021', 'jmq', 'JiMeiQu');
INSERT INTO `area` VALUES ('350212', '同安区', '', '350200', '361100', 'taq', 'TongAnQu');
INSERT INTO `area` VALUES ('350213', '翔安区', '', '350200', '361101', 'xaq', 'XiangAnQu');
INSERT INTO `area` VALUES ('350214', '其它区', '', '350200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('350300', '莆田市', '', '350000', '351100', 'pts', 'PuTianShi');
INSERT INTO `area` VALUES ('350302', '城厢区', '', '350300', '351100', 'cxq', 'ChengXiangQu');
INSERT INTO `area` VALUES ('350303', '涵江区', '', '350300', '351111', 'hjq', 'HanJiangQu');
INSERT INTO `area` VALUES ('350304', '荔城区', '', '350300', '351100', 'lcq', 'LiChengQu');
INSERT INTO `area` VALUES ('350305', '秀屿区', '', '350300', '351152', 'xyq', 'XiuYuQu');
INSERT INTO `area` VALUES ('350322', '仙游县', '', '350300', '351200', 'xyx', 'XianYouXian');
INSERT INTO `area` VALUES ('350323', '其它区', '', '350300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('350400', '三明市', '', '350000', '365000', 'sms', 'SanMingShi');
INSERT INTO `area` VALUES ('350402', '梅列区', '', '350400', '365000', 'mlq', 'MeiLieQu');
INSERT INTO `area` VALUES ('350403', '三元区', '', '350400', '365001', 'syq', 'SanYuanQu');
INSERT INTO `area` VALUES ('350421', '明溪县', '', '350400', '365200', 'mxx', 'MingXiXian');
INSERT INTO `area` VALUES ('350423', '清流县', '', '350400', '365300', 'qlx', 'QingLiuXian');
INSERT INTO `area` VALUES ('350424', '宁化县', '', '350400', '365400', 'nhx', 'NingHuaXian');
INSERT INTO `area` VALUES ('350425', '大田县', '', '350400', '366100', 'dtx', 'DaTianXian');
INSERT INTO `area` VALUES ('350426', '尤溪县', '', '350400', '365100', 'yxx', 'YouXiXian');
INSERT INTO `area` VALUES ('350427', '沙县', '', '350400', '365500', 'sx', 'ShaXian');
INSERT INTO `area` VALUES ('350428', '将乐县', '', '350400', '353300', 'jlx', 'JiangLeXian');
INSERT INTO `area` VALUES ('350429', '泰宁县', '', '350400', '354400', 'tnx', 'TaiNingXian');
INSERT INTO `area` VALUES ('350430', '建宁县', '', '350400', '354500', 'jnx', 'JianNingXian');
INSERT INTO `area` VALUES ('350481', '永安市', '', '350400', '366000', 'yas', 'YongAnShi');
INSERT INTO `area` VALUES ('350482', '其它区', '', '350400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('350500', '泉州市', '', '350000', '362000', 'qzs', 'QuanZhouShi');
INSERT INTO `area` VALUES ('350502', '鲤城区', '', '350500', '362000', 'lcq', 'LiChengQu');
INSERT INTO `area` VALUES ('350503', '丰泽区', '', '350500', '362000', 'fzq', 'FengZeQu');
INSERT INTO `area` VALUES ('350504', '洛江区', '', '350500', '362011', 'ljq', 'LuoJiangQu');
INSERT INTO `area` VALUES ('350505', '泉港区', '', '350500', '362801', 'qgq', 'QuanGangQu');
INSERT INTO `area` VALUES ('350521', '惠安县', '', '350500', '362100', 'hax', 'HuiAnXian');
INSERT INTO `area` VALUES ('350524', '安溪县', '', '350500', '362400', 'axx', 'AnXiXian');
INSERT INTO `area` VALUES ('350525', '永春县', '', '350500', '362600', 'ycx', 'YongChunXian');
INSERT INTO `area` VALUES ('350526', '德化县', '', '350500', '362500', 'dhx', 'DeHuaXian');
INSERT INTO `area` VALUES ('350527', '金门县', '', '350500', '362000', 'jmx', 'JinMenXian');
INSERT INTO `area` VALUES ('350581', '石狮市', '', '350500', '362700', 'sss', 'ShiShiShi');
INSERT INTO `area` VALUES ('350582', '晋江市', '', '350500', '362200', 'jjs', 'JinJiangShi');
INSERT INTO `area` VALUES ('350583', '南安市', '', '350500', '362300', 'nas', 'NanAnShi');
INSERT INTO `area` VALUES ('350584', '其它区', '', '350500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('350600', '漳州市', '', '350000', '363000', 'zzs', 'ZhangZhouShi');
INSERT INTO `area` VALUES ('350602', '芗城区', '', '350600', '363000', 'xcq', 'ZuoChengQu');
INSERT INTO `area` VALUES ('350603', '龙文区', '', '350600', '363005', 'lwq', 'LongWenQu');
INSERT INTO `area` VALUES ('350622', '云霄县', '', '350600', '363300', 'yxx', 'YunXiaoXian');
INSERT INTO `area` VALUES ('350623', '漳浦县', '', '350600', '363200', 'zpx', 'ZhangPuXian');
INSERT INTO `area` VALUES ('350624', '诏安县', '', '350600', '363500', 'zax', 'ZuoAnXian');
INSERT INTO `area` VALUES ('350625', '长泰县', '', '350600', '363900', 'ctx', 'ChangTaiXian');
INSERT INTO `area` VALUES ('350626', '东山县', '', '350600', '363400', 'dsx', 'DongShanXian');
INSERT INTO `area` VALUES ('350627', '南靖县', '', '350600', '363600', 'njx', 'NanJingXian');
INSERT INTO `area` VALUES ('350628', '平和县', '', '350600', '363700', 'phx', 'PingHeXian');
INSERT INTO `area` VALUES ('350629', '华安县', '', '350600', '363800', 'hax', 'HuaAnXian');
INSERT INTO `area` VALUES ('350681', '龙海市', '', '350600', '363100', 'lhs', 'LongHaiShi');
INSERT INTO `area` VALUES ('350682', '其它区', '', '350600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('350700', '南平市', '', '350000', '353000', 'nps', 'NanPingShi');
INSERT INTO `area` VALUES ('350702', '延平区', '', '350700', '353000', 'ypq', 'YanPingQu');
INSERT INTO `area` VALUES ('350721', '顺昌县', '', '350700', '353200', 'scx', 'ShunChangXian');
INSERT INTO `area` VALUES ('350722', '浦城县', '', '350700', '353400', 'pcx', 'PuChengXian');
INSERT INTO `area` VALUES ('350723', '光泽县', '', '350700', '354100', 'gzx', 'GuangZeXian');
INSERT INTO `area` VALUES ('350724', '松溪县', '', '350700', '353500', 'sxx', 'SongXiXian');
INSERT INTO `area` VALUES ('350725', '政和县', '', '350700', '353600', 'zhx', 'ZhengHeXian');
INSERT INTO `area` VALUES ('350781', '邵武市', '', '350700', '354000', 'sws', 'ShaoWuShi');
INSERT INTO `area` VALUES ('350782', '武夷山市', '', '350700', '354300', 'wyss', 'WuYiShanShi');
INSERT INTO `area` VALUES ('350783', '建瓯市', '', '350700', '353100', 'jos', 'JianZuoShi');
INSERT INTO `area` VALUES ('350784', '建阳市', '', '350700', '354200', 'jys', 'JianYangShi');
INSERT INTO `area` VALUES ('350785', '其它区', '', '350700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('350800', '龙岩市', '', '350000', '364000', 'lys', 'LongYanShi');
INSERT INTO `area` VALUES ('350802', '新罗区', '', '350800', '364000', 'xlq', 'XinLuoQu');
INSERT INTO `area` VALUES ('350821', '长汀县', '', '350800', '366300', 'ctx', 'ChangTingXian');
INSERT INTO `area` VALUES ('350822', '永定县', '', '350800', '364100', 'ydx', 'YongDingXian');
INSERT INTO `area` VALUES ('350823', '上杭县', '', '350800', '364200', 'shx', 'ShangHangXian');
INSERT INTO `area` VALUES ('350824', '武平县', '', '350800', '364300', 'wpx', 'WuPingXian');
INSERT INTO `area` VALUES ('350825', '连城县', '', '350800', '366200', 'lcx', 'LianChengXian');
INSERT INTO `area` VALUES ('350881', '漳平市', '', '350800', '364400', 'zps', 'ZhangPingShi');
INSERT INTO `area` VALUES ('350882', '其它区', '', '350800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('350900', '宁德市', '', '350000', '352100', 'nds', 'NingDeShi');
INSERT INTO `area` VALUES ('350902', '蕉城区', '', '350900', '352100', 'jcq', 'JiaoChengQu');
INSERT INTO `area` VALUES ('350921', '霞浦县', '', '350900', '355100', 'xpx', 'XiaPuXian');
INSERT INTO `area` VALUES ('350922', '古田县', '', '350900', '352200', 'gtx', 'GuTianXian');
INSERT INTO `area` VALUES ('350923', '屏南县', '', '350900', '352300', 'pnx', 'PingNanXian');
INSERT INTO `area` VALUES ('350924', '寿宁县', '', '350900', '355500', 'snx', 'ShouNingXian');
INSERT INTO `area` VALUES ('350925', '周宁县', '', '350900', '355400', 'znx', 'ZhouNingXian');
INSERT INTO `area` VALUES ('350926', '柘荣县', '', '350900', '355300', 'zrx', 'ZuoRongXian');
INSERT INTO `area` VALUES ('350981', '福安市', '', '350900', '355000', 'fas', 'FuAnShi');
INSERT INTO `area` VALUES ('350982', '福鼎市', '', '350900', '355200', 'fds', 'FuDingShi');
INSERT INTO `area` VALUES ('350983', '其它区', '', '350900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('360000', '江西省', '', '1', '', 'jxs', 'JiangXiSheng');
INSERT INTO `area` VALUES ('360100', '南昌市', '', '360000', '330000', 'ncs', 'NanChangShi');
INSERT INTO `area` VALUES ('360102', '东湖区', '', '360100', '330006', 'dhq', 'DongHuQu');
INSERT INTO `area` VALUES ('360103', '西湖区', '', '360100', '330009', 'xhq', 'XiHuQu');
INSERT INTO `area` VALUES ('360104', '青云谱区', '', '360100', '330001', 'qypq', 'QingYunPuQu');
INSERT INTO `area` VALUES ('360105', '湾里区', '', '360100', '330004', 'wlq', 'WanLiQu');
INSERT INTO `area` VALUES ('360111', '青山湖区', '', '360100', '330006', 'qshq', 'QingShanHuQu');
INSERT INTO `area` VALUES ('360121', '南昌县', '', '360100', '330200', 'ncx', 'NanChangXian');
INSERT INTO `area` VALUES ('360122', '新建县', '', '360100', '330100', 'xjx', 'XinJianXian');
INSERT INTO `area` VALUES ('360123', '安义县', '', '360100', '330500', 'ayx', 'AnYiXian');
INSERT INTO `area` VALUES ('360124', '进贤县', '', '360100', '331700', 'jxx', 'JinXianXian');
INSERT INTO `area` VALUES ('360125', '红谷滩新区', '', '360100', '', 'hgtxq', 'HongGuTanXinQu');
INSERT INTO `area` VALUES ('360126', '经济技术开发区', '', '360100', '', 'jjjskfq', 'JingJiJiShuKaiFaQu');
INSERT INTO `area` VALUES ('360127', '昌北区', '', '360100', '', 'cbq', 'ChangBeiQu');
INSERT INTO `area` VALUES ('360128', '其它区', '', '360100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('360200', '景德镇市', '', '360000', '333000', 'jdzs', 'JingDeZhenShi');
INSERT INTO `area` VALUES ('360202', '昌江区', '', '360200', '333000', 'cjq', 'ChangJiangQu');
INSERT INTO `area` VALUES ('360203', '珠山区', '', '360200', '333000', 'zsq', 'ZhuShanQu');
INSERT INTO `area` VALUES ('360222', '浮梁县', '', '360200', '333400', 'flx', 'FuLiangXian');
INSERT INTO `area` VALUES ('360281', '乐平市', '', '360200', '333300', 'lps', 'LePingShi');
INSERT INTO `area` VALUES ('360282', '其它区', '', '360200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('360300', '萍乡市', '', '360000', '337000', 'pxs', 'PingXiangShi');
INSERT INTO `area` VALUES ('360302', '安源区', '', '360300', '337000', 'ayq', 'AnYuanQu');
INSERT INTO `area` VALUES ('360313', '湘东区', '', '360300', '337032', 'xdq', 'XiangDongQu');
INSERT INTO `area` VALUES ('360321', '莲花县', '', '360300', '337100', 'lhx', 'LianHuaXian');
INSERT INTO `area` VALUES ('360322', '上栗县', '', '360300', '337009', 'slx', 'ShangLiXian');
INSERT INTO `area` VALUES ('360323', '芦溪县', '', '360300', '337200', 'lxx', 'LuXiXian');
INSERT INTO `area` VALUES ('360324', '其它区', '', '360300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('360400', '九江市', '', '360000', '332000', 'jjs', 'JiuJiangShi');
INSERT INTO `area` VALUES ('360402', '庐山区', '', '360400', '332005', 'lsq', 'LuShanQu');
INSERT INTO `area` VALUES ('360403', '浔阳区', '', '360400', '332000', 'xyq', 'ZuoYangQu');
INSERT INTO `area` VALUES ('360421', '九江县', '', '360400', '332100', 'jjx', 'JiuJiangXian');
INSERT INTO `area` VALUES ('360423', '武宁县', '', '360400', '332300', 'wnx', 'WuNingXian');
INSERT INTO `area` VALUES ('360424', '修水县', '', '360400', '332400', 'xsx', 'XiuShuiXian');
INSERT INTO `area` VALUES ('360425', '永修县', '', '360400', '330300', 'yxx', 'YongXiuXian');
INSERT INTO `area` VALUES ('360426', '德安县', '', '360400', '330400', 'dax', 'DeAnXian');
INSERT INTO `area` VALUES ('360427', '星子县', '', '360400', '332800', 'xzx', 'XingZiXian');
INSERT INTO `area` VALUES ('360428', '都昌县', '', '360400', '332600', 'dcx', 'DuChangXian');
INSERT INTO `area` VALUES ('360429', '湖口县', '', '360400', '332500', 'hkx', 'HuKouXian');
INSERT INTO `area` VALUES ('360430', '彭泽县', '', '360400', '332700', 'pzx', 'PengZeXian');
INSERT INTO `area` VALUES ('360481', '瑞昌市', '', '360400', '332200', 'rcs', 'RuiChangShi');
INSERT INTO `area` VALUES ('360482', '其它区', '', '360400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('360500', '新余市', '', '360000', '338000', 'xys', 'XinYuShi');
INSERT INTO `area` VALUES ('360502', '渝水区', '', '360500', '338025', 'ysq', 'YuShuiQu');
INSERT INTO `area` VALUES ('360521', '分宜县', '', '360500', '336600', 'fyx', 'FenYiXian');
INSERT INTO `area` VALUES ('360522', '其它区', '', '360500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('360600', '鹰潭市', '', '360000', '335000', 'yts', 'YingTanShi');
INSERT INTO `area` VALUES ('360602', '月湖区', '', '360600', '335000', 'yhq', 'YueHuQu');
INSERT INTO `area` VALUES ('360622', '余江县', '', '360600', '335200', 'yjx', 'YuJiangXian');
INSERT INTO `area` VALUES ('360681', '贵溪市', '', '360600', '335400', 'gxs', 'GuiXiShi');
INSERT INTO `area` VALUES ('360682', '其它区', '', '360600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('360700', '赣州市', '', '360000', '341000', 'gzs', 'GanZhouShi');
INSERT INTO `area` VALUES ('360702', '章贡区', '', '360700', '', 'zgq', 'ZhangGongQu');
INSERT INTO `area` VALUES ('360721', '赣县', '', '360700', '341100', 'gx', 'GanXian');
INSERT INTO `area` VALUES ('360722', '信丰县', '', '360700', '341600', 'xfx', 'XinFengXian');
INSERT INTO `area` VALUES ('360723', '大余县', '', '360700', '341500', 'dyx', 'DaYuXian');
INSERT INTO `area` VALUES ('360724', '上犹县', '', '360700', '341200', 'syx', 'ShangYouXian');
INSERT INTO `area` VALUES ('360725', '崇义县', '', '360700', '341300', 'cyx', 'ChongYiXian');
INSERT INTO `area` VALUES ('360726', '安远县', '', '360700', '342100', 'ayx', 'AnYuanXian');
INSERT INTO `area` VALUES ('360727', '龙南县', '', '360700', '341700', 'lnx', 'LongNanXian');
INSERT INTO `area` VALUES ('360728', '定南县', '', '360700', '341900', 'dnx', 'DingNanXian');
INSERT INTO `area` VALUES ('360729', '全南县', '', '360700', '341800', 'qnx', 'QuanNanXian');
INSERT INTO `area` VALUES ('360730', '宁都县', '', '360700', '342800', 'ndx', 'NingDuXian');
INSERT INTO `area` VALUES ('360731', '于都县', '', '360700', '342300', 'ydx', 'YuDuXian');
INSERT INTO `area` VALUES ('360732', '兴国县', '', '360700', '342400', 'xgx', 'XingGuoXian');
INSERT INTO `area` VALUES ('360733', '会昌县', '', '360700', '342600', 'hcx', 'HuiChangXian');
INSERT INTO `area` VALUES ('360734', '寻乌县', '', '360700', '342200', 'xwx', 'XunWuXian');
INSERT INTO `area` VALUES ('360735', '石城县', '', '360700', '342700', 'scx', 'ShiChengXian');
INSERT INTO `area` VALUES ('360751', '黄金区', '', '360700', '', 'hjq', 'HuangJinQu');
INSERT INTO `area` VALUES ('360781', '瑞金市', '', '360700', '342500', 'rjs', 'RuiJinShi');
INSERT INTO `area` VALUES ('360782', '南康市', '', '360700', '341400', 'nks', 'NanKangShi');
INSERT INTO `area` VALUES ('360783', '其它区', '', '360700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('360800', '吉安市', '', '360000', '343000', 'jas', 'JiAnShi');
INSERT INTO `area` VALUES ('360802', '吉州区', '', '360800', '343000', 'jzq', 'JiZhouQu');
INSERT INTO `area` VALUES ('360803', '青原区', '', '360800', '343009', 'qyq', 'QingYuanQu');
INSERT INTO `area` VALUES ('360821', '吉安县', '', '360800', '343100', 'jax', 'JiAnXian');
INSERT INTO `area` VALUES ('360822', '吉水县', '', '360800', '331600', 'jsx', 'JiShuiXian');
INSERT INTO `area` VALUES ('360823', '峡江县', '', '360800', '331400', 'xjx', 'XiaJiangXian');
INSERT INTO `area` VALUES ('360824', '新干县', '', '360800', '331300', 'xgx', 'XinGanXian');
INSERT INTO `area` VALUES ('360825', '永丰县', '', '360800', '331500', 'yfx', 'YongFengXian');
INSERT INTO `area` VALUES ('360826', '泰和县', '', '360800', '343700', 'thx', 'TaiHeXian');
INSERT INTO `area` VALUES ('360827', '遂川县', '', '360800', '343900', 'scx', 'SuiChuanXian');
INSERT INTO `area` VALUES ('360828', '万安县', '', '360800', '343800', 'wax', 'WanAnXian');
INSERT INTO `area` VALUES ('360829', '安福县', '', '360800', '343200', 'afx', 'AnFuXian');
INSERT INTO `area` VALUES ('360830', '永新县', '', '360800', '343400', 'yxx', 'YongXinXian');
INSERT INTO `area` VALUES ('360881', '井冈山市', '', '360800', '343600', 'jgss', 'JingGangShanShi');
INSERT INTO `area` VALUES ('360882', '其它区', '', '360800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('360900', '宜春市', '', '360000', '336000', 'ycs', 'YiChunShi');
INSERT INTO `area` VALUES ('360902', '袁州区', '', '360900', '336000', 'yzq', 'YuanZhouQu');
INSERT INTO `area` VALUES ('360921', '奉新县', '', '360900', '330700', 'fxx', 'FengXinXian');
INSERT INTO `area` VALUES ('360922', '万载县', '', '360900', '336100', 'wzx', 'WanZaiXian');
INSERT INTO `area` VALUES ('360923', '上高县', '', '360900', '336400', 'sgx', 'ShangGaoXian');
INSERT INTO `area` VALUES ('360924', '宜丰县', '', '360900', '336300', 'yfx', 'YiFengXian');
INSERT INTO `area` VALUES ('360925', '靖安县', '', '360900', '330600', 'jax', 'JingAnXian');
INSERT INTO `area` VALUES ('360926', '铜鼓县', '', '360900', '336200', 'tgx', 'TongGuXian');
INSERT INTO `area` VALUES ('360981', '丰城市', '', '360900', '331100', 'fcs', 'FengChengShi');
INSERT INTO `area` VALUES ('360982', '樟树市', '', '360900', '331200', 'zss', 'ZhangShuShi');
INSERT INTO `area` VALUES ('360983', '高安市', '', '360900', '330800', 'gas', 'GaoAnShi');
INSERT INTO `area` VALUES ('360984', '其它区', '', '360900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('361000', '抚州市', '', '360000', '344000', 'fzs', 'FuZhouShi');
INSERT INTO `area` VALUES ('361002', '临川区', '', '361000', '344100', 'lcq', 'LinChuanQu');
INSERT INTO `area` VALUES ('361021', '南城县', '', '361000', '344700', 'ncx', 'NanChengXian');
INSERT INTO `area` VALUES ('361022', '黎川县', '', '361000', '344600', 'lcx', 'LiChuanXian');
INSERT INTO `area` VALUES ('361023', '南丰县', '', '361000', '344500', 'nfx', 'NanFengXian');
INSERT INTO `area` VALUES ('361024', '崇仁县', '', '361000', '344200', 'crx', 'ChongRenXian');
INSERT INTO `area` VALUES ('361025', '乐安县', '', '361000', '344300', 'lax', 'LeAnXian');
INSERT INTO `area` VALUES ('361026', '宜黄县', '', '361000', '344400', 'yhx', 'YiHuangXian');
INSERT INTO `area` VALUES ('361027', '金溪县', '', '361000', '344800', 'jxx', 'JinXiXian');
INSERT INTO `area` VALUES ('361028', '资溪县', '', '361000', '335300', 'zxx', 'ZiXiXian');
INSERT INTO `area` VALUES ('361029', '东乡县', '', '361000', '331800', 'dxx', 'DongXiangXian');
INSERT INTO `area` VALUES ('361030', '广昌县', '', '361000', '344900', 'gcx', 'GuangChangXian');
INSERT INTO `area` VALUES ('361031', '其它区', '', '361000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('361100', '上饶市', '', '360000', '334000', 'srs', 'ShangRaoShi');
INSERT INTO `area` VALUES ('361102', '信州区', '', '361100', '334000', 'xzq', 'XinZhouQu');
INSERT INTO `area` VALUES ('361121', '上饶县', '', '361100', '334100', 'srx', 'ShangRaoXian');
INSERT INTO `area` VALUES ('361122', '广丰县', '', '361100', '334600', 'gfx', 'GuangFengXian');
INSERT INTO `area` VALUES ('361123', '玉山县', '', '361100', '334700', 'ysx', 'YuShanXian');
INSERT INTO `area` VALUES ('361124', '铅山县', '', '361100', '334500', 'qsx', 'QianShanXian');
INSERT INTO `area` VALUES ('361125', '横峰县', '', '361100', '334300', 'hfx', 'HengFengXian');
INSERT INTO `area` VALUES ('361126', '弋阳县', '', '361100', '334400', 'yyx', 'ZuoYangXian');
INSERT INTO `area` VALUES ('361127', '余干县', '', '361100', '335100', 'ygx', 'YuGanXian');
INSERT INTO `area` VALUES ('361128', '鄱阳县', '', '361100', '333100', 'pyx', 'ZuoYangXian');
INSERT INTO `area` VALUES ('361129', '万年县', '', '361100', '335500', 'wnx', 'WanNianXian');
INSERT INTO `area` VALUES ('361130', '婺源县', '', '361100', '333200', 'wyx', 'ZuoYuanXian');
INSERT INTO `area` VALUES ('361181', '德兴市', '', '361100', '334200', 'dxs', 'DeXingShi');
INSERT INTO `area` VALUES ('361182', '其它区', '', '361100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('370000', '山东省', '', '1', '', 'sds', 'ShanDongSheng');
INSERT INTO `area` VALUES ('370100', '济南市', '', '370000', '250000', 'jns', 'JiNanShi');
INSERT INTO `area` VALUES ('370102', '历下区', '', '370100', '250013', 'lxq', 'LiXiaQu');
INSERT INTO `area` VALUES ('370103', '市中区', '', '370100', '250002', 'szq', 'ShiZhongQu');
INSERT INTO `area` VALUES ('370104', '槐荫区', '', '370100', '250021', 'hyq', 'HuaiYinQu');
INSERT INTO `area` VALUES ('370105', '天桥区', '', '370100', '250031', 'tqq', 'TianQiaoQu');
INSERT INTO `area` VALUES ('370112', '历城区', '', '370100', '250100', 'lcq', 'LiChengQu');
INSERT INTO `area` VALUES ('370113', '长清区', '', '370100', '250300', 'cqq', 'ChangQingQu');
INSERT INTO `area` VALUES ('370124', '平阴县', '', '370100', '250400', 'pyx', 'PingYinXian');
INSERT INTO `area` VALUES ('370125', '济阳县', '', '370100', '251400', 'jyx', 'JiYangXian');
INSERT INTO `area` VALUES ('370126', '商河县', '', '370100', '251600', 'shx', 'ShangHeXian');
INSERT INTO `area` VALUES ('370181', '章丘市', '', '370100', '250200', 'zqs', 'ZhangQiuShi');
INSERT INTO `area` VALUES ('370182', '其它区', '', '370100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('370200', '青岛市', '', '370000', '266000', 'qds', 'QingDaoShi');
INSERT INTO `area` VALUES ('370202', '市南区', '', '370200', '266001', 'snq', 'ShiNanQu');
INSERT INTO `area` VALUES ('370203', '市北区', '', '370200', '266011', 'sbq', 'ShiBeiQu');
INSERT INTO `area` VALUES ('370205', '四方区', '', '370200', '266031', 'sfq', 'SiFangQu');
INSERT INTO `area` VALUES ('370211', '黄岛区', '', '370200', '266500', 'hdq', 'HuangDaoQu');
INSERT INTO `area` VALUES ('370212', '崂山区', '', '370200', '266100', 'lsq', 'ZuoShanQu');
INSERT INTO `area` VALUES ('370213', '李沧区', '', '370200', '266100', 'lcq', 'LiCangQu');
INSERT INTO `area` VALUES ('370214', '城阳区', '', '370200', '266041', 'cyq', 'ChengYangQu');
INSERT INTO `area` VALUES ('370251', '开发区', '', '370200', '', 'kfq', 'KaiFaQu');
INSERT INTO `area` VALUES ('370281', '胶州市', '', '370200', '266300', 'jzs', 'JiaoZhouShi');
INSERT INTO `area` VALUES ('370282', '即墨市', '', '370200', '266200', 'jms', 'JiMoShi');
INSERT INTO `area` VALUES ('370283', '平度市', '', '370200', '266700', 'pds', 'PingDuShi');
INSERT INTO `area` VALUES ('370284', '胶南市', '', '370200', '266400', 'jns', 'JiaoNanShi');
INSERT INTO `area` VALUES ('370285', '莱西市', '', '370200', '266600', 'lxs', 'LaiXiShi');
INSERT INTO `area` VALUES ('370286', '其它区', '', '370200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('370300', '淄博市', '', '370000', '255000', 'zbs', 'ZiBoShi');
INSERT INTO `area` VALUES ('370302', '淄川区', '', '370300', '255100', 'zcq', 'ZiChuanQu');
INSERT INTO `area` VALUES ('370303', '张店区', '', '370300', '255022', 'zdq', 'ZhangDianQu');
INSERT INTO `area` VALUES ('370304', '博山区', '', '370300', '255200', 'bsq', 'BoShanQu');
INSERT INTO `area` VALUES ('370305', '临淄区', '', '370300', '255400', 'lzq', 'LinZiQu');
INSERT INTO `area` VALUES ('370306', '周村区', '', '370300', '255300', 'zcq', 'ZhouCunQu');
INSERT INTO `area` VALUES ('370321', '桓台县', '', '370300', '256400', 'htx', 'HuanTaiXian');
INSERT INTO `area` VALUES ('370322', '高青县', '', '370300', '256300', 'gqx', 'GaoQingXian');
INSERT INTO `area` VALUES ('370323', '沂源县', '', '370300', '256100', 'yyx', 'YiYuanXian');
INSERT INTO `area` VALUES ('370324', '其它区', '', '370300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('370400', '枣庄市', '', '370000', '277100', 'zzs', 'ZaoZhuangShi');
INSERT INTO `area` VALUES ('370402', '市中区', '', '370400', '277101', 'szq', 'ShiZhongQu');
INSERT INTO `area` VALUES ('370403', '薛城区', '', '370400', '277000', 'xcq', 'XueChengQu');
INSERT INTO `area` VALUES ('370404', '峄城区', '', '370400', '277300', 'ycq', 'ZuoChengQu');
INSERT INTO `area` VALUES ('370405', '台儿庄区', '', '370400', '277400', 'tezq', 'TaiErZhuangQu');
INSERT INTO `area` VALUES ('370406', '山亭区', '', '370400', '277200', 'stq', 'ShanTingQu');
INSERT INTO `area` VALUES ('370481', '滕州市', '', '370400', '277500', 'tzs', 'ZuoZhouShi');
INSERT INTO `area` VALUES ('370482', '其它区', '', '370400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('370500', '东营市', '', '370000', '257000', 'dys', 'DongYingShi');
INSERT INTO `area` VALUES ('370502', '东营区', '', '370500', '257029', 'dyq', 'DongYingQu');
INSERT INTO `area` VALUES ('370503', '河口区', '', '370500', '257200', 'hkq', 'HeKouQu');
INSERT INTO `area` VALUES ('370521', '垦利县', '', '370500', '257500', 'klx', 'KenLiXian');
INSERT INTO `area` VALUES ('370522', '利津县', '', '370500', '257400', 'ljx', 'LiJinXian');
INSERT INTO `area` VALUES ('370523', '广饶县', '', '370500', '257300', 'grx', 'GuangRaoXian');
INSERT INTO `area` VALUES ('370589', '西城区', '', '370500', '', 'xcq', 'XiChengQu');
INSERT INTO `area` VALUES ('370590', '东城区', '', '370500', '', 'dcq', 'DongChengQu');
INSERT INTO `area` VALUES ('370591', '其它区', '', '370500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('370600', '烟台市', '', '370000', '264000', 'yts', 'YanTaiShi');
INSERT INTO `area` VALUES ('370602', '芝罘区', '', '370600', '264001', 'zfq', 'ZhiZuoQu');
INSERT INTO `area` VALUES ('370611', '福山区', '', '370600', '265500', 'fsq', 'FuShanQu');
INSERT INTO `area` VALUES ('370612', '牟平区', '', '370600', '264100', 'mpq', 'MouPingQu');
INSERT INTO `area` VALUES ('370613', '莱山区', '', '370600', '264600', 'lsq', 'LaiShanQu');
INSERT INTO `area` VALUES ('370634', '长岛县', '', '370600', '265800', 'cdx', 'ChangDaoXian');
INSERT INTO `area` VALUES ('370681', '龙口市', '', '370600', '265700', 'lks', 'LongKouShi');
INSERT INTO `area` VALUES ('370682', '莱阳市', '', '370600', '265200', 'lys', 'LaiYangShi');
INSERT INTO `area` VALUES ('370683', '莱州市', '', '370600', '261400', 'lzs', 'LaiZhouShi');
INSERT INTO `area` VALUES ('370684', '蓬莱市', '', '370600', '265600', 'pls', 'PengLaiShi');
INSERT INTO `area` VALUES ('370685', '招远市', '', '370600', '265400', 'zys', 'ZhaoYuanShi');
INSERT INTO `area` VALUES ('370686', '栖霞市', '', '370600', '265300', 'qxs', 'QiXiaShi');
INSERT INTO `area` VALUES ('370687', '海阳市', '', '370600', '265100', 'hys', 'HaiYangShi');
INSERT INTO `area` VALUES ('370688', '其它区', '', '370600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('370700', '潍坊市', '', '370000', '261000', 'wfs', 'WeiFangShi');
INSERT INTO `area` VALUES ('370702', '潍城区', '', '370700', '261021', 'wcq', 'WeiChengQu');
INSERT INTO `area` VALUES ('370703', '寒亭区', '', '370700', '261100', 'htq', 'HanTingQu');
INSERT INTO `area` VALUES ('370704', '坊子区', '', '370700', '261200', 'fzq', 'FangZiQu');
INSERT INTO `area` VALUES ('370705', '奎文区', '', '370700', '261041', 'kwq', 'KuiWenQu');
INSERT INTO `area` VALUES ('370724', '临朐县', '', '370700', '262600', 'lqx', 'LinZuoXian');
INSERT INTO `area` VALUES ('370725', '昌乐县', '', '370700', '262400', 'clx', 'ChangLeXian');
INSERT INTO `area` VALUES ('370751', '开发区', '', '370700', '', 'kfq', 'KaiFaQu');
INSERT INTO `area` VALUES ('370781', '青州市', '', '370700', '262500', 'qzs', 'QingZhouShi');
INSERT INTO `area` VALUES ('370782', '诸城市', '', '370700', '262200', 'zcs', 'ZhuChengShi');
INSERT INTO `area` VALUES ('370783', '寿光市', '', '370700', '262700', 'sgs', 'ShouGuangShi');
INSERT INTO `area` VALUES ('370784', '安丘市', '', '370700', '262100', 'aqs', 'AnQiuShi');
INSERT INTO `area` VALUES ('370785', '高密市', '', '370700', '261500', 'gms', 'GaoMiShi');
INSERT INTO `area` VALUES ('370786', '昌邑市', '', '370700', '261300', 'cys', 'ChangYiShi');
INSERT INTO `area` VALUES ('370787', '其它区', '', '370700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('370800', '济宁市', '', '370000', '272100', 'jns', 'JiNingShi');
INSERT INTO `area` VALUES ('370802', '市中区', '', '370800', '272133', 'szq', 'ShiZhongQu');
INSERT INTO `area` VALUES ('370811', '任城区', '', '370800', '272113', 'rcq', 'RenChengQu');
INSERT INTO `area` VALUES ('370826', '微山县', '', '370800', '277600', 'wsx', 'WeiShanXian');
INSERT INTO `area` VALUES ('370827', '鱼台县', '', '370800', '272300', 'ytx', 'YuTaiXian');
INSERT INTO `area` VALUES ('370828', '金乡县', '', '370800', '272200', 'jxx', 'JinXiangXian');
INSERT INTO `area` VALUES ('370829', '嘉祥县', '', '370800', '272400', 'jxx', 'JiaXiangXian');
INSERT INTO `area` VALUES ('370830', '汶上县', '', '370800', '272501', 'wsx', 'ZuoShangXian');
INSERT INTO `area` VALUES ('370831', '泗水县', '', '370800', '273200', 'ssx', 'ZuoShuiXian');
INSERT INTO `area` VALUES ('370832', '梁山县', '', '370800', '272600', 'lsx', 'LiangShanXian');
INSERT INTO `area` VALUES ('370881', '曲阜市', '', '370800', '273100', 'qfs', 'QuFuShi');
INSERT INTO `area` VALUES ('370882', '兖州市', '', '370800', '272000', 'yzs', 'ZuoZhouShi');
INSERT INTO `area` VALUES ('370883', '邹城市', '', '370800', '273500', 'zcs', 'ZouChengShi');
INSERT INTO `area` VALUES ('370884', '其它区', '', '370800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('370900', '泰安市', '', '370000', '271000', 'tas', 'TaiAnShi');
INSERT INTO `area` VALUES ('370902', '泰山区', '', '370900', '271000', 'tsq', 'TaiShanQu');
INSERT INTO `area` VALUES ('370903', '岱岳区', '', '370900', '271000', 'dyq', 'ZuoYueQu');
INSERT INTO `area` VALUES ('370921', '宁阳县', '', '370900', '271400', 'nyx', 'NingYangXian');
INSERT INTO `area` VALUES ('370923', '东平县', '', '370900', '271500', 'dpx', 'DongPingXian');
INSERT INTO `area` VALUES ('370982', '新泰市', '', '370900', '271200', 'xts', 'XinTaiShi');
INSERT INTO `area` VALUES ('370983', '肥城市', '', '370900', '271600', 'fcs', 'FeiChengShi');
INSERT INTO `area` VALUES ('370984', '其它区', '', '370900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('371000', '威海市', '', '370000', '264200', 'whs', 'WeiHaiShi');
INSERT INTO `area` VALUES ('371002', '环翠区', '', '371000', '264200', 'hcq', 'HuanCuiQu');
INSERT INTO `area` VALUES ('371081', '文登市', '', '371000', '264400', 'wds', 'WenDengShi');
INSERT INTO `area` VALUES ('371082', '荣成市', '', '371000', '264300', 'rcs', 'RongChengShi');
INSERT INTO `area` VALUES ('371083', '乳山市', '', '371000', '264500', 'rss', 'RuShanShi');
INSERT INTO `area` VALUES ('371084', '其它区', '', '371000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('371100', '日照市', '', '370000', '276800', 'rzs', 'RiZhaoShi');
INSERT INTO `area` VALUES ('371102', '东港区', '', '371100', '276800', 'dgq', 'DongGangQu');
INSERT INTO `area` VALUES ('371103', '岚山区', '', '371100', '276808', 'lsq', 'ZuoShanQu');
INSERT INTO `area` VALUES ('371121', '五莲县', '', '371100', '262300', 'wlx', 'WuLianXian');
INSERT INTO `area` VALUES ('371122', '莒县', '', '371100', '276500', 'jx', 'ZuoXian');
INSERT INTO `area` VALUES ('371123', '其它区', '', '371100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('371200', '莱芜市', '', '370000', '271100', 'lws', 'LaiWuShi');
INSERT INTO `area` VALUES ('371202', '莱城区', '', '371200', '271100', 'lcq', 'LaiChengQu');
INSERT INTO `area` VALUES ('371203', '钢城区', '', '371200', '271100', 'gcq', 'GangChengQu');
INSERT INTO `area` VALUES ('371204', '其它区', '', '371200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('371300', '临沂市', '', '370000', '276000', 'lys', 'LinYiShi');
INSERT INTO `area` VALUES ('371302', '兰山区', '', '371300', '276002', 'lsq', 'LanShanQu');
INSERT INTO `area` VALUES ('371311', '罗庄区', '', '371300', '276022', 'lzq', 'LuoZhuangQu');
INSERT INTO `area` VALUES ('371312', '河东区', '', '371300', '276034', 'hdq', 'HeDongQu');
INSERT INTO `area` VALUES ('371321', '沂南县', '', '371300', '276300', 'ynx', 'YiNanXian');
INSERT INTO `area` VALUES ('371322', '郯城县', '', '371300', '276100', 'tcx', 'ZuoChengXian');
INSERT INTO `area` VALUES ('371323', '沂水县', '', '371300', '276400', 'ysx', 'YiShuiXian');
INSERT INTO `area` VALUES ('371324', '苍山县', '', '371300', '277700', 'csx', 'CangShanXian');
INSERT INTO `area` VALUES ('371325', '费县', '', '371300', '273400', 'fx', 'FeiXian');
INSERT INTO `area` VALUES ('371326', '平邑县', '', '371300', '273300', 'pyx', 'PingYiXian');
INSERT INTO `area` VALUES ('371327', '莒南县', '', '371300', '276600', 'jnx', 'ZuoNanXian');
INSERT INTO `area` VALUES ('371328', '蒙阴县', '', '371300', '276200', 'myx', 'MengYinXian');
INSERT INTO `area` VALUES ('371329', '临沭县', '', '371300', '276700', 'lsx', 'LinZuoXian');
INSERT INTO `area` VALUES ('371330', '其它区', '', '371300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('371400', '德州市', '', '370000', '253000', 'dzs', 'DeZhouShi');
INSERT INTO `area` VALUES ('371402', '德城区', '', '371400', '253011', 'dcq', 'DeChengQu');
INSERT INTO `area` VALUES ('371421', '陵县', '', '371400', '253500', 'lx', 'LingXian');
INSERT INTO `area` VALUES ('371422', '宁津县', '', '371400', '253400', 'njx', 'NingJinXian');
INSERT INTO `area` VALUES ('371423', '庆云县', '', '371400', '253700', 'qyx', 'QingYunXian');
INSERT INTO `area` VALUES ('371424', '临邑县', '', '371400', '251500', 'lyx', 'LinYiXian');
INSERT INTO `area` VALUES ('371425', '齐河县', '', '371400', '251100', 'qhx', 'QiHeXian');
INSERT INTO `area` VALUES ('371426', '平原县', '', '371400', '253121', 'pyx', 'PingYuanXian');
INSERT INTO `area` VALUES ('371427', '夏津县', '', '371400', '253200', 'xjx', 'XiaJinXian');
INSERT INTO `area` VALUES ('371428', '武城县', '', '371400', '253300', 'wcx', 'WuChengXian');
INSERT INTO `area` VALUES ('371451', '开发区', '', '371400', '', 'kfq', 'KaiFaQu');
INSERT INTO `area` VALUES ('371481', '乐陵市', '', '371400', '253600', 'lls', 'LeLingShi');
INSERT INTO `area` VALUES ('371482', '禹城市', '', '371400', '251200', 'ycs', 'YuChengShi');
INSERT INTO `area` VALUES ('371483', '其它区', '', '371400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('371500', '聊城市', '', '370000', '252000', 'lcs', 'LiaoChengShi');
INSERT INTO `area` VALUES ('371502', '东昌府区', '', '371500', '252000', 'dcfq', 'DongChangFuQu');
INSERT INTO `area` VALUES ('371521', '阳谷县', '', '371500', '252300', 'ygx', 'YangGuXian');
INSERT INTO `area` VALUES ('371522', '莘县', '', '371500', '252400', 'sx', 'ZuoXian');
INSERT INTO `area` VALUES ('371523', '茌平县', '', '371500', '252100', 'cpx', 'ZuoPingXian');
INSERT INTO `area` VALUES ('371524', '东阿县', '', '371500', '252200', 'dax', 'DongAXian');
INSERT INTO `area` VALUES ('371525', '冠县', '', '371500', '252500', 'gx', 'GuanXian');
INSERT INTO `area` VALUES ('371526', '高唐县', '', '371500', '252800', 'gtx', 'GaoTangXian');
INSERT INTO `area` VALUES ('371581', '临清市', '', '371500', '252600', 'lqs', 'LinQingShi');
INSERT INTO `area` VALUES ('371582', '其它区', '', '371500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('371600', '滨州市', '', '370000', '256600', 'bzs', 'BinZhouShi');
INSERT INTO `area` VALUES ('371602', '滨城区', '', '371600', '256600', 'bcq', 'BinChengQu');
INSERT INTO `area` VALUES ('371621', '惠民县', '', '371600', '257100', 'hmx', 'HuiMinXian');
INSERT INTO `area` VALUES ('371622', '阳信县', '', '371600', '251800', 'yxx', 'YangXinXian');
INSERT INTO `area` VALUES ('371623', '无棣县', '', '371600', '251900', 'wdx', 'WuZuoXian');
INSERT INTO `area` VALUES ('371624', '沾化县', '', '371600', '256800', 'zhx', 'ZhanHuaXian');
INSERT INTO `area` VALUES ('371625', '博兴县', '', '371600', '256500', 'bxx', 'BoXingXian');
INSERT INTO `area` VALUES ('371626', '邹平县', '', '371600', '256200', 'zpx', 'ZouPingXian');
INSERT INTO `area` VALUES ('371627', '其它区', '', '371600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('371700', '菏泽市', '', '370000', '274000', 'hzs', 'HeZeShi');
INSERT INTO `area` VALUES ('371702', '牡丹区', '', '371700', '274009', 'mdq', 'MuDanQu');
INSERT INTO `area` VALUES ('371721', '曹县', '', '371700', '274400', 'cx', 'CaoXian');
INSERT INTO `area` VALUES ('371722', '单县', '', '371700', '274300', 'dx', 'DanXian');
INSERT INTO `area` VALUES ('371723', '成武县', '', '371700', '274200', 'cwx', 'ChengWuXian');
INSERT INTO `area` VALUES ('371724', '巨野县', '', '371700', '274900', 'jyx', 'JuYeXian');
INSERT INTO `area` VALUES ('371725', '郓城县', '', '371700', '274700', 'ycx', 'ZuoChengXian');
INSERT INTO `area` VALUES ('371726', '鄄城县', '', '371700', '274600', 'jcx', 'ZuoChengXian');
INSERT INTO `area` VALUES ('371727', '定陶县', '', '371700', '274100', 'dtx', 'DingTaoXian');
INSERT INTO `area` VALUES ('371728', '东明县', '', '371700', '274500', 'dmx', 'DongMingXian');
INSERT INTO `area` VALUES ('371729', '其它区', '', '371700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('410000', '河南省', '', '1', '', 'hns', 'HeNanSheng');
INSERT INTO `area` VALUES ('410100', '郑州市', '', '410000', '450000', 'zzs', 'ZhengZhouShi');
INSERT INTO `area` VALUES ('410102', '中原区', '', '410100', '450007', 'zyq', 'ZhongYuanQu');
INSERT INTO `area` VALUES ('410103', '二七区', '', '410100', '450000', 'eqq', 'ErQiQu');
INSERT INTO `area` VALUES ('410104', '管城回族区', '', '410100', '450000', 'gchzq', 'GuanChengHuiZuQu');
INSERT INTO `area` VALUES ('410105', '金水区', '', '410100', '450003', 'jsq', 'JinShuiQu');
INSERT INTO `area` VALUES ('410106', '上街区', '', '410100', '450041', 'sjq', 'ShangJieQu');
INSERT INTO `area` VALUES ('410108', '惠济区', '', '410100', '450053', 'hjq', 'HuiJiQu');
INSERT INTO `area` VALUES ('410122', '中牟县', '', '410100', '451450', 'zmx', 'ZhongMouXian');
INSERT INTO `area` VALUES ('410181', '巩义市', '', '410100', '451200', 'gys', 'GongYiShi');
INSERT INTO `area` VALUES ('410182', '荥阳市', '', '410100', '450100', 'xys', 'ZuoYangShi');
INSERT INTO `area` VALUES ('410183', '新密市', '', '410100', '452300', 'xms', 'XinMiShi');
INSERT INTO `area` VALUES ('410184', '新郑市', '', '410100', '451150', 'xzs', 'XinZhengShi');
INSERT INTO `area` VALUES ('410185', '登封市', '', '410100', '452470', 'dfs', 'DengFengShi');
INSERT INTO `area` VALUES ('410186', '郑东新区', '', '410100', '', 'zdxq', 'ZhengDongXinQu');
INSERT INTO `area` VALUES ('410187', '高新区', '', '410100', '', 'gxq', 'GaoXinQu');
INSERT INTO `area` VALUES ('410188', '其它区', '', '410100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('410200', '开封市', '', '410000', '475000', 'kfs', 'KaiFengShi');
INSERT INTO `area` VALUES ('410202', '龙亭区', '', '410200', '475100', 'ltq', 'LongTingQu');
INSERT INTO `area` VALUES ('410203', '顺河回族区', '', '410200', '475000', 'shhzq', 'ShunHeHuiZuQu');
INSERT INTO `area` VALUES ('410204', '鼓楼区', '', '410200', '475000', 'glq', 'GuLouQu');
INSERT INTO `area` VALUES ('410205', '禹王台区', '', '410200', '475003', 'ywtq', 'YuWangTaiQu');
INSERT INTO `area` VALUES ('410211', '金明区', '', '410200', '475002', 'jmq', 'JinMingQu');
INSERT INTO `area` VALUES ('410221', '杞县', '', '410200', '475200', 'qx', 'ZuoXian');
INSERT INTO `area` VALUES ('410222', '通许县', '', '410200', '475400', 'txx', 'TongXuXian');
INSERT INTO `area` VALUES ('410223', '尉氏县', '', '410200', '475500', 'wsx', 'WeiShiXian');
INSERT INTO `area` VALUES ('410224', '开封县', '', '410200', '475100', 'kfx', 'KaiFengXian');
INSERT INTO `area` VALUES ('410225', '兰考县', '', '410200', '475300', 'lkx', 'LanKaoXian');
INSERT INTO `area` VALUES ('410226', '其它区', '', '410200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('410300', '洛阳市', '', '410000', '471000', 'lys', 'LuoYangShi');
INSERT INTO `area` VALUES ('410302', '老城区', '', '410300', '471002', 'lcq', 'LaoChengQu');
INSERT INTO `area` VALUES ('410303', '西工区', '', '410300', '471000', 'xgq', 'XiGongQu');
INSERT INTO `area` VALUES ('410304', '廛河回族区', '', '410300', '471002', 'chhzq', 'ZuoHeHuiZuQu');
INSERT INTO `area` VALUES ('410305', '涧西区', '', '410300', '471003', 'jxq', 'JianXiQu');
INSERT INTO `area` VALUES ('410306', '吉利区', '', '410300', '471012', 'jlq', 'JiLiQu');
INSERT INTO `area` VALUES ('410307', '洛龙区', '', '410300', '471000', 'llq', 'LuoLongQu');
INSERT INTO `area` VALUES ('410322', '孟津县', '', '410300', '471100', 'mjx', 'MengJinXian');
INSERT INTO `area` VALUES ('410323', '新安县', '', '410300', '471800', 'xax', 'XinAnXian');
INSERT INTO `area` VALUES ('410324', '栾川县', '', '410300', '471500', 'lcx', 'ZuoChuanXian');
INSERT INTO `area` VALUES ('410325', '嵩县', '', '410300', '471400', 'sx', 'ZuoXian');
INSERT INTO `area` VALUES ('410326', '汝阳县', '', '410300', '471200', 'ryx', 'RuYangXian');
INSERT INTO `area` VALUES ('410327', '宜阳县', '', '410300', '471600', 'yyx', 'YiYangXian');
INSERT INTO `area` VALUES ('410328', '洛宁县', '', '410300', '471700', 'lnx', 'LuoNingXian');
INSERT INTO `area` VALUES ('410329', '伊川县', '', '410300', '471300', 'ycx', 'YiChuanXian');
INSERT INTO `area` VALUES ('410381', '偃师市', '', '410300', '471900', 'yss', 'ZuoShiShi');
INSERT INTO `area` VALUES ('410400', '平顶山市', '', '410000', '467000', 'pdss', 'PingDingShanShi');
INSERT INTO `area` VALUES ('410402', '新华区', '', '410400', '467002', 'xhq', 'XinHuaQu');
INSERT INTO `area` VALUES ('410403', '卫东区', '', '410400', '467021', 'wdq', 'WeiDongQu');
INSERT INTO `area` VALUES ('410404', '石龙区', '', '410400', '467045', 'slq', 'ShiLongQu');
INSERT INTO `area` VALUES ('410411', '湛河区', '', '410400', '467000', 'zhq', 'ZhanHeQu');
INSERT INTO `area` VALUES ('410421', '宝丰县', '', '410400', '467400', 'bfx', 'BaoFengXian');
INSERT INTO `area` VALUES ('410422', '叶县', '', '410400', '467200', 'yx', 'YeXian');
INSERT INTO `area` VALUES ('410423', '鲁山县', '', '410400', '467300', 'lsx', 'LuShanXian');
INSERT INTO `area` VALUES ('410425', '郏县', '', '410400', '467100', 'jx', 'ZuoXian');
INSERT INTO `area` VALUES ('410481', '舞钢市', '', '410400', '462500', 'wgs', 'WuGangShi');
INSERT INTO `area` VALUES ('410482', '汝州市', '', '410400', '467500', 'rzs', 'RuZhouShi');
INSERT INTO `area` VALUES ('410483', '其它区', '', '410400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('410500', '安阳市', '', '410000', '455000', 'ays', 'AnYangShi');
INSERT INTO `area` VALUES ('410502', '文峰区', '', '410500', '455000', 'wfq', 'WenFengQu');
INSERT INTO `area` VALUES ('410503', '北关区', '', '410500', '455001', 'bgq', 'BeiGuanQu');
INSERT INTO `area` VALUES ('410505', '殷都区', '', '410500', '455004', 'ydq', 'YinDuQu');
INSERT INTO `area` VALUES ('410506', '龙安区', '', '410500', '455001', 'laq', 'LongAnQu');
INSERT INTO `area` VALUES ('410522', '安阳县', '', '410500', '455100', 'ayx', 'AnYangXian');
INSERT INTO `area` VALUES ('410523', '汤阴县', '', '410500', '456150', 'tyx', 'TangYinXian');
INSERT INTO `area` VALUES ('410526', '滑县', '', '410500', '456400', 'hx', 'HuaXian');
INSERT INTO `area` VALUES ('410527', '内黄县', '', '410500', '456300', 'nhx', 'NeiHuangXian');
INSERT INTO `area` VALUES ('410581', '林州市', '', '410500', '456500', 'lzs', 'LinZhouShi');
INSERT INTO `area` VALUES ('410582', '其它区', '', '410500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('410600', '鹤壁市', '', '410000', '458000', 'hbs', 'HeBiShi');
INSERT INTO `area` VALUES ('410602', '鹤山区', '', '410600', '458010', 'hsq', 'HeShanQu');
INSERT INTO `area` VALUES ('410603', '山城区', '', '410600', '458000', 'scq', 'ShanChengQu');
INSERT INTO `area` VALUES ('410611', '淇滨区', '', '410600', '458030', 'qbq', 'ZuoBinQu');
INSERT INTO `area` VALUES ('410621', '浚县', '', '410600', '456250', 'jx', 'JunXian');
INSERT INTO `area` VALUES ('410622', '淇县', '', '410600', '456750', 'qx', 'ZuoXian');
INSERT INTO `area` VALUES ('410623', '其它区', '', '410600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('410700', '新乡市', '', '410000', '453000', 'xxs', 'XinXiangShi');
INSERT INTO `area` VALUES ('410702', '红旗区', '', '410700', '453000', 'hqq', 'HongQiQu');
INSERT INTO `area` VALUES ('410703', '卫滨区', '', '410700', '453000', 'wbq', 'WeiBinQu');
INSERT INTO `area` VALUES ('410704', '凤泉区', '', '410700', '453011', 'fqq', 'FengQuanQu');
INSERT INTO `area` VALUES ('410711', '牧野区', '', '410700', '453002', 'myq', 'MuYeQu');
INSERT INTO `area` VALUES ('410721', '新乡县', '', '410700', '453700', 'xxx', 'XinXiangXian');
INSERT INTO `area` VALUES ('410724', '获嘉县', '', '410700', '453800', 'hjx', 'HuoJiaXian');
INSERT INTO `area` VALUES ('410725', '原阳县', '', '410700', '453500', 'yyx', 'YuanYangXian');
INSERT INTO `area` VALUES ('410726', '延津县', '', '410700', '453200', 'yjx', 'YanJinXian');
INSERT INTO `area` VALUES ('410727', '封丘县', '', '410700', '453300', 'fqx', 'FengQiuXian');
INSERT INTO `area` VALUES ('410728', '长垣县', '', '410700', '453400', 'cyx', 'ChangYuanXian');
INSERT INTO `area` VALUES ('410781', '卫辉市', '', '410700', '453100', 'whs', 'WeiHuiShi');
INSERT INTO `area` VALUES ('410782', '辉县市', '', '410700', '453600', 'hxs', 'HuiXianShi');
INSERT INTO `area` VALUES ('410783', '其它区', '', '410700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('410800', '焦作市', '', '410000', '454000', 'jzs', 'JiaoZuoShi');
INSERT INTO `area` VALUES ('410802', '解放区', '', '410800', '454000', 'jfq', 'JieFangQu');
INSERT INTO `area` VALUES ('410803', '中站区', '', '410800', '454191', 'zzq', 'ZhongZhanQu');
INSERT INTO `area` VALUES ('410804', '马村区', '', '410800', '454171', 'mcq', 'MaCunQu');
INSERT INTO `area` VALUES ('410811', '山阳区', '', '410800', '454002', 'syq', 'ShanYangQu');
INSERT INTO `area` VALUES ('410821', '修武县', '', '410800', '454350', 'xwx', 'XiuWuXian');
INSERT INTO `area` VALUES ('410822', '博爱县', '', '410800', '454450', 'bax', 'BoAiXian');
INSERT INTO `area` VALUES ('410823', '武陟县', '', '410800', '454950', 'wzx', 'WuZuoXian');
INSERT INTO `area` VALUES ('410825', '温县', '', '410800', '454850', 'wx', 'WenXian');
INSERT INTO `area` VALUES ('410881', '济源市', '', '410000', '454650', 'jys', 'JiYuanShi');
INSERT INTO `area` VALUES ('410882', '沁阳市', '', '410800', '454550', 'qys', 'QinYangShi');
INSERT INTO `area` VALUES ('410883', '孟州市', '', '410800', '454750', 'mzs', 'MengZhouShi');
INSERT INTO `area` VALUES ('410884', '其它区', '', '410800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('410900', '濮阳市', '', '410000', '457000', 'pys', 'ZuoYangShi');
INSERT INTO `area` VALUES ('410902', '华龙区', '', '410900', '457001', 'hlq', 'HuaLongQu');
INSERT INTO `area` VALUES ('410922', '清丰县', '', '410900', '457300', 'qfx', 'QingFengXian');
INSERT INTO `area` VALUES ('410923', '南乐县', '', '410900', '457400', 'nlx', 'NanLeXian');
INSERT INTO `area` VALUES ('410926', '范县', '', '410900', '457500', 'fx', 'FanXian');
INSERT INTO `area` VALUES ('410927', '台前县', '', '410900', '457600', 'tqx', 'TaiQianXian');
INSERT INTO `area` VALUES ('410928', '濮阳县', '', '410900', '457100', 'pyx', 'ZuoYangXian');
INSERT INTO `area` VALUES ('410929', '其它区', '', '410900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('411000', '许昌市', '', '410000', '461000', 'xcs', 'XuChangShi');
INSERT INTO `area` VALUES ('411002', '魏都区', '', '411000', '461000', 'wdq', 'WeiDuQu');
INSERT INTO `area` VALUES ('411023', '许昌县', '', '411000', '461100', 'xcx', 'XuChangXian');
INSERT INTO `area` VALUES ('411024', '鄢陵县', '', '411000', '461200', 'ylx', 'ZuoLingXian');
INSERT INTO `area` VALUES ('411025', '襄城县', '', '411000', '461700', 'xcx', 'XiangChengXian');
INSERT INTO `area` VALUES ('411081', '禹州市', '', '411000', '461670', 'yzs', 'YuZhouShi');
INSERT INTO `area` VALUES ('411082', '长葛市', '', '411000', '461500', 'cgs', 'ChangGeShi');
INSERT INTO `area` VALUES ('411083', '其它区', '', '411000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('411100', '漯河市', '', '410000', '462000', 'lhs', 'ZuoHeShi');
INSERT INTO `area` VALUES ('411102', '源汇区', '', '411100', '462000', 'yhq', 'YuanHuiQu');
INSERT INTO `area` VALUES ('411103', '郾城区', '', '411100', '462300', 'ycq', 'ZuoChengQu');
INSERT INTO `area` VALUES ('411104', '召陵区', '', '411100', '462300', 'zlq', 'ZhaoLingQu');
INSERT INTO `area` VALUES ('411121', '舞阳县', '', '411100', '462400', 'wyx', 'WuYangXian');
INSERT INTO `area` VALUES ('411122', '临颍县', '', '411100', '462600', 'lyx', 'LinZuoXian');
INSERT INTO `area` VALUES ('411123', '其它区', '', '411100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('411200', '三门峡市', '', '410000', '472000', 'smxs', 'SanMenXiaShi');
INSERT INTO `area` VALUES ('411202', '湖滨区', '', '411200', '472000', 'hbq', 'HuBinQu');
INSERT INTO `area` VALUES ('411221', '渑池县', '', '411200', '472400', 'mcx', 'ZuoChiXian');
INSERT INTO `area` VALUES ('411222', '陕县', '', '411200', '472100', 'sx', 'ShanXian');
INSERT INTO `area` VALUES ('411224', '卢氏县', '', '411200', '472200', 'lsx', 'LuShiXian');
INSERT INTO `area` VALUES ('411281', '义马市', '', '411200', '472300', 'yms', 'YiMaShi');
INSERT INTO `area` VALUES ('411282', '灵宝市', '', '411200', '472500', 'lbs', 'LingBaoShi');
INSERT INTO `area` VALUES ('411283', '其它区', '', '411200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('411300', '南阳市', '', '410000', '473000', 'nys', 'NanYangShi');
INSERT INTO `area` VALUES ('411302', '宛城区', '', '411300', '473001', 'wcq', 'WanChengQu');
INSERT INTO `area` VALUES ('411303', '卧龙区', '', '411300', '473003', 'wlq', 'WoLongQu');
INSERT INTO `area` VALUES ('411321', '南召县', '', '411300', '474650', 'nzx', 'NanZhaoXian');
INSERT INTO `area` VALUES ('411322', '方城县', '', '411300', '473200', 'fcx', 'FangChengXian');
INSERT INTO `area` VALUES ('411323', '西峡县', '', '411300', '474550', 'xxx', 'XiXiaXian');
INSERT INTO `area` VALUES ('411324', '镇平县', '', '411300', '474250', 'zpx', 'ZhenPingXian');
INSERT INTO `area` VALUES ('411325', '内乡县', '', '411300', '474350', 'nxx', 'NeiXiangXian');
INSERT INTO `area` VALUES ('411326', '淅川县', '', '411300', '474450', 'xcx', 'ZuoChuanXian');
INSERT INTO `area` VALUES ('411327', '社旗县', '', '411300', '473300', 'sqx', 'SheQiXian');
INSERT INTO `area` VALUES ('411328', '唐河县', '', '411300', '473400', 'thx', 'TangHeXian');
INSERT INTO `area` VALUES ('411329', '新野县', '', '411300', '473500', 'xyx', 'XinYeXian');
INSERT INTO `area` VALUES ('411330', '桐柏县', '', '411300', '474750', 'tbx', 'TongBaiXian');
INSERT INTO `area` VALUES ('411381', '邓州市', '', '411300', '474150', 'dzs', 'DengZhouShi');
INSERT INTO `area` VALUES ('411382', '其它区', '', '411300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('411400', '商丘市', '', '410000', '476000', 'sqs', 'ShangQiuShi');
INSERT INTO `area` VALUES ('411402', '梁园区', '', '411400', '476000', 'lyq', 'LiangYuanQu');
INSERT INTO `area` VALUES ('411403', '睢阳区', '', '411400', '476100', 'syq', 'ZuoYangQu');
INSERT INTO `area` VALUES ('411421', '民权县', '', '411400', '476800', 'mqx', 'MinQuanXian');
INSERT INTO `area` VALUES ('411422', '睢县', '', '411400', '476900', 'sx', 'ZuoXian');
INSERT INTO `area` VALUES ('411423', '宁陵县', '', '411400', '476700', 'nlx', 'NingLingXian');
INSERT INTO `area` VALUES ('411424', '柘城县', '', '411400', '476200', 'zcx', 'ZuoChengXian');
INSERT INTO `area` VALUES ('411425', '虞城县', '', '411400', '476300', 'ycx', 'YuChengXian');
INSERT INTO `area` VALUES ('411426', '夏邑县', '', '411400', '476400', 'xyx', 'XiaYiXian');
INSERT INTO `area` VALUES ('411481', '永城市', '', '411400', '476600', 'ycs', 'YongChengShi');
INSERT INTO `area` VALUES ('411482', '其它区', '', '411400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('411500', '信阳市', '', '410000', '464000', 'xys', 'XinYangShi');
INSERT INTO `area` VALUES ('411502', '浉河区', '', '411500', '464000', 'shq', 'HeQu');
INSERT INTO `area` VALUES ('411503', '平桥区', '', '411500', '464100', 'pqq', 'PingQiaoQu');
INSERT INTO `area` VALUES ('411521', '罗山县', '', '411500', '464200', 'lsx', 'LuoShanXian');
INSERT INTO `area` VALUES ('411522', '光山县', '', '411500', '465450', 'gsx', 'GuangShanXian');
INSERT INTO `area` VALUES ('411523', '新县', '', '411500', '465550', 'xx', 'XinXian');
INSERT INTO `area` VALUES ('411524', '商城县', '', '411500', '465350', 'scx', 'ShangChengXian');
INSERT INTO `area` VALUES ('411525', '固始县', '', '411500', '465200', 'gsx', 'GuShiXian');
INSERT INTO `area` VALUES ('411526', '潢川县', '', '411500', '465150', 'hcx', 'ZuoChuanXian');
INSERT INTO `area` VALUES ('411527', '淮滨县', '', '411500', '464400', 'hbx', 'HuaiBinXian');
INSERT INTO `area` VALUES ('411528', '息县', '', '411500', '464300', 'xx', 'XiXian');
INSERT INTO `area` VALUES ('411529', '其它区', '', '411500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('411600', '周口市', '', '410000', '466000', 'zks', 'ZhouKouShi');
INSERT INTO `area` VALUES ('411602', '川汇区', '', '411600', '466000', 'chq', 'ChuanHuiQu');
INSERT INTO `area` VALUES ('411621', '扶沟县', '', '411600', '461300', 'fgx', 'FuGouXian');
INSERT INTO `area` VALUES ('411622', '西华县', '', '411600', '466600', 'xhx', 'XiHuaXian');
INSERT INTO `area` VALUES ('411623', '商水县', '', '411600', '466100', 'ssx', 'ShangShuiXian');
INSERT INTO `area` VALUES ('411624', '沈丘县', '', '411600', '466300', 'sqx', 'ShenQiuXian');
INSERT INTO `area` VALUES ('411625', '郸城县', '', '411600', '477150', 'dcx', 'DanChengXian');
INSERT INTO `area` VALUES ('411626', '淮阳县', '', '411600', '466700', 'hyx', 'HuaiYangXian');
INSERT INTO `area` VALUES ('411627', '太康县', '', '411600', '475400', 'tkx', 'TaiKangXian');
INSERT INTO `area` VALUES ('411628', '鹿邑县', '', '411600', '477200', 'lyx', 'LuYiXian');
INSERT INTO `area` VALUES ('411681', '项城市', '', '411600', '466200', 'xcs', 'XiangChengShi');
INSERT INTO `area` VALUES ('411682', '其它区', '', '411600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('411700', '驻马店市', '', '410000', '463000', 'zmds', 'ZhuMaDianShi');
INSERT INTO `area` VALUES ('411702', '驿城区', '', '411700', '463000', 'ycq', 'ZuoChengQu');
INSERT INTO `area` VALUES ('411721', '西平县', '', '411700', '463900', 'xpx', 'XiPingXian');
INSERT INTO `area` VALUES ('411722', '上蔡县', '', '411700', '463800', 'scx', 'ShangCaiXian');
INSERT INTO `area` VALUES ('411723', '平舆县', '', '411700', '463400', 'pyx', 'PingYuXian');
INSERT INTO `area` VALUES ('411724', '正阳县', '', '411700', '463600', 'zyx', 'ZhengYangXian');
INSERT INTO `area` VALUES ('411725', '确山县', '', '411700', '463200', 'qsx', 'QueShanXian');
INSERT INTO `area` VALUES ('411726', '泌阳县', '', '411700', '463700', 'myx', 'MiYangXian');
INSERT INTO `area` VALUES ('411727', '汝南县', '', '411700', '463300', 'rnx', 'RuNanXian');
INSERT INTO `area` VALUES ('411728', '遂平县', '', '411700', '463100', 'spx', 'SuiPingXian');
INSERT INTO `area` VALUES ('411729', '新蔡县', '', '411700', '463500', 'xcx', 'XinCaiXian');
INSERT INTO `area` VALUES ('411730', '其它区', '', '411700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('420000', '湖北省', '', '1', '', 'hbs', 'HuBeiSheng');
INSERT INTO `area` VALUES ('420100', '武汉市', '', '420000', '430000', 'whs', 'WuHanShi');
INSERT INTO `area` VALUES ('420102', '江岸区', '', '420100', '430014', 'jaq', 'JiangAnQu');
INSERT INTO `area` VALUES ('420103', '江汉区', '', '420100', '430015', 'jhq', 'JiangHanQu');
INSERT INTO `area` VALUES ('420104', '硚口区', '', '420100', '430033', 'ckq', 'ChangKouQu');
INSERT INTO `area` VALUES ('420105', '汉阳区', '', '420100', '430050', 'hyq', 'HanYangQu');
INSERT INTO `area` VALUES ('420106', '武昌区', '', '420100', '430061', 'wcq', 'WuChangQu');
INSERT INTO `area` VALUES ('420107', '青山区', '', '420100', '430080', 'qsq', 'QingShanQu');
INSERT INTO `area` VALUES ('420111', '洪山区', '', '420100', '430070', 'hsq', 'HongShanQu');
INSERT INTO `area` VALUES ('420112', '东西湖区', '', '420100', '430040', 'dxhq', 'DongXiHuQu');
INSERT INTO `area` VALUES ('420113', '汉南区', '', '420100', '430090', 'hnq', 'HanNanQu');
INSERT INTO `area` VALUES ('420114', '蔡甸区', '', '420100', '430100', 'cdq', 'CaiDianQu');
INSERT INTO `area` VALUES ('420115', '江夏区', '', '420100', '430200', 'jxq', 'JiangXiaQu');
INSERT INTO `area` VALUES ('420116', '黄陂区', '', '420100', '430300', 'hbq', 'HuangZuoQu');
INSERT INTO `area` VALUES ('420117', '新洲区', '', '420100', '431400', 'xzq', 'XinZhouQu');
INSERT INTO `area` VALUES ('420118', '其它区', '', '420100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('420200', '黄石市', '', '420000', '435000', 'hss', 'HuangShiShi');
INSERT INTO `area` VALUES ('420202', '黄石港区', '', '420200', '435002', 'hsgq', 'HuangShiGangQu');
INSERT INTO `area` VALUES ('420203', '西塞山区', '', '420200', '435001', 'xssq', 'XiSaiShanQu');
INSERT INTO `area` VALUES ('420204', '下陆区', '', '420200', '435004', 'xlq', 'XiaLuQu');
INSERT INTO `area` VALUES ('420205', '铁山区', '', '420200', '435006', 'tsq', 'TieShanQu');
INSERT INTO `area` VALUES ('420222', '阳新县', '', '420200', '435200', 'yxx', 'YangXinXian');
INSERT INTO `area` VALUES ('420281', '大冶市', '', '420200', '435100', 'dys', 'DaYeShi');
INSERT INTO `area` VALUES ('420282', '其它区', '', '420200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('420300', '十堰市', '', '420000', '442000', 'sys', 'ShiYanShi');
INSERT INTO `area` VALUES ('420302', '茅箭区', '', '420300', '442012', 'mjq', 'MaoJianQu');
INSERT INTO `area` VALUES ('420303', '张湾区', '', '420300', '442001', 'zwq', 'ZhangWanQu');
INSERT INTO `area` VALUES ('420321', '郧县', '', '420300', '442500', 'yx', 'YunXian');
INSERT INTO `area` VALUES ('420322', '郧西县', '', '420300', '442600', 'yxx', 'YunXiXian');
INSERT INTO `area` VALUES ('420323', '竹山县', '', '420300', '442200', 'zsx', 'ZhuShanXian');
INSERT INTO `area` VALUES ('420324', '竹溪县', '', '420300', '442300', 'zxx', 'ZhuXiXian');
INSERT INTO `area` VALUES ('420325', '房县', '', '420300', '442100', 'fx', 'FangXian');
INSERT INTO `area` VALUES ('420381', '丹江口市', '', '420300', '441900', 'djks', 'DanJiangKouShi');
INSERT INTO `area` VALUES ('420382', '城区', '', '420300', '', 'cq', 'ChengQu');
INSERT INTO `area` VALUES ('420383', '其它区', '', '420300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('420500', '宜昌市', '', '420000', '443000', 'ycs', 'YiChangShi');
INSERT INTO `area` VALUES ('420502', '西陵区', '', '420500', '443000', 'xlq', 'XiLingQu');
INSERT INTO `area` VALUES ('420503', '伍家岗区', '', '420500', '443001', 'wjgq', 'WuJiaGangQu');
INSERT INTO `area` VALUES ('420504', '点军区', '', '420500', '443006', 'djq', 'DianJunQu');
INSERT INTO `area` VALUES ('420505', '猇亭区', '', '420500', '443007', 'xtq', 'TingQu');
INSERT INTO `area` VALUES ('420506', '夷陵区', '', '420500', '443100', 'ylq', 'YiLingQu');
INSERT INTO `area` VALUES ('420525', '远安县', '', '420500', '444200', 'yax', 'YuanAnXian');
INSERT INTO `area` VALUES ('420526', '兴山县', '', '420500', '443700', 'xsx', 'XingShanXian');
INSERT INTO `area` VALUES ('420527', '秭归县', '', '420500', '443600', 'zgx', 'ZuoGuiXian');
INSERT INTO `area` VALUES ('420528', '长阳土家族自治县', '', '420500', '443500', 'cytjzzzx', 'ChangYangTuJiaZuZiZhiXian');
INSERT INTO `area` VALUES ('420529', '五峰土家族自治县', '', '420500', '443400', 'wftjzzzx', 'WuFengTuJiaZuZiZhiXian');
INSERT INTO `area` VALUES ('420551', '葛洲坝区', '', '420500', '', 'gzbq', 'GeZhouBaQu');
INSERT INTO `area` VALUES ('420552', '开发区', '', '420500', '', 'kfq', 'KaiFaQu');
INSERT INTO `area` VALUES ('420581', '宜都市', '', '420500', '443300', 'yds', 'YiDuShi');
INSERT INTO `area` VALUES ('420582', '当阳市', '', '420500', '444100', 'dys', 'DangYangShi');
INSERT INTO `area` VALUES ('420583', '枝江市', '', '420500', '443200', 'zjs', 'ZhiJiangShi');
INSERT INTO `area` VALUES ('420584', '其它区', '', '420500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('420600', '襄阳市', '', '420000', '441000', 'sys', 'xiangyangshi');
INSERT INTO `area` VALUES ('420602', '襄城区', '', '420600', '441021', 'xcq', 'XiangChengQu');
INSERT INTO `area` VALUES ('420606', '樊城区', '', '420600', '441001', 'fcq', 'FanChengQu');
INSERT INTO `area` VALUES ('420607', '襄州区', '', '420600', '441100', 'xyq', 'XiangYangQu');
INSERT INTO `area` VALUES ('420624', '南漳县', '', '420600', '441500', 'nzx', 'NanZhangXian');
INSERT INTO `area` VALUES ('420625', '谷城县', '', '420600', '441700', 'gcx', 'GuChengXian');
INSERT INTO `area` VALUES ('420626', '保康县', '', '420600', '441600', 'bkx', 'BaoKangXian');
INSERT INTO `area` VALUES ('420682', '老河口市', '', '420600', '441800', 'lhks', 'LaoHeKouShi');
INSERT INTO `area` VALUES ('420683', '枣阳市', '', '420600', '441200', 'zys', 'ZaoYangShi');
INSERT INTO `area` VALUES ('420684', '宜城市', '', '420600', '441400', 'ycs', 'YiChengShi');
INSERT INTO `area` VALUES ('420685', '其它区', '', '420600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('420700', '鄂州市', '', '420000', '436000', 'ezs', 'EZhouShi');
INSERT INTO `area` VALUES ('420702', '梁子湖区', '', '420700', '436064', 'lzhq', 'LiangZiHuQu');
INSERT INTO `area` VALUES ('420703', '华容区', '', '420700', '436030', 'hrq', 'HuaRongQu');
INSERT INTO `area` VALUES ('420704', '鄂城区', '', '420700', '436000', 'ecq', 'EChengQu');
INSERT INTO `area` VALUES ('420705', '其它区', '', '420700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('420800', '荆门市', '', '420000', '448000', 'jms', 'JingMenShi');
INSERT INTO `area` VALUES ('420802', '东宝区', '', '420800', '448004', 'dbq', 'DongBaoQu');
INSERT INTO `area` VALUES ('420804', '掇刀区', '', '420800', '448124', 'ddq', 'DuoDaoQu');
INSERT INTO `area` VALUES ('420821', '京山县', '', '420800', '431800', 'jsx', 'JingShanXian');
INSERT INTO `area` VALUES ('420822', '沙洋县', '', '420800', '448200', 'syx', 'ShaYangXian');
INSERT INTO `area` VALUES ('420881', '钟祥市', '', '420800', '431900', 'zxs', 'ZhongXiangShi');
INSERT INTO `area` VALUES ('420882', '其它区', '', '420800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('420900', '孝感市', '', '420000', '432000', 'xgs', 'XiaoGanShi');
INSERT INTO `area` VALUES ('420902', '孝南区', '', '420900', '432100', 'xnq', 'XiaoNanQu');
INSERT INTO `area` VALUES ('420921', '孝昌县', '', '420900', '432900', 'xcx', 'XiaoChangXian');
INSERT INTO `area` VALUES ('420922', '大悟县', '', '420900', '432800', 'dwx', 'DaWuXian');
INSERT INTO `area` VALUES ('420923', '云梦县', '', '420900', '432500', 'ymx', 'YunMengXian');
INSERT INTO `area` VALUES ('420981', '应城市', '', '420900', '432400', 'ycs', 'YingChengShi');
INSERT INTO `area` VALUES ('420982', '安陆市', '', '420900', '432600', 'als', 'AnLuShi');
INSERT INTO `area` VALUES ('420984', '汉川市', '', '420900', '431600', 'hcs', 'HanChuanShi');
INSERT INTO `area` VALUES ('420985', '其它区', '', '420900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('421000', '荆州市', '', '420000', '434000', 'jzs', 'JingZhouShi');
INSERT INTO `area` VALUES ('421002', '沙市区', '', '421000', '434000', 'ssq', 'ShaShiQu');
INSERT INTO `area` VALUES ('421003', '荆州区', '', '421000', '434020', 'jzq', 'JingZhouQu');
INSERT INTO `area` VALUES ('421022', '公安县', '', '421000', '434300', 'gax', 'GongAnXian');
INSERT INTO `area` VALUES ('421023', '监利县', '', '421000', '433300', 'jlx', 'JianLiXian');
INSERT INTO `area` VALUES ('421024', '江陵县', '', '421000', '434100', 'jlx', 'JiangLingXian');
INSERT INTO `area` VALUES ('421081', '石首市', '', '421000', '434400', 'sss', 'ShiShouShi');
INSERT INTO `area` VALUES ('421083', '洪湖市', '', '421000', '433200', 'hhs', 'HongHuShi');
INSERT INTO `area` VALUES ('421087', '松滋市', '', '421000', '434200', 'szs', 'SongZiShi');
INSERT INTO `area` VALUES ('421088', '其它区', '', '421000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('421100', '黄冈市', '', '420000', '438000', 'hgs', 'HuangGangShi');
INSERT INTO `area` VALUES ('421102', '黄州区', '', '421100', '438000', 'hzq', 'HuangZhouQu');
INSERT INTO `area` VALUES ('421121', '团风县', '', '421100', '438000', 'tfx', 'TuanFengXian');
INSERT INTO `area` VALUES ('421122', '红安县', '', '421100', '431500', 'hax', 'HongAnXian');
INSERT INTO `area` VALUES ('421123', '罗田县', '', '421100', '438600', 'ltx', 'LuoTianXian');
INSERT INTO `area` VALUES ('421124', '英山县', '', '421100', '438700', 'ysx', 'YingShanXian');
INSERT INTO `area` VALUES ('421125', '浠水县', '', '421100', '438200', 'xsx', 'ZuoShuiXian');
INSERT INTO `area` VALUES ('421126', '蕲春县', '', '421100', '436300', 'qcx', 'ZuoChunXian');
INSERT INTO `area` VALUES ('421127', '黄梅县', '', '421100', '435500', 'hmx', 'HuangMeiXian');
INSERT INTO `area` VALUES ('421181', '麻城市', '', '421100', '438300', 'mcs', 'MaChengShi');
INSERT INTO `area` VALUES ('421182', '武穴市', '', '421100', '435400', 'wxs', 'WuXueShi');
INSERT INTO `area` VALUES ('421183', '其它区', '', '421100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('421200', '咸宁市', '', '420000', '437100', 'xns', 'XianNingShi');
INSERT INTO `area` VALUES ('421202', '咸安区', '', '421200', '437000', 'xaq', 'XianAnQu');
INSERT INTO `area` VALUES ('421221', '嘉鱼县', '', '421200', '437200', 'jyx', 'JiaYuXian');
INSERT INTO `area` VALUES ('421222', '通城县', '', '421200', '437400', 'tcx', 'TongChengXian');
INSERT INTO `area` VALUES ('421223', '崇阳县', '', '421200', '437500', 'cyx', 'ChongYangXian');
INSERT INTO `area` VALUES ('421224', '通山县', '', '421200', '437600', 'tsx', 'TongShanXian');
INSERT INTO `area` VALUES ('421281', '赤壁市', '', '421200', '437300', 'cbs', 'ChiBiShi');
INSERT INTO `area` VALUES ('421282', '温泉城区', '', '421200', '', 'wqcq', 'WenQuanChengQu');
INSERT INTO `area` VALUES ('421283', '其它区', '', '421200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('421300', '随州市', '', '420000', '441300', 'szs', 'SuiZhouShi');
INSERT INTO `area` VALUES ('421302', '曾都区', '', '421300', '441300', 'zdq', 'ZengDuQu');
INSERT INTO `area` VALUES ('421321', '随县', '', '421300', '441300', '', '');
INSERT INTO `area` VALUES ('421381', '广水市', '', '421300', '432700', 'gss', 'GuangShuiShi');
INSERT INTO `area` VALUES ('421382', '其它区', '', '421300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('422800', '恩施土家族苗族自治州', '', '420000', '', 'estjzmzzzz', 'EnShiTuJiaZuMiaoZuZiZhiZhou');
INSERT INTO `area` VALUES ('422801', '恩施市', '', '422800', '445000', 'ess', 'EnShiShi');
INSERT INTO `area` VALUES ('422802', '利川市', '', '422800', '445400', 'lcs', 'LiChuanShi');
INSERT INTO `area` VALUES ('422822', '建始县', '', '422800', '445300', 'jsx', 'JianShiXian');
INSERT INTO `area` VALUES ('422823', '巴东县', '', '422800', '444300', 'bdx', 'BaDongXian');
INSERT INTO `area` VALUES ('422825', '宣恩县', '', '422800', '445500', 'xex', 'XuanEnXian');
INSERT INTO `area` VALUES ('422826', '咸丰县', '', '422800', '445600', 'xfx', 'XianFengXian');
INSERT INTO `area` VALUES ('422827', '来凤县', '', '422800', '445700', 'lfx', 'LaiFengXian');
INSERT INTO `area` VALUES ('422828', '鹤峰县', '', '422800', '445800', 'hfx', 'HeFengXian');
INSERT INTO `area` VALUES ('422829', '其它区', '', '422800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('429004', '仙桃市', '', '420000', '433000', 'xts', 'XianTaoShi');
INSERT INTO `area` VALUES ('429005', '潜江市', '', '420000', '433100', 'qjs', 'QianJiangShi');
INSERT INTO `area` VALUES ('429006', '天门市', '', '420000', '431700', 'tms', 'TianMenShi');
INSERT INTO `area` VALUES ('429021', '神农架林区', '', '420000', '442400', 'snjlq', 'ShenNongJiaLinQu');
INSERT INTO `area` VALUES ('430000', '湖南省', '', '1', '', 'hns', 'HuNanSheng');
INSERT INTO `area` VALUES ('430100', '长沙市', '', '430000', '410000', 'css', 'ChangShaShi');
INSERT INTO `area` VALUES ('430102', '芙蓉区', '', '430100', '410006', 'frq', 'ZuoRongQu');
INSERT INTO `area` VALUES ('430103', '天心区', '', '430100', '410002', 'txq', 'TianXinQu');
INSERT INTO `area` VALUES ('430104', '岳麓区', '', '430100', '410006', 'ylq', 'YueLuQu');
INSERT INTO `area` VALUES ('430105', '开福区', '', '430100', '410005', 'kfq', 'KaiFuQu');
INSERT INTO `area` VALUES ('430111', '雨花区', '', '430100', '410007', 'yhq', 'YuHuaQu');
INSERT INTO `area` VALUES ('430121', '长沙县', '', '430100', '410100', 'csx', 'ChangShaXian');
INSERT INTO `area` VALUES ('430122', '望城县', '', '430100', '410200', 'wcx', 'WangChengXian');
INSERT INTO `area` VALUES ('430124', '宁乡县', '', '430100', '410600', 'nxx', 'NingXiangXian');
INSERT INTO `area` VALUES ('430181', '浏阳市', '', '430100', '410300', 'lys', 'ZuoYangShi');
INSERT INTO `area` VALUES ('430182', '其它区', '', '430100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('430200', '株洲市', '', '430000', '412000', 'zzs', 'ZhuZhouShi');
INSERT INTO `area` VALUES ('430202', '荷塘区', '', '430200', '412000', 'htq', 'HeTangQu');
INSERT INTO `area` VALUES ('430203', '芦淞区', '', '430200', '412000', 'lsq', 'LuZuoQu');
INSERT INTO `area` VALUES ('430204', '石峰区', '', '430200', '412005', 'sfq', 'ShiFengQu');
INSERT INTO `area` VALUES ('430211', '天元区', '', '430200', '412000', 'tyq', 'TianYuanQu');
INSERT INTO `area` VALUES ('430221', '株洲县', '', '430200', '412100', 'zzx', 'ZhuZhouXian');
INSERT INTO `area` VALUES ('430223', '攸县', '', '430200', '412300', 'yx', 'ZuoXian');
INSERT INTO `area` VALUES ('430224', '茶陵县', '', '430200', '412400', 'clx', 'ChaLingXian');
INSERT INTO `area` VALUES ('430225', '炎陵县', '', '430200', '412500', 'ylx', 'YanLingXian');
INSERT INTO `area` VALUES ('430281', '醴陵市', '', '430200', '412200', 'lls', 'ZuoLingShi');
INSERT INTO `area` VALUES ('430282', '其它区', '', '430200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('430300', '湘潭市', '', '430000', '411100', 'xts', 'XiangTanShi');
INSERT INTO `area` VALUES ('430302', '雨湖区', '', '430300', '411100', 'yhq', 'YuHuQu');
INSERT INTO `area` VALUES ('430304', '岳塘区', '', '430300', '411101', 'ytq', 'YueTangQu');
INSERT INTO `area` VALUES ('430321', '湘潭县', '', '430300', '411200', 'xtx', 'XiangTanXian');
INSERT INTO `area` VALUES ('430381', '湘乡市', '', '430300', '411400', 'xxs', 'XiangXiangShi');
INSERT INTO `area` VALUES ('430382', '韶山市', '', '430300', '411300', 'sss', 'ShaoShanShi');
INSERT INTO `area` VALUES ('430383', '其它区', '', '430300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('430400', '衡阳市', '', '430000', '421000', 'hys', 'HengYangShi');
INSERT INTO `area` VALUES ('430405', '珠晖区', '', '430400', '421002', 'zhq', 'ZhuZuoQu');
INSERT INTO `area` VALUES ('430406', '雁峰区', '', '430400', '421001', 'yfq', 'YanFengQu');
INSERT INTO `area` VALUES ('430407', '石鼓区', '', '430400', '421001', 'sgq', 'ShiGuQu');
INSERT INTO `area` VALUES ('430408', '蒸湘区', '', '430400', '421001', 'zxq', 'ZhengXiangQu');
INSERT INTO `area` VALUES ('430412', '南岳区', '', '430400', '421900', 'nyq', 'NanYueQu');
INSERT INTO `area` VALUES ('430421', '衡阳县', '', '430400', '421200', 'hyx', 'HengYangXian');
INSERT INTO `area` VALUES ('430422', '衡南县', '', '430400', '421100', 'hnx', 'HengNanXian');
INSERT INTO `area` VALUES ('430423', '衡山县', '', '430400', '421300', 'hsx', 'HengShanXian');
INSERT INTO `area` VALUES ('430424', '衡东县', '', '430400', '421400', 'hdx', 'HengDongXian');
INSERT INTO `area` VALUES ('430426', '祁东县', '', '430400', '421600', 'qdx', 'QiDongXian');
INSERT INTO `area` VALUES ('430481', '耒阳市', '', '430400', '421800', 'lys', 'ZuoYangShi');
INSERT INTO `area` VALUES ('430482', '常宁市', '', '430400', '421500', 'cns', 'ChangNingShi');
INSERT INTO `area` VALUES ('430483', '其它区', '', '430400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('430500', '邵阳市', '', '430000', '422000', 'sys', 'ShaoYangShi');
INSERT INTO `area` VALUES ('430502', '双清区', '', '430500', '422001', 'sqq', 'ShuangQingQu');
INSERT INTO `area` VALUES ('430503', '大祥区', '', '430500', '422000', 'dxq', 'DaXiangQu');
INSERT INTO `area` VALUES ('430511', '北塔区', '', '430500', '422001', 'btq', 'BeiTaQu');
INSERT INTO `area` VALUES ('430521', '邵东县', '', '430500', '422800', 'sdx', 'ShaoDongXian');
INSERT INTO `area` VALUES ('430522', '新邵县', '', '430500', '422900', 'xsx', 'XinShaoXian');
INSERT INTO `area` VALUES ('430523', '邵阳县', '', '430500', '422100', 'syx', 'ShaoYangXian');
INSERT INTO `area` VALUES ('430524', '隆回县', '', '430500', '422200', 'lhx', 'LongHuiXian');
INSERT INTO `area` VALUES ('430525', '洞口县', '', '430500', '422300', 'dkx', 'DongKouXian');
INSERT INTO `area` VALUES ('430527', '绥宁县', '', '430500', '422600', 'snx', 'SuiNingXian');
INSERT INTO `area` VALUES ('430528', '新宁县', '', '430500', '422700', 'xnx', 'XinNingXian');
INSERT INTO `area` VALUES ('430529', '城步苗族自治县', '', '430500', '422500', 'cbmzzzx', 'ChengBuMiaoZuZiZhiXian');
INSERT INTO `area` VALUES ('430581', '武冈市', '', '430500', '422400', 'wgs', 'WuGangShi');
INSERT INTO `area` VALUES ('430582', '其它区', '', '430500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('430600', '岳阳市', '', '430000', '414000', 'yys', 'YueYangShi');
INSERT INTO `area` VALUES ('430602', '岳阳楼区', '', '430600', '414000', 'yylq', 'YueYangLouQu');
INSERT INTO `area` VALUES ('430603', '云溪区', '', '430600', '414003', 'yxq', 'YunXiQu');
INSERT INTO `area` VALUES ('430611', '君山区', '', '430600', '414005', 'jsq', 'JunShanQu');
INSERT INTO `area` VALUES ('430621', '岳阳县', '', '430600', '414100', 'yyx', 'YueYangXian');
INSERT INTO `area` VALUES ('430623', '华容县', '', '430600', '414200', 'hrx', 'HuaRongXian');
INSERT INTO `area` VALUES ('430624', '湘阴县', '', '430600', '414600', 'xyx', 'XiangYinXian');
INSERT INTO `area` VALUES ('430626', '平江县', '', '430600', '410400', 'pjx', 'PingJiangXian');
INSERT INTO `area` VALUES ('430681', '汨罗市', '', '430600', '414400', 'mls', 'ZuoLuoShi');
INSERT INTO `area` VALUES ('430682', '临湘市', '', '430600', '414300', 'lxs', 'LinXiangShi');
INSERT INTO `area` VALUES ('430683', '其它区', '', '430600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('430700', '常德市', '', '430000', '415000', 'cds', 'ChangDeShi');
INSERT INTO `area` VALUES ('430702', '武陵区', '', '430700', '415000', 'wlq', 'WuLingQu');
INSERT INTO `area` VALUES ('430703', '鼎城区', '', '430700', '415100', 'dcq', 'DingChengQu');
INSERT INTO `area` VALUES ('430721', '安乡县', '', '430700', '415600', 'axx', 'AnXiangXian');
INSERT INTO `area` VALUES ('430722', '汉寿县', '', '430700', '415900', 'hsx', 'HanShouXian');
INSERT INTO `area` VALUES ('430723', '澧县', '', '430700', '415500', 'lx', 'ZuoXian');
INSERT INTO `area` VALUES ('430724', '临澧县', '', '430700', '415200', 'llx', 'LinZuoXian');
INSERT INTO `area` VALUES ('430725', '桃源县', '', '430700', '415700', 'tyx', 'TaoYuanXian');
INSERT INTO `area` VALUES ('430726', '石门县', '', '430700', '415300', 'smx', 'ShiMenXian');
INSERT INTO `area` VALUES ('430781', '津市市', '', '430700', '415400', 'jss', 'JinShiShi');
INSERT INTO `area` VALUES ('430782', '其它区', '', '430700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('430800', '张家界市', '', '430000', '427000', 'zjjs', 'ZhangJiaJieShi');
INSERT INTO `area` VALUES ('430802', '永定区', '', '430800', '427000', 'ydq', 'YongDingQu');
INSERT INTO `area` VALUES ('430811', '武陵源区', '', '430800', '427400', 'wlyq', 'WuLingYuanQu');
INSERT INTO `area` VALUES ('430821', '慈利县', '', '430800', '427200', 'clx', 'CiLiXian');
INSERT INTO `area` VALUES ('430822', '桑植县', '', '430800', '427100', 'szx', 'SangZhiXian');
INSERT INTO `area` VALUES ('430823', '其它区', '', '430800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('430900', '益阳市', '', '430000', '413000', 'yys', 'YiYangShi');
INSERT INTO `area` VALUES ('430902', '资阳区', '', '430900', '413000', 'zyq', 'ZiYangQu');
INSERT INTO `area` VALUES ('430903', '赫山区', '', '430900', '413002', 'hsq', 'HeShanQu');
INSERT INTO `area` VALUES ('430921', '南县', '', '430900', '413200', 'nx', 'NanXian');
INSERT INTO `area` VALUES ('430922', '桃江县', '', '430900', '413400', 'tjx', 'TaoJiangXian');
INSERT INTO `area` VALUES ('430923', '安化县', '', '430900', '413500', 'ahx', 'AnHuaXian');
INSERT INTO `area` VALUES ('430981', '沅江市', '', '430900', '413100', 'yjs', 'ZuoJiangShi');
INSERT INTO `area` VALUES ('430982', '其它区', '', '430900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('431000', '郴州市', '', '430000', '423000', 'czs', 'ChenZhouShi');
INSERT INTO `area` VALUES ('431002', '北湖区', '', '431000', '423000', 'bhq', 'BeiHuQu');
INSERT INTO `area` VALUES ('431003', '苏仙区', '', '431000', '423000', 'sxq', 'SuXianQu');
INSERT INTO `area` VALUES ('431021', '桂阳县', '', '431000', '424400', 'gyx', 'GuiYangXian');
INSERT INTO `area` VALUES ('431022', '宜章县', '', '431000', '424200', 'yzx', 'YiZhangXian');
INSERT INTO `area` VALUES ('431023', '永兴县', '', '431000', '423300', 'yxx', 'YongXingXian');
INSERT INTO `area` VALUES ('431024', '嘉禾县', '', '431000', '424500', 'jhx', 'JiaHeXian');
INSERT INTO `area` VALUES ('431025', '临武县', '', '431000', '424300', 'lwx', 'LinWuXian');
INSERT INTO `area` VALUES ('431026', '汝城县', '', '431000', '424100', 'rcx', 'RuChengXian');
INSERT INTO `area` VALUES ('431027', '桂东县', '', '431000', '423500', 'gdx', 'GuiDongXian');
INSERT INTO `area` VALUES ('431028', '安仁县', '', '431000', '423600', 'arx', 'AnRenXian');
INSERT INTO `area` VALUES ('431081', '资兴市', '', '431000', '423400', 'zxs', 'ZiXingShi');
INSERT INTO `area` VALUES ('431082', '其它区', '', '431000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('431100', '永州市', '', '430000', '425000', 'yzs', 'YongZhouShi');
INSERT INTO `area` VALUES ('431102', '零陵区', '', '431100', '425007', 'llq', 'LingLingQu');
INSERT INTO `area` VALUES ('431103', '冷水滩区', '', '431100', '425000', 'lstq', 'LengShuiTanQu');
INSERT INTO `area` VALUES ('431121', '祁阳县', '', '431100', '426100', 'qyx', 'QiYangXian');
INSERT INTO `area` VALUES ('431122', '东安县', '', '431100', '425900', 'dax', 'DongAnXian');
INSERT INTO `area` VALUES ('431123', '双牌县', '', '431100', '425200', 'spx', 'ShuangPaiXian');
INSERT INTO `area` VALUES ('431124', '道县', '', '431100', '425300', 'dx', 'DaoXian');
INSERT INTO `area` VALUES ('431125', '江永县', '', '431100', '425400', 'jyx', 'JiangYongXian');
INSERT INTO `area` VALUES ('431126', '宁远县', '', '431100', '425600', 'nyx', 'NingYuanXian');
INSERT INTO `area` VALUES ('431127', '蓝山县', '', '431100', '425800', 'lsx', 'LanShanXian');
INSERT INTO `area` VALUES ('431128', '新田县', '', '431100', '425700', 'xtx', 'XinTianXian');
INSERT INTO `area` VALUES ('431129', '江华瑶族自治县', '', '431100', '425500', 'jhyzzzx', 'JiangHuaYaoZuZiZhiXian');
INSERT INTO `area` VALUES ('431130', '其它区', '', '431100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('431200', '怀化市', '', '430000', '418000', 'hhs', 'HuaiHuaShi');
INSERT INTO `area` VALUES ('431202', '鹤城区', '', '431200', '418000', 'hcq', 'HeChengQu');
INSERT INTO `area` VALUES ('431221', '中方县', '', '431200', '418005', 'zfx', 'ZhongFangXian');
INSERT INTO `area` VALUES ('431222', '沅陵县', '', '431200', '419600', 'ylx', 'ZuoLingXian');
INSERT INTO `area` VALUES ('431223', '辰溪县', '', '431200', '419500', 'cxx', 'ChenXiXian');
INSERT INTO `area` VALUES ('431224', '溆浦县', '', '431200', '419300', 'xpx', 'ZuoPuXian');
INSERT INTO `area` VALUES ('431225', '会同县', '', '431200', '418300', 'htx', 'HuiTongXian');
INSERT INTO `area` VALUES ('431226', '麻阳苗族自治县', '', '431200', '419400', 'mymzzzx', 'MaYangMiaoZuZiZhiXian');
INSERT INTO `area` VALUES ('431227', '新晃侗族自治县', '', '431200', '419200', 'xhdzzzx', 'XinHuangDongZuZiZhiXian');
INSERT INTO `area` VALUES ('431228', '芷江侗族自治县', '', '431200', '419100', 'zjdzzzx', 'ZuoJiangDongZuZiZhiXian');
INSERT INTO `area` VALUES ('431229', '靖州苗族侗族自治县', '', '431200', '418400', 'jzmzdzzzx', 'JingZhouMiaoZuDongZuZiZhiXian');
INSERT INTO `area` VALUES ('431230', '通道侗族自治县', '', '431200', '418500', 'tddzzzx', 'TongDaoDongZuZiZhiXian');
INSERT INTO `area` VALUES ('431281', '洪江市', '', '431200', '418200', 'hjs', 'HongJiangShi');
INSERT INTO `area` VALUES ('431282', '其它区', '', '431200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('431300', '娄底市', '', '430000', '417000', 'lds', 'LouDiShi');
INSERT INTO `area` VALUES ('431302', '娄星区', '', '431300', '417000', 'lxq', 'LouXingQu');
INSERT INTO `area` VALUES ('431321', '双峰县', '', '431300', '417700', 'sfx', 'ShuangFengXian');
INSERT INTO `area` VALUES ('431322', '新化县', '', '431300', '417600', 'xhx', 'XinHuaXian');
INSERT INTO `area` VALUES ('431381', '冷水江市', '', '431300', '417500', 'lsjs', 'LengShuiJiangShi');
INSERT INTO `area` VALUES ('431382', '涟源市', '', '431300', '417100', 'lys', 'LianYuanShi');
INSERT INTO `area` VALUES ('431383', '其它区', '', '431300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('433100', '湘西土家族苗族自治州', '', '430000', '416000', 'xxtjzmzzzz', 'XiangXiTuJiaZuMiaoZuZiZhiZhou');
INSERT INTO `area` VALUES ('433101', '吉首市', '', '433100', '416000', 'jss', 'JiShouShi');
INSERT INTO `area` VALUES ('433122', '泸溪县', '', '433100', '416100', 'lxx', 'ZuoXiXian');
INSERT INTO `area` VALUES ('433123', '凤凰县', '', '433100', '416200', 'fhx', 'FengHuangXian');
INSERT INTO `area` VALUES ('433124', '花垣县', '', '433100', '416400', 'hyx', 'HuaYuanXian');
INSERT INTO `area` VALUES ('433125', '保靖县', '', '433100', '416500', 'bjx', 'BaoJingXian');
INSERT INTO `area` VALUES ('433126', '古丈县', '', '433100', '416300', 'gzx', 'GuZhangXian');
INSERT INTO `area` VALUES ('433127', '永顺县', '', '433100', '416700', 'ysx', 'YongShunXian');
INSERT INTO `area` VALUES ('433130', '龙山县', '', '433100', '416800', 'lsx', 'LongShanXian');
INSERT INTO `area` VALUES ('433131', '其它区', '', '433100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('440000', '广东省', '', '1', '', 'gds', 'GuangDongSheng');
INSERT INTO `area` VALUES ('440100', '广州市', '', '440000', '510000', 'gzs', 'GuangZhouShi');
INSERT INTO `area` VALUES ('440103', '荔湾区', '', '440100', '510145', 'lwq', 'LiWanQu');
INSERT INTO `area` VALUES ('440104', '越秀区', '', '440100', '510180', 'yxq', 'YueXiuQu');
INSERT INTO `area` VALUES ('440105', '海珠区', '', '440100', '510220', 'hzq', 'HaiZhuQu');
INSERT INTO `area` VALUES ('440106', '天河区', '', '440100', '510510', 'thq', 'TianHeQu');
INSERT INTO `area` VALUES ('440111', '白云区', '', '440100', '510440', 'byq', 'BaiYunQu');
INSERT INTO `area` VALUES ('440112', '黄埔区', '', '440100', '510700', 'hpq', 'HuangPuQu');
INSERT INTO `area` VALUES ('440113', '番禺区', '', '440100', '511400', 'fyq', 'FanZuoQu');
INSERT INTO `area` VALUES ('440114', '花都区', '', '440100', '510800', 'hdq', 'HuaDuQu');
INSERT INTO `area` VALUES ('440115', '南沙区', '', '440100', '', 'nsq', 'NanShaQu');
INSERT INTO `area` VALUES ('440116', '萝岗区', '', '440100', '', 'lgq', 'LuoGangQu');
INSERT INTO `area` VALUES ('440183', '增城市', '', '440100', '511300', 'zcs', 'ZengChengShi');
INSERT INTO `area` VALUES ('440184', '从化市', '', '440100', '510900', 'chs', 'CongHuaShi');
INSERT INTO `area` VALUES ('440188', '东山区', '', '440100', '', 'dsq', 'DongShanQu');
INSERT INTO `area` VALUES ('440189', '其它区', '', '440100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('440200', '韶关市', '', '440000', '512000', 'sgs', 'ShaoGuanShi');
INSERT INTO `area` VALUES ('440203', '武江区', '', '440200', '512026', 'wjq', 'WuJiangQu');
INSERT INTO `area` VALUES ('440204', '浈江区', '', '440200', '512023', 'zjq', 'ZuoJiangQu');
INSERT INTO `area` VALUES ('440205', '曲江区', '', '440200', '512100', 'qjq', 'QuJiangQu');
INSERT INTO `area` VALUES ('440222', '始兴县', '', '440200', '512500', 'sxx', 'ShiXingXian');
INSERT INTO `area` VALUES ('440224', '仁化县', '', '440200', '512300', 'rhx', 'RenHuaXian');
INSERT INTO `area` VALUES ('440229', '翁源县', '', '440200', '512600', 'wyx', 'WengYuanXian');
INSERT INTO `area` VALUES ('440232', '乳源瑶族自治县', '', '440200', '512700', 'ryyzzzx', 'RuYuanYaoZuZiZhiXian');
INSERT INTO `area` VALUES ('440233', '新丰县', '', '440200', '511100', 'xfx', 'XinFengXian');
INSERT INTO `area` VALUES ('440281', '乐昌市', '', '440200', '512200', 'lcs', 'LeChangShi');
INSERT INTO `area` VALUES ('440282', '南雄市', '', '440200', '512400', 'nxs', 'NanXiongShi');
INSERT INTO `area` VALUES ('440283', '其它区', '', '440200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('440300', '深圳市', '', '440000', '518000', 'szs', 'ShenZhenShi');
INSERT INTO `area` VALUES ('440303', '罗湖区', '', '440300', '518002', 'lhq', 'LuoHuQu');
INSERT INTO `area` VALUES ('440304', '福田区', '', '440300', '518031', 'ftq', 'FuTianQu');
INSERT INTO `area` VALUES ('440305', '南山区', '', '440300', '518052', 'nsq', 'NanShanQu');
INSERT INTO `area` VALUES ('440306', '宝安区', '', '440300', '518101', 'baq', 'BaoAnQu');
INSERT INTO `area` VALUES ('440307', '龙岗区', '', '440300', '518116', 'lgq', 'LongGangQu');
INSERT INTO `area` VALUES ('440308', '盐田区', '', '440300', '518083', 'ytq', 'YanTianQu');
INSERT INTO `area` VALUES ('440309', '其它区', '', '440300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('440400', '珠海市', '', '440000', '519000', 'zhs', 'ZhuHaiShi');
INSERT INTO `area` VALUES ('440402', '香洲区', '', '440400', '519000', 'xzq', 'XiangZhouQu');
INSERT INTO `area` VALUES ('440403', '斗门区', '', '440400', '519100', 'dmq', 'DouMenQu');
INSERT INTO `area` VALUES ('440404', '金湾区', '', '440400', '519090', 'jwq', 'JinWanQu');
INSERT INTO `area` VALUES ('440486', '金唐区', '', '440400', '', 'jtq', 'JinTangQu');
INSERT INTO `area` VALUES ('440487', '南湾区', '', '440400', '', 'nwq', 'NanWanQu');
INSERT INTO `area` VALUES ('440488', '其它区', '', '440400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('440500', '汕头市', '', '440000', '515000', 'sts', 'ShanTouShi');
INSERT INTO `area` VALUES ('440507', '龙湖区', '', '440500', '515041', 'lhq', 'LongHuQu');
INSERT INTO `area` VALUES ('440511', '金平区', '', '440500', '515041', 'jpq', 'JinPingQu');
INSERT INTO `area` VALUES ('440512', '濠江区', '', '440500', '515071', 'hjq', 'ZuoJiangQu');
INSERT INTO `area` VALUES ('440513', '潮阳区', '', '440500', '515100', 'cyq', 'ChaoYangQu');
INSERT INTO `area` VALUES ('440514', '潮南区', '', '440500', '515144', 'cnq', 'ChaoNanQu');
INSERT INTO `area` VALUES ('440515', '澄海区', '', '440500', '515800', 'chq', 'ChengHaiQu');
INSERT INTO `area` VALUES ('440523', '南澳县', '', '440500', '515900', 'nax', 'NanAoXian');
INSERT INTO `area` VALUES ('440524', '其它区', '', '440500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('440600', '佛山市', '', '440000', '528000', 'fss', 'FoShanShi');
INSERT INTO `area` VALUES ('440604', '禅城区', '', '440600', '528000', 'ccq', 'ZuoChengQu');
INSERT INTO `area` VALUES ('440605', '南海区', '', '440600', '528200', 'nhq', 'NanHaiQu');
INSERT INTO `area` VALUES ('440606', '顺德区', '', '440600', '528300', 'sdq', 'ShunDeQu');
INSERT INTO `area` VALUES ('440607', '三水区', '', '440600', '528100', 'ssq', 'SanShuiQu');
INSERT INTO `area` VALUES ('440608', '高明区', '', '440600', '528500', 'gmq', 'GaoMingQu');
INSERT INTO `area` VALUES ('440609', '其它区', '', '440600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('440700', '江门市', '', '440000', '529000', 'jms', 'JiangMenShi');
INSERT INTO `area` VALUES ('440703', '蓬江区', '', '440700', '529051', 'pjq', 'PengJiangQu');
INSERT INTO `area` VALUES ('440704', '江海区', '', '440700', '529000', 'jhq', 'JiangHaiQu');
INSERT INTO `area` VALUES ('440705', '新会区', '', '440700', '529100', 'xhq', 'XinHuiQu');
INSERT INTO `area` VALUES ('440781', '台山市', '', '440700', '529200', 'tss', 'TaiShanShi');
INSERT INTO `area` VALUES ('440783', '开平市', '', '440700', '529300', 'kps', 'KaiPingShi');
INSERT INTO `area` VALUES ('440784', '鹤山市', '', '440700', '529700', 'hss', 'HeShanShi');
INSERT INTO `area` VALUES ('440785', '恩平市', '', '440700', '529400', 'eps', 'EnPingShi');
INSERT INTO `area` VALUES ('440786', '其它区', '', '440700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('440800', '湛江市', '', '440000', '524000', 'zjs', 'ZhanJiangShi');
INSERT INTO `area` VALUES ('440802', '赤坎区', '', '440800', '524033', 'ckq', 'ChiKanQu');
INSERT INTO `area` VALUES ('440803', '霞山区', '', '440800', '524002', 'xsq', 'XiaShanQu');
INSERT INTO `area` VALUES ('440804', '坡头区', '', '440800', '524057', 'ptq', 'PoTouQu');
INSERT INTO `area` VALUES ('440811', '麻章区', '', '440800', '524003', 'mzq', 'MaZhangQu');
INSERT INTO `area` VALUES ('440823', '遂溪县', '', '440800', '524300', 'sxx', 'SuiXiXian');
INSERT INTO `area` VALUES ('440825', '徐闻县', '', '440800', '524100', 'xwx', 'XuWenXian');
INSERT INTO `area` VALUES ('440881', '廉江市', '', '440800', '524400', 'ljs', 'LianJiangShi');
INSERT INTO `area` VALUES ('440882', '雷州市', '', '440800', '524200', 'lzs', 'LeiZhouShi');
INSERT INTO `area` VALUES ('440883', '吴川市', '', '440800', '524500', 'wcs', 'WuChuanShi');
INSERT INTO `area` VALUES ('440884', '其它区', '', '440800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('440900', '茂名市', '', '440000', '525000', 'mms', 'MaoMingShi');
INSERT INTO `area` VALUES ('440902', '茂南区', '', '440900', '525011', 'mnq', 'MaoNanQu');
INSERT INTO `area` VALUES ('440903', '茂港区', '', '440900', '525027', 'mgq', 'MaoGangQu');
INSERT INTO `area` VALUES ('440923', '电白县', '', '440900', '525400', 'dbx', 'DianBaiXian');
INSERT INTO `area` VALUES ('440981', '高州市', '', '440900', '525200', 'gzs', 'GaoZhouShi');
INSERT INTO `area` VALUES ('440982', '化州市', '', '440900', '525100', 'hzs', 'HuaZhouShi');
INSERT INTO `area` VALUES ('440983', '信宜市', '', '440900', '525300', 'xys', 'XinYiShi');
INSERT INTO `area` VALUES ('440984', '其它区', '', '440900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('441200', '肇庆市', '', '440000', '526000', 'zqs', 'ZhaoQingShi');
INSERT INTO `area` VALUES ('441202', '端州区', '', '441200', '526040', 'dzq', 'DuanZhouQu');
INSERT INTO `area` VALUES ('441203', '鼎湖区', '', '441200', '526070', 'dhq', 'DingHuQu');
INSERT INTO `area` VALUES ('441223', '广宁县', '', '441200', '526300', 'gnx', 'GuangNingXian');
INSERT INTO `area` VALUES ('441224', '怀集县', '', '441200', '526400', 'hjx', 'HuaiJiXian');
INSERT INTO `area` VALUES ('441225', '封开县', '', '441200', '526500', 'fkx', 'FengKaiXian');
INSERT INTO `area` VALUES ('441226', '德庆县', '', '441200', '526600', 'dqx', 'DeQingXian');
INSERT INTO `area` VALUES ('441283', '高要市', '', '441200', '526100', 'gys', 'GaoYaoShi');
INSERT INTO `area` VALUES ('441284', '四会市', '', '441200', '526200', 'shs', 'SiHuiShi');
INSERT INTO `area` VALUES ('441285', '其它区', '', '441200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('441300', '惠州市', '', '440000', '516000', 'hzs', 'HuiZhouShi');
INSERT INTO `area` VALUES ('441302', '惠城区', '', '441300', '516001', 'hcq', 'HuiChengQu');
INSERT INTO `area` VALUES ('441303', '惠阳区', '', '441300', '516200', 'hyq', 'HuiYangQu');
INSERT INTO `area` VALUES ('441322', '博罗县', '', '441300', '516100', 'blx', 'BoLuoXian');
INSERT INTO `area` VALUES ('441323', '惠东县', '', '441300', '516300', 'hdx', 'HuiDongXian');
INSERT INTO `area` VALUES ('441324', '龙门县', '', '441300', '516800', 'lmx', 'LongMenXian');
INSERT INTO `area` VALUES ('441325', '其它区', '', '441300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('441400', '梅州市', '', '440000', '514000', 'mzs', 'MeiZhouShi');
INSERT INTO `area` VALUES ('441402', '梅江区', '', '441400', '514000', 'mjq', 'MeiJiangQu');
INSERT INTO `area` VALUES ('441421', '梅县', '', '441400', '514700', 'mx', 'MeiXian');
INSERT INTO `area` VALUES ('441422', '大埔县', '', '441400', '514200', 'dpx', 'DaPuXian');
INSERT INTO `area` VALUES ('441423', '丰顺县', '', '441400', '514300', 'fsx', 'FengShunXian');
INSERT INTO `area` VALUES ('441424', '五华县', '', '441400', '514400', 'whx', 'WuHuaXian');
INSERT INTO `area` VALUES ('441426', '平远县', '', '441400', '514600', 'pyx', 'PingYuanXian');
INSERT INTO `area` VALUES ('441427', '蕉岭县', '', '441400', '514100', 'jlx', 'JiaoLingXian');
INSERT INTO `area` VALUES ('441481', '兴宁市', '', '441400', '514500', 'xns', 'XingNingShi');
INSERT INTO `area` VALUES ('441482', '其它区', '', '441400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('441500', '汕尾市', '', '440000', '516600', 'sws', 'ShanWeiShi');
INSERT INTO `area` VALUES ('441502', '城区', '', '441500', '516601', 'cq', 'ChengQu');
INSERT INTO `area` VALUES ('441521', '海丰县', '', '441500', '516400', 'hfx', 'HaiFengXian');
INSERT INTO `area` VALUES ('441523', '陆河县', '', '441500', '516700', 'lhx', 'LuHeXian');
INSERT INTO `area` VALUES ('441581', '陆丰市', '', '441500', '516500', 'lfs', 'LuFengShi');
INSERT INTO `area` VALUES ('441582', '其它区', '', '441500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('441600', '河源市', '', '440000', '517000', 'hys', 'HeYuanShi');
INSERT INTO `area` VALUES ('441602', '源城区', '', '441600', '517000', 'ycq', 'YuanChengQu');
INSERT INTO `area` VALUES ('441621', '紫金县', '', '441600', '517400', 'zjx', 'ZiJinXian');
INSERT INTO `area` VALUES ('441622', '龙川县', '', '441600', '517300', 'lcx', 'LongChuanXian');
INSERT INTO `area` VALUES ('441623', '连平县', '', '441600', '517100', 'lpx', 'LianPingXian');
INSERT INTO `area` VALUES ('441624', '和平县', '', '441600', '517200', 'hpx', 'HePingXian');
INSERT INTO `area` VALUES ('441625', '东源县', '', '441600', '517500', 'dyx', 'DongYuanXian');
INSERT INTO `area` VALUES ('441626', '其它区', '', '441600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('441700', '阳江市', '', '440000', '529500', 'yjs', 'YangJiangShi');
INSERT INTO `area` VALUES ('441702', '江城区', '', '441700', '529525', 'jcq', 'JiangChengQu');
INSERT INTO `area` VALUES ('441721', '阳西县', '', '441700', '529800', 'yxx', 'YangXiXian');
INSERT INTO `area` VALUES ('441723', '阳东县', '', '441700', '529931', 'ydx', 'YangDongXian');
INSERT INTO `area` VALUES ('441781', '阳春市', '', '441700', '529600', 'ycs', 'YangChunShi');
INSERT INTO `area` VALUES ('441782', '其它区', '', '441700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('441800', '清远市', '', '440000', '511500', 'qys', 'QingYuanShi');
INSERT INTO `area` VALUES ('441802', '清城区', '', '441800', '511500', 'qcq', 'QingChengQu');
INSERT INTO `area` VALUES ('441821', '佛冈县', '', '441800', '511600', 'fgx', 'FoGangXian');
INSERT INTO `area` VALUES ('441823', '阳山县', '', '441800', '513100', 'ysx', 'YangShanXian');
INSERT INTO `area` VALUES ('441825', '连山壮族瑶族自治县', '', '441800', '513200', 'lszzyzzzx', 'LianShanZhuangZuYaoZuZiZhiXian');
INSERT INTO `area` VALUES ('441826', '连南瑶族自治县', '', '441800', '513300', 'lnyzzzx', 'LianNanYaoZuZiZhiXian');
INSERT INTO `area` VALUES ('441827', '清新县', '', '441800', '511800', 'qxx', 'QingXinXian');
INSERT INTO `area` VALUES ('441881', '英德市', '', '441800', '513000', 'yds', 'YingDeShi');
INSERT INTO `area` VALUES ('441882', '连州市', '', '441800', '513400', 'lzs', 'LianZhouShi');
INSERT INTO `area` VALUES ('441883', '其它区', '', '441800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('441900', '东莞市', '', '440000', '523000', 'dgs', 'DongZuoShi');
INSERT INTO `area` VALUES ('442000', '中山市', '', '440000', '528400', 'zss', 'ZhongShanShi');
INSERT INTO `area` VALUES ('445100', '潮州市', '', '440000', '521000', 'czs', 'ChaoZhouShi');
INSERT INTO `area` VALUES ('445102', '湘桥区', '', '445100', '521000', 'xqq', 'XiangQiaoQu');
INSERT INTO `area` VALUES ('445121', '潮安县', '', '445100', '515600', 'cax', 'ChaoAnXian');
INSERT INTO `area` VALUES ('445122', '饶平县', '', '445100', '515700', 'rpx', 'RaoPingXian');
INSERT INTO `area` VALUES ('445185', '枫溪区', '', '445100', '', 'fxq', 'FengXiQu');
INSERT INTO `area` VALUES ('445186', '其它区', '', '445100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('445200', '揭阳市', '', '440000', '522000', 'jys', 'JieYangShi');
INSERT INTO `area` VALUES ('445202', '榕城区', '', '445200', '522095', 'rcq', 'ZuoChengQu');
INSERT INTO `area` VALUES ('445221', '揭东县', '', '445200', '515500', 'jdx', 'JieDongXian');
INSERT INTO `area` VALUES ('445222', '揭西县', '', '445200', '515400', 'jxx', 'JieXiXian');
INSERT INTO `area` VALUES ('445224', '惠来县', '', '445200', '515200', 'hlx', 'HuiLaiXian');
INSERT INTO `area` VALUES ('445281', '普宁市', '', '445200', '515300', 'pns', 'PuNingShi');
INSERT INTO `area` VALUES ('445284', '东山区', '', '445200', '', 'dsq', 'DongShanQu');
INSERT INTO `area` VALUES ('445285', '其它区', '', '445200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('445300', '云浮市', '', '440000', '527300', 'yfs', 'YunFuShi');
INSERT INTO `area` VALUES ('445302', '云城区', '', '445300', '527300', 'ycq', 'YunChengQu');
INSERT INTO `area` VALUES ('445321', '新兴县', '', '445300', '527400', 'xxx', 'XinXingXian');
INSERT INTO `area` VALUES ('445322', '郁南县', '', '445300', '527100', 'ynx', 'YuNanXian');
INSERT INTO `area` VALUES ('445323', '云安县', '', '445300', '527500', 'yax', 'YunAnXian');
INSERT INTO `area` VALUES ('445381', '罗定市', '', '445300', '527200', 'lds', 'LuoDingShi');
INSERT INTO `area` VALUES ('445382', '其它区', '', '445300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('450000', '广西壮族自治区', '', '1', '', 'gxzzzzq', 'GuangXiZhuangZuZiZhiQu');
INSERT INTO `area` VALUES ('450100', '南宁市', '', '450000', '530000', 'nns', 'NanNingShi');
INSERT INTO `area` VALUES ('450102', '兴宁区', '', '450100', '530012', 'xnq', 'XingNingQu');
INSERT INTO `area` VALUES ('450103', '青秀区', '', '450100', '530022', 'qxq', 'QingXiuQu');
INSERT INTO `area` VALUES ('450105', '江南区', '', '450100', '530031', 'jnq', 'JiangNanQu');
INSERT INTO `area` VALUES ('450107', '西乡塘区', '', '450100', '530001', 'xxtq', 'XiXiangTangQu');
INSERT INTO `area` VALUES ('450108', '良庆区', '', '450100', '530200', 'lqq', 'LiangQingQu');
INSERT INTO `area` VALUES ('450109', '邕宁区', '', '450100', '530200', 'ynq', 'ZuoNingQu');
INSERT INTO `area` VALUES ('450122', '武鸣县', '', '450100', '530100', 'wmx', 'WuMingXian');
INSERT INTO `area` VALUES ('450123', '隆安县', '', '450100', '532700', 'lax', 'LongAnXian');
INSERT INTO `area` VALUES ('450124', '马山县', '', '450100', '530600', 'msx', 'MaShanXian');
INSERT INTO `area` VALUES ('450125', '上林县', '', '450100', '530500', 'slx', 'ShangLinXian');
INSERT INTO `area` VALUES ('450126', '宾阳县', '', '450100', '530400', 'byx', 'BinYangXian');
INSERT INTO `area` VALUES ('450127', '横县', '', '450100', '530300', 'hx', 'HengXian');
INSERT INTO `area` VALUES ('450128', '其它区', '', '450100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('450200', '柳州市', '', '450000', '545000', 'lzs', 'LiuZhouShi');
INSERT INTO `area` VALUES ('450202', '城中区', '', '450200', '545001', 'czq', 'ChengZhongQu');
INSERT INTO `area` VALUES ('450203', '鱼峰区', '', '450200', '545005', 'yfq', 'YuFengQu');
INSERT INTO `area` VALUES ('450204', '柳南区', '', '450200', '545005', 'lnq', 'LiuNanQu');
INSERT INTO `area` VALUES ('450205', '柳北区', '', '450200', '545001', 'lbq', 'LiuBeiQu');
INSERT INTO `area` VALUES ('450221', '柳江县', '', '450200', '545100', 'ljx', 'LiuJiangXian');
INSERT INTO `area` VALUES ('450222', '柳城县', '', '450200', '545200', 'lcx', 'LiuChengXian');
INSERT INTO `area` VALUES ('450223', '鹿寨县', '', '450200', '545600', 'lzx', 'LuZhaiXian');
INSERT INTO `area` VALUES ('450224', '融安县', '', '450200', '545400', 'rax', 'RongAnXian');
INSERT INTO `area` VALUES ('450225', '融水苗族自治县', '', '450200', '545300', 'rsmzzzx', 'RongShuiMiaoZuZiZhiXian');
INSERT INTO `area` VALUES ('450226', '三江侗族自治县', '', '450200', '545500', 'sjdzzzx', 'SanJiangDongZuZiZhiXian');
INSERT INTO `area` VALUES ('450227', '其它区', '', '450200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('450300', '桂林市', '', '450000', '541000', 'gls', 'GuiLinShi');
INSERT INTO `area` VALUES ('450302', '秀峰区', '', '450300', '541001', 'xfq', 'XiuFengQu');
INSERT INTO `area` VALUES ('450303', '叠彩区', '', '450300', '541001', 'dcq', 'DieCaiQu');
INSERT INTO `area` VALUES ('450304', '象山区', '', '450300', '541002', 'xsq', 'XiangShanQu');
INSERT INTO `area` VALUES ('450305', '七星区', '', '450300', '541004', 'qxq', 'QiXingQu');
INSERT INTO `area` VALUES ('450311', '雁山区', '', '450300', '541006', 'ysq', 'YanShanQu');
INSERT INTO `area` VALUES ('450321', '阳朔县', '', '450300', '541900', 'ysx', 'YangShuoXian');
INSERT INTO `area` VALUES ('450322', '临桂县', '', '450300', '541100', 'lgx', 'LinGuiXian');
INSERT INTO `area` VALUES ('450323', '灵川县', '', '450300', '541200', 'lcx', 'LingChuanXian');
INSERT INTO `area` VALUES ('450324', '全州县', '', '450300', '541500', 'qzx', 'QuanZhouXian');
INSERT INTO `area` VALUES ('450325', '兴安县', '', '450300', '541300', 'xax', 'XingAnXian');
INSERT INTO `area` VALUES ('450326', '永福县', '', '450300', '541800', 'yfx', 'YongFuXian');
INSERT INTO `area` VALUES ('450327', '灌阳县', '', '450300', '541600', 'gyx', 'GuanYangXian');
INSERT INTO `area` VALUES ('450328', '龙胜各族自治县', '', '450300', '541700', 'lsgzzzx', 'LongShengGeZuZiZhiXian');
INSERT INTO `area` VALUES ('450329', '资源县', '', '450300', '541400', 'zyx', 'ZiYuanXian');
INSERT INTO `area` VALUES ('450330', '平乐县', '', '450300', '542400', 'plx', 'PingLeXian');
INSERT INTO `area` VALUES ('450331', '荔浦县', '', '450300', '546600', 'lpx', 'LiPuXian');
INSERT INTO `area` VALUES ('450332', '恭城瑶族自治县', '', '450300', '542500', 'gcyzzzx', 'GongChengYaoZuZiZhiXian');
INSERT INTO `area` VALUES ('450333', '其它区', '', '450300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('450400', '梧州市', '', '450000', '543000', 'wzs', 'WuZhouShi');
INSERT INTO `area` VALUES ('450403', '万秀区', '', '450400', '543000', 'wxq', 'WanXiuQu');
INSERT INTO `area` VALUES ('450404', '蝶山区', '', '450400', '543002', 'dsq', 'DieShanQu');
INSERT INTO `area` VALUES ('450405', '长洲区', '', '450400', '543002', 'czq', 'ChangZhouQu');
INSERT INTO `area` VALUES ('450421', '苍梧县', '', '450400', '543100', 'cwx', 'CangWuXian');
INSERT INTO `area` VALUES ('450422', '藤县', '', '450400', '543300', 'tx', 'TengXian');
INSERT INTO `area` VALUES ('450423', '蒙山县', '', '450400', '546700', 'msx', 'MengShanXian');
INSERT INTO `area` VALUES ('450481', '岑溪市', '', '450400', '543200', 'cxs', 'ZuoXiShi');
INSERT INTO `area` VALUES ('450482', '其它区', '', '450400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('450500', '北海市', '', '450000', '536000', 'bhs', 'BeiHaiShi');
INSERT INTO `area` VALUES ('450502', '海城区', '', '450500', '536000', 'hcq', 'HaiChengQu');
INSERT INTO `area` VALUES ('450503', '银海区', '', '450500', '536000', 'yhq', 'YinHaiQu');
INSERT INTO `area` VALUES ('450512', '铁山港区', '', '450500', '536017', 'tsgq', 'TieShanGangQu');
INSERT INTO `area` VALUES ('450521', '合浦县', '', '450500', '536100', 'hpx', 'HePuXian');
INSERT INTO `area` VALUES ('450522', '其它区', '', '450500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('450600', '防城港市', '', '450000', '538000', 'fcgs', 'FangChengGangShi');
INSERT INTO `area` VALUES ('450602', '港口区', '', '450600', '538001', 'gkq', 'GangKouQu');
INSERT INTO `area` VALUES ('450603', '防城区', '', '450600', '538021', 'fcq', 'FangChengQu');
INSERT INTO `area` VALUES ('450621', '上思县', '', '450600', '535500', 'ssx', 'ShangSiXian');
INSERT INTO `area` VALUES ('450681', '东兴市', '', '450600', '538100', 'dxs', 'DongXingShi');
INSERT INTO `area` VALUES ('450682', '其它区', '', '450600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('450700', '钦州市', '', '450000', '535000', 'qzs', 'QinZhouShi');
INSERT INTO `area` VALUES ('450702', '钦南区', '', '450700', '535000', 'qnq', 'QinNanQu');
INSERT INTO `area` VALUES ('450703', '钦北区', '', '450700', '535000', 'qbq', 'QinBeiQu');
INSERT INTO `area` VALUES ('450721', '灵山县', '', '450700', '535400', 'lsx', 'LingShanXian');
INSERT INTO `area` VALUES ('450722', '浦北县', '', '450700', '535300', 'pbx', 'PuBeiXian');
INSERT INTO `area` VALUES ('450723', '其它区', '', '450700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('450800', '贵港市', '', '450000', '537100', 'ggs', 'GuiGangShi');
INSERT INTO `area` VALUES ('450802', '港北区', '', '450800', '537100', 'gbq', 'GangBeiQu');
INSERT INTO `area` VALUES ('450803', '港南区', '', '450800', '537132', 'gnq', 'GangNanQu');
INSERT INTO `area` VALUES ('450804', '覃塘区', '', '450800', '537121', 'ttq', 'ZuoTangQu');
INSERT INTO `area` VALUES ('450821', '平南县', '', '450800', '537300', 'pnx', 'PingNanXian');
INSERT INTO `area` VALUES ('450881', '桂平市', '', '450800', '537200', 'gps', 'GuiPingShi');
INSERT INTO `area` VALUES ('450882', '其它区', '', '450800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('450900', '玉林市', '', '450000', '537000', 'yls', 'YuLinShi');
INSERT INTO `area` VALUES ('450902', '玉州区', '', '450900', '537000', 'yzq', 'YuZhouQu');
INSERT INTO `area` VALUES ('450921', '容县', '', '450900', '537500', 'rx', 'RongXian');
INSERT INTO `area` VALUES ('450922', '陆川县', '', '450900', '537700', 'lcx', 'LuChuanXian');
INSERT INTO `area` VALUES ('450923', '博白县', '', '450900', '537600', 'bbx', 'BoBaiXian');
INSERT INTO `area` VALUES ('450924', '兴业县', '', '450900', '537800', 'xyx', 'XingYeXian');
INSERT INTO `area` VALUES ('450981', '北流市', '', '450900', '537400', 'bls', 'BeiLiuShi');
INSERT INTO `area` VALUES ('450982', '其它区', '', '450900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('451000', '百色市', '', '450000', '533000', 'bss', 'BaiSeShi');
INSERT INTO `area` VALUES ('451002', '右江区', '', '451000', '533000', 'yjq', 'YouJiangQu');
INSERT INTO `area` VALUES ('451021', '田阳县', '', '451000', '533600', 'tyx', 'TianYangXian');
INSERT INTO `area` VALUES ('451022', '田东县', '', '451000', '531500', 'tdx', 'TianDongXian');
INSERT INTO `area` VALUES ('451023', '平果县', '', '451000', '531400', 'pgx', 'PingGuoXian');
INSERT INTO `area` VALUES ('451024', '德保县', '', '451000', '533700', 'dbx', 'DeBaoXian');
INSERT INTO `area` VALUES ('451025', '靖西县', '', '451000', '533800', 'jxx', 'JingXiXian');
INSERT INTO `area` VALUES ('451026', '那坡县', '', '451000', '533900', 'npx', 'NaPoXian');
INSERT INTO `area` VALUES ('451027', '凌云县', '', '451000', '533100', 'lyx', 'LingYunXian');
INSERT INTO `area` VALUES ('451028', '乐业县', '', '451000', '533200', 'lyx', 'LeYeXian');
INSERT INTO `area` VALUES ('451029', '田林县', '', '451000', '533300', 'tlx', 'TianLinXian');
INSERT INTO `area` VALUES ('451030', '西林县', '', '451000', '533500', 'xlx', 'XiLinXian');
INSERT INTO `area` VALUES ('451031', '隆林各族自治县', '', '451000', '533400', 'llgzzzx', 'LongLinGeZuZiZhiXian');
INSERT INTO `area` VALUES ('451032', '其它区', '', '451000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('451100', '贺州市', '', '450000', '542800', 'hzs', 'HeZhouShi');
INSERT INTO `area` VALUES ('451102', '八步区', '', '451100', '542800', 'bbq', 'BaBuQu');
INSERT INTO `area` VALUES ('451121', '昭平县', '', '451100', '546800', 'zpx', 'ZhaoPingXian');
INSERT INTO `area` VALUES ('451122', '钟山县', '', '451100', '542600', 'zsx', 'ZhongShanXian');
INSERT INTO `area` VALUES ('451123', '富川瑶族自治县', '', '451100', '542700', 'fcyzzzx', 'FuChuanYaoZuZiZhiXian');
INSERT INTO `area` VALUES ('451124', '其它区', '', '451100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('451200', '河池市', '', '450000', '547000', 'hcs', 'HeChiShi');
INSERT INTO `area` VALUES ('451202', '金城江区', '', '451200', '547000', 'jcjq', 'JinChengJiangQu');
INSERT INTO `area` VALUES ('451221', '南丹县', '', '451200', '547200', 'ndx', 'NanDanXian');
INSERT INTO `area` VALUES ('451222', '天峨县', '', '451200', '547300', 'tex', 'TianEXian');
INSERT INTO `area` VALUES ('451223', '凤山县', '', '451200', '547600', 'fsx', 'FengShanXian');
INSERT INTO `area` VALUES ('451224', '东兰县', '', '451200', '547400', 'dlx', 'DongLanXian');
INSERT INTO `area` VALUES ('451225', '罗城仫佬族自治县', '', '451200', '546400', 'lcmlzzzx', 'LuoChengZuoLaoZuZiZhiXian');
INSERT INTO `area` VALUES ('451226', '环江毛南族自治县', '', '451200', '547100', 'hjmnzzzx', 'HuanJiangMaoNanZuZiZhiXian');
INSERT INTO `area` VALUES ('451227', '巴马瑶族自治县', '', '451200', '547500', 'bmyzzzx', 'BaMaYaoZuZiZhiXian');
INSERT INTO `area` VALUES ('451228', '都安瑶族自治县', '', '451200', '530700', 'dayzzzx', 'DuAnYaoZuZiZhiXian');
INSERT INTO `area` VALUES ('451229', '大化瑶族自治县', '', '451200', '530800', 'dhyzzzx', 'DaHuaYaoZuZiZhiXian');
INSERT INTO `area` VALUES ('451281', '宜州市', '', '451200', '546300', 'yzs', 'YiZhouShi');
INSERT INTO `area` VALUES ('451282', '其它区', '', '451200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('451300', '来宾市', '', '450000', '546100', 'lbs', 'LaiBinShi');
INSERT INTO `area` VALUES ('451302', '兴宾区', '', '451300', '546100', 'xbq', 'XingBinQu');
INSERT INTO `area` VALUES ('451321', '忻城县', '', '451300', '546200', 'xcx', 'XinChengXian');
INSERT INTO `area` VALUES ('451322', '象州县', '', '451300', '545800', 'xzx', 'XiangZhouXian');
INSERT INTO `area` VALUES ('451323', '武宣县', '', '451300', '545900', 'wxx', 'WuXuanXian');
INSERT INTO `area` VALUES ('451324', '金秀瑶族自治县', '', '451300', '545700', 'jxyzzzx', 'JinXiuYaoZuZiZhiXian');
INSERT INTO `area` VALUES ('451381', '合山市', '', '451300', '546500', 'hss', 'HeShanShi');
INSERT INTO `area` VALUES ('451382', '其它区', '', '451300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('451400', '崇左市', '', '450000', '532200', 'czs', 'ChongZuoShi');
INSERT INTO `area` VALUES ('451402', '江州区', '', '451400', '532200', 'jzq', 'JiangZhouQu');
INSERT INTO `area` VALUES ('451421', '扶绥县', '', '451400', '532100', 'fsx', 'FuSuiXian');
INSERT INTO `area` VALUES ('451422', '宁明县', '', '451400', '532500', 'nmx', 'NingMingXian');
INSERT INTO `area` VALUES ('451423', '龙州县', '', '451400', '532400', 'lzx', 'LongZhouXian');
INSERT INTO `area` VALUES ('451424', '大新县', '', '451400', '532300', 'dxx', 'DaXinXian');
INSERT INTO `area` VALUES ('451425', '天等县', '', '451400', '532800', 'tdx', 'TianDengXian');
INSERT INTO `area` VALUES ('451481', '凭祥市', '', '451400', '532600', 'pxs', 'PingXiangShi');
INSERT INTO `area` VALUES ('451482', '其它区', '', '451400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('460000', '海南省', '', '1', '', 'hns', 'HaiNanSheng');
INSERT INTO `area` VALUES ('460100', '海口市', '', '460000', '570000', 'hks', 'HaiKouShi');
INSERT INTO `area` VALUES ('460105', '秀英区', '', '460100', '570311', 'xyq', 'XiuYingQu');
INSERT INTO `area` VALUES ('460106', '龙华区', '', '460100', '570105', 'lhq', 'LongHuaQu');
INSERT INTO `area` VALUES ('460107', '琼山区', '', '460100', '571100', 'qsq', 'QiongShanQu');
INSERT INTO `area` VALUES ('460108', '美兰区', '', '460100', '570203', 'mlq', 'MeiLanQu');
INSERT INTO `area` VALUES ('460109', '其它区', '', '460100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('460200', '三亚市', '', '460000', '572000', 'sys', 'SanYaShi');
INSERT INTO `area` VALUES ('469001', '五指山市', '', '460000', '572200', 'wzss', 'WuZhiShanShi');
INSERT INTO `area` VALUES ('469002', '琼海市', '', '460000', '571400', 'qhs', 'QiongHaiShi');
INSERT INTO `area` VALUES ('469003', '儋州市', '', '460000', '571700', 'dzs', 'ZuoZhouShi');
INSERT INTO `area` VALUES ('469005', '文昌市', '', '460000', '571300', 'wcs', 'WenChangShi');
INSERT INTO `area` VALUES ('469006', '万宁市', '', '460000', '571500', 'wns', 'WanNingShi');
INSERT INTO `area` VALUES ('469007', '东方市', '', '460000', '572600', 'dfs', 'DongFangShi');
INSERT INTO `area` VALUES ('469025', '定安县', '', '460000', '571200', 'dax', 'DingAnXian');
INSERT INTO `area` VALUES ('469026', '屯昌县', '', '460000', '571600', 'tcx', 'TunChangXian');
INSERT INTO `area` VALUES ('469027', '澄迈县', '', '460000', '571900', 'cmx', 'ChengMaiXian');
INSERT INTO `area` VALUES ('469028', '临高县', '', '460000', '571800', 'lgx', 'LinGaoXian');
INSERT INTO `area` VALUES ('469030', '白沙黎族自治县', '', '460000', '572800', 'bslzzzx', 'BaiShaLiZuZiZhiXian');
INSERT INTO `area` VALUES ('469031', '昌江黎族自治县', '', '460000', '572700', 'cjlzzzx', 'ChangJiangLiZuZiZhiXian');
INSERT INTO `area` VALUES ('469033', '乐东黎族自治县', '', '460000', '572500', 'ldlzzzx', 'LeDongLiZuZiZhiXian');
INSERT INTO `area` VALUES ('469034', '陵水黎族自治县', '', '460000', '572400', 'lslzzzx', 'LingShuiLiZuZiZhiXian');
INSERT INTO `area` VALUES ('469035', '保亭黎族苗族自治县', '', '460000', '572300', 'btlzmzzzx', 'BaoTingLiZuMiaoZuZiZhiXian');
INSERT INTO `area` VALUES ('469036', '琼中黎族苗族自治县', '', '460000', '572900', 'qzlzmzzzx', 'QiongZhongLiZuMiaoZuZiZhiXian');
INSERT INTO `area` VALUES ('469037', '西沙群岛', '', '460000', '573100', 'xsqd', 'XiShaQunDao');
INSERT INTO `area` VALUES ('469038', '南沙群岛', '', '460000', '573100', 'nsqd', 'NanShaQunDao');
INSERT INTO `area` VALUES ('469039', '中沙群岛的岛礁及其海域', '', '460000', '573100', 'zsqdddjjqhy', 'ZhongShaQunDaoDeDaoJiaoJiQiHai');
INSERT INTO `area` VALUES ('471004', '高新区', '', '410300', '', 'gxq', 'GaoXinQu');
INSERT INTO `area` VALUES ('471005', '其它区', '', '410300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('500000', '重庆', '', '1', '', 'cq', 'chongQing');
INSERT INTO `area` VALUES ('500100', '重庆市', '', '500000', '400000', 'cqs', 'chongQingShi');
INSERT INTO `area` VALUES ('500101', '万州区', '', '500100', '404000', 'wzq', 'WanZhouQu');
INSERT INTO `area` VALUES ('500102', '涪陵区', '', '500100', '408000', 'flq', 'FuLingQu');
INSERT INTO `area` VALUES ('500103', '渝中区', '', '500100', '400012', 'yzq', 'YuZhongQu');
INSERT INTO `area` VALUES ('500104', '大渡口区', '', '500100', '400084', 'ddkq', 'DaDuKouQu');
INSERT INTO `area` VALUES ('500105', '江北区', '', '500100', '400021', 'jbq', 'JiangBeiQu');
INSERT INTO `area` VALUES ('500106', '沙坪坝区', '', '500100', '400020', 'spbq', 'ShaPingBaQu');
INSERT INTO `area` VALUES ('500107', '九龙坡区', '', '500100', '400039', 'jlpq', 'JiuLongPoQu');
INSERT INTO `area` VALUES ('500108', '南岸区', '', '500100', '400060', 'naq', 'NanAnQu');
INSERT INTO `area` VALUES ('500109', '北碚区', '', '500100', '400700', 'bbq', 'BeiZuoQu');
INSERT INTO `area` VALUES ('500110', '万盛区', '', '500100', '400800', 'wsq', 'WanShengQu');
INSERT INTO `area` VALUES ('500111', '双桥区', '', '500100', '400900', 'sqq', 'ShuangQiaoQu');
INSERT INTO `area` VALUES ('500112', '渝北区', '', '500100', '401120', 'ybq', 'YuBeiQu');
INSERT INTO `area` VALUES ('500113', '巴南区', '', '500100', '401320', 'bnq', 'BaNanQu');
INSERT INTO `area` VALUES ('500114', '黔江区', '', '500100', '409700', 'qjq', 'QianJiangQu');
INSERT INTO `area` VALUES ('500115', '长寿区', '', '500100', '401220', 'csq', 'ChangShouQu');
INSERT INTO `area` VALUES ('500222', '綦江县', '', '500100', '401420', 'qjx', 'ZuoJiangXian');
INSERT INTO `area` VALUES ('500223', '潼南县', '', '500100', '402660', 'tnx', 'ZuoNanXian');
INSERT INTO `area` VALUES ('500224', '铜梁县', '', '500100', '402560', 'tlx', 'TongLiangXian');
INSERT INTO `area` VALUES ('500225', '大足县', '', '500100', '402360', 'dzx', 'DaZuXian');
INSERT INTO `area` VALUES ('500226', '荣昌县', '', '500100', '402460', 'rcx', 'RongChangXian');
INSERT INTO `area` VALUES ('500227', '璧山县', '', '500100', '402760', 'bsx', 'ZuoShanXian');
INSERT INTO `area` VALUES ('500228', '梁平县', '', '500100', '405200', 'lpx', 'LiangPingXian');
INSERT INTO `area` VALUES ('500229', '城口县', '', '500100', '405900', 'ckx', 'ChengKouXian');
INSERT INTO `area` VALUES ('500230', '丰都县', '', '500100', '408200', 'fdx', 'FengDuXian');
INSERT INTO `area` VALUES ('500231', '垫江县', '', '500100', '408300', 'djx', 'DianJiangXian');
INSERT INTO `area` VALUES ('500232', '武隆县', '', '500100', '408500', 'wlx', 'WuLongXian');
INSERT INTO `area` VALUES ('500233', '忠县', '', '500100', '404300', 'zx', 'ZhongXian');
INSERT INTO `area` VALUES ('500234', '开县', '', '500100', '405400', 'kx', 'KaiXian');
INSERT INTO `area` VALUES ('500235', '云阳县', '', '500100', '404500', 'yyx', 'YunYangXian');
INSERT INTO `area` VALUES ('500236', '奉节县', '', '500100', '404600', 'fjx', 'FengJieXian');
INSERT INTO `area` VALUES ('500237', '巫山县', '', '500100', '404700', 'wsx', 'WuShanXian');
INSERT INTO `area` VALUES ('500238', '巫溪县', '', '500100', '405800', 'wxx', 'WuXiXian');
INSERT INTO `area` VALUES ('500240', '石柱土家族自治县', '', '500100', '409100', 'sztjzzzx', 'ShiZhuTuJiaZuZiZhiXian');
INSERT INTO `area` VALUES ('500241', '秀山土家族苗族自治县', '', '500100', '409900', 'xstjzmzzzx', 'XiuShanTuJiaZuMiaoZuZiZhiXian');
INSERT INTO `area` VALUES ('500242', '酉阳土家族苗族自治县', '', '500100', '409800', 'yytjzmzzzx', 'YouYangTuJiaZuMiaoZuZiZhiXian');
INSERT INTO `area` VALUES ('500243', '彭水苗族土家族自治县', '', '500100', '409600', 'psmztjzzzx', 'PengShuiMiaoZuTuJiaZuZiZhiXian');
INSERT INTO `area` VALUES ('500381', '江津区', '', '500100', '402260', 'jjq', 'JiangJinQu');
INSERT INTO `area` VALUES ('500382', '合川区', '', '500100', '401520', 'hcq', 'HeChuanQu');
INSERT INTO `area` VALUES ('500383', '永川区', '', '500100', '402160', 'ycq', 'YongChuanQu');
INSERT INTO `area` VALUES ('500384', '南川区', '', '500100', '408400', 'ncq', 'NanChuanQu');
INSERT INTO `area` VALUES ('500385', '其它区', '', '500100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('510000', '四川省', '', '1', '', 'scs', 'SiChuanSheng');
INSERT INTO `area` VALUES ('510100', '成都市', '', '510000', '610000', 'cds', 'ChengDuShi');
INSERT INTO `area` VALUES ('510104', '锦江区', '', '510100', '610011', 'jjq', 'JinJiangQu');
INSERT INTO `area` VALUES ('510105', '青羊区', '', '510100', '610031', 'qyq', 'QingYangQu');
INSERT INTO `area` VALUES ('510106', '金牛区', '', '510100', '610036', 'jnq', 'JinNiuQu');
INSERT INTO `area` VALUES ('510107', '武侯区', '', '510100', '610041', 'whq', 'WuHouQu');
INSERT INTO `area` VALUES ('510108', '成华区', '', '510100', '610066', 'chq', 'ChengHuaQu');
INSERT INTO `area` VALUES ('510112', '龙泉驿区', '', '510100', '610100', 'lqyq', 'LongQuanZuoQu');
INSERT INTO `area` VALUES ('510113', '青白江区', '', '510100', '610300', 'qbjq', 'QingBaiJiangQu');
INSERT INTO `area` VALUES ('510114', '新都区', '', '510100', '610500', 'xdq', 'XinDuQu');
INSERT INTO `area` VALUES ('510115', '温江区', '', '510100', '611130', 'wjq', 'WenJiangQu');
INSERT INTO `area` VALUES ('510121', '金堂县', '', '510100', '610400', 'jtx', 'JinTangXian');
INSERT INTO `area` VALUES ('510122', '双流县', '', '510100', '610200', 'slx', 'ShuangLiuXian');
INSERT INTO `area` VALUES ('510124', '郫县', '', '510100', '611730', 'px', 'ZuoXian');
INSERT INTO `area` VALUES ('510129', '大邑县', '', '510100', '611330', 'dyx', 'DaYiXian');
INSERT INTO `area` VALUES ('510131', '蒲江县', '', '510100', '611630', 'pjx', 'PuJiangXian');
INSERT INTO `area` VALUES ('510132', '新津县', '', '510100', '611430', 'xjx', 'XinJinXian');
INSERT INTO `area` VALUES ('510181', '都江堰市', '', '510100', '611830', 'djys', 'DuJiangYanShi');
INSERT INTO `area` VALUES ('510182', '彭州市', '', '510100', '611930', 'pzs', 'PengZhouShi');
INSERT INTO `area` VALUES ('510183', '邛崃市', '', '510100', '611530', 'qls', 'ZuoZuoShi');
INSERT INTO `area` VALUES ('510184', '崇州市', '', '510100', '611230', 'czs', 'ChongZhouShi');
INSERT INTO `area` VALUES ('510185', '其它区', '', '510100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('510300', '自贡市', '', '510000', '643000', 'zgs', 'ZiGongShi');
INSERT INTO `area` VALUES ('510302', '自流井区', '', '510300', '643000', 'zljq', 'ZiLiuJingQu');
INSERT INTO `area` VALUES ('510303', '贡井区', '', '510300', '643020', 'gjq', 'GongJingQu');
INSERT INTO `area` VALUES ('510304', '大安区', '', '510300', '643010', 'daq', 'DaAnQu');
INSERT INTO `area` VALUES ('510311', '沿滩区', '', '510300', '643030', 'ytq', 'YanTanQu');
INSERT INTO `area` VALUES ('510321', '荣县', '', '510300', '643100', 'rx', 'RongXian');
INSERT INTO `area` VALUES ('510322', '富顺县', '', '510300', '643200', 'fsx', 'FuShunXian');
INSERT INTO `area` VALUES ('510323', '其它区', '', '510300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('510400', '攀枝花市', '', '510000', '617000', 'pzhs', 'PanZhiHuaShi');
INSERT INTO `area` VALUES ('510402', '东区', '', '510400', '617067', 'dq', 'DongQu');
INSERT INTO `area` VALUES ('510403', '西区', '', '510400', '617012', 'xq', 'XiQu');
INSERT INTO `area` VALUES ('510411', '仁和区', '', '510400', '617061', 'rhq', 'RenHeQu');
INSERT INTO `area` VALUES ('510421', '米易县', '', '510400', '617200', 'myx', 'MiYiXian');
INSERT INTO `area` VALUES ('510422', '盐边县', '', '510400', '617100', 'ybx', 'YanBianXian');
INSERT INTO `area` VALUES ('510423', '其它区', '', '510400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('510500', '泸州市', '', '510000', '646000', 'lzs', 'ZuoZhouShi');
INSERT INTO `area` VALUES ('510502', '江阳区', '', '510500', '646000', 'jyq', 'JiangYangQu');
INSERT INTO `area` VALUES ('510503', '纳溪区', '', '510500', '646300', 'nxq', 'NaXiQu');
INSERT INTO `area` VALUES ('510504', '龙马潭区', '', '510500', '646000', 'lmtq', 'LongMaTanQu');
INSERT INTO `area` VALUES ('510521', '泸县', '', '510500', '646100', 'lx', 'ZuoXian');
INSERT INTO `area` VALUES ('510522', '合江县', '', '510500', '646200', 'hjx', 'HeJiangXian');
INSERT INTO `area` VALUES ('510524', '叙永县', '', '510500', '646400', 'xyx', 'XuYongXian');
INSERT INTO `area` VALUES ('510525', '古蔺县', '', '510500', '646500', 'glx', 'GuZuoXian');
INSERT INTO `area` VALUES ('510526', '其它区', '', '510500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('510600', '德阳市', '', '510000', '618000', 'dys', 'DeYangShi');
INSERT INTO `area` VALUES ('510603', '旌阳区', '', '510600', '618000', 'jyq', 'ZuoYangQu');
INSERT INTO `area` VALUES ('510623', '中江县', '', '510600', '618300', 'zjx', 'ZhongJiangXian');
INSERT INTO `area` VALUES ('510626', '罗江县', '', '510600', '618500', 'ljx', 'LuoJiangXian');
INSERT INTO `area` VALUES ('510681', '广汉市', '', '510600', '618300', 'ghs', 'GuangHanShi');
INSERT INTO `area` VALUES ('510682', '什邡市', '', '510600', '618400', 'sfs', 'ShiZuoShi');
INSERT INTO `area` VALUES ('510683', '绵竹市', '', '510600', '618200', 'mzs', 'MianZhuShi');
INSERT INTO `area` VALUES ('510684', '其它区', '', '510600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('510700', '绵阳市', '', '510000', '621000', 'mys', 'MianYangShi');
INSERT INTO `area` VALUES ('510703', '涪城区', '', '510700', '621000', 'fcq', 'FuChengQu');
INSERT INTO `area` VALUES ('510704', '游仙区', '', '510700', '621022', 'yxq', 'YouXianQu');
INSERT INTO `area` VALUES ('510722', '三台县', '', '510700', '621100', 'stx', 'SanTaiXian');
INSERT INTO `area` VALUES ('510723', '盐亭县', '', '510700', '621600', 'ytx', 'YanTingXian');
INSERT INTO `area` VALUES ('510724', '安县', '', '510700', '622650', 'ax', 'AnXian');
INSERT INTO `area` VALUES ('510725', '梓潼县', '', '510700', '622150', 'ztx', 'ZuoZuoXian');
INSERT INTO `area` VALUES ('510726', '北川羌族自治县', '', '510700', '622750', 'bcqzzzx', 'BeiChuanQiangZuZiZhiXian');
INSERT INTO `area` VALUES ('510727', '平武县', '', '510700', '621550', 'pwx', 'PingWuXian');
INSERT INTO `area` VALUES ('510751', '高新区', '', '510700', '', 'gxq', 'GaoXinQu');
INSERT INTO `area` VALUES ('510781', '江油市', '', '510700', '621700', 'jys', 'JiangYouShi');
INSERT INTO `area` VALUES ('510782', '其它区', '', '510700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('510800', '广元市', '', '510000', '628000', 'gys', 'GuangYuanShi');
INSERT INTO `area` VALUES ('510802', '利州区', '', '510800', '628017', 'lzq', 'LiZhouQu');
INSERT INTO `area` VALUES ('510811', '元坝区', '', '510800', '628021', 'ybq', 'YuanBaQu');
INSERT INTO `area` VALUES ('510812', '朝天区', '', '510800', '628012', 'ctq', 'ChaoTianQu');
INSERT INTO `area` VALUES ('510821', '旺苍县', '', '510800', '628200', 'wcx', 'WangCangXian');
INSERT INTO `area` VALUES ('510822', '青川县', '', '510800', '628100', 'qcx', 'QingChuanXian');
INSERT INTO `area` VALUES ('510823', '剑阁县', '', '510800', '628300', 'jgx', 'JianGeXian');
INSERT INTO `area` VALUES ('510824', '苍溪县', '', '510800', '628400', 'cxx', 'CangXiXian');
INSERT INTO `area` VALUES ('510825', '其它区', '', '510800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('510900', '遂宁市', '', '510000', '629000', 'sns', 'SuiNingShi');
INSERT INTO `area` VALUES ('510903', '船山区', '', '510900', '629000', 'csq', 'ChuanShanQu');
INSERT INTO `area` VALUES ('510904', '安居区', '', '510900', '629000', 'ajq', 'AnJuQu');
INSERT INTO `area` VALUES ('510921', '蓬溪县', '', '510900', '629100', 'pxx', 'PengXiXian');
INSERT INTO `area` VALUES ('510922', '射洪县', '', '510900', '629200', 'shx', 'SheHongXian');
INSERT INTO `area` VALUES ('510923', '大英县', '', '510900', '629300', 'dyx', 'DaYingXian');
INSERT INTO `area` VALUES ('510924', '其它区', '', '510900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('511000', '内江市', '', '510000', '641000', 'njs', 'NeiJiangShi');
INSERT INTO `area` VALUES ('511002', '市中区', '', '511000', '641000', 'szq', 'ShiZhongQu');
INSERT INTO `area` VALUES ('511011', '东兴区', '', '511000', '641100', 'dxq', 'DongXingQu');
INSERT INTO `area` VALUES ('511024', '威远县', '', '511000', '642450', 'wyx', 'WeiYuanXian');
INSERT INTO `area` VALUES ('511025', '资中县', '', '511000', '641200', 'zzx', 'ZiZhongXian');
INSERT INTO `area` VALUES ('511028', '隆昌县', '', '511000', '642150', 'lcx', 'LongChangXian');
INSERT INTO `area` VALUES ('511029', '其它区', '', '511000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('511100', '乐山市', '', '510000', '614000', 'lss', 'LeShanShi');
INSERT INTO `area` VALUES ('511102', '市中区', '', '511100', '614000', 'szq', 'ShiZhongQu');
INSERT INTO `area` VALUES ('511111', '沙湾区', '', '511100', '614900', 'swq', 'ShaWanQu');
INSERT INTO `area` VALUES ('511112', '五通桥区', '', '511100', '614800', 'wtqq', 'WuTongQiaoQu');
INSERT INTO `area` VALUES ('511113', '金口河区', '', '511100', '614700', 'jkhq', 'JinKouHeQu');
INSERT INTO `area` VALUES ('511123', '犍为县', '', '511100', '614400', 'jwx', 'ZuoWeiXian');
INSERT INTO `area` VALUES ('511124', '井研县', '', '511100', '613100', 'jyx', 'JingYanXian');
INSERT INTO `area` VALUES ('511126', '夹江县', '', '511100', '614100', 'jjx', 'JiaJiangXian');
INSERT INTO `area` VALUES ('511129', '沐川县', '', '511100', '614500', 'mcx', 'ZuoChuanXian');
INSERT INTO `area` VALUES ('511132', '峨边彝族自治县', '', '511100', '614300', 'ebyzzzx', 'EBianYiZuZiZhiXian');
INSERT INTO `area` VALUES ('511133', '马边彝族自治县', '', '511100', '614600', 'mbyzzzx', 'MaBianYiZuZiZhiXian');
INSERT INTO `area` VALUES ('511181', '峨眉山市', '', '511100', '614200', 'emss', 'EMeiShanShi');
INSERT INTO `area` VALUES ('511182', '其它区', '', '511100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('511300', '南充市', '', '510000', '637000', 'ncs', 'NanChongShi');
INSERT INTO `area` VALUES ('511302', '顺庆区', '', '511300', '637500', 'sqq', 'ShunQingQu');
INSERT INTO `area` VALUES ('511303', '高坪区', '', '511300', '637100', 'gpq', 'GaoPingQu');
INSERT INTO `area` VALUES ('511304', '嘉陵区', '', '511300', '637900', 'jlq', 'JiaLingQu');
INSERT INTO `area` VALUES ('511321', '南部县', '', '511300', '637300', 'nbx', 'NanBuXian');
INSERT INTO `area` VALUES ('511322', '营山县', '', '511300', '638150', 'ysx', 'YingShanXian');
INSERT INTO `area` VALUES ('511323', '蓬安县', '', '511300', '638250', 'pax', 'PengAnXian');
INSERT INTO `area` VALUES ('511324', '仪陇县', '', '511300', '637600', 'ylx', 'YiLongXian');
INSERT INTO `area` VALUES ('511325', '西充县', '', '511300', '637200', 'xcx', 'XiChongXian');
INSERT INTO `area` VALUES ('511381', '阆中市', '', '511300', '637400', 'lzs', 'ZuoZhongShi');
INSERT INTO `area` VALUES ('511382', '其它区', '', '511300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('511400', '眉山市', '', '510000', '620000', 'mss', 'MeiShanShi');
INSERT INTO `area` VALUES ('511402', '东坡区', '', '511400', '620010', 'dpq', 'DongPoQu');
INSERT INTO `area` VALUES ('511421', '仁寿县', '', '511400', '620500', 'rsx', 'RenShouXian');
INSERT INTO `area` VALUES ('511422', '彭山县', '', '511400', '620860', 'psx', 'PengShanXian');
INSERT INTO `area` VALUES ('511423', '洪雅县', '', '511400', '620360', 'hyx', 'HongYaXian');
INSERT INTO `area` VALUES ('511424', '丹棱县', '', '511400', '620200', 'dlx', 'DanLengXian');
INSERT INTO `area` VALUES ('511425', '青神县', '', '511400', '620460', 'qsx', 'QingShenXian');
INSERT INTO `area` VALUES ('511426', '其它区', '', '511400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('511500', '宜宾市', '', '510000', '644000', 'ybs', 'YiBinShi');
INSERT INTO `area` VALUES ('511502', '翠屏区', '', '511500', '644000', 'cpq', 'CuiPingQu');
INSERT INTO `area` VALUES ('511521', '宜宾县', '', '511500', '644600', 'ybx', 'YiBinXian');
INSERT INTO `area` VALUES ('511522', '南溪县', '', '511500', '644100', 'nxx', 'NanXiXian');
INSERT INTO `area` VALUES ('511523', '江安县', '', '511500', '644200', 'jax', 'JiangAnXian');
INSERT INTO `area` VALUES ('511524', '长宁县', '', '511500', '644300', 'cnx', 'ChangNingXian');
INSERT INTO `area` VALUES ('511525', '高县', '', '511500', '645150', 'gx', 'GaoXian');
INSERT INTO `area` VALUES ('511526', '珙县', '', '511500', '644500', 'gx', 'ZuoXian');
INSERT INTO `area` VALUES ('511527', '筠连县', '', '511500', '645250', 'ylx', 'ZuoLianXian');
INSERT INTO `area` VALUES ('511528', '兴文县', '', '511500', '644400', 'xwx', 'XingWenXian');
INSERT INTO `area` VALUES ('511529', '屏山县', '', '511500', '645350', 'psx', 'PingShanXian');
INSERT INTO `area` VALUES ('511530', '其它区', '', '511500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('511600', '广安市', '', '510000', '638000', 'gas', 'GuangAnShi');
INSERT INTO `area` VALUES ('511602', '广安区', '', '511600', '638550', 'gaq', 'GuangAnQu');
INSERT INTO `area` VALUES ('511621', '岳池县', '', '511600', '638300', 'ycx', 'YueChiXian');
INSERT INTO `area` VALUES ('511622', '武胜县', '', '511600', '638420', 'wsx', 'WuShengXian');
INSERT INTO `area` VALUES ('511623', '邻水县', '', '511600', '638520', 'lsx', 'LinShuiXian');
INSERT INTO `area` VALUES ('511681', '华蓥市', '', '511600', '638650', 'hys', 'HuaZuoShi');
INSERT INTO `area` VALUES ('511682', '市辖区', '', '511600', '', 'sxq', 'ShiXiaQu');
INSERT INTO `area` VALUES ('511683', '其它区', '', '511600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('511700', '达州市', '', '510000', '635000', 'dzs', 'DaZhouShi');
INSERT INTO `area` VALUES ('511702', '通川区', '', '511700', '635000', 'tcq', 'TongChuanQu');
INSERT INTO `area` VALUES ('511721', '达县', '', '511700', '635006', 'dx', 'DaXian');
INSERT INTO `area` VALUES ('511722', '宣汉县', '', '511700', '636150', 'xhx', 'XuanHanXian');
INSERT INTO `area` VALUES ('511723', '开江县', '', '511700', '636250', 'kjx', 'KaiJiangXian');
INSERT INTO `area` VALUES ('511724', '大竹县', '', '511700', '635100', 'dzx', 'DaZhuXian');
INSERT INTO `area` VALUES ('511725', '渠县', '', '511700', '635200', 'qx', 'QuXian');
INSERT INTO `area` VALUES ('511781', '万源市', '', '511700', '636350', 'wys', 'WanYuanShi');
INSERT INTO `area` VALUES ('511782', '其它区', '', '511700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('511800', '雅安市', '', '510000', '625000', 'yas', 'YaAnShi');
INSERT INTO `area` VALUES ('511802', '雨城区', '', '511800', '625000', 'ycq', 'YuChengQu');
INSERT INTO `area` VALUES ('511821', '名山县', '', '511800', '625100', 'msx', 'MingShanXian');
INSERT INTO `area` VALUES ('511822', '荥经县', '', '511800', '625200', 'xjx', 'ZuoJingXian');
INSERT INTO `area` VALUES ('511823', '汉源县', '', '511800', '625300', 'hyx', 'HanYuanXian');
INSERT INTO `area` VALUES ('511824', '石棉县', '', '511800', '625400', 'smx', 'ShiMianXian');
INSERT INTO `area` VALUES ('511825', '天全县', '', '511800', '625500', 'tqx', 'TianQuanXian');
INSERT INTO `area` VALUES ('511826', '芦山县', '', '511800', '625600', 'lsx', 'LuShanXian');
INSERT INTO `area` VALUES ('511827', '宝兴县', '', '511800', '625700', 'bxx', 'BaoXingXian');
INSERT INTO `area` VALUES ('511828', '其它区', '', '511800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('511900', '巴中市', '', '510000', '636000', 'bzs', 'BaZhongShi');
INSERT INTO `area` VALUES ('511902', '巴州区', '', '511900', '636601', 'bzq', 'BaZhouQu');
INSERT INTO `area` VALUES ('511921', '通江县', '', '511900', '636700', 'tjx', 'TongJiangXian');
INSERT INTO `area` VALUES ('511922', '南江县', '', '511900', '636600', 'njx', 'NanJiangXian');
INSERT INTO `area` VALUES ('511923', '平昌县', '', '511900', '636400', 'pcx', 'PingChangXian');
INSERT INTO `area` VALUES ('511924', '其它区', '', '511900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('512000', '资阳市', '', '510000', '641300', 'zys', 'ZiYangShi');
INSERT INTO `area` VALUES ('512002', '雁江区', '', '512000', '641300', 'yjq', 'YanJiangQu');
INSERT INTO `area` VALUES ('512021', '安岳县', '', '512000', '642350', 'ayx', 'AnYueXian');
INSERT INTO `area` VALUES ('512022', '乐至县', '', '512000', '641500', 'lzx', 'LeZhiXian');
INSERT INTO `area` VALUES ('512081', '简阳市', '', '512000', '641400', 'jys', 'JianYangShi');
INSERT INTO `area` VALUES ('512082', '其它区', '', '512000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('513200', '阿坝藏族羌族自治州', '', '510000', '', 'abzzqzzzz', 'ABaZangZuQiangZuZiZhiZhou');
INSERT INTO `area` VALUES ('513221', '汶川县', '', '513200', '623000', 'wcx', 'ZuoChuanXian');
INSERT INTO `area` VALUES ('513222', '理县', '', '513200', '632100', 'lx', 'LiXian');
INSERT INTO `area` VALUES ('513223', '茂县', '', '513200', '623200', 'mx', 'MaoXian');
INSERT INTO `area` VALUES ('513224', '松潘县', '', '513200', '623300', 'spx', 'SongPanXian');
INSERT INTO `area` VALUES ('513225', '九寨沟县', '', '513200', '623400', 'jzgx', 'JiuZhaiGouXian');
INSERT INTO `area` VALUES ('513226', '金川县', '', '513200', '624100', 'jcx', 'JinChuanXian');
INSERT INTO `area` VALUES ('513227', '小金县', '', '513200', '624200', 'xjx', 'XiaoJinXian');
INSERT INTO `area` VALUES ('513228', '黑水县', '', '513200', '623500', 'hsx', 'HeiShuiXian');
INSERT INTO `area` VALUES ('513229', '马尔康县', '', '513200', '624000', 'mekx', 'MaErKangXian');
INSERT INTO `area` VALUES ('513230', '壤塘县', '', '513200', '624300', 'rtx', 'RangTangXian');
INSERT INTO `area` VALUES ('513231', '阿坝县', '', '513200', '624600', 'abx', 'ABaXian');
INSERT INTO `area` VALUES ('513232', '若尔盖县', '', '513200', '624500', 'regx', 'RuoErGaiXian');
INSERT INTO `area` VALUES ('513233', '红原县', '', '513200', '624400', 'hyx', 'HongYuanXian');
INSERT INTO `area` VALUES ('513234', '其它区', '', '513200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('513300', '甘孜藏族自治州', '', '510000', '', 'gzzzzzz', 'GanZiZangZuZiZhiZhou');
INSERT INTO `area` VALUES ('513321', '康定县', '', '513300', '626000', 'kdx', 'KangDingXian');
INSERT INTO `area` VALUES ('513322', '泸定县', '', '513300', '626100', 'ldx', 'ZuoDingXian');
INSERT INTO `area` VALUES ('513323', '丹巴县', '', '513300', '626300', 'dbx', 'DanBaXian');
INSERT INTO `area` VALUES ('513324', '九龙县', '', '513300', '626200', 'jlx', 'JiuLongXian');
INSERT INTO `area` VALUES ('513325', '雅江县', '', '513300', '627450', 'yjx', 'YaJiangXian');
INSERT INTO `area` VALUES ('513326', '道孚县', '', '513300', '626400', 'dfx', 'DaoZuoXian');
INSERT INTO `area` VALUES ('513327', '炉霍县', '', '513300', '626500', 'lhx', 'LuHuoXian');
INSERT INTO `area` VALUES ('513328', '甘孜县', '', '513300', '626700', 'gzx', 'GanZiXian');
INSERT INTO `area` VALUES ('513329', '新龙县', '', '513300', '626800', 'xlx', 'XinLongXian');
INSERT INTO `area` VALUES ('513330', '德格县', '', '513300', '627250', 'dgx', 'DeGeXian');
INSERT INTO `area` VALUES ('513331', '白玉县', '', '513300', '627150', 'byx', 'BaiYuXian');
INSERT INTO `area` VALUES ('513332', '石渠县', '', '513300', '627350', 'sqx', 'ShiQuXian');
INSERT INTO `area` VALUES ('513333', '色达县', '', '513300', '626600', 'sdx', 'SeDaXian');
INSERT INTO `area` VALUES ('513334', '理塘县', '', '513300', '627550', 'ltx', 'LiTangXian');
INSERT INTO `area` VALUES ('513335', '巴塘县', '', '513300', '627650', 'btx', 'BaTangXian');
INSERT INTO `area` VALUES ('513336', '乡城县', '', '513300', '627850', 'xcx', 'XiangChengXian');
INSERT INTO `area` VALUES ('513337', '稻城县', '', '513300', '627750', 'dcx', 'DaoChengXian');
INSERT INTO `area` VALUES ('513338', '得荣县', '', '513300', '627950', 'drx', 'DeRongXian');
INSERT INTO `area` VALUES ('513339', '其它区', '', '513300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('513400', '凉山彝族自治州', '', '510000', '', 'lsyzzzz', 'LiangShanYiZuZiZhiZhou');
INSERT INTO `area` VALUES ('513401', '西昌市', '', '513400', '615000', 'xcs', 'XiChangShi');
INSERT INTO `area` VALUES ('513422', '木里藏族自治县', '', '513400', '615800', 'mlzzzzx', 'MuLiZangZuZiZhiXian');
INSERT INTO `area` VALUES ('513423', '盐源县', '', '513400', '615700', 'yyx', 'YanYuanXian');
INSERT INTO `area` VALUES ('513424', '德昌县', '', '513400', '615500', 'dcx', 'DeChangXian');
INSERT INTO `area` VALUES ('513425', '会理县', '', '513400', '615100', 'hlx', 'HuiLiXian');
INSERT INTO `area` VALUES ('513426', '会东县', '', '513400', '615200', 'hdx', 'HuiDongXian');
INSERT INTO `area` VALUES ('513427', '宁南县', '', '513400', '615400', 'nnx', 'NingNanXian');
INSERT INTO `area` VALUES ('513428', '普格县', '', '513400', '615300', 'pgx', 'PuGeXian');
INSERT INTO `area` VALUES ('513429', '布拖县', '', '513400', '616350', 'btx', 'BuTuoXian');
INSERT INTO `area` VALUES ('513430', '金阳县', '', '513400', '616250', 'jyx', 'JinYangXian');
INSERT INTO `area` VALUES ('513431', '昭觉县', '', '513400', '616150', 'zjx', 'ZhaoJueXian');
INSERT INTO `area` VALUES ('513432', '喜德县', '', '513400', '616750', 'xdx', 'XiDeXian');
INSERT INTO `area` VALUES ('513433', '冕宁县', '', '513400', '615600', 'mnx', 'MianNingXian');
INSERT INTO `area` VALUES ('513434', '越西县', '', '513400', '616650', 'yxx', 'YueXiXian');
INSERT INTO `area` VALUES ('513435', '甘洛县', '', '513400', '616850', 'glx', 'GanLuoXian');
INSERT INTO `area` VALUES ('513436', '美姑县', '', '513400', '616450', 'mgx', 'MeiGuXian');
INSERT INTO `area` VALUES ('513437', '雷波县', '', '513400', '616550', 'lbx', 'LeiBoXian');
INSERT INTO `area` VALUES ('513438', '其它区', '', '513400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('520000', '贵州省', '', '1', '', 'gzs', 'GuiZhouSheng');
INSERT INTO `area` VALUES ('520100', '贵阳市', '', '520000', '550000', 'gys', 'GuiYangShi');
INSERT INTO `area` VALUES ('520102', '南明区', '', '520100', '550002', 'nmq', 'NanMingQu');
INSERT INTO `area` VALUES ('520103', '云岩区', '', '520100', '550001', 'yyq', 'YunYanQu');
INSERT INTO `area` VALUES ('520111', '花溪区', '', '520100', '550025', 'hxq', 'HuaXiQu');
INSERT INTO `area` VALUES ('520112', '乌当区', '', '520100', '550018', 'wdq', 'WuDangQu');
INSERT INTO `area` VALUES ('520113', '白云区', '', '520100', '550014', 'byq', 'BaiYunQu');
INSERT INTO `area` VALUES ('520114', '小河区', '', '520100', '550009', 'xhq', 'XiaoHeQu');
INSERT INTO `area` VALUES ('520121', '开阳县', '', '520100', '550300', 'kyx', 'KaiYangXian');
INSERT INTO `area` VALUES ('520122', '息烽县', '', '520100', '551100', 'xfx', 'XiFengXian');
INSERT INTO `area` VALUES ('520123', '修文县', '', '520100', '550200', 'xwx', 'XiuWenXian');
INSERT INTO `area` VALUES ('520151', '金阳开发区', '', '520100', '', 'jykfq', 'JinYangKaiFaQu');
INSERT INTO `area` VALUES ('520181', '清镇市', '', '520100', '551400', 'qzs', 'QingZhenShi');
INSERT INTO `area` VALUES ('520182', '其它区', '', '520100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('520200', '六盘水市', '', '520000', '553000', 'lpss', 'LiuPanShuiShi');
INSERT INTO `area` VALUES ('520201', '钟山区', '', '520200', '553000', 'zsq', 'ZhongShanQu');
INSERT INTO `area` VALUES ('520203', '六枝特区', '', '520200', '553400', 'lztq', 'LiuZhiTeQu');
INSERT INTO `area` VALUES ('520221', '水城县', '', '520200', '553600', 'scx', 'ShuiChengXian');
INSERT INTO `area` VALUES ('520222', '盘县', '', '520200', '561601', 'px', 'PanXian');
INSERT INTO `area` VALUES ('520223', '其它区', '', '520200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('520300', '遵义市', '', '520000', '563000', 'zys', 'ZunYiShi');
INSERT INTO `area` VALUES ('520302', '红花岗区', '', '520300', '563000', 'hhgq', 'HongHuaGangQu');
INSERT INTO `area` VALUES ('520303', '汇川区', '', '520300', '563000', 'hcq', 'HuiChuanQu');
INSERT INTO `area` VALUES ('520321', '遵义县', '', '520300', '563100', 'zyx', 'ZunYiXian');
INSERT INTO `area` VALUES ('520322', '桐梓县', '', '520300', '563200', 'tzx', 'TongZuoXian');
INSERT INTO `area` VALUES ('520323', '绥阳县', '', '520300', '563300', 'syx', 'SuiYangXian');
INSERT INTO `area` VALUES ('520324', '正安县', '', '520300', '563400', 'zax', 'ZhengAnXian');
INSERT INTO `area` VALUES ('520325', '道真仡佬族苗族自治县', '', '520300', '563500', 'dzylzmzzzx', 'DaoZhenZuoLaoZuMiaoZuZiZhiXian');
INSERT INTO `area` VALUES ('520326', '务川仡佬族苗族自治县', '', '520300', '564300', 'wcylzmzzzx', 'WuChuanZuoLaoZuMiaoZuZiZhiXian');
INSERT INTO `area` VALUES ('520327', '凤冈县', '', '520300', '564200', 'fgx', 'FengGangXian');
INSERT INTO `area` VALUES ('520328', '湄潭县', '', '520300', '564100', 'mtx', 'ZuoTanXian');
INSERT INTO `area` VALUES ('520329', '余庆县', '', '520300', '564400', 'yqx', 'YuQingXian');
INSERT INTO `area` VALUES ('520330', '习水县', '', '520300', '564600', 'xsx', 'XiShuiXian');
INSERT INTO `area` VALUES ('520381', '赤水市', '', '520300', '564700', 'css', 'ChiShuiShi');
INSERT INTO `area` VALUES ('520382', '仁怀市', '', '520300', '564500', 'rhs', 'RenHuaiShi');
INSERT INTO `area` VALUES ('520383', '其它区', '', '520300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('520400', '安顺市', '', '520000', '561000', 'ass', 'AnShunShi');
INSERT INTO `area` VALUES ('520402', '西秀区', '', '520400', '561000', 'xxq', 'XiXiuQu');
INSERT INTO `area` VALUES ('520421', '平坝县', '', '520400', '561100', 'pbx', 'PingBaXian');
INSERT INTO `area` VALUES ('520422', '普定县', '', '520400', '562100', 'pdx', 'PuDingXian');
INSERT INTO `area` VALUES ('520423', '镇宁布依族苗族自治县', '', '520400', '561200', 'znbyzmzzzx', 'ZhenNingBuYiZuMiaoZuZiZhiXian');
INSERT INTO `area` VALUES ('520424', '关岭布依族苗族自治县', '', '520400', '561300', 'glbyzmzzzx', 'GuanLingBuYiZuMiaoZuZiZhiXian');
INSERT INTO `area` VALUES ('520425', '紫云苗族布依族自治县', '', '520400', '550800', 'zymzbyzzzx', 'ZiYunMiaoZuBuYiZuZiZhiXian');
INSERT INTO `area` VALUES ('520426', '其它区', '', '520400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('522200', '铜仁地区', '', '520000', '', 'trdq', 'TongRenDiQu');
INSERT INTO `area` VALUES ('522201', '铜仁市', '', '522200', '554300', 'trs', 'TongRenShi');
INSERT INTO `area` VALUES ('522222', '江口县', '', '522200', '554400', 'jkx', 'JiangKouXian');
INSERT INTO `area` VALUES ('522223', '玉屏侗族自治县', '', '522200', '554000', 'ypdzzzx', 'YuPingDongZuZiZhiXian');
INSERT INTO `area` VALUES ('522224', '石阡县', '', '522200', '555100', 'sqx', 'ShiZuoXian');
INSERT INTO `area` VALUES ('522225', '思南县', '', '522200', '565100', 'snx', 'SiNanXian');
INSERT INTO `area` VALUES ('522226', '印江土家族苗族自治县', '', '522200', '555200', 'yjtjzmzzzx', 'YinJiangTuJiaZuMiaoZuZiZhiXian');
INSERT INTO `area` VALUES ('522227', '德江县', '', '522200', '565200', 'djx', 'DeJiangXian');
INSERT INTO `area` VALUES ('522228', '沿河土家族自治县', '', '522200', '565300', 'yhtjzzzx', 'YanHeTuJiaZuZiZhiXian');
INSERT INTO `area` VALUES ('522229', '松桃苗族自治县', '', '522200', '554100', 'stmzzzx', 'SongTaoMiaoZuZiZhiXian');
INSERT INTO `area` VALUES ('522230', '万山特区', '', '522200', '554200', 'wstq', 'WanShanTeQu');
INSERT INTO `area` VALUES ('522231', '其它区', '', '522200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('522300', '黔西南布依族苗族自治州', '', '520000', '', 'qxnbyzmzzzz', 'QianXiNanBuYiZuMiaoZuZiZhi');
INSERT INTO `area` VALUES ('522301', '兴义市', '', '522300', '562400', 'xys', 'XingYiShi');
INSERT INTO `area` VALUES ('522322', '兴仁县', '', '522300', '562300', 'xrx', 'XingRenXian');
INSERT INTO `area` VALUES ('522323', '普安县', '', '522300', '561500', 'pax', 'PuAnXian');
INSERT INTO `area` VALUES ('522324', '晴隆县', '', '522300', '561400', 'qlx', 'QingLongXian');
INSERT INTO `area` VALUES ('522325', '贞丰县', '', '522300', '562200', 'zfx', 'ZhenFengXian');
INSERT INTO `area` VALUES ('522326', '望谟县', '', '522300', '552300', 'wmx', 'WangZuoXian');
INSERT INTO `area` VALUES ('522327', '册亨县', '', '522300', '552200', 'chx', 'CeHengXian');
INSERT INTO `area` VALUES ('522328', '安龙县', '', '522300', '552400', 'alx', 'AnLongXian');
INSERT INTO `area` VALUES ('522329', '其它区', '', '522300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('522400', '毕节地区', '', '520000', '', 'bjdq', 'BiJieDiQu');
INSERT INTO `area` VALUES ('522401', '毕节市', '', '522400', '551700', 'bjs', 'BiJieShi');
INSERT INTO `area` VALUES ('522422', '大方县', '', '522400', '551600', 'dfx', 'DaFangXian');
INSERT INTO `area` VALUES ('522423', '黔西县', '', '522400', '551500', 'qxx', 'QianXiXian');
INSERT INTO `area` VALUES ('522424', '金沙县', '', '522400', '551800', 'jsx', 'JinShaXian');
INSERT INTO `area` VALUES ('522425', '织金县', '', '522400', '552100', 'zjx', 'ZhiJinXian');
INSERT INTO `area` VALUES ('522426', '纳雍县', '', '522400', '553300', 'nyx', 'NaYongXian');
INSERT INTO `area` VALUES ('522427', '威宁彝族回族苗族自治县', '', '522400', '553100', 'wnyzhzmzzzx', 'WeiNingYiZuHuiZuMiaoZuZiZhi');
INSERT INTO `area` VALUES ('522428', '赫章县', '', '522400', '553200', 'hzx', 'HeZhangXian');
INSERT INTO `area` VALUES ('522429', '其它区', '', '522400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('522600', '黔东南苗族侗族自治州', '', '520000', '', 'qdnmzdzzzz', 'QianDongNanMiaoZuDongZuZiZhiZhou');
INSERT INTO `area` VALUES ('522601', '凯里市', '', '522600', '556000', 'kls', 'KaiLiShi');
INSERT INTO `area` VALUES ('522622', '黄平县', '', '522600', '556100', 'hpx', 'HuangPingXian');
INSERT INTO `area` VALUES ('522623', '施秉县', '', '522600', '556200', 'sbx', 'ShiBingXian');
INSERT INTO `area` VALUES ('522624', '三穗县', '', '522600', '556500', 'ssx', 'SanSuiXian');
INSERT INTO `area` VALUES ('522625', '镇远县', '', '522600', '557700', 'zyx', 'ZhenYuanXian');
INSERT INTO `area` VALUES ('522626', '岑巩县', '', '522600', '557800', 'cgx', 'ZuoGongXian');
INSERT INTO `area` VALUES ('522627', '天柱县', '', '522600', '556600', 'tzx', 'TianZhuXian');
INSERT INTO `area` VALUES ('522628', '锦屏县', '', '522600', '556700', 'jpx', 'JinPingXian');
INSERT INTO `area` VALUES ('522629', '剑河县', '', '522600', '556400', 'jhx', 'JianHeXian');
INSERT INTO `area` VALUES ('522630', '台江县', '', '522600', '556300', 'tjx', 'TaiJiangXian');
INSERT INTO `area` VALUES ('522631', '黎平县', '', '522600', '557300', 'lpx', 'LiPingXian');
INSERT INTO `area` VALUES ('522632', '榕江县', '', '522600', '557200', 'rjx', 'ZuoJiangXian');
INSERT INTO `area` VALUES ('522633', '从江县', '', '522600', '557400', 'cjx', 'CongJiangXian');
INSERT INTO `area` VALUES ('522634', '雷山县', '', '522600', '557100', 'lsx', 'LeiShanXian');
INSERT INTO `area` VALUES ('522635', '麻江县', '', '522600', '557600', 'mjx', 'MaJiangXian');
INSERT INTO `area` VALUES ('522636', '丹寨县', '', '522600', '557500', 'dzx', 'DanZhaiXian');
INSERT INTO `area` VALUES ('522637', '其它区', '', '522600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('522700', '黔南布依族苗族自治州', '', '520000', '', 'qnbyzmzzzz', 'QianNanBuYiZuMiaoZuZiZhiZhou');
INSERT INTO `area` VALUES ('522701', '都匀市', '', '522700', '558000', 'dys', 'DuYunShi');
INSERT INTO `area` VALUES ('522702', '福泉市', '', '522700', '550500', 'fqs', 'FuQuanShi');
INSERT INTO `area` VALUES ('522722', '荔波县', '', '522700', '558400', 'lbx', 'LiBoXian');
INSERT INTO `area` VALUES ('522723', '贵定县', '', '522700', '551300', 'gdx', 'GuiDingXian');
INSERT INTO `area` VALUES ('522725', '瓮安县', '', '522700', '550400', 'wax', 'WengAnXian');
INSERT INTO `area` VALUES ('522726', '独山县', '', '522700', '558200', 'dsx', 'DuShanXian');
INSERT INTO `area` VALUES ('522727', '平塘县', '', '522700', '558300', 'ptx', 'PingTangXian');
INSERT INTO `area` VALUES ('522728', '罗甸县', '', '522700', '550100', 'ldx', 'LuoDianXian');
INSERT INTO `area` VALUES ('522729', '长顺县', '', '522700', '550700', 'csx', 'ChangShunXian');
INSERT INTO `area` VALUES ('522730', '龙里县', '', '522700', '551200', 'llx', 'LongLiXian');
INSERT INTO `area` VALUES ('522731', '惠水县', '', '522700', '550600', 'hsx', 'HuiShuiXian');
INSERT INTO `area` VALUES ('522732', '三都水族自治县', '', '522700', '558100', 'sdszzzx', 'SanDuShuiZuZiZhiXian');
INSERT INTO `area` VALUES ('522733', '其它区', '', '522700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('530000', '云南省', '', '1', '', 'yns', 'YunNanSheng');
INSERT INTO `area` VALUES ('530100', '昆明市', '', '530000', '650000', 'kms', 'KunMingShi');
INSERT INTO `area` VALUES ('530102', '五华区', '', '530100', '650032', 'whq', 'WuHuaQu');
INSERT INTO `area` VALUES ('530103', '盘龙区', '', '530100', '650051', 'plq', 'PanLongQu');
INSERT INTO `area` VALUES ('530111', '官渡区', '', '530100', '650220', 'gdq', 'GuanDuQu');
INSERT INTO `area` VALUES ('530112', '西山区', '', '530100', '650100', 'xsq', 'XiShanQu');
INSERT INTO `area` VALUES ('530113', '东川区', '', '530100', '654100', 'dcq', 'DongChuanQu');
INSERT INTO `area` VALUES ('530121', '呈贡县', '', '530100', '650500', 'cgx', 'ChengGongXian');
INSERT INTO `area` VALUES ('530122', '晋宁县', '', '530100', '650600', 'jnx', 'JinNingXian');
INSERT INTO `area` VALUES ('530124', '富民县', '', '530100', '650400', 'fmx', 'FuMinXian');
INSERT INTO `area` VALUES ('530125', '宜良县', '', '530100', '652100', 'ylx', 'YiLiangXian');
INSERT INTO `area` VALUES ('530126', '石林彝族自治县', '', '530100', '652200', 'slyzzzx', 'ShiLinYiZuZiZhiXian');
INSERT INTO `area` VALUES ('530127', '嵩明县', '', '530100', '651700', 'smx', 'ZuoMingXian');
INSERT INTO `area` VALUES ('530128', '禄劝彝族苗族自治县', '', '530100', '651500', 'lqyzmzzzx', 'LuQuanYiZuMiaoZuZiZhiXian');
INSERT INTO `area` VALUES ('530129', '寻甸回族彝族自治县', '', '530100', '655200', 'xdhzyzzzx', 'XunDianHuiZuYiZuZiZhiXian');
INSERT INTO `area` VALUES ('530181', '安宁市', '', '530100', '650300', 'ans', 'AnNingShi');
INSERT INTO `area` VALUES ('530182', '其它区', '', '530100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('530300', '曲靖市', '', '530000', '655000', 'qjs', 'QuJingShi');
INSERT INTO `area` VALUES ('530302', '麒麟区', '', '530300', '655000', 'qlq', 'ZuoZuoQu');
INSERT INTO `area` VALUES ('530321', '马龙县', '', '530300', '655100', 'mlx', 'MaLongXian');
INSERT INTO `area` VALUES ('530322', '陆良县', '', '530300', '655600', 'llx', 'LuLiangXian');
INSERT INTO `area` VALUES ('530323', '师宗县', '', '530300', '655700', 'szx', 'ShiZongXian');
INSERT INTO `area` VALUES ('530324', '罗平县', '', '530300', '655800', 'lpx', 'LuoPingXian');
INSERT INTO `area` VALUES ('530325', '富源县', '', '530300', '655500', 'fyx', 'FuYuanXian');
INSERT INTO `area` VALUES ('530326', '会泽县', '', '530300', '654200', 'hzx', 'HuiZeXian');
INSERT INTO `area` VALUES ('530328', '沾益县', '', '530300', '655331', 'zyx', 'ZhanYiXian');
INSERT INTO `area` VALUES ('530381', '宣威市', '', '530300', '655400', 'xws', 'XuanWeiShi');
INSERT INTO `area` VALUES ('530382', '其它区', '', '530300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('530400', '玉溪市', '', '530000', '', 'yxs', 'YuXiShi');
INSERT INTO `area` VALUES ('530402', '红塔区', '', '530400', '653100', 'htq', 'HongTaQu');
INSERT INTO `area` VALUES ('530421', '江川县', '', '530400', '652600', 'jcx', 'JiangChuanXian');
INSERT INTO `area` VALUES ('530422', '澄江县', '', '530400', '652500', 'cjx', 'ChengJiangXian');
INSERT INTO `area` VALUES ('530423', '通海县', '', '530400', '652700', 'thx', 'TongHaiXian');
INSERT INTO `area` VALUES ('530424', '华宁县', '', '530400', '652800', 'hnx', 'HuaNingXian');
INSERT INTO `area` VALUES ('530425', '易门县', '', '530400', '651100', 'ymx', 'YiMenXian');
INSERT INTO `area` VALUES ('530426', '峨山彝族自治县', '', '530400', '653200', 'esyzzzx', 'EShanYiZuZiZhiXian');
INSERT INTO `area` VALUES ('530427', '新平彝族傣族自治县', '', '530400', '653400', 'xpyzdzzzx', 'XinPingYiZuDaiZuZiZhiXian');
INSERT INTO `area` VALUES ('530428', '元江哈尼族彝族傣族自治县', '', '530400', '653300', 'yjhnzyzdzzzx', 'YuanJiangHaNiZuYiZuDaiZuZi');
INSERT INTO `area` VALUES ('530429', '其它区', '', '530400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('530500', '保山市', '', '530000', '', 'bss', 'BaoShanShi');
INSERT INTO `area` VALUES ('530502', '隆阳区', '', '530500', '678000', 'lyq', 'LongYangQu');
INSERT INTO `area` VALUES ('530521', '施甸县', '', '530500', '678200', 'sdx', 'ShiDianXian');
INSERT INTO `area` VALUES ('530522', '腾冲县', '', '530500', '679100', 'tcx', 'TengChongXian');
INSERT INTO `area` VALUES ('530523', '龙陵县', '', '530500', '678300', 'llx', 'LongLingXian');
INSERT INTO `area` VALUES ('530524', '昌宁县', '', '530500', '678100', 'cnx', 'ChangNingXian');
INSERT INTO `area` VALUES ('530525', '其它区', '', '530500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('530600', '昭通市', '', '530000', '657000', 'zts', 'ZhaoTongShi');
INSERT INTO `area` VALUES ('530602', '昭阳区', '', '530600', '657000', 'zyq', 'ZhaoYangQu');
INSERT INTO `area` VALUES ('530621', '鲁甸县', '', '530600', '657100', 'ldx', 'LuDianXian');
INSERT INTO `area` VALUES ('530622', '巧家县', '', '530600', '654600', 'qjx', 'QiaoJiaXian');
INSERT INTO `area` VALUES ('530623', '盐津县', '', '530600', '657500', 'yjx', 'YanJinXian');
INSERT INTO `area` VALUES ('530624', '大关县', '', '530600', '657400', 'dgx', 'DaGuanXian');
INSERT INTO `area` VALUES ('530625', '永善县', '', '530600', '657300', 'ysx', 'YongShanXian');
INSERT INTO `area` VALUES ('530626', '绥江县', '', '530600', '657700', 'sjx', 'SuiJiangXian');
INSERT INTO `area` VALUES ('530627', '镇雄县', '', '530600', '657200', 'zxx', 'ZhenXiongXian');
INSERT INTO `area` VALUES ('530628', '彝良县', '', '530600', '657600', 'ylx', 'YiLiangXian');
INSERT INTO `area` VALUES ('530629', '威信县', '', '530600', '657900', 'wxx', 'WeiXinXian');
INSERT INTO `area` VALUES ('530630', '水富县', '', '530600', '657800', 'sfx', 'ShuiFuXian');
INSERT INTO `area` VALUES ('530631', '其它区', '', '530600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('530700', '丽江市', '', '530000', '', 'ljs', 'LiJiangShi');
INSERT INTO `area` VALUES ('530702', '古城区', '', '530700', '674100', 'gcq', 'GuChengQu');
INSERT INTO `area` VALUES ('530721', '玉龙纳西族自治县', '', '530700', '674100', 'ylnxzzzx', 'YuLongNaXiZuZiZhiXian');
INSERT INTO `area` VALUES ('530722', '永胜县', '', '530700', '674200', 'ysx', 'YongShengXian');
INSERT INTO `area` VALUES ('530723', '华坪县', '', '530700', '674800', 'hpx', 'HuaPingXian');
INSERT INTO `area` VALUES ('530724', '宁蒗彝族自治县', '', '530700', '674300', 'nlyzzzx', 'NingZuoYiZuZiZhiXian');
INSERT INTO `area` VALUES ('530725', '其它区', '', '530700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('530800', '普洱市', '', '530000', '665000', 'pes', 'PuErShi');
INSERT INTO `area` VALUES ('530802', '思茅区', '', '530800', '665000', 'smq', 'SiMaoQu');
INSERT INTO `area` VALUES ('530821', '宁洱哈尼族彝族自治县', '', '530800', '665100', 'nehnzyzzzx', 'NingErHaNiZuYiZuZiZhiXian');
INSERT INTO `area` VALUES ('530822', '墨江哈尼族自治县', '', '530800', '654800', 'mjhnzzzx', 'MoJiangHaNiZuZiZhiXian');
INSERT INTO `area` VALUES ('530823', '景东彝族自治县', '', '530800', '676200', 'jdyzzzx', 'JingDongYiZuZiZhiXian');
INSERT INTO `area` VALUES ('530824', '景谷傣族彝族自治县', '', '530800', '666400', 'jgdzyzzzx', 'JingGuDaiZuYiZuZiZhiXian');
INSERT INTO `area` VALUES ('530825', '镇沅彝族哈尼族拉祜族自治县', '', '530800', '666500', 'zyyzhnzlhzzzx', 'ZhenZuoYiZuHaNiZuLaZuoZu');
INSERT INTO `area` VALUES ('530826', '江城哈尼族彝族自治县', '', '530800', '665900', 'jchnzyzzzx', 'JiangChengHaNiZuYiZuZiZhiXian');
INSERT INTO `area` VALUES ('530827', '孟连傣族拉祜族佤族自治县', '', '530800', '665800', 'mldzlhzwzzzx', 'MengLianDaiZuLaZuoZuZuoZuZi');
INSERT INTO `area` VALUES ('530828', '澜沧拉祜族自治县', '', '530800', '665600', 'lclhzzzx', 'LanCangLaZuoZuZiZhiXian');
INSERT INTO `area` VALUES ('530829', '西盟佤族自治县', '', '530800', '665700', 'xmwzzzx', 'XiMengZuoZuZiZhiXian');
INSERT INTO `area` VALUES ('530830', '其它区', '', '530800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('530900', '临沧市', '', '530000', '', 'lcs', 'LinCangShi');
INSERT INTO `area` VALUES ('530902', '临翔区', '', '530900', '677000', 'lxq', 'LinXiangQu');
INSERT INTO `area` VALUES ('530921', '凤庆县', '', '530900', '675900', 'fqx', 'FengQingXian');
INSERT INTO `area` VALUES ('530922', '云县', '', '530900', '675800', 'yx', 'YunXian');
INSERT INTO `area` VALUES ('530923', '永德县', '', '530900', '677600', 'ydx', 'YongDeXian');
INSERT INTO `area` VALUES ('530924', '镇康县', '', '530900', '677700', 'zkx', 'ZhenKangXian');
INSERT INTO `area` VALUES ('530925', '双江拉祜族佤族布朗族傣族自治县', '', '530900', '677300', 'sjlhzwzblzdzzzx', 'ShuangJiangLaZuoZuZuoZuBuLangZu');
INSERT INTO `area` VALUES ('530926', '耿马傣族佤族自治县', '', '530900', '677500', 'gmdzwzzzx', 'GengMaDaiZuZuoZuZiZhiXian');
INSERT INTO `area` VALUES ('530927', '沧源佤族自治县', '', '530900', '677400', 'cywzzzx', 'CangYuanZuoZuZiZhiXian');
INSERT INTO `area` VALUES ('530928', '其它区', '', '530900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('532300', '楚雄彝族自治州', '', '530000', '', 'cxyzzzz', 'ChuXiongYiZuZiZhiZhou');
INSERT INTO `area` VALUES ('532301', '楚雄市', '', '532300', '675000', 'cxs', 'ChuXiongShi');
INSERT INTO `area` VALUES ('532322', '双柏县', '', '532300', '675100', 'sbx', 'ShuangBaiXian');
INSERT INTO `area` VALUES ('532323', '牟定县', '', '532300', '675500', 'mdx', 'MouDingXian');
INSERT INTO `area` VALUES ('532324', '南华县', '', '532300', '675200', 'nhx', 'NanHuaXian');
INSERT INTO `area` VALUES ('532325', '姚安县', '', '532300', '675300', 'yax', 'YaoAnXian');
INSERT INTO `area` VALUES ('532326', '大姚县', '', '532300', '675400', 'dyx', 'DaYaoXian');
INSERT INTO `area` VALUES ('532327', '永仁县', '', '532300', '651400', 'yrx', 'YongRenXian');
INSERT INTO `area` VALUES ('532328', '元谋县', '', '532300', '651300', 'ymx', 'YuanMouXian');
INSERT INTO `area` VALUES ('532329', '武定县', '', '532300', '651600', 'wdx', 'WuDingXian');
INSERT INTO `area` VALUES ('532331', '禄丰县', '', '532300', '651200', 'lfx', 'LuFengXian');
INSERT INTO `area` VALUES ('532332', '其它区', '', '532300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('532500', '红河哈尼族彝族自治州', '', '530000', '', 'hhhnzyzzzz', 'HongHeHaNiZuYiZuZiZhiZhou');
INSERT INTO `area` VALUES ('532501', '个旧市', '', '532500', '661000', 'gjs', 'GeJiuShi');
INSERT INTO `area` VALUES ('532502', '开远市', '', '532500', '661600', 'kys', 'KaiYuanShi');
INSERT INTO `area` VALUES ('532522', '蒙自县', '', '532500', '661100', 'mzx', 'MengZiXian');
INSERT INTO `area` VALUES ('532523', '屏边苗族自治县', '', '532500', '661200', 'pbmzzzx', 'PingBianMiaoZuZiZhiXian');
INSERT INTO `area` VALUES ('532524', '建水县', '', '532500', '654300', 'jsx', 'JianShuiXian');
INSERT INTO `area` VALUES ('532525', '石屏县', '', '532500', '662200', 'spx', 'ShiPingXian');
INSERT INTO `area` VALUES ('532526', '弥勒县', '', '532500', '652300', 'mlx', 'MiLeXian');
INSERT INTO `area` VALUES ('532527', '泸西县', '', '532500', '652400', 'lxx', 'ZuoXiXian');
INSERT INTO `area` VALUES ('532528', '元阳县', '', '532500', '662400', 'yyx', 'YuanYangXian');
INSERT INTO `area` VALUES ('532529', '红河县', '', '532500', '654400', 'hhx', 'HongHeXian');
INSERT INTO `area` VALUES ('532530', '金平苗族瑶族傣族自治县', '', '532500', '661500', 'jpmzyzdzzzx', 'JinPingMiaoZuYaoZuDaiZuZiZhi');
INSERT INTO `area` VALUES ('532531', '绿春县', '', '532500', '662500', 'lcx', 'LvChunXian');
INSERT INTO `area` VALUES ('532532', '河口瑶族自治县', '', '532500', '661300', 'hkyzzzx', 'HeKouYaoZuZiZhiXian');
INSERT INTO `area` VALUES ('532533', '其它区', '', '532500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('532600', '文山壮族苗族自治州', '', '530000', '', 'wszzmzzzz', 'WenShanZhuangZuMiaoZuZiZhiZhou');
INSERT INTO `area` VALUES ('532621', '文山县', '', '532600', '663000', 'wsx', 'WenShanXian');
INSERT INTO `area` VALUES ('532622', '砚山县', '', '532600', '663100', 'ysx', 'YanShanXian');
INSERT INTO `area` VALUES ('532623', '西畴县', '', '532600', '663500', 'xcx', 'XiChouXian');
INSERT INTO `area` VALUES ('532624', '麻栗坡县', '', '532600', '663600', 'mlpx', 'MaLiPoXian');
INSERT INTO `area` VALUES ('532625', '马关县', '', '532600', '663700', 'mgx', 'MaGuanXian');
INSERT INTO `area` VALUES ('532626', '丘北县', '', '532600', '663200', 'qbx', 'QiuBeiXian');
INSERT INTO `area` VALUES ('532627', '广南县', '', '532600', '663300', 'gnx', 'GuangNanXian');
INSERT INTO `area` VALUES ('532628', '富宁县', '', '532600', '663400', 'fnx', 'FuNingXian');
INSERT INTO `area` VALUES ('532629', '其它区', '', '532600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('532800', '西双版纳傣族自治州', '', '530000', '', 'xsbndzzzz', 'XiShuangBanNaDaiZuZiZhiZhou');
INSERT INTO `area` VALUES ('532801', '景洪市', '', '532800', '666100', 'jhs', 'JingHongShi');
INSERT INTO `area` VALUES ('532822', '勐海县', '', '532800', '666200', 'mhx', 'ZuoHaiXian');
INSERT INTO `area` VALUES ('532823', '勐腊县', '', '532800', '666300', 'mlx', 'ZuoLaXian');
INSERT INTO `area` VALUES ('532824', '其它区', '', '532800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('532900', '大理白族自治州', '', '530000', '', 'dlbzzzz', 'DaLiBaiZuZiZhiZhou');
INSERT INTO `area` VALUES ('532901', '大理市', '', '532900', '671000', 'dls', 'DaLiShi');
INSERT INTO `area` VALUES ('532922', '漾濞彝族自治县', '', '532900', '672500', 'ybyzzzx', 'YangZuoYiZuZiZhiXian');
INSERT INTO `area` VALUES ('532923', '祥云县', '', '532900', '672100', 'xyx', 'XiangYunXian');
INSERT INTO `area` VALUES ('532924', '宾川县', '', '532900', '671600', 'bcx', 'BinChuanXian');
INSERT INTO `area` VALUES ('532925', '弥渡县', '', '532900', '675600', 'mdx', 'MiDuXian');
INSERT INTO `area` VALUES ('532926', '南涧彝族自治县', '', '532900', '675700', 'njyzzzx', 'NanJianYiZuZiZhiXian');
INSERT INTO `area` VALUES ('532927', '巍山彝族回族自治县', '', '532900', '672400', 'wsyzhzzzx', 'WeiShanYiZuHuiZuZiZhiXian');
INSERT INTO `area` VALUES ('532928', '永平县', '', '532900', '672600', 'ypx', 'YongPingXian');
INSERT INTO `area` VALUES ('532929', '云龙县', '', '532900', '672700', 'ylx', 'YunLongXian');
INSERT INTO `area` VALUES ('532930', '洱源县', '', '532900', '671200', 'eyx', 'ErYuanXian');
INSERT INTO `area` VALUES ('532931', '剑川县', '', '532900', '671300', 'jcx', 'JianChuanXian');
INSERT INTO `area` VALUES ('532932', '鹤庆县', '', '532900', '671500', 'hqx', 'HeQingXian');
INSERT INTO `area` VALUES ('532933', '其它区', '', '532900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('533100', '德宏傣族景颇族自治州', '', '530000', '', 'dhdzjpzzzz', 'DeHongDaiZuJingPoZuZiZhiZhou');
INSERT INTO `area` VALUES ('533102', '瑞丽市', '', '533100', '678600', 'rls', 'RuiLiShi');
INSERT INTO `area` VALUES ('533103', '潞西市', '', '533100', '678400', 'lxs', 'LuXiShi');
INSERT INTO `area` VALUES ('533122', '梁河县', '', '533100', '679200', 'lhx', 'LiangHeXian');
INSERT INTO `area` VALUES ('533123', '盈江县', '', '533100', '679300', 'yjx', 'YingJiangXian');
INSERT INTO `area` VALUES ('533124', '陇川县', '', '533100', '678700', 'lcx', 'LongChuanXian');
INSERT INTO `area` VALUES ('533125', '其它区', '', '533100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('533300', '怒江傈僳族自治州', '', '530000', '', 'njlszzzz', 'NuJiangLiSuZuZiZhiZhou');
INSERT INTO `area` VALUES ('533321', '泸水县', '', '533300', '673100', 'lsx', 'ZuoShuiXian');
INSERT INTO `area` VALUES ('533323', '福贡县', '', '533300', '673400', 'fgx', 'FuGongXian');
INSERT INTO `area` VALUES ('533324', '贡山独龙族怒族自治县', '', '533300', '673500', 'gsdlznzzzx', 'GongShanDuLongZuNuZuZiZhiXian');
INSERT INTO `area` VALUES ('533325', '兰坪白族普米族自治县', '', '533300', '671400', 'lpbzpmzzzx', 'LanPingBaiZuPuMiZuZiZhiXian');
INSERT INTO `area` VALUES ('533326', '其它区', '', '533300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('533400', '迪庆藏族自治州', '', '530000', '', 'dqzzzzz', 'DiQingZangZuZiZhiZhou');
INSERT INTO `area` VALUES ('533421', '香格里拉县', '', '533400', '674400', 'xgllx', 'XiangGeLiLaXian');
INSERT INTO `area` VALUES ('533422', '德钦县', '', '533400', '674500', 'dqx', 'DeQinXian');
INSERT INTO `area` VALUES ('533423', '维西傈僳族自治县', '', '533400', '674600', 'wxlszzzx', 'WeiXiLiSuZuZiZhiXian');
INSERT INTO `area` VALUES ('533424', '其它区', '', '533400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('540000', '西藏自治区', '', '1', '', 'xzzzq', 'XiZangZiZhiQu');
INSERT INTO `area` VALUES ('540100', '拉萨市', '', '540000', '850000', 'lss', 'LaSaShi');
INSERT INTO `area` VALUES ('540102', '城关区', '', '540100', '850000', 'cgq', 'ChengGuanQu');
INSERT INTO `area` VALUES ('540121', '林周县', '', '540100', '851600', 'lzx', 'LinZhouXian');
INSERT INTO `area` VALUES ('540122', '当雄县', '', '540100', '851500', 'dxx', 'DangXiongXian');
INSERT INTO `area` VALUES ('540123', '尼木县', '', '540100', '851300', 'nmx', 'NiMuXian');
INSERT INTO `area` VALUES ('540124', '曲水县', '', '540100', '850600', 'qsx', 'QuShuiXian');
INSERT INTO `area` VALUES ('540125', '堆龙德庆县', '', '540100', '851400', 'dldqx', 'DuiLongDeQingXian');
INSERT INTO `area` VALUES ('540126', '达孜县', '', '540100', '850100', 'dzx', 'DaZiXian');
INSERT INTO `area` VALUES ('540127', '墨竹工卡县', '', '540100', '850200', 'mzgkx', 'MoZhuGongKaXian');
INSERT INTO `area` VALUES ('540128', '其它区', '', '540100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('542100', '昌都地区', '', '540000', '', 'cddq', 'ChangDuDiQu');
INSERT INTO `area` VALUES ('542121', '昌都县', '', '542100', '854000', 'cdx', 'ChangDuXian');
INSERT INTO `area` VALUES ('542122', '江达县', '', '542100', '854100', 'jdx', 'JiangDaXian');
INSERT INTO `area` VALUES ('542123', '贡觉县', '', '542100', '854200', 'gjx', 'GongJueXian');
INSERT INTO `area` VALUES ('542124', '类乌齐县', '', '542100', '855600', 'lwqx', 'LeiWuQiXian');
INSERT INTO `area` VALUES ('542125', '丁青县', '', '542100', '855700', 'dqx', 'DingQingXian');
INSERT INTO `area` VALUES ('542126', '察雅县', '', '542100', '854300', 'cyx', 'ChaYaXian');
INSERT INTO `area` VALUES ('542127', '八宿县', '', '542100', '854600', 'bsx', 'BaSuXian');
INSERT INTO `area` VALUES ('542128', '左贡县', '', '542100', '854400', 'zgx', 'ZuoGongXian');
INSERT INTO `area` VALUES ('542129', '芒康县', '', '542100', '854500', 'mkx', 'MangKangXian');
INSERT INTO `area` VALUES ('542132', '洛隆县', '', '542100', '855400', 'llx', 'LuoLongXian');
INSERT INTO `area` VALUES ('542133', '边坝县', '', '542100', '855500', 'bbx', 'BianBaXian');
INSERT INTO `area` VALUES ('542134', '其它区', '', '542100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('542200', '山南地区', '', '540000', '', 'sndq', 'ShanNanDiQu');
INSERT INTO `area` VALUES ('542221', '乃东县', '', '542200', '856100', 'ndx', 'NaiDongXian');
INSERT INTO `area` VALUES ('542222', '扎囊县', '', '542200', '850800', 'znx', 'ZhaNangXian');
INSERT INTO `area` VALUES ('542223', '贡嘎县', '', '542200', '850700', 'ggx', 'GongGaXian');
INSERT INTO `area` VALUES ('542224', '桑日县', '', '542200', '856200', 'srx', 'SangRiXian');
INSERT INTO `area` VALUES ('542225', '琼结县', '', '542200', '856800', 'qjx', 'QiongJieXian');
INSERT INTO `area` VALUES ('542226', '曲松县', '', '542200', '856300', 'qsx', 'QuSongXian');
INSERT INTO `area` VALUES ('542227', '措美县', '', '542200', '856900', 'cmx', 'CuoMeiXian');
INSERT INTO `area` VALUES ('542228', '洛扎县', '', '542200', '851200', 'lzx', 'LuoZhaXian');
INSERT INTO `area` VALUES ('542229', '加查县', '', '542200', '856400', 'jcx', 'JiaChaXian');
INSERT INTO `area` VALUES ('542231', '隆子县', '', '542200', '856600', 'lzx', 'LongZiXian');
INSERT INTO `area` VALUES ('542232', '错那县', '', '542200', '856700', 'cnx', 'CuoNaXian');
INSERT INTO `area` VALUES ('542233', '浪卡子县', '', '542200', '851100', 'lkzx', 'LangKaZiXian');
INSERT INTO `area` VALUES ('542234', '其它区', '', '542200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('542300', '日喀则地区', '', '540000', '', 'rkzdq', 'RiKaZeDiQu');
INSERT INTO `area` VALUES ('542301', '日喀则市', '', '542300', '857000', 'rkzs', 'RiKaZeShi');
INSERT INTO `area` VALUES ('542322', '南木林县', '', '542300', '857100', 'nmlx', 'NanMuLinXian');
INSERT INTO `area` VALUES ('542323', '江孜县', '', '542300', '857400', 'jzx', 'JiangZiXian');
INSERT INTO `area` VALUES ('542324', '定日县', '', '542300', '858200', 'drx', 'DingRiXian');
INSERT INTO `area` VALUES ('542325', '萨迦县', '', '542300', '857800', 'sjx', 'SaZuoXian');
INSERT INTO `area` VALUES ('542326', '拉孜县', '', '542300', '858100', 'lzx', 'LaZiXian');
INSERT INTO `area` VALUES ('542327', '昂仁县', '', '542300', '858500', 'arx', 'AngRenXian');
INSERT INTO `area` VALUES ('542328', '谢通门县', '', '542300', '858900', 'xtmx', 'XieTongMenXian');
INSERT INTO `area` VALUES ('542329', '白朗县', '', '542300', '857300', 'blx', 'BaiLangXian');
INSERT INTO `area` VALUES ('542330', '仁布县', '', '542300', '857200', 'rbx', 'RenBuXian');
INSERT INTO `area` VALUES ('542331', '康马县', '', '542300', '857500', 'kmx', 'KangMaXian');
INSERT INTO `area` VALUES ('542332', '定结县', '', '542300', '857900', 'djx', 'DingJieXian');
INSERT INTO `area` VALUES ('542333', '仲巴县', '', '542300', '858800', 'zbx', 'ZhongBaXian');
INSERT INTO `area` VALUES ('542334', '亚东县', '', '542300', '857600', 'ydx', 'YaDongXian');
INSERT INTO `area` VALUES ('542335', '吉隆县', '', '542300', '858700', 'jlx', 'JiLongXian');
INSERT INTO `area` VALUES ('542336', '聂拉木县', '', '542300', '858300', 'nlmx', 'NieLaMuXian');
INSERT INTO `area` VALUES ('542337', '萨嘎县', '', '542300', '858600', 'sgx', 'SaGaXian');
INSERT INTO `area` VALUES ('542338', '岗巴县', '', '542300', '857700', 'gbx', 'GangBaXian');
INSERT INTO `area` VALUES ('542339', '其它区', '', '542300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('542400', '那曲地区', '', '540000', '', 'nqdq', 'NaQuDiQu');
INSERT INTO `area` VALUES ('542421', '那曲县', '', '542400', '852000', 'nqx', 'NaQuXian');
INSERT INTO `area` VALUES ('542422', '嘉黎县', '', '542400', '852400', 'jlx', 'JiaLiXian');
INSERT INTO `area` VALUES ('542423', '比如县', '', '542400', '852300', 'brx', 'BiRuXian');
INSERT INTO `area` VALUES ('542424', '聂荣县', '', '542400', '853500', 'nrx', 'NieRongXian');
INSERT INTO `area` VALUES ('542425', '安多县', '', '542400', '853400', 'adx', 'AnDuoXian');
INSERT INTO `area` VALUES ('542426', '申扎县', '', '542400', '853100', 'szx', 'ShenZhaXian');
INSERT INTO `area` VALUES ('542427', '索县', '', '542400', '852200', 'sx', 'SuoXian');
INSERT INTO `area` VALUES ('542428', '班戈县', '', '542400', '852500', 'bgx', 'BanGeXian');
INSERT INTO `area` VALUES ('542429', '巴青县', '', '542400', '852100', 'bqx', 'BaQingXian');
INSERT INTO `area` VALUES ('542430', '尼玛县', '', '542400', '852600', 'nmx', 'NiMaXian');
INSERT INTO `area` VALUES ('542431', '其它区', '', '542400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('542500', '阿里地区', '', '540000', '', 'aldq', 'ALiDiQu');
INSERT INTO `area` VALUES ('542521', '普兰县', '', '542500', '859500', 'plx', 'PuLanXian');
INSERT INTO `area` VALUES ('542522', '札达县', '', '542500', '859600', 'zdx', 'ZhaDaXian');
INSERT INTO `area` VALUES ('542523', '噶尔县', '', '542500', '859400', 'gex', 'GaErXian');
INSERT INTO `area` VALUES ('542524', '日土县', '', '542500', '859700', 'rtx', 'RiTuXian');
INSERT INTO `area` VALUES ('542525', '革吉县', '', '542500', '859100', 'gjx', 'GeJiXian');
INSERT INTO `area` VALUES ('542526', '改则县', '', '542500', '859200', 'gzx', 'GaiZeXian');
INSERT INTO `area` VALUES ('542527', '措勤县', '', '542500', '859300', 'cqx', 'CuoQinXian');
INSERT INTO `area` VALUES ('542528', '其它区', '', '542500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('542600', '林芝地区', '', '540000', '', 'lzdq', 'LinZhiDiQu');
INSERT INTO `area` VALUES ('542621', '林芝县', '', '542600', '860100', 'lzx', 'LinZhiXian');
INSERT INTO `area` VALUES ('542622', '工布江达县', '', '542600', '860200', 'gbjdx', 'GongBuJiangDaXian');
INSERT INTO `area` VALUES ('542623', '米林县', '', '542600', '860500', 'mlx', 'MiLinXian');
INSERT INTO `area` VALUES ('542624', '墨脱县', '', '542600', '860700', 'mtx', 'MoTuoXian');
INSERT INTO `area` VALUES ('542625', '波密县', '', '542600', '860300', 'bmx', 'BoMiXian');
INSERT INTO `area` VALUES ('542626', '察隅县', '', '542600', '860600', 'cyx', 'ChaYuXian');
INSERT INTO `area` VALUES ('542627', '朗县', '', '542600', '860400', 'lx', 'LangXian');
INSERT INTO `area` VALUES ('542628', '其它区', '', '542600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('610000', '陕西省', '', '1', '', 'sxs', 'ShanXiSheng');
INSERT INTO `area` VALUES ('610100', '西安市', '', '610000', '710000', 'xas', 'XiAnShi');
INSERT INTO `area` VALUES ('610102', '新城区', '', '610100', '710005', 'xcq', 'XinChengQu');
INSERT INTO `area` VALUES ('610103', '碑林区', '', '610100', '710001', 'blq', 'BeiLinQu');
INSERT INTO `area` VALUES ('610104', '莲湖区', '', '610100', '710003', 'lhq', 'LianHuQu');
INSERT INTO `area` VALUES ('610111', '灞桥区', '', '610100', '710038', 'bqq', 'ZuoQiaoQu');
INSERT INTO `area` VALUES ('610112', '未央区', '', '610100', '710016', 'wyq', 'WeiYangQu');
INSERT INTO `area` VALUES ('610113', '雁塔区', '', '610100', '710061', 'ytq', 'YanTaQu');
INSERT INTO `area` VALUES ('610114', '阎良区', '', '610100', '710089', 'ylq', 'YanLiangQu');
INSERT INTO `area` VALUES ('610115', '临潼区', '', '610100', '710600', 'ltq', 'LinZuoQu');
INSERT INTO `area` VALUES ('610116', '长安区', '', '610100', '710100', 'caq', 'ChangAnQu');
INSERT INTO `area` VALUES ('610122', '蓝田县', '', '610100', '710500', 'ltx', 'LanTianXian');
INSERT INTO `area` VALUES ('610124', '周至县', '', '610100', '710400', 'zzx', 'ZhouZhiXian');
INSERT INTO `area` VALUES ('610125', '户县', '', '610100', '710300', 'hx', 'HuXian');
INSERT INTO `area` VALUES ('610126', '高陵县', '', '610100', '710200', 'glx', 'GaoLingXian');
INSERT INTO `area` VALUES ('610127', '其它区', '', '610100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('610200', '铜川市', '', '610000', '727000', 'tcs', 'TongChuanShi');
INSERT INTO `area` VALUES ('610202', '王益区', '', '610200', '727000', 'wyq', 'WangYiQu');
INSERT INTO `area` VALUES ('610203', '印台区', '', '610200', '727007', 'ytq', 'YinTaiQu');
INSERT INTO `area` VALUES ('610204', '耀州区', '', '610200', '727100', 'yzq', 'YaoZhouQu');
INSERT INTO `area` VALUES ('610222', '宜君县', '', '610200', '727200', 'yjx', 'YiJunXian');
INSERT INTO `area` VALUES ('610223', '其它区', '', '610200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('610300', '宝鸡市', '', '610000', '721000', 'bjs', 'BaoJiShi');
INSERT INTO `area` VALUES ('610302', '渭滨区', '', '610300', '721000', 'wbq', 'WeiBinQu');
INSERT INTO `area` VALUES ('610303', '金台区', '', '610300', '721001', 'jtq', 'JinTaiQu');
INSERT INTO `area` VALUES ('610304', '陈仓区', '', '610300', '721300', 'ccq', 'ChenCangQu');
INSERT INTO `area` VALUES ('610322', '凤翔县', '', '610300', '721400', 'fxx', 'FengXiangXian');
INSERT INTO `area` VALUES ('610323', '岐山县', '', '610300', '722400', 'qsx', 'ZuoShanXian');
INSERT INTO `area` VALUES ('610324', '扶风县', '', '610300', '722200', 'ffx', 'FuFengXian');
INSERT INTO `area` VALUES ('610326', '眉县', '', '610300', '722300', 'mx', 'MeiXian');
INSERT INTO `area` VALUES ('610327', '陇县', '', '610300', '721200', 'lx', 'LongXian');
INSERT INTO `area` VALUES ('610328', '千阳县', '', '610300', '721100', 'qyx', 'QianYangXian');
INSERT INTO `area` VALUES ('610329', '麟游县', '', '610300', '721500', 'lyx', 'ZuoYouXian');
INSERT INTO `area` VALUES ('610330', '凤县', '', '610300', '721700', 'fx', 'FengXian');
INSERT INTO `area` VALUES ('610331', '太白县', '', '610300', '721600', 'tbx', 'TaiBaiXian');
INSERT INTO `area` VALUES ('610332', '其它区', '', '610300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('610400', '咸阳市', '', '610000', '712000', 'xys', 'XianYangShi');
INSERT INTO `area` VALUES ('610402', '秦都区', '', '610400', '712000', 'qdq', 'QinDuQu');
INSERT INTO `area` VALUES ('610403', '杨凌区', '', '610400', '712100', 'ylq', 'YangLingQu');
INSERT INTO `area` VALUES ('610404', '渭城区', '', '610400', '712000', 'wcq', 'WeiChengQu');
INSERT INTO `area` VALUES ('610422', '三原县', '', '610400', '713800', 'syx', 'SanYuanXian');
INSERT INTO `area` VALUES ('610423', '泾阳县', '', '610400', '713700', 'jyx', 'ZuoYangXian');
INSERT INTO `area` VALUES ('610424', '乾县', '', '610400', '713300', 'qx', 'QianXian');
INSERT INTO `area` VALUES ('610425', '礼泉县', '', '610400', '713200', 'lqx', 'LiQuanXian');
INSERT INTO `area` VALUES ('610426', '永寿县', '', '610400', '713400', 'ysx', 'YongShouXian');
INSERT INTO `area` VALUES ('610427', '彬县', '', '610400', '713500', 'bx', 'BinXian');
INSERT INTO `area` VALUES ('610428', '长武县', '', '610400', '713600', 'cwx', 'ChangWuXian');
INSERT INTO `area` VALUES ('610429', '旬邑县', '', '610400', '711300', 'xyx', 'XunYiXian');
INSERT INTO `area` VALUES ('610430', '淳化县', '', '610400', '711200', 'chx', 'ChunHuaXian');
INSERT INTO `area` VALUES ('610431', '武功县', '', '610400', '712200', 'wgx', 'WuGongXian');
INSERT INTO `area` VALUES ('610481', '兴平市', '', '610400', '713100', 'xps', 'XingPingShi');
INSERT INTO `area` VALUES ('610482', '其它区', '', '610400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('610500', '渭南市', '', '610000', '714000', 'wns', 'WeiNanShi');
INSERT INTO `area` VALUES ('610502', '临渭区', '', '610500', '714000', 'lwq', 'LinWeiQu');
INSERT INTO `area` VALUES ('610521', '华县', '', '610500', '714100', 'hx', 'HuaXian');
INSERT INTO `area` VALUES ('610522', '潼关县', '', '610500', '714300', 'tgx', 'ZuoGuanXian');
INSERT INTO `area` VALUES ('610523', '大荔县', '', '610500', '715100', 'dlx', 'DaLiXian');
INSERT INTO `area` VALUES ('610524', '合阳县', '', '610500', '715300', 'hyx', 'HeYangXian');
INSERT INTO `area` VALUES ('610525', '澄城县', '', '610500', '715200', 'ccx', 'ChengChengXian');
INSERT INTO `area` VALUES ('610526', '蒲城县', '', '610500', '715500', 'pcx', 'PuChengXian');
INSERT INTO `area` VALUES ('610527', '白水县', '', '610500', '715600', 'bsx', 'BaiShuiXian');
INSERT INTO `area` VALUES ('610528', '富平县', '', '610500', '711700', 'fpx', 'FuPingXian');
INSERT INTO `area` VALUES ('610581', '韩城市', '', '610500', '715400', 'hcs', 'HanChengShi');
INSERT INTO `area` VALUES ('610582', '华阴市', '', '610500', '714200', 'hys', 'HuaYinShi');
INSERT INTO `area` VALUES ('610583', '其它区', '', '610500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('610600', '延安市', '', '610000', '716000', 'yas', 'YanAnShi');
INSERT INTO `area` VALUES ('610602', '宝塔区', '', '610600', '716000', 'btq', 'BaoTaQu');
INSERT INTO `area` VALUES ('610621', '延长县', '', '610600', '717100', 'ycx', 'YanChangXian');
INSERT INTO `area` VALUES ('610622', '延川县', '', '610600', '717200', 'ycx', 'YanChuanXian');
INSERT INTO `area` VALUES ('610623', '子长县', '', '610600', '717300', 'zcx', 'ZiChangXian');
INSERT INTO `area` VALUES ('610624', '安塞县', '', '610600', '717400', 'asx', 'AnSaiXian');
INSERT INTO `area` VALUES ('610625', '志丹县', '', '610600', '717500', 'zdx', 'ZhiDanXian');
INSERT INTO `area` VALUES ('610626', '吴起县', '', '610600', '717600', 'wqx', 'WuQiXian');
INSERT INTO `area` VALUES ('610627', '甘泉县', '', '610600', '716100', 'gqx', 'GanQuanXian');
INSERT INTO `area` VALUES ('610628', '富县', '', '610600', '727500', 'fx', 'FuXian');
INSERT INTO `area` VALUES ('610629', '洛川县', '', '610600', '727400', 'lcx', 'LuoChuanXian');
INSERT INTO `area` VALUES ('610630', '宜川县', '', '610600', '716200', 'ycx', 'YiChuanXian');
INSERT INTO `area` VALUES ('610631', '黄龙县', '', '610600', '715700', 'hlx', 'HuangLongXian');
INSERT INTO `area` VALUES ('610632', '黄陵县', '', '610600', '727300', 'hlx', 'HuangLingXian');
INSERT INTO `area` VALUES ('610633', '其它区', '', '610600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('610700', '汉中市', '', '610000', '723000', 'hzs', 'HanZhongShi');
INSERT INTO `area` VALUES ('610702', '汉台区', '', '610700', '723000', 'htq', 'HanTaiQu');
INSERT INTO `area` VALUES ('610721', '南郑县', '', '610700', '723100', 'nzx', 'NanZhengXian');
INSERT INTO `area` VALUES ('610722', '城固县', '', '610700', '723200', 'cgx', 'ChengGuXian');
INSERT INTO `area` VALUES ('610723', '洋县', '', '610700', '723300', 'yx', 'YangXian');
INSERT INTO `area` VALUES ('610724', '西乡县', '', '610700', '723500', 'xxx', 'XiXiangXian');
INSERT INTO `area` VALUES ('610725', '勉县', '', '610700', '724200', 'mx', 'MianXian');
INSERT INTO `area` VALUES ('610726', '宁强县', '', '610700', '724400', 'nqx', 'NingQiangXian');
INSERT INTO `area` VALUES ('610727', '略阳县', '', '610700', '724300', 'lyx', 'LueYangXian');
INSERT INTO `area` VALUES ('610728', '镇巴县', '', '610700', '723600', 'zbx', 'ZhenBaXian');
INSERT INTO `area` VALUES ('610729', '留坝县', '', '610700', '724100', 'lbx', 'LiuBaXian');
INSERT INTO `area` VALUES ('610730', '佛坪县', '', '610700', '723400', 'fpx', 'FoPingXian');
INSERT INTO `area` VALUES ('610731', '其它区', '', '610700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('610800', '榆林市', '', '610000', '719000', 'yls', 'YuLinShi');
INSERT INTO `area` VALUES ('610802', '榆阳区', '', '610800', '719000', 'yyq', 'YuYangQu');
INSERT INTO `area` VALUES ('610821', '神木县', '', '610800', '719300', 'smx', 'ShenMuXian');
INSERT INTO `area` VALUES ('610822', '府谷县', '', '610800', '719400', 'fgx', 'FuGuXian');
INSERT INTO `area` VALUES ('610823', '横山县', '', '610800', '719100', 'hsx', 'HengShanXian');
INSERT INTO `area` VALUES ('610824', '靖边县', '', '610800', '718500', 'jbx', 'JingBianXian');
INSERT INTO `area` VALUES ('610825', '定边县', '', '610800', '718600', 'dbx', 'DingBianXian');
INSERT INTO `area` VALUES ('610826', '绥德县', '', '610800', '718000', 'sdx', 'SuiDeXian');
INSERT INTO `area` VALUES ('610827', '米脂县', '', '610800', '718100', 'mzx', 'MiZhiXian');
INSERT INTO `area` VALUES ('610828', '佳县', '', '610800', '719200', 'jx', 'JiaXian');
INSERT INTO `area` VALUES ('610829', '吴堡县', '', '610800', '718200', 'wbx', 'WuBaoXian');
INSERT INTO `area` VALUES ('610830', '清涧县', '', '610800', '718300', 'qjx', 'QingJianXian');
INSERT INTO `area` VALUES ('610831', '子洲县', '', '610800', '718400', 'zzx', 'ZiZhouXian');
INSERT INTO `area` VALUES ('610832', '其它区', '', '610800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('610900', '安康市', '', '610000', '725000', 'aks', 'AnKangShi');
INSERT INTO `area` VALUES ('610902', '汉滨区', '', '610900', '725000', 'hbq', 'HanBinQu');
INSERT INTO `area` VALUES ('610921', '汉阴县', '', '610900', '725100', 'hyx', 'HanYinXian');
INSERT INTO `area` VALUES ('610922', '石泉县', '', '610900', '725200', 'sqx', 'ShiQuanXian');
INSERT INTO `area` VALUES ('610923', '宁陕县', '', '610900', '711600', 'nsx', 'NingShanXian');
INSERT INTO `area` VALUES ('610924', '紫阳县', '', '610900', '725300', 'zyx', 'ZiYangXian');
INSERT INTO `area` VALUES ('610925', '岚皋县', '', '610900', '725400', 'lgx', 'ZuoGaoXian');
INSERT INTO `area` VALUES ('610926', '平利县', '', '610900', '725500', 'plx', 'PingLiXian');
INSERT INTO `area` VALUES ('610927', '镇坪县', '', '610900', '725600', 'zpx', 'ZhenPingXian');
INSERT INTO `area` VALUES ('610928', '旬阳县', '', '610900', '725700', 'xyx', 'XunYangXian');
INSERT INTO `area` VALUES ('610929', '白河县', '', '610900', '725800', 'bhx', 'BaiHeXian');
INSERT INTO `area` VALUES ('610930', '其它区', '', '610900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('611000', '商洛市', '', '610000', '726000', 'sls', 'ShangLuoShi');
INSERT INTO `area` VALUES ('611002', '商州区', '', '611000', '726000', 'szq', 'ShangZhouQu');
INSERT INTO `area` VALUES ('611021', '洛南县', '', '611000', '726100', 'lnx', 'LuoNanXian');
INSERT INTO `area` VALUES ('611022', '丹凤县', '', '611000', '726200', 'dfx', 'DanFengXian');
INSERT INTO `area` VALUES ('611023', '商南县', '', '611000', '726300', 'snx', 'ShangNanXian');
INSERT INTO `area` VALUES ('611024', '山阳县', '', '611000', '726400', 'syx', 'ShanYangXian');
INSERT INTO `area` VALUES ('611025', '镇安县', '', '611000', '711500', 'zax', 'ZhenAnXian');
INSERT INTO `area` VALUES ('611026', '柞水县', '', '611000', '711400', 'zsx', 'ZuoShuiXian');
INSERT INTO `area` VALUES ('611027', '其它区', '', '611000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('620000', '甘肃省', '', '1', '', 'gss', 'GanSuSheng');
INSERT INTO `area` VALUES ('620100', '兰州市', '', '620000', '730000', 'lzs', 'LanZhouShi');
INSERT INTO `area` VALUES ('620102', '城关区', '', '620100', '730030', 'cgq', 'ChengGuanQu');
INSERT INTO `area` VALUES ('620103', '七里河区', '', '620100', '730050', 'qlhq', 'QiLiHeQu');
INSERT INTO `area` VALUES ('620104', '西固区', '', '620100', '730060', 'xgq', 'XiGuQu');
INSERT INTO `area` VALUES ('620105', '安宁区', '', '620100', '730070', 'anq', 'AnNingQu');
INSERT INTO `area` VALUES ('620111', '红古区', '', '620100', '730080', 'hgq', 'HongGuQu');
INSERT INTO `area` VALUES ('620121', '永登县', '', '620100', '730300', 'ydx', 'YongDengXian');
INSERT INTO `area` VALUES ('620122', '皋兰县', '', '620100', '730200', 'glx', 'GaoLanXian');
INSERT INTO `area` VALUES ('620123', '榆中县', '', '620100', '730100', 'yzx', 'YuZhongXian');
INSERT INTO `area` VALUES ('620124', '其它区', '', '620100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('620200', '嘉峪关市', '', '620000', '735100', 'jygs', 'JiaYuGuanShi');
INSERT INTO `area` VALUES ('620300', '金昌市', '', '620000', '737100', 'jcs', 'JinChangShi');
INSERT INTO `area` VALUES ('620302', '金川区', '', '620300', '737103', 'jcq', 'JinChuanQu');
INSERT INTO `area` VALUES ('620321', '永昌县', '', '620300', '737200', 'ycx', 'YongChangXian');
INSERT INTO `area` VALUES ('620322', '其它区', '', '620300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('620400', '白银市', '', '620000', '', 'bys', 'BaiYinShi');
INSERT INTO `area` VALUES ('620402', '白银区', '', '620400', '730900', 'byq', 'BaiYinQu');
INSERT INTO `area` VALUES ('620403', '平川区', '', '620400', '730910', 'pcq', 'PingChuanQu');
INSERT INTO `area` VALUES ('620421', '靖远县', '', '620400', '730600', 'jyx', 'JingYuanXian');
INSERT INTO `area` VALUES ('620422', '会宁县', '', '620400', '730700', 'hnx', 'HuiNingXian');
INSERT INTO `area` VALUES ('620423', '景泰县', '', '620400', '730400', 'jtx', 'JingTaiXian');
INSERT INTO `area` VALUES ('620424', '其它区', '', '620400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('620500', '天水市', '', '620000', '', 'tss', 'TianShuiShi');
INSERT INTO `area` VALUES ('620502', '秦州区', '', '620500', '741000', 'qzq', 'QinZhouQu');
INSERT INTO `area` VALUES ('620503', '麦积区', '', '620500', '741020', 'mjq', 'MaiJiQu');
INSERT INTO `area` VALUES ('620521', '清水县', '', '620500', '741400', 'qsx', 'QingShuiXian');
INSERT INTO `area` VALUES ('620522', '秦安县', '', '620500', '741600', 'qax', 'QinAnXian');
INSERT INTO `area` VALUES ('620523', '甘谷县', '', '620500', '741200', 'ggx', 'GanGuXian');
INSERT INTO `area` VALUES ('620524', '武山县', '', '620500', '741300', 'wsx', 'WuShanXian');
INSERT INTO `area` VALUES ('620525', '张家川回族自治县', '', '620500', '741500', 'zjchzzzx', 'ZhangJiaChuanHuiZuZiZhiXian');
INSERT INTO `area` VALUES ('620526', '其它区', '', '620500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('620600', '武威市', '', '620000', '733000', 'wws', 'WuWeiShi');
INSERT INTO `area` VALUES ('620602', '凉州区', '', '620600', '733000', 'lzq', 'LiangZhouQu');
INSERT INTO `area` VALUES ('620621', '民勤县', '', '620600', '733300', 'mqx', 'MinQinXian');
INSERT INTO `area` VALUES ('620622', '古浪县', '', '620600', '733100', 'glx', 'GuLangXian');
INSERT INTO `area` VALUES ('620623', '天祝藏族自治县', '', '620600', '733200', 'tzzzzzx', 'TianZhuZangZuZiZhiXian');
INSERT INTO `area` VALUES ('620624', '其它区', '', '620600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('620700', '张掖市', '', '620000', '734000', 'zys', 'ZhangYeShi');
INSERT INTO `area` VALUES ('620702', '甘州区', '', '620700', '734000', 'gzq', 'GanZhouQu');
INSERT INTO `area` VALUES ('620721', '肃南裕固族自治县', '', '620700', '734400', 'snygzzzx', 'SuNanYuGuZuZiZhiXian');
INSERT INTO `area` VALUES ('620722', '民乐县', '', '620700', '734500', 'mlx', 'MinLeXian');
INSERT INTO `area` VALUES ('620723', '临泽县', '', '620700', '734200', 'lzx', 'LinZeXian');
INSERT INTO `area` VALUES ('620724', '高台县', '', '620700', '734300', 'gtx', 'GaoTaiXian');
INSERT INTO `area` VALUES ('620725', '山丹县', '', '620700', '734100', 'sdx', 'ShanDanXian');
INSERT INTO `area` VALUES ('620726', '其它区', '', '620700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('620800', '平凉市', '', '620000', '744000', 'pls', 'PingLiangShi');
INSERT INTO `area` VALUES ('620802', '崆峒区', '', '620800', '744000', 'ktq', 'ZuoZuoQu');
INSERT INTO `area` VALUES ('620821', '泾川县', '', '620800', '744300', 'jcx', 'ZuoChuanXian');
INSERT INTO `area` VALUES ('620822', '灵台县', '', '620800', '744400', 'ltx', 'LingTaiXian');
INSERT INTO `area` VALUES ('620823', '崇信县', '', '620800', '744200', 'cxx', 'ChongXinXian');
INSERT INTO `area` VALUES ('620824', '华亭县', '', '620800', '744100', 'htx', 'HuaTingXian');
INSERT INTO `area` VALUES ('620825', '庄浪县', '', '620800', '744600', 'zlx', 'ZhuangLangXian');
INSERT INTO `area` VALUES ('620826', '静宁县', '', '620800', '743400', 'jnx', 'JingNingXian');
INSERT INTO `area` VALUES ('620827', '其它区', '', '620800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('620900', '酒泉市', '', '620000', '735000', 'jqs', 'JiuQuanShi');
INSERT INTO `area` VALUES ('620902', '肃州区', '', '620900', '735000', 'szq', 'SuZhouQu');
INSERT INTO `area` VALUES ('620921', '金塔县', '', '620900', '735300', 'jtx', 'JinTaXian');
INSERT INTO `area` VALUES ('620922', '安西县', '', '620900', '743000', 'axx', 'AnXiXian');
INSERT INTO `area` VALUES ('620923', '肃北蒙古族自治县', '', '620900', '736300', 'sbmgzzzx', 'SuBeiMengGuZuZiZhiXian');
INSERT INTO `area` VALUES ('620924', '阿克塞哈萨克族自治县', '', '620900', '736400', 'akshskzzzx', 'AKeSaiHaSaKeZuZiZhiXian');
INSERT INTO `area` VALUES ('620981', '玉门市', '', '620900', '735200', 'yms', 'YuMenShi');
INSERT INTO `area` VALUES ('620982', '敦煌市', '', '620900', '736200', 'dhs', 'DunHuangShi');
INSERT INTO `area` VALUES ('620983', '其它区', '', '620900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('621000', '庆阳市', '', '620000', '', 'qys', 'QingYangShi');
INSERT INTO `area` VALUES ('621002', '西峰区', '', '621000', '745000', 'xfq', 'XiFengQu');
INSERT INTO `area` VALUES ('621021', '庆城县', '', '621000', '745100', 'qcx', 'QingChengXian');
INSERT INTO `area` VALUES ('621022', '环县', '', '621000', '745700', 'hx', 'HuanXian');
INSERT INTO `area` VALUES ('621023', '华池县', '', '621000', '745600', 'hcx', 'HuaChiXian');
INSERT INTO `area` VALUES ('621024', '合水县', '', '621000', '745400', 'hsx', 'HeShuiXian');
INSERT INTO `area` VALUES ('621025', '正宁县', '', '621000', '745300', 'znx', 'ZhengNingXian');
INSERT INTO `area` VALUES ('621026', '宁县', '', '621000', '745200', 'nx', 'NingXian');
INSERT INTO `area` VALUES ('621027', '镇原县', '', '621000', '744500', 'zyx', 'ZhenYuanXian');
INSERT INTO `area` VALUES ('621028', '其它区', '', '621000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('621100', '定西市', '', '620000', '743000', 'dxs', 'DingXiShi');
INSERT INTO `area` VALUES ('621102', '安定区', '', '621100', '743000', 'adq', 'AnDingQu');
INSERT INTO `area` VALUES ('621121', '通渭县', '', '621100', '743300', 'twx', 'TongWeiXian');
INSERT INTO `area` VALUES ('621122', '陇西县', '', '621100', '748100', 'lxx', 'LongXiXian');
INSERT INTO `area` VALUES ('621123', '渭源县', '', '621100', '748200', 'wyx', 'WeiYuanXian');
INSERT INTO `area` VALUES ('621124', '临洮县', '', '621100', '730500', 'ltx', 'LinZuoXian');
INSERT INTO `area` VALUES ('621125', '漳县', '', '621100', '748300', 'zx', 'ZhangXian');
INSERT INTO `area` VALUES ('621126', '岷县', '', '621100', '748400', 'mx', 'ZuoXian');
INSERT INTO `area` VALUES ('621127', '其它区', '', '621100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('621200', '陇南市', '', '620000', '', 'lns', 'LongNanShi');
INSERT INTO `area` VALUES ('621202', '武都区', '', '621200', '746000', 'wdq', 'WuDuQu');
INSERT INTO `area` VALUES ('621221', '成县', '', '621200', '742500', 'cx', 'ChengXian');
INSERT INTO `area` VALUES ('621222', '文县', '', '621200', '746400', 'wx', 'WenXian');
INSERT INTO `area` VALUES ('621223', '宕昌县', '', '621200', '748500', 'dcx', 'ZuoChangXian');
INSERT INTO `area` VALUES ('621224', '康县', '', '621200', '746500', 'kx', 'KangXian');
INSERT INTO `area` VALUES ('621225', '西和县', '', '621200', '742100', 'xhx', 'XiHeXian');
INSERT INTO `area` VALUES ('621226', '礼县', '', '621200', '742200', 'lx', 'LiXian');
INSERT INTO `area` VALUES ('621227', '徽县', '', '621200', '742300', 'hx', 'HuiXian');
INSERT INTO `area` VALUES ('621228', '两当县', '', '621200', '742400', 'ldx', 'LiangDangXian');
INSERT INTO `area` VALUES ('621229', '其它区', '', '621200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('622900', '临夏回族自治州', '', '620000', '', 'lxhzzzz', 'LinXiaHuiZuZiZhiZhou');
INSERT INTO `area` VALUES ('622901', '临夏市', '', '622900', '731100', 'lxs', 'LinXiaShi');
INSERT INTO `area` VALUES ('622921', '临夏县', '', '622900', '731800', 'lxx', 'LinXiaXian');
INSERT INTO `area` VALUES ('622922', '康乐县', '', '622900', '731500', 'klx', 'KangLeXian');
INSERT INTO `area` VALUES ('622923', '永靖县', '', '622900', '731600', 'yjx', 'YongJingXian');
INSERT INTO `area` VALUES ('622924', '广河县', '', '622900', '731300', 'ghx', 'GuangHeXian');
INSERT INTO `area` VALUES ('622925', '和政县', '', '622900', '731200', 'hzx', 'HeZhengXian');
INSERT INTO `area` VALUES ('622926', '东乡族自治县', '', '622900', '731400', 'dxzzzx', 'DongXiangZuZiZhiXian');
INSERT INTO `area` VALUES ('622927', '积石山保安族东乡族撒拉族自治县', '', '622900', '731700', 'jssbazdxzslzzzx', 'JiShiShanBaoAnZuDongXiangZuSa');
INSERT INTO `area` VALUES ('622928', '其它区', '', '622900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('623000', '甘南藏族自治州', '', '620000', '747000', 'gnzzzzz', 'GanNanZangZuZiZhiZhou');
INSERT INTO `area` VALUES ('623001', '合作市', '', '623000', '747000', 'hzs', 'HeZuoShi');
INSERT INTO `area` VALUES ('623021', '临潭县', '', '623000', '747500', 'ltx', 'LinTanXian');
INSERT INTO `area` VALUES ('623022', '卓尼县', '', '623000', '747600', 'znx', 'ZhuoNiXian');
INSERT INTO `area` VALUES ('623023', '舟曲县', '', '623000', '746300', 'zqx', 'ZhouQuXian');
INSERT INTO `area` VALUES ('623024', '迭部县', '', '623000', '747400', 'dbx', 'DieBuXian');
INSERT INTO `area` VALUES ('623025', '玛曲县', '', '623000', '747300', 'mqx', 'MaQuXian');
INSERT INTO `area` VALUES ('623026', '碌曲县', '', '623000', '747200', 'lqx', 'LuQuXian');
INSERT INTO `area` VALUES ('623027', '夏河县', '', '623000', '747100', 'xhx', 'XiaHeXian');
INSERT INTO `area` VALUES ('623028', '其它区', '', '623000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('630000', '青海省', '', '1', '', 'qhs', 'QingHaiSheng');
INSERT INTO `area` VALUES ('630100', '西宁市', '', '630000', '810000', 'xns', 'XiNingShi');
INSERT INTO `area` VALUES ('630102', '城东区', '', '630100', '810000', 'cdq', 'ChengDongQu');
INSERT INTO `area` VALUES ('630103', '城中区', '', '630100', '810000', 'czq', 'ChengZhongQu');
INSERT INTO `area` VALUES ('630104', '城西区', '', '630100', '810001', 'cxq', 'ChengXiQu');
INSERT INTO `area` VALUES ('630105', '城北区', '', '630100', '810001', 'cbq', 'ChengBeiQu');
INSERT INTO `area` VALUES ('630121', '大通回族土族自治县', '', '630100', '810100', 'dthztzzzx', 'DaTongHuiZuTuZuZiZhiXian');
INSERT INTO `area` VALUES ('630122', '湟中县', '', '630100', '811600', 'hzx', 'ZuoZhongXian');
INSERT INTO `area` VALUES ('630123', '湟源县', '', '630100', '812100', 'hyx', 'ZuoYuanXian');
INSERT INTO `area` VALUES ('630124', '其它区', '', '630100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('632100', '海东地区', '', '630000', '', 'hddq', 'HaiDongDiQu');
INSERT INTO `area` VALUES ('632121', '平安县', '', '632100', '810600', 'pax', 'PingAnXian');
INSERT INTO `area` VALUES ('632122', '民和回族土族自治县', '', '632100', '810800', 'mhhztzzzx', 'MinHeHuiZuTuZuZiZhiXian');
INSERT INTO `area` VALUES ('632123', '乐都县', '', '632100', '810700', 'ldx', 'LeDuXian');
INSERT INTO `area` VALUES ('632126', '互助土族自治县', '', '632100', '810500', 'hztzzzx', 'HuZhuTuZuZiZhiXian');
INSERT INTO `area` VALUES ('632127', '化隆回族自治县', '', '632100', '810900', 'hlhzzzx', 'HuaLongHuiZuZiZhiXian');
INSERT INTO `area` VALUES ('632128', '循化撒拉族自治县', '', '632100', '811100', 'xhslzzzx', 'XunHuaSaLaZuZiZhiXian');
INSERT INTO `area` VALUES ('632129', '其它区', '', '632100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('632200', '海北藏族自治州', '', '630000', '', 'hbzzzzz', 'HaiBeiZangZuZiZhiZhou');
INSERT INTO `area` VALUES ('632221', '门源回族自治县', '', '632200', '810300', 'myhzzzx', 'MenYuanHuiZuZiZhiXian');
INSERT INTO `area` VALUES ('632222', '祁连县', '', '632200', '810400', 'qlx', 'QiLianXian');
INSERT INTO `area` VALUES ('632223', '海晏县', '', '632200', '812200', 'hyx', 'HaiZuoXian');
INSERT INTO `area` VALUES ('632224', '刚察县', '', '632200', '812300', 'gcx', 'GangChaXian');
INSERT INTO `area` VALUES ('632225', '其它区', '', '632200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('632300', '黄南藏族自治州', '', '630000', '', 'hnzzzzz', 'HuangNanZangZuZiZhiZhou');
INSERT INTO `area` VALUES ('632321', '同仁县', '', '632300', '811300', 'trx', 'TongRenXian');
INSERT INTO `area` VALUES ('632322', '尖扎县', '', '632300', '811200', 'jzx', 'JianZhaXian');
INSERT INTO `area` VALUES ('632323', '泽库县', '', '632300', '811400', 'zkx', 'ZeKuXian');
INSERT INTO `area` VALUES ('632324', '河南蒙古族自治县', '', '632300', '811500', 'hnmgzzzx', 'HeNanMengGuZuZiZhiXian');
INSERT INTO `area` VALUES ('632325', '其它区', '', '632300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('632500', '海南藏族自治州', '', '630000', '', 'hnzzzzz', 'HaiNanZangZuZiZhiZhou');
INSERT INTO `area` VALUES ('632521', '共和县', '', '632500', '813000', 'ghx', 'GongHeXian');
INSERT INTO `area` VALUES ('632522', '同德县', '', '632500', '813200', 'tdx', 'TongDeXian');
INSERT INTO `area` VALUES ('632523', '贵德县', '', '632500', '811700', 'gdx', 'GuiDeXian');
INSERT INTO `area` VALUES ('632524', '兴海县', '', '632500', '813300', 'xhx', 'XingHaiXian');
INSERT INTO `area` VALUES ('632525', '贵南县', '', '632500', '813100', 'gnx', 'GuiNanXian');
INSERT INTO `area` VALUES ('632526', '其它区', '', '632500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('632600', '果洛藏族自治州', '', '630000', '', 'glzzzzz', 'GuoLuoZangZuZiZhiZhou');
INSERT INTO `area` VALUES ('632621', '玛沁县', '', '632600', '814000', 'mqx', 'MaQinXian');
INSERT INTO `area` VALUES ('632622', '班玛县', '', '632600', '814300', 'bmx', 'BanMaXian');
INSERT INTO `area` VALUES ('632623', '甘德县', '', '632600', '814100', 'gdx', 'GanDeXian');
INSERT INTO `area` VALUES ('632624', '达日县', '', '632600', '814200', 'drx', 'DaRiXian');
INSERT INTO `area` VALUES ('632625', '久治县', '', '632600', '624700', 'jzx', 'JiuZhiXian');
INSERT INTO `area` VALUES ('632626', '玛多县', '', '632600', '813500', 'mdx', 'MaDuoXian');
INSERT INTO `area` VALUES ('632627', '其它区', '', '632600', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('632700', '玉树藏族自治州', '', '630000', '', 'yszzzzz', 'YuShuZangZuZiZhiZhou');
INSERT INTO `area` VALUES ('632721', '玉树县', '', '632700', '815000', 'ysx', 'YuShuXian');
INSERT INTO `area` VALUES ('632722', '杂多县', '', '632700', '815300', 'zdx', 'ZaDuoXian');
INSERT INTO `area` VALUES ('632723', '称多县', '', '632700', '815100', 'cdx', 'ChengDuoXian');
INSERT INTO `area` VALUES ('632724', '治多县', '', '632700', '815400', 'zdx', 'ZhiDuoXian');
INSERT INTO `area` VALUES ('632725', '囊谦县', '', '632700', '815200', 'nqx', 'NangQianXian');
INSERT INTO `area` VALUES ('632726', '曲麻莱县', '', '632700', '815500', 'qmlx', 'QuMaLaiXian');
INSERT INTO `area` VALUES ('632727', '其它区', '', '632700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('632800', '海西蒙古族藏族自治州', '', '630000', '', 'hxmgzzzzzz', 'HaiXiMengGuZuZangZuZiZhiZhou');
INSERT INTO `area` VALUES ('632801', '格尔木市', '', '632800', '816000', 'gems', 'GeErMuShi');
INSERT INTO `area` VALUES ('632802', '德令哈市', '', '632800', '817000', 'dlhs', 'DeLingHaShi');
INSERT INTO `area` VALUES ('632821', '乌兰县', '', '632800', '817100', 'wlx', 'WuLanXian');
INSERT INTO `area` VALUES ('632822', '都兰县', '', '632800', '816100', 'dlx', 'DuLanXian');
INSERT INTO `area` VALUES ('632823', '天峻县', '', '632800', '817200', 'tjx', 'TianJunXian');
INSERT INTO `area` VALUES ('632824', '其它区', '', '632800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('640000', '宁夏回族自治区', '', '1', '', 'nxhzzzq', 'NingXiaHuiZuZiZhiQu');
INSERT INTO `area` VALUES ('640100', '银川市', '', '640000', '750000', 'ycs', 'YinChuanShi');
INSERT INTO `area` VALUES ('640104', '兴庆区', '', '640100', '750001', 'xqq', 'XingQingQu');
INSERT INTO `area` VALUES ('640105', '西夏区', '', '640100', '750027', 'xxq', 'XiXiaQu');
INSERT INTO `area` VALUES ('640106', '金凤区', '', '640100', '750011', 'jfq', 'JinFengQu');
INSERT INTO `area` VALUES ('640121', '永宁县', '', '640100', '750100', 'ynx', 'YongNingXian');
INSERT INTO `area` VALUES ('640122', '贺兰县', '', '640100', '750200', 'hlx', 'HeLanXian');
INSERT INTO `area` VALUES ('640181', '灵武市', '', '640100', '751400', 'lws', 'LingWuShi');
INSERT INTO `area` VALUES ('640182', '其它区', '', '640100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('640200', '石嘴山市', '', '640000', '', 'szss', 'ShiZuiShanShi');
INSERT INTO `area` VALUES ('640202', '大武口区', '', '640200', '753000', 'dwkq', 'DaWuKouQu');
INSERT INTO `area` VALUES ('640205', '惠农区', '', '640200', '753200', 'hnq', 'HuiNongQu');
INSERT INTO `area` VALUES ('640221', '平罗县', '', '640200', '753400', 'plx', 'PingLuoXian');
INSERT INTO `area` VALUES ('640222', '其它区', '', '640200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('640300', '吴忠市', '', '640000', '751100', 'wzs', 'WuZhongShi');
INSERT INTO `area` VALUES ('640302', '利通区', '', '640300', '751100', 'ltq', 'LiTongQu');
INSERT INTO `area` VALUES ('640303', '红寺堡区', '', '640300', '751900', '', '');
INSERT INTO `area` VALUES ('640323', '盐池县', '', '640300', '751500', 'ycx', 'YanChiXian');
INSERT INTO `area` VALUES ('640324', '同心县', '', '640300', '751300', 'txx', 'TongXinXian');
INSERT INTO `area` VALUES ('640381', '青铜峡市', '', '640300', '751600', 'qtxs', 'QingTongXiaShi');
INSERT INTO `area` VALUES ('640382', '其它区', '', '640300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('640400', '固原市', '', '640000', '756000', 'gys', 'GuYuanShi');
INSERT INTO `area` VALUES ('640402', '原州区', '', '640400', '756000', 'yzq', 'YuanZhouQu');
INSERT INTO `area` VALUES ('640422', '西吉县', '', '640400', '756200', 'xjx', 'XiJiXian');
INSERT INTO `area` VALUES ('640423', '隆德县', '', '640400', '756300', 'ldx', 'LongDeXian');
INSERT INTO `area` VALUES ('640424', '泾源县', '', '640400', '756400', 'jyx', 'ZuoYuanXian');
INSERT INTO `area` VALUES ('640425', '彭阳县', '', '640400', '756500', 'pyx', 'PengYangXian');
INSERT INTO `area` VALUES ('640426', '其它区', '', '640400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('640500', '中卫市', '', '640000', '', 'zws', 'ZhongWeiShi');
INSERT INTO `area` VALUES ('640502', '沙坡头区', '', '640500', '751700', 'sptq', 'ShaPoTouQu');
INSERT INTO `area` VALUES ('640521', '中宁县', '', '640500', '751200', 'znx', 'ZhongNingXian');
INSERT INTO `area` VALUES ('640522', '海原县', '', '640500', '756100', 'hyx', 'HaiYuanXian');
INSERT INTO `area` VALUES ('640523', '其它区', '', '640500', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('650000', '新疆维吾尔自治区', '', '1', '', 'xjwwezzq', 'XinJiangWeiWuErZiZhiQu');
INSERT INTO `area` VALUES ('650100', '乌鲁木齐市', '', '650000', '830000', 'wlmqs', 'WuLuMuQiShi');
INSERT INTO `area` VALUES ('650102', '天山区', '', '650100', '830002', 'tsq', 'TianShanQu');
INSERT INTO `area` VALUES ('650103', '沙依巴克区', '', '650100', '830000', 'sybkq', 'ShaYiBaKeQu');
INSERT INTO `area` VALUES ('650104', '新市区', '', '650100', '830011', 'xsq', 'XinShiQu');
INSERT INTO `area` VALUES ('650105', '水磨沟区', '', '650100', '830017', 'smgq', 'ShuiMoGouQu');
INSERT INTO `area` VALUES ('650106', '头屯河区', '', '650100', '830023', 'tthq', 'TouTunHeQu');
INSERT INTO `area` VALUES ('650107', '达坂城区', '', '650100', '830039', 'dbcq', 'DaZuoChengQu');
INSERT INTO `area` VALUES ('650108', '东山区', '', '650100', '830019', 'dsq', 'DongShanQu');
INSERT INTO `area` VALUES ('650109', '米东区', '', '650100', '831400', 'mdq', 'MiDongQu');
INSERT INTO `area` VALUES ('650121', '乌鲁木齐县', '', '650100', '830063', 'wlmqx', 'WuLuMuQiXian');
INSERT INTO `area` VALUES ('650122', '其它区', '', '650100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('650200', '克拉玛依市', '', '650000', '834000', 'klmys', 'KeLaMaYiShi');
INSERT INTO `area` VALUES ('650202', '独山子区', '', '650200', '838600', 'dszq', 'DuShanZiQu');
INSERT INTO `area` VALUES ('650203', '克拉玛依区', '', '650200', '834000', 'klmyq', 'KeLaMaYiQu');
INSERT INTO `area` VALUES ('650204', '白碱滩区', '', '650200', '834009', 'bjtq', 'BaiJianTanQu');
INSERT INTO `area` VALUES ('650205', '乌尔禾区', '', '650200', '834014', 'wehq', 'WuErHeQu');
INSERT INTO `area` VALUES ('650206', '其它区', '', '650200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('652100', '吐鲁番地区', '', '650000', '838000', 'tlfdq', 'TuLuFanDiQu');
INSERT INTO `area` VALUES ('652101', '吐鲁番市', '', '652100', '838000', 'tlfs', 'TuLuFanShi');
INSERT INTO `area` VALUES ('652122', '鄯善县', '', '652100', '838200', 'ssx', 'ZuoShanXian');
INSERT INTO `area` VALUES ('652123', '托克逊县', '', '652100', '838100', 'tkxx', 'TuoKeXunXian');
INSERT INTO `area` VALUES ('652124', '其它区', '', '652100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('652200', '哈密地区', '', '650000', '839000', 'hmdq', 'HaMiDiQu');
INSERT INTO `area` VALUES ('652201', '哈密市', '', '652200', '839000', 'hms', 'HaMiShi');
INSERT INTO `area` VALUES ('652222', '巴里坤哈萨克自治县', '', '652200', '839200', 'blkhskzzx', 'BaLiKunHaSaKeZiZhiXian');
INSERT INTO `area` VALUES ('652223', '伊吾县', '', '652200', '839300', 'ywx', 'YiWuXian');
INSERT INTO `area` VALUES ('652224', '其它区', '', '652200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('652300', '昌吉回族自治州', '', '650000', '831100', 'cjhzzzz', 'ChangJiHuiZuZiZhiZhou');
INSERT INTO `area` VALUES ('652301', '昌吉市', '', '652300', '831100', 'cjs', 'ChangJiShi');
INSERT INTO `area` VALUES ('652302', '阜康市', '', '652300', '831500', 'fks', 'FuKangShi');
INSERT INTO `area` VALUES ('652303', '米泉市', '', '652300', '831400', 'mqs', 'MiQuanShi');
INSERT INTO `area` VALUES ('652323', '呼图壁县', '', '652300', '831200', 'htbx', 'HuTuBiXian');
INSERT INTO `area` VALUES ('652324', '玛纳斯县', '', '652300', '832200', 'mnsx', 'MaNaSiXian');
INSERT INTO `area` VALUES ('652325', '奇台县', '', '652300', '831800', 'qtx', 'QiTaiXian');
INSERT INTO `area` VALUES ('652327', '吉木萨尔县', '', '652300', '831700', 'jmsex', 'JiMuSaErXian');
INSERT INTO `area` VALUES ('652328', '木垒哈萨克自治县', '', '652300', '831900', 'mlhskzzx', 'MuLeiHaSaKeZiZhiXian');
INSERT INTO `area` VALUES ('652329', '其它区', '', '652300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('652700', '博尔塔拉蒙古自治州', '', '650000', '833400', 'betlmgzzz', 'BoErTaLaMengGuZiZhiZhou');
INSERT INTO `area` VALUES ('652701', '博乐市', '', '652700', '833400', 'bls', 'BoLeShi');
INSERT INTO `area` VALUES ('652722', '精河县', '', '652700', '833300', 'jhx', 'JingHeXian');
INSERT INTO `area` VALUES ('652723', '温泉县', '', '652700', '833500', 'wqx', 'WenQuanXian');
INSERT INTO `area` VALUES ('652724', '其它区', '', '652700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('652800', '巴音郭楞蒙古自治州', '', '650000', '841000', 'byglmgzzz', 'BaYinGuoLengMengGuZiZhiZhou');
INSERT INTO `area` VALUES ('652801', '库尔勒市', '', '652800', '841000', 'kels', 'KuErLeShi');
INSERT INTO `area` VALUES ('652822', '轮台县', '', '652800', '841600', 'ltx', 'LunTaiXian');
INSERT INTO `area` VALUES ('652823', '尉犁县', '', '652800', '841500', 'wlx', 'WeiLiXian');
INSERT INTO `area` VALUES ('652824', '若羌县', '', '652800', '841800', 'rqx', 'RuoQiangXian');
INSERT INTO `area` VALUES ('652825', '且末县', '', '652800', '841900', 'qmx', 'QieMoXian');
INSERT INTO `area` VALUES ('652826', '焉耆回族自治县', '', '652800', '841100', 'yqhzzzx', 'YanZuoHuiZuZiZhiXian');
INSERT INTO `area` VALUES ('652827', '和静县', '', '652800', '841300', 'hjx', 'HeJingXian');
INSERT INTO `area` VALUES ('652828', '和硕县', '', '652800', '841200', 'hsx', 'HeShuoXian');
INSERT INTO `area` VALUES ('652829', '博湖县', '', '652800', '841400', 'bhx', 'BoHuXian');
INSERT INTO `area` VALUES ('652830', '其它区', '', '652800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('652900', '阿克苏地区', '', '650000', '843000', 'aksdq', 'AKeSuDiQu');
INSERT INTO `area` VALUES ('652901', '阿克苏市', '', '652900', '843000', 'akss', 'AKeSuShi');
INSERT INTO `area` VALUES ('652922', '温宿县', '', '652900', '843100', 'wsx', 'WenSuXian');
INSERT INTO `area` VALUES ('652923', '库车县', '', '652900', '842000', 'kcx', 'KuCheXian');
INSERT INTO `area` VALUES ('652924', '沙雅县', '', '652900', '842200', 'syx', 'ShaYaXian');
INSERT INTO `area` VALUES ('652925', '新和县', '', '652900', '842100', 'xhx', 'XinHeXian');
INSERT INTO `area` VALUES ('652926', '拜城县', '', '652900', '842300', 'bcx', 'BaiChengXian');
INSERT INTO `area` VALUES ('652927', '乌什县', '', '652900', '843400', 'wsx', 'WuShiXian');
INSERT INTO `area` VALUES ('652928', '阿瓦提县', '', '652900', '843200', 'awtx', 'AWaTiXian');
INSERT INTO `area` VALUES ('652929', '柯坪县', '', '652900', '843600', 'kpx', 'KePingXian');
INSERT INTO `area` VALUES ('652930', '其它区', '', '652900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('653000', '克孜勒苏柯尔克孜自治州', '', '650000', '845350', 'kzlskekzzzz', 'KeZiLeSuKeErKeZiZiZhi');
INSERT INTO `area` VALUES ('653001', '阿图什市', '', '653000', '845350', 'atss', 'ATuShiShi');
INSERT INTO `area` VALUES ('653022', '阿克陶县', '', '653000', '845550', 'aktx', 'AKeTaoXian');
INSERT INTO `area` VALUES ('653023', '阿合奇县', '', '653000', '843500', 'ahqx', 'AHeQiXian');
INSERT INTO `area` VALUES ('653024', '乌恰县', '', '653000', '845450', 'wqx', 'WuQiaXian');
INSERT INTO `area` VALUES ('653025', '其它区', '', '653000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('653100', '喀什地区', '', '650000', '844000', 'ksdq', 'KaShiDiQu');
INSERT INTO `area` VALUES ('653101', '喀什市', '', '653100', '844000', 'kss', 'KaShiShi');
INSERT INTO `area` VALUES ('653121', '疏附县', '', '653100', '844100', 'sfx', 'ShuFuXian');
INSERT INTO `area` VALUES ('653122', '疏勒县', '', '653100', '844200', 'slx', 'ShuLeXian');
INSERT INTO `area` VALUES ('653123', '英吉沙县', '', '653100', '844500', 'yjsx', 'YingJiShaXian');
INSERT INTO `area` VALUES ('653124', '泽普县', '', '653100', '844800', 'zpx', 'ZePuXian');
INSERT INTO `area` VALUES ('653125', '莎车县', '', '653100', '844700', 'scx', 'ShaCheXian');
INSERT INTO `area` VALUES ('653126', '叶城县', '', '653100', '844900', 'ycx', 'YeChengXian');
INSERT INTO `area` VALUES ('653127', '麦盖提县', '', '653100', '844600', 'mgtx', 'MaiGaiTiXian');
INSERT INTO `area` VALUES ('653128', '岳普湖县', '', '653100', '844400', 'yphx', 'YuePuHuXian');
INSERT INTO `area` VALUES ('653129', '伽师县', '', '653100', '844300', 'qsx', 'ZuoShiXian');
INSERT INTO `area` VALUES ('653130', '巴楚县', '', '653100', '843800', 'bcx', 'BaChuXian');
INSERT INTO `area` VALUES ('653131', '塔什库尔干塔吉克自治县', '', '653100', '845250', 'tskegtjkzzx', 'TaShiKuErGanTaJiKeZiZhi');
INSERT INTO `area` VALUES ('653132', '其它区', '', '653100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('653200', '和田地区', '', '650000', '848000', 'htdq', 'HeTianDiQu');
INSERT INTO `area` VALUES ('653201', '和田市', '', '653200', '848000', 'hts', 'HeTianShi');
INSERT INTO `area` VALUES ('653221', '和田县', '', '653200', '848000', 'htx', 'HeTianXian');
INSERT INTO `area` VALUES ('653222', '墨玉县', '', '653200', '848100', 'myx', 'MoYuXian');
INSERT INTO `area` VALUES ('653223', '皮山县', '', '653200', '845150', 'psx', 'PiShanXian');
INSERT INTO `area` VALUES ('653224', '洛浦县', '', '653200', '848200', 'lpx', 'LuoPuXian');
INSERT INTO `area` VALUES ('653225', '策勒县', '', '653200', '848300', 'clx', 'CeLeXian');
INSERT INTO `area` VALUES ('653226', '于田县', '', '653200', '848400', 'ytx', 'YuTianXian');
INSERT INTO `area` VALUES ('653227', '民丰县', '', '653200', '848500', 'mfx', 'MinFengXian');
INSERT INTO `area` VALUES ('653228', '其它区', '', '653200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('654000', '伊犁哈萨克自治州', '', '650000', '835000', 'ylhskzzz', 'YiLiHaSaKeZiZhiZhou');
INSERT INTO `area` VALUES ('654002', '伊宁市', '', '654000', '835000', 'yns', 'YiNingShi');
INSERT INTO `area` VALUES ('654003', '奎屯市', '', '654000', '833200', 'kts', 'KuiTunShi');
INSERT INTO `area` VALUES ('654021', '伊宁县', '', '654000', '835100', 'ynx', 'YiNingXian');
INSERT INTO `area` VALUES ('654022', '察布查尔锡伯自治县', '', '654000', '835300', 'cbcexbzzx', 'ChaBuChaErXiBoZiZhiXian');
INSERT INTO `area` VALUES ('654023', '霍城县', '', '654000', '835200', 'hcx', 'HuoChengXian');
INSERT INTO `area` VALUES ('654024', '巩留县', '', '654000', '835400', 'glx', 'GongLiuXian');
INSERT INTO `area` VALUES ('654025', '新源县', '', '654000', '835800', 'xyx', 'XinYuanXian');
INSERT INTO `area` VALUES ('654026', '昭苏县', '', '654000', '835600', 'zsx', 'ZhaoSuXian');
INSERT INTO `area` VALUES ('654027', '特克斯县', '', '654000', '835500', 'tksx', 'TeKeSiXian');
INSERT INTO `area` VALUES ('654028', '尼勒克县', '', '654000', '835700', 'nlkx', 'NiLeKeXian');
INSERT INTO `area` VALUES ('654029', '其它区', '', '654000', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('654200', '塔城地区', '', '650000', '834700', 'tcdq', 'TaChengDiQu');
INSERT INTO `area` VALUES ('654201', '塔城市', '', '654200', '834700', 'tcs', 'TaChengShi');
INSERT INTO `area` VALUES ('654202', '乌苏市', '', '654200', '833000', 'wss', 'WuSuShi');
INSERT INTO `area` VALUES ('654221', '额敏县', '', '654200', '834600', 'emx', 'EMinXian');
INSERT INTO `area` VALUES ('654223', '沙湾县', '', '654200', '832100', 'swx', 'ShaWanXian');
INSERT INTO `area` VALUES ('654224', '托里县', '', '654200', '834500', 'tlx', 'TuoLiXian');
INSERT INTO `area` VALUES ('654225', '裕民县', '', '654200', '834800', 'ymx', 'YuMinXian');
INSERT INTO `area` VALUES ('654226', '和布克赛尔蒙古自治县', '', '654200', '834400', 'hbksemgzzx', 'HeBuKeSaiErMengGuZiZhiXian');
INSERT INTO `area` VALUES ('654227', '其它区', '', '654200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('654300', '阿勒泰地区', '', '650000', '836500', 'altdq', 'ALeTaiDiQu');
INSERT INTO `area` VALUES ('654301', '阿勒泰市', '', '654300', '836500', 'alts', 'ALeTaiShi');
INSERT INTO `area` VALUES ('654321', '布尔津县', '', '654300', '836600', 'bejx', 'BuErJinXian');
INSERT INTO `area` VALUES ('654322', '富蕴县', '', '654300', '836100', 'fyx', 'FuYunXian');
INSERT INTO `area` VALUES ('654323', '福海县', '', '654300', '836400', 'fhx', 'FuHaiXian');
INSERT INTO `area` VALUES ('654324', '哈巴河县', '', '654300', '836700', 'hbhx', 'HaBaHeXian');
INSERT INTO `area` VALUES ('654325', '青河县', '', '654300', '836200', 'qhx', 'QingHeXian');
INSERT INTO `area` VALUES ('654326', '吉木乃县', '', '654300', '836800', 'jmnx', 'JiMuNaiXian');
INSERT INTO `area` VALUES ('654327', '其它区', '', '654300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('659001', '石河子市', '', '650000', '832000', 'shzs', 'ShiHeZiShi');
INSERT INTO `area` VALUES ('659002', '阿拉尔市', '', '650000', '843300', 'ales', 'ALaErShi');
INSERT INTO `area` VALUES ('659003', '图木舒克市', '', '650000', '843806', 'tmsks', 'TuMuShuKeShi');
INSERT INTO `area` VALUES ('659004', '五家渠市', '', '650000', '831300', 'wjqs', 'WuJiaQuShi');
INSERT INTO `area` VALUES ('710000', '台湾省', '', '1', '', 'tws', 'TaiWanSheng');
INSERT INTO `area` VALUES ('710100', '台北市', '', '710000', '', 'tbs', 'TaiBeiShi');
INSERT INTO `area` VALUES ('710101', '中正区', '', '710100', '100', 'zzq', 'ZhongZhengQu');
INSERT INTO `area` VALUES ('710102', '大同区', '', '710100', '103', 'dtq', 'DaTongQu');
INSERT INTO `area` VALUES ('710103', '中山区', '', '710100', '104', 'zsq', 'ZhongShanQu');
INSERT INTO `area` VALUES ('710104', '松山区', '', '710100', '105', 'ssq', 'SongShanQu');
INSERT INTO `area` VALUES ('710105', '大安区', '', '710100', '106', 'daq', 'DaAnQu');
INSERT INTO `area` VALUES ('710106', '万华区', '', '710100', '108', 'whq', 'WanHuaQu');
INSERT INTO `area` VALUES ('710107', '信义区', '', '710100', '110', 'xyq', 'XinYiQu');
INSERT INTO `area` VALUES ('710108', '士林区', '', '710100', '111', 'slq', 'ShiLinQu');
INSERT INTO `area` VALUES ('710109', '北投区', '', '710100', '112', 'btq', 'BeiTouQu');
INSERT INTO `area` VALUES ('710110', '内湖区', '', '710100', '114', 'nhq', 'NeiHuQu');
INSERT INTO `area` VALUES ('710111', '南港区', '', '710100', '115', 'ngq', 'NanGangQu');
INSERT INTO `area` VALUES ('710112', '文山区', '', '710100', '116', 'wsq', 'WenShanQu');
INSERT INTO `area` VALUES ('710113', '其它区', '', '710100', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('710200', '高雄市', '', '710000', '', 'gxs', 'GaoXiongShi');
INSERT INTO `area` VALUES ('710201', '新兴区', '', '710200', '800', 'xxq', 'XinXingQu');
INSERT INTO `area` VALUES ('710202', '前金区', '', '710200', '801', 'qjq', 'QianJinQu');
INSERT INTO `area` VALUES ('710203', '芩雅区', '', '710200', '802', 'qyq', 'ZuoYaQu');
INSERT INTO `area` VALUES ('710204', '盐埕区', '', '710200', '803', 'ycq', 'YanZuoQu');
INSERT INTO `area` VALUES ('710205', '鼓山区', '', '710200', '804', 'gsq', 'GuShanQu');
INSERT INTO `area` VALUES ('710206', '旗津区', '', '710200', '805', 'qjq', 'QiJinQu');
INSERT INTO `area` VALUES ('710207', '前镇区', '', '710200', '806', 'qzq', 'QianZhenQu');
INSERT INTO `area` VALUES ('710208', '三民区', '', '710200', '807', 'smq', 'SanMinQu');
INSERT INTO `area` VALUES ('710209', '左营区', '', '710200', '813', 'zyq', 'ZuoYingQu');
INSERT INTO `area` VALUES ('710210', '楠梓区', '', '710200', '811', 'nzq', 'ZuoZuoQu');
INSERT INTO `area` VALUES ('710211', '小港区', '', '710200', '812', 'xgq', 'XiaoGangQu');
INSERT INTO `area` VALUES ('710212', '其它区', '', '710200', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('710300', '台南市', '', '710000', '', 'tns', 'TaiNanShi');
INSERT INTO `area` VALUES ('710301', '中西区', '', '710300', '703', 'zxq', 'ZhongXiQu');
INSERT INTO `area` VALUES ('710302', '东区', '', '710300', '701', 'dq', 'DongQu');
INSERT INTO `area` VALUES ('710303', '南区', '', '710300', '702', 'nq', 'NanQu');
INSERT INTO `area` VALUES ('710304', '北区', '', '710300', '704', 'bq', 'BeiQu');
INSERT INTO `area` VALUES ('710305', '安平区', '', '710300', '708', 'apq', 'AnPingQu');
INSERT INTO `area` VALUES ('710306', '安南区', '', '710300', '709', 'anq', 'AnNanQu');
INSERT INTO `area` VALUES ('710307', '其它区', '', '710300', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('710400', '台中市', '', '710000', '', 'tzs', 'TaiZhongShi');
INSERT INTO `area` VALUES ('710401', '中区', '', '710400', '400', 'zq', 'ZhongQu');
INSERT INTO `area` VALUES ('710402', '东区', '', '710400', '401', 'dq', 'DongQu');
INSERT INTO `area` VALUES ('710403', '南区', '', '710400', '402', 'nq', 'NanQu');
INSERT INTO `area` VALUES ('710404', '西区', '', '710400', '403', 'xq', 'XiQu');
INSERT INTO `area` VALUES ('710405', '北区', '', '710400', '404', 'bq', 'BeiQu');
INSERT INTO `area` VALUES ('710406', '北屯区', '', '710400', '406', 'btq', 'BeiTunQu');
INSERT INTO `area` VALUES ('710407', '西屯区', '', '710400', '407', 'xtq', 'XiTunQu');
INSERT INTO `area` VALUES ('710408', '南屯区', '', '710400', '408', 'ntq', 'NanTunQu');
INSERT INTO `area` VALUES ('710409', '其它区', '', '710400', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('710500', '金门县', '', '710000', '', 'jmx', 'JinMenXian');
INSERT INTO `area` VALUES ('710600', '南投县', '', '710000', '', 'ntx', 'NanTouXian');
INSERT INTO `area` VALUES ('710700', '基隆市', '', '710000', '', 'jls', 'JiLongShi');
INSERT INTO `area` VALUES ('710701', '仁爱区', '', '710700', '200', 'raq', 'RenAiQu');
INSERT INTO `area` VALUES ('710702', '信义区', '', '710700', '201', 'xyq', 'XinYiQu');
INSERT INTO `area` VALUES ('710703', '中正区', '', '710700', '202', 'zzq', 'ZhongZhengQu');
INSERT INTO `area` VALUES ('710704', '中山区', '', '710700', '203', 'zsq', 'ZhongShanQu');
INSERT INTO `area` VALUES ('710705', '安乐区', '', '710700', '204', 'alq', 'AnLeQu');
INSERT INTO `area` VALUES ('710706', '暖暖区', '', '710700', '205', 'nnq', 'NuanNuanQu');
INSERT INTO `area` VALUES ('710707', '七堵区', '', '710700', '206', 'qdq', 'QiDuQu');
INSERT INTO `area` VALUES ('710708', '其它区', '', '710700', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('710800', '新竹市', '', '710000', '', 'xzs', 'XinZhuShi');
INSERT INTO `area` VALUES ('710801', '东区', '', '710800', '', 'dq', 'DongQu');
INSERT INTO `area` VALUES ('710802', '北区', '', '710800', '', 'bq', 'BeiQu');
INSERT INTO `area` VALUES ('710803', '香山区', '', '710800', '', 'xsq', 'XiangShanQu');
INSERT INTO `area` VALUES ('710804', '其它区', '', '710800', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('710900', '嘉义市', '', '710000', '', 'jys', 'JiaYiShi');
INSERT INTO `area` VALUES ('710901', '东区', '', '710900', '', 'dq', 'DongQu');
INSERT INTO `area` VALUES ('710902', '西区', '', '710900', '', 'xq', 'XiQu');
INSERT INTO `area` VALUES ('710903', '其它区', '', '710900', '', 'qtq', 'QiTaQu');
INSERT INTO `area` VALUES ('711100', '新北市', '', '710000', '', 'tbx', 'TaiBeiXian');
INSERT INTO `area` VALUES ('711200', '宜兰县', '', '710000', '', 'ylx', 'YiLanXian');
INSERT INTO `area` VALUES ('711300', '新竹县', '', '710000', '', 'xzx', 'XinZhuXian');
INSERT INTO `area` VALUES ('711400', '桃园县', '', '710000', '', 'tyx', 'TaoYuanXian');
INSERT INTO `area` VALUES ('711500', '苗栗县', '', '710000', '', 'mlx', 'MiaoLiXian');
INSERT INTO `area` VALUES ('711600', '台中县', '', '710000', '', 'tzx', 'TaiZhongXian');
INSERT INTO `area` VALUES ('711700', '彰化县', '', '710000', '', 'zhx', 'ZhangHuaXian');
INSERT INTO `area` VALUES ('711900', '嘉义县', '', '710000', '', 'jyx', 'JiaYiXian');
INSERT INTO `area` VALUES ('712100', '云林县', '', '710000', '', 'ylx', 'YunLinXian');
INSERT INTO `area` VALUES ('712200', '台南县', '', '710000', '', 'tnx', 'TaiNanXian');
INSERT INTO `area` VALUES ('712300', '高雄县', '', '710000', '', 'gxx', 'GaoXiongXian');
INSERT INTO `area` VALUES ('712400', '屏东县', '', '710000', '', 'pdx', 'PingDongXian');
INSERT INTO `area` VALUES ('712500', '台东县', '', '710000', '', 'tdx', 'TaiDongXian');
INSERT INTO `area` VALUES ('712600', '花莲县', '', '710000', '', 'hlx', 'HuaLianXian');
INSERT INTO `area` VALUES ('712700', '澎湖县', '', '710000', '', 'phx', 'PengHuXian');
INSERT INTO `area` VALUES ('810000', '香港特别行政区', '', '1', '999077', 'xgtbxzq', 'XiangGangTeBieXingZhengQu');
INSERT INTO `area` VALUES ('810100', '香港岛', '', '810000', '999077', 'xgd', 'XiangGangDao');
INSERT INTO `area` VALUES ('810101', '中西区', '', '810100', '810101', '', '');
INSERT INTO `area` VALUES ('810102', '湾仔', '', '810100', '810102', '', '');
INSERT INTO `area` VALUES ('810103', '东区', '', '810100', '810103', '', '');
INSERT INTO `area` VALUES ('810104', '南区', '', '810100', '810104', '', '');
INSERT INTO `area` VALUES ('810200', '九龙', '', '810000', '', 'jl', 'JiuLong');
INSERT INTO `area` VALUES ('810201', '九龙城区', '', '810200', '810201', '', '');
INSERT INTO `area` VALUES ('810202', '油尖旺区', '', '810200', '810202', '', '');
INSERT INTO `area` VALUES ('810203', '深水埗区', '', '810200', '810203', '', '');
INSERT INTO `area` VALUES ('810204', '黄大仙区', '', '810200', '810204', '', '');
INSERT INTO `area` VALUES ('810205', '观塘区', '', '810200', '810205', '', '');
INSERT INTO `area` VALUES ('810300', '新界', '', '810000', '', 'xj', 'XinJie');
INSERT INTO `area` VALUES ('810301', '北区', '', '810300', '810301', '', '');
INSERT INTO `area` VALUES ('810302', '大埔区', '', '810300', '810302', '', '');
INSERT INTO `area` VALUES ('810303', '沙田区', '', '810300', '810303', '', '');
INSERT INTO `area` VALUES ('810304', '西贡区', '', '810300', '810304', '', '');
INSERT INTO `area` VALUES ('810305', '元朗区', '', '810300', '810305', '', '');
INSERT INTO `area` VALUES ('810306', '屯门区', '', '810300', '810306', '', '');
INSERT INTO `area` VALUES ('810307', '荃湾区', '', '810300', '810307', '', '');
INSERT INTO `area` VALUES ('810308', '葵青区', '', '810300', '810308', '', '');
INSERT INTO `area` VALUES ('810309', '离岛区', '', '810300', '810309', '', '');
INSERT INTO `area` VALUES ('820000', '澳门特别行政区', '', '1', '', 'amtbxzq', 'AoMenTeBieXingZhengQu');
INSERT INTO `area` VALUES ('820100', '澳门半岛', '', '820000', '', 'ambd', 'AoMenBanDao');
INSERT INTO `area` VALUES ('820200', '离岛', '', '820000', '', 'ld', 'LiDao');
INSERT INTO `area` VALUES ('990000', '海外', '', '1', '', 'hw', 'HaiWai');
INSERT INTO `area` VALUES ('990100', '海外', '', '990000', '', 'hw', 'HaiWai');

-- ----------------------------
-- Table structure for businesslicence
-- ----------------------------
DROP TABLE IF EXISTS `businesslicence`;
CREATE TABLE `businesslicence` (
  `LicenceCode` varchar(15) NOT NULL,
  `ConpanyName` varchar(100) DEFAULT NULL,
  `CompanyType` varchar(100) DEFAULT NULL,
  `CompanyAddress` varchar(100) DEFAULT NULL,
  `CompanyRegister` varchar(20) DEFAULT NULL,
  `RegistMoney` decimal(18,0) DEFAULT NULL,
  `BuildTime` date DEFAULT NULL,
  `BusinessEndTime` datetime DEFAULT NULL,
  `BusinessScope` varchar(100) DEFAULT NULL,
  `AuditingDepartment` varchar(100) DEFAULT NULL,
  `RegistTime` date DEFAULT NULL,
  `PictureUrl` varchar(1000) DEFAULT NULL,
  `orgid` char(12) NOT NULL,
  PRIMARY KEY (`LicenceCode`),
  KEY `Refonlineorg42` (`orgid`),
  CONSTRAINT `Refonlineorg42` FOREIGN KEY (`orgid`) REFERENCES `onlineorg` (`orgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of businesslicence
-- ----------------------------

-- ----------------------------
-- Table structure for detectpic
-- ----------------------------
DROP TABLE IF EXISTS `detectpic`;
CREATE TABLE `detectpic` (
  `DetectPicID` char(36) NOT NULL,
  `UploadTime` datetime DEFAULT NULL,
  `PicType` varchar(10) DEFAULT NULL,
  `picpath` varchar(1000) DEFAULT NULL,
  `wbRepairListId` char(36) NOT NULL,
  `ProjectId` char(4) NOT NULL,
  PRIMARY KEY (`DetectPicID`),
  KEY `RefwbRepairInfo83` (`wbRepairListId`,`ProjectId`),
  CONSTRAINT `RefwbRepairInfo83` FOREIGN KEY (`wbRepairListId`, `ProjectId`) REFERENCES `wbrepairinfo` (`wbRepairListId`, `ProjectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of detectpic
-- ----------------------------

-- ----------------------------
-- Table structure for devices
-- ----------------------------
DROP TABLE IF EXISTS `devices`;
CREATE TABLE `devices` (
  `deviceaddress` varchar(30) NOT NULL,
  `Sysaddress` int(11) NOT NULL,
  `Gatewayaddress` varchar(30) NOT NULL,
  `vdesc` varchar(500) DEFAULT NULL,
  `dRecorddate` datetime DEFAULT NULL,
  `fPositionX` float(8,0) DEFAULT NULL,
  `fPositionY` float(8,0) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `Manufacture` varchar(50) DEFAULT NULL,
  `Model` varchar(50) DEFAULT NULL,
  `ProductDate` datetime DEFAULT NULL,
  `expdate` datetime DEFAULT NULL,
  `memo` varchar(1000) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `StateValue` int(11) DEFAULT NULL,
  `StateTime` datetime DEFAULT NULL,
  `DeviceNo` int(11) DEFAULT NULL,
  `HostID` varchar(10) DEFAULT NULL,
  `Road` varchar(10) DEFAULT NULL,
  `address` varchar(10) DEFAULT NULL,
  `cFlatPic` char(14) DEFAULT NULL,
  `iDeviceType` int(11) DEFAULT NULL,
  PRIMARY KEY (`deviceaddress`,`Sysaddress`,`Gatewayaddress`),
  KEY `Refflatpic21` (`cFlatPic`),
  KEY `Refdevicetype126` (`iDeviceType`),
  KEY `RefGatewaySystemInfo141` (`Sysaddress`,`Gatewayaddress`),
  CONSTRAINT `Refdevicetype126` FOREIGN KEY (`iDeviceType`) REFERENCES `devicetype` (`iDeviceType`),
  CONSTRAINT `Refflatpic21` FOREIGN KEY (`cFlatPic`) REFERENCES `flatpic` (`cFlatPic`),
  CONSTRAINT `RefGatewaySystemInfo141` FOREIGN KEY (`Sysaddress`, `Gatewayaddress`) REFERENCES `gatewaysysteminfo` (`Sysaddress`, `Gatewayaddress`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of devices
-- ----------------------------

-- ----------------------------
-- Table structure for devicestate
-- ----------------------------
DROP TABLE IF EXISTS `devicestate`;
CREATE TABLE `devicestate` (
  `bideviceStateID` bigint(20) NOT NULL,
  `iSystype` int(11) DEFAULT NULL,
  `iSysaddress` int(11) DEFAULT NULL,
  `iDeviceType` int(11) DEFAULT NULL,
  `iDeviceAddress` varchar(30) NOT NULL,
  `StateValue` int(11) DEFAULT NULL,
  `w0` char(1) DEFAULT NULL,
  `w1` char(1) DEFAULT NULL,
  `w2` char(1) DEFAULT NULL,
  `w3` char(1) DEFAULT NULL,
  `w4` char(1) DEFAULT NULL,
  `w5` char(1) DEFAULT NULL,
  `w6` char(1) DEFAULT NULL,
  `w7` char(1) DEFAULT NULL,
  `w8` char(1) DEFAULT NULL,
  `w9` char(1) DEFAULT NULL,
  `w10` char(1) DEFAULT NULL,
  `w11` char(1) DEFAULT NULL,
  `w12` char(1) DEFAULT NULL,
  `w13` char(1) DEFAULT NULL,
  `w14` char(1) DEFAULT NULL,
  `w15` char(1) DEFAULT NULL,
  `dStateoccurtime` datetime DEFAULT NULL,
  `dReceiveTime` datetime DEFAULT NULL,
  `Gatewayaddress` varchar(30) NOT NULL,
  PRIMARY KEY (`bideviceStateID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of devicestate
-- ----------------------------

-- ----------------------------
-- Table structure for devicetype
-- ----------------------------
DROP TABLE IF EXISTS `devicetype`;
CREATE TABLE `devicetype` (
  `iDeviceType` int(11) NOT NULL,
  `DeviceTypeName` varchar(100) DEFAULT NULL,
  `tiSysType` int(11) NOT NULL,
  PRIMARY KEY (`iDeviceType`),
  KEY `Reffiresystype124` (`tiSysType`),
  CONSTRAINT `Reffiresystype124` FOREIGN KEY (`tiSysType`) REFERENCES `firesystype` (`tiSysType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of devicetype
-- ----------------------------
INSERT INTO `devicetype` VALUES ('0', '通用', '0');
INSERT INTO `devicetype` VALUES ('1', '火灾报警控制器', '1');
INSERT INTO `devicetype` VALUES ('10', '可燃气体探测器', '1');
INSERT INTO `devicetype` VALUES ('11', '点型可燃气体探测器', '0');
INSERT INTO `devicetype` VALUES ('12', '独立式可燃气体探测器', '1');
INSERT INTO `devicetype` VALUES ('13', '线型可燃气体探测器', '0');
INSERT INTO `devicetype` VALUES ('16', '电气火灾监控报警器', '1');
INSERT INTO `devicetype` VALUES ('17', '剩余电流式电气火灾监控探测器', '1');
INSERT INTO `devicetype` VALUES ('18', '测温式电气火灾监控探测器', '1');
INSERT INTO `devicetype` VALUES ('21', '探测回路', '1');
INSERT INTO `devicetype` VALUES ('22', '火灾显示盘', '1');
INSERT INTO `devicetype` VALUES ('23', '手动火灾报警按钮', '1');
INSERT INTO `devicetype` VALUES ('24', '消火栓按钮', '1');
INSERT INTO `devicetype` VALUES ('25', '火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('30', '感温火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('31', '点型感温火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('32', '点型火灾探测器（S型）', '1');
INSERT INTO `devicetype` VALUES ('33', '点型火灾探测器（R型）', '1');
INSERT INTO `devicetype` VALUES ('34', '线型感温火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('35', '线型火灾探测器（S型）', '1');
INSERT INTO `devicetype` VALUES ('36', '线型火灾探测器（R型）', '1');
INSERT INTO `devicetype` VALUES ('37', '光纤感温火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('40', '感烟火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('41', '点型离子感烟火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('42', '点型光电感烟火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('43', '线型光束感烟火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('44', '吸气式感烟火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('50', '复合式火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('51', '复合式感烟感温火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('52', '复合式感光感温火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('53', '复合式感光感烟火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('61', '紫外火焰探测器', '1');
INSERT INTO `devicetype` VALUES ('62', '红外火焰探测器', '1');
INSERT INTO `devicetype` VALUES ('69', '感光火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('74', '气体探测器', '1');
INSERT INTO `devicetype` VALUES ('78', '图象摄像方式火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('79', '感声火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('81', '气体灭火控制器', '1');
INSERT INTO `devicetype` VALUES ('82', '消防电气控制装置', '1');
INSERT INTO `devicetype` VALUES ('83', '消防控制室图形显示装置', '1');
INSERT INTO `devicetype` VALUES ('84', '模块', '1');
INSERT INTO `devicetype` VALUES ('85', '输入模块', '24');
INSERT INTO `devicetype` VALUES ('87', '输入/输出模块', '24');
INSERT INTO `devicetype` VALUES ('88', '中继模块', '24');
INSERT INTO `devicetype` VALUES ('90', '消防广播', '21');
INSERT INTO `devicetype` VALUES ('91', '消防水泵', '132');
INSERT INTO `devicetype` VALUES ('93', '稳压泵', '132');
INSERT INTO `devicetype` VALUES ('95', '喷淋泵', '132');
INSERT INTO `devicetype` VALUES ('96', '水流指示器', '12');
INSERT INTO `devicetype` VALUES ('97', '信号阀', '12');
INSERT INTO `devicetype` VALUES ('98', '报警阀', '16');
INSERT INTO `devicetype` VALUES ('99', '压力开关', '12');
INSERT INTO `devicetype` VALUES ('101', '阀驱动装置', '1');
INSERT INTO `devicetype` VALUES ('102', '防火门', '19');
INSERT INTO `devicetype` VALUES ('103', '防火阀', '19');
INSERT INTO `devicetype` VALUES ('104', '通风空调', '18');
INSERT INTO `devicetype` VALUES ('105', '泡沫液泵', '16');
INSERT INTO `devicetype` VALUES ('106', '管网电磁阀', '16');
INSERT INTO `devicetype` VALUES ('107', '讯响器', '1');
INSERT INTO `devicetype` VALUES ('108', '消防电话', '1');
INSERT INTO `devicetype` VALUES ('111', '防烟排烟风机', '18');
INSERT INTO `devicetype` VALUES ('112', '防火阀', '1');
INSERT INTO `devicetype` VALUES ('113', '排烟防火阀', '18');
INSERT INTO `devicetype` VALUES ('114', '常闭送风口', '18');
INSERT INTO `devicetype` VALUES ('115', '排烟口', '18');
INSERT INTO `devicetype` VALUES ('116', '电控挡烟垂壁', '18');
INSERT INTO `devicetype` VALUES ('117', '防火卷帘控制器', '1');
INSERT INTO `devicetype` VALUES ('118', '防火门监控器', '133');
INSERT INTO `devicetype` VALUES ('120', '卷帘门中', '1');
INSERT INTO `devicetype` VALUES ('121', '警报装置', '19');
INSERT INTO `devicetype` VALUES ('122', '开关量报警', '1');
INSERT INTO `devicetype` VALUES ('124', '柴油发电', '1');
INSERT INTO `devicetype` VALUES ('125', '照明配电', '1');
INSERT INTO `devicetype` VALUES ('126', '动力配电', '1');
INSERT INTO `devicetype` VALUES ('127', '水幕电嗞', '1');
INSERT INTO `devicetype` VALUES ('129', '紧急照明', '1');
INSERT INTO `devicetype` VALUES ('130', '疏导指示', '1');
INSERT INTO `devicetype` VALUES ('131', '防盗模块', '1');
INSERT INTO `devicetype` VALUES ('132', '气压罐', '1');
INSERT INTO `devicetype` VALUES ('133', '层号灯', '1');
INSERT INTO `devicetype` VALUES ('134', '设备停动', '1');
INSERT INTO `devicetype` VALUES ('136', '急停按钮', '1');
INSERT INTO `devicetype` VALUES ('137', '上位机', '1');
INSERT INTO `devicetype` VALUES ('138', '空压机', '1');
INSERT INTO `devicetype` VALUES ('139', '联动电源', '1');
INSERT INTO `devicetype` VALUES ('140', '多线制盘锁', '1');
INSERT INTO `devicetype` VALUES ('141', '雨淋阀', '1');
INSERT INTO `devicetype` VALUES ('142', '故障输出', '1');
INSERT INTO `devicetype` VALUES ('143', '卷帘门下', '1');
INSERT INTO `devicetype` VALUES ('200', '点型感烟火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('201', '红外光束感烟火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('202', '吸气式火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('203', '点型火焰探测器', '1');
INSERT INTO `devicetype` VALUES ('204', '点型可燃气体探测器', '1');
INSERT INTO `devicetype` VALUES ('205', '独立式感烟火灾探测报警器', '1');
INSERT INTO `devicetype` VALUES ('206', '点型紫外火焰探测器', '1');
INSERT INTO `devicetype` VALUES ('207', '特种火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('208', '消防联动控制器', '1');
INSERT INTO `devicetype` VALUES ('209', '总线联动控制盘', '1');
INSERT INTO `devicetype` VALUES ('210', '直接联动控制盘', '1');
INSERT INTO `devicetype` VALUES ('211', '可燃气体报警控制器', '1');
INSERT INTO `devicetype` VALUES ('213', '消防设备应急电源', '1');
INSERT INTO `devicetype` VALUES ('214', '系统备用电源', '1');
INSERT INTO `devicetype` VALUES ('215', '消防应急广播设备', '1');
INSERT INTO `devicetype` VALUES ('216', '消防电动装置', '1');
INSERT INTO `devicetype` VALUES ('217', '自动喷水灭火系统控制装置', '1');
INSERT INTO `devicetype` VALUES ('218', '干粉灭火系统控制装置', '1');
INSERT INTO `devicetype` VALUES ('219', '泡沫灭火系统的控制装置', '1');
INSERT INTO `devicetype` VALUES ('220', '消火栓系统的控制装置', '1');
INSERT INTO `devicetype` VALUES ('221', '通风空调控制装置', '1');
INSERT INTO `devicetype` VALUES ('222', '防烟排烟控制装置', '1');
INSERT INTO `devicetype` VALUES ('223', '电动防火阀控制装置', '1');
INSERT INTO `devicetype` VALUES ('224', '电动防火门控制装置', '1');
INSERT INTO `devicetype` VALUES ('225', '消防电梯和非消防电梯的回降控制装置', '1');
INSERT INTO `devicetype` VALUES ('226', '火灾声光报警器', '1');
INSERT INTO `devicetype` VALUES ('227', '声光报警器、警铃', '1');
INSERT INTO `devicetype` VALUES ('228', '火灾应急照明和疏散指示控制装置', '1');
INSERT INTO `devicetype` VALUES ('229', '切断非消防电源的控制装置', '1');
INSERT INTO `devicetype` VALUES ('230', '电动阀控制装置', '1');
INSERT INTO `devicetype` VALUES ('231', '电气火灾监控设备', '130');
INSERT INTO `devicetype` VALUES ('232', '测量范围为0～100％LEL的点型可燃气体探测器', '131');
INSERT INTO `devicetype` VALUES ('233', '测量范围为0～100％LEL的独立式可燃气体探测器', '131');
INSERT INTO `devicetype` VALUES ('234', '测量范围为0～100％LEL的便携式可燃气体探测器', '131');
INSERT INTO `devicetype` VALUES ('235', '测量人工煤气的点型可燃气体探测器', '131');
INSERT INTO `devicetype` VALUES ('236', '测量人工煤气的独立式可燃气体探测器', '131');
INSERT INTO `devicetype` VALUES ('237', '测量人工煤气的便携式可燃气体探测器', '131');
INSERT INTO `devicetype` VALUES ('256', '消防配电柜（箱）', '128');
INSERT INTO `devicetype` VALUES ('257', '自备发电机组', '128');
INSERT INTO `devicetype` VALUES ('258', '应急电源', '128');
INSERT INTO `devicetype` VALUES ('259', '储油设施', '128');
INSERT INTO `devicetype` VALUES ('261', '传输设备', '1');
INSERT INTO `devicetype` VALUES ('263', '消防水池', '132');
INSERT INTO `devicetype` VALUES ('264', '低压车用消防泵', '132');
INSERT INTO `devicetype` VALUES ('265', '车用消防泵', '132');
INSERT INTO `devicetype` VALUES ('266', '手台机动消防泵', '132');
INSERT INTO `devicetype` VALUES ('267', '船用消防泵', '132');
INSERT INTO `devicetype` VALUES ('268', '消防泵组', '132');
INSERT INTO `devicetype` VALUES ('269', '工程柴油机消防泵（不含控制柜', '132');
INSERT INTO `devicetype` VALUES ('270', '卧式单极切线消防泵', '132');
INSERT INTO `devicetype` VALUES ('271', '立式单极切线消防泵', '132');
INSERT INTO `devicetype` VALUES ('272', '卧式单极消防泵', '132');
INSERT INTO `devicetype` VALUES ('273', '水平中开双吸消防泵', '132');
INSERT INTO `devicetype` VALUES ('274', '立式单极消防泵', '132');
INSERT INTO `devicetype` VALUES ('276', '地上式消防泵接合器', '132');
INSERT INTO `devicetype` VALUES ('277', '地下式消防泵接合器', '132');
INSERT INTO `devicetype` VALUES ('278', '墙壁式消防泵接合器', '132');
INSERT INTO `devicetype` VALUES ('279', '多用式消防泵接合器', '132');
INSERT INTO `devicetype` VALUES ('280', '消防气压给水设备', '132');
INSERT INTO `devicetype` VALUES ('281', '消防水泵控制柜', '132');
INSERT INTO `devicetype` VALUES ('282', '增压泵', '132');
INSERT INTO `devicetype` VALUES ('283', '气压水罐', '132');
INSERT INTO `devicetype` VALUES ('284', '压力表', '132');
INSERT INTO `devicetype` VALUES ('285', '管网控制阀门', '132');
INSERT INTO `devicetype` VALUES ('286', '系统减压、泄压装置', '132');
INSERT INTO `devicetype` VALUES ('288', '喷淋泵控制器', '132');
INSERT INTO `devicetype` VALUES ('289', '消防接口', '12');
INSERT INTO `devicetype` VALUES ('290', '室内消火栓', '219');
INSERT INTO `devicetype` VALUES ('291', '消防水带', '219');
INSERT INTO `devicetype` VALUES ('292', '消防软管盘卷', '219');
INSERT INTO `devicetype` VALUES ('293', '压力显示装置', '219');
INSERT INTO `devicetype` VALUES ('294', '地上式室外消火栓', '219');
INSERT INTO `devicetype` VALUES ('295', '地下式室外消火栓', '219');
INSERT INTO `devicetype` VALUES ('296', '地下消火栓标志', '219');
INSERT INTO `devicetype` VALUES ('297', '栓井', '219');
INSERT INTO `devicetype` VALUES ('298', '直接水枪', '219');
INSERT INTO `devicetype` VALUES ('299', '喷雾水枪', '219');
INSERT INTO `devicetype` VALUES ('300', '直流喷雾水枪', '219');
INSERT INTO `devicetype` VALUES ('301', '多用水枪', '219');
INSERT INTO `devicetype` VALUES ('302', '消防炮', '219');
INSERT INTO `devicetype` VALUES ('303', '炮塔', '219');
INSERT INTO `devicetype` VALUES ('304', '现场火灾探测控制装置', '219');
INSERT INTO `devicetype` VALUES ('305', '回旋装置', '219');
INSERT INTO `devicetype` VALUES ('308', '消防炮控制装置', '219');
INSERT INTO `devicetype` VALUES ('309', '消防泵组【水炮系统】', '219');
INSERT INTO `devicetype` VALUES ('310', '消防泵站【水炮系统】', '219');
INSERT INTO `devicetype` VALUES ('311', '泡沫比例混合器【泡沫炮系统】', '219');
INSERT INTO `devicetype` VALUES ('312', '泡沫液罐【泡沫炮系统】', '219');
INSERT INTO `devicetype` VALUES ('313', '干粉罐【干粉炮系统】', '219');
INSERT INTO `devicetype` VALUES ('314', '氦气瓶【干粉炮系统】', '219');
INSERT INTO `devicetype` VALUES ('315', '内扣式消防接口', '219');
INSERT INTO `devicetype` VALUES ('316', '卡式消防接口', '219');
INSERT INTO `devicetype` VALUES ('317', '螺纹式消防接口', '219');
INSERT INTO `devicetype` VALUES ('318', '异接口', '219');
INSERT INTO `devicetype` VALUES ('319', '吸水管接口', '219');
INSERT INTO `devicetype` VALUES ('320', '报警阀组', '12');
INSERT INTO `devicetype` VALUES ('321', '干式报警阀组', '12');
INSERT INTO `devicetype` VALUES ('322', '预作用报警阀组', '12');
INSERT INTO `devicetype` VALUES ('323', '雨淋报警阀组', '12');
INSERT INTO `devicetype` VALUES ('324', '洒水喷头', '12');
INSERT INTO `devicetype` VALUES ('325', '水雾喷头', '12');
INSERT INTO `devicetype` VALUES ('326', '扩大覆盖面积洒水喷头', '12');
INSERT INTO `devicetype` VALUES ('327', '水幕喷头', '12');
INSERT INTO `devicetype` VALUES ('328', '家用喷头', '12');
INSERT INTO `devicetype` VALUES ('329', '早期抑制快速响应ESFR喷头', '12');
INSERT INTO `devicetype` VALUES ('330', '末端试水装置', '12');
INSERT INTO `devicetype` VALUES ('332', '消防水泵接合器', '12');
INSERT INTO `devicetype` VALUES ('333', '消防接口', '12');
INSERT INTO `devicetype` VALUES ('334', '泄水阀（或泄水池）', '12');
INSERT INTO `devicetype` VALUES ('335', '排气阀（或排气口）', '12');
INSERT INTO `devicetype` VALUES ('337', '控制阀', '12');
INSERT INTO `devicetype` VALUES ('338', '水力警钟', '12');
INSERT INTO `devicetype` VALUES ('339', '节流管和减压孔扳', '12');
INSERT INTO `devicetype` VALUES ('340', '减压阀', '12');
INSERT INTO `devicetype` VALUES ('341', '多功能水泵控制阀', '12');
INSERT INTO `devicetype` VALUES ('342', '倒流防止器', '12');
INSERT INTO `devicetype` VALUES ('343', '通用阀门', '12');
INSERT INTO `devicetype` VALUES ('344', '自动寻地喷水灭火装置', '12');
INSERT INTO `devicetype` VALUES ('345', '压力式比例混合装置', '16');
INSERT INTO `devicetype` VALUES ('346', '泡沫液压力储罐', '16');
INSERT INTO `devicetype` VALUES ('347', '安全阀', '16');
INSERT INTO `devicetype` VALUES ('349', '环泵式比例混合器', '16');
INSERT INTO `devicetype` VALUES ('350', '管线式比例混合器', '16');
INSERT INTO `devicetype` VALUES ('351', '平衡式比例混合装置', '16');
INSERT INTO `devicetype` VALUES ('352', '平衡阀', '16');
INSERT INTO `devicetype` VALUES ('353', '低倍数空气泡沫产生器', '16');
INSERT INTO `devicetype` VALUES ('354', '高背压泡沫产生器', '16');
INSERT INTO `devicetype` VALUES ('355', '中倍数泡沫产生器', '16');
INSERT INTO `devicetype` VALUES ('356', '高倍数泡沫产生器', '16');
INSERT INTO `devicetype` VALUES ('358', '泡沫钩管', '16');
INSERT INTO `devicetype` VALUES ('359', '泡沫炮', '16');
INSERT INTO `devicetype` VALUES ('360', '空气泡沫枪', '16');
INSERT INTO `devicetype` VALUES ('361', '泡沫喷头', '16');
INSERT INTO `devicetype` VALUES ('362', '泡沫消火栓', '16');
INSERT INTO `devicetype` VALUES ('363', '单向阀', '16');
INSERT INTO `devicetype` VALUES ('364', '控制阀门', '16');
INSERT INTO `devicetype` VALUES ('365', '过滤器', '16');
INSERT INTO `devicetype` VALUES ('366', '连接软管', '16');
INSERT INTO `devicetype` VALUES ('367', '控制盘、控制柜', '16');
INSERT INTO `devicetype` VALUES ('368', '常压泡沫液储罐', '16');
INSERT INTO `devicetype` VALUES ('369', '半固定式（轻便式）泡沫灭火装置', '16');
INSERT INTO `devicetype` VALUES ('370', '泡沫消火栓箱', '16');
INSERT INTO `devicetype` VALUES ('371', '泡沫消防水泵', '16');
INSERT INTO `devicetype` VALUES ('372', '泡沫混合液泵', '16');
INSERT INTO `devicetype` VALUES ('373', '泡沫管道', '16');
INSERT INTO `devicetype` VALUES ('374', '压力泄放阀', '16');
INSERT INTO `devicetype` VALUES ('375', '电磁阀', '16');
INSERT INTO `devicetype` VALUES ('376', '泡沫喷雾灭火装置', '16');
INSERT INTO `devicetype` VALUES ('377', '其他泡沫灭火设备', '16');
INSERT INTO `devicetype` VALUES ('378', '闭式喷淋头【闭式泡沫-水喷淋系统】', '16');
INSERT INTO `devicetype` VALUES ('379', '灭火剂瓶组', '13');
INSERT INTO `devicetype` VALUES ('380', '驱动气体瓶组', '13');
INSERT INTO `devicetype` VALUES ('381', '容器（贮存灭火剂容器）', '13');
INSERT INTO `devicetype` VALUES ('384', '容器阀', '13');
INSERT INTO `devicetype` VALUES ('385', '选择阀', '13');
INSERT INTO `devicetype` VALUES ('386', '集流管', '13');
INSERT INTO `devicetype` VALUES ('387', '连接管', '13');
INSERT INTO `devicetype` VALUES ('388', '喷嘴', '13');
INSERT INTO `devicetype` VALUES ('389', '信号反馈装置', '13');
INSERT INTO `devicetype` VALUES ('390', '安全泄放装置', '13');
INSERT INTO `devicetype` VALUES ('391', '控制盘', '13');
INSERT INTO `devicetype` VALUES ('392', '检漏装置', '13');
INSERT INTO `devicetype` VALUES ('393', '减压装置', '13');
INSERT INTO `devicetype` VALUES ('394', '低泄高封阀', '13');
INSERT INTO `devicetype` VALUES ('398', '压力讯号器【高、低压二氧化碳灭火系统】', '13');
INSERT INTO `devicetype` VALUES ('400', '制冷机组', '1');
INSERT INTO `devicetype` VALUES ('401', '储瓶柜【柜式七氟丙烷灭火装置】', '13');
INSERT INTO `devicetype` VALUES ('402', '火灾探测装置【柜式七氟丙烷灭火装置】', '13');
INSERT INTO `devicetype` VALUES ('403', '控制器【柜式七氟丙烷灭火装置】', '13');
INSERT INTO `devicetype` VALUES ('404', '消防柜【油浸变压器排油注氮灭火装置】', '13');
INSERT INTO `devicetype` VALUES ('405', '消防控制柜【油浸变压器排油注氮灭火装置】', '13');
INSERT INTO `devicetype` VALUES ('406', '火灾探测装置【油浸变压器排油注氮灭火装置】', '13');
INSERT INTO `devicetype` VALUES ('407', '断流阀【油浸变压器排油注氮灭火装置】', '13');
INSERT INTO `devicetype` VALUES ('408', '氮气瓶组【油浸变压器排油注氮灭火装置】', '13');
INSERT INTO `devicetype` VALUES ('409', '氮气释放阀【油浸变压器排油注氮灭火装置】', '0');
INSERT INTO `devicetype` VALUES ('412', '排油阀及配套的管路管件', '1');
INSERT INTO `devicetype` VALUES ('413', '流量调节阀【油浸变压器排油注氮灭火装置】', '13');
INSERT INTO `devicetype` VALUES ('414', '排气组件【油浸变压器排油注氮灭火装置】', '13');
INSERT INTO `devicetype` VALUES ('415', '油气隔离装置【油浸变压器排油注氮灭火装置】', '13');
INSERT INTO `devicetype` VALUES ('416', '检修阀【油浸变压器排油注氮灭火装置】', '13');
INSERT INTO `devicetype` VALUES ('417', '送风口', '18');
INSERT INTO `devicetype` VALUES ('418', '送风阀', '18');
INSERT INTO `devicetype` VALUES ('419', '送风机', '18');
INSERT INTO `devicetype` VALUES ('420', '送风机控制柜', '18');
INSERT INTO `devicetype` VALUES ('421', '挡烟垂壁', '1');
INSERT INTO `devicetype` VALUES ('423', '排烟阀', '18');
INSERT INTO `devicetype` VALUES ('424', '排烟风机', '18');
INSERT INTO `devicetype` VALUES ('425', '电动排烟窗', '18');
INSERT INTO `devicetype` VALUES ('427', '排烟风机控制柜', '18');
INSERT INTO `devicetype` VALUES ('428', '自然排烟窗', '18');
INSERT INTO `devicetype` VALUES ('429', '送风、排烟机房', '18');
INSERT INTO `devicetype` VALUES ('430', '应急照明集中电源【集中电源】', '22');
INSERT INTO `devicetype` VALUES ('431', '应急照明分配电装置【集中电源型】', '22');
INSERT INTO `devicetype` VALUES ('432', '应急照明控制器', '22');
INSERT INTO `devicetype` VALUES ('433', '消防应急标志灯具', '22');
INSERT INTO `devicetype` VALUES ('434', '消防应急照明灯具', '22');
INSERT INTO `devicetype` VALUES ('435', '消防应急照明标志复合灯具', '22');
INSERT INTO `devicetype` VALUES ('436', '持续型消防应急灯具', '22');
INSERT INTO `devicetype` VALUES ('437', '非持续性消防应急灯具', '22');
INSERT INTO `devicetype` VALUES ('438', '自带电源型消防应急灯具【自带电源型】', '22');
INSERT INTO `devicetype` VALUES ('439', '集中电源型消防应急灯具【集中电源型】', '22');
INSERT INTO `devicetype` VALUES ('441', '非集中控制型消防应急灯具【非集中控制型】', '22');
INSERT INTO `devicetype` VALUES ('442', '集中控制型消防应急灯具【集中控制型】', '22');
INSERT INTO `devicetype` VALUES ('443', '功放', '1');
INSERT INTO `devicetype` VALUES ('445', '音箱（扩音机、喇叭）', '1');
INSERT INTO `devicetype` VALUES ('446', '广播模块', '1');
INSERT INTO `devicetype` VALUES ('447', '消防广播主机', '1');
INSERT INTO `devicetype` VALUES ('448', '消防电话总机', '24');
INSERT INTO `devicetype` VALUES ('449', '消防电话分机', '24');
INSERT INTO `devicetype` VALUES ('450', '消防电话插孔', '24');
INSERT INTO `devicetype` VALUES ('451', '电源', '1');
INSERT INTO `devicetype` VALUES ('452', '防火墙', '1');
INSERT INTO `devicetype` VALUES ('453', '钢质隔热防火门', '133');
INSERT INTO `devicetype` VALUES ('454', '钢质部分隔热防火门', '133');
INSERT INTO `devicetype` VALUES ('455', '钢质非隔热防火门', '133');
INSERT INTO `devicetype` VALUES ('456', '木质隔热防火门', '133');
INSERT INTO `devicetype` VALUES ('457', '木质部分隔热防火门', '133');
INSERT INTO `devicetype` VALUES ('458', '木质非隔热防火门', '133');
INSERT INTO `devicetype` VALUES ('459', '钢木质隔热防火门', '133');
INSERT INTO `devicetype` VALUES ('460', '钢木质部分隔热防火门', '133');
INSERT INTO `devicetype` VALUES ('461', '钢木质非隔热防火门', '133');
INSERT INTO `devicetype` VALUES ('462', '其他材质隔热防火门', '133');
INSERT INTO `devicetype` VALUES ('463', '其他材质部分隔热防火门', '133');
INSERT INTO `devicetype` VALUES ('464', '其他材质非隔热防火门', '133');
INSERT INTO `devicetype` VALUES ('465', '防火窗', '133');
INSERT INTO `devicetype` VALUES ('466', '防火卷帘', '1');
INSERT INTO `devicetype` VALUES ('467', '控制箱', '1');
INSERT INTO `devicetype` VALUES ('468', '轿门和层门', '1');
INSERT INTO `devicetype` VALUES ('469', '驱动主机和相关设备', '1');
INSERT INTO `devicetype` VALUES ('470', '控制系统', '1');
INSERT INTO `devicetype` VALUES ('471', '供电电源', '1');
INSERT INTO `devicetype` VALUES ('472', '轿厢和层站的控制装置', '1');
INSERT INTO `devicetype` VALUES ('473', '消防服务通讯系统', '1');
INSERT INTO `devicetype` VALUES ('474', '细水雾喷头', '134');
INSERT INTO `devicetype` VALUES ('475', '贮气瓶组【瓶组式系统】', '134');
INSERT INTO `devicetype` VALUES ('476', '贮气容器【瓶组式系统】', '134');
INSERT INTO `devicetype` VALUES ('477', '贮水瓶组【瓶组式系统】', '134');
INSERT INTO `devicetype` VALUES ('478', '贮水箱【泵组式系统】', '134');
INSERT INTO `devicetype` VALUES ('479', '分区控制阀', '134');
INSERT INTO `devicetype` VALUES ('480', '气体单向阀【瓶组式系统】', '134');
INSERT INTO `devicetype` VALUES ('481', '泵组单元【泵组式系统】', '1');
INSERT INTO `devicetype` VALUES ('482', '泄压调压阀【泵组式系统】', '134');
INSERT INTO `devicetype` VALUES ('483', '干粉贮存容器', '17');
INSERT INTO `devicetype` VALUES ('484', '干粉贮存容器出口释放装置', '17');
INSERT INTO `devicetype` VALUES ('486', '驱动控制装置', '17');
INSERT INTO `devicetype` VALUES ('487', '安全防护装置', '17');
INSERT INTO `devicetype` VALUES ('488', '燃气发生器', '17');
INSERT INTO `devicetype` VALUES ('489', '干粉软管卷盘', '17');
INSERT INTO `devicetype` VALUES ('490', '干粉炮', '17');
INSERT INTO `devicetype` VALUES ('491', '手提式干粉灭火器', '135');
INSERT INTO `devicetype` VALUES ('492', '手提式二氧化碳灭火器', '135');
INSERT INTO `devicetype` VALUES ('493', '手提式水基型灭火器', '135');
INSERT INTO `devicetype` VALUES ('494', '手提式洁净气体灭火器', '135');
INSERT INTO `devicetype` VALUES ('495', '推车式干粉灭火器', '135');
INSERT INTO `devicetype` VALUES ('496', '推车式二氧化碳灭火器', '135');
INSERT INTO `devicetype` VALUES ('497', '推车式水基型灭火器', '135');
INSERT INTO `devicetype` VALUES ('498', '推车式洁净气休灭火器', '135');
INSERT INTO `devicetype` VALUES ('499', '端子箱', '1');
INSERT INTO `devicetype` VALUES ('500', '逃生自救设施', '1');
INSERT INTO `devicetype` VALUES ('501', '安全车道', '1');
INSERT INTO `devicetype` VALUES ('502', '疏散楼梯', '1');
INSERT INTO `devicetype` VALUES ('503', '疏散走道', '1');
INSERT INTO `devicetype` VALUES ('504', '建筑防火安全标志', '1');
INSERT INTO `devicetype` VALUES ('506', '家用报警器', '1');
INSERT INTO `devicetype` VALUES ('507', '手提贮压式干粉灭火器', '135');
INSERT INTO `devicetype` VALUES ('509', '消防应急照明防爆灯具', '22');
INSERT INTO `devicetype` VALUES ('510', '推车式1211灭火器', '135');
INSERT INTO `devicetype` VALUES ('511', '手提式清水灭火器', '135');
INSERT INTO `devicetype` VALUES ('512', '手提式酸碱灭火器', '135');
INSERT INTO `devicetype` VALUES ('513', '手提式化学泡沫灭火器', '135');
INSERT INTO `devicetype` VALUES ('515', '消防火灾控制器', '1');
INSERT INTO `devicetype` VALUES ('517', '消防报警控制器', '1');
INSERT INTO `devicetype` VALUES ('546', '应急照明系统检查', '22');
INSERT INTO `devicetype` VALUES ('547', '子母型消防应急灯具', '22');
INSERT INTO `devicetype` VALUES ('548', '探测回路', '1');
INSERT INTO `devicetype` VALUES ('549', '手动火灾报警按钮', '1');
INSERT INTO `devicetype` VALUES ('550', '图象型火灾探测器', '1');
INSERT INTO `devicetype` VALUES ('551', '区域显示器（火灾显示盘）', '1');
INSERT INTO `devicetype` VALUES ('552', '消防水箱', '132');
INSERT INTO `devicetype` VALUES ('553', '排污口', '12');
INSERT INTO `devicetype` VALUES ('555', '泡沫泵', '16');
INSERT INTO `devicetype` VALUES ('556', '驱动装置', '13');
INSERT INTO `devicetype` VALUES ('562', '泵租单元【泵组式系统】', '134');
INSERT INTO `devicetype` VALUES ('564', '室外消火栓', '1');
INSERT INTO `devicetype` VALUES ('565', '输入输出模块', '1');
INSERT INTO `devicetype` VALUES ('566', '火灾报警探测器', '1');
INSERT INTO `devicetype` VALUES ('567', '手动报警按钮', '1');
INSERT INTO `devicetype` VALUES ('568', '消防联动控制设备', '1');
INSERT INTO `devicetype` VALUES ('572', '消防卷盘', '219');
INSERT INTO `devicetype` VALUES ('573', '消火栓启动按钮', '219');
INSERT INTO `devicetype` VALUES ('574', '消防水炮', '219');
INSERT INTO `devicetype` VALUES ('575', '泡沫消防泵', '16');
INSERT INTO `devicetype` VALUES ('576', '泡沫消防泵控制柜', '16');
INSERT INTO `devicetype` VALUES ('577', '泡沫发生器', '16');
INSERT INTO `devicetype` VALUES ('578', '气体灭火控制盘', '13');
INSERT INTO `devicetype` VALUES ('580', '机械排烟风机', '18');
INSERT INTO `devicetype` VALUES ('581', '消防应急照明防爆灯', '22');
INSERT INTO `devicetype` VALUES ('583', 'led防水应急灯', '22');
INSERT INTO `devicetype` VALUES ('584', '手提式驻压式干粉灭火器', '135');
INSERT INTO `devicetype` VALUES ('585', '电话模块', '1');

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary` (
  `DictionaryID` char(36) NOT NULL,
  `ItemName` varchar(100) DEFAULT NULL,
  `TypeName` varchar(20) DEFAULT NULL,
  `TypeID` int(11) DEFAULT NULL,
  `OrderNum` int(11) DEFAULT NULL,
  PRIMARY KEY (`DictionaryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dictionary
-- ----------------------------
INSERT INTO `dictionary` VALUES ('D100000', '消防安全教育、培训制度', '制度类型', null, '1');
INSERT INTO `dictionary` VALUES ('D100001', '防火巡查、检查制度', '制度类型', null, '2');
INSERT INTO `dictionary` VALUES ('D100002', '安全疏散设施管理制度', '制度类型', null, '3');
INSERT INTO `dictionary` VALUES ('D100003', '消防设施、器材维护管理制度', '制度类型', null, '4');
INSERT INTO `dictionary` VALUES ('D100004', '火灾隐患整改制度', '制度类型', null, '5');
INSERT INTO `dictionary` VALUES ('D100005', '用火、用电安全管理制度', '制度类型', null, '6');
INSERT INTO `dictionary` VALUES ('D100006', '灭火和应急疏散预案演练制度', '制度类型', null, '7');
INSERT INTO `dictionary` VALUES ('D100007', '燃气和电气设备的检查和管理制度（含防雷、防静电）', '制度类型', null, '8');
INSERT INTO `dictionary` VALUES ('D100008', '消防控制室值班制度', '制度类型', null, '9');
INSERT INTO `dictionary` VALUES ('D100009', '消防安全工作考评和奖惩制度', '制度类型', null, '10');
INSERT INTO `dictionary` VALUES ('D100010', '专职和志愿消防队的组织管理制度', '制度类型', null, '11');
INSERT INTO `dictionary` VALUES ('D100011', '易燃易爆危险品和场所防火防爆管理制度', '制度类型', null, '12');
INSERT INTO `dictionary` VALUES ('D100012', '灭火和应急疏散预案', '制度类型', null, '13');
INSERT INTO `dictionary` VALUES ('D100013', '其他消防安全制度、措施', '制度类型', null, '14');
INSERT INTO `dictionary` VALUES ('D200000', '消防安全责任人职责', '安全职责', null, '15');
INSERT INTO `dictionary` VALUES ('D200001', '消防安全管理人职责', '安全职责', null, '16');
INSERT INTO `dictionary` VALUES ('D200002', '专（兼）职消防安全管理人员职责', '安全职责', null, '17');
INSERT INTO `dictionary` VALUES ('D200003', '安保部经理职责', '安全职责', null, '18');
INSERT INTO `dictionary` VALUES ('D200004', '工程部经理职责', '安全职责', null, '19');
INSERT INTO `dictionary` VALUES ('D200005', '前厅部经理职责', '安全职责', null, '20');
INSERT INTO `dictionary` VALUES ('D200006', '客房部经理职责', '安全职责', null, '21');
INSERT INTO `dictionary` VALUES ('D200007', '商场经理职责', '安全职责', null, '22');
INSERT INTO `dictionary` VALUES ('D200008', '餐饮部经理职责', '安全职责', null, '23');
INSERT INTO `dictionary` VALUES ('D200009', '娱乐场所负责人职责', '安全职责', null, '24');
INSERT INTO `dictionary` VALUES ('D200010', '其他部门经理职责', '安全职责', null, '25');
INSERT INTO `dictionary` VALUES ('D200011', '消防控制室值班员职责', '安全职责', null, '26');
INSERT INTO `dictionary` VALUES ('D200012', '电工职责', '安全职责', null, '27');
INSERT INTO `dictionary` VALUES ('D200013', '电焊工职责', '安全职责', null, '28');
INSERT INTO `dictionary` VALUES ('D200014', '油漆工职责', '安全职责', null, '29');
INSERT INTO `dictionary` VALUES ('D200015', '厨师职责', '安全职责', null, '30');
INSERT INTO `dictionary` VALUES ('D200016', '物资仓库管理员职责', '安全职责', null, '31');
INSERT INTO `dictionary` VALUES ('D200017', '楼层疏散引导员职责', '安全职责', null, '32');
INSERT INTO `dictionary` VALUES ('D200018', '一般员工职责', '安全职责', null, '33');
INSERT INTO `dictionary` VALUES ('D300000', '博士生', '文化程度', null, '34');
INSERT INTO `dictionary` VALUES ('D300001', '硕士生', '文化程度', null, '35');
INSERT INTO `dictionary` VALUES ('D300002', '研究生', '文化程度', null, '36');
INSERT INTO `dictionary` VALUES ('D300003', '大学', '文化程度', null, '37');
INSERT INTO `dictionary` VALUES ('D300004', '大专', '文化程度', null, '38');
INSERT INTO `dictionary` VALUES ('D300005', '职高', '文化程度', null, '39');
INSERT INTO `dictionary` VALUES ('D300006', '中专', '文化程度', null, '40');
INSERT INTO `dictionary` VALUES ('D300007', '技工', '文化程度', null, '41');
INSERT INTO `dictionary` VALUES ('D300008', '高中', '文化程度', null, '42');
INSERT INTO `dictionary` VALUES ('D300009', '初中', '文化程度', null, '43');
INSERT INTO `dictionary` VALUES ('D300010', '小学', '文化程度', null, '44');
INSERT INTO `dictionary` VALUES ('D300011', '其他', '文化程度', null, '45');
INSERT INTO `dictionary` VALUES ('D400000', '人员密集场所', '单位其他情况', null, '46');
INSERT INTO `dictionary` VALUES ('D400001', '易燃易爆危险品生产单位', '单位其他情况', null, '47');
INSERT INTO `dictionary` VALUES ('D400002', '易燃易爆危险品存放单位', '单位其他情况', null, '48');
INSERT INTO `dictionary` VALUES ('D400003', '易燃易爆危险品经营单位', '单位其他情况', null, '49');
INSERT INTO `dictionary` VALUES ('D400004', '消防产品生产企业', '单位其他情况', null, '50');
INSERT INTO `dictionary` VALUES ('D400005', '消防产品维修企业', '单位其他情况', null, '51');
INSERT INTO `dictionary` VALUES ('D400006', '消防产品销售企业', '单位其他情况', null, '52');
INSERT INTO `dictionary` VALUES ('D400007', '建筑消防设施维保企业', '单位其他情况', null, '53');
INSERT INTO `dictionary` VALUES ('D400008', '物业服务企业', '单位其他情况', null, '54');
INSERT INTO `dictionary` VALUES ('D400009', '其他', '单位其他情况', null, '55');
INSERT INTO `dictionary` VALUES ('D500001', '商场', '单位类别', null, '56');
INSERT INTO `dictionary` VALUES ('D500002', '宾馆', '单位类别', null, '57');
INSERT INTO `dictionary` VALUES ('D500003', '交通枢纽', '单位类别', null, '58');
INSERT INTO `dictionary` VALUES ('D500004', '新闻单位', '单位类别', null, '59');
INSERT INTO `dictionary` VALUES ('D500005', '邮电', '单位类别', null, '60');
INSERT INTO `dictionary` VALUES ('D500006', '政府机关', '单位类别', null, '61');
INSERT INTO `dictionary` VALUES ('D500007', '事业单位', '单位类别', null, '62');
INSERT INTO `dictionary` VALUES ('D500008', '企业单位', '单位类别', null, '63');
INSERT INTO `dictionary` VALUES ('D500009', '私营企业', '单位类别', null, '64');
INSERT INTO `dictionary` VALUES ('D500010', '外商企业', '单位类别', null, '65');
INSERT INTO `dictionary` VALUES ('D500011', '军工企业', '单位类别', null, '66');
INSERT INTO `dictionary` VALUES ('D500012', '保密单位', '单位类别', null, '67');
INSERT INTO `dictionary` VALUES ('D500013', '院校', '单位类别', null, '68');
INSERT INTO `dictionary` VALUES ('D500014', '重要的科研单位', '单位类别', null, '69');
INSERT INTO `dictionary` VALUES ('D500015', '公共娱乐场所', '单位类别', null, '70');
INSERT INTO `dictionary` VALUES ('D500016', '通信枢纽', '单位类别', null, '71');
INSERT INTO `dictionary` VALUES ('D500017', '党政首脑机关', '单位类别', null, '72');
INSERT INTO `dictionary` VALUES ('D500018', '高层公共建筑', '单位类别', null, '73');
INSERT INTO `dictionary` VALUES ('D500019', '图书馆', '单位类别', null, '74');
INSERT INTO `dictionary` VALUES ('D500020', '博物馆', '单位类别', null, '75');
INSERT INTO `dictionary` VALUES ('D500021', '展览馆', '单位类别', null, '76');
INSERT INTO `dictionary` VALUES ('D500022', '档案馆', '单位类别', null, '77');
INSERT INTO `dictionary` VALUES ('D500023', '大型工程及施工现场', '单位类别', null, '78');
INSERT INTO `dictionary` VALUES ('D500024', '其他重要场所', '单位类别', null, '79');
INSERT INTO `dictionary` VALUES ('D500025', '工业企业', '单位类别', null, '80');
INSERT INTO `dictionary` VALUES ('D500026', '公众聚集场所', '单位类别', null, '81');
INSERT INTO `dictionary` VALUES ('D500027', '医院', '单位类别', null, '82');
INSERT INTO `dictionary` VALUES ('D500028', '小商铺', '单位类别', null, '83');
INSERT INTO `dictionary` VALUES ('D500029', '小娱乐场所', '单位类别', null, '84');
INSERT INTO `dictionary` VALUES ('D500030', '出租屋', '单位类别', null, '85');
INSERT INTO `dictionary` VALUES ('D500031', '一般单位', '单位类别', null, '86');
INSERT INTO `dictionary` VALUES ('D500032', '小作坊', '单位类别', null, '87');

-- ----------------------------
-- Table structure for equipment
-- ----------------------------
DROP TABLE IF EXISTS `equipment`;
CREATE TABLE `equipment` (
  `EquipmentID` char(36) NOT NULL,
  `equipmentName` varchar(100) DEFAULT NULL,
  `equipmentmodel` varchar(100) DEFAULT NULL,
  `equipmentNum` int(11) DEFAULT NULL,
  `equipmenttype` varchar(50) NOT NULL,
  `isGood` varchar(10) DEFAULT NULL,
  `BuyDate` date DEFAULT NULL,
  `memo` text,
  `firecompayid` char(36) NOT NULL,
  PRIMARY KEY (`EquipmentID`),
  KEY `RefequipmentType95` (`equipmenttype`),
  KEY `Reffirecompany97` (`firecompayid`),
  CONSTRAINT `RefequipmentType95` FOREIGN KEY (`equipmenttype`) REFERENCES `equipmenttype` (`equipmenttype`),
  CONSTRAINT `Reffirecompany97` FOREIGN KEY (`firecompayid`) REFERENCES `firecompany` (`firecompayid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of equipment
-- ----------------------------

-- ----------------------------
-- Table structure for equipmenttype
-- ----------------------------
DROP TABLE IF EXISTS `equipmenttype`;
CREATE TABLE `equipmenttype` (
  `equipmenttype` varchar(50) NOT NULL,
  `ordernum` int(11) DEFAULT NULL,
  PRIMARY KEY (`equipmenttype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of equipmenttype
-- ----------------------------
INSERT INTO `equipmenttype` VALUES ('其他类型消防装备器材', '9');
INSERT INTO `equipmenttype` VALUES ('抢险救援器材', '5');
INSERT INTO `equipmenttype` VALUES ('消防人员防护装备', '1');
INSERT INTO `equipmenttype` VALUES ('消防车、船（艇）、飞行器', '2');
INSERT INTO `equipmenttype` VALUES ('消防通信指挥装备', '6');
INSERT INTO `equipmenttype` VALUES ('灭火器材装备', '3');
INSERT INTO `equipmenttype` VALUES ('灭火药剂', '4');
INSERT INTO `equipmenttype` VALUES ('特种消防装备', '7');
INSERT INTO `equipmenttype` VALUES ('防火检查与火灾调查装备', '8');

-- ----------------------------
-- Table structure for eventinfos
-- ----------------------------
DROP TABLE IF EXISTS `eventinfos`;
CREATE TABLE `eventinfos` (
  `Firealarmid` char(36) NOT NULL,
  `cAlarmtype` varchar(10) DEFAULT NULL,
  `Gatewayaddress` varchar(30) DEFAULT NULL,
  `sysaddress` int(11) DEFAULT NULL,
  `systypeID` int(11) DEFAULT NULL,
  `deviceaddress` varchar(30) DEFAULT NULL,
  `idevicetype` int(11) DEFAULT NULL,
  `faultdesc` varchar(300) DEFAULT NULL,
  `dFirstAlarmtime` datetime DEFAULT NULL,
  `StateValue` int(11) DEFAULT NULL,
  `dRecentAlarmtime` datetime DEFAULT NULL,
  `dReceivetime` datetime DEFAULT NULL,
  `AlarmNum` int(11) DEFAULT NULL,
  `vAlarmsource` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Firealarmid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eventinfos
-- ----------------------------

-- ----------------------------
-- Table structure for firecompany
-- ----------------------------
DROP TABLE IF EXISTS `firecompany`;
CREATE TABLE `firecompany` (
  `firecompayid` char(36) NOT NULL,
  `firecompanyname` varchar(100) DEFAULT NULL,
  `CreateDate` date DEFAULT NULL,
  `contactor` varchar(30) DEFAULT NULL,
  `Tel` varchar(50) DEFAULT NULL,
  `baseinfo` varchar(1000) DEFAULT NULL,
  `memo` text,
  `orgid` char(12) NOT NULL,
  PRIMARY KEY (`firecompayid`),
  KEY `Refonlineorg94` (`orgid`),
  CONSTRAINT `Refonlineorg94` FOREIGN KEY (`orgid`) REFERENCES `onlineorg` (`orgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of firecompany
-- ----------------------------

-- ----------------------------
-- Table structure for firedevice
-- ----------------------------
DROP TABLE IF EXISTS `firedevice`;
CREATE TABLE `firedevice` (
  `deviceNo` char(30) NOT NULL,
  `devicename` varchar(100) DEFAULT NULL,
  `Manufacture` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `productDate` date DEFAULT NULL,
  `validate` date DEFAULT NULL,
  `SetupDate` date DEFAULT NULL,
  `SetLocation` varchar(1000) DEFAULT NULL,
  `memo` text,
  `siteid` char(20) DEFAULT NULL,
  `iDeviceType` int(11) NOT NULL,
  PRIMARY KEY (`deviceNo`),
  KEY `Refsite105` (`siteid`),
  KEY `Refdevicetype125` (`iDeviceType`),
  CONSTRAINT `Refdevicetype125` FOREIGN KEY (`iDeviceType`) REFERENCES `devicetype` (`iDeviceType`),
  CONSTRAINT `Refsite105` FOREIGN KEY (`siteid`) REFERENCES `site` (`siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of firedevice
-- ----------------------------

-- ----------------------------
-- Table structure for firedevicechangerecord
-- ----------------------------
DROP TABLE IF EXISTS `firedevicechangerecord`;
CREATE TABLE `firedevicechangerecord` (
  `ChangeNo` char(22) NOT NULL,
  `ChangeDate` datetime DEFAULT NULL,
  `Manufacture` varchar(100) DEFAULT NULL,
  `ProductModel` varchar(50) DEFAULT NULL,
  `ProductDate` datetime DEFAULT NULL,
  `Validate` datetime DEFAULT NULL,
  `Others` varchar(1000) DEFAULT NULL,
  `PicPath` varchar(1000) DEFAULT NULL,
  `deviceNo` char(30) NOT NULL,
  PRIMARY KEY (`ChangeNo`),
  KEY `RefFireDevice101` (`deviceNo`),
  CONSTRAINT `RefFireDevice101` FOREIGN KEY (`deviceNo`) REFERENCES `firedevice` (`deviceNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of firedevicechangerecord
-- ----------------------------

-- ----------------------------
-- Table structure for firesafetycheck
-- ----------------------------
DROP TABLE IF EXISTS `firesafetycheck`;
CREATE TABLE `firesafetycheck` (
  `FireSafetyCheckID` char(36) NOT NULL,
  `CheckTime` datetime DEFAULT NULL,
  `checkposite` varchar(100) DEFAULT NULL,
  `Department` varchar(100) DEFAULT NULL,
  `Problem` varchar(1000) DEFAULT NULL,
  `handing` varchar(1000) DEFAULT NULL,
  `attendperson` varchar(200) DEFAULT NULL,
  `CheckedDepartment` varchar(500) DEFAULT NULL,
  `RecordMan` varchar(100) DEFAULT NULL,
  `SafetyMan` varchar(100) DEFAULT NULL,
  `orgid` char(12) NOT NULL,
  PRIMARY KEY (`FireSafetyCheckID`),
  KEY `Refonlineorg144` (`orgid`),
  CONSTRAINT `Refonlineorg144` FOREIGN KEY (`orgid`) REFERENCES `onlineorg` (`orgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of firesafetycheck
-- ----------------------------

-- ----------------------------
-- Table structure for firesysstate
-- ----------------------------
DROP TABLE IF EXISTS `firesysstate`;
CREATE TABLE `firesysstate` (
  `biSysStateID` bigint(20) NOT NULL,
  `iSysType` int(11) DEFAULT NULL,
  `tiSysAddress` int(11) DEFAULT NULL,
  `StateValue` int(11) DEFAULT NULL,
  `w0` char(1) DEFAULT NULL,
  `w1` char(1) DEFAULT NULL,
  `w2` char(1) DEFAULT NULL,
  `w3` char(1) DEFAULT NULL,
  `w4` char(1) DEFAULT NULL,
  `w5` char(1) DEFAULT NULL,
  `w6` char(1) DEFAULT NULL,
  `w7` char(1) DEFAULT NULL,
  `w8` char(1) DEFAULT NULL,
  `w9` char(1) DEFAULT NULL,
  `w10` char(1) DEFAULT NULL,
  `w11` char(1) DEFAULT NULL,
  `w12` char(1) DEFAULT NULL,
  `w13` char(1) DEFAULT NULL,
  `w14` char(1) DEFAULT NULL,
  `w15` char(1) DEFAULT NULL,
  `dStateOccurTime` datetime DEFAULT NULL,
  `dReceiveTime` datetime DEFAULT NULL,
  `Gatewayaddress` varchar(30) NOT NULL,
  PRIMARY KEY (`biSysStateID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of firesysstate
-- ----------------------------

-- ----------------------------
-- Table structure for firesystype
-- ----------------------------
DROP TABLE IF EXISTS `firesystype`;
CREATE TABLE `firesystype` (
  `tiSysType` int(11) NOT NULL,
  `vSysdesc` varchar(100) NOT NULL,
  `OrderNO` int(11) DEFAULT NULL,
  PRIMARY KEY (`tiSysType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of firesystype
-- ----------------------------
INSERT INTO `firesystype` VALUES ('0', '通用', null);
INSERT INTO `firesystype` VALUES ('1', '火灾探测报警系统', null);
INSERT INTO `firesystype` VALUES ('10', '消防联动控制器', null);
INSERT INTO `firesystype` VALUES ('11', '消火栓系统', null);
INSERT INTO `firesystype` VALUES ('12', '自动喷水灭火系统', null);
INSERT INTO `firesystype` VALUES ('13', '气体灭火系统', null);
INSERT INTO `firesystype` VALUES ('14', '水喷雾灭火系统（泵启动方式）', null);
INSERT INTO `firesystype` VALUES ('15', '水喷雾灭火系统（压力容器启动方式）', null);
INSERT INTO `firesystype` VALUES ('16', '泡沫灭火系统', null);
INSERT INTO `firesystype` VALUES ('17', '干粉灭火系统', null);
INSERT INTO `firesystype` VALUES ('18', '防烟排烟系统', null);
INSERT INTO `firesystype` VALUES ('19', '防火门及卷帘系统', null);
INSERT INTO `firesystype` VALUES ('20', '消防电梯', null);
INSERT INTO `firesystype` VALUES ('21', '消防应急广播', null);
INSERT INTO `firesystype` VALUES ('22', '消防应急照明和疏散指示系统', null);
INSERT INTO `firesystype` VALUES ('23', '消防电源', null);
INSERT INTO `firesystype` VALUES ('24', '消防电话', null);
INSERT INTO `firesystype` VALUES ('25', '消防设备', null);
INSERT INTO `firesystype` VALUES ('26', '防排烟通风系统', null);
INSERT INTO `firesystype` VALUES ('27', 'RFID', null);
INSERT INTO `firesystype` VALUES ('128', '消防供配电设施', null);
INSERT INTO `firesystype` VALUES ('130', '电气火灾监控系统', null);
INSERT INTO `firesystype` VALUES ('131', '可燃气体探测报警系统', null);
INSERT INTO `firesystype` VALUES ('132', '消防供水设施', null);
INSERT INTO `firesystype` VALUES ('133', '防火分隔设施', null);
INSERT INTO `firesystype` VALUES ('134', '细水雾灭火系统', null);
INSERT INTO `firesystype` VALUES ('135', '灭火器', null);
INSERT INTO `firesystype` VALUES ('218', '细水雾灭火系统', null);
INSERT INTO `firesystype` VALUES ('219', '消火栓（消防炮）灭火系统', null);
INSERT INTO `firesystype` VALUES ('221', '火灾自动报警系统', null);
INSERT INTO `firesystype` VALUES ('223', '其他设施', null);

-- ----------------------------
-- Table structure for flatpic
-- ----------------------------
DROP TABLE IF EXISTS `flatpic`;
CREATE TABLE `flatpic` (
  `cFlatPic` char(14) NOT NULL,
  `vPlatpicdesc` varchar(100) DEFAULT NULL,
  `dRecordSet` datetime DEFAULT NULL,
  `imFlatPic` varchar(1000) DEFAULT NULL,
  `floornum` varchar(50) DEFAULT NULL,
  `PicName` varchar(30) DEFAULT NULL,
  `siteid` char(20) NOT NULL,
  PRIMARY KEY (`cFlatPic`),
  KEY `Refsite17` (`siteid`),
  CONSTRAINT `Refsite17` FOREIGN KEY (`siteid`) REFERENCES `site` (`siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of flatpic
-- ----------------------------

-- ----------------------------
-- Table structure for gateway
-- ----------------------------
DROP TABLE IF EXISTS `gateway`;
CREATE TABLE `gateway` (
  `Gatewayaddress` varchar(30) NOT NULL,
  `ynonline` varchar(4) DEFAULT NULL,
  `onlinetime` datetime DEFAULT NULL,
  `Manufacturer` varchar(100) DEFAULT NULL,
  `Model` varchar(50) DEFAULT NULL,
  `productdate` datetime DEFAULT NULL,
  `setupdate` datetime DEFAULT NULL,
  `ControlorManufacture` varchar(100) DEFAULT NULL,
  `ControlorMode` varchar(100) DEFAULT NULL,
  `ConnectControlerState` varchar(50) DEFAULT NULL,
  `MainPower` varchar(10) DEFAULT NULL,
  `BackupPower` varchar(10) DEFAULT NULL,
  `CableState` varchar(10) DEFAULT NULL,
  `memo` varchar(1000) DEFAULT NULL,
  `gatewayversion` varchar(100) DEFAULT NULL,
  `versionupdatedate` datetime DEFAULT NULL,
  `gatewaytype` varchar(100) DEFAULT NULL,
  `workState` varchar(10) DEFAULT NULL,
  `annalTime` datetime DEFAULT NULL,
  PRIMARY KEY (`Gatewayaddress`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of gateway
-- ----------------------------

-- ----------------------------
-- Table structure for gatewayopinfo
-- ----------------------------
DROP TABLE IF EXISTS `gatewayopinfo`;
CREATE TABLE `gatewayopinfo` (
  `iOpeID` char(36) NOT NULL,
  `StateValue` int(11) DEFAULT NULL,
  `w0` char(1) DEFAULT NULL,
  `w1` char(1) DEFAULT NULL,
  `w2` char(1) DEFAULT NULL,
  `w3` char(1) DEFAULT NULL,
  `w4` char(1) DEFAULT NULL,
  `w5` char(1) DEFAULT NULL,
  `w6` char(1) DEFAULT NULL,
  `w7` char(1) DEFAULT NULL,
  `dOpRecordDate` datetime DEFAULT NULL,
  `dReceivetime` datetime DEFAULT NULL,
  `Gatewayaddress` varchar(30) NOT NULL,
  PRIMARY KEY (`iOpeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of gatewayopinfo
-- ----------------------------

-- ----------------------------
-- Table structure for gatewaystate
-- ----------------------------
DROP TABLE IF EXISTS `gatewaystate`;
CREATE TABLE `gatewaystate` (
  `gatewaystateid` char(36) NOT NULL,
  `cRunstate` varchar(10) DEFAULT NULL,
  `statevalue` int(11) DEFAULT NULL,
  `w0` char(1) DEFAULT NULL,
  `w1` char(1) DEFAULT NULL,
  `w2` char(1) DEFAULT NULL,
  `w3` char(1) DEFAULT NULL,
  `w4` char(1) DEFAULT NULL,
  `w5` char(1) DEFAULT NULL,
  `w6` char(1) DEFAULT NULL,
  `w7` char(1) DEFAULT NULL,
  `dStateoccurtime` datetime DEFAULT NULL,
  `dReceivetime` datetime DEFAULT NULL,
  `Gatewayaddress` varchar(30) NOT NULL,
  PRIMARY KEY (`gatewaystateid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of gatewaystate
-- ----------------------------

-- ----------------------------
-- Table structure for gatewaysysteminfo
-- ----------------------------
DROP TABLE IF EXISTS `gatewaysysteminfo`;
CREATE TABLE `gatewaysysteminfo` (
  `Sysaddress` int(11) NOT NULL,
  `Gatewayaddress` varchar(30) NOT NULL,
  `memo` varchar(1000) DEFAULT NULL,
  `tiSysType` int(11) NOT NULL,
  `siteid` char(20) NOT NULL,
  PRIMARY KEY (`Sysaddress`,`Gatewayaddress`),
  KEY `Refgateway140` (`Gatewayaddress`),
  KEY `RefonlineFiresystem142` (`tiSysType`,`siteid`),
  CONSTRAINT `Refgateway140` FOREIGN KEY (`Gatewayaddress`) REFERENCES `gateway` (`Gatewayaddress`),
  CONSTRAINT `RefonlineFiresystem142` FOREIGN KEY (`tiSysType`, `siteid`) REFERENCES `onlinefiresystem` (`tiSysType`, `siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of gatewaysysteminfo
-- ----------------------------

-- ----------------------------
-- Table structure for jobtype
-- ----------------------------
DROP TABLE IF EXISTS `jobtype`;
CREATE TABLE `jobtype` (
  `JobTypeName` varchar(100) NOT NULL,
  `OrderNum` int(11) DEFAULT NULL,
  PRIMARY KEY (`JobTypeName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jobtype
-- ----------------------------
INSERT INTO `jobtype` VALUES ('保安员', '6');
INSERT INTO `jobtype` VALUES ('其他重点岗位人员', '7');
INSERT INTO `jobtype` VALUES ('建设工程消防设施施工、监理、检测、维保等执业人员', '3');
INSERT INTO `jobtype` VALUES ('建设工程设计人员', '2');
INSERT INTO `jobtype` VALUES ('易燃易爆危险化学品从业人员', '4');
INSERT INTO `jobtype` VALUES ('消防安全监测人员', '1');
INSERT INTO `jobtype` VALUES ('电工、电气焊工等特殊工种作业人员', '5');

-- ----------------------------
-- Table structure for loginrecord
-- ----------------------------
DROP TABLE IF EXISTS `loginrecord`;
CREATE TABLE `loginrecord` (
  `LoginID` char(36) NOT NULL,
  `LoginTime` datetime DEFAULT NULL,
  `loginIp` varchar(50) DEFAULT NULL,
  `UserID` char(36) NOT NULL,
  PRIMARY KEY (`LoginID`),
  KEY `RefUsers86` (`UserID`),
  CONSTRAINT `RefUsers86` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of loginrecord
-- ----------------------------

-- ----------------------------
-- Table structure for maintenance
-- ----------------------------
DROP TABLE IF EXISTS `maintenance`;
CREATE TABLE `maintenance` (
  `MaintenanceId` char(36) NOT NULL,
  `EnrollNo` char(30) DEFAULT NULL,
  `UnitName` varchar(200) DEFAULT NULL,
  `UnitType` varchar(100) DEFAULT NULL,
  `Address` varchar(1000) DEFAULT NULL,
  `LegalRepresentative` varchar(100) DEFAULT NULL,
  `Assets` decimal(10,0) DEFAULT NULL,
  `SetupDate` date DEFAULT NULL,
  `LimitDate` varchar(200) DEFAULT NULL,
  `EngageRange` varchar(1000) DEFAULT NULL,
  `EnrollDepartMent` varchar(100) DEFAULT NULL,
  `EnrollDate` date DEFAULT NULL,
  `CheckState` varchar(20) DEFAULT NULL,
  `CheckDate` datetime DEFAULT NULL,
  `ContactName` varchar(100) DEFAULT NULL,
  `ContactMobilePhone` varchar(100) DEFAULT NULL,
  `memo` varchar(1000) DEFAULT NULL,
  `AreaId` char(6) DEFAULT NULL,
  PRIMARY KEY (`MaintenanceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of maintenance
-- ----------------------------
INSERT INTO `maintenance` VALUES ('ae166196a19b4cdb99167764253781d3', null, '四川维保大队', null, null, null, null, null, null, null, null, null, null, null, null, null, null, '110103');

-- ----------------------------
-- Table structure for maintenanceorginfo
-- ----------------------------
DROP TABLE IF EXISTS `maintenanceorginfo`;
CREATE TABLE `maintenanceorginfo` (
  `orgid` char(12) NOT NULL,
  `MaintenanceId` char(36) NOT NULL,
  `OrgRegistTime` datetime DEFAULT NULL,
  `RegistUser` varchar(50) DEFAULT NULL,
  `ReviewState` varchar(20) DEFAULT NULL,
  `ReviewTime` datetime DEFAULT NULL,
  `ReviewUserId` varchar(50) DEFAULT NULL,
  `ynterminate` varchar(20) DEFAULT NULL,
  `terminateman` varchar(100) DEFAULT NULL,
  `terminateTime` datetime DEFAULT NULL,
  `Ynagreement` varchar(10) DEFAULT NULL,
  `agreementTime` datetime DEFAULT NULL,
  `AgreementMan` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`orgid`,`MaintenanceId`),
  KEY `RefMaintenance48` (`MaintenanceId`),
  CONSTRAINT `RefMaintenance48` FOREIGN KEY (`MaintenanceId`) REFERENCES `maintenance` (`MaintenanceId`),
  CONSTRAINT `Refonlineorg47` FOREIGN KEY (`orgid`) REFERENCES `onlineorg` (`orgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of maintenanceorginfo
-- ----------------------------

-- ----------------------------
-- Table structure for managerorg
-- ----------------------------
DROP TABLE IF EXISTS `managerorg`;
CREATE TABLE `managerorg` (
  `ManagerOrgID` char(36) NOT NULL,
  `ManagerOrgName` varchar(100) DEFAULT NULL,
  `ManageOrgGrade` varchar(30) DEFAULT NULL,
  `PName` varchar(50) DEFAULT NULL,
  `ManagerJob` varchar(100) DEFAULT NULL,
  `ContactName` varchar(100) DEFAULT NULL,
  `ContactTel` varchar(100) DEFAULT NULL,
  `address` varchar(1000) DEFAULT NULL,
  `YnSetMonitor` varchar(2) DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `ParentID` char(36) DEFAULT NULL,
  `tel` varchar(100) DEFAULT NULL,
  `Remark` text,
  `AreaId` char(6) NOT NULL,
  PRIMARY KEY (`ManagerOrgID`),
  KEY `RefArea41` (`AreaId`),
  CONSTRAINT `Refarea41` FOREIGN KEY (`AreaId`) REFERENCES `area` (`AreaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of managerorg
-- ----------------------------

-- ----------------------------
-- Table structure for manoeuvre
-- ----------------------------
DROP TABLE IF EXISTS `manoeuvre`;
CREATE TABLE `manoeuvre` (
  `manoeuvreID` char(36) NOT NULL,
  `manoeuvretime` datetime DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `Department` varchar(100) DEFAULT NULL,
  `manager` varchar(50) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `scheme` varchar(1000) DEFAULT NULL,
  `attendperson` varchar(100) DEFAULT NULL,
  `implementation` varchar(1000) DEFAULT NULL,
  `summary` varchar(500) DEFAULT NULL,
  `suggestion` varchar(500) DEFAULT NULL,
  `orgid` char(12) DEFAULT NULL,
  `schemafile` varchar(500) DEFAULT NULL,
  `attendpersonfile` varchar(500) DEFAULT NULL,
  `implementationfile` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`manoeuvreID`),
  KEY `Refonlineorg146` (`orgid`),
  CONSTRAINT `Refonlineorg146` FOREIGN KEY (`orgid`) REFERENCES `onlineorg` (`orgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of manoeuvre
-- ----------------------------
INSERT INTO `manoeuvre` VALUES ('703bad9b1e2d4a0e8f5cf5a6bc776c8c', '2017-08-16 00:00:00', null, '恒华', null, null, null, '恒华', '恒华', null, '恒华', '621202000001', 'Uploading/Manoeuvre/703bad9b1e2d4a0e8f5cf5a6bc776c8c/Module-API-2017-8-17.doc', null, null);
INSERT INTO `manoeuvre` VALUES ('b1bbe7b092f342eebff8d58ab1f98cad', '2017-08-01 00:00:00', '恒华光迅', '恒华光迅', '恒华光迅', '恒华光迅', '恒华光迅', '恒华光迅', '恒华光迅', null, '恒华光迅', '110101000001', 'Uploading/Manoeuvre/b1bbe7b092f342eebff8d58ab1f98cad/module-api2.doc', null, null);
INSERT INTO `manoeuvre` VALUES ('f665d2a4bb5d4549b22c797b507269f4', '2017-08-10 00:00:00', null, '研发部', null, null, null, '三十人', '完成', null, '继续努力', '621202000001', 'Uploading/Manoeuvre/f665d2a4bb5d4549b22c797b507269f4/Module-API(2).doc', 'Uploading/Manoeuvre/f665d2a4bb5d4549b22c797b507269f4/Module-API-2017-8-17.doc', 'Uploading/Manoeuvre/f665d2a4bb5d4549b22c797b507269f4/Module-API-2017-8-17.doc');

-- ----------------------------
-- Table structure for module_usertype
-- ----------------------------
DROP TABLE IF EXISTS `module_usertype`;
CREATE TABLE `module_usertype` (
  `ModuleID` char(10) NOT NULL,
  `UserTypeID` varchar(20) NOT NULL,
  `Remark` text,
  PRIMARY KEY (`ModuleID`,`UserTypeID`),
  KEY `RefUserType4` (`UserTypeID`),
  CONSTRAINT `RefModuleList2` FOREIGN KEY (`ModuleID`) REFERENCES `modulelist` (`ModuleID`),
  CONSTRAINT `RefUserType4` FOREIGN KEY (`UserTypeID`) REFERENCES `usertype` (`UserTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of module_usertype
-- ----------------------------
INSERT INTO `module_usertype` VALUES ('M001000000', 'Orgmanager', '');
INSERT INTO `module_usertype` VALUES ('M001000000', 'Orgpatrol', '');
INSERT INTO `module_usertype` VALUES ('M002000000', 'Orgmanager', '');
INSERT INTO `module_usertype` VALUES ('M003000000', 'Orgmanager', '');
INSERT INTO `module_usertype` VALUES ('M004000000', 'Orgmanager', '');
INSERT INTO `module_usertype` VALUES ('M005000000', 'Orgmanager', '');
INSERT INTO `module_usertype` VALUES ('M006000000', 'Orgmanager', '');
INSERT INTO `module_usertype` VALUES ('M007000000', 'Orgmanager', '');
INSERT INTO `module_usertype` VALUES ('M008000000', 'Orgmanager', '');
INSERT INTO `module_usertype` VALUES ('M009000000', 'Orgmanager', '');
INSERT INTO `module_usertype` VALUES ('M010000000', 'maintenancemanager', '');
INSERT INTO `module_usertype` VALUES ('M010000000', 'maintenancetest', '');
INSERT INTO `module_usertype` VALUES ('M011000000', 'maintenancemanager', '');
INSERT INTO `module_usertype` VALUES ('M012000000', 'maintenancemanager', '');
INSERT INTO `module_usertype` VALUES ('M013000000', 'maintenancemanager', '');
INSERT INTO `module_usertype` VALUES ('M014000000', '119manager', '');
INSERT INTO `module_usertype` VALUES ('M015000000', '119assessor', '');
INSERT INTO `module_usertype` VALUES ('M015000000', '119manager', '');
INSERT INTO `module_usertype` VALUES ('M016000000', '119manager', '');
INSERT INTO `module_usertype` VALUES ('M017000000', 'admin', '');
INSERT INTO `module_usertype` VALUES ('M018000000', 'admin', '');
INSERT INTO `module_usertype` VALUES ('M019000000', 'admin', '');

-- ----------------------------
-- Table structure for modulelist
-- ----------------------------
DROP TABLE IF EXISTS `modulelist`;
CREATE TABLE `modulelist` (
  `ModuleID` char(10) NOT NULL,
  `ModuleName` varchar(50) DEFAULT NULL,
  `URL` varchar(500) DEFAULT NULL,
  `OrderNum` int(11) DEFAULT NULL,
  `ParentID` char(10) DEFAULT NULL,
  `levelnum` int(11) DEFAULT NULL,
  `pic` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ModuleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of modulelist
-- ----------------------------
INSERT INTO `modulelist` VALUES ('M001000000', '消防工作记录', '', '1', '', '1', 'FireRecord');
INSERT INTO `modulelist` VALUES ('M001000001', '每日防火巡查', './FireUnit/DailyFire.html', '21', 'M001000000', '2', '');
INSERT INTO `modulelist` VALUES ('M001000002', '防火检查', './FireUnit/FireInspection.html', '22', 'M001000000', '2', '');
INSERT INTO `modulelist` VALUES ('M001000003', '消防安全培训', './FireUnit/FireSafety.html', '23', 'M001000000', '2', '');
INSERT INTO `modulelist` VALUES ('M001000004', '灭火应急预案', './FireUnit/FireEmergency.html', '24', 'M001000000', '2', '');
INSERT INTO `modulelist` VALUES ('M002000000', '远程监控', '', '2', '', '1', 'RemoteControl ');
INSERT INTO `modulelist` VALUES ('M002000001', '处理报警', './FireUnit/ProcessingAlarm.html', '25', 'M002000000', '2', '');
INSERT INTO `modulelist` VALUES ('M002000002', '报警处理记录', './FireUnit/AlarmRecord.html', '26', 'M002000000', '2', '');
INSERT INTO `modulelist` VALUES ('M003000000', '制度和职责', '', '3', '', '1', 'SystemResponsibility ');
INSERT INTO `modulelist` VALUES ('M003000001', '消防管理制度', './FireUnit/ManagementSystem.html', '27', 'M003000000', '2', '');
INSERT INTO `modulelist` VALUES ('M003000002', '消防安全职责', './FireUnit/SafetyResponsibility.html', '28', 'M003000000', '2', '');
INSERT INTO `modulelist` VALUES ('M004000000', '机构及人员', '', '4', '', '1', 'InstitutionPersonnel ');
INSERT INTO `modulelist` VALUES ('M004000002', '消防队', './FireUnit/FireStation.html', '30', 'M004000000', '2', '');
INSERT INTO `modulelist` VALUES ('M004000003', '消防队装备', './FireUnit/FireEquipment.html', '31', 'M004000000', '2', '');
INSERT INTO `modulelist` VALUES ('M004000004', '重点岗位人员', './FireUnit/KeyPersonnel.html', '32', 'M004000000', '2', '');
INSERT INTO `modulelist` VALUES ('M004000005', '其它人员', './FireUnit/OtherPersonnel.html', '33', 'M004000000', '2', '');
INSERT INTO `modulelist` VALUES ('M004000006', '人员管理', './FireUnit/PersonnelSummary.html', '34', 'M004000000', '2', '');
INSERT INTO `modulelist` VALUES ('M005000000', '单位基本情况', '', '5', '', '1', 'UnitBase ');
INSERT INTO `modulelist` VALUES ('M005000001', '单位基本信息', './FireUnit/CompanyProfile.html', '35', 'M005000000', '2', '');
INSERT INTO `modulelist` VALUES ('M005000002', '建筑物信息', './FireUnit/BuildingInfo.html', '36', 'M005000000', '2', '');
INSERT INTO `modulelist` VALUES ('M005000003', '单位简介', './FireUnit/UnitProfile.html', '37', 'M005000000', '2', '');
INSERT INTO `modulelist` VALUES ('M005000004', '地理位置', './FireUnit/GeographicalPosition.html', '38', 'M005000000', '2', '');
INSERT INTO `modulelist` VALUES ('M005000005', '单位图纸信息', './FireUnit/DrawingInformation.html', '39', 'M005000000', '2', '');
INSERT INTO `modulelist` VALUES ('M005000006', '单位危险品', './FireUnit/DangerousGoods.html', '40', 'M005000000', '2', '');
INSERT INTO `modulelist` VALUES ('M006000000', '消防设施情况', '', '6', '', '1', 'FireService ');
INSERT INTO `modulelist` VALUES ('M006000001', '消防系统信息', './FireUnit/SystemInformation.html', '41', 'M006000000', '2', '');
INSERT INTO `modulelist` VALUES ('M006000002', '消防设备信息', './FireUnit/EquipmentInformation.html', '42', 'M006000000', '2', '');
INSERT INTO `modulelist` VALUES ('M006000003', '传输设备信息', './FireUnit/TransportInformation.html', '43', 'M006000000', '2', '');
INSERT INTO `modulelist` VALUES ('M006000004', '报警部件信息', './FireUnit/AlarmComponent.html', '44', 'M006000000', '2', '');
INSERT INTO `modulelist` VALUES ('M006000005', '实时数据监控', './FireUnit/DataMonitoring.html', null, 'M006000000', '2', '');
INSERT INTO `modulelist` VALUES ('M007000000', '注册签约', '', '7', '', '1', 'RegisterSign ');
INSERT INTO `modulelist` VALUES ('M007000001', '单位信息注册', './FireUnit/InformationRegistration.html', '45', 'M007000000', '2', '');
INSERT INTO `modulelist` VALUES ('M007000002', '签约维保单位', './FireUnit/SignMaintenance.html', '46', 'M007000000', '2', '');
INSERT INTO `modulelist` VALUES ('M008000000', '统计报表', '', '8', '', '1', 'StatisticalReport ');
INSERT INTO `modulelist` VALUES ('M008000001', '火警故障统计', './FireUnit/FireTrouble.html', '47', 'M008000000', '2', '');
INSERT INTO `modulelist` VALUES ('M008000002', '巡查情况统计', './FireUnit/PatrolStatistics.html', '48', 'M008000000', '2', '');
INSERT INTO `modulelist` VALUES ('M008000003', '单项检测统计', './FireUnit/IndividualTest.html', '49', 'M008000000', '2', '');
INSERT INTO `modulelist` VALUES ('M008000004', '综合情况统计', './FireUnit/ComprehensiveStatistics.html', '50', 'M008000000', '2', '');
INSERT INTO `modulelist` VALUES ('M009000000', '帐户管理', '', '9', '', '1', 'AccountManagement');
INSERT INTO `modulelist` VALUES ('M009000001', '帐户管理', './FireUnit/AccountManagement.html', '51', 'M009000000', '2', '');
INSERT INTO `modulelist` VALUES ('M010000000', '消防检测', '', '10', '', '1', 'FireDetection ');
INSERT INTO `modulelist` VALUES ('M010000001', '单项检测登记', './Technology/InspectionRegistration.html', '52', 'M010000000', '2', '');
INSERT INTO `modulelist` VALUES ('M010000002', '联动测试登记', './Technology/LinkageTest.html', '53', 'M010000000', '2', '');
INSERT INTO `modulelist` VALUES ('M011000000', '故障处理', '', '11', '', '1', 'Troubleshooting ');
INSERT INTO `modulelist` VALUES ('M011000001', '故障处理', './Technology/Troubleshooting.html', '54', 'M011000000', '2', '');
INSERT INTO `modulelist` VALUES ('M012000000', '帐户管理', '', '12', '', '1', 'AccountManagement ');
INSERT INTO `modulelist` VALUES ('M012000001', '帐户管理', './Technology/AccountManagement.html', '55', 'M012000000', '2', '');
INSERT INTO `modulelist` VALUES ('M013000000', '签约审批', '', '13', '', '1', 'ContractApproval ');
INSERT INTO `modulelist` VALUES ('M013000001', '签约审批', './Technology/ContractApproval.html', '56', 'M013000000', '2', '');
INSERT INTO `modulelist` VALUES ('M014000000', '消防管理情况', '', '14', '', '1', 'ManagementSituation ');
INSERT INTO `modulelist` VALUES ('M014000001', '防火单位巡查情况', './Competent/PatrolSituation.html', '57', 'M014000000', '2', '');
INSERT INTO `modulelist` VALUES ('M014000002', '值班情况', './Competent/OnDuty.html', '58', 'M014000000', '2', '');
INSERT INTO `modulelist` VALUES ('M014000003', '报警信息处理情况', './Competent/AlarmInformation.html', '59', 'M014000000', '2', '');
INSERT INTO `modulelist` VALUES ('M014000005', '设备单项检测情况', './Competent/EquipmentTest.html', '61', 'M014000000', '2', '');
INSERT INTO `modulelist` VALUES ('M014000006', '防火单位总览情况', './Competent/FireOverview.html', '62', 'M014000000', '2', '');
INSERT INTO `modulelist` VALUES ('M014000007', '防火单位评估情况', './Competent/FireDepartment.html', '69', 'M014000000', '2', '');
INSERT INTO `modulelist` VALUES ('M014000008', '火警处理结果统计', './Competent/ResultStatistics.html', null, 'M014000000', '2', '');
INSERT INTO `modulelist` VALUES ('M015000000', '注册单位管理', '', '15', '', '1', 'UnitManagement');
INSERT INTO `modulelist` VALUES ('M015000001', '注册单位审核', './Competent/RegistrationAudit.html', '63', 'M015000000', '2', '');
INSERT INTO `modulelist` VALUES ('M015000002', '注册单位查询', './Competent/UnitInquiry.html', '64', 'M015000000', '2', '');
INSERT INTO `modulelist` VALUES ('M016000000', '帐户管理', '', '16', '', '1', 'AccountManagement ');
INSERT INTO `modulelist` VALUES ('M016000001', '帐户管理', './Competent/AccountManagement.html', '65', 'M016000000', '2', '');
INSERT INTO `modulelist` VALUES ('M017000000', '防火单位查询', '', '17', '', '1', 'FireInquiry ');
INSERT INTO `modulelist` VALUES ('M017000001', '防火单位查询', './Admin/FireInquiry.html', '66', 'M017000000', '2', '');
INSERT INTO `modulelist` VALUES ('M018000000', '消防主管部门', '', '18', '', '1', 'FireDepartment ');
INSERT INTO `modulelist` VALUES ('M018000001', '组织机构', './Admin/InstitutionalFramework.html\r\n', '67', 'M018000000', '2', '');
INSERT INTO `modulelist` VALUES ('M019000000', '系统帐号管理', '', '19', '', '1', 'AccountManagement');
INSERT INTO `modulelist` VALUES ('M019000001', '帐户管理', './Admin/AccountManagement.html', '68', 'M019000000', '2', '');

-- ----------------------------
-- Table structure for onduty
-- ----------------------------
DROP TABLE IF EXISTS `onduty`;
CREATE TABLE `onduty` (
  `OndutyID` char(36) NOT NULL,
  `QueryTime` datetime DEFAULT NULL,
  `YnAnswer` varchar(10) DEFAULT NULL,
  `AnswerTime` datetime DEFAULT NULL,
  `Gatewayaddress` varchar(30) NOT NULL,
  PRIMARY KEY (`OndutyID`),
  KEY `Refgateway114` (`Gatewayaddress`),
  CONSTRAINT `Refgateway114` FOREIGN KEY (`Gatewayaddress`) REFERENCES `gateway` (`Gatewayaddress`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of onduty
-- ----------------------------

-- ----------------------------
-- Table structure for ondutyrecord
-- ----------------------------
DROP TABLE IF EXISTS `ondutyrecord`;
CREATE TABLE `ondutyrecord` (
  `RecordID` char(36) NOT NULL,
  `RecordTime` datetime DEFAULT NULL,
  `FireControlor` varchar(50) DEFAULT NULL,
  `Alarmattribution` varchar(50) DEFAULT NULL,
  `gangcontrolor` varchar(10) DEFAULT NULL,
  `ProcessResult` varchar(1000) DEFAULT NULL,
  `ControlorModel` varchar(100) DEFAULT NULL,
  `selfcheck` varchar(20) DEFAULT NULL,
  `eliminateVoice` varchar(20) DEFAULT NULL,
  `RESET` varchar(20) DEFAULT NULL,
  `MainPower` varchar(20) DEFAULT NULL,
  `SecondPower` varchar(20) DEFAULT NULL,
  `Faulthandling` varchar(1000) DEFAULT NULL,
  `CheckPeople` varchar(20) DEFAULT NULL,
  `DutySign` varchar(20) DEFAULT NULL,
  `ManagerSign` varchar(20) DEFAULT NULL,
  `orgid` char(12) NOT NULL,
  PRIMARY KEY (`RecordID`),
  KEY `Refonlineorg122` (`orgid`),
  CONSTRAINT `Refonlineorg122` FOREIGN KEY (`orgid`) REFERENCES `onlineorg` (`orgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ondutyrecord
-- ----------------------------

-- ----------------------------
-- Table structure for onlinefiresystem
-- ----------------------------
DROP TABLE IF EXISTS `onlinefiresystem`;
CREATE TABLE `onlinefiresystem` (
  `tiSysType` int(11) NOT NULL,
  `siteid` char(20) NOT NULL,
  `states` char(10) DEFAULT NULL,
  `YnOnline` varchar(10) DEFAULT NULL,
  `Remarks` char(100) DEFAULT NULL,
  `MaintenanceId` char(36) DEFAULT NULL,
  `SysFlatpic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tiSysType`,`siteid`),
  KEY `Refsite129` (`siteid`),
  KEY `RefMaintenance131` (`MaintenanceId`),
  CONSTRAINT `Reffiresystype74` FOREIGN KEY (`tiSysType`) REFERENCES `firesystype` (`tiSysType`),
  CONSTRAINT `RefMaintenance131` FOREIGN KEY (`MaintenanceId`) REFERENCES `maintenance` (`MaintenanceId`),
  CONSTRAINT `Refsite129` FOREIGN KEY (`siteid`) REFERENCES `site` (`siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of onlinefiresystem
-- ----------------------------

-- ----------------------------
-- Table structure for onlineorg
-- ----------------------------
DROP TABLE IF EXISTS `onlineorg`;
CREATE TABLE `onlineorg` (
  `orgid` char(12) NOT NULL,
  `orgcode` varchar(100) DEFAULT NULL,
  `orgname` varchar(100) NOT NULL,
  `vAddress` varchar(200) DEFAULT NULL,
  `OrganType` varchar(200) DEFAULT NULL,
  `vNamelegalperson` varchar(20) DEFAULT NULL,
  `otherthings` text,
  `YnImportant` char(2) DEFAULT NULL,
  `SuperiorOrg` varchar(100) DEFAULT NULL,
  `cZip` varchar(10) DEFAULT NULL,
  `vTel` varchar(50) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `E-Mail` varchar(100) DEFAULT NULL,
  `howmanypeople` int(11) DEFAULT NULL,
  `souyouzhi` varchar(100) DEFAULT NULL,
  `SetupDate` date DEFAULT NULL,
  `realtymoney` decimal(65,0) DEFAULT NULL,
  `ipersonnum` int(11) DEFAULT NULL,
  `fAreanum` decimal(18,2) DEFAULT NULL,
  `fBuildingarea` decimal(18,2) DEFAULT NULL,
  `GasType` varchar(50) DEFAULT NULL,
  `howmanyfireman` int(11) DEFAULT NULL,
  `howmanyexit` int(11) DEFAULT NULL,
  `howmanystair` int(11) DEFAULT NULL,
  `howmanylane` int(11) DEFAULT NULL,
  `howmanyelevator` int(11) DEFAULT NULL,
  `lanelocation` varchar(200) DEFAULT NULL,
  `vfireroomtel` varchar(15) DEFAULT NULL,
  `escapefloor` int(11) DEFAULT NULL,
  `escapebuildingarea` decimal(2,0) DEFAULT NULL,
  `escapelocation` varchar(100) DEFAULT NULL,
  `neareast` varchar(100) DEFAULT NULL,
  `nearsouth` varchar(100) DEFAULT NULL,
  `nearwest` varchar(100) DEFAULT NULL,
  `nearnorth` varchar(100) DEFAULT NULL,
  `AutoFireFacility` char(2) DEFAULT NULL,
  `bFlatpic` longblob,
  `fLongitude` float(8,0) DEFAULT NULL,
  `fLatitude` float(8,0) DEFAULT NULL,
  `dRecordDate` datetime DEFAULT NULL,
  `managegrade` varchar(200) DEFAULT NULL,
  `NetworkStatus` char(10) DEFAULT NULL,
  `NetworkTime` datetime DEFAULT NULL,
  `ApproveState` varchar(10) DEFAULT NULL,
  `ApproveTime` datetime DEFAULT NULL,
  `ApproveMan` varchar(50) DEFAULT NULL,
  `AreaId` char(6) NOT NULL,
  `ManagerOrgID` char(36) DEFAULT NULL,
  PRIMARY KEY (`orgid`),
  KEY `RefArea40` (`AreaId`),
  KEY `RefManagerOrg49` (`ManagerOrgID`),
  CONSTRAINT `Refarea40` FOREIGN KEY (`AreaId`) REFERENCES `area` (`AreaId`),
  CONSTRAINT `RefManagerOrg49` FOREIGN KEY (`ManagerOrgID`) REFERENCES `managerorg` (`ManagerOrgID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of onlineorg
-- ----------------------------
INSERT INTO `onlineorg` VALUES ('110101000001', null, '恒华广讯科技有限公司', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '待审批', null, null, '110101', null);
INSERT INTO `onlineorg` VALUES ('621202000001', null, '陇上江南', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '待审批', null, null, '621202', null);

-- ----------------------------
-- Table structure for people
-- ----------------------------
DROP TABLE IF EXISTS `people`;
CREATE TABLE `people` (
  `PeopleNo` char(36) NOT NULL,
  `identification` varchar(50) DEFAULT NULL,
  `PeopleName` varchar(50) DEFAULT NULL,
  `sex` char(2) DEFAULT NULL,
  `job` varchar(50) NOT NULL,
  `birthday` datetime DEFAULT NULL,
  `education` varchar(20) DEFAULT NULL,
  `tel` varchar(100) DEFAULT NULL,
  `department` varchar(200) DEFAULT NULL,
  `WorkBeginDate` datetime DEFAULT NULL,
  `YnTraining` varchar(2) DEFAULT NULL,
  `trainingTime` datetime DEFAULT NULL,
  `certificateID` varchar(50) DEFAULT NULL,
  `TypeandGrade` varchar(100) DEFAULT NULL,
  `TheoryExamScore` varchar(10) DEFAULT NULL,
  `TechExamScore` varchar(10) DEFAULT NULL,
  `totalscore` varchar(10) DEFAULT NULL,
  `issueorg` varchar(100) DEFAULT NULL,
  `issuedate` datetime DEFAULT NULL,
  `GetDate` datetime DEFAULT NULL,
  `YnEscapeLeader` char(1) DEFAULT NULL,
  `OnDutyArea` varchar(1000) DEFAULT NULL,
  `OrderNum` int(11) DEFAULT NULL,
  `PeoplePicPath` varchar(1000) DEFAULT NULL,
  `CertificatePicPath` varchar(1000) DEFAULT NULL,
  `orgid` char(12) NOT NULL,
  `PeopleTypeName` varchar(100) NOT NULL,
  `JobTypeName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PeopleNo`),
  KEY `Refonlineorg93` (`orgid`),
  KEY `RefPeopleType99` (`PeopleTypeName`),
  KEY `RefJobType100` (`JobTypeName`),
  CONSTRAINT `RefJobType100` FOREIGN KEY (`JobTypeName`) REFERENCES `jobtype` (`JobTypeName`),
  CONSTRAINT `Refonlineorg93` FOREIGN KEY (`orgid`) REFERENCES `onlineorg` (`orgid`),
  CONSTRAINT `RefPeopleType99` FOREIGN KEY (`PeopleTypeName`) REFERENCES `peopletype` (`PeopleTypeName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of people
-- ----------------------------

-- ----------------------------
-- Table structure for peopletype
-- ----------------------------
DROP TABLE IF EXISTS `peopletype`;
CREATE TABLE `peopletype` (
  `PeopleTypeName` varchar(100) NOT NULL,
  `OrderNo` int(11) DEFAULT NULL,
  PRIMARY KEY (`PeopleTypeName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of peopletype
-- ----------------------------
INSERT INTO `peopletype` VALUES ('专（兼）职消防安全管理人员', '4');
INSERT INTO `peopletype` VALUES ('消防控制室操作人员', '3');
INSERT INTO `peopletype` VALUES ('社会单位消防安全管理人', '2');
INSERT INTO `peopletype` VALUES ('社会单位消防安全责任人', '1');

-- ----------------------------
-- Table structure for phone_module_usertype
-- ----------------------------
DROP TABLE IF EXISTS `phone_module_usertype`;
CREATE TABLE `phone_module_usertype` (
  `ModuleID` char(10) NOT NULL,
  `UserTypeID` varchar(20) NOT NULL,
  `Remark` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`ModuleID`,`UserTypeID`),
  KEY `RefPhone_UserType117` (`UserTypeID`),
  CONSTRAINT `RefPhone_ModuleList116` FOREIGN KEY (`ModuleID`) REFERENCES `phone_modulelist` (`ModuleID`),
  CONSTRAINT `RefPhone_UserType117` FOREIGN KEY (`UserTypeID`) REFERENCES `phone_usertype` (`UserTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of phone_module_usertype
-- ----------------------------

-- ----------------------------
-- Table structure for phone_modulelist
-- ----------------------------
DROP TABLE IF EXISTS `phone_modulelist`;
CREATE TABLE `phone_modulelist` (
  `ModuleID` char(10) NOT NULL,
  `ModuleName` varchar(50) DEFAULT NULL,
  `OrderNum` int(11) DEFAULT NULL,
  `ParentID` char(10) DEFAULT NULL,
  `levelnum` int(11) DEFAULT NULL,
  PRIMARY KEY (`ModuleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of phone_modulelist
-- ----------------------------

-- ----------------------------
-- Table structure for phone_users
-- ----------------------------
DROP TABLE IF EXISTS `phone_users`;
CREATE TABLE `phone_users` (
  `UserID` char(36) NOT NULL,
  `account` varchar(100) NOT NULL,
  `PASSWORD` varchar(1000) DEFAULT NULL,
  `RealName` varchar(50) DEFAULT NULL,
  `mobilephone` varchar(50) DEFAULT NULL,
  `Tel` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `Remark` text,
  `UserBelongTo` varchar(50) DEFAULT NULL,
  `TokenID` varchar(100) DEFAULT NULL,
  `TokenExpireDate` datetime DEFAULT NULL,
  `MaintenanceId` char(36) DEFAULT NULL,
  `orgid` char(12) DEFAULT NULL,
  `ManagerOrgID` char(36) DEFAULT NULL,
  `UserTypeID` varchar(20) NOT NULL,
  PRIMARY KEY (`UserID`),
  KEY `RefMaintenance118` (`MaintenanceId`),
  KEY `Refonlineorg119` (`orgid`),
  KEY `RefManagerOrg120` (`ManagerOrgID`),
  KEY `RefPhone_UserType121` (`UserTypeID`),
  CONSTRAINT `RefMaintenance118` FOREIGN KEY (`MaintenanceId`) REFERENCES `maintenance` (`MaintenanceId`),
  CONSTRAINT `RefManagerOrg120` FOREIGN KEY (`ManagerOrgID`) REFERENCES `managerorg` (`ManagerOrgID`),
  CONSTRAINT `Refonlineorg119` FOREIGN KEY (`orgid`) REFERENCES `onlineorg` (`orgid`),
  CONSTRAINT `RefPhone_UserType121` FOREIGN KEY (`UserTypeID`) REFERENCES `phone_usertype` (`UserTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of phone_users
-- ----------------------------

-- ----------------------------
-- Table structure for phone_usertype
-- ----------------------------
DROP TABLE IF EXISTS `phone_usertype`;
CREATE TABLE `phone_usertype` (
  `UserTypeID` varchar(20) NOT NULL,
  `UserTypeName` varchar(40) DEFAULT NULL,
  `UserBelongTo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`UserTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of phone_usertype
-- ----------------------------

-- ----------------------------
-- Table structure for safeduty
-- ----------------------------
DROP TABLE IF EXISTS `safeduty`;
CREATE TABLE `safeduty` (
  `SafeDutyID` char(36) NOT NULL,
  `dutyname` varchar(500) DEFAULT NULL,
  `uploadtime` datetime DEFAULT NULL,
  `safedutytype` varchar(1000) DEFAULT NULL,
  `filepath` varchar(1000) DEFAULT NULL,
  `orgid` char(12) NOT NULL,
  PRIMARY KEY (`SafeDutyID`),
  KEY `Refonlineorg88` (`orgid`),
  CONSTRAINT `Refonlineorg88` FOREIGN KEY (`orgid`) REFERENCES `onlineorg` (`orgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of safeduty
-- ----------------------------

-- ----------------------------
-- Table structure for safemanagerules
-- ----------------------------
DROP TABLE IF EXISTS `safemanagerules`;
CREATE TABLE `safemanagerules` (
  `SafeManageRulesID` char(36) NOT NULL,
  `SafeManageRulesName` char(10) DEFAULT NULL,
  `UploadTime` datetime DEFAULT NULL,
  `SafeManageRulesType` varchar(1000) DEFAULT NULL,
  `filepath` varchar(1000) DEFAULT NULL,
  `orgid` char(12) NOT NULL,
  PRIMARY KEY (`SafeManageRulesID`),
  KEY `Refonlineorg89` (`orgid`),
  CONSTRAINT `Refonlineorg89` FOREIGN KEY (`orgid`) REFERENCES `onlineorg` (`orgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of safemanagerules
-- ----------------------------
INSERT INTO `safemanagerules` VALUES ('4af375b7810645fcb6cd98aaafaff8d1', '相仿管理制度', '2017-08-28 14:05:37', '', 'Uploading/ManageRule/4af375b7810645fcb6cd98aaafaff8d1/存储过程.txt', '110101000001');

-- ----------------------------
-- Table structure for site
-- ----------------------------
DROP TABLE IF EXISTS `site`;
CREATE TABLE `site` (
  `siteid` char(20) NOT NULL,
  `sitename` varchar(100) DEFAULT NULL,
  `buildingaddress` varchar(200) DEFAULT NULL,
  `useproperty` varchar(100) DEFAULT NULL,
  `DSCS` varchar(20) DEFAULT NULL,
  `JZGD` varchar(20) DEFAULT NULL,
  `DSJZMJ` varchar(20) DEFAULT NULL,
  `NHDJ` varchar(50) DEFAULT NULL,
  `JGLX` varchar(50) DEFAULT NULL,
  `DXCS` varchar(20) DEFAULT NULL,
  `DXJZMJ` varchar(20) DEFAULT NULL,
  `SDQK` varchar(500) DEFAULT NULL,
  `ZYCCW` varchar(500) DEFAULT NULL,
  `RLRS` varchar(10) DEFAULT NULL,
  `QLJZ` varchar(500) DEFAULT NULL,
  `east` varchar(500) DEFAULT NULL,
  `west` varchar(500) DEFAULT NULL,
  `south` varchar(500) DEFAULT NULL,
  `north` varchar(500) DEFAULT NULL,
  `xx` float(8,0) DEFAULT NULL,
  `yy` float(8,0) DEFAULT NULL,
  `sitetypename` varchar(100) DEFAULT NULL,
  `holdthings` varchar(100) DEFAULT NULL,
  `holdthingsnum` varchar(100) DEFAULT NULL,
  `annalTime` datetime NOT NULL,
  `fLongitude` float(8,0) DEFAULT NULL,
  `fLatitude` float(8,0) DEFAULT NULL,
  `orgid` char(12) NOT NULL,
  PRIMARY KEY (`siteid`),
  KEY `Refonlineorg14` (`orgid`),
  CONSTRAINT `Refonlineorg14` FOREIGN KEY (`orgid`) REFERENCES `onlineorg` (`orgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of site
-- ----------------------------

-- ----------------------------
-- Table structure for training
-- ----------------------------
DROP TABLE IF EXISTS `training`;
CREATE TABLE `training` (
  `TrainingID` char(36) NOT NULL,
  `TrainingTime` datetime DEFAULT NULL,
  `TrainingAddress` varchar(1000) DEFAULT NULL,
  `TrainingType` varchar(100) DEFAULT NULL,
  `TrainingObject` varchar(100) DEFAULT NULL,
  `HowmanyPeople` int(11) DEFAULT NULL,
  `Lecturer` varchar(50) DEFAULT NULL,
  `TrainingContent` varchar(1000) DEFAULT NULL,
  `AttendPeople` varchar(500) DEFAULT NULL,
  `Examination` varchar(100) DEFAULT NULL,
  `TrainingManager` varchar(40) DEFAULT NULL,
  `ContentFile` varchar(500) DEFAULT NULL,
  `signtable` varchar(500) DEFAULT NULL,
  `examfile` varchar(500) DEFAULT NULL,
  `orgid` char(12) NOT NULL,
  PRIMARY KEY (`TrainingID`),
  KEY `Refonlineorg145` (`orgid`),
  CONSTRAINT `Refonlineorg145` FOREIGN KEY (`orgid`) REFERENCES `onlineorg` (`orgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of training
-- ----------------------------
INSERT INTO `training` VALUES ('7ebd42a0422f4c4a8dbea495aa16f0ee', '2017-08-28 00:00:00', '融创汇', '普通', '所有人', '20', '李总', '我', '', '', '朱迪', 'Uploading/Training/7ebd42a0422f4c4a8dbea495aa16f0ee/UserManual-DOS-V4.3.0.pdf', 'Uploading/Training/7ebd42a0422f4c4a8dbea495aa16f0ee/文本(2017-08-04 092100).txt', 'Uploading/Training/7ebd42a0422f4c4a8dbea495aa16f0ee/文本(2017-08-04 092100).txt', '110101000001');

-- ----------------------------
-- Table structure for uerchecklist
-- ----------------------------
DROP TABLE IF EXISTS `uerchecklist`;
CREATE TABLE `uerchecklist` (
  `UserCheckId` char(36) NOT NULL,
  `UserCheckTime` datetime DEFAULT NULL,
  `OrgUserId` varchar(20) DEFAULT NULL,
  `OrgManagerId` varchar(20) DEFAULT NULL,
  `SubmitStatet` varchar(20) DEFAULT NULL,
  `SubmitTime` datetime DEFAULT NULL,
  `Remarks` varchar(200) DEFAULT NULL,
  `orgid` char(12) NOT NULL,
  PRIMARY KEY (`UserCheckId`),
  KEY `Refonlineorg56` (`orgid`),
  CONSTRAINT `Refonlineorg56` FOREIGN KEY (`orgid`) REFERENCES `onlineorg` (`orgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uerchecklist
-- ----------------------------
INSERT INTO `uerchecklist` VALUES ('341c87a85533499a88413a95f0268524', '2017-08-09 00:00:00', 'null', '问问', null, '2017-08-28 14:09:51', null, '110101000001');
INSERT INTO `uerchecklist` VALUES ('6ea17910102e4032af7c13a1b4e427a9', '2017-08-09 00:00:00', 'null', '问问', null, '2017-08-28 14:11:35', null, '110101000001');
INSERT INTO `uerchecklist` VALUES ('dbd179f546ae464f9a66457712f8fbd7', '2017-08-10 00:00:00', 'null', '晚进军', null, '2017-08-28 12:54:14', null, '110101000001');

-- ----------------------------
-- Table structure for usercheckcontent
-- ----------------------------
DROP TABLE IF EXISTS `usercheckcontent`;
CREATE TABLE `usercheckcontent` (
  `orgid` char(12) NOT NULL,
  `ProjectId` char(4) NOT NULL,
  `Remarks` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`orgid`,`ProjectId`),
  KEY `RefUserCheckProjectContent59` (`ProjectId`),
  CONSTRAINT `Refonlineorg55` FOREIGN KEY (`orgid`) REFERENCES `onlineorg` (`orgid`),
  CONSTRAINT `RefUserCheckProjectContent59` FOREIGN KEY (`ProjectId`) REFERENCES `usercheckprojectcontent` (`ProjectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usercheckcontent
-- ----------------------------

-- ----------------------------
-- Table structure for usercheckinfo
-- ----------------------------
DROP TABLE IF EXISTS `usercheckinfo`;
CREATE TABLE `usercheckinfo` (
  `UserCheckId` char(36) NOT NULL,
  `ProjectId` char(4) NOT NULL,
  `UserCheckResult` varchar(200) DEFAULT NULL,
  `FaultShow` varchar(500) DEFAULT NULL,
  `YnHanding` varchar(2) DEFAULT NULL,
  `Handingimmediately` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`UserCheckId`,`ProjectId`),
  KEY `RefUserCheckProjectContent60` (`ProjectId`),
  CONSTRAINT `RefUerCheckList58` FOREIGN KEY (`UserCheckId`) REFERENCES `uerchecklist` (`UserCheckId`),
  CONSTRAINT `RefUserCheckProjectContent60` FOREIGN KEY (`ProjectId`) REFERENCES `usercheckprojectcontent` (`ProjectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usercheckinfo
-- ----------------------------

-- ----------------------------
-- Table structure for usercheckpic
-- ----------------------------
DROP TABLE IF EXISTS `usercheckpic`;
CREATE TABLE `usercheckpic` (
  `PicID` char(36) NOT NULL,
  `PicType` varchar(10) DEFAULT NULL,
  `PicPath` varchar(1000) DEFAULT NULL,
  `UploadTime` datetime DEFAULT NULL,
  `UserCheckId` char(36) NOT NULL,
  `ProjectId` char(4) NOT NULL,
  PRIMARY KEY (`PicID`),
  KEY `RefUserCheckInfo82` (`UserCheckId`,`ProjectId`),
  CONSTRAINT `RefUserCheckInfo82` FOREIGN KEY (`UserCheckId`, `ProjectId`) REFERENCES `usercheckinfo` (`UserCheckId`, `ProjectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usercheckpic
-- ----------------------------

-- ----------------------------
-- Table structure for usercheckprojecklist
-- ----------------------------
DROP TABLE IF EXISTS `usercheckprojecklist`;
CREATE TABLE `usercheckprojecklist` (
  `ProjectId` char(4) NOT NULL,
  `ProjectName` varchar(50) DEFAULT NULL,
  `ProjectContent` varchar(100) DEFAULT NULL,
  `OrderNumber` int(11) DEFAULT NULL,
  `IsCheck` char(1) DEFAULT NULL,
  `tiSysType` int(11) NOT NULL,
  PRIMARY KEY (`ProjectId`),
  KEY `Reffiresystype63` (`tiSysType`),
  CONSTRAINT `Reffiresystype63` FOREIGN KEY (`tiSysType`) REFERENCES `firesystype` (`tiSysType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usercheckprojecklist
-- ----------------------------
INSERT INTO `usercheckprojecklist` VALUES ('1001', '消防配电', '试验主、备电切换功能', '1', '', '128');
INSERT INTO `usercheckprojecklist` VALUES ('1002', '自备发电机组', '试验启动发电机组', '2', '', '128');
INSERT INTO `usercheckprojecklist` VALUES ('1003', '储油设施', '核对储油量', '3', '', '128');
INSERT INTO `usercheckprojecklist` VALUES ('1004', '火灾报警探测器', '试验报警功能', '4', '', '1');
INSERT INTO `usercheckprojecklist` VALUES ('1005', '手动报警按钮', '试验报警功能', '5', '', '1');
INSERT INTO `usercheckprojecklist` VALUES ('1006', '警报装置', '试验警报功能', '6', '', '1');
INSERT INTO `usercheckprojecklist` VALUES ('1007', '报警控制器', '试验报警功能、故障报警功能、火警优先功能、打印机打印功能、火灾显示盘和CRT显示器的显示功能', '7', '', '1');
INSERT INTO `usercheckprojecklist` VALUES ('1008', '消防联动控制器', '试验联动控制和显示功能', '8', '', '1');
INSERT INTO `usercheckprojecklist` VALUES ('1009', '消防水池', '核对储水量', '9', '', '132');
INSERT INTO `usercheckprojecklist` VALUES ('1010', '消防水箱', '核对储水量', '10', '', '132');
INSERT INTO `usercheckprojecklist` VALUES ('1011', '稳（增）压泵及气压水罐', '试验启泵、停泵时的压力工况', '11', '', '132');
INSERT INTO `usercheckprojecklist` VALUES ('1012', '消防水泵', '试验启泵和主、备泵切换功能', '12', '', '132');
INSERT INTO `usercheckprojecklist` VALUES ('1013', '管道阀门', '试验管道阀门启闭功能', '13', '', '132');
INSERT INTO `usercheckprojecklist` VALUES ('1014', '室内消火栓', '试验屋顶消火栓出水及静压', '14', '', '219');
INSERT INTO `usercheckprojecklist` VALUES ('1015', '室外消火栓', '试验室外消火栓出水及静压', '15', '', '219');
INSERT INTO `usercheckprojecklist` VALUES ('1016', '消防炮', '试验消防炮出水', '16', '', '219');
INSERT INTO `usercheckprojecklist` VALUES ('1017', '启泵按钮', '实验远距离启泵功能', '17', '', '219');
INSERT INTO `usercheckprojecklist` VALUES ('1018', '报警阀组', '试验放水阀放水及压力开关动作信号', '18', '', '12');
INSERT INTO `usercheckprojecklist` VALUES ('1019', '末端试水装置', '试验末端放水及压力开关动作信号', '19', '', '12');
INSERT INTO `usercheckprojecklist` VALUES ('1020', '水流指示器', '核对反馈信号', '20', '', '12');
INSERT INTO `usercheckprojecklist` VALUES ('1021', '泡沫储液罐', '核对泡沫液有效期和储存量', '21', '', '16');
INSERT INTO `usercheckprojecklist` VALUES ('1022', '泡沫栓', '试验泡沫栓出水或出泡沫', '22', '', '16');
INSERT INTO `usercheckprojecklist` VALUES ('1023', '瓶组与储罐', '核对灭火剂储存量', '23', '', '13');
INSERT INTO `usercheckprojecklist` VALUES ('1024', '气体灭火控制设备', '模拟自动启闭，试验切断空调等相关联动', '24', '', '13');
INSERT INTO `usercheckprojecklist` VALUES ('1025', '风机', '实验联动启动风机', '25', '', '26');
INSERT INTO `usercheckprojecklist` VALUES ('1026', '送风口', '核对送风口风速', '26', '', '26');
INSERT INTO `usercheckprojecklist` VALUES ('1027', '风机', '试验联动启动风机', '27', '', '18');
INSERT INTO `usercheckprojecklist` VALUES ('1028', '排烟阀、电动排烟窗', '试验联动启动排烟阀、电动排烟窗；核对排烟口风速', '28', '', '18');
INSERT INTO `usercheckprojecklist` VALUES ('1029', '应急照明', '试验切断正常供电，测量照度', '29', '', '22');
INSERT INTO `usercheckprojecklist` VALUES ('1030', '疏散指示标志', '试验切断正常供电，测量照度', '30', '', '22');
INSERT INTO `usercheckprojecklist` VALUES ('1031', '扩音器', '试验联动启动和强制切换功能', '31', '', '21');
INSERT INTO `usercheckprojecklist` VALUES ('1032', '扬声器', '测量音量、音质', '32', '', '21');
INSERT INTO `usercheckprojecklist` VALUES ('1033', '消防专用电话', '试验通话质量', '33', '', '24');
INSERT INTO `usercheckprojecklist` VALUES ('1034', '防火门', '试验启闭功能', '34', '', '133');
INSERT INTO `usercheckprojecklist` VALUES ('1035', '防火卷帘', '试验手动、机械应急和自动控制功能', '35', '', '133');
INSERT INTO `usercheckprojecklist` VALUES ('1036', '电动防火阀', '试验联动关闭功能', '36', '', '133');
INSERT INTO `usercheckprojecklist` VALUES ('1037', '消防电梯', '试验按钮迫降和联动控制功能', '37', '', '20');
INSERT INTO `usercheckprojecklist` VALUES ('1038', '灭火器', '核对选型、压力和有效期', '38', '', '135');
INSERT INTO `usercheckprojecklist` VALUES ('1039', '其他设施', '', '39', '', '223');

-- ----------------------------
-- Table structure for usercheckproject
-- ----------------------------
DROP TABLE IF EXISTS `usercheckproject`;
CREATE TABLE `usercheckproject` (
  `ProjectId` char(4) NOT NULL,
  `orgid` char(12) NOT NULL,
  `DevicesCount` int(11) DEFAULT NULL,
  `Remarks` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ProjectId`,`orgid`),
  KEY `Refonlineorg65` (`orgid`),
  CONSTRAINT `Refonlineorg65` FOREIGN KEY (`orgid`) REFERENCES `onlineorg` (`orgid`),
  CONSTRAINT `RefUserCheckProjeckList64` FOREIGN KEY (`ProjectId`) REFERENCES `usercheckprojecklist` (`ProjectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usercheckproject
-- ----------------------------

-- ----------------------------
-- Table structure for usercheckprojectcontent
-- ----------------------------
DROP TABLE IF EXISTS `usercheckprojectcontent`;
CREATE TABLE `usercheckprojectcontent` (
  `ProjectId` char(4) NOT NULL,
  `ProjectContent` varchar(500) DEFAULT NULL,
  `OrderNumber` int(11) DEFAULT NULL,
  `IsMust` char(1) DEFAULT NULL,
  `tiSysType` int(11) NOT NULL,
  PRIMARY KEY (`ProjectId`),
  KEY `Reffiresystype62` (`tiSysType`),
  CONSTRAINT `Reffiresystype62` FOREIGN KEY (`tiSysType`) REFERENCES `firesystype` (`tiSysType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usercheckprojectcontent
-- ----------------------------
INSERT INTO `usercheckprojectcontent` VALUES ('1001', '消防电源工作状态', '1', '0', '128');
INSERT INTO `usercheckprojectcontent` VALUES ('1002', '自备发电设备状况', '2', '0', '128');
INSERT INTO `usercheckprojectcontent` VALUES ('1003', '消防配电房、发电机房环境', '3', '0', '128');
INSERT INTO `usercheckprojectcontent` VALUES ('1101', '火灾报警探测器外观', '4', '0', '221');
INSERT INTO `usercheckprojectcontent` VALUES ('1102', '区域显示器、CRT图形显示器、火灾报警控制器、消防联动控制器外观运行状况', '5', '0', '221');
INSERT INTO `usercheckprojectcontent` VALUES ('1103', '手动报警按钮外观', '6', '0', '221');
INSERT INTO `usercheckprojectcontent` VALUES ('1104', '火灾警报装置外观', '7', '0', '221');
INSERT INTO `usercheckprojectcontent` VALUES ('1105', '消防控制室工作环境', '8', '0', '221');
INSERT INTO `usercheckprojectcontent` VALUES ('1201', '消防水池外观', '9', '0', '132');
INSERT INTO `usercheckprojectcontent` VALUES ('1202', '消防水箱外观', '10', '0', '132');
INSERT INTO `usercheckprojectcontent` VALUES ('1203', '消防水泵及控制柜工作状态', '11', '0', '132');
INSERT INTO `usercheckprojectcontent` VALUES ('1204', '稳压泵、增压泵、气压泵罐工作状态', '12', '0', '132');
INSERT INTO `usercheckprojectcontent` VALUES ('1205', '水泵接合器外观、标识', '13', '0', '132');
INSERT INTO `usercheckprojectcontent` VALUES ('1206', '管网控制阀门启闭状态', '14', '0', '132');
INSERT INTO `usercheckprojectcontent` VALUES ('1207', '泵房工作环境', '15', '0', '132');
INSERT INTO `usercheckprojectcontent` VALUES ('1301', '室内消火栓外观', '16', '0', '219');
INSERT INTO `usercheckprojectcontent` VALUES ('1302', '室外消火栓外观', '17', '0', '219');
INSERT INTO `usercheckprojectcontent` VALUES ('1303', '消防炮外观', '18', '0', '219');
INSERT INTO `usercheckprojectcontent` VALUES ('1304', '启泵按钮外观', '19', '0', '219');
INSERT INTO `usercheckprojectcontent` VALUES ('1401', '喷头外观', '20', '0', '12');
INSERT INTO `usercheckprojectcontent` VALUES ('1402', '报警阀组外观', '21', '0', '12');
INSERT INTO `usercheckprojectcontent` VALUES ('1403', '末端试水装置压力值', '22', '0', '12');
INSERT INTO `usercheckprojectcontent` VALUES ('1501', '泡沫喷头外观', '23', '0', '16');
INSERT INTO `usercheckprojectcontent` VALUES ('1502', '泡沫消火栓外观', '24', '0', '16');
INSERT INTO `usercheckprojectcontent` VALUES ('1503', '泡沫炮外观', '25', '0', '16');
INSERT INTO `usercheckprojectcontent` VALUES ('1504', '泡沫产生器外观', '26', '0', '16');
INSERT INTO `usercheckprojectcontent` VALUES ('1505', '泡沫液贮罐间环境', '27', '0', '16');
INSERT INTO `usercheckprojectcontent` VALUES ('1506', '泡沫液贮罐外观', '28', '0', '16');
INSERT INTO `usercheckprojectcontent` VALUES ('1507', '比例混合器外观', '29', '0', '16');
INSERT INTO `usercheckprojectcontent` VALUES ('1508', '泡沫泵工作状态', '30', '0', '16');
INSERT INTO `usercheckprojectcontent` VALUES ('1601', '气体灭火控制器工作状态', '31', '0', '13');
INSERT INTO `usercheckprojectcontent` VALUES ('1602', '储瓶间环境', '32', '0', '13');
INSERT INTO `usercheckprojectcontent` VALUES ('1603', '气体瓶组或储罐外观', '33', '0', '13');
INSERT INTO `usercheckprojectcontent` VALUES ('1604', '选择阀、驱动装置等组件外观', '34', '0', '13');
INSERT INTO `usercheckprojectcontent` VALUES ('1605', '紧急启/停按钮外观', '35', '0', '13');
INSERT INTO `usercheckprojectcontent` VALUES ('1606', '放气指示灯及警报器外观', '36', '0', '13');
INSERT INTO `usercheckprojectcontent` VALUES ('1607', '喷嘴外观', '37', '0', '13');
INSERT INTO `usercheckprojectcontent` VALUES ('1608', '防护区状况', '38', '0', '13');
INSERT INTO `usercheckprojectcontent` VALUES ('1701', '挡烟垂壁外观', '39', '0', '18');
INSERT INTO `usercheckprojectcontent` VALUES ('1702', '送风阀外观', '40', '0', '18');
INSERT INTO `usercheckprojectcontent` VALUES ('1703', '送风机工作状态', '41', '0', '18');
INSERT INTO `usercheckprojectcontent` VALUES ('1704', '排烟阀外观', '42', '0', '18');
INSERT INTO `usercheckprojectcontent` VALUES ('1705', '电动排烟窗外观', '43', '0', '18');
INSERT INTO `usercheckprojectcontent` VALUES ('1706', '自然排烟窗外观', '44', '0', '18');
INSERT INTO `usercheckprojectcontent` VALUES ('1707', '排烟机工作状态', '45', '0', '18');
INSERT INTO `usercheckprojectcontent` VALUES ('1708', '送风、排烟机房环境', '46', '0', '18');
INSERT INTO `usercheckprojectcontent` VALUES ('1801', '应急灯外观', '47', '0', '22');
INSERT INTO `usercheckprojectcontent` VALUES ('1802', '应急灯工作状态', '48', '0', '22');
INSERT INTO `usercheckprojectcontent` VALUES ('1803', '疏散指示标志外观', '49', '0', '22');
INSERT INTO `usercheckprojectcontent` VALUES ('1804', '疏散指示标志工作状态', '50', '0', '22');
INSERT INTO `usercheckprojectcontent` VALUES ('1901', '扬声器外观', '51', '0', '21');
INSERT INTO `usercheckprojectcontent` VALUES ('1902', '扩音机工作状态', '52', '0', '21');
INSERT INTO `usercheckprojectcontent` VALUES ('2001', '分机电话外观', '53', '0', '24');
INSERT INTO `usercheckprojectcontent` VALUES ('2002', '插孔电话', '54', '0', '24');
INSERT INTO `usercheckprojectcontent` VALUES ('2101', '防火门外观', '55', '0', '133');
INSERT INTO `usercheckprojectcontent` VALUES ('2102', '防火门启闭状况', '56', '0', '133');
INSERT INTO `usercheckprojectcontent` VALUES ('2103', '防火卷帘外观', '57', '0', '133');
INSERT INTO `usercheckprojectcontent` VALUES ('2104', '防火卷帘工作状态', '58', '0', '133');
INSERT INTO `usercheckprojectcontent` VALUES ('2201', '紧急按钮外观', '59', '0', '20');
INSERT INTO `usercheckprojectcontent` VALUES ('2202', '轿厢内电话外观', '60', '0', '20');
INSERT INTO `usercheckprojectcontent` VALUES ('2203', '消防电梯工作状态', '61', '0', '20');
INSERT INTO `usercheckprojectcontent` VALUES ('2301', '灭火器外观', '62', '0', '135');
INSERT INTO `usercheckprojectcontent` VALUES ('2302', '设置位置状况', '63', '0', '135');
INSERT INTO `usercheckprojectcontent` VALUES ('2401', '其他设施', '64', '0', '223');
INSERT INTO `usercheckprojectcontent` VALUES ('2403', '巡查人', '65', '0', '223');
INSERT INTO `usercheckprojectcontent` VALUES ('2406', '消防安全管理人', '66', '0', '223');
INSERT INTO `usercheckprojectcontent` VALUES ('2409', '备注', '67', '0', '223');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `UserID` char(36) NOT NULL,
  `account` varchar(100) NOT NULL,
  `PASSWORD` varchar(1000) DEFAULT NULL,
  `RealName` varchar(50) DEFAULT NULL,
  `mobilephone` varchar(50) DEFAULT NULL,
  `Tel` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `isFirstEnroll` char(2) DEFAULT NULL,
  `Remark` text,
  `UserBelongTo` varchar(50) DEFAULT NULL,
  `TokenID` varchar(100) DEFAULT NULL,
  `TokenExpireDate` datetime DEFAULT NULL,
  `ManagerOrgID` char(36) DEFAULT NULL,
  `UserTypeID` varchar(20) NOT NULL,
  `orgid` char(12) DEFAULT NULL,
  `MaintenanceId` char(36) DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  KEY `RefUserType3` (`UserTypeID`),
  KEY `RefManagerOrg6` (`ManagerOrgID`),
  KEY `Refonlineorg84` (`orgid`),
  KEY `RefMaintenance85` (`MaintenanceId`),
  CONSTRAINT `RefMaintenance85` FOREIGN KEY (`MaintenanceId`) REFERENCES `maintenance` (`MaintenanceId`),
  CONSTRAINT `RefManagerOrg6` FOREIGN KEY (`ManagerOrgID`) REFERENCES `managerorg` (`ManagerOrgID`),
  CONSTRAINT `Refonlineorg84` FOREIGN KEY (`orgid`) REFERENCES `onlineorg` (`orgid`),
  CONSTRAINT `RefUserType3` FOREIGN KEY (`UserTypeID`) REFERENCES `usertype` (`UserTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('101f922b4b054cc2a4bf7fdffe3e65f6', '789', 'cf2fa0ee49ad1c0336a0e643a0b726a6', null, null, null, null, null, '是', null, '2', null, null, null, 'maintenancemanager', null, 'ae166196a19b4cdb99167764253781d3');
INSERT INTO `users` VALUES ('6ec04b9ed0144ff58de3605da4010157', '123', 'cf2fa0ee49ad1c0336a0e643a0b726a6', null, null, null, null, null, '是', null, '1', null, null, null, 'Orgmanager', '110101000001', null);
INSERT INTO `users` VALUES ('b045e816fc284a6d9199588d17503708', '456', 'cf2fa0ee49ad1c0336a0e643a0b726a6', null, null, null, null, null, '是', null, '1', null, null, null, 'Orgmanager', '621202000001', null);

-- ----------------------------
-- Table structure for usertype
-- ----------------------------
DROP TABLE IF EXISTS `usertype`;
CREATE TABLE `usertype` (
  `UserTypeID` varchar(20) NOT NULL,
  `UserTypeName` varchar(40) DEFAULT NULL,
  `UserBelongTo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`UserTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usertype
-- ----------------------------
INSERT INTO `usertype` VALUES ('119assessor', '消防主管部门审核员', '3');
INSERT INTO `usertype` VALUES ('119manager', '消防主管部门管理员', '3');
INSERT INTO `usertype` VALUES ('admin', '系统管理员', '4');
INSERT INTO `usertype` VALUES ('maintenancemanager', '维保单位管理员', '2');
INSERT INTO `usertype` VALUES ('maintenancetest', '维保单位维保测试人员', '2');
INSERT INTO `usertype` VALUES ('Orgmanager', '防火单位管理员', '1');
INSERT INTO `usertype` VALUES ('Orgpatrol', '防火单位巡查员', '1');

-- ----------------------------
-- Table structure for wbcheckinfo
-- ----------------------------
DROP TABLE IF EXISTS `wbcheckinfo`;
CREATE TABLE `wbcheckinfo` (
  `wbId` int(11) NOT NULL AUTO_INCREMENT,
  `wbCheckResult` varchar(200) DEFAULT NULL,
  `wbProblemRemaks` varchar(300) DEFAULT NULL,
  `tiSysType` int(11) NOT NULL,
  `wbCheckId` char(36) NOT NULL,
  `YnHanding` varchar(2) DEFAULT NULL,
  `Handingimmediately` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`wbId`),
  KEY `RefwbCheckList80` (`wbCheckId`),
  KEY `Reffiresystype81` (`tiSysType`),
  CONSTRAINT `Reffiresystype81` FOREIGN KEY (`tiSysType`) REFERENCES `firesystype` (`tiSysType`),
  CONSTRAINT `RefwbCheckList80` FOREIGN KEY (`wbCheckId`) REFERENCES `wbchecklist` (`wbCheckId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wbcheckinfo
-- ----------------------------

-- ----------------------------
-- Table structure for wbchecklist
-- ----------------------------
DROP TABLE IF EXISTS `wbchecklist`;
CREATE TABLE `wbchecklist` (
  `wbCheckId` char(36) NOT NULL,
  `wbCheckRemark` varchar(200) DEFAULT NULL,
  `CheckDate` datetime DEFAULT NULL,
  `wbUserId` varchar(20) DEFAULT NULL,
  `wbCheckTime` datetime DEFAULT NULL,
  `CheckOrgName` varchar(100) DEFAULT NULL,
  `OrgUserManagerMark` varchar(20) DEFAULT NULL,
  `OrgUserManagerMarkTime` datetime DEFAULT NULL,
  `siteid` char(20) NOT NULL,
  PRIMARY KEY (`wbCheckId`),
  KEY `Refsite76` (`siteid`),
  CONSTRAINT `Refsite76` FOREIGN KEY (`siteid`) REFERENCES `site` (`siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wbchecklist
-- ----------------------------

-- ----------------------------
-- Table structure for wbdevicerepairinfo_auto
-- ----------------------------
DROP TABLE IF EXISTS `wbdevicerepairinfo_auto`;
CREATE TABLE `wbdevicerepairinfo_auto` (
  `wbRepairInfoId` char(22) NOT NULL,
  `wbRepairTime` datetime DEFAULT NULL,
  `wbUserID` varchar(50) DEFAULT NULL,
  `wbProblemInfo` varchar(1000) DEFAULT NULL,
  `UserManagerRemaks` varchar(500) DEFAULT NULL,
  `UserAdminNameMark` varchar(50) DEFAULT NULL,
  `HandingState` varchar(20) DEFAULT NULL,
  `DealResult` varchar(200) DEFAULT NULL,
  `SolutionUserManagerMark` varchar(20) DEFAULT NULL,
  `source` varchar(10) DEFAULT NULL,
  `wbRepairListId` char(36) DEFAULT NULL,
  `ProjectId` char(4) DEFAULT NULL,
  `Firealarmid` char(36) NOT NULL,
  PRIMARY KEY (`wbRepairInfoId`),
  KEY `Refalarmdata128` (`Firealarmid`),
  CONSTRAINT `Refalarmdata128` FOREIGN KEY (`Firealarmid`) REFERENCES `alarmdata` (`Firealarmid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wbdevicerepairinfo_auto
-- ----------------------------

-- ----------------------------
-- Table structure for wbdevicerepairinfo_comovement
-- ----------------------------
DROP TABLE IF EXISTS `wbdevicerepairinfo_comovement`;
CREATE TABLE `wbdevicerepairinfo_comovement` (
  `wbRepairInfoId` char(22) NOT NULL,
  `wbRepairTime` datetime DEFAULT NULL,
  `wbUserID` varchar(50) DEFAULT NULL,
  `wbProblemInfo` varchar(1000) DEFAULT NULL,
  `UserManagerRemaks` varchar(500) DEFAULT NULL,
  `UserAdminNameMark` varchar(50) DEFAULT NULL,
  `HandingState` varchar(20) DEFAULT NULL,
  `DealResult` varchar(200) DEFAULT NULL,
  `SolutionUserManagerMark` varchar(20) DEFAULT NULL,
  `source` varchar(10) DEFAULT NULL,
  `wbRepairListId` char(36) DEFAULT NULL,
  `ProjectId` char(4) DEFAULT NULL,
  `wbCheckId` char(36) NOT NULL,
  PRIMARY KEY (`wbRepairInfoId`),
  KEY `RefwbCheckList130` (`wbCheckId`),
  CONSTRAINT `RefwbCheckList130` FOREIGN KEY (`wbCheckId`) REFERENCES `wbchecklist` (`wbCheckId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wbdevicerepairinfo_comovement
-- ----------------------------

-- ----------------------------
-- Table structure for wbdevicerepairinfo_patrol
-- ----------------------------
DROP TABLE IF EXISTS `wbdevicerepairinfo_patrol`;
CREATE TABLE `wbdevicerepairinfo_patrol` (
  `wbRepairInfoId` char(22) NOT NULL,
  `wbRepairTime` datetime DEFAULT NULL,
  `wbUserID` varchar(50) DEFAULT NULL,
  `wbProblemInfo` varchar(1000) DEFAULT NULL,
  `UserManagerRemaks` varchar(500) DEFAULT NULL,
  `UserAdminNameMark` varchar(50) DEFAULT NULL,
  `HandingState` varchar(20) DEFAULT NULL,
  `DealResult` varchar(200) DEFAULT NULL,
  `SolutionUserManagerMark` varchar(20) DEFAULT NULL,
  `UserCheckId` char(36) NOT NULL,
  `ProjectId` char(4) NOT NULL,
  PRIMARY KEY (`wbRepairInfoId`),
  KEY `RefUserCheckInfo143` (`UserCheckId`,`ProjectId`),
  CONSTRAINT `RefUserCheckInfo143` FOREIGN KEY (`UserCheckId`, `ProjectId`) REFERENCES `usercheckinfo` (`UserCheckId`, `ProjectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wbdevicerepairinfo_patrol
-- ----------------------------

-- ----------------------------
-- Table structure for wbdevicerepairinfo_test
-- ----------------------------
DROP TABLE IF EXISTS `wbdevicerepairinfo_test`;
CREATE TABLE `wbdevicerepairinfo_test` (
  `wbRepairInfoId` char(22) NOT NULL,
  `wbRepairTime` datetime DEFAULT NULL,
  `wbUserID` varchar(50) DEFAULT NULL,
  `wbProblemInfo` varchar(1000) DEFAULT NULL,
  `UserManagerRemaks` varchar(500) DEFAULT NULL,
  `UserAdminNameMark` varchar(50) DEFAULT NULL,
  `HandingState` varchar(20) DEFAULT NULL,
  `DealResult` varchar(200) DEFAULT NULL,
  `SolutionUserManagerMark` varchar(20) DEFAULT NULL,
  `source` varchar(10) DEFAULT NULL,
  `wbRepairListId` char(36) DEFAULT NULL,
  `ProjectId` char(4) DEFAULT NULL,
  PRIMARY KEY (`wbRepairInfoId`),
  KEY `RefwbRepairInfo73` (`wbRepairListId`,`ProjectId`),
  CONSTRAINT `RefwbRepairInfo73` FOREIGN KEY (`wbRepairListId`, `ProjectId`) REFERENCES `wbrepairinfo` (`wbRepairListId`, `ProjectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wbdevicerepairinfo_test
-- ----------------------------

-- ----------------------------
-- Table structure for wbrepairinfo
-- ----------------------------
DROP TABLE IF EXISTS `wbrepairinfo`;
CREATE TABLE `wbrepairinfo` (
  `wbRepairListId` char(36) NOT NULL,
  `ProjectId` char(4) NOT NULL,
  `wbRepairedNumber` int(11) DEFAULT NULL,
  `wbRepairedRemarks` varchar(1000) DEFAULT NULL,
  `IsGood` varchar(10) DEFAULT NULL,
  `YnHanding` varchar(2) DEFAULT NULL,
  `Handingimmediately` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`wbRepairListId`,`ProjectId`),
  KEY `RefUserCheckProjeckList67` (`ProjectId`),
  CONSTRAINT `RefUserCheckProjeckList67` FOREIGN KEY (`ProjectId`) REFERENCES `usercheckprojecklist` (`ProjectId`),
  CONSTRAINT `RefwbRepairList66` FOREIGN KEY (`wbRepairListId`) REFERENCES `wbrepairlist` (`wbRepairListId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wbrepairinfo
-- ----------------------------

-- ----------------------------
-- Table structure for wbrepairlist
-- ----------------------------
DROP TABLE IF EXISTS `wbrepairlist`;
CREATE TABLE `wbrepairlist` (
  `wbRepairListId` char(36) NOT NULL,
  `wbRepairTime` datetime DEFAULT NULL,
  `wbRepairPerson` varchar(50) DEFAULT NULL,
  `OrgManagerMarl` varchar(50) DEFAULT NULL,
  `IsReport` varchar(10) DEFAULT NULL,
  `ReportTime` datetime DEFAULT NULL,
  `orgid` char(12) NOT NULL,
  `MaintenanceId` char(36) DEFAULT NULL,
  PRIMARY KEY (`wbRepairListId`),
  KEY `Refonlineorg69` (`orgid`),
  KEY `RefMaintenance71` (`MaintenanceId`),
  CONSTRAINT `RefMaintenance71` FOREIGN KEY (`MaintenanceId`) REFERENCES `maintenance` (`MaintenanceId`),
  CONSTRAINT `Refonlineorg69` FOREIGN KEY (`orgid`) REFERENCES `onlineorg` (`orgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wbrepairlist
-- ----------------------------

-- ----------------------------
-- Table structure for xfchecktimeround
-- ----------------------------
DROP TABLE IF EXISTS `xfchecktimeround`;
CREATE TABLE `xfchecktimeround` (
  `RoundId` int(11) NOT NULL AUTO_INCREMENT,
  `RoundName` varchar(50) DEFAULT NULL,
  `RoundDays` int(11) DEFAULT NULL,
  PRIMARY KEY (`RoundId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xfchecktimeround
-- ----------------------------
INSERT INTO `xfchecktimeround` VALUES ('1', '一天', '1');
INSERT INTO `xfchecktimeround` VALUES ('2', '一周', '7');
INSERT INTO `xfchecktimeround` VALUES ('3', '一月', '30');
INSERT INTO `xfchecktimeround` VALUES ('4', '一年', '365');

-- ----------------------------
-- View structure for v_CheckRecord
-- ----------------------------
DROP VIEW IF EXISTS `v_CheckRecord`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_CheckRecord` AS select `a`.`ProjectName` AS `ProjectName`,`c`.`UserCheckId` AS `UserCheckId`,`c`.`UserCheckTime` AS `UserCheckTime`,`c`.`OrgUserId` AS `OrgUserId`,`c`.`OrgManagerId` AS `OrgManagerId`,`e`.`ProjectContent` AS `ProjectContent`,`d`.`UserCheckResult` AS `UserCheckResult`,`d`.`FaultShow` AS `FaultShow`,`d`.`YnHanding` AS `YnHanding`,`d`.`Handingimmediately` AS `Handingimmediately`,`f`.`PicPath` AS `PicPath` from (((((`usercheckprojecklist` `a` join `usercheckproject` `b` on((`a`.`ProjectId` = `b`.`ProjectId`))) join `uerchecklist` `c` on((`b`.`orgid` = `c`.`orgid`))) join `usercheckinfo` `d` on((`c`.`UserCheckId` = `d`.`UserCheckId`))) join `usercheckprojectcontent` `e` on((`d`.`ProjectId` = `e`.`ProjectId`))) join `usercheckpic` `f` on((`d`.`ProjectId` = `f`.`ProjectId`))) ;

-- ----------------------------
-- View structure for v_city
-- ----------------------------
DROP VIEW IF EXISTS `v_city`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_city` AS select `a`.`AreaId` AS `AreaId`,concat(`c`.`AreaName`,`b`.`AreaName`,`a`.`AreaName`) AS `city` from ((`area` `a` join `area` `b` on((`a`.`ParentId` = `b`.`AreaId`))) join `area` `c` on((`c`.`AreaId` = `b`.`ParentId`))) ;

-- ----------------------------
-- View structure for v_FireAlarm
-- ----------------------------
DROP VIEW IF EXISTS `v_FireAlarm`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_FireAlarm` AS select `a`.`vSysdesc` AS `vSysdesc`,`b`.`DeviceTypeName` AS `DeviceTypeName`,`c`.`DeviceNo` AS `DeviceNo`,`c`.`fPositionX` AS `fPositionX`,`c`.`fPositionY` AS `fPositionY`,`c`.`location` AS `location`,`c`.`deviceaddress` AS `deviceaddress`,`c`.`Sysaddress` AS `Sysaddress`,`c`.`Gatewayaddress` AS `Gatewayaddress`,`d`.`floornum` AS `floornum`,`d`.`imFlatPic` AS `imFlatPic`,`e`.`siteid` AS `siteid`,`e`.`sitename` AS `sitename`,`e`.`fLongitude` AS `fLongitude`,`e`.`fLatitude` AS `fLatitude`,`f`.`orgid` AS `orgid`,`f`.`orgname` AS `orgname`,`f`.`vfireroomtel` AS `vfireroomtel`,`f`.`bFlatpic` AS `bFlatpic` from (((((`firesystype` `a` join `devicetype` `b` on((`a`.`tiSysType` = `b`.`tiSysType`))) join `devices` `c` on((`b`.`iDeviceType` = `c`.`iDeviceType`))) join `flatpic` `d` on((`c`.`cFlatPic` = `d`.`cFlatPic`))) join `site` `e` on((`d`.`siteid` = `e`.`siteid`))) join `onlineorg` `f` on((`e`.`orgid` = `f`.`orgid`))) ;

-- ----------------------------
-- View structure for v_Gateway
-- ----------------------------
DROP VIEW IF EXISTS `v_Gateway`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_Gateway` AS select `A`.`orgid` AS `orgid`,`D`.`Gatewayaddress` AS `Gatewayaddress`,`A`.`siteid` AS `siteid`,`A`.`sitename` AS `sitename`,`E`.`tiSysType` AS `tiSysType`,`E`.`vSysdesc` AS `vSysdesc`,`C`.`Sysaddress` AS `Sysaddress` from ((((`site` `A` join `onlinefiresystem` `B` on((`A`.`siteid` = `B`.`siteid`))) join `gatewaysysteminfo` `C` on(((`C`.`tiSysType` = `B`.`tiSysType`) and (`C`.`siteid` = `B`.`siteid`)))) join `gateway` `D` on((`D`.`Gatewayaddress` = `C`.`Gatewayaddress`))) join `firesystype` `E` on((`E`.`tiSysType` = `C`.`tiSysType`))) ;

-- ----------------------------
-- View structure for v_PatrolDetail
-- ----------------------------
DROP VIEW IF EXISTS `v_PatrolDetail`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_PatrolDetail` AS select `ui`.`UserCheckId` AS `UserCheckId`,`ui`.`ProjectId` AS `ProjectId`,`ft`.`vSysdesc` AS `vSysdesc`,`uc`.`ProjectContent` AS `ProjectContent`,`ui`.`UserCheckResult` AS `UserCheckResult`,`ui`.`FaultShow` AS `FaultShow`,`ui`.`YnHanding` AS `YnHanding`,`ui`.`Handingimmediately` AS `Handingimmediately` from ((`usercheckinfo` `ui` join `usercheckprojectcontent` `uc` on((`uc`.`ProjectId` = `ui`.`ProjectId`))) join `firesystype` `ft` on((`ft`.`tiSysType` = `uc`.`tiSysType`))) ;

-- ----------------------------
-- View structure for v_PatrolProject
-- ----------------------------
DROP VIEW IF EXISTS `v_PatrolProject`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_PatrolProject` AS select `a`.`orgid` AS `orgid`,`c`.`vSysdesc` AS `vSysdesc`,`a`.`ProjectId` AS `ProjectId`,`b`.`ProjectContent` AS `ProjectContent`,`c`.`tiSysType` AS `tiSysType`,`c`.`OrderNO` AS `OrderNO`,`b`.`OrderNumber` AS `OrderNumber` from ((`usercheckcontent` `a` join `usercheckprojectcontent` `b` on((`b`.`ProjectId` = `a`.`ProjectId`))) join `firesystype` `c` on((`c`.`tiSysType` = `b`.`tiSysType`))) ;
 
---- The user specified as a definer ('montor'@'%') does not exist---
grant all privileges on *.* to root@"%" identified by ".";