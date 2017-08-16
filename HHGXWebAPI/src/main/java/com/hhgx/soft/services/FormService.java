package com.hhgx.soft.services;

import org.springframework.stereotype.Service;

import com.hhgx.soft.entitys.Manoeuvre;
import com.hhgx.soft.entitys.Training;
import com.hhgx.soft.entitys.UserCheckInfo;
import com.hhgx.soft.entitys.UserCheckPic;
import com.hhgx.soft.mappers.FormMapper;

@Service
public class FormService {

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
	
}
