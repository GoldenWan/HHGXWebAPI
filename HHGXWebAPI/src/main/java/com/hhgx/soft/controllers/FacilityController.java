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

import com.hhgx.soft.entitys.FireDevice;
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
	 * 
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value = "/GetAllSys", method = RequestMethod.POST)
	public String getAllSys() throws IOException {
		List<Firesystype> list = null;
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
	 *    
	 */
	@ResponseBody
	@RequestMapping(value = "/AddFireDevice", method = RequestMethod.POST)
	public String addFireDevice(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqOriginJson(reqBody, "devicename", "Manufacture", "model",
				"productDate", "validate", "SetupDate", "SetLocation", "siteid", "iDeviceType", "memo");
		String devicename = map.get("devicename");
		String manufacture = map.get("Manufacture");
		String model = map.get("model");
		String productDate = map.get("productDate");
		String validate = map.get("validate");
		String setupDate = map.get("SetupDate");
		String setLocation = map.get("SetLocation");
		String siteid = map.get("siteid");
		String iDeviceType = map.get("iDeviceType");
		String memo = map.get("memo");
		String dataBag = null;
		int statusCode = -1;
		try {
			FireDevice fireDevice = new FireDevice();
			// 1101010000 0100000003
			// 数据库字段30-》34yyyyMMddHHmmss
			fireDevice.setDeviceNo(siteid + DateUtils.formatDateToString("yyyyMMddHHmmss"));
			fireDevice.setDevicename(devicename);

			fireDevice.setiDeviceType(iDeviceType);
			fireDevice.setManufacture(manufacture);
			fireDevice.setMemo(memo);
			fireDevice.setModel(model);
			if(null != productDate && !StringUtils.isEmpty(productDate) )
			fireDevice.setProductDate(DateUtils.formatToDate(productDate));
			if(null != setupDate && !StringUtils.isEmpty(setupDate) )
			fireDevice.setSetupDate(DateUtils.formatToDate(setupDate));
			if(null != validate && !StringUtils.isEmpty(validate) )
			fireDevice.setValidate(DateUtils.formatToDate(validate));
			fireDevice.setSiteid(siteid);
			fireDevice.setSetLocation(setLocation);
			facilityService.addFireDevice(fireDevice);

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
	 * 74.删除消防设备信息
	 */
	@ResponseBody
	@RequestMapping(value = "/DeleteFireDeviceList", method = RequestMethod.POST)
	public String deleteFireDeviceList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "deviceNo");
		String deviceNo = map.get("deviceNo");
		String dataBag = null;
		int statusCode = -1;
		try {
			facilityService.delFireDeviceChangeRecord(deviceNo);
			facilityService.deleteFireDeviceList(deviceNo);
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
	 * 40.修改消防设备信息
	 * 
	 */

	@ResponseBody
	@RequestMapping(value = "/UpdateFireDevice", method = RequestMethod.POST)
	public String updateFireDevice(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqOriginJson(reqBody, "deviceNo", "devicename", "Manufacture", "model",
				"productDate", "validate", "SetupDate", "SetLocation", "siteid", "iDeviceType", "memo");
		String deviceNo = map.get("deviceNo");// 设备传输地址
		String devicename = map.get("devicename");
		String manufacture = map.get("Manufacture");
		String model = map.get("model");
		String productDate = map.get("productDate");
		String validate = map.get("validate");
		String setupDate = map.get("SetupDate");
		String setLocation = map.get("SetLocation");
		String siteid = map.get("siteid");
		String iDeviceType = map.get("iDeviceType");
		String memo = map.get("memo");
		String dataBag = null;
		int statusCode = -1;
		try {
			FireDevice fireDevice = new FireDevice();
			fireDevice.setDevicename(devicename);
			fireDevice.setDeviceNo(deviceNo);
			fireDevice.setiDeviceType(iDeviceType);
			fireDevice.setManufacture(manufacture);
			fireDevice.setMemo(memo);
			fireDevice.setModel(model);
			if(null != productDate && !StringUtils.isEmpty(productDate) )
			fireDevice.setProductDate(DateUtils.formatToDate(productDate));
			if(null != setupDate && !StringUtils.isEmpty(setupDate) )
			fireDevice.setSetupDate(DateUtils.formatToDate(setupDate));
			if(null != validate && !StringUtils.isEmpty(validate) )
			fireDevice.setValidate(DateUtils.formatToDate(validate));
			fireDevice.setSetLocation(setLocation);
			fireDevice.setSiteid(siteid);
			//先删除FireDeviceChangeRecord
			facilityService.deleteFireDeviceCheckRecord(deviceNo);
			facilityService.updateFireDevice(fireDevice);

			statusCode = ConstValues.OK;
			dataBag = "修改成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "修改失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 * 75.获取设备列表信息【分页】
	 * 
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/GetFireDeviceList", method = RequestMethod.POST)
	public String getFireDeviceList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid", "conditionName", "conditionValue",
				"PageIndex");
		String orgid = map.get("orgid");
		String conditionName = map.get("conditionName");
		String conditionValue = map.get("conditionValue");// 为空查所有
		String pageIndex = map.get("pageIndex");

		Page page = null;
		List<Map<String, Object>> list = null;
		List<Map<String, Object>> lists = new ArrayList<>();
		int statusCode = -1;

		if (conditionName.equals("vSysdesc")) {
			int pageCount = facilityService.getFireDeviceBySysCount(orgid, conditionValue);
			try {

				if (!StringUtils.isEmpty(pageIndex)) {
					page = new Page(pageCount, Integer.parseInt(pageIndex));
					list = facilityService.getFireDeviceListBySys(orgid, conditionValue, page.getStartPos(),
							page.getPageSize());

				} else {
					page = new Page(pageCount, 1);
					list = facilityService.getFireDeviceListBySys(orgid, conditionValue, page.getStartPos(),
							page.getPageSize());
				}
				for (Map<String, Object> m : list) {
					if (!StringUtils.isEmpty(m.get("productDate")))

						m.put("productDate", DateUtils.formatToDateTime(m.get("productDate").toString()));
					if (!StringUtils.isEmpty(m.get("validate")))

						m.put("validate", DateUtils.formatToDateTime(m.get("validate").toString()));
					if (!StringUtils.isEmpty(m.get("SetupDate")))

						m.put("SetupDate", DateUtils.formatToDateTime(m.get("SetupDate").toString()));
					lists.add(m);

				}
				statusCode = ConstValues.OK;
			} catch (Exception e) {
				e.printStackTrace();
				statusCode = ConstValues.FAILED;
			}

			return ResponseJson.responseFindPageJsonArray(lists, statusCode, pageCount);

		} else if (conditionName.equals("deviceNo")) {
			int pageCount = facilityService.getFireDeviceByDeviceCount(orgid, conditionValue);

			try {
				if (!StringUtils.isEmpty(pageIndex)) {
					page = new Page(pageCount, Integer.parseInt(pageIndex));
					list = facilityService.getFireDeviceListByDevice(orgid, conditionValue, page.getStartPos(),
							page.getPageSize());

				} else {
					page = new Page(pageCount, 1);
					list = facilityService.getFireDeviceListByDevice(orgid, conditionValue, page.getStartPos(),
							page.getPageSize());
				}

				for (Map<String, Object> m : list) {
					if (!StringUtils.isEmpty(m.get("productDate")))
						m.put("productDate", DateUtils.formatToDateTime(m.get("productDate").toString()));
					if (!StringUtils.isEmpty(m.get("validate")))
						m.put("validate", DateUtils.formatToDateTime(m.get("validate").toString()));
					if (!StringUtils.isEmpty(m.get("SetupDate")))
						m.put("SetupDate", DateUtils.formatToDateTime(m.get("SetupDate").toString()));
					lists.add(m);
				}
				statusCode = ConstValues.OK;
			} catch (Exception e) {
				e.printStackTrace();
				statusCode = ConstValues.FAILED;
			}
			return ResponseJson.responseFindPageJsonArray(lists, statusCode, pageCount);

		}
		return null;
	}

	/**
	 * 110.获取部件类型
	 */
	@ResponseBody
	@RequestMapping(value = "/GetFireDevice", method = RequestMethod.POST)
	public String getFireDevice(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "deviceNo");
		String deviceNo = map.get("deviceNo");

		List<Map<String, Object>> list = null;
		List<Map<String, Object>> lists = new ArrayList<>();
		int statusCode = -1;
		try {
			list = facilityService.getFireDeviceListByDeviceNo(deviceNo);

			for (Map<String, Object> m : list) {
				if (!StringUtils.isEmpty(m.get("productDate")))
					m.put("productDate", DateUtils.formatToDateTime(m.get("productDate").toString()));
				if (!StringUtils.isEmpty(m.get("validate")))
					m.put("validate", DateUtils.formatToDateTime(m.get("validate").toString()));
				if (!StringUtils.isEmpty(m.get("SetupDate")))
					m.put("SetupDate", DateUtils.formatToDateTime(m.get("SetupDate").toString()));
				lists.add(m);

			}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}

		return ResponseJson.responseFindJsonArray(lists, statusCode);
	}

	/**
	 * 111.获取消防设备信息
	 */
	@ResponseBody
	@RequestMapping(value = "/GetDeviceType", method = RequestMethod.POST)
	public String getDeviceType() throws IOException {
		List<Map<String, String>> list = null;
		int statusCode = -1;
		try {
			list = facilityService.getDeviceType();
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
		Timestamp startTime = null;
		Timestamp endTime = null;

		if (!StringUtils.isEmpty(startDate)) {
			startTime = DateUtils.stringToTimestamp(startDate, " 00:00:00");
		}
		if (!StringUtils.isEmpty(endDate)) {
			endTime = DateUtils.stringToTimestamp(endDate, " 23:59:59");
		}

		Page page = null;
		List<Training> trainingList = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		int totalCount = facilityService.getTrainingListCount(orgid, startTime, endTime);
		int statusCode = -1;

		try {
			if (!StringUtils.isEmpty(pageIndex)) {
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
				map2.put("TrainingID", training.getTrainingID());
				map2.put("TrainingTime", DateUtils.formatDate(training.getTrainingTime()));
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
		return ResponseJson.responseFindPageJsonArray(lmList, statusCode, totalCount);

	}

	/**
	 * 163.获取消防安全培训详情【**】
	 * 
	 * @throws IOException
	 */

	@ResponseBody
	@RequestMapping(value = "/GetTraingingDetail", method = RequestMethod.POST)
	public String getTraingingDetail(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "TrainingID");
		String trainingID = map.get("trainingID");
		if (StringUtils.isEmpty(trainingID)) {
			return ResponseJson.responseAddJson("TrainingID 为空", -256);
		}
		Map<String, String> map2 = new HashMap<String, String>();
		int statusCode = -1;
		try {
			Training training = facilityService.getTraingingDetail(trainingID);
			if (!StringUtils.isEmpty(training)) {

				map2.put("TrainingID", training.getTrainingID());
				map2.put("TrainingTime",
						DateUtils.formatToDate(DateUtils.formatDate(training.getTrainingTime())));
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
	 * 
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
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid", "PageIndex", "startTime", "endTime");
		String orgid = map.get("orgid");
		String pageIndex = map.get("pageIndex");
		String startTime_ = map.get("startTime");
		String endTime_ = map.get("endTime");
		Timestamp startTime = null;
		Timestamp endTime = null;

		if (!StringUtils.isEmpty(startTime_)) {
			startTime = DateUtils.stringToTimestamp(startTime_, " 00:00:00");
		}
		if (!StringUtils.isEmpty(endTime_)) {
			endTime = DateUtils.stringToTimestamp(endTime_, " 23:59:59");
		}

		Page page = null;
		List<Manoeuvre> manoeuvreList = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		int totalCount = facilityService.getManoeuvreCount(orgid, startTime, endTime);
		int statusCode = -1;
		if (StringUtils.isEmpty(orgid) || orgid.equals("null")) {
			return ResponseJson.responseAddJson("orgid 为空", statusCode);
		}

		try {
			if (!StringUtils.isEmpty(pageIndex)) {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				manoeuvreList = facilityService.getManoeuvreByOrgid(orgid, startTime, endTime, page.getStartPos(),
						page.getPageSize());

			} else {
				page = new Page(totalCount, 1);
				manoeuvreList = facilityService.getManoeuvreByOrgid(orgid, startTime, endTime, page.getStartPos(),
						page.getPageSize());
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
		return ResponseJson.responseFindPageJsonArray(lmList, statusCode, totalCount);

	}

	/**
	 * 169.获取灭火应急演练详情【**】
	 * 
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
