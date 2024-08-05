package com.dkitec.barocle.admin.statistics.join.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.statistics.join.service.JoinStatisticsMapper;
import com.dkitec.barocle.admin.statistics.join.service.JoinStatisticsService;
import com.dkitec.barocle.admin.statistics.join.vo.JoinStatisticsVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="joinStatisticsService")
public class JoinStatisticsServiceImpl extends EgovAbstractServiceImpl implements JoinStatisticsService {

	@Autowired private JoinStatisticsMapper joinStatisticsMapper;

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.STATICS)
	public List<JoinStatisticsVO> getMemJoinList(JoinStatisticsVO joinStatisticsVo) {
		// TODO Auto-generated method stub
		return joinStatisticsMapper.getMemJoinList(joinStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.STATICS)
	public List<JoinStatisticsVO> getUseMiniBikeList(JoinStatisticsVO joinStatisticsVo) {
		// TODO Auto-generated method stub
		return joinStatisticsMapper.getUseMiniBikeList(joinStatisticsVo);
	}
	
}