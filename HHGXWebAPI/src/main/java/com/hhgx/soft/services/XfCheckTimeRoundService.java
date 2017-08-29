package com.hhgx.soft.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hhgx.soft.entitys.XfCheckTimeRound;
import com.hhgx.soft.mappers.XfCheckTimeRoundMapper;


@Service
@Transactional
public class XfCheckTimeRoundService {
	@Autowired
	private XfCheckTimeRoundMapper xfCheckTimeRoundMapper;
	public List<XfCheckTimeRound> findAllXfCheckTimeRound() {
		return xfCheckTimeRoundMapper.findAllXfCheckTimeRound();
	}
	public List<XfCheckTimeRound> findByIdXfCheckTimeRound(int id) {
		return xfCheckTimeRoundMapper.findByIdXfCheckTimeRound( id);
	}
	public void addXfCheckTimeRound(XfCheckTimeRound xfCheckTimeRound) {
		 xfCheckTimeRoundMapper.addXfCheckTimeRound(xfCheckTimeRound);		
	}
	public void updateXfCheckTimeRound(XfCheckTimeRound xfCheckTimeRound) {
		 xfCheckTimeRoundMapper.updateXfCheckTimeRound(xfCheckTimeRound);			
	}

}
