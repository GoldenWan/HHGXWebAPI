package com.hhgx.soft.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.Manoeuvre;

@Component
@MapperScan
public interface AlarmDataMapper {

	//int getfireAlarmCount(@Param("orgid")String orgid, @Param("cAlarmtype")String cAlarmtype, );

	//List<Manoeuvre> fireAlarm(@Param("orgid")String orgid, @Param("cAlarmtype")String cAlarmtype);

	
}
