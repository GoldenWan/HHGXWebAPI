/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : hhnew

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2017-08-15 11:15:33
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
  `HostID` varchar(10) NOT NULL,
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
-- Table structure for equipmenttype
-- ----------------------------
DROP TABLE IF EXISTS `equipmenttype`;
CREATE TABLE `equipmenttype` (
  `equipmenttype` varchar(50) NOT NULL,
  `ordernum` int(11) DEFAULT NULL,
  PRIMARY KEY (`equipmenttype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Table structure for jobtype
-- ----------------------------
DROP TABLE IF EXISTS `jobtype`;
CREATE TABLE `jobtype` (
  `JobTypeName` varchar(100) NOT NULL,
  `OrderNum` int(11) DEFAULT NULL,
  PRIMARY KEY (`JobTypeName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `ParentID` int(11) DEFAULT NULL,
  `tel` varchar(100) DEFAULT NULL,
  `Remark` text,
  `AreaId` char(6) NOT NULL,
  PRIMARY KEY (`ManagerOrgID`),
  KEY `RefArea41` (`AreaId`),
  CONSTRAINT `RefArea41` FOREIGN KEY (`AreaId`) REFERENCES `area` (`AreaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for managerorg_copy
-- ----------------------------
DROP TABLE IF EXISTS `managerorg_copy`;
CREATE TABLE `managerorg_copy` (
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
  `ParentID` int(11) DEFAULT NULL,
  `tel` varchar(100) DEFAULT NULL,
  `Remark` text,
  `AreaId` char(6) NOT NULL,
  PRIMARY KEY (`ManagerOrgID`),
  KEY `RefArea41` (`AreaId`),
  CONSTRAINT `managerorg_copy_ibfk_1` FOREIGN KEY (`AreaId`) REFERENCES `area` (`AreaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  PRIMARY KEY (`tiSysType`,`siteid`),
  KEY `Refsite129` (`siteid`),
  KEY `RefMaintenance131` (`MaintenanceId`),
  CONSTRAINT `Reffiresystype74` FOREIGN KEY (`tiSysType`) REFERENCES `firesystype` (`tiSysType`),
  CONSTRAINT `RefMaintenance131` FOREIGN KEY (`MaintenanceId`) REFERENCES `maintenance` (`MaintenanceId`),
  CONSTRAINT `Refsite129` FOREIGN KEY (`siteid`) REFERENCES `site` (`siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  CONSTRAINT `RefArea40` FOREIGN KEY (`AreaId`) REFERENCES `area` (`AreaId`),
  CONSTRAINT `RefManagerOrg49` FOREIGN KEY (`ManagerOrgID`) REFERENCES `managerorg` (`ManagerOrgID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Table structure for peopletype
-- ----------------------------
DROP TABLE IF EXISTS `peopletype`;
CREATE TABLE `peopletype` (
  `PeopleTypeName` varchar(100) NOT NULL,
  `OrderNo` int(11) DEFAULT NULL,
  PRIMARY KEY (`PeopleTypeName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Table structure for xfchecktimeround
-- ----------------------------
DROP TABLE IF EXISTS `xfchecktimeround`;
CREATE TABLE `xfchecktimeround` (
  `RoundId` int(11) NOT NULL AUTO_INCREMENT,
  `RoundName` varchar(50) DEFAULT NULL,
  `RoundDays` int(11) DEFAULT NULL,
  PRIMARY KEY (`RoundId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
