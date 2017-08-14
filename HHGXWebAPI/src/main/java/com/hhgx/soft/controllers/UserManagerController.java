package com.hhgx.soft.controllers;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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

import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.hhgx.soft.entitys.ChildModule;
import com.hhgx.soft.entitys.RegisterNew;
import com.hhgx.soft.entitys.User;
import com.hhgx.soft.entitys.UserInfo;
import com.hhgx.soft.entitys.Ztree;
import com.hhgx.soft.services.UserManagerService;
import com.hhgx.soft.utils.CommonMethod;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.RegistMessage;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;
import com.hhgx.soft.utils.UUIDGenerator;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/UserManager")
public class UserManagerController {

	@Autowired
	UserManagerService userManagerService;

	/****************** 注册 ****************************/

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
		registerNew.setIsFirstEnroll("是");
		String neworgid = null;
		if (!StringUtils.isEmpty(areaID)) {
			try {
				neworgid = userManagerService.findMaxBack6(areaID);
			} catch (Exception e) {
				e.printStackTrace();
				return ResponseJson.responseAddJson("注册失败", ConstValues.FAILED);
			}
		}

		int neworgid_ = 0;
		String orgid = null;
		if (StringUtils.isEmpty(neworgid)) {
			orgid = areaID + "000001";
			registerNew.setApproveState("待审批");

		} else {
			neworgid_ = Integer.parseInt(neworgid) + 1;
			orgid = areaID + String.valueOf(neworgid_);
		}
		registerNew.setOrgid(orgid);
		System.err.println(orgid);
		String number = (String) request.getSession().getAttribute("number");

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

		} else if (!verifycode.equals(number)) {
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
	 * 158. 短信发送
	 */

	@ResponseBody
	@RequestMapping(value = "/RegistMessage", method = {
			RequestMethod.POST }, consumes = "application/json;charset=UTF-8", produces = "text/html;charset=UTF-8")
	public String registMessage(@RequestBody String reqBody, HttpServletRequest request) {

		Map<String, String> map = RequestJson.reqJson(reqBody, "UserPoneNo");
		// 设置短信内容参数
		String userPoneNo = map.get("userPoneNo");
		String smsFreeSignName = "恒华光迅H";
		String smsTemplateCode = "SMS_83185001";
		int number = CommonMethod.getRandNum(100000, 999999);
		String smsParamJson = "{\"number\":\"" + number + "\"}";
		int ret = -1;
		String dataTag = null;
		// 发短信
		try {
			SendSmsResponse response = RegistMessage.sendSms(smsFreeSignName, smsTemplateCode, smsParamJson,
					userPoneNo);
			System.out.println(response.getCode());
			System.out.println(response.getCode().equals("OK"));
			if (response.getCode().equals("OK") && response.getMessage().equals("OK")) {
				ret = 1;
			}

		} catch (ClientException e) {
			e.printStackTrace();
			ret = -1;
		}

		Map<String, String> result = new HashMap<String, String>();
		if (ret == 1) {
			dataTag = "发送成功";
			// 把图片内容存入Session中
			request.getSession().setAttribute("number", String.valueOf(number));

		} else
			dataTag = "发送失败";
		result.put("DataTag", dataTag);
		result.put("ret", String.valueOf(ret));
		return JSONObject.fromBean(result).toString();

	}
	/****************** 登录 ****************************/

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
	 * 3.根据用户帐号获取模块列表  
	 * 
	 * 
	 * 【所用表:用户Users,用户类型UserType,模块ModuleList,模块用户类型Module_UserType,
	 * 防火单位Onlineorg,维保单位Maintenance,消防管理部门ManagerOrg】
	 * 【说明：此API主要是获取登录系统后，展现在左侧的模块列表。根据ModuleList及Module_UserType及Users表可以得到一级模块
	 * 。然后根据一级模块的ModuleID=ModuleList中ParentID获取二级模块。
	 * 
	 * 
	 * 其次需要返回该用户的其他信息，假如在Users表中查找的该记录为ValidUser,则根据ValidUser.UserBelongTo
	 * case1:OrgIDValue = validUser.orgid;
	 * UserBelongName=”防火单位”;CompanyName为防火单位名字 case2:OrgIDValue =
	 * validUser.MaintenanceId; UserBelongName=”维保单位”,CompanyName......
	 * case3:OrgIDValue = validUser.ManagerOrgID;
	 * UserBelongName=”管理机构”,CompanyName..... case4:UserBelongName=”系统管理员”
	 * 
	 * 
	 * @return  
	 * @throws JsonProcessingException:TODO
	 *              
	 */
	@ResponseBody
	@RequestMapping(value = "/RetrieveZtreeNodes", method = {
			RequestMethod.POST }, consumes = "application/json;charset=UTF-8", produces = "text/html;charset=UTF-8")
	public String retrieveZtreeNodes(@RequestBody String reqBody) throws JsonProcessingException {
		Map<String, String> map = RequestJson.reqJson(reqBody, "username");
		String username = map.get("username");
		Map<String, Object> dataBag = new HashMap<String, Object>();
		int statusCode = 0;
try {
	
		if (!username.equals(null)) {
			UserInfo validUser = userManagerService.getUserInfoByName(username);
			String userBelongTo = validUser.getUserBelongTo();

			switch (Integer.parseInt(userBelongTo)) {
			// orgid
			case 1:
				validUser.setUserBelongName("防火单位");
				validUser.setCompanyName(userManagerService.getOnlineorgById(validUser.getOrgID()));
				break;
			case 2:
				validUser.setUserBelongName("维保单位");
				validUser.setCompanyName(userManagerService.getMaintenanceById(validUser.getMaintenanceId()));
				break;
			case 3:
				validUser.setUserBelongName("管理机构");
				validUser.setCompanyName(userManagerService.getManagerOrgById(validUser.getManagerOrgID()));
				break;
			case 4:
				validUser.setUserBelongName("系统管理员");
				break;
			default:
				break;
			}

			Map<String, Object> validUserMap = new HashMap<String, Object>();
			validUserMap.put("UserBelongTo", validUser.getUserBelongTo());
			validUserMap.put("userBelongName", validUser.getUserBelongName());
			validUserMap.put("usertype", validUser.getUsertype());
			validUserMap.put("account", validUser.getAccount());
			validUserMap.put("RealName", validUser.getRealName());
			validUserMap.put("OrgID", validUser.getOrgID());
			validUserMap.put("CompanyName", validUser.getCompanyName());
			System.out.println(JSONObject.fromBean(validUserMap).toString());
			List<Ztree> ztrees = userManagerService.retrieveZtreeNodes(username);
			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

			for (Ztree ztree : ztrees) {
				Map<String, Object> ztreeMap = new HashMap<String, Object>();
				ztreeMap.put("ModuleID", ztree.getModuleID());
				ztreeMap.put("ModuleName", ztree.getModuleName());
				ztreeMap.put("URL", ztree.getuRL());
				ztreeMap.put("OrderNum", ztree.getOrderNum());
				ztreeMap.put("ParentID", ztree.getParentID());
				ztreeMap.put("levelnum", ztree.getLevelnum());
				ztreeMap.put("pic", ztree.getPic());
				List<Map<String, String>> childModuleMapList = new ArrayList<Map<String, String>>();

				for (ChildModule childModule : ztree.getDKZTree()) {
					Map<String, String> childModuleMap = new HashMap<String, String>();
					childModuleMap.put("ModuleID", childModule.getModuleID());
					childModuleMap.put("ModuleName", childModule.getModuleName());
					childModuleMap.put("URL", childModule.getuRL());
					childModuleMap.put("OrderNum", childModule.getOrderNum());
					childModuleMap.put("ParentID", childModule.getModuleID());
					childModuleMap.put("levelnum", childModule.getLevelnum());
					childModuleMap.put("pic", childModule.getPic());
					childModuleMapList.add(childModuleMap);
				}
				ztreeMap.put("DKZTree", childModuleMapList);

				list.add(ztreeMap);
			}
			dataBag.put("userInfo", validUserMap);
			dataBag.put("ztree", list);
			statusCode = ConstValues.OK;
			list=null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;

		}

		return ResponseJson.responseFindJson(dataBag, statusCode);
	}

}
