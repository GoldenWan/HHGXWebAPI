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

import com.hhgx.soft.entitys.Firesystype;
import com.hhgx.soft.entitys.Manoeuvre;
import com.hhgx.soft.entitys.Page;
import com.hhgx.soft.entitys.Training;
import com.hhgx.soft.services.FacilityService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.DateUtils;
import com.hhgx.soft.utils.GetRequestJsonUtils;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;

/**
 * 
 * 消防安全培训
 *
 */

@Controller
@RequestMapping(value = "/Facility")
public class FacilityController {

	@Autowired
	private FacilityService facilityService;
	
	/**
	 * 15.获取所有的消防系统
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/GetAllSys", method = RequestMethod.POST)
	public String getAllSys() throws IOException {
		List<Firesystype> list =null;
		int statusCode = -1;
		try {
			list = facilityService.getAllSys();
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(list, statusCode);

	}

	/**
	 * 160.获取消防安全培训情况【**】
	 * 
	 * @param reqBody
	 * @return
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/getTrainingList", method = RequestMethod.POST)
	public String getTrainingList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid", "startTime", "endTime", "PageIndex");
		String orgid = map.get("orgid");
		String startDate = map.get("startTime");
		String endDate = map.get("endTime");
		String pageIndex = map.get("pageIndex");
		Timestamp startTime= null;
		Timestamp endTime = null;
		
		if(!StringUtils.isEmpty(startDate)){
			startTime=DateUtils.stringToTimestamp(startDate," 00:00:00");
		}
		if(!StringUtils.isEmpty(endDate)){
			endTime=DateUtils.stringToTimestamp(endDate," 23:59:59");
		}

		
		Page page = null;
		List<Training> trainingList = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		int totalCount = facilityService.getTrainingListCount(orgid, startTime, endTime);
		int statusCode = -1;

		try {
			if (pageIndex != null) {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				trainingList = facilityService.getTrainingList(orgid, startTime, endTime, page.getStartPos(),
						page.getPageSize());

			} else {
				page = new Page(totalCount, 1);
				trainingList = facilityService.getTrainingList(orgid, startTime, endTime, page.getStartPos(),
						page.getPageSize());
			}

			for (Training training : trainingList) {				
				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("TrainingID",training.getTrainingID());
				map2.put("TrainingTime", DateUtils.formatDate(training.getTrainingTime(),null));
				map2.put("TrainingAddress", training.getTrainingAddress());
				map2.put("TrainingContent", training.getTrainingContent());
				map2.put("TrainingObject", training.getTrainingObject());
				map2.put("TrainingType", training.getTrainingType());
				map2.put("Lecturer", training.getLecturer());
				map2.put("HowmanyPeople", String.valueOf(training.getHowmanyPeople()));
				lmList.add(map2);
			}	
			statusCode = ConstValues.OK;

		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJsonArray1(lmList, statusCode, totalCount);

	}

	/**
	 * 163.获取消防安全培训详情【**】
	 * @throws IOException 
	 */

	@ResponseBody
	@RequestMapping(value = "/GetTraingingDetail", method = RequestMethod.POST)
	public String getTraingingDetail(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "TrainingID");
		String trainingID = map.get("trainingID");
		if(StringUtils.isEmpty(trainingID)){
			return ResponseJson.responseAddJson("TrainingID 为空", -256);
		}
		Map<String, String> map2 = new HashMap<String, String>();
		int statusCode = -1;
		try {
			Training training = facilityService.getTraingingDetail(trainingID);
			if (!StringUtils.isEmpty(training)) {
				
				map2.put("TrainingID", training.getTrainingID());
				map2.put("TrainingTime", DateUtils.formatToDate(DateUtils.formatDate(training.getTrainingTime(),null)));
				map2.put("TrainingAddress", training.getTrainingAddress());
				map2.put("TrainingType", training.getTrainingType());
				map2.put("HowmanyPeople", String.valueOf(training.getHowmanyPeople()));
				map2.put("Lecturer", training.getLecturer());
				map2.put("TrainingObject", training.getTrainingObject());
				map2.put("TrainingContent", training.getTrainingContent());
				map2.put("AttendPeople", training.getAttendPeople());
				map2.put("Examination", training.getExamination());
				map2.put("TrainingManager", training.getTrainingManager());
				map2.put("ContentFile", training.getContentFile());
				map2.put("examfile", training.getExamfile());
				map2.put("signtable", training.getSigntable());
				map2.put("orgid", training.getOrgid());

				statusCode = ConstValues.OK;
			} else {

				statusCode = ConstValues.OK;
			}
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(map2, statusCode);
	}

	/**
	 * 166.删除消防安全培训【**】
	 * @throws IOException 
	 * 
	 */

