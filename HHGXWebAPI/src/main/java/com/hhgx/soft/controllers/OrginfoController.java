package com.hhgx.soft.controllers;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
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
	 * @throws IOException 
	 */

	@ResponseBody
	@RequestMapping(value = "/GetFireSystemList", method = RequestMethod.POST)
	public String getFireSystemList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid", "isDivid", "PageIndex");
		String orgid = map.get("orgid");
		String isDivid = map.get("isDivid");
		String pageIndex = map.get("pageIndex");
		int statusCode = -1;
		Page page = null;
		List<FireSystem> list = null;

		if (isDivid.equals("No")) {
			try {
				list = orginfoService.getFireSystemList(orgid);
				statusCode = ConstValues.OK;
			} catch (Exception e) {
				e.printStackTrace();
				statusCode = ConstValues.FAILED;
			}
			return ResponseJson.responseFindJson(list, statusCode);

		} else {
			int totalCount = orginfoService.getFireSystemListCount(orgid);
			try {
				if (pageIndex != null) {
					page = new Page(totalCount, Integer.parseInt(pageIndex));
					list = orginfoService.getFireSystemListByPage(orgid, page.getStartPos(), page.getPageSize());

				} else {
					page = new Page(totalCount, 1);
					list = orginfoService.getFireSystemListByPage(orgid, page.getStartPos(), page.getPageSize());
				}
				statusCode = ConstValues.OK;

			} catch (Exception e) {
				e.printStackTrace();
				statusCode = ConstValues.FAILED;
			}
			return ResponseJson.responseFindPageJson(list, statusCode, totalCount);
		}

	}

	/**
	 * 18.根据防火单位获取建物简要列表
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
		} catch (Exception e) {
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(siteList, statusCode);
	}

	/**
	 * 20.删除防火单位的系统
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
	 * @throws IOException 
	 */

	@Transactional
	@ResponseBody
	@RequestMapping(value = "/AddGateway", method = RequestMethod.POST)
	public String addGateway(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		
		Map<String, String> map = RequestJson.reqOriginJson(reqBody, "Gatewayaddress","Manufacturer",
				"Model","productdate","setupdate","ControlorManufacture","ControlorMode","memo");
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
	 * @throws IOException 
	 */

	@Transactional
	@ResponseBody
	@RequestMapping(value = "/UpdateGateway", method = RequestMethod.POST)
	public String updateGateway(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqOriginJson(reqBody, "Gatewayaddress","newGatewayaddress",
				"Manufacturer","Model","productdate","setupdate","ControlorManufacture","ControlorMode","memo");

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
			orginfoService.deleteGatewaySysInfo(gatewayaddress);

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
				map3.put("productdate", gateway.getProductdate());
				map3.put("setupdate", gateway.getSetupdate());
				map3.put("ControlorManufacture", gateway.getControlorManufacture());
				map3.put("ControlorMode", gateway.getControlorMode());
				map3.put("memo", gateway.getMemo());
				map3.put("ynonline", gateway.getYnonline());
				map3.put("onlinetime", gateway.getOnlinetime());

				for (GatewaySystemInfo gatewaysyinfo : gateway.getGatewaySystemInfoList()) {
					Map<String, String> map2 = new HashMap<String, String>();
					map2.put("siteid", gatewaysyinfo.getSiteid());
					map2.put("sitename", gatewaysyinfo.getSitename());
					map2.put("tiSysType", gatewaysyinfo.getTiSysType());
					map2.put("vSysdesc", gatewaysyinfo.getvSysdesc());
					map2.put("Sysaddress", gatewaysyinfo.getSysaddress());
					map3.put("FireSysList", map2);
				}
				lmList.add(map3);
			}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJson(lmList, statusCode, totalCount);
	}

	/**
	 * 24.删除传输设备
	 * @throws IOException 
	 */

	@ResponseBody
	@RequestMapping(value = "/DeleteGateway", method = RequestMethod.POST)
	public String deleteGateway( HttpServletRequest request)
			throws IOException {
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
	 * @throws IOException 
	 */

	@ResponseBody
	@RequestMapping(value = "/GetflatpicList", method = RequestMethod.POST)
	public String getflatpicList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> ret = RequestJson.reqFirstLowerJson(reqBody,"orgid", "siteid");
		String orgid = ret.get("orgid");
		String siteid = ret.get("siteid");
		List<Flatpic> flatpicList = null;
		int statusCode = -1;
		try {
			flatpicList = orginfoService.getflatpicList(orgid, siteid);
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJson(flatpicList, statusCode);
	}

	/**
	 * 28.删除平面图
	 * @throws IOException 
	 */

	@ResponseBody
	@RequestMapping(value = "/DeleteflatPic", method = RequestMethod.POST)
	public String deleteflatPic(HttpServletRequest request)
			throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "cFlatPic");
		String cFlatPic = map.get("cFlatPic");
		String dataBag = null;
		int statusCode = -1;
		try {
			orginfoService.deleteDevicesBycflatPic(cFlatPic);
			orginfoService.deleteflatPic(cFlatPic);
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
	 * 29.添加自动报警部件
	 * @throws IOException 
	 */
	@Transactional
	@ResponseBody
	@RequestMapping(value = "/AddDevices", method = RequestMethod.POST)
	public String addDevices(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqOriginJson(reqBody,"Road", "Address",
				"sysaddress", "gatewayaddress","vdesc", "fPositionX",
				"fPositionY", "location","Manufacture", "Model",
				"ProductDate", "expdate","AddTime", "memo","cFlatPic", "iDeviceType");
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
			devices.setProductDate(DateUtils.StringToDate(productDate,"yyyy/MM/dd"));
			devices.setExpdate(DateUtils.StringToDate(expdate,"yyyy/MM/dd"));
			devices.setAddTime(DateUtils.StringToDate(addTime,"yyyy/MM/dd"));
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
	 * 30.修改自动报警部件  * @param maprq  * @return  * @throws
	 * JsonProcessingException:TODO  
	 * @throws IOException 
	 */

	@Transactional
	@ResponseBody
	@RequestMapping(value = "/UpdateDevices", method = RequestMethod.POST)
	public String updateDevices(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqOriginJson(reqBody,"Road","Address","sysaddress","gatewayaddress","vdesc"
				,"fPositionX","fPositionY","location","Manufacture","Model","ProductDate","expdate","AddTime","memo","cFlatPic"
				,"iDeviceType","DeviceNo");

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
			devices.setProductDate(DateUtils.StringToDate(productDate,"yyyy/MM/dd"));
			devices.setExpdate(DateUtils.StringToDate(expdate,"yyyy/MM/dd"));
			devices.setAddTime(DateUtils.StringToDate(addTime,"yyyy/MM/dd"));
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
	 * 31.删除自动报警部件  * @param reqBody  * @param request  * @return  * @throws
	 * JsonProcessingException:TODO  
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/DeleteDevices", method = RequestMethod.POST)
	public String deleteDevices(HttpServletRequest request)
			throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "deviceaddress", "sysaddress", "gatewayaddress");
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
	 * @throws IOException 
	 */

	@ResponseBody
	@RequestMapping(value = "/SelectDevicesList", method = RequestMethod.POST)
	public String selectDevicesList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		
		Map<String, String> ret = RequestJson.reqOriginJson(reqBody, "cFlatPic","iDeviceType","deviceaddress","PageIndex");
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
		return ResponseJson.responseFindPageJson(lmList, statusCode, totalCount);

	}

	/**
	 * 33.查询自动报警部件详情
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/SelectDeviceDetail", method = RequestMethod.POST)
	public String selectDeviceDetail(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		
		Map<String, String> ret = RequestJson.reqOriginJson(reqBody, "gatewayaddress","sysaddress","deviceaddress");
		
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
	 * 58.修改防火单位信息【**】  * @param map  * @return  * @throws
	 * JsonProcessingException:TODO  
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/UpdateOnlineOrg", method = RequestMethod.POST)
	public Object updateOnlineOrg(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> ret = RequestJson.reqOriginJson(reqBody
				, "OrgID","orgcode","orgname","vAddress","OrganType"
				, "vNamelegalperson","otherthings","YnImportant","SuperiorOrg","cZip"
				, "vTel","fax","E-Mail","howmanypeople","souyouzhi"
				, "SetupDate","realtymoney","ipersonnum","fAreanum","fBuildingarea"
				, "gasType","howmanyexit","howmanystair","howmanylane","howmanyelevator"
				, "lanelocation","vfireroomtel","escapefloor","escapebuildingarea","escapelocation"
				, "AutoFireFacility","bFlatpic","dRecordDate","ApproveMan","AreaId"
				, "ManagerOrgID","neareast","nearsouth","nearwest","nearnorth"
				, "managegrade","NetworkStatus","NetworkTime","ApproveState","ApproveTime"
				);
		String autoFireFacility = ret.get("AutoFireFacility");
		String bFlatpic = ret.get("bFlatpic");
		String dRecordDate = ret.get("dRecordDate");
		String approveMan = ret.get("ApproveMan");
		String areaId = ret.get("AreaId");
		String managerOrgID = ret.get("ManagerOrgID");
		String neareast = ret.get("neareast");
		String nearsouth = ret.get("nearsouth");
		String nearwest = ret.get("nearwest");
		String nearnorth = ret.get("nearnorth");
		
		String managegrade = ret.get("managegrade");
		String networkStatus = ret.get("NetworkStatus");
		String networkTime = ret.get("NetworkTime");
		String approveState = ret.get("ApproveState");
		String approveTime = ret.get("ApproveTime");
		
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
		String escapelocation = ret.get("escapelocation");
		
		
		String orgID = ret.get("OrgID");
		String orgcode = ret.get("orgcode");
		String orgname = ret.get("orgname");
		String vAddress = ret.get("vAddress");
		String organType = ret.get("OrganType");
		String vNamelegalperson = ret.get("vNamelegalperson");
		String otherthings = ret.get("otherthings");
		String ynImportant = ret.get("YnImportant");
		String superiorOrg = ret.get("SuperiorOrg");
		String cZip = ret.get("cZip");
		String vTel = ret.get("vTel");
		String fax = ret.get("fax");
		String eMail = ret.get("E-Mail");
		String howmanypeople = ret.get("howmanypeople");
		String souyouzhi = ret.get("souyouzhi");
		String setupDate = ret.get("SetupDate");

		
		OnlineOrg onlineOrg = new OnlineOrg();
		onlineOrg.setNeareast(neareast);
		onlineOrg.setNearwest(nearwest);
		onlineOrg.setNearsouth(nearsouth);
		onlineOrg.setNearnorth(nearnorth);
		onlineOrg.setManagegrade(managegrade);
		onlineOrg.setNetworkStatus(networkStatus);
		onlineOrg.setNetworkTime(DateUtils.StringToDate(networkTime,"yyyy/MM/dd"));
		onlineOrg.setApproveMan(approveMan);
		onlineOrg.setApproveTime(DateUtils.StringToDate(approveTime,"yyyy/MM/dd"));
		onlineOrg.setOrgID(orgID);
		onlineOrg.setOrgcode(orgcode);
		onlineOrg.setOrgname(orgname);
		onlineOrg.setOrganType(organType);
		onlineOrg.setvAddress(vAddress);
		onlineOrg.setOtherthings(otherthings);
		onlineOrg.setYnImportant(ynImportant);
		onlineOrg.setSuperiorOrg(superiorOrg);
		onlineOrg.setSetupDate(DateUtils.StringToDate(setupDate,"yyyy/MM/dd"));
		onlineOrg.setvNamelegalperson(vNamelegalperson);
		onlineOrg.setvTel(vTel);
		onlineOrg.setFax(fax);
		onlineOrg.setApproveMan(approveMan);
		onlineOrg.setIpersonnum(ipersonnum);
		onlineOrg.setAutoFireFacility(autoFireFacility);
		onlineOrg.setbFlatpic(bFlatpic);
		onlineOrg.setcZip(cZip);
		onlineOrg.setEscapebuildingarea(escapebuildingarea);
		onlineOrg.setRealtymoney(realtymoney);
		onlineOrg.setEscapelocation(escapelocation);
		onlineOrg.setVfireroomtel(vfireroomtel);
		onlineOrg.setGasType(gasType);
		onlineOrg.setHowmanyfireman(howmanyfireman);
		onlineOrg.setApproveState(approveState);
		onlineOrg.setAreaId(areaId);
		onlineOrg.setHowmanystair(howmanystair);
		onlineOrg.setHowmanylane(howmanylane);
		onlineOrg.setLanelocation(lanelocation);
		onlineOrg.setHowmanypeople(howmanypeople);
		onlineOrg.seteMail(eMail);
		onlineOrg.setdRecordDate(DateUtils.StringToDate(dRecordDate,"yyyy/MM/dd"));
		onlineOrg.setEscapefloor(escapefloor);
		onlineOrg.setSouyouzhi(souyouzhi);
		onlineOrg.setfAreanum(fAreanum);
		onlineOrg.setfBuildingarea(fBuildingarea);
		onlineOrg.setGasType(gasType);
		onlineOrg.setHowmanyelevator(howmanyelevator);
		onlineOrg.setHowmanyexit(howmanyexit);
		onlineOrg.setManagerOrgID(managerOrgID);
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
	 * 84.获取防火单位信息【**】
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
				map2.put("E-Mail", onlineOrg.geteMail());
				map2.put("howmanypeople", onlineOrg.getHowmanypeople());
				map2.put("souyouzhi", onlineOrg.getSouyouzhi());
				map2.put("SetupDate", DateUtils.formatDate(onlineOrg.getSetupDate(), "yyyy-MM-dd"));
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
			}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJson(map2, statusCode);
	}

	/**
	 * 34.标注一个自动报警部件在平面图上的位置
	 * 
	 * @throws IOException
	 */
	/**@ResponseBody
	@RequestMapping(value = "/MarkPoint", method = RequestMethod.POST)
	public String markPoint(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "deviceaddress", "sysaddress", "gatewayaddress",
				"cFlatPic", "DeviceNo", "fPositionX", "fPositionY");
		String deviceaddress = map.get("deviceaddress");
		String sysaddress = map.get("sysaddress");
		String gatewayaddress = map.get("gatewayaddress");
		String cFlatPic = map.get("cFlatPic");
		String deviceNo = map.get("deviceNo");
		String fPositionX = map.get("fPositionX");
		String fPositionY = map.get("fPositionY");
		Map<String, String> map2 = new HashMap<String, String>();
		int statusCode =-1;
		try{
		Devices devices=new Devices();
		devices.setDeviceaddress(deviceaddress);
		devices.setSysaddress(Integer.parseInt(sysaddress));
		devices.setDeviceNo(Integer.parseInt(deviceNo));
		devices.setGatewayaddress(gatewayaddress);
		devices.setfPositionX(fPositionX);
		devices.setfPositionY(fPositionY);
		devices.setcFlatPic(cFlatPic);
		
		
		Devices newDevices = orginfoService.markPoint(devices);
		
		if (!StringUtils.isEmpty(newDevices)) {

			map2.put("deviceaddress", newDevices.getDeviceaddress());
			map2.put("sysaddress", String.valueOf(newDevices.getSysaddress()));
			map2.put("gatewayaddress", newDevices.getGatewayaddress());
			map2.put("DeviceNo", String.valueOf(newDevices.getDeviceNo()));
			map2.put("iDeviceType", newDevices.getiDeviceType());
			map2.put("DeviceTypeName", newDevices.getDeviceTypeName());
			
			
		} 
			statusCode = ConstValues.OK;

		
	} catch (Exception e) {
		e.printStackTrace();
		statusCode = ConstValues.FAILED;
	}
	return ResponseJson.responseFindJson(map2, statusCode);
}
*/
/**
 * 35.获取第一个自动报警部件
 */
/**	@ResponseBody
	@RequestMapping(value = "/GetFirstDevice", method = RequestMethod.POST)
	public String getFirstDevice(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "cFlatPic");
		String cFlatPic = map.get("cFlatPic");
	
		Map<String, String> map2 = new HashMap<String, String>();
		int statusCode =-1;
		try{
		
		
		Devices newDevices = orginfoService.getFirstDevice(cFlatPic);
		
		if (!StringUtils.isEmpty(newDevices)) {

			map2.put("deviceaddress", newDevices.getDeviceaddress());
			map2.put("sysaddress", String.valueOf(newDevices.getSysaddress()));
			map2.put("gatewayaddress", newDevices.getGatewayaddress());
			map2.put("DeviceNo", String.valueOf(newDevices.getDeviceNo()));
			map2.put("iDeviceType", newDevices.getiDeviceType());
			map2.put("DeviceTypeName", newDevices.getDeviceTypeName());
		} 
			statusCode = ConstValues.OK;
		
	} catch (Exception e) {
		e.printStackTrace();
		statusCode = ConstValues.FAILED;
	}
	return ResponseJson.responseFindJson(map2, statusCode);
}*/	
	/**
	 * 36.获取某一个自动报警部件
	 */
	/**
	@ResponseBody
	@RequestMapping(value = "/GetOneDevice", method = RequestMethod.POST)
	public String getOneDevice(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, 
				"cFlatPic", "DeviceNo");
		
		String cFlatPic = map.get("cFlatPic");
		String deviceNo = map.get("deviceNo");

		Map<String, String> map2 = new HashMap<String, String>();
		int statusCode =-1;
		try{
	
		
		Devices newDevices = orginfoService.getOneDevice(cFlatPic,deviceNo );
		
		if (!StringUtils.isEmpty(newDevices)) {
			map2.put("deviceaddress", newDevices.getDeviceaddress());
			map2.put("sysaddress", String.valueOf(newDevices.getSysaddress()));
			map2.put("gatewayaddress", newDevices.getGatewayaddress());
			map2.put("DeviceNo", String.valueOf(newDevices.getDeviceNo()));
		} 
			statusCode = ConstValues.OK;
		
	} catch (Exception e) {
		e.printStackTrace();
		statusCode = ConstValues.FAILED;
	}
	return ResponseJson.responseFindJson(map2, statusCode);
}	
	*/
	
	/**
	 * 85.查询营业执照【**】
	 * @throws IOException 
	 */

	@ResponseBody
	@RequestMapping(value = "/GetBusinessLicence", method = RequestMethod.POST)
	public String getBusinessLicence(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid");
		String orgid = map.get("orgid");

		Map<String, String> map2 = new HashMap<String, String>();
		int statusCode = -1;
		try {
			BusinessLicence businessLicence = orginfoService.getBusinessLicence(orgid);
			if (!StringUtils.isEmpty(businessLicence)) {

				map2.put("LicenceCode", businessLicence.getLicenceCode());
				map2.put("ConpanyName", businessLicence.getConpanyName());
				map2.put("CompanyType", businessLicence.getCompanyType());
				map2.put("CompanyAddress", businessLicence.getCompanyAddress());
				map2.put("CompanyRegister", businessLicence.getCompanyRegister());
				map2.put("RegistMoney", businessLicence.getRegistMoney());
				map2.put("BuildTime", DateUtils.formatDateTime(businessLicence.getBuildTime()));
				map2.put("BusinessEndTime", DateUtils.formatDateTime(businessLicence.getBusinessEndTime()));
				map2.put("BusinessScope", businessLicence.getBusinessScope());
				map2.put("AuditingDepartment", businessLicence.getAuditingDepartment());
				map2.put("RegistTime", DateUtils.formatDateTime(businessLicence.getRegistTime()));
				map2.put("PictureUrl", businessLicence.getPictureUrl());
				map2.put("orgid", businessLicence.getOrgid());
			} 
				statusCode = ConstValues.OK;

			
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJson(map2, statusCode);
	}
	
	/**
	 * 测试结果	
接口地址	/ Orginfo/GetSiteName
接口方法	GetSiteName
请求方式	POST
接口请求
参数名称	参数代码	参数类型
防火单位编号	orgid	string
接口返回
建筑物编号	siteid	string
建筑物名称	sitename	string
数据库表：

	 */
	
	@ResponseBody
	@RequestMapping(value = "/GetSiteName", method = RequestMethod.POST)
	public String getSiteName(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody,"orgid");
		String orgid = map.get("orgid");
List<Map<String, String>> lists = new ArrayList<Map<String, String>>();
		int statusCode =-1;
		try{
	
		
		List<Site> sites= orginfoService.getSiteName(orgid);
		
		for(Site site: sites){
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
	/*
	 * 
	 * 122.文件下载
	 * http://localhost:8888/HHGXWebAPI/Orginfo/DownFile?filepath=Uploading/Manoeuvre/b1bbe7b092f342eebff8d
	 */

    @RequestMapping("/DownFile")
    public void downloadFile(@RequestParam("filepath") String filepath,
            HttpServletRequest request, HttpServletResponse response) {
        if (filepath != null) {
        	String realName = UploadUtil.getFileName(filepath);
        	System.out.println(filepath);
        		String storeName =UploadUtil.getStoreName(filepath);
        	System.out.println(storeName);
        	String contentType="application/force-download";
        	//UploadUtil.download(request, response, storeName, contentType, realName);
        	/**
             * 文件下载
             * @Description: 
             * @param fileName
             * @param request
             * @param response
             * @return
             */
      
          
                    String realPath = request.getServletContext().getRealPath(
                            "Uploading/");
                    File file = new File(realPath, realName);
                    if (file.exists()) {
                        response.setContentType("application/force-download");// 设置强制下载不打开
                        response.addHeader("Content-Disposition",
                                "attachment;fileName=" + realName);// 设置文件名
                        byte[] buffer = new byte[1024];
                        FileInputStream fis = null;
                        BufferedInputStream bis = null;
                        try {
                            fis = new FileInputStream(file);
                            bis = new BufferedInputStream(fis);
                            OutputStream os = response.getOutputStream();
                            int i = bis.read(buffer);
                            while (i != -1) {
                                os.write(buffer, 0, i);
                                i = bis.read(buffer);
                            }
                        } catch (Exception e) {
                            // TODO: handle exception
                            e.printStackTrace();
                        } finally {
                            if (bis != null) {
                                try {
                                    bis.close();
                                } catch (IOException e) {
                                    // TODO Auto-generated catch block
                                    e.printStackTrace();
                                }
                            }
                            if (fis != null) {
                                try {
                                    fis.close();
                                } catch (IOException e) {
                                    // TODO Auto-generated catch block
                                    e.printStackTrace();
                                }
                            }
                        }
                    }
                
           
        	
        	
         }
    }
}