package com.hhgx.soft.controllers;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.hhgx.soft.entitys.OnDutyRecord;
import com.hhgx.soft.services.OnDutyRecordService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.DateUtils;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;
import com.hhgx.soft.utils.UUIDGenerator;

@Controller
@RequestMapping("/OnDutyRecord")
public class OnDutyRecordController {
	@Autowired
	private OnDutyRecordService onDutyRecordService;

	/**
	 * 87.新增值班记录
	 */

	@ResponseBody
	@RequestMapping(value = "/AddOnDutyRecord", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String addOnDutyRecord(@RequestBody String reqBody) throws JsonProcessingException {
		Map<String, String> map = RequestJson.reqJson(reqBody, "orgid", "FireControlor", "gangcontrolor",
				"ProcessResult", "ControlorModel", "selfcheck    ", "eliminateVoice", "Reset        ", "MainPower    ",
				"SecondPower", "Faulthandling", "CheckPeople", "DutySignID");
		String orgid = map.get("orgid");
		String recordID = UUIDGenerator.getUUID();
		String recordTime = DateUtils.timesstampToString();
		String fireControlor = map.get("fireControlor");
		String gangcontrolor = map.get("gangcontrolor");
		String processResult = map.get("processResult");
		String controlorModel = map.get("controlorModel");
		String selfcheck = map.get("selfcheck");
		String eliminateVoice = map.get("eliminateVoice");
		String reset = map.get("reset");
		String mainPower = map.get("mainPower");
		String secondPower = map.get("secondPower");
		String faulthandling = map.get("faulthandling");
		String checkPeople = map.get("CheckPeople");
		String dutySign = map.get("DutySign");
		OnDutyRecord onDutyRecord = new OnDutyRecord();
		onDutyRecord.setOrgid(orgid);
		onDutyRecord.setRecordID(recordID);
		onDutyRecord.setRecordTime(recordTime);
		onDutyRecord.setFireControlor(fireControlor);
		onDutyRecord.setGangcontrolor(gangcontrolor);
		onDutyRecord.setProcessResult(processResult);
		onDutyRecord.setControlorModel(controlorModel);
		onDutyRecord.setSelfcheck(selfcheck);
		onDutyRecord.setEliminateVoice(eliminateVoice);
		onDutyRecord.setCheckPeople(checkPeople);
		onDutyRecord.setFaulthandling(faulthandling);
		onDutyRecord.setMainPower(mainPower);
		onDutyRecord.setSecondPower(secondPower);
		onDutyRecord.setReset(reset);
		onDutyRecord.setDutySign(dutySign);

		int statusCode = -1;
		String dataBag = null;
		try {
			onDutyRecordService.addOnDutyRecord(onDutyRecord);
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
	 * 8.编辑值班记录获取编辑详情
	 */
	@ResponseBody
	@RequestMapping(value = "/EditOnDutyRecordInfo", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String editOnDutyRecordInfo(@RequestBody String reqBody) throws JsonProcessingException {
		Map<String, String> map = RequestJson.reqJson(reqBody,"RecordID", "RecordTime","FireControlor", "gangcontrolor",
				"ProcessResult", "ControlorModel", "selfcheck    ", "eliminateVoice", "Reset        ", "MainPower    ",
				"SecondPower", "Faulthandling", "CheckPeople", "DutySignID");
		
		String recordID =map.get("recordID");
		String recordTime =map.get("recordTime");
		String fireControlor = map.get("fireControlor");
		String gangcontrolor = map.get("gangcontrolor");
		String processResult = map.get("processResult");
		String controlorModel = map.get("controlorModel");
		String selfcheck = map.get("selfcheck");
		String eliminateVoice = map.get("eliminateVoice");
		String reset = map.get("reset");
		String mainPower = map.get("mainPower");
		String secondPower = map.get("secondPower");
		String faulthandling = map.get("faulthandling");
		String checkPeople = map.get("CheckPeople");
		String dutySign = map.get("DutySign");
		OnDutyRecord onDutyRecord = new OnDutyRecord();
		onDutyRecord.setRecordID(recordID);
		onDutyRecord.setRecordTime(recordTime);
		onDutyRecord.setFireControlor(fireControlor);
		onDutyRecord.setGangcontrolor(gangcontrolor);
		onDutyRecord.setProcessResult(processResult);
		onDutyRecord.setControlorModel(controlorModel);
		onDutyRecord.setSelfcheck(selfcheck);
		onDutyRecord.setEliminateVoice(eliminateVoice);
		onDutyRecord.setCheckPeople(checkPeople);
		onDutyRecord.setFaulthandling(faulthandling);
		onDutyRecord.setMainPower(mainPower);
		onDutyRecord.setSecondPower(secondPower);
		onDutyRecord.setReset(reset);
		onDutyRecord.setDutySign(dutySign);

		int statusCode = -1;
		String dataBag = null;
		try {
			onDutyRecordService.editOnDutyRecordInfo(onDutyRecord);
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
	 * 
	 */
	
	

}