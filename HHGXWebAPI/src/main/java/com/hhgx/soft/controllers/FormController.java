package com.hhgx.soft.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping(value="/Form")
@Controller
public class FormController {

	@ResponseBody
	@RequestMapping(value = "/AddUserCheckList", method = RequestMethod.POST, consumes = "application/json;charset=UTF-8", produces = "application/json;charset=UTF-8")
	
	public String addOrUpdateCheckRecord(){
		
		
		
		return null;
	}
}
