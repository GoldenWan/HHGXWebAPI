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
import com.hhgx.soft.services.OrginfoService;
import com.hhgx.soft.services.PlayWithRoleService;
import com.hhgx.soft.services.UsersService;
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
	private AlarmDataService alarmDataService;
	@Autowired
	private OrginfoService orginfoService;
	@Autowired
	private PlayWithRoleService playWithRoleService;
	@Autowired
	private UsersService usersService;

	/**
	 * 174.删除灭火应急演练预案【**】
	 * 
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
	@ResponseBody
	@RequestMapping(value = "/PersonInfo/GetPeopleType", method = RequestMethod.POST)
	public String getPeopleType() throws IOException {
		
		List<Map<String, String>> list=null;
		int statusCode = -1;
		try {
			list = usersService.getPeopleType();
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(list, statusCode);
	}
	@ResponseBody
	@RequestMapping(value = "/PersonInfo/PeopleDetail", method = RequestMethod.POST)
	public String peopleDetail(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "PeopleNo");
		String peopleNo = map.get("peopleNo");
		List<Map<String, String>> list=null;
		int statusCode = -1;
		try {
			list = usersService.peopleDetail(peopleNo);
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(list, statusCode);
	}
	@ResponseBody
	@RequestMapping(value = "/PersonInfo/SelectPeople", method = RequestMethod.POST)
	public String selectPeople(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid", "peopleType","peopleName","PageIndex");
		String orgid = map.get("orgid");
		String peopleType = map.get("peopleType");
		String peopleName = map.get("peopleName");
		String pageIndex = map.get("pageIndex");
		
		List<Map<String, String>> list=null;
		Page page = null;
		int statusCode = -1;
			
			int totalCount = usersService.selectPeopleCount(orgid, peopleType, peopleName);
			try {
				if (StringUtils.isEmpty(orgid) || orgid.equals("null")) {
					statusCode = ConstValues.FAILED;
					return ResponseJson.responseAddJson("orgid为空", statusCode);
				}
				if (StringUtils.isEmpty(pageIndex) || pageIndex.equals("null")) {
					page = new Page(totalCount, 1);
					list = usersService.selectPeople(orgid, peopleType, peopleName, page.getStartPos(),
							page.getPageSize());
					
				} else {
					page = new Page(totalCount, Integer.parseInt(pageIndex));
					list = usersService.selectPeople(orgid, peopleType, peopleName, page.getStartPos(),
							page.getPageSize());
				}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJsonArray(list, statusCode, totalCount);
	}

	/**
	 * 185.获取报警处理记录列表
	 */

	@ResponseBody
	@RequestMapping(value = "/OrgControl/GetAlarmDataList", method = { RequestMethod.POST })
	public String getAlarmDataList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid", "cAlarmtype", "startTime", "endTime",
				"pageIndex");
		String orgid = map.get("orgid");
		String pageIndex = map.get("pageIndex");
		String cAlarmtype = map.get("cAlarmtype");
		String startDate = map.get("startTime");
		String endDate = map.get("endTime");

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

		int totalCount = alarmDataService.getAlarmDataListCount(orgid, cAlarmtype, startTime, endTime);
		try {
			if (StringUtils.isEmpty(orgid) || orgid.equals("null")) {
				statusCode = ConstValues.FAILED;
				return ResponseJson.responseAddJson("orgid为空", statusCode);
			}
			if (StringUtils.isEmpty(pageIndex) || pageIndex.equals("null")) {
				page = new Page(totalCount, 1);
				lmList = alarmDataService.getAlarmDataList(orgid, cAlarmtype, startTime, endTime, page.getStartPos(),
						page.getPageSize());
			} else {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				lmList = alarmDataService.getAlarmDataList(orgid, cAlarmtype, startTime, endTime, page.getStartPos(),
						page.getPageSize());
			}
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}

		if (lmList.size() < 1) {
			return ResponseJson.responseAddJson("无报警处理记录", 1000);
		}

		statusCode = ConstValues.OK;

		return ResponseJson.responseFindPageJsonArray(lmList, statusCode, totalCount);

	}

	@ResponseBody
	@RequestMapping(value = "/OrgInfo/GetOrgSummary", method = RequestMethod.POST)
	public String getOrgSummary(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid");
		String orgid = map.get("orgid");
		Map<String, String> map2 = null;
		int statusCode = -1;
		try {
			map2 = orginfoService.getOrgSummary(orgid);
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJson(map2, statusCode);
	}

	/**
	 * 编辑单位简介 orgid":"510108000001","vIntroduceText":"
	 */
	@ResponseBody
	@RequestMapping(value = "/OrgInfo/EditOrgSummary", method = RequestMethod.POST)
	public String editOrgSummary(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqOriginJson(reqBody, "vIntroduceText", "orgid");
		String vIntroduceText = map.get("vIntroduceText");
		String orgid = map.get("orgid");
		int statusCode = -1;
		String dataBag = null;
		try {
			if (orginfoService.existOrgSummary(orgid)) {

				orginfoService.updateOrgSummary(vIntroduceText, orgid);
			} else {
				orginfoService.editOrgSummary(vIntroduceText, orgid);

			}
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
	 * 5. 查询某消防管理部门的下级管理部门【分页】
	 * 
	 * @param reqBody
	 * @return
	 * @throws IOException
	 */

	@RequestMapping(value = "/playwithrole/GetManagersSubs", method = { RequestMethod.POST })
	@ResponseBody
	public String getManagersSubs(HttpServletRequest request) throws IOException {

		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "MID", "managerorgname", "PageIndex");
		String mid = map.get("mID");
		String managerorgname = map.get("managerorgname");// 模糊查询
		String pageIndex = map.get("pageIndex");
		Page page = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		int totalCount = playWithRoleService.getManagersSubsCount(mid, managerorgname);
		int statusCode = -1;
		try {
			if (pageIndex != null) {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				// 模糊查询
				lmList = playWithRoleService.getManagersSubs(mid, managerorgname, page.getStartPos(),
						page.getPageSize());

			} else {
				page = new Page(totalCount, 1);
				lmList = playWithRoleService.getManagersSubs(mid, managerorgname, page.getStartPos(),
						page.getPageSize());
			}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJsonArray(lmList, statusCode, totalCount);

	}
	
	@ResponseBody
	@RequestMapping(value = "/PersonInfo/UpdatePassword", method = RequestMethod.POST)
	public String updatePassword(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "newPassword","password","UserID");
		
		
		String newPassword = map.get("newPassword");
		String password = map.get("password");
		String userid = map.get("userID");
		
		int statusCode = -1;
		String dataBag=null;
		try {
			if(!usersService.isCorrectPwd(userid,password)){
		
				dataBag="原密码不正确，请重新输入";
				statusCode=-2;
				return ResponseJson.responseAddJson(dataBag, statusCode);
			}
		    dataBag="修改成功";
		    usersService.updatePassword(userid,newPassword);
			statusCode = ConstValues.OK;
			
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);
	}
	
}
