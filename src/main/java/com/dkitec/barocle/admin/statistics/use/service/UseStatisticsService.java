package com.dkitec.barocle.admin.statistics.use.service;

import java.util.List;
import java.util.Map;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO;
import com.dkitec.barocle.admin.statistics.use.vo.UseStatisticsBoardVO;
import com.dkitec.barocle.admin.statistics.use.vo.UseStatisticsVO;


public interface UseStatisticsService {

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
	public int listUseStatisticsBoardCount(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception;
	public List<UseStatisticsBoardVO> listUseStatisticsBoard(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception;
	public Map<String,UseStatisticsBoardVO> viewUseStatisticsBoard(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception;	
	public List<DaumEditorVO> listDaumEditorVO(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception;
	
	public UseStatisticsBoardVO insertUseStatisticsBoard(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception;
	public UseStatisticsBoardVO updateUseStatisticsBoard(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception;
	public int deleteUseStatisticsBoard(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception;	
	
	public String staticFileDownloadList(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception;
	public String staticFileDownloadNm(UseStatisticsBoardVO useStatisticsBoardVO) throws Exception;
	
}
