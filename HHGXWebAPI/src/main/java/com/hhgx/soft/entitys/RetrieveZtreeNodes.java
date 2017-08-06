package com.hhgx.soft.entitys;

public class RetrieveZtreeNodes {
	
	private String userID;    //用户的编号
	private String userbelong;//用户类别 1:防火单位用户；2：维保部门用户3：消防管理部门用户；4：系统管理员用户 
	private String usertype;  //用户类型	
	private String moduleName;//模块名称
	private ChildModule childModule;//子模块
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserbelong() {
		return userbelong;
	}
	public void setUserbelong(String userbelong) {
		this.userbelong = userbelong;
	}
	public String getUsertype() {
		return usertype;
	}
	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}
	public String getModuleName() {
		return moduleName;
	}
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	public ChildModule getChildModule() {
		return childModule;
	}
	public void setChildModule(ChildModule childModule) {
		this.childModule = childModule;
	}
	@Override
	public String toString() {
		return "RetrieveZtreeNodes [userID=" + userID + ", userbelong=" + userbelong + ", usertype=" + usertype
				+ ", moduleName=" + moduleName + ", childModule=" + childModule + "]";
	}
	
}
