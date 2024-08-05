package com.dkitec.barocle.admin.statistics.group.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.statistics.group.service.GroupStatisticsMapper;
import com.dkitec.barocle.admin.statistics.group.service.GroupStatisticsService;
import com.dkitec.barocle.admin.statistics.group.vo.GroupStatisticsVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="groupStatisticsService")
public class GroupStatisticsServiceImpl extends EgovAbstractServiceImpl implements GroupStatisticsService {

	@Autowired private GroupStatisticsMapper groupStatisticsMapper;

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.STATICS)
	public int getGroupMoveDayCnt(GroupStatisticsVO groupStatisticsVo) {
		// TODO Auto-generated method stub
		return groupStatisticsMapper.getGroupMoveDayCnt(groupStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.STATICS)
	public List<GroupStatisticsVO> getGroupMoveDayList(GroupStatisticsVO groupStatisticsVo) {
		// TODO Auto-generated method stub
		return groupStatisticsMapper.getGroupMoveDayList(groupStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.STATICS)
	public int getGroupMoveMonthCnt(GroupStatisticsVO groupStatisticsVo) {
		// TODO Auto-generated method stub
		return groupStatisticsMapper.getGroupMoveMonthCnt(groupStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.STATICS)
	public List<GroupStatisticsVO> getGroupMoveMonthList(GroupStatisticsVO groupStatisticsVo) {
		// TODO Auto-generated method stub
		return groupStatisticsMapper.getGroupMoveMonthList(groupStatisticsVo);
	}

}