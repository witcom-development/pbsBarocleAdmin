package com.dkitec.barocle.admin.statistics.route.service;

import java.util.List;

import com.dkitec.barocle.admin.statistics.route.vo.RouteStatisticsVO;


public interface RouteStatisticsService {
	
	List<RouteStatisticsVO> getRouteDataList(RouteStatisticsVO routeStatisticsVo);
	
}
