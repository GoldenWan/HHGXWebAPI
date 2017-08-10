package com.hhgx.soft.controllers;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
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
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;
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
	public @ResponseBody String registerNew(@RequestBody String reqBody, HttpServletRequest request)
			throws JsonProcessingException {
		Map<String, String> m = RequestJson.reqJson(reqBody, "username", "password", "orgname", "AreaID", "verifycode",
				"UserBelongTo");
		RegisterNew registerNew = new RegisterNew();
		String userBelongTo = m.get("userBelongTo");
		String areaID = m.get("areaID");
		String orgname = m.get("orgname");
		String username = m.get("username");
		String password = m.get("password");
		String verifycode = m.get("verifycode");

		registerNew.setUserID(UUIDGenerator.getUUID());
		registerNew.setMaintenanceId(UUIDGenerator.getUUID());
		registerNew.setAreaID(areaID);
		registerNew.setOrgname(orgname);
		registerNew.setUserBelongTo(userBelongTo);
		registerNew.setUsername(username);
		registerNew.setPassword(password);
		String neworgid = userManagerService.findMaxBack6(areaID);
		int neworgid_ = 0;
		String orgid = null;
		if (StringUtils.isEmpty(neworgid)) {
			orgid = areaID + "000001";
		} else {
			neworgid_ = Integer.parseInt(neworgid) + 1;
			orgid = areaID + String.valueOf(neworgid_);
		}
		registerNew.setOrgid(orgid);
       System.err.println(orgid);
		String number = 2017+"";

		String dataBag = null;
		int statusCode = -1;

		if (StringUtils.isEmpty(userBelongTo) || userBelongTo == "0") {
			statusCode = ConstValues.ERROR;
			dataBag = "请选择用户类型";
			return ResponseJson.responseAddJson(dataBag, statusCode);

		} else if (StringUtils.isEmpty(username)) {
			statusCode = ConstValues.ERROR;
			dataBag = "请输入手机号";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		} else if (StringUtils.isEmpty(verifycode)) {
			statusCode = ConstValues.ERROR;
			dataBag = "请输入手机验证码";
			return ResponseJson.responseAddJson(dataBag, statusCode);

		} else if (!number.equalsIgnoreCase(verifycode)) {
			statusCode = ConstValues.ERROR;
			dataBag = "手机验证码错误";
			return ResponseJson.responseAddJson(dataBag, statusCode);

		} else if (StringUtils.isEmpty(orgname)) {
			statusCode = ConstValues.ERROR;
			dataBag = "请输入公司名";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		} else if (StringUtils.isEmpty(password)) {
			statusCode = ConstValues.ERROR;
			dataBag = "请输入密码";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		} else if (userManagerService.findAccount(username)) {
			statusCode = ConstValues.NOAUTHORIZED;
			dataBag = "已经有这个用户了 请更换手机号";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		} else {
			if (userManagerService.registerNew(registerNew, userBelongTo)) {
				dataBag = "插入成功";
				statusCode = ConstValues.OK;
				return ResponseJson.responseAddJson(dataBag, statusCode);
			} else {
				dataBag = "注册失败";
				statusCode = ConstValues.FAILED;
			}
			return ResponseJson.responseAddJson(dataBag, statusCode);
		}

	}

	/**
	 * 2.用户登录  * @return  * @throws JsonProcessingException:TODO  
	 * 
	 * @throws JsonProcessingException
	 */

	@RequestMapping(value = "/LoginBy", method = { RequestMethod.GET }, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String loginBy(HttpServletRequest request) throws JsonProcessingException {
		String sessionCode = (String) request.getSession().getAttribute("certCode");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String code = request.getParameter("code");
		int statusCode = 0;
		String dataBag = null;

		if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
			statusCode = ConstValues.FAILED;
			dataBag = "对不起，账号或密码不能为空";
			return ResponseJson.responseAddJson(dataBag, statusCode);

		} else if (StringUtils.isEmpty(code)) {
			statusCode = ConstValues.ERROR;
			dataBag = "没有验证码，请先获取验证码";
			return ResponseJson.responseAddJson(dataBag, statusCode);

		} else if (!code.equalsIgnoreCase(sessionCode)) {
			statusCode = ConstValues.NOAUTHORIZED;
			dataBag = "验证码错误";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		}

		else if (!userManagerService.findAccount(username)) {
			statusCode = ConstValues.NOAUTHORIZED;
			dataBag = "没有用户 请先注册";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		} else {
			User user = userManagerService.loginBy(username, password);
			if (user != null) {
				request.setAttribute("UserID", user.getUserID());
				statusCode = ConstValues.OK;
				String userTypeName = userManagerService.getUserTypeName(user.getUserTypeID());
				Map<String, String> map = new HashMap<String, String>();
				map.put("message", "登陆成功  欢迎回来[" + user.getAccount() + "]," + userTypeName);
				map.put("tokenID", user.getUserID());
				String content = JSONObject.fromBean(map).toString().replace("\"", "");
				return ResponseJson.responseFindJson(content, statusCode);
			} else {
				statusCode = ConstValues.NOAUTHORIZED;
				dataBag = "密码错误 找回密码";
				return ResponseJson.responseAddJson(dataBag, statusCode);
			}
		}
	}

	/**
	 * 3.根据用户帐号获取模块列表  * @return  * @throws JsonProcessingException:TODO  
	 */
	@ResponseBody
	@RequestMapping(value = "/RetrieveZtreeNodes", method = {
			RequestMethod.POST }, consumes = "application/json;charset=UTF-8", produces = "text/html;charset=UTF-8")
	public String retrieveZtreeNodes(@RequestBody String reqBody) {
		Map<String, String> map = RequestJson.reqJson(reqBody, "username");
		String username = map.get("username");
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

		Map<String, String> map = RequestJson.reqJson(reqBody, "UserPoneNo");
		String userPoneNo =map.get("userPoneNo");
		userManagerService.sendTelMessage(userPoneNo);
		return "";
	}
	
	
}
