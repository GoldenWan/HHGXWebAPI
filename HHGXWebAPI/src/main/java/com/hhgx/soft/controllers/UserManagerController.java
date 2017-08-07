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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
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
	public @ResponseBody String registerNew(@RequestBody String reqBody, HttpServletRequest request) {
		Map<String, String> m = RequestJson.reqJson(reqBody, "username", "password", "orgname", "AreaID",
				"UserBelongTo");
		System.err.println(m.get("password"));
		RegisterNew registerNew = new RegisterNew();
		registerNew.setUserID(UUIDGenerator.getUUID());
		registerNew.setOrgid(UUIDGenerator.getUUID());
		registerNew.setMaintenanceId(UUIDGenerator.getUUID());

		registerNew.setAreaID(m.get("areaID"));
		registerNew.setOrgname(m.get("orgname"));
		registerNew.setUserBelongTo(m.get("userBelongTo"));
		registerNew.setUsername(m.get("username"));
		registerNew.setPassword(m.get("password"));
		String dataBag = null;
		int statusCode = 0;
		String result = null;
		if (userManagerService.findAccount(m.get("username"))) {
			dataBag = "账号已注册";
			statusCode = ConstValues.ERROR;
		}
		else if (userManagerService.registerNew(registerNew)) {
			dataBag = "注册成功";
			statusCode = ConstValues.OK;

		} else {
			dataBag = "注册失败";
			statusCode = ConstValues.FAILED;
		}

		try {
			result = ResponseJson.responseAddJson(dataBag, statusCode);
		} catch (JsonProcessingException e) {
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
	 * 2.用户登录  * @return  * @throws JsonProcessingException:TODO  
	 * 
	 * @throws JsonProcessingException
	 */

	@RequestMapping(value = "/LoginBy", method = {
			RequestMethod.GET }, consumes = "text/html;charset=UTF-8", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String loginBy(@RequestBody String reqBody, HttpServletRequest request) {
		String sessionCode = (String) request.getSession().getAttribute("certCode");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String code = request.getParameter("code");

		int statusCode = 0;
		String dataBag = null;
		String result = null;
		// 判断验证码
		if (code == "" || code == null || !code.equals(sessionCode)) {
			statusCode = ConstValues.ERROR;
			dataBag = "验证码错误";
		} else {
			User user = userManagerService.loginBy(username, password);
			if (userManagerService.loginBy(username, password) != null) {
				request.setAttribute("UserID", user.getUserID());
				statusCode = ConstValues.OK;
				dataBag = "登陆成功";
			}
		}
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

		JSONObject jObject = JSONObject.fromObject(reqBody);
		String username = JSONObject.fromObject(jObject.getString("infoBag")).getString("username");
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

}
