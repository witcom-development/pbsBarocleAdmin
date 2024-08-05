package com.dkitec.barocle.admin.manage.suspension.vo;

import org.apache.ibatis.type.Alias;

@Alias("voucherVO")
public class VoucherVO implements java.io.Serializable {
	
	private static final long serialVersionUID = 3588203331676299980L;
	
	private int voucherSeq;
	private int usrSeq;
	private String paymentClsCD;
	private int paymenSeq;
	private java.util.Date paymentDttm;
	private String couponNO;
	private java.util.Date voucherStrDttm;
	private java.util.Date voucherEndDttm;
	private java.util.Date firstStrDttm;
	private java.util.Date firstEndDttm;
	private int partyUseCnt;
	private String voucherUseYN;
	
	private String dateDiff;
	private String newVoucherEndDttm;
	
	public VoucherVO(){
		this.voucherUseYN = "N";
	}
	
	public int getVoucherSeq() {
		return voucherSeq;
	}
	public void setVoucherSeq(int voucherSeq) {
		this.voucherSeq = voucherSeq;
	}
	public int getUsrSeq() {
		return usrSeq;
	}
	public void setUsrSeq(int usrSeq) {
		this.usrSeq = usrSeq;
	}
	public String getPaymentClsCD() {
		return paymentClsCD;
	}
	public void setPaymentClsCD(String paymentClsCD) {
		this.paymentClsCD = paymentClsCD;
	}
	public int getPaymenSeq() {
		return paymenSeq;
	}
	public void setPaymenSeq(int paymenSeq) {
		this.paymenSeq = paymenSeq;
	}
	public java.util.Date getPaymentDttm() {
		return paymentDttm;
	}
	public void setPaymentDttm(java.util.Date paymentDttm) {
		this.paymentDttm = paymentDttm;
	}
	public String getCouponNO() {
		return couponNO;
	}
	public void setCouponNO(String couponNO) {
		this.couponNO = couponNO;
	}
	public java.util.Date getVoucherStrDttm() {
		return voucherStrDttm;
	}
	public void setVoucherStrDttm(java.util.Date voucherStrDttm) {
		this.voucherStrDttm = voucherStrDttm;
	}
	public java.util.Date getVoucherEndDttm() {
		return voucherEndDttm;
	}
	public void setVoucherEndDttm(java.util.Date voucherEndDttm) {
		this.voucherEndDttm = voucherEndDttm;
	}
	public java.util.Date getFirstStrDttm() {
		return firstStrDttm;
	}
	public void setFirstStrDttm(java.util.Date firstStrDttm) {
		this.firstStrDttm = firstStrDttm;
	}
	public java.util.Date getFirstEndDttm() {
		return firstEndDttm;
	}
	public void setFirstEndDttm(java.util.Date firstEndDttm) {
		this.firstEndDttm = firstEndDttm;
	}
	public int getPartyUseCnt() {
		return partyUseCnt;
	}
	public void setPartyUseCnt(int partyUseCnt) {
		this.partyUseCnt = partyUseCnt;
	}
	public String getVoucherUseYN() {
		return voucherUseYN;
	}
	public void setVoucherUseYN(String voucherUseYN) {
		this.voucherUseYN = voucherUseYN;
	}
	public String getDateDiff() {
		return dateDiff;
	}
	public void setDateDiff(String dateDiff) {
		this.dateDiff = dateDiff;
	}
	public String getNewVoucherEndDttm() {
		return newVoucherEndDttm;
	}
	public void setNewVoucherEndDttm(String newVoucherEndDttm) {
		this.newVoucherEndDttm = newVoucherEndDttm;
	}
	
	@Override
	public String toString() {
		return "VoucherVO [voucherSeq=" + voucherSeq + ", usrSeq=" + usrSeq
				+ ", paymentClsCD=" + paymentClsCD + ", paymenSeq=" + paymenSeq
				+ ", paymentDttm=" + paymentDttm + ", couponNO=" + couponNO
				+ ", voucherStrDttm=" + voucherStrDttm + ", voucherEndDttm="
				+ voucherEndDttm + ", firstStrDttm=" + firstStrDttm
				+ ", firstEndDttm=" + firstEndDttm + ", partyUseCnt="
				+ partyUseCnt + ", voucherUseYN=" + voucherUseYN
				+ ", dateDiff=" + dateDiff + ", newVoucherEndDttm="
				+ newVoucherEndDttm + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}
	
}
