package com.hhgx.soft.utils;

import org.springframework.util.DigestUtils;

public class Md5Util {
	//md5盐值字符串,用于混淆MD5

    public static String getMD5(String pasword) {
    	final String salt = "sadkfjalsdjfalksj23423^&*^&%&!EBJKH#£4";
        String base = pasword + "/" + salt;
        String md5 = DigestUtils.md5DigestAsHex(base.getBytes());
        return md5;
    }
	public static void main(String[] args) {
		System.out.println(getMD5("admin"));
	}
	
}
