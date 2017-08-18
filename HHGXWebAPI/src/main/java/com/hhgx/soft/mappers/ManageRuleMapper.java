package com.hhgx.soft.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.SafeDuty;
import com.hhgx.soft.entitys.SafeManageRules;
@Component
@MapperScan(value="/manageRuleMapper")
public interface ManageRuleMapper {


	void deleteSafeManageRules(@Param("safeManageRulesID") String safeManageRulesID);

	int safeManageRulesListCount(@Param("orgid")String orgid);

	List<SafeManageRules> safeManageRulesList(@Param("orgid") String orgid, @Param("startPos") int startPos,  @Param("pageSize") int pageSize);

	SafeManageRules getSafeManageRules(@Param("safeManageRulesID")String safeManageRulesID);

	void deleteSafeDutyID(@Param("safeDutyID")String safeDutyID);

	int searchSafeDutyCount(@Param("orgid")String orgid);

	SafeDuty safeDutyInfo(@Param("safeDutyID")String safeDutyID);


	List<SafeDuty> searchSafeDuty(@Param("orgid")String orgid,@Param("startPos") int startPos, @Param("pageSize")int pageSize);
	
	
}
