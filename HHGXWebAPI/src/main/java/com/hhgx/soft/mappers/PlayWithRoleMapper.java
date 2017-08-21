package com.hhgx.soft.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.ManagerOrg;
import com.hhgx.soft.entitys.User;

@Component
@MapperScan("/playWithRoleMapper")
public interface PlayWithRoleMapper {



	int getManagersSubsCount(@Param("infoBagMID")String infoBagMID, @Param("managerorgname")String managerorgname);

	List<ManagerOrg> getManagersSubs(@Param("infoBagMID")String infoBagMID, @Param("managerorgname")String managerorgname, @Param("startPos")int startPos, @Param("pageSize")int pageSize);
	
	void addManagerSubs(ManagerOrg managerOrg);
	
	void addManagerSubsUser(User user);
	
	void removeManagerSubs(@Param("managerOrgID") String managerOrgID);

	List<ManagerOrg> getAllManagerOrg();
	

}
