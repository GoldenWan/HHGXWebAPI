package com.hhgx.soft.entitys;

public class FireSystem {
	private String tiSysType;    //系统类型值
	private String vSysdesc ;    //系统名称
	private String sitename ;    //建筑物名称
	private String siteid   ;    //建筑物编号
    private String states     ;
    private String ynOnline   ;
    private String remarks    ;

	public String getStates() {
		return states;
	}
	public void setStates(String states) {
		this.states = states;
	}
	public String getYnOnline() {
		return ynOnline;
	}
	public void setYnOnline(String ynOnline) {
		this.ynOnline = ynOnline;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
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
	public String getSitename() {
		return sitename;
	}
	public void setSitename(String sitename) {
		this.sitename = sitename;
	}
	public String getSiteid() {
		return siteid;
	}
	public void setSiteid(String siteid) {
		this.siteid = siteid;
	}
	
}
