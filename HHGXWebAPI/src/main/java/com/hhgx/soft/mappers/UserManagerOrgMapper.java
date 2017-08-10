package com.hhgx.soft.mappers;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.RegisterNew;
import com.hhgx.soft.entitys.RetrieveZtreeNodes;
import com.hhgx.soft.entitys.User;

@MapperScan
@Component("/userManagerMapper")
public interface UserManagerOrgMapper {

	RetrieveZtreeNodes retrieveZtreeNodes(@Param("username") String username);

	User loginBy(@Param("username") String username, @Param("password") String password);

	int findAccount(@Param("username") String username);


	void onlineorgRegister(RegisterNew registerNew);

	void usersRegister(RegisterNew registerNew);

	void maintenanceRegister(RegisterNew registerNew);

	String getUserTypeName(@Param("userTypeID") String userTypeID);

	String findMaxBack6(@Param("areaID") String areaID);

}
