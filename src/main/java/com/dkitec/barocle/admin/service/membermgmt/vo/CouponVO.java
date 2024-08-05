package com.dkitec.barocle.admin.service.membermgmt.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@SuppressWarnings("serial")
@Alias("CouponVO")
public class CouponVO extends PagingVO implements Serializable {


	private String usr_seq;
	private String usrMpnNo;
	private String couponName;
	private String couponNo;
	private String regDttm;
	private String sendDttm;
	private String recvPhoneNo;
	private String voucherBgnDttm;
	private String voucherEndDttm;
	private String voucherUseYn;
	private String voucherStatus;
	private String couponStatus;
	private String couponSender;
	private String btn_chk;
	private String telNo;
	private String paymentDttm;
	
	public String getPaymentDttm() {
		return paymentDttm;
	}

	public void setPaymentDttm(String paymentDttm) {
		this.paymentDttm = paymentDttm;
	}

	private String lang = IConstants.LANG_KR;

	



	public String getTelNo() {
		return telNo;
	}

	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}

	public String getBtn_chk() {
		return btn_chk;
	}

	public void setBtn_chk(String btn_chk) {
		this.btn_chk = btn_chk;
	}

	public String getUsr_seq() {
		return usr_seq;
	}

	public void setUsr_seq(String usr_seq) {
		this.usr_seq = usr_seq;
	}

	public String getUsrMpnNo() {
		return usrMpnNo;
	}

	public void setUsrMpnNo(String usrMpnNo) {
		this.usrMpnNo = usrMpnNo;
	}

	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}

	public String getCouponNo() {
		return couponNo;
	}

	public void setCouponNo(String couponNo) {
		this.couponNo = couponNo;
	}

	public String getRegDttm() {
		return regDttm;
	}

	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}

	public String getSendDttm() {
		return sendDttm;
	}

	public void setSendDttm(String sendDttm) {
		this.sendDttm = sendDttm;
	}

	public String getRecvPhoneNo() {
		return recvPhoneNo;
	}

	public void setRecvPhoneNo(String recvPhoneNo) {
		this.recvPhoneNo = recvPhoneNo;
	}

	public String getVoucherBgnDttm() {
		return voucherBgnDttm;
	}

	public void setVoucherBgnDttm(String voucherBgnDttm) {
		this.voucherBgnDttm = voucherBgnDttm;
	}

	public String getVoucherEndDttm() {
		return voucherEndDttm;
	}

	public void setVoucherEndDttm(String voucherEndDttm) {
		this.voucherEndDttm = voucherEndDttm;
	}

	public String getVoucherUseYn() {
		return voucherUseYn;
	}

	public void setVoucherUseYn(String voucherUseYn) {
		this.voucherUseYn = voucherUseYn;
	}

	public String getVoucherStatus() {
		return voucherStatus;
	}

	public void setVoucherStatus(String voucherStatus) {
		this.voucherStatus = voucherStatus;
	}

	public String getCouponStatus() {
		return couponStatus;
	}

	public void setCouponStatus(String couponStatus) {
		this.couponStatus = couponStatus;
	}

	public String getCouponSender() {
		return couponSender;
	}

	public void setCouponSender(String couponSender) {
		this.couponSender = couponSender;
	}

	public String getLang() {
		return lang;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}

	@Override
	public String toString() {
		return "CouponVO [usrSeq=" + usr_seq + ", usrMpnNo=" + usrMpnNo
				+ ", couponName=" + couponName + ", couponNo=" + couponNo
				+ ", regDttm=" + regDttm + ", sendDttm=" + sendDttm
				+ ", recvPhoneNo=" + recvPhoneNo + ", voucherBgnDttm="
				+ voucherBgnDttm + ", voucherEndDttm=" + voucherEndDttm
				+ ", voucherUseYn=" + voucherUseYn + ", voucherStatus="
				+ voucherStatus + ", couponStatus=" + couponStatus
				+ ", couponSender=" + couponSender + ", lang=" + lang + "]";
	}
}
