package com.dkitec.barocle.admin.statistics.join.service;

import java.util.List;

import com.dkitec.barocle.admin.statistics.join.vo.JoinStatisticsVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("joinStatisticsMapper")
public interface JoinStatisticsMapper {

	List<JoinStatisticsVO> getMemJoinList(JoinStatisticsVO joinStatisticsVo);

	List<JoinStatisticsVO> getUseMiniBikeList(JoinStatisticsVO joinStatisticsVo);
	
}
	