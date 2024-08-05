package com.dkitec.barocle.admin.manage.suspension.vo;

import javax.validation.GroupSequence;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;
import com.dkitec.barocle.util.validator.annotation.SearchDate;

@Alias("suspensionVO")
@SearchDate(groups=PagingVO.SearchDateValidator.class)
public class SuspensionVO extends PagingVO implements java.io.Serializable {
	
	private static final long serialVersionUID = 6532781777338856405L;
	
	@IsNumeric(groups={SuspensionUpdate.class,SuspensionDelete.class})
	private int delaySeq;
	@NotNull(message="운휴 시작일을 입력해 주세요.",groups={SuspensionInsert.class,SuspensionUpdate.class})
	private java.util.Date delayStrDate;
	@NotNull(message="운휴 시작일을 입력해 주세요.",groups={SuspensionInsert.class,SuspensionUpdate.class})
	private java.util.Date delayEndDate;
	private String ticketChngYN;
	@CheckValue(message="운휴 사유를 입력해 주세요.",groups={SuspensionInsert.class,SuspensionUpdate.class})
	@Size(message="500자 이내 입력해 주세요.",max=500)
	private String delayReasonDesc;
	private java.util.Date regDttm;
	private String regID;
	private java.util.Date modDttm;
	private String modID;
	
	private String adminName;
	
	public SuspensionVO(){
		this.ticketChngYN = "N";
	}
	
	public int getDelaySeq() {
		return delaySeq;
	}

	public void setDelaySeq(int delaySeq) {
		this.delaySeq = delaySeq;
	}

	public java.util.Date getDelayStrDate() {
		return delayStrDate;
	}

	public void setDelayStrDate(java.util.Date delayStrDate) {
		this.delayStrDate = delayStrDate;
	}

	public java.util.Date getDelayEndDate() {
		return delayEndDate;
	}

	public void setDelayEndDate(java.util.Date delayEndDate) {
		this.delayEndDate = delayEndDate;
	}

	public String getTicketChngYN() {
		return ticketChngYN;
	}

	public void setTicketChngYN(String ticketChngYN) {
		this.ticketChngYN = ticketChngYN;
	}

	public String getDelayReasonDesc() {
		return delayReasonDesc;
	}

	public void setDelayReasonDesc(String delayReasonDesc) {
		this.delayReasonDesc = delayReasonDesc;
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

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	
	@Override
	public String toString() {
		return "SuspensionVO [delaySeq=" + delaySeq + ", delayStrDate="
				+ delayStrDate + ", delayEndDate=" + delayEndDate
				+ ", ticketChngYN=" + ticketChngYN + ", delayReasonDesc="
				+ delayReasonDesc + ", regDttm=" + regDttm + ", regID=" + regID
				+ ", modDttm=" + modDttm + ", modID=" + modID + ", adminName="
				+ adminName + ", getCurrentPageNo()=" + getCurrentPageNo()
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
	
	private interface SuspensionList{}
	private interface SuspensionEdit{}
	private interface SuspensionInsert{}
	private interface SuspensionUpdate{}
	private interface SuspensionDelete{}
	
	@GroupSequence({SuspensionList.class})
	public static interface SuspensionListVal{}
	
	@GroupSequence({SuspensionEdit.class})
	public static interface SuspensionEditVal{}
	
	@GroupSequence({GetMode.class,SuspensionInsert.class,SuspensionUpdate.class})
	public static interface SuspensionPersistVal{}
	
	@GroupSequence({GetMode.class,SuspensionDelete.class})
	public static interface SuspensionDeleteVal{}

}
