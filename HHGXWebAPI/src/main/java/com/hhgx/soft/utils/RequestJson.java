package com.hhgx.soft.utils;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONNull;
import net.sf.json.JSONObject;

public class RequestJson {

	
	public static 	Map<String, String> reqJson(String reqBody,String... args) {
		JSONObject jObject = JSONObject.fromObject(reqBody);
		Map<String, String> map = new HashMap<String, String>();
		 for (int i = 0; i < args.length; i++) {
			 Object o = JSONObject.fromObject(jObject.getString("infoBag")).getString(args[i]);
			 if(o instanceof JSONNull)
			   map.put(toLowerCaseFirstOne(args[i]),"");
	        else {
	        	 map.put(toLowerCaseFirstOne(args[i]), JSONObject.fromObject(jObject.getString("infoBag")).getString(args[i]));
			}
			 
		 }
		return map;
		
		
	}
	//首字母转小写
    public static String toLowerCaseFirstOne(String s)
    {
        if(Character.isLowerCase(s.charAt(0)))
            return s;
        else
            return (new StringBuilder()).append(Character.toLowerCase(s.charAt(0))).append(s.substring(1)).toString();
    }
	
}
