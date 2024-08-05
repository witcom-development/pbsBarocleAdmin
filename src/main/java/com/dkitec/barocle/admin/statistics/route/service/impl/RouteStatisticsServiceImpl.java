package com.dkitec.barocle.admin.statistics.route.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.statistics.route.service.RouteStatisticsMapper;
import com.dkitec.barocle.admin.statistics.route.service.RouteStatisticsService;
import com.dkitec.barocle.admin.statistics.route.vo.RouteStatisticsVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="routeStatisticsService")
public class RouteStatisticsServiceImpl extends EgovAbstractServiceImpl implements RouteStatisticsService {

	@Autowired private RouteStatisticsMapper routeStatisticsMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<RouteStatisticsVO> getRouteDataList(RouteStatisticsVO routeStatisticsVo){
		// TODO Auto-generated method stub
		return routeStatisticsMapper.getRouteDataList(routeStatisticsVo);
	}
}