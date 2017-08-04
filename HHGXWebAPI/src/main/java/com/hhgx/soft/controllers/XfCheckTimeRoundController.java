package com.hhgx.soft.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hhgx.soft.entitys.XfCheckTimeRound;
import com.hhgx.soft.services.XfCheckTimeRoundService;



@Controller
@RequestMapping("/xfCheckTimeRound")
public class XfCheckTimeRoundController {
	@Autowired
	XfCheckTimeRoundService xfCheckTimeRoundService;

	@RequestMapping(value = "/findAll", method = { RequestMethod.POST, RequestMethod.GET }, produces = "text/html;charset=UTF-8")
	public @ResponseBody String findAllCategory(HttpServletRequest request,HttpServletResponse response, Model model) throws JsonProcessingException {
		List<XfCheckTimeRound>  xfCheckTimeRounds = xfCheckTimeRoundService.findAllXfCheckTimeRound();
		Map<String, Object> params = new HashMap<String, Object>();
		ObjectMapper mapper = new ObjectMapper();  
		params.put("DataBag", xfCheckTimeRounds);
		params.put("StatusCode",1000);
		return mapper.writeValueAsString(params);
	}
	
	
	@RequestMapping(value = "/findById", method = { RequestMethod.POST, RequestMethod.GET },produces = "text/html;charset=UTF-8")
	public @ResponseBody String  findByIdCategory(HttpServletRequest request, Model model) throws JsonProcessingException {
		Map<String, Object> params = new HashMap<String, Object>();
		List<XfCheckTimeRound> listXf =xfCheckTimeRoundService.findByIdXfCheckTimeRound(Integer.parseInt(request.getParameter("id")));
		ObjectMapper mapper = new ObjectMapper();  
		params.put("DataBag", listXf);
		params.put("StatusCode",1000);
		return mapper.writeValueAsString(params);
	}
	
	@RequestMapping(value = "/add", method = { RequestMethod.POST, RequestMethod.GET },produces = "text/html;charset=UTF-8")
	public  @ResponseBody String add( HttpServletRequest request) throws JsonProcessingException {
		
		//xfCheckTimeRoundService.addXfCheckTimeRound(xfCheckTimeRound);
		Map<String, Object> params = new HashMap<String, Object>();
		ObjectMapper mapper = new ObjectMapper();  
		params.put("DataBag", null);
		params.put("StatusCode",1000);
		return mapper.writeValueAsString(params);
	}
	
	
	
	@RequestMapping(value = "/update", method = { RequestMethod.POST, RequestMethod.GET },produces = "text/html;charset=UTF-8")
	public  @ResponseBody String update(@RequestBody XfCheckTimeRound	xfCheckTimeRound, HttpServletRequest request) throws JsonProcessingException {
	
		xfCheckTimeRoundService.updateXfCheckTimeRound(xfCheckTimeRound);
		Map<String, Object> params = new HashMap<String, Object>();
		ObjectMapper mapper = new ObjectMapper();  
		params.put("DataBag", null);
		params.put("StatusCode",1000);
		return mapper.writeValueAsString(params);
	}
	
		

}
