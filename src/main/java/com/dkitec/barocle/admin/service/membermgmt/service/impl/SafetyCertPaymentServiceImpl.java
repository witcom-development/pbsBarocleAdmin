package com.dkitec.barocle.admin.service.membermgmt.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.membermgmt.service.SafetyCertMapper;
import com.dkitec.barocle.admin.service.membermgmt.service.SafetyCertPaymentService;
import com.dkitec.barocle.admin.service.membermgmt.vo.MemberPaymentVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertPaymentVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("safetyCertPaymentService")
public class SafetyCertPaymentServiceImpl implements SafetyCertPaymentService {

	@Autowired SafetyCertMapper safetyCertMapper;
	
	@Override
	@Transactional(readOnly=false, propagation=Propagation.REQUIRED, rollbackFor={SQLException.class, Exception.class})
	@DataSource(DataSourceType.MASTER)
	public int addCertPayment(SafetyCertPaymentVO sftCertPaymentVO)throws CfoodException {
		return safetyCertMapper.addCertPayment(sftCertPaymentVO);
	}

	@Override
	public List<MemberPaymentVO> getSafetyCertPaymentInfoList(MemberPaymentVO memberPaymentVO) {
		return safetyCertMapper.getSafetyCertPaymentInfoList(memberPaymentVO);
	}

	@Override
	public int safetyCertPaymentInfoListCnt(MemberPaymentVO memberPaymentVO) {
		int result = 0;
		result =  safetyCertMapper.safetyCertPaymentInfoListCnt(memberPaymentVO);
		return result;
	}
	
	@Override
	public int safetyCertPaymentStatisticsCnt(MemberPaymentVO memberPaymentVO) {
		int result = 0;
		result =  safetyCertMapper.safetyCertPaymentStatisticsCnt(memberPaymentVO);
		return result;
	}

	@Override
	public List<MemberPaymentVO> getSafetyCertPaymentStatistics(MemberPaymentVO memberPaymentVO) {
		return safetyCertMapper.getSafetyCertPaymentStatistics(memberPaymentVO);
	}

	@Override
	public int safetyCertPaymentInfoListMemberCnt(MemberPaymentVO memberPaymentVO) {
		int result = 0;
		result =  safetyCertMapper.safetyCertPaymentInfoListMemberCnt(memberPaymentVO);
		return result;
	}

	@Override
	public int safetyCertPaymentInfoListDisAmtSum(MemberPaymentVO memberPaymentVO) {
		int result = 0;
		result =  safetyCertMapper.safetyCertPaymentInfoListDisAmtSum(memberPaymentVO);
		return result;
	}

}
