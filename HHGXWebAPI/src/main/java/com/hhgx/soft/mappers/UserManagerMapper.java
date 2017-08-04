package com.hhgx.soft.mappers;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

@MapperScan
@Component("/userManagerMapper")
public interface UserManagerMapper {

}
