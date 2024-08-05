package com.dkitec.barocle.admin.service.paymentmgmt.overpayment.service;

import java.util.List;

import com.dkitec.barocle.admin.service.paymentmgmt.overpayment.vo.OverPaymentVO;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.vo.PaymentVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("overPaymentMapper")
public interface OverPaymentMapper {
	public List<OverPaymentVO> getOverPaymentList(PaymentVO paymentVO);
	public int getOverPaymentListCount(PaymentVO paymentVO);
}
