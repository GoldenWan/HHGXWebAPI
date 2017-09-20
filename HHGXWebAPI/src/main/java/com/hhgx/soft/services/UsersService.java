package com.hhgx.soft.services;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hhgx.soft.entitys.User;
import com.hhgx.soft.entitys.Users;
import com.hhgx.soft.mappers.UsersMapper;

@Service
@Transactional
public class UsersService {

	@Autowired
	private UsersMapper usersMapper;


	public int getUserListCount(String orgid, String userBelongTo,String userName) {
		return usersMapper.getUserListCount(orgid, userBelongTo,userName);
	}


	public List<Users> getUserList(String orgid, String userBelongTo,String userName, int startPos, int pageSize) {
		return usersMapper.getUserList(orgid, userBelongTo,userName, startPos, pageSize );
				}


	public void updateUser(Users users) {
		usersMapper.updateUser(users);
	}


	public User getUser(String userid) {
		return usersMapper.getUser(userid);
	}


	public void addUser(User users) {
		 usersMapper.addUser(users);		
	}


	public void deleteUser(String userid) {
		usersMapper.deleteUser(userid);
	}


	public List<Map<String, String>> getUserType(String userBelongTo) {
		return usersMapper.getUserType(userBelongTo);
	}


	public boolean existUserName(String userName) {
		return usersMapper.existUserName(userName)>0 ? true : false;
	}
	


}
