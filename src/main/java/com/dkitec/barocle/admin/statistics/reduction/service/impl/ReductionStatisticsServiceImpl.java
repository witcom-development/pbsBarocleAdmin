package com.dkitec.barocle.admin.statistics.reduction.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.statistics.reduction.service.ReductionStatisticsMapper;
import com.dkitec.barocle.admin.statistics.reduction.service.ReductionStatisticsService;
import com.dkitec.barocle.admin.statistics.reduction.vo.ReductionStatisticsVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="reductionStatisticsService")
public class ReductionStatisticsServiceImpl extends EgovAbstractServiceImpl implements ReductionStatisticsService {

	@Autowired private ReductionStatisticsMapper reductionStatisticsMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getReductionTypeListCnt(ReductionStatisticsVO reductionStatisticsVo) {
		return reductionStatisticsMapper.getReductionTypeListCnt(reductionStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ReductionStatisticsVO> getReductionTypeList(ReductionStatisticsVO reductionStatisticsVo) {
		return reductionStatisticsMapper.getReductionTypeList(reductionStatisticsVo);
	}



	
}