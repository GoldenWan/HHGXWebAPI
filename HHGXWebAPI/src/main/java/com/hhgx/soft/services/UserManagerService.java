package com.hhgx.soft.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.mappers.UserManagerMapper;

@Service
public class UserManagerService {
	@Autowired
	private UserManagerMapper userManagerMapper; 
	

}
