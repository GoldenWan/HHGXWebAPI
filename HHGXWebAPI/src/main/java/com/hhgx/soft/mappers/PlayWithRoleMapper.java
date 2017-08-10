package com.hhgx.soft.mappers;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.ManagerOrg;

@MapperScan
@Component("/PlayWithRoleMapper")
public interface PlayWithRoleMapper {

	List<ManagerOrg> getManagerOrgAll();

}
