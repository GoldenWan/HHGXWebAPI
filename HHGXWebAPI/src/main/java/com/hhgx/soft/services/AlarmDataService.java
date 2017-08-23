package com.hhgx.soft.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.entitys.FireAlarm;
import com.hhgx.soft.mappers.AlarmDataMapper;

@Service
public class AlarmDataService {

	@Autowired
	private AlarmDataMapper alarmDataMapper;

	public int getfireAlarmCount(String orgid, String cAlarmtype) {
		return alarmDataMapper.getfireAlarmCount(orgid, cAlarmtype);
	}

	public List<FireAlarm> findFireAlarm(String orgid, String cAlarmtype, int startPos, int pageSize) {
		return alarmDataMapper.findFireAlarm(orgid, cAlarmtype, startPos,  pageSize);
	} 
	
}
