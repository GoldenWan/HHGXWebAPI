package com.hhgx.soft.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.entitys.BusinessLicence;
import com.hhgx.soft.entitys.OnlineOrg;
import com.hhgx.soft.mappers.OrginfoMapper;

@Service
public class OrginfoService {

	@Autowired
	private OrginfoMapper orginfoMapper;

	public void updateOnlineOrg(OnlineOrg onlineOrg) {
		orginfoMapper.updateOnlineOrg(onlineOrg);
	}

	public OnlineOrg getOnlineOrg(String orgID) {
		return orginfoMapper.getOnlineOrg(orgID);
	}

	public BusinessLicence getBusinessLicence(String orgid) {
		return orginfoMapper.getBusinessLicence(orgid);
	}
	
}
