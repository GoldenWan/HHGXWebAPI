package com.hhgx.soft.entitys;

import java.util.List;

public class Firesystype {
	private String  tiSysType;
	private String sysaddress;
    private String  vSysdesc ;
    private String orderNO  ;
    
    List<UserCheckProjectContent> userCheckProjectContents;  
    
	public List<UserCheckProjectContent> getUserCheckProjectContents() {
		return userCheckProjectContents;
	}
	public void setUserCheckProjectContents(List<UserCheckProjectContent> userCheckProjectContents) {
		this.userCheckProjectContents = userCheckProjectContents;
	}
	
	public String getSysaddress() {
		return sysaddress;
	}
	public void setSysaddress(String sysaddress) {
		this.sysaddress = sysaddress;
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
	public String getOrderNO() {
		return orderNO;
	}
	public void setOrderNO(String orderNO) {
		this.orderNO = orderNO;
	}
  
	
}
