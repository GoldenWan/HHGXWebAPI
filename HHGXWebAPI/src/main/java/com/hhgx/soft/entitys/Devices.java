package com.hhgx.soft.entitys;

import java.util.Date;

public class Devices {

	private String deviceaddress;
	private int sysaddress;
	private String gatewayaddress;
	private String vdesc;
	private Date dRecorddate;
	private String fPositionX;
	private String fPositionY;
	private String location;
	private String manufacture;
	private String model;
	private Date productDate;
	private Date expdate;
	private String memo;
	private Date addTime;
	private String stateValue;
	private Date stateTime;
	private int deviceNo;
	private String hostID;
	private String road;
	private String address;
	private String cFlatPic;
	private String iDeviceType;
	
	private String deviceTypeName;
	
	
	public String getDeviceTypeName() {
		return deviceTypeName;
	}


	public void setDeviceTypeName(String deviceTypeName) {
		this.deviceTypeName = deviceTypeName;
	}


	public String getDeviceaddress() {
		return deviceaddress;
	}


	public void setDeviceaddress(String deviceaddress) {
		this.deviceaddress = deviceaddress;
	}


	public int getSysaddress() {
		return sysaddress;
	}


	public void setSysaddress(int sysaddress) {
		this.sysaddress = sysaddress;
	}


	public String getGatewayaddress() {
		return gatewayaddress;
	}


	public void setGatewayaddress(String gatewayaddress) {
		this.gatewayaddress = gatewayaddress;
	}


	public String getVdesc() {
		return vdesc;
	}


	public void setVdesc(String vdesc) {
		this.vdesc = vdesc;
	}


	public Date getdRecorddate() {
		return dRecorddate;
	}


	public void setdRecorddate(Date dRecorddate) {
		this.dRecorddate = dRecorddate;
	}


	public String getfPositionX() {
		return fPositionX;
	}


	public void setfPositionX(String fPositionX) {
		this.fPositionX = fPositionX;
	}


	public String getfPositionY() {
		return fPositionY;
	}


	public void setfPositionY(String fPositionY) {
		this.fPositionY = fPositionY;
	}


	public String getLocation() {
		return location;
	}


	public void setLocation(String location) {
		this.location = location;
	}


	public String getManufacture() {
		return manufacture;
	}


	public void setManufacture(String manufacture) {
		this.manufacture = manufacture;
	}


	public String getModel() {
		return model;
	}


	public void setModel(String model) {
		this.model = model;
	}


	public Date getProductDate() {
		return productDate;
	}


	public void setProductDate(Date productDate) {
		this.productDate = productDate;
	}


	public Date getExpdate() {
		return expdate;
	}


	public void setExpdate(Date expdate) {
		this.expdate = expdate;
	}


	public String getMemo() {
		return memo;
	}


	public void setMemo(String memo) {
		this.memo = memo;
	}


	public Date getAddTime() {
		return addTime;
	}


	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}


	public String getStateValue() {
		return stateValue;
	}


	public void setStateValue(String stateValue) {
		this.stateValue = stateValue;
	}


	public Date getStateTime() {
		return stateTime;
	}


	public void setStateTime(Date stateTime) {
		this.stateTime = stateTime;
	}


	public int getDeviceNo() {
		return deviceNo;
	}


	public void setDeviceNo(int deviceNo) {
		this.deviceNo = deviceNo;
	}


	public String getHostID() {
		return hostID;
	}


	public void setHostID(String hostID) {
		this.hostID = hostID;
	}


	public String getRoad() {
		return road;
	}


	public void setRoad(String road) {
		this.road = road;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getcFlatPic() {
		return cFlatPic;
	}


	public void setcFlatPic(String cFlatPic) {
		this.cFlatPic = cFlatPic;
	}


	public String getiDeviceType() {
		return iDeviceType;
	}


	public void setiDeviceType(String iDeviceType) {
		this.iDeviceType = iDeviceType;
	}


	@Override
	public String toString() {
		return "Devices [deviceaddress=" + deviceaddress + ", sysaddress=" + sysaddress + ", gatewayaddress="
				+ gatewayaddress + ", vdesc=" + vdesc + ", dRecorddate=" + dRecorddate + ", fPositionX=" + fPositionX
				+ ", fPositionY=" + fPositionY + ", location=" + location + ", manufacture=" + manufacture + ", model="
				+ model + ", productDate=" + productDate + ", expdate=" + expdate + ", memo=" + memo + ", addTime="
				+ addTime + ", stateValue=" + stateValue + ", stateTime=" + stateTime + ", deviceNo=" + deviceNo
				+ ", hostID=" + hostID + ", road=" + road + ", address=" + address + ", cFlatPic=" + cFlatPic
				+ ", iDeviceType=" + iDeviceType + "]";
	}
	

}
