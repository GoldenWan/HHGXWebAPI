package com.hhgx.soft.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.hhgx.soft.entitys.FireSafetyCheck;
import com.hhgx.soft.entitys.PatrolRecord;
import com.hhgx.soft.entitys.UserCheckInfo;
import com.hhgx.soft.mappers.PatrolMapper;

@Service
public class PatrolService {

	@Autowired
	private PatrolMapper patrolMapper;

	public int gePatrolRecordByOrgCount(String orgID, String startDate, String endDate) {
		return patrolMapper.gePatrolRecordByOrgCount(orgID, startDate, endDate);
	}

	public List<PatrolRecord> getPatrolRecordByOrg(String orgID, String startDate, String endDate, int startPos,
			int pageSize) {
		return patrolMapper.getPatrolRecordByOrg(orgID, startDate, endDate, startPos, pageSize);
	}

	public void deleteUserCheckList(String userCheckId) {
		patrolMapper.deleteUserCheckList(userCheckId);
	}

	public void addUserCheckList(String userCheckId, String orgID, String userCheckTime, String orgUser,
			String orgManagerId, String submitTime) {
		patrolMapper.addUserCheckList(userCheckId, orgID, userCheckTime, orgUser, orgManagerId, submitTime);
	}

	public void addUserCheckInfoByOrgid(String userCheckId, String orgID) {
		patrolMapper.addUserCheckInfoByOrgid(userCheckId, orgID);
	}

	public void updateUserCheckList(String userCheckId, String userCheckTime) {
		patrolMapper.updateUserCheckList(userCheckId, userCheckTime);

	}

	public void updateSubmitState(String userCheckId, String submitState) {
		patrolMapper.updateSubmitState(userCheckId, submitState);

	}

	public boolean findNullUserCheckInfo(String userCheckId) {
		int sum = 0;
		List<UserCheckInfo> patrolList = patrolMapper.findNullUserCheckInfo(userCheckId);

		for (UserCheckInfo userCheckInfo : patrolList) {
			if (StringUtils.isEmpty(userCheckInfo.getFaultShow())) {
				sum = sum + 1;
			}
			if (StringUtils.isEmpty(userCheckInfo.getHandingimmediately())) {
				sum = sum + 1;
			}
			if (StringUtils.isEmpty(userCheckInfo.getUserCheckResult())) {
				sum = sum + 1;
			}
			if (StringUtils.isEmpty(userCheckInfo.getYnHanding())) {
				sum = sum + 1;
			}

		}

		return sum > 0 ? true : false;
	}

	public int fireSafetyCheckCount(String orgid, String startTime, String endTime) {
		return patrolMapper.fireSafetyCheckCount(orgid, startTime, endTime);
	}

	public List<FireSafetyCheck> getfireSafetyCheckByOrgid(String orgid, String startTime, String endTime, int startPos,
			int pageSize) {
		return patrolMapper.getfireSafetyCheckByOrgid(orgid, startTime, endTime, startPos, pageSize);
	}

	public FireSafetyCheck fireSafetyCheckDetail(String fireSafetyCheckID) {
		return patrolMapper.fireSafetyCheckDetail(fireSafetyCheckID);

	}

	public void editFireSafetyCheck(FireSafetyCheck fireSafetyCheck) {
		patrolMapper.editFireSafetyCheck(fireSafetyCheck);
	}

	public void addFireSafetyCheck(FireSafetyCheck fireSafetyCheck) {
		patrolMapper.addFireSafetyCheck(fireSafetyCheck);
	}

	public boolean findFireSafetyCheckID(String fireSafetyCheckID) {
		int temp = -1;
		temp = patrolMapper.findFireSafetyCheckID(fireSafetyCheckID);
		return temp > 0 ? true : false;
	}

	public void deleteFireSafetyCheck(String fireSafetyCheckID) {
		patrolMapper.deleteFireSafetyCheck(fireSafetyCheckID);
	}

	public void deleteFireSafetyCheckByOrgid(String orgid) {
		patrolMapper.deleteFireSafetyCheckByOrgid(orgid);
	}

	public void deleteUserCheckpic(String userCheckId) {
		patrolMapper.deleteUserCheckpic(userCheckId);
		
	}

	public void deleteUserCheckinfo(String userCheckId) {
		patrolMapper.deleteUserCheckinfo(userCheckId);		
	}

	public void deleteWBdevicerepairinfo_patrol(String userCheckId) {
		patrolMapper.deleteWBdevicerepairinfo_patrol(userCheckId);
	}

	public List<String> findUserCheckpic(String userCheckId) {
		return patrolMapper.findUserCheckpic(userCheckId);		
	}

}
