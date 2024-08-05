package com.dkitec.barocle.admin.service.paymentmgmt.refundReq.service;

import java.util.List;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.paymentmgmt.refundReq.vo.RefundReqVO;

public interface RefundReqService {
	public List<RefundReqVO> getRefundList(RefundReqVO refundVO) throws CfoodException;
	public RefundReqVO getRefundListCount(RefundReqVO refundVO) throws CfoodException;
	public List<RefundReqVO> getCancelPaymentList(RefundReqVO refundVO) throws CfoodException;
	public RefundReqVO getCancelPaymentListCount(RefundReqVO refundVO) throws CfoodException;
	public String getmemberAcnutBank(String usrSeq) throws CfoodException;
	
	public int cancleRefundReq(RefundReqVO refundVO) throws CfoodException;
}
