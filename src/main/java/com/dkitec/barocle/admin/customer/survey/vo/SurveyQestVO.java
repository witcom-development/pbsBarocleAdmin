package com.dkitec.barocle.admin.customer.survey.vo;

import java.io.Serializable;

import javax.validation.GroupSequence;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.ModeVO.GetMode;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO.SearchDateValidator;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;
import com.dkitec.barocle.util.validator.annotation.IsStringNumeric;

@Alias("surveyQestVO")
public class SurveyQestVO implements Serializable {
	
	// TABLE : TB_COM_QUSTNR_QESITM
	
	private static final long serialVersionUID = -8869944926168863759L;
	
	/*
	 * JSP에서 각 질문을 받을때 질문마다 list의 index가 정의 되어 있다.
	 * 질문 1,2,3을 등록하고 추후 2를 삭제하면 list.get(2)는 내용이 비어 있는 VO객체로 저장된다.
	 * flag 변수 값을 ""혹은 null로 하여 list의 해당 객체의 내용의 등록여부를 확인한다.
	 * 해당 객체가 유효하면 true값으로 한다.
	 */
	private String flag;
	private String action;
	
	@IsNumeric(groups={SurveyQestView.class,SurveyQestEdit.class,SurveyQestUpdate.class,SurveyQestDelete.class})
	private int qustnrSeq;
	@IsStringNumeric(groups={SurveyQestView.class,SurveyQestEdit.class,SurveyQestUpdate.class})
	private String qustnrQesitmID;
	@IsNumeric(groups={SurveyQestInsert.class,SurveyQestUpdate.class})
	private int qestnOrd;
	private String qestnTypeCD;
	@CheckValue(message="질문을 입력해 주세요.",groups={SurveyQestInsert.class,SurveyQestUpdate.class})
	private String qestnContent;
	private String delYN;
	private java.util.Date regDttm;
	private String regID;
	private java.util.Date modDttm;
	private String modID;
	private String etcYn;
	
	private java.util.List<SurveyQestItemVO> surveyQestItemVO;
	
	
	
	public String getEtcYn() {
		return etcYn;
	}


	public void setEtcYn(String etcYn) {
		this.etcYn = etcYn;
	}


	public SurveyQestVO(){
		this.delYN = "N";
	}
	
	
	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public int getQustnrSeq() {
		return qustnrSeq;
	}

	public void setQustnrSeq(int qustnrSeq) {
		this.qustnrSeq = qustnrSeq;
	}

	public String getQustnrQesitmID() {
		return qustnrQesitmID;
	}

	public void setQustnrQesitmID(String qustnrQesitmID) {
		this.qustnrQesitmID = qustnrQesitmID;
	}

	public int getQestnOrd() {
		return qestnOrd;
	}

	public void setQestnOrd(int qestnOrd) {
		this.qestnOrd = qestnOrd;
	}

	public String getQestnTypeCD() {
		return qestnTypeCD;
	}

	public void setQestnTypeCD(String qestnTypeCD) {
		this.qestnTypeCD = qestnTypeCD;
	}

	public String getQestnContent() {
		return qestnContent;
	}

	public void setQestnContent(String qestnContent) {
		this.qestnContent = qestnContent;
	}

	public String getDelYN() {
		return delYN;
	}

	public void setDelYN(String delYN) {
		this.delYN = delYN;
	}

	public java.util.Date getRegDttm() {
		return regDttm;
	}

	public void setRegDttm(java.util.Date regDttm) {
		this.regDttm = regDttm;
	}

	public String getRegID() {
		return regID;
	}

	public void setRegID(String regID) {
		this.regID = regID;
	}

	public java.util.Date getModDttm() {
		return modDttm;
	}

	public void setModDttm(java.util.Date modDttm) {
		this.modDttm = modDttm;
	}

	public String getModID() {
		return modID;
	}

	public void setModID(String modID) {
		this.modID = modID;
	}

	public java.util.List<SurveyQestItemVO> getSurveyQestItemVO() {
		return surveyQestItemVO;
	}

	public void setSurveyQestItemVO(
			java.util.List<SurveyQestItemVO> surveyQestItemVO) {
		this.surveyQestItemVO = surveyQestItemVO;
	}


	@Override
	public String toString() {
		return "SurveyQestVO [flag=" + flag + ", action=" + action
				+ ", qustnrSeq=" + qustnrSeq + ", qustnrQesitmID="
				+ qustnrQesitmID + ", qestnOrd=" + qestnOrd + ", qestnTypeCD="
				+ qestnTypeCD + ", qestnContent=" + qestnContent + ", delYN="
				+ delYN + ", regDttm=" + regDttm + ", regID=" + regID
				+ ", modDttm=" + modDttm + ", modID=" + modID + ", etcYn="
				+ etcYn + ", surveyQestItemVO=" + surveyQestItemVO
				+ ", getEtcYn()=" + getEtcYn() + ", getFlag()=" + getFlag()
				+ ", getAction()=" + getAction() + ", getQustnrSeq()="
				+ getQustnrSeq() + ", getQustnrQesitmID()="
				+ getQustnrQesitmID() + ", getQestnOrd()=" + getQestnOrd()
				+ ", getQestnTypeCD()=" + getQestnTypeCD()
				+ ", getQestnContent()=" + getQestnContent() + ", getDelYN()="
				+ getDelYN() + ", getRegDttm()=" + getRegDttm()
				+ ", getRegID()=" + getRegID() + ", getModDttm()="
				+ getModDttm() + ", getModID()=" + getModID()
				+ ", getSurveyQestItemVO()=" + getSurveyQestItemVO()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}


	private interface SurveyQestList{}
	private interface SurveyQestView{}
	private interface SurveyQestWrite{}
	private interface SurveyQestEdit{}
	private interface SurveyQestInsert{}
	private interface SurveyQestUpdate{}
	private interface SurveyQestDelete{}
	
	@GroupSequence({SurveyQestList.class,SearchDateValidator.class})
	public static interface SurveyQestListVal{}
	
	@GroupSequence({SurveyQestView.class})
	public static interface SurveyQestViewVal{}
	
	@GroupSequence({SurveyQestWrite.class})
	public static interface SurveyQestWriteVal{}
	
	@GroupSequence({SurveyQestEdit.class})
	public static interface SurveyQestEditVal{}
	
	@GroupSequence({GetMode.class,SurveyQestInsert.class,SurveyQestUpdate.class})
	public static interface SurveyQestPersistVal{}
	
	@GroupSequence({GetMode.class,SurveyQestDelete.class})
	public static interface SurveyQestDeleteVal{}
	
	@GroupSequence({GetMode.class,SurveyQestList.class,SurveyQestView.class,SurveyQestWrite.class,SurveyQestEdit.class,SurveyQestInsert.class,SurveyQestUpdate.class,SurveyQestDelete.class})
	public static interface SurveyQestAllVal{}
	
}
