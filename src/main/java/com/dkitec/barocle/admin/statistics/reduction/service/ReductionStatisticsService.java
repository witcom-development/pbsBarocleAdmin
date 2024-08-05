package com.dkitec.barocle.admin.statistics.reduction.service;

import java.util.List;

import com.dkitec.barocle.admin.statistics.reduction.vo.ReductionStatisticsVO;

public interface ReductionStatisticsService {

	//이용감면 서비스 통계
	int getReductionTypeListCnt(ReductionStatisticsVO reductionStatisticsVo);
	List<ReductionStatisticsVO> getReductionTypeList(ReductionStatisticsVO reductionStatisticsVo);


	
}
