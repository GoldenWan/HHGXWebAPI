package com.hhgx.soft.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.PatrolRecord;


@MapperScan
@Component("/patrolMapper")
public interface PatrolMapper {

	int gePatrolRecordByOrgCount(@Param("orgID") String orgID);

	List<PatrolRecord> getPatrolRecordByOrg(@Param("orgID") String orgID, @Param("startDate") String startDate,
			@Param("endTime") String EndDate, @Param("startPos") int startPos, @Param("pageSize") int pageSize);

	void deleteCheckRecord(@Param("userCheckId") String userCheckId);

	void addUserCheckList(@Param("userCheckId") String userCheckId, @Param("orgID") String orgID, @Param("userCheckTime") String userCheckTime, @Param("orgUser")String orgUser, @Param("orgManagerId") String orgManagerId);

	void addUserCheckInfoByOrgid(@Param("userCheckId") String userCheckId, @Param("orgID") String orgID);

	void updateUserCheckList(@Param("userCheckId")String userCheckId, @Param("userCheckTime")String userCheckTime);

}
