package com.dkitec.barocle.admin.service.membermgmt.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@SuppressWarnings("serial")
@Alias("memberPaymentVO")
public class MemberPaymentVO extends PagingVO implements Serializable{
	
	private String payment_seq;
	private String payment_dttm;
	private String usr_seq;
	private String payment_cls_cd;
	private String cls_cd;
	private String payment_method_cd;
	private String method_cd;
	private String payment_stus_cd;
	private String stus_cd;
	private String payment_confm_no;
	private String payment_confm_dttm;
	private String payment_req_dttm;
	private String tot_amt;
	private String mileage_payment_amt;
	private String rent_over_fee_sum;
	private String cancel_dttm;
	private String cancel_reason_desc;
	private String cancel_admin_id;
	
	private String rent_hist_seq;
	private String rent_dttm;
	private String rent_station_id;
	private String rent_station;
	private String rent_cls_cd;
	private String return_station_id;
	private String return_station;
	private String return_rack_id;
	private String return_dttm;
	private String use_mi;
	private String rent_bike_id;
	private String bike_no;
	private String rentCd;
	private String rentName;
	
	private String refund_dttm;
	private String refund_amt;
	private String refund_reason;
	private String refund_comssn_amt;
	private String refund_id;
	private String over_fee;
	
	
	private String voucher_seq;
	private String voucher_str_dttm;
	private String voucher_end_dttm;
	private String voucher_use_yn;
	private String party_use_cnt;
	private String coupon_no;
	private String mb_id;
	
	// 대여예약 구분 추가
	private String rent_yn;
	private String rent_rack_id;
	private String rent_seq;
	
	//대여 채널 구분 추가
	private String rent_mth_cd;
	private String rent_mth_cd_nm;
	private String payment_chnnl_cd;
	
	//shoh2999 자전거인증제할인추가
	private String certDisYn;
	private String disAmt;
	private String certStatisticsYear;
	private String certStatisticsMonth;

