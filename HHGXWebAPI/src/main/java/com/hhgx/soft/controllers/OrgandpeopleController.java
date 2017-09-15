package com.hhgx.soft.controllers;

import java.io.IOException;
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
import com.hhgx.soft.services.OrgandpeopleService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.GetRequestJsonUtils;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;
import com.hhgx.soft.utils.UUIDGenerator;


@RequestMapping("/Organdpeople")
@Controller
public class OrgandpeopleController {

@Autowired
private OrgandpeopleService organdpeopleService;

@RequestMapping(value="/getequipmentdetail", method =RequestMethod.POST)
@ResponseBody
public String getequipmentdetail(HttpServletRequest request) throws IOException{
	String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
	
	Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody,"EquipmentID");

	List<Map<String, String>> lmList = null;
	int statusCode=-1;
	try {
		
		lmList = organdpeopleService.getequipmentdetail(map.get("equipmentID"));
		statusCode = ConstValues.OK;
	} catch (Exception e) {
		statusCode = ConstValues.FAILED;
		e.printStackTrace();
	}
	return ResponseJson.responseFindPageJsonArray(lmList, statusCode,lmList.size());
	
}	
@RequestMapping(value="/GetequipmentList", method =RequestMethod.POST)
@ResponseBody
public String getEquipmentList(HttpServletRequest request) throws IOException{
	String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

	Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody,"orgid","PageIndex");
	String orgid = map.get("orgid");
	orgid="110101000001";
	String pageIndex = map.get("pageIndex");
	int statusCode = -1;
	List<Map<String, String>> lmList = null;
	Page page = null;
	int totalCount = organdpeopleService.getEquipmentListCount(orgid);
	try {
		if (!StringUtils.isEmpty(pageIndex)) {
			page = new Page(totalCount, Integer.parseInt(pageIndex));
			lmList = organdpeopleService.getEquipmentList(orgid, page.getStartPos(), page.getPageSize());

		} else {
			page = new Page(totalCount, 1);
			lmList = organdpeopleService.getEquipmentList(orgid, page.getStartPos(), page.getPageSize());
		}

		statusCode = ConstValues.OK;
} catch (Exception e) {
	statusCode = ConstValues.FAILED;
	e.printStackTrace();
}
	return ResponseJson.responseFindPageJsonArray(lmList, statusCode, totalCount);

}	

@RequestMapping(value="/GetEquipmentType", method =RequestMethod.POST)
@ResponseBody
public String getEquipmentType(HttpServletRequest request) throws IOException {
	List<String> lmList = null;
	int statusCode = -1;
	try {
		
		lmList = organdpeopleService.getEquipmentType();
		statusCode = ConstValues.OK;
		
	} catch (Exception e) {
		e.printStackTrace();
		statusCode = ConstValues.FAILED;
	}
	
	return ResponseJson.responseFindJsonArray(lmList, statusCode);

}



@ResponseBody
@RequestMapping(value = "/Addequipment", method = RequestMethod.POST)
public String addequipment(HttpServletRequest request) throws IOException {
	String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

	Map<String, String> map = RequestJson.reqOriginJson(reqBody, 
			"equipmentName", "equipmenttype", "equipmentmodel",
			"equipmentNum", "isGood", "BuyDate");
	String dataBag = null;
	int statusCode = -1;

	try{
		map.put("orgid", "110101000001");
		map.put("equipmentID", UUIDGenerator.getUUID());
		organdpeopleService.addEquipment(map);
		statusCode = ConstValues.OK;
		dataBag = ConstValues.SUCCESS;
	} catch (Exception e) {
		e.printStackTrace();
		statusCode = ConstValues.FAILED;
		dataBag = ConstValues.FIALURE;
	}
	return ResponseJson.responseAddJson(dataBag, statusCode);

}

@ResponseBody
@RequestMapping(value = "/updateequipment", method = RequestMethod.POST)
public String updateequipment(HttpServletRequest request) throws IOException {
	String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
	Map<String, String> map = RequestJson.reqOriginJson(reqBody, 
			"equipmentName", "equipmenttype", "equipmentmodel",
			"equipmentNum", "isGood", "BuyDate","EquipmentID");
	String dataBag = null;
	int statusCode = -1;
	
	try{
		organdpeopleService.updateequipment(map);
		statusCode = ConstValues.OK;
		dataBag = ConstValues.SUCCESS_;
	} catch (Exception e) {
		e.printStackTrace();
		statusCode = ConstValues.FAILED;
		dataBag = ConstValues.FIALURE_;
	}
	return ResponseJson.responseAddJson(dataBag, statusCode);
	
}

@ResponseBody
@RequestMapping(value = "/deleteequipment", method = RequestMethod.POST)
public String deleteEquipment(HttpServletRequest request) throws IOException {
	String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
	
	Map<String, String> map = RequestJson.reqOriginJson(reqBody, "EquipmentID");
	
	String dataBag = null;
	int statusCode = -1;
	
	try{
		organdpeopleService.deleteEquipment(map.get("EquipmentID"));
		statusCode = ConstValues.OK;
		dataBag = ConstValues.SUCCESSDEL;
	} catch (Exception e) {
		e.printStackTrace();
		statusCode = ConstValues.FAILED;
		dataBag = ConstValues.FIALUREDEL;
	}
	return ResponseJson.responseAddJson(dataBag, statusCode);
	
}




}
