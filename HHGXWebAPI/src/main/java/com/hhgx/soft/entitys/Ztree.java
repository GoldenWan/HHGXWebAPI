package com.hhgx.soft.entitys;

import java.util.List;

public class Ztree {
	
	private List<ChildModule> dKZTree ;
	private String moduleID;//模块编号
	private String moduleName;//模块名称
	private String uRL;//url
	private String orderNum;
	private String parentID;
	private String levelnum;
	private String pic;
	
	
	public List<ChildModule> getDKZTree() {
		return dKZTree;
	}
	public void setDKZTree(List<ChildModule> dKZTree) {
		this.dKZTree = dKZTree;
	}
	public String getModuleID() {
		return moduleID;
	}
	public void setModuleID(String moduleID) {
		this.moduleID = moduleID;
	}
	public String getModuleName() {
		return moduleName;
	}
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	public String getuRL() {
		return uRL;
	}
	public void setuRL(String uRL) {
		this.uRL = uRL;
	}
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public String getParentID() {
		return parentID;
	}
	public void setParentID(String parentID) {
		this.parentID = parentID;
	}
	public String getLevelnum() {
		return levelnum;
	}
	public void setLevelnum(String levelnum) {
		this.levelnum = levelnum;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	
	/*
	"DKZTree": [
	            {
	              "ModuleID": "M014000008",
	              "ModuleName": "火警处理结果统计",
	              "URL": "./Competent/ResultStatistics.html",
	              "OrderNum": null,
	              "ParentID": "M014000000",
	              "levelnum": 2,
	              "pic": null,
	              "Module_UserType": []
	            },
	            {
	              "ModuleID": "M014000005",
	              "ModuleName": "单项检测情况",
	              "URL": "./Competent/EquipmentTest.html",
	              "OrderNum": 61,
	              "ParentID": "M014000000",
	              "levelnum": 2,
	              "pic": "",
	              "Module_UserType": []
	            }
	          ],
	 "TreeType": null,
     "ModuleID": "M014000000",
     "ModuleName": "消防管理情况",
     "URL": "",
     "OrderNum": 14,
     "ParentID": "          ",
     "levelnum": 1,
     "pic": "ManagementSituation ",
     "Module_UserType": []
    		 
    	*/	 
}
