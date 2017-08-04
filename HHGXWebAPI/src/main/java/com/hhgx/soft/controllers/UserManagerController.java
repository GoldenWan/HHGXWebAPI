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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hhgx.soft.services.UserManagerService;

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
	@RequestMapping(value = "/RegisterNew", method = { RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	public @ResponseBody String RegisterNew() throws JsonProcessingException {

		// userManagerService.registerNew();
		Map<String, Object> params = new HashMap<String, Object>();
		ObjectMapper mapper = new ObjectMapper();
		params.put("DataBag", "注册成功");
		params.put("StatusCode", 1000);
		return mapper.writeValueAsString(params);
	}

	/**
	 * 2.用户登录  * @return  * @throws JsonProcessingException:TODO  
	 */

	@RequestMapping(value = "/LoginBy", method = { RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String LoginBy(Object reqBody) throws JsonProcessingException {

		// userManagerService.LoginBy(username, password);

		Map<String, Object> params = new HashMap<String, Object>();
		ObjectMapper mapper = new ObjectMapper();
		params.put("DataBag", "登录成功");
		params.put("StatusCode", 1000);
		return mapper.writeValueAsString(params);
	}

	/**
	 * 3.根据用户帐号获取模块列表  * @return  * @throws JsonProcessingException:TODO  
	 */
	@RequestMapping(value = "/RetrieveZtreeNodes", method = {
			RequestMethod.POST }, produces = "text/html;charset=UTF-8")
	public @ResponseBody String RetrieveZtreeNodes() throws JsonProcessingException {

		// userManagerService.LoginBy(username, password);

		Map<String, Object> params = new HashMap<String, Object>();
		ObjectMapper mapper = new ObjectMapper();
		params.put("DataBag", "登录成功");
		params.put("StatusCode", 1000);
		return mapper.writeValueAsString(params);
	}

	/**
	 * 生成一张随即数字验证码
	 * 
	 * @throws IOException
	 */
	@RequestMapping(value = "Code", method = RequestMethod.GET)
	@ResponseBody
	public void Code(HttpServletRequest request, HttpServletResponse response) throws IOException {

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
			System.out.println(index);
			g.setColor(new Color(r.nextInt(66), r.nextInt(155), r.nextInt(255)));
			// 输出字体和大小
			g.setFont(new Font("Arial", Font.BOLD | Font.ITALIC, 22));
			// 写什么数字，在在图片的什么位子画
			g.drawString("" + ch[index], (i * 15) + 3, 18);// 迭代器，位置x,位置y
			sb.append(ch[index]);
		}
		// 把图片内容存入Session中
		request.getSession().setAttribute("certCode", sb.toString());
		// 向页面输出
		ImageIO.write(img, "JPG", response.getOutputStream());

	}

}
