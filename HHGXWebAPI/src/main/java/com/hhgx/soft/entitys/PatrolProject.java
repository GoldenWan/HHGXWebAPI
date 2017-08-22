package com.hhgx.soft.entitys;

import java.util.List;

public class PatrolProject {

	private String tiSysType;       //系统类型值
	private String vSysdesc;        //系统名称
	private List<UserCheckProjectContent> userCheckProjectContentList;
	public String getTiSysType() {
		return tiSysType;
	}
	public void setTiSysType(String tiSysType) {
		this.tiSysType = tiSysType;
	}
	public String getvSysdesc() {
		return vSysdesc;
	}
	public void setvSysdesc(String vSysdesc) {
		this.vSysdesc = vSysdesc;
	}
	public List<UserCheckProjectContent> getUserCheckProjectContentList() {
		return userCheckProjectContentList;
	}
	public void setUserCheckProjectContentList(List<UserCheckProjectContent> userCheckProjectContentList) {
		this.userCheckProjectContentList = userCheckProjectContentList;
	}
	@Override
	public String toString() {
		return "PatrolProject [tiSysType=" + tiSysType + ", vSysdesc=" + vSysdesc + ", userCheckProjectContentList="
				+ userCheckProjectContentList + "]";
	}
	
	
}
