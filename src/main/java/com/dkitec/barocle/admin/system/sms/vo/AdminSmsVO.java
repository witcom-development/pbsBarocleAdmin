package com.dkitec.barocle.admin.system.sms.vo;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@Alias("adminSmsVO")
public class AdminSmsVO extends CommonVo implements java.io.Serializable {
	
	private static final long serialVersionUID = 3453447728032933309L;
	
	//TB_SYS_REQ_ADMIN_SMS
	private String reqSmsSeq;
	private String reqTitle;
	private String reqContent;
	private String reqResDate;
	private String reqSendType;
	private String reqSendYn;
	private String regDttm;
	private String regId;
	private String modDttm;
	private String modId;
	
	private String adminIdArr;
	
	//TB_SYS_REQ_ADMIN_SMS_DTL
	private String reqSmsDtlSeq;
	private String messageSeq;
	private String adminId;
	private String sendResultCd;
	
	//search	
	private String searchAdmin;
	private String searchAprd;
	
	//
	private String adminName;
	private String adminGrpName;
	private String adminPno;
	
	//
	private String reqSendAdmTelNo; //발송자 번호(전송문자 발신번호)
	
	public String getReqSmsSeq() {
		return reqSmsSeq;
	}
	public void setReqSmsSeq(String reqSmsSeq) {
		this.reqSmsSeq = reqSmsSeq;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getReqTitle() {
		return reqTitle;
	}
	public void setReqTitle(String reqTitle) {
		this.reqTitle = reqTitle;
	}
	public String getReqContent() {
		return reqContent;
	}
	public void setReqContent(String reqContent) {
		this.reqContent = reqContent;
	}
	public String getReqResDate() {
		return reqResDate;
	}
	public void setReqResDate(String reqResDate) {
		this.reqResDate = reqResDate;
	}
	public String getReqSendType() {
		return reqSendType;
	}
	public void setReqSendType(String reqSendType) {
		this.reqSendType = reqSendType;
	}
	public String getReqSmsDtlSeq() {
		return reqSmsDtlSeq;
	}
	public void setReqSmsDtlSeq(String reqSmsDtlSeq) {
		this.reqSmsDtlSeq = reqSmsDtlSeq;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getModDttm() {
		return modDttm;
	}
	public void setModDttm(String modDttm) {
		this.modDttm = modDttm;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getAdminIdArr() {
		return adminIdArr;
	}
	public void setAdminIdArr(String adminIdArr) {
		this.adminIdArr = adminIdArr;
	}
	public String getSearchAprd() {
		return searchAprd;
	}
	public void setSearchAprd(String searchAprd) {
		this.searchAprd = searchAprd;
	}
	public String getSearchAdmin() {
		return searchAdmin;
	}
	public void setSearchAdmin(String searchAdmin) {
		this.searchAdmin = searchAdmin;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getAdminPno() {
		return adminPno;
	}
	public void setAdminPno(String adminPno) {
		this.adminPno = adminPno;
	}
	public String getMessageSeq() {
		return messageSeq;
	}
	public void setMessageSeq(String messageSeq) {
		this.messageSeq = messageSeq;
	}
	public String getReqSendYn() {
		return reqSendYn;
	}
	public void setReqSendYn(String reqSendYn) {
		this.reqSendYn = reqSendYn;
	}
	public String getSendResultCd() {
		return sendResultCd;
	}
	public void setSendResultCd(String sendResultCd) {
		this.sendResultCd = sendResultCd;
	}
	public String getAdminGrpName() {
		return adminGrpName;
	}
	public void setAdminGrpName(String adminGrpName) {
		this.adminGrpName = adminGrpName;
	}
	public String getReqSendAdmTelNo() {
		return reqSendAdmTelNo;
	}
	public void setReqSendAdmTelNo(String reqSendAdmTelNo) {
		this.reqSendAdmTelNo = reqSendAdmTelNo;
	}


	
}
