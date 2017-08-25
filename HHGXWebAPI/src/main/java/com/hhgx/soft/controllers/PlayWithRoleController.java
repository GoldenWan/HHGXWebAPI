package com.hhgx.soft.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hhgx.soft.entitys.ManagerOrg;
import com.hhgx.soft.entitys.Page;
import com.hhgx.soft.entitys.User;
import com.hhgx.soft.services.PlayWithRoleService;
import com.hhgx.soft.utils.CommonMethod;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.GetRequestJsonUtils;
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
	 * @throws IOException 
	 */

	@RequestMapping(value = "GetManagerOrgAll", method = { RequestMethod.POST })
	@ResponseBody
	public String getManagerOrgAll(HttpServletRequest request) throws IOException {
	
		
		List<ManagerOrg> list =null;
		int statusCode = -1;
		try {
			list = playWithRoleService.getAllManagerOrg();
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		List<Map<String, String>> list2 = new ArrayList<>();
		for(ManagerOrg managerOrg : list){
			Map<String, String> map2 = new HashMap<String, String>();
			map2.put("id", managerOrg.getManagerOrgID());
			map2.put("pId", managerOrg.getParentID());
			map2.put("name", managerOrg.getAreaName());
			list2.add(map2);
		}
		return ResponseJson.responseFindJson(list2, statusCode);

	}

	/**
	 * 5. 查询某消防管理部门的下级管理部门【分页】
	 * 
	 * @param reqBody
	 * @return
	 * @throws IOException 
	 */

	@RequestMapping(value = "/GetManagersSubs", method = { RequestMethod.POST })
	@ResponseBody
	public String getManagersSubs(HttpServletRequest request) throws IOException {
		
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "infoBag.MID", "managerorgname", "PageIndex");
		String infoBagMID = map.get("infoBag.MID");
		String managerorgname = map.get("managerorgname");// 模糊查询
		String pageIndex = map.get("pageIndex");

		Page page = null;
		List<ManagerOrg> managerOrgList = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		int totalCount = playWithRoleService.getManagersSubsCount(infoBagMID,managerorgname);
		int statusCode = -1;

		try {
			if (pageIndex != null) {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				//模糊查询
				managerOrgList  = playWithRoleService.getManagersSubs(infoBagMID,managerorgname, page.getStartPos(),
						page.getPageSize());

			} else {
				page = new Page(totalCount, 1);
				managerOrgList = playWithRoleService.getManagersSubs(infoBagMID,managerorgname, page.getStartPos(),
						page.getPageSize());
			}
			for (ManagerOrg managerOrg : managerOrgList ) {
				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("managerorgid", managerOrg.getManagerOrgID());
				map2.put("managerorgname", managerOrg.getManagerOrgName());
				map2.put("YnSetMonitor", managerOrg.getYnSetMonitor());
				map2.put("tel", managerOrg.getTel());
				map2.put("Status", managerOrg.getStatus());
				map2.put("areaname", managerOrg.getAreaName());
				map2.put("ManagerAddress", managerOrg.getAddress());
				map2.put("ManageOrgGrade", managerOrg.getManageOrgGrade());
				map2.put("PName", managerOrg.getpName());
				map2.put("ManagerJob", managerOrg.getManagerJob());
				map2.put("ContactName", managerOrg.getContactName());
				map2.put("ContactTel", managerOrg.getContactTel());
				lmList.add(map2);
			}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responsePalyWithRoleFindPageJson(lmList,managerorgname,statusCode, totalCount);

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
		Map<String, String> m = RequestJson.reqFirstLowerJson(reqBody, "ManagerOrgName", "YnSetMonitor", "tel", "Status",
				"ParentID", "AreaId", "Remark", "ManagerAddress", "ManageOrgGrade", "PName",
				"ManagerJob", "ContactName", "ContactTel"
		);
		int ret=1;
		String  dataTag=null;
		try{
		ManagerOrg managerOrg = new ManagerOrg();
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
		managerOrg.setManagerOrgID(managerOrgID);
		managerOrg.setManagerOrgName(managerOrgName);
		managerOrg.setYnSetMonitor(ynSetMonitor);
		managerOrg.setTel(tel);
		managerOrg.setStatus(status);
		managerOrg.setParentID(parentID);
		managerOrg.setAreaId(areaId);
		managerOrg.setRemark(remark);
		managerOrg.setAddress(managerAddress);
		managerOrg.setManageOrgGrade(manageOrgGrade);
		managerOrg.setpName(pName);
		managerOrg.setManagerJob(managerJob);
		managerOrg.setContactName(contactName);
		managerOrg.setContactTel(contactTel);
		
		playWithRoleService.addManagerSubs(managerOrg);
			
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
	 * @throws IOException 
	 * 
	 */
	@ResponseBody
	@RequestMapping(value="/RemoveManagerSubs", method={RequestMethod.POST})
	public String removeManagerSubs(HttpServletRequest request) throws IOException{
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "ManagerOrgID");
		String managerOrgID = map.get("managerOrgID");
		int ret = -1;
		String dataTag=null;
		try {
			playWithRoleService.removeManagerSubs(managerOrgID);
			ret=1;
			dataTag="刪除成功";
		} catch (Exception e) {
			e.printStackTrace();
			ret=0;
			dataTag="刪除失败";
		}
		
        Map<String,String> m =new HashMap<String,String>();		
		m.put("DataTag", dataTag);
		m.put("ret", String.valueOf(ret));
		return JSONObject.fromBean(m).toString();
	}
	

}
