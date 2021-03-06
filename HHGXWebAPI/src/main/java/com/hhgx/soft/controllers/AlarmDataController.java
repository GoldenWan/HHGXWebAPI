package com.hhgx.soft.controllers;

import java.io.IOException;
import java.sql.Timestamp;
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

import com.hhgx.soft.entitys.FireDealInfo;
import com.hhgx.soft.entitys.Page;
import com.hhgx.soft.services.AlarmDataService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.DateUtils;
import com.hhgx.soft.utils.GetRequestJsonUtils;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;

@Controller
@RequestMapping(value = "/AlarmData")
public class AlarmDataController {
	@Autowired
	private AlarmDataService alarmDataService;

	/******************************* 远程监控 ******************************/
	/**
	 * 10.获取报警信息【**】【分页】
	 * 
	 * @throws IOException
	 * 
	 *             {"tokenUUID":"6ec04b9ed0144ff58de3605da4010157", "infoBag":
	 *             {"orgid":"null","cAlarmtype":"火警","StartTime":"","EndTime":""
	 *             ,"PageIndex":null,"siteid":null}}:
	 */

	@ResponseBody
	@RequestMapping(value = "/FireAlarm", method = { RequestMethod.POST })
	public String fireAlarm(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid", "cAlarmtype", "StartTime", "EndTime",
				"PageIndex", "siteid");
		String orgid = map.get("orgid");
		String pageIndex = map.get("pageIndex");
		String cAlarmtype = map.get("cAlarmtype");

		String startDate = map.get("startTime");
		String endDate = map.get("endTime");
		String siteid = map.get("siteid");

		Timestamp startTime = null;
		Timestamp endTime = null;

		if (!StringUtils.isEmpty(startDate)) {
			startTime = DateUtils.stringToTimestamp(startDate, " 00:00:00");
		}
		if (!StringUtils.isEmpty(endDate)) {
			endTime = DateUtils.stringToTimestamp(endDate, " 23:59:59");
		}

		int statusCode = -1;
		Page page = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();

		int totalCount = alarmDataService.getfireAlarmCount(orgid, cAlarmtype, siteid, startTime, endTime);
		try {
			if (StringUtils.isEmpty(orgid) || orgid.equals("null")) {
				statusCode = ConstValues.FAILED;
				return ResponseJson.responseAddJson("orgid为空", statusCode);
			}
			if (StringUtils.isEmpty(pageIndex) || pageIndex.equals("null")) {
				page = new Page(totalCount, 1);
				lmList = alarmDataService.findFireAlarm(orgid, cAlarmtype, siteid, startTime, endTime,
						page.getStartPos(), page.getPageSize());
			} else {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				lmList = alarmDataService.findFireAlarm(orgid, cAlarmtype, siteid, startTime, endTime,
						page.getStartPos(), page.getPageSize());
			}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}

