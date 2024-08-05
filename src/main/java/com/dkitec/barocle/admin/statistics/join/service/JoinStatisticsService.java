package com.dkitec.barocle.admin.statistics.join.service;

import java.util.List;

import com.dkitec.barocle.admin.statistics.join.vo.JoinStatisticsVO;


public interface JoinStatisticsService {

	List<JoinStatisticsVO> getMemJoinList(JoinStatisticsVO joinStatisticsVo);

	List<JoinStatisticsVO> getUseMiniBikeList(JoinStatisticsVO joinStatisticsVo);
	
}
