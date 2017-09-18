package com.hhgx.soft.mappers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

@Component
@MapperScan
public interface OrgandpeopleMapper {

	int getEquipmentListCount(String orgid);

	List<Map<String, String>> getEquipmentList(@Param("orgid")String orgid, @Param("startPos")int startPos, @Param("pageSize")int pageSize);

	List<String> getEquipmentType();

	void addEquipment(Map<String, String> map);

	void deleteEquipment(String equipmentID);

	void updateequipment(Map<String, String> map);

	List<Map<String, String>> getequipmentdetail(String equipmentID);

	
	
}
