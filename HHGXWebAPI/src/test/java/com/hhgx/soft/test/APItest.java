package com.hhgx.soft.test;


import java.util.Random;

import com.hhgx.soft.utils.CommonMethod;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;

public class APItest {
	public static int getRandNum(int min, int max) {
	    int randNum = min + (int)(Math.random() * ((max - min) + 1));
	    return randNum;
	}
	
	public static void sendMobileCode() {
		int radomInt = new Random().nextInt(999999);
      System.out.println(radomInt);
	}

	public static int sendTelMessage(String userPoneNo) {
		String url="http://gw.api.taobao.com/router/rest";  
		//成为开发者，创建应用后系统自动生成  
		String appkey="LTAIyAHnKa8nRx8G";  
		String secret="4SIBqpDdYNOR0kCWOZSuHxBzkvYNAP";  
		
		int radomInt = CommonMethod.getRandNum(100000,  999999);
		String product="恒华光讯";
		//短信模板的内容  
		//String json="{\"number\":\""+radomInt+"\"}";  
		String json="{\"number\":\""+radomInt+"\",\"product\":\""+product+"\"}";
		TaobaoClient client = new DefaultTaobaoClient(url, appkey, secret);  
		AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();  
		req.setExtend("123456");  
		req.setSmsType("normal");  
		req.setSmsFreeSignName("恒华光讯H");  
		req.setSmsParamString(json);  
		req.setRecNum(userPoneNo);  
		req.setSmsTemplateCode("SMS_83185001");  
		try {  
		    AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);  
		    System.out.println(rsp.getBody());  
		    return 1;  
		} catch (Exception e) {  
		    return -1;  
		}  
	}
	public static void main(String[] args) {
		
		sendTelMessage("17340203424");
	}
}
