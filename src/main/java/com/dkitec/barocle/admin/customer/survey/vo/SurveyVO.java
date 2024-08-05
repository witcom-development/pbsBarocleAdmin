package com.dkitec.barocle.admin.customer.survey.vo;

import java.io.Serializable;

import javax.validation.GroupSequence;
import javax.validation.constraints.NotNull;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;
import com.dkitec.barocle.util.validator.annotation.SearchDate;

@Alias("surveyVO")
@SearchDate(groups=PagingVO.SearchDateValidator.class)
public class SurveyVO extends PagingVO implements Serializable{
	
	// TABLE : TB_COM_QESTNR_INFO
	
	private static final long serialVersionUID = 2963918400861863110L;
	
	@IsNumeric(groups={SurveyView.class,SurveyUpdate.class,SurveyDelete.class})
	private int qustnrSeq;
	private String cateCD;
	@CheckValue(message="제목을 입력해 주세요.",groups={SurveyInsert.class,SurveyUpdate.class})
	private String qustnrTitle;
	private String qustnrPurps;
	@CheckValue(message="질문을 입력해 주세요.",groups={SurveyInsert.class,SurveyUpdate.class})
	private String qustnrWritngGuideContent;
	@NotNull(message="설문 시작 날짜를 입력해주세요.",groups={SurveyInsert.class,SurveyUpdate.class})
	private java.util.Date qustnrStrDttm;
	@NotNull(message="설문 시작 날짜를 입력해주세요.",groups={SurveyInsert.class,SurveyUpdate.class})
	private java.util.Date qustnrEndDttm;
	private String atchFileID;
	private String delYN;
	private java.util.Date regDttm;
	private String regID;
	private java.util.Date modDttm;
	private String modID;
	private String etcYn;
	private String qestnOrd;
	
	private String popqustnrItemID;
	private String itemContent;
	
	private java.util.List<SurveyQestVO> surveyQestVO;
	
	private java.util.List<String> imageList;		// 이미지 URL 목록
	private String attach_image_info;
	private String borTextContent;
	private String borHTMLContent;
	
	
	
	
	public java.util.List<String> getImageList() {
		return imageList;
	}


	public void setImageList(java.util.List<String> imageList) {
		this.imageList = imageList;
	}


	public String getAttach_image_info() {
		return attach_image_info;
	}


	public void setAttach_image_info(String attach_image_info) {
		this.attach_image_info = attach_image_info;
	}


	public String getBorTextContent() {
		return borTextContent;
	}


	public void setBorTextContent(String borTextContent) {
		this.borTextContent = borTextContent;
	}


	public String getBorHTMLContent() {
		return borHTMLContent;
	}


	public void setBorHTMLContent(String borHTMLContent) {
		this.borHTMLContent = borHTMLContent;
	}


	public String getItemContent() {
		return itemContent;
	}


	public void setItemContent(String itemContent) {
		this.itemContent = itemContent;
	}


	public String getPopqustnrItemID() {
		return popqustnrItemID;
	}


	public void setPopqustnrItemID(String popqustnrItemID) {
		this.popqustnrItemID = popqustnrItemID;
	}


	public String getQestnOrd() {
		return qestnOrd;
	}


	public void setQestnOrd(String qestnOrd) {
		this.qestnOrd = qestnOrd;
	}


	public String getEtcYn() {
		return etcYn;
	}


	public void setEtcYn(String etcYn) {
		this.etcYn = etcYn;
	}


	public SurveyVO(){
		this.delYN = "N";
	}
	
	
	public int getQustnrSeq() {
		return qustnrSeq;
	}

	public void setQustnrSeq(int qustnrSeq) {
		this.qustnrSeq = qustnrSeq;
	}

	public String getCateCD() {
		return cateCD;
	}

	public void setCateCD(String cateCD) {
		this.cateCD = cateCD;
	}

	public String getQustnrTitle() {
		return qustnrTitle;
	}

	public void setQustnrTitle(String qustnrTitle) {
		this.qustnrTitle = qustnrTitle;
	}

	public String getQustnrPurps() {
		return qustnrPurps;
	}

	public void setQustnrPurps(String qustnrPurps) {
		this.qustnrPurps = qustnrPurps;
	}

	public String getQustnrWritngGuideContent() {
		return qustnrWritngGuideContent;
	}

	public void setQustnrWritngGuideContent(String qustnrWritngGuideContent) {
		this.qustnrWritngGuideContent = qustnrWritngGuideContent;
	}

	public java.util.Date getQustnrStrDttm() {
		return qustnrStrDttm;
	}

