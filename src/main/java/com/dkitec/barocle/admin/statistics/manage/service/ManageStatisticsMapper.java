package com.dkitec.barocle.admin.statistics.manage.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.dkitec.barocle.admin.maintenance.repair.division.vo.RepairDivisionVO;
import com.dkitec.barocle.admin.statistics.manage.vo.ManageStatisticsVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("manageStatisticsMapper")
public interface ManageStatisticsMapper {
	int getManageDayPeriod(ManageStatisticsVO manageStatisticsVo);
	int getManageMonthPeriod(ManageStatisticsVO manageStatisticsVo);

	// 운영내역 현황 - 수익금리스트
	List<ManageStatisticsVO> getIncomeDayList(ManageStatisticsVO manageStatisticsVo);
	List<ManageStatisticsVO> getIncomeMonthList(ManageStatisticsVO manageStatisticsVo);
	// 운영내역 현황 - 회원가입리스트
	List<ManageStatisticsVO> getUserJoinDayList(ManageStatisticsVO manageStatisticsVo);
	List<ManageStatisticsVO> getUserJoinMonthList(ManageStatisticsVO manageStatisticsVo);
	// 운영내역 현황 - 자전거이용리스트
	List<ManageStatisticsVO> getBikeUseDayList(ManageStatisticsVO manageStatisticsVo);
	List<ManageStatisticsVO> getBikeUseMonthList(ManageStatisticsVO manageStatisticsVo);
	// 시간대 이용 현황 리스트
	List<ManageStatisticsVO> getTimeUseList(ManageStatisticsVO manageStatisticsVo);
	// 주요 대여소 리스트
	List<ManageStatisticsVO> getHighStationList(ManageStatisticsVO manageStatisticsVo);
	List<ManageStatisticsVO> getLowStationList(ManageStatisticsVO manageStatisticsVo);
	
	// 최대운영자전거 수 조회_cms_20161129
	int getBikeListCnt(ManageStatisticsVO manageStatisticsVo);
	// 최대운영자전거  조회_cms_20161129
	List<RepairDivisionVO> getBikeList(ManageStatisticsVO manageStatisticsVo);
	
	// 자전거 배터리상태 정보_cms_20170111
	int getBikeBatteryListCnt(ManageStatisticsVO manageStatisticsVo);
	// 자전거 배터리상태 정보_cms_20170111
	ArrayList<Map<String, String>> getBikeBatteryList(ManageStatisticsVO manageStatisticsVo);
	
	ArrayList<Map<String, String>> getBikeBatteryExcelList(ManageStatisticsVO manageStatisticsVo);
	
	// 2020-12-18 : 시민의견 - 등록 처리 통계
	List<ManageStatisticsVO> opinionList(ManageStatisticsVO manageStatisticsVo);
	
}
	