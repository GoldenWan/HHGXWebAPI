package com.hhgx.soft.utils;

import java.io.IOException;

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
  
}  

