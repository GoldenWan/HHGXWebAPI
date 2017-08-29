package com.hhgx.soft.mappers;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;
@Component
@MapperScan
public interface ExtraMapper {

	void deleteManoeuvre(String manoeuvreID);
	

}
