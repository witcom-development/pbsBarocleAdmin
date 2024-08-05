package com.dkitec.barocle.admin.service.membermgmt.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("safetyCertUserVO")
public class SafetyCertUserVO extends PagingVO implements Serializable{

	private static final long serialVersionUID = 1889913333795283239L;
	
	private String lang = IConstants.LANG_KR;
	private String viewFlg = IConstants.MODE_LIST;
	private String excel;
	
	private String certUsrSeq; 
	private String certNum; 
	private String usrName; 
	private String usrMpnNo; 
	private String usrPrvCd; 
	private String certDate; 
	private String certCls; 
	private String certOrg; 
	private String usrUsrSeq; 
	private String mbYn; 
	private String mbId; 
	private String regDttm; 
	private String modDttm; 
	private String certEdDate; 
	private String disSDttm; 
	private String disEDttm;
	
	public String getCertUsrSeq() {
		return certUsrSeq;
	}
	public void setCertUsrSeq(String certUsrSeq) {
		this.certUsrSeq = certUsrSeq;
	}
	public String getCertNum() {
		return certNum;
	}
	public void setCertNum(String certNum) {
		this.certNum = certNum;
	}
	public String getUsrName() {
		return usrName;
	}
	public void setUsrName(String usrName) {
		this.usrName = usrName;
	}
	public String getUsrMpnNo() {
		return usrMpnNo;
	}
	public void setUsrMpnNo(String usrMpnNo) {
		this.usrMpnNo = usrMpnNo;
	}
	public String getUsrPrvCd() {
		return usrPrvCd;
	}
	public void setUsrPrvCd(String usrPrvCd) {
		this.usrPrvCd = usrPrvCd;
	}
	public String getCertDate() {
		return certDate;
	}
	public void setCertDate(String certDate) {
		this.certDate = certDate;
	}
	public String getCertCls() {
		return certCls;
	}
	public void setCertCls(String certCls) {
		this.certCls = certCls;
	}
	public String getCertOrg() {
		return certOrg;
	}
	public void setCertOrg(String certOrg) {
		this.certOrg = certOrg;
	}
	public String getUsrUsrSeq() {
		return usrUsrSeq;
	}
	public void setUsrUsrSeq(String usrUsrSeq) {
		this.usrUsrSeq = usrUsrSeq;
	}
	public String getMbYn() {
		return mbYn;
	}
	public void setMbYn(String mbYn) {
		this.mbYn = mbYn;
	}
	public String getMbId() {
		return mbId;
	}
	public void setMbId(String mbId) {
		this.mbId = mbId;
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
	public String getCertEdDate() {
		return certEdDate;
	}
	public void setCertEdDate(String certEdDate) {
		this.certEdDate = certEdDate;
	}
	public String getDisSDttm() {
		return disSDttm;
	}
	public void setDisSDttm(String disSDttm) {
		this.disSDttm = disSDttm;
	}
	public String getDisEDttm() {
		return disEDttm;
	}
	public void setDisEDttm(String disEDttm) {
		this.disEDttm = disEDttm;
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
	public String getExcel() {
		return excel;
	}
	public void setExcel(String excel) {
		this.excel = excel;
	}
	
	
}
