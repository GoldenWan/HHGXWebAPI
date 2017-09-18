package com.hhgx.soft.services;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.mappers.OrgandpeopleMapper;

@Service
public class OrgandpeopleService {
@Autowired
private OrgandpeopleMapper organdpeopleMapper;
	public int getEquipmentListCount(String orgid) {
		return organdpeopleMapper.getEquipmentListCount(orgid);
	}

	public List<Map<String, String>> getEquipmentList(String orgid, int startPos, int pageSize) {
		return organdpeopleMapper.getEquipmentList(orgid,startPos,pageSize);
	}

	public List<String> getEquipmentType() {
		return organdpeopleMapper.getEquipmentType();
	}

	public void addEquipment(Map<String, String> map) {
		 organdpeopleMapper.addEquipment(map);
	}

	public void deleteEquipment(String equipmentID) {
		organdpeopleMapper.deleteEquipment(equipmentID);
	}

	public void updateequipment(Map<String, String> map) {
		organdpeopleMapper.updateequipment(map);
	}

	public List<Map<String, String>> getequipmentdetail(String equipmentID) {
		return organdpeopleMapper.getequipmentdetail(equipmentID);
	}

}
