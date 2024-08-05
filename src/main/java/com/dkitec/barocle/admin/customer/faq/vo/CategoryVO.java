package com.dkitec.barocle.admin.customer.faq.vo;

import javax.validation.GroupSequence;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.ModeVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;

@Alias("categoryVO")
public class CategoryVO extends ModeVO implements java.io.Serializable {
	
	private static final long serialVersionUID = 5000261045221639346L;
	
	private String comCD;
	@CheckValue(message="카테고리 값이 존재하지 않습니다.",groups={CategoryPersist.class})
	private String comUpCD;
	private String cdDesc1;
	private String cdDesc2;
	private String useYN;
	private String dspOrd;
	private String regID;
	private java.util.Date regDttm;
	private String newRegDttm;
	private String addVal1;
	private String addVal2;
	private String addVal3;
	
	private String langClsCD;
	@CheckValue(message="카테고리명이 존재하지 않습니다.",groups={CategoryPersist.class})
	private String mLangComCDName;
	
	public CategoryVO(){
		this.useYN = "Y";
	}
	
	public String getComCD() {
		return comCD;
	}
	public void setComCD(String comCD) {
		this.comCD = comCD;
	}
	public String getComUpCD() {
		return comUpCD;
	}
	public void setComUpCD(String comUpCD) {
		this.comUpCD = comUpCD;
	}
	public String getCdDesc1() {
		return cdDesc1;
	}
	public void setCdDesc1(String cdDesc1) {
		this.cdDesc1 = cdDesc1;
	}
	public String getCdDesc2() {
		return cdDesc2;
	}
	public void setCdDesc2(String cdDesc2) {
		this.cdDesc2 = cdDesc2;
	}
	public String getUseYN() {
		return useYN;
	}
	public void setUseYN(String useYN) {
		this.useYN = useYN;
	}
	public String getDspOrd() {
		return dspOrd;
	}
	public void setDspOrd(String dspOrd) {
		this.dspOrd = dspOrd;
	}
	public String getRegID() {
		return regID;
	}
	public void setRegID(String regID) {
		this.regID = regID;
	}
	public java.util.Date getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(java.util.Date regDttm) {
		this.regDttm = regDttm;
	}
	public String getNewRegDttm() {
		return newRegDttm;
	}
	public void setNewRegDttm(String newRegDttm) {
		this.newRegDttm = newRegDttm;
	}
	public String getAddVal1() {
		return addVal1;
	}
	public void setAddVal1(String addVal1) {
		this.addVal1 = addVal1;
	}
	public String getAddVal2() {
		return addVal2;
	}
	public void setAddVal2(String addVal2) {
		this.addVal2 = addVal2;
	}
	public String getAddVal3() {
		return addVal3;
	}
	public void setAddVal3(String addVal3) {
		this.addVal3 = addVal3;
	}
	public String getLangClsCD() {
		return langClsCD;
	}
	public void setLangClsCD(String langClsCD) {
		this.langClsCD = langClsCD;
	}
	public String getmLangComCDName() {
		return mLangComCDName;
	}
	public void setmLangComCDName(String mLangComCDName) {
		this.mLangComCDName = mLangComCDName;
	}
	
	@Override
	public String toString() {
		return "CategoryVO [comCD=" + comCD + ", comUpCD=" + comUpCD
				+ ", cdDesc1=" + cdDesc1 + ", cdDesc2=" + cdDesc2 + ", useYN="
				+ useYN + ", dspOrd=" + dspOrd + ", regID=" + regID
				+ ", regDttm=" + regDttm + ", newRegDttm=" + newRegDttm
				+ ", addVal1=" + addVal1 + ", addVal2=" + addVal2
				+ ", addVal3=" + addVal3 + ", langClsCD=" + langClsCD
				+ ", mLangComCDName=" + mLangComCDName + ", getMode()="
				+ getMode() + ", getClass()=" + getClass() + ", hashCode()="
				+ hashCode() + ", toString()=" + super.toString() + "]";
	}
	
	public interface CategoryPersist{}
	
	@GroupSequence({GetMode.class,CategoryPersist.class})
	public static interface CategoryPersistVal{}
	
}
