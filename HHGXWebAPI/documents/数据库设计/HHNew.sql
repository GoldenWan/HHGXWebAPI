sqlserver  ==> mysql  区别
专有名词要 `status`
char(255)
realtymoney DECIMAL (65, 0),




--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      Microsoft
-- Project :      消防管理平台.DM1
-- Author :       Microsoft
--
-- Date Created : Monday, August 14, 2017 00:32:31
-- Target DBMS : MySQL 5.x
--

-- 
-- TABLE: alarmdata 
--

CREATE TABLE alarmdata(
    Firealarmid         CHAR(36)         NOT NULL,
    cAlarmtype          VARCHAR(10),
    Gatewayaddress      VARCHAR(30),
    sysaddress          INT,
    systypeID           INT,
    deviceaddress       VARCHAR(30),
    idevicetype         INT,
    dFirstAlarmtime     DATETIME,
    faultdesc           VARCHAR(300),
    StateValue          INT,
    dRecentAlarmtime    DATETIME,
    dReceivetime        DATETIME,
    AlarmNum            INT,
    vAlarmsource        VARCHAR(20),
    checkresult         VARCHAR(50),
    checkdesc           VARCHAR(1000),
    chulidate           DATETIME,
    chuliren            VARCHAR(100),
    YnRequest           VARCHAR(10),
    PRIMARY KEY (Firealarmid)
)ENGINE=INNODB
;



-- 
-- TABLE: analogType 
--
CREATE TABLE analogType (
	anlogTypeID INT NOT NULL,
	vanalogDesc VARCHAR (50),
	vUnit VARCHAR (10),
	minvalue INT,
	`MAXVALUE` INT,
	minUnit VARCHAR (50),
	PRIMARY KEY (anlogTypeID)
) ENGINE = INNODB;




-- 
-- TABLE: AnalogValue 
--
CREATE TABLE AnalogValue (
	AnalogID CHAR (36) NOT NULL,
	address VARCHAR (30),
	Sysaddress INT,
	tiSysType INT,
	ivalue INT,
	iAnalogType INT,
	ValueTime DATETIME,
	Gatewayaddress VARCHAR (30),
	PRIMARY KEY (AnalogID)
) ENGINE = INNODB;

-- 
-- TABLE: AnlogAlarmSettings 
--
CREATE TABLE AnlogAlarmSettings (
	deviceaddress VARCHAR (30) NOT NULL,
	Sysaddress INT NOT NULL,
	Gatewayaddress VARCHAR (30) NOT NULL,
	LowValue INT,
	UpValue INT,
	PRIMARY KEY (
		deviceaddress,
		Sysaddress,
		Gatewayaddress
	)
) ENGINE = INNODB;

-- 
-- TABLE: Appearancepic 
--
CREATE TABLE Appearancepic (
	iphotoID CHAR (15) NOT NULL,
	vPhotoname VARCHAR (100) NOT NULL,
	dRecordDate DATETIME,
	Picpath VARCHAR (255),
	ExteriorInfo TEXT,
	siteid CHAR (20) NOT NULL,
	PRIMARY KEY (iphotoID)
) ENGINE = INNODB;

-- 
-- TABLE: Area 
--
CREATE TABLE Area (
	AreaId CHAR (6) NOT NULL,
	AreaName NATIONAL VARCHAR (20),
	`LEVEL` CHAR (1),
	ParentId CHAR (6),
	ZipCode CHAR (6) DEFAULT 0,
	Abbreviation VARCHAR (20),
	Remarks NATIONAL VARCHAR (300),
	PRIMARY KEY (AreaId)
) ENGINE = INNODB;

-- 
-- TABLE: BusinessLicence 
--
CREATE TABLE BusinessLicence (
	LicenceCode VARCHAR (15) NOT NULL,
	ConpanyName VARCHAR (100),
	CompanyType VARCHAR (100),
	CompanyAddress VARCHAR (100),
	CompanyRegister VARCHAR (20),
	RegistMoney DECIMAL (18, 0),
	BuildTime DATE,
	BusinessEndTime DATETIME,
	BusinessScope VARCHAR (100),
	AuditingDepartment VARCHAR (100),
	RegistTime DATE,
	PictureUrl VARCHAR (255),
	orgid CHAR (12) NOT NULL,
	PRIMARY KEY (LicenceCode)
) ENGINE = INNODB;

-- 
-- TABLE: cTestPeriod 
--
CREATE TABLE cTestPeriod (
	cTestPeriod VARCHAR (10) NOT NULL,
	vTestPeriod VARCHAR (100),
	days INT,
	PRIMARY KEY (cTestPeriod)
) ENGINE = INNODB;

-- 
-- TABLE: dangerousGoods 
--
CREATE TABLE dangerousGoods (
	cGoodsID CHAR (36) NOT NULL,
	vGoodsName VARCHAR (100),
	deAmount DECIMAL (10, 2),
	vUnit VARCHAR (50),
	vPutSite VARCHAR (500),
	vGoodsStatus VARCHAR (50),
	vLevel VARCHAR (50),
	vGoodsUse VARCHAR (500),
	vTechdirector VARCHAR (50),
	vTechdirectorTel CHAR (50),
	vSafeManager VARCHAR (50),
	vSafeManagerTel VARCHAR (50),
	vMeasure VARCHAR (500),
	vYnSetsign VARCHAR (10),
	vOperateDesc VARCHAR (500),
	orgid CHAR (12) NOT NULL,
	vTypeName VARCHAR (50) NOT NULL,
	PRIMARY KEY (cGoodsID)
) ENGINE = INNODB;

-- 
-- TABLE: dangerousGoodsType 
--
CREATE TABLE dangerousGoodsType (
	vTypeName VARCHAR (50) NOT NULL,
	vBelongto VARCHAR (50),
	iOrderNo INT,
	PRIMARY KEY (vTypeName)
) ENGINE = INNODB;

-- 
-- TABLE: DetectPic 
--
CREATE TABLE DetectPic (
	DetectPicID CHAR (36) NOT NULL,
	UploadTime DATETIME,
	PicType VARCHAR (10),
	picpath VARCHAR (255),
	wbRepairListId CHAR (36) NOT NULL,
	ProjectId CHAR (4) NOT NULL,
	PRIMARY KEY (DetectPicID)
) ENGINE = INNODB;

-- 
-- TABLE: devices 
--
CREATE TABLE devices (
	deviceaddress VARCHAR (30) NOT NULL,
	Sysaddress INT NOT NULL,
	Gatewayaddress VARCHAR (30) NOT NULL,
	vdesc VARCHAR (500),
	dRecorddate DATETIME,
	fPositionX FLOAT (8, 0),
	fPositionY FLOAT (8, 0),
	location VARCHAR (100),
	Manufacture VARCHAR (50),
	Model VARCHAR (50),
	ProductDate DATETIME,
	expdate DATETIME,
	memo VARCHAR (255),
	AddTime DATETIME,
	StateValue INT,
	StateTime DATETIME,
	DeviceNo INT,
	HostID VARCHAR (10) NOT NULL,
	Road VARCHAR (10),
	address VARCHAR (10),
	cFlatPic CHAR (14),
	iDeviceType INT,
	PRIMARY KEY (
		deviceaddress,
		Sysaddress,
		Gatewayaddress
	)
) ENGINE = INNODB;

