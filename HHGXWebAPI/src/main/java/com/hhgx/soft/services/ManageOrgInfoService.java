package com.hhgx.soft.services;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.mappers.ManageOrgInfoMapper;

@Service
public class ManageOrgInfoService {
	@Autowired
	private ManageOrgInfoMapper manageOrgInfoMapper;

	public int managerRecurOrgListCount(String managerOrgID, String orgName) {
		return manageOrgInfoMapper.managerRecurOrgListCount(managerOrgID, orgName);
	}

	public List<Map<String, Object>> managerRecurOrgList(String managerOrgID, String orgName, int startPos,
			int pageSize) {
		return manageOrgInfoMapper.managerRecurOrgList(managerOrgID, orgName,startPos, pageSize);
	}

}
