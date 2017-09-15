package com.hhgx.soft.services;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hhgx.soft.entitys.BusinessLicence;
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

	public List<Map<String, String>> getOnlineOrg(String orgID) {
		return orginfoMapper.getOnlineOrg(orgID);
	}

	public List<BusinessLicence> getBusinessLicence(String orgid) {
		return orginfoMapper.getBusinessLicence(orgid);
	}

	public List<FireSystem> getFireSystemList(String orgid) {
		return orginfoMapper.getFireSystemList(orgid);
	}

	public int getFireSystemListCount(String orgid) {
		return orginfoMapper.getFireSystemListCount(orgid);
	}

	public List<Map<String, Object>> getFireSystemListByPage(String orgid, int startPos, int pageSize) {
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

		return orginfoMapper.findGatewayaddressExist(newGatewayaddress) > 0 ? true : false ;
	}

	public void deleteDevicesBycflatPic(String cFlatPic) {
		orginfoMapper.deleteDevicesBycflatPic(cFlatPic);
		
	}

	public int selectDevicesListCount(String cFlatPic, String iDeviceType, String deviceaddress) {
		return orginfoMapper.selectDevicesListCount( cFlatPic,  iDeviceType, deviceaddress);
	}

	public List<Map<String, String>> selectDevicesLists(String cFlatPic, String iDeviceType, String deviceaddress, int startPos,
			int pageSize) {
		return orginfoMapper.selectDevicesLists(cFlatPic,iDeviceType, deviceaddress,  startPos, pageSize);
	}

	public List<Map<String, String>> selectDeviceDetail(String gatewayaddress, String sysaddress, String deviceaddress) {
		return  orginfoMapper.selectDeviceDetail( gatewayaddress,  sysaddress,  deviceaddress);
	}

	public Devices markPoint(Devices devices) {
		//据联合主键修改部件的fPositionX,fPositionY,
		orginfoMapper.updateMarkPoint(devices);
		//然后根据cFlatPic和DeviceNo,返回下一个节点信息，下一个节点是大于当前节点的最小节点
		Object [] deviceNos = orginfoMapper.getDeviceNosByFlatpic(devices.getcFlatPic());
		int currentNo =devices.getDeviceNo();
		int nextDevicesNo =currentNo;
		for(Object no :deviceNos){
			if(Integer.parseInt(no.toString())>currentNo){
				nextDevicesNo=Integer.parseInt(no.toString());
				break;
			}
		}
		// "不存在下一个节点",
		if(nextDevicesNo==currentNo)
			return null;
		else {
			return orginfoMapper.returnMarkPoint(devices.getcFlatPic(),nextDevicesNo).get(0);
		}
		

		
		
	}



	public Devices getOneDevice(String cFlatPic, String deviceNo ) {
		return orginfoMapper.getOneDevice(cFlatPic, deviceNo);
	}

	public Devices getFirstDevice(String cFlatPic) {
		return orginfoMapper.getFirstDevice(cFlatPic);
	}
	


	public List<Site> getSiteName(String orgid) {
		return orginfoMapper.getSiteName(orgid);
	}

public List<Site> getSiteList(String orgid, int startPos, int pageSize) {
	return orginfoMapper.getSiteList(orgid, startPos, pageSize);
}

public void addSite(Site site) {
	 orginfoMapper.addSite(site);
}

public List<OnlineOrg>  getMapPoint(String orgid) {
	// TODO Auto-generated method stub
	return  orginfoMapper.getMapPoint(orgid);
}

public String findMaxBack8(String orgid) {
	return orginfoMapper.findMaxBack8(orgid);
}

public int getSiteTotalCount(String orgid) {
	return orginfoMapper.getSiteTotalCount(orgid);
}

public void deleteSite(String siteid) {
	 orginfoMapper.deleteSite(siteid);
}

public Site getSite(String siteid) {
	// TODO Auto-generated method stub
	return  orginfoMapper.getSite(siteid);
}

