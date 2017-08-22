package com.hhgx.soft.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.entitys.BusinessLicence;
import com.hhgx.soft.entitys.FireSystem;
import com.hhgx.soft.entitys.Gateway;
import com.hhgx.soft.entitys.GatewaySystemInfo;
import com.hhgx.soft.entitys.OnlineOrg;
import com.hhgx.soft.entitys.Site;
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

	public List<FireSystem> getFireSystemList(String orgid) {
		return orginfoMapper.getFireSystemList(orgid);
	}

	public int getFireSystemListCount(String orgid) {
		return orginfoMapper.getFireSystemListCount(orgid);
	}

	public List<FireSystem> getFireSystemListByPage(String orgid, int startPos, int pageSize) {
		return orginfoMapper.getFireSystemListByPage(orgid, startPos,pageSize);
	}

	public List<Site> briefsiteList(String orgid) {
		return orginfoMapper.briefsiteList(orgid);
	}

	public void deleteorgSys(String siteid, String tiSysType) {
		orginfoMapper.deleteorgSys(siteid, tiSysType);		
	}

	public void addGateway(Gateway gateway) {
		orginfoMapper.addGateway(gateway);
	}

	public void deleteGateway(String gatewayaddress) {
		orginfoMapper.deleteGateway(gatewayaddress);
	}



	public int gePatrolRecordByOrgCount(String orgid) {
		return orginfoMapper.gePatrolRecordByOrgCount(orgid);
	}

	public List<Gateway> selectGateway(String orgid, int startPos, int pageSize) {
		return orginfoMapper.selectGateway(orgid, startPos, pageSize);
	}

	public void deleteGatewaySysInfo(String gatewayaddress) {
		orginfoMapper.deleteGatewaySysInfo(gatewayaddress);		
	}

	public void addGatewaySysInfo(GatewaySystemInfo gatewaySystemInfo) {
		orginfoMapper.addGatewaySysInfo(gatewaySystemInfo);
	}
	
}
