package com.dkitec.barocle.admin.service.paymentmgmt.reduction.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.paymentmgmt.reduction.service.ReductionMapper;
import com.dkitec.barocle.admin.service.paymentmgmt.reduction.service.ReductionService;
import com.dkitec.barocle.admin.service.paymentmgmt.reduction.vo.ReductionVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("reductionService")
public class ReductionServiceImpl implements ReductionService {

	@Autowired ReductionMapper reductionMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ReductionVO> getReductionList(ReductionVO reductionVO) throws CfoodException {
		return reductionMapper.getReductionList(reductionVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getReductionListCount(ReductionVO reductionVO) throws CfoodException {
		return reductionMapper.getReductionListCount(reductionVO);
	}
}
