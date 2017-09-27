package com.hhgx.soft.utils;

import java.util.List;

import com.hhgx.soft.entitys.BusinessLicence;
import com.hhgx.soft.entitys.Firesystype;
import com.hhgx.soft.entitys.OnlineFiresystem;
import com.hhgx.soft.entitys.Site;
import com.hhgx.soft.entitys.UserCheckPic;
import com.hhgx.soft.entitys.UserCheckProjectContent;
import com.hhgx.soft.entitys.model.OnlineAllInfo;
import com.hhgx.soft.entitys.model.Project;
import com.hhgx.soft.entitys.model.SystemType;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ResponseJson {

	public static String responseRegistJson(int code, String dataBag, int statusCode) {
		// {DataBag: {code: 2, message: "没有验证码，请先获取验证码"}, StateMessage: -1}
		JSONObject jsonObject = new JSONObject();
		JSONObject jsonObject1 = new JSONObject();
		jsonObject1.put("code", code);
		jsonObject1.put(ConstValues.MESSAGE, dataBag);
		jsonObject.put(ConstValues.RESPDATA, jsonObject1);
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		jsonObject.put(ConstValues.RESPDATA, jsonObject1);
		return jsonObject.toString();
	}

	public static String responseLoginJson(int code, String message, int statusCode) {
		JSONObject jO = new JSONObject();
		jO.put("code", code);
		jO.put("message", message);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put(ConstValues.RESPDATA, jO);
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		return jsonObject.toString();
	}

	public static String responseAddJson(String dataBag, int statusCode) {

		JSONObject jsonObject = new JSONObject();
		jsonObject.put(ConstValues.RESPDATA, dataBag);
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		return jsonObject.toString();
	}

	public static String responseFindJsonDictionary(Object dataBag, int statusCode) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put(ConstValues.RESPDATA, JSONObject.fromBean(dataBag));
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		return jsonObject.toString();

	}

	public static String responseFindJson(Object dataBag, int statusCode) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put(ConstValues.RESPDATA, JSONObject.fromBean(dataBag));
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		return jsonObject.toString();

	}

	public static String responseFindJsonArray(Object dataBag, int statusCode) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put(ConstValues.RESPDATA, JSONArray.fromObject(dataBag));
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		return jsonObject.toString();

	}

	public static String responseFindOnlineAllInfo(List<OnlineAllInfo> infos, int statusCode) {

		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		JSONArray jsonArray2 = new JSONArray();
		JSONArray jsonArray3 = new JSONArray();
		JSONArray jsonArray6 = new JSONArray();
		JSONArray jsonArray7 = new JSONArray();
		for (OnlineAllInfo info : infos) {
			JSONObject jsonObject1 = new JSONObject();
			jsonObject1.put("orgid", info.getOrgid());
			jsonObject1.put("orgcode", info.getOrgcode());
			jsonObject1.put("orgname", info.getOrgname());
			jsonObject1.put("vAddress", info.getvAddress());
			jsonObject1.put("OrganType", info.getOrganType());
			jsonObject1.put("vNamelegalperson", info.getvNamelegalperson());
			jsonObject1.put("otherthings", info.getOtherthings());
			jsonObject1.put("YnImportant", info.getYnImportant());
			jsonObject1.put("SuperiorOrg", info.getSuperiorOrg());
			jsonObject1.put("cZip", info.getcZip());
			jsonObject1.put("vTel", info.getvTel());
			jsonObject1.put("fax", info.getFax());
			jsonObject1.put("E_Mail", info.getE_Mail());
			jsonObject1.put("howmanypeople", info.getHowmanypeople());
			jsonObject1.put("souyouzhi", info.getSouyouzhi());
			jsonObject1.put("SetupDate", DateUtils.formatToDate(info.getSetupDate()));
			jsonObject1.put("realtymoney", info.getRealtymoney());
			jsonObject1.put("ipersonnum", info.getIpersonnum());
			jsonObject1.put("fAreanum", info.getfAreanum());
			jsonObject1.put("fBuildingarea", info.getfBuildingarea());
			jsonObject1.put("GasType", info.getGasType());
			jsonObject1.put("howmanyfireman", info.getHowmanyfireman());
			jsonObject1.put("howmanyexit", info.getHowmanyexit());
			jsonObject1.put("howmanystair", info.getHowmanystair());
			jsonObject1.put("howmanylane", info.getHowmanylane());
			jsonObject1.put("howmanyelevator", info.getHowmanyelevator());
			jsonObject1.put("lanelocation", info.getLanelocation());
			jsonObject1.put("vfireroomtel", info.getVfireroomtel());
			jsonObject1.put("escapefloor", info.getEscapefloor());
			jsonObject1.put("escapebuildingarea", info.getEscapebuildingarea());
			jsonObject1.put("escapelocation", info.getEscapelocation());
			jsonObject1.put("neareast", info.getNeareast());
			jsonObject1.put("nearsouth", info.getNearsouth());
			jsonObject1.put("nearwest", info.getNearwest());
			jsonObject1.put("nearnorth", info.getNearnorth());
			jsonObject1.put("AutoFireFacility", info.getAutoFireFacility());
			jsonObject1.put("fLongitude", info.getfLongitude());
			jsonObject1.put("fLatitude", info.getfLatitude());
			jsonObject1.put("managegrade", info.getManagegrade());
			jsonObject1.put("NetworkStatus", info.getNetworkStatus());
			jsonObject1.put("dRecordDate", DateUtils.formatToDate(info.getdRecordDate()));
			jsonObject1.put("NetworkTime", DateUtils.formatToDateTime(info.getNetworkTime()));
			jsonObject1.put("ApproveState", info.getApproveState());
			jsonObject1.put("ApproveMan", info.getApproveMan());
			jsonObject1.put("AreaId", info.getAreaId());
			jsonObject1.put("ManagerOrgID", info.getManagerOrgID());
			jsonObject1.put("bFlatpic", info.getbFlatpic());
			jsonObject1.put("ApproveTime", DateUtils.formatToDateTime(info.getApproveTime()));
			jsonArray.put(jsonObject1);

			for (BusinessLicence businessLicence : info.getBusiLicences()) {
				JSONObject jsonObject2 = new JSONObject();
				jsonObject2.put("LicenceCode", businessLicence.getLicenceCode());
				jsonObject2.put("ConpanyName", businessLicence.getConpanyName());
				jsonObject2.put("CompanyType", businessLicence.getCompanyType());
				jsonObject2.put("CompanyAddress", businessLicence.getCompanyAddress());
				jsonObject2.put("CompanyRegister", businessLicence.getCompanyRegister());
				jsonObject2.put("RegistMoney", businessLicence.getRegistMoney());
				jsonObject2.put("BuildTime", DateUtils.formatDate(businessLicence.getBuildTime()));
				jsonObject2.put("BusinessEndTime", DateUtils.formatDate(businessLicence.getBusinessEndTime()));
				jsonObject2.put("BusinessScope", businessLicence.getBusinessScope());
				jsonObject2.put("AuditingDepartment", businessLicence.getAuditingDepartment());
				jsonObject2.put("RegistTime", DateUtils.formatDate(businessLicence.getRegistTime()));
				jsonObject2.put("PictureUrl", businessLicence.getPictureUrl());
				jsonObject2.put("orgid", businessLicence.getOrgid());
				jsonArray1.put(jsonObject2);
			}
			for (Site site : info.getSiteListInfo()) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("siteid", site.getSiteid());
				jsonObject.put("sitename", site.getSitename());
				jsonObject.put("buildingaddress", site.getBuildingaddress());
				jsonObject.put("useproperty", site.getUseproperty());
				jsonObject.put("DSCS", site.getdSCS());
				jsonObject.put("JZGD", site.getjZGD());
				jsonObject.put("DSJZMJ", site.getdSCS());
				jsonObject.put("NHDJ", site.getnHDJ());
				jsonObject.put("JGLX", site.getjGLX());
				jsonObject.put("DXCS", site.getdXCS());
				jsonObject.put("DXJZMJ", site.getdXJZMJ());
				jsonObject.put("SDQK", site.getsDQK());
				jsonObject.put("ZYCCW", site.getzYCCW());
				jsonObject.put("RLRS", site.getrLRS());
				jsonObject.put("QLJZ", site.getqLJZ());
				jsonObject.put("east", site.getEast());
				jsonObject.put("west", site.getWest());
				jsonObject.put("south", site.getSouth());
				jsonObject.put("north", site.getNorth());
				jsonObject.put("xx", site.getXx());
				jsonObject.put("yy", site.getYy());
				jsonObject.put("sitetypename", site.getSitetypename());
				jsonObject.put("holdthings", site.getHoldthings());
				jsonObject.put("holdthingsnum", site.getHoldthingsnum());
				jsonObject.put("annalTime", DateUtils.formatToDateTime(site.getAnnalTime()));
				jsonObject.put("fLongitude", site.getfLongitude());
				jsonObject.put("fLatitude", site.getfLatitude());
				jsonObject.put("orgid", site.getOrgid());

				jsonObject.put("Appearancepic", JSONArray.fromObject(site.getAppearancepics()));
				jsonArray2.put(jsonObject);
			}
			for (OnlineFiresystem onlineFiresystem : info.getSysInfos()) {

				JSONObject jsonObject = new JSONObject();
				jsonObject.put("vSysdesc", onlineFiresystem.getvSysdesc());
				jsonObject.put("siteid", onlineFiresystem.getSiteid());
				jsonObject.put("sitename", onlineFiresystem.getSitename());
				jsonObject.put("states", onlineFiresystem.getStates());
				jsonObject.put("YnOnline", onlineFiresystem.getYnOnline());
				jsonObject.put("Remarks", onlineFiresystem.getRemarks());
				jsonArray3.put(jsonObject);
			}

			for (SystemType systemType : info.getRecordProjects()) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("tiSysType", systemType.getTiSysType());
				jsonObject.put("vSysdesc", systemType.getvSysdesc());
				JSONArray jsonArray5 = new JSONArray();

				for (Project project : systemType.getContents()) {
					JSONObject jsonObject_ = new JSONObject();
					jsonObject_.put("ProjectId", project.getProjectId());
					//jsonObject_.put("ProjectName", project.getProjectName());
					jsonObject_.put("ProjectContent", project.getProjectContent());
					jsonArray5.put(jsonObject_);
				}

				jsonObject.put("Contents", jsonArray5);

				jsonArray6.put(jsonObject);
			}
			for (SystemType systemType : info.getCheckProjects()) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("tiSysType", systemType.getTiSysType());
				jsonObject.put("vSysdesc", systemType.getvSysdesc());
				JSONArray jsonArray5 = new JSONArray();

				for (Project project : systemType.getContents()) {
					JSONObject jsonObject_ = new JSONObject();
					jsonObject_.put("ProjectId", project.getProjectId());
					jsonObject_.put("ProjectName", project.getProjectName());
					jsonObject_.put("ProjectContent", project.getProjectContent());
					jsonArray5.put(jsonObject_);
				}

				jsonObject.put("Contents", jsonArray5);

				jsonArray7.put(jsonObject);
			}

		}
		JSONObject jsonObject0 = new JSONObject();
		JSONObject jsonObject00 = new JSONObject();
		jsonObject00.put("BaseInfo", jsonArray);
		jsonObject00.put("BusiLicence", jsonArray1);
		jsonObject00.put("siteListInfo", jsonArray2);
		jsonObject00.put("sysInfo", jsonArray3);
		jsonObject00.put("recordProject", jsonArray6);
		jsonObject00.put("checkProject", jsonArray7);

		jsonObject0.put(ConstValues.RESPDATA, jsonObject00);
		jsonObject0.put(ConstValues.RESPCODE, statusCode);
		return jsonObject0.toString();

	}

	public static String responseFindFireCheckArray(List<Site> sites, int statusCode) {
		JSONArray jsonArray = new JSONArray();
		for (Site site : sites) {
			JSONObject jsonObject1 = new JSONObject();
			jsonObject1.put("siteid", site.getSiteid());
			jsonObject1.put("sitename", site.getSitename());
			JSONArray jsonArray0 = new JSONArray();
			for (Firesystype firesystype : site.getFiresystypes()) {
				JSONObject jsonObject2 = new JSONObject();
				jsonObject2.put("tiSysType", firesystype.getTiSysType());
				jsonObject2.put("vSysdesc", firesystype.getvSysdesc());
				JSONArray jsonArray1 = new JSONArray();
				for (UserCheckProjectContent userCheckProjectContent : firesystype.getUserCheckProjectContents()) {
					JSONObject jsonObject3 = new JSONObject();
					jsonObject3.put("ProjectId", userCheckProjectContent.getProjectId());
					jsonObject3.put("ProjectContent", userCheckProjectContent.getProjectContent());
					jsonObject3.put("UserCheckResult",
							userCheckProjectContent.getUserCheckInfos().get(0).getUserCheckResult());
					jsonObject3.put("FaultShow", userCheckProjectContent.getUserCheckInfos().get(0).getFaultShow());
					jsonObject3.put("YnHanding", userCheckProjectContent.getUserCheckInfos().get(0).getYnHanding());
					jsonObject3.put("Handingimmediately",
							userCheckProjectContent.getUserCheckInfos().get(0).getHandingimmediately());
					JSONObject jsonObject4 = new JSONObject();
					jsonObject4.put("PicProject", firesystype.getvSysdesc());
					jsonObject4.put("PicContent", userCheckProjectContent.getProjectContent());
					JSONArray jsonArray2 = new JSONArray();
					for (UserCheckPic userCheckPic : userCheckProjectContent.getUserCheckInfos().get(0)
							.getUserCheckPics()) {
						JSONObject jsonObject5 = new JSONObject();
						jsonObject5.put("PicID", userCheckPic.getPicID());
						jsonObject5.put("PicPath", userCheckPic.getPicPath());
						jsonArray2.put(jsonObject5);
					}
					jsonObject4.put("Picture", jsonArray2);
					jsonObject3.put("PicInfo", jsonObject4);
					jsonArray1.put(jsonObject3);
				}
				jsonObject2.put("Content", jsonArray1);
				jsonArray0.put(jsonObject2);
			}
			jsonObject1.put("vSysContent", jsonArray0);
			jsonArray.put(jsonObject1);
		}
		JSONObject jsonObject0 = new JSONObject();
		jsonObject0.put(ConstValues.RESPDATA, jsonArray);
		jsonObject0.put(ConstValues.RESPCODE, statusCode);
		return jsonObject0.toString();

	}

	public static String responseFindPageJsonArray(Object dataBag, int statusCode, int pageCount) {

		JSONObject jsonO = new JSONObject();
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("pageCount", pageCount);
		jsonO.put(ConstValues.RESPCODE, statusCode);
		jsonObject.put("PageDatas", JSONArray.fromObject(dataBag));
		jsonO.put(ConstValues.RESPDATA, jsonObject);
		return jsonO.toString();

	}

	public static String respPalyWithRoleFindPageJsonArray(Object dataBag, String mangerorgname, int statusCode,
			int pageCount) {
		JSONObject jsonObject = new JSONObject();

		jsonObject.put("pageCount", pageCount);
		jsonObject.put("PageDatas", JSONArray.fromObject(dataBag));
		jsonObject.put("mangerorgname", mangerorgname);
		jsonObject.put(ConstValues.RESPCODE, statusCode);

		return jsonObject.toString();
	}

	public static String responsePalyWithRoleFindPageJson(Object dataBag, String mangerorgname, int statusCode,
			int pageCount) {
		JSONObject jsonObject = new JSONObject();

		jsonObject.put("pageCount", pageCount);
		jsonObject.put("PageDatas", JSONObject.fromBean(dataBag));
		jsonObject.put("mangerorgname", mangerorgname);
		jsonObject.put(ConstValues.RESPCODE, statusCode);

		return jsonObject.toString();
	}
	/*
	 * public static String responseAddJson(String dataBag, int statusCode){
	 * 
	 * Map<String, Object> params = new HashMap<String, Object>(); ObjectMapper
	 * mapper = new ObjectMapper(); params.put(ConstValues.RESPDATA, dataBag);
	 * params.put(ConstValues.RESPCODE, statusCode); return
	 * mapper.writeValueAsString(params);
	 * 
	 * } public static String responseFindJson(Object dataBag, int statusCode){
	 * Map<String, Object> params = new HashMap<String, Object>(); ObjectMapper
	 * mapper = new ObjectMapper(); params.put(ConstValues.RESPDATA, dataBag);
	 * params.put(ConstValues.RESPCODE, statusCode); return
	 * mapper.writeValueAsString(params);
	 * 
	 * }
	 * 
	 * public static String responseFindPageJson(Object dataBag, int statusCode,
	 * int pageCount){ String result=null; Map<String, Object> params = new
	 * HashMap<String, Object>(); ObjectMapper mapper = new ObjectMapper();
	 * params.put("pageCount", pageCount); params.put("PageDatas", dataBag);
	 * params.put(ConstValues.RESPCODE, statusCode);
	 * result=mapper.writeValueAsString(params); return result;
	 * 
	 * } public static String responsePalyWithRoleFindPageJson(Object dataBag,
	 * String mangerorgname, int statusCode, int pageCount){ String result=null;
	 * Map<String, Object> params = new HashMap<String, Object>(); ObjectMapper
	 * mapper = new ObjectMapper(); params.put("pageCount", pageCount);
	 * params.put("PageDatas", dataBag); params.put("mangerorgname",
	 * mangerorgname); params.put(ConstValues.RESPCODE, statusCode);
	 * result=mapper.writeValueAsString(params); return result;
	 * 
	 * }
	 */

	// 首字母转大写
	public static String toUpperCaseFirstOne(String s) {
		if (Character.isUpperCase(s.charAt(0)))
			return s;
		else
			return (new StringBuilder()).append(Character.toUpperCase(s.charAt(0))).append(s.substring(1)).toString();
	}
}
