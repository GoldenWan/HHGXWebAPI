package com.hhgx.soft.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hhgx.soft.entitys.RegisterNew;
import com.hhgx.soft.entitys.User;
import com.hhgx.soft.entitys.UserInfo;
import com.hhgx.soft.entitys.Ztree;
import com.hhgx.soft.mappers.UserManagerOrgMapper;

@Service
public class UserManagerService {
	@Autowired
	private UserManagerOrgMapper userManagerMapper;

	public User loginBy(String username, String password) {
		return userManagerMapper.loginBy(username, password);
	}

	public boolean registerNew(RegisterNew registerNew, String userBelongTo) {
		int temp = 1;
		try {
			
		if (userBelongTo.equals("1")) {
			registerNew.setUsertypeID("Orgmanager");
			userManagerMapper.onlineorgRegister(registerNew);
		} else if (userBelongTo.equals("2")) {
			registerNew.setUsertypeID("maintenancemanager");
			userManagerMapper.maintenanceRegister(registerNew);
			System.err.println(registerNew.toString());
		} else {
			temp = -1;
		}
		if (temp > 0) {
			userManagerMapper.usersRegister(registerNew);
		}
		} catch (Exception e) {
			e.printStackTrace();
			temp = -1;
		}
		return temp > 0 ? true : false;
	}

	public boolean findAccount(String username) {
		int temp = userManagerMapper.findAccount(username);
		return temp > 0 ? true : false;
	}

	public String getUserTypeName(String userTypeID) {
		return userManagerMapper.getUserTypeName(userTypeID);
	}

	public String findMaxBack6(String areaID) {
		return userManagerMapper.findMaxBack6(areaID);
	}

	public UserInfo getUserInfoByName(String username) {
		return userManagerMapper.getUserInfoByName(username);
	}

	
	public List<Ztree> retrieveZtreeNodes(String tokenUUID) {
		
		return userManagerMapper.retrieveZtreeNodes(tokenUUID);
	}

	public String getOnlineorgById(String orgID) {
		return userManagerMapper.getOnlineorgById(orgID);
	}

	public String getMaintenanceById(String maintenanceId) {
		return userManagerMapper.getMaintenanceById(maintenanceId);
	}

	public String getManagerOrgById(String managerOrgID) {
		return userManagerMapper.getManagerOrgById(managerOrgID);
	}

}
