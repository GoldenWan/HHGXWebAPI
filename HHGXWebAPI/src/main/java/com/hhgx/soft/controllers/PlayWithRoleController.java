package com.hhgx.soft.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hhgx.soft.entitys.ManagerOrg;
import com.hhgx.soft.entitys.User;
import com.hhgx.soft.services.PlayWithRoleService;
import com.hhgx.soft.utils.CommonMethod;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.GetRequestJsonUtils;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;
import com.hhgx.soft.utils.UUIDGenerator;


@Controller
@RequestMapping(value = "/PlayWithRole")
public class PlayWithRoleController {

	@Autowired
	PlayWithRoleService playWithRoleService;

	/**
	 * 4. 查询所有消防管理部门
	 * @throws IOException 
	 */

	@RequestMapping(value = "GetManagerOrgAll", method = { RequestMethod.POST })
	@ResponseBody
	public String getManagerOrgAll(HttpServletRequest request) throws IOException {
	
		
		List<Map<String, String>> list =null;
		int statusCode = -1;
		try {
			list = playWithRoleService.getAllManagerOrg();
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(list, statusCode);

	}

	

	/**
	 * 6. 添加消防管理部门
	 * 
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value = "/AddManagerSubs", method = {RequestMethod.POST })
	public @ResponseBody String addManagerSubs(HttpServletRequest request)
			throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		
		
		Map<String, String> m = RequestJson.reqFirstLowerJson(reqBody, "ManagerOrgName", "ManageOrgGrade", "PName", "ManagerJob",
				"ContactName", "ContactTel", "AreaId", "ManagerAddress", "Status", "Remark", "ParentID");
		int statusCode=1;
		String  dataBag=null;
		try{
		ManagerOrg managerOrg = new ManagerOrg();
		String managerOrgName = m.get("managerOrgName");
		String manageOrgGrade = m.get("manageOrgGrade");
		String pName = m.get("pName");
		String managerJob = m.get("managerJob");
		String contactName = m.get("contactName");
		String contactTel = m.get("contactTel");
		String areaId = m.get("areaId");
		String managerAddress = m.get("managerAddress");
		String status = m.get("status");
		String remark = m.get("remark");
		String parentID = m.get("parentID");		
		
		String managerOrgID =UUIDGenerator.getUUID();
		managerOrg.setManagerOrgID(managerOrgID);
		managerOrg.setManagerOrgName(managerOrgName);
		managerOrg.setManageOrgGrade(manageOrgGrade);
		managerOrg.setpName(pName);
		managerOrg.setManagerJob(managerJob);
		managerOrg.setContactName(contactName);
		managerOrg.setContactTel(contactTel);
		managerOrg.setAreaId(areaId);
		managerOrg.setManagerAddress(managerAddress);
		managerOrg.setStatus(status);
		managerOrg.setRemark(remark);
		managerOrg.setParentID(parentID);
		
		playWithRoleService.addManagerSubs(managerOrg);
		
		User user = new User();
		user.setUserID(UUIDGenerator.getUUID());
		user.setAccount(String.valueOf(CommonMethod.getRandNum(100000, 999999)));
		user.setPassword("123456");
		user.setUserBelongTo("3");
		user.setUserTypeID("119manager");
		user.setManagerOrgID(managerOrgID);
		playWithRoleService.addManagerSubsUser(user);
		
		
		statusCode = ConstValues.OK;
		dataBag = ConstValues.SUCCESS;
	} catch (Exception e) {
		e.printStackTrace();
		statusCode = ConstValues.FAILED;
		dataBag = ConstValues.FIALURE;
	}
	return ResponseJson.responseAddJson(dataBag, statusCode);
	
}
	@RequestMapping(value = "/UpdateManagerSubs", method = {RequestMethod.POST })
	public @ResponseBody String updateManagerSubs(HttpServletRequest request)
			throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		
		
		Map<String, String> m = RequestJson.reqFirstLowerJson(reqBody, "ManagerOrgName", "ManageOrgGrade", "PName", "ManagerJob",
				"ContactName", "ContactTel", "AreaId", "ManagerAdress", "Status", "Remark", "ManagerOrgID");
		int statusCode=1;
		String  dataBag=null;
		try{
			ManagerOrg managerOrg = new ManagerOrg();
			String managerOrgName = m.get("managerOrgName");
			String manageOrgGrade = m.get("manageOrgGrade");
			String pName = m.get("pName");
			String managerJob = m.get("managerJob");
			String contactName = m.get("contactName");
			String contactTel = m.get("contactTel");
			String areaId = m.get("areaId");
			String managerAddress = m.get("managerAdress");
			String status = m.get("status");
			String remark = m.get("remark");
			String parentID = m.get("parentID");		
			String managerOrgID = m.get("managerOrgID");		
			
			managerOrg.setManagerOrgID(managerOrgID);
			managerOrg.setManagerOrgName(managerOrgName);
			managerOrg.setManageOrgGrade(manageOrgGrade);
			managerOrg.setpName(pName);
			managerOrg.setManagerJob(managerJob);
			managerOrg.setContactName(contactName);
			managerOrg.setContactTel(contactTel);
			managerOrg.setAreaId(areaId);
			managerOrg.setManagerAddress(managerAddress);
			managerOrg.setStatus(status);
			managerOrg.setRemark(remark);
			managerOrg.setParentID(parentID);
			
			playWithRoleService.updateManagerSubs(managerOrg);
			
			
			statusCode = ConstValues.OK;
			dataBag = ConstValues.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = ConstValues.FIALURE;
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);
		
	}
	/**
	 * 7.	删除消防管理部门
	 * @throws IOException 
	 * 
	 */
	@ResponseBody
	@RequestMapping(value="/RemoveManagerSubs", method={RequestMethod.POST})
	public String removeManagerSubs(HttpServletRequest request) throws IOException{
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "ManagerOrgID");
		String managerOrgID = map.get("managerOrgID");
		int statusCode = -1;
		String dataBag=null;
		try {
			playWithRoleService.deleteManagerSubsUser(managerOrgID);
			playWithRoleService.removeManagerSubs(managerOrgID);
			statusCode = ConstValues.OK;
			dataBag=ConstValues.SUCCESSDEL;

	} catch (Exception e) {
		e.printStackTrace();
		statusCode = ConstValues.FAILED;
		dataBag=ConstValues.FIALUREDEL;
	}

	return ResponseJson.responseAddJson(dataBag, statusCode);
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "/ManagerDetail", method = RequestMethod.POST)
	public String getPatrolDetail(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "ManagerOrgID");
		String managerOrgID = map.get("managerOrgID");
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		
		int statusCode = -1;
		try {
			lmList = playWithRoleService.getManagerDetail(managerOrgID);
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJson(lmList.get(0), statusCode);
	}
	
	@ResponseBody
	@RequestMapping(value = "/GetManagerUsers", method = RequestMethod.POST)
	public String getManagerUsers(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "managerOrgID");
		String managerOrgID = map.get("managerOrgID");
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		
		int statusCode = -1;
		try {
			
			lmList = playWithRoleService.getManagerUsers(managerOrgID);
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(lmList, statusCode);
	}

}
