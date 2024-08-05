package com.dkitec.barocle.admin.customer.notice.vo;

import javax.validation.GroupSequence;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.CheckXSS;
import com.dkitec.barocle.util.validator.annotation.DaumEmpty;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;
import com.dkitec.barocle.util.validator.annotation.IsYN;
import com.dkitec.barocle.util.validator.annotation.SearchDate;

@Alias("noticeVO")
@SearchDate(groups=PagingVO.SearchDateValidator.class)
public class NoticeVO extends PagingVO implements java.io.Serializable {
	
	private static final long serialVersionUID = -6030085711355250193L;
	private static final String currentMenu = "CTM_001";
	private static final String currentMenuName = "notice";
	
	@IsNumeric(groups={NoticeView.class,/*NoticeEdit.class,NoticeInsert.class,*/NoticeUpdate.class,NoticeDelete.class/*,NoticeComment.class,NoticeReply.class*/})
	private int noticeSeq;
	private String cateCD;
	@CheckValue(message="공지대상을 선택해 주세요.",groups={NoticeInsert.class,NoticeUpdate.class})
	private String siteClsCD;
	private int noticeNO;
	@CheckValue(message="제목을 입력해 주세요.",groups={NoticeInsert.class,NoticeUpdate.class})
	@CheckXSS(groups={NoticeInsert.class,NoticeUpdate.class})
	private String noticeTitle;
	private String noticeTextContent;
	@DaumEmpty(message="내용을 입력해 주세요.",groups={NoticeInsert.class,NoticeUpdate.class})
	@CheckXSS(groups={NoticeInsert.class,NoticeUpdate.class})
	private String noticeHTMLContent;
	@IsYN(groups={NoticeInsert.class,NoticeUpdate.class})
	private String replyYN;
	private int sortOrd;
	private int readCnt;
	@IsYN(groups={NoticeInsert.class,NoticeUpdate.class})
	private String useYN;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private java.util.Date postStrDttm;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private java.util.Date postEndDttm;
	private String atchFileID;
	@IsYN(groups={NoticeInsert.class,NoticeUpdate.class})
	private String popupYN;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private java.util.Date popupStrDttm;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private java.util.Date popupEndDttm;
	@IsYN(groups={NoticeInsert.class,NoticeUpdate.class})
	private String mainNoticeYN;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private java.util.Date mainNoticeStrDttm;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private java.util.Date mainNoticeEndDttm;
	private java.util.Date regDttm;
	private String regID;
	private java.util.Date modDttm;
	private String modID;
	
	private java.util.List<String> imageList;		// 이미지 URL 목록
	private String attach_image_info;				// 다음 에디터에서 받은 이미지 목록
	
	private java.util.List<String> fileList;		// 파일 URL 목록
	private String attach_file;						// 첨부파일 업로드 _ cms_20161108
	private String attachNo;						// 첨부파일 번호
	private String attachNm;						// 파일명
	private String imgUrl;							// 서버파일경로+파일명
	private String aFolder;							// 현패이지경로
	private String imgSeq;							// 이미지 시퀀스
	
	private String imgName;

	private String pushYN;
	
	private String topYN;							// 20200607
	private String adminGrpSeq;
	
 
	public String getAdminGrpSeq() {
		return adminGrpSeq;
	}

	public void setAdminGrpSeq(String adminGrpSeq) {
		this.adminGrpSeq = adminGrpSeq;
	}

	public String getTopYN() {
		return topYN;
	}

	public void setTopYN(String topYN) {
		this.topYN = topYN;
	}

	public NoticeVO(){
		this.replyYN = "N";
		this.useYN = "Y";
		this.popupYN = "N";
		//this.mainNoticeYN = "Y";		// 검색 조건 추가로 막음 2019.03.28
	}

	//station 템플릿을 위해 추가함
	
	private String noticeStationId;

	

	public String getNoticeStationId() {
		return noticeStationId;
	}

	public void setNoticeStationId(String noticeStationId) {
		this.noticeStationId = noticeStationId;
	}

	public String getImgName() {
		return imgName;
	}
	
	public void setImgName(String imgName) {
		this.imgName = imgName;
	}
	
	public String getImgSeq() {
		return imgSeq;
	}

	public void setImgSeq(String imgSeq) {
		this.imgSeq = imgSeq;
	}

	public String getaFolder() {
		return aFolder;
	}

