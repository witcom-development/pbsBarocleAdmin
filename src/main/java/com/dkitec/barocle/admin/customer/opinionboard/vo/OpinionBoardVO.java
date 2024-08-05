package com.dkitec.barocle.admin.customer.opinionboard.vo;

import javax.validation.GroupSequence;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
//import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.CheckXSS;
import com.dkitec.barocle.util.validator.annotation.DaumEmpty;
//import com.dkitec.barocle.util.validator.annotation.IsEMail;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;
import com.dkitec.barocle.util.validator.annotation.SearchDate;

@Alias("opinionBoardVO")
@SearchDate(groups=PagingVO.SearchDateValidator.class)
public class OpinionBoardVO extends PagingVO implements java.io.Serializable {
	
	private static final long serialVersionUID = 3909353460219022807L;
	private static final String currentMenu = "CTM_003";
	private static final String currentMenuName = "opinionboard";
	
	@IsNumeric(groups={OpinionBoardView.class,OpinionBoardUpdate.class,OpinionBoardDelete.class})
	private int qnaSeq;
	private String cateCD;
	//@CheckValue(groups={OpinionBoardInsert.class})
	//@CheckXSS(groups={OpinionBoardInsert.class})
	private String qestnTitle;		// 사용자 질문 제목
	//@CheckValue(groups={OpinionBoardInsert.class})
	//@CheckXSS(groups={OpinionBoardInsert.class})
	private String qestnTextContent;
	private String qestnHTMLContent;
	private String qestnAtchFileID;
	private int readCnt;
	//@IsEMail(groups={OpinionBoardInsert.class,OpinionBoardUpdate.class})
	private String emailAddr;
	private String usr_regDttm;
	private String usr_regID;
	private String usr_modDttm;
	private String usr_modID;
	private String qnaProcessStusCD;
	private String wrterName;
	private String openYN;
	
	@IsNumeric(groups={OpinionBoardUpdate.class,OpinionBoardDelete.class,OpinionBoardComment.class,OpinionBoardReply.class})
	private int qnaAnswerSeq;
	private String wrterID;
	private String qnaAnswerPassWD;
	private String answerTextContent;
	private String answerHTMLContent;
	@DaumEmpty(groups={OpinionBoardUpdate.class})
	@CheckXSS(groups={OpinionBoardUpdate.class})
	private String useYN;
	private String answerAtchFileId;
	private String regDttm;
	private String regID;
	private String modDttm;
	private String modID;
	
	private java.util.List<String> imageList;		// 이미지 URL 목록
	private String attach_image_info;
	
	private String cdNm;							//카테고리 구분명_cms_20161121
	private String openNm;							//공개여부_cms_20161121
	
	private String secretYn;						//시민의견수렴 공개여부_cms_20161201
	
	private String cdDesc1;							//시민의겸수렴 구분List _cms_20161222
	private String comCd;							//시민의겸수렴 구분List _cms_20161222

	private String adminId;							//담당자 추가 20180823
	
	private String deadline;						// 답변기한 변수 20200914
	private String deadline_Date;
	
	private int dateCnt; // 답변기한일로부터 남은 일자 계산 20201005
	
	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getDeadline() {
		return deadline;
	}

	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	
	public String getDeadline_Date() {
		return deadline_Date;
	}

	public void setDeadline_Date(String deadline_Date) {
		this.deadline_Date = deadline_Date;
	}
	
	public int getDateCnt() {
		return dateCnt;
	}

	public void setDateCnt(int dateCnt) {
		this.dateCnt = dateCnt;
	}
	
	public String getComCd() {
		return comCd;
	}

	public void setComCd(String comCd) {
		this.comCd = comCd;
	}

	public String getCdDesc1() {
		return cdDesc1;
	}

	public void setCdDesc1(String cdDesc1) {
		this.cdDesc1 = cdDesc1;
	}

	public String getSecretYn() {
		return secretYn;
	}

	public void setSecretYn(String secretYn) {
		this.secretYn = secretYn;
	}

	public String getCdNm() {
		return cdNm;
	}

	public void setCdNm(String cdNm) {
		this.cdNm = cdNm;
	}

	public String getOpenNm() {
		return openNm;
	}

	public void setOpenNm(String openNm) {
		this.openNm = openNm;
	}

	public OpinionBoardVO(){
		this.openYN = "Y";
		this.useYN = "Y";
	}

	public int getQnaSeq() {
		return qnaSeq;
	}

	public void setQnaSeq(int qnaSeq) {
		this.qnaSeq = qnaSeq;
	}

	public String getCateCD() {
		return cateCD;
	}

	public void setCateCD(String cateCD) {
		this.cateCD = cateCD;
	}

	public String getQestnTitle() {
		return qestnTitle;
	}

	public void setQestnTitle(String qestnTitle) {
		this.qestnTitle = qestnTitle;
	}

	public String getQestnTextContent() {
		return qestnTextContent;
	}

	public void setQestnTextContent(String qestnTextContent) {
		this.qestnTextContent = qestnTextContent;
	}

	public String getQestnHTMLContent() {
		return qestnHTMLContent;
	}

	public void setQestnHTMLContent(String qestnHTMLContent) {
		this.qestnHTMLContent = qestnHTMLContent;
	}

	public String getQestnAtchFileID() {
		return qestnAtchFileID;
	}

	public void setQestnAtchFileID(String qestnAtchFileID) {
		this.qestnAtchFileID = qestnAtchFileID;
	}

	public int getReadCnt() {
		return readCnt;
	}

	public void setReadCnt(int readCnt) {
		this.readCnt = readCnt;
	}

