package com.dkitec.barocle.admin.statistics.zeropay.service;

import java.util.List;

import com.dkitec.barocle.admin.statistics.zeropay.vo.ZeropayStatisticsVO;

public interface ZeropayStatisticsService {

	//제로페이 이용권별 통계
	List<ZeropayStatisticsVO> getTicketList(ZeropayStatisticsVO zeropayStatisticsVo);
	int getTicketListCnt(ZeropayStatisticsVO zeropayStatisticsVo);
	List<ZeropayStatisticsVO> getDailyTicketPmtList(ZeropayStatisticsVO zeropayStatisticsVo);
	int getDailyTicketPmtListCnt(ZeropayStatisticsVO zeropayStatisticsVo);
	int getPaymentTypeListCnt(ZeropayStatisticsVO zeropayStatisticsVo);
	List<ZeropayStatisticsVO> getPaymentTypeList(ZeropayStatisticsVO zeropayStatisticsVo);
	int getSeasonTicketPmtListCnt(ZeropayStatisticsVO zeropayStatisticsVo);
	List<ZeropayStatisticsVO> getSeasonTicketPmtList(ZeropayStatisticsVO zeropayStatisticsVo);


	
}
