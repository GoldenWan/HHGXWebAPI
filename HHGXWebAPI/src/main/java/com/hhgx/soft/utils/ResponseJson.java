package com.hhgx.soft.utils;


import com.fasterxml.jackson.core.JsonProcessingException;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class ResponseJson {

	
	public static String responseRegistJson(int code, String dataBag, int statusCode) throws JsonProcessingException{
		//{DataBag: {code: 2, message: "没有验证码，请先获取验证码"}, StateMessage: -1}
		JSONObject jsonObject = new JSONObject();
		JSONObject jsonObject1 = new JSONObject();
		jsonObject1.put("code", code);
		jsonObject1.put(ConstValues.MESSAGE, dataBag);
		jsonObject.put(ConstValues.RESPDATA, jsonObject1);
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		jsonObject.put(ConstValues.RESPDATA, jsonObject1);
		return jsonObject.toString();
	}
	public static String responseAddJson(String dataBag, int statusCode) throws JsonProcessingException{
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put(ConstValues.RESPDATA, dataBag);
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		return jsonObject.toString();
	}
	public static String responseFindJson(Object dataBag, int statusCode) throws JsonProcessingException{
		JSONObject jsonObject = new JSONObject();
		jsonObject.put(ConstValues.RESPDATA, JSONObject.fromBean(dataBag));
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		return jsonObject.toString();
		
	}
	public static String responseFindJsonArray(Object dataBag, int statusCode) throws JsonProcessingException{
		JSONObject jsonObject = new JSONObject();
		jsonObject.put(ConstValues.RESPDATA, JSONArray.fromObject(dataBag));
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		return jsonObject.toString();
		
	}

	public static String responseFindPageJson(Object dataBag, int statusCode, int pageCount) throws JsonProcessingException{
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("pageCount", pageCount);
		jsonObject.put("PageDatas", JSONObject.fromBean(dataBag));
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		
		return jsonObject.toString();
		
	}
	public static String responseFindPageJsonArray(Object dataBag, int statusCode, int pageCount) throws JsonProcessingException{
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("pageCount", pageCount);
		jsonObject.put("PageDatas", JSONArray.fromObject(dataBag));
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		
		return jsonObject.toString();
		
	}
	public static String responseFindPageJsonArray1(Object dataBag, int statusCode, int pageCount) throws JsonProcessingException{

		JSONObject jsonO = new JSONObject();
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("pageCount", pageCount);
		jsonObject.put("PageDatas", JSONArray.fromObject(dataBag));
		jsonO.put(ConstValues.RESPCODE, statusCode);
		jsonO.put("DataBag", jsonObject);
		return jsonO.toString();
		
	}
	
	public static String respPalyWithRoleFindPageJsonArray(Object dataBag, String mangerorgname, int statusCode, int pageCount) throws JsonProcessingException{
		JSONObject jsonObject = new JSONObject();
		
		jsonObject.put("pageCount", pageCount);
		jsonObject.put("PageDatas", JSONArray.fromObject(dataBag));
		jsonObject.put("mangerorgname", mangerorgname);
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		
		return jsonObject.toString();
	}
	public static String responsePalyWithRoleFindPageJson(Object dataBag, String mangerorgname, int statusCode, int pageCount) throws JsonProcessingException{
		JSONObject jsonObject = new JSONObject();

		jsonObject.put("pageCount", pageCount);
		jsonObject.put("PageDatas", JSONObject.fromBean(dataBag));
		jsonObject.put("mangerorgname", mangerorgname);
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		
		return jsonObject.toString();
	}
/*	public static String responseAddJson(String dataBag, int statusCode) throws JsonProcessingException{
		
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
	public static String responsePalyWithRoleFindPageJson(Object dataBag, String mangerorgname, int statusCode, int pageCount) throws JsonProcessingException{
		String result=null;
		Map<String, Object> params = new HashMap<String, Object>();
		ObjectMapper mapper = new ObjectMapper();
		params.put("pageCount", pageCount);
		params.put("PageDatas", dataBag);
		params.put("mangerorgname", mangerorgname);
		params.put(ConstValues.RESPCODE, statusCode);
		result=mapper.writeValueAsString(params);
		return result;
		
	}
*/

	
    //首字母转大写
    public static String toUpperCaseFirstOne(String s)
    {
        if(Character.isUpperCase(s.charAt(0)))
            return s;
        else
            return (new StringBuilder()).append(Character.toUpperCase(s.charAt(0))).append(s.substring(1)).toString();
    } 
}
