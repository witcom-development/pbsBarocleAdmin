package com.dkitec.barocle.admin.board.distribute.vo;

import javax.validation.GroupSequence;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.egov.paging.VO.ModeVO.GetMode;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO.SearchDateValidator;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.CheckXSS;
import com.dkitec.barocle.util.validator.annotation.DaumEmpty;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;
import com.dkitec.barocle.util.validator.annotation.IsYN;
import com.dkitec.barocle.util.validator.annotation.SearchDate;

@Alias("distributeBoardVO")
@SearchDate(groups=PagingVO.SearchDateValidator.class)
public class DistributeBoardVO extends PagingVO{
	// noticeVO 참고, 팜업 관련 제외 -
	
	private static final long serialVersionUID = -6811631191513403098L;
	private static final String currentMenu = "DIST";
	private static final String currentMenuName = "distributeboard";
	
	@IsNumeric(groups= {DistBoardView.class, DistBoardUpdate.class, DistBoardDelete.class})
	private int distSeq;
	private String cateCD;
	@CheckValue(message="대상을 선택해 주세요", groups= {DistBoardInsert.class, DistBoardUpdate.class})
	private String siteClsCD;
	private int distNO;
	@CheckValue(message="제목을 입력해 주세요.",groups= {DistBoardInsert.class, DistBoardUpdate.class})
	@CheckXSS(groups= {DistBoardInsert.class, DistBoardUpdate.class})
	private String distTitle;
	private String distTextContent;
	@DaumEmpty(message="내용을 입력해 주세요",groups= {DistBoardInsert.class, DistBoardUpdate.class})
	@CheckXSS(groups= {DistBoardInsert.class, DistBoardUpdate.class})
	private String distHTMLContent;
	@IsYN(groups= {DistBoardInsert.class, DistBoardUpdate.class})
	private String replyYN;
	private int sortOrd;
	private int readCnt;
	@IsYN(groups= {DistBoardInsert.class, DistBoardUpdate.class})
	private String useYN;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private java.util.Date postStrDttm;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private java.util.Date postEndDttm;
	private String atchFileID;
	private String popupYN;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private java.util.Date popupStrDttm;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private java.util.Date popupEndDttm;
	@IsYN(groups= {DistBoardInsert.class, DistBoardUpdate.class})
	private String mainDistYN;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private java.util.Date mainDistStrDttm;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private java.util.Date mainDistEndDttm;
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
	
	private String topYN;
	
