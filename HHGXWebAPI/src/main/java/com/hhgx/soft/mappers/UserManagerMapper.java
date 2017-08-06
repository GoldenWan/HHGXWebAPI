package com.hhgx.soft.mappers;


import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.RetrieveZtreeNodes;

@MapperScan
@Component("/userManagerMapper")
public interface UserManagerMapper {

	RetrieveZtreeNodes retrieveZtreeNodes(@Param("username") String username);

}
