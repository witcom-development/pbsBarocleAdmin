package com.dkitec.barocle.admin.statistics.group.service;

import java.util.List;

import com.dkitec.barocle.admin.statistics.group.vo.GroupStatisticsVO;

public interface GroupStatisticsService {

	int getGroupMoveDayCnt(GroupStatisticsVO groupStatisticsVo);
	
	List<GroupStatisticsVO> getGroupMoveDayList(GroupStatisticsVO groupStatisticsVo);

	int getGroupMoveMonthCnt(GroupStatisticsVO groupStatisticsVo);
	
	List<GroupStatisticsVO> getGroupMoveMonthList(GroupStatisticsVO groupStatisticsVo);
	
}
