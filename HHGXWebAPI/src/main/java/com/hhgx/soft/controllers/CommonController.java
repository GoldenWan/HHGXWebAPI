package com.hhgx.soft.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hhgx.soft.entitys.Dictionary;
import com.hhgx.soft.services.CommonService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.GetRequestJsonUtils;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;

@Controller
@RequestMapping("/Common")
public class CommonController {
@Autowired
private CommonService  commonService;
	@RequestMapping(value="/GetDictionary", method = RequestMethod.POST)
	@ResponseBody
	public String  getDictionary(HttpServletRequest request) throws IOException{
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "TypeName");
	
		int statusCode=-1;
		String typeName = map.get("typeName");
		List<String> list = new ArrayList<String>();
		try{
			
		if(!StringUtils.isEmpty(typeName)){
			List<Dictionary> listDictionary=commonService.getDictionaryByTypeName(typeName);
			for(Dictionary dictionary : listDictionary){
				list.add(dictionary.getItemName());
			}
			statusCode=ConstValues.OK;
		}
		}catch(Exception e){
			e.printStackTrace();
			statusCode=ConstValues.FAILED;
		}
		
		return ResponseJson.responseFindJsonArray(list, statusCode);

		
	}
	
}
