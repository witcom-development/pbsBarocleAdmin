package com.dkitec.barocle.admin.service.membermgmt.vo;

import java.math.BigInteger;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.base.IConstants;

@Alias("safetyCertInfoVO")
public class SafetyCertInfoVO extends SafetyCertUserVO {

	private static final long serialVersionUID = -8683521711502137205L;
	
	private String lang = IConstants.LANG_KR;
	private String viewFlg = IConstants.MODE_LIST;
	
	private BigInteger disRate;
	private String comCd;

	public String getComCd() {
		return comCd;
	}

	public void setComCd(String comCd) {
		this.comCd = comCd;
	}

	public BigInteger getDisRate() {
		return disRate;
	}

	public void setDisRate(BigInteger disRate) {
		this.disRate = disRate;
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
