package com.hhgx.soft.entitys;

public class SafeDuty {
/**
 * 
 */                                              
	private String safeDutyID;                     
	private String dutyname;                     // 职责名称  
	private String uploadtime;                   //  上传时间
	private String safedutytype;                 //   职责类别
	private String filepath;                     // 职责文件
	private String orgid;                        // 防火单位编号

	public String getSafeDutyID() {
		return safeDutyID;
	}

	public void setSafeDutyID(String safeDutyID) {
		this.safeDutyID = safeDutyID;
	}

	public String getDutyname() {
		return dutyname;
	}

	public void setDutyname(String dutyname) {
		this.dutyname = dutyname;
	}

	public String getUploadtime() {
		return uploadtime;
	}

	public void setUploadtime(String uploadtime) {
		this.uploadtime = uploadtime;
	}

	public String getSafedutytype() {
		return safedutytype;
	}

	public void setSafedutytype(String safedutytype) {
		this.safedutytype = safedutytype;
	}

	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

}
