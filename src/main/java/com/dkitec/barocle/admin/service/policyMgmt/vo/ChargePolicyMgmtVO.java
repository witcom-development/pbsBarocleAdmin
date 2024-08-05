package com.dkitec.barocle.admin.service.policyMgmt.vo;

import java.io.Serializable;
import java.util.List;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@SuppressWarnings("serial")
public class ChargePolicyMgmtVO extends PagingVO implements Serializable {

	private String rentFeeSeq;
	private List<String> rentFeeSeqList;
	private String paymentClsCd;
	private String rentFee;
	private List<String> rentFeeList;
	private String mileageUseYn;
	private List<String> mileageUseYnList;
		
	private String addFeeSeq;
	private List<String> addFeeSeqList;
	private String overStrMi;
	private List<String> overStrMiList;
	private String overEndMi;
	private List<String> overEndMiList;
	private String addFeeInterMi;
	private List<String> addFeeInterMiList;
	private String addFee;
	private List<String> addFeeList;
	private String addFeeCls;
	
	private String specialFeeSeq;
	private List<String> specialFeeSeqList;
	private String specialFeeClsCd;
	private List<String> specialFeeClsCdList;
	private String specialDay;
	private List<String> specialDayList;
	private String specialMM;
	private List<String> specialMMList;
	private String applyStrHH;
	private List<String> applyStrHHList;
	private String applyEndHH;
	private List<String> applyEndHHList;
	private String applyHHState;
	private List<String> applyHHStateList;
	private String specialFee;
	private List<String> specialFeeList;
	
	private String comCd;
	private String addVal1;
	private String addVal2;
	private String addVal3;
	
	private String cdDesc;
	
	//프리미엄 요금제 자전거 정책_20160620_JJH_START
	private String premiumSeason;
	private String premiumMday;
	
	//제로페이 요금감면 20190812
	private String discountFee;
	private String zeroPayDiscountFee;
	private List<String> discountFeeList;
	private List<String> zeroPayDiscountFeeList;
	
	//요금감면 추가 20191127
	private String meriterFee;
	private String bscLivFee;
	private String singleParentFee;
	private String youthFee;
	private List<String> meriterFeeList;
	private List<String> bscLivFeeList;
	private List<String> singleParentFeeList;
	private List<String> youthFeeList;
	
	//shoh2999 안전교육인증제
	private String disRate;
	private List<String> disRateList;
	
	public String getDiscountFee() {
		return discountFee;
	}
	public void setDiscountFee(String discountFee) {
		this.discountFee = discountFee;
	}
	public String getZeroPayDiscountFee() {
		return zeroPayDiscountFee;
	}
	public void setZeroPayDiscountFee(String zeroPayDiscountFee) {
		this.zeroPayDiscountFee = zeroPayDiscountFee;
	}
	public List<String> getDiscountFeeList() {
		return discountFeeList;
	}
	public void setDiscountFeeList(List<String> discountFeeList) {
		this.discountFeeList = discountFeeList;
	}
	public List<String> getZeroPayDiscountFeeList() {
		return zeroPayDiscountFeeList;
	}
	public void setZeroPayDiscountFeeList(List<String> zeroPayDiscountFeeList) {
		this.zeroPayDiscountFeeList = zeroPayDiscountFeeList;
	}
	public String getPremiumSeason() {
		return premiumSeason;
	}
	public void setPremiumSeason(String premiumSeason) {
		this.premiumSeason = premiumSeason;
	}
	public String getPremiumMday() {
		return premiumMday;
	}
	public void setPremiumMday(String premiumMday) {
		this.premiumMday = premiumMday;
	}
	// 요금 감면 추가 20191127
	
	public String getRentFeeSeq() {
		return rentFeeSeq;
	}
	public String getMeriterFee() {
		return meriterFee;
	}
	public void setMeriterFee(String meriterFee) {
		this.meriterFee = meriterFee;
	}
	public String getBscLivFee() {
		return bscLivFee;
	}
	public void setBscLivFee(String bscLivFee) {
		this.bscLivFee = bscLivFee;
	}
	public String getSingleParentFee() {
		return singleParentFee;
	}
	public void setSingleParentFee(String singleParentFee) {
		this.singleParentFee = singleParentFee;
	}
	public String getYouthFee() {
		return youthFee;
	}
	public void setYouthFee(String youthFee) {
		this.youthFee = youthFee;
	}
	public List<String> getMeriterFeeList() {
		return meriterFeeList;
	}
	public void setMeriterFeeList(List<String> meriterFeeList) {
		this.meriterFeeList = meriterFeeList;
	}
	public List<String> getBscLivFeeList() {
		return bscLivFeeList;
	}
	public void setBscLivFeeList(List<String> bscLivFeeList) {
		this.bscLivFeeList = bscLivFeeList;
	}
	public List<String> getSingleParentFeeList() {
		return singleParentFeeList;
	}
	public void setSingleParentFeeList(List<String> singleParentFeeList) {
		this.singleParentFeeList = singleParentFeeList;
	}
	public List<String> getYouthFeeList() {
		return youthFeeList;
	}
	public void setYouthFeeList(List<String> youthFeeList) {
		this.youthFeeList = youthFeeList;
	}
	
	//프리미엄 요금제 자전거 정책_20160620_JJH_END
	
	public void setRentFeeSeq(String rentFeeSeq) {
		this.rentFeeSeq = rentFeeSeq;
	}
	public String getRentFee() {
		return rentFee;
	}
	public void setRentFee(String rentFee) {
		this.rentFee = rentFee;
	}
	
	//마일리지 사용 여부 _ 20180207 dustjm
	public String getMileageUseYn() {
		return mileageUseYn;
	}
	public void setMileageUseYn(String mileageUseYn) {
		this.mileageUseYn = mileageUseYn;
	}
	public List<String> getMileageUseYnList() {
		return mileageUseYnList;
	}
	public void setMileageUseYnList(List<String> mileageUseYnList) {
		this.mileageUseYnList = mileageUseYnList;
	}
	public String getAddFeeSeq() {
		return addFeeSeq;
	}
	public void setAddFeeSeq(String addFeeSeq) {
		this.addFeeSeq = addFeeSeq;
	}
	public String getAddFee() {
		return addFee;
	}
	public void setAddFee(String addFee) {
		this.addFee = addFee;
	}
	public String getSpecialFeeSeq() {
		return specialFeeSeq;
	}
	public void setSpecialFeeSeq(String specialFeeSeq) {
		this.specialFeeSeq = specialFeeSeq;
	}
	public String getSpecialFeeClsCd() {
		return specialFeeClsCd;
	}
	public void setSpecialFeeClsCd(String specialFeeClsCd) {
		this.specialFeeClsCd = specialFeeClsCd;
	}
	public String getSpecialDay() {
		return specialDay;
	}
	public void setSpecialDay(String specialDay) {
		this.specialDay = specialDay;
	}
	public String getSpecialMM() {
		return specialMM;
	}
	public void setSpecialMM(String specialMM) {
		this.specialMM = specialMM;
	}
	public String getApplyStrHH() {
		return applyStrHH;
	}
	public void setApplyStrHH(String applyStrHH) {
		this.applyStrHH = applyStrHH;
	}
	public String getApplyEndHH() {
		return applyEndHH;
	}
	public void setApplyEndHH(String applyEndHH) {
		this.applyEndHH = applyEndHH;
	}
	public String getSpecialFee() {
		return specialFee;
	}
	public void setSpecialFee(String specialFee) {
		this.specialFee = specialFee;
	}
	public String getAddFeeInterMi() {
		return addFeeInterMi;
	}
	public void setAddFeeInterMi(String addFeeInterMi) {
		this.addFeeInterMi = addFeeInterMi;
	}
	public String getAddFeeCls() {
		return addFeeCls;
	}
	public void setAddFeeCls(String addFeeCls) {
		this.addFeeCls = addFeeCls;
	}
	public String getOverStrMi() {
		return overStrMi;
	}
	public void setOverStrMi(String overStrMi) {
		this.overStrMi = overStrMi;
	}
	public String getOverEndMi() {
		return overEndMi;
	}
	public void setOverEndMi(String overEndMi) {
		this.overEndMi = overEndMi;
	}
	public String getPaymentClsCd() {
		return paymentClsCd;
	}
	public void setPaymentClsCd(String paymentClsCd) {
		this.paymentClsCd = paymentClsCd;
	}
	public String getComCd() {
		return comCd;
	}
	public void setComCd(String comCd) {
		this.comCd = comCd;
	}
	public String getAddVal1() {
		return addVal1;
	}
	public void setAddVal1(String addVal1) {
		this.addVal1 = addVal1;
	}
	public List<String> getRentFeeSeqList() {
		return rentFeeSeqList;
	}
	public void setRentFeeSeqList(List<String> rentFeeSeqList) {
		this.rentFeeSeqList = rentFeeSeqList;
	}
	public List<String> getRentFeeList() {
		return rentFeeList;
	}
	public void setRentFeeList(List<String> rentFeeList) {
		this.rentFeeList = rentFeeList;
	}
	public List<String> getAddFeeSeqList() {
		return addFeeSeqList;
	}
	public void setAddFeeSeqList(List<String> addFeeSeqList) {
		this.addFeeSeqList = addFeeSeqList;
	}
	public List<String> getOverStrMiList() {
		return overStrMiList;
	}
	public void setOverStrMiList(List<String> overStrMiList) {
		this.overStrMiList = overStrMiList;
	}
	public List<String> getOverEndMiList() {
		return overEndMiList;
	}
	public void setOverEndMiList(List<String> overEndMiList) {
		this.overEndMiList = overEndMiList;
	}
	public List<String> getAddFeeInterMiList() {
		return addFeeInterMiList;
	}
	public void setAddFeeInterMiList(List<String> addFeeInterMiList) {
		this.addFeeInterMiList = addFeeInterMiList;
	}
	public List<String> getAddFeeList() {
		return addFeeList;
	}
	public void setAddFeeList(List<String> addFeeList) {
		this.addFeeList = addFeeList;
	}
	public List<String> getSpecialFeeSeqList() {
		return specialFeeSeqList;
	}
	public void setSpecialFeeSeqList(List<String> specialFeeSeqList) {
		this.specialFeeSeqList = specialFeeSeqList;
	}
	public List<String> getSpecialDayList() {
		return specialDayList;
	}
	public void setSpecialDayList(List<String> specialDayList) {
		this.specialDayList = specialDayList;
	}
	public List<String> getSpecialMMList() {
		return specialMMList;
	}
	public void setSpecialMMList(List<String> specialMMList) {
		this.specialMMList = specialMMList;
	}
	public List<String> getApplyStrHHList() {
		return applyStrHHList;
	}
	public void setApplyStrHHList(List<String> applyStrHHList) {
		this.applyStrHHList = applyStrHHList;
	}
	public List<String> getApplyEndHHList() {
		return applyEndHHList;
	}
	public void setApplyEndHHList(List<String> applyEndHHList) {
		this.applyEndHHList = applyEndHHList;
	}
	public String getApplyHHState() {
		return applyHHState;
	}
	public void setApplyHHState(String applyHHState) {
		this.applyHHState = applyHHState;
	}
	public List<String> getApplyHHStateList() {
		return applyHHStateList;
	}
	public void setApplyHHStateList(List<String> applyHHStateList) {
		this.applyHHStateList = applyHHStateList;
	}
	public List<String> getSpecialFeeList() {
		return specialFeeList;
	}
	public void setSpecialFeeList(List<String> specialFeeList) {
		this.specialFeeList = specialFeeList;
	}
	public List<String> getSpecialFeeClsCdList() {
		return specialFeeClsCdList;
	}
	public void setSpecialFeeClsCdList(List<String> specialFeeClsCdList) {
		this.specialFeeClsCdList = specialFeeClsCdList;
	}
	