-- 
-- TABLE: devicestate 
--
CREATE TABLE devicestate (
	bideviceStateID BIGINT NOT NULL,
	iSystype INT,
	iSysaddress INT,
	iDeviceType INT,
	iDeviceAddress VARCHAR (30) NOT NULL,
	StateValue INT,
	w0 CHAR (1),
	w1 CHAR (1),
	w2 CHAR (1),
	w3 CHAR (1),
	w4 CHAR (1),
	w5 CHAR (1),
	w6 CHAR (1),
	w7 CHAR (1),
	w8 CHAR (1),
	w9 CHAR (1),
	w10 CHAR (1),
	w11 CHAR (1),
	w12 CHAR (1),
	w13 CHAR (1),
	w14 CHAR (1),
	w15 CHAR (1),
	dStateoccurtime DATETIME,
	dReceiveTime DATETIME,
	Gatewayaddress VARCHAR (30) NOT NULL,
	PRIMARY KEY (bideviceStateID)
) ENGINE = INNODB;

-- 
-- TABLE: devicetype 
--
CREATE TABLE devicetype (
	iDeviceType INT NOT NULL,
	DeviceTypeName VARCHAR (100),
	tiSysType INT NOT NULL,
	PRIMARY KEY (iDeviceType)
) ENGINE = INNODB;

-- 
-- TABLE: Dictionary 
--
CREATE TABLE Dictionary (
	DictionaryID CHAR (36) NOT NULL,
	ItemName VARCHAR (100),
	TypeName VARCHAR (20),
	TypeID INT,
	OrderNum INT,
	PRIMARY KEY (DictionaryID)
) ENGINE = INNODB;

-- 
-- TABLE: equipment 
--
CREATE TABLE equipment (
	EquipmentID CHAR (36) NOT NULL,
	equipmentName VARCHAR (100),
	equipmentmodel VARCHAR (100),
	equipmentNum INT,
	equipmenttype VARCHAR (50) NOT NULL,
	isGood VARCHAR (10),
	BuyDate DATE,
	memo TEXT,
	firecompayid CHAR (36) NOT NULL,
	PRIMARY KEY (EquipmentID)
) ENGINE = INNODB;

-- 
-- TABLE: equipmentType 
--
CREATE TABLE equipmentType (
	equipmenttype VARCHAR (50) NOT NULL,
	ordernum INT,
	PRIMARY KEY (equipmenttype)
) ENGINE = INNODB;

-- 
-- TABLE: Eventinfos 
--
CREATE TABLE Eventinfos (
	Firealarmid CHAR (36) NOT NULL,
	cAlarmtype VARCHAR (10),
	Gatewayaddress VARCHAR (30),
	sysaddress INT,
	systypeID INT,
	deviceaddress VARCHAR (30),
	idevicetype INT,
	faultdesc VARCHAR (300),
	dFirstAlarmtime DATETIME,
	StateValue INT,
	dRecentAlarmtime DATETIME,
	dReceivetime DATETIME,
	AlarmNum INT,
	vAlarmsource VARCHAR (20),
	PRIMARY KEY (Firealarmid)
) ENGINE = INNODB;

-- 
-- TABLE: firecompany 
--
CREATE TABLE firecompany (
	firecompayid CHAR (36) NOT NULL,
	firecompanyname VARCHAR (100),
	CreateDate DATE,
	contactor VARCHAR (30),
	Tel VARCHAR (50),
	baseinfo VARCHAR (255),
	memo TEXT,
	orgid CHAR (12) NOT NULL,
	PRIMARY KEY (firecompayid)
) ENGINE = INNODB;

-- 
-- TABLE: FireDevice 
--
CREATE TABLE FireDevice (
	deviceNo CHAR (30) NOT NULL,
	devicename VARCHAR (100),
	Manufacture VARCHAR (100),
	model VARCHAR (100),
	productDate DATE,
	validate DATE,
	SetupDate DATE,
	SetLocation VARCHAR (255),
	memo TEXT,
	siteid CHAR (20),
	iDeviceType INT NOT NULL,
	PRIMARY KEY (deviceNo)
) ENGINE = INNODB;

-- 
-- TABLE: FireDeviceChangeRecord 
--
CREATE TABLE FireDeviceChangeRecord (
	ChangeNo CHAR (22) NOT NULL,
	ChangeDate DATETIME,
	Manufacture VARCHAR (100),
	ProductModel VARCHAR (50),
	ProductDate DATETIME,
	Validate DATETIME,
	Others VARCHAR (255),
	PicPath VARCHAR (255),
	deviceNo CHAR (30) NOT NULL,
	PRIMARY KEY (ChangeNo)
) ENGINE = INNODB;

-- 
-- TABLE: FireSafetyCheck 
--
CREATE TABLE FireSafetyCheck (
	FireSafetyCheckID CHAR (36) NOT NULL,
	CheckTime DATETIME,
	checkposite VARCHAR (100),
	Department VARCHAR (100),
	Problem VARCHAR (255),
	handing VARCHAR (255),
	attendperson VARCHAR (200),
	CheckedDepartment VARCHAR (500),
	RecordMan VARCHAR (100),
	SafetyMan VARCHAR (100),
	orgid CHAR (12) NOT NULL,
	PRIMARY KEY (FireSafetyCheckID)
) ENGINE = INNODB;

-- 
-- TABLE: firesysstate 
--
CREATE TABLE firesysstate (
	biSysStateID BIGINT NOT NULL,
	iSysType INT,
	tiSysAddress INT,
	StateValue INT,
	w0 CHAR (1),
	w1 CHAR (1),
	w2 CHAR (1),
	w3 CHAR (1),
	w4 CHAR (1),
	w5 CHAR (1),
	w6 CHAR (1),
	w7 CHAR (1),
	w8 CHAR (1),
	w9 CHAR (1),
	w10 CHAR (1),
	w11 CHAR (1),
	w12 CHAR (1),
	w13 CHAR (1),
	w14 CHAR (1),
	w15 CHAR (1),
	dStateOccurTime DATETIME,
	dReceiveTime DATETIME,
	Gatewayaddress VARCHAR (30) NOT NULL,
	PRIMARY KEY (biSysStateID)
) ENGINE = INNODB;

-- 
-- TABLE: firesystype 
--
CREATE TABLE firesystype (
	tiSysType INT NOT NULL,
	vSysdesc VARCHAR (100) NOT NULL,
	OrderNO INT,
	PRIMARY KEY (tiSysType)
) ENGINE = INNODB;

-- 
-- TABLE: flatpic 
--
CREATE TABLE flatpic (
	cFlatPic CHAR (14) NOT NULL,
	vPlatpicdesc VARCHAR (100),
	dRecordSet DATETIME,
	imFlatPic VARCHAR (255),
	floornum VARCHAR (50),
	PicName VARCHAR (30),
	siteid CHAR (20) NOT NULL,
	PRIMARY KEY (cFlatPic)
) ENGINE = INNODB;

-- 
-- TABLE: gateway 
--
CREATE TABLE gateway (
	Gatewayaddress VARCHAR (30) NOT NULL,
	ynonline NATIONAL VARCHAR (4),
	onlinetime DATETIME,
	Manufacturer VARCHAR (100),
	Model VARCHAR (50),
	productdate DATETIME,
	setupdate DATETIME,
	ControlorManufacture VARCHAR (100),
	ControlorMode VARCHAR (100),
	ConnectControlerState NATIONAL VARCHAR (50),
	MainPower VARCHAR (10),
	BackupPower VARCHAR (10),
	CableState VARCHAR (10),
	memo VARCHAR (255),
	gatewayversion VARCHAR (100),
	versionupdatedate DATETIME,
	gatewaytype VARCHAR (100),
	workState VARCHAR (10),
	annalTime DATETIME,
	PRIMARY KEY (Gatewayaddress)
) ENGINE = INNODB;

-- 
-- TABLE: gatewayopinfo 
--
CREATE TABLE gatewayopinfo (
	iOpeID CHAR (36) NOT NULL,
	StateValue INT,
	w0 CHAR (1),
	w1 CHAR (1),
	w2 CHAR (1),
	w3 CHAR (1),
	w4 CHAR (1),
	w5 CHAR (1),
	w6 CHAR (1),
	w7 CHAR (1),
	dOpRecordDate DATETIME,
	dReceivetime DATETIME,
	Gatewayaddress VARCHAR (30) NOT NULL,
	PRIMARY KEY (iOpeID)
) ENGINE = INNODB;

-- 
-- TABLE: gatewaystate 
--
CREATE TABLE gatewaystate (
	gatewaystateid CHAR (36) NOT NULL,
	cRunstate VARCHAR (10),
	statevalue INT,
	w0 CHAR (1),
	w1 CHAR (1),
	w2 CHAR (1),
	w3 CHAR (1),
	w4 CHAR (1),
	w5 CHAR (1),
	w6 CHAR (1),
	w7 CHAR (1),
	dStateoccurtime DATETIME,
	dReceivetime DATETIME,
	Gatewayaddress VARCHAR (30) NOT NULL,
	PRIMARY KEY (gatewaystateid)
) ENGINE = INNODB;

-- 
-- TABLE: GatewaySystemInfo 
--
CREATE TABLE GatewaySystemInfo (
	Sysaddress INT NOT NULL,
	Gatewayaddress VARCHAR (30) NOT NULL,
	memo VARCHAR (255),
	tiSysType INT NOT NULL,
	siteid CHAR (20) NOT NULL,
	PRIMARY KEY (Sysaddress, Gatewayaddress)
) ENGINE = INNODB;

-- 
-- TABLE: Introduce 
--
CREATE TABLE Introduce (
	orgid CHAR (12) NOT NULL,
	vIntroduceText VARCHAR (5000),
	vPicturePath VARCHAR (255),
	PRIMARY KEY (orgid)
) ENGINE = INNODB;

-- 
-- TABLE: JobType 
--
CREATE TABLE JobType (
	JobTypeName VARCHAR (100) NOT NULL,
	OrderNum INT,
	PRIMARY KEY (JobTypeName)
) ENGINE = INNODB;

-- 
-- TABLE: LoginRecord 
--
CREATE TABLE LoginRecord (
	LoginID CHAR (36) NOT NULL,
	LoginTime DATETIME,
	loginIp VARCHAR (50),
	UserID CHAR (36) NOT NULL,
	PRIMARY KEY (LoginID)
) ENGINE = INNODB;

-- 
-- TABLE: Maintenance 
--
CREATE TABLE Maintenance (
	MaintenanceId CHAR (36) NOT NULL,
	EnrollNo CHAR (30) NOT NULL,
	UnitName VARCHAR (200),
	UnitType VARCHAR (100),
	Address VARCHAR (255),
	LegalRepresentative VARCHAR (100),
	Assets DECIMAL (10, 0),
	SetupDate DATE,
	LimitDate VARCHAR (200),
	EngageRange VARCHAR (255),
	EnrollDepartMent VARCHAR (100),
	EnrollDate DATE,
	CheckState VARCHAR (20),
	CheckDate DATETIME,
	ContactName VARCHAR (100),
	ContactMobilePhone VARCHAR (100),
	memo VARCHAR (255),
	AreaId CHAR (6),
	cTestPeriod VARCHAR (10),
	PRIMARY KEY (MaintenanceId)
) ENGINE = INNODB;

-- 
-- TABLE: MaintenanceOrgInfo 
--
CREATE TABLE MaintenanceOrgInfo (
	orgid CHAR (12) NOT NULL,
	MaintenanceId CHAR (36) NOT NULL,
	OrgRegistTime DATETIME,
	RegistUser VARCHAR (50),
	ReviewState VARCHAR (20),
	ReviewTime DATETIME,
	ReviewUserId VARCHAR (50),
	ynterminate VARCHAR (20),
	terminateman VARCHAR (100),
	terminateTime DATETIME,
	Ynagreement VARCHAR (10),
	agreementTime DATETIME,
	AgreementMan VARCHAR (20),
	PRIMARY KEY (orgid, MaintenanceId)
) ENGINE = INNODB;

-- 
-- TABLE: ManagerOrg 
--
CREATE TABLE ManagerOrg (
	ManagerOrgID CHAR (36) NOT NULL,
	ManagerOrgName VARCHAR (100),
	ManageOrgGrade VARCHAR (30),
	PName VARCHAR (50),
	ManagerJob VARCHAR (100),
	ContactName VARCHAR (100),
	ContactTel VARCHAR (100),
	address VARCHAR (255),
	YnSetMonitor VARCHAR (2),
	`STATUS` VARCHAR (10),
	ParentID INT,
	tel VARCHAR (100),
	Remark TEXT,
	AreaId CHAR (6) NOT NULL,
	PRIMARY KEY (ManagerOrgID)
) ENGINE = INNODB;

-- 
-- TABLE: manoeuvre 
--
CREATE TABLE manoeuvre (
	manoeuvreID CHAR (36) NOT NULL,
	manoeuvretime DATETIME,
	address VARCHAR (500),
	Department VARCHAR (100),
	manager VARCHAR (50),
	content VARCHAR (255),
	scheme VARCHAR (255),
	attendperson VARCHAR (100),
	implementation VARCHAR (255),
	summary VARCHAR (500),
	suggestion VARCHAR (500),
	orgid CHAR (12),
	PRIMARY KEY (manoeuvreID)
) ENGINE = INNODB;

-- 
-- TABLE: Module_UserType 
--
CREATE TABLE Module_UserType (
	ModuleID CHAR (10) NOT NULL,
	UserTypeID VARCHAR (20) NOT NULL,
	Remark TEXT,
	PRIMARY KEY (ModuleID, UserTypeID)
) ENGINE = INNODB;

-- 
-- TABLE: ModuleList 
--
CREATE TABLE ModuleList (
	ModuleID CHAR (10) NOT NULL,
	ModuleName VARCHAR (50),
	URL VARCHAR (500),
	OrderNum INT,
	ParentID CHAR (10),
	levelnum INT,
	pic VARCHAR (100),
	PRIMARY KEY (ModuleID)
) ENGINE = INNODB;

-- 
-- TABLE: OnDuty 
--
CREATE TABLE OnDuty (
	OndutyID CHAR (36) NOT NULL,
	QueryTime DATETIME,
	YnAnswer VARCHAR (10),
	AnswerTime DATETIME,
	Gatewayaddress VARCHAR (30) NOT NULL,
	PRIMARY KEY (OndutyID)
) ENGINE = INNODB;

