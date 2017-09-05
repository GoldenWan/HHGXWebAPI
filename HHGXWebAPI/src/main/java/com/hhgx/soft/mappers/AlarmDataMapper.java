package com.hhgx.soft.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.FireAlarm;

@Component
@MapperScan("/alarmDataMapper")
public interface AlarmDataMapper {

	int getfireAlarmCount(@Param("orgid")String orgid, @Param("cAlarmtype")String cAlarmtype);
	List<FireAlarm> findFireAlarm(@Param("orgid")String orgid, @Param("cAlarmtype")String cAlarmtype, 
			@Param("startPos")int startPos, @Param("pageSize")int pageSize);
	
	Map<String, String> findRecentAlarmInfo(@Param("orgid")String orgid, @Param("cAlarmtype")String cAlarmtype);

	
}
