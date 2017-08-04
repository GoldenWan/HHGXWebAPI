package com.hhgx.soft.mappers;

import java.util.HashMap;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

@MapperScan
@Component("/userManagerMapper")
public interface UserManagerMapper {

	HashMap<String, Object> retrieveZtreeNodes(String username);

}
