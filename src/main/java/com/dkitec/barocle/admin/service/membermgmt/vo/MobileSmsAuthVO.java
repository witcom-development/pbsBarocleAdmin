package com.dkitec.barocle.admin.service.membermgmt.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("mobileSmsAuthVO")
public class MobileSmsAuthVO extends PagingVO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8455046637363171693L;
	
	
	private String authNoHistSeq;
	private String usrSeq;
	private String authNo;
	private String usrMpnNo;
	private String noHistRegDttm;
	private String smsAuthTryCnt;
	private String inputNo;
	private String authDetRegDttm;
	
	private String searchValue;
	private String searchParameter;
	private String searchParameter2;
	
	private String searchStartDate;
	private String searchEndDate;
	
	private String viewFlg;
	private String paymentConfmNo;
	private String cancelAdminId;
	
	private String page;
	private String pageNo;
	
	
	public String getAuthNoHistSeq() {
		return authNoHistSeq;
	}
	public void setAuthNoHistSeq(String authNoHistSeq) {
		this.authNoHistSeq = authNoHistSeq;
	}
	public String getUsrSeq() {
		return usrSeq;
	}
	public void setUsrSeq(String usrSeq) {
		this.usrSeq = usrSeq;
	}
	public String getAuthNo() {
		return authNo;
	}
	public void setAuthNo(String authNo) {
		this.authNo = authNo;
	}
	public String getUsrMpnNo() {
		return usrMpnNo;
	}
	public void setUsrMpnNo(String usrMpnNo) {
		this.usrMpnNo = usrMpnNo;
	}
	public String getNoHistRegDttm() {
		return noHistRegDttm;
	}
	public void setNoHistRegDttm(String noHistRegDttm) {
		this.noHistRegDttm = noHistRegDttm;
	}
	public String getSmsAuthTryCnt() {
		return smsAuthTryCnt;
	}
	public void setSmsAuthTryCnt(String smsAuthTryCnt) {
		this.smsAuthTryCnt = smsAuthTryCnt;
	}
	public String getInputNo() {
		return inputNo;
	}
	public void setInputNo(String inputNo) {
		this.inputNo = inputNo;
	}
	public String getAuthDetRegDttm() {
		return authDetRegDttm;
	}
	public void setAuthDetRegDttm(String authDetRegDttm) {
		this.authDetRegDttm = authDetRegDttm;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
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
	@Override
	public String toString() {
		return "MobileSmsAuthVO [authNoHistSeq=" + authNoHistSeq + ", usrSeq="
				+ usrSeq + ", authNo=" + authNo + ", usrMpnNo=" + usrMpnNo
				+ ", noHistRegDttm=" + noHistRegDttm + ", smsAuthTryCnt="
				+ smsAuthTryCnt + ", inputNo=" + inputNo + ", authDetRegDttm="
				+ authDetRegDttm + ", searchValue=" + searchValue
				+ ", searchParameter=" + searchParameter
				+ ", searchParameter2=" + searchParameter2
				+ ", searchStartDate=" + searchStartDate + ", searchEndDate="
				+ searchEndDate	+ ", viewFlg=" + viewFlg + ", paymentConfmNo=" + paymentConfmNo
				+ ", cancelAdminId=" + cancelAdminId + ", page=" + page
				+ ", pageNo=" + pageNo + "]";
	}
	

}
