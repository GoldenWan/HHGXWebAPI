package com.hhgx.soft.services;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hhgx.soft.entitys.User;
import com.hhgx.soft.entitys.Users;
import com.hhgx.soft.mappers.UsersMapper;
import com.hhgx.soft.utils.Md5Util;

@Service
@Transactional
public class UsersService {

	@Autowired
	private UsersMapper usersMapper;

	public int getUserListCount(String orgid, String maintenanceId, String userBelongTo, String userName) {
		return usersMapper.getUserListCount(orgid, maintenanceId, userBelongTo, userName);
	}

	public List<Users> getUserList(String orgid, String maintenanceId, String userBelongTo, String userName,
			int startPos, int pageSize) {
		return usersMapper.getUserList(orgid, maintenanceId, userBelongTo, userName, startPos, pageSize);
	}

	public void updateUser(Users users) {
		usersMapper.updateUser(users);
	}

	public User getUser(String userid) {
		return usersMapper.getUser(userid);
	}

	public void addUser(User users) {

		// 添加消防单位管理员
		if (users.getUserBelongTo().equals("1")) {
			usersMapper.addUser(users);
		} else if (users.getUserBelongTo().equals("4")) {
			users.setOrgid(null);
			usersMapper.addUser(users);
		} else if (users.getUserBelongTo().equals("3")) {
			usersMapper.addUser(users);
		} else if (users.getUserBelongTo().equals("2")) {
			users.setMaintenanceId(users.getOrgid());
			users.setOrgid(null);
			usersMapper.addUser(users);
		}
	}

	public void deleteUser(String userid) {
		usersMapper.deleteUser(userid);
	}

	public List<Map<String, String>> getUserType(String userBelongTo) {
		return usersMapper.getUserType(userBelongTo);
	}

	public boolean existUserName(String userName) {
		return usersMapper.existUserName(userName) > 0 ? true : false;
	}

	public Map<String, Object> isBindPhone(String userid) {
		return usersMapper.isBindPhone(userid);
	}

	public String getUserPic(String userid) {
		return usersMapper.getUserPic(userid);
	}

	public boolean existUserId(String userid, String phone) {
		return usersMapper.existUserId(userid, phone) > 0 ? true : false;
	}

	public boolean isCorrectPwd(String userid, String password) {
		return usersMapper.isCorrectPwd(userid, Md5Util.getMD5(password)) > 0 ? true : false;
	}

	public void updatePassword(String userid, String newPassword) {
		usersMapper.updatePassword(userid, Md5Util.getMD5(newPassword));
	}

	public boolean isRightPhone(String phone, String userid) {
		return usersMapper.isRightPhone(phone, userid) > 0 ? true : false;
	}

	public void unBindPhone(String userid) {
		usersMapper.unBindPhone(userid);

	}

	public List<Map<String, String>> getPeopleType() {

		return usersMapper.getPeopleType();
	}


	public List<Map<String, String>> selectPeople(String orgid, String peopleType, String peopleName,
			int startPos, int pageSize) {
		return  usersMapper.selectPeople(orgid, peopleType, peopleName, startPos,  pageSize);
	}

	public int selectPeopleCount(String orgid, String peopleType, String peopleName) {
		return usersMapper.selectPeopleCount(orgid, peopleType, peopleName);
	}

	public List<Map<String, String>> peopleDetail(String peopleNo) {
		return usersMapper.peopleDetail(peopleNo);
	}

}
