package com.hhgx.soft.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.RegisterNew;
import com.hhgx.soft.entitys.User;
import com.hhgx.soft.entitys.UserInfo;
import com.hhgx.soft.entitys.Ztree;

@MapperScan
@Component("/userManagerMapper")
public interface UserManagerOrgMapper {

	//List<Ztree> retrieveZtreeNodes(@Param("username") String username);

	User loginBy(@Param("username") String username, @Param("password") String password);

	int findAccount(@Param("username") String username);


	void onlineorgRegister(RegisterNew registerNew);

	void usersRegister(RegisterNew registerNew);

	void maintenanceRegister(RegisterNew registerNew);

	String getUserTypeName(@Param("userTypeID") String userTypeID);

	String findMaxBack6(@Param("areaID") String areaID);

	UserInfo getUserInfoByName(@Param("useranme") String username);

}
