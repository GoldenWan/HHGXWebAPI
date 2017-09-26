package com.hhgx.soft.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

@MapperScan
@Component
public interface ManageOrgInfoMapper {

	int managerRecurOrgListCount(@Param("managerOrgID")String managerOrgID, @Param("orgName")String orgName);

	List<Map<String, Object>> managerRecurOrgList(@Param("managerOrgID")String managerOrgID, @Param("orgName")String orgName, 
			@Param("startPos")int startPos, @Param("pageSize")int pageSize);

	
}
