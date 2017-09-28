package com.hhgx.soft.mappers;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.FireDevice;
import com.hhgx.soft.entitys.Firesystype;
import com.hhgx.soft.entitys.Manoeuvre;
import com.hhgx.soft.entitys.Training;

@Component
@MapperScan("facilityMapper")
public interface FacilityMapper {

	int getTrainingListCount(@Param("orgid") String orgid, @Param("startTime") Timestamp startTime,
			@Param("endTime") Timestamp endTime);

	List<Training> getTrainingList(@Param("orgid") String orgid, @Param("startTime") Timestamp startTime,
			@Param("endTime") Timestamp endTime, @Param("startPos") int startPos, @Param("pageSize") int pageSize);

	void deleteTraining(@Param("trainingID") String trainingID);

	int getManoeuvreCount(@Param("orgid") String orgid,  @Param("startTime") Timestamp startTime,  @Param("endTime") Timestamp endTime);

	List<Manoeuvre> getManoeuvreByOrgid(@Param("orgid") String orgid,  @Param("startTime") Timestamp startTime,  @Param("endTime") Timestamp endTime,@Param("startPos") int startPos,
			@Param("pageSize") int pageSize);

	Manoeuvre getManoeuvreDetail(@Param("manoeuvreID") String manoeuvreID);

	void deleteManoeuvre(@Param("manoeuvreID") String manoeuvreID);

	Training getTraingingDetail(@Param("trainingID") String trainingID);

	List<Firesystype> getAllSys();

	List<Map<String, String>> getDeviceType();

	
	int getFireDeviceBySysCount(@Param("orgid")String orgid, @Param("vSysdesc")String vSysdesc);

	List<Map<String, Object>> getFireDeviceListBySys(@Param("orgid")String orgid, @Param("vSysdesc")String vSysdesc, @Param("startPos") int startPos, @Param("pageSize") int pageSize);

	int getFireDeviceByDeviceCount(@Param("orgid")String orgid, @Param("deviceNo")String deviceNo);

	List<Map<String, Object>> getFireDeviceListByDevice(@Param("orgid")String orgid, @Param("deviceNo")String deviceNo, @Param("startPos") int startPos, @Param("pageSize") int pageSize);

	List<Map<String, Object>> getFireDeviceListByDeviceNo(String deviceNo);

	void updateFireDevice(FireDevice fireDevice);

	void addFireDevice(FireDevice fireDevice);

	void deleteFireDeviceList(String deviceNo);

	void delFireDeviceChangeRecord(String deviceNo);

	void deleteFireDeviceCheckRecord(String deviceNo);

	List<Map<String, String>> getSiteExceptSys(@Param("siteid")String siteid, @Param("tiSysType")String tiSysType);

}
