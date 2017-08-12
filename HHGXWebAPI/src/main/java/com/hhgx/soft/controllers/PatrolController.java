


package com.hhgx.soft.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.hhgx.soft.entitys.Page;
import com.hhgx.soft.entitys.PatrolRecord;
import com.hhgx.soft.services.PatrolService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.DateUtils;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;
import com.hhgx.soft.utils.UUIDGenerator;

import net.sf.json.JSONObject;

/**
 * 消防工作记录
 * 
 * @author win
 *
 */

@Controller
@RequestMapping(value = "/Patrol")
public class PatrolController {

	@Autowired
	private PatrolService patrolService;

	/**
	 * 12.按防火单位获取巡查记录【**】 【说明：SubmitFlag根据SubmitStatet设定， 若SubmitStatet为“已提交”
	 * 则SubmitFlag为true,否则为false】 ?* @param reqBody ?* @return:TODO ?
	 * 
	 * @throws JsonProcessingException
	 */
	@ResponseBody
	@RequestMapping(value = "/GetPatrolRecordByOrg", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String getPatrolRecordByOrg(@RequestBody String reqBody) throws JsonProcessingException {

		Map<String, String> map = RequestJson.reqJson(reqBody, "OrgID", "StartDate", "EndDate", "PageIndex");
		String orgID = map.get("orgID");
		String startDate = map.get("startDate");
		String endDate = map.get("endDate");
		String pageIndex = map.get("pageIndex");

		Page page = null;
		List<PatrolRecord> patrolRecordList = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		int totalCount = patrolService.gePatrolRecordByOrgCount(orgID);
		int statusCode = -1;

		try {
			if (pageIndex != null) {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				patrolRecordList = patrolService.getPatrolRecordByOrg(orgID, startDate, endDate, page.getStartPos(),
						page.getPageSize());

			} else {
				page = new Page(totalCount, 1);
				patrolRecordList = patrolService.getPatrolRecordByOrg(orgID, startDate, endDate, page.getStartPos(),
						page.getPageSize());
			}
			statusCode = ConstValues.OK;
			
			System.out.println(patrolRecordList.size());
			for(PatrolRecord patrolRecord:patrolRecordList){
			String submitStatet=patrolRecord.getSubmitStatet();
			String submitFlag=null;
			if(submitStatet.equals("已提交"))
				submitFlag ="true";
			else {
				submitFlag="false";
			}
			
			Map<String, String> map2 = new HashMap<String, String>();
			map2.put("UserCheckId", patrolRecord.getUserCheckId());
			map2.put("UserCheckTime",patrolRecord.getUserCheckTime().toString());
			map2.put("OrgUser", patrolRecord.getOrgUser());
			map2.put("OrgManager", patrolRecord.getOrgManager());
			map2.put("SubmitTime", patrolRecord.getSubmitTime().toString());
			map2.put("Remarks", patrolRecord.getRemarks());
			map2.put("UserCheckResult", patrolRecord.getUserCheckResult());
			map2.put("SubmitStatet", patrolRecord.getSubmitStatet());
			map2.put("SubmitFlag", submitFlag);
			lmList.add(map2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJson(lmList, statusCode, totalCount);

	}


	
	/**
	 * 119.删除巡查记录【**】 【说明：使用了级联删除，但需要代码删除与之相关的巡查照片】
	 * @throws JsonProcessingException 
	 */

	@ResponseBody
	@RequestMapping(value = "/DeleteCheckRecord", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String deleteCheckRecord(@RequestBody String reqBody) throws JsonProcessingException {

		Map<String, String> map = RequestJson.reqJson(reqBody, "UserCheckId");
		String userCheckId = map.get("userCheckId");
		String dataBag =null; 
		int statusCode =-1;
		try {
			patrolService.deleteCheckRecord(userCheckId);
			statusCode =ConstValues.OK;
		} catch (Exception e) {
			statusCode =ConstValues.FAILED;
		}
		if (statusCode==ConstValues.OK) {
			dataBag = "刪除成功";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		} else {
			dataBag ="刪除失败";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		}
		
		
	}

	/**
	 * 126.新增巡查记录【**】
	 * 【说明：新增巡查记录，并按防火单位查找UserCheckContent表获得巡查内容编号，再相应插入UserCheckInfo表】
	 * @throws JsonProcessingException 
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/AddUserCheckList", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String addUserCheckList(@RequestBody String reqBody) throws JsonProcessingException {

		Map<String, String> map = RequestJson.reqJson(reqBody, "OrgID", "UserCheckTime", "OrgUser", "OrgManagerId");
		String orgID = map.get("orgID");
		String userCheckTime = map.get("userCheckTime");
		String orgUser = map.get("orgUser");
		String orgManagerId = map.get("orgManagerId");
		String userCheckId = UUIDGenerator.getUUID();
		String dataBag =null; 
		int statusCode =-1;
		String submitTime=DateUtils.timesstampToString();
	try {

		patrolService.addUserCheckList(userCheckId,orgID,userCheckTime,orgUser,orgManagerId,submitTime);
		patrolService.addUserCheckInfoByOrgid(userCheckId,orgID);
		statusCode =ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode =ConstValues.FAILED;
		}
		if (statusCode==ConstValues.OK) {
			dataBag = "插入成功";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		} else {
			dataBag ="插入失败";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		}
		
	}
	
	

	/**
	 * 127.修改巡查记录【**】
	 * @throws JsonProcessingException 
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/UpdateUserCheckList", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String updateUserCheckList(@RequestBody String reqBody) throws JsonProcessingException {
		Map<String, String> map = RequestJson.reqJson(reqBody, "UserCheckId", "UserCheckTime");
		String userCheckId = map.get("userCheckId");
		String userCheckTime= map.get("userCheckTime");
		String dataBag =null; 
		int statusCode =-1;
		try {
		patrolService.updateUserCheckList(userCheckId,userCheckTime);
		statusCode =ConstValues.OK;
	} catch (Exception e) {
		statusCode =ConstValues.FAILED;
	}
	if (statusCode==ConstValues.OK) {
		dataBag = "修改成功";
		return ResponseJson.responseAddJson(dataBag, statusCode);
	} else {
		dataBag ="修改失败";
		return ResponseJson.responseAddJson(dataBag, statusCode);
	}
	}


	/**
	 *157.检查并修改巡查记录状态【**】
	 *【所用表：巡查情况UserCheckInfo，巡查记录UerCheckList】
	 * @throws JsonProcessingException 
	 */
	@ResponseBody
	@RequestMapping(value = "/UpdateSubmitState", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String updateSubmitState(@RequestBody String reqBody) throws JsonProcessingException {
		Map<String, String> map = RequestJson.reqJson(reqBody, "UserCheckId");
		String userCheckId = map.get("UserCheckId");
		String submitState = "已提交";
		boolean flag =false;
	   Map<String,String> result =new HashMap<String,String>();		

		try {
			
			if(!patrolService.findNullUserCheckInfo(userCheckId)){
				patrolService.updateSubmitState(userCheckId,submitState);
				flag =true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			flag=false;
		}
		if (flag) {
			result.put("DataTag", "提交成功");
			result.put("flag", String.valueOf(flag));
			return JSONObject.fromBean(result).toString();
			
		} else {
			result.put("DataTag", "提交失败");
			result.put("flag", String.valueOf(flag));
			return JSONObject.fromBean(result).toString();
		}
	}

	
	
	

}