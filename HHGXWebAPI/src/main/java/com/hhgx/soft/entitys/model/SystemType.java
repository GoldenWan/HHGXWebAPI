package com.hhgx.soft.entitys.model;

import java.util.List;

public class SystemType {
	private String tiSysType;
    private String vSysdesc;
    private List<Project> contents;
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
	public List<Project> getContents() {
		return contents;
	}
	public void setContents(List<Project> contents) {
		this.contents = contents;
	}
	   
   
}