		return ResponseJson.responseFindPageJsonArray(lmList, statusCode, totalCount);

	}

	/**
	 * 120.警情处理详情 /AlarmData/FireDealInfo
	 */
	@ResponseBody
	@RequestMapping(value = "/FireDealInfo", method = { RequestMethod.POST })
	public String fireDealInfo(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "Firealarmid");
		String firealarmid = map.get("firealarmid");
		int statusCode = -1;
		List<Map<String, Object>> lmList = new ArrayList<>();
		List<FireDealInfo> fireDealInfos = null;
		try {
			fireDealInfos = alarmDataService.fireDealInfo(firealarmid);
			for (FireDealInfo fireDealInfo : fireDealInfos) {
				Map<String, Object> map2 = new HashMap<String, Object>();
				map2.put("orgname", fireDealInfo.getOrgname());
				map2.put("DeviceTypeName", fireDealInfo.getDeviceTypeName());
				map2.put("sitename", fireDealInfo.getSitename());
				map2.put("Gatewayaddress", fireDealInfo.getGatewayaddress());
				map2.put("deviceaddress", fireDealInfo.getDeviceaddress());
				map2.put("idevicetype", fireDealInfo.getIdevicetype());
				map2.put("StateValue", fireDealInfo.getStateValue());
				map2.put("location", fireDealInfo.getLocation());
				map2.put("fPositionX", fireDealInfo.getfPositionX());
				map2.put("fPositionY", fireDealInfo.getfPositionY());
				map2.put("DeviceNo", fireDealInfo.getDeviceNo());
				map2.put("dFirstAlarmtime", DateUtils.formatToDateTime(fireDealInfo.getdFirstAlarmtime()));
				map2.put("AlarmNum", fireDealInfo.getAlarmNum());
				map2.put("dRecentAlarmtime", DateUtils.formatToDateTime(fireDealInfo.getdRecentAlarmtime()));
				map2.put("vSysdesc", fireDealInfo.getvSysdesc());
				map2.put("systypeID", fireDealInfo.getSystypeID());
				map2.put("sysaddress", fireDealInfo.getSysaddress());
				map2.put("dReceivetime", DateUtils.formatToDateTime(fireDealInfo.getdRecentAlarmtime()));
				map2.put("vAlarmsource", fireDealInfo.getvAlarmsource());
				map2.put("floornum", fireDealInfo.getFloornum());
				map2.put("vfireroomtel", fireDealInfo.getVfireroomtel());
				map2.put("imFlatPic", fireDealInfo.getImFlatPic());
				map2.put("bFlatpic", fireDealInfo.getbFlatpic());
				map2.put("fLongitude", fireDealInfo.getfLongitude());
				map2.put("fLatitude", fireDealInfo.getfLatitude());
				map2.put("ynRequest", fireDealInfo.getfLatitude());
				map2.put("chulidate", fireDealInfo.getfLatitude());
				map2.put("chuliren", fireDealInfo.getfLatitude());
				map2.put("checkdesc", fireDealInfo.getfLatitude());
				map2.put("checkresult", fireDealInfo.getfLatitude());
				map2.put("Picpath", fireDealInfo.getPicpaths());

				lmList.add(map2);
			}

			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(lmList, statusCode);

	}

	/**
	 * 124.警情处理【**】
	 * 
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value = "/FireDetail", method = { RequestMethod.POST })
	public String fireDetail(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "Firealarmid", "username", "checkresult",
				"checkdesc", "YnRequest");
		String firealarmid = map.get("firealarmid");
		String username = map.get("username");
		String checkdesc = map.get("checkdesc");
		String checkresult = map.get("checkresult");
		String ynRequest = map.get("ynRequest");

		int statusCode = -1;
		String dataBag = null;

		if (StringUtils.isEmpty(firealarmid)) {

			return ResponseJson.responseAddJson("firealarmid 为空", -256);
		}
		try {
			// 先删除 一条记录eventinfo
			// 后增加一条记录dao alarmdata
			alarmDataService.fireDetail(firealarmid, username, checkdesc, checkresult, ynRequest);
			statusCode = ConstValues.OK;
			dataBag = ConstValues.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();

		}

		return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 * 188.警情未处理详情【**】
	 */
	@ResponseBody
	@RequestMapping(value = "/FireUnDealInfo", method = { RequestMethod.POST })
	public String fireUnDealInfo(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "Firealarmid", "cAlarmtype");
		String firealarmid = map.get("firealarmid");
		String cAlarmtype = map.get("cAlarmtype");

		int statusCode = -1;
		List<Map<String, Object>> lmList = new ArrayList<>();
		List<FireDealInfo> fireDealInfos = null;
		try {

			fireDealInfos = alarmDataService.fireUnDealInfo(firealarmid, cAlarmtype);
			for (FireDealInfo fireDealInfo : fireDealInfos) {
				Map<String, Object> map2 = new HashMap<String, Object>();
				map2.put("orgname", fireDealInfo.getOrgname());
				map2.put("DeviceTypeName", fireDealInfo.getDeviceTypeName());
				map2.put("sitename", fireDealInfo.getSitename());
				map2.put("Gatewayaddress", fireDealInfo.getGatewayaddress());
				map2.put("deviceaddress", fireDealInfo.getDeviceaddress());
				map2.put("idevicetype", fireDealInfo.getIdevicetype());
				map2.put("StateValue", fireDealInfo.getStateValue());
				map2.put("location", fireDealInfo.getLocation());
				map2.put("fPositionX", fireDealInfo.getfPositionX());
				map2.put("fPositionY", fireDealInfo.getfPositionY());
				map2.put("DeviceNo", fireDealInfo.getDeviceNo());
				map2.put("dFirstAlarmtime", DateUtils.formatToDateTime(fireDealInfo.getdFirstAlarmtime()));
				map2.put("AlarmNum", fireDealInfo.getAlarmNum());
				map2.put("dRecentAlarmtime", DateUtils.formatToDateTime(fireDealInfo.getdRecentAlarmtime()));
				map2.put("vSysdesc", fireDealInfo.getvSysdesc());
				map2.put("systypeID", fireDealInfo.getSystypeID());
				map2.put("sysaddress", fireDealInfo.getSysaddress());
				map2.put("dReceivetime", DateUtils.formatToDateTime(fireDealInfo.getdRecentAlarmtime()));
				map2.put("vAlarmsource", fireDealInfo.getvAlarmsource());
				map2.put("floornum", fireDealInfo.getFloornum());
				map2.put("vfireroomtel", fireDealInfo.getVfireroomtel());
				map2.put("imFlatPic", fireDealInfo.getImFlatPic());
				map2.put("bFlatpic", fireDealInfo.getbFlatpic());
				map2.put("fLongitude", fireDealInfo.getfLongitude());
				map2.put("fLatitude", fireDealInfo.getfLatitude());
				map2.put("Picpath", fireDealInfo.getPicpaths());
				lmList.add(map2);
			}

			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}

		return ResponseJson.responseFindJsonArray(lmList, statusCode);
	}

	/**
	 * 203. 最新一条火警/故障平面图
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value = "/RecentAlarmInfo", method = { RequestMethod.POST })
	public String recentAlarmInfo(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid", "cAlarmtype");
		String orgid = map.get("orgid");
		String cAlarmtype = map.get("cAlarmtype");

		int statusCode = -1;
		if (StringUtils.isEmpty(orgid) || orgid.equals("null")) {
			statusCode = ConstValues.FAILED;
			return ResponseJson.responseAddJson("orgid为空", statusCode);
		}
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		
		if(lmList.size()<1){
			return ResponseJson.responseAddJson("无最新火警情况", 1000);
		}
		try {

			lmList = alarmDataService.findRecentAlarmInfo(orgid, cAlarmtype);
			statusCode = ConstValues.OK;

		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}

		return ResponseJson.responseFindJsonArray(lmList, statusCode);

	}

}
