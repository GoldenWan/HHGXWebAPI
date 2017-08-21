package com.hhgx.soft.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.BusinessLicence;
import com.hhgx.soft.entitys.FireSystem;
import com.hhgx.soft.entitys.OnlineOrg;

@Component
@MapperScan("/orginfoMapper")
public interface OrginfoMapper {

	void updateOnlineOrg(OnlineOrg onlineOrg);

	OnlineOrg getOnlineOrg(@Param("orgID")String orgID);

	BusinessLicence getBusinessLicence(@Param("orgid")String orgid);

	List<FireSystem> getFireSystemList(@Param("orgid")String orgid);

	int getFireSystemListCount(@Param("orgid")String orgid);

	List<FireSystem> getFireSystemListByPage(@Param("orgid")String orgid, @Param("startPos")int startPos, @Param("pageSize")int pageSize);

}
