package com.hhgx.soft.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
/**
 * 
 * 
   // @RequestMapping(value = "to_upload")  
    public ModelAndView toUpload() {  
        return new ModelAndView("background/fileOperate/upload");  
    }  
 
    @RequestMapping(value = "upload")  
    public ModelAndView upload(HttpServletRequest request) throws Exception {  
  
        Map<String, Object> map = new HashMap<String, Object>();  
  
        // 别名  
        String[] alaises = ServletRequestUtils.getStringParameters(request,  
                "alais");  
  
        String[] params = new String[] { "alais" };  
        Map<String, Object[]> values = new HashMap<String, Object[]>();  
        values.put("alais", alaises);  
  
        List<Map<String, Object>> result = FileOperateUtil.upload(request,  
                params, values);  
  
        map.put("result", result);  
  
        return new ModelAndView("background/fileOperate/list", map);  
    }  
  
  
    //@RequestMapping(value = "download")  
    public ModelAndView download(HttpServletRequest request,  
            HttpServletResponse response) throws Exception {  
  
        String storeName = "201205051340364510870879724.zip";  
        String realName = "Java设计模式.zip";  
        String contentType = "application/octet-stream";  
  
        FileOperateUtil.download(request, response, storeName, contentType,  
                realName);  
  
        return null;  
    }  
}  

 */
/**
 * 
 * 
 * @author 13信息_晚进军
 * 
 * @version 1.0
 * 
 * @Description 文件上传相关的工具类
 *	
 */
public class FileOperateUtil {

	 private static final String REALNAME = "realName";  
	    private static final String STORENAME = "storeName";  
	    private static final String SIZE = "size";  
	    private static final String SUFFIX = "suffix";  
	    private static final String CONTENTTYPE = "contentType";  
	    private static final String CREATETIME = "createTime";  
	    private static final String UPLOADDIR = "uploadDir/";  
	  
	    /** 
	     * 将上传的文件进行重命名 
	     *  
	     * @param name 
	     * @return 
	     */  
	    private static String rename(String name) {  
	  
	        Long now = Long.parseLong(new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));  
	        Long random = (long) (Math.random() * now);  
	        String fileName = now + "" + random;  
	  
	        if (name.indexOf(".") != -1) {  
	            fileName += name.substring(name.lastIndexOf("."));  
	        }  
	        return fileName;  
	    }  
	  
	    /** 
	     * 压缩后的文件名 
	     * @param name 
	     * @return 
	     */  
	    private static String zipName(String name) {  
	        String prefix = "";  
	        if (name.indexOf(".") != -1) {  
	            prefix = name.substring(0, name.lastIndexOf("."));  
	        } else {  
	            prefix = name;  
	        }  
	        return prefix + ".zip";  
	    }  
	  
	    /** 
	     * 上传文件 
	     *  
	     * @param request 
	     * @param params 
	     * @param values 
	     * @return 
	     * @throws Exception 
	     */  
	    public static List<Map<String, Object>> upload(HttpServletRequest request,  
	            String[] params, Map<String, Object[]> values) throws Exception {  
	  
	        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();  
	  
	        MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest) request;  
	        Map<String, MultipartFile> fileMap = mRequest.getFileMap();  
	  
	        String uploadDir = request.getSession().getServletContext()  
	                .getRealPath("/")  
	                + FileOperateUtil.UPLOADDIR;  
	        File file = new File(uploadDir);  
	  
	        if (!file.exists()) {  
	            file.mkdir();  
	        }  
	  
	        String fileName = null;  
	        int i = 0;  
	        for (Iterator<Map.Entry<String, MultipartFile>> it = fileMap.entrySet()  
	                .iterator(); it.hasNext(); i++) {  
	  
	            Map.Entry<String, MultipartFile> entry = it.next();  
	            MultipartFile mFile = entry.getValue();  
	  
	            fileName = mFile.getOriginalFilename();  
	  
	            String storeName = rename(fileName);  
	  
	            String noZipName = uploadDir + storeName;  
	            String zipName = zipName(noZipName);  
	  
	            // 上传成为压缩文件  
	            ZipOutputStream outputStream = new ZipOutputStream(  
	                    new BufferedOutputStream(new FileOutputStream(zipName)));  
	            outputStream.putNextEntry(new ZipEntry(fileName));  
	            //outputStream.("GBK");  
	  
	            FileCopyUtils.copy(mFile.getInputStream(), outputStream);  
	  
	            Map<String, Object> map = new HashMap<String, Object>();  
	            // 固定参数值对  
	            map.put(FileOperateUtil.REALNAME, zipName(fileName));  
	            map.put(FileOperateUtil.STORENAME, zipName(storeName));  
	            map.put(FileOperateUtil.SIZE, new File(zipName).length());  
	            map.put(FileOperateUtil.SUFFIX, "zip");  
	            map.put(FileOperateUtil.CONTENTTYPE, "application/octet-stream");  
	            map.put(FileOperateUtil.CREATETIME, new Date());  
	  
	            // 自定义参数值对  
	            for (String param : params) {  
	                map.put(param, values.get(param)[i]);  
	            }  
	  
	            result.add(map);  
	        }  
	        return result;  
	    }  
	  
	    /** 
	     * 下载 
	     * @param request 
	     * @param response 
	     * @param storeName 
	     * @param contentType 
	     * @param realName 
	     * @throws Exception 
	     */  
	    public static void download(HttpServletRequest request,  
	            HttpServletResponse response, String storeName, String contentType,  
	            String realName) throws Exception {  
	        response.setContentType("text/html;charset=UTF-8");  
	        request.setCharacterEncoding("UTF-8");  
	        BufferedInputStream bis = null;  
	        BufferedOutputStream bos = null;  
	  
	        String ctxPath = request.getSession().getServletContext()  
	                .getRealPath("/")  
	                + FileOperateUtil.UPLOADDIR;  
	        String downLoadPath = ctxPath + storeName;  
	  
	        long fileLength = new File(downLoadPath).length();  
	  
	        response.setContentType(contentType);  
	        response.setHeader("Content-disposition", "attachment; filename="  
	                + new String(realName.getBytes("utf-8"), "ISO8859-1"));  
	        response.setHeader("Content-Length", String.valueOf(fileLength));  
	  
	        bis = new BufferedInputStream(new FileInputStream(downLoadPath));  
	        bos = new BufferedOutputStream(response.getOutputStream());  
	        byte[] buff = new byte[2048];  
	        int bytesRead;  
	        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
	            bos.write(buff, 0, bytesRead);  
	        }  
	        bis.close();  
	        bos.close();  
	    }  

	
	
	/**
	 * 根据真实文件名 生成uuidname
	 * 
	 * @param filename
	 * @return
	 */
	public static String generateUUIDFilename(String filename) {
		String uuid = UUID.randomUUID().toString();
		// 不想保留源文件名 --- 保留源文件扩展名
		String ext = filename.substring(filename.lastIndexOf("."));

		return uuid +ext;
	}
	

}