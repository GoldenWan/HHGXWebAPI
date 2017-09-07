package com.hhgx.soft.services;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hhgx.soft.entitys.FireDevice;
import com.hhgx.soft.entitys.Firesystype;
import com.hhgx.soft.entitys.Manoeuvre;
import com.hhgx.soft.entitys.Training;
import com.hhgx.soft.mappers.FacilityMapper;

@Service
@Transactional
public class FacilityService {
@Autowired
private FacilityMapper facilityMapper;

public void deleteTraining(String trainingID) {
	facilityMapper.deleteTraining(trainingID);	
}

public List<Training> getTrainingList(String orgid, Timestamp startTime, Timestamp endTime, int startPos, int pageSize) {
	return facilityMapper.getTrainingList(orgid, startTime,endTime, startPos,pageSize);
}

public int getTrainingListCount(String orgid, Timestamp startTime, Timestamp endTime) {
	return facilityMapper.getTrainingListCount(orgid, startTime, endTime);
}

public int getManoeuvreCount(String orgid, Timestamp startTime, Timestamp endTime) {
	return facilityMapper.getManoeuvreCount(orgid,startTime,endTime);
}

public List<Manoeuvre> getManoeuvreByOrgid(String orgid,Timestamp startTime, Timestamp endTime, int startPos, int pageSize) {
	return facilityMapper.getManoeuvreByOrgid(orgid, startTime, endTime,startPos, pageSize);
}

public Manoeuvre getManoeuvreDetail(String manoeuvreID) {
	return facilityMapper.getManoeuvreDetail(manoeuvreID);
}

public void deleteManoeuvre(String manoeuvreID) {
	 facilityMapper.deleteManoeuvre(manoeuvreID);	
}

public Training getTraingingDetail(String trainingID) {
	return facilityMapper.getTraingingDetail(trainingID);
}

public List<Firesystype> getAllSys() {
	return facilityMapper.getAllSys();
}

public List<Map<String, String>> getDeviceType() {
	return facilityMapper.getDeviceType();
}


public int getFireDeviceBySysCount(String orgid, String vSysdesc) {
	return facilityMapper.getFireDeviceBySysCount(orgid, vSysdesc) ;
}

public List<Map<String, Object>> getFireDeviceListBySys(String orgid, String vSysdesc, int startPos,
		int pageSize) {
	return facilityMapper.getFireDeviceListBySys(orgid, vSysdesc, startPos,pageSize);
}

public int getFireDeviceByDeviceCount(String orgid, String deviceNo) {
	return facilityMapper.getFireDeviceByDeviceCount(orgid, deviceNo);
}

public List<Map<String, Object>> getFireDeviceListByDevice(String orgid, String deviceNo, int startPos,
		int pageSize) {
	return facilityMapper.getFireDeviceListByDevice(orgid, deviceNo, startPos, pageSize);
}

public List<Map<String, Object>> getFireDeviceListByDeviceNo(String deviceNo) {
	return facilityMapper.getFireDeviceListByDeviceNo(deviceNo);
}

public void updateFireDevice(FireDevice fireDevice) {
	facilityMapper.updateFireDevice(fireDevice);
}

public void addFireDevice(FireDevice fireDevice) {
	facilityMapper.addFireDevice(fireDevice);
}

public void deleteFireDeviceList(String deviceNo) {
	facilityMapper.deleteFireDeviceList(deviceNo);
}

public void delFireDeviceChangeRecord(String deviceNo) {
	facilityMapper.delFireDeviceChangeRecord(deviceNo);
	
} 
	
}
