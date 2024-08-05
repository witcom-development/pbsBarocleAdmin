package com.dkitec.barocle.admin.service.membermgmt.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("rentSerialNumVO")
public class RentSerialNumVO extends PagingVO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6137134651617173935L;
	
	
	private String serialNoHistSeq;
	private String serialNoUsrSeq;
	private String serialNoPaymentSeq;
	private String serialNoVoucherSeq;
	private String serialNo;
	private String serialNoRegDttm;
	private String paymentClsCd;
	private String voucherType;
	
	private String paymentStusCd;
	private String payStatusType;
	private String paymentMethodCd;
	private String payMethodType;
	private String paymentDttm;
	private String voucherUseYnFlg;
	private String voucherUseYn;
	private String payMethodNo;
	private String voucherStrDttm;
	private String voucherEndDttm;
	private String payTotAmt;
	private String smsRecvAgreeYn;
	private String overPayMethodType;
	private String overFee;
	private String overFeePayYn;
	
	private String searchValue;
	private String searchParameter;
	@Override
	public String toString() {
		return "RentSerialNumVO [serialNoHistSeq=" + serialNoHistSeq
				+ ", serialNoUsrSeq=" + serialNoUsrSeq
				+ ", serialNoPaymentSeq=" + serialNoPaymentSeq
				+ ", serialNoVoucherSeq=" + serialNoVoucherSeq + ", serialNo="
				+ serialNo + ", serialNoRegDttm=" + serialNoRegDttm
				+ ", voucherType=" + voucherType + ", payMethodType="
				+ payMethodType + ", paymentDttm=" + paymentDttm
				+ ", voucherUseYn=" + voucherUseYn + ", payMethodNo="
				+ payMethodNo + ", voucherStrDttm=" + voucherStrDttm
				+ ", voucherEndDttm=" + voucherEndDttm + ", payTotAmt="
				+ payTotAmt + ", smsRecvAgreeYn=" + smsRecvAgreeYn
				+ ", overPayMethodType=" + overPayMethodType + ", overFee="
				+ overFee + ", overFeePayYn=" + overFeePayYn + ", searchValue="
				+ searchValue + ", searchParameter=" + searchParameter
				+ ", searchParameter2=" + searchParameter2
				+ ", searchStartDate=" + searchStartDate + ", searchEndDate="
				+ searchEndDate + ", cancelReasonDesc=" + cancelReasonDesc
				+ ", viewFlg=" + viewFlg + ", paymentConfmNo=" + paymentConfmNo
				+ ", cancelAdminId=" + cancelAdminId + ", page=" + page
				+ ", pageNo=" + pageNo + "]";
	}
	private String searchParameter2;
	
	private String searchStartDate;
	private String searchEndDate;
	
	private String cancelReasonDesc;
	private String viewFlg;
	private String paymentConfmNo;
	private String cancelAdminId;
	
	private String page;
	private String pageNo;
	
	public String getSerialNoHistSeq() {
		return serialNoHistSeq;
	}
	public void setSerialNoHistSeq(String serialNoHistSeq) {
		this.serialNoHistSeq = serialNoHistSeq;
	}
	public String getSerialNoUsrSeq() {
		return serialNoUsrSeq;
	}
	public void setSerialNoUsrSeq(String serialNoUsrSeq) {
		this.serialNoUsrSeq = serialNoUsrSeq;
	}
	public String getSerialNoPaymentSeq() {
		return serialNoPaymentSeq;
	}
	public void setSerialNoPaymentSeq(String serialNoPaymentSeq) {
		this.serialNoPaymentSeq = serialNoPaymentSeq;
	}
	public String getSerialNoVoucherSeq() {
		return serialNoVoucherSeq;
	}
	public void setSerialNoVoucherSeq(String serialNoVoucherSeq) {
		this.serialNoVoucherSeq = serialNoVoucherSeq;
	}
	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
	public String getSerialNoRegDttm() {
		return serialNoRegDttm;
	}
	public void setSerialNoRegDttm(String serialNoRegDttm) {
		this.serialNoRegDttm = serialNoRegDttm;
	}
	public String getPaymentClsCd() {
		return paymentClsCd;
	}
	public void setPaymentClsCd(String paymentClsCd) {
		this.paymentClsCd = paymentClsCd;
	}
	public String getVoucherType() {
		return voucherType;
	}
	public void setVoucherType(String voucherType) {
		this.voucherType = voucherType;
	}
	public String getPaymentStusCd() {
		return paymentStusCd;
	}
	public void setPaymentStusCd(String paymentStusCd) {
		this.paymentStusCd = paymentStusCd;
	}
	public String getPayStatusType() {
		return payStatusType;
	}
	public void setPayStatusType(String payStatusType) {
		this.payStatusType = payStatusType;
	}
	public String getPaymentMethodCd() {
		return paymentMethodCd;
	}
	public void setPaymentMethodCd(String paymentMethodCd) {
		this.paymentMethodCd = paymentMethodCd;
	}
	public String getPayMethodType() {
		return payMethodType;
	}
	public void setPayMethodType(String payMethodType) {
		this.payMethodType = payMethodType;
	}
	public String getPaymentDttm() {
		return paymentDttm;
	}
	public void setPaymentDttm(String paymentDttm) {
		this.paymentDttm = paymentDttm;
	}
	public String getVoucherUseYnFlg() {
		return voucherUseYnFlg;
	}
	public void setVoucherUseYnFlg(String voucherUseYnFlg) {
		this.voucherUseYnFlg = voucherUseYnFlg;
	}
	public String getVoucherUseYn() {
		return voucherUseYn;
	}
	public void setVoucherUseYn(String voucherUseYn) {
		this.voucherUseYn = voucherUseYn;
	}
	public String getPayMethodNo() {
		return payMethodNo;
	}
	public void setPayMethodNo(String payMethodNo) {
		this.payMethodNo = payMethodNo;
	}
	public String getVoucherStrDttm() {
		return voucherStrDttm;
	}
	public void setVoucherStrDttm(String voucherStrDttm) {
		this.voucherStrDttm = voucherStrDttm;
	}
	public String getVoucherEndDttm() {
		return voucherEndDttm;
	}
	public void setVoucherEndDttm(String voucherEndDttm) {
		this.voucherEndDttm = voucherEndDttm;
	}
	public String getPayTotAmt() {
		return payTotAmt;
	}
	public void setPayTotAmt(String payTotAmt) {
		this.payTotAmt = payTotAmt;
	}
	public String getSmsRecvAgreeYn() {
		return smsRecvAgreeYn;
	}
	public void setSmsRecvAgreeYn(String smsRecvAgreeYn) {
		this.smsRecvAgreeYn = smsRecvAgreeYn;
	}
	public String getOverPayMethodType() {
		return overPayMethodType;
	}
	public void setOverPayMethodType(String overPayMethodType) {
		this.overPayMethodType = overPayMethodType;
	}
	public String getOverFee() {
		return overFee;
	}
	public void setOverFee(String overFee) {
		this.overFee = overFee;
	}
	public String getOverFeePayYn() {
		return overFeePayYn;
	}
	public void setOverFeePayYn(String overFeePayYn) {
		this.overFeePayYn = overFeePayYn;
	}
	public String getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	public String getSearchParameter() {
		return searchParameter;
	}
	public void setSearchParameter(String searchParameter) {
		this.searchParameter = searchParameter;
	}
	public String getSearchParameter2() {
		return searchParameter2;
	}
	public void setSearchParameter2(String searchParameter2) {
		this.searchParameter2 = searchParameter2;
	}
	public String getSearchStartDate() {
		return searchStartDate;
	}
	public void setSearchStartDate(String searchStartDate) {
		this.searchStartDate = searchStartDate;
	}
	public String getSearchEndDate() {
		return searchEndDate;
	}
	public void setSearchEndDate(String searchEndDate) {
		this.searchEndDate = searchEndDate;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getPageNo() {
		return pageNo;
	}
	public void setPageNo(String pageNo) {
		this.pageNo = pageNo;
	}
	public String getCancelReasonDesc() {
		return cancelReasonDesc;
	}
	public void setCancelReasonDesc(String cancelReasonDesc) {
		this.cancelReasonDesc = cancelReasonDesc;
	}
	public String getViewFlg() {
		return viewFlg;
	}
	public void setViewFlg(String viewFlg) {
		this.viewFlg = viewFlg;
	}
	public String getPaymentConfmNo() {
		return paymentConfmNo;
	}
	public void setPaymentConfmNo(String paymentConfmNo) {
		this.paymentConfmNo = paymentConfmNo;
	}
	public String getCancelAdminId() {
		return cancelAdminId;
	}
	public void setCancelAdminId(String cancelAdminId) {
		this.cancelAdminId = cancelAdminId;
	}
	

}