	public String getCdDesc() {
		return cdDesc;
	}
	public void setCdDesc(String cdDesc) {
		this.cdDesc = cdDesc;
	}
	
	public String getAddVal2() {
		return addVal2;
	}
	public void setAddVal2(String addVal2) {
		this.addVal2 = addVal2;
	}
	public String getAddVal3() {
		return addVal3;
	}
	public void setAddVal3(String addVal3) {
		this.addVal3 = addVal3;
	}
	public String getDisRate() {
		return disRate;
	}
	public void setDisRate(String disRate) {
		this.disRate = disRate;
	}
	public List<String> getDisRateList() {
		return disRateList;
	}
	public void setDisRateList(List<String> disRateList) {
		this.disRateList = disRateList;
	}
	@Override
	public String toString() {
		return "ChargePolicyMgmtVO [rentFeeSeq=" + rentFeeSeq
				+ ", rentFeeSeqList=" + rentFeeSeqList + ", paymentClsCd="
				+ paymentClsCd + ", rentFee=" + rentFee + ", rentFeeList="
				+ rentFeeList + ", addFeeSeq=" + addFeeSeq + ", addFeeSeqList="
				+ addFeeSeqList + ", overStrMi=" + overStrMi +", mileageUseYn="
				+ mileageUseYn + ", mileageUseYnList=" + mileageUseYnList
				+ ", overStrMiList=" + overStrMiList + ", overEndMi="
				+ overEndMi + ", overEndMiList=" + overEndMiList
				+ ", addFeeInterMi=" + addFeeInterMi + ", addFee=" + addFee
				+ ", addFeeList=" + addFeeList + ", addFeeCls=" + addFeeCls
				+ ", specialFeeSeq=" + specialFeeSeq + ", specialFeeSeqList="
				+ specialFeeSeqList + ", specialFeeClsCd=" + specialFeeClsCd
				+ ", specialFeeClsCdList=" + specialFeeClsCdList
				+ ", specialDay=" + specialDay + ", specialDayList="
				+ specialDayList + ", specialMM=" + specialMM
				+ ", specialMMList=" + specialMMList + ", applyStrHH="
				+ applyStrHH + ", applyStrHHList=" + applyStrHHList
				+ ", applyEndHH=" + applyEndHH + ", applyEndHHList="
				+ applyEndHHList + ", applyHHState=" + applyHHState
				+ ", applyHHStateList=" + applyHHStateList + ", specialFee="
				+ specialFee + ", specialFeeList=" + specialFeeList
				+ ", addFeeInterMiList=" + addFeeInterMiList
				+ ", comCd=" + comCd + ", addVal1=" + addVal1 + ", cdDesc="
				+ cdDesc 
				+ ", discountFeeList=" + discountFeeList + ", zeroPayDiscountFeeList=" + zeroPayDiscountFeeList
				+ ", meriterFeeList=" + meriterFeeList + ", bscLivFeeList=" + bscLivFeeList
				+ ", singleParentFeeList=" + singleParentFeeList + ", youthFeeList=" + youthFeeList
				+ ", disRate=" + disRate + ", disRateList=" + disRateList
				+ "]";
	}

	public static interface chargeUpdateValid{}
	public static interface specialChargeDeleteValid{}
}
