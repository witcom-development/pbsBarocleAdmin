package com.dkitec.barocle.admin.service.paymentmgmt.reduction.service;

import java.util.List;

import com.dkitec.barocle.admin.service.paymentmgmt.reduction.vo.ReductionVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("reductionMapper")
public interface ReductionMapper {
	public List<ReductionVO> getReductionList(ReductionVO reductionVO);
	public int getReductionListCount(ReductionVO reductionVO);
}
