package com.hhgx.soft.controllers;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hhgx.soft.entitys.Page;
import com.hhgx.soft.services.ManageOrgInfoService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.DateUtils;
import com.hhgx.soft.utils.GetRequestJsonUtils;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;

@Controller
@RequestMapping("/ManageOrgInfo")
public class ManageOrgInfoController {
	
	@Autowired
	private ManageOrgInfoService manageOrgInfoService;
	
	@ResponseBody
	@RequestMapping(value = "/ManageTestState", method = RequestMethod.POST)
	public String manageTestState(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody,"ManagerOrgID", "startTime", "endTime", "PageIndex");
		
		
		String managerOrgID = map.get("managerOrgID");
		String startDate = map.get("startTime");
		String endDate = map.get("endTime");
		Timestamp startTime= null;
		Timestamp endTime = null;
		
		if(!StringUtils.isEmpty(startDate)){
			startTime=DateUtils.stringToTimestamp(startDate," 00:00:00");
		}
		if(!StringUtils.isEmpty(endDate)){
			endTime=DateUtils.stringToTimestamp(endDate," 23:59:59");
		}
		String pageIndex = map.get("pageIndex");
		int statusCode = -1;
		Page page = null;
		List<Map<String, Object>> lmList = null;
		int totalCount = manageOrgInfoService.ManageTestStateCount(managerOrgID, startTime,endTime);
		try {
			if (!StringUtils.isEmpty(pageIndex)) {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				lmList = manageOrgInfoService.ManageTestStateList(managerOrgID, startTime,endTime, page.getStartPos(), page.getPageSize());
				
			} else {
				page = new Page(totalCount, 1);
				lmList = manageOrgInfoService.ManageTestStateList(managerOrgID, startTime,endTime, page.getStartPos(), page.getPageSize());
			}
			
			statusCode = ConstValues.OK;
			
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJsonArray(lmList, statusCode, totalCount);
	}
	@ResponseBody
	@RequestMapping(value = "/ManagerRecurOrgList", method = RequestMethod.POST)
	public String managerRecurOrgList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "managerorgid", "orgname", "PageIndex");
		
		
		String orgName = map.get("orgname");
		String managerOrgID = map.get("managerorgid");
		String pageIndex = map.get("pageIndex");
		int statusCode = -1;
		Page page = null;
		List<Map<String, Object>> lmList = null;
		int totalCount = manageOrgInfoService.managerRecurOrgListCount(managerOrgID, orgName);
		try {
			if (!StringUtils.isEmpty(pageIndex)) {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				lmList = manageOrgInfoService.managerRecurOrgList(managerOrgID,orgName, page.getStartPos(), page.getPageSize());
				
			} else {
				page = new Page(totalCount, 1);
				lmList = manageOrgInfoService.managerRecurOrgList(managerOrgID,orgName, page.getStartPos(), page.getPageSize());
			}
			
			statusCode = ConstValues.OK;
			
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJsonArray(lmList, statusCode, totalCount);
	}
	
	/**
	 * 159.获取火警报警统计情况
	 * @param request
	 * @return
	 * @throws IOException:TODO
	 
	 */
	@ResponseBody
	@RequestMapping(value = "/AlarmCencus", method = RequestMethod.POST)
	public String alarmCencus(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "ManagerOrgID", "startTime", "endTime");
		String managerOrgID = map.get("managerOrgID");
		String startDate = map.get("startTime");
		String endDate = map.get("endTime");
		Timestamp startTime= null;
		Timestamp endTime = null;
		
		if(!StringUtils.isEmpty(startDate)){
			startTime=DateUtils.stringToTimestamp(startDate," 00:00:00");
		}
		if(!StringUtils.isEmpty(endDate)){
			endTime=DateUtils.stringToTimestamp(endDate," 23:59:59");
		}

		
		int statusCode = -1;
		List<Map<String, Object>> lmList = null;
		try {
		
			lmList = manageOrgInfoService.alarmCencus(managerOrgID,startTime,endTime);
			statusCode = ConstValues.OK;
			
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(lmList, statusCode);
	}
	

}
