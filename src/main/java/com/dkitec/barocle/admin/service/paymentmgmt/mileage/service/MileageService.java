package com.dkitec.barocle.admin.service.paymentmgmt.mileage.service;

import java.util.List;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.paymentmgmt.mileage.vo.MileageVO;

public interface MileageService {
	public List<MileageVO> getMileageHistList(MileageVO mileageVO) throws CfoodException;
	public int getMileageHistCount(MileageVO mileageVO) throws CfoodException;
	public int getMileageHistTotalSum(MileageVO mileageVO) throws CfoodException;
}