	public void setaFolder(String aFolder) {
		this.aFolder = aFolder;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public String getAttachNm() {
		return attachNm;
	}

	public void setAttachNm(String attachNm) {
		this.attachNm = attachNm;
	}

	public String getAttachNo() {
		return attachNo;
	}

	public void setAttachNo(String attachNo) {
		this.attachNo = attachNo;
	}

	public java.util.List<String> getFileList() {
		return fileList;
	}

	public void setFileList(java.util.List<String> fileList) {
		this.fileList = fileList;
	}

	public String getAttach_file() {
		return attach_file;
	}
	
	public void setAttach_file(String attach_file) {
		this.attach_file = attach_file;
	}

	public int getNoticeSeq() {
		return noticeSeq;
	}

	public void setNoticeSeq(int noticeSeq) {
		this.noticeSeq = noticeSeq;
	}

	public String getCateCD() {
		return cateCD;
	}

	public void setCateCD(String cateCD) {
		this.cateCD = cateCD;
	}

	public String getSiteClsCD() {
		return siteClsCD;
	}

	public void setSiteClsCD(String siteClsCD) {
		this.siteClsCD = siteClsCD;
	}

	public int getNoticeNO() {
		return noticeNO;
	}

	public void setNoticeNO(int noticeNO) {
		this.noticeNO = noticeNO;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeTextContent() {
		return noticeTextContent;
	}

	public void setNoticeTextContent(String noticeTextContent) {
		this.noticeTextContent = noticeTextContent;
	}

	public String getNoticeHTMLContent() {
		return noticeHTMLContent;
	}

	public void setNoticeHTMLContent(String noticeHTMLContent) {
		this.noticeHTMLContent = noticeHTMLContent;
	}

	public String getReplyYN() {
		return replyYN;
	}

	public void setReplyYN(String replyYN) {
		this.replyYN = replyYN;
	}

	public int getSortOrd() {
		return sortOrd;
	}

	public void setSortOrd(int sortOrd) {
		this.sortOrd = sortOrd;
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

	public java.util.Date getPostStrDttm() {
		return postStrDttm;
	}

	public void setPostStrDttm(java.util.Date postStrDttm) {
		this.postStrDttm = postStrDttm;
	}

	public java.util.Date getPostEndDttm() {
		return postEndDttm;
	}

	public void setPostEndDttm(java.util.Date postEndDttm) {
		this.postEndDttm = postEndDttm;
	}

	public String getAtchFileID() {
		return atchFileID;
	}

	public void setAtchFileID(String atchFileID) {
		this.atchFileID = atchFileID;
	}

	public String getPopupYN() {
		return popupYN;
	}

	public void setPopupYN(String popupYN) {
		this.popupYN = popupYN;
	}

	public java.util.Date getPopupStrDttm() {
		return popupStrDttm;
	}

	public void setPopupStrDttm(java.util.Date popupStrDttm) {
		this.popupStrDttm = popupStrDttm;
	}

	public java.util.Date getPopupEndDttm() {
		return popupEndDttm;
	}

	public void setPopupEndDttm(java.util.Date popupEndDttm) {
		this.popupEndDttm = popupEndDttm;
	}

	public String getMainNoticeYN() {
		return mainNoticeYN;
	}

	public void setMainNoticeYN(String mainNoticeYN) {
		this.mainNoticeYN = mainNoticeYN;
	}

	public java.util.Date getMainNoticeStrDttm() {
		return mainNoticeStrDttm;
	}

	public void setMainNoticeStrDttm(java.util.Date mainNoticeStrDttm) {
		this.mainNoticeStrDttm = mainNoticeStrDttm;
	}

	public java.util.Date getMainNoticeEndDttm() {
		return mainNoticeEndDttm;
	}

	public void setMainNoticeEndDttm(java.util.Date mainNoticeEndDttm) {
		this.mainNoticeEndDttm = mainNoticeEndDttm;
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
	
	public String getPushYN() {
		return pushYN;
	}

	public void setPushYN(String pushYN) {
		this.pushYN = pushYN;
	}





	@Override
	public String toString() {
		return "NoticeVO [noticeSeq=" + noticeSeq + ", cateCD=" + cateCD
				+ ", siteClsCD=" + siteClsCD + ", noticeNO=" + noticeNO
				+ ", noticeTitle=" + noticeTitle + ", noticeTextContent="
				+ noticeTextContent + ", noticeHTMLContent="
				+ noticeHTMLContent + ", replyYN=" + replyYN + ", sortOrd="
				+ sortOrd + ", readCnt=" + readCnt + ", useYN=" + useYN
				+ ", postStrDttm=" + postStrDttm + ", postEndDttm="
				+ postEndDttm + ", atchFileID=" + atchFileID + ", popupYN="
				+ popupYN + ", popupStrDttm=" + popupStrDttm
				+ ", popupEndDttm=" + popupEndDttm + ", mainNoticeYN="
				+ mainNoticeYN + ", mainNoticeStrDttm=" + mainNoticeStrDttm
				+ ", mainNoticeEndDttm=" + mainNoticeEndDttm + ", regDttm="
				+ regDttm + ", regID=" + regID + ", modDttm=" + modDttm
				+ ", modID=" + modID + ", imageList=" + imageList
				+ ", fileList=" + fileList
				+ ", attach_image_info=" + attach_image_info
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
	
	private interface NoticeList{}
	private interface NoticeView{}
	private interface NoticeWrite{}
	private interface NoticeEdit{}
	private interface NoticeInsert{}
	private interface NoticeUpdate{}
	private interface NoticeDelete{}
	private interface NoticeComment{}
	private interface NoticeReply{}
	
	@GroupSequence({NoticeList.class,SearchDateValidator.class})
	public static interface NoticeListVal{}
	
	@GroupSequence({NoticeView.class})
	public static interface NoticeViewVal{}
	
	@GroupSequence({NoticeWrite.class})
	public static interface NoticeWriteVal{}
	
	@GroupSequence({NoticeEdit.class})
	public static interface NoticeEditVal{}
	
	@GroupSequence({GetMode.class,NoticeInsert.class,NoticeUpdate.class})
	public static interface NoticePersistVal{}
	
	@GroupSequence({GetMode.class,NoticeDelete.class})
	public static interface NoticeDeleteVal{}
	
	@GroupSequence({GetMode.class,NoticeList.class,NoticeView.class,NoticeWrite.class,NoticeEdit.class,NoticeInsert.class,NoticeUpdate.class,NoticeDelete.class,NoticeComment.class,NoticeReply.class})
	public static interface NoticeAllVal{}
	
}
