package com.hhgx.soft.services;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hhgx.soft.entitys.FireAlarm;
import com.hhgx.soft.mappers.AlarmDataMapper;

@Service
@Transactional
public class AlarmDataService {

	@Autowired
	private AlarmDataMapper alarmDataMapper;

	public int getfireAlarmCount(String orgid, String cAlarmtype) {
		return alarmDataMapper.getfireAlarmCount(orgid, cAlarmtype);
	}

	public List<FireAlarm> findFireAlarm(String orgid, String cAlarmtype, int startPos, int pageSize) {
		return alarmDataMapper.findFireAlarm(orgid, cAlarmtype, startPos,  pageSize);
	}

	public Map<String, String> findRecentAlarmInfo(String orgid, String cAlarmtype) {
		return alarmDataMapper.findRecentAlarmInfo(orgid,cAlarmtype);
	} 
	
}
