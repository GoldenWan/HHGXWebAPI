package com.hhgx.soft.services;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hhgx.soft.entitys.EventInfo;
import com.hhgx.soft.entitys.FireDealInfo;
import com.hhgx.soft.mappers.AlarmDataMapper;

@Service
@Transactional
public class AlarmDataService {

	@Autowired
	private AlarmDataMapper alarmDataMapper;

	public int getfireAlarmCount(String orgid, String cAlarmtype, String siteid, Timestamp startTime,
			Timestamp endTime) {
		return alarmDataMapper.getfireAlarmCount(orgid, cAlarmtype, siteid, startTime, endTime);
	}

	public List<Map<String, String>> findFireAlarm(String orgid, String cAlarmtype, String siteid, Timestamp startTime,
			Timestamp endTime, int startPos, int pageSize) {
		return alarmDataMapper.findFireAlarm(orgid, cAlarmtype, siteid, startTime, endTime, startPos, pageSize);
	}

	public List<Map<String, String>> findRecentAlarmInfo(String orgid, String cAlarmtype) {
		return alarmDataMapper.findRecentAlarmInfo(orgid, cAlarmtype);
	}

	public int getAlarmDataListCount(String orgid, String cAlarmtype, Timestamp startTime, Timestamp endTime) {
		return alarmDataMapper.getAlarmDataListCount(orgid, cAlarmtype, startTime, endTime);
	}

	public List<Map<String, String>> getAlarmDataList(String orgid, String cAlarmtype, Timestamp startTime,
			Timestamp endTime, int startPos, int pageSize) {
		return alarmDataMapper.getAlarmDataList(orgid, cAlarmtype, startTime, endTime, startPos, pageSize);
	}

	public List<FireDealInfo> fireDealInfo(String firealarmid) {
		return alarmDataMapper.fireDealInfo(firealarmid);
	}

	public List<FireDealInfo> fireUnDealInfo(String firealarmid, String cAlarmtype) {
		return alarmDataMapper.fireUnDealInfo(firealarmid, cAlarmtype);
	}

	@Transactional
	public void fireDetail(String firealarmid, String username, String checkdesc, String checkresult, String ynRequest) {
		EventInfo eventInfo = alarmDataMapper.findAlarmById(firealarmid);
		alarmDataMapper.deleteAlarmDataById(firealarmid);
		alarmDataMapper.addAlarmDataByID(firealarmid, username, checkdesc, checkresult, eventInfo,ynRequest);
	}

}
