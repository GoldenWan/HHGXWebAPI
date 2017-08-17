package com.hhgx.soft.entitys;

public class UserCheckInfo {
	

 private String userCheckId;              //巡查记录编号
 private String projectId;                //巡查内容编号
 private String userCheckResult;          //巡查结果  
 private String faultShow;                //故障现象  
 private String ynHanding;                //是否当场处理
 private String handingimmediately;       //现场处理情况
 
 
@Override
public String toString() {
	return "UserCheckInfo [userCheckId=" + userCheckId + ", projectId=" + projectId + ", userCheckResult="
			+ userCheckResult + ", faultShow=" + faultShow + ", ynHanding=" + ynHanding + ", handingimmediately="
			+ handingimmediately + "]";
}
public String getUserCheckId() {         
	return userCheckId;                  
}
public void setUserCheckId(String userCheckId) {
	this.userCheckId = userCheckId;
}
public String getProjectId() {
	return projectId;
}
public void setProjectId(String projectId) {
	this.projectId = projectId;
}
public String getUserCheckResult() {
	return userCheckResult;
}
public void setUserCheckResult(String userCheckResult) {
	this.userCheckResult = userCheckResult;
}
public String getFaultShow() {
	return faultShow;
}
public void setFaultShow(String faultShow) {
	this.faultShow = faultShow;
}
public String getYnHanding() {
	return ynHanding;
}
public void setYnHanding(String ynHanding) {
	this.ynHanding = ynHanding;
}
public String getHandingimmediately() {
	return handingimmediately;
}
public void setHandingimmediately(String handingimmediately) {
	this.handingimmediately = handingimmediately;
}
	

}