-- 
-- TABLE: OnDutyRecord 
--
CREATE TABLE OnDutyRecord (
	RecordID CHAR (36) NOT NULL,
	RecordTime DATETIME,
	FireControlor VARCHAR (50),
	Alarmattribution VARCHAR (50),
	gangcontrolor VARCHAR (10),
	ProcessResult text,
	ControlorModel VARCHAR (100),
	selfcheck VARCHAR (20),
	eliminateVoice VARCHAR (20),
	`RESET` VARCHAR (20),
	MainPower VARCHAR (20),
	SecondPower VARCHAR (20),
	Faulthandling VARCHAR (255),
	CheckPeople VARCHAR (20),
	DutySign VARCHAR (20),
	ManagerSign VARCHAR (20),
	orgid CHAR (12) NOT NULL,
	PRIMARY KEY (RecordID)
) ENGINE = INNODB;

-- 
-- TABLE: onlineFiresystem 
--
CREATE TABLE onlineFiresystem (
	tiSysType INT NOT NULL,
	siteid CHAR (20) NOT NULL,
	states CHAR (10),
	YnOnline VARCHAR (10),
	Remarks CHAR (100),
	MaintenanceId CHAR (36),
	PRIMARY KEY (tiSysType, siteid)
) ENGINE = INNODB;

-- 
-- TABLE: onlineorg 
--
CREATE TABLE onlineorg (
	orgid CHAR (12) NOT NULL,
	orgcode VARCHAR (100),
	orgname VARCHAR (100) NOT NULL,
	vAddress VARCHAR (200),
	OrganType VARCHAR (200),
	vNamelegalperson VARCHAR (20),
	otherthings TEXT,
	YnImportant CHAR (2),
	SuperiorOrg VARCHAR (100),
	cZip VARCHAR (10),
	vTel VARCHAR (50),
	fax VARCHAR (50),
	`E-Mail` VARCHAR (100),
	howmanypeople INT,
	souyouzhi VARCHAR (100),
	SetupDate DATE,
	realtymoney DECIMAL (65, 0),
	ipersonnum INT,
	fAreanum DECIMAL (18, 2),
	fBuildingarea DECIMAL (18, 2),
	GasType VARCHAR (50),
	howmanyfireman INT,
	howmanyexit INT,
	howmanystair INT,
	howmanylane INT,
	howmanyelevator INT,
	lanelocation VARCHAR (200),
	vfireroomtel VARCHAR (15),
	escapefloor INT,
	escapebuildingarea DECIMAL (2, 0),
	escapelocation VARCHAR (100),
	neareast VARCHAR (100),
	nearsouth VARCHAR (100),
	nearwest VARCHAR (100),
	nearnorth VARCHAR (100),
	AutoFireFacility CHAR (2),
	bFlatpic LONGBLOB,
	fLongitude FLOAT (8, 0),
	fLatitude FLOAT (8, 0),
	dRecordDate DATETIME,
	managegrade VARCHAR (200),
	NetworkStatus CHAR (10),
	NetworkTime DATETIME,
	ApproveState VARCHAR (10),
	ApproveTime DATETIME,
	ApproveMan VARCHAR (50),
	ApproveIdea VARCHAR (500),
	AreaId CHAR (6) NOT NULL,
	ManagerOrgID CHAR (36),
	PRIMARY KEY (orgid)
) ENGINE = INNODB;

-- 
-- TABLE: People 
--
CREATE TABLE People (
	PeopleNo CHAR (36) NOT NULL,
	identification VARCHAR (50),
	PeopleName VARCHAR (50),
	sex CHAR (2),
	job VARCHAR (50) NOT NULL,
	birthday DATETIME,
	education VARCHAR (20),
	tel VARCHAR (100),
	department VARCHAR (200),
	WorkBeginDate DATETIME,
	YnTraining VARCHAR (2),
	trainingTime DATETIME,
	certificateID VARCHAR (50),
	TypeandGrade VARCHAR (100),
	TheoryExamScore VARCHAR (10),
	TechExamScore VARCHAR (10),
	totalscore VARCHAR (10),
	issueorg VARCHAR (100),
	issuedate DATETIME,
	GetDate DATETIME,
	YnEscapeLeader NATIONAL CHAR (1),
	OnDutyArea VARCHAR (255),
	OrderNum INT,
	PeoplePicPath VARCHAR (255),
	CertificatePicPath VARCHAR (255),
	orgid CHAR (12) NOT NULL,
	PeopleTypeName VARCHAR (100) NOT NULL,
	JobTypeName VARCHAR (100),
	PRIMARY KEY (PeopleNo)
) ENGINE = INNODB;

-- 
-- TABLE: PeopleType 
--
CREATE TABLE PeopleType (
	PeopleTypeName VARCHAR (100) NOT NULL,
	OrderNo INT,
	PRIMARY KEY (PeopleTypeName)
) ENGINE = INNODB;

-- 
-- TABLE: Phone_Module_UserType 
--
CREATE TABLE Phone_Module_UserType (
	ModuleID CHAR (10) NOT NULL,
	UserTypeID VARCHAR (20) NOT NULL,
	Remark VARCHAR (255),
	PRIMARY KEY (ModuleID, UserTypeID)
) ENGINE = INNODB;

-- 
-- TABLE: Phone_ModuleList 
--
CREATE TABLE Phone_ModuleList (
	ModuleID CHAR (10) NOT NULL,
	ModuleName VARCHAR (50),
	OrderNum INT,
	ParentID CHAR (10),
	levelnum INT,
	PRIMARY KEY (ModuleID)
) ENGINE = INNODB;

-- 
-- TABLE: Phone_Users 
--
CREATE TABLE Phone_Users (
	UserID CHAR (36) NOT NULL,
	account VARCHAR (100) NOT NULL,
	PASSWORD VARCHAR (255),
	RealName VARCHAR (50),
	mobilephone VARCHAR (50),
	Tel VARCHAR (100),
	Email VARCHAR (100),
	`STATUS` VARCHAR (10),
	Remark TEXT,
	UserBelongTo VARCHAR (50),
	TokenID VARCHAR (100),
	TokenExpireDate DATETIME,
	MaintenanceId CHAR (36),
	orgid CHAR (12),
	ManagerOrgID CHAR (36),
	UserTypeID VARCHAR (20) NOT NULL,
	PRIMARY KEY (UserID)
) ENGINE = INNODB;

-- 
-- TABLE: Phone_UserType 
--
CREATE TABLE Phone_UserType (
	UserTypeID VARCHAR (20) NOT NULL,
	UserTypeName VARCHAR (40),
	UserBelongTo VARCHAR (50),
	PRIMARY KEY (UserTypeID)
) ENGINE = INNODB;

-- 
-- TABLE: SafeDuty 
--
CREATE TABLE SafeDuty (
	SafeDutyID CHAR (36) NOT NULL,
	dutyname VARCHAR (500),
	uploadtime DATETIME,
	safedutytype VARCHAR (255),
	filepath VARCHAR (255),
	orgid CHAR (12) NOT NULL,
	PRIMARY KEY (SafeDutyID)
) ENGINE = INNODB;

