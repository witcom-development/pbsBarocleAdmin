package com.dkitec.barocle.admin.statistics.route.service;

import java.util.List;

import com.dkitec.barocle.admin.statistics.route.vo.RouteStatisticsVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("routeStatisticsMapper")
public interface RouteStatisticsMapper {

	List<RouteStatisticsVO> getRouteDataList(RouteStatisticsVO routeStatisticsVo);
	
}
	