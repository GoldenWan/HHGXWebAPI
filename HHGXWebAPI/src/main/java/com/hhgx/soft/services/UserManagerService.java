package com.hhgx.soft.services;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.entitys.RegisterNew;
import com.hhgx.soft.entitys.RetrieveZtreeNodes;
import com.hhgx.soft.entitys.User;
import com.hhgx.soft.mappers.UserManagerOrgMapper;
import com.hhgx.soft.utils.CommonMethod;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;

@Service
public class UserManagerService {
	@Autowired
	private UserManagerOrgMapper userManagerMapper;

	public RetrieveZtreeNodes retrieveZtreeNodes(String username) {

		return userManagerMapper.retrieveZtreeNodes(username);
	}

	public User loginBy(String username, String password) {
		return userManagerMapper.loginBy(username, password);
	}

	public boolean registerNew(RegisterNew registerNew, String userBelongTo) {
		int temp = 1;
		if (userBelongTo.equals("1")) {
			registerNew.setUsertypeID("Orgmanager");
			userManagerMapper.onlineorgRegister(registerNew);
			System.err.println(registerNew.toString());

		} else if (userBelongTo.equals("2")) {
			registerNew.setUsertypeID("maintenancemanager");
			userManagerMapper.maintenanceRegister(registerNew);
			System.err.println(registerNew.toString());
		} else {
			temp = -1;
		}
		if (temp > 0) {
			userManagerMapper.usersRegister(registerNew);
		}

		return temp > 0 ? true : false;
	}

	public boolean findAccount(String username) {
		int temp = userManagerMapper.findAccount(username);
		return temp > 0 ? true : false;
	}

	public String getUserTypeName(String userTypeID) {
		return userManagerMapper.getUserTypeName(userTypeID);
	}

	public String findMaxBack6(String areaID) {
		return userManagerMapper.findMaxBack6(areaID);
	}

	public int sendTelMessage(String userPoneNo) {
		String url="http://gw.api.taobao.com/router/rest";  
		//成为开发者，创建应用后系统自动生成  
		String appkey="LTAIyAHnKa8nRx8G";  
		String secret="4SIBqpDdYNOR0kCWOZSuHxBzkvYNAP";  
		
		int radomInt = CommonMethod.getRandNum(100000,  999999);
		//短信模板的内容  
		String json="{\"number\":\""+radomInt+"\"}";  
		TaobaoClient client = new DefaultTaobaoClient(url, appkey, secret);  
		AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();  
		req.setExtend("123456");  
		req.setSmsType("normal");  
		req.setSmsFreeSignName("短信验证");  
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
	
	

}
