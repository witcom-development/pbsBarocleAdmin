package com.dkitec.barocle.admin.service.policyMgmt.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.membermgmt.vo.MemberMgmtVO;
import com.dkitec.barocle.admin.service.policyMgmt.service.PolicyMgmtMapper;
import com.dkitec.barocle.admin.service.policyMgmt.service.PolicyMgmtService;
import com.dkitec.barocle.admin.service.policyMgmt.vo.ChargePolicyMgmtVO;
import com.dkitec.barocle.admin.service.policyMgmt.vo.PenaltyPolicyMgmtVO;
import com.dkitec.barocle.admin.service.policyMgmt.vo.TransferPolicyMgmtVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("policyMgmtService")
public class PolicyMgmtServiceImpl extends EgovAbstractServiceImpl implements PolicyMgmtService {
	protected static Logger log = LoggerFactory.getLogger(PolicyMgmtServiceImpl.class);

	@Autowired private PolicyMgmtMapper policyMgmtMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ChargePolicyMgmtVO> listRentChargePolicy() {
		return policyMgmtMapper.listRentChargePolicy();
	}
	
	//프리미엄 요금 정책 리스트_20160614_JJH
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ChargePolicyMgmtVO> listPremiumRentChargePolicy() {
		return policyMgmtMapper.listPremiumRentChargePolicy();
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ChargePolicyMgmtVO> listAddChargePolicy() {
		return policyMgmtMapper.listAddChargePolicy();
	}
	
	//프리미엄 추가 요금 정책 리스트_20160614_JJH
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ChargePolicyMgmtVO> listAddPremiumChargePolicy() {
		return policyMgmtMapper.listAddPremiumChargePolicy();
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ChargePolicyMgmtVO> listSpecialChargePolicy(String paymentClsCd) {
		return policyMgmtMapper.listSpecialChargePolicy(paymentClsCd);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ChargePolicyMgmtVO> listRentMM() {
		return policyMgmtMapper.listRentMM();
	}
	
	//프리미엄 요금제 자전거 정책_20160614_JJH
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ChargePolicyMgmtVO> PremiumlistRentMM() {
		return policyMgmtMapper.PremiumlistRentMM();
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public boolean modChargePolicy(ChargePolicyMgmtVO chargePolicyMgmtVO) {
		
		//프리미엄 요금제 사용유무 수정
		if(chargePolicyMgmtVO.getPremiumSeason() != null){
			policyMgmtMapper.updatePremiumSeasonUseYn(chargePolicyMgmtVO);
			policyMgmtMapper.updatePremiumMdayUseYn(chargePolicyMgmtVO);
		}
		
		//일반 요금 정책 수정
		if(chargePolicyMgmtVO.getRentFeeSeqList() != null) {
			ChargePolicyMgmtVO rentChargePolicyMgmtVO = null;
			for(int i=0;i<chargePolicyMgmtVO.getRentFeeSeqList().size();i++) {
				rentChargePolicyMgmtVO = new ChargePolicyMgmtVO();
				rentChargePolicyMgmtVO.setRentFeeSeq(chargePolicyMgmtVO.getRentFeeSeqList().get(i));
				rentChargePolicyMgmtVO.setRentFee(chargePolicyMgmtVO.getRentFeeList().get(i));
				//요금할인 추가 201908112 dwyoon
				rentChargePolicyMgmtVO.setDiscountFee(chargePolicyMgmtVO.getDiscountFeeList().get(i));
				rentChargePolicyMgmtVO.setZeroPayDiscountFee(chargePolicyMgmtVO.getZeroPayDiscountFeeList().get(i));
				//요금감면 추가 20191127 dwyoon
				rentChargePolicyMgmtVO.setMeriterFee(chargePolicyMgmtVO.getMeriterFeeList().get(i));
				rentChargePolicyMgmtVO.setBscLivFee(chargePolicyMgmtVO.getBscLivFeeList().get(i));
				rentChargePolicyMgmtVO.setSingleParentFee(chargePolicyMgmtVO.getSingleParentFeeList().get(i));
				rentChargePolicyMgmtVO.setYouthFee(chargePolicyMgmtVO.getYouthFeeList().get(i));
				// 마일리지 사용 여부 추가 20180207 dustjm
				if(chargePolicyMgmtVO.getMileageUseYnList() != null) {
					for(int ii=0; ii<chargePolicyMgmtVO.getMileageUseYnList().size(); ii++) {
						if (chargePolicyMgmtVO.getMileageUseYnList().get(ii).equals(rentChargePolicyMgmtVO.getRentFeeSeq())) {
							rentChargePolicyMgmtVO.setMileageUseYn("Y");
						}
					}
				}
				if(policyMgmtMapper.modRentChargePolicy(rentChargePolicyMgmtVO) == 0)
					return false;
			}
		}
		
		//특례 요금 정책 수정
		int stateListIdx = 0;
		if(chargePolicyMgmtVO.getSpecialFeeSeqList() != null) {
			ChargePolicyMgmtVO specialChargePolicyMgmtVO = null;
			for(int i=0;i<chargePolicyMgmtVO.getSpecialFeeSeqList().size();i++) {
				specialChargePolicyMgmtVO = new ChargePolicyMgmtVO();
				specialChargePolicyMgmtVO.setSpecialFeeSeq(chargePolicyMgmtVO.getSpecialFeeSeqList().get(i));
				specialChargePolicyMgmtVO.setSpecialFee(chargePolicyMgmtVO.getSpecialFeeList().get(i));
				
				if("SDV_001".equals(chargePolicyMgmtVO.getSpecialFeeClsCdList().get(i))) {
					specialChargePolicyMgmtVO.setApplyStrHH(chargePolicyMgmtVO.getApplyStrHHList().get(stateListIdx));
					specialChargePolicyMgmtVO.setApplyEndHH(chargePolicyMgmtVO.getApplyEndHHList().get(stateListIdx));

					if("I".equals(chargePolicyMgmtVO.getApplyHHStateList().get(stateListIdx))) {
						specialChargePolicyMgmtVO.setPaymentClsCd(chargePolicyMgmtVO.getPaymentClsCd());
						
						if(policyMgmtMapper.insertSpecialTimeChargePolicy(specialChargePolicyMgmtVO) == 0)
							return false;
						
						stateListIdx++;
						continue;
					}
					stateListIdx++;
				}
				
				if(policyMgmtMapper.modSpecialChargePolicy(specialChargePolicyMgmtVO) == 0)
					return false;
			}
		}
		
		//추가 요금 정책 수정
		if(chargePolicyMgmtVO.getAddFeeSeqList() != null) {
			ChargePolicyMgmtVO addChargePolicyMgmtVO = null;
			for(int i=0;i<chargePolicyMgmtVO.getAddFeeSeqList().size();i++) {
				addChargePolicyMgmtVO = new ChargePolicyMgmtVO();
				addChargePolicyMgmtVO.setAddFeeSeq(chargePolicyMgmtVO.getAddFeeSeqList().get(i));
				addChargePolicyMgmtVO.setOverStrMi(chargePolicyMgmtVO.getOverStrMiList().get(i));
				addChargePolicyMgmtVO.setAddFeeInterMi(chargePolicyMgmtVO.getAddFeeInterMiList().get(i));
				if(i != chargePolicyMgmtVO.getAddFeeSeqList().size()-1)
					addChargePolicyMgmtVO.setOverEndMi(chargePolicyMgmtVO.getOverEndMiList().get(i));
				addChargePolicyMgmtVO.setAddFee(chargePolicyMgmtVO.getAddFeeList().get(i));
				
				if(policyMgmtMapper.modAddChargePolicy(addChargePolicyMgmtVO) == 0)
					return false;
			}
		}
		
		return true;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public boolean delSpecialTimeChargePolicy(ChargePolicyMgmtVO chargePolicyMgmtVO) {
		return policyMgmtMapper.delSpecialTimeChargePolicy(chargePolicyMgmtVO) > 0 ? true : false;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<PenaltyPolicyMgmtVO> listPenaltyPolicy(PenaltyPolicyMgmtVO penaltyPolicyMgmtVO) {
		return policyMgmtMapper.listPenaltyPolicy(penaltyPolicyMgmtVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int listPenaltyPolicyCount(PenaltyPolicyMgmtVO penaltyPolicyMgmtVO) {
		return policyMgmtMapper.listPenaltyPolicyCount(penaltyPolicyMgmtVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean isPenaltyCdDupl(String penaltyCd) {
		return policyMgmtMapper.isPenaltyCdDupl(penaltyCd) > 0 ? true : false;
	}
	
	//프리미엄 요금제 사용여부_20160614_JJH
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public java.util.List<java.util.Map> premiumUseYnList(){
		return policyMgmtMapper.premiumUseYnList();
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public boolean insertPenaltyPolicy(PenaltyPolicyMgmtVO penaltyPolicyMgmtVO) {
		return policyMgmtMapper.insertPenaltyPolicy(penaltyPolicyMgmtVO) > 0 ? true : false;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean isPenaltyApply(String penaltyCd) {
		return policyMgmtMapper.isPenaltyApply(penaltyCd) > 0 ? true : false;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public boolean delPenaltyPolicy(PenaltyPolicyMgmtVO penaltyPolicyMgmtVO) {
		return policyMgmtMapper.delPenaltyPolicy(penaltyPolicyMgmtVO) > 0 ? true : false;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public boolean modPenaltyPolicy(PenaltyPolicyMgmtVO penaltyPolicyMgmtVO) {
		return policyMgmtMapper.modPenaltyPolicy(penaltyPolicyMgmtVO) > 0 ? true : false;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<TransferPolicyMgmtVO> listTransferPolicy(TransferPolicyMgmtVO transferPolicyMgmtVO) {
		return policyMgmtMapper.listTransferPolicy(transferPolicyMgmtVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int listTransferPolicyCount(TransferPolicyMgmtVO transferPolicyMgmtVO) {
		return policyMgmtMapper.listTransferPolicyCount(transferPolicyMgmtVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean isTransferDateDupl(TransferPolicyMgmtVO transferPolicyMgmtVO) {
		return policyMgmtMapper.isTransferDateDupl(transferPolicyMgmtVO) > 0 ? true : false;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public boolean insertTransferPolicy(TransferPolicyMgmtVO transferPolicyMgmtVO) {
		policyMgmtMapper.modRecentTransferPolicy(transferPolicyMgmtVO);
		return policyMgmtMapper.insertTransferPolicy(transferPolicyMgmtVO) > 0 ? true : false;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public boolean delTransferPolicy(TransferPolicyMgmtVO transferPolicyMgmtVO) {
		return policyMgmtMapper.delTransferPolicy(transferPolicyMgmtVO) > 0 ? true : false;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public boolean modTransferPolicy(TransferPolicyMgmtVO transferPolicyMgmtVO) {
		return policyMgmtMapper.modTransferPolicy(transferPolicyMgmtVO) > 0 ? true : false;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE02)
	public int smsSendListCnt(MemberMgmtVO memberVo) {
		return policyMgmtMapper.smsSendListCnt(memberVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE02)
	public List<MemberMgmtVO> smsSendList(MemberMgmtVO memberMgmtVO) {
		// TODO Auto-generated method stub
		List<MemberMgmtVO> resultList = policyMgmtMapper.smsSendList(memberMgmtVO);
		return resultList;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MMSDB)
	public List<MemberMgmtVO> smsLongSendList(MemberMgmtVO memberVo) {
		List<MemberMgmtVO> resultList = policyMgmtMapper.smsLongSendList(memberVo);
		return resultList;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MMSDB)	
	public int smsLongSendListCnt(MemberMgmtVO memberVo) {
		int resultList = policyMgmtMapper.smsLongSendListCnt(memberVo);
		return resultList;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.PUSH)
	public List<MemberMgmtVO> pushSendList(MemberMgmtVO memberVo) {
		// TODO Auto-generated method stub
		return policyMgmtMapper.pushSendList(memberVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.PUSH)
	public int pushSendListCnt(MemberMgmtVO memberVo) {
		// TODO Auto-generated method stub
		return policyMgmtMapper.pushSendListCnt(memberVo);
	}


}
