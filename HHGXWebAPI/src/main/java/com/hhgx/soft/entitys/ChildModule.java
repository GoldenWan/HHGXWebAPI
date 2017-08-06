package com.hhgx.soft.entitys;

public class ChildModule {
	private String	 moduleID;//模块编号
	private String	 moduleName;//模块名称
	private String	 uRL;//url
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
	@Override
	public String toString() {
		return "ChildModule [moduleID=" + moduleID + ", moduleName=" + moduleName + ", uRL=" + uRL + "]";
	}

	
	
}
