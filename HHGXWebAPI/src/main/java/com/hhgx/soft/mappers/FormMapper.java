package com.hhgx.soft.mappers;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.BusinessLicence;
import com.hhgx.soft.entitys.Manoeuvre;
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

	
	
}
