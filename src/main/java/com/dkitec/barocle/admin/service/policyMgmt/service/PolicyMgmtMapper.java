package com.dkitec.barocle.admin.service.policyMgmt.service;

import java.util.List;

import com.dkitec.barocle.admin.service.membermgmt.vo.MemberMgmtVO;
import com.dkitec.barocle.admin.service.policyMgmt.vo.ChargePolicyMgmtVO;
import com.dkitec.barocle.admin.service.policyMgmt.vo.PenaltyPolicyMgmtVO;
import com.dkitec.barocle.admin.service.policyMgmt.vo.TransferPolicyMgmtVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("policyMgmtMapper")
public interface PolicyMgmtMapper {

	public List<ChargePolicyMgmtVO> listRentChargePolicy();
	public List<ChargePolicyMgmtVO> listPremiumRentChargePolicy();	//프리미엄 요금 정책 리스트_20160614_JJH
	public List<ChargePolicyMgmtVO> listAddChargePolicy();
	public List<ChargePolicyMgmtVO> listAddPremiumChargePolicy();	//프리미엄 추가 요금 정책 리스트_20160614_JJH
	public List<ChargePolicyMgmtVO> listSpecialChargePolicy(String paymentClsCd);
	public List<ChargePolicyMgmtVO> listRentMM();
	public List<ChargePolicyMgmtVO> PremiumlistRentMM();	//프리미엄 요금제 자전거 정책_20160614_JJH
	public java.util.List<java.util.Map> premiumUseYnList();	//프리미엄 요금제 사용여부_20160614_JJH
	public int updatePremiumSeasonUseYn(ChargePolicyMgmtVO chargePolicyMgmtVO);	//프리미엄 요금제 사용여부_2016062_JJH
	public int updatePremiumMdayUseYn(ChargePolicyMgmtVO chargePolicyMgmtVO);	//프리미엄 요금제 사용여부_2016062_JJH
	public int modRentChargePolicy(ChargePolicyMgmtVO chargePolicyMgmtVO);		//프리미엄 요금제 사용여부_2016062_JJH
	public int modAddChargePolicy(ChargePolicyMgmtVO chargePolicyMgmtVO);
	public int modSpecialChargePolicy(ChargePolicyMgmtVO chargePolicyMgmtVO);
	public int insertSpecialTimeChargePolicy(ChargePolicyMgmtVO chargePolicyMgmtVO);
	public int delSpecialTimeChargePolicy(ChargePolicyMgmtVO chargePolicyMgmtVO);
	
	public List<PenaltyPolicyMgmtVO> listPenaltyPolicy(PenaltyPolicyMgmtVO penaltyPolicyMgmtVO);	
	public int listPenaltyPolicyCount(PenaltyPolicyMgmtVO penaltyPolicyMgmtVO);	
	public int isPenaltyCdDupl(String penaltyCd);
	public int insertPenaltyPolicy(PenaltyPolicyMgmtVO penaltyPolicyMgmtVO);
	public int modPenaltyPolicy(PenaltyPolicyMgmtVO penaltyPolicyMgmtVO);
	public int isPenaltyApply(String penaltyCd);
	public int delPenaltyPolicy(PenaltyPolicyMgmtVO penaltyPolicyMgmtVO);
	
	public List<TransferPolicyMgmtVO> listTransferPolicy(TransferPolicyMgmtVO transferPolicyMgmtVO);
	public int listTransferPolicyCount(TransferPolicyMgmtVO transferPolicyMgmtVO);
	public int isTransferDateDupl(TransferPolicyMgmtVO transferPolicyMgmtVO);
	public int insertTransferPolicy(TransferPolicyMgmtVO transferPolicyMgmtVO);
	public int modRecentTransferPolicy(TransferPolicyMgmtVO transferPolicyMgmtVO);
	public int modTransferPolicy(TransferPolicyMgmtVO transferPolicyMgmtVO);
	public int delTransferPolicy(TransferPolicyMgmtVO transferPolicyMgmtVO);
	
	//sms 전송 리스트_카운트 _cms_20161216
	public int smsSendListCnt(MemberMgmtVO memberMgmtVO);
	//sms 전송 리스트_cms_20161216
	public List<MemberMgmtVO> smsSendList(MemberMgmtVO memberMgmtVO);
	
	// 장기 미반납리스트
	public List<MemberMgmtVO> smsLongSendList(MemberMgmtVO memberMgmtVO);
	public int smsLongSendListCnt(MemberMgmtVO memberVo);
	
	
	// 푸쉬 발송 리스트
	public List<MemberMgmtVO> pushSendList(MemberMgmtVO memberMgmtVO);
	public int pushSendListCnt(MemberMgmtVO memberVo);
}
