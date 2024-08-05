package com.dkitec.barocle.admin.manage.suspension.vo;

import org.apache.ibatis.type.Alias;

@Alias("voucherHistVO")
public class VoucherHistVO implements java.io.Serializable {
	
	private static final long serialVersionUID = 4734293639988634235L;
	
	private int voucherSeq;
	private int delaySeq;
	private java.util.Date applyDttm;
	private String delayDdCnt;
	private java.util.Date voucherStrDttm;
	private java.util.Date voucherEndDttm;
	
	public int getVoucherSeq() {
		return voucherSeq;
	}
	public void setVoucherSeq(int voucherSeq) {
		this.voucherSeq = voucherSeq;
	}
	public int getDelaySeq() {
		return delaySeq;
	}
	public void setDelaySeq(int delaySeq) {
		this.delaySeq = delaySeq;
	}
	public java.util.Date getApplyDttm() {
		return applyDttm;
	}
	public void setApplyDttm(java.util.Date applyDttm) {
		this.applyDttm = applyDttm;
	}
	public String getDelayDdCnt() {
		return delayDdCnt;
	}
	public void setDelayDdCnt(String delayDdCnt) {
		this.delayDdCnt = delayDdCnt;
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
	
	@Override
	public String toString() {
		return "VoucherHistVO [voucherSeq=" + voucherSeq + ", delaySeq="
				+ delaySeq + ", applyDttm=" + applyDttm + ", delayDdCnt="
				+ delayDdCnt + ", voucherStrDttm=" + voucherStrDttm
				+ ", voucherEndDttm=" + voucherEndDttm + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}
	
}
