package com.hhgx.soft.entitys;

import java.util.Date;

public class PatrolRecord {

	private String userCheckId;
	private Date userCheckTime;
	private String orgUser;
	private String orgManager;
	private Date submitTime;
	private String remarks;
	private String userCheckResult;
	private String submitStatet;
	
	
	
	
	public String getUserCheckId() {
		return userCheckId;
	}
	public void setUserCheckId(String userCheckId) {
		this.userCheckId = userCheckId;
	}
	public Date getUserCheckTime() {
		return userCheckTime;
	}
	public void setUserCheckTime(Date userCheckTime) {
		this.userCheckTime = userCheckTime;
	}
	public String getOrgUser() {
		return orgUser;
	}
	public void setOrgUser(String orgUser) {
		this.orgUser = orgUser;
	}
	public String getOrgManager() {
		return orgManager;
	}
	public void setOrgManager(String orgManager) {
		this.orgManager = orgManager;
	}
	public Date getSubmitTime() {
		return submitTime;
	}
	public void setSubmitTime(Date submitTime) {
		this.submitTime = submitTime;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getUserCheckResult() {
		return userCheckResult;
	}
	public void setUserCheckResult(String userCheckResult) {
		this.userCheckResult = userCheckResult;
	}
	public String getSubmitStatet() {
		return submitStatet;
	}
	public void setSubmitStatet(String submitStatet) {
		this.submitStatet = submitStatet;
	}
	
	

}
