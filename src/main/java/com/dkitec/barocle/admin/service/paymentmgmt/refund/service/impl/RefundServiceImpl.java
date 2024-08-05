package com.dkitec.barocle.admin.service.paymentmgmt.refund.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.paymentmgmt.refund.service.RefundMapper;
import com.dkitec.barocle.admin.service.paymentmgmt.refund.service.RefundService;
import com.dkitec.barocle.admin.service.paymentmgmt.refund.vo.RefundVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("refundService")
public class RefundServiceImpl implements RefundService {
	
	@Autowired RefundMapper refundMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RefundVO> getRefundList(RefundVO refundVO) throws CfoodException {
		return refundMapper.getRefundList(refundVO);
	}
	 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public RefundVO getRefundListCount(RefundVO refundVO) throws CfoodException {
		return refundMapper.getRefundListCount(refundVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RefundVO> getCancelPaymentList(RefundVO refundVO) throws CfoodException {
		return refundMapper.getCancelPaymentList(refundVO);
	}
	 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public RefundVO getCancelPaymentListCount(RefundVO refundVO) throws CfoodException {
		return refundMapper.getCancelPaymentListCount(refundVO);
	}
}
