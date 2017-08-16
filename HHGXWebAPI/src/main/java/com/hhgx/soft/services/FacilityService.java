package com.hhgx.soft.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.entitys.Manoeuvre;
import com.hhgx.soft.entitys.Training;
import com.hhgx.soft.mappers.FacilityMapper;

@Service
public class FacilityService {
@Autowired
private FacilityMapper facilityMapper;

public void deleteTraining(String trainingID) {
	facilityMapper.deleteTraining(trainingID);	
}

public List<Training> getTrainingList(String orgid, String startTime, String endTime, int startPos, int pageSize) {
	return facilityMapper.getTrainingList(orgid, startTime,endTime, startPos,pageSize);
}

public int getTrainingListCount(String orgid) {
	return facilityMapper.getTrainingListCount(orgid);
}

public int getManoeuvreCount(String orgid) {
	return facilityMapper.getManoeuvreCount(orgid);
}

public List<Manoeuvre> getManoeuvreByOrgid(String orgid, int startPos, int pageSize) {
	return facilityMapper.getManoeuvreByOrgid(orgid, startPos, pageSize);
}

public Manoeuvre getManoeuvreDetail(String manoeuvreID) {
	return facilityMapper.getManoeuvreDetail(manoeuvreID);
}

public void deleteManoeuvre(String manoeuvreID) {
	 facilityMapper.deleteManoeuvre(manoeuvreID);	
} 
	
}