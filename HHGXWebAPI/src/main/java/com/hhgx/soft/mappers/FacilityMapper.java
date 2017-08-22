package com.hhgx.soft.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.Firesystype;
import com.hhgx.soft.entitys.Manoeuvre;
import com.hhgx.soft.entitys.Training;

@Component
@MapperScan("facilityMapper")
public interface FacilityMapper {

	int getTrainingListCount(@Param("orgid") String orgid, @Param("startTime") String startTime,
			@Param("endTime") String endTime);

	List<Training> getTrainingList(@Param("orgid") String orgid, @Param("startTime") String startTime,
			@Param("endTime") String endTime, @Param("startPos") int startPos, @Param("pageSize") int pageSize);

	void deleteTraining(@Param("trainingID") String trainingID);

	int getManoeuvreCount(@Param("orgid") String orgid);

	List<Manoeuvre> getManoeuvreByOrgid(@Param("orgid") String orgid, @Param("startPos") int startPos,
			@Param("pageSize") int pageSize);

	Manoeuvre getManoeuvreDetail(@Param("manoeuvreID") String manoeuvreID);

	void deleteManoeuvre(@Param("manoeuvreID") String manoeuvreID);

	Training getTraingingDetail(@Param("trainingID") String trainingID);

	List<Firesystype> getAllSys();

}
