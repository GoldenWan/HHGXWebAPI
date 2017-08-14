package com.hhgx.soft.mappers;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.OnDutyRecord;
@Component
@MapperScan("onDutyRecordMapper")
public interface OnDutyRecordMapper {

	void addOnDutyRecord(OnDutyRecord addOnDutyRecord);

}
