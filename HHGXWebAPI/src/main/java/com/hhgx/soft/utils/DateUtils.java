package com.hhgx.soft.utils;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * 
 * Function:  日期工具类
 * date: 2017年8月25日 下午5:48:15
 * @author Mr.GoldenWan
 
 */
public class DateUtils {

	public static final SimpleDateFormat FORMATER = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static final SimpleDateFormat NOSFORMATER = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	public static long getTimeSub(Date submitTime_) 
	{ 
	
	long hours=0;//小时
		try 
		{    //服务器时间格式2017年 08月 30日 星期三 10:32:43 UTC
			 //SimpleDateFormat format_ = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			  DateFormat format = new SimpleDateFormat("MMM dd,yyyy KK:mm:ss aa", Locale.ENGLISH);
			
			 Date endDate=FORMATER.parse(FORMATER.format(submitTime_)); 
			 Date nowDate=format.parse(format.format(new Date()));
			 
			 long temp=endDate.getTime()-nowDate.getTime();//截止时间的总微秒
			 //long mins = (temp % (1000 * 3600)) / 1000 / 60;  //相差分钟数
			 hours = temp / 1000 / 3600;                //相差小时数
			// long day=temp/(24*60*60*1000); //相差总天数
		    } catch (ParseException e){ 
			e.printStackTrace(); 
			} 
		return hours;
	}

	
	/**
	 * 按照指定的格式返回日期字符串. 默认 "yyyy-MM-dd"
	 * yyyy-MM-dd HH:mm:ss
	 * yyyyMMddHHmmss
	 * @param String
	 */
	public static String formatDateToString(String pattern) {
		
		Date d = new Date();
		if (pattern == null)
			pattern = "yyyy-MM-dd";
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		return (sdf.format(d));
	}
	
	public static String formatDateTime(Date date) {
		return (formatDate(date, "yyyy-MM-dd HH:mm:ss"));
	}
	/**
	 * 按照指定的格式返回日期字符串. 默认 "yyyy-MM-dd"
	 * 
	 * @param Date
	 * @param String
	 */
	public static String formatDate(Date date, String pattern) {
		if (date == null)
			return "";
		if (pattern == null)
			pattern = "yyyy-MM-dd";
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		return (sdf.format(date));
	}
	
	/**
	 * 按照指定的格式返回日期字符串. 默认 "yyyy/MM/dd"
	 * 
	 * @param Date
	 * @param String
	 */
	public static String formatToDate(String date) 
	{  String formatDATE ="";
		if (date == null)
			return "";
		String d = date.substring(0,10);
		formatDATE=d.replaceAll("-", "/");
		return formatDATE;
	}
/**按照指定的格式返回日期字符串. 默认 "yyyy/MM/dd HH:mm:ss"
 * 
 * @param date
 * @return:TODO
 
 */
	public static String formatToDateTime(String date) {
		String formatDATE = "";
		if (date == null)
			return "";
		formatDATE = date.replaceAll("-", "/");
		// 2017/08/30 14:28:53.0
		if (formatDATE.length() > 19) {
			formatDATE = formatDATE.substring(0, 19);
		}
		return formatDATE;
	}

	
	/**
	 * 时间字符串转化为timestamp
	 * 2017/08/30  00:00:00
	 * @param times
	 * @return
	 */
	public static Timestamp stringToTimestamp(String times,String ext) {
		if(ext==null)
		ext=" 00:00:00";
		String formatDATE ="";
		formatDATE=times.replaceAll("/", "-").concat(ext);
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		try {
			ts = Timestamp.valueOf(formatDATE);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ts;
	}
	

	public static String timesstampToString(String s) {
		String tsStr = "";
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			// 方法一
			tsStr = sdf.format(s);
		    tsStr = tsStr.substring(0,10).replaceAll("-", "/");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tsStr;
	}
	
	public static String timesstampToString() {
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		String tsStr = "";
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			// 方法一
			tsStr = sdf.format(ts);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tsStr;
	}
	
	/**
	 * 字符串转日期
	 * 
	 * @param date
	 * @return
	 */
	public static Date StringToDate(String dateStr, String dateformat) {
		SimpleDateFormat dd = new SimpleDateFormat(dateformat);
		Date date = null;
		try {
			date = dd.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}




	/**
	 * function get the days of one year
	 * 
	 * @return days
	 */
	public static boolean getLeapYear() {
		boolean tag = false;
		Date date = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy");
		String dt = df.format(date);
		int pastYear = Integer.parseInt(dt) - 1;
		if (pastYear % 4 == 0 && (pastYear % 100 != 0 || pastYear % 400 == 0))
			tag = true;
		return tag;
	}
	
	/**
	 * function format time
	 * 
	 * @param str
	 * @return
	 */
	public static String getFormatDate(String str, String format) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		Date date = null;
		String dateStr = null;
		try {
			date = sdf.parse(str);
			dateStr = sdf.format(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return dateStr;
	}


}
