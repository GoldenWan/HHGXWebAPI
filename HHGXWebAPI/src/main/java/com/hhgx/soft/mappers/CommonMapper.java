package com.hhgx.soft.mappers;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.Dictionary;

@MapperScan
@Component
public interface CommonMapper {

	List<Dictionary> getDictionaryByTypeName(String typeName);

}
