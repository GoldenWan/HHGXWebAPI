package com.hhgx.soft.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.entitys.Users;
import com.hhgx.soft.mappers.UsersMapper;

@Service
public class UsersService {

	@Autowired
	private UsersMapper usersMapper;


	public int getUserListCount(String orgid, String userBelongTo) {
		return usersMapper.getUserListCount(orgid, userBelongTo);
	}


	public List<Users> getUserList(String orgid, String userBelongTo, int startPos, int pageSize) {
		return usersMapper.getUserList(orgid, userBelongTo, startPos, pageSize);
				}


	public void updateUser(Users users) {
		usersMapper.updateUser(users);
	}
	


}
