package com.hhgx.soft.test;

import net.sf.json.JSONObject;

public class APItest {
public static void main(String[] args) {
JSONObject jsonObject = new JSONObject();
	jsonObject.put("a","a");
	jsonObject.put("A","b");
	jsonObject.put("A","C");
	System.out.println(jsonObject.toString());
	
	String picPathName ="/Uploading/CheckRecord/7a5cc34b-8ff4-4a26-bc20-5565e7345d22/6f7e4fed-e2e9-4995-a40b-99a3786a8b3b.png";
	String str[] = picPathName.split("/");
for(int i=0;i<str.length;i++){
	

	System.out.println(str[0]+0);
	System.out.println(str[i]+i);
}}

}
