package com.hhgx.soft.controllers;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.hhgx.soft.entitys.BusinessLicence;
import com.hhgx.soft.entitys.FireSystem;
import com.hhgx.soft.entitys.Gateway;
import com.hhgx.soft.entitys.GatewaySystemInfo;
import com.hhgx.soft.entitys.OnlineOrg;
import com.hhgx.soft.entitys.Page;
import com.hhgx.soft.entitys.PatrolProject;
import com.hhgx.soft.entitys.PatrolRecord;
import com.hhgx.soft.entitys.Site;
import com.hhgx.soft.entitys.UserCheckProjectContent;
import com.hhgx.soft.services.OrginfoService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.DateUtils;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;
import com.hhgx.soft.utils.UUIDGenerator;
import com.hhgx.soft.utils.UploadUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/Orginfo")
@SuppressWarnings("unchecked")
public class OrginfoController {
	@Autowired
	private OrginfoService orginfoService;

	/**
	 * 8.防火单位消防系统查询【分页】
	 *
	 * orgid isDivid
	 */

	@ResponseBody
	@RequestMapping(value = "/GetFireSystemList", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String getFireSystemList(@RequestBody String reqBody) throws JsonProcessingException {

		Map<String, String> map = RequestJson.reqJson(reqBody, "orgid", "isDivid", "PageIndex");
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
	 */
	
	@ResponseBody
	@RequestMapping(value = "/BriefsiteList", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String briefsiteList(@RequestBody String reqBody) throws JsonProcessingException {
		Map<String, String> map = RequestJson.reqJson(reqBody, "orgid");
		String orgid = map.get("orgid");
		List<Site> siteList = null;
		int statusCode = -1;
		JSONArray jsonList = new JSONArray();
		try {
			siteList =orginfoService.briefsiteList(orgid);
			for (Site site : siteList) {
				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("Siteid", site.getSiteid());
				map2.put("sitename", site.getSitename());
				jsonList.put(map2);	
			}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJson(jsonList.toString().replace("\"",""), statusCode);
	}
	/**
	 * 20.删除防火单位的系统
	 */

	
	@ResponseBody
	@RequestMapping(value = "/DeleteorgSys", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String deleteorgSys(@RequestBody String reqBody,HttpServletRequest request) throws JsonProcessingException {

		Map<String, String> map = RequestJson.reqJson(reqBody, "siteid","tiSysType");
		String siteid = map.get("siteid");
		String tiSysType = map.get("tiSysType");
		String dataBag = null;
		int statusCode = -1;
		try {
			 orginfoService.deleteorgSys(siteid,tiSysType);
			
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
	 */
	

	@Transactional
	@ResponseBody
	@RequestMapping(value = "/AddGateway", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String addGateway(@RequestBody final Map<String, Object> maprq) throws JsonProcessingException {
		Map<String, String> map = (Map<String, String>) maprq.get("infoBag");
	
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
		if(json.length()>0){
		  for(int i=0;i<json.length();i++){
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
	 * 23.查询传输设备
	 */
	
	@ResponseBody
	@RequestMapping(value = "/SelectGateway", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String selectGateway(@RequestBody String reqBody) throws JsonProcessingException {
		Map<String, String> map = RequestJson.reqJson(reqBody, "orgid","PageIndex");
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
			        gatewayList =orginfoService.selectGateway(orgid, page.getStartPos(),page.getPageSize());	

			} else {
				page = new Page(totalCount, 1);
		        gatewayList =orginfoService.selectGateway(orgid, page.getStartPos(),page.getPageSize());	

			}
				
			for(Gateway gateway : gatewayList){
	    	Map<String, Object> map3 = new HashMap<String, Object>();

			map3.put("Gatewayaddress", gateway.getGatewayaddress());
			map3.put("Manufacturer", gateway.getManufacturer());
			map3.put("Model", gateway.getModel());
			map3.put("productdate", gateway.getProductdate());
			map3.put("setupdate", gateway.getSetupdate());
			map3.put("ControlorManufacture",  gateway.getControlorManufacture());
			map3.put("ControlorMode",  gateway.getControlorMode());
			map3.put("memo",  gateway.getMemo());
			map3.put("ynonline",  gateway.getYnonline());
			map3.put("onlinetime",  gateway.getOnlinetime());
			
			for (GatewaySystemInfo gatewaysyinfo : gateway.getGatewaySystemInfoList()) {
				Map<String, String> map2 = new HashMap<String, String>();
				map2.put("siteid", gatewaysyinfo.getSiteid());
				map2.put("sitename", gatewaysyinfo.getSitename());
				map2.put("tiSysType", gatewaysyinfo.getTiSysType());
				map2.put("vSysdesc", gatewaysyinfo.getvSysdesc());
				map2.put("Sysaddress", gatewaysyinfo.getSysaddress());
				map3.put("FireSysList",map2);	
				}
			lmList.add(map3);
			}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJson(lmList,statusCode, totalCount);
	}
	
	
	/**
	 * 24.删除传输设备
	 */
	
	@ResponseBody
	@RequestMapping(value = "/DeleteGateway", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String deleteGateway(@RequestBody String reqBody,HttpServletRequest request) throws JsonProcessingException {

		Map<String, String> map = RequestJson.reqJson(reqBody, "Gatewayaddress");
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
	 * 58.修改防火单位信息【**】  * @param map  * @return  * @throws
	 * JsonProcessingException:TODO  
	 */
	@ResponseBody
	@RequestMapping(value = "/UpdateOnlineOrg", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public Object updateOnlineOrg(@RequestBody final Map<String, Object> map) throws JsonProcessingException {
		Map<String, String> ret = (Map<String, String>) map.get("infoBag");
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

		OnlineOrg onlineOrg = new OnlineOrg();
		onlineOrg.setNeareast(neareast);
		onlineOrg.setNearwest(nearwest);
		onlineOrg.setNearsouth(nearsouth);
		onlineOrg.setNearnorth(nearnorth);
		onlineOrg.setManagegrade(managegrade);
		onlineOrg.setNetworkStatus(networkStatus);
		onlineOrg.setNetworkTime(DateUtils.stringToTimestamp(networkTime));
		onlineOrg.setApproveMan(approveMan);
		onlineOrg.setApproveTime(DateUtils.stringToTimestamp(approveTime));
		onlineOrg.setOrgID(orgID);
		onlineOrg.setOrgcode(orgcode);
		onlineOrg.setOrgname(orgname);
		onlineOrg.setOrganType(organType);
		onlineOrg.setvAddress(vAddress);
		onlineOrg.setOtherthings(otherthings);
		onlineOrg.setYnImportant(ynImportant);
		onlineOrg.setSuperiorOrg(superiorOrg);
		onlineOrg.setSetupDate(DateUtils.stringToTimestamp(setupDate));
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
		onlineOrg.setdRecordDate(DateUtils.stringToTimestamp(dRecordDate));
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
	 */
	@ResponseBody
	@RequestMapping(value = "/GetOnlineOrg", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String GetOnlineOrg(@RequestBody final Map<String, Object> map) throws JsonProcessingException {

		Map<String, String> ret = (Map<String, String>) map.get("infoBag");
		String orgID = ret.get("OrgID");
		Map<String, String> map2 = new HashMap<String, String>();
		int statusCode = -1;
		try {
			OnlineOrg onlineOrg = orginfoService.getOnlineOrg(orgID);
			if(!StringUtils.isEmpty(onlineOrg)){
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
	 * 85.查询营业执照【**】
	 */

	@ResponseBody
	@RequestMapping(value = "/GetBusinessLicence", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String getBusinessLicence(@RequestBody final Map<String, Object> map) throws JsonProcessingException {

		Map<String, String> ret = (Map<String, String>) map.get("infoBag");
		String orgid = ret.get("orgid");

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
				statusCode = ConstValues.OK;
			} else {
				statusCode = ConstValues.OK;

			}
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJson(map2, statusCode);
	}

	/**
	 * 59.根据防火单位获取建筑物列表信息【**】[分页]
	 */

}