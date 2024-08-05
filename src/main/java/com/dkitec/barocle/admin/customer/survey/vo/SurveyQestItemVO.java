package com.dkitec.barocle.admin.customer.survey.vo;

import java.io.Serializable;

import javax.validation.GroupSequence;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.ModeVO.GetMode;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO.SearchDateValidator;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;
import com.dkitec.barocle.util.validator.annotation.IsStringNumeric;

@Alias("surveyQestItemVO")
public class SurveyQestItemVO implements Serializable {
	
	// TABLE : TB_COM_QUSTNR_ITEM
	
	private static final long serialVersionUID = -7218718654899104730L;
	
	private String flag;
	private String action;
	
	@IsNumeric(groups={SurveyQestItemView.class,SurveyQestItemEdit.class,SurveyQestItemUpdate.class,SurveyQestItemDelete.class})
	private int qustnrSeq;
	@IsStringNumeric(groups={SurveyQestItemView.class,SurveyQestItemEdit.class,SurveyQestItemUpdate.class})
	private String qustnrQesitmID;
	@IsStringNumeric(groups={SurveyQestItemView.class,SurveyQestItemEdit.class,SurveyQestItemUpdate.class})
	private String qustnrItemID;
	private int itemOrd;
	@CheckValue(message="제목을 입력해 주세요.",groups={SurveyQestItemInsert.class,SurveyQestItemUpdate.class})
	private String itemContent;
	private String delYN;
	private java.util.Date regDttm;
	private String regID;
	private java.util.Date modDttm;
	private String modID;
	private String etcYn;
	
	
	
	public String getEtcYn() {
		return etcYn;
	}


	public void setEtcYn(String etcYn) {
		this.etcYn = etcYn;
	}


	public SurveyQestItemVO(){
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

	public String getQustnrItemID() {
		return qustnrItemID;
	}

	public void setQustnrItemID(String qustnrItemID) {
		this.qustnrItemID = qustnrItemID;
	}

	public int getItemOrd() {
		return itemOrd;
	}

	public void setItemOrd(int itemOrd) {
		this.itemOrd = itemOrd;
	}

	public String getItemContent() {
		return itemContent;
	}

	public void setItemContent(String itemContent) {
		this.itemContent = itemContent;
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
	

	
	@Override
	public String toString() {
		return "SurveyQestItemVO [flag=" + flag + ", action=" + action
				+ ", qustnrSeq=" + qustnrSeq + ", qustnrQesitmID="
				+ qustnrQesitmID + ", qustnrItemID=" + qustnrItemID
				+ ", itemOrd=" + itemOrd + ", itemContent=" + itemContent
				+ ", delYN=" + delYN + ", regDttm=" + regDttm + ", regID="
				+ regID + ", modDttm=" + modDttm + ", modID=" + modID
				+ ", etcYn=" + etcYn + ", getEtcYn()=" + getEtcYn()
				+ ", getFlag()=" + getFlag() + ", getAction()=" + getAction()
				+ ", getQustnrSeq()=" + getQustnrSeq()
				+ ", getQustnrQesitmID()=" + getQustnrQesitmID()
				+ ", getQustnrItemID()=" + getQustnrItemID()
				+ ", getItemOrd()=" + getItemOrd() + ", getItemContent()="
				+ getItemContent() + ", getDelYN()=" + getDelYN()
				+ ", getRegDttm()=" + getRegDttm() + ", getRegID()="
				+ getRegID() + ", getModDttm()=" + getModDttm()
				+ ", getModID()=" + getModID() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}



	private interface SurveyQestItemList{}
	private interface SurveyQestItemView{}
	private interface SurveyQestItemWrite{}
	private interface SurveyQestItemEdit{}
	private interface SurveyQestItemInsert{}
	private interface SurveyQestItemUpdate{}
	private interface SurveyQestItemDelete{}
	
	@GroupSequence({SurveyQestItemList.class,SearchDateValidator.class})
	public static interface SurveyQestItemListVal{}
	
	@GroupSequence({SurveyQestItemView.class})
	public static interface SurveyQestItemViewVal{}
	
	@GroupSequence({SurveyQestItemWrite.class})
	public static interface SurveyQestItemWriteVal{}
	
	@GroupSequence({SurveyQestItemEdit.class})
	public static interface SurveyQestItemEditVal{}
	
	@GroupSequence({GetMode.class,SurveyQestItemInsert.class,SurveyQestItemUpdate.class})
	public static interface SurveyQestItemPersistVal{}
	
	@GroupSequence({GetMode.class,SurveyQestItemDelete.class})
	public static interface SurveyQestItemDeleteVal{}
	
	@GroupSequence({GetMode.class,SurveyQestItemList.class,SurveyQestItemView.class,SurveyQestItemWrite.class,SurveyQestItemEdit.class,SurveyQestItemInsert.class,SurveyQestItemUpdate.class,SurveyQestItemDelete.class})
	public static interface SurveyQestItemAllVal{}
	
}