-- 
-- TABLE: SafeManageRules 
--
CREATE TABLE SafeManageRules (
	SafeManageRulesID CHAR (36) NOT NULL,
	SafeManageRulesName CHAR (10),
	UploadTime DATETIME,
	SafeManageRulesType VARCHAR (255),
	filepath VARCHAR (255),
	orgid CHAR (12) NOT NULL,
	PRIMARY KEY (SafeManageRulesID)
) ENGINE = INNODB;

-- 
-- TABLE: site 
--
CREATE TABLE site (
	siteid CHAR (20) NOT NULL,
	sitename VARCHAR (100),
	buildingaddress VARCHAR (200),
	useproperty VARCHAR (100),
	DSCS VARCHAR (20),
	JZGD VARCHAR (20),
	DSJZMJ VARCHAR (20),
	NHDJ VARCHAR (50),
	JGLX VARCHAR (50),
	DXCS VARCHAR (20),
	DXJZMJ VARCHAR (20),
	SDQK VARCHAR (500),
	ZYCCW VARCHAR (500),
	RLRS VARCHAR (10),
	QLJZ VARCHAR (500),
	east VARCHAR (500),
	west VARCHAR (500),
	south VARCHAR (500),
	north VARCHAR (500),
	xx FLOAT (8, 0),
	yy FLOAT (8, 0),
	sitetypename VARCHAR (100),
	holdthings VARCHAR (100),
	holdthingsnum VARCHAR (100),
	annalTime DATETIME NOT NULL,
	fLongitude FLOAT (8, 0),
	fLatitude FLOAT (8, 0),
	orgid CHAR (12) NOT NULL,
	PRIMARY KEY (siteid)
) ENGINE = INNODB;

-- 
-- TABLE: Taskassign 
--
CREATE TABLE Taskassign (
	orgid CHAR (12) NOT NULL,
	UserID CHAR (36) NOT NULL,
	TaskassignTime DATETIME,
	PRIMARY KEY (orgid, UserID)
) ENGINE = INNODB;

-- 
-- TABLE: TestPeriod 
--
CREATE TABLE TestPeriod (
	cTestPeriod VARCHAR (10) NOT NULL,
	vTestPeriod VARCHAR (100),
	days INT,
	PRIMARY KEY (cTestPeriod)
) ENGINE = INNODB;

-- 
-- TABLE: Ticket 
--
CREATE TABLE Ticket (
	TicketID CHAR (16) NOT NULL,
	vReason VARCHAR (255),
	penalty DECIMAL (10, 0),
	TicketTime DATETIME,
	`STATUS` CHAR (1),
	payment DECIMAL (10, 0),
	dPaymentTime DATETIME,
	vPaymentType VARCHAR (100),
	vPayID VARCHAR (50),
	orgid CHAR (12) NOT NULL,
	ManagerOrgID CHAR (36) NOT NULL,
	PRIMARY KEY (TicketID)
) ENGINE = INNODB;

-- 
-- TABLE: Training 
--
CREATE TABLE Training (
	TrainingID CHAR (36) NOT NULL,
	TrainingTime DATETIME,
	TrainingAddress VARCHAR (255),
	TrainingType VARCHAR (100),
	TrainingObject VARCHAR (100),
	HowmanyPeople INT,
	Lecturer VARCHAR (50),
	TrainingContent VARCHAR (255),
	AttendPeople VARCHAR (500),
	Examination VARCHAR (100),
	TrainingManager VARCHAR (40),
	ContentFile VARCHAR (500),
	signtable VARCHAR (500),
	examfile text,
	orgid CHAR (12) NOT NULL,
	PRIMARY KEY (TrainingID)
) ENGINE = INNODB;

CREATE TABLE UerCheckList(
    UserCheckId      CHAR(36)        NOT NULL,
    UserCheckTime    DATETIME,
    OrgUserId        VARCHAR(20),
    OrgManagerId     VARCHAR(20),
    SubmitStatet     VARCHAR(20),
    SubmitTime       DATETIME,
    Remarks          VARCHAR(200),
    orgid            CHAR(12)        NOT NULL,
    siteid           CHAR(20),
    PRIMARY KEY (UserCheckId), 
    CONSTRAINT Refsite150 FOREIGN KEY (siteid)
    REFERENCES site(siteid),
    CONSTRAINT Refonlineorg56 FOREIGN KEY (orgid)
    REFERENCES onlineorg(orgid)
)ENGINE=INNODB
;


-- 
-- TABLE: UserCheckContent 
--
CREATE TABLE UserCheckContent (
	orgid CHAR (12) NOT NULL,
	ProjectId CHAR (4) NOT NULL,
	Remarks VARCHAR (100),
	PRIMARY KEY (orgid, ProjectId)
) ENGINE = INNODB;

-- 
-- TABLE: UserCheckInfo 
--
CREATE TABLE UserCheckInfo (
	UserCheckId CHAR (36) NOT NULL,
	ProjectId CHAR (4) NOT NULL,
	UserCheckResult VARCHAR (200),
	FaultShow VARCHAR (500),
	YnHanding VARCHAR (2),
	Handingimmediately NATIONAL VARCHAR (20),
	PRIMARY KEY (UserCheckId, ProjectId)
) ENGINE = INNODB;

-- 
-- TABLE: UserCheckPic 
--
CREATE TABLE UserCheckPic (
	PicID CHAR (36) NOT NULL,
	PicType VARCHAR (10),
	PicPath VARCHAR (255),
	UploadTime DATETIME,
	UserCheckId CHAR (36) NOT NULL,
	ProjectId CHAR (4) NOT NULL,
	PRIMARY KEY (PicID)
) ENGINE = INNODB;

-- 
-- TABLE: UserCheckProjeckList 
--
CREATE TABLE UserCheckProjeckList (
	ProjectId CHAR (4) NOT NULL,
	ProjectName VARCHAR (50),
	ProjectContent VARCHAR (100),
	OrderNumber INT,
	IsCheck NATIONAL CHAR (1),
	tiSysType INT NOT NULL,
	PRIMARY KEY (ProjectId)
) ENGINE = INNODB;

-- 
-- TABLE: UserCheckProject 
--
CREATE TABLE UserCheckProject (
	ProjectId CHAR (4) NOT NULL,
	orgid CHAR (12) NOT NULL,
	DevicesCount INT,
	Remarks VARCHAR (100),
	PRIMARY KEY (ProjectId, orgid)
) ENGINE = INNODB;

-- 
-- TABLE: UserCheckProjectContent 
--
CREATE TABLE UserCheckProjectContent (
	ProjectId CHAR (4) NOT NULL,
	ProjectContent VARCHAR (500),
	OrderNumber INT,
	IsMust NATIONAL CHAR (1),
	tiSysType INT NOT NULL,
	PRIMARY KEY (ProjectId)
) ENGINE = INNODB;

