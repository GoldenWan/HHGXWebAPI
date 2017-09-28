package com.hhgx.soft.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.User;
import com.hhgx.soft.entitys.Users;

@Component
@MapperScan("/usersMapper")
public interface UsersMapper {

	int getUserListCount(@Param("orgid")String orgid,@Param("maintenanceId")String maintenanceId, @Param("userBelongTo")String userBelongTo, 
			@Param("userName")String userName);

	List<Users> getUserList(@Param("orgid")String orgid, @Param("maintenanceId")String maintenanceId,@Param("userBelongTo") String userBelongTo,
			@Param("userName")String userName, @Param("startPos")int startPos, @Param("pageSize")int pageSize);

	void updateUser(Users users);

	User getUser(String userid);

	void addUser(User users);

	void deleteUser(String userid);

	List<Map<String, String>> getUserType(String userBelongTo);

	int existUserName(String userName);

	Map<String, Object> isBindPhone(String userid);

	String getUserPic(String userid);

	int existUserId(@Param("userid")String userid, @Param("phone")String phone);

	int isCorrectPwd(@Param("userid")String userid, @Param("pwd")String md5);

	void updatePassword(@Param("userid")String userid,@Param("pwd") String md5);

	int isRightPhone(@Param("phone")String phone, @Param("userid")String userid);

	void unBindPhone(@Param("userid")String userid);

	List<Map<String, String>> getPeopleType();

	List<Map<String, String>> selectPeople(@Param("orgid")String orgid, @Param("peopleType")String peopleType, @Param("peopleName")String peopleName, @Param("startPos")int startPos, @Param("pageSize")int pageSize);

	int selectPeopleCount(@Param("orgid")String orgid, @Param("peopleType")String peopleType, @Param("peopleName")String peopleName);

	List<Map<String, String>> peopleDetail(String peopleNo);

}
