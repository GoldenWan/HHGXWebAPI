package com.hhgx.soft.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.hhgx.soft.entitys.Manoeuvre;
import com.hhgx.soft.mappers.AlarmDataMapper;

@Service
public class AlarmDataService {

	private AlarmDataMapper alarmDataMapper;

	/*public int getfireAlarmCount(String orgid, String cAlarmtype) {
		return alarmDataMapper.getfireAlarmCount(orgid, cAlarmtype);
	}

	public List<Manoeuvre> fireAlarm(String orgid, String cAlarmtype, int startPos, int pageSize) {
		return alarmDataMapper.fireAlarm(orgid, cAlarmtype);
	} 
	*/
}
