package com.dkitec.barocle.admin.customer.faq.vo;

import javax.validation.GroupSequence;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.CheckXSS;
import com.dkitec.barocle.util.validator.annotation.DaumEmpty;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;
import com.dkitec.barocle.util.validator.annotation.IsYN;
import com.dkitec.barocle.util.validator.annotation.SearchDate;

@Alias("faqVO")
@SearchDate(groups=PagingVO.SearchDateValidator.class)
public class FaqVO extends PagingVO implements java.io.Serializable {
	
	private static final long serialVersionUID = -7273469024487969245L;
	private static final String currentMenu = "CTM_002";
	private static final String currentMenuName = "faq";
	
	@IsNumeric(groups={FaqView.class,FaqUpdate.class,FaqDelete.class})
	private int faqSeq;
	@CheckValue(message="카테고리 정의는 필수입니다.",groups={FaqInsert.class,FaqUpdate.class})
	private String cateCD;
	@CheckValue(message="이전 카테고리 정의는 필수입니다.")
	private String tempCateCD;
	private String currentQestnOrder;
	@IsNumeric(message="표시순서를 입력해 주세요.",groups={FaqInsert.class,FaqUpdate.class})
	private int qestnOrd;
	@CheckValue(message="제목을 입력해 주세요.",groups={FaqInsert.class,FaqUpdate.class})
	@CheckXSS(groups={FaqInsert.class,FaqUpdate.class})
	private String qestnTitle;
	private String qestnContent;
	private String answerTextContent;
	@DaumEmpty(message="내용을 입력해 주세요.",groups={FaqInsert.class,FaqUpdate.class})
	@CheckXSS(groups={FaqInsert.class,FaqUpdate.class})
	private String answerHTMLContent;
	private int readCnt;
	@IsYN(groups={FaqInsert.class,FaqUpdate.class})
	private String useYN;
	private java.util.Date regDttm;
	private String regID;
	private java.util.Date modDttm;
	private String modID;
	private String atchFileID;
	
	private java.util.List<String> imageList;		// 이미지 URL 목록
	private String attach_image_info;
	
	private String cdDesc1;
	private String cdDesc2;
	
	
	public FaqVO(){
		this.useYN = "Y";
	}
	
	
	public int getFaqSeq() {
		return faqSeq;
	}

	public void setFaqSeq(int faqSeq) {
		this.faqSeq = faqSeq;
	}

	public String getCateCD() {
		return cateCD;
	}

	public void setCateCD(String cateCD) {
		this.cateCD = cateCD;
	}

	public String getTempCateCD() {
		return tempCateCD;
	}


	public void setTempCateCD(String tempCateCD) {
		this.tempCateCD = tempCateCD;
	}


	public String getCurrentQestnOrder() {
		return currentQestnOrder;
	}

	public void setCurrentQestnOrder(String currentQestnOrder) {
		this.currentQestnOrder = currentQestnOrder;
	}

	public int getQestnOrd() {
		return qestnOrd;
	}

	public void setQestnOrd(int qestnOrd) {
		this.qestnOrd = qestnOrd;
	}

	public String getQestnTitle() {
		return qestnTitle;
	}

	public void setQestnTitle(String qestnTitle) {
		this.qestnTitle = qestnTitle;
	}

	public String getQestnContent() {
		return qestnContent;
	}

	public void setQestnContent(String qestnContent) {
		this.qestnContent = qestnContent;
	}

	public String getAnswerTextContent() {
		return answerTextContent;
	}

	public void setAnswerTextContent(String answerTextContent) {
		this.answerTextContent = answerTextContent;
	}

	public String getAnswerHTMLContent() {
		return answerHTMLContent;
	}

	public void setAnswerHTMLContent(String answerHTMLContent) {
		this.answerHTMLContent = answerHTMLContent;
	}

	public int getReadCnt() {
		return readCnt;
	}

	public void setReadCnt(int readCnt) {
		this.readCnt = readCnt;
	}

	public String getUseYN() {
		return useYN;
	}

	public void setUseYN(String useYN) {
		this.useYN = useYN;
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

	public String getAtchFileID() {
		return atchFileID;
	}

	public void setAtchFileID(String atchFileID) {
		this.atchFileID = atchFileID;
	}

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

	public String getCdDesc1() {
		return cdDesc1;
	}

	public void setCdDesc1(String cdDesc1) {
		this.cdDesc1 = cdDesc1;
	}

	public String getCdDesc2() {
		return cdDesc2;
	}

	public void setCdDesc2(String cdDesc2) {
		this.cdDesc2 = cdDesc2;
	}

	public static String getCurrentmenu() {
		return currentMenu;
	}

	public static String getCurrentmenuname() {
		return currentMenuName;
	}
	
	@Override
	public String toString() {
		return "FaqVO [faqSeq=" + faqSeq + ", cateCD=" + cateCD
				+ ", tempCateCD=" + tempCateCD + ", currentQestnOrder="
				+ currentQestnOrder + ", qestnOrd=" + qestnOrd
				+ ", qestnTitle=" + qestnTitle + ", qestnContent="
				+ qestnContent + ", answerTextContent=" + answerTextContent
				+ ", answerHTMLContent=" + answerHTMLContent + ", readCnt="
				+ readCnt + ", useYN=" + useYN + ", regDttm=" + regDttm
				+ ", regID=" + regID + ", modDttm=" + modDttm + ", modID="
				+ modID + ", atchFileID=" + atchFileID + ", imageList="
				+ imageList + ", attach_image_info=" + attach_image_info
				+ ", cdDesc1=" + cdDesc1 + ", cdDesc2=" + cdDesc2
				+ ", getCurrentPageNo()=" + getCurrentPageNo()
				+ ", getRecordCountPerPage()=" + getRecordCountPerPage()
				+ ", getPageSize()=" + getPageSize()
				+ ", getTotalRecordCount()=" + getTotalRecordCount()
				+ ", getFirstRecordIndex()=" + getFirstRecordIndex()
				+ ", getSearchValue()=" + getSearchValue()
				+ ", getSearchParameter()=" + getSearchParameter()
				+ ", getSearchDate()=" + getSearchDate()
				+ ", getSearchStartDate()=" + getSearchStartDate()
				+ ", getSearchEndDate()=" + getSearchEndDate() + ", getMode()="
				+ getMode() + ", getClass()=" + getClass() + ", hashCode()="
				+ hashCode() + ", toString()=" + super.toString() + "]";
	}
	
	private interface FaqList{}
	private interface FaqView{}
	private interface FaqWrite{}
	private interface FaqEdit{}
	private interface FaqInsert{}
	private interface FaqUpdate{}
	private interface FaqDelete{}
	private interface FaqComment{}
	private interface FaqReply{}
	
	@GroupSequence({FaqList.class})
	public static interface FaqListVal{}
	
	@GroupSequence({FaqView.class})
	public static interface FaqViewVal{}
	
	@GroupSequence({FaqWrite.class})
	public static interface FaqWriteVal{}
	
	@GroupSequence({FaqEdit.class})
	public static interface FaqEditVal{}
	
	@GroupSequence({GetMode.class,FaqInsert.class,FaqUpdate.class})
	public static interface FaqPersistVal{}
	
	@GroupSequence({GetMode.class,FaqDelete.class})
	public static interface FaqDeleteVal{}
	
	@GroupSequence({GetMode.class,FaqList.class,FaqView.class,FaqWrite.class,FaqEdit.class,FaqInsert.class,FaqUpdate.class,FaqDelete.class,FaqComment.class,FaqReply.class})
	public static interface FaqAllVal{}

}
