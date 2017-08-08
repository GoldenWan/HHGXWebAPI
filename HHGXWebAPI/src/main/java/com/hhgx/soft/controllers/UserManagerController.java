package com.hhgx.soft.controllers;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Map;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.hhgx.soft.services.UserManagerService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;
import com.hhgx.soft.utils.UUIDGenerator;
import com.hhgx.soft.entitys.RegisterNew;
import net.sf.json.JSONObject;
import com.hhgx.soft.entitys.RetrieveZtreeNodes;
import com.hhgx.soft.entitys.User;

@Controller
@RequestMapping(value = "/UserManager")
public class UserManagerController {

	@Autowired
	UserManagerService userManagerService;

	/**
	 * 1. 用户注册
	 * 
	 * @return
	 * @throws JsonProcessingException
	 */
	@RequestMapping(value = "/RegisterNew", method = {
			RequestMethod.POST }, consumes = "application/json;charset=UTF-8", produces = "text/html;charset=UTF-8")
	public @ResponseBody String registerNew(@RequestBody String reqBody, HttpServletRequest request) throws JsonProcessingException {
		Map<String, String> m = RequestJson.reqJson(reqBody, "username", "password", "orgname", "AreaID","UserBelongTo");
		RegisterNew registerNew = new RegisterNew();
		String userBelongTo =m.get("userBelongTo");
		registerNew.setUserID(UUIDGenerator.getUUID());
		registerNew.setOrgid(UUIDGenerator.getUUID().substring(0, 11));
		registerNew.setMaintenanceId(UUIDGenerator.getUUID().substring(0, 11));
		registerNew.setAreaID(m.get("areaID"));
		registerNew.setOrgname(m.get("orgname"));
		registerNew.setUserBelongTo(userBelongTo);
		registerNew.setUsername(m.get("username"));
		registerNew.setPassword(m.get("password"));
		System.err.println(registerNew.toString());
		String dataBag = null;
		int statusCode = -1;
		
		if (userManagerService.findAccount(m.get("username"))) {
			dataBag = "账号已注册";
			statusCode = ConstValues.ERROR;
		}
		else if (userManagerService.registerNew(registerNew,userBelongTo )) {
			
			dataBag = "注册成功";
			statusCode = ConstValues.OK;

		}else {
			dataBag = "注册失败";
			statusCode = ConstValues.FAILED;
		}
		
		return ResponseJson.responseAddJson(dataBag, statusCode);

	}

	/**
	 * 2.用户登录  * @return  * @throws JsonProcessingException:TODO  
	 * 
	 * @throws JsonProcessingException
	 */

	@RequestMapping(value = "/LoginBy", method = {
			RequestMethod.GET }, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String loginBy(HttpServletRequest request) {
		String sessionCode = (String) request.getSession().getAttribute("certCode");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String code = request.getParameter("code");

		int statusCode = 0;
		String dataBag = null;
		String result = null;
		// 判断验证码
	/*	if (code == "" || code == null || !code.equals(sessionCode)) {
			statusCode = ConstValues.ERROR;
			dataBag = "验证码错误";
		} else {*/
			User user = userManagerService.loginBy(username, password);	
			System.err.println(user.toString()+"--"+username+"--"+password);
			if (user.getAccount()!=null) {
				request.setAttribute("UserID", user.getUserID());
				statusCode = ConstValues.OK;
				dataBag = "登陆成功";
			}else{
				statusCode = ConstValues.FAILED;
				dataBag = "账号或密码错误";
			}
		//}
		try {
			result = ResponseJson.responseAddJson(dataBag, statusCode);
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
			dataBag = "后台异常";
			try {
				result = ResponseJson.responseAddJson(dataBag, statusCode);
			} catch (JsonProcessingException e1) {
				e1.printStackTrace();
			}
		}

		return result;
	}

	/**
	 * 3.根据用户帐号获取模块列表  * @return  * @throws JsonProcessingException:TODO  
	 */
	@ResponseBody
	@RequestMapping(value = "/RetrieveZtreeNodes", method = {
			RequestMethod.POST }, consumes = "application/json;charset=UTF-8", produces = "text/html;charset=UTF-8")
	public String retrieveZtreeNodes(@RequestBody String reqBody) {
		Map<String, String> map = RequestJson.reqJson(reqBody, "username");
		String username  = map.get("username");
		RetrieveZtreeNodes retrieveZtreeNodes = userManagerService.retrieveZtreeNodes(username);
		int statusCode = 0;
		String result = null;
		if (retrieveZtreeNodes != null) {
			statusCode = 1000;
			try {
				result = ResponseJson.responseFindJson(retrieveZtreeNodes, statusCode);
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
		}

		return result;
	}

	/**
	 * 生成一张随即数字验证码
	 * 
	 * @throws IOException
	 */
	@RequestMapping(value = "Code", method = RequestMethod.GET)
	@ResponseBody
	public void code(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int width = 68, height = 22;
		BufferedImage img = new BufferedImage(68, 22, BufferedImage.TYPE_INT_RGB);
		// 得到该图片的对象
		Graphics g = img.getGraphics();
		Color c = new Color(200, 150, 255);// 产生颜色
		g.setColor(c);// 对图像设置颜色
		g.fillRect(0, 0, 68, 22);// 填充图片
		// 向图片输出数字和字母
		StringBuffer sb = new StringBuffer();
		// 字符数组
		char[] ch = "abcdefghijklmnopqrstuvwxyz0123456789".toCharArray();
		int index, len = ch.length;
		Random r = new Random();
		for (int i = 0; i < 4; i++) {// 产生四个字符
			index = r.nextInt(len);// 从字符流中输出下一个字符----产生一个字符
			g.setColor(new Color(r.nextInt(66), r.nextInt(155), r.nextInt(255)));
			// 输出字体和大小
			g.setFont(new Font("Arial", Font.BOLD | Font.ITALIC, 22));
			// 写什么数字，在在图片的什么位子画
			g.drawString("" + ch[index], (i * 15) + 3, 18);// 迭代器，位置x,位置y
			sb.append(ch[index]);
		}
		g.setColor(new Color(r.nextInt(66), r.nextInt(155), r.nextInt(255)));
		// 绘制干扰线
		for (int i = 0; i < 2; i++) {

			int x = r.nextInt(width);
			int y = r.nextInt(height);
			int x1 = r.nextInt(12);
			int y1 = r.nextInt(12);
			g.drawLine(x1, y1, x, y);
		}

		// 把图片内容存入Session中
		request.getSession().setAttribute("certCode", sb.toString());
		// 向页面输出
		ImageIO.write(img, "JPG", response.getOutputStream());

	}

	
	/**
	 * 
	 */
	
	
	@ResponseBody
	@RequestMapping(value = "/RegistMessage", method = {
			RequestMethod.POST }, consumes = "application/json;charset=UTF-8", produces = "text/html;charset=UTF-8")
	public String registMessage(@RequestBody String reqBody) {

		JSONObject jObject = JSONObject.fromObject(reqBody);
		String userPoneNo = JSONObject.fromObject(jObject.getString("infoBag")).getString("UserPoneNo");
		
		/*入参列表

		参数名称	参数类型	必填与否	样例取值	参数说明
		PhoneNumbers	String	必须	15000000000	短信接收号码,支持以逗号分隔的形式进行批量调用，批量上限为1000个手机号码,批量调用相对于单条调用及时性稍有延迟,验证码类型的短信推荐使用单条调用的方式
		SignName	String	必须	云通信	短信签名
		TemplateCode	String	必须	SMS_0000	短信模板ID
		TemplateParam	String	可选	{“code”:”1234”,”product”:”ytx”}	短信模板变量替换JSON串,友情提示:如果JSON中需要带换行符,请参照标准的JSON协议对换行符的要求,比如短信内容中包含\r\n的情况在JSON中需要表示成\r\n,否则会导致JSON在服务端解析失败
		smsUpExtendCode	String	可选	90999	上行短信扩展码,无特殊需要此字段的用户请忽略此字段
		OutId	String	可选	abcdefgh	外部流水扩展字段
		出参列表

		出参名称	出参类型	样例取值	参数说明
		RequestId	String	8906582E-6722	请求ID
		Code	String	OK	状态码-返回OK代表请求成功,其他错误码详见错误码列表
		Message	String	请求成功	状态码的描述
		BizId	String	134523^4351232	发送回执ID,可根据该ID查询具体的发送状态
		技术对接步骤

		1:下载SDK工具包

		SDK工具包中一共包含了2个类库，一个aliyun-java-sdk-core包，另外一个是alicom-dysms-api包，将这两个包执行mvn package命令或者mvn deploy命令打包出相应的jar包，添加到工程类库中依赖使用。

		SDK&DEMO[下载地址]

		2: 编写样例程序*/
/*
		//设置超时时间-可自行调整
		System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
		System.setProperty("sun.net.client.defaultReadTimeout", "10000");
		//初始化ascClient需要的几个参数
		final String product = "Dysmsapi";//短信API产品名称（短信产品名固定，无需修改）
		final String domain = "dysmsapi.aliyuncs.com";//短信API产品域名（接口地址固定，无需修改）
		//替换成你的AK
		final String accessKeyId = "LTAIyAHnKa8nRx8G";//你的accessKeyId,参考本文档步骤2
		final String accessKeySecret = "4SIBqpDdYNOR0kCWOZSuHxBzkvYNAP";//你的accessKeySecret，参考本文档步骤2
		//初始化ascClient,暂时不支持多region
		IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId,
		accessKeySecret);
		DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", product, domain);
		IAcsClient acsClient = new DefaultAcsClient(profile);
		 //组装请求对象
		 SendSmsRequest request = new SendSmsRequest();
		 //使用post提交
		 request.setMethod(MethodType.POST);
		 
		 //必填:待发送手机号。支持以逗号分隔的形式进行批量调用，批量上限为1000个手机号码,批量调用相对于单条调用及时性稍有延迟,验证码类型的短信推荐使用单条调用的方式
		 request.setPhoneNumbers(userPoneNo);
		 //必填:短信签名-可在短信控制台中找到
		 request.setSignName("云通信");
		 //必填:短信模板-可在短信控制台中找到
		 request.setTemplateCode("SMS_83185001");
		 //可选:模板中的变量替换JSON串,如模板内容为"亲爱的${name},您的验证码为${code}"时,此处的值为
		 //友情提示:如果JSON中需要带换行符,请参照标准的JSON协议对换行符的要求,比如短信内容中包含\r\n的情况在JSON中需要表示成\\r\\n,否则会导致JSON在服务端解析失败
		 request.setTemplateParam("{\"name\":\"Tom\", \"code\":\"123\"}");
		 //可选-上行短信扩展码(无特殊需求用户请忽略此字段)
		 //request.setSmsUpExtendCode("90997");
		 //可选:outId为提供给业务方扩展字段,最终在短信回执消息中将此值带回给调用者
		 request.setOutId("yourOutId");
		//请求失败这里会抛ClientException异常
		 
		SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);
		if(sendSmsResponse.getCode() != null && sendSmsResponse.getCode().equals("OK")) {
		//请求成功
		}*/
		

		return "";
	}
}
