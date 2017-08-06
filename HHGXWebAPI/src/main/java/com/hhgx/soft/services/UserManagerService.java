package com.hhgx.soft.services;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.entitys.RegisterNew;
import com.hhgx.soft.entitys.RetrieveZtreeNodes;
import com.hhgx.soft.mappers.UserManagerMapper;

@Service
public class UserManagerService {
	@Autowired
	private UserManagerMapper userManagerMapper;

	public RetrieveZtreeNodes RetrieveZtreeNodes(String username) {
		
		return userManagerMapper.retrieveZtreeNodes(username);		
	}

	public boolean LoginBy(String username, String password) {
		
		return false;
	}

	public boolean registerNew(RegisterNew registerNew) {
		return false;
	} 
	

}
