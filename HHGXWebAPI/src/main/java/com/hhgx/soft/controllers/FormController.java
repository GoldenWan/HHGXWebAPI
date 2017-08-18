package com.hhgx.soft.controllers;

import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.hhgx.soft.entitys.Manoeuvre;
import com.hhgx.soft.entitys.SafeDuty;
import com.hhgx.soft.entitys.SafeManageRules;
import com.hhgx.soft.entitys.Training;
import com.hhgx.soft.entitys.UserCheckInfo;
import com.hhgx.soft.entitys.UserCheckPic;
import com.hhgx.soft.services.FormService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.DateUtils;
import com.hhgx.soft.utils.ResponseJson;
import com.hhgx.soft.utils.UUIDGenerator;
import com.hhgx.soft.utils.UploadUtil;

@Controller
@RequestMapping(value = "/Form")
public class FormController {
	@Autowired
	private FormService formService;

	/**
	 * 129.巡查记录填写【**】
	 * 
	 * @return
	 * @throws JsonProcessingException
	 */

	@ResponseBody
	@RequestMapping(value = "/AddOrUpdateCheckRecord", method = {
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String addOrUpdateCheckRecord(HttpServletRequest request) throws JsonProcessingException {

		String userCheckId = request.getParameter("UserCheckId");
		System.out.println(userCheckId);
		String projectId = request.getParameter("ProjectId");
		System.out.println(projectId);
		int listNum = Integer.parseInt(request.getParameter("listNum"));
		System.out.println(listNum);
		String delList = request.getParameter("delList");
		String userCheckResult = request.getParameter("UserCheckResult");
		String faultShow = request.getParameter("FaultShow");
		String ynHanding = request.getParameter("YnHanding");
		String handingimmediately = request.getParameter("Handingimmediately");
		String dataBag = null;
		int statusCode = -1;
		try {
			UserCheckInfo userCheckInfo = new UserCheckInfo();
			userCheckInfo.setFaultShow(faultShow);
			userCheckInfo.setHandingimmediately(handingimmediately);
			userCheckInfo.setUserCheckId(userCheckId);
			userCheckInfo.setYnHanding(ynHanding);
			userCheckInfo.setProjectId(projectId);
			userCheckInfo.setUserCheckResult(userCheckResult);
			formService.addOrUpdateCheckRecord(userCheckInfo);
			// 先删除图片
			String[] picIDList = delList.split(",");
			for (int i = 0; i < picIDList.length; i++) {
				String picType = formService.findPicType(picIDList[i]);
				UploadUtil.deleteFileOrDirectory(request, picIDList[i] + "." + picType, userCheckId);
				formService.deletePicByID(picIDList[i]);
			}
			// 上传图片
			if (listNum > 0) {

				// 创建一个通用的多部分解析器
				CommonsMultipartResolver cmr = new CommonsMultipartResolver(request.getSession().getServletContext());
				// 设置编码
				cmr.setDefaultEncoding("utf-8");
				// 判断 request 是否有文件上传,即多部分请求
				if (cmr.isMultipart(request)) {
					MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest) (request);
					Iterator<String> files = mRequest.getFileNames();
					while (files.hasNext()) {
						MultipartFile mFile = mRequest.getFile(files.next());
						String picID = UUIDGenerator.getUUID();
						String picType = UploadUtil.getExtention(mFile.getOriginalFilename());
						String picPath = UploadUtil.uploadImg(request, mFile, picID + "." + picType, userCheckId);
						UserCheckPic userCheckPic = new UserCheckPic();
						userCheckPic.setPicID(picID);
						userCheckPic.setPicPath(picPath);
						userCheckPic.setProjectId(projectId);
						userCheckPic.setUploadTime(DateUtils.timesstampToString());
						userCheckPic.setUserCheckId(userCheckId);
						userCheckPic.setPicType(picType);
						formService.addUserCheckPic(userCheckPic);
					}

				}
			}
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
	 * 161.添加消防安全培训情况【**】
	 */
	@ResponseBody
	@RequestMapping(value = "/AddTraining", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String addTraining(HttpServletRequest request, @RequestParam("ContentFile") MultipartFile contentFile,
			@RequestParam("examfile") MultipartFile examfile, @RequestParam("signtable") MultipartFile signtable)
					throws JsonProcessingException {
		String trainingTime = request.getParameter("TrainingTime");
		String trainingAddress = request.getParameter("TrainingAddress");
		String trainingType = request.getParameter("TrainingType");
		int howmanyPeople = Integer.valueOf(request.getParameter("HowmanyPeople"));
		String lecturer = request.getParameter("Lecturer");
		String trainingObject = request.getParameter("TrainingObject");
		String trainingContent = request.getParameter("TrainingContent");
		String attendPeople = request.getParameter("AttendPeople");
		String examination = request.getParameter("Examination");
		String trainingManager = request.getParameter("TrainingManager");
		String orgid = request.getParameter("orgid");
		String dataBag = null;
		int statusCode = -1;
		try {
			Training training = new Training();
			String trainingID = UUIDGenerator.getUUID();
			training.setTrainingID(trainingID);
			training.setOrgid(orgid);
			training.setAttendPeople(attendPeople);
			training.setExamination(examination);
			training.setHowmanyPeople(howmanyPeople);
			training.setLecturer(lecturer);
			training.setTrainingAddress(trainingAddress);
			training.setTrainingManager(trainingManager);
			training.setTrainingTime(DateUtils.stringToTimestamp(trainingTime));
			training.setTrainingContent(trainingContent);
			training.setTrainingObject(trainingObject);
			training.setTrainingType(trainingType);

			String fName = contentFile.getOriginalFilename();
			String fName1 = examfile.getOriginalFilename();
			String fName2 = signtable.getOriginalFilename();

			String contentFile1 = UploadUtil.uploadFile(request, contentFile, fName, trainingID);
			String examfile1 = UploadUtil.uploadFile(request, examfile, fName1, trainingID);
			String signtable1 = UploadUtil.uploadFile(request, signtable, fName2, trainingID);
			training.setExamfile(examfile1);
			training.setContentFile(contentFile1);
			training.setSigntable(signtable1);
			formService.addTraining(training);
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
	 * 164.修改消防安全培训情况【**】
	 */
	@ResponseBody
	@RequestMapping(value = "/UpdateTraining", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String updateTraining(HttpServletRequest request, @RequestParam("ContentFile") MultipartFile contentFile,
			@RequestParam("examfile") MultipartFile examfile, @RequestParam("signtable") MultipartFile signtable)
					throws JsonProcessingException {
		String trainingID = request.getParameter("TrainingID");
		String trainingTime = request.getParameter("TrainingTime");
		String trainingAddress = request.getParameter("TrainingAddress");
		String trainingType = request.getParameter("TrainingType");
		int howmanyPeople = Integer.valueOf(request.getParameter("HowmanyPeople"));
		String lecturer = request.getParameter("Lecturer");
		String trainingObject = request.getParameter("TrainingObject");
		String trainingContent = request.getParameter("TrainingContent");
		String attendPeople = request.getParameter("AttendPeople");
		String examination = request.getParameter("Examination");
		String trainingManager = request.getParameter("TrainingManager");
		String orgid = request.getParameter("orgid");
		String dataBag = null;
		int statusCode = -1;
		try {
			Training training = new Training();
			training.setTrainingID(trainingID);
			training.setOrgid(orgid);
			training.setAttendPeople(attendPeople);
			training.setExamination(examination);
			training.setHowmanyPeople(howmanyPeople);
			training.setLecturer(lecturer);
			training.setTrainingAddress(trainingAddress);
			training.setTrainingManager(trainingManager);
			training.setTrainingTime(DateUtils.stringToTimestamp(trainingTime));
			training.setTrainingContent(trainingContent);
			training.setTrainingObject(trainingObject);
			training.setTrainingType(trainingType);

			String fName = contentFile.getOriginalFilename();
			String fName1 = examfile.getOriginalFilename();
			String fName2 = signtable.getOriginalFilename();

			String contentFile1 = UploadUtil.uploadFile(request, contentFile, fName, trainingID);
			String examfile1 = UploadUtil.uploadFile(request, examfile, fName1, trainingID);
			String signtable1 = UploadUtil.uploadFile(request, signtable, fName2, trainingID);
			training.setExamfile(examfile1);
			training.setContentFile(contentFile1);
			training.setSigntable(signtable1);
			formService.updateTraining(training);

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
	 * 170.新增灭火应急演练【**】
	 */
	@ResponseBody
	@RequestMapping(value = "/AddManoeuvre", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String addManoeuvre(HttpServletRequest request, @RequestParam("schemafile") MultipartFile schemafile,
			@RequestParam("attendpersonfile") MultipartFile attendpersonfile,
			@RequestParam("implementationfile") MultipartFile implementationfile) throws JsonProcessingException {
		String orgid = request.getParameter("Orgid");
		String manoeuvretime = request.getParameter("manoeuvretime");
		String address = request.getParameter("Address");
		String department = request.getParameter("Department");
		String manager = request.getParameter("Manager");
		String content = request.getParameter("Content");
		String scheme = request.getParameter("Scheme");
		String attendperson = request.getParameter("attendperson");
		String implementation = request.getParameter("implementation");
		String summary = request.getParameter("Summary");
		String suggestion = request.getParameter("suggestion");
		String dataBag = null;
		int statusCode = -1;
		try {
			Manoeuvre manoeuvre = new Manoeuvre();
			String manoeuvreID = UUIDGenerator.getUUID();
			manoeuvre.setManoeuvreID(manoeuvreID);
			manoeuvre.setAddress(address);
			manoeuvre.setAttendperson(attendperson);
			manoeuvre.setContent(content);
			manoeuvre.setDepartment(department);
			manoeuvre.setImplementation(implementation);
			manoeuvre.setManoeuvretime(manoeuvretime);
			manoeuvre.setManager(manager);
			manoeuvre.setScheme(scheme);
			manoeuvre.setOrgid(orgid);
			manoeuvre.setSummary(summary);
			manoeuvre.setSuggestion(suggestion);

			String schemafile1 = UploadUtil.uploadFile(request, schemafile, schemafile.getOriginalFilename(),
					manoeuvreID);
			String attendpersonfile1 = UploadUtil.uploadFile(request, attendpersonfile,
					attendpersonfile.getOriginalFilename(), manoeuvreID);
			String implementationfile1 = UploadUtil.uploadFile(request, implementationfile,
					implementationfile.getOriginalFilename(), manoeuvreID);

			manoeuvre.setSchemafile(schemafile1);
			manoeuvre.setAttendpersonfile(attendpersonfile1);
			manoeuvre.setImplementationfile(implementationfile1);
			formService.addManoeuvre(manoeuvre);

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
	 * 171.修改灭火应急演练预案【**】
	 */
	@ResponseBody
	@RequestMapping(value = "/UpdateManoeuvre", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String updateManoeuvre(HttpServletRequest request, @RequestParam("schemafile") MultipartFile schemafile,
			@RequestParam("attendpersonfile") MultipartFile attendpersonfile,
			@RequestParam("implementationfile") MultipartFile implementationfile) throws JsonProcessingException {
		String manoeuvreID = request.getParameter("manoeuvreID");
		String orgid = request.getParameter("Orgid");
		String manoeuvretime = request.getParameter("manoeuvretime");
		String address = request.getParameter("Address");
		String department = request.getParameter("Department");
		String manager = request.getParameter("Manager");
		String content = request.getParameter("Content");
		String scheme = request.getParameter("Scheme");
		String attendperson = request.getParameter("attendperson");
		String implementation = request.getParameter("implementation");
		String summary = request.getParameter("Summary");
		String suggestion = request.getParameter("suggestion");
		String dataBag = null;
		int statusCode = -1;
		try {
			Manoeuvre manoeuvre = new Manoeuvre();
			manoeuvre.setManoeuvreID(manoeuvreID);
			manoeuvre.setAddress(address);
			manoeuvre.setAttendperson(attendperson);
			manoeuvre.setContent(content);
			manoeuvre.setDepartment(department);
			manoeuvre.setImplementation(implementation);
			manoeuvre.setManoeuvretime(manoeuvretime);
			manoeuvre.setManager(manager);
			manoeuvre.setScheme(scheme);
			manoeuvre.setOrgid(orgid);
			manoeuvre.setSummary(summary);
			manoeuvre.setSuggestion(suggestion);

			String schemafile1 = UploadUtil.uploadFile(request, schemafile, schemafile.getOriginalFilename(),
					manoeuvreID);
			String attendpersonfile1 = UploadUtil.uploadFile(request, attendpersonfile,
					attendpersonfile.getOriginalFilename(), manoeuvreID);
			String implementationfile1 = UploadUtil.uploadFile(request, implementationfile,
					implementationfile.getOriginalFilename(), manoeuvreID);

			manoeuvre.setSchemafile(schemafile1);
			manoeuvre.setAttendpersonfile(attendpersonfile1);
			manoeuvre.setImplementationfile(implementationfile1);
			formService.updateManoeuvre(manoeuvre);

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
	 *
	 * 46.添加消防安全管理制度【**】
	 * 
	 */

	@ResponseBody
	@RequestMapping(value = "/AddSafeManageRules", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String updateManoeuvre(HttpServletRequest request, @RequestParam("SafeRuleFile") MultipartFile safeRuleFile) throws JsonProcessingException {
		String orgid = request.getParameter("orgid");
		String safeManageRulesName = request.getParameter("SafeManageRulesName");
		String safeManageRulesType = request.getParameter("SafeManageRulesType");

		String dataBag = null;
		int statusCode = -1;
		try {
			SafeManageRules safeManageRules = new SafeManageRules();
			String safeManageRulesID = UUIDGenerator.getUUID();
			safeManageRules.setSafeManageRulesID(safeManageRulesID);
			safeManageRules.setSafeManageRulesName(safeManageRulesName);
			safeManageRules.setUploadTime(DateUtils.timesstampToString());
			safeManageRules.setSafeManageRulesType(safeManageRulesType);
			safeManageRules.setOrgid(orgid);

			String filepath = UploadUtil.uploadFileManageRule(request, safeRuleFile, safeRuleFile.getOriginalFilename(),
					safeManageRulesID);

			safeManageRules.setFilepath(filepath);
			formService.addSafeManageRules(safeManageRules);
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
	 * 47.修改消防安全管理制度【**】
	 * 
	 * @param request
	 * @param safeRuleFile
	 * @return
	 * @throws JsonProcessingException
	 */
	@ResponseBody
	@RequestMapping(value = "/UpdateSafeManageRules", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String updateSafeManageRules(HttpServletRequest request,
			@RequestParam("SafeRuleFile") MultipartFile safeRuleFile) throws JsonProcessingException {
		String safeManageRulesID = request.getParameter("safeManageRulesID");
		String orgid = request.getParameter("orgid");
		String safeManageRulesName = request.getParameter("SafeManageRulesName");
		String safeManageRulesType = request.getParameter("SafeManageRulesType");

		String dataBag = null;
		int statusCode = -1;
		try {
			SafeManageRules safeManageRules = new SafeManageRules();
			safeManageRules.setSafeManageRulesID(safeManageRulesID);
			safeManageRules.setSafeManageRulesName(safeManageRulesName);
			safeManageRules.setUploadTime(DateUtils.timesstampToString());
			safeManageRules.setSafeManageRulesType(safeManageRulesType);
			safeManageRules.setOrgid(orgid);

			String filepathBefore = formService.findFilePath(safeManageRulesID);
			String filedir = request.getSession().getServletContext().getRealPath("/") + filepathBefore;
			// 先删除文件
			UploadUtil.deleteFile(filedir);
			String filepath = UploadUtil.uploadFileManageRule(request, safeRuleFile, safeRuleFile.getOriginalFilename(),
					safeManageRulesID);

			safeManageRules.setFilepath(filepath);
			formService.updateSafeManageRules(safeManageRules);

			statusCode = ConstValues.OK;
			dataBag = "修改成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "修改失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "/AddSafeDuty", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String addSafeDuty(HttpServletRequest request, @RequestParam("SafeDutyFile") MultipartFile safeDutyFile) throws JsonProcessingException {
		String dutyname = request.getParameter("dutyname");
		String safedutytype = request.getParameter("safedutytype");
		String orgid = request.getParameter("orgid");
		
		String dataBag = null;
		int statusCode = -1;
		try {
			
			SafeDuty safeDuty = new SafeDuty();
			String safeDutyID = UUIDGenerator.getUUID();
			safeDuty.setSafeDutyID(safeDutyID);
			safeDuty.setDutyname(dutyname);
			safeDuty.setUploadtime(DateUtils.timesstampToString());
			safeDuty.setOrgid(orgid);
			safeDuty.setSafedutytype(safedutytype);
			
			String filepath = UploadUtil.uploadSafeDutyFile(request, safeDutyFile, safeDutyFile.getOriginalFilename(),
					safeDutyID);
			
			safeDuty.setFilepath(filepath);
			
		//	formService.addSafeDuty(safeDuty);
			
			formService.addSafeDuty(safeDuty);
			statusCode = ConstValues.OK;
			dataBag = "插入成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "插入失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/UpdateSafeDuty", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String updateSafeDuty(HttpServletRequest request, @RequestParam("SafeDutyFile") MultipartFile safeDutyFile) throws JsonProcessingException {
		String dutyname = request.getParameter("dutyname");
		String safedutytype = request.getParameter("safedutytype");
		String orgid = request.getParameter("orgid");
		String safeDutyID = request.getParameter("SafeDutyID");
		
		String dataBag = null;
		int statusCode = -1;
		try {
			
			SafeDuty safeDuty = new SafeDuty();
			safeDuty.setSafeDutyID(safeDutyID);
			safeDuty.setDutyname(dutyname);
			safeDuty.setOrgid(orgid);
			safeDuty.setSafedutytype(safedutytype);
			safeDuty.setUploadtime(DateUtils.timesstampToString());
			//先删除文件
			String filepathBefore = formService.findSafeDutyFilePath(safeDutyID);
			String filedir = request.getSession().getServletContext().getRealPath("/") + filepathBefore;
			// 先删除文件
			UploadUtil.deleteFile(filedir);
			
			String filepath = UploadUtil.uploadSafeDutyFile(request, safeDutyFile, safeDutyFile.getOriginalFilename(),
					safeDutyID);
			
			safeDuty.setFilepath(filepath);
			
			//	formService.addSafeDuty(safeDuty);
			
			formService.updateSafeDuty(safeDuty);
			statusCode = ConstValues.OK;
			dataBag = "修改成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "修改失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);
		
	}
	
	
	

}
