package com.dkitec.barocle.admin.service.paymentmgmt.refundReq.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.paymentmgmt.refundReq.service.RefundReqMapper;
import com.dkitec.barocle.admin.service.paymentmgmt.refundReq.service.RefundReqService;
import com.dkitec.barocle.admin.service.paymentmgmt.refundReq.vo.RefundReqVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("refundReqService")
public class RefundReqServiceImpl implements RefundReqService {
	
	@Autowired RefundReqMapper refundReqMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RefundReqVO> getRefundList(RefundReqVO refundReqVO) throws CfoodException {
		return refundReqMapper.getRefundList(refundReqVO);
	}
	 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public RefundReqVO getRefundListCount(RefundReqVO refundReqVO) throws CfoodException {
		return refundReqMapper.getRefundListCount(refundReqVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RefundReqVO> getCancelPaymentList(RefundReqVO refundReqVO) throws CfoodException {
		return refundReqMapper.getCancelPaymentList(refundReqVO);
	}
	 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public RefundReqVO getCancelPaymentListCount(RefundReqVO refundReqVO) throws CfoodException {
		return refundReqMapper.getCancelPaymentListCount(refundReqVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public String getmemberAcnutBank(String usrSeq) throws CfoodException {
		return refundReqMapper.getmemberAcnutBank(usrSeq);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int cancleRefundReq(RefundReqVO refundReqVO) throws CfoodException {
		int result = 0;
		result = refundReqMapper.cancleRefundReq(refundReqVO);
		return result;
	}
}
