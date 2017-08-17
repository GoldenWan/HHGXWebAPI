package com.hhgx.soft.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.hhgx.soft.entitys.Page;
import com.hhgx.soft.entitys.SafeManageRules;
import com.hhgx.soft.services.FormService;
import com.hhgx.soft.services.ManageRuleService;
import com.hhgx.soft.utils.ConstValues;
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
	 */

	@ResponseBody
	@RequestMapping(value = "/DeleteSafeManageRules", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String deleteSafeManageRules(@RequestBody String reqBody, HttpServletRequest request)
			throws JsonProcessingException {

		Map<String, String> map = RequestJson.reqJson(reqBody, "SafeManageRulesID");
		String safeManageRulesID = map.get("safeManageRulesID");
		String dataBag = null;
		int statusCode = -1;
		try {

			String filepathBefore = formService.findFilePath(safeManageRulesID);
			String filedir = request.getSession().getServletContext().getRealPath("/") + filepathBefore;
			// 先删除文件
			UploadUtil.deleteFile(filedir);
			manageRuleService.deleteSafeManageRules(safeManageRulesID);

			dataBag = "刪除成功";
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "刪除失败";
		}
			return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 * 49.查询消防安全管理制度列表【**】【分页】
	 */
	@ResponseBody
	@RequestMapping(value = "/SafeManageRulesList", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String safeManageRulesList(@RequestBody String reqBody) throws JsonProcessingException {

		Map<String, String> map = RequestJson.reqJson(reqBody, "orgid", "PageIndex");
		String orgid = map.get("orgid");
		String pageIndex = map.get("pageIndex");

		Page page = null;
		List<SafeManageRules> safeManageRulesList = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();

		int totalCount = manageRuleService.safeManageRulesListCount(orgid);
		int statusCode = -1;

		try {
			if (pageIndex != null) {
				page = new Page(totalCount, Integer.parseInt(pageIndex));
				safeManageRulesList = manageRuleService.safeManageRulesList(orgid, page.getStartPos(),
						page.getPageSize());

			} else {
				page = new Page(totalCount, 1);
				safeManageRulesList = manageRuleService.safeManageRulesList(orgid, page.getStartPos(),
						page.getPageSize());
			}
			if (safeManageRulesList.size() > 0) {
				for (SafeManageRules safeManageRules : safeManageRulesList) {

					Map<String, String> map2 = new HashMap<String, String>();
					map2.put("SafeManageRulesID", safeManageRules.getSafeManageRulesID());
					map2.put("SafeManageRulesName", safeManageRules.getSafeManageRulesName());
					map2.put("UploadTime", safeManageRules.getUploadTime());
					map2.put("SafeManageRulesType", safeManageRules.getSafeManageRulesID());
					map2.put("filePath", safeManageRules.getFilepath());
					map2.put("orgid", safeManageRules.getOrgid());
					lmList.add(map2);
				}
				statusCode = ConstValues.OK;

			} else {
				statusCode = ConstValues.OK;
			}

		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJson(lmList, statusCode, totalCount);

	}

	/**
	 * 121.获取消防管理制度详情【**】
	 */
	@ResponseBody
	@RequestMapping(value = "/GetSafeManageRules", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String getSafeManageRules(@RequestBody String reqBody) throws JsonProcessingException {
		Map<String, String> map = RequestJson.reqJson(reqBody, "SafeManageRulesID");
		String safeManageRulesID = map.get("safeManageRulesID");

		Map<String, String> map2 = new HashMap<String, String>();
		int statusCode = -1;
		try {
			SafeManageRules safeManageRules = manageRuleService.getSafeManageRules(safeManageRulesID);
			if (!StringUtils.isEmpty(safeManageRules)) {
				map2.put("orgid", safeManageRules.getOrgid());
				map2.put("SafeManageRulesName", safeManageRules.getSafeManageRulesName());
				map2.put("SafeManageRulesType", safeManageRules.getSafeManageRulesType());
				map2.put("fileName", safeManageRules.getFilepath());
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