	@ResponseBody
	@RequestMapping(value = "/DeleteTraining", method = RequestMethod.POST)
	public String deleteTraining(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "TrainingID");
		String trainingID = map.get("trainingID");
		String dataBag = null;
		int statusCode = -1;
		try {
			if (!StringUtils.isEmpty(trainingID)) {
				facilityService.deleteTraining(trainingID);
				dataBag = "刪除成功";
				statusCode = ConstValues.OK;
			} else {
				dataBag = "刪除失败  trainingID为空";
				statusCode = ConstValues.FAILED;
			}
		} catch (Exception e) {
			e.printStackTrace();
			dataBag = "刪除失败";
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/***************************** 灭火应急预案 * * ****************************/

	/**
	 * 167.获取灭火应急演练列表【**】
	 * 
	 * @throws IOException
	 */

	@ResponseBody
	@RequestMapping(value = "/GetManoeuvreList", method = { RequestMethod.POST })
	public String getManoeuvreList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid", "PageIndex","startTime","endTime");
		String orgid = map.get("orgid");
		String pageIndex = map.get("pageIndex");
		String startTime_ = map.get("startTime");
		String endTime_ = map.get("endTime");
		Timestamp startTime= null;
		Timestamp endTime = null;
		
		if(!StringUtils.isEmpty(startTime_)){
			startTime=DateUtils.stringToTimestamp(startTime_," 00:00:00");
		}
		if(!StringUtils.isEmpty(endTime_)){
			endTime=DateUtils.stringToTimestamp(endTime_," 23:59:59");
		}

		Page page = null;
		List<Manoeuvre> manoeuvreList = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		int totalCount = facilityService.getManoeuvreCount(orgid,startTime,endTime);
		int statusCode = -1;
		if (StringUtils.isEmpty(orgid) || orgid.equals("null")) {
			return ResponseJson.responseAddJson("orgid 为空", statusCode);
		}

		try {
			if (pageIndex != null) {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				manoeuvreList = facilityService.getManoeuvreByOrgid(orgid,startTime,endTime, page.getStartPos(), page.getPageSize());

			} else {
				page = new Page(totalCount, 1);
				manoeuvreList = facilityService.getManoeuvreByOrgid(orgid,startTime,endTime, page.getStartPos(), page.getPageSize());
			}

			for (Manoeuvre manoeuvre : manoeuvreList) {

				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("manoeuvreID", manoeuvre.getManoeuvreID());
				map2.put("manoeuvretime", DateUtils.formatToDate(manoeuvre.getManoeuvretime()));
				map2.put("address", manoeuvre.getAddress());
				map2.put("Department", manoeuvre.getDepartment());
				map2.put("manager", manoeuvre.getManager());
				map2.put("content", manoeuvre.getContent());
				map2.put("orgid", orgid);
				lmList.add(map2);
			}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJsonArray1(lmList, statusCode, totalCount);

	}

	/**
	 * 169.获取灭火应急演练详情【**】
	 * @throws IOException 
	 */

	@ResponseBody
	@RequestMapping(value = "/GetManoeuvreDetail", method = RequestMethod.POST)
	public String getManoeuvreDetail(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "manoeuvreID");
		String manoeuvreID = map.get("manoeuvreID");

		Map<String, String> map2 = new HashMap<String, String>();
		int statusCode = -1;
		try {
			Manoeuvre manoeuvreDetail = facilityService.getManoeuvreDetail(manoeuvreID);
			if (!StringUtils.isEmpty(manoeuvreDetail)) {

				map2.put("manoeuvreID", manoeuvreDetail.getManoeuvreID());
				map2.put("manoeuvretime", manoeuvreDetail.getManoeuvretime());
				map2.put("address", manoeuvreDetail.getAddress());
				map2.put("Department", manoeuvreDetail.getDepartment());
				map2.put("content", manoeuvreDetail.getContent());
				map2.put("manager", manoeuvreDetail.getManager());
				map2.put("scheme", manoeuvreDetail.getScheme());
				map2.put("attendperson", manoeuvreDetail.getAttendperson());
				map2.put("implementation", manoeuvreDetail.getImplementation());
				map2.put("summary", manoeuvreDetail.getSummary());
				map2.put("suggestion", manoeuvreDetail.getSuggestion());
				map2.put("schemafile", manoeuvreDetail.getSchemafile());
				map2.put("attendpersonfile", manoeuvreDetail.getAttendpersonfile());
				map2.put("implementationfile", manoeuvreDetail.getImplementationfile());
				map2.put("orgid", manoeuvreDetail.getOrgid());
				statusCode = ConstValues.OK;
			} else {

				statusCode = ConstValues.OK;
			}
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJson(map2, statusCode);
	}

	
}
