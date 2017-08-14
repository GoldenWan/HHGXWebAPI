package com.hhgx.soft.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.entitys.OnDutyRecord;
import com.hhgx.soft.mappers.OnDutyRecordMapper;

@Service
public class OnDutyRecordService {
	
	@Autowired
	private OnDutyRecordMapper onDutyRecordMapper ;
	public void addOnDutyRecord(OnDutyRecord addOnDutyRecord) {
		onDutyRecordMapper.addOnDutyRecord(addOnDutyRecord);
	}
	public void editOnDutyRecordInfo(OnDutyRecord onDutyRecord) {
		// TODO Auto-generated method stub
		
	}

}
