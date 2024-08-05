package com.dkitec.barocle.admin.service.membermgmt.service;

import java.util.List;

import com.dkitec.barocle.admin.service.membermgmt.vo.MemberPaymentVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertPaymentVO;


public interface SafetyCertPaymentService {
	
	public int addCertPayment(SafetyCertPaymentVO sftCertPaymentVO) throws Exception;

	public List<MemberPaymentVO> getSafetyCertPaymentInfoList(MemberPaymentVO memberPaymentVO);

	public int safetyCertPaymentInfoListCnt(MemberPaymentVO memberPaymentVO);

	public List<MemberPaymentVO> getSafetyCertPaymentStatistics(MemberPaymentVO memberPaymentVO);

	int safetyCertPaymentStatisticsCnt(MemberPaymentVO memberPaymentVO);

	public int safetyCertPaymentInfoListMemberCnt(MemberPaymentVO memberPaymentVO);

	public int safetyCertPaymentInfoListDisAmtSum(MemberPaymentVO memberPaymentVO);
	
}
