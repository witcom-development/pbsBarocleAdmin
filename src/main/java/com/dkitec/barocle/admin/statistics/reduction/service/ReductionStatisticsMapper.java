package com.dkitec.barocle.admin.statistics.reduction.service;

import java.util.List;

import com.dkitec.barocle.admin.statistics.reduction.vo.ReductionStatisticsVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("reductionStatisticsMapper")
public interface ReductionStatisticsMapper {

	//요금 할인 수단별 통계
	int getReductionTypeListCnt(ReductionStatisticsVO reductionStatisticsVo);
	List<ReductionStatisticsVO> getReductionTypeList(ReductionStatisticsVO reductionStatisticsVo);
	
}
	