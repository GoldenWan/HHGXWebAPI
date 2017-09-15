package com.hhgx.soft.mappers;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.EventInfo;
import com.hhgx.soft.entitys.FireDealInfo;


@Component
@MapperScan("/alarmDataMapper")
public interface AlarmDataMapper {

	int getfireAlarmCount(@Param("orgid")String orgid, @Param("cAlarmtype")String cAlarmtype, @Param("siteid")String siteid, @Param("startTime")Timestamp startTime, @Param("endTime")Timestamp endTime);
	List<Map<String, String>> findFireAlarm(@Param("orgid")String orgid, @Param("cAlarmtype")String cAlarmtype, 
			@Param("siteid")String siteid, @Param("startTime")Timestamp startTime, @Param("endTime")Timestamp endTime, @Param("startPos")int startPos, @Param("pageSize")int pageSize);
	
	List<Map<String, String>> findRecentAlarmInfo(@Param("orgid")String orgid, @Param("cAlarmtype")String cAlarmtype);
	int getAlarmDataListCount(@Param("orgid")String orgid, @Param("cAlarmtype")String cAlarmtype, @Param("startTime")Timestamp startTime, @Param("endTime")Timestamp endTime);
	List<Map<String, String>> getAlarmDataList(@Param("orgid")String orgid, @Param("cAlarmtype")String cAlarmtype, @Param("startTime")Timestamp startTime, @Param("endTime")Timestamp endTime,
			 @Param("startPos")int startPos, @Param("pageSize")int pageSize);
	List<FireDealInfo> fireDealInfo(@Param("firealarmid")String firealarmid);
	List<String> findPicPathById(String siteid);
	List<FireDealInfo> fireUnDealInfo(@Param("firealarmid")String firealarmid, @Param("cAlarmtype")String cAlarmtype);
	void deleteAlarmDataById(String firealarmid);
	void addAlarmDataByID(@Param(value="firealarmid")String firealarmid, @Param(value="username")String username, @Param("checkdesc")String checkdesc, @Param("checkresult")String checkresult, @Param("eventInfo")EventInfo eventInfo, @Param("ynRequest")String ynRequest);
	EventInfo findAlarmById(String firealarmid);

	
	
}
