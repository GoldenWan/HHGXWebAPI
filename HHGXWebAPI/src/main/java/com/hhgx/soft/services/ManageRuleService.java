package com.hhgx.soft.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.entitys.SafeManageRules;
import com.hhgx.soft.mappers.ManageRuleMapper;
@Service
public class ManageRuleService {

	@Autowired
	private  ManageRuleMapper manageRuleMapper;
 
	public void deleteSafeManageRules(String safeManageRulesID) {
		manageRuleMapper.deleteSafeManageRules(safeManageRulesID);
	}

	public int safeManageRulesListCount(String orgid) {
		return manageRuleMapper.safeManageRulesListCount(orgid);
	}

	public List<SafeManageRules> safeManageRulesList(String orgid, int startPos, int pageSize) {
		return manageRuleMapper.safeManageRulesList(orgid, startPos, pageSize);
	}


	public SafeManageRules getSafeManageRules(String safeManageRulesID) {
		return  manageRuleMapper.getSafeManageRules(safeManageRulesID);
	}

}