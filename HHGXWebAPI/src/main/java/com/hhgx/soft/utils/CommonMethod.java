package com.hhgx.soft.utils;

public class CommonMethod {

	
	public static int getRandNum(int min, int max) {
	    int randNum = min + (int)(Math.random() * ((max - min) + 1));
	    return randNum;
	}
	
	public static String getTimeString() {
		
		java.util.Date date=new java.util.Date();
		//yyyyMMddHHmmss
		java.text.DateFormat df = new java.text.SimpleDateFormat("yyyyMMddHHmm"); 
		String timeString = df.format(date);
		return timeString;
	}
	public static void main(String[] args) {
		System.out.println(getTimeString());
	}
}
