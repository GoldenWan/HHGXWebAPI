package com.hhgx.soft.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hhgx.soft.entitys.Appearancepic;
import com.hhgx.soft.entitys.BusinessLicence;
import com.hhgx.soft.entitys.Flatpic;
import com.hhgx.soft.entitys.Manoeuvre;
import com.hhgx.soft.entitys.OnlineFiresystem;
import com.hhgx.soft.entitys.SafeDuty;
import com.hhgx.soft.entitys.SafeManageRules;
import com.hhgx.soft.entitys.Training;
import com.hhgx.soft.entitys.UpdateFireSystem;
import com.hhgx.soft.entitys.UserCheckInfo;
import com.hhgx.soft.entitys.UserCheckPic;
import com.hhgx.soft.entitys.model.People;
import com.hhgx.soft.mappers.FormMapper;

@Service
@Transactional
public class FormService {

	@Autowired
	private FormMapper formMapper;

	public String findPicType(String ID) {
		return formMapper.findPicType(ID);
	}

	public void addOrUpdateCheckRecord(UserCheckInfo userCheckInfo) {
		formMapper.addOrUpdateCheckRecord(userCheckInfo);		
	}

	public void addorgSys(OnlineFiresystem onlineFiresystem) {
		formMapper.addorgSys(onlineFiresystem);		
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

	public void updateFireSystemList(UpdateFireSystem updateFireSystem) {
		formMapper.updateFireSystemList(updateFireSystem);
	}

	public void addflatPic(Flatpic flatpic) {
		formMapper.addflatPic(flatpic);
	}

	public boolean eixstLicenceCode(String licenceCode) {
		return formMapper.eixstLicenceCode(licenceCode)>0 ? true:false;
	}

	public void updateBusinessLicence(BusinessLicence businessLicence) {
		formMapper.updateBusinessLicence(businessLicence);
	}

	public void addAppearance(Appearancepic appearancepic) {
		formMapper.addAppearance(appearancepic);
	}

	public void submitTotalFlatPic(String bflatpic, String orgid) {
		formMapper.submitTotalFlatPic( bflatpic,  orgid);
		
	}

	public String findCflatPic(String cFlatPic) {
		return formMapper.findCflatPic(cFlatPic);
	}

	public void updateflatPic(Flatpic flatpic) {
		formMapper.updateflatPic(flatpic);	
	}

	public boolean existOrgSys(String siteid, String tiSysType) {
		return formMapper.existOrgSys(siteid, tiSysType) > 0?true:false;
	}

	public void uploadOrgSummaryPic(String vPicturePath, String orgid) {
		formMapper.uploadOrgSummaryPic(vPicturePath, orgid);
	}

	public String findIntroducePath(String orgid) {
		return formMapper.findIntroducePath(orgid);
	}

	public void deleteLicenceCode(String orgid) {
		formMapper.deleteLicenceCode(orgid);
	}

	public List<String> findLicencePathUrl(String orgid) {
		return formMapper.findLicencePathUrl(orgid);
	}

	public void updateUserPic(String userPic1, String userID) {
		formMapper.updateUserPic(userPic1, userID);
	}

	public void AddPeople(People people) {
		// TODO Auto-generated method stub
		
	}

}
