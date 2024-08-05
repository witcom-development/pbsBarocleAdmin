package com.dkitec.barocle.admin.service.paymentmgmt.refund.service;

import java.util.List;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.paymentmgmt.refund.vo.RefundVO;

public interface RefundService {
	public List<RefundVO> getRefundList(RefundVO refundVO) throws CfoodException;
	public RefundVO getRefundListCount(RefundVO refundVO) throws CfoodException;
	public List<RefundVO> getCancelPaymentList(RefundVO refundVO) throws CfoodException;
	public RefundVO getCancelPaymentListCount(RefundVO refundVO) throws CfoodException;
}
