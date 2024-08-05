package com.dkitec.barocle.admin.service.policyMgmt.vo;

import java.io.Serializable;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;

@SuppressWarnings("serial")
public class PenaltyPolicyMgmtVO extends PagingVO implements Serializable{

	@CheckValue(message="벌점 코드를 입력해주세요.",groups={penaltyInsertValid.class, penaltyUpdateValid.class, penaltyDeleteValid.class})
	private String penaltyCd;
	
	@CheckValue(message="벌점 명을 입력해주세요.",groups={penaltyInsertValid.class, penaltyUpdateValid.class})
	private String penaltyName;
	
	@IsNumeric(groups={penaltyInsertValid.class, penaltyUpdateValid.class})
	@CheckValue(message="벌점 점수를 입력해주세요.",groups={penaltyInsertValid.class, penaltyUpdateValid.class})
	private String penaltyPoint;
	private String useYn;
	private String regDttm;
	private String regId;
	private String modDttm;
	private String modId;
	private String penaltyContent;
	
	private String viewFlg;
	
	public String getPenaltyCd() {
		return penaltyCd;
	}

	public void setPenaltyCd(String penaltyCd) {
		this.penaltyCd = penaltyCd;
	}

	public String getPenaltyName() {
		return penaltyName;
	}

	public void setPenaltyName(String penaltyName) {
		this.penaltyName = penaltyName;
	}

	public String getPenaltyPoint() {
		return penaltyPoint;
	}

	public void setPenaltyPoint(String penaltyPoint) {
		this.penaltyPoint = penaltyPoint;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getRegDttm() {
		return regDttm;
	}

	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public String getModDttm() {
		return modDttm;
	}

	public void setModDttm(String modDttm) {
		this.modDttm = modDttm;
	}

	public String getModId() {
		return modId;
	}

	public void setModId(String modId) {
		this.modId = modId;
	}

	public String getViewFlg() {
		return viewFlg;
	}

	public void setViewFlg(String viewFlg) {
		this.viewFlg = viewFlg;
	}

	public String getPenaltyContent() {
		return penaltyContent;
	}

	public void setPenaltyContent(String penaltyContent) {
		this.penaltyContent = penaltyContent;
	}
	
	public static interface penaltyInsertValid{}
	public static interface penaltyUpdateValid{}
	public static interface penaltyDeleteValid{}
	
}
