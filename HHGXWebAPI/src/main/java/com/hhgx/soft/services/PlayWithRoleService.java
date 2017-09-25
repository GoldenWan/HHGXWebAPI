package com.hhgx.soft.services;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hhgx.soft.entitys.ManagerOrg;
import com.hhgx.soft.entitys.User;
import com.hhgx.soft.mappers.PlayWithRoleMapper;

@Service
@Transactional
public class PlayWithRoleService {
	@Autowired
	private PlayWithRoleMapper playWithRoleMapper;


	public void addManagerSubs(ManagerOrg managerOrg) {
		playWithRoleMapper.addManagerSubs(managerOrg);
	}

	public void addManagerSubsUser(User user) {
		playWithRoleMapper.addManagerSubsUser(user);
	}

	public void removeManagerSubs(String managerOrgID) {
		playWithRoleMapper.removeManagerSubs(managerOrgID);
	}

	public int getManagersSubsCount(String infoBagMID, String managerorgname) {
		return playWithRoleMapper.getManagersSubsCount(infoBagMID, managerorgname);
	}

	public List<Map<String, String>> getManagersSubs(String infoBagMID, String managerorgname, int startPos, int pageSize) {
		return playWithRoleMapper.getManagersSubs(infoBagMID, managerorgname, startPos, pageSize);
	}

	public List<Map<String, String>> getAllManagerOrg() {
		return playWithRoleMapper.getAllManagerOrg();
	}

	public List<Map<String, String>> getManagerDetail(String managerOrgID) {
		return playWithRoleMapper.getManagerDetail(managerOrgID);
	}

	public List<Map<String, String>> getManagerUsers(String managerOrgID) {
		return  playWithRoleMapper.getManagerUsers(managerOrgID);
	}

	public void updateManagerSubs(ManagerOrg managerOrg) {
		playWithRoleMapper.updateManagerSubs(managerOrg);	
	}

	public void deleteManagerSubsUser(String managerOrgID) {
		playWithRoleMapper.deleteManagerSubsUser(managerOrgID);
		
	}




	
	
}
