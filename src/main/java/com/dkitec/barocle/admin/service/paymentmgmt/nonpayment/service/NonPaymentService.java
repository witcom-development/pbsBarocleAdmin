package com.dkitec.barocle.admin.service.paymentmgmt.nonpayment.service;

import java.util.List;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.paymentmgmt.nonpayment.vo.NonPaymentVO;

public interface NonPaymentService {
	public List<NonPaymentVO> getNonPaymentList(NonPaymentVO nonPaymentVO) throws CfoodException;
	public int getNonPaymentListCount(NonPaymentVO nonPaymentVO) throws CfoodException;
	public List<String> getStation(String stationGrpSeq) throws CfoodException;
	public int addNonPayment(NonPaymentVO nonPaymentVO) throws CfoodException;
	public int setRentOverFee(NonPaymentVO nonPaymentVO) throws CfoodException;
}
