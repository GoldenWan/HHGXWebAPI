package com.hhgx.soft.entitys;

public class Manoeuvre {
	private String manoeuvreID; // 演练编号
	private String manoeuvretime; // 演练时间
	private String address; // 演练地点
	private String Department; // 组织部门
	private String manager; // 演练负责人
	private String content; // 演练内容
	private String scheme; // 演练方案
	private String attendperson; // 参与人员
	private String implementation; // 演练实施情况
	private String summary; // 演练小结
	private String suggestion; // 对预案的改进意见
	private String schemafile; // 演练方案附件
	private String attendpersonfile; // 参与人员附件
	private String implementationfile; // 演练实施情况附件
	private String orgid;

	public String getManoeuvreID() {
		return manoeuvreID;
	}

	public void setManoeuvreID(String manoeuvreID) {
		this.manoeuvreID = manoeuvreID;
	}

	public String getManoeuvretime() {
		return manoeuvretime;
	}

	public void setManoeuvretime(String manoeuvretime) {
		this.manoeuvretime = manoeuvretime;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDepartment() {
		return Department;
	}

	public void setDepartment(String department) {
		Department = department;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getScheme() {
		return scheme;
	}

	public void setScheme(String scheme) {
		this.scheme = scheme;
	}

	public String getAttendperson() {
		return attendperson;
	}

	public void setAttendperson(String attendperson) {
		this.attendperson = attendperson;
	}

	public String getImplementation() {
		return implementation;
	}

	public void setImplementation(String implementation) {
		this.implementation = implementation;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getSuggestion() {
		return suggestion;
	}

	public void setSuggestion(String suggestion) {
		this.suggestion = suggestion;
	}

	public String getSchemafile() {
		return schemafile;
	}

	public void setSchemafile(String schemafile) {
		this.schemafile = schemafile;
	}

	public String getAttendpersonfile() {
		return attendpersonfile;
	}

	public void setAttendpersonfile(String attendpersonfile) {
		this.attendpersonfile = attendpersonfile;
	}

	public String getImplementationfile() {
		return implementationfile;
	}

	public void setImplementationfile(String implementationfile) {
		this.implementationfile = implementationfile;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

}
