package com.dkitec.barocle.admin.service.policyMgmt.vo;

import java.io.Serializable;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.IsDate;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;

@SuppressWarnings("serial")
public class TransferPolicyMgmtVO extends PagingVO implements Serializable {

	@IsNumeric(groups={transferUpdateValid.class, transferDeleteValid.class})
	@CheckValue(message="벌점 일련번호를 입력해주세요.",groups={transferUpdateValid.class, transferDeleteValid.class})
	private String transferPolicySeq;
	
	@IsDate(groups={transferInsertValid.class, transferUpdateValid.class})
	@CheckValue(message="적용 시작시간을 입력해주세요.",groups={transferInsertValid.class, transferUpdateValid.class})
	private String applyStrDate;
	
	@IsDate(groups={transferInsertValid.class, transferUpdateValid.class})
	@CheckValue(message="적용 종료시간을 입력해주세요.",groups={transferInsertValid.class, transferUpdateValid.class})
	private String applyEndDate;
	
	@IsNumeric(groups={transferInsertValid.class, transferUpdateValid.class})
	@CheckValue(message="일 최대 적립 포인트를 입력해주세요.",groups={transferInsertValid.class, transferUpdateValid.class})
	private String ddMaxAccMileage;
	
	@IsNumeric(groups={transferInsertValid.class, transferUpdateValid.class})
	@CheckValue(message="월 최대 적립 포인트를 입력해주세요.",groups={transferInsertValid.class, transferUpdateValid.class})
	private String mmMaxAccMileage;
	
	@IsNumeric(groups={transferInsertValid.class, transferUpdateValid.class})
	@CheckValue(message="년 최대 적립 포인트를 입력해주세요.",groups={transferInsertValid.class, transferUpdateValid.class})
	private String yyMaxAccMileage;
	
	@IsNumeric(groups={transferInsertValid.class, transferUpdateValid.class})
	@CheckValue(message="1회 적립 포인트를 입력해주세요.",groups={transferInsertValid.class, transferUpdateValid.class})
	private String tmsAccMileage;
	
	@IsNumeric(groups={transferInsertValid.class, transferUpdateValid.class})
	@CheckValue(message="환승 범위를 입력해주세요.",groups={transferInsertValid.class, transferUpdateValid.class})
	private String transferRangeMi;
	
	@IsNumeric(groups={transferInsertValid.class, transferUpdateValid.class})
	@CheckValue(message="일 최대 적립 회수를 입력해주세요.",groups={transferInsertValid.class, transferUpdateValid.class})
	private String ddMaxAccCnt;
	
	@IsNumeric(groups={transferInsertValid.class, transferUpdateValid.class})
	@CheckValue(message="최소 사용 포인트를 입력해주세요.",groups={transferInsertValid.class, transferUpdateValid.class})
	private String minUseMileage;
	
	@IsNumeric(groups={transferInsertValid.class, transferUpdateValid.class})
	@CheckValue(message="최대 사용 포인트를 입력해주세요.",groups={transferInsertValid.class, transferUpdateValid.class})
	private String maxUseMileage;
	
	@IsNumeric(groups={transferInsertValid.class, transferUpdateValid.class})
	@CheckValue(message="포인트 기준을 입력해주세요.",groups={transferInsertValid.class, transferUpdateValid.class})
	private String mileageStandard;
	
	private String viewFlg;
	
	public String getTransferPolicySeq() {
		return transferPolicySeq;
	}
	public void setTransferPolicySeq(String transferPolicySeq) {
		this.transferPolicySeq = transferPolicySeq;
	}
	public String getApplyStrDate() {
		return applyStrDate;
	}
	public void setApplyStrDate(String applyStrDate) {
		this.applyStrDate = applyStrDate;
	}
	public String getApplyEndDate() {
		return applyEndDate;
	}
	public void setApplyEndDate(String applyEndDate) {
		this.applyEndDate = applyEndDate;
	}
	public String getDdMaxAccMileage() {
		return ddMaxAccMileage;
	}
	public void setDdMaxAccMileage(String ddMaxAccMileage) {
		this.ddMaxAccMileage = ddMaxAccMileage;
	}
	public String getMmMaxAccMileage() {
		return mmMaxAccMileage;
	}
	public void setMmMaxAccMileage(String mmMaxAccMileage) {
		this.mmMaxAccMileage = mmMaxAccMileage;
	}
	public String getYyMaxAccMileage() {
		return yyMaxAccMileage;
	}
	public void setYyMaxAccMileage(String yyMaxAccMileage) {
		this.yyMaxAccMileage = yyMaxAccMileage;
	}
	public String getTmsAccMileage() {
		return tmsAccMileage;
	}
	public void setTmsAccMileage(String tmsAccMileage) {
		this.tmsAccMileage = tmsAccMileage;
	}
	public String getTransferRangeMi() {
		return transferRangeMi;
	}
	public void setTransferRangeMi(String transferRangeMi) {
		this.transferRangeMi = transferRangeMi;
	}
	public String getDdMaxAccCnt() {
		return ddMaxAccCnt;
	}
	public void setDdMaxAccCnt(String ddMaxAccCnt) {
		this.ddMaxAccCnt = ddMaxAccCnt;
	}
	public String getMinUseMileage() {
		return minUseMileage;
	}
	public void setMinUseMileage(String minUseMileage) {
		this.minUseMileage = minUseMileage;
	}
	public String getMaxUseMileage() {
		return maxUseMileage;
	}
	public void setMaxUseMileage(String maxUseMileage) {
		this.maxUseMileage = maxUseMileage;
	}
	public String getMileageStandard() {
		return mileageStandard;
	}
	public void setMileageStandard(String mileageStandard) {
		this.mileageStandard = mileageStandard;
	}
	public String getViewFlg() {
		return viewFlg;
	}
	public void setViewFlg(String viewFlg) {
		this.viewFlg = viewFlg;
	}
	
	public static interface transferInsertValid{}
	public static interface transferUpdateValid{}
	public static interface transferDeleteValid{}
	
}
