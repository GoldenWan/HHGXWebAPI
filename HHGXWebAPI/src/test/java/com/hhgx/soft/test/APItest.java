package com.hhgx.soft.test;

import net.sf.json.JSONObject;

public class APItest {
public static void main(String[] args) {
JSONObject jsonObject = new JSONObject();
	jsonObject.put("a","a");
	jsonObject.put("A","b");
	jsonObject.put("A","C");
	System.out.println(jsonObject.toString());
}

}
