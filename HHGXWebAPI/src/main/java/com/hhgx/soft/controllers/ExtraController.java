package com.hhgx.soft.controllers;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
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
import com.hhgx.soft.services.AlarmDataService;
import com.hhgx.soft.services.ExtraService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.DateUtils;
import com.hhgx.soft.utils.GetRequestJsonUtils;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;

@Controller
public class ExtraController {
	@Autowired 
	private ExtraService extraService;
	@Autowired
	private AlarmDataService alarmDataService ;
	/**
	 * 174.删除灭火应急演练预案【**】
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/Faclity/DeleteManoeuvre", method = RequestMethod.POST)
	public String deleteManoeuvre(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "manoeuvreID");
		String manoeuvreID = map.get("manoeuvreID");
		String dataBag = null;
		int statusCode = -1;
		try {
			extraService.deleteManoeuvre(manoeuvreID);
			statusCode = ConstValues.OK;
			dataBag = ConstValues.SUCCESSDEL;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = ConstValues.FIALUREDEL;
		}
	   return ResponseJson.responseAddJson(dataBag, statusCode);
	}

	/**
	 * 185.获取报警处理记录列表
	 */
	
	@ResponseBody
	@RequestMapping(value = "/OrgControl/GetAlarmDataList", method = {
			RequestMethod.POST })
	public String getAlarmDataList(HttpServletRequest request) throws IOException {
			String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
			
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid","cAlarmtype","startTime","endTime","pageIndex");
		String orgid = map.get("orgid");
		String pageIndex = map.get("pageIndex");
		String cAlarmtype = map.get("cAlarmtype");
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
		Page page = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		
		int totalCount = alarmDataService.getAlarmDataListCount(orgid, cAlarmtype,startTime,endTime);
		try {
			if(StringUtils.isEmpty(orgid)|| orgid.equals("null")){
				statusCode = ConstValues.FAILED;
				return  ResponseJson.responseAddJson("orgid为空", statusCode);
			}
			if (StringUtils.isEmpty(pageIndex)|| pageIndex.equals("null")) {
				page = new Page(totalCount, 1);
				lmList = alarmDataService.getAlarmDataList(orgid, cAlarmtype,startTime,endTime, page.getStartPos(), page.getPageSize());
			} else {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				lmList = alarmDataService.getAlarmDataList(orgid, cAlarmtype,startTime,endTime, page.getStartPos(), page.getPageSize());
			}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		
		return ResponseJson.responseFindPageJsonArray(lmList, statusCode, totalCount);
		
	}
	
	
}
