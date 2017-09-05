package com.hhgx.soft.entitys;

import java.util.Date;

public class OnlineOrg {

	private String orgID;                     //防火单位编号
	private String orgcode;                   //组织机构代码
	private String orgname;                   //单位名称
	private String vAddress;                  //单位地址
	private String organType;                 //单位类型
	private String vNamelegalperson;          //法人代表
	private String otherthings;               //单位其他情况
	private String ynImportant;               //是否重点防火单位
	private String superiorOrg;               //上级单位
	private String cZip;                      //邮政编码
	private String vTel;                      //单位电话
	private String fax;                       //单位传真
	private String eMail;                     //E-mail
	private String howmanypeople;             //营业时最大人数
	private String souyouzhi;                 //经济所有制
	private Date setupDate;                   //单位成立时间
	private String realtymoney;               //固定资产
	private String ipersonnum;                //职工人数
	private String fAreanum;                  //占地面积
	private String fBuildingarea;             //建筑面积
	private String gasType;                   //燃气类型
	private String howmanyfireman;            //单位专职（志愿）消防人数
	private String howmanyexit;               //安全出口数
	private String howmanystair;              //疏散楼梯数
	private String howmanylane;               //消防车道数
	private String howmanyelevator;           //消防电梯数
	private String lanelocation;              //消防车道位置
	private String vfireroomtel;              //消防控制室电话
	private String escapefloor;               //避难层数
	private String escapebuildingarea;        //避难层总面积
	private String escapelocation;            //避难层位置
	private String neareast;                  //毗邻单位东
	private String nearsouth;                 //毗邻单位南
	private String nearwest;                  //毗邻单位西
	private String nearnorth;                 //毗邻单位北
	private String autoFireFacility;          //有无自动消防设施
	private String bFlatpic;                  //单位总平面图
	private Date dRecordDate;                 //记录时间
	private String managegrade;               //监管等级
	private String networkStatus;             //联网状态
	private Date networkTime;                 //入网时间
	private String approveState;              //审批状态
	private Date approveTime;                 //审批时间
	private String approveMan;                //审批人
	private String areaId;                    //区域编号
	private String managerOrgID;              //管理机构编号
	
	private String fLongitude;
	private String fLatitude;

	
	
