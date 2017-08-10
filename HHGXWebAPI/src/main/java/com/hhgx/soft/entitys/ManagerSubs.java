package com.hhgx.soft.entitys;

public class ManagerSubs {
	
	private String  managerOrgID;
	private String managerOrgName; // 管理机构名称
	private String ynSetMonitor;// 是否设置接警平台
	private String tel; // 联系电话
	private String status; // 状态
	private String parentID; // 上级主管部门编号
	private String areaId; // 区域编号
	private String remark; // 备注
	private String managerAddress; // 地址
	private String manageOrgGrade; // 级别
	private String pName; // 负责人
	private String managerJob; // 负责人职务
	private String contactName; // 联系人姓名
	private String contactTel; // 联系人电话
	
	
	

	public String getManagerOrgName() {
		return managerOrgName;
	}


	public void setManagerOrgName(String managerOrgName) {
		this.managerOrgName = managerOrgName;
	}


	public String getYnSetMonitor() {
		return ynSetMonitor;
	}


	public void setYnSetMonitor(String ynSetMonitor) {
		this.ynSetMonitor = ynSetMonitor;
	}


	public String getTel() {
		return tel;
	}


	public void setTel(String tel) {
		this.tel = tel;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getParentID() {
		return parentID;
	}


	public void setParentID(String parentID) {
		this.parentID = parentID;
	}


	public String getAreaId() {
		return areaId;
	}


	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}


	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}


	public String getManagerAddress() {
		return managerAddress;
	}


	public void setManagerAddress(String managerAddress) {
		this.managerAddress = managerAddress;
	}


	public String getManageOrgGrade() {
		return manageOrgGrade;
	}


	public void setManageOrgGrade(String manageOrgGrade) {
		this.manageOrgGrade = manageOrgGrade;
	}


	public String getpName() {
		return pName;
	}


	public void setpName(String pName) {
		this.pName = pName;
	}


	public String getManagerJob() {
		return managerJob;
	}


	public void setManagerJob(String managerJob) {
		this.managerJob = managerJob;
	}


	public String getContactName() {
		return contactName;
	}


	public void setContactName(String contactName) {
		this.contactName = contactName;
	}


	public String getContactTel() {
		return contactTel;
	}


	public void setContactTel(String contactTel) {
		this.contactTel = contactTel;
	}


	@Override
	public String toString() {
		return "ManagerSubs [managerOrgName=" + managerOrgName + ", ynSetMonitor=" + ynSetMonitor + ", tel=" + tel
				+ ", status=" + status + ", parentID=" + parentID + ", areaId=" + areaId + ", remark=" + remark
				+ ", managerAddress=" + managerAddress + ", manageOrgGrade=" + manageOrgGrade + ", pName=" + pName
				+ ", managerJob=" + managerJob + ", contactName=" + contactName + ", contactTel=" + contactTel + "]";
	}


	public String getManagerOrgID() {
		return managerOrgID;
	}


	public void setManagerOrgID(String managerOrgID) {
		this.managerOrgID = managerOrgID;
	}
	
	
	
	

}
