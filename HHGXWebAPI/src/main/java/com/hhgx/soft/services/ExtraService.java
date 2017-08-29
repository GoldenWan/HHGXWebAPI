package com.hhgx.soft.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.mappers.ExtraMapper;

@Service
public class ExtraService {
	
	@Autowired
	private ExtraMapper extraMapper;

	
	public void deleteManoeuvre(String manoeuvreID) {
	extraMapper.deleteManoeuvre(manoeuvreID);	
	}

}
