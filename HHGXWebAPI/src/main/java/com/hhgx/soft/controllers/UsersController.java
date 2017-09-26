package com.hhgx.soft.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hhgx.soft.entitys.Page;
import com.hhgx.soft.entitys.User;
import com.hhgx.soft.entitys.Users;
import com.hhgx.soft.services.UsersService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.GetRequestJsonUtils;
import com.hhgx.soft.utils.Md5Util;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;
import com.hhgx.soft.utils.UUIDGenerator;

@Controller
@RequestMapping(value="/Users")
public class UsersController {
	@Autowired
	private UsersService usersService;
	
	
	/**
	 * 53获取用户列表【**】【分页】
	 * @param reqBody
	 * @return
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/GetUserList", method = {
			RequestMethod.POST })
	public String getUserList(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "orgid","UserBelongTo","userName", "PageIndex");
		String orgid = map.get("orgid");
		String pageIndex = map.get("pageIndex");
		String userBelongTo = map.get("userBelongTo");
		String userName = map.get("userName");
		
		/*if(StringUtils.isEmpty(orgid)){
			return ResponseJson.responseAddJson("orgid为空", -2);
		}*/
		
		Page page = null;
		List<Users> userList = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		int totalCount = usersService.getUserListCount(orgid, userBelongTo,userName);
		int statusCode = -1;
		
		
	
		try {
			
			
			if (pageIndex != null) {
			page = new Page(totalCount, Integer.parseInt(pageIndex));
			userList = usersService.getUserList(orgid, userBelongTo,userName, page.getStartPos(), page.getPageSize());

			} else {
			page = new Page(totalCount, 1);
			userList  = usersService.getUserList(orgid, userBelongTo,userName, page.getStartPos(), page.getPageSize());
			}
			for (Users users : userList ) {
		     
				Map<String, String> map2 = new HashMap<String, String>();
		        map2.put("UserID",users.getUserid());
				map2.put("account",users.getAccount());
				map2.put("RealName",users.getRealName());
				map2.put("mobilephone",users.getMobilephone());
				map2.put("tel" ,users.getTel());
				map2.put("Status" ,users.getStatus());
				map2.put("UserTypeName",users.getUserTypeName());
				lmList.add(map2);
			}
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindPageJsonArray(lmList, statusCode, totalCount);
	}
	/**
	 *83.添加用户信息
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/AddUser", method = RequestMethod.POST)
	public String addUser(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "account","password", "RealName", "mobilephone", "tel", "Email","Status","Remark","UserTypeID","UserBelongTo","orgid");
	
		String userName =map.get("account");
		String userBelongTo =map.get("userBelongTo");
		String orgid = map.get("orgid");
		User users = new User();
		users.setUserID(UUIDGenerator.getUUID());
		users.setAccount(userName);
		users.setPassword(Md5Util.getMD5(map.get("password")));
		users.setMobilephone(map.get("mobilephone"));
		users.setRealName(map.get("realName"));
		users.setTel(map.get("tel"));
		users.setEmail(map.get("email"));
		users.setStatus(map.get("status"));
		users.setRemark(map.get("remark"));
		users.setUserTypeID(map.get("userTypeID"));
		users.setUserBelongTo(userBelongTo);
		users.setOrgid(orgid);
		String dataBag = null;
		int statusCode = -1;
		try {
			if(usersService.existUserName(userName)){
				return ResponseJson.responseAddJson("账号已存在,请重新输入", -2);
			}
			usersService.addUser(users);
			dataBag = ConstValues.SUCCESS;
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			dataBag = ConstValues.FIALURE;
			statusCode = ConstValues.FAILED;
		}
		
		return ResponseJson.responseAddJson(dataBag, statusCode);
		
	}
	/**
	 * 54.修改用户信息【**】
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/UpdateUser", method = RequestMethod.POST)
	public String updateUser(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "Userid", "RealName", "mobilephone", "tel", "Email","Status","Remark","UserTypeID");
		Users users = new Users();
		users.setUserid(map.get("userid"));
		users.setMobilephone(map.get("mobilephone"));
		users.setRealName(map.get("realName"));
		users.setTel(map.get("tel"));
		users.setEmail(map.get("email"));
		users.setStatus(map.get("status"));
		users.setRemark(map.get("remark"));
		users.setUserTypeID(map.get("userTypeID"));
		
		String dataBag = null;
		int statusCode = -1;
		try {
			usersService.updateUser(users);
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			statusCode = ConstValues.FAILED;
		}
		if (statusCode == ConstValues.OK) {
			dataBag = ConstValues.SUCCESS_;
			return ResponseJson.responseAddJson(dataBag, statusCode);
		} else {
			dataBag = ConstValues.FIALURE_;
			return ResponseJson.responseAddJson(dataBag, statusCode);
		}
	}
	/**
	 * 55.删除用户信息【**】
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/DeleteUser", method = RequestMethod.POST)
	public String deleteUser(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);

		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "Userid");
		String userid = map.get("userid");
		String dataBag = null;
		int statusCode = -1;
		try {
			usersService.deleteUser(userid);
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			statusCode = ConstValues.FAILED;
		}
		if (statusCode == ConstValues.OK) {
			dataBag = ConstValues.SUCCESSDEL;
			return ResponseJson.responseAddJson(dataBag, statusCode);
		} else {
			dataBag = ConstValues.FIALUREDEL;
			return ResponseJson.responseAddJson(dataBag, statusCode);
		}

	}
	
	/**
	 *82.根据用户类别获取用户类型 
	 */
	
	@ResponseBody
	@RequestMapping(value = "/GetUserType", method = RequestMethod.POST)
	public String getUserType(HttpServletRequest request) throws IOException {
		List<Map<String, String>> lmList =null;

		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "UserBelongTo");
		String userBelongTo = map.get("userBelongTo");
		int statusCode = -1;
		try {
			
			lmList = usersService.getUserType(userBelongTo);
			
			statusCode = ConstValues.OK;
			
		} catch (Exception e) {
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(lmList, statusCode);
	}
		/**
		 * 57.获取防火单位列表信息
		 */
	@ResponseBody
	@RequestMapping(value = "/GetUser", method = RequestMethod.POST)
	public String getUser(HttpServletRequest request) throws IOException {
		String reqBody = GetRequestJsonUtils.getRequestPostStr(request);
		Map<String, String> map = RequestJson.reqFirstLowerJson(reqBody, "Userid");
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		Map<String, String> map2 = new HashMap<String, String>();
		String userid = map.get("userid");
		if(StringUtils.isEmpty(userid)){
		    return ResponseJson.responseAddJson("userid 为空", -256);	
			}
		int statusCode = -1;
		try {
			   User user = usersService.getUser(userid);
				map2.put("UserID"      , user.getUserID());
				map2.put("account"     , user.getAccount());
				map2.put("RealName"    , user.getRealName());
				map2.put("mobilephone" , user.getMobilephone());
				map2.put("Tel"         , user.getTel());
				map2.put("Email"       , user.getEmail());
				map2.put("Status"      , user.getStatus());
				map2.put("Remark"      , user.getRemark());
				map2.put("UserTypeID"  , user.getUserTypeID());
				map2.put("UserTypeName", user.getUserTypeName());
				lmList.add(map2);
				statusCode = ConstValues.OK;
			
		} catch (Exception e) {
			e.printStackTrace();
			statusCode = ConstValues.FAILED;
		}
		return ResponseJson.responseFindJsonArray(lmList, statusCode);
	}
	

}
