package com.hhgx.soft.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.entitys.BusinessLicence;
import com.hhgx.soft.entitys.Manoeuvre;
import com.hhgx.soft.entitys.SafeDuty;
import com.hhgx.soft.entitys.SafeManageRules;
import com.hhgx.soft.entitys.Training;
import com.hhgx.soft.entitys.UserCheckInfo;
import com.hhgx.soft.entitys.UserCheckPic;
import com.hhgx.soft.mappers.FormMapper;

@Service
public class FormService {

	@Autowired
	private FormMapper formMapper;

	public String findPicType(String ID) {
		return formMapper.findPicType(ID);
	}

	public void addOrUpdateCheckRecord(UserCheckInfo userCheckInfo) {
		formMapper.addOrUpdateCheckRecord(userCheckInfo);		
	}

	public void deletePicByID(String ID) {
		formMapper.deletePicByID(ID);
		
	}

	public void addUserCheckPic(UserCheckPic userCheckPic) {
		formMapper.addUserCheckPic(userCheckPic);		
	}

	public void addTraining(Training training) {
		formMapper.addTraining(training);
	}

	public void updateTraining(Training training) {
		formMapper.updateTraining(training);		
	}

	public void addManoeuvre(Manoeuvre manoeuvre) {
		formMapper.addManoeuvre(manoeuvre);
	}

	public void updateManoeuvre(Manoeuvre manoeuvre) {
		formMapper.updateManoeuvre(manoeuvre);
	}

	public void addSafeManageRules(SafeManageRules safeManageRules) {
		formMapper.addSafeManageRules(safeManageRules);
	}

	public String findFilePath(String safeManageRulesID) {
		return formMapper.findFilePath(safeManageRulesID);
	}

	public void updateSafeManageRules(SafeManageRules safeManageRules) {
		formMapper.updateSafeManageRules(safeManageRules);	
	}

	public void addSafeDuty(SafeDuty safeDuty) {
		formMapper.addSafeDuty(safeDuty);
	}

	public String findSafeDutyFilePath(String safeDutyID) {
		return formMapper.findSafeDutyFilePath(safeDutyID);
	}

	public void updateSafeDuty(SafeDuty safeDuty) {
		formMapper.updateSafeDuty(safeDuty);
	}

	public void addBusinessLicence(BusinessLicence businessLicence) {
		formMapper.addBusinessLicence(businessLicence);
	}
	
}
