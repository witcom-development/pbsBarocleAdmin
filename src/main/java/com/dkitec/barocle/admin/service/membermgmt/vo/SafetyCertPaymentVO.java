package com.dkitec.barocle.admin.service.membermgmt.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("safetyCertPaymentVO")
public class SafetyCertPaymentVO extends PagingVO implements Serializable{

	private static final long serialVersionUID = 2300885611243020503L;
	
	private String lang = IConstants.LANG_KR;
	private String viewFlg = IConstants.MODE_LIST;
	
	private String certPaymentSeq;
	private String paymentSeq;
	private String disAmt;
	private String disRate;
	private String regDttm;
	private String modDttm;
	
	public String getCertPaymentSeq() {
		return certPaymentSeq;
	}
	public void setCertPaymentSeq(String certPaymentSeq) {
		this.certPaymentSeq = certPaymentSeq;
	}
	public String getPaymentSeq() {
		return paymentSeq;
	}
	public void setPaymentSeq(String paymentSeq) {
		this.paymentSeq = paymentSeq;
	}
	public String getDisAmt() {
		return disAmt;
	}
	public void setDisAmt(String disAmt) {
		this.disAmt = disAmt;
	}
	public String getDisRate() {
		return disRate;
	}
	public void setDisRate(String disRate) {
		this.disRate = disRate;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getModDttm() {
		return modDttm;
	}
	public void setModDttm(String modDttm) {
		this.modDttm = modDttm;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getViewFlg() {
		return viewFlg;
	}
	public void setViewFlg(String viewFlg) {
		this.viewFlg = viewFlg;
	}
	
}
