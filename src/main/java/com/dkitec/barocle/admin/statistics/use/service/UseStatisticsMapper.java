package com.dkitec.barocle.admin.statistics.use.service;

import java.util.List;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO;
import com.dkitec.barocle.admin.statistics.use.vo.UseStatisticsBoardVO;
import com.dkitec.barocle.admin.statistics.use.vo.UseStatisticsVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("useStatisticsMapper")
public interface UseStatisticsMapper {
	
	int getDayPeriod(UseStatisticsVO useStatisticsVo);

	int getMonthPeriod(UseStatisticsVO useStatisticsVo);
	
	int getUseMemberCnt(UseStatisticsVO useStatisticsVo);
	
	List<UseStatisticsVO> getUseMemberList(UseStatisticsVO useStatisticsVo);

	List<UseStatisticsVO> getUseMemberRentTypeSumData(UseStatisticsVO useStatisticsVo);

	List<UseStatisticsVO> getUseMemberGenderSumData(UseStatisticsVO useStatisticsVo);

	int getUseHourlyCnt(UseStatisticsVO useStatisticsVo);
	
	List<UseStatisticsVO> getUseHourlyList(UseStatisticsVO useStatisticsVo);

	int getUseAgeGroupCnt(UseStatisticsVO useStatisticsVo);
	
	List<UseStatisticsVO> getUseAgeGroupList(UseStatisticsVO useStatisticsVo);
	
	int getUseRanDayCnt(UseStatisticsVO useStatisticsVo);
	
	List<UseStatisticsVO> getUseRanDayList(UseStatisticsVO useStatisticsVo);

	int getUseRanWeekCnt(UseStatisticsVO useStatisticsVo);
	
	List<UseStatisticsVO> getUseRanWeekList(UseStatisticsVO useStatisticsVo);

	int getUseRanMonthCnt(UseStatisticsVO useStatisticsVo);
	
	List<UseStatisticsVO> getUseRanMonthList(UseStatisticsVO useStatisticsVo);
	
	int getUseForeignDayCnt(UseStatisticsVO useStatisticsVo);
	
	List<UseStatisticsVO> getUseForeignDayList(UseStatisticsVO useStatisticsVo);
	
	int getUseForeignMonthCnt(UseStatisticsVO useStatisticsVo);
	
	List<UseStatisticsVO> getUseForeignMonthList(UseStatisticsVO useStatisticsVo);

	int getUseMemberMaxPeriod();
	

	// 통계용 게시판 추가
	int listUseStatisticsBoardCount(UseStatisticsBoardVO useStatisticsBoardVO);
	List<UseStatisticsBoardVO> listUseStatisticsBoard(UseStatisticsBoardVO useStatisticsBoardVO);
	UseStatisticsBoardVO viewUseStatisticsBoard(UseStatisticsBoardVO useStatisticsBoardVO);
	List<DaumEditorVO> getDaumEditorImage(UseStatisticsBoardVO useStatisticsBoardVO);
	
	public int insertUseStatisticsBoard(UseStatisticsBoardVO useStatisticsBoardVO);
	public int updateUseStatisticsBoard(UseStatisticsBoardVO useStatisticsBoardVO);
	public int deleteUseStatisticsBoard(UseStatisticsBoardVO useStatisticsBoardVO);	
	
	public int deleteDaumEditorImage(UseStatisticsBoardVO useStatisticsBoardVO);
	public int updateDaumEditorImage(UseStatisticsBoardVO useStatisticsBoardVO);	
	
	public List<UseStatisticsBoardVO> staticFileDownloadList(UseStatisticsBoardVO useStatisticsBoardVO);
	
}
	