package com.dkitec.barocle.admin.system.appversion.vo;

import javax.validation.GroupSequence;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;
import com.dkitec.barocle.util.validator.annotation.SearchDate;

@Alias("appVersionVO")
@SearchDate(groups=PagingVO.SearchDateValidator.class)
public class AppVersionVO extends PagingVO implements java.io.Serializable {

	private static final long serialVersionUID = -4079875176792615616L;
	
	@IsNumeric(groups={AppVersionEdit.class,AppVersionInsert.class,AppVersionUpdate.class})
	private int appSeq;
	/*@CheckValue(message="OS 구분을 선택해 주세요.",groups={AppVersionInsert.class,AppVersionUpdate.class})*/
	private String osClsCD;
	private String osClsName;
	@CheckValue(message="버전정보를 입력해 주세요.",groups={AppVersionInsert.class,AppVersionUpdate.class})
	private String appVerInfo;
	/*@CheckValue(message="메세지 구분을 선택해 주세요.",groups={AppVersionInsert.class,AppVersionUpdate.class})*/
	private String updateClsCD;
	private String updateClsName;
	@CheckValue(message="앱 마켓 주소를 입력해 주세요.",groups={AppVersionInsert.class,AppVersionUpdate.class})
	private String downloadPath;
	@CheckValue(message="내용을 입력해 주세요.",groups={AppVersionInsert.class,AppVersionUpdate.class})
	@Size(min=1,max=400)
	private String msgContent;
	private String regID;
	private java.util.Date regDttm;
	
	private String adminID;
	private String adminName;
	
	private java.util.List<CategoryVO> codeOSS;
	private java.util.List<CategoryVO> codeUDT;
	
	
	public int getAppSeq() {
		return appSeq;
	}

	public void setAppSeq(int appSeq) {
		this.appSeq = appSeq;
	}

	public String getOsClsCD() {
		return osClsCD;
	}

	public void setOsClsCD(String osClsCD) {
		this.osClsCD = osClsCD;
	}

	public String getOsClsName() {
		return osClsName;
	}

	public void setOsClsName(String osClsName) {
		this.osClsName = osClsName;
	}

	public String getAppVerInfo() {
		return appVerInfo;
	}

	public void setAppVerInfo(String appVerInfo) {
		this.appVerInfo = appVerInfo;
	}

	public String getUpdateClsCD() {
		return updateClsCD;
	}

	public void setUpdateClsCD(String updateClsCD) {
		this.updateClsCD = updateClsCD;
	}

	public String getUpdateClsName() {
		return updateClsName;
	}

	public void setUpdateClsName(String updateClsName) {
		this.updateClsName = updateClsName;
	}

	public String getDownloadPath() {
		return downloadPath;
	}

	public void setDownloadPath(String downloadPath) {
		this.downloadPath = downloadPath;
	}

	public String getMsgContent() {
		return msgContent;
	}

	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
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

	public String getAdminID() {
		return adminID;
	}

	public void setAdminID(String adminID) {
		this.adminID = adminID;
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	public java.util.List<CategoryVO> getCodeOSS() {
		return codeOSS;
	}

	public void setCodeOSS(java.util.List<CategoryVO> codeOSS) {
		this.codeOSS = codeOSS;
	}

	public java.util.List<CategoryVO> getCodeUDT() {
		return codeUDT;
	}

	public void setCodeUDT(java.util.List<CategoryVO> codeUDT) {
		this.codeUDT = codeUDT;
	}
	
	@Override
	public String toString() {
		return "AppVersionVO [appSeq=" + appSeq + ", osClsCD=" + osClsCD
				+ ", osClsName=" + osClsName + ", appVerInfo=" + appVerInfo
				+ ", updateClsCD=" + updateClsCD + ", updateClsName="
				+ updateClsName + ", downloadPath=" + downloadPath
				+ ", msgContent=" + msgContent + ", regID=" + regID
				+ ", regDttm=" + regDttm + ", adminID=" + adminID
				+ ", adminName=" + adminName + ", codeOSS=" + codeOSS
				+ ", codeUDT=" + codeUDT + ", getCurrentPageNo()="
				+ getCurrentPageNo() + ", getRecordCountPerPage()="
				+ getRecordCountPerPage() + ", getPageSize()=" + getPageSize()
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
	
	private interface AppVersionList{}
	private interface AppVersionEdit{}
	private interface AppVersionInsert{}
	private interface AppVersionUpdate{}
	private interface AppVersionDelete{}
	
	@GroupSequence({AppVersionList.class})
	public static interface AppVersionListVal{}
	
	@GroupSequence({AppVersionEdit.class})
	public static interface AppVersionEditVal{}
	
	@GroupSequence({GetMode.class,AppVersionInsert.class})
	public static interface AppVersionInsertVal{}
	
	@GroupSequence({GetMode.class,AppVersionUpdate.class})
	public static interface AppVersionUpdateVal{}
	
	@GroupSequence({GetMode.class,AppVersionDelete.class})
	public static interface AppVersionDeleteVal{}
	
}
