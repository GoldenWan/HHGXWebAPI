package com.hhgx.soft.entitys;

public class OnlineFiresystem {

	private String tiSysType;    //建筑物编号
	private String siteid;       //系统类型值
	private String states;       //状态
	private String ynOnline;     //是否具有联网功能
	private String remarks;      //备注
	private String maintenanceId;
	private String sysFlatpic;
	
	private String vSysdesc;
	private String sitename;
	
	
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
	public String getSysFlatpic() {
		return sysFlatpic;
	}
	public void setSysFlatpic(String sysFlatpic) {
		this.sysFlatpic = sysFlatpic;
	}
	public String getTiSysType() {
		return tiSysType;
	}
	public void setTiSysType(String tiSysType) {
		this.tiSysType = tiSysType;
	}
	public String getSiteid() {
		return siteid;
	}
	public void setSiteid(String siteid) {
		this.siteid = siteid;
	}
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
	public String getMaintenanceId() {
		return maintenanceId;
	}
	public void setMaintenanceId(String maintenanceId) {
		this.maintenanceId = maintenanceId;
	}
	
	
	
	
}
