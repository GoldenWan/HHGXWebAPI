package com.hhgx.soft.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.User;
import com.hhgx.soft.entitys.Users;

@Component
@MapperScan("/usersMapper")
public interface UsersMapper {

	int getUserListCount(@Param("orgid")String orgid, @Param("userBelongTo")String userBelongTo);

	List<Users> getUserList(@Param("orgid")String orgid, @Param("userBelongTo") String userBelongTo, @Param("startPos")int startPos, @Param("pageSize")int pageSize);

	void updateUser(Users users);

}
