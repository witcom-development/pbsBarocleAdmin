package com.dkitec.barocle.admin.customer.hikingcourse.vo;

import javax.validation.GroupSequence;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.CheckXSS;
import com.dkitec.barocle.util.validator.annotation.DaumEmpty;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;
import com.dkitec.barocle.util.validator.annotation.IsYN;
import com.dkitec.barocle.util.validator.annotation.SearchDate;

@Alias("hikingCourseVO")
@SearchDate(groups=PagingVO.SearchDateValidator.class)
public class HikingCourseVO extends PagingVO implements java.io.Serializable {
	
	private static final long serialVersionUID = -2790794294343501127L;
	private static final String currentMenu = "CTM_006";
	private static final String currentMenuName = "hikingcourse";
	
	@IsNumeric(groups={HikingCourseView.class,HikingCourseUpdate.class,HikingCourseDelete.class})
	private int hikingCourseSeq;
	private String cateCD;
	private String hikingCourseNO;
	@CheckValue(message="제목을 입력해 주세요.",groups={HikingCourseInsert.class,HikingCourseUpdate.class})
	@CheckXSS(groups={HikingCourseInsert.class,HikingCourseUpdate.class})
	private String hikingCourseTitle;
	private String hikingCourseTextContent;
	@DaumEmpty(message="내용을 입력해 주세요.",groups={HikingCourseInsert.class,HikingCourseUpdate.class})
	@CheckXSS(groups={HikingCourseInsert.class,HikingCourseUpdate.class})
	private String hikingCourseHTMLContent;
	@CheckValue(message="자치구를 선택해 주세요.",groups={HikingCourseInsert.class,HikingCourseUpdate.class})
	private String districtCD;
	@IsNumeric(message="총 거리를 입력해 주세요.",groups={HikingCourseInsert.class,HikingCourseUpdate.class})
	private int courseDist;
	private int readCnt;
	@IsYN(groups={HikingCourseInsert.class,HikingCourseUpdate.class})
	private String useYN;
	private java.util.Date regDttm;
	private String regID;
	private java.util.Date modDttm;
	private String modID;
	
	private java.util.List<String> imageList;		// 이미지 URL 목록
	private String attach_image_info;
	
	private String cdDesc1;
	private String cdDesc2;
	
	
	public HikingCourseVO(){
		this.useYN = "Y";
	}
	
	
	public int getHikingCourseSeq() {
		return hikingCourseSeq;
	}

	public void setHikingCourseSeq(int hikingCourseSeq) {
		this.hikingCourseSeq = hikingCourseSeq;
	}

	public String getCateCD() {
		return cateCD;
	}

	public void setCateCD(String cateCD) {
		this.cateCD = cateCD;
	}

	public String getHikingCourseNO() {
		return hikingCourseNO;
	}

	public void setHikingCourseNO(String hikingCourseNO) {
		this.hikingCourseNO = hikingCourseNO;
	}

	public String getHikingCourseTitle() {
		return hikingCourseTitle;
	}

	public void setHikingCourseTitle(String hikingCourseTitle) {
		this.hikingCourseTitle = hikingCourseTitle;
	}

	public String getHikingCourseTextContent() {
		return hikingCourseTextContent;
	}

	public void setHikingCourseTextContent(String hikingCourseTextContent) {
		this.hikingCourseTextContent = hikingCourseTextContent;
	}

	public String getHikingCourseHTMLContent() {
		return hikingCourseHTMLContent;
	}

	public void setHikingCourseHTMLContent(String hikingCourseHTMLContent) {
		this.hikingCourseHTMLContent = hikingCourseHTMLContent;
	}

	public String getDistrictCD() {
		return districtCD;
	}

	public void setDistrictCD(String districtCD) {
		this.districtCD = districtCD;
	}

	public int getCourseDist() {
		return courseDist;
	}

	public void setCourseDist(int courseDist) {
		this.courseDist = courseDist;
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
		return "HikingCourseVO [hikingCourseSeq=" + hikingCourseSeq
				+ ", cateCD=" + cateCD + ", hikingCourseNO=" + hikingCourseNO
				+ ", hikingCourseTitle=" + hikingCourseTitle
				+ ", hikingCourseTextContent=" + hikingCourseTextContent
				+ ", hikingCourseHTMLContent=" + hikingCourseHTMLContent
				+ ", districtCD=" + districtCD + ", courseDist=" + courseDist
				+ ", readCnt=" + readCnt + ", useYN=" + useYN + ", regDttm="
				+ regDttm + ", regID=" + regID + ", modDttm=" + modDttm
				+ ", modID=" + modID + ", imageList=" + imageList
				+ ", attach_image_info=" + attach_image_info + ", cdDesc1="
				+ cdDesc1 + ", cdDesc2=" + cdDesc2 + ", getCurrentPageNo()="
				+ getCurrentPageNo() + ", getRecordCountPerPage()="
				+ getRecordCountPerPage() + ", getPageSize()=" + getPageSize()
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
	
	private interface HikingCourseList{}
	private interface HikingCourseView{}
	private interface HikingCourseWrite{}
	private interface HikingCourseEdit{}
	private interface HikingCourseInsert{}
	private interface HikingCourseUpdate{}
	private interface HikingCourseDelete{}
	private interface HikingCourseComment{}
	private interface HikingCourseReply{}
	
	@GroupSequence({HikingCourseList.class})
	public static interface HikingCourseListVal{}
	
	@GroupSequence({HikingCourseView.class})
	public static interface HikingCourseViewVal{}
	
	@GroupSequence({HikingCourseWrite.class})
	public static interface HikingCourseWriteVal{}
	
	@GroupSequence({HikingCourseEdit.class})
	public static interface HikingCourseEditVal{}
	
	@GroupSequence({GetMode.class,HikingCourseInsert.class,HikingCourseUpdate.class})
	public static interface HikingCoursePersistVal{}
	
	@GroupSequence({GetMode.class,HikingCourseDelete.class})
	public static interface HikingCourseDeleteVal{}
	
	@GroupSequence({HikingCourseList.class,HikingCourseView.class,HikingCourseWrite.class,HikingCourseEdit.class,HikingCourseInsert.class,HikingCourseUpdate.class,HikingCourseDelete.class,HikingCourseComment.class,HikingCourseReply.class})
	public static interface HikingCourseAllVal{}

}
