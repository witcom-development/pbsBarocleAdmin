package com.dkitec.barocle.admin.customer.survey.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

@Alias("surveyRspnsVO")
public class SurveyRspnsVO implements Serializable {
	
	// TABLE : TB_COM_QUSTNR_RSPNS_RESULT
	
	private static final long serialVersionUID = -5579046563660311552L;
	
	private String qustnrResRsltID;
	private int qustnrSeq;
	private String qustnrQesitmID;
	private String respondAnswerContent;
	private String etcAnswerContent;
	private String respondName;
	private String delYN;
	private java.util.Date regDttm;
	private String regID;
	private java.util.Date modDttm;
	private String modID;
	private String qustnrItemID;
	
	
	public SurveyRspnsVO(){
		this.delYN = "N";
	}
	
	
	public String getQustnrResRsltID() {
		return qustnrResRsltID;
	}

	public void setQustnrResRsltID(String qustnrResRsltID) {
		this.qustnrResRsltID = qustnrResRsltID;
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

	public String getRespondAnswerContent() {
		return respondAnswerContent;
	}

	public void setRespondAnswerContent(String respondAnswerContent) {
		this.respondAnswerContent = respondAnswerContent;
	}

	public String getEtcAnswerContent() {
		return etcAnswerContent;
	}

	public void setEtcAnswerContent(String etcAnswerContent) {
		this.etcAnswerContent = etcAnswerContent;
	}

	public String getRespondName() {
		return respondName;
	}

	public void setRespondName(String respondName) {
		this.respondName = respondName;
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

	public String getQustnrItemID() {
		return qustnrItemID;
	}

	public void setQustnrItemID(String qustnrItemID) {
		this.qustnrItemID = qustnrItemID;
	}
	
	@Override
	public String toString() {
		return "SurveyRspnsVO [qustnrResRsltID=" + qustnrResRsltID
				+ ", qustnrSeq=" + qustnrSeq + ", qustnrQesitmID="
				+ qustnrQesitmID + ", respondAnswerContent="
				+ respondAnswerContent + ", etcAnswerContent="
				+ etcAnswerContent + ", respondName=" + respondName
				+ ", delYN=" + delYN + ", regDttm=" + regDttm + ", regID="
				+ regID + ", modDttm=" + modDttm + ", modID=" + modID
				+ ", qustnrItemID=" + qustnrItemID + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}
	
}
