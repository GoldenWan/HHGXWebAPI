package com.hhgx.soft.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hhgx.soft.entitys.Appearancepic;
import com.hhgx.soft.entitys.BusinessLicence;
import com.hhgx.soft.entitys.DeviceList;
import com.hhgx.soft.entitys.Devices;
import com.hhgx.soft.entitys.FireSystem;
import com.hhgx.soft.entitys.Flatpic;
import com.hhgx.soft.entitys.Gateway;
import com.hhgx.soft.entitys.GatewaySystemInfo;
import com.hhgx.soft.entitys.OnlineOrg;
import com.hhgx.soft.entitys.Page;
import com.hhgx.soft.entitys.Site;
import com.hhgx.soft.services.OrginfoService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.DateUtils;
import com.hhgx.soft.utils.GetRequestJsonUtils;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;
import com.hhgx.soft.utils.UploadUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/Orginfo")
public class OrginfoController {
	@Autowired
	private OrginfoService orginfoService;

	/**
	 * 8.防火单位消防系统查询【分页】
	 *
	 * orgid isDivid
	 * 
	 * @throws IOException
	 */

	@ResponseBody
	@RequestMapping(value = "/GetFireSystemList", method = RequestMethod.POST)
	public String getFireSystemList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid","isDivid", "PageIndex");
		String orgid = map.get("orgid");
		String isDivid = map.get("isDivid");
		String pageIndex = map.get("pageIndex");
		int statusCode = -1;
		Page page = null;
		List<FireSystem> list = null;

