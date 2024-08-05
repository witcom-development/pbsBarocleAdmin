package com.dkitec.barocle.admin.service.paymentmgmt.nonpayment.service;

import java.util.List;

import com.dkitec.barocle.admin.service.paymentmgmt.nonpayment.vo.NonPaymentVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("nonPaymentMapper")
public interface NonPaymentMapper {
	public List<NonPaymentVO> getNonPaymentList(NonPaymentVO nonPaymentVO);
	public int getNonPaymentListCount(NonPaymentVO nonPaymentVO);
	public List<String> getStation(String stationGrpSeq);
	public int addNonPayment(NonPaymentVO nonPaymentVO);
	public int setRentOverFee(NonPaymentVO nonPaymentVO);
}
