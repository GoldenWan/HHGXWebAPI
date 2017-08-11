package com.hhgx.soft.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.entitys.PatrolRecord;
import com.hhgx.soft.mappers.PatrolMapper;

@Service
public class PatrolService {

	@Autowired
	private PatrolMapper patrolMapper;

	public int gePatrolRecordByOrgCount(String orgID) {
		return patrolMapper.gePatrolRecordByOrgCount(orgID);
	}

	public List<PatrolRecord> getPatrolRecordByOrg(String orgID, String startDate, String endDate, int startPos, int pageSize) {
		return patrolMapper.getPatrolRecordByOrg(orgID, startDate, endDate, startPos, pageSize);
	}

	public void deleteCheckRecord(String userCheckId) {
		 patrolMapper.deleteCheckRecord(userCheckId);
	}

	public void addUserCheckList(String userCheckId, String orgID, String userCheckTime, String orgUser, String orgManagerId) {
		patrolMapper.addUserCheckList(userCheckId, orgID, userCheckTime, orgUser, orgManagerId);
	}

	public void addUserCheckInfoByOrgid(String userCheckId, String orgID) {
patrolMapper.addUserCheckInfoByOrgid(userCheckId, orgID);	
	}

	public void updateUserCheckList(String userCheckId, String userCheckTime) {
patrolMapper.updateUserCheckList(userCheckId, userCheckTime);
		
	}


	
}
