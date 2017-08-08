package com.hhgx.soft.controllers;

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
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;


@Controller
@RequestMapping(value = "/Patrol")
public class PatrolController {
	
	
	@Autowired
	private PatrolService patrolService;
	
	/**
	 *12.按防火单位获取巡查记录【**】
	 * 【说明：SubmitFlag根据SubmitStatet设定，若SubmitStatet为“已提交”则SubmitFlag为true,否则为false】
	 * @param reqBody
	 * @return:TODO
	 
	 */
	@ResponseBody
	@RequestMapping( value="/GetPatrolRecordByOrg", method =RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String  getPatrolRecordByOrg(@RequestBody String reqBody){
		  
		Map<String, String> map = RequestJson.reqJson(reqBody, "OrgID", "StartDate", "EndDate", "PageIndex");
		String orgID = map.get("OrgID");
		String startDate =map.get("StartDate");
		String endDate = map.get("EndDate");
		String pageIndex =map.get("PageIndex");
		
		Page page = null;  
		List<PatrolRecord> patrolRecordList =null;
		String dataBag = null;
		int statusCode = 0;
		String result = null;
		//pageCount==totalCount
		int pageCount = (int) patrolService.gePatrolRecordByOrgCount(orgID, startDate, endDate);
		if (pageIndex != null) {  
		//@Param(value="startPos") Integer startPos,@Param(value="pageSize") 
	        page = new Page(pageCount, Integer.parseInt(pageIndex));  
	          patrolRecordList =  patrolService.getPatrolRecordByOrg(orgID, startDate, endDate,page.getStartPos(), page.getPageSize());
	    } else {  
	        page = new Page(pageCount, 1);  
	        patrolRecordList =  patrolService.getPatrolRecordByOrg(orgID, startDate, endDate, page.getStartPos(), page.getPageSize());
	    } 
		
		
		try {
			result = ResponseJson.responseFindPageJson(patrolRecordList, 1000, pageCount);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return result;
	}

	/**
	 * 17.添加巡查记录
	 */
	
	@ResponseBody
	@RequestMapping( value="/AddPatrolRecord", method =RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String  addPatrolRecord(@RequestBody String reqBody){
	
		Map<String, String> map = RequestJson.reqJson(reqBody, "OrgID", "UserCheckTime", "OrgUser");
		String orgID = map.get("OrgID");
		String userCheckTime =map.get("UserCheckTime");
		String orgUser = map.get("OrgUser");
		
		
		return null;
	}
	/**
	 *16.按防火单位获取应该巡查的项目
	 */
	
	@ResponseBody
	@RequestMapping( value="/GetPatrolProject", method =RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String  getPatrolProject(@RequestBody String reqBody){
		
		Map<String, String> map = RequestJson.reqJson(reqBody, "orgid");
		String orgID = map.get("orgid");
		
		
		return null;
	}
	/**
	 *114.每日巡查记录表查询
	 */
	
	@ResponseBody
	@RequestMapping( value="/GetCheckRecord", method =RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String  GetCheckRecord(@RequestBody String reqBody){
		
		Map<String, String> map = RequestJson.reqJson(reqBody, "UserCheckId");
		String userCheckId = map.get("UserCheckId");
		
		
		return null;
	}
	
	/**
	119.删除巡查记录【**】
	【说明：使用了级联删除，但需要代码删除与之相关的巡查照片】
	 */
	
	@ResponseBody
	@RequestMapping( value="/DeleteCheckRecord", method =RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String  deleteCheckRecord(@RequestBody String reqBody){
		
		Map<String, String> map = RequestJson.reqJson(reqBody, "UserCheckId");
		String userCheckId = map.get("UserCheckId");
		
		
		return null;
	}
	/**126.新增巡查记录【**】
	 * 【说明：新增巡查记录，并按防火单位查找UserCheckContent表获得巡查内容编号，再相应插入UserCheckInfo表】
	 * 
	 */
	@ResponseBody
	@RequestMapping( value="/AddUserCheckList", method =RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String addUserCheckList(@RequestBody String reqBody){
		
		Map<String, String> map = RequestJson.reqJson(reqBody, "OrgID","UserCheckTime","OrgUser","OrgManagerId");
		String orgID = map.get("OrgID");
		String userCheckTime = map.get("UserCheckTime");
		String orgUser = map.get("OrgUser");
		String orgManagerId = map.get("OrgManagerId");
	
		return null;
	}
	/**127.修改巡查记录【**】
	 * 
	 */
	@ResponseBody
	@RequestMapping( value="/UpdateUserCheckList", method =RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String updateUserCheckList(@RequestBody String reqBody){
		Map<String, String> map = RequestJson.reqJson(reqBody, "UserCheckId","UserCheckTime");
		String userCheckId = map.get("UserCheckId");
		String userCheckTime = map.get("UserCheckTime");
		
		return null;
	}
	/**
	 * 
	 * 157.检查并修改巡查记录状态【**】
	 */
	
	@ResponseBody
	@RequestMapping( value="/UpdateSubmitState ", method =RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String UpdateSubmitState (@RequestBody String reqBody){
		Map<String, String> map = RequestJson.reqJson(reqBody, "UserCheckId");
		String userCheckId = map.get("UserCheckId");
		
		return null;
	}
	/**
	 * 116.防火检查记录列表信息【**】【分页】
	 */
	@ResponseBody
	@RequestMapping( value="/FireSafetyCheckList ", method =RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String fireSafetyCheckList(@RequestBody String reqBody){
		Map<String, String> map = RequestJson.reqJson(reqBody, "orgid","StartTime","EndTime","PageIndex");
		String userCheckId = map.get("orgid");
		String startTime = map.get("StartTime");
		String endTime = map.get("EndTime");
		String pageIndex = map.get("PageIndex");
		
		return null;
	}
	
	/**
	 * 116.防火检查记录列表信息【**】【分页】
	 */
	@ResponseBody
	@RequestMapping( value="/FireSafetyCheckDetail ", method =RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String fireSafetyCheckDetail(@RequestBody String reqBody){
		Map<String, String> map = RequestJson.reqJson(reqBody, "FireSafetyCheckID");
		String fireSafetyCheckID = map.get("FireSafetyCheckID");
		
		return null;
	}
	
	/**
	 * 117.编辑防火检查记录【**】
	 */
	
	@ResponseBody
	@RequestMapping( value="/EditFireSafetyCheck ", method =RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String editFireSafetyCheck(@RequestBody String reqBody){
		Map<String, String> map = RequestJson.reqJson(reqBody, "orgid","FireSafetyCheckID","CheckTime","checkposite", "Department","Problem","handing","attendperson","CheckedDepartment","RecordMan","SafetyMan");
		String orgid = map.get("orgid");
		return null;
	}
	
}
