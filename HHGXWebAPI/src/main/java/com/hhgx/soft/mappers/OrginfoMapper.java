package com.hhgx.soft.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.BusinessLicence;
import com.hhgx.soft.entitys.Devices;
import com.hhgx.soft.entitys.FireSystem;
import com.hhgx.soft.entitys.Firesystype;
import com.hhgx.soft.entitys.Flatpic;
import com.hhgx.soft.entitys.Gateway;
import com.hhgx.soft.entitys.GatewaySystemInfo;
import com.hhgx.soft.entitys.OnlineOrg;
import com.hhgx.soft.entitys.Site;

@Component
@MapperScan("/orginfoMapper")
public interface OrginfoMapper {

	void updateOnlineOrg(OnlineOrg onlineOrg);

	List<Map<String, String>> getOnlineOrg(@Param("orgID")String orgID);

	List<BusinessLicence> getBusinessLicence(@Param("orgid")String orgid);

	List<FireSystem> getFireSystemList(@Param("orgid")String orgid);

	int getFireSystemListCount(@Param("orgid")String orgid);

	List<Map<String, Object>> getFireSystemListByPage(@Param("orgid")String orgid, @Param("startPos")int startPos, @Param("pageSize")int pageSize);

	List<Site> briefsiteList(@Param("orgid") String orgid);

	void deleteorgSys(@Param("siteid")String siteid, @Param("tiSysType")String tiSysType);

	void deleteGateway(String gatewayaddress);
	void selectVgateway(String gatewayaddress);


	int gePatrolRecordByOrgCount(String orgid);

	List<Gateway> selectGateway(@Param("orgid")String orgid, @Param("startPos")int startPos, @Param("pageSize")int pageSize);

	void deleteGatewaySysInfo(String gatewayaddress);

	void addGatewaySysInfo(GatewaySystemInfo gatewaySystemInfo);

	void addGateway(Gateway gateway);

	
	void updateGateway(Gateway gateway);

	void updateGatewaySysInfo(GatewaySystemInfo gatewaySystemInfo);

	List<Flatpic> getflatpicList(@Param("orgid")String orgid, @Param("siteid")String siteid);

	void deleteflatPic(String cFlatPic);

	void addDevices(Devices devices);

	void updateDevices(Devices devices);

	void deleteDevices(@Param("deviceaddress")String deviceaddress, @Param("sysaddress")String sysaddress, @Param("gatewayaddress")String gatewayaddress);

	String findMaxDeviceNo(String cFlatPic);

	void updateGatewaySame(Gateway gateway);

	int findGatewayaddressExist(String newGatewayaddress);

	void deleteDevicesBycflatPic(String cFlatPic);
	int selectDevicesListCount(@Param("cFlatPic")String cFlatPic, @Param("iDeviceType")String iDeviceType, @Param("deviceaddress")String deviceaddress);
	List<Map<String, String>> selectDevicesLists(@Param("cFlatPic")String cFlatPic, @Param("iDeviceType")String iDeviceType, @Param("deviceaddress")String deviceaddress, @Param("startPos")int startPos,
			@Param("pageSize")int pageSize);
	List<Map<String, String>> selectDeviceDetail(@Param("gatewayaddress") String gatewayaddress, @Param("sysaddress") String sysaddress,
			@Param("deviceaddress") String deviceaddress);

	List<Site> getSiteName(String orgid);


	List<Site> getSiteList(@Param("orgid")String orgid, @Param("startPos")int startPos, @Param("pageSize")int pageSize);

	void addSite(Site site);

	List<OnlineOrg>  getMapPoint(String orgid);

	String findMaxBack8(String orgid);

	int getSiteTotalCount(String orgid);

	void deleteSite(String siteid);

	Site getSite(String siteid);

	void updateSite(Site site);

	List<Map<String, String>> getAppearancepic(String siteid);

	void deleteAppearance(String iphotoID);

	void setMapPoint(@Param("orgid")String orgid, @Param("fLatitude")String fLatitude, @Param("fLongitude")String fLongitude);

	List<OnlineOrg> getTotalFlatPic(String orgid);

	int getflatpicCount(@Param("orgid")String orgid, @Param("siteid")String siteid);

	List<Flatpic> getflatpicListPage(@Param("orgid")String orgid, @Param("siteid")String siteid, @Param("startPos")int startPos, @Param("pageSize")int pageSize);

	List<Site> orgSiteSys(String orgid);
	Firesystype findSystypeById(String tiSysType);

	int dataMonitorCount(@Param("siteid")String siteid, @Param("tiSysType")String tiSysType);

	List<Map<String, Object>> dataMonitor(@Param("siteid")String siteid, @Param("tiSysType")String tiSysType, @Param("startPos")int startPos, @Param("pageSize")int pageSize);

	List<Map<String, String>> getOnlineFireSystem(@Param("siteid")String siteid, @Param("tisystype")String tisystype);

	List<Gateway> gatewayInfo(@Param("orgid")String orgid, @Param("gatewayaddress")String gatewayaddress);



	int siteDevicesCount(@Param("orgid")String orgid, @Param("siteid")String siteid);

	List<Map<String, Object>> siteDevices(@Param("orgid")String orgid,  @Param("siteid")String siteid, @Param("startPos")int startPos, @Param("pageSize")int pageSize);

	List<Map<String, Object>> deviceTypeList();

	List<Map<String, Object>> findGatewaySysInfoByType(@Param("tiSysType")String tiSysType);
	List<Map<String, Object>> findGatewaySysInfoByAddr(@Param("gatewayaddress")String gatewayaddress);

	List<Map<String, Object>> findDevicesByGateway(@Param("sysaddress")Object sysaddress, @Param("gatewayaddress")Object gatewayaddress);

	void deleteAnlogAlarmSettings(@Param("deviceaddress")Object deviceaddress, @Param("sysaddress")Object sysaddress, @Param("gatewayaddress")Object gatewayaddress);

	void deleteDevices1(@Param("sysaddress")Object sysaddress, @Param("gatewayaddress")Object gatewayaddress);

	List<GatewaySystemInfo> getSiteNeedAddress(String siteid);

	int findDevicesByKey(@Param("deviceAddr")String deviceAddr, @Param("sysaddress")String sysaddress, @Param("gatewayaddress")String gatewayaddress);

	String findDevicesTypeByName(@Param("deviceTypeName")String name);



	
	void updateMarkPoint(Devices devices);

	List<Devices> returnMarkPoint(@Param("cFlatPic")String getcFlatPic, @Param("deviceNo")int nextDevicesNo);

	Devices getFirstDevice(String cFlatPic);

	Devices getOneDevice(@Param("cFlatPic")String cFlatPic, @Param("deviceNo")String deviceNo);


	List<Map<String, Object>> getLabelledDevice(String cFlatPic);

	Object[] getDeviceNosByFlatpic(String getcFlatPic);

}
