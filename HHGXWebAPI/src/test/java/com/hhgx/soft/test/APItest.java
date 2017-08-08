package com.hhgx.soft.test;


import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;

public class APItest {

/*	@Test*/
	public void sendMobileCode() {
	    String rusult = null;
	    // 官网的URL
	    String url = "http://gw.api.taobao.com/router/rest";
	    // 成为开发者，创建应用后系统自动生成
	    String appkey = "23566780";
	    String secret = "自己的App Secret";
	    String code = "520";
	    String product = "cool_moon";
	    
	    TaobaoClient client = new DefaultTaobaoClient(url, appkey, secret);
	    AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
	    req.setExtend("1234");
	    req.setSmsType("normal");
	    req.setSmsFreeSignName("验证提醒");
	    req.setSmsParamString("{\"code\":\""+code+"\",\"product\":\""+product+"\"}");
	    req.setRecNum("17340203424");
	    req.setSmsTemplateCode("SMS_34530098");
	    try {
	        AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
	        System.out.println(rsp.getBody());  
	        rusult = rsp.getSubMsg();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    System.out.println(rusult);
	}
}
