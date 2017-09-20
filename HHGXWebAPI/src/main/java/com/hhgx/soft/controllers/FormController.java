package com.hhgx.soft.controllers;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.hhgx.soft.entitys.Appearancepic;
import com.hhgx.soft.entitys.BusinessLicence;
import com.hhgx.soft.entitys.Devices;
import com.hhgx.soft.entitys.Flatpic;
import com.hhgx.soft.entitys.Manoeuvre;
import com.hhgx.soft.entitys.OnlineFiresystem;
import com.hhgx.soft.entitys.SafeDuty;
import com.hhgx.soft.entitys.SafeManageRules;
import com.hhgx.soft.entitys.Training;
import com.hhgx.soft.entitys.UserCheckInfo;
import com.hhgx.soft.entitys.UserCheckPic;
import com.hhgx.soft.entitys.UpdateFireSystem;
import com.hhgx.soft.services.FormService;
import com.hhgx.soft.services.OrginfoService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.DateUtils;
import com.hhgx.soft.utils.ReadExcel;
import com.hhgx.soft.utils.ResponseJson;
import com.hhgx.soft.utils.UUIDGenerator;
import com.hhgx.soft.utils.UploadUtil;

@Controller
@RequestMapping(value = "/Form")
public class FormController {
	@Autowired
	private FormService formService;
	@Autowired
	private OrginfoService orginfoService;

	/**
	 * 9.修改防火单位的系统
	 * 
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/UpdateFireSystemList", method = { RequestMethod.POST })
	public String updateFireSystemList(HttpServletRequest request,
			@RequestParam(value = "SysFlatpic", required = false) MultipartFile sysFlatpic) {

	
		
		String siteid = request.getParameter("siteid");
		String tisystype = request.getParameter("tisystype");
		String newTisystype = request.getParameter("newTisystype");
		String states = request.getParameter("states");
		String remarks = request.getParameter("Remarks");
		String ynOnline = request.getParameter("YnOnline");
		String dataBag = null;
		int statusCode = -1;
		try {
			UpdateFireSystem updateFireSystem = new UpdateFireSystem();
			if (newTisystype.equals("all")) {
				newTisystype = "0";
			}
			updateFireSystem.setNewTisystype(newTisystype);
			updateFireSystem.setRemarks(remarks);
			updateFireSystem.setSiteid(siteid);
			updateFireSystem.setStates(states);
			updateFireSystem.setTisystype(tisystype);
			updateFireSystem.setYnOnline(ynOnline);
			if (!StringUtils.isEmpty(sysFlatpic)) {
				String fName = sysFlatpic.getOriginalFilename();
				String sysFlatpic1 = UploadUtil.uploadOneFile(request, sysFlatpic,fName, "SysFlatpic/" + UUIDGenerator.getUUID());
				updateFireSystem.setSysFlatpic(sysFlatpic1);
			}
			//修改前先删掉
			
			formService.updateFireSystemList(updateFireSystem);
			// 遗留小问题，如果数据插入失败，上传的照片没有删掉
			statusCode = ConstValues.OK;
			dataBag = ConstValues.SUCCESS_;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = -2;
			dataBag ="该系统已经使用，不能被删除！!";
			return ResponseJson.responseAddJson(dataBag, statusCode);

		}

		return ResponseJson.responseAddJson(dataBag, statusCode);

	}


   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 
	 * 19.添加防火单位的系统
	 * 
	 * @throws IOException
	 */