-- 
-- TABLE: Users 
--
CREATE TABLE Users (
	UserID CHAR (36) NOT NULL,
	account VARCHAR (100) NOT NULL,
	`PASSWORD` VARCHAR (255),
	RealName VARCHAR (50),
	mobilephone VARCHAR (50),
	Tel VARCHAR (100),
	Email VARCHAR (100),
	`STATUS` VARCHAR (10),
	isFirstEnroll CHAR (2),
	Remark TEXT,
	UserBelongTo VARCHAR (50),
	TokenID VARCHAR (100),
	TokenExpireDate DATETIME,
	ManagerOrgID CHAR (36),
	UserTypeID VARCHAR (20) NOT NULL,
	orgid CHAR (12),
	MaintenanceId CHAR (36),
	PRIMARY KEY (UserID)
) ENGINE = INNODB;

-- 
-- TABLE: UserType 
--
CREATE TABLE UserType (
	UserTypeID VARCHAR (20) NOT NULL,
	UserTypeName VARCHAR (40),
	UserBelongTo VARCHAR (50),
	PRIMARY KEY (UserTypeID)
) ENGINE = INNODB;

-- 
-- TABLE: wbCheckInfo 
--
CREATE TABLE wbCheckInfo (
	wbId INT AUTO_INCREMENT,
	wbCheckResult VARCHAR (200),
	wbProblemRemaks VARCHAR (300),
	tiSysType INT NOT NULL,
	wbCheckId CHAR (36) NOT NULL,
	YnHanding VARCHAR (2),
	Handingimmediately VARCHAR (100),
	PRIMARY KEY (wbId)
) ENGINE = INNODB;

-- 
-- TABLE: wbCheckList 
--
CREATE TABLE wbCheckList (
	wbCheckId CHAR (36) NOT NULL,
	wbCheckRemark VARCHAR (200),
	CheckDate DATETIME,
	wbUserId VARCHAR (20),
	wbCheckTime DATETIME,
	CheckOrgName VARCHAR (100),
	OrgUserManagerMark VARCHAR (20),
	OrgUserManagerMarkTime DATETIME,
	siteid CHAR (20) NOT NULL,
	PRIMARY KEY (wbCheckId)
) ENGINE = INNODB;

-- 
-- TABLE: wbDeviceRepairInfo_Auto 
--
CREATE TABLE wbDeviceRepairInfo_Auto (
	wbRepairInfoId CHAR (22) NOT NULL,
	wbRepairTime DATETIME,
	wbUserID VARCHAR (50),
	wbProblemInfo VARCHAR (255),
	UserManagerRemaks VARCHAR (500),
	UserAdminNameMark VARCHAR (50),
	HandingState VARCHAR (20),
	DealResult VARCHAR (200),
	SolutionUserManagerMark VARCHAR (20),
	source VARCHAR (10),
	wbRepairListId CHAR (36),
	ProjectId CHAR (4),
	Firealarmid CHAR (36) NOT NULL,
	PRIMARY KEY (wbRepairInfoId)
) ENGINE = INNODB;

-- 
-- TABLE: wbDeviceRepairInfo_comovement 
--
CREATE TABLE wbDeviceRepairInfo_comovement (
	wbRepairInfoId CHAR (22) NOT NULL,
	wbRepairTime DATETIME,
	wbUserID VARCHAR (50),
	wbProblemInfo VARCHAR (255),
	UserManagerRemaks VARCHAR (500),
	UserAdminNameMark VARCHAR (50),
	HandingState VARCHAR (20),
	DealResult VARCHAR (200),
	SolutionUserManagerMark VARCHAR (20),
	source VARCHAR (10),
	wbRepairListId CHAR (36),
	ProjectId CHAR (4),
	wbCheckId CHAR (36) NOT NULL,
	PRIMARY KEY (wbRepairInfoId)
) ENGINE = INNODB;

-- 
-- TABLE: wbDeviceRepairInfo_Patrol 
--
CREATE TABLE wbDeviceRepairInfo_Patrol (
	wbRepairInfoId CHAR (22) NOT NULL,
	wbRepairTime DATETIME,
	wbUserID VARCHAR (50),
	wbProblemInfo VARCHAR (255),
	UserManagerRemaks VARCHAR (500),
	UserAdminNameMark VARCHAR (50),
	HandingState VARCHAR (20),
	DealResult VARCHAR (200),
	SolutionUserManagerMark VARCHAR (20),
	UserCheckId CHAR (36) NOT NULL,
	ProjectId CHAR (4) NOT NULL,
	PRIMARY KEY (wbRepairInfoId)
) ENGINE = INNODB;

-- 
-- TABLE: wbDeviceRepairInfo_Test 
--
CREATE TABLE wbDeviceRepairInfo_Test (
	wbRepairInfoId CHAR (22) NOT NULL,
	wbRepairTime DATETIME,
	wbUserID VARCHAR (50),
	wbProblemInfo VARCHAR (255),
	UserManagerRemaks VARCHAR (500),
	UserAdminNameMark VARCHAR (50),
	HandingState VARCHAR (20),
	DealResult VARCHAR (200),
	SolutionUserManagerMark VARCHAR (20),
	source VARCHAR (10),
	wbRepairListId CHAR (36),
	ProjectId CHAR (4),
	PRIMARY KEY (wbRepairInfoId)
) ENGINE = INNODB;

-- 
-- TABLE: wbRepairInfo 
--
CREATE TABLE wbRepairInfo (
	wbRepairListId CHAR (36) NOT NULL,
	ProjectId CHAR (4) NOT NULL,
	wbRepairedNumber INT,
	wbRepairedRemarks VARCHAR (255),
	IsGood VARCHAR (10),
	YnHanding VARCHAR (2),
	Handingimmediately VARCHAR (100),
	PRIMARY KEY (wbRepairListId, ProjectId)
) ENGINE = INNODB;

-- 
-- TABLE: wbRepairList 
--
CREATE TABLE wbRepairList (
	wbRepairListId CHAR (36) NOT NULL,
	TaskTime DATETIME,
	wbRepairTime DATETIME,
	wbRepairPerson VARCHAR (50),
	OrgManagerMarl VARCHAR (50),
	IsReport VARCHAR (10),
	ReportTime DATETIME,
	orgid CHAR (12) NOT NULL,
	MaintenanceId CHAR (36),
	siteid CHAR (20),
	PRIMARY KEY (wbRepairListId)
) ENGINE = INNODB;

-- 
-- TABLE: xfCheckTimeRound 
--
CREATE TABLE xfCheckTimeRound (
	RoundId INT AUTO_INCREMENT,
	RoundName VARCHAR (50),
	RoundDays INT,
	PRIMARY KEY (RoundId)
) ENGINE = INNODB;

-- 
-- TABLE: AnlogAlarmSettings 
--
ALTER TABLE AnlogAlarmSettings ADD CONSTRAINT Refdevices112 FOREIGN KEY (
	deviceaddress,
	Sysaddress,
	Gatewayaddress
) REFERENCES devices (
	deviceaddress,
	Sysaddress,
	Gatewayaddress
);

-- 
-- TABLE: Appearancepic 
--
ALTER TABLE Appearancepic ADD CONSTRAINT Refsite18 FOREIGN KEY (siteid) REFERENCES site (siteid);

-- 
-- TABLE: BusinessLicence 
--
ALTER TABLE BusinessLicence ADD CONSTRAINT Refonlineorg42 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

-- 
-- TABLE: dangerousGoods 
--
ALTER TABLE dangerousGoods ADD CONSTRAINT RefdangerousGoodsType152 FOREIGN KEY (vTypeName) REFERENCES dangerousGoodsType (vTypeName);

ALTER TABLE dangerousGoods ADD CONSTRAINT Refonlineorg151 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

-- 
-- TABLE: DetectPic 
--
ALTER TABLE DetectPic ADD CONSTRAINT RefwbRepairInfo83 FOREIGN KEY (wbRepairListId, ProjectId) REFERENCES wbRepairInfo (wbRepairListId, ProjectId);

-- 
-- TABLE: devices 
--
ALTER TABLE devices ADD CONSTRAINT Refdevicetype126 FOREIGN KEY (iDeviceType) REFERENCES devicetype (iDeviceType);

ALTER TABLE devices ADD CONSTRAINT RefGatewaySystemInfo141 FOREIGN KEY (Sysaddress, Gatewayaddress) REFERENCES GatewaySystemInfo (Sysaddress, Gatewayaddress);

ALTER TABLE devices ADD CONSTRAINT Refflatpic21 FOREIGN KEY (cFlatPic) REFERENCES flatpic (cFlatPic);

-- 
-- TABLE: devicetype 
--
ALTER TABLE devicetype ADD CONSTRAINT Reffiresystype124 FOREIGN KEY (tiSysType) REFERENCES firesystype (tiSysType);

-- 
-- TABLE: equipment 
--
ALTER TABLE equipment ADD CONSTRAINT RefequipmentType95 FOREIGN KEY (equipmenttype) REFERENCES equipmentType (equipmenttype);

ALTER TABLE equipment ADD CONSTRAINT Reffirecompany97 FOREIGN KEY (firecompayid) REFERENCES firecompany (firecompayid);

-- 
-- TABLE: firecompany 
--
ALTER TABLE firecompany ADD CONSTRAINT Refonlineorg94 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

-- 
-- TABLE: FireDevice 
--
ALTER TABLE FireDevice ADD CONSTRAINT Refsite105 FOREIGN KEY (siteid) REFERENCES site (siteid);

ALTER TABLE FireDevice ADD CONSTRAINT Refdevicetype125 FOREIGN KEY (iDeviceType) REFERENCES devicetype (iDeviceType);

-- 
-- TABLE: FireDeviceChangeRecord 
--
ALTER TABLE FireDeviceChangeRecord ADD CONSTRAINT RefFireDevice101 FOREIGN KEY (deviceNo) REFERENCES FireDevice (deviceNo);

-- 
-- TABLE: FireSafetyCheck 
--
ALTER TABLE FireSafetyCheck ADD CONSTRAINT Refonlineorg144 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

-- 
-- TABLE: flatpic 
--
ALTER TABLE flatpic ADD CONSTRAINT Refsite17 FOREIGN KEY (siteid) REFERENCES site (siteid);

-- 
-- TABLE: GatewaySystemInfo 
--
ALTER TABLE GatewaySystemInfo ADD CONSTRAINT Refgateway140 FOREIGN KEY (Gatewayaddress) REFERENCES gateway (Gatewayaddress);

ALTER TABLE GatewaySystemInfo ADD CONSTRAINT RefonlineFiresystem142 FOREIGN KEY (tiSysType, siteid) REFERENCES onlineFiresystem (tiSysType, siteid);

-- 
-- TABLE: Introduce 
--
ALTER TABLE Introduce ADD CONSTRAINT Refonlineorg153 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

-- 
-- TABLE: LoginRecord 
--
ALTER TABLE LoginRecord ADD CONSTRAINT RefUsers86 FOREIGN KEY (UserID) REFERENCES Users (UserID);

-- 
-- TABLE: Maintenance 
--
ALTER TABLE Maintenance ADD CONSTRAINT RefcTestPeriod156 FOREIGN KEY (cTestPeriod) REFERENCES cTestPeriod (cTestPeriod);

ALTER TABLE Maintenance ADD CONSTRAINT RefTestPeriod157 FOREIGN KEY (cTestPeriod) REFERENCES TestPeriod (cTestPeriod);

-- 
-- TABLE: MaintenanceOrgInfo 
--
ALTER TABLE MaintenanceOrgInfo ADD CONSTRAINT Refonlineorg47 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

ALTER TABLE MaintenanceOrgInfo ADD CONSTRAINT RefMaintenance48 FOREIGN KEY (MaintenanceId) REFERENCES Maintenance (MaintenanceId);

-- 
-- TABLE: ManagerOrg 
--
ALTER TABLE ManagerOrg ADD CONSTRAINT RefArea41 FOREIGN KEY (AreaId) REFERENCES Area (AreaId);

-- 
-- TABLE: manoeuvre 
--
ALTER TABLE manoeuvre ADD CONSTRAINT Refonlineorg146 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

-- 
-- TABLE: Module_UserType 
--
ALTER TABLE Module_UserType ADD CONSTRAINT RefModuleList2 FOREIGN KEY (ModuleID) REFERENCES ModuleList (ModuleID);

ALTER TABLE Module_UserType ADD CONSTRAINT RefUserType4 FOREIGN KEY (UserTypeID) REFERENCES UserType (UserTypeID);

-- 
-- TABLE: OnDuty 
--
ALTER TABLE OnDuty ADD CONSTRAINT Refgateway114 FOREIGN KEY (Gatewayaddress) REFERENCES gateway (Gatewayaddress);

-- 
-- TABLE: OnDutyRecord 
--
ALTER TABLE OnDutyRecord ADD CONSTRAINT Refonlineorg122 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

-- 
-- TABLE: onlineFiresystem 
--
ALTER TABLE onlineFiresystem ADD CONSTRAINT Reffiresystype74 FOREIGN KEY (tiSysType) REFERENCES firesystype (tiSysType);

ALTER TABLE onlineFiresystem ADD CONSTRAINT Refsite129 FOREIGN KEY (siteid) REFERENCES site (siteid);

ALTER TABLE onlineFiresystem ADD CONSTRAINT RefMaintenance131 FOREIGN KEY (MaintenanceId) REFERENCES Maintenance (MaintenanceId);

-- 
-- TABLE: onlineorg 
--
ALTER TABLE onlineorg ADD CONSTRAINT RefArea40 FOREIGN KEY (AreaId) REFERENCES Area (AreaId);

ALTER TABLE onlineorg ADD CONSTRAINT RefManagerOrg49 FOREIGN KEY (ManagerOrgID) REFERENCES ManagerOrg (ManagerOrgID);

-- 
-- TABLE: People 
--
ALTER TABLE People ADD CONSTRAINT Refonlineorg93 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

ALTER TABLE People ADD CONSTRAINT RefPeopleType99 FOREIGN KEY (PeopleTypeName) REFERENCES PeopleType (PeopleTypeName);

ALTER TABLE People ADD CONSTRAINT RefJobType100 FOREIGN KEY (JobTypeName) REFERENCES JobType (JobTypeName);

-- 
-- TABLE: Phone_Module_UserType 
--
ALTER TABLE Phone_Module_UserType ADD CONSTRAINT RefPhone_ModuleList116 FOREIGN KEY (ModuleID) REFERENCES Phone_ModuleList (ModuleID);

ALTER TABLE Phone_Module_UserType ADD CONSTRAINT RefPhone_UserType117 FOREIGN KEY (UserTypeID) REFERENCES Phone_UserType (UserTypeID);

