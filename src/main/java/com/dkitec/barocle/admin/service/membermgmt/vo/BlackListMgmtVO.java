package com.dkitec.barocle.admin.service.membermgmt.vo;

import java.io.Serializable;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;

@SuppressWarnings("serial")
public class BlackListMgmtVO extends PagingVO implements Serializable {

	@IsNumeric(groups={blackListInsertValid.class, blackListDeleteValid.class})
	@CheckValue(message="회원 일련번호를 입력해주세요.",groups={blackListInsertValid.class, blackListDeleteValid.class})
	private String usrSeq;
	
	private String mbId;
	private String mbTelNo;
	private String usrMpnNo;
	private String blkListReasonCd;
	private String blkListReasonName;
	private String blkListStrDate;
	private String blkListEndDate;
	private String blkListRegDttm;
	private String modStrDate;
	private String modEndDate;
	private String auth_di_val;
	private String readClsCd;
	
	public String getReadClsCd() {
		return readClsCd;
	}
	public void setReadClsCd(String readClsCd) {
		this.readClsCd = readClsCd;
	}
	public String getAuth_di_val() {
		return auth_di_val;
	}
	public void setAuth_di_val(String auth_di_val) {
		this.auth_di_val = auth_di_val;
	}
	public String getUsrSeq() {
		return usrSeq;
	}
	public void setUsrSeq(String usrSeq) {
		this.usrSeq = usrSeq;
	}
	public String getMbId() {
		return mbId;
	}
	public void setMbId(String mbId) {
		this.mbId = mbId;
	}
	public String getMbTelNo() {
		return mbTelNo;
	}
	public void setMbTelNo(String mbTelNo) {
		this.mbTelNo = mbTelNo;
	}
	public String getBlkListReasonCd() {
		return blkListReasonCd;
	}
	public void setBlkListReasonCd(String blkListReasonCd) {
		this.blkListReasonCd = blkListReasonCd;
	}
	public String getBlkListRegDttm() {
		return blkListRegDttm;
	}
	public void setBlkListRegDttm(String blkListRegDttm) {
		this.blkListRegDttm = blkListRegDttm;
	}
	public String getModStrDate() {
		return modStrDate;
	}
	public void setModStrDate(String modStrDate) {
		this.modStrDate = modStrDate;
	}
	public String getModEndDate() {
		return modEndDate;
	}
	public void setModEndDate(String modEndDate) {
		this.modEndDate = modEndDate;
	}
	public String getBlkListStrDate() {
		return blkListStrDate;
	}
	public void setBlkListStrDate(String blkListStrDate) {
		this.blkListStrDate = blkListStrDate;
	}
	public String getBlkListEndDate() {
		return blkListEndDate;
	}
	public void setBlkListEndDate(String blkListEndDate) {
		this.blkListEndDate = blkListEndDate;
	}
	public String getBlkListReasonName() {
		return blkListReasonName;
	}
	public void setBlkListReasonName(String blkListReasonName) {
		this.blkListReasonName = blkListReasonName;
	}
	
	public String getUsrMpnNo() {
		return usrMpnNo;
	}
	public void setUsrMpnNo(String usrMpnNo) {
		this.usrMpnNo = usrMpnNo;
	}

	public static interface blackListInsertValid{}
	public static interface blackListDeleteValid{}
	
}
