package com.dkitec.barocle.admin.service.paymentmgmt.refund.service;

import java.util.List;

import com.dkitec.barocle.admin.service.paymentmgmt.refund.vo.RefundVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("refundMapper")
public interface RefundMapper {
	public List<RefundVO> getRefundList(RefundVO refundVO);
	public RefundVO getRefundListCount(RefundVO refundVO);
	public List<RefundVO> getCancelPaymentList(RefundVO refundVO);
	public RefundVO getCancelPaymentListCount(RefundVO refundVO);
}