	public String getRent_yn() {
		return rent_yn;
	}
	public void setRent_yn(String rent_yn) {
		this.rent_yn = rent_yn;
	}
	public String getRentCd() {
		return rentCd;
	}
	public void setRentCd(String rentCd) {
		this.rentCd = rentCd;
	}
	public String getRentName() {
		return rentName;
	}
	public void setRentName(String rentName) {
		this.rentName = rentName;
	}
	public String getMb_id() {
		return mb_id;
	}
	public void setMb_id(String mb_id) {
		this.mb_id = mb_id;
	}
	public String getCoupon_no() {
		return coupon_no;
	}
	public void setCoupon_no(String coupon_no) {
		this.coupon_no = coupon_no;
	}
	public String getVoucher_seq() {
		return voucher_seq;
	}
	public void setVoucher_seq(String voucher_seq) {
		this.voucher_seq = voucher_seq;
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
	public String getVoucher_use_yn() {
		return voucher_use_yn;
	}
	public void setVoucher_use_yn(String voucher_use_yn) {
		this.voucher_use_yn = voucher_use_yn;
	}
	public String getParty_use_cnt() {
		return party_use_cnt;
	}
	public void setParty_use_cnt(String party_use_cnt) {
		this.party_use_cnt = party_use_cnt;
	}
	public String getOver_fee() {
		return over_fee;
	}
	public void setOver_fee(String over_fee) {
		this.over_fee = over_fee;
	}
	public String getBike_no() {
		return bike_no;
	}
	public void setBike_no(String bike_no) {
		this.bike_no = bike_no;
	}
	public String getRent_bike_id() {
		return rent_bike_id;
	}
	public void setRent_bike_id(String rent_bike_id) {
		this.rent_bike_id = rent_bike_id;
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
	public String getPayment_cls_cd() {
		return payment_cls_cd;
	}
	public void setPayment_cls_cd(String payment_cls_cd) {
		this.payment_cls_cd = payment_cls_cd;
	}
	public String getPayment_method_cd() {
		return payment_method_cd;
	}
	public void setPayment_method_cd(String payment_method_cd) {
		this.payment_method_cd = payment_method_cd;
	}
	public String getPayment_stus_cd() {
		return payment_stus_cd;
	}
	public void setPayment_stus_cd(String payment_stus_cd) {
		this.payment_stus_cd = payment_stus_cd;
	}
	public String getPayment_confm_no() {
		return payment_confm_no;
	}
	public void setPayment_confm_no(String payment_confm_no) {
		this.payment_confm_no = payment_confm_no;
	}
	public String getPayment_confm_dttm() {
		return payment_confm_dttm;
	}
	public void setPayment_confm_dttm(String payment_confm_dttm) {
		this.payment_confm_dttm = payment_confm_dttm;
	}
	public String getPayment_req_dttm() {
		return payment_req_dttm;
	}
	public void setPayment_req_dttm(String payment_req_dttm) {
		this.payment_req_dttm = payment_req_dttm;
	}
	public String getTot_amt() {
		return tot_amt;
	}
	public void setTot_amt(String tot_amt) {
		this.tot_amt = tot_amt;
	}
	public String getMileage_payment_amt() {
		return mileage_payment_amt;
	}
	public void setMileage_payment_amt(String mileage_payment_amt) {
		this.mileage_payment_amt = mileage_payment_amt;
	}
	public String getRent_over_fee_sum() {
		return rent_over_fee_sum;
	}
	public void setRent_over_fee_sum(String rent_over_fee_sum) {
		this.rent_over_fee_sum = rent_over_fee_sum;
	}
	public String getCancel_dttm() {
		return cancel_dttm;
	}
	public void setCancel_dttm(String cancel_dttm) {
		this.cancel_dttm = cancel_dttm;
	}
	public String getCancel_reason_desc() {
		return cancel_reason_desc;
	}
	public void setCancel_reason_desc(String cancel_reason_desc) {
		this.cancel_reason_desc = cancel_reason_desc;
	}
	public String getCancel_admin_id() {
		return cancel_admin_id;
	}
	public void setCancel_admin_id(String cancel_admin_id) {
		this.cancel_admin_id = cancel_admin_id;
	}
	
	public String getCls_cd() {
		return cls_cd;
	}
	public void setCls_cd(String cls_cd) {
		this.cls_cd = cls_cd;
	}
	public String getMethod_cd() {
		return method_cd;
	}
	public void setMethod_cd(String method_cd) {
		this.method_cd = method_cd;
	}
	public String getStus_cd() {
		return stus_cd;
	}
	public void setStus_cd(String stus_cd) {
		this.stus_cd = stus_cd;
	}
	
	public String getRent_hist_seq() {
		return rent_hist_seq;
	}
	public void setRent_hist_seq(String rent_hist_seq) {
		this.rent_hist_seq = rent_hist_seq;
	}
	public String getRent_dttm() {
		return rent_dttm;
	}
	public void setRent_dttm(String rent_dttm) {
		this.rent_dttm = rent_dttm;
	}
	public String getRent_station_id() {
		return rent_station_id;
	}
	public void setRent_station_id(String rent_station_id) {
		this.rent_station_id = rent_station_id;
	}
	public String getRent_station() {
		return rent_station;
	}
	public void setRent_station(String rent_station) {
		this.rent_station = rent_station;
	}
	public String getRent_cls_cd() {
		return rent_cls_cd;
	}
	public void setRent_cls_cd(String rent_cls_cd) {
		this.rent_cls_cd = rent_cls_cd;
	}
	public String getReturn_station_id() {
		return return_station_id;
	}
	public void setReturn_station_id(String return_station_id) {
		this.return_station_id = return_station_id;
	}
	public String getReturn_station() {
		return return_station;
	}
	public void setReturn_station(String return_station) {
		this.return_station = return_station;
	}
	public String getReturn_rack_id() {
		return return_rack_id;
	}
	public void setReturn_rack_id(String return_rack_id) {
		this.return_rack_id = return_rack_id;
	}
	public String getReturn_dttm() {
		return return_dttm;
	}
	public void setReturn_dttm(String return_dttm) {
		this.return_dttm = return_dttm;
	}
	public String getUse_mi() {
		return use_mi;
	}
	public void setUse_mi(String use_mi) {
		this.use_mi = use_mi;
	}
	
	public String getRefund_dttm() {
		return refund_dttm;
	}
	public void setRefund_dttm(String refund_dttm) {
		this.refund_dttm = refund_dttm;
	}
	public String getRefund_amt() {
		return refund_amt;
	}
	public void setRefund_amt(String refund_amt) {
		this.refund_amt = refund_amt;
	}
	public String getRefund_reason() {
		return refund_reason;
	}
	public void setRefund_reason(String refund_reason) {
		this.refund_reason = refund_reason;
	}
	public String getRefund_comssn_amt() {
		return refund_comssn_amt;
	}
	public void setRefund_comssn_amt(String refund_comssn_amt) {
		this.refund_comssn_amt = refund_comssn_amt;
	}
	public String getRefund_id() {
		return refund_id;
	}
	public void setRefund_id(String refund_id) {
		this.refund_id = refund_id;
	}
	@Override
	public String toString() {
		return "MemberPaymentVO [payment_seq=" + payment_seq
				+ " , payment_dttm=" + payment_dttm + " , usr_seq=" + usr_seq
				+ " , payment_cls_cd=" + payment_cls_cd + " , cls_cd=" + cls_cd
				+ " , payment_method_cd=" + payment_method_cd + " , method_cd="
				+ method_cd + " , payment_stus_cd=" + payment_stus_cd
				+ " , stus_cd=" + stus_cd + " , payment_confm_no="
				+ payment_confm_no + " , payment_confm_dttm="
				+ payment_confm_dttm + " , payment_req_dttm="
				+ payment_req_dttm + " , tot_amt=" + tot_amt
				+ " , mileage_payment_amt=" + mileage_payment_amt
				+ " , rent_over_fee_sum=" + rent_over_fee_sum
				+ " , cancel_dttm=" + cancel_dttm + " , cancel_reason_desc="
				+ cancel_reason_desc + " , cancel_admin_id=" + cancel_admin_id
				+ " , rent_hist_seq=" + rent_hist_seq + " , rent_dttm="
				+ rent_dttm + " , rent_station_id=" + rent_station_id
				+ " , rent_station=" + rent_station + " , rent_cls_cd="
				+ rent_cls_cd + " , return_station_id=" + return_station_id
				+ " , return_station=" + return_station + " , return_rack_id="
				+ return_rack_id + " , return_dttm=" + return_dttm
				+ " , use_mi=" + use_mi 
				+ "]";
	}
	public String getRent_rack_id() {
		return rent_rack_id;
	}
	public void setRent_rack_id(String rent_rack_id) {
		this.rent_rack_id = rent_rack_id;
	}
	public String getRent_seq() {
		return rent_seq;
	}
	public void setRent_seq(String rent_seq) {
		this.rent_seq = rent_seq;
	}
	public String getRent_mth_cd() {
		return rent_mth_cd;
	}
	public void setRent_mth_cd(String rent_mth_cd) {
		this.rent_mth_cd = rent_mth_cd;
	}
	public String getRent_mth_cd_nm() {
		return rent_mth_cd_nm;
	}
	public void setRent_mth_cd_nm(String rent_mth_cd_nm) {
		this.rent_mth_cd_nm = rent_mth_cd_nm;
	}
	public String getPayment_chnnl_cd() {
		return payment_chnnl_cd;
	}
	public void setPayment_chnnl_cd(String payment_chnnl_cd) {
		this.payment_chnnl_cd = payment_chnnl_cd;
	}
	public String getCertDisYn() {
		return certDisYn;
	}
	public void setCertDisYn(String certDisYn) {
		this.certDisYn = certDisYn;
	}
	public String getDisAmt() {
		return disAmt;
	}
	public void setDisAmt(String disAmt) {
		this.disAmt = disAmt;
	}
	public String getCertStatisticsYear() {
		return certStatisticsYear;
	}
	public void setCertStatisticsYear(String certStatisticsYear) {
		this.certStatisticsYear = certStatisticsYear;
	}
	public String getCertStatisticsMonth() {
		return certStatisticsMonth;
	}
	public void setCertStatisticsMonth(String certStatisticsMonth) {
		this.certStatisticsMonth = certStatisticsMonth;
	}  

}
