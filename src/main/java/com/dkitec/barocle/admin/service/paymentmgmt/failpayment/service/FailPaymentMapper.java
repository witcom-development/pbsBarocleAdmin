package com.dkitec.barocle.admin.service.paymentmgmt.failpayment.service;

import java.util.List;

import com.dkitec.barocle.admin.service.paymentmgmt.failpayment.vo.FailPaymentVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("failPaymentMapper")
public interface FailPaymentMapper {
	public List<FailPaymentVO> getFailPaymentList(FailPaymentVO failPaymentVO);
	public int getFailPaymentListCount(FailPaymentVO failPaymentVO);
}
