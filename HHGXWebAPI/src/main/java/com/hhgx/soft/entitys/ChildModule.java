package com.hhgx.soft.entitys;

public class ChildModule {
	private String moduleID;//模块编号
	private String moduleName;//模块名称
	private String uRL;//url
	private String orderNum;
	private String parentID;
	private String levelnum;
	private String pic;
   
	
	public String getModuleID() {
		return moduleID;
	}
	public void setModuleID(String moduleID) {
		this.moduleID = moduleID;
	}
	public String getModuleName() {
		return moduleName;
	}
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	public String getuRL() {
		return uRL;
	}
	public void setuRL(String uRL) {
		this.uRL = uRL;
	}
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public String getParentID() {
		return parentID;
	}
	public void setParentID(String parentID) {
		this.parentID = parentID;
	}
	public String getLevelnum() {
		return levelnum;
	}
	public void setLevelnum(String levelnum) {
		this.levelnum = levelnum;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	@Override
	public String toString() {
		return "ChildModule [moduleID=" + moduleID + ", moduleName=" + moduleName + ", uRL=" + uRL + ", orderNum="
				+ orderNum + ", parentID=" + parentID + ", levelnum=" + levelnum + ", pic=" + pic + "]";
	}

	
	
}