public void updateSite(Site site) {
	 orginfoMapper.updateSite(site);
}

public List<Map<String, String>> getAppearancepic(String siteid) {
	return  orginfoMapper.getAppearancepic(siteid);
}

public void deleteAppearance(String iphotoID) {
	orginfoMapper.deleteAppearance(iphotoID);
}

public void setMapPoint(String orgid, String fLatitude, String fLongitude) {
	orginfoMapper.setMapPoint(orgid,  fLatitude,  fLongitude);
	
}

public List<OnlineOrg> getTotalFlatPic(String orgid) {
	return orginfoMapper.getTotalFlatPic(orgid);
}

public int getflatpicCount(String orgid, String siteid) {
	return orginfoMapper.getflatpicCount(orgid, siteid);
}

public List<Flatpic> getflatpicListPage(String orgid, String siteid, int startPos, int pageSize) {
	return orginfoMapper.getflatpicListPage(orgid, siteid, startPos, pageSize);
}

public List<Site> orgSiteSys(String orgid) {
	return orginfoMapper.orgSiteSys(orgid);
}

public int dataMonitorCount(String siteid, String tiSysType) {
	return orginfoMapper.dataMonitorCount(siteid, tiSysType);
}

public List<Map<String, Object>> dataMonitor(String siteid, String tiSysType, int startPos, int pageSize) {
	return orginfoMapper.dataMonitor(siteid, tiSysType, startPos, pageSize);
}

public List<Map<String, String>> getOnlineFireSystem(String siteid, String tisystype) {
	return orginfoMapper.getOnlineFireSystem(siteid, tisystype);
}

public List<Gateway> gatewayInfo(String orgid, String gatewayaddress) {
	return orginfoMapper.gatewayInfo(orgid,  gatewayaddress);
}



public int siteDevicesCount(String orgid, String siteid) {
	return orginfoMapper.siteDevicesCount(orgid, siteid);
}

public List<Map<String, Object>> siteDevices(String orgid, String siteid, int startPos, int pageSize) {
	return orginfoMapper.siteDevices( orgid,  siteid, startPos, pageSize);
}

public List<Map<String, Object>> deviceTypeList() {
	return  orginfoMapper.deviceTypeList();
}

public List<Map<String, Object>> findGatewaySysInfoByAddr(String gatewayaddress) {
	return orginfoMapper.findGatewaySysInfoByAddr(gatewayaddress);
}

public List<Map<String, Object>> findDevicesByGateway(Object sysaddress, Object gatewayaddress) {
	return orginfoMapper.findDevicesByGateway(sysaddress,gatewayaddress);
}

public void deleteAnlogAlarmSettings(Object deviceaddress, Object sysaddress, Object gatewayaddress) {
	orginfoMapper.deleteAnlogAlarmSettings(deviceaddress, sysaddress,gatewayaddress);
	
}

public void deleteDevices1(Object sysaddress, Object gatewayaddress) {
	orginfoMapper.deleteDevices1(sysaddress,gatewayaddress);

	
}

public List<Map<String, Object>> findGatewaySysInfoByType(String tiSysType) {
	return orginfoMapper.findGatewaySysInfoByType(tiSysType);
}

public List<GatewaySystemInfo> getSiteNeedAddress(String siteid) {
	return orginfoMapper.getSiteNeedAddress(siteid);
}

public boolean findDevicesByKey(String deviceAddr, String sysaddress, String gatewayaddress) {
	return orginfoMapper.findDevicesByKey(deviceAddr, sysaddress, gatewayaddress)>0 ? true :false;
}

public String findDevicesTypeByName(String name) {
	return orginfoMapper.findDevicesTypeByName(name);
}

public List<Map<String, Object>> getLabelledDevice(String cFlatPic) {
	return  orginfoMapper.getLabelledDevice(cFlatPic);
}

	
}