-- 
-- TABLE: Phone_Users 
--
ALTER TABLE Phone_Users ADD CONSTRAINT RefMaintenance118 FOREIGN KEY (MaintenanceId) REFERENCES Maintenance (MaintenanceId);

ALTER TABLE Phone_Users ADD CONSTRAINT Refonlineorg119 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

ALTER TABLE Phone_Users ADD CONSTRAINT RefManagerOrg120 FOREIGN KEY (ManagerOrgID) REFERENCES ManagerOrg (ManagerOrgID);

ALTER TABLE Phone_Users ADD CONSTRAINT RefPhone_UserType121 FOREIGN KEY (UserTypeID) REFERENCES Phone_UserType (UserTypeID);

-- 
-- TABLE: SafeDuty 
--
ALTER TABLE SafeDuty ADD CONSTRAINT Refonlineorg88 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

-- 
-- TABLE: SafeManageRules 
--
ALTER TABLE SafeManageRules ADD CONSTRAINT Refonlineorg89 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

-- 
-- TABLE: site 
--
ALTER TABLE site ADD CONSTRAINT Refonlineorg14 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

-- 
-- TABLE: Taskassign 
--
ALTER TABLE Taskassign ADD CONSTRAINT Refonlineorg154 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

ALTER TABLE Taskassign ADD CONSTRAINT RefUsers155 FOREIGN KEY (UserID) REFERENCES Users (UserID);

-- 
-- TABLE: Ticket 
--
ALTER TABLE Ticket ADD CONSTRAINT Refonlineorg158 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

ALTER TABLE Ticket ADD CONSTRAINT RefManagerOrg159 FOREIGN KEY (ManagerOrgID) REFERENCES ManagerOrg (ManagerOrgID);

-- 
-- TABLE: Training 
--
ALTER TABLE Training ADD CONSTRAINT Refonlineorg145 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);


-- 
-- TABLE: UserCheckContent 
--
ALTER TABLE UserCheckContent ADD CONSTRAINT Refonlineorg55 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

ALTER TABLE UserCheckContent ADD CONSTRAINT RefUserCheckProjectContent59 FOREIGN KEY (ProjectId) REFERENCES UserCheckProjectContent (ProjectId);

-- 
-- TABLE: UserCheckInfo 
--
ALTER TABLE UserCheckInfo ADD CONSTRAINT RefUerCheckList58 FOREIGN KEY (UserCheckId) REFERENCES UerCheckList (UserCheckId);

ALTER TABLE UserCheckInfo ADD CONSTRAINT RefUserCheckProjectContent60 FOREIGN KEY (ProjectId) REFERENCES UserCheckProjectContent (ProjectId);

-- 
-- TABLE: UserCheckPic 
--
ALTER TABLE UserCheckPic ADD CONSTRAINT RefUserCheckInfo82 FOREIGN KEY (UserCheckId, ProjectId) REFERENCES UserCheckInfo (UserCheckId, ProjectId);

-- 
-- TABLE: UserCheckProjeckList 
--
ALTER TABLE UserCheckProjeckList ADD CONSTRAINT Reffiresystype63 FOREIGN KEY (tiSysType) REFERENCES firesystype (tiSysType);

-- 
-- TABLE: UserCheckProject 
--
ALTER TABLE UserCheckProject ADD CONSTRAINT RefUserCheckProjeckList64 FOREIGN KEY (ProjectId) REFERENCES UserCheckProjeckList (ProjectId);

ALTER TABLE UserCheckProject ADD CONSTRAINT Refonlineorg65 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

-- 
-- TABLE: UserCheckProjectContent 
--
ALTER TABLE UserCheckProjectContent ADD CONSTRAINT Reffiresystype62 FOREIGN KEY (tiSysType) REFERENCES firesystype (tiSysType);

-- 
-- TABLE: Users 
--
ALTER TABLE Users ADD CONSTRAINT RefManagerOrg6 FOREIGN KEY (ManagerOrgID) REFERENCES ManagerOrg (ManagerOrgID);

ALTER TABLE Users ADD CONSTRAINT RefUserType3 FOREIGN KEY (UserTypeID) REFERENCES UserType (UserTypeID);

ALTER TABLE Users ADD CONSTRAINT Refonlineorg84 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

ALTER TABLE Users ADD CONSTRAINT RefMaintenance85 FOREIGN KEY (MaintenanceId) REFERENCES Maintenance (MaintenanceId);

-- 
-- TABLE: wbCheckInfo 
--
ALTER TABLE wbCheckInfo ADD CONSTRAINT RefwbCheckList80 FOREIGN KEY (wbCheckId) REFERENCES wbCheckList (wbCheckId);

ALTER TABLE wbCheckInfo ADD CONSTRAINT Reffiresystype81 FOREIGN KEY (tiSysType) REFERENCES firesystype (tiSysType);

-- 
-- TABLE: wbCheckList 
--
ALTER TABLE wbCheckList ADD CONSTRAINT Refsite76 FOREIGN KEY (siteid) REFERENCES site (siteid);

-- 
-- TABLE: wbDeviceRepairInfo_Auto 
--
ALTER TABLE wbDeviceRepairInfo_Auto ADD CONSTRAINT Refalarmdata128 FOREIGN KEY (Firealarmid) REFERENCES alarmdata (Firealarmid);

-- 
-- TABLE: wbDeviceRepairInfo_comovement 
--
ALTER TABLE wbDeviceRepairInfo_comovement ADD CONSTRAINT RefwbCheckList130 FOREIGN KEY (wbCheckId) REFERENCES wbCheckList (wbCheckId);

-- 
-- TABLE: wbDeviceRepairInfo_Patrol 
--
ALTER TABLE wbDeviceRepairInfo_Patrol ADD CONSTRAINT RefUserCheckInfo143 FOREIGN KEY (UserCheckId, ProjectId) REFERENCES UserCheckInfo (UserCheckId, ProjectId);

-- 
-- TABLE: wbDeviceRepairInfo_Test 
--
ALTER TABLE wbDeviceRepairInfo_Test ADD CONSTRAINT RefwbRepairInfo73 FOREIGN KEY (wbRepairListId, ProjectId) REFERENCES wbRepairInfo (wbRepairListId, ProjectId);

-- 
-- TABLE: wbRepairInfo 
--
ALTER TABLE wbRepairInfo ADD CONSTRAINT RefwbRepairList66 FOREIGN KEY (wbRepairListId) REFERENCES wbRepairList (wbRepairListId);

ALTER TABLE wbRepairInfo ADD CONSTRAINT RefUserCheckProjeckList67 FOREIGN KEY (ProjectId) REFERENCES UserCheckProjeckList (ProjectId);

-- 
-- TABLE: wbRepairList 
--
ALTER TABLE wbRepairList ADD CONSTRAINT Refsite149 FOREIGN KEY (siteid) REFERENCES site (siteid);

ALTER TABLE wbRepairList ADD CONSTRAINT Refonlineorg69 FOREIGN KEY (orgid) REFERENCES onlineorg (orgid);

ALTER TABLE wbRepairList ADD CONSTRAINT RefMaintenance71 FOREIGN KEY (MaintenanceId) REFERENCES Maintenance (MaintenanceId);

