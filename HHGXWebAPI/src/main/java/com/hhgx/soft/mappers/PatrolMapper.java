package com.hhgx.soft.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.FireSafetyCheck;
import com.hhgx.soft.entitys.PatrolRecord;
import com.hhgx.soft.entitys.UserCheckInfo;

@MapperScan
@Component("/patrolMapper")
public interface PatrolMapper {

	int gePatrolRecordByOrgCount(@Param("orgID") String orgID, @Param("startDate") String startDate,
			@Param("endTime") String EndDate);

	List<PatrolRecord> getPatrolRecordByOrg(@Param("orgID") String orgID, @Param("startDate") String startDate,
			@Param("endTime") String EndDate, @Param("startPos") int startPos, @Param("pageSize") int pageSize);


	void addUserCheckList(@Param("userCheckId") String userCheckId, @Param("orgID") String orgID,
			@Param("userCheckTime") String userCheckTime, @Param("orgUser") String orgUser,
			@Param("orgManagerId") String orgManagerId, @Param("submitTime") String submitTime);

	void addUserCheckInfoByOrgid(@Param("userCheckId") String userCheckId, @Param("orgID") String orgID);

	void updateUserCheckList(@Param("userCheckId") String userCheckId, @Param("userCheckTime") String userCheckTime);

	List<UserCheckInfo> findNullUserCheckInfo(@Param("userCheckId") String userCheckId);

	void updateSubmitState(@Param("userCheckId") String userCheckId, @Param("submitState") String submitState);

	int fireSafetyCheckCount(@Param("orgid") String orgid,@Param("startTime")String startTime, @Param("endTime") String endTime);

	List<FireSafetyCheck> getfireSafetyCheckByOrgid(@Param("orgid") String orgid, @Param("startTime")String startTime, @Param("endTime") String endTime, @Param("startPos") int startPos,
			@Param("pageSize") int pageSize);

	FireSafetyCheck fireSafetyCheckDetail(@Param("fireSafetyCheckID")String fireSafetyCheckID);

	void editFireSafetyCheck(FireSafetyCheck fireSafetyCheck);

	void addFireSafetyCheck(FireSafetyCheck fireSafetyCheck);

	int findFireSafetyCheckID(@Param("fireSafetyCheckID")String fireSafetyCheckID);

	void deleteFireSafetyCheck(@Param("fireSafetyCheckID")String fireSafetyCheckID);

	void deleteFireSafetyCheckByOrgid(@Param("orgid")String orgid);

	void deleteUserCheckpic(@Param("userCheckId") String userCheckId);
	void deleteUserCheckinfo(@Param("userCheckId") String userCheckId);
	void deleteUserCheckList(@Param("userCheckId") String userCheckId);

	void deleteWBdevicerepairinfo_patrol(@Param("userCheckId") String userCheckId);

	List<String> findUserCheckpic(@Param("userCheckId")String userCheckId);

}
