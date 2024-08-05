package com.dkitec.barocle.admin.customer.donor.vo;

import javax.validation.GroupSequence;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.CheckXSS;
import com.dkitec.barocle.util.validator.annotation.DaumEmpty;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;
import com.dkitec.barocle.util.validator.annotation.SearchDate;

@Alias("donorVO")
@SearchDate(groups=PagingVO.SearchDateValidator.class)
public class DonorVO extends PagingVO implements java.io.Serializable {
	
	private static final long serialVersionUID = -2790794294343501127L;
	private static final String currentMenu = "CTM_007";
	private static final String currentMenuName = "donor";
	
	@IsNumeric(groups={DonorView.class,DonorUpdate.class,DonorDelete.class})
	private int donorSeq;
	private String donorNO;
	@CheckValue(message="제목을 입력해 주세요.",groups={DonorInsert.class,DonorUpdate.class})
	@CheckXSS(groups={DonorInsert.class,DonorUpdate.class})
	private String donorTitle;
	private String donorName;
	private String donorTextContent;
	@DaumEmpty(message="내용을 입력해 주세요.",groups={DonorInsert.class,DonorUpdate.class})
	@CheckXSS(groups={DonorInsert.class,DonorUpdate.class})
	private String donorHTMLContent;
	private String donorDate;
	private java.util.Date regDttm;
	private String regID;
	private java.util.Date modDttm;
	private String modID;
	
	private java.util.List<String> imageList;		// 이미지 URL 목록
	private String attach_image_info;
	
	public DonorVO(){
	}
	
	public int getDonorSeq() {
		return donorSeq;
	}

	public void setDonorSeq(int donorSeq) {
		this.donorSeq = donorSeq;
	}

	public String getDonorNO() {
		return donorNO;
	}

	public void setDonorNO(String donorNO) {
		this.donorNO = donorNO;
	}

	public String getDonorTitle() {
		return donorTitle;
	}

	public void setDonorTitle(String donorTitle) {
		this.donorTitle = donorTitle;
	}

	public String getDonorName() {
		return donorName;
	}

	public void setDonorName(String donorName) {
		this.donorName = donorName;
	}

	public String getDonorTextContent() {
		return donorTextContent;
	}

	public void setDonorTextContent(String donorTextContent) {
		this.donorTextContent = donorTextContent;
	}

	public String getDonorHTMLContent() {
		return donorHTMLContent;
	}

	public void setDonorHTMLContent(String donorHTMLContent) {
		this.donorHTMLContent = donorHTMLContent;
	}

	public String getDonorDate() {
		return donorDate;
	}

	public void setDonorDate(String donorDate) {
		this.donorDate = donorDate;
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
	
	@Override
	public String toString() {
		return "DonorVO [donorSeq=" + donorSeq
				+ ", donorNO=" + donorNO
				+ ", donorName=" + donorName
				+ ", donorTitle=" + donorTitle
				+ ", donorTextContent=" + donorTextContent
				+ ", donorHTMLContent=" + donorHTMLContent
				+ ", regDttm=" + regDttm + ", regID=" + regID + ", modDttm=" + modDttm
				+ ", modID=" + modID + ", imageList=" + imageList
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
	
	private interface DonorList{}
	private interface DonorView{}
	private interface DonorWrite{}
	private interface DonorEdit{}
	private interface DonorInsert{}
	private interface DonorUpdate{}
	private interface DonorDelete{}
	private interface DonorComment{}
	private interface DonorReply{}
	
	@GroupSequence({DonorList.class})
	public static interface DonorListVal{}
	
	@GroupSequence({DonorView.class})
	public static interface DonorViewVal{}
	
	@GroupSequence({DonorWrite.class})
	public static interface DonorWriteVal{}
	
	@GroupSequence({DonorEdit.class})
	public static interface DonorEditVal{}
	
	@GroupSequence({GetMode.class,DonorInsert.class,DonorUpdate.class})
	public static interface DonorPersistVal{}
	
	@GroupSequence({GetMode.class,DonorDelete.class})
	public static interface DonorDeleteVal{}
	
	@GroupSequence({DonorList.class,DonorView.class,DonorWrite.class,DonorEdit.class,DonorInsert.class,DonorUpdate.class,DonorDelete.class,DonorComment.class,DonorReply.class})
	public static interface DonorAllVal{}

}
