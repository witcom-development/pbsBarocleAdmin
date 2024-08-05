package com.dkitec.barocle.admin.service.paymentmgmt.reduction.service;

import java.util.List;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.paymentmgmt.reduction.vo.ReductionVO;

public interface ReductionService {
	public List<ReductionVO> getReductionList(ReductionVO reductionVO) throws CfoodException;
	public int getReductionListCount(ReductionVO reductionVO) throws CfoodException;
}
