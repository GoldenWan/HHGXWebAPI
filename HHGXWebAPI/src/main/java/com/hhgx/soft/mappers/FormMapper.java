package com.hhgx.soft.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

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

@Component
@MapperScan(value="/formMapper")
public interface FormMapper {

	String findPicType(@Param("picID") String ID);

	void addOrUpdateCheckRecord(UserCheckInfo userCheckInfo);

	void deletePicByID(@Param("picID") String ID);

	void addUserCheckPic(UserCheckPic userCheckPic);

	void addTraining(Training training);

	void updateTraining(Training training);

	void addManoeuvre(Manoeuvre manoeuvre);

	void updateManoeuvre(Manoeuvre manoeuvre);

	void addSafeManageRules(SafeManageRules safeManageRules);

	String findFilePath(@Param("safeManageRulesID") String safeManageRulesID);

	void updateSafeManageRules(SafeManageRules safeManageRules);

	void addSafeDuty(SafeDuty safeDuty);

	String findSafeDutyFilePath(@Param("safeDutyID")String safeDutyID);

	void updateSafeDuty(SafeDuty safeDuty);

	void addBusinessLicence(BusinessLicence businessLicence);

	void updateFireSystemList(UpdateFireSystem updateFireSystem);

	void addflatPic(Flatpic flatpic);

	int eixstLicenceCode(String licenceCode);

	void updateBusinessLicence(BusinessLicence businessLicence);

	void addAppearance(Appearancepic appearancepic);

	void submitTotalFlatPic(@Param("bFlatpic")String bFlatpic, @Param("orgid")String orgid);

	String findCflatPic(String cFlatPic);

	void updateflatPic(Flatpic flatpic);

	void addorgSys(OnlineFiresystem onlineFiresystem);

	int existOrgSys(@Param("siteid")String siteid, @Param("tiSysType")String tiSysType);

	void uploadOrgSummaryPic(@Param("vPicturePath") String vPicturePath, @Param("orgid")String orgid);

	String findIntroducePath(String orgid);

	void deleteLicenceCode(String orgid);

	List<String> findLicencePathUrl(String orgid);

	void updateUserPic(@Param("userPic")String userPic1, @Param("userID")String userID);

	
	
}
