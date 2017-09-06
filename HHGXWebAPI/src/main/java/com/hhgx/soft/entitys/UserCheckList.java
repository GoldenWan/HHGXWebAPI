package com.hhgx.soft.entitys;

import java.util.List;

public class UserCheckList {
	 private String	  userCheckId   ; 
	 private String   userCheckTime ; 
	 private String   orgUserId     ; 
	 private String   orgManagerId  ; 
	 private String   submitStatet  ; 
	 private String   submitTime    ; 
	 private String   remarks       ; 
	 private String   orgid         ; 
	 private String   siteid        ; 
	 private List<Site> sites;
	public String getUserCheckId() {
		return userCheckId;
	}
	public void setUserCheckId(String userCheckId) {
		this.userCheckId = userCheckId;
	}
	public String getUserCheckTime() {
		return userCheckTime;
	}
	public void setUserCheckTime(String userCheckTime) {
		this.userCheckTime = userCheckTime;
	}
	public String getOrgUserId() {
		return orgUserId;
	}
	public void setOrgUserId(String orgUserId) {
		this.orgUserId = orgUserId;
	}
	public String getOrgManagerId() {
		return orgManagerId;
	}
	public void setOrgManagerId(String orgManagerId) {
		this.orgManagerId = orgManagerId;
	}
	public String getSubmitStatet() {
		return submitStatet;
	}
	public void setSubmitStatet(String submitStatet) {
		this.submitStatet = submitStatet;
	}
	public String getSubmitTime() {
		return submitTime;
	}
	public void setSubmitTime(String submitTime) {
		this.submitTime = submitTime;
	}
	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getOrgid() {
		return orgid;
	}
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}
	public String getSiteid() {
		return siteid;
	}
	public void setSiteid(String siteid) {
		this.siteid = siteid;
	}
	public List<Site> getSites() {
		return sites;
	}
	public void setSites(List<Site> sites) {
		this.sites = sites;
	}
	 
	
}
