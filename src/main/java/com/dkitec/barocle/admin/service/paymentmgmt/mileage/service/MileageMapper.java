package com.dkitec.barocle.admin.service.paymentmgmt.mileage.service;

import java.util.List;

import com.dkitec.barocle.admin.service.paymentmgmt.mileage.vo.MileageVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mileageMapper")
public interface MileageMapper {
	public List<MileageVO> getMileageHistList(MileageVO mileageVO);
	public int getMileageHistCount(MileageVO mileageVO);
	public int getMileageHistTotalSum(MileageVO mileageVO);
}
