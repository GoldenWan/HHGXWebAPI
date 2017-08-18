package com.hhgx.soft.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.hhgx.soft.entitys.ManagerOrg;
import com.hhgx.soft.entitys.ManagerSubs;
import com.hhgx.soft.entitys.User;
import com.hhgx.soft.services.PlayWithRoleService;
import com.hhgx.soft.utils.CommonMethod;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;
import com.hhgx.soft.utils.UUIDGenerator;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/PlayWithRole")
public class PlayWithRoleController {

	@Autowired
	PlayWithRoleService playWithRoleService;

	/**
	 * 4. 查询所有消防管理部门
	 * 
	 * @throws JsonProcessingException
	 */

	@RequestMapping(value = "GetManagerOrgAll", method = { RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String getManagerOrgAll() throws JsonProcessingException {
		List<ManagerOrg> list = playWithRoleService.getManagerOrgAll();
		return ResponseJson.respManagerOrgAll(list);
	}

	/**
	 * 5. 查询某消防管理部门的下级管理部门【分页】
	 * 
	 * @param reqBody
	 * @return
	 * @throws JsonProcessingException
	 */

	@RequestMapping(value = "/GetManagersSubs", method = { RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String getManagersSubs(@RequestBody String reqBody) throws JsonProcessingException {
		Map<String, String> map = RequestJson.reqJson(reqBody, "InfoBag.MID", "managerorgname", "PageIndex");
		String infoBagMID = map.get("infoBag.MID");
		String managerorgname = map.get("managerorgname");// 模糊查询
		String pageIndex = map.get("pageIndex");

		// List<ManagerOrg> list=
		// playWithRoleService.getManagersSubs(infoBagMID,managerorgname,pageIndex,Configuration.getPageSize());
		/*
		 * int statusCode = 0; statusCode = ConstValues.OK; return
		 * ResponseJson.respManagerOrgAll(list);
		 */
		return null;
	}

	/**
	 * 6. 添加消防管理部门
	 * 
	 * @return
	 * @throws JsonProcessingException
	 */
	@RequestMapping(value = "/AddManagerSubs", method = {
			RequestMethod.POST }, consumes = "application/json;charset=UTF-8", produces = "text/html;charset=UTF-8")
	public @ResponseBody String addManagerSubs(@RequestBody String reqBody, HttpServletRequest request)
			throws JsonProcessingException {

		Map<String, String> m = RequestJson.reqJson(reqBody, "ManagerOrgName", "YnSetMonitor", "tel", "Status",
				"ParentID", "AreaId", "Remark", "ManagerAddress", "ManageOrgGrade", "PName",
				"ManagerJob", "ContactName", "ContactTel"
		);
		
		ManagerSubs managerSubs = new ManagerSubs();
		String managerOrgName = m.get("managerOrgName");
		String ynSetMonitor = m.get("ynSetMonitor");
		String tel = m.get("tel");
		String status = m.get("status");
		String parentID = m.get("parentID");
		String areaId = m.get("areaId");
		String remark = m.get("remark");
		String managerAddress = m.get("managerAddress");
		String manageOrgGrade = m.get("manageOrgGrade");
		String pName = m.get("pName");
		String managerJob = m.get("managerJob");
		String contactName = m.get("contactName");
		String contactTel = m.get("contactTel");
		String managerOrgID = UUIDGenerator.getUUID();
		managerSubs.setManagerOrgID(managerOrgID);
		managerSubs.setManagerOrgName(managerOrgName);
		managerSubs.setYnSetMonitor(ynSetMonitor);
		managerSubs.setTel(tel);
		managerSubs.setStatus(status);
		managerSubs.setParentID(parentID);
		managerSubs.setAreaId(areaId);
		managerSubs.setRemark(remark);
		managerSubs.setManagerAddress(managerAddress);
		managerSubs.setManageOrgGrade(manageOrgGrade);
		managerSubs.setpName(pName);
		managerSubs.setManagerJob(managerJob);
		managerSubs.setContactName(contactName);
		managerSubs.setContactTel(contactTel);
		int ret=1;
		String  dataTag=null;
		
		try {
			playWithRoleService.addManagerSubs(managerSubs);
			User user = new User();
			user.setUserID(UUIDGenerator.getUUID());
			user.setAccount(String.valueOf(CommonMethod.getRandNum(100000, 999999)));
			user.setPassword("123456");
			user.setUserBelongTo("3");
			user.setUserTypeID("119manager");
			user.setManagerOrgID(managerOrgID);
			playWithRoleService.addManagerSubsUser(user);
		} catch (Exception e) {
			e.printStackTrace();
			ret=0;
		}
		
        Map<String,String> map =new HashMap<String,String>();		
		if(ret==1)
			dataTag="添加成功";
		else 
			dataTag="添加失败";
		
		map.put("DataTag", dataTag);
		map.put("ret", String.valueOf(ret));
		return JSONObject.fromBean(map).toString();
	}
	
	/**
	 * 7.	删除消防管理部门
	 * 
	 */
	@RequestMapping(value="/RemoveManagerSubs", method={RequestMethod.POST},consumes = "application/json;charset=UTF-8", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String removeManagerSubs(@RequestBody String reqBody){
		Map<String, String> map = RequestJson.reqJson(reqBody, "ManagerOrgID");
		String managerOrg = map.get("managerOrg");
		int ret = 1;
		String dataTag=null;
		try {
			playWithRoleService.removeManagerSubs(managerOrg);
		} catch (Exception e) {
			e.printStackTrace();
			ret=0;
		}
		
        Map<String,String> m =new HashMap<String,String>();		
		if(ret==1)
			dataTag="刪除成功";
		else 
			dataTag="刪除失败";
		
		m.put("DataTag", dataTag);
		m.put("ret", String.valueOf(ret));
		return JSONObject.fromBean(m).toString();
	}
	

}
