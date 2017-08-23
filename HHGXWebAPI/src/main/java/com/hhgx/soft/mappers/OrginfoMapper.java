package com.hhgx.soft.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.BusinessLicence;
import com.hhgx.soft.entitys.DeviceList;
import com.hhgx.soft.entitys.Devices;
import com.hhgx.soft.entitys.FireSystem;
import com.hhgx.soft.entitys.Flatpic;
import com.hhgx.soft.entitys.Gateway;
import com.hhgx.soft.entitys.GatewaySystemInfo;
import com.hhgx.soft.entitys.OnlineOrg;
import com.hhgx.soft.entitys.Site;

@Component
@MapperScan("/orginfoMapper")
public interface OrginfoMapper {

	void updateOnlineOrg(OnlineOrg onlineOrg);

	OnlineOrg getOnlineOrg(@Param("orgID")String orgID);

	BusinessLicence getBusinessLicence(@Param("orgid")String orgid);

	List<FireSystem> getFireSystemList(@Param("orgid")String orgid);

	int getFireSystemListCount(@Param("orgid")String orgid);

	List<FireSystem> getFireSystemListByPage(@Param("orgid")String orgid, @Param("startPos")int startPos, @Param("pageSize")int pageSize);

	List<Site> briefsiteList(@Param("orgid") String orgid);

	void deleteorgSys(@Param("siteid")String siteid, @Param("tiSysType")String tiSysType);

	void deleteGateway(String gatewayaddress);
	void selectVgateway(String gatewayaddress);


	int gePatrolRecordByOrgCount(String orgid);

	List<Gateway> selectGateway(@Param("orgid")String orgid, @Param("startPos")int startPos, @Param("pageSize")int pageSize);

	void deleteGatewaySysInfo(String gatewayaddress);

	void addGatewaySysInfo(GatewaySystemInfo gatewaySystemInfo);

	void addGateway(Gateway gateway);

	/*no application*/
	
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
//
	int selectDevicesListCount(@Param("cFlatPic")String cFlatPic, @Param("iDeviceType")String iDeviceType, @Param("deviceaddress")String deviceaddress);
	List<DeviceList> selectDevicesLists(@Param("cFlatPic")String cFlatPic, @Param("iDeviceType")String iDeviceType, @Param("deviceaddress")String deviceaddress, @Param("startPos")int startPos,
			@Param("pageSize")int pageSize);
	Devices selectDeviceDetail(@Param("gatewayaddress") String gatewayaddress, @Param("sysaddress") String sysaddress,
			@Param("deviceaddress") String deviceaddress);

}
