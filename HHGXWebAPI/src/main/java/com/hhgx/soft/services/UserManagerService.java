package com.hhgx.soft.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.entitys.RegisterNew;
import com.hhgx.soft.entitys.RetrieveZtreeNodes;
import com.hhgx.soft.entitys.User;
import com.hhgx.soft.mappers.UserManagerMapper;

@Service
public class UserManagerService {
	@Autowired
	private UserManagerMapper userManagerMapper;

	public RetrieveZtreeNodes retrieveZtreeNodes(String username) {

		return userManagerMapper.retrieveZtreeNodes(username);
	}

	public User loginBy(String username, String password) {

		return userManagerMapper.loginBy(username, password);
	}

	public boolean registerNew(RegisterNew registerNew) {
		int temp = 1;
		try {
			userManagerMapper.registerNew(registerNew);
		} catch (Exception e) {
			temp = -1;
		}

		return temp > 0 ? true : false;
	}

	public boolean findAccount(String username) {
		int temp = userManagerMapper.findAccount(username);
		return temp > 0 ? true : false;
	}

}
