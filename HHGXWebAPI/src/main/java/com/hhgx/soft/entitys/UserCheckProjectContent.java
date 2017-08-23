package com.hhgx.soft.entitys;

public class UserCheckProjectContent {
	   private String  projectContent  ; 
	   private String  projectId       ; 
	   private int     orderNumber        ;
	   private String  isMust          ;
	   private String  tiSysType       ;
	public String getProjectContent() {
		return projectContent;
	}
	public void setProjectContent(String projectContent) {
		this.projectContent = projectContent;
	}
	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	public int getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(int orderNumber) {
		this.orderNumber = orderNumber;
	}
	public String getIsMust() {
		return isMust;
	}
	public void setIsMust(String isMust) {
		this.isMust = isMust;
	}
	public String getTiSysType() {
		return tiSysType;
	}
	public void setTiSysType(String tiSysType) {
		this.tiSysType = tiSysType;
	}
	@Override
	public String toString() {
		return "UserCheckProjectContent [projectContent=" + projectContent + ", projectId=" + projectId
				+ ", orderNumber=" + orderNumber + ", isMust=" + isMust + ", tiSysType=" + tiSysType + "]";
	}
	                                   
	
}
