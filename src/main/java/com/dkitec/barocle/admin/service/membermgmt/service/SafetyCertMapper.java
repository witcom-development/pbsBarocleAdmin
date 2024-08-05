package com.dkitec.barocle.admin.service.membermgmt.service;

import java.util.HashMap;
import java.util.List;

import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertUserVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.MemberMgmtVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.MemberPaymentVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertDiscountVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertInfoVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertPaymentVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("safetyCertMapper")
public interface SafetyCertMapper {
	public SafetyCertInfoVO getCertInfo(SafetyCertInfoVO safetyCertInfoVO);
	public int addCertPayment(SafetyCertPaymentVO sftCertPaymentVO);
	public List<SafetyCertDiscountVO> getSafetyCertDiscount(SafetyCertDiscountVO safetyCertDiscountVO);

	//admin
	public int safetyCertUserListCnt(SafetyCertUserVO memberVo);
	public List<SafetyCertUserVO> safetyCertUserList(SafetyCertUserVO memberVo);
	public int chkCertNum(HashMap<String, String> errorMap);
	public int chkUsrMpnNo(HashMap<String, String> errorMap);
	public int chkMbId(HashMap<String, String> errorMap);
	public int addCertUsrFromExcel(HashMap<String, String> map);
	public SafetyCertUserVO getCertInfoWithMpnNo(String mpnNo);
	public SafetyCertUserVO getSafetyCertUserInfo(SafetyCertUserVO safetyCertUserVo);
	public int setSafetyCertUser(SafetyCertUserVO safetyCertUserVo);
	public void delSafetyCertUser(SafetyCertUserVO safetyCertUserVo);
	public int setSafetyCertDiscount(SafetyCertDiscountVO sVo);
	public List<MemberPaymentVO> getSafetyCertPaymentInfoList(MemberPaymentVO memberPaymentVO);
	public int safetyCertPaymentInfoListCnt(MemberPaymentVO memberPaymentVO);
	public List<MemberPaymentVO> getSafetyCertPaymentStatistics(MemberPaymentVO memberPaymentVO);
	public int safetyCertPaymentStatisticsCnt(MemberPaymentVO memberPaymentVO);
	public int safetyCertPaymentInfoListMemberCnt(MemberPaymentVO memberPaymentVO);
	public int safetyCertPaymentInfoListDisAmtSum(MemberPaymentVO memberPaymentVO);
	public List<SafetyCertUserVO> safetyCertEndUserList(SafetyCertUserVO safetyCertUserVo);
	public int smsSendListCnt(MemberMgmtVO memberMgmtVO);
	public List<MemberMgmtVO> smsSendList(MemberMgmtVO memberMgmtVO);
}
