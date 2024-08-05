package com.dkitec.barocle.admin.statistics.rent.service;

import java.util.List;

import com.dkitec.barocle.admin.statistics.rent.vo.RentStatisticsVO;


public interface RentStatisticsService {
	
	int getRentDayCnt(RentStatisticsVO rentStatisticsVo);
	
	List<RentStatisticsVO> getRentDayList(RentStatisticsVO rentStatisticsVo);
	
	int getRentMonthCnt(RentStatisticsVO rentStatisticsVo);
	
	List<RentStatisticsVO> getRentMonthList(RentStatisticsVO rentStatisticsVo);

	int getReturnDayCnt(RentStatisticsVO rentStatisticsVo);
	
	List<RentStatisticsVO> getReturnDayList(RentStatisticsVO rentStatisticsVo);

	int getReturnMonthCnt(RentStatisticsVO rentStatisticsVo);
	
	List<RentStatisticsVO> getReturnMonthList(RentStatisticsVO rentStatisticsVo);

}
