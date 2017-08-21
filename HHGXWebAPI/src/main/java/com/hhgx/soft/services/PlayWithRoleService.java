package com.hhgx.soft.services;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.entitys.ManagerOrg;
import com.hhgx.soft.entitys.User;
import com.hhgx.soft.mappers.PlayWithRoleMapper;

@Service
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

	public List<ManagerOrg> getManagersSubs(String infoBagMID, String managerorgname, int startPos, int pageSize) {
		return playWithRoleMapper.getManagersSubs(infoBagMID, managerorgname, startPos, pageSize);
	}

	public List<ManagerOrg> getAllManagerOrg() {
		return playWithRoleMapper.getAllManagerOrg();
	}




	
	
}
