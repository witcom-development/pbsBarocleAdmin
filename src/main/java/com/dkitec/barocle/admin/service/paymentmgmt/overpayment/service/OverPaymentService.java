package com.dkitec.barocle.admin.service.paymentmgmt.overpayment.service;

import java.util.List;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.paymentmgmt.overpayment.vo.OverPaymentVO;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.vo.PaymentVO;

public interface OverPaymentService {
	public List<OverPaymentVO> getOverPaymentList(PaymentVO paymentVO) throws CfoodException;
	public int getOverPaymentListCount(PaymentVO paymentVO) throws CfoodException;
}
