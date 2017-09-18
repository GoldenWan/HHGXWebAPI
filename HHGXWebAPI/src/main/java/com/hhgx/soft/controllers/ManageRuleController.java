package com.hhgx.soft.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hhgx.soft.entitys.Page;
import com.hhgx.soft.entitys.SafeDuty;
import com.hhgx.soft.entitys.SafeManageRules;
import com.hhgx.soft.services.FormService;
import com.hhgx.soft.services.ManageRuleService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.DateUtils;
import com.hhgx.soft.utils.GetRequestJsonUtils;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;
import com.hhgx.soft.utils.UploadUtil;

/**
 * 消防管理制度
 * 
 * @author win
 *
 */
@Controller
@RequestMapping("/ManageRule")
public class ManageRuleController {

	@Autowired
	private ManageRuleService manageRuleService;
	@Autowired
	private FormService formService;

	/**
	 * 48.删除消防安全管理制度【**】
	 * @throws IOException 
	 */

	@ResponseBody
	@RequestMapping(value = "/DeleteSafeManageRules", method = RequestMethod.POST)
	public String deleteSafeManageRules(HttpServletRequest request)
			throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "SafeManageRulesID");
		String safeManageRulesID = map.get("safeManageRulesID");
		String dataBag = null;
		int statusCode = -1;
		try {

			String filepathBefore = formService.findFilePath(safeManageRulesID);
			String filedir = request.getSession().getServletContext().getRealPath("/") + filepathBefore;
			// 先删除文件
			UploadUtil.deleteFile(filedir);
			manageRuleService.deleteSafeManageRules(safeManageRulesID);

			dataBag = ConstValues.SUCCESSDEL;
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = ConstValues.FIALUREDEL;
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 * 49.查询消防安全管理制度列表【**】【分页】
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/SafeManageRulesList", method = RequestMethod.POST)
	public String safeManageRulesList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestJsonString(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid", "PageIndex");
		String orgid = map.get("orgid");
		String pageIndex = map.get("pageIndex");

		if(StringUtils.isEmpty(orgid)){
			return ResponseJson.responseAddJson("orgid为空", -256);
		}
		Page page = null;
		List<SafeManageRules> safeManageRulesList = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();

		int totalCount = manageRuleService.safeManageRulesListCount(orgid);
		int statusCode = -1;

		try {
			if (pageIndex != null && pageIndex != "" ) {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				safeManageRulesList = manageRuleService.safeManageRulesList(orgid, page.getStartPos(),
						page.getPageSize());
			} else {
				page = new Page(totalCount, 1);
				safeManageRulesList = manageRuleService.safeManageRulesList(orgid, page.getStartPos(),
						page.getPageSize());
			}
				for (SafeManageRules safeManageRules : safeManageRulesList) {	
					
					Map<String, String> map2 = new HashMap<String, String>();
					map2.put("SafeManageRulesID", safeManageRules.getSafeManageRulesID());
					map2.put("SafeManageRulesName", safeManageRules.getSafeManageRulesName());
					map2.put("UploadTime", DateUtils.formatToDateTime(safeManageRules.getUploadTime()));
					map2.put("SafeManageRulesType", safeManageRules.getSafeManageRulesType());
					map2.put("filepath", safeManageRules.getFilepath());
					map2.put("orgid", safeManageRules.getOrgid());
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
	 * 121.获取消防管理制度详情【**】
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/GetSafeManageRules", method = RequestMethod.POST)
	public String getSafeManageRules(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestJsonString(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "SafeManageRulesID");
		String safeManageRulesID = map.get("safeManageRulesID");

		Map<String, String> map2 = new HashMap<String, String>();
		int statusCode = -1;
		try {
			SafeManageRules safeManageRules = manageRuleService.getSafeManageRules(safeManageRulesID);
			if (!StringUtils.isEmpty(safeManageRules)) {
				map2.put("orgid", safeManageRules.getOrgid());
				map2.put("SafeManageRulesName", safeManageRules.getSafeManageRulesName());
				map2.put("SafeManageRulesType", safeManageRules.getSafeManageRulesType());
				if(!StringUtils.isEmpty(safeManageRules.getFilepath()))
					map2.put("fileName", UploadUtil.getFileName(safeManageRules.getFilepath()));
				else{
					map2.put("fileName","");
				}
					
					
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
	 * 52.删除消防安全职责【**】
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/DeleteSafeDuty", method = RequestMethod.POST)
	public String deleteSafeDuty(HttpServletRequest request)
			throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "SafeDutyID");
		String safeDutyID = map.get("safeDutyID");

		String dataBag = null;
		int statusCode = -1;
		try {

			String filepathBefore = formService.findSafeDutyFilePath(safeDutyID);
			String filedir = request.getSession().getServletContext().getRealPath("/") + filepathBefore;
			// 先删除文件
			UploadUtil.deleteFile(filedir);
			manageRuleService.deleteSafeDuty(safeDutyID);

			dataBag = ConstValues.SUCCESSDEL;
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = ConstValues.FIALUREDEL;
		}
		return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 * 92.查询消防安全职责【**】【分页】  * 
	 * @param reqBody  * @return  * @throws
	 * JsonProcessingException:TODO  
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/SearchSafeDuty", method = RequestMethod.POST)
	public String searchSafeDuty(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid", "PageIndex");
		String orgid = map.get("orgid");
		String pageIndex = map.get("pageIndex");

		Page page = null;
		List<SafeDuty> safeDutyList = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		int totalCount = manageRuleService.searchSafeDutyCount(orgid);
		int statusCode = -1;

		try {
			if (pageIndex != null) {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				safeDutyList = manageRuleService.searchSafeDuty(orgid, page.getStartPos(), page.getPageSize());
			} else {
				page = new Page(totalCount, 1);
				safeDutyList = manageRuleService.searchSafeDuty(orgid, page.getStartPos(), page.getPageSize());
			}
				for (SafeDuty safeDuty : safeDutyList) {
					Map<String, String> map2 = new HashMap<String, String>();
					map2.put("dutyname", safeDuty.getDutyname());
					map2.put("SafeDutyID", safeDuty.getSafeDutyID());
					map2.put("safedutytype", safeDuty.getSafedutytype());
					map2.put("filepath", safeDuty.getFilepath());
					map2.put("uploadtime", DateUtils.formatToDateTime(safeDuty.getUploadtime()));
					map2.put("orgid", safeDuty.getOrgid());
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
	 * 93.消防安全职责详情【**】
	 * @throws IOException 
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/SafeDutyInfo", method = RequestMethod.POST)
	public String safeDutyInfo(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "SafeDutyID");
		String safeDutyID = map.get("safeDutyID");

		Map<String, String> map2 = new HashMap<String, String>();
		int statusCode = -1;
		try {
			SafeDuty safeDuty = manageRuleService.safeDutyInfo(safeDutyID);
			if (!StringUtils.isEmpty(safeDuty)) {
				map2.put("dutyname", safeDuty.getDutyname());
				//map2.put("SafeDutyID", safeDuty.getSafeDutyID());
				map2.put("safedutytype", safeDuty.getSafedutytype());
				if(!StringUtils.isEmpty(safeDuty.getFilepath()))
					map2.put("fileName", UploadUtil.getFileName(safeDuty.getFilepath()));
				else{
					map2.put("fileName","");
				}
				//map2.put("uploadtime", safeDuty.getUploadtime());
				map2.put("orgid", safeDuty.getOrgid());
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

}
