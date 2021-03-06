package com.hhgx.soft.controllers;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
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
import com.hhgx.soft.utils.GetRequestJsonUtils;
import com.hhgx.soft.utils.Md5Util;
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
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value = "/RegisterNew", method = { RequestMethod.POST })
	public String registerNew(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> m = RequestJson.reqFirstLowerJson(reqBody, "username", "password", "orgname", "AreaID",
				"verifycode", "UserBelongTo");
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
		registerNew.setPassword(Md5Util.getMD5(password));
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
			StringBuilder sBuilder = new StringBuilder(String.valueOf(neworgid_));
			for(int len =sBuilder.length();len<6;len++){
				sBuilder.insert( 0 , "0" ); 
			}
			
			orgid = areaID + sBuilder.toString();
		}
		registerNew.setOrgid(orgid);
		String number = (String) request.getSession().getAttribute("number");

		String dataBag = null;
		int code = -1;
		int statusCode = -1;

		/*
		 * if (StringUtils.isEmpty(userBelongTo) || userBelongTo == "0") {
		 * statusCode = ConstValues.; dataBag = "请选择用户类型"; return
		 * ResponseJson.responseAddJson(dataBag, statusCode);
		 * 
		 * } else if (StringUtils.isEmpty(username)) { statusCode =
		 * ConstValues.; dataBag = "请输入手机号"; return
		 * ResponseJson.responseAddJson(dataBag, statusCode); }
		 */
		if (StringUtils.isEmpty(verifycode)) {
			statusCode = ConstValues.NOAUTHORIZED;
			code = 2;
			dataBag = "验证码为空，请先获取验证码";
			return ResponseJson.responseRegistJson(code, dataBag, statusCode);

		} else if (!verifycode.equals(number)) {
			statusCode = ConstValues.NOAUTHORIZED;
			code = 3;
			dataBag = "验证码不正确";
			return ResponseJson.responseRegistJson(code, dataBag, statusCode);

		} /*
			 * else if (StringUtils.isEmpty(orgname)) { statusCode =
			 * ConstValues.; dataBag = "请输入公司名"; return
			 * ResponseJson.responseAddJson(dataBag, statusCode); } else if
			 * (StringUtils.isEmpty(password)) { statusCode = ConstValues.;
			 * dataBag = "请输入密码"; return ResponseJson.responseAddJson(dataBag,
			 * statusCode); }
			 */
		else if (userManagerService.findAccount(username)) {
			statusCode = ConstValues.NOAUTHORIZED;
			code = 1;
			dataBag = "已经有这个用户了 请更换手机号";

			return ResponseJson.responseRegistJson(code, dataBag, statusCode);
		} else {
			
			if (userManagerService.registerNew(registerNew, userBelongTo)) {
				dataBag = ConstValues.SUCCESS;
				statusCode = ConstValues.OK;
				return ResponseJson.responseRegistJson(code, dataBag, statusCode);
			} else {
				dataBag = "注册失败";
				statusCode = ConstValues.FAILED;
			}
			return ResponseJson.responseRegistJson(code, dataBag, statusCode);
		}
	}

	/**
	 * 158. 短信发送
	 * 
	 * @throws IOException
	 */

	@ResponseBody
	@RequestMapping(value = "/RegistMessage", method = { RequestMethod.POST })
	public String registMessage(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "UserPoneNo");
		System.out.println(map.get("userPoneNo"));
		// 设置短信内容参数
		String userPoneNo = map.get("userPoneNo");
		String smsFreeSignName = "恒华光迅H";
		String smsTemplateCode = "SMS_83185001";
		int number = CommonMethod.getRandNum(100000, 999999);
		String smsParamJson = "{\"number\":\"" + number + "\"}";
		int ret = -256;
		String dataTag = null;
		// 发短信
		try {
			SendSmsResponse response = RegistMessage.sendSms(smsFreeSignName, smsTemplateCode, smsParamJson,
					userPoneNo);
			System.out.println(response.getCode());
			System.out.println(response.getCode().equals("OK"));
			if (response.getCode().equals("OK") && response.getMessage().equals("OK")) {
				ret = 1000;
				dataTag = "短信发送成功";
				request.getSession().setAttribute("number", String.valueOf(number));
			} else {
				ret = -256;
				dataTag = "短信发送失败";
			}

		} catch (ClientException e) {
			e.printStackTrace();
			ret = -256;
			dataTag = "短信发送失败";
		}

		JSONObject result = new JSONObject();

		result.put("DataBag", dataTag);
		result.put("StateMessage", ret);
		return result.toString();

	}
	/****************** 登录 ****************************/

	/**
	 * 2.用户登录  * @return  * @throws JsonProcessingException:TODO  
	 * 
	 * @throws JsonProcessingException
	 * @throws UnsupportedEncodingException
	 */

	@ResponseBody
	@RequestMapping(value = "/LoginBy", method = { RequestMethod.GET })
	public String loginBy(HttpServletRequest request) throws JsonProcessingException, UnsupportedEncodingException {
		String sessionCode = (String) request.getSession().getAttribute("certCode");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String code = request.getParameter("code");
		int statusCode = 0;
		String dataBag = null;

		if (StringUtils.isEmpty(username) || !userManagerService.findAccount(username)) {
			statusCode = ConstValues.NOAUTHORIZED;
			dataBag = "没有用户 请注册";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		}

		else if (StringUtils.isEmpty(code) || !code.equalsIgnoreCase(sessionCode)) {
			statusCode = ConstValues.ERROR;
			int code_ =2;
			String message="您输入的验证码不正确!";
			return ResponseJson.responseLoginJson(code_,message, statusCode);
		}

		else {
			User user = userManagerService.loginBy(username, Md5Util.getMD5(password));
			if (user != null) {
				request.setAttribute("UserID", user.getUserID());
				String userTypeName = userManagerService.getUserTypeName(user.getUserTypeID());
				statusCode = ConstValues.OK;
				Map<String, String> map = new HashMap<String, String>();
				map.put("message", "登录成功 欢迎回来[" + user.getAccount() + "]," + userTypeName);
				map.put("tokenID", user.getUserID());
				// String content = JSONObject.fromBean(map).toString();

				return ResponseJson.responseFindJson(map, statusCode);
			} else {
				statusCode = ConstValues.ERROR;
				int code_ =3;
				String message="密码错误 找回密码?";
				return ResponseJson.responseLoginJson(code_, message, statusCode);
			}

			/**
			 * 
			 * {"StateMessage":-1,"DataBag":"没有用户 请先注册"} { "DataBag": "没有用户 请注册"
			 * , "StateMessage": -1 } { "DataBag": { "message":
			 * "登录成功 欢迎回来[18866668888],防火单位管理员", "tokenID":
			 * "6e2cda35-2a40-4c44-8b3a-d8d3817e9a6d" }, "StateMessage": 1000 }
			 */
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
		// Color.Blue, Color.DarkRed, 1.2f

		Color c = new Color(255, 251, 255);// 产生颜色
		g.setColor(c);// 对图像设置颜色
		g.fillRect(0, 0, 68, 22);// 填充图片
		// 向图片输出数字和字母
		StringBuffer sb = new StringBuffer();
		// 字符数组
		char[] ch = "abcdefghixyz023DFGHJKLZXCVBNM456jkmnopqstuvw789QWERTYUOPAS".toCharArray();
		int index, len = ch.length;
		Random r = new Random();
		for (int i = 0; i < 4; i++) {// 产生四个字符
			index = r.nextInt(len);// 从字符流中输出下一个字符----产生一个字符
			g.setColor(new Color(r.nextInt(66), r.nextInt(155), r.nextInt(255)));
			// 输出字体和大小
			g.setFont(new Font("Arial", Font.BOLD | Font.ITALIC, 14));
			// 写什么数字，在在图片的什么位子画
			g.drawString("" + ch[index], (i * 15) + 3, 18);// 迭代器，位置x,位置y
			sb.append(ch[index]);
		}
		g.setColor(new Color(r.nextInt(66), r.nextInt(155), r.nextInt(255)));
		Graphics gg = img.getGraphics();
		gg.setColor(new Color(r.nextInt(66), r.nextInt(155), r.nextInt(255)));
		gg.setFont(new Font("Arial", Font.ITALIC , 1));

		/*
	// 绘制干扰线
	//	for (int i = 0; i <2; i++) {
			int x = r.nextInt(width)+56;
			int y = r.nextInt(height)+5;
			int x1 = r.nextInt(1);
			int y1 = r.nextInt(height);
			gg.drawLine(x1, y1, x, y);
	//}*/
		for (int i = 0; i <35; i++) {
			int xx = r.nextInt(width);
			int yy = r.nextInt(height);
			g.drawOval(xx, yy, 1, 1);
			}
		//画出随机点

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
	 * 
	 * [Description("SLS:根据用户账号获取模块列表")] [HttpPost] public string
	 * RetrieveZtreeNodes() { //这里应该根据token统一检查用户令牌是否过期 var validUser =
	 * LinqDBContext.Users .Where(o => o.UserID.Equals(tokenid)) .Select(o =>
	 * o).SingleOrDefault();
	 * 
	 * // 3.成功登录 3.1获取ZTree 3.2 //T-SQL:[获取ZTree侧边栏]  
	 * 
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value = "/RetrieveZtreeNodes", method = { RequestMethod.POST })
	public String retrieveZtreeNodes(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		JSONObject map = JSONObject.fromObject(reqBody);
		String tokenUUID = (String) map.get("tokenUUID");
		Map<String, Object> dataBag = new HashMap<String, Object>();
		int statusCode = -1;
		try {
			if (!tokenUUID.equals(null)) {
					Map<String, Object> validUserMap = new HashMap<String, Object>();

				UserInfo validUser = userManagerService.getUserInfoByName(tokenUUID);
				if (!StringUtils.isEmpty(validUser)) {
					String userBelongTo = validUser.getUserBelongTo();

					switch (Integer.parseInt(userBelongTo)) {
					case 1:
						validUser.setUserBelongName("防火单位");
						validUser.setCompanyName(userManagerService.getOnlineorgById(validUser.getOrgID()));
						validUserMap.put("OrgID", validUser.getOrgID());
						break;
					case 2:
						validUser.setUserBelongName("维保单位");
						validUser.setCompanyName(userManagerService.getMaintenanceById(validUser.getMaintenanceId()));
						validUserMap.put("OrgID",validUser.getMaintenanceId());
						break;
					case 3:
						validUser.setUserBelongName("管理机构");
						validUser.setCompanyName(userManagerService.getManagerOrgById(validUser.getManagerOrgID()));
						validUserMap.put("OrgID", validUser.getManagerOrgID());
						break;
					case 4:
						validUser.setUserBelongName("系统管理员");
						validUserMap.put("OrgID", "");
						break;
					default:
						validUserMap.put("OrgID", validUser.getOrgID());
						break;
					}
			
					validUserMap.put("UserBelongTo", validUser.getUserBelongTo());
					validUserMap.put("UserBelongName", validUser.getUserBelongName());
					validUserMap.put("usertype", validUser.getUsertype());
					validUserMap.put("account", validUser.getAccount());
					validUserMap.put("RealName", validUser.getRealName());
					validUserMap.put("CompanyName", validUser.getCompanyName());
					validUserMap.put("HeaderPic", validUser.getHeaderPic());
					System.out.println(JSONObject.fromBean(validUserMap).toString());
					List<Ztree> ztrees = userManagerService.retrieveZtreeNodes(tokenUUID);
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

				}
				statusCode = ConstValues.OK;
			}
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;

		}

		return ResponseJson.responseFindJson(dataBag, statusCode);
	}

}