	@ResponseBody
	@RequestMapping(value = "/AddorgSys", method = { RequestMethod.POST })
	public String addorgSys(HttpServletRequest request,
			@RequestParam(value = "SysFlatpic", required = false) MultipartFile sysFlatpic) throws IOException {

		String siteid = request.getParameter("siteid");
		String tiSysType = request.getParameter("tiSysType");
		String states = request.getParameter("states");
		String ynOnline = request.getParameter("ynOnline");
		String remarks = request.getParameter("remarks");

		int statusCode = -1;
		String dataBag = null;

		if (formService.existOrgSys(siteid, tiSysType)) {

			statusCode = -2;
			dataBag = "对不起，不能添加已存在的数据";
			return ResponseJson.responseAddJson(dataBag, statusCode);

		}
		try {
			OnlineFiresystem onlineFiresystem = new OnlineFiresystem();
			onlineFiresystem.setStates(states);
			onlineFiresystem.setYnOnline(ynOnline);
			onlineFiresystem.setRemarks(remarks);
			onlineFiresystem.setSiteid(siteid);
			onlineFiresystem.setTiSysType(tiSysType);
			String sysFlatpic1 ="";
			if (!StringUtils.isEmpty(sysFlatpic)) {
				//String ext = UploadUtil.getExtention(sysFlatpic.getOriginalFilename());
				 String fName = sysFlatpic.getOriginalFilename();
				 sysFlatpic1 = UploadUtil.uploadOneFile(request, sysFlatpic, fName,
						"SysFlatpic/" + UUIDGenerator.getUUID());
			}
			onlineFiresystem.setSysFlatpic(sysFlatpic1);

			formService.addorgSys(onlineFiresystem);
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
	 * 26. 添加平面图
	 */
	@ResponseBody
	@RequestMapping(value = "/AddflatPic", method = { RequestMethod.POST })
	public String addflatPic(HttpServletRequest request,
			@RequestParam(value = "imFlatPic", required = false) MultipartFile imFlatPic) {
		String siteid = request.getParameter("siteid");
		String floornum = request.getParameter("floornum");
		//String orgid = request.getParameter("orgid");
		String dataBag = null;
		int statusCode = -1;
		try {
			Flatpic flatpic = new Flatpic();
			flatpic.setdRecordSet(DateUtils.timesstampToString());
			// String cFlatPic = String.valueOf(new Random().nextInt(99)+10);
			
			flatpic.setcFlatPic(DateUtils.DatePathname());
			flatpic.setSiteid(siteid);
			flatpic.setFloornum(floornum);
			String imFlatPic1="";
			if (!StringUtils.isEmpty(imFlatPic)) {

				String ext = UploadUtil.getExtention(imFlatPic.getOriginalFilename());
				 imFlatPic1 = UploadUtil.uploadOneFile(request, imFlatPic, UUIDGenerator.getUUID() + "." + ext,
						UUIDGenerator.getUUID() + "/Flatpic");
			}
			flatpic.setImFlatPic(imFlatPic1);
			formService.addflatPic(flatpic);
			// 遗留小问题，如果数据插入失败，上传的照片没有删掉
			statusCode = ConstValues.OK;
			dataBag = "添加平面图成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "添加平面图失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);
	}

	/**
	 * 
	 *  * @param request  * @param imFlatPic  * @return:TODO  
	 */

	@ResponseBody
	@RequestMapping(value = "/UpdateflatPic", method = { RequestMethod.POST })
	public String updateflatPic(HttpServletRequest request,
			@RequestParam(value = "imFlatPic", required = false) MultipartFile imFlatPic) {
		String siteid = request.getParameter("siteid");
		String cFlatPic = request.getParameter("cFlatPic");
		String floornum = request.getParameter("floornum");
		String dataBag = null;
		int statusCode = -1;
		try {
			Flatpic flatpic = new Flatpic();
			flatpic.setcFlatPic(cFlatPic);
			flatpic.setSiteid(siteid);
			flatpic.setFloornum(floornum);

			if (!StringUtils.isEmpty(imFlatPic)) {

				// 删除文件
				String filepathBefore = formService.findCflatPic(cFlatPic);
				String filedir = request.getSession().getServletContext().getRealPath("/") + filepathBefore;
				// 先删除文件
				UploadUtil.deleteFile(filedir);
				String ext = UploadUtil.getExtention(imFlatPic.getOriginalFilename());
				String imFlatPic1 = UploadUtil.uploadOneFile(request, imFlatPic, UUIDGenerator.getUUID() + "." + ext,
						UUIDGenerator.getUUID() + "/Flatpic");
				flatpic.setImFlatPic(imFlatPic1);
			}
			formService.updateflatPic(flatpic);
			statusCode = ConstValues.OK;
			dataBag = "数据修改成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "数据修改失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);
	}
	@ResponseBody
	@RequestMapping(value = "/UploadOrgSummaryPic", method = { RequestMethod.POST })
	public String uploadOrgSummaryPic(HttpServletRequest request,
			@RequestParam(value = "vPicturePath", required = false) MultipartFile vPicturePath) throws IOException {		
		String orgid = request.getParameter("orgid");
		int statusCode=-1;
		String dataBag =null;
		String vPicturePath1 ="";
		try {
			if (!StringUtils.isEmpty(vPicturePath)) {

				// 删除文件
				String filepathBefore = formService.findIntroducePath(orgid);
				String filedir = request.getSession().getServletContext().getRealPath("/") + filepathBefore;
				// 先删除文件
				UploadUtil.deleteFile(filedir);
				String ext = UploadUtil.getExtention(vPicturePath.getOriginalFilename());
			    vPicturePath1 = UploadUtil.uploadOneFile(request, vPicturePath, UUIDGenerator.getUUID() + "." + ext,
						UUIDGenerator.getUUID() + "/Introduce");
			}
			
			formService.uploadOrgSummaryPic(vPicturePath1, orgid);
			statusCode = ConstValues.OK;
			dataBag = "上传成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "上传失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);
	}

	/**
	 * 65.添加外观图（P）
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/AddAppearance", method = { RequestMethod.POST })
	public String addAppearance(HttpServletRequest request,
			@RequestParam(value = "Picpath", required = false) MultipartFile picpath) {

		String siteid = request.getParameter("siteid");
		// String iphotoID = request.getParameter("iphotoID");
		String vPhotoname = request.getParameter("vPhotoname");
		String exteriorInfo = "";

		String dataBag = null;
		int statusCode = -1;
		try {
			Appearancepic appearancepic = new Appearancepic();
			String random = String.valueOf(new Random().nextInt(99) + 1);
			appearancepic.setIphotoID(System.currentTimeMillis() + random);
			appearancepic.setdRecordDate(DateUtils.timesstampToString());
			appearancepic.setvPhotoname(vPhotoname);
			appearancepic.setExteriorInfo(exteriorInfo);
			appearancepic.setSiteid(siteid);
			String picpath1="";
			if (!StringUtils.isEmpty(picpath)) {

				String ext = UploadUtil.getExtention(picpath.getOriginalFilename());
				 picpath1 = UploadUtil.uploadOneFile(request, picpath, UUIDGenerator.getUUID() + "." + ext,
						UUIDGenerator.getUUID() + "/AppearancePic");
			}
			appearancepic.setPicpath(picpath1);
			formService.addAppearance(appearancepic);
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
	 * 107.提交总平图（Z）
	 */
	@ResponseBody
	@RequestMapping(value = "/SubmitTotalFlatPic", method = { RequestMethod.POST })
	public String submitTotalFlatPic(HttpServletRequest request,
			@RequestParam(value = "Flatpic", required = false) MultipartFile flatpic) {
		String orgid = request.getParameter("orgid");
		String userdefinedFile = request.getParameter("userdefinedFile");
		System.err.println(userdefinedFile + "userdefinedFile");
		String dataBag = null;
		int statusCode = -1;
		String bflatpic = null;
		try {

			if (!StringUtils.isEmpty(flatpic)) {
				// 删除文件
				// String filepathBefore =
				// formService.findFilePath(userdefinedFile);
				// String filedir =
				// request.getSession().getServletContext().getRealPath("/") +
				// filepathBefore;
				// 先删除文件
				// UploadUtil.deleteFile(filedir);
				String ext = UploadUtil.getExtention(flatpic.getOriginalFilename());
				bflatpic = UploadUtil.uploadOneFile(request, flatpic, UUIDGenerator.getUUID() + "." + ext,
						UUIDGenerator.getUUID() + "/Flatpic");
			}
			formService.submitTotalFlatPic(bflatpic, orgid);
			statusCode = ConstValues.OK;
			dataBag = "提交总平图成功！";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "提交总平图失败！";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);
	}

	/**
	 * 129.巡查记录填写【**】
	 * 
	 * @return @
	 */

	@ResponseBody
	@RequestMapping(value = "/AddOrUpdateCheckRecord", method = { RequestMethod.POST })
	public String addOrUpdateCheckRecord(HttpServletRequest request) {

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
			for (int i = 0; i < picIDList.length; i++) {
				String picType = formService.findPicType(picIDList[i]);
				UploadUtil.deleteOneFileOrDirectory(request, picIDList[i] + "." + picType,
						"CheckRecord/" + userCheckId);
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
						String picPath = UploadUtil.uploadOneFile(request, mFile, picID + "." + picType,
								"CheckRecord/" + userCheckId);
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
			dataBag = ConstValues.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag =ConstValues.FIALURE;
		}

		return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 * 161.添加消防安全培训情况【**】
	 */
	@ResponseBody
	@RequestMapping(value = "/AddTraining", method = RequestMethod.POST)
	public String addTraining(HttpServletRequest request,
			@RequestParam(value = "ContentFile", required = false) MultipartFile contentFile,
			@RequestParam(value = "examfile", required = false) MultipartFile examfile,
			@RequestParam(value = "signtable", required = false) MultipartFile signtable) {
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
			training.setTrainingTime(DateUtils.StringToDate(trainingTime, "yyyy/MM/dd"));
			training.setTrainingContent(trainingContent);
			training.setTrainingObject(trainingObject);
			training.setTrainingType(trainingType);
			String contentFile1="";
			String examfile1="";
			String signtable1="";

			if (!StringUtils.isEmpty(contentFile)) {
				String fName = contentFile.getOriginalFilename();
				 contentFile1 = UploadUtil.uploadOneFile(request, contentFile, fName, "Training/" + trainingID);
			}
			if (!StringUtils.isEmpty(examfile)) {
				String fName1 = examfile.getOriginalFilename();
				 examfile1 = UploadUtil.uploadOneFile(request, examfile, fName1, "Training/" + trainingID);
			}
			if (!StringUtils.isEmpty(signtable)) {
				String fName2 = signtable.getOriginalFilename();
				 signtable1 = UploadUtil.uploadOneFile(request, signtable, fName2, "Training/" + trainingID);
			}
			training.setContentFile(contentFile1);
			training.setExamfile(examfile1);
			training.setSigntable(signtable1);
			formService.addTraining(training);
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
	 * 164.修改消防安全培训情况【**】
	 */
	@ResponseBody
	@RequestMapping(value = "/UpdateTraining", method = RequestMethod.POST)
	public String updateTraining(HttpServletRequest request,
			@RequestParam(value = "ContentFile", required = false) MultipartFile contentFile,
			@RequestParam(value = "examfile", required = false) MultipartFile examfile,
			@RequestParam(value = "signtable", required = false) MultipartFile signtable) {
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
			training.setTrainingTime(DateUtils.StringToDate(trainingTime, "yyyy/MM/dd"));
			training.setTrainingContent(trainingContent);
			training.setTrainingObject(trainingObject);
			training.setTrainingType(trainingType);

			if (!StringUtils.isEmpty(contentFile)) {
				String fName = contentFile.getOriginalFilename();
				String contentFile1 = UploadUtil.uploadOneFile(request, contentFile, fName, "Training/" + trainingID);
				training.setContentFile(contentFile1);

			}
			if (!StringUtils.isEmpty(examfile)) {
				String fName1 = examfile.getOriginalFilename();
				String examfile1 = UploadUtil.uploadOneFile(request, examfile, fName1, "Training/" + trainingID);

				training.setExamfile(examfile1);
			}
			if (!StringUtils.isEmpty(signtable)) {
				String fName2 = signtable.getOriginalFilename();
				String signtable1 = UploadUtil.uploadOneFile(request, signtable, fName2, "Training/" + trainingID);
				training.setSigntable(signtable1);

			}
			formService.updateTraining(training);

			statusCode = ConstValues.OK;
			dataBag = ConstValues.SUCCESS_;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = ConstValues.FIALURE_;
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 * 170.新增灭火应急演练【**】
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/AddManoeuvre", method = RequestMethod.POST)
	public String addManoeuvre(HttpServletRequest request,
			@RequestParam(value = "schemafile", required = false) MultipartFile schemafile,
			@RequestParam(value = "attendpersonfile", required = false) MultipartFile attendpersonfile,
			@RequestParam(value = "implementationfile", required = false) MultipartFile implementationfile) {
		String orgid = request.getParameter("orgid");
		String manoeuvretime = request.getParameter("manoeuvretime");
		String address = request.getParameter("address");
		String department = request.getParameter("Department");
		String manager = request.getParameter("manager");
		String content = request.getParameter("content");
		String scheme = request.getParameter("scheme");
		String attendperson = request.getParameter("attendperson");
		String implementation = request.getParameter("implementation");
		String summary = request.getParameter("summary");
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
			String schemafile1          ="";
			String attendpersonfile1    ="";
			String implementationfile1  ="";
			if (!StringUtils.isEmpty(schemafile)) {

				 schemafile1 = UploadUtil.uploadOneFile(request, schemafile, schemafile.getOriginalFilename(),
						"Manoeuvre/" + manoeuvreID);
			}
			if (!StringUtils.isEmpty(attendpersonfile)) {

				 attendpersonfile1 = UploadUtil.uploadOneFile(request, attendpersonfile,
						attendpersonfile.getOriginalFilename(), "Manoeuvre/" + manoeuvreID);
			}
			if (!StringUtils.isEmpty(implementationfile)) {

				 implementationfile1 = UploadUtil.uploadOneFile(request, implementationfile,
						implementationfile.getOriginalFilename(), "Manoeuvre/" + manoeuvreID);
			}

			manoeuvre.setSchemafile(schemafile1);
			manoeuvre.setAttendpersonfile(attendpersonfile1);
			manoeuvre.setImplementationfile(implementationfile1);
			formService.addManoeuvre(manoeuvre);
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
	 * 171.修改灭火应急演练预案【**】
	 */
	@ResponseBody
	@RequestMapping(value = "/UpdateManoeuvre", method = RequestMethod.POST)
	public String updateManoeuvre(HttpServletRequest request,
			@RequestParam(value = "schemafile", required = false) MultipartFile schemafile,
			@RequestParam(value = "attendpersonfile", required = false) MultipartFile attendpersonfile,
			@RequestParam(value = "implementationfile", required = false) MultipartFile implementationfile) {
		String manoeuvreID = request.getParameter("manoeuvreID");
		String orgid = request.getParameter("orgid");
		String manoeuvretime = request.getParameter("manoeuvretime");
		String address = request.getParameter("address");
		String department = request.getParameter("Department");
		String manager = request.getParameter("manager");
		String content = request.getParameter("content");
		String scheme = request.getParameter("scheme");
		String attendperson = request.getParameter("attendperson");
		String implementation = request.getParameter("implementation");
		String summary = request.getParameter("summary");
		String suggestion = request.getParameter("suggestion");
		String dataBag = null;
		int statusCode = -1;
		try {

			Manoeuvre manoeuvre = new Manoeuvre();
			manoeuvre.setOrgid(orgid);
			manoeuvre.setManoeuvreID(manoeuvreID);
			manoeuvre.setManoeuvretime(manoeuvretime);
			manoeuvre.setAddress(address);
			manoeuvre.setDepartment(department);
			manoeuvre.setManager(manager);
			manoeuvre.setContent(content);
			manoeuvre.setScheme(scheme);
			manoeuvre.setAttendperson(attendperson);
			manoeuvre.setImplementation(implementation);
			manoeuvre.setSummary(summary);
			manoeuvre.setSuggestion(suggestion);

			if (!StringUtils.isEmpty(schemafile)) {
				String schemafile1 = UploadUtil.uploadOneFile(request, schemafile, schemafile.getOriginalFilename(),
						"Manoeuvre/" + manoeuvreID);
				manoeuvre.setSchemafile(schemafile1);
			}
			if (!StringUtils.isEmpty(attendpersonfile)) {
				String attendpersonfile1 = UploadUtil.uploadOneFile(request, attendpersonfile,
						attendpersonfile.getOriginalFilename(), "Manoeuvre/" + manoeuvreID);
				manoeuvre.setAttendpersonfile(attendpersonfile1);
			}
			if (!StringUtils.isEmpty(implementationfile)) {
				String implementationfile1 = UploadUtil.uploadOneFile(request, implementationfile,
						implementationfile.getOriginalFilename(), "Manoeuvre/" + manoeuvreID);
				manoeuvre.setImplementationfile(implementationfile1);
			}

			formService.updateManoeuvre(manoeuvre);
			statusCode = ConstValues.OK;
			dataBag = ConstValues.SUCCESS_;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = ConstValues.FIALURE_;
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 *
	 * 46.添加消防安全管理制度【**】
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/AddSafeManageRules", method = RequestMethod.POST)
	public String updateManoeuvre(HttpServletRequest request,
			@RequestParam(value = "SafeRuleFile", required = false) MultipartFile safeRuleFile) {
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
			String filepath ="";
			if (!StringUtils.isEmpty(safeRuleFile)) {
				 filepath = UploadUtil.uploadOneFile(request, safeRuleFile, safeRuleFile.getOriginalFilename(),
						"ManageRule/" + safeManageRulesID);
			}
			safeManageRules.setFilepath(filepath);
			formService.addSafeManageRules(safeManageRules);
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
	 * 47.修改消防安全管理制度【**】
	 * 
	 * @param request
	 * @param safeRuleFile
	 * @return @
	 */
	@ResponseBody
	@RequestMapping(value = "/UpdateSafeManageRules", method = RequestMethod.POST)
	public String updateSafeManageRules(HttpServletRequest request,
			@RequestParam(value = "SafeRuleFile", required = false) MultipartFile safeRuleFile) {
		String safeManageRulesID = request.getParameter("SafeManageRulesID");
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

			if (!StringUtils.isEmpty(safeRuleFile)) {
				String filepathBefore = formService.findFilePath(safeManageRulesID);
				String filedir = request.getSession().getServletContext().getRealPath("/") + filepathBefore;
				// 先删除文件
				UploadUtil.deleteFile(filedir);

				String filepath = UploadUtil.uploadOneFile(request, safeRuleFile, safeRuleFile.getOriginalFilename(),
						"ManageRule/" + safeManageRulesID);
				System.out.println(filepath);
				safeManageRules.setFilepath(filepath);
			}
			formService.updateSafeManageRules(safeManageRules);
			statusCode = ConstValues.OK;
			dataBag = ConstValues.SUCCESS_;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = ConstValues.FIALURE_;
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);
	}

	/**
	 * 50.添加消防安全职责【**】  *
	 * 
	 * @param request
	 *             * @param safeDutyFile  * @return  * @:TODO  
	 */

	@ResponseBody
	@RequestMapping(value = "/AddSafeDuty", method = RequestMethod.POST)
	public String addSafeDuty(HttpServletRequest request,
			@RequestParam(value = "SafeDutyFile", required = false) MultipartFile safeDutyFile) {
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
			String filepath="";
			if (!StringUtils.isEmpty(safeDutyFile)) {
				 filepath = UploadUtil.uploadOneFile(request, safeDutyFile, safeDutyFile.getOriginalFilename(),
						"SafeDuty/" + safeDutyID);
			}
			safeDuty.setFilepath(filepath);

			formService.addSafeDuty(safeDuty);
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
	 * 51.修改消防安全职责【**】  * @param request  * @param safeDutyFile  * @return
	 *  * @:TODO  
	 */

	@ResponseBody
	@RequestMapping(value = "/UpdateSafeDuty", method = RequestMethod.POST)
	public String updateSafeDuty(HttpServletRequest request,
			@RequestParam(value = "SafeDutyFile", required = false) MultipartFile safeDutyFile) {
		String dutyname = request.getParameter("dutyname");
		String safedutytype = request.getParameter("safedutytype");
		String orgid = request.getParameter("Orgid");
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
			if (!StringUtils.isEmpty(safeDutyFile)) {
				// 先删除文件
				String filepathBefore = formService.findSafeDutyFilePath(safeDutyID);
				String filedir = request.getSession().getServletContext().getRealPath("/") + filepathBefore;
				// 先删除文件
				UploadUtil.deleteFile(filedir);
				String filepath = UploadUtil.uploadOneFile(request, safeDutyFile, safeDutyFile.getOriginalFilename(),
						"SafeDuty/" + safeDutyID);
				safeDuty.setFilepath(filepath);
			}

			formService.updateSafeDuty(safeDuty);
			statusCode = ConstValues.OK;
			dataBag = ConstValues.SUCCESS_;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = ConstValues.FIALURE_;
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 * 86.修改和添加营业执照【**】
	 */
	@ResponseBody
	@RequestMapping(value = "/AddBusinessLicence", method = RequestMethod.POST)
	public String addBusinessLicence(HttpServletRequest request,
			@RequestParam(value = "PictureUrl", required = false) MultipartFile pictureUrl) {
		String licenceCode = request.getParameter("LicenceCode");
		String conpanyName = request.getParameter("ConpanyName");
		String companyType = request.getParameter("CompanyType");
		String companyAddress = request.getParameter("CompanyAddress");
		String companyRegister = request.getParameter("CompanyRegister");
		String registMoney = request.getParameter("RegistMoney");
		String buildTime = request.getParameter("BuildTime");
		String businessEndTime = request.getParameter("BusinessEndTime");
		String businessScope = request.getParameter("BusinessScope");
		String auditingDepartment = request.getParameter("AuditingDepartment");
		String registTime = request.getParameter("RegistTime");
		String orgid = request.getParameter("orgid");

		String dataBag = null;
		int statusCode = -1;
		try {

			BusinessLicence businessLicence = new BusinessLicence();
			businessLicence.setLicenceCode(licenceCode);
			businessLicence.setAuditingDepartment(auditingDepartment);
			businessLicence.setBuildTime(DateUtils.StringToDate(buildTime, "yyyy/MM/dd"));
			businessLicence.setBusinessEndTime(DateUtils.StringToDate(businessEndTime, "yyyy/MM/dd"));
			businessLicence.setBusinessScope(businessScope);
			businessLicence.setRegistMoney(registMoney);
			businessLicence.setConpanyName(conpanyName);
			businessLicence.setCompanyAddress(companyAddress);
			businessLicence.setCompanyRegister(companyRegister);
			businessLicence.setCompanyType(companyType);
			businessLicence.setOrgid(orgid);
			businessLicence.setRegistTime(DateUtils.StringToDate(registTime, "yyyy/MM/dd"));
			String pictureUrl1="";
			if (!StringUtils.isEmpty(pictureUrl)) {
				String ext = UploadUtil.getExtention(pictureUrl.getOriginalFilename());
				 pictureUrl1 = UploadUtil.uploadOneFile(request, pictureUrl, UUIDGenerator.getUUID() + "." + ext,
						orgid + "/BusinessLicence");
			}
			businessLicence.setPictureUrl(pictureUrl1);
			if (formService.eixstLicenceCode(licenceCode)) {
				formService.updateBusinessLicence(businessLicence);
			} else {
				formService.addBusinessLicence(businessLicence);
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
	 * 135. 导入Excel到数据库 测试结果 接口地址 /Form/ExcelToDataBase 接口方法 ExcelToDataBase
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/ExcelToDataBase", method = RequestMethod.POST)
	public String excelToDataBase(HttpServletRequest request,
			@RequestParam(value = "excelFile", required = false) MultipartFile excelFile) {
		String cFlatpic = request.getParameter("cFlatpic");

		String dataBag = null;
		int statusCode = -1;
		if (StringUtils.isEmpty(excelFile)) {
			return ResponseJson.responseAddJson("没有传递excel文件", -256);
		}
		try {
			ReadExcel readExcel = new ReadExcel();
			List<Devices> devicesLists = readExcel.getExcelInfo(excelFile);
			for (Devices devices : devicesLists) {
				devices.setcFlatPic(cFlatpic);
				if(!StringUtils.isEmpty(devices.getiDeviceType())){
					String iDeviceType = orginfoService.findDevicesTypeByName(devices.getiDeviceType().trim());
					if(!StringUtils.isEmpty(iDeviceType))
						devices.setiDeviceType(iDeviceType);}
				
				if (orginfoService.findDevicesByKey(devices.getDeviceaddress(), String.valueOf(devices.getSysaddress()), devices.getGatewayaddress()))
					orginfoService.updateDevices(devices);
				else {
					orginfoService.addDevices(devices);
				}
			}
			statusCode = ConstValues.OK;
			dataBag = "导入成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "导入失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);

	}
}