	public String getEmailAddr() {
		return emailAddr;
	}

	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}

	public String getUsr_regDttm() {
		return usr_regDttm;
	}

	public void setUsr_regDttm(String usr_regDttm) {
		this.usr_regDttm = usr_regDttm;
	}

	public String getUsr_regID() {
		return usr_regID;
	}

	public void setUsr_regID(String usr_regID) {
		this.usr_regID = usr_regID;
	}

	public String getUsr_modDttm() {
		return usr_modDttm;
	}

	public void setUsr_modDttm(String usr_modDttm) {
		this.usr_modDttm = usr_modDttm;
	}

	public String getUsr_modID() {
		return usr_modID;
	}

	public void setUsr_modID(String usr_modID) {
		this.usr_modID = usr_modID;
	}

	public String getQnaProcessStusCD() {
		return qnaProcessStusCD;
	}

	public void setQnaProcessStusCD(String qnaProcessStusCD) {
		this.qnaProcessStusCD = qnaProcessStusCD;
	}

	public String getWrterName() {
		return wrterName;
	}

	public void setWrterName(String wrterName) {
		this.wrterName = wrterName;
	}

	public String getOpenYN() {
		return openYN;
	}

	public void setOpenYN(String openYN) {
		this.openYN = openYN;
	}

	public int getQnaAnswerSeq() {
		return qnaAnswerSeq;
	}

	public void setQnaAnswerSeq(int qnaAnswerSeq) {
		this.qnaAnswerSeq = qnaAnswerSeq;
	}

	public String getWrterID() {
		return wrterID;
	}

	public void setWrterID(String wrterID) {
		this.wrterID = wrterID;
	}

	public String getQnaAnswerPassWD() {
		return qnaAnswerPassWD;
	}

	public void setQnaAnswerPassWD(String qnaAnswerPassWD) {
		this.qnaAnswerPassWD = qnaAnswerPassWD;
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

	public String getUseYN() {
		return useYN;
	}

	public void setUseYN(String useYN) {
		this.useYN = useYN;
	}

	public String getAnswerAtchFileId() {
		return answerAtchFileId;
	}

	public void setAnswerAtchFileId(String answerAtchFileId) {
		this.answerAtchFileId = answerAtchFileId;
	}

	public String getRegDttm() {
		return regDttm;
	}

	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}

	public String getRegID() {
		return regID;
	}

	public void setRegID(String regID) {
		this.regID = regID;
	}

	public String getModDttm() {
		return modDttm;
	}

	public void setModDttm(String modDttm) {
		this.modDttm = modDttm;
	}

	public String getModID() {
		return modID;
	}

	public void setModID(String modID) {
		this.modID = modID;
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

	public static String getCurrentmenu() {
		return currentMenu;
	}

	public static String getCurrentmenuname() {
		return currentMenuName;
	}
	
	@Override
	public String toString() {
		return "OpinionBoardVO [qnaSeq=" + qnaSeq + ", cateCD=" + cateCD
				+ ", qestnTitle=" + qestnTitle + ", qestnTextContent="
				+ qestnTextContent + ", qestnHTMLContent=" + qestnHTMLContent
				+ ", qestnAtchFileID=" + qestnAtchFileID + ", readCnt="
				+ readCnt + ", emailAddr=" + emailAddr + ", usr_regDttm="
				+ usr_regDttm + ", usr_regID=" + usr_regID + ", usr_modDttm="
				+ usr_modDttm + ", usr_modID=" + usr_modID
				+ ", qnaProcessStusCD=" + qnaProcessStusCD + ", wrterName="
				+ wrterName + ", openYN=" + openYN + ", qnaAnswerSeq="
				+ qnaAnswerSeq + ", wrterID=" + wrterID + ", qnaAnswerPassWD="
				+ qnaAnswerPassWD + ", answerTextContent=" + answerTextContent
				+ ", answerHTMLContent=" + answerHTMLContent + ", useYN="
				+ useYN + ", answerAtchFileId=" + answerAtchFileId
				+ ", regDttm=" + regDttm + ", regID=" + regID + ", modDttm="
				+ modDttm + ", modID=" + modID + ", imageList=" + imageList
				+ ", attach_image_info=" + attach_image_info 
				+ ", deadline=" + deadline + ", deadline_Date=" + deadline_Date
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
				+ ", getMode()=" + getMode() + ", getClass()=" + getClass() 
				+ ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}
	
	private interface OpinionBoardList{}
	private interface OpinionBoardView{}
	private interface OpinionBoardWrite{}
	private interface OpinionBoardEdit{}
	private interface OpinionBoardInsert{}
	private interface OpinionBoardUpdate{}
	private interface OpinionBoardDelete{}
	private interface OpinionBoardComment{}
	private interface OpinionBoardReply{}
	
	@GroupSequence({OpinionBoardList.class})
	public static interface OpinionBoardListVal{}
	
	@GroupSequence({OpinionBoardView.class})
	public static interface OpinionBoardViewVal{}
	
	@GroupSequence({OpinionBoardWrite.class})
	public static interface OpinionBoardWriteVal{}
	
	@GroupSequence({OpinionBoardEdit.class})
	public static interface OpinionBoardEditVal{}
	
	@GroupSequence({GetMode.class,OpinionBoardUpdate.class})
	public static interface OpinionBoardPersistVal{}
	
	@GroupSequence({GetMode.class,OpinionBoardDelete.class})
	public static interface OpinionBoardDeleteVal{}
	
	@GroupSequence({OpinionBoardList.class,OpinionBoardView.class,OpinionBoardWrite.class,OpinionBoardEdit.class,OpinionBoardInsert.class,OpinionBoardUpdate.class,OpinionBoardDelete.class,OpinionBoardComment.class,OpinionBoardReply.class})
	public static interface OpinionBoardAllVal{}
	
}
