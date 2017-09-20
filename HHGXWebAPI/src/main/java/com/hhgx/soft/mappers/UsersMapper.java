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

	int getUserListCount(@Param("orgid")String orgid, @Param("userBelongTo")String userBelongTo, 
			@Param("userName")String userName);

	List<Users> getUserList(@Param("orgid")String orgid, @Param("userBelongTo") String userBelongTo,
			@Param("userName")String userName, @Param("startPos")int startPos, @Param("pageSize")int pageSize);

	void updateUser(Users users);

	User getUser(String userid);

	void addUser(User users);

	void deleteUser(String userid);

	List<Map<String, String>> getUserType(String userBelongTo);

	int existUserName(String userName);

}
