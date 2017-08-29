package com.hhgx.soft.controllers;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hhgx.soft.services.ExtraService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.GetRequestJsonUtils;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;

@Controller
public class ExtraController {
	@Autowired 
	private ExtraService extraService;
	/**
	 * 174.删除灭火应急演练预案【**】
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/Faclity/DeleteManoeuvre", method = RequestMethod.POST)
	public String deleteManoeuvre(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "manoeuvreID");
		String manoeuvreID = map.get("manoeuvreID");
		String dataBag = null;
		int statusCode = -1;
		try {
			extraService.deleteManoeuvre(manoeuvreID);
			statusCode = ConstValues.OK;
			dataBag = "刪除成功";
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "刪除失败";
		}
	   return ResponseJson.responseAddJson(dataBag, statusCode);
		

	}


}
