package com.hhgx.soft.mappers;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.Training;
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

	
	
}