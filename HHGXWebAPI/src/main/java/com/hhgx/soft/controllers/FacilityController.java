package com.hhgx.soft.controllers;

import java.util.ArrayList;
import java.util.HashMap;
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
import com.hhgx.soft.entitys.Page;
import com.hhgx.soft.entitys.Training;
import com.hhgx.soft.services.FacilityService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;

@Controller
@RequestMapping(value="/Facility")
public class FacilityController {

	@Autowired
	private FacilityService facilityService; 
	
	/**
	 * 160.获取消防安全培训情况【**】
	 * @param reqBody
	 * @return
	 * @throws JsonProcessingException
	 */
	@ResponseBody
	@RequestMapping(value = "/getTrainingList", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String getTrainingList(@RequestBody String reqBody) throws JsonProcessingException {

		Map<String, String> map = RequestJson.reqJson(reqBody, "orgid", "startTime", "endTime", "PageIndex");
		String orgid = map.get("orgid");
		String startTime = map.get("startTime");
		String endTime = map.get("endTime");
		String pageIndex = map.get("pageIndex");

		Page page = null;
		List<Training> trainingList = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		int totalCount = facilityService.getTrainingListCount(orgid);
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
			statusCode = ConstValues.OK;

			for (Training training : trainingList) {
				
				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("TrainingTime ", training.getTrainingTime());
				map2.put("TrainingAddress",training.getTrainingAddress());
				map2.put("TrainingContent", training.getTrainingContent());
				map2.put("TrainingObject", training.getTrainingObject());
				map2.put("TrainingType ", training.getTrainingType());
				map2.put("Lecturer ", training.getLecturer());
				map2.put("HowmanyPeople", String.valueOf(training.getHowmanyPeople()));
				lmList.add(map2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJson(lmList, statusCode, totalCount);

	}
	/**
	 * 166.删除消防安全培训【**】

	 */
	
	@ResponseBody
	@RequestMapping(value = "/DeleteTraining", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String deleteTraining(@RequestBody String reqBody) throws JsonProcessingException {

		Map<String, String> map = RequestJson.reqJson(reqBody, "TrainingID");
		String trainingID = map.get("trainingID");
		String dataBag = null;
		int statusCode = -1;
		try {
			if(!StringUtils.isEmpty(trainingID)){
				facilityService.deleteTraining(trainingID);
				dataBag = "刪除成功";
				statusCode = ConstValues.OK;
			}else {
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

	
}