	public void setQustnrStrDttm(java.util.Date qustnrStrDttm) {
		this.qustnrStrDttm = qustnrStrDttm;
	}

	public java.util.Date getQustnrEndDttm() {
		return qustnrEndDttm;
	}

	public void setQustnrEndDttm(java.util.Date qustnrEndDttm) {
		this.qustnrEndDttm = qustnrEndDttm;
	}

	public String getAtchFileID() {
		return atchFileID;
	}

	public void setAtchFileID(String atchFileID) {
		this.atchFileID = atchFileID;
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

	public java.util.List<SurveyQestVO> getSurveyQestVO() {
		return surveyQestVO;
	}

	public void setSurveyQestVO(java.util.List<SurveyQestVO> surveyQestVO) {
		this.surveyQestVO = surveyQestVO;
	}
	
	
	
	@Override
	public String toString() {
		return "SurveyVO [qustnrSeq=" + qustnrSeq + ", cateCD=" + cateCD
				+ ", qustnrTitle=" + qustnrTitle + ", qustnrPurps="
				+ qustnrPurps + ", qustnrWritngGuideContent="
				+ qustnrWritngGuideContent + ", qustnrStrDttm=" + qustnrStrDttm
				+ ", qustnrEndDttm=" + qustnrEndDttm + ", atchFileID="
				+ atchFileID + ", delYN=" + delYN + ", regDttm=" + regDttm
				+ ", regID=" + regID + ", modDttm=" + modDttm + ", modID="
				+ modID + ", etcYn=" + etcYn + ", surveyQestVO=" + surveyQestVO
				+ ", getEtcYn()=" + getEtcYn() + ", getQustnrSeq()="
				+ getQustnrSeq() + ", getCateCD()=" + getCateCD()
				+ ", getQustnrTitle()=" + getQustnrTitle()
				+ ", getQustnrPurps()=" + getQustnrPurps()
				+ ", getQustnrWritngGuideContent()="
				+ getQustnrWritngGuideContent() + ", getQustnrStrDttm()="
				+ getQustnrStrDttm() + ", getQustnrEndDttm()="
				+ getQustnrEndDttm() + ", getAtchFileID()=" + getAtchFileID()
				+ ", getDelYN()=" + getDelYN() + ", getRegDttm()="
				+ getRegDttm() + ", getRegID()=" + getRegID()
				+ ", getModDttm()=" + getModDttm() + ", getModID()="
				+ getModID() + ", getSurveyQestVO()=" + getSurveyQestVO()
				+ ", getCurrentPageNo()=" + getCurrentPageNo()
				+ ", getRecordCountPerPage()=" + getRecordCountPerPage()
				+ ", getPageSize()=" + getPageSize()
				+ ", getTotalRecordCount()=" + getTotalRecordCount()
				+ ", getFirstRecordIndex()=" + getFirstRecordIndex()
				+ ", getSearchValue()=" + getSearchValue()
				+ ", getSearchParameter()=" + getSearchParameter()
				+ ", getSearchDate()=" + getSearchDate()
				+ ", getSearchStartDate()=" + getSearchStartDate()
				+ ", getSearchEndDate()=" + getSearchEndDate()
				+ ", toString()=" + super.toString() + ", getMode()="
				+ getMode() + ", getClass()=" + getClass() + ", hashCode()="
				+ hashCode() + "]";
	}



	private interface SurveyList{}
	private interface SurveyView{}
	private interface SurveyWrite{}
	private interface SurveyEdit{}
	private interface SurveyInsert{}
	private interface SurveyUpdate{}
	private interface SurveyDelete{}
	
	@GroupSequence({SurveyList.class,SearchDateValidator.class})
	public static interface SurveyListVal{}
	
	@GroupSequence({SurveyView.class})
	public static interface SurveyViewVal{}
	
	@GroupSequence({SurveyWrite.class})
	public static interface SurveyWriteVal{}
	
	@GroupSequence({SurveyEdit.class})
	public static interface SurveyEditVal{}
	
	@GroupSequence({GetMode.class,SurveyInsert.class,SurveyUpdate.class})
	public static interface SurveyPersistVal{}
	
	@GroupSequence({GetMode.class,SurveyDelete.class})
	public static interface SurveyDeleteVal{}
	
	@GroupSequence({GetMode.class,SurveyList.class,SurveyView.class,SurveyWrite.class,SurveyEdit.class,SurveyInsert.class,SurveyUpdate.class,SurveyDelete.class})
	public static interface SurveyAllVal{}
	
}
