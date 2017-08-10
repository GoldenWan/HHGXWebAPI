package com.hhgx.soft.entitys;

public class User {
	
	private String userID;
	private String account;
	private String password;
	private String realName;
	private String mobilephone;
	private String tel;
	private String email;
	private String status;
	private String isFirstEnroll;
	private String remark;
	private String userBelongTo;
	private String tokenID;
	private String tokenExpireDate;
	private String managerOrgID;
	private String userTypeID;
	private String orgid;
	private String maintenanceId;
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getMobilephone() {
		return mobilephone;
	}
	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getIsFirstEnroll() {
		return isFirstEnroll;
	}
	public void setIsFirstEnroll(String isFirstEnroll) {
		this.isFirstEnroll = isFirstEnroll;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getUserBelongTo() {
		return userBelongTo;
	}
	public void setUserBelongTo(String userBelongTo) {
		this.userBelongTo = userBelongTo;
	}
	public String getTokenID() {
		return tokenID;
	}
	public void setTokenID(String tokenID) {
		this.tokenID = tokenID;
	}
	public String getTokenExpireDate() {
		return tokenExpireDate;
	}
	public void setTokenExpireDate(String tokenExpireDate) {
		this.tokenExpireDate = tokenExpireDate;
	}
	public String getManagerOrgID() {
		return managerOrgID;
	}
	public void setManagerOrgID(String managerOrgID) {
		this.managerOrgID = managerOrgID;
	}
	public String getUserTypeID() {
		return userTypeID;
	}
	public void setUserTypeID(String userTypeID) {
		this.userTypeID = userTypeID;
	}
	public String getOrgid() {
		return orgid;
	}
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}
	public String getMaintenanceId() {
		return maintenanceId;
	}
	public void setMaintenanceId(String maintenanceId) {
		this.maintenanceId = maintenanceId;
	}
	@Override
	public String toString() {
		return "User [userID=" + userID + ", account=" + account + ", password=" + password + ", realName=" + realName
				+ ", mobilephone=" + mobilephone + ", tel=" + tel + ", email=" + email + ", status=" + status
				+ ", isFirstEnroll=" + isFirstEnroll + ", remark=" + remark + ", userBelongTo=" + userBelongTo
				+ ", tokenID=" + tokenID + ", tokenExpireDate=" + tokenExpireDate + ", managerOrgID=" + managerOrgID
				+ ", userTypeID=" + userTypeID + ", orgid=" + orgid + ", maintenanceId=" + maintenanceId + "]";
	}


}