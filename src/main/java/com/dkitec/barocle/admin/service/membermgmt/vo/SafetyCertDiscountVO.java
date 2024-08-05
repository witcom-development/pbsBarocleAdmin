package com.dkitec.barocle.admin.service.membermgmt.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("safetyCertDiscountVO")
public class SafetyCertDiscountVO extends PagingVO implements Serializable{

	private static final long serialVersionUID = -7279662175499172539L;
	
	private String lang = IConstants.LANG_KR;
	private String viewFlg = IConstants.MODE_LIST;
	
	private String certDiscountSeq;
	private String disRate;
	private String comCd;
	private String adminId;
	private String memo;
	private String regDttm;
	private String modDttm;
	
	public String getCertDiscountSeq() {
		return certDiscountSeq;
	}
	public void setCertDiscountSeq(String certDiscountSeq) {
		this.certDiscountSeq = certDiscountSeq;
	}
	public String getComCd() {
		return comCd;
	}
	public void setComCd(String comCd) {
		this.comCd = comCd;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
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
