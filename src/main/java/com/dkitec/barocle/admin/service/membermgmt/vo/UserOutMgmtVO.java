package com.dkitec.barocle.admin.service.membermgmt.vo;

import java.io.Serializable;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@SuppressWarnings("serial")
public class UserOutMgmtVO extends PagingVO implements Serializable {

	private String mbId;
	private String sexCd;
	private String usrBirthDate;
	private String leaveReasonCd;
	private String leaveDttm;
	private String blklistYn;
	private String leaveStrDate;
	private String leaveEndDate;
	
	public String getMbId() {
		return mbId;
	}
	public void setMbId(String mbId) {
		this.mbId = mbId;
	}
	public String getSexCd() {
		return sexCd;
	}
	public void setSexCd(String sexCd) {
		this.sexCd = sexCd;
	}
	public String getUsrBirthDate() {
		return usrBirthDate;
	}
	public void setUsrBirthDate(String usrBirthDate) {
		this.usrBirthDate = usrBirthDate;
	}
	public String getLeaveReasonCd() {
		return leaveReasonCd;
	}
	public void setLeaveReasonCd(String leaveReasonCd) {
		this.leaveReasonCd = leaveReasonCd;
	}
	public String getLeaveDttm() {
		return leaveDttm;
	}
	public void setLeaveDttm(String leaveDttm) {
		this.leaveDttm = leaveDttm;
	}
	public String getBlklistYn() {
		return blklistYn;
	}
	public void setBlklistYn(String blklistYn) {
		this.blklistYn = blklistYn;
	}
	public String getLeaveStrDate() {
		return leaveStrDate;
	}
	public void setLeaveStrDate(String leaveStrDate) {
		this.leaveStrDate = leaveStrDate;
	}
	public String getLeaveEndDate() {
		return leaveEndDate;
	}
	public void setLeaveEndDate(String leaveEndDate) {
		this.leaveEndDate = leaveEndDate;
	}
	
}
