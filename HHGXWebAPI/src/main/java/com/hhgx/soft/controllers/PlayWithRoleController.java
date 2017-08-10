package com.hhgx.soft.controllers;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.hhgx.soft.entitys.ManagerOrg;
import com.hhgx.soft.services.PlayWithRoleService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;

@Controller
@RequestMapping(value="/PlayWithRole")
public class PlayWithRoleController {
	
	@Autowired
	PlayWithRoleService playWithRoleService;
	/**
	 * 4.	查询所有消防管理部门
	 * @throws JsonProcessingException 
	 */

	@RequestMapping(value="GetManagerOrgAll", method = {RequestMethod.POST },produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String getManagerOrgAll() throws JsonProcessingException {
	   List<ManagerOrg> list= playWithRoleService.getManagerOrgAll();
	   return ResponseJson.respManagerOrgAll(list);
	}
	
	/**
	 * 查询某消防管理部门的下级管理部门【分页】
	 * @param reqBody
	 * @return
	 * @throws JsonProcessingException
	 */
	
	@RequestMapping(value="GetManagersSubs", method = {RequestMethod.POST },produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String getManagersSubs(@RequestBody String reqBody ) throws JsonProcessingException {
		Map<String, String> map = RequestJson.reqJson(reqBody, "InfoBag.MID", "managerorgname","PageIndex");
		String infoBagMID = map.get("infoBag.MID");
		String managerorgname = map.get("managerorgname");//模糊查询
		
		
		
		
		//List<ManagerOrg> list= playWithRoleService.getManagersSubs();
		/*
		int statusCode = 0;
		statusCode = ConstValues.OK;
		return ResponseJson.respManagerOrgAll(list);*/
		return null;
	}
	
	
	
}
