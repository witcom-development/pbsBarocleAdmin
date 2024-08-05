package com.dkitec.barocle.admin.customer.photogallery.vo;

import javax.validation.GroupSequence;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.CheckXSS;
//import com.dkitec.barocle.util.validator.annotation.DaumEmpty;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;
import com.dkitec.barocle.util.validator.annotation.IsYN;
import com.dkitec.barocle.util.validator.annotation.SearchDate;

@Alias("photoGalleryVO")
@SearchDate(groups=PagingVO.SearchDateValidator.class)
public class PhotoGalleryVO extends PagingVO implements java.io.Serializable {
	
	private static final long serialVersionUID = 5246921178210361738L;
	private static final String currentMenu = "CTM_004";
	private static final String currentMenuName = "photogallery";
	
	@IsNumeric(groups={PhotoGalleryView.class,PhotoGalleryUpdate.class,PhotoGalleryDelete.class})
	private int photoGallerySeq;
	private String cateCD;
	private String galleryNO;
	@CheckValue(message="제목을 입력해 주세요.",groups={PhotoGalleryInsert.class,PhotoGalleryUpdate.class})
	@CheckXSS(groups={PhotoGalleryInsert.class,PhotoGalleryUpdate.class})
	private String galleryTitle;
	private String galleryTextContent;
	//@DaumEmpty(groups={PhotoGalleryInsert.class,PhotoGalleryUpdate.class})
	@CheckXSS(groups={PhotoGalleryInsert.class,PhotoGalleryUpdate.class})
	private String galleryHTMLContent;
	private int readCnt;
	@IsYN(groups={PhotoGalleryInsert.class,PhotoGalleryUpdate.class})
	private String delYN;
	private String regID;
	private java.util.Date regDttm;
	private String modID;
	private java.util.Date modDttm;
	
	private java.util.List<String> imageList;
	private String attach_image_info;
	
	private String imgSeq;
	private String bbsClsCD;
	private String thumbnailImgUrl;
	
	
	public PhotoGalleryVO(){
		this.delYN = "N";
	}
	
	
	public int getPhotoGallerySeq() {
		return photoGallerySeq;
	}

	public void setPhotoGallerySeq(int photoGallerySeq) {
		this.photoGallerySeq = photoGallerySeq;
	}

	public String getCateCD() {
		return cateCD;
	}

	public void setCateCD(String cateCD) {
		this.cateCD = cateCD;
	}

	public String getGalleryNO() {
		return galleryNO;
	}

	public void setGalleryNO(String galleryNO) {
		this.galleryNO = galleryNO;
	}

	public String getGalleryTitle() {
		return galleryTitle;
	}

	public void setGalleryTitle(String galleryTitle) {
		this.galleryTitle = galleryTitle;
	}

	public String getGalleryTextContent() {
		return galleryTextContent;
	}

	public void setGalleryTextContent(String galleryTextContent) {
		this.galleryTextContent = galleryTextContent;
	}

	public String getGalleryHTMLContent() {
		return galleryHTMLContent;
	}

	public void setGalleryHTMLContent(String galleryHTMLContent) {
		this.galleryHTMLContent = galleryHTMLContent;
	}

	public int getReadCnt() {
		return readCnt;
	}

	public void setReadCnt(int readCnt) {
		this.readCnt = readCnt;
	}

	public String getDelYN() {
		return delYN;
	}

	public void setDelYN(String delYN) {
		this.delYN = delYN;
	}

	public String getRegID() {
		return regID;
	}

	public void setRegID(String regID) {
		this.regID = regID;
	}

	public java.util.Date getRegDttm() {
		return regDttm;
	}

	public void setRegDttm(java.util.Date regDttm) {
		this.regDttm = regDttm;
	}

	public String getModID() {
		return modID;
	}

	public void setModID(String modID) {
		this.modID = modID;
	}

	public java.util.Date getModDttm() {
		return modDttm;
	}

	public void setModDttm(java.util.Date modDttm) {
		this.modDttm = modDttm;
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

	public String getImgSeq() {
		return imgSeq;
	}

	public void setImgSeq(String imgSeq) {
		this.imgSeq = imgSeq;
	}

	public String getBbsClsCD() {
		return bbsClsCD;
	}

	public void setBbsClsCD(String bbsClsCD) {
		this.bbsClsCD = bbsClsCD;
	}

	public String getThumbnailImgUrl() {
		return thumbnailImgUrl;
	}

	public void setThumbnailImgUrl(String thumbnailImgUrl) {
		this.thumbnailImgUrl = thumbnailImgUrl;
	}

	public static String getCurrentmenu() {
		return currentMenu;
	}

	public static String getCurrentmenuname() {
		return currentMenuName;
	}
	
	@Override
	public String toString() {
		return "PhotoGalleryVO [photoGallerySeq=" + photoGallerySeq
				+ ", cateCD=" + cateCD + ", galleryNO=" + galleryNO
				+ ", galleryTitle=" + galleryTitle + ", galleryTextContent="
				+ galleryTextContent + ", galleryHTMLContent="
				+ galleryHTMLContent + ", readCnt=" + readCnt + ", delYN="
				+ delYN + ", regID=" + regID + ", regDttm=" + regDttm
				+ ", modID=" + modID + ", modDttm=" + modDttm + ", imageList="
				+ imageList + ", attach_image_info=" + attach_image_info
				+ ", imgSeq=" + imgSeq + ", bbsClsCD=" + bbsClsCD
				+ ", thumbnailImgUrl=" + thumbnailImgUrl
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
	
	private interface PhotoGalleryList{}
	private interface PhotoGalleryView{}
	private interface PhotoGalleryWrite{}
	private interface PhotoGalleryEdit{}
	private interface PhotoGalleryInsert{}
	private interface PhotoGalleryUpdate{}
	private interface PhotoGalleryDelete{}
	private interface PhotoGalleryComment{}
	private interface PhotoGalleryReply{}
	
	@GroupSequence({PhotoGalleryList.class})
	public static interface PhotoGalleryListVal{}
	
	@GroupSequence({PhotoGalleryView.class})
	public static interface PhotoGalleryViewVal{}
	
	@GroupSequence({PhotoGalleryWrite.class})
	public static interface PhotoGalleryWriteVal{}
	
	@GroupSequence({PhotoGalleryEdit.class})
	public static interface PhotoGalleryEditVal{}
	
	@GroupSequence({GetMode.class,PhotoGalleryInsert.class,PhotoGalleryUpdate.class})
	public static interface PhotoGalleryPersistVal{}
	
	@GroupSequence({GetMode.class,PhotoGalleryDelete.class})
	public static interface PhotoGalleryDeleteVal{}
	
	@GroupSequence({PhotoGalleryList.class,PhotoGalleryView.class,PhotoGalleryWrite.class,PhotoGalleryEdit.class,PhotoGalleryInsert.class,PhotoGalleryUpdate.class,PhotoGalleryDelete.class,PhotoGalleryComment.class,PhotoGalleryReply.class})
	public static interface PhotoGalleryAllVal{}

}