	public DistributeBoardVO(){
		this.replyYN = "N";
		this.useYN = "Y";
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

	public String getSiteClsCD() {
		return siteClsCD;
	}

	public void setSiteClsCD(String siteClsCD) {
		this.siteClsCD = siteClsCD;
	}

	public int getDistSeq() {
		return distSeq;
	}

	public void setDistSeq(int distSeq) {
		this.distSeq = distSeq;
	}

	public String getCateCD() {
		return cateCD;
	}

	public void setCateCD(String cateCD) {
		this.cateCD = cateCD;
	}

	public int getDistNO() {
		return distNO;
	}

	public void setDistNO(int distNO) {
		this.distNO = distNO;
	}

	public String getDistTitle() {
		return distTitle;
	}

	public void setDistTitle(String distTitle) {
		this.distTitle = distTitle;
	}

	public String getDistTextContent() {
		return distTextContent;
	}

	public void setDistTextContent(String distTextContent) {
		this.distTextContent = distTextContent;
	}

	public String getDistHTMLContent() {
		return distHTMLContent;
	}

	public void setDistHTMLContent(String distHTMLContent) {
		this.distHTMLContent = distHTMLContent;
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

	public String getMainDistYN() {
		return mainDistYN;
	}

	public void setMainDistYN(String mainDistYN) {
		this.mainDistYN = mainDistYN;
	}

	public java.util.Date getMainDistStrDttm() {
		return mainDistStrDttm;
	}

	public void setMainDistStrDttm(java.util.Date mainDistStrDttm) {
		this.mainDistStrDttm = mainDistStrDttm;
	}

	public java.util.Date getMainDistEndDttm() {
		return mainDistEndDttm;
	}

	public void setMainDistEndDttm(java.util.Date mainDistEndDttm) {
		this.mainDistEndDttm = mainDistEndDttm;
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

	public String getAttachNo() {
		return attachNo;
	}

	public void setAttachNo(String attachNo) {
		this.attachNo = attachNo;
	}

	public String getAttachNm() {
		return attachNm;
	}

	public void setAttachNm(String attachNm) {
		this.attachNm = attachNm;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public String getaFolder() {
		return aFolder;
	}

	public void setaFolder(String aFolder) {
		this.aFolder = aFolder;
	}

	public String getImgSeq() {
		return imgSeq;
	}

	public void setImgSeq(String imgSeq) {
		this.imgSeq = imgSeq;
	}

	public String getImgName() {
		return imgName;
	}

	public void setImgName(String imgName) {
		this.imgName = imgName;
	}

	public static String getCurrentmenu() {
		return currentMenu;
	}

	public static String getCurrentmenuname() {
		return currentMenuName;
	}

	

	public String getTopYN() {
		return topYN;
	}

	public void setTopYN(String topYN) {
		this.topYN = topYN;
	}

	@Override
	public String toString() {
		return "DistributeBoardVO [distSeq=" + distSeq + ", cateCD=" + cateCD + ", distNO=" + distNO + ", distTitle="
				+ distTitle + ", distTextContent=" + distTextContent + ", distHTMLContent=" + distHTMLContent
				+ ", replyYN=" + replyYN + ", sortOrd=" + sortOrd + ", readCnt=" + readCnt + ", useYN=" + useYN
				+ ", postStrDttm=" + postStrDttm + ", postEndDttm=" + postEndDttm + ", atchFileID=" + atchFileID
				+ ", mainDistYN=" + mainDistYN + ", mainDistStrDttm=" + mainDistStrDttm + ", mainDistEndDttm="
				+ mainDistEndDttm + ", regDttm=" + regDttm + ", regID=" + regID + ", modDttm=" + modDttm + ", modID="
				+ modID + ", imageList=" + imageList + ", attach_image_info=" + attach_image_info + ", fileList="
				+ fileList + ", siteClsCD=" + siteClsCD 
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
				+ hashCode() + ", toString()=" + super.toString() +"]";
	}

	private interface DistBoardList{}
	private interface DistBoardView{}
	private interface DistBoardWrite{}
	private interface DistBoardEdit{}
	private interface DistBoardInsert{}
	private interface DistBoardUpdate{}
	private interface DistBoardDelete{}
	private interface DistBoardComment{}
	private interface DistBoardReply{}
	
	@GroupSequence({DistBoardList.class, SearchDateValidator.class})
	public static interface DistBoardListVal{}
	
	@GroupSequence({DistBoardView.class})
	public static interface DistBoardViewVal{}
	
	@GroupSequence({DistBoardWrite.class})
	public static interface DistBoardWriteVal{}
	
	@GroupSequence({DistBoardEdit.class})
	public static interface DistBoardEditVal{}
	
	@GroupSequence({GetMode.class, DistBoardInsert.class, DistBoardUpdate.class})
	public static interface DistBoardPersistVal{}
	
	@GroupSequence({GetMode.class, DistBoardDelete.class})
	public static interface DistBoardDeleteVal{}
	
	@GroupSequence({GetMode.class, DistBoardList.class, DistBoardView.class, DistBoardWrite.class, DistBoardEdit.class, DistBoardInsert.class, DistBoardUpdate.class, DistBoardDelete.class, DistBoardComment.class, DistBoardReply.class})
	public static interface DistBoardAllVal{}
}
