package com.dkitec.barocle.admin.service.paymentmgmt.failpayment.service;

import java.util.List;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.paymentmgmt.failpayment.vo.FailPaymentVO;

public interface FailPaymentService {
	public List<FailPaymentVO> getFailPaymentList(FailPaymentVO failPaymentVO) throws CfoodException;
	public int getFailPaymentListCount(FailPaymentVO failPaymentVO) throws CfoodException;
}
