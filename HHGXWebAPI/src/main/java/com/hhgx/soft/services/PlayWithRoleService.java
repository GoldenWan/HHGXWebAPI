package com.hhgx.soft.services;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.entitys.ManagerOrg;
import com.hhgx.soft.mappers.PlayWithRoleMapper;

@Service
public class PlayWithRoleService {
	@Autowired
	private PlayWithRoleMapper playWithRoleMapper;

	public List<ManagerOrg> getManagerOrgAll() {
		return playWithRoleMapper.getManagerOrgAll();
	}



	
	
}
