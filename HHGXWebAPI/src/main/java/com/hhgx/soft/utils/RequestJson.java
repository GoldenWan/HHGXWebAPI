package com.hhgx.soft.utils;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONNull;
import net.sf.json.JSONObject;

/**
 * 
 *  * Function: 请求Json处理工具类  * Reason: TODO ADD REASON(可选).  * date: 2017年8月25日
 * 下午1:24:57  * @author Mr.GoldenWan  
 */
public class RequestJson {

	/**
	 * 将前端传递json 首字母小写放进map
	 * 
	 *  * @param reqBody  * @param args  * @return:TODO  
	 */
	public static Map<String, String> reqFirstLowerJson(String reqBody, String... args) {
		JSONObject jObject = JSONObject.fromObject(reqBody);
		Map<String, String> map = new HashMap<String, String>();
		try {

			for (int i = 0; i < args.length; i++) {
				Object o = JSONObject.fromObject(jObject.getString(ConstValues.REQDATA)).getString(args[i]);
				if (o instanceof JSONNull)
					map.put(toLowerCaseFirstOne(args[i]), "");
				else {
					map.put(toLowerCaseFirstOne(args[i]),
							JSONObject.fromObject(jObject.getString(ConstValues.REQDATA)).getString(args[i]));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	/**
	 * 将前端传递json 按照原来格式放进map
	 * 
	 *  * @param reqBody  * @param args  * @return:TODO  
	 */
	public static Map<String, String> reqOriginJson(String reqBody, String... args) {
		JSONObject jObject = JSONObject.fromObject(reqBody);
		Map<String, String> map = new HashMap<String, String>();
		try {
			for (int i = 0; i < args.length; i++) {
				Object o = JSONObject.fromObject(jObject.getString(ConstValues.REQDATA)).getString(args[i]);
				if (o instanceof JSONNull)
					map.put(args[i], "");
				else {
					map.put(args[i], JSONObject.fromObject(jObject.getString(ConstValues.REQDATA)).getString(args[i]));
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;

	}

	// 首字母转小写方法
	public static String toLowerCaseFirstOne(String s) {
		if (Character.isLowerCase(s.charAt(0)))
			return s;
		else
			return (new StringBuilder()).append(Character.toLowerCase(s.charAt(0))).append(s.substring(1)).toString();
	}

}
