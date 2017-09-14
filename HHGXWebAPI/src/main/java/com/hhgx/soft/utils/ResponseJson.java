package com.hhgx.soft.utils;



import java.util.List;

import com.hhgx.soft.entitys.Firesystype;
import com.hhgx.soft.entitys.Site;
import com.hhgx.soft.entitys.UserCheckPic;
import com.hhgx.soft.entitys.UserCheckProjectContent;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class ResponseJson {

	
	public static String responseRegistJson(int code, String dataBag, int statusCode){
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
	public static String responseLoginJson(int code, String message, int statusCode){
		JSONObject jO = new JSONObject();
		jO.put("code", code);
		jO.put("message", message);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put(ConstValues.RESPDATA, jO);
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		return jsonObject.toString();
	}
	
	public static String responseAddJson(String dataBag, int statusCode){
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put(ConstValues.RESPDATA, dataBag);
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		return jsonObject.toString();
	}
	public static String responseFindJsonDictionary(Object dataBag, int statusCode){
		JSONObject jsonObject = new JSONObject();
		jsonObject.put(ConstValues.RESPDATA, JSONObject.fromBean(dataBag));
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		return jsonObject.toString();
		
	}
	public static String responseFindJson(Object dataBag, int statusCode){
		JSONObject jsonObject = new JSONObject();
		jsonObject.put(ConstValues.RESPDATA, JSONObject.fromBean(dataBag));
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		return jsonObject.toString();
		
	}
	
	
	
	public static String responseFindJsonArray(Object dataBag, int statusCode){
		JSONObject jsonObject = new JSONObject();
		jsonObject.put(ConstValues.RESPDATA, JSONArray.fromObject(dataBag));
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		return jsonObject.toString();
		
	}
	
	public static String responseFindFireCheckArray(List<Site> sites, int statusCode){
		JSONArray jsonArray =new JSONArray();
		for(Site site : sites){
		JSONObject jsonObject1 = new JSONObject();
		jsonObject1.put("siteid", site.getSiteid());
		jsonObject1.put("sitename", site.getSitename());
		JSONArray jsonArray0 =new JSONArray();
		for(Firesystype firesystype : site.getFiresystypes()){
			JSONObject jsonObject2 = new JSONObject();
			jsonObject2.put("tiSysType", firesystype.getTiSysType());
			jsonObject2.put("vSysdesc", firesystype.getvSysdesc());
			JSONArray jsonArray1 =new JSONArray();
			for(UserCheckProjectContent userCheckProjectContent: firesystype.getUserCheckProjectContents()){
				JSONObject jsonObject3 = new JSONObject();
				jsonObject3.put("ProjectId", userCheckProjectContent.getProjectId());
				jsonObject3.put("ProjectContent", userCheckProjectContent.getProjectContent());
				jsonObject3.put("UserCheckResult", userCheckProjectContent.getUserCheckInfos().get(0).getUserCheckResult());
				jsonObject3.put("FaultShow", userCheckProjectContent.getUserCheckInfos().get(0).getFaultShow());
				jsonObject3.put("YnHanding", userCheckProjectContent.getUserCheckInfos().get(0).getYnHanding());
				jsonObject3.put("Handingimmediately", userCheckProjectContent.getUserCheckInfos().get(0).getHandingimmediately());
				JSONObject jsonObject4 = new JSONObject();
				jsonObject4.put("PicProject", firesystype.getvSysdesc());
				jsonObject4.put("PicContent", userCheckProjectContent.getProjectContent());
				JSONArray jsonArray2 =new JSONArray();
				for(UserCheckPic userCheckPic :userCheckProjectContent.getUserCheckInfos().get(0).getUserCheckPics()){
					JSONObject jsonObject5 = new JSONObject();
					jsonObject5.put("PicID", userCheckPic.getPicID());
					jsonObject5.put("PicPath", userCheckPic.getPicPath());
					jsonArray2.put(jsonObject5);
				}
				jsonObject4.put("Picture", jsonArray2);
				jsonObject3.put("PicInfo",jsonObject4 );
				jsonArray1.put(jsonObject3);
			}
			jsonObject2.put("Content", jsonArray1);
			jsonArray0.put(jsonObject2);
		}
		jsonObject1.put("vSysContent", jsonArray0);
		jsonArray.put(jsonObject1);
		}
		JSONObject jsonObject0 = new JSONObject();
		jsonObject0.put(ConstValues.RESPDATA,jsonArray);
		jsonObject0.put(ConstValues.RESPCODE, statusCode);
		return jsonObject0.toString();
		
	}

	public static String responseFindPageJsonArray(Object dataBag, int statusCode, int pageCount){

		JSONObject jsonO = new JSONObject();
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("pageCount", pageCount);
		jsonO.put(ConstValues.RESPCODE, statusCode);
		jsonObject.put("PageDatas", JSONArray.fromObject(dataBag));
		jsonO.put(ConstValues.RESPDATA, jsonObject);
		return jsonO.toString();
		
	}
	
	public static String respPalyWithRoleFindPageJsonArray(Object dataBag, String mangerorgname, int statusCode, int pageCount){
		JSONObject jsonObject = new JSONObject();
		
		jsonObject.put("pageCount", pageCount);
		jsonObject.put("PageDatas", JSONArray.fromObject(dataBag));
		jsonObject.put("mangerorgname", mangerorgname);
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		
		return jsonObject.toString();
	}
	public static String responsePalyWithRoleFindPageJson(Object dataBag, String mangerorgname, int statusCode, int pageCount){
		JSONObject jsonObject = new JSONObject();

		jsonObject.put("pageCount", pageCount);
		jsonObject.put("PageDatas", JSONObject.fromBean(dataBag));
		jsonObject.put("mangerorgname", mangerorgname);
		jsonObject.put(ConstValues.RESPCODE, statusCode);
		
		return jsonObject.toString();
	}
/*	public static String responseAddJson(String dataBag, int statusCode){
		
		Map<String, Object> params = new HashMap<String, Object>();
		ObjectMapper mapper = new ObjectMapper();
		params.put(ConstValues.RESPDATA, dataBag);
		params.put(ConstValues.RESPCODE, statusCode);
		return mapper.writeValueAsString(params);
		
	}
	public static String responseFindJson(Object dataBag, int statusCode){
		Map<String, Object> params = new HashMap<String, Object>();
		ObjectMapper mapper = new ObjectMapper();
		params.put(ConstValues.RESPDATA, dataBag);
		params.put(ConstValues.RESPCODE, statusCode);
		return mapper.writeValueAsString(params);
		
	}
	
	public static String responseFindPageJson(Object dataBag, int statusCode, int pageCount){
		String result=null;
		Map<String, Object> params = new HashMap<String, Object>();
		ObjectMapper mapper = new ObjectMapper();
		params.put("pageCount", pageCount);
		params.put("PageDatas", dataBag);
		params.put(ConstValues.RESPCODE, statusCode);
		result=mapper.writeValueAsString(params);
		return result;
		
	}
	public static String responsePalyWithRoleFindPageJson(Object dataBag, String mangerorgname, int statusCode, int pageCount){
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
