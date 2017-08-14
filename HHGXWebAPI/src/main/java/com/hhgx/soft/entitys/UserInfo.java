package com.hhgx.soft.entitys;

public class UserInfo {

	private String userBelongTo;          //用户类别
	private String userBelongName;        //用户所属机构名字
	private String usertype;              //用户类型
	private String account;               //用户账号
	private String realName;              //用户真实名字
	private String orgID;                 //防火单位编号
	private String companyName;           //公司名字
	
	private String maintenanceId; 
	
	private String managerOrgID; 
	
	public String getUserBelongTo() {
		return userBelongTo;
	}
	public void setUserBelongTo(String userBelongTo) {
		this.userBelongTo = userBelongTo;
	}
	public String getUserBelongName() {
		return userBelongName;
	}
	public void setUserBelongName(String userBelongName) {
		this.userBelongName = userBelongName;
	}
	public String getUsertype() {
		return usertype;
	}
	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getOrgID() {
		return orgID;
	}
	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getMaintenanceId() {
		return maintenanceId;
	}
	public void setMaintenanceId(String maintenanceId) {
		this.maintenanceId = maintenanceId;
	}
	public String getManagerOrgID() {
		return managerOrgID;
	}
	public void setManagerOrgID(String managerOrgID) {
		this.managerOrgID = managerOrgID;
	}

}
