package com.hhgx.soft.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.hhgx.soft.entitys.Page;
import com.hhgx.soft.entitys.Users;
import com.hhgx.soft.services.UsersService;
import com.hhgx.soft.utils.ConstValues;
import com.hhgx.soft.utils.RequestJson;
import com.hhgx.soft.utils.ResponseJson;

@Controller
@RequestMapping(value="/Users")
public class UsersController {
	@Autowired
	private UsersService usersService;
	
	
	/**
	 * 53获取用户列表【**】【分页】
	 * @param reqBody
	 * @return
	 * @throws JsonProcessingException
	 */
	@ResponseBody
	@RequestMapping(value = "/GetUserList", method = {
			RequestMethod.POST }, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String getUserList(@RequestBody String reqBody) throws JsonProcessingException {
		Map<String, String> map = RequestJson.reqJson(reqBody, "orgid","UserBelongTo", "PageIndex");
		String orgid = map.get("orgid");
		String pageIndex = map.get("pageIndex");
		String userBelongTo = map.get("userBelongTo");

		Page page = null;
		List<Users> userList = null;
		List<Map<String, String>> lmList = new ArrayList<Map<String, String>>();
		int totalCount = usersService.getUserListCount(orgid, userBelongTo);
		int statusCode = -1;

		try {
			if (pageIndex != null) {
			page = new Page(totalCount, Integer.parseInt(pageIndex));
			userList = usersService.getUserList(orgid, userBelongTo, page.getStartPos(), page.getPageSize());

			} else {
			page = new Page(totalCount, 1);
			userList  = usersService.getUserList(orgid, userBelongTo, page.getStartPos(), page.getPageSize());
			}
			for (Users users : userList ) {

				Map<String, String> map2 = new HashMap<String, String>();
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
		return ResponseJson.responseFindPageJson(lmList, statusCode, totalCount);
	}
	
	/**
	 * 54.修改用户信息【**】
	 */
	@ResponseBody
	@RequestMapping(value = "/UpdateUser", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String updateUser(@RequestBody String reqBody) throws JsonProcessingException {
		Map<String, String> map = RequestJson.reqJson(reqBody, "Userid", "RealName", "mobilephone", "tel", "Email","Status","Remark","UserTypeID");
		Users users = new Users();
		users.setUserid(map.get("userid"));
		users.setMobilephone(map.get("mobilephone"));
		users.setRealName(map.get("realName"));
		users.setStatus(map.get("tel"));
		users.setTel(map.get("email"));
		users.setStatus(map.get("status"));
		users.setUserTypeName(map.get("remark"));
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
			dataBag = "修改成功";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		} else {
			dataBag = "修改失败";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		}
	}
	/**
	 * 55.删除用户信息【**】
	 */
	@ResponseBody
	@RequestMapping(value = "/DeleteUser", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	public String deleteUser(@RequestBody String reqBody) throws JsonProcessingException {

		Map<String, String> map = RequestJson.reqJson(reqBody, "Userid");
		String userCheckId = map.get("userid");
		String dataBag = null;
		int statusCode = -1;
		try {
			/// 删除
			statusCode = ConstValues.OK;
		} catch (Exception e) {
			statusCode = ConstValues.FAILED;
		}
		if (statusCode == ConstValues.OK) {
			dataBag = "刪除成功";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		} else {
			dataBag = "刪除失败";
			return ResponseJson.responseAddJson(dataBag, statusCode);
		}

	}

		
}