		if (!StringUtils.isEmpty(isDivid) && isDivid.equals("No")) {
			try {
				list = orginfoService.getFireSystemList(orgid);
				statusCode = ConstValues.OK;
			} catch (Exception e) {
				e.printStackTrace();
				statusCode = ConstValues.FAILED;
			}
			return ResponseJson.responseFindJsonArray(list, statusCode);

		}
		List<Map<String, Object>> lmList =null;
		int totalCount = orginfoService.getFireSystemListCount(orgid);
		try {
				if (pageIndex != null) {
					page = new Page(totalCount, Integer.parseInt(pageIndex));
					lmList = orginfoService.getFireSystemListByPage(orgid, page.getStartPos(), page.getPageSize());

				} else {
					page = new Page(totalCount, 1);
					lmList = orginfoService.getFireSystemListByPage(orgid, page.getStartPos(), page.getPageSize());
				}
				
				statusCode = ConstValues.OK;

			} catch (Exception e) {
				e.printStackTrace();
				statusCode = ConstValues.FAILED;
			}
			return ResponseJson.responseFindPageJsonArray(lmList, statusCode, totalCount);
		}


	/**
	 * 18.根据防火单位获取建物简要列表
	 * 
	 * @throws IOException
	 */

	@ResponseBody
	@RequestMapping(value = "/BriefsiteList", method = RequestMethod.POST)
	public String briefsiteList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid");
		String orgid = map.get("orgid");
		List<Site> siteList = null;
		int statusCode = -1;
		try {
			siteList = orginfoService.briefsiteList(orgid);
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(siteList, statusCode);
	}

	/**
	 * 20.删除防火单位的系统
	 * 
	 * @throws IOException
	 */

	@ResponseBody
	@RequestMapping(value = "/DeleteorgSys", method = RequestMethod.POST)
	public String deleteorgSys(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "siteid", "tiSysType");
		String siteid = map.get("siteid");
		String tiSysType = map.get("tiSysType");
		String dataBag = null;
		int statusCode = -1;
		try {
			// Cannot delete or update a parent row: a foreign key constraint fails (`hhnew`.`gatewaysysteminfo`, CONSTRAINT `RefonlineFiresystem142` FOREIGN KEY (`tiSysType`, `siteid`) REFERENCES `onlinefiresystem` (`tiSysType`, `siteid`))
			//at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
			orginfoService.deleteorgSys(siteid, tiSysType);
			

			statusCode = ConstValues.OK;
			dataBag = "刪除成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "刪除失败";
		}

		return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 * 21.添加传输设备
	 * 
	 * @throws IOException
	 */

	@ResponseBody
	@RequestMapping(value = "/AddGateway", method = RequestMethod.POST)
	public String addGateway(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqOriginJson(reqBody, "Gatewayaddress", "Manufacturer", "Model",
				"productdate", "setupdate", "ControlorManufacture", "ControlorMode", "memo","FireSysList");
		String gatewayaddress = map.get("Gatewayaddress");
		String manufacturer = map.get("Manufacturer");
		String model = map.get("Model");
		String productdate = map.get("productdate");
		String setupdate = map.get("setupdate");
		String controlorManufacture = map.get("ControlorManufacture");
		String controlorMode = map.get("ControlorMode");
		String memo = map.get("memo");
		String dataBag = null;
		int statusCode = -1;
		
		if(orginfoService.findGatewayaddressExist(gatewayaddress)){
			statusCode=-256;
			return ResponseJson.responseAddJson("传输设备地址:"+gatewayaddress+"已存在", statusCode);
		}
		try {
			Gateway gateway = new Gateway();
			gateway.setGatewayaddress(gatewayaddress);
			gateway.setManufacturer(manufacturer);
			gateway.setModel(model);
			gateway.setProductdate(productdate);
			gateway.setSetupdate(setupdate);
			gateway.setControlorManufacture(controlorManufacture);
			gateway.setControlorMode(controlorMode);
			gateway.setMemo(memo);
			orginfoService.addGateway(gateway);
			
			JSONArray json = JSONArray.fromObject(map.get("FireSysList"));
			if (json.length() > 0) {
				for (int i = 0; i < json.length(); i++) {
					JSONObject jobj = json.getJSONObject(i);
					GatewaySystemInfo gatewaySystemInfo = new GatewaySystemInfo();
					gatewaySystemInfo.setSiteid(jobj.getString("siteid"));
					gatewaySystemInfo.setTiSysType(jobj.getString("tisystype"));
					gatewaySystemInfo.setSysaddress(jobj.getString("Sysaddress"));
					gatewaySystemInfo.setGatewayaddress(gatewayaddress);
					orginfoService.addGatewaySysInfo(gatewaySystemInfo);
				}
			}
			statusCode = ConstValues.OK;
			dataBag = "插入成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "插入失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 * 22.修改传输设备
	 * 
	 * @throws IOException
	 */


	@ResponseBody
	@RequestMapping(value = "/UpdateGateway", method = RequestMethod.POST)
	public String updateGateway(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqOriginJson(reqBody, "Gatewayaddress", "newGatewayaddress",
				"Manufacturer", "Model", "productdate", "setupdate", "ControlorManufacture", "ControlorMode", "memo","FireSysList");

		String gatewayaddress = map.get("Gatewayaddress");// 设备传输地址
		String newGatewayaddress = map.get("newGatewayaddress");
		String manufacturer = map.get("Manufacturer");
		String model = map.get("Model");
		String productdate = map.get("productdate");
		String setupdate = map.get("setupdate");
		String controlorManufacture = map.get("ControlorManufacture");
		String controlorMode = map.get("ControlorMode");
		String memo = map.get("memo");
		String dataBag = null;
		int statusCode = -1;
		if(StringUtils.isEmpty(gatewayaddress)){
			statusCode=-256;
			dataBag = "修改失败，gatewayaddress为空";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		}
		try {
			Gateway gateway = new Gateway();
			gateway.setGatewayaddress(newGatewayaddress);
			gateway.setManufacturer(manufacturer);
			gateway.setModel(model);
			gateway.setProductdate(productdate);
			gateway.setSetupdate(setupdate);
			gateway.setControlorManufacture(controlorManufacture);
			gateway.setControlorMode(controlorMode);
			gateway.setMemo(memo);
			// GatewaySystemInfo删除Gatewayaddress相关的所有数据
			//orginfoService.deleteGatewaySysInfo(gatewayaddress);

			if (orginfoService.findGatewayaddressExist(newGatewayaddress)) {
				orginfoService.updateGatewayExist(gateway);
			} else {
				orginfoService.updateGateway(gateway);
			}

			JSONArray json = JSONArray.fromObject(map.get("FireSysList"));
			if (json.length() > 0) {
				for (int i = 0; i < json.length(); i++) {
					JSONObject jobj = json.getJSONObject(i);
					GatewaySystemInfo gatewaySystemInfo = new GatewaySystemInfo();
					gatewaySystemInfo.setSiteid(jobj.getString("siteid"));//
					gatewaySystemInfo.setTiSysType(jobj.getString("tisystype"));
					gatewaySystemInfo.setSysaddress(jobj.getString("Sysaddress"));// 主键
					gatewaySystemInfo.setGatewayaddress(newGatewayaddress);// 主键
					orginfoService.updateGatewaySysInfo(gatewaySystemInfo);

				}
			}
			statusCode = ConstValues.OK;
			dataBag = "修改成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "修改失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 * 23.查询传输设备
	 * 
	 * @throws IOException
	 */

	@ResponseBody
	@RequestMapping(value = "/SelectGateway", method = RequestMethod.POST)
	public String selectGateway(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid", "PageIndex");
		String orgid = map.get("orgid");
		String pageIndex = map.get("pageIndex");
		Page page = null;
		List<Gateway> gatewayList = null;
		List<Map<String, Object>> lmList = new ArrayList<Map<String, Object>>();
		int statusCode = -1;

		int totalCount = orginfoService.gePatrolRecordByOrgCount(orgid);
		try {
			if (pageIndex != null) {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				gatewayList = orginfoService.selectGateway(orgid, page.getStartPos(), page.getPageSize());

			} else {
				page = new Page(totalCount, 1);
				gatewayList = orginfoService.selectGateway(orgid, page.getStartPos(), page.getPageSize());

			}

			for (Gateway gateway : gatewayList) {
				Map<String, Object> map3 = new HashMap<String, Object>();

				map3.put("Gatewayaddress", gateway.getGatewayaddress());
				map3.put("Manufacturer", gateway.getManufacturer());
				map3.put("Model", gateway.getModel());
				map3.put("productdate", DateUtils.formatToDateTime(gateway.getProductdate()));
				map3.put("setupdate", DateUtils.formatToDateTime(gateway.getSetupdate()));
				map3.put("ControlorManufacture", gateway.getControlorManufacture());
				map3.put("ControlorMode", gateway.getControlorMode());
				map3.put("memo", gateway.getMemo());
				map3.put("ynonline", gateway.getYnonline());
				map3.put("onlinetime", DateUtils.formatToDateTime(gateway.getOnlinetime()));
				List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
				for (GatewaySystemInfo gatewaysyinfo : gateway.getGatewaySystemInfoList()) {
					Map<String, Object> map2 = new HashMap<String, Object>();
					map2.put("siteid", gatewaysyinfo.getSiteid());
					map2.put("sitename", gatewaysyinfo.getSitename());
					map2.put("tiSysType", gatewaysyinfo.getTiSysType());
					map2.put("vSysdesc", gatewaysyinfo.getvSysdesc());
					map2.put("Sysaddress", gatewaysyinfo.getSysaddress());
					list.add(map2);
					
				}
				map3.put("FireSysList", list);
				lmList.add(map3);
			}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJsonArray(lmList, statusCode, totalCount);
	}

	/**
	 * 24.删除传输设备
	 * 
	 * @throws IOException
	 */

	@ResponseBody
	@RequestMapping(value = "/DeleteGateway", method = RequestMethod.POST)
	public String deleteGateway(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "Gatewayaddress");
		String gatewayaddress = map.get("gatewayaddress");
		String dataBag = null;
		int statusCode = -1;
		try {
			orginfoService.deleteGatewaySysInfo(gatewayaddress);
			orginfoService.deleteGateway(gatewayaddress);
			statusCode = ConstValues.OK;
			dataBag = "刪除成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "刪除失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);
	}

	/**
	 * 25.查询楼层平面图信息
	 * 
	 * @throws IOException
	 */

	@ResponseBody
	@RequestMapping(value = "/GetflatpicList", method = RequestMethod.POST)
	public String getflatpicList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> ret = RequestJson.reqFirstLowerJson(reqBody, "orgid", "siteid", "PageIndex");
		String orgid = ret.get("orgid");
		String siteid = ret.get("siteid");
		String pageIndex = ret.get("pageIndex");
		
		Page page = null;
		List<Flatpic> flatpicList = null;
		int statusCode = -1;

		int totalCount = orginfoService.getflatpicCount(orgid,siteid);
		try {
			if (pageIndex != null) {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				flatpicList = orginfoService.getflatpicListPage(orgid, siteid, page.getStartPos(), page.getPageSize());

			} else {
				page = new Page(totalCount, 1);
				flatpicList = orginfoService.getflatpicListPage(orgid, siteid, page.getStartPos(), page.getPageSize());
			}
		
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJsonArray(flatpicList, statusCode, totalCount);
	}

	/**
	 * 28.删除平面图
	 * 
	 * @throws IOException
	 */

	@ResponseBody
	@RequestMapping(value = "/DeleteflatPic", method = RequestMethod.POST)
	public String deleteflatPic(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "cFlatPic");
		String cFlatPic = map.get("cFlatPic");
		String dataBag = null;
		int statusCode = -1;
		try {
			orginfoService.deleteDevicesBycflatPic(cFlatPic);
			orginfoService.deleteflatPic(cFlatPic);
			statusCode = ConstValues.OK;
			dataBag = "删除数据成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "删除数据失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);
	}

	/**
	 * 29.添加自动报警部件
	 * 
	 * @throws IOException
	 */
	@Transactional
	@ResponseBody
	@RequestMapping(value = "/AddDevices", method = RequestMethod.POST)
	public String addDevices(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqOriginJson(reqBody, "Road", "Address", "sysaddress", "gatewayaddress",
				"vdesc", "fPositionX", "fPositionY", "location", "Manufacture", "Model", "ProductDate", "expdate",
				"AddTime", "memo", "cFlatPic", "iDeviceType");
		String road = map.get("Road");
		String address = map.get("Address");
		String sysaddress = map.get("sysaddress");
		String gatewayaddress = map.get("gatewayaddress");
		String vdesc = map.get("vdesc");
		String fPositionX = map.get("fPositionX");
		String fPositionY = map.get("fPositionY");
		String location = map.get("location");
		String manufacture = map.get("Manufacture");
		String model = map.get("Model");
		String productDate = map.get("ProductDate");
		String expdate = map.get("expdate");
		String addTime = map.get("AddTime");
		String memo = map.get("memo");
		String cFlatPic = map.get("cFlatPic");
		String iDeviceType = map.get("iDeviceType");

		int statusCode = -1;
		String dataBag = null;
		try {
			Devices devices = new Devices();
			// 插入数据时DeviceNo：根据cFlatPic查找，若没有数据DeviceNo=1，若有数据则取最大数据+1

			int deviceNo = 1;
			deviceNo = orginfoService.findMaxDeviceNo(cFlatPic) + 1;
			devices.setDeviceaddress(road + "." + address);
			devices.setRoad(road);
			devices.setAddress(gatewayaddress);
			devices.setSysaddress(Integer.parseInt(sysaddress));
			devices.setDeviceNo(deviceNo);
			devices.setGatewayaddress(gatewayaddress);
			devices.setVdesc(vdesc);
			devices.setfPositionX(fPositionX);
			devices.setfPositionY(fPositionY);
			devices.setLocation(location);
			devices.setManufacture(manufacture);
			devices.setModel(model);
			devices.setProductDate(DateUtils.StringToDate(productDate, "yyyy/MM/dd"));
			devices.setExpdate(DateUtils.StringToDate(expdate, "yyyy/MM/dd"));
			devices.setAddTime(DateUtils.StringToDate(addTime, "yyyy/MM/dd"));
			devices.setMemo(memo);
			devices.setcFlatPic(cFlatPic);
			devices.setiDeviceType(iDeviceType);

			orginfoService.addDevices(devices);
			statusCode = ConstValues.OK;
			dataBag = "添加成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "添加失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 * 30.修改自动报警部件  * 
	 * @param maprq  * @return  * @throws
	 * JsonProcessingException:TODO  
	 * 
	 * @throws IOException
	 */

	@Transactional
	@ResponseBody
	@RequestMapping(value = "/UpdateDevices", method = RequestMethod.POST)
	public String updateDevices(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqOriginJson(reqBody, "Road", "Address", "sysaddress", "gatewayaddress",
				"vdesc", "fPositionX", "fPositionY", "location", "Manufacture", "Model", "ProductDate", "expdate",
				"AddTime", "memo", "cFlatPic", "iDeviceType", "DeviceNo");

		String road = map.get("Road");
		String address = map.get("Address");
		String sysaddress = map.get("sysaddress");
		String gatewayaddress = map.get("gatewayaddress");
		String vdesc = map.get("vdesc");
		String fPositionX = map.get("fPositionX");
		String fPositionY = map.get("fPositionY");
		String location = map.get("location");
		String manufacture = map.get("Manufacture");
		String model = map.get("Model");
		String productDate = map.get("ProductDate");
		String expdate = map.get("expdate");
		String addTime = map.get("AddTime");
		String memo = map.get("memo");
		String cFlatPic = map.get("cFlatPic");
		String iDeviceType = map.get("iDeviceType");
		String deviceNo = map.get("DeviceNo");

		int statusCode = -1;
		String dataBag = null;
		try {
			Devices devices = new Devices();

			devices.setDeviceaddress(road + "." + address);
			devices.setRoad(road);
			devices.setAddress(address);
			devices.setSysaddress(Integer.parseInt(sysaddress));
			devices.setDeviceNo(Integer.parseInt(deviceNo));
			devices.setGatewayaddress(gatewayaddress);
			devices.setVdesc(vdesc);
			devices.setfPositionX(fPositionX);
			devices.setfPositionY(fPositionY);
			devices.setLocation(location);
			devices.setManufacture(manufacture);
			devices.setModel(model);
			devices.setProductDate(DateUtils.StringToDate(productDate, "yyyy/MM/dd"));
			devices.setExpdate(DateUtils.StringToDate(expdate, "yyyy/MM/dd"));
			devices.setAddTime(DateUtils.StringToDate(addTime, "yyyy/MM/dd"));
			devices.setMemo(memo);
			devices.setcFlatPic(cFlatPic);
			devices.setiDeviceType(iDeviceType);

			orginfoService.updateDevices(devices);
			statusCode = ConstValues.OK;
			dataBag = "修改成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "修改失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 * 31.删除自动报警部件  * 
	 * @param reqBody  * @param request  * @return  * @throws
	 * JsonProcessingException:TODO  
	 * 
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value = "/DeleteDevices", method = RequestMethod.POST)
	public String deleteDevices(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "deviceaddress", "sysaddress",
				"gatewayaddress");
		String deviceaddress = map.get("deviceaddress");
		String sysaddress = map.get("sysaddress");
		String gatewayaddress = map.get("gatewayaddress");
		String dataBag = null;
		int statusCode = -1;
		try {
			orginfoService.deleteDevices(deviceaddress, sysaddress, gatewayaddress);
			statusCode = ConstValues.OK;
			dataBag = "刪除成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "刪除失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);
	}

	/**
	 * 32.查询自动报警部件列表
	 * 
	 * @throws IOException
	 */

	@ResponseBody
	@RequestMapping(value = "/SelectDevicesList", method = RequestMethod.POST)
	public String selectDevicesList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> ret = RequestJson.reqOriginJson(reqBody, "cFlatPic", "iDeviceType", "deviceaddress",
				"PageIndex");
		String cFlatPic = ret.get("cFlatPic");
		String iDeviceType = ret.get("iDeviceType");// 若为0，忽略此条件
		String deviceaddress = ret.get("deviceaddress");// 若为0，忽略此条件
		String pageIndex = ret.get("PageIndex");

		Page page = null;
		List<DeviceList> deviceLists = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		int totalCount = orginfoService.selectDevicesListCount(cFlatPic, iDeviceType, deviceaddress);
		int statusCode = -1;

		try {
			if (pageIndex != null) {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				deviceLists = orginfoService.selectDevicesLists(cFlatPic, iDeviceType, deviceaddress,
						page.getStartPos(), page.getPageSize());

			} else {
				page = new Page(totalCount, 1);
				deviceLists = orginfoService.selectDevicesLists(cFlatPic, iDeviceType, deviceaddress,
						page.getStartPos(), page.getPageSize());
			}
			for (DeviceList deviceList : deviceLists) {
				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("deviceaddress", deviceList.getDeviceaddress());
				map2.put("sysaddress", deviceList.getSysaddress());
				map2.put("gatewayaddress", deviceList.getGatewayaddress());
				map2.put("fPositionX", deviceList.getfPositionX());
				map2.put("fPositionY", deviceList.getfPositionY());
				map2.put("location", deviceList.getLocation());
				map2.put("DeviceNo", deviceList.getDeviceNo());
				map2.put("iDeviceType", deviceList.getiDeviceType());
				map2.put("imFlatPic", deviceList.getImFlatPic());
				map2.put("DeviceTypeName", deviceList.getDeviceTypeName());

				lmList.add(map2);
			}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJsonArray(lmList, statusCode, totalCount);

	}

	/**
	 * 33.查询自动报警部件详情
	 * 
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value = "/SelectDeviceDetail", method = RequestMethod.POST)
	public String selectDeviceDetail(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> ret = RequestJson.reqOriginJson(reqBody, "gatewayaddress", "sysaddress", "deviceaddress");

		String gatewayaddress = ret.get("gatewayaddress");
		String sysaddress = ret.get("sysaddress");
		String deviceaddress = ret.get("deviceaddress");
		Map<String, String> map2 = new HashMap<String, String>();
		int statusCode = -1;
		Devices devices = new Devices();
		try {
			devices = orginfoService.selectDeviceDetail(gatewayaddress, sysaddress, deviceaddress);
			if (!StringUtils.isEmpty(devices)) {

				map2.put("deviceaddress", devices.getDeviceaddress());
				map2.put("sysaddress", String.valueOf(devices.getSysaddress()));
				map2.put("gatewayaddress", devices.getGatewayaddress());
				map2.put("vdesc", devices.getVdesc());
				map2.put("fPositionX", devices.getfPositionX());
				map2.put("fPositionY", devices.getfPositionY());
				map2.put("location", devices.getLocation());
				map2.put("Manufacture", devices.getManufacture());
				map2.put("Model", devices.getModel());
				map2.put("ProductDate", DateUtils.formatDateTime(devices.getProductDate()));
				map2.put("expdate", DateUtils.formatDateTime(devices.getExpdate()));
				map2.put("AddTime", devices.getDeviceaddress());
				map2.put("memo", devices.getMemo());
				map2.put("DeviceNo", String.valueOf(devices.getDeviceNo()));
				map2.put("cFlatPic", devices.getcFlatPic());
				map2.put("iDeviceType", devices.getiDeviceType());
				map2.put("StateValue", devices.getStateValue());
				map2.put("StateTime", DateUtils.formatDateTime(devices.getStateTime()));
				map2.put("DeviceTypeName", devices.getDeviceTypeName());
			}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJson(map2, statusCode);

	}
	/**
	 * 34.标注一个自动报警部件在平面图上的位置
	 */

	
	/**
	 * 38.删除外观图
	 */
	@ResponseBody
	@RequestMapping(value = "/DeleteAppearance", method = RequestMethod.POST)
	public String deleteAppearance(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "iphotoID");
		String iphotoID = map.get("iphotoID");
		String dataBag = null;
		int statusCode = -1;
		try {
			orginfoService.deleteAppearance(iphotoID);
			statusCode = ConstValues.OK;
			dataBag = "刪除成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "刪除失败";
		}
			return ResponseJson.responseAddJson(dataBag, statusCode);
	}
	
	/**
	 * 58.修改防火单位信息【**】  * @param map  * @return  * @throws
	 * JsonProcessingException:TODO  
	 * 
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value = "/UpdateOnlineOrg", method = RequestMethod.POST)
	public Object updateOnlineOrg(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> ret = RequestJson.reqOriginJson(reqBody, "OrgID", "orgcode", "orgname", "souyouzhi",
				"OrganType", "otherthings", "YnImportant", "SuperiorOrg", "cZip", "vTel", "fax",
				"E_Mail", "howmanypeople", "realtymoney", "ipersonnum", "fAreanum",
				"fBuildingarea", "GasType", "howmanyexit", "howmanystair", "howmanylane", "howmanyelevator",
				"lanelocation", "vfireroomtel", "escapefloor", "escapebuildingarea",
				"AutoFireFacility", "ManagerOrgID", "neareast",
				"nearsouth", "nearwest", "nearnorth", "managegrade", "NetworkStatus", "NetworkTime","howmanyfireman"
				);
		
		///managegrade 和GasType
		
		String orgID = ret.get("OrgID");
		String orgcode = ret.get("orgcode");
		String orgname = ret.get("orgname");
		String souyouzhi = ret.get("souyouzhi");
		String organType = ret.get("OrganType");
		String otherthings = ret.get("otherthings");
		String ynImportant = ret.get("YnImportant");
		String superiorOrg = ret.get("SuperiorOrg");
		
		String cZip = ret.get("cZip");
		String vTel = ret.get("vTel");
		String fax = ret.get("fax");
		String eMail = ret.get("E_Mail");
		String howmanypeople = ret.get("howmanypeople");
		String autoFireFacility = ret.get("AutoFireFacility");
		//String dRecordDate = ret.get("dRecordDate");
		String managerOrgID = ret.get("ManagerOrgID");
		String neareast = ret.get("neareast");
		String nearsouth = ret.get("nearsouth");
		String nearwest = ret.get("nearwest");
		String nearnorth = ret.get("nearnorth");

		String managegrade = ret.get("managegrade");
		String networkStatus = ret.get("NetworkStatus");
		String networkTime = ret.get("NetworkTime");
		String realtymoney = ret.get("realtymoney");
		String ipersonnum = ret.get("ipersonnum");
		String fAreanum = ret.get("fAreanum");
		String fBuildingarea = ret.get("fBuildingarea");
		String gasType = ret.get("GasType");
		String howmanyfireman = ret.get("howmanyfireman");
		String howmanyexit = ret.get("howmanyexit");
		String howmanystair = ret.get("howmanystair");
		String howmanylane = ret.get("howmanylane");
		String howmanyelevator = ret.get("howmanyelevator");
		String lanelocation = ret.get("lanelocation");
		String vfireroomtel = ret.get("vfireroomtel");
		String escapefloor = ret.get("escapefloor");
		String escapebuildingarea = ret.get("escapebuildingarea");
		

		
		//String setupDate = ret.get("SetupDate");

		OnlineOrg onlineOrg = new OnlineOrg();
		onlineOrg.setNeareast(neareast);
		onlineOrg.setNearwest(nearwest);
		onlineOrg.setNearsouth(nearsouth);
		onlineOrg.setNearnorth(nearnorth);
		onlineOrg.setManagegrade(managegrade);
		onlineOrg.setNetworkStatus(networkStatus);
		onlineOrg.setNetworkTime(DateUtils.StringToDate(networkTime, "yyyy-MM-dd"));
		onlineOrg.setOrgID(orgID);
		onlineOrg.setOrgcode(orgcode);
		onlineOrg.setOrgname(orgname);
		onlineOrg.setOrganType(organType);
		onlineOrg.setSouyouzhi(souyouzhi);
		onlineOrg.setOtherthings(otherthings);
		onlineOrg.setYnImportant(ynImportant);
		onlineOrg.setSuperiorOrg(superiorOrg);
		onlineOrg.setSetupDate(new Date());
		onlineOrg.setvTel(vTel);
		onlineOrg.setFax(fax);
		onlineOrg.setIpersonnum(ipersonnum);
		onlineOrg.setAutoFireFacility(autoFireFacility);
		onlineOrg.setcZip(cZip);
		onlineOrg.setEscapebuildingarea(escapebuildingarea);
		onlineOrg.setRealtymoney(realtymoney);
		onlineOrg.setVfireroomtel(vfireroomtel);
		onlineOrg.setGasType(gasType);
		onlineOrg.setHowmanyfireman(howmanyfireman);
		onlineOrg.setHowmanystair(howmanystair);
		onlineOrg.setHowmanylane(howmanylane);
		onlineOrg.setLanelocation(lanelocation);
		onlineOrg.setHowmanypeople(howmanypeople);
		onlineOrg.seteMail(eMail);
		//onlineOrg.setdRecordDate(DateUtils.StringToDate(dRecordDate, "yyyy/MM/dd"));
		onlineOrg.setEscapefloor(escapefloor);
		onlineOrg.setfAreanum(fAreanum);
		onlineOrg.setfBuildingarea(fBuildingarea);
		onlineOrg.setGasType(gasType);
		onlineOrg.setHowmanyelevator(howmanyelevator);
		onlineOrg.setHowmanyexit(howmanyexit);
		if(!StringUtils.isEmpty(managerOrgID) && managerOrgID!="null"){
			onlineOrg.setManagerOrgID(managerOrgID);
		}
		String dataBag = null;
		int statusCode = -1;
		try {
			orginfoService.updateOnlineOrg(onlineOrg);
			dataBag = "修改成功";
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			dataBag = "修改失败";
			statusCode = ConstValues.FAILED;
		}

		return ResponseJson.responseAddJson(dataBag, statusCode);

	}
	/**
	 * 62.删除建筑物信息（P）
	 */
	@ResponseBody
	@RequestMapping(value = "/DeleteSite", method = RequestMethod.POST)
	public String deleteSite(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "siteid");
		String siteid = map.get("siteid");
		String dataBag = null;
		int statusCode = -1;
		try {
			
			orginfoService.deleteSite(siteid);
			statusCode = ConstValues.OK;
			dataBag = "刪除成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "刪除失败";
		}
			return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	
	/**
	 * 84.获取防火单位信息【**】
	 * 
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value = "/GetOnlineOrg", method = RequestMethod.POST)
	public String getOnlineOrg(HttpServletRequest request) throws IOException {
		
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> ret = RequestJson.reqOriginJson(reqBody, "OrgID");
		String orgID = ret.get("OrgID");
		Map<String, String> map2 = new HashMap<String, String>();
		int statusCode = -1;
		try {
			OnlineOrg onlineOrg = orginfoService.getOnlineOrg(orgID);
				   
			
			if (!StringUtils.isEmpty(onlineOrg)) {
				map2.put("orgcode", onlineOrg.getOrgcode());
				map2.put("orgname", onlineOrg.getOrgname());
				map2.put("vAddress", onlineOrg.getvAddress());
				map2.put("OrganType", onlineOrg.getOrganType());
				map2.put("vNamelegalperson", onlineOrg.getvNamelegalperson());
				map2.put("otherthings", onlineOrg.getOtherthings());
				map2.put("YnImportant", onlineOrg.getYnImportant());
				map2.put("SuperiorOrg", onlineOrg.getSuperiorOrg());
				map2.put("cZip", onlineOrg.getcZip());
				map2.put("vTel", onlineOrg.getvTel());
				map2.put("fax", onlineOrg.getFax());
				map2.put("E_Mail", onlineOrg.geteMail());
				map2.put("howmanypeople", onlineOrg.getHowmanypeople());
				map2.put("souyouzhi", onlineOrg.getSouyouzhi());
				map2.put("SetupDate", DateUtils.formatToDate(DateUtils.formatDateTime(onlineOrg.getSetupDate())));
				map2.put("realtymoney", onlineOrg.getRealtymoney());
				map2.put("ipersonnum", onlineOrg.getIpersonnum());
				map2.put("fAreanum", onlineOrg.getfAreanum());
				map2.put("fBuildingarea", onlineOrg.getfBuildingarea());
				map2.put("GasType", onlineOrg.getGasType());
				map2.put("howmanyfireman", onlineOrg.getHowmanyfireman());
				map2.put("howmanyexit", onlineOrg.getHowmanyexit());
				map2.put("howmanystair", onlineOrg.getHowmanystair());
				map2.put("howmanylane", onlineOrg.getHowmanylane());
				map2.put("howmanyelevator", onlineOrg.getHowmanyelevator());
				map2.put("lanelocation", onlineOrg.getLanelocation());
				map2.put("vfireroomtel", onlineOrg.getVfireroomtel());
				map2.put("escapefloor", onlineOrg.getEscapefloor());
				map2.put("escapebuildingarea", onlineOrg.getEscapebuildingarea());
				map2.put("escapelocation", onlineOrg.getEscapelocation());
				map2.put("neareast", onlineOrg.getNeareast());
				map2.put("nearsouth", onlineOrg.getNearsouth());
				map2.put("nearwest", onlineOrg.getNearwest());
				map2.put("nearnorth", onlineOrg.getNearnorth());
				map2.put("AutoFireFacility", onlineOrg.getAutoFireFacility());
				map2.put("fLongitude", onlineOrg.getfLongitude() );
				map2.put("fLatitude", onlineOrg.getfLatitude());
				
				map2.put("bFlatpic", onlineOrg.getbFlatpic());
				map2.put("dRecordDate", DateUtils.formatDate(onlineOrg.getdRecordDate(), null));
				map2.put("managegrade", onlineOrg.getManagegrade());
				map2.put("NetworkStatus", onlineOrg.getNetworkStatus());
				map2.put("NetworkTime", DateUtils.formatDate(onlineOrg.getNetworkTime(), "yyyy-MM-dd"));
				map2.put("ApproveState", onlineOrg.getApproveState());
				map2.put("ApproveTime", DateUtils.formatDate(onlineOrg.getApproveTime(), null));
				map2.put("ApproveMan", onlineOrg.getApproveMan());
				map2.put("AreaId", onlineOrg.getAreaId());
				map2.put("ManagerOrgID", onlineOrg.getManagerOrgID());
				map2.put("orgid", orgID);
			}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(map2, statusCode);
	}

	/**
	 * 34.标注一个自动报警部件在平面图上的位置
	 * 
	 * @throws IOException
	 */
	/**
	 * @ResponseBody
	 * @RequestMapping(value = "/MarkPoint", method = RequestMethod.POST) public
	 *                       String markPoint(HttpServletRequest request) throws
	 *                       IOException { String reqBody =
	 *                       GetRequestJsonUtils.getRequestPostStr(request);
	 *                       Map<String, String> map =
	 *                       RequestJson.reqFirstLowerJson(reqBody,
	 *                       "deviceaddress", "sysaddress", "gatewayaddress",
	 *                       "cFlatPic", "DeviceNo", "fPositionX",
	 *                       "fPositionY"); String deviceaddress =
	 *                       map.get("deviceaddress"); String sysaddress =
	 *                       map.get("sysaddress"); String gatewayaddress =
	 *                       map.get("gatewayaddress"); String cFlatPic =
	 *                       map.get("cFlatPic"); String deviceNo =
	 *                       map.get("deviceNo"); String fPositionX =
	 *                       map.get("fPositionX"); String fPositionY =
	 *                       map.get("fPositionY"); Map<String, String> map2 =
	 *                       new HashMap<String, String>(); int statusCode =-1;
	 *                       try{ Devices devices=new Devices();
	 *                       devices.setDeviceaddress(deviceaddress);
	 *                       devices.setSysaddress(Integer.parseInt(sysaddress))
	 *                       ; devices.setDeviceNo(Integer.parseInt(deviceNo));
	 *                       devices.setGatewayaddress(gatewayaddress);
	 *                       devices.setfPositionX(fPositionX);
	 *                       devices.setfPositionY(fPositionY);
	 *                       devices.setcFlatPic(cFlatPic);
	 * 
	 * 
	 *                       Devices newDevices =
	 *                       orginfoService.markPoint(devices);
	 * 
	 *                       if (!StringUtils.isEmpty(newDevices)) {
	 * 
	 *                       map2.put("deviceaddress",
	 *                       newDevices.getDeviceaddress());
	 *                       map2.put("sysaddress",
	 *                       String.valueOf(newDevices.getSysaddress()));
	 *                       map2.put("gatewayaddress",
	 *                       newDevices.getGatewayaddress());
	 *                       map2.put("DeviceNo",
	 *                       String.valueOf(newDevices.getDeviceNo()));
	 *                       map2.put("iDeviceType",
	 *                       newDevices.getiDeviceType());
	 *                       map2.put("DeviceTypeName",
	 *                       newDevices.getDeviceTypeName());
	 * 
	 * 
	 *                       } statusCode = ConstValues.OK;
	 * 
	 * 
	 *                       } catch (Exception e) { e.printStackTrace();
	 *                       statusCode = ConstValues.FAILED; } return
	 *                       ResponseJson.responseFindJson(map2, statusCode); }
	 */
	/**
	 * 35.获取第一个自动报警部件
	 */
	/**
	 * @ResponseBody
	 * @RequestMapping(value = "/GetFirstDevice", method = RequestMethod.POST)
	 *                       public String getFirstDevice(HttpServletRequest
	 *                       request) throws IOException { String reqBody =
	 *                       GetRequestJsonUtils.getRequestPostStr(request);
	 *                       Map<String, String> map =
	 *                       RequestJson.reqFirstLowerJson(reqBody, "cFlatPic");
	 *                       String cFlatPic = map.get("cFlatPic");
	 * 
	 *                       Map<String, String> map2 = new HashMap<String,
	 *                       String>(); int statusCode =-1; try{
	 * 
	 * 
	 *                       Devices newDevices =
	 *                       orginfoService.getFirstDevice(cFlatPic);
	 * 
	 *                       if (!StringUtils.isEmpty(newDevices)) {
	 * 
	 *                       map2.put("deviceaddress",
	 *                       newDevices.getDeviceaddress());
	 *                       map2.put("sysaddress",
	 *                       String.valueOf(newDevices.getSysaddress()));
	 *                       map2.put("gatewayaddress",
	 *                       newDevices.getGatewayaddress());
	 *                       map2.put("DeviceNo",
	 *                       String.valueOf(newDevices.getDeviceNo()));
	 *                       map2.put("iDeviceType",
	 *                       newDevices.getiDeviceType());
	 *                       map2.put("DeviceTypeName",
	 *                       newDevices.getDeviceTypeName()); } statusCode =
	 *                       ConstValues.OK;
	 * 
	 *                       } catch (Exception e) { e.printStackTrace();
	 *                       statusCode = ConstValues.FAILED; } return
	 *                       ResponseJson.responseFindJson(map2, statusCode); }
	 */
	/**
	 * 36.获取某一个自动报警部件
	 */
	/**
	 * @ResponseBody
	 * @RequestMapping(value = "/GetOneDevice", method = RequestMethod.POST)
	 *                       public String getOneDevice(HttpServletRequest
	 *                       request) throws IOException { String reqBody =
	 *                       GetRequestJsonUtils.getRequestPostStr(request);
	 *                       Map<String, String> map =
	 *                       RequestJson.reqFirstLowerJson(reqBody, "cFlatPic",
	 *                       "DeviceNo");
	 * 
	 *                       String cFlatPic = map.get("cFlatPic"); String
	 *                       deviceNo = map.get("deviceNo");
	 * 
	 *                       Map<String, String> map2 = new HashMap<String,
	 *                       String>(); int statusCode =-1; try{
	 * 
	 * 
	 *                       Devices newDevices =
	 *                       orginfoService.getOneDevice(cFlatPic,deviceNo );
	 * 
	 *                       if (!StringUtils.isEmpty(newDevices)) {
	 *                       map2.put("deviceaddress",
	 *                       newDevices.getDeviceaddress());
	 *                       map2.put("sysaddress",
	 *                       String.valueOf(newDevices.getSysaddress()));
	 *                       map2.put("gatewayaddress",
	 *                       newDevices.getGatewayaddress());
	 *                       map2.put("DeviceNo",
	 *                       String.valueOf(newDevices.getDeviceNo())); }
	 *                       statusCode = ConstValues.OK;
	 * 
	 *                       } catch (Exception e) { e.printStackTrace();
	 *                       statusCode = ConstValues.FAILED; } return
	 *                       ResponseJson.responseFindJson(map2, statusCode); }
	 */

	/**
	 * 59. 根据防火单位获取建筑物列表信息（P）
	 */
	@ResponseBody
	@RequestMapping(value = "/GetSiteList", method = RequestMethod.POST)
	public String getSiteList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid","PageIndex");
		String orgid = map.get("orgid");
		String pageIndex = map.get("pageIndex");
		
		Page page = null;
		List<Map<String, String>> list = new ArrayList<>();
		int statusCode = -1;
		List<Site> sites =null;
		int pageCount = orginfoService.getSiteTotalCount(orgid);
		try {
			
			if (pageIndex != null) {
				page = new Page(pageCount, Integer.parseInt(pageIndex));
				 sites = orginfoService.getSiteList(orgid, page.getStartPos(),page.getPageSize());

			} else {
				page = new Page(pageCount, 1);
				 sites = orginfoService.getSiteList(orgid, page.getStartPos(),page.getPageSize());
			}
			
			
			for (Site site : sites) {
				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("siteid", site.getSiteid());
				map2.put("sitename", site.getSitename());
				map2.put("buildingaddress", site.getBuildingaddress());
				map2.put("useproperty", site.getUseproperty());
				map2.put("DSCS", site.getdSCS());
				map2.put("JZGD", site.getjZGD());
				map2.put("DSJZMJ", site.getdSJZMJ());
				map2.put("NHDJ", site.getnHDJ());
				map2.put("JGLX", site.getnHDJ());
				map2.put("DXCS", site.getdXCS());
				map2.put("DXJZMJ", site.getdXJZMJ());
				map2.put("SDQK", site.getsDQK());
				map2.put("ZYCCW", site.getzYCCW());
				map2.put("RLRS", site.getrLRS());
				map2.put("QLJZ", site.getqLJZ());
				map2.put("east", site.getEast());
				map2.put("west", site.getWest());
				map2.put("south", site.getSouth());
				map2.put("north", site.getNorth());
				map2.put("xx", site.getXx());
				map2.put("yy", site.getYy());
				map2.put("sitetypename", site.getSitetypename());
				map2.put("holdthings", site.getHoldthings());
				map2.put("holdthingsnum", site.getHoldthingsnum());
				map2.put("annalTime", DateUtils.formatToDate(site.getAnnalTime()));
				map2.put("fLongitude", site.getfLongitude());
				map2.put("fLatitude", site.getfLatitude());
				map2.put("orgid", site.getOrgid());
				list.add(map2);
			}
			statusCode = ConstValues.OK;

		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJsonArray(list, statusCode, pageCount);
	}
	/**
	 * 60.获取建筑物信息（P）
	 */
	@ResponseBody
	@RequestMapping(value = "/GetSite", method = RequestMethod.POST)
	public String getSite(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "siteid");
		String siteid = map.get("siteid");
		List<Map<String, String>> list = new ArrayList<>();
		int statusCode = -1;
		try {
			
			Site site = orginfoService.getSite(siteid);
			if(!StringUtils.isEmpty(site)){ 
				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("siteid", siteid);
				map2.put("sitename", site.getSitename());
				map2.put("buildingaddress", site.getBuildingaddress());
				map2.put("useproperty", site.getUseproperty());
				map2.put("DSCS", site.getdSCS());
				map2.put("JZGD", site.getjZGD());
				map2.put("DSJZMJ", site.getdSJZMJ());
				map2.put("NHDJ", site.getnHDJ());
				map2.put("JGLX", site.getjGLX());
				map2.put("DXCS", site.getdXCS());
				map2.put("DXJZMJ", site.getdXJZMJ());
				map2.put("SDQK", site.getsDQK());
				map2.put("ZYCCW", site.getzYCCW());
				map2.put("RLRS", site.getrLRS());
				map2.put("QLJZ", site.getqLJZ());
				map2.put("east", site.getEast());
				map2.put("west", site.getWest());
				map2.put("south", site.getSouth());
				map2.put("north", site.getNorth());
				map2.put("xx", site.getXx());
				map2.put("yy", site.getYy());
				map2.put("sitetypename", site.getSitetypename());
				map2.put("holdthings", site.getHoldthings());
				map2.put("holdthingsnum", site.getHoldthingsnum());
				map2.put("annalTime", DateUtils.formatToDate(site.getAnnalTime()));
				map2.put("fLongitude", site.getfLongitude());
				map2.put("fLatitude", site.getfLatitude());
				map2.put("orgid", site.getOrgid());
				list.add(map2);
			}
			statusCode = ConstValues.OK;

		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(list, statusCode);
	}
	/**
	 * 61.修改建筑物信息（P）
	 */
	@ResponseBody
	@RequestMapping(value = "/UpdateSite", method = RequestMethod.POST)
	public String updateSite(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqOriginJson(reqBody,
				"sitename", "buildingaddress", "useproperty",
				"DSCS", "JZGD", "DSJZMJ","NHDJ", "JGLX", "DXCS",
				"DXJZMJ", "SDQK", "ZYCCW","RLRS", "QLJZ", "east", 
				"west", "south", "north", "sitetypename", 
				"holdthings", "holdthingsnum", "fLongitude", 
				"fLatitude", "orgid","annalTime","siteid");
		String annalTime = map.get("annalTime");
		String siteid = map.get("siteid");
		String sitename = map.get("sitename");
		String buildingaddress = map.get("buildingaddress");
		String useproperty = map.get("useproperty");
		String dSCS = map.get("DSCS");
		String jZGD = map.get("JZGD");
		String dSJZMJ = map.get("DSJZMJ");
		String nHDJ = map.get("NHDJ");
		String jGLX = map.get("JGLX");
		String dXCS = map.get("DXCS");
		String dXJZMJ = map.get("DXJZMJ");
		String sDQK = map.get("SDQK");
		String zYCCW = map.get("ZYCCW");
		String rLRS= map.get("RLRS");
		String qLJZ= map.get("QLJZ");
		String east= map.get("east");
		String west= map.get("west");
		String south= map.get("south");
		String north= map.get("north");
	//	String xx= map.get("xx");
	//	String yy= map.get("yy");
		String sitetypename= map.get("sitetypename");
		String holdthings= map.get("holdthings");
		String holdthingsnum= map.get("holdthingsnum");
		//String annalTime= map.get("annalTime");
		String fLongitude= map.get("fLongitude");
		String fLatitude= map.get("fLatitude");
		String orgid = map.get("orgid");
		String dataBag = null;
		int statusCode = -1;
		try {
			Site site = new Site();
			site.setSiteid(siteid);
			site.setSitename(sitename);
			site.setBuildingaddress(buildingaddress);
			site.setUseproperty(useproperty);
			site.setdSCS(dSCS);
			site.setjZGD(jZGD);
			site.setdSCS(dSCS);
			site.setnHDJ(nHDJ);
			site.setdSJZMJ(dSJZMJ);
			site.setjGLX(jGLX);
			site.setdXCS(dXCS);
			site.setdXJZMJ(dXJZMJ);
			site.setsDQK(sDQK);
			site.setzYCCW(zYCCW);
			site.setrLRS(rLRS);
			site.setqLJZ(qLJZ);
			site.setEast(east);
			site.setWest(west);
			site.setSouth(south);
			site.setNorth(north);
			
			//site.setXx(xx);
			//site.setYy(yy);
			
			site.setHoldthings(holdthings);
			site.setSitetypename(sitetypename);
			site.setHoldthingsnum(holdthingsnum);
			
			site.setAnnalTime(annalTime);
			site.setAnnalTime(DateUtils.timesstampToString());
			
			site.setfLongitude(fLongitude);
			site.setfLatitude(fLatitude);
			site.setOrgid(orgid);
			   
			orginfoService.updateSite(site);
			statusCode = ConstValues.OK;
			dataBag = "修改成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "修改失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);
	}
	
	/**
	 * 63.	添加建筑物信息（P）
	 */
	@ResponseBody
	@RequestMapping(value = "/addSite", method = RequestMethod.POST)
	public String addSite(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqOriginJson(reqBody,
				"sitename", "buildingaddress", "useproperty",
				"DSCS", "JZGD", "DSJZMJ","NHDJ", "JGLX", "DXCS",
				"DXJZMJ", "SDQK", "ZYCCW","RLRS", "QLJZ", "east", 
				"west", "south", "north", "sitetypename", 
				"holdthings", "holdthingsnum", "fLongitude", 
				"fLatitude", "orgid");
		String sitename = map.get("sitename");
		String buildingaddress = map.get("buildingaddress");
		String useproperty = map.get("useproperty");
		String dSCS = map.get("DSCS");
		String jZGD = map.get("JZGD");
		String dSJZMJ = map.get("DSJZMJ");
		String nHDJ = map.get("NHDJ");
		String jGLX = map.get("JGLX");
		String dXCS = map.get("DXCS");
		String dXJZMJ = map.get("DXJZMJ");
		String sDQK = map.get("SDQK");
		String zYCCW = map.get("ZYCCW");
		String rLRS= map.get("RLRS");
		String qLJZ= map.get("QLJZ");
		String east= map.get("east");
		String west= map.get("west");
		String south= map.get("south");
		String north= map.get("north");
	//	String xx= map.get("xx");
	//	String yy= map.get("yy");
		String sitetypename= map.get("sitetypename");
		String holdthings= map.get("holdthings");
		String holdthingsnum= map.get("holdthingsnum");
		//String annalTime= map.get("annalTime");
		String fLongitude= map.get("fLongitude");
		String fLatitude= map.get("fLatitude");
		String orgid = map.get("orgid");
		String dataBag = null;
		int statusCode = -1;
		try {
			Site site = new Site();
			String siteid =null;
			//siteid orgid+ 00000001
			String newSiteid = null;
			newSiteid = orginfoService.findMaxBack8(orgid);
			if (StringUtils.isEmpty(newSiteid)) {
				siteid = orgid + "00000001";
			} else {
				StringBuilder sBuilder = new StringBuilder(Integer.parseInt(newSiteid) + 1);
				for(int len =sBuilder.length();len<8;len++){
					sBuilder.insert( 0 , "0" ); 
				}
				siteid = orgid + sBuilder.toString();
			}
			site.setSiteid(siteid);
			site.setSitename(sitename);
			site.setBuildingaddress(buildingaddress);
			site.setUseproperty(useproperty);
			site.setdSCS(dSCS);
			site.setjZGD(jZGD);
			site.setdSCS(dSCS);
			site.setnHDJ(nHDJ);
			site.setdSJZMJ(dSJZMJ);
			site.setjGLX(jGLX);
			site.setdXCS(dXCS);
			site.setdXJZMJ(dXJZMJ);
			site.setsDQK(sDQK);
			site.setzYCCW(zYCCW);
			site.setrLRS(rLRS);
			site.setqLJZ(qLJZ);
			site.setEast(east);
			site.setWest(west);
			site.setSouth(south);
			site.setNorth(north);
			
			//site.setXx(xx);
			//site.setYy(yy);
			
			site.setHoldthings(holdthings);
			site.setSitetypename(sitetypename);
			site.setHoldthingsnum(holdthingsnum);
			
			//site.setAnnalTime(annalTime);
			site.setAnnalTime(DateUtils.timesstampToString());
			
			site.setfLongitude(fLongitude);
			site.setfLatitude(fLatitude);
			site.setOrgid(orgid);
			orginfoService.addSite(site);
			statusCode = ConstValues.OK;
			dataBag = "插入成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "插入失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);
	}
/**
 * 64.获取外观图列表信息（P）
 */
	@ResponseBody
	@RequestMapping(value = "/GetAppearancepicList", method = RequestMethod.POST)
	public String getAppearancepicList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "siteid");
	
		String siteid = map.get("siteid");
		List<Map<String, String>> list = new ArrayList<>();
		Map<String, String> map2 = new HashMap<String, String>();
		int statusCode = -1;
		try {
			List<Appearancepic> appearancepics = orginfoService.getAppearancepic(siteid);
				//有可能是get(0)
			for(Appearancepic appearancepic : appearancepics){
				map2.put("iphotoID"	, appearancepic.getIphotoID());
				map2.put("vPhotoname", appearancepic.getvPhotoname());
				map2.put("dRecordDate", DateUtils.formatToDate(appearancepic.getdRecordDate()));
				map2.put("Picpath", appearancepic.getPicpath());
				map2.put("ExteriorInfo", appearancepic.getExteriorInfo());
				map2.put("siteid", appearancepic.getSiteid());
				list.add(map2);
			}
			statusCode = ConstValues.OK;

		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(list, statusCode);
	}
	
	
	
	/**
	 * 85.查询营业执照【**】
	 * 
	 * @throws IOException
	 */

	@ResponseBody
	@RequestMapping(value = "/GetBusinessLicence", method = RequestMethod.POST)
	public String getBusinessLicence(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid");
		String orgid = map.get("orgid");
		List<Map<String, String>> list = new ArrayList<>();
		Map<String, String> map2 = new HashMap<String, String>();
		int statusCode = -1;
		try {
			List<BusinessLicence> businessLicences = orginfoService.getBusinessLicence(orgid);
				//有可能是get(0)
			for(BusinessLicence businessLicence:businessLicences){
				map2.put("LicenceCode", businessLicence.getLicenceCode());
				map2.put("ConpanyName", businessLicence.getConpanyName());
				map2.put("CompanyType", businessLicence.getCompanyType());
				map2.put("CompanyAddress", businessLicence.getCompanyAddress());
				map2.put("CompanyRegister", businessLicence.getCompanyRegister());
				map2.put("RegistMoney", businessLicence.getRegistMoney());
				map2.put("BuildTime", DateUtils.formatToDate(DateUtils.formatDateTime(businessLicence.getBuildTime())));
				map2.put("BusinessEndTime", DateUtils.formatToDate(DateUtils.formatDateTime(businessLicence.getBusinessEndTime())));
				map2.put("BusinessScope", businessLicence.getBusinessScope());
				map2.put("AuditingDepartment", businessLicence.getAuditingDepartment());
				map2.put("RegistTime", DateUtils.formatToDate(DateUtils.formatDateTime(businessLicence.getRegistTime())));
				map2.put("PictureUrl", businessLicence.getPictureUrl());
				map2.put("orgid", orgid);
				list.add(map2);
				}
			statusCode = ConstValues.OK;

		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(list, statusCode);
	}

	/**
	 * 104.提交地理位置（Z）
	 * {"orgid":"510108000001","fLongitude":"104.114623","fLatitude":"30.661593"}
	 */
	@ResponseBody
	@RequestMapping(value = "/SetMapPoint", method = RequestMethod.POST)
	public String setMapPoint(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqOriginJson(reqBody,
				"fLatitude", "fLongitude",  "orgid");
		String fLatitude = map.get("fLatitude");
		String fLongitude = map.get("fLongitude");
		String orgid = map.get("orgid");
		
		String dataBag = null;
		int statusCode = -1;
		try {
		
			orginfoService.setMapPoint(orgid,fLatitude,fLongitude);
			statusCode = ConstValues.OK;
			dataBag = "保存成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "保存失败";
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);

	}
		/**
	 * 105.	获取地理位置（Z）
	 */
	@ResponseBody
	@RequestMapping(value = "/GetMapPoint", method = RequestMethod.POST)
	public String getMapPoint(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid");
		String orgid = map.get("orgid");
		List<Map<String, String>> list = new ArrayList<>();
		Map<String, String> map2 = new HashMap<String, String>();
		int statusCode = -1;
		try {
			List<OnlineOrg> orgs = orginfoService.getMapPoint(orgid);
			//有可能是get(0)
			for(OnlineOrg org : orgs){	
				map2.put("fLongitude", org.getfLongitude());
				map2.put("fLatitude", org.getfLatitude());
				list.add(map2);
			}
				statusCode = ConstValues.OK;
			
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(list, statusCode);
	}
	
	
	
	
	/**
	 * 106.获取总平图（Z）
	 */
	@ResponseBody
	@RequestMapping(value = "/GetTotalFlatPic", method = RequestMethod.POST)
	public String getTotalFlatPic(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid");
		String orgid = map.get("orgid");
		List<String> list = new ArrayList<>();
		int statusCode = -1;
		try {
			List<OnlineOrg> orgs = orginfoService.getTotalFlatPic(orgid);
			//有可能是get(0)
			for(OnlineOrg onlineOrg : orgs){	
				list.add(onlineOrg.getbFlatpic());
			}
				statusCode = ConstValues.OK;
			
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(list, statusCode);
	}
	/**
	 * 109.获取防火单位系统详情
	 */
	@ResponseBody
	@RequestMapping(value = "/GetOnlineFireSystem", method = RequestMethod.POST)
	public String getOnlineFireSystem(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "siteid", "tisystype");
		String siteid = map.get("siteid");
		String tisystype = map.get("tisystype");
		List<Map<String, String>> lists = new ArrayList<Map<String, String>>();
		int statusCode = -1;
		try {

			lists= orginfoService.getOnlineFireSystem(siteid,tisystype);
			statusCode = ConstValues.OK;

		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(lists, statusCode);
	}
	
	
	
	/**
	 * 125根据防火单位获取建筑物名称列表  * @param request  * @return  * @throws
	 * IOException:TODO  
	 */

	@ResponseBody
	@RequestMapping(value = "/GetSiteName", method = RequestMethod.POST)
	public String getSiteName(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid");
		String orgid = map.get("orgid");
		List<Map<String, String>> lists = new ArrayList<Map<String, String>>();
		int statusCode = -1;
		try {

			List<Site> sites = orginfoService.getSiteName(orgid);

			for (Site site : sites) {
				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("siteid", site.getSiteid());
				map2.put("sitename", site.getSitename());
				lists.add(map2);
			}
			statusCode = ConstValues.OK;

		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(lists, statusCode);
	}
	/**
	 * 
	 * 122.文件下载
	 */

	@RequestMapping("/DownFile")
	public void downloadFile(@RequestParam("filepath") String filepath, HttpServletRequest request,
			HttpServletResponse response) {
		if (filepath != null) {
			String realName = UploadUtil.getFileName(filepath);
			String storeName = UploadUtil.getStoreName(filepath);
			String contentType = "application/force-download";
			UploadUtil.download(request, response, storeName, contentType, realName);

		}
	}
	/**
	 * 178.防火单位下的建筑物及对应系统
	 */
	@ResponseBody
	@RequestMapping(value = "/OrgSiteSys", method = RequestMethod.POST)
	public String orgSiteSys(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid");
		String orgid = map.get("orgid");
		List<Map<String, Object>> list = new ArrayList<>();
		int statusCode = -1;
		try {
			List<Site> sites = orginfoService.orgSiteSys(orgid);
				//有可能是get(0)
			for(Site site : sites){
				Map<String, Object> map2 = new HashMap<String, Object>();
				map2.put("siteid", site.getSiteid());
				map2.put("sitename", site.getSitename());
				map2.put("Sys", site.getFiresystypes());
				list.add(map2);
				}
			statusCode = ConstValues.OK;

		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(list, statusCode);
	}
	
	/**
	 * 133.传输设备信息
	 */
	@ResponseBody
	@RequestMapping(value = "/GatewayInfo", method = RequestMethod.POST)
	public String gatewayInfo(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid","Gatewayaddress");
		String orgid = map.get("orgid");
		String gatewayaddress = map.get("gatewayaddress");
		List<Map<String, Object>> lmList = new ArrayList<>();
		int statusCode = -1;
		try {
			List<Gateway> gatewayList = orginfoService.gatewayInfo(orgid,gatewayaddress);
			for (Gateway gateway : gatewayList) {
				Map<String, Object> map3 = new HashMap<String, Object>();

				map3.put("Gatewayaddress", gateway.getGatewayaddress());
				map3.put("Manufacturer", gateway.getManufacturer());
				map3.put("Model", gateway.getModel());
				map3.put("productdate", DateUtils.formatToDateTime(gateway.getProductdate()));
				map3.put("setupdate", DateUtils.formatToDateTime(gateway.getSetupdate()));
				map3.put("ControlorManufacture", gateway.getControlorManufacture());
				map3.put("ControlorMode", gateway.getControlorMode());
				map3.put("memo", gateway.getMemo());
				map3.put("ynonline", gateway.getYnonline());
				map3.put("onlinetime", DateUtils.formatToDateTime(gateway.getOnlinetime()));
				List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
				for (GatewaySystemInfo gatewaysyinfo : gateway.getGatewaySystemInfoList()) {
						Map<String, Object> map2 = new HashMap<String, Object>();
						map2.put("siteid", gatewaysyinfo.getSiteid());
						map2.put("sitename", gatewaysyinfo.getSitename());
						map2.put("tiSysType", gatewaysyinfo.getTiSysType());
						map2.put("vSysdesc", gatewaysyinfo.getvSysdesc());
						map2.put("Sysaddress", gatewaysyinfo.getSysaddress());
						list.add(map2);
						
					}
					map3.put("FireSysList", list);
				lmList.add(map3);
			}
			statusCode = ConstValues.OK;

		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(lmList, statusCode);
	}
	
	
	/**
	 * 179.防火单位实时数据监控
	 */
	@ResponseBody
	@RequestMapping(value = "/DataMonitor", method = RequestMethod.POST)
	public String dataMonitor(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "siteid","PageIndex","tiSysType");
		String siteid = map.get("siteid");
		String tiSysType = map.get("tiSysType");
		String pageIndex = map.get("pageIndex");
		int statusCode = -1;
		Page page = null;
		List<Map<String, Object>> lmList =null;
		List<Map<String, Object>> list = new ArrayList<>();
					
		int totalCount = orginfoService.dataMonitorCount(siteid, tiSysType);
		
			try {
				if (pageIndex != null) {
					page = new Page(totalCount, Integer.parseInt(pageIndex));
					lmList = orginfoService.dataMonitor(siteid, tiSysType, page.getStartPos(), page.getPageSize());

				} else {
					page = new Page(totalCount, 1);
					lmList = orginfoService.dataMonitor(siteid, tiSysType, page.getStartPos(), page.getPageSize());
				}
				for(Map<String, Object> m:lmList){
					m.put("dRecorddate", DateUtils.formatToDateTime(m.get("dRecorddate").toString()));
					list.add(m);
					
				}
				
				statusCode = ConstValues.OK;

			} catch (Exception e) {
				e.printStackTrace();
				statusCode = ConstValues.FAILED;
			}
			return ResponseJson.responseFindPageJsonArray(list, statusCode, totalCount);
		

	}
	
	
}