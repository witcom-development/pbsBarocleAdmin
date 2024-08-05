package com.dkitec.barocle.admin.service.paymentmgmt.overpayment.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.paymentmgmt.overpayment.service.OverPaymentMapper;
import com.dkitec.barocle.admin.service.paymentmgmt.overpayment.service.OverPaymentService;
import com.dkitec.barocle.admin.service.paymentmgmt.overpayment.vo.OverPaymentVO;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.vo.PaymentVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("overPaymentService")
public class OverPaymentServiceImpl implements OverPaymentService {

	@Autowired OverPaymentMapper overPaymentMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<OverPaymentVO> getOverPaymentList(PaymentVO paymentVO) throws CfoodException {
		return overPaymentMapper.getOverPaymentList(paymentVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getOverPaymentListCount(PaymentVO paymentVO) throws CfoodException {
		return overPaymentMapper.getOverPaymentListCount(paymentVO);
	}
}
