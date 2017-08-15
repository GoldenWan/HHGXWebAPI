package com.hhgx.soft.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.hhgx.soft.entitys.Manoeuvre;
import com.hhgx.soft.entitys.Page;
import com.hhgx.soft.services.AlarmDataService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;

@Controller
@RequestMapping(value="/AlarmData")
public class AlarmDataController {
	private AlarmDataService alarmDataService ;
	
	/*******************************远程监控******************************/
	/**
	  10.获取报警信息【**】【分页】
	 */
	
	@ResponseBody
	@RequestMapping(value = "/FireAlarm", method = {
			RequestMethod.POST }, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String fireAlarm(@RequestBody String reqBody) throws JsonProcessingException {
		Map<String, String> map = RequestJson.reqJson(reqBody, "orgid","cAlarmtype", "PageIndex");
		String orgid = map.get("orgid");
		String pageIndex = map.get("pageIndex");
		String cAlarmtype = map.get("cAlarmtype");

		Page page = null;
		List<Manoeuvre> manoeuvreList = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		//int totalCount = alarmDataService.getfireAlarmCount(orgid, cAlarmtype);
		int statusCode = -1;

		try {
			if (pageIndex != null) {
			///	page = new Page(totalCount, Integer.parseInt(pageIndex));
			//	manoeuvreList = alarmDataService.fireAlarm(orgid, cAlarmtype, page.getStartPos(), page.getPageSize());

			} else {
			//	page = new Page(totalCount, 1);
			//	manoeuvreList = alarmDataService.fireAlarm(orgid, cAlarmtype, page.getStartPos(), page.getPageSize());
			}
			statusCode = ConstValues.OK;

			for (Manoeuvre manoeuvre : manoeuvreList) {

				Map<String, String> map2 = new HashMap<String, String>();
				/*map2.put("manoeuvreID",manoeuvre.getManoeuvreID());
				map2.put("manoeuvretime",manoeuvre.getManoeuvretime());
				map2.put("address",manoeuvre.getAddress());
				map2.put("Department",manoeuvre.getDepartment());
				map2.put("manager",manoeuvre.getManager());
				map2.put("content",manoeuvre.getContent());*/
				lmList.add(map2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		//return ResponseJson.responseFindPageJson(lmList, statusCode, totalCount);
return null;
		
	}
	
	/**
	 * 124.警情处理【**】
	 */
	@ResponseBody
	@RequestMapping(value="/FireDetail", method = {
			RequestMethod.POST }, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String fireDetail(@RequestBody String reqBody){
		Map<String, String> map = RequestJson.reqJson(reqBody, "Firealarmid","username", "checkresult", "checkdesc", "YnRequest");

		
		return reqBody;
		
	}
	/**
	 *188.警情未处理详情【**】
	 */
	@ResponseBody
	@RequestMapping(value="/FireUnDealInfo", method = {
			RequestMethod.POST }, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String fireUnDealInfo(@RequestBody String reqBody){
		Map<String, String> map = RequestJson.reqJson(reqBody, "Firealarmid");

		
		return reqBody;
		
	}
	
}
