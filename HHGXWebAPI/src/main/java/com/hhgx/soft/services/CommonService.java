package com.hhgx.soft.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hhgx.soft.entitys.Dictionary;
import com.hhgx.soft.mappers.CommonMapper;

@Service
@Transactional
public class CommonService {
	
	@Autowired
	private CommonMapper commonMapper;

	public List<Dictionary> getDictionaryByTypeName(String typeName) {
		// TODO Auto-generated method stub
		return commonMapper.getDictionaryByTypeName(typeName);
	} 

}
