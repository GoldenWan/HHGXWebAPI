package com.hhgx.soft.utils;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

/**
 * Request中发送json数据用post方式发送Content-type用
 * application/json;charset=utf-8方式发送的话，直接用springMVC的@RequestBody标签接收
 * 后面跟实体对象就行了，
 * spring会帮你自动拼装成对象，
 * 如果Content-type设置成application/x-www-form-urlencoded;charset=utf-8
 * 就不能用spring的东西了，只能以常规的方式获取json串了
 * @author win
 *
 */

public class GetRequestJsonUtils {


    /*** 
     * 获取 request 中 json 字符串的内容 
     *  
     * @param request 
     * @return : <code>byte[]</code> 
     * @throws IOException 
     */  
    public static String getRequestJsonString(HttpServletRequest request)  
            throws IOException {  
        String submitMehtod = request.getMethod();  
        // GET  
        if (submitMehtod.equals("GET")) {  
            return new String(request.getQueryString().getBytes("iso-8859-1"),"utf-8").replaceAll("%22", "\"");  
        // POST  
        } else {  
            return getRequestPostStr(request);  
        }  
    }  
  
    /**       
     * 描述:获取 post 请求的 byte[] 数组 
     * <pre> 
     * 举例： 
     * </pre> 
     * @param request 
     * @return 
     * @throws IOException       
     */  
    public static byte[] getRequestPostBytes(HttpServletRequest request)  
            throws IOException {  
        int contentLength = request.getContentLength();  
        if(contentLength<0){  
            return null;  
        }  
        byte buffer[] = new byte[contentLength];  
        for (int i = 0; i < contentLength;) {  
  
            int readlen = request.getInputStream().read(buffer, i,  
                    contentLength - i);  
            if (readlen == -1) {  
                break;  
            }  
            i += readlen;  
        }  
        return buffer;  
    }  
  
    /**       
     * 描述:获取 post 请求内容 
     * <pre> 
     * 举例： 
     * </pre> 
     * @param request 
     * @return 
     * @throws IOException       
     */  
    public static String getRequestPostStr(HttpServletRequest request)  
            throws IOException {  
        byte buffer[] = getRequestPostBytes(request);  
        String charEncoding = request.getCharacterEncoding();  
        if (charEncoding == null) {  
            charEncoding = "UTF-8";  
        }  
        return new String(buffer, charEncoding);  
    }  
    /**
     * 如果json数据中存在=号，数据会在等号的地方断掉，后面的数据会被存储成map的values，需要重新拼装key和values的值
     * @param request
     * @return
     */
    @SuppressWarnings("unused")
	private String getParameterMap(HttpServletRequest request) {  
        Map map = request.getParameterMap();  
        String text = "";  
        if (map != null) {  
            Set set = map.entrySet();  
            Iterator iterator = set.iterator();  
            while (iterator.hasNext()) {  
                Map.Entry entry =(Entry) iterator.next();  
                if (entry.getValue() instanceof String[]) {  
                    String key = (String) entry.getKey();  
                    if (key != null && !"id".equals(key) && key.startsWith("[") && key.endsWith("]")) {  
                        text = (String) entry.getKey();  
                        break;  
                    }  
                    String[] values = (String[]) entry.getValue();  
                    for (int i = 0; i < values.length; i++) {  
                        key += "="+values[i];  
                    }  
                    if (key.startsWith("[") && key.endsWith("]")) {  
                        text = (String) entry.getKey();  
                        break;  
                    }  
                } else if (entry.getValue() instanceof String) {  
                   }  
            }  
        }  
        return text;  
    }  
    /**  
     * 方法说明 :通过获取所有参数名的方式 
     * 对json串中不能传特殊字符，比如/=， \=， /， ~等的这样的符号都不能有如果存在也不会读出来
     */   
    @SuppressWarnings({ "rawtypes", "unchecked" })  
    private String getParamNames(HttpServletRequest request) {    
        Map map = new HashMap();    
        Enumeration paramNames = request.getParameterNames();    
        while (paramNames.hasMoreElements()) {    
            String paramName = (String) paramNames.nextElement();    
    
            String[] paramValues = request.getParameterValues(paramName);    
            if (paramValues.length == 1) {    
                String paramValue = paramValues[0];    
                if (paramValue.length() != 0) {    
                    map.put(paramName, paramValue);    
                }    
            }    
        }    
    
        Set<Map.Entry<String, String>> set = map.entrySet();    
        String text = "";  
        for (Map.Entry entry : set) {    
            text += entry.getKey() + ":" + entry.getValue();  
        }    
        if(text.startsWith("[") && text.endsWith("]")){  
            return text;  
        }  
        return "";  
    }  
    
}  

