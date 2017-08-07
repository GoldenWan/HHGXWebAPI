package com.hhgx.soft.mappers;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.RegisterNew;
import com.hhgx.soft.entitys.RetrieveZtreeNodes;
import com.hhgx.soft.entitys.User;

@MapperScan
@Component("/userManagerMapper")
public interface UserManagerMapper {

	RetrieveZtreeNodes retrieveZtreeNodes(@Param("username") String username);

	User loginBy(@Param("username") String username, @Param("password") String password);

	int findAccount(@Param("username") String username);

	void registerNew(RegisterNew registerNew);

}
