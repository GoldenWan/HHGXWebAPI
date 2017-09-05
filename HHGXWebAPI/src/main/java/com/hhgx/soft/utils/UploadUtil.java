package com.hhgx.soft.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;


public class UploadUtil {

	/**
	 * 上传单个文件
	 * 
	 * @param f
	 *          MultipartFile  文件
	 * @param fName
	 *            保存文件名称
	 * @param paperFileName
	 *          Uploading下的文件目录
	 * @return
	 */
	public final static String uploadOneFile(HttpServletRequest request, MultipartFile f, String fName,
			String paperFileName) {
		if (f.getSize() != 0 && !("").equals(fName) && null != f && null != fName) {
			String filedir = request.getSession().getServletContext().getRealPath("/") + "Uploading/" + paperFileName;
			File dir = new File(filedir);
			if (!dir.exists()) // 如果目录不存在就创建目录
				dir.mkdirs();
			File accessoryFile = new File(filedir + "/" + fName); // NEW一个文件对象
			try {
				copyFile(f, accessoryFile); // 拷贝上传的文件对象
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "/Uploading/" + paperFileName + "/" + fName; // 新生成的图片路径名称
		}
		return null;
	}

	// 获取文件后缀
	public static String getExtention(String fileName) {
		int pos = fileName.lastIndexOf(".");
		return fileName.substring(pos+1);
	}
	// 获取文件名称
	public static String getFileName(String filepath) {
		return filepath.substring( filepath.lastIndexOf("/")+1);
	}
	// 获取文件目录
	public static String getStoreName(String filepath) {
		return  filepath.substring( filepath.indexOf("/")+10,filepath.lastIndexOf("/")+1);//+1
	
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

		return uuid + ext;
	}
	
	//复制文件
	private static void copyFile(MultipartFile imgFile, File dst) throws IOException {
		imgFile.transferTo(dst); // 保存上传的文件
	}

		
		/**
		 * 删除单个文件
		 * 
		 * @param fileName
		 *            被删除文件的文件名
		 * @return 单个文件删除成功返回true,否则返回false
		 */
	public static boolean deleteFile(String fileName) {
		File file = new File(fileName);
		if (file.isFile() && file.exists()) {
			file.delete();// "删除单个文件"+name+"成功！"
			return true;
		} // "删除单个文件"+name+"失败！"
		return false;
	}
	/********************************** 解析上传文件后缀 **********/

	public static boolean setmsgext(String list, String ext) {
		boolean flag = false;
		if (list != null && list.length() > 0) {
			String[] arr = list.split(",");
			for (int i = 0; i < arr.length; i++) {
				if (ext.equals(arr[i])) {
					flag = true;
					break;
				}
			}

		}
		return flag;
	}

	
	
	
	public void upload(File f, String fileName) {
		try {
			// 创建读取流
			FileInputStream fin = new FileInputStream(f);
			String files = Thread.currentThread().getContextClassLoader().getResource("/").getPath() + "upload/";

			// 创建输入流
			File fe = new File(files + fileName);

			FileOutputStream fout = new FileOutputStream(fe);

			// 一边读取，一边写入
			byte data[] = new byte[1024];

			int count = 0;

			while ((count = fin.read(data)) != -1) {

				fout.write(data, 0, count);
			}

			// 关闭流
			fin.close();
			fout.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}





	/******************************************************************************************************************/
	/**
	 * 删除文件CheckRecord
	 * 
	 * @param fName
	 *            文件名称
	 * @param paperFileName
	 *            文件夹名称
	 * @return
	 */
	public final static boolean deleteOneFileOrDirectory(HttpServletRequest request, String fName, String paperFileName) {
		// 文件路径
		String filedir = request.getSession().getServletContext().getRealPath("/") + "Uploading/" + paperFileName + "/"
				+ fName;
		// 文件夹
		String directorydir = request.getSession().getServletContext().getRealPath("/") + "Uploading/" + paperFileName;
		// 保存文件 文件夹路径
		String rootPath = request.getSession().getServletContext().getRealPath("/") + "Uploading/";
		File file = new File(filedir);
		if (!file.exists()) {
			// "删除文件失败："+fName+"文件不存在";
			return false;
		} else {
			// 删除所有空文件夹
			List<File> list = getAllNullDirectorys(new File(rootPath));
			removeNullFile(list, rootPath);
			if (file.isFile()) {
				return deleteFile(filedir); // 删除单个文件
			} else {
				return deleteDirectory(directorydir); // 删除目录（文件夹）以及目录下的文件
			}
		}
	}


	/**
	 * 删除目录（文件夹）以及目录下的文件
	 * 
	 * @param dir
	 *            被删除目录的文件路径
	 * @return 目录删除成功返回true,否则返回false
	 */
	public static boolean deleteDirectory(String directorydir) {
		// 如果dir不以文件分隔符结尾，自动添加文件分隔符
		if (!directorydir.endsWith(File.separator)) {
			directorydir = directorydir + File.separator;
		}
		File dirFile = new File(directorydir);
		// 如果dir对应的文件不存在，或者不是一个目录，则退出
		if (!dirFile.exists() || !dirFile.isDirectory()) {
			// "删除目录失败"+name+"目录不存在！"
			return false;
		}
		boolean flag = true;
		// 删除文件夹下的所有文件(包括子目录)
		File[] files = dirFile.listFiles();
		for (int i = 0; i < files.length; i++) {
			// 删除子文件
			if (files[i].isFile()) {
				flag = deleteFile(files[i].getAbsolutePath());
				if (!flag) {
					break;
				}
			}
			// 删除子目录
			else {
				flag = deleteDirectory(files[i].getAbsolutePath());
				if (!flag) {
					break;
				}
			}
		}

		if (!flag) {
			// System.out.println("删除目录失败");
			return false;
		}

		// 删除当前目录
		if (dirFile.delete()) {
			// System.out.println("删除目录"+directorydir+"成功！");
			return true;
		} else {
			// System.out.println("删除目录"+directorydir+"失败！");
			return false;
		}
	}

	// 删除文件夹 folderPath 文件夹完整绝对路径
	public static void delFolder(String folderPath) {
		try {
			delAllFile(folderPath); // 删除完里面所有内容
			String filePath = folderPath;
			filePath = filePath.toString();
			java.io.File myFilePath = new java.io.File(filePath);
			myFilePath.delete(); // 删除空文件夹
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 删除指定文件夹下所有文件 path 文件夹完整绝对路径
	public static boolean delAllFile(String path) {
		boolean flag = false;
		File file = new File(path);
		if (!file.exists()) {
			return flag;
		}
		if (!file.isDirectory()) {// 判断该路径是否是一个目录
			return flag;
		}
		String[] tempList = file.list();
		File temp = null;
		for (int i = 0; i < tempList.length; i++) {
			if (path.endsWith(File.separator)) {
				temp = new File(path + tempList[i]);
			} else {
				temp = new File(path + File.separator + tempList[i]);
			}
			if (temp.isFile()) {
				temp.delete();
			}
			if (temp.isDirectory()) {
				delAllFile(path + "/" + tempList[i]);// 先删除文件夹里面的文件
				delFolder(path + "/" + tempList[i]);// 再删除空文件夹
				flag = true;
			}
		}
		return flag;
	}




	/**
	 * 递归列出某文件夹下的最深层的空文件夹绝对路径，储存至list
	 * 
	 * @param root
	 * @return
	 */
	public static List<File> getAllNullDirectorys(File root) {
		List<File> list = new ArrayList<File>();
		File[] dirs = root.listFiles();
		if (dirs != null) {
			for (int i = 0; i < dirs.length; i++) {
				if (dirs[i].isDirectory() && dirs[i].listFiles().length == 0) {
					// System.out.println("name:" + dirs[i].getPath());
					list.add(dirs[i]);
				}
				if (dirs[i].isFile()) {
					// System.out.println("文件:"+dirs[i].getPath());
				}
				list.addAll(getAllNullDirectorys(dirs[i]));
			}
		}
		return list;
	}

	/**
	 * 由最深一层的空文件，向上（父文件夹）递归，删除空文件夹
	 * 
	 * @param list
	 * @param rootPath
	 */
	public static void removeNullFile(List<File> list, String rootPath) {
		if (list == null || list.size() == 0) {
			return;
		}
		List<File> plist = new ArrayList<File>();
		for (int i = 0; i < list.size(); i++) {
			File temp = list.get(i);
			if (temp.isDirectory() && temp.listFiles().length <= 0) {
				temp.delete();
				// System.out.println("parent:" +
				// temp.getParentFile().getPath());
				File pFile = temp.getParentFile();
				if (pFile.getPath().equals(rootPath)) {
					continue;
				}
				if (!plist.contains(pFile)) {// 父目录去重添加
					plist.add(pFile);
				}
			}
		}
		removeNullFile(plist, rootPath);
	}

	/**
	 * 下载
	 * 
	 * @param request
	 * @param response
	 * @param storeName
	 *            /Manoeuvre/b1bbe7b092f342eebff8d 下载的文件名称(下载文件路径)
	 * @param contentType:
	 *            application/force-download
	 * @param realName
	 *            下载后需要显示的文件名称
	 * @throws Exception
	 */
	public static void download(HttpServletRequest request, HttpServletResponse response, String storeName,
			String contentType, String realName) {
		response.setContentType("text/html;charset=UTF-8");
		// request.setCharacterEncoding("UTF-8");
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try {
			String downLoadPath =null;
			String ctxPath = request.getSession().getServletContext().getRealPath("/") + "Uploading/";
			if(StringUtils.isEmpty(storeName)){
			  downLoadPath = ctxPath;
			}else {
				 downLoadPath = ctxPath + storeName + "/" ;
			}
			
		
			
			File file = new File(downLoadPath,realName);
			if (file.exists()) {
				response.setContentType(contentType);// response.setContentType("application/force-download");//
				response.setHeader("Content-disposition",
						"attachment; filename=" + new String(realName.getBytes("utf-8"), "ISO-8859-1"));
				response.setHeader("Content-Length", String.valueOf(file.length()));

				bis = new BufferedInputStream(new FileInputStream(downLoadPath+realName));
				bos = new BufferedOutputStream(response.getOutputStream());
				byte[] buff = new byte[2048];
				int bytesRead;
				while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
					bos.write(buff, 0, bytesRead);
				}
			}

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			if (bis != null) {
				try {
					bis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (bos != null) {
				try {
					bos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

	}

}
