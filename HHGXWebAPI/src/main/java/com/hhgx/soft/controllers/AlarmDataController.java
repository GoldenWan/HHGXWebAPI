package com.hhgx.soft.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hhgx.soft.entitys.FireAlarm;
import com.hhgx.soft.entitys.Page;
import com.hhgx.soft.services.AlarmDataService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.GetRequestJsonUtils;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;

@Controller
@RequestMapping(value="/AlarmData")
public class AlarmDataController {
	@Autowired
	private AlarmDataService alarmDataService ;
	
	/*******************************远程监控******************************/
	/**
	  10.获取报警信息【**】【分页】
	 * @throws IOException 
	 */
	
	@ResponseBody
	@RequestMapping(value = "/FireAlarm", method = {
			RequestMethod.POST })
	public String fireAlarm(HttpServletRequest request) throws IOException {
	String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
			
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid","cAlarmtype", "PageIndex");
		String orgid = map.get("orgid");
		String pageIndex = map.get("pageIndex");
		String cAlarmtype = map.get("cAlarmtype");
	    
		int statusCode = -1;
		Page page = null;
		List<FireAlarm> fireAlarmList = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		
		int totalCount = alarmDataService.getfireAlarmCount(orgid, cAlarmtype);
		try {
			if (StringUtils.isEmpty(pageIndex) ) {
				page = new Page(totalCount, 1);
				fireAlarmList = alarmDataService.findFireAlarm(orgid, cAlarmtype, page.getStartPos(), page.getPageSize());
			} else {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				fireAlarmList = alarmDataService.findFireAlarm(orgid, cAlarmtype, page.getStartPos(), page.getPageSize());
			}
			statusCode = ConstValues.OK;
			for (FireAlarm fireAlarm : fireAlarmList) {
				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("Firealarmid",fireAlarm.getFirealarmid());
				map2.put("CAlarmype",fireAlarm.getcAlarmype());
				map2.put("orgname",fireAlarm.getOrgname());
				map2.put("vSysdesc",fireAlarm.getvSysdesc());
				map2.put("DeviceTypeName",fireAlarm.getDeviceTypeName());
				map2.put("sitename",fireAlarm.getSitename());
				map2.put("floornum",fireAlarm.getFloornum());
				map2.put("location",fireAlarm.getLocation());
				map2.put("faultdesc",fireAlarm.getFaultdesc());
				map2.put("GateWayAddress",fireAlarm.getGateWayAddress());
				map2.put("sysaddress",fireAlarm.getSysaddress());
				map2.put("deviceaddress",fireAlarm.getDeviceaddress());
				map2.put("dFirstAlarmtime",fireAlarm.getdFirstAlarmtime());
				map2.put("AlarmNum",fireAlarm.getAlarmNum());
				map2.put("dRecentAlarmtime",fireAlarm.getdRecentAlarmtime());
		
				lmList.add(map2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		
		return ResponseJson.responseFindPageJson(lmList, statusCode, totalCount);
		
	}
	
	/**
	 * 124.警情处理【**】
	 */
	/**@ResponseBody
	@RequestMapping(value="/FireDetail", method = {
			RequestMethod.POST })
	public String fireDetail(HttpServletRequest request){
	//	Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "Firealarmid","username", "checkresult", "checkdesc", "YnRequest");

		
		return "";
		
	}*/
	/**
	 *188.警情未处理详情【**】
	 */
	/**@ResponseBody
	@RequestMapping(value="/FireUnDealInfo", method = {
			RequestMethod.POST })
	public String fireUnDealInfo(HttpServletRequest request){
		//Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "Firealarmid");

		
		return "";
		
	}*/
	
}
