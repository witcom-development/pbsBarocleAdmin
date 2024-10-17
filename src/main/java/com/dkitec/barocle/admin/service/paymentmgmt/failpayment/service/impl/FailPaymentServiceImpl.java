package com.dkitec.barocle.admin.service.paymentmgmt.failpayment.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.service.paymentmgmt.failpayment.service.FailPaymentMapper;
import com.dkitec.barocle.admin.service.paymentmgmt.failpayment.service.FailPaymentService;
import com.dkitec.barocle.admin.service.paymentmgmt.failpayment.vo.FailPaymentVO;
import com.dkitec.barocle.admin.service.paymentmgmt.mileage.vo.MileageVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.cfood.core.CfoodException;

@Service("failPaymentService")
public class FailPaymentServiceImpl implements FailPaymentService {
	
	@Autowired FailPaymentMapper failPaymentMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<FailPaymentVO> getFailPaymentList(FailPaymentVO failPaymentVO) throws CfoodException {
		return failPaymentMapper.getFailPaymentList(failPaymentVO);
	}
	 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getFailPaymentListCount(FailPaymentVO failPaymentVO) throws CfoodException {
		return failPaymentMapper.getFailPaymentListCount(failPaymentVO);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int addTicketPaymentFail(FailPaymentVO failPaymentVO) throws CfoodException {
		return failPaymentMapper.addTicketPaymentFail(failPaymentVO);
	}
}
