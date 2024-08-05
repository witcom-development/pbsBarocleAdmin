package com.dkitec.barocle.admin.service.paymentmgmt.nonpayment.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.paymentmgmt.nonpayment.service.NonPaymentMapper;
import com.dkitec.barocle.admin.service.paymentmgmt.nonpayment.service.NonPaymentService;
import com.dkitec.barocle.admin.service.paymentmgmt.nonpayment.vo.NonPaymentVO;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("nonPaymentService")
public class NonPaymentServiceImpl implements NonPaymentService {
	
	@Autowired NonPaymentMapper nonPaymentMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<NonPaymentVO> getNonPaymentList(NonPaymentVO nonPaymentVO) throws CfoodException {
		return nonPaymentMapper.getNonPaymentList(nonPaymentVO);
	}
	 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getNonPaymentListCount(NonPaymentVO nonPaymentVO) throws CfoodException {
		return nonPaymentMapper.getNonPaymentListCount(nonPaymentVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<String> getStation(String stationGrpSeq) {
		return nonPaymentMapper.getStation(stationGrpSeq);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int addNonPayment(NonPaymentVO nonPaymentVO) throws CfoodException {
		List<NonPaymentVO> nonPayList = nonPaymentVO.getNonPayList();
		int result = 0;
		
		if(nonPayList.size() > 0) {
			NonPaymentVO insertVO = null;
			for(NonPaymentVO vo : nonPayList)	{
				insertVO = new NonPaymentVO();
				insertVO.setUsrSeq(vo.getUsrSeq());
				insertVO.setPaymentMethodCd(nonPaymentVO.getPaymentMethodCd());
				insertVO.setOverFee(vo.getOverFee());
				insertVO.setOverFeeProcessClsCd(nonPaymentVO.getOverFeeProcessClsCd());
				insertVO.setProcessReasonDesc(nonPaymentVO.getProcessReasonDesc());
				insertVO.setRentHistSeq(vo.getRentHistSeq());
				
				if(nonPaymentVO.getOverFeeProcessClsCd().equals("OPD_001")){
					result = nonPaymentMapper.addNonPayment(insertVO);
				}
				result = nonPaymentMapper.setRentOverFee(insertVO);
			}
		}
		return result;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int setRentOverFee(NonPaymentVO nonPaymentVO) throws CfoodException {
		return nonPaymentMapper.setRentOverFee(nonPaymentVO);
	}
}
