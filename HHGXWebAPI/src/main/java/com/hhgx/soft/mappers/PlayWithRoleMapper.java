package com.hhgx.soft.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.ManagerOrg;
import com.hhgx.soft.entitys.ManagerSubs;
import com.hhgx.soft.entitys.User;

@MapperScan
@Component("/PlayWithRoleMapper")
public interface PlayWithRoleMapper {

	List<ManagerOrg> getManagerOrgAll();
	
	void addManagerSubs(ManagerSubs managerSubs);

	void addManagerSubsUser(User user);

	void removeManagerSubs(@Param("managerOrg") String managerOrg);
	
	

}
