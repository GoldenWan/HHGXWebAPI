package com.hhgx.soft.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.PatrolRecord;


@MapperScan
@Component("/patrolMapper")
public interface PatrolMapper {

	int gePatrolRecordByOrgCount(@Param("orgID") String orgID, @Param("startDate") String startDate,
			@Param("EndDate") String EndDate);

	List<PatrolRecord> getPatrolRecordByOrg(@Param("orgID") String orgID, @Param("startDate") String startDate,
			@Param("EndDate") String EndDate, @Param("startPos") int startPos, @Param("pageSize") int pageSize);

}
