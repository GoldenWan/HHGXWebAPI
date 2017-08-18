package com.hhgx.soft.mappers;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.BusinessLicence;
import com.hhgx.soft.entitys.OnlineOrg;

@Component
@MapperScan("/orginfoMapper")
public interface OrginfoMapper {

	void updateOnlineOrg(OnlineOrg onlineOrg);

	OnlineOrg getOnlineOrg(@Param("orgID")String orgID);

	BusinessLicence getBusinessLicence(@Param("orgid")String orgid);

}
