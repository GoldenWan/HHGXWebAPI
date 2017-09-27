package com.hhgx.soft.entitys;

import java.util.List;

public class Site {

	private String siteid; // 建筑物编号
	private String sitename; // 建筑物名称
	private String buildingaddress; // 建筑地址
	private String useproperty; // 使用性质
	private String dSCS; // 地上层数
	private String jZGD; // 建筑高度
	private String dSJZMJ; // 地上建筑面积
	private String nHDJ; // 耐火等级
	private String jGLX; // 结构类型
	private String dXCS; // 地下层数
	private String dXJZMJ; // 地下建筑面积
	private String sDQK; // 遂道情况
	private String zYCCW; // 主要存储物情况
	private String rLRS; // 建筑物内最大容纳人数
	private String qLJZ; // 毗邻建筑物情况
	private String east; // 东边毗邻
	private String west; // 西边毗邻
	private String south; // 南边毗邻
	private String north; // 北边毗邻
	private String xx; // 在单位总平面图中的x坐标
	private String yy; // 在单位总平面图中的y坐标
	private String sitetypename; // 建筑物类别
	private String holdthings; // 储存物名称
	private String holdthingsnum; // 储存物数量
	private String annalTime; // 记录时间
	private String fLongitude; // 经度
	private String fLatitude; // 纬度
	private String orgid; // 防火单位编号
	private List<Firesystype> firesystypes ;
	private List<String> appearancepics;
	
	public List<String> getAppearancepics() {
		return appearancepics;
	}
	public void setAppearancepics(List<String> appearancepics) {
		this.appearancepics = appearancepics;
	}
	public List<Firesystype> getFiresystypes() {
		return firesystypes;
	}
	public void setFiresystypes(List<Firesystype> firesystypes) {
		this.firesystypes = firesystypes;
	}
	public String getSiteid() {
		return siteid;
	}
	public void setSiteid(String siteid) {
		this.siteid = siteid;
	}
	public String getSitename() {
		return sitename;
	}
	public void setSitename(String sitename) {
		this.sitename = sitename;
	}
	public String getBuildingaddress() {
		return buildingaddress;
	}
	public void setBuildingaddress(String buildingaddress) {
		this.buildingaddress = buildingaddress;
	}
	public String getUseproperty() {
		return useproperty;
	}
	public void setUseproperty(String useproperty) {
		this.useproperty = useproperty;
	}
	public String getdSCS() {
		return dSCS;
	}
	
	@Override
	public String toString() {
		return "Site [siteid=" + siteid + ", sitename=" + sitename + ", buildingaddress=" + buildingaddress
				+ ", useproperty=" + useproperty + ", dSCS=" + dSCS + ", jZGD=" + jZGD + ", dSJZMJ=" + dSJZMJ
				+ ", nHDJ=" + nHDJ + ", jGLX=" + jGLX + ", dXCS=" + dXCS + ", dXJZMJ=" + dXJZMJ + ", sDQK=" + sDQK
				+ ", zYCCW=" + zYCCW + ", rLRS=" + rLRS + ", qLJZ=" + qLJZ + ", east=" + east + ", west=" + west
				+ ", south=" + south + ", north=" + north + ", xx=" + xx + ", yy=" + yy + ", sitetypename="
				+ sitetypename + ", holdthings=" + holdthings + ", holdthingsnum=" + holdthingsnum + ", annalTime="
				+ annalTime + ", fLongitude=" + fLongitude + ", fLatitude=" + fLatitude + ", orgid=" + orgid
				+ ", firesystypes=" + firesystypes + ", appearancepics=" + appearancepics + "]";
	}
	public void setdSCS(String dSCS) {
		this.dSCS = dSCS;
	}
	public String getjZGD() {
		return jZGD;
	}
	public void setjZGD(String jZGD) {
		this.jZGD = jZGD;
	}
	public String getdSJZMJ() {
		return dSJZMJ;
	}
	public void setdSJZMJ(String dSJZMJ) {
		this.dSJZMJ = dSJZMJ;
	}
	public String getnHDJ() {
		return nHDJ;
	}
	public void setnHDJ(String nHDJ) {
		this.nHDJ = nHDJ;
	}
	public String getjGLX() {
		return jGLX;
	}
	public void setjGLX(String jGLX) {
		this.jGLX = jGLX;
	}
	public String getdXCS() {
		return dXCS;
	}
	public void setdXCS(String dXCS) {
		this.dXCS = dXCS;
	}
	public String getdXJZMJ() {
		return dXJZMJ;
	}
	public void setdXJZMJ(String dXJZMJ) {
		this.dXJZMJ = dXJZMJ;
	}
	public String getsDQK() {
		return sDQK;
	}
	public void setsDQK(String sDQK) {
		this.sDQK = sDQK;
	}
	public String getzYCCW() {
		return zYCCW;
	}
	public void setzYCCW(String zYCCW) {
		this.zYCCW = zYCCW;
	}
	public String getrLRS() {
		return rLRS;
	}
	public void setrLRS(String rLRS) {
		this.rLRS = rLRS;
	}
	public String getqLJZ() {
		return qLJZ;
	}
	public void setqLJZ(String qLJZ) {
		this.qLJZ = qLJZ;
	}
	public String getEast() {
		return east;
	}
	public void setEast(String east) {
		this.east = east;
	}
	public String getWest() {
		return west;
	}
	public void setWest(String west) {
		this.west = west;
	}
	public String getSouth() {
		return south;
	}
	public void setSouth(String south) {
		this.south = south;
	}
	public String getNorth() {
		return north;
	}
	public void setNorth(String north) {
		this.north = north;
	}
	public String getXx() {
		return xx;
	}
	public void setXx(String xx) {
		this.xx = xx;
	}
	public String getYy() {
		return yy;
	}
	public void setYy(String yy) {
		this.yy = yy;
	}
	public String getSitetypename() {
		return sitetypename;
	}
	public void setSitetypename(String sitetypename) {
		this.sitetypename = sitetypename;
	}
	public String getHoldthings() {
		return holdthings;
	}
	public void setHoldthings(String holdthings) {
		this.holdthings = holdthings;
	}
	public String getHoldthingsnum() {
		return holdthingsnum;
	}
	public void setHoldthingsnum(String holdthingsnum) {
		this.holdthingsnum = holdthingsnum;
	}
	public String getAnnalTime() {
		return annalTime;
	}
	public void setAnnalTime(String annalTime) {
		this.annalTime = annalTime;
	}
	public String getfLongitude() {
		return fLongitude;
	}
	public void setfLongitude(String fLongitude) {
		this.fLongitude = fLongitude;
	}
	public String getfLatitude() {
		return fLatitude;
	}
	public void setfLatitude(String fLatitude) {
		this.fLatitude = fLatitude;
	}
	public String getOrgid() {
		return orgid;
	}
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}
	
	
	

}
