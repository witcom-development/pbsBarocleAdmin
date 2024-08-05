package com.dkitec.barocle.admin.service.membermgmt.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@SuppressWarnings("serial")
@Alias("voucherMgmtVO")
public class VoucherMgmtVO extends PagingVO implements Serializable {
	private String voucherCd;
	private String voucherName;
	private String usr_seq;
	private String usr_mpn_no;
	private String mb_id;
	private String payment_cls_cd;
	private String admin_id;
	private String voucher_create_reason;
	private String voucher_extend_reason;
	private String payment_seq;
	private String payment_dttm;
	private String voucher_str_dttm;
	private String voucher_end_dttm;
	private String voucher_seq;
	private String party_use_cnt;
	
	public String getVoucher_seq() {
		return voucher_seq;
	}
	public void setVoucher_seq(String voucher_seq) {
		this.voucher_seq = voucher_seq;
	}
	public String getVoucher_extend_reason() {
		return voucher_extend_reason;
	}
	public void setVoucher_extend_reason(String voucher_extend_reason) {
		this.voucher_extend_reason = voucher_extend_reason;
	}
	public String getVoucher_str_dttm() {
		return voucher_str_dttm;
	}
	public void setVoucher_str_dttm(String voucher_str_dttm) {
		this.voucher_str_dttm = voucher_str_dttm;
	}
	public String getVoucher_end_dttm() {
		return voucher_end_dttm;
	}
	public void setVoucher_end_dttm(String voucher_end_dttm) {
		this.voucher_end_dttm = voucher_end_dttm;
	}
	public String getPayment_seq() {
		return payment_seq;
	}
	public void setPayment_seq(String payment_seq) {
		this.payment_seq = payment_seq;
	}
	public String getPayment_dttm() {
		return payment_dttm;
	}
	public void setPayment_dttm(String payment_dttm) {
		this.payment_dttm = payment_dttm;
	}
	public String getUsr_seq() {
		return usr_seq;
	}
	public void setUsr_seq(String usr_seq) {
		this.usr_seq = usr_seq;
	}
	public String getUsr_mpn_no() {
		return usr_mpn_no;
	}
	public void setUsr_mpn_no(String usr_mpn_no) {
		this.usr_mpn_no = usr_mpn_no;
	}
	public String getMb_id() {
		return mb_id;
	}
	public void setMb_id(String mb_id) {
		this.mb_id = mb_id;
	}
	public String getPayment_cls_cd() {
		return payment_cls_cd;
	}
	public void setPayment_cls_cd(String payment_cls_cd) {
		this.payment_cls_cd = payment_cls_cd;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	public String getVoucher_create_reason() {
		return voucher_create_reason;
	}
	public void setVoucher_create_reason(String voucher_create_reason) {
		this.voucher_create_reason = voucher_create_reason;
	}
	public String getVoucherCd() {
		return voucherCd;
	}
	public void setVoucherCd(String voucherCd) {
		this.voucherCd = voucherCd;
	}
	public String getVoucherName() {
		return voucherName;
	}
	public void setVoucherName(String voucherName) {
		this.voucherName = voucherName;
	}
	public String getParty_use_cnt() {
		return party_use_cnt;
	}
	public void setParty_use_cnt(String party_use_cnt) {
		this.party_use_cnt = party_use_cnt;
	}
	@Override
	public String toString() {
		return "VoucherMgmtVO [voucherCd=" + voucherCd + ", voucherName="
				+ voucherName + ", usr_seq=" + usr_seq + ", usr_mpn_no="
				+ usr_mpn_no + ", mb_id=" + mb_id + ", payment_cls_cd="
				+ payment_cls_cd + ", admin_id=" + admin_id
				+ ", voucher_create_reason=" + voucher_create_reason
				+ ", payment_seq=" + payment_seq + ", payment_dttm="
				+ payment_dttm + ", party_use_cnt="
						+ party_use_cnt + "]";
	}
	
	
}
