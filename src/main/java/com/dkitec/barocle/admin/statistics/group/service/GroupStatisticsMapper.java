package com.dkitec.barocle.admin.statistics.group.service;

import java.util.List;

import com.dkitec.barocle.admin.statistics.group.vo.GroupStatisticsVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("groupStatisticsMapper")
public interface GroupStatisticsMapper {

	int getGroupMoveDayCnt(GroupStatisticsVO groupStatisticsVo);
	
	List<GroupStatisticsVO> getGroupMoveDayList(GroupStatisticsVO groupStatisticsVo);

	int getGroupMoveMonthCnt(GroupStatisticsVO groupStatisticsVo);
	
	List<GroupStatisticsVO> getGroupMoveMonthList(GroupStatisticsVO groupStatisticsVo);
	
}
	