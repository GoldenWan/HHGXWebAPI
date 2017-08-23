package com.hhgx.soft.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.controllers.FireAlarm;

@Component
@MapperScan("/alarmDataMapper")
public interface AlarmDataMapper {

	int getfireAlarmCount(@Param("orgid")String orgid, @Param("cAlarmtype")String cAlarmtype);
	List<FireAlarm> findFireAlarm(@Param("orgid")String orgid, @Param("cAlarmtype")String cAlarmtype, 
			@Param("startPos")int startPos, @Param("pageSize")int pageSize);

	
}
