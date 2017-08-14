package com.hhgx.soft.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
}
