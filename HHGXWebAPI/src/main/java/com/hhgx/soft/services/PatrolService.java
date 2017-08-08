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

	public int gePatrolRecordByOrgCount(String orgID, String startDate, String endDate) {
		return patrolMapper.gePatrolRecordByOrgCount(orgID, startDate, endDate);
	}

	public List<PatrolRecord> getPatrolRecordByOrg(String orgID, String startDate, String endDate, int startPos, int pageSize) {
		return patrolMapper.getPatrolRecordByOrg(orgID, startDate, endDate, startPos, pageSize);
	}

	
}