	public String getfLongitude() {
		return fLongitude;
	}
	public void setfLongitude(String fLongitude) {
		this.fLongitude = fLongitude;
	}
	public String getfLatitude() {
		return fLatitude;
	}
	public void setfLatitude(String fLatitude) {
		this.fLatitude = fLatitude;
	}
	public Date getdRecordDate() {
		return dRecordDate;
	}
	public void setdRecordDate(Date dRecordDate) {
		this.dRecordDate = dRecordDate;
	}
	@Override
	public String toString() {
		return "OnlineOrg [orgID=" + orgID + ", orgcode=" + orgcode + ", orgname=" + orgname + ", vAddress=" + vAddress
				+ ", organType=" + organType + ", vNamelegalperson=" + vNamelegalperson + ", otherthings=" + otherthings
				+ ", ynImportant=" + ynImportant + ", superiorOrg=" + superiorOrg + ", cZip=" + cZip + ", vTel=" + vTel
				+ ", fax=" + fax + ", eMail=" + eMail + ", howmanypeople=" + howmanypeople + ", souyouzhi=" + souyouzhi
				+ ", setupDate=" + setupDate + ", realtymoney=" + realtymoney + ", ipersonnum=" + ipersonnum
				+ ", fAreanum=" + fAreanum + ", fBuildingarea=" + fBuildingarea + ", gasType=" + gasType
				+ ", howmanyfireman=" + howmanyfireman + ", howmanyexit=" + howmanyexit + ", howmanystair="
				+ howmanystair + ", howmanylane=" + howmanylane + ", howmanyelevator=" + howmanyelevator
				+ ", lanelocation=" + lanelocation + ", vfireroomtel=" + vfireroomtel + ", escapefloor=" + escapefloor
				+ ", escapebuildingarea=" + escapebuildingarea + ", escapelocation=" + escapelocation + ", neareast="
				+ neareast + ", nearsouth=" + nearsouth + ", nearwest=" + nearwest + ", nearnorth=" + nearnorth
				+ ", autoFireFacility=" + autoFireFacility + ", bFlatpic=" + bFlatpic + ", dRecordDate=" + dRecordDate
				+ ", managegrade=" + managegrade + ", networkStatus=" + networkStatus + ", networkTime=" + networkTime
				+ ", approveState=" + approveState + ", approveTime=" + approveTime + ", approveMan=" + approveMan
				+ ", areaId=" + areaId + ", managerOrgID=" + managerOrgID + "]";
	}
	public Date getNetworkTime() {
		return networkTime;
	}
	public void setNetworkTime(Date networkTime) {
		this.networkTime = networkTime;
	}
	public Date getApproveTime() {
		return approveTime;
	}
	public void setApproveTime(Date approveTime) {
		this.approveTime = approveTime;
	}
	public String getOrgID() {
		return orgID;
	}
	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}
	public String getOrgcode() {
		return orgcode;
	}
	public void setOrgcode(String orgcode) {
		this.orgcode = orgcode;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public String getvAddress() {
		return vAddress;
	}
	public Date getSetupDate() {
		return setupDate;
	}
	public void setSetupDate(Date setupDate) {
		this.setupDate = setupDate;
	}
	public void setvAddress(String vAddress) {
		this.vAddress = vAddress;
	}
	public String getOrganType() {
		return organType;
	}
	public void setOrganType(String organType) {
		this.organType = organType;
	}
	public String getvNamelegalperson() {
		return vNamelegalperson;
	}
	public void setvNamelegalperson(String vNamelegalperson) {
		this.vNamelegalperson = vNamelegalperson;
	}
	public String getOtherthings() {
		return otherthings;
	}
	public void setOtherthings(String otherthings) {
		this.otherthings = otherthings;
	}
	public String getYnImportant() {
		return ynImportant;
	}
	public void setYnImportant(String ynImportant) {
		this.ynImportant = ynImportant;
	}
	public String getSuperiorOrg() {
		return superiorOrg;
	}
	public void setSuperiorOrg(String superiorOrg) {
		this.superiorOrg = superiorOrg;
	}
	public String getcZip() {
		return cZip;
	}
	public void setcZip(String cZip) {
		this.cZip = cZip;
	}
	public String getvTel() {
		return vTel;
	}
	public void setvTel(String vTel) {
		this.vTel = vTel;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String geteMail() {
		return eMail;
	}
	public void seteMail(String eMail) {
		this.eMail = eMail;
	}
	public String getHowmanypeople() {
		return howmanypeople;
	}
	public void setHowmanypeople(String howmanypeople) {
		this.howmanypeople = howmanypeople;
	}
	public String getSouyouzhi() {
		return souyouzhi;
	}
	public void setSouyouzhi(String souyouzhi) {
		this.souyouzhi = souyouzhi;
	}

	public String getRealtymoney() {
		return realtymoney;
	}
	public void setRealtymoney(String realtymoney) {
		this.realtymoney = realtymoney;
	}
	public String getIpersonnum() {
		return ipersonnum;
	}
	public void setIpersonnum(String ipersonnum) {
		this.ipersonnum = ipersonnum;
	}
	public String getfAreanum() {
		return fAreanum;
	}
	public void setfAreanum(String fAreanum) {
		this.fAreanum = fAreanum;
	}
	public String getfBuildingarea() {
		return fBuildingarea;
	}
	public void setfBuildingarea(String fBuildingarea) {
		this.fBuildingarea = fBuildingarea;
	}
	public String getGasType() {
		return gasType;
	}
	public void setGasType(String gasType) {
		this.gasType = gasType;
	}
	public String getHowmanyfireman() {
		return howmanyfireman;
	}
	public void setHowmanyfireman(String howmanyfireman) {
		this.howmanyfireman = howmanyfireman;
	}
	public String getHowmanyexit() {
		return howmanyexit;
	}
	public void setHowmanyexit(String howmanyexit) {
		this.howmanyexit = howmanyexit;
	}
	public String getHowmanystair() {
		return howmanystair;
	}
	public void setHowmanystair(String howmanystair) {
		this.howmanystair = howmanystair;
	}
	public String getHowmanylane() {
		return howmanylane;
	}
	public void setHowmanylane(String howmanylane) {
		this.howmanylane = howmanylane;
	}
	public String getHowmanyelevator() {
		return howmanyelevator;
	}
	public void setHowmanyelevator(String howmanyelevator) {
		this.howmanyelevator = howmanyelevator;
	}
	public String getLanelocation() {
		return lanelocation;
	}
	public void setLanelocation(String lanelocation) {
		this.lanelocation = lanelocation;
	}
	public String getVfireroomtel() {
		return vfireroomtel;
	}
	public void setVfireroomtel(String vfireroomtel) {
		this.vfireroomtel = vfireroomtel;
	}
	public String getEscapefloor() {
		return escapefloor;
	}
	public void setEscapefloor(String escapefloor) {
		this.escapefloor = escapefloor;
	}
	public String getEscapebuildingarea() {
		return escapebuildingarea;
	}
	public void setEscapebuildingarea(String escapebuildingarea) {
		this.escapebuildingarea = escapebuildingarea;
	}
	public String getEscapelocation() {
		return escapelocation;
	}
	public void setEscapelocation(String escapelocation) {
		this.escapelocation = escapelocation;
	}
	public String getNeareast() {
		return neareast;
	}
	public void setNeareast(String neareast) {
		this.neareast = neareast;
	}
	public String getNearsouth() {
		return nearsouth;
	}
	public void setNearsouth(String nearsouth) {
		this.nearsouth = nearsouth;
	}
	public String getNearwest() {
		return nearwest;
	}
	public void setNearwest(String nearwest) {
		this.nearwest = nearwest;
	}
	public String getNearnorth() {
		return nearnorth;
	}
	public void setNearnorth(String nearnorth) {
		this.nearnorth = nearnorth;
	}
	public String getAutoFireFacility() {
		return autoFireFacility;
	}
	public void setAutoFireFacility(String autoFireFacility) {
		this.autoFireFacility = autoFireFacility;
	}
	public String getbFlatpic() {
		return bFlatpic;
	}
	public void setbFlatpic(String bFlatpic) {
		this.bFlatpic = bFlatpic;
	}

	public String getManagegrade() {
		return managegrade;
	}
	public void setManagegrade(String managegrade) {
		this.managegrade = managegrade;
	}
	public String getNetworkStatus() {
		return networkStatus;
	}
	public void setNetworkStatus(String networkStatus) {
		this.networkStatus = networkStatus;
	}
	public String getApproveState() {
		return approveState;
	}
	public void setApproveState(String approveState) {
		this.approveState = approveState;
	}
	public String getApproveMan() {
		return approveMan;
	}
	public void setApproveMan(String approveMan) {
		this.approveMan = approveMan;
	}
	public String getAreaId() {
		return areaId;
	}
	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}
	public String getManagerOrgID() {
		return managerOrgID;
	}
	public void setManagerOrgID(String managerOrgID) {
		this.managerOrgID = managerOrgID;
	}

}
