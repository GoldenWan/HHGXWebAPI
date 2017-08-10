package com.hhgx.soft.entitys;

public class User {     
	   private String  UserID          ; 
	   private String account          ; 
	   private String  password        ; 
	   private String RealName         ; 
	   private String mobilephone      ; 
	   private String Tel              ; 
	   private String Email            ; 
	   private String Status           ; 
	   private String isFirstEnroll    ; 
	   private String Remark           ; 
	   private String UserBelongTo     ; 
	   private String TokenID          ; 
	   private String TokenExpireDate  ; 
	   private String ManagerOrgID     ; 
	   private String UserTypeID       ; 
	   private String orgid            ; 
	   private String MaintenanceId    ;
	   
	   
	public String getUserID() {
		return UserID;
	}


	public void setUserID(String userID) {
		UserID = userID;
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
		return RealName;
	}


	public void setRealName(String realName) {
		RealName = realName;
	}


	public String getMobilephone() {
		return mobilephone;
	}


	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}


	public String getTel() {
		return Tel;
	}


	public void setTel(String tel) {
		Tel = tel;
	}


	public String getEmail() {
		return Email;
	}


	public void setEmail(String email) {
		Email = email;
	}


	public String getStatus() {
		return Status;
	}


	public void setStatus(String status) {
		Status = status;
	}


	public String getIsFirstEnroll() {
		return isFirstEnroll;
	}


	public void setIsFirstEnroll(String isFirstEnroll) {
		this.isFirstEnroll = isFirstEnroll;
	}


	public String getRemark() {
		return Remark;
	}


	public void setRemark(String remark) {
		Remark = remark;
	}


	public String getUserBelongTo() {
		return UserBelongTo;
	}


	public void setUserBelongTo(String userBelongTo) {
		UserBelongTo = userBelongTo;
	}


	public String getTokenID() {
		return TokenID;
	}


	public void setTokenID(String tokenID) {
		TokenID = tokenID;
	}


	public String getTokenExpireDate() {
		return TokenExpireDate;
	}


	public void setTokenExpireDate(String tokenExpireDate) {
		TokenExpireDate = tokenExpireDate;
	}


	public String getManagerOrgID() {
		return ManagerOrgID;
	}


	public void setManagerOrgID(String managerOrgID) {
		ManagerOrgID = managerOrgID;
	}


	public String getUserTypeID() {
		return UserTypeID;
	}


	public void setUserTypeID(String userTypeID) {
		UserTypeID = userTypeID;
	}


	public String getOrgid() {
		return orgid;
	}


	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}


	public String getMaintenanceId() {
		return MaintenanceId;
	}


	public void setMaintenanceId(String maintenanceId) {
		MaintenanceId = maintenanceId;
	}


	@Override
	public String toString() {
		return "User [UserID=" + UserID + ", account=" + account + ", password=" + password + ", RealName=" + RealName
				+ ", mobilephone=" + mobilephone + ", Tel=" + Tel + ", Email=" + Email + ", Status=" + Status
				+ ", isFirstEnroll=" + isFirstEnroll + ", Remark=" + Remark + ", UserBelongTo=" + UserBelongTo
				+ ", TokenID=" + TokenID + ", TokenExpireDate=" + TokenExpireDate + ", ManagerOrgID=" + ManagerOrgID
				+ ", UserTypeID=" + UserTypeID + ", orgid=" + orgid + ", MaintenanceId=" + MaintenanceId + "]";
	} 
	                                   
	                                   
}