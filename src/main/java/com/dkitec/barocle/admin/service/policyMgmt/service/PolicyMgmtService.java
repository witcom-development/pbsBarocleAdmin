package com.dkitec.barocle.admin.service.policyMgmt.service;

import java.util.List;

import com.dkitec.barocle.admin.service.membermgmt.vo.MemberMgmtVO;
import com.dkitec.barocle.admin.service.policyMgmt.vo.ChargePolicyMgmtVO;
import com.dkitec.barocle.admin.service.policyMgmt.vo.PenaltyPolicyMgmtVO;
import com.dkitec.barocle.admin.service.policyMgmt.vo.TransferPolicyMgmtVO;

public interface PolicyMgmtService {

	/**
	 * @Todo 		: 기본 요금 정책 리스트
	 * @Date 		: 2015. 5. 26.
	 * @Return		: List<ChargePolicyMgmtVO> 
	 */
	public List<ChargePolicyMgmtVO> listRentChargePolicy();
	
	//Premium 요금제_20160614_JJH
	/**
	 * @Todo 		: 프리미엄 요금 정책 리스트
	 * @Date 		: 2016. 6. 14.
	 * @Return		: List<ChargePolicyMgmtVO> 
	 */
	public List<ChargePolicyMgmtVO> listPremiumRentChargePolicy();
	
	/**
	 * @Todo 		: 추가 요금 정책 리스트
	 * @Date 		: 2015. 5. 26.
	 * @Return		: List<ChargePolicyMgmtVO> 
	 */
	public List<ChargePolicyMgmtVO> listAddChargePolicy();
	
	//Premium 요금제_20160614_JJH
	/**
	 * @Todo 		: 프리미엄 추가 요금 정책 리스트
	 * @Date 		: 2016. 6. 14.
	 * @Return		: List<ChargePolicyMgmtVO> 
	 */
	public List<ChargePolicyMgmtVO> listAddPremiumChargePolicy();
	
	/**
	 * @Todo 		: 특례 요금 정책 리스트
	 * @Date 		: 2015. 5. 26.
	 * @Return		: List<ChargePolicyMgmtVO> 
	 */
	public List<ChargePolicyMgmtVO> listSpecialChargePolicy(String paymentClsCd);
	
	/**
	 * @Todo 		: 대여 시간 리스트
	 * @Date 		: 2015. 5. 26.
	 * @Return		: List<ChargePolicyMgmtVO> 
	 */
	public List<ChargePolicyMgmtVO> listRentMM();
	
	//Premium 요금제_20160614_JJH
	/**
	 * @Todo 		: 프리미엄 요금제 대여 시간 리스트
	 * @Date 		: 2016. 6. 14.
	 * @Return		: List<ChargePolicyMgmtVO> 
	 */
	public List<ChargePolicyMgmtVO> PremiumlistRentMM();
	
	/**
	 * @Todo 		: 요금 정책 수정
	 * @Date 		: 2015. 5. 26.
	 * @Return		: boolean 
	 */
	public boolean modChargePolicy(ChargePolicyMgmtVO chargePolicyMgmtVO);
	
	/**
	 * @Todo 		: 특례 시간 삭제
	 * @Date 		: 2015. 5. 27.
	 * @Return		: boolean 
	 */
	public boolean delSpecialTimeChargePolicy(ChargePolicyMgmtVO chargePolicyMgmtVO);
	
	/**
	 * @Todo 		: 벌점 정책 리스트
	 * @Date 		: 2015. 5. 26.
	 * @Return		: List<PenaltyPolicyMgmtVO> 
	 */
	public List<PenaltyPolicyMgmtVO> listPenaltyPolicy(PenaltyPolicyMgmtVO penaltyPolicyMgmtVO);
	
	/**
	 * @Todo 		: 벌점 정책 리스트 카운트
	 * @Date 		: 2015. 5. 26.
	 * @Return		: int 
	 */
	public int listPenaltyPolicyCount(PenaltyPolicyMgmtVO penaltyPolicyMgmtVO);
	
	/**
	 * @Todo 		: 벌점 코드 중복 체크
	 * @Date 		: 2015. 5. 26.
	 * @Return		: boolean 
	 */
	public boolean isPenaltyCdDupl(String penaltyCd);
	
	/**
	 * @Todo 		: 벌점 정책 등록
	 * @Date 		: 2015. 5. 26.
	 * @Return		: boolean 
	 */
	public boolean insertPenaltyPolicy(PenaltyPolicyMgmtVO penaltyPolicyMgmtVO);
	
	/**
	 * @Todo 		: 적용 벌점 체크
	 * @Date 		: 2015. 6. 1.
	 * @Return		: int 
	 */
	public boolean isPenaltyApply(String penaltyCd);
	
	/**
	 * @Todo 		: 벌점 정책 삭제
	 * @Date 		: 2015. 5. 26.
	 * @Return		: boolean 
	 */
	public boolean delPenaltyPolicy(PenaltyPolicyMgmtVO penaltyPolicyMgmtVO);
	
	/**
	 * @Todo 		: 벌점 정책 수정
	 * @Date 		: 2015. 5. 26.
	 * @Return		: boolean 
	 */
	public boolean modPenaltyPolicy(PenaltyPolicyMgmtVO penaltyPolicyMgmtVO);
	
	/**
	 * @Todo 		: 환승 정책 리스트
	 * @Date 		: 2015. 5. 26.
	 * @Return		: List<TransferPolicyMgmtVO> 
	 */
	public List<TransferPolicyMgmtVO> listTransferPolicy(TransferPolicyMgmtVO transferPolicyMgmtVO);
	
	/**
	 * @Todo 		: 벌점 정책 리스트 카운트
	 * @Date 		: 2015. 5. 26.
	 * @Return		: int 
	 */
	public int listTransferPolicyCount(TransferPolicyMgmtVO transferPolicyMgmtVO);
	
	/**
	 * @Todo 		: 환승 정책 기간 중복 체크
	 * @Date 		: 2015. 5. 26.
	 * @Return		: boolean 
	 */
	public boolean isTransferDateDupl(TransferPolicyMgmtVO transferPolicyMgmtVO);
	
	/**
	 * @Todo 		: 환승 정책 등록
	 * @Date 		: 2015. 5. 26.
	 * @Return		: boolean 
	 */
	public boolean insertTransferPolicy(TransferPolicyMgmtVO transferPolicyMgmtVO);
	
	/**
	 * @Todo 		: 환승 정책 삭제
	 * @Date 		: 2015. 5. 26.
	 * @Return		: boolean 
	 */
	public boolean delTransferPolicy(TransferPolicyMgmtVO transferPolicyMgmtVO);
	
	/**
	 * @Todo 		: 환승 정책 수정
	 * @Date 		: 2015. 5. 26.
	 * @Return		: boolean 
	 */
	public boolean modTransferPolicy(TransferPolicyMgmtVO transferPolicyMgmtVO);
	
	//프리미엄 요금제 사용여부_20160614_JJH
	/**
	 * @Todo 		: 프리미엄 이용권 사용여부
	 * @Date 		: 2016. 6. 14.
	 * @Return		: java.util.List<java.util.Map>
	 */
	public java.util.List<java.util.Map> premiumUseYnList();
	
	public int smsSendListCnt(MemberMgmtVO memberVo);
	
	public List<MemberMgmtVO> smsSendList(MemberMgmtVO memberVo);
	
	/*
	 * 장기 미반납 리스트
	 */
	public List<MemberMgmtVO> smsLongSendList(MemberMgmtVO memberVo);
	
	/*
	 * 장기 미반납 리스트
	 */
	public int smsLongSendListCnt(MemberMgmtVO memberVo);
	
	

	/*
	 * 장기 미반납 리스트
	 */
	public List<MemberMgmtVO> pushSendList(MemberMgmtVO memberVo);
	
	/*
	 * 장기 미반납 리스트
	 */
	public int pushSendListCnt(MemberMgmtVO memberVo);
}
