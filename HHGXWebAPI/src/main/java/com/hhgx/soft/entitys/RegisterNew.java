package com.hhgx.soft.entitys;

public class RegisterNew {
	private String userID;
	private String maintenanceId;
	private String orgid;
	private String username;//要求用户填写手机号
	private String password;
	private String orgname;//单位名称
	private String areaID;//区域编号:省市县选择，区域编号县信息
	private String userBelongTo;//用户类别:用于识别用户类别。1:防火单位用户； 2：维保部门用户
	private String usertypeID;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public String getAreaID() {
		return areaID;
	}
	public void setAreaID(String areaID) {
		this.areaID = areaID;
	}
	public String getUserBelongTo() {
		return userBelongTo;
	}
	public void setUserBelongTo(String userBelongTo) {
		this.userBelongTo = userBelongTo;
	}	
	public String getMaintenanceId() {
		return maintenanceId;
	}
	public void setMaintenanceId(String maintenanceId) {
		this.maintenanceId = maintenanceId;
	}
	public String getOrgid() {
		return orgid;
	}
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}
	
	public String getUsertypeID() {
		return usertypeID;
	}
	public void setUsertypeID(String usertypeID) {
		this.usertypeID = usertypeID;
	}
	@Override
	public String toString() {
		return "RegisterNew [userID=" + userID + ", maintenanceId=" + maintenanceId + ", orgid=" + orgid + ", username="
				+ username + ", password=" + password + ", orgname=" + orgname + ", areaID=" + areaID
				+ ", userBelongTo=" + userBelongTo + ", usertypeID=" + usertypeID + "]";
	}


}
