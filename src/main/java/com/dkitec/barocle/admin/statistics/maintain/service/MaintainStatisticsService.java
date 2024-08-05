package com.dkitec.barocle.admin.statistics.maintain.service;

import java.util.List;

import com.dkitec.barocle.admin.statistics.maintain.vo.MaintainStatisticsVO;


public interface MaintainStatisticsService {
	// 장애 리스트
	int getFaultStateCnt(MaintainStatisticsVO maintainStatisticsVo);
	
	int getFaultDayCnt(MaintainStatisticsVO maintainStatisticsVo);
	
	List<MaintainStatisticsVO> getFaultDayList(MaintainStatisticsVO maintainStatisticsVo);
	
	int getFaultMonthCnt(MaintainStatisticsVO maintainStatisticsVo);
	
	List<MaintainStatisticsVO> getFaultMonthList(MaintainStatisticsVO maintainStatisticsVo);
	
	int getFaultYearCnt(MaintainStatisticsVO maintainStatisticsVo);
	
	List<MaintainStatisticsVO> getFaultYearList(MaintainStatisticsVO maintainStatisticsVo);
	
	// 수리 리스트
	int getRepairStateCnt(MaintainStatisticsVO maintainStatisticsVo);
	
	int getRepairDayCnt(MaintainStatisticsVO maintainStatisticsVo);
	
	List<MaintainStatisticsVO> getRepairDayList(MaintainStatisticsVO maintainStatisticsVo);
	
	int getRepairMonthCnt(MaintainStatisticsVO maintainStatisticsVo);
	
	List<MaintainStatisticsVO> getRepairMonthList(MaintainStatisticsVO maintainStatisticsVo);
	
	int getRepairYearCnt(MaintainStatisticsVO maintainStatisticsVo);
	
	List<MaintainStatisticsVO> getRepairYearList(MaintainStatisticsVO maintainStatisticsVo);
	
}
