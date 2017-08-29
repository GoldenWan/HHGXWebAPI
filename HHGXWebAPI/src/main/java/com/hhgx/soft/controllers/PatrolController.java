package com.hhgx.soft.controllers;

import java.io.File;
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

import com.hhgx.soft.entitys.FireSafetyCheck;
import com.hhgx.soft.entitys.OnlineFiresystem;
import com.hhgx.soft.entitys.Page;
import com.hhgx.soft.entitys.PatrolDetail;
import com.hhgx.soft.entitys.PatrolProject;
import com.hhgx.soft.entitys.PatrolRecord;
import com.hhgx.soft.entitys.PatrolTotal;
import com.hhgx.soft.entitys.UserCheckPic;
import com.hhgx.soft.entitys.UserCheckProjectContent;
import com.hhgx.soft.services.PatrolService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.DateUtils;
import com.hhgx.soft.utils.GetRequestJsonUtils;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;
import com.hhgx.soft.utils.UUIDGenerator;
import com.hhgx.soft.utils.UploadUtil;

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

	/*************** 每日防火巡查 ***********************/
	/**
	 * 11.获取防火单位的巡查总体情况
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/GetPatrolTotal", method = RequestMethod.POST)
	public String getPatrolTotal(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "ManagerOrgID", "StartDate", "EndDate", "PageIndex");
		String managerOrgID = map.get("managerOrgID");
		String startDate = map.get("startDate");
		String endDate = map.get("endDate");
		String pageIndex = map.get("pageIndex");

		Page page = null;
		List<PatrolTotal> patrolTotalList = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		int totalCount = patrolService.getPatrolTotalCount(managerOrgID);
		int statusCode = -1;

		try {
			if (pageIndex != null) {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				patrolTotalList = patrolService.getPatrolTotal(managerOrgID, startDate, endDate, page.getStartPos(),
						page.getPageSize());

			} else {
				page = new Page(totalCount, 1);
				patrolTotalList = patrolService.getPatrolTotal(managerOrgID, startDate, endDate, page.getStartPos(),
						page.getPageSize());
			}
			for (PatrolTotal patrolTotal : patrolTotalList) {
				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("orgid",patrolTotal.getOrgid());
				map2.put("orgname",patrolTotal.getOrgname());
				map2.put("PlanPatrolNum",patrolTotal.getPlanPatrolNum());
				map2.put("RealPatrolNum",patrolTotal.getRealPatrolNum());
				map2.put("PatrolRatio",patrolTotal.getPatrolRatio());
				map2.put("PlanProjectNum",patrolTotal.getPlanProjectNum());
				map2.put("RealProjectNum",patrolTotal.getRealProjectNum());
				map2.put("ProjectRatio",patrolTotal.getProjectRatio());
				map2.put("NormalNum",patrolTotal.getNormalNum());
				map2.put("NormalRatio", patrolTotal.getNormalRatio());
				lmList.add(map2);
			}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJsonArray(lmList, statusCode, totalCount);

	}
	
	

	/**
	 * 12.按防火单位获取巡查记录【**】 
	 
	 * @param reqBody
	 *            ?*
	 * @return:TODO ?
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/GetPatrolRecordByOrg", method = RequestMethod.POST)
	public String getPatrolRecordByOrg(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "OrgID", "StartDate", "EndDate", "PageIndex");
		String orgID = map.get("orgID");
		String startDate = map.get("startDate");
		String endDate = map.get("endDate");
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
		List<PatrolRecord> patrolRecordList = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		int totalCount = patrolService.gePatrolRecordByOrgCount(orgID,startTime,endTime);
		int statusCode = -1;		
		String submitFlag = null;

		try {
			if (pageIndex != null) {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				patrolRecordList = patrolService.getPatrolRecordByOrg(orgID,startTime,endTime, page.getStartPos(),
						page.getPageSize());

			} else {
				page = new Page(totalCount, 1);
				patrolRecordList = patrolService.getPatrolRecordByOrg(orgID, startTime,endTime, page.getStartPos(),
						page.getPageSize());
			}
			statusCode = ConstValues.OK;
			for (PatrolRecord patrolRecord : patrolRecordList) {
				String submitStatet = patrolRecord.getSubmitStatet();
				if (!StringUtils.isEmpty(submitStatet) && submitStatet.equals("已提交"))
					submitFlag = "true";
				else {
					submitFlag = "false";
				}

				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("UserCheckId", patrolRecord.getUserCheckId());
				map2.put("UserCheckTime", DateUtils.formatDateTime(patrolRecord.getUserCheckTime()));
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
		return ResponseJson.responseFindPageJsonArray1(lmList, statusCode, totalCount);

	}
/**
 * 13.按巡查记录编号查询巡查记录详情
 * @throws IOException 
 */
	@ResponseBody
	@RequestMapping(value = "/GetPatrolDetail", method = RequestMethod.POST)
	public String getPatrolDetail(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "UserCheckId");
		String userCheckId = map.get("userCheckId");
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();

		int statusCode = -1;
		try {
			List<PatrolDetail> patrolDetails = patrolService.getPatrolDetail(userCheckId);
			for(PatrolDetail patrolDetail: patrolDetails){
				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("UserCheckId",patrolDetail.getUserCheckId());
				map2.put("projectid",patrolDetail.getProjectid());
				map2.put("vSysdesc",patrolDetail.getvSysdesc());
				map2.put("ProjectContent",patrolDetail.getProjectContent());
				map2.put("UserCheckResult",patrolDetail.getUserCheckResult());
				map2.put("FaultShow",patrolDetail.getFaultShow());
				map2.put("YnHanding",patrolDetail.getYnHanding());
				map2.put("Handingimmediately",patrolDetail.getHandingimmediately());
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
	 * 14.按巡查记录编号查询巡查图片
	 * @throws IOException 
	 */
	
	@ResponseBody
	@RequestMapping(value = "/GetPatrolPic", method = RequestMethod.POST)
	public String getPatrolPic(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "UserCheckId");
		String userCheckId = map.get("userCheckId");
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		
		int statusCode = -1;
		try {
			List<UserCheckPic> userCheckPics = patrolService.getPatrolPic(userCheckId);
			for(UserCheckPic userCheckPic: userCheckPics){
				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("PicID", userCheckPic.getPicID());
				map2.put("PicType", userCheckPic.getPicType());
				map2.put("PicPath", userCheckPic.getPicPath());
				map2.put("UploadTime", DateUtils.formatToDateTime(userCheckPic.getUploadTime()));
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
	 * 16.按防火单位获取应该巡查的项目/获取所有巡查项目
	 * @throws IOException 
	 */

	@ResponseBody
	@RequestMapping(value = "/GetPatrolProject", method = RequestMethod.POST)
	public String getPatrolProject(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid");
		String orgid = map.get("orgid");
		List<PatrolProject> patrolProjectList = null;
		int statusCode = -1;
		List<Map<String, Object>> lists = new ArrayList<Map<String, Object>>();
		try {
			patrolProjectList = patrolService.getPatrolProject(orgid);
			
			Map<String, Object>  jsonObject = new HashMap<String, Object>();
			
			for (PatrolProject patrolProject : patrolProjectList) {
				jsonObject.put("tiSysType", patrolProject.getTiSysType());
				jsonObject.put("vSysdesc", patrolProject.getvSysdesc());
				
				List<Map<String, String>> list = new ArrayList<Map<String, String>>();
				for (UserCheckProjectContent userCheckProjectContent : patrolProject.getUserCheckProjectContentList()) {
					Map<String, String> map2 = new HashMap<String, String>();
					map2.put("ProjectId", userCheckProjectContent.getProjectId());
					map2.put("ProjectContent", userCheckProjectContent.getProjectContent());
					list.add(map2);
				}
				jsonObject.put("Contents", list);
				lists.add(jsonObject);
				System.out.println(lists);
			}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(lists, statusCode);
	}
	/**
	 * 
	 * 19.添加防火单位的系统
	 * @throws IOException 
	 */
	
	@ResponseBody
	@RequestMapping(value = "/AddorgSys", method = {
			RequestMethod.POST })
	public String addorgSys(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map =  RequestJson.reqOriginJson(reqBody, "infoBag");

		String siteid = map.get("siteid");
		String tiSysType = map.get("tiSysType");
		String states = map.get("states");
		String ynOnline = map.get("ynOnline");
		String remarks = map.get("remarks");

		int statusCode = -1;
		String dataBag =null;
		try{
			OnlineFiresystem onlineFiresystem = new OnlineFiresystem();
			onlineFiresystem.setStates(states);
			onlineFiresystem.setYnOnline(ynOnline);
			onlineFiresystem.setRemarks(remarks);
			onlineFiresystem.setSiteid(siteid);
			onlineFiresystem.setTiSysType(tiSysType);
			patrolService.addorgSys(onlineFiresystem);
			statusCode = ConstValues.OK;
			dataBag = "添加成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "添加失败";
		}
			return ResponseJson.responseAddJson(dataBag, statusCode);
			
		
	}
	
	
	
	
	
	/**
	 * 119.删除巡查记录【**】 【说明：使用了级联删除，但需要代码删除与之相关的巡查照片】
	 * @throws IOException 
	 */

	@ResponseBody
	@RequestMapping(value = "/DeleteCheckRecord", method = RequestMethod.POST)
	public String deleteCheckRecord(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "UserCheckId");
		String userCheckId = map.get("userCheckId");
		String dataBag = null;
		int statusCode = -1;
		try {
			List<String> picPath= patrolService.findUserCheckpic(userCheckId);
			
			for(String picPathName : picPath){
				picPathName.substring( picPathName.lastIndexOf(File.separatorChar) + 1);
				String str[] = picPathName.split("/");
				String paperFileName=str[3]+File.separatorChar;
				UploadUtil.deleteOneFileOrDirectory(request, str[4], "CheckRecord/"+paperFileName);
			}
			
			patrolService.deleteUserCheckpic(userCheckId);
			patrolService.deleteWBdevicerepairinfo_patrol(userCheckId);
			patrolService.deleteUserCheckinfo(userCheckId);
			patrolService.deleteUserCheckList(userCheckId);
			
			
			statusCode = ConstValues.OK;
			dataBag = "刪除成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "刪除失败";
		}
		
			return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 * 126.新增巡查记录【**】
	 * 【说明：新增巡查记录，并按防火单位查找UserCheckContent表获得巡查内容编号，再相应插入UserCheckInfo表】
	 * @throws IOException 
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/AddUserCheckList", method = RequestMethod.POST)
	public String addUserCheckList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "OrgID", "UserCheckTime", "OrgUser", "OrgManagerId");
		String orgID = map.get("orgID");
		String userCheckTime = map.get("userCheckTime");
		String orgUser = map.get("orgUser");
		String orgManagerId = map.get("orgManagerId");
		String userCheckId = UUIDGenerator.getUUID();
		String dataBag = null;
		int statusCode = -1;
		String submitTime = DateUtils.timesstampToString();
		try {

			patrolService.addUserCheckList(userCheckId, orgID, userCheckTime, orgUser, orgManagerId, submitTime);
			patrolService.addUserCheckInfoByOrgid(userCheckId, orgID);
			statusCode = ConstValues.OK;
			dataBag = "插入成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "插入失败";
		}
			return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 * 127.修改巡查记录【**】
	 * @throws IOException 
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/UpdateUserCheckList", method = RequestMethod.POST)
	public String updateUserCheckList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "UserCheckId", "UserCheckTime");
		String userCheckId = map.get("userCheckId");
		String userCheckTime = map.get("userCheckTime");
		String dataBag = null;
		int statusCode = -1;
		try {
			patrolService.updateUserCheckList(userCheckId, userCheckTime);
			statusCode = ConstValues.OK;
			dataBag = "修改成功";
		} catch (Exception e) {
			statusCode = ConstValues.FAILED;
			dataBag = "修改失败";
		}
			return ResponseJson.responseAddJson(dataBag, statusCode);
	}

	/**
	 * 157.检查并修改巡查记录状态【**】 【所用表：巡查情况UserCheckInfo，巡查记录UerCheckList】
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/UpdateSubmitState", method = RequestMethod.POST)
	public String updateSubmitState(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "UserCheckId");
		String userCheckId = map.get("UserCheckId");
		String submitState = "已提交";
		boolean flag = false;
		Map<String, String> result = new HashMap<String, String>();

		try {

			if (!patrolService.findNullUserCheckInfo(userCheckId)) {
				patrolService.updateSubmitState(userCheckId, submitState);
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			flag = false;
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

	/*************** 防火检查 ***********************/
	/**
	 * 116.防火检查记录列表信息【**】【分页】
	 * 
	 * @param reqBody
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value = "/FireSafetyCheckList", method = {
			RequestMethod.POST })
	@ResponseBody
	public String fireSafetyCheckList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid", "StartTime", "EndTime", "PageIndex");
		String orgid = map.get("orgid");
		String startTime = map.get("startTime");
		String endTime = map.get("endTime");
		String pageIndex = map.get("pageIndex");

		Page page = null;
		List<FireSafetyCheck> FireSafetyCheckList = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		int totalCount = patrolService.fireSafetyCheckCount(orgid, startTime, endTime);
		System.err.println(totalCount);
		int statusCode = -1;

		try {
			if (pageIndex != null) {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				FireSafetyCheckList = patrolService.getfireSafetyCheckByOrgid(orgid, startTime, endTime,
						page.getStartPos(), page.getPageSize());

			} else {
				page = new Page(totalCount, 1);
				FireSafetyCheckList = patrolService.getfireSafetyCheckByOrgid(orgid, startTime, endTime,
						page.getStartPos(), page.getPageSize());
			}
			statusCode = ConstValues.OK;

			System.out.println(FireSafetyCheckList.size());
			for (FireSafetyCheck fireSafetyCheck : FireSafetyCheckList) {

				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("FireSafetyCheckID", fireSafetyCheck.getFireSafetyCheckID());
				map2.put("CheckTime	", fireSafetyCheck.getCheckTime().toString());
				map2.put("checkposite", fireSafetyCheck.getCheckposite());
				map2.put("Department", fireSafetyCheck.getDepartment());
				map2.put("Problem", fireSafetyCheck.getProblem());
				map2.put("handing ", fireSafetyCheck.getHanding());
				map2.put("attendperson ", fireSafetyCheck.getAttendperson());
				map2.put("CheckedDepartment", fireSafetyCheck.getCheckedDepartment());
				map2.put("RecordMan", fireSafetyCheck.getRecordMan());
				map2.put("SafetyMan", fireSafetyCheck.getSafetyMan());
				lmList.add(map2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJsonArray1(lmList, statusCode, totalCount);

	}

	/**
	 * 115.防火检查记录详情【**】
	 */

	/**
	 * @param reqBody
	 * @return
	 * @throws JsonProcessingException:TODO
	 
	 * @throws IOException */
	@ResponseBody
	@RequestMapping(value = "/FireSafetyCheckDetail", method = RequestMethod.POST)
	public String fireSafetyCheckDetail(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "FireSafetyCheckID");
		String fireSafetyCheckID = map.get("fireSafetyCheckID");

		Map<String, String> map2 = new HashMap<String, String>();
		int statusCode = -1;
		try {
			FireSafetyCheck fireSafetyCheck = patrolService.fireSafetyCheckDetail(fireSafetyCheckID);
			map2.put("FireSafetyCheckID", fireSafetyCheck.getFireSafetyCheckID());
			map2.put("CheckTime", fireSafetyCheck.getCheckTime());
			map2.put("checkposite", fireSafetyCheck.getCheckposite());
			map2.put("Department", fireSafetyCheck.getDepartment());
			map2.put("Problem", fireSafetyCheck.getProblem());
			map2.put("handing", fireSafetyCheck.getHanding());
			map2.put("attendperson", fireSafetyCheck.getAttendperson());
			map2.put("CheckedDepartment", fireSafetyCheck.getCheckedDepartment());
			map2.put("RecordMan", fireSafetyCheck.getRecordMan());
			map2.put("SafetyMan", fireSafetyCheck.getSafetyMan());
			map2.put("orgid", fireSafetyCheck.getOrgid());
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJson(map2, statusCode);
	}

	/**
	 * 117.编辑防火检查记录【**】
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/EditFireSafetyCheck", method = RequestMethod.POST)
	public String editFireSafetyCheck(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid", "FireSafetyCheckID", "checkposite",
				"Department", "Problem", "handing", "attendperson", "CheckedDepartment", "RecordMan", "SafetyMan");
		String orgid = map.get("orgid");
		String fireSafetyCheckID = map.get("fireSafetyCheckID");
		String checkTime = DateUtils.timesstampToString();
		String checkposite = map.get("checkposite");
		String department = map.get("department");
		String problem = map.get("problem");
		String handing = map.get("handing");
		String attendperson = map.get("attendperson");
		String checkedDepartment = map.get("checkedDepartment");
		String recordMan = map.get("recordMan");
		String safetyMan = map.get("safetyMan");
		FireSafetyCheck fireSafetyCheck = new FireSafetyCheck();
		fireSafetyCheck.setOrgid(orgid);
		fireSafetyCheck.setFireSafetyCheckID(fireSafetyCheckID);
		System.out.println(checkTime);
		fireSafetyCheck.setCheckTime(checkTime);
		fireSafetyCheck.setCheckposite(checkposite);
		fireSafetyCheck.setDepartment(department);
		fireSafetyCheck.setProblem(problem);
		fireSafetyCheck.setHanding(handing);
		fireSafetyCheck.setAttendperson(attendperson);
		fireSafetyCheck.setCheckedDepartment(checkedDepartment);
		fireSafetyCheck.setRecordMan(recordMan);
		fireSafetyCheck.setSafetyMan(safetyMan);
		int statusCode = -1;
		String dataBag = null;
		try {
			patrolService.editFireSafetyCheck(fireSafetyCheck);
			dataBag = "修改成功";
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			dataBag = "修改失败";
			statusCode = ConstValues.FAILED;
		}

		return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 * 118.新增防火检查记录【**】
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/AddFireSafetyCheck", method = RequestMethod.POST)
	public String addFireSafetyCheck(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid", "checkposite", "Department", "Problem",
				"handing", "attendperson", "CheckedDepartment", "RecordMan", "SafetyMan");
		String orgid = map.get("orgid");
		String fireSafetyCheckID = UUIDGenerator.getUUID();
		String checkTime = DateUtils.timesstampToString();
		String checkposite = map.get("checkposite");
		String department = map.get("department");
		String problem = map.get("problem");
		String handing = map.get("handing");
		String attendperson = map.get("attendperson");
		String checkedDepartment = map.get("checkedDepartment");
		String recordMan = map.get("recordMan");
		String safetyMan = map.get("safetyMan");
		FireSafetyCheck fireSafetyCheck = new FireSafetyCheck();
		fireSafetyCheck.setOrgid(orgid);
		fireSafetyCheck.setFireSafetyCheckID(fireSafetyCheckID);
		System.out.println(checkTime);
		fireSafetyCheck.setCheckTime(checkTime);
		fireSafetyCheck.setCheckposite(checkposite);
		fireSafetyCheck.setDepartment(department);
		fireSafetyCheck.setProblem(problem);
		fireSafetyCheck.setHanding(handing);
		fireSafetyCheck.setAttendperson(attendperson);
		fireSafetyCheck.setCheckedDepartment(checkedDepartment);
		fireSafetyCheck.setRecordMan(recordMan);
		fireSafetyCheck.setSafetyMan(safetyMan);
		int statusCode = -1;
		String dataBag = null;
		try {
			patrolService.addFireSafetyCheck(fireSafetyCheck);
			dataBag = "添加成功";
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			dataBag = "添加失败";
			statusCode = ConstValues.FAILED;
		}

		return ResponseJson.responseAddJson(dataBag, statusCode);
	}

	/**
	 * 137.删除防火检查记录【**】
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/DeleteFireSafetyCheck", method = RequestMethod.POST)
	public String deleteFireSafetyCheck(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid", "FireSafetyCheckID");
		String orgid = map.get("orgid");
		String fireSafetyCheckID = map.get("fireSafetyCheckID");

		int statusCode = -1;
		String dataBag = null;
		try {
			// （后端判断没有检查编号即删除所有该防火单位检查记录）
			if (patrolService.findFireSafetyCheckID(fireSafetyCheckID)) {
				patrolService.deleteFireSafetyCheck(fireSafetyCheckID);
			} else {
				patrolService.deleteFireSafetyCheckByOrgid(orgid);
			}
			dataBag = "删除成功";
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			dataBag = "删除失败";
			statusCode = ConstValues.FAILED;
		}

		return ResponseJson.responseAddJson(dataBag, statusCode);
	}
	
	/**
	 * 114.每日巡查记录表查询
	 * 
	 * {"tokenUUID":"6e2cda35-2a40-4c44-8b3a-d8d3817e9a6d",
	 * "infoBag":{"UserCheckId":"f810d79a-ee81-4272-a1ea-f41ca7e6c9f4","siteid":"all"}}:
	 */
	
	
}
