package com.hhgx.soft.mappers;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

import com.hhgx.soft.entitys.XfCheckTimeRound;

@MapperScan
@Component("xfCheckTimeRoundMapper")
public interface XfCheckTimeRoundMapper {

	List<XfCheckTimeRound> findAllXfCheckTimeRound();

	List<XfCheckTimeRound> findByIdXfCheckTimeRound(int id);

	void addXfCheckTimeRound(XfCheckTimeRound xfCheckTimeRound);

	void updateXfCheckTimeRound(XfCheckTimeRound xfCheckTimeRound);

}
