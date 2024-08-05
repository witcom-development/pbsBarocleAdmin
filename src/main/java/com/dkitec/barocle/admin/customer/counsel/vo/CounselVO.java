package com.dkitec.barocle.admin.customer.counsel.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;

@SuppressWarnings("serial")
@Alias("counselVo")
public class CounselVO extends CommonVo implements Serializable {
	private String conslSeq;
	private String custNm;
	private String conslDate;
	private String talkTno;
	private String talkStrtDt;
	private String talkEndDt;
    private String conslLcd;
	private String conslMcd;
	private String requestConslDscrp;
	private String comCd;
	private String cdDesc1;
	private String lcdName;
	private String mcdName;
	
	public String getTalkStrtDt() {
		return talkStrtDt;
	}
	public void setTalkStrtDt(String talkStrtDt) {
		this.talkStrtDt = talkStrtDt;
	}
	public String getTalkEndDt() {
		return talkEndDt;
	}
	public void setTalkEndDt(String talkEndDt) {
		this.talkEndDt = talkEndDt;
	}
	public String getConslSeq() {
		return conslSeq;
	}
	public void setConslSeq(String conslSeq) {
		this.conslSeq = conslSeq;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getConslDate() {
		return conslDate;
	}
	public void setConslDate(String conslDate) {
		this.conslDate = conslDate;
	}
	public String getTalkTno() {
		return talkTno;
	}
	public void setTalkTno(String talkTno) {
		this.talkTno = talkTno;
	}
	public String getConslLcd() {
		return conslLcd;
	}
	public void setConslLcd(String conslLcd) {
		this.conslLcd = conslLcd;
	}
	public String getConslMcd() {
		return conslMcd;
	}
	public void setConslMcd(String conslMcd) {
		this.conslMcd = conslMcd;
	}
	public String getRequestConslDscrp() {
		return requestConslDscrp;
	}
	public void setRequestConslDscrp(String requestConslDscrp) {
		this.requestConslDscrp = requestConslDscrp;
	}
	public String getComCd() {
		return comCd;
	}
	public void setComCd(String comCd) {
		this.comCd = comCd;
	}
	public String getCdDesc1() {
		return cdDesc1;
	}
	public void setCdDesc1(String cdDesc1) {
		this.cdDesc1 = cdDesc1;
	}
	public String getLcdName() {
		return lcdName;
	}
	public void setLcdName(String lcdName) {
		this.lcdName = lcdName;
	}
	public String getMcdName() {
		return mcdName;
	}
	public void setMcdName(String mcdName) {
		this.mcdName = mcdName;
	}
	
}
