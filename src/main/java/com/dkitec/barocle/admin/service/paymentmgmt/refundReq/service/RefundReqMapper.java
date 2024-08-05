package com.dkitec.barocle.admin.service.paymentmgmt.refundReq.service;

import java.util.List;

import com.dkitec.barocle.admin.service.paymentmgmt.refundReq.vo.RefundReqVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("refundReqMapper")
public interface RefundReqMapper {
	public List<RefundReqVO> getRefundList(RefundReqVO refundReqVO);
	public RefundReqVO getRefundListCount(RefundReqVO refundReqVO);
	public List<RefundReqVO> getCancelPaymentList(RefundReqVO refundReqVO);
	public RefundReqVO getCancelPaymentListCount(RefundReqVO refundReqVO);
	public String getmemberAcnutBank(String acnutBank);
	
	public int cancleRefundReq(RefundReqVO refundReqVO);
}
