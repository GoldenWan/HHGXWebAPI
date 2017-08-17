package com.hhgx.soft.utils;

import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import net.sf.json.JSONObject;

public class ResponseJson {
	
	
	public static String responseAddJson(String dataBag, int statusCode) throws JsonProcessingException{
	
		Map<String, Object> params = new HashMap<String, Object>();
		ObjectMapper mapper = new ObjectMapper();
		params.put(ConstValues.RESPDATA, dataBag);
		params.put(ConstValues.RESPCODE, statusCode);
		return mapper.writeValueAsString(params);
		
	}
	public static String responseFindJson(Object dataBag, int statusCode) throws JsonProcessingException{
		Map<String, Object> params = new HashMap<String, Object>();
		ObjectMapper mapper = new ObjectMapper();
		params.put(ConstValues.RESPDATA, dataBag);
		params.put(ConstValues.RESPCODE, statusCode);
		return mapper.writeValueAsString(params);
		
	}
	public static String respManagerOrgAll(Object dataBag) throws JsonProcessingException{
		Map<String, Object> params = new HashMap<String, Object>();
		ObjectMapper mapper = new ObjectMapper();
		params.put(ConstValues.RESPDATA, dataBag);
		return mapper.writeValueAsString(params);
		
	}
	public static String responseFindPageJson(Object dataBag, int statusCode, int pageCount) throws JsonProcessingException{
		String result=null;
		Map<String, Object> params = new HashMap<String, Object>();
		ObjectMapper mapper = new ObjectMapper();
		params.put("pageCount", pageCount);
		params.put("PageDatas", dataBag);
		params.put(ConstValues.RESPCODE, statusCode);
		result=mapper.writeValueAsString(params);
		return result;
		
	}


	
    //首字母转大写
    public static String toUpperCaseFirstOne(String s)
    {
        if(Character.isUpperCase(s.charAt(0)))
            return s;
        else
            return (new StringBuilder()).append(Character.toUpperCase(s.charAt(0))).append(s.substring(1)).toString();
    } 
}
