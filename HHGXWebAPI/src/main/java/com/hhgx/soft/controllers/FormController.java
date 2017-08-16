package com.hhgx.soft.controllers;

import java.io.File;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	@RequestMapping(value = "/AddOrUpdateCheckRecord", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String addOrUpdateCheckRecord(HttpServletRequest request, HttpServletResponse response)
			throws JsonProcessingException {
		String userCheckId = request.getParameter("UserCheckId");
		String projectId = request.getParameter("ProjectId");

		int listNum = Integer.parseInt(request.getParameter("listNum"));
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
			for (String ID : picIDList) {
				String picType = formService.findPicType(ID);
				UploadUtil.deleteFileOrDirectory(request, ID + "." + picType, userCheckId);
				formService.deletePicByID(ID);
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
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		if (statusCode == ConstValues.OK) {
			dataBag = "插入成功";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		} else {
			dataBag = "插入失败";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		}

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
			training.setTrainingTime(trainingTime);
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
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		if (statusCode == ConstValues.OK) {
			dataBag = "插入成功";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		} else {
			dataBag = "插入失败";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		}

	}
	/**
	 *164.修改消防安全培训情况【**】
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
			training.setTrainingTime(trainingTime);
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
			
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		if (statusCode == ConstValues.OK) {
			dataBag = "修改成功";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		} else {
			dataBag = "修改失败";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		}
		
	}
}
