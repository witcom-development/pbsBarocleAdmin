package com.dkitec.barocle.util.sms.vo;

import javax.validation.GroupSequence;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.CheckXSS;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;
import com.dkitec.barocle.util.validator.annotation.SearchDate;

@Alias("smsBodyVO")
@SearchDate(groups=PagingVO.SearchDateValidator.class)
public class SmsBodyVO implements java.io.Serializable {
	
	private static final long serialVersionUID = -5351574270118880859L;
	
	@IsNumeric(groups={SmsEdit.class,SmsUpdate.class,SmsDelete.class})
	private long smsSeq;
	@CheckValue(groups={SmsInsert.class,SmsUpdate.class})
	@CheckXSS(groups={SmsInsert.class,SmsUpdate.class})
	private String sendClsName;
	private String autoSendYN;
	private String autoSendID;
	@CheckValue(groups={SmsInsert.class,SmsUpdate.class})
	@CheckXSS(groups={SmsInsert.class,SmsUpdate.class})
	private String orignlMsg;
	@CheckXSS(groups={SmsInsert.class,SmsUpdate.class})
	private String noteDesc;
	private String regID;
	private java.util.Date regDttm;
	
	private String adminID;
	private String adminName;
	
	
	public SmsBodyVO(){
		this.autoSendYN = "N";
	}
	
	
	public long getSmsSeq() {
		return smsSeq;
	}

	public void setSmsSeq(long smsSeq) {
		this.smsSeq = smsSeq;
	}

	public String getSendClsName() {
		return sendClsName;
	}

	public void setSendClsName(String sendClsName) {
		this.sendClsName = sendClsName;
	}

	public String getAutoSendYN() {
		return autoSendYN;
	}

	public void setAutoSendYN(String autoSendYN) {
		this.autoSendYN = autoSendYN;
	}

	public String getAutoSendID() {
		return autoSendID;
	}

	public void setAutoSendID(String autoSendID) {
		this.autoSendID = autoSendID;
	}

	public String getOrignlMsg() {
		return orignlMsg;
	}

	public void setOrignlMsg(String orignlMsg) {
		this.orignlMsg = orignlMsg;
	}

	public String getNoteDesc() {
		return noteDesc;
	}

	public void setNoteDesc(String noteDesc) {
		this.noteDesc = noteDesc;
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
	
	@Override
	public String toString() {
		return "SmsBodyVO [smsSeq=" + smsSeq + ", sendClsName=" + sendClsName
				+ ", autoSendYN=" + autoSendYN + ", autoSendID=" + autoSendID
				+ ", orignlMsg=" + orignlMsg + ", noteDesc=" + noteDesc
				+ ", regID=" + regID + ", regDttm=" + regDttm + ", adminID="
				+ adminID + ", adminName=" + adminName
				+ ", toString()=" + super.toString() + ", getMode()="
				+ ", getClass()=" + getClass() + ", hashCode()="
				+ hashCode() + "]";
	}
	
	private interface SmsList{}
	private interface SmsEdit{}
	private interface SmsInsert{}
	private interface SmsUpdate{}
	private interface SmsDelete{}
	
	@GroupSequence({SmsList.class})
	public static interface SmsListVal{}
	
	@GroupSequence({SmsEdit.class})
	public static interface SmsEditVal{}
	
}
