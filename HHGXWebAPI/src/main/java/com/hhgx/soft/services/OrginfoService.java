package com.hhgx.soft.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hhgx.soft.entitys.BusinessLicence;
import com.hhgx.soft.entitys.DeviceList;
import com.hhgx.soft.entitys.Devices;
import com.hhgx.soft.entitys.FireSystem;
import com.hhgx.soft.entitys.Flatpic;
import com.hhgx.soft.entitys.Gateway;
import com.hhgx.soft.entitys.GatewaySystemInfo;
import com.hhgx.soft.entitys.OnlineOrg;
import com.hhgx.soft.entitys.Site;
import com.hhgx.soft.mappers.OrginfoMapper;

@Service
@Transactional
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

	public void updateGateway(Gateway gateway) {
		orginfoMapper.updateGateway(gateway);		
	}

	public void updateGatewaySysInfo(GatewaySystemInfo gatewaySystemInfo) {
		orginfoMapper.updateGatewaySysInfo(gatewaySystemInfo);
		
	}

	public List<Flatpic> getflatpicList(String orgid, String siteid) {
		return orginfoMapper.getflatpicList(orgid, siteid) ;
	}

	public void deleteflatPic(String cFlatPic) {
		orginfoMapper.deleteflatPic(cFlatPic);		
	}

	public void addDevices(Devices devices) {
		orginfoMapper.addDevices(devices);		
	}

	public void updateDevices(Devices devices) {
		orginfoMapper.updateDevices(devices);
		
	}

	public void deleteDevices(String deviceaddress, String sysaddress, String gatewayaddress) {
		orginfoMapper.deleteDevices(deviceaddress,  sysaddress, gatewayaddress);	
	}

	public int findMaxDeviceNo(String cFlatPic) {
		String temp=orginfoMapper.findMaxDeviceNo(cFlatPic);
		return temp !=null?Integer.parseInt(temp):0;
	}

	public void updateGatewayExist(Gateway gateway) {
		orginfoMapper.updateGatewaySame(gateway);
	}

	public boolean findGatewayaddressExist(String newGatewayaddress) {
		int temp =-1;
		temp =orginfoMapper.findGatewayaddressExist(newGatewayaddress);
		return temp > 0 ? true : false ;
	}

	public void deleteDevicesBycflatPic(String cFlatPic) {
		orginfoMapper.deleteDevicesBycflatPic(cFlatPic);
		
	}

	public int selectDevicesListCount(String cFlatPic, String iDeviceType, String deviceaddress) {
		return orginfoMapper.selectDevicesListCount( cFlatPic,  iDeviceType, deviceaddress);
	}

	public List<DeviceList> selectDevicesLists(String cFlatPic, String iDeviceType, String deviceaddress, int startPos,
			int pageSize) {
		return orginfoMapper.selectDevicesLists(cFlatPic,iDeviceType, deviceaddress,  startPos, pageSize);
	}

	public Devices selectDeviceDetail(String gatewayaddress, String sysaddress, String deviceaddress) {
		return  orginfoMapper.selectDeviceDetail( gatewayaddress,  sysaddress,  deviceaddress);
	}
	
}