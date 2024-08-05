package com.dkitec.barocle.admin.customer.survey.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

@Alias("surveyResultVO")
public class SurveyResultVO implements Serializable{
	
	private static final long serialVersionUID = -2622606660752734152L;
	
	private int qustnrSeq;
	private String qustnrQesitmID;
	private int qestnOrd;
	private String qestnContent;
	private String qustnrItemID;
	private int itemOrd;
	private String itemContent;
	private int qustnrItemIDCount;
	private int sumQuantity;
	private int percentQuantity;
	private String etcYn;
	
	private String etcChk;
	
	private String sexCd;
	private String usrBirthDate;
	private int age;
	private String years;
	private String mbPostNo;
	private String mbAddr1;
	private String qestnQesitmId;
	private String counta;
	private String qustnrRespondId;
	private String sumUnrespond;
	private String sumTotRespondUnrespond;
	
	public String getEtcChk() {
		return etcChk;
	}
	public void setEtcChk(String etcChk) {
		this.etcChk = etcChk;
	}
	public String getEtcYn() {
		return etcYn;
	}
	public void setEtcYn(String etcYn) {
		this.etcYn = etcYn;
	}
	public int getQustnrSeq() {
		return qustnrSeq;
	}
	public void setQustnrSeq(int qustnrSeq) {
		this.qustnrSeq = qustnrSeq;
	}
	public String getQustnrQesitmID() {
		return qustnrQesitmID;
	}
	public void setQustnrQesitmID(String qustnrQesitmID) {
		this.qustnrQesitmID = qustnrQesitmID;
	}
	public int getQestnOrd() {
		return qestnOrd;
	}
	public void setQestnOrd(int qestnOrd) {
		this.qestnOrd = qestnOrd;
	}
	public String getQestnContent() {
		return qestnContent;
	}
	public void setQestnContent(String qestnContent) {
		this.qestnContent = qestnContent;
	}
	public String getQustnrItemID() {
		return qustnrItemID;
	}
	public void setQustnrItemID(String qustnrItemID) {
		this.qustnrItemID = qustnrItemID;
	}
	public int getItemOrd() {
		return itemOrd;
	}
	public void setItemOrd(int itemOrd) {
		this.itemOrd = itemOrd;
	}
	public String getItemContent() {
		return itemContent;
	}
	public void setItemContent(String itemContent) {
		this.itemContent = itemContent;
	}
	public int getQustnrItemIDCount() {
		return qustnrItemIDCount;
	}
	public void setQustnrItemIDCount(int qustnrItemIDCount) {
		this.qustnrItemIDCount = qustnrItemIDCount;
	}
	public int getSumQuantity() {
		return sumQuantity;
	}
	public void setSumQuantity(int sumQuantity) {
		this.sumQuantity = sumQuantity;
	}
	public int getPercentQuantity() {
		return percentQuantity;
	}
	public void setPercentQuantity(int percentQuantity) {
		this.percentQuantity = percentQuantity;
	}
	@Override
	public String toString() {
		return "SurveyResultVO [qustnrSeq=" + qustnrSeq + ", qustnrQesitmID="
				+ qustnrQesitmID + ", qestnOrd=" + qestnOrd + ", qestnContent="
				+ qestnContent + ", qustnrItemID=" + qustnrItemID
				+ ", itemOrd=" + itemOrd + ", itemContent=" + itemContent
				+ ", qustnrItemIDCount=" + qustnrItemIDCount + ", sumQuantity="
				+ sumQuantity + ", percentQuantity=" + percentQuantity
				+ ", etcYn=" + etcYn + ", getEtcYn()=" + getEtcYn()
				+ ", getQustnrSeq()=" + getQustnrSeq()
				+ ", getQustnrQesitmID()=" + getQustnrQesitmID()
				+ ", getQestnOrd()=" + getQestnOrd() + ", getQestnContent()="
				+ getQestnContent() + ", getQustnrItemID()="
				+ getQustnrItemID() + ", getItemOrd()=" + getItemOrd()
				+ ", getItemContent()=" + getItemContent()
				+ ", getQustnrItemIDCount()=" + getQustnrItemIDCount()
				+ ", getSumQuantity()=" + getSumQuantity()
				+ ", getPercentQuantity()=" + getPercentQuantity()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}
	public String getSexCd() {
		return sexCd;
	}
	public void setSexCd(String sexCd) {
		this.sexCd = sexCd;
	}
	public String getUsrBirthDate() {
		return usrBirthDate;
	}
	public void setUsrBirthDate(String usrBirthDate) {
		this.usrBirthDate = usrBirthDate;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getYears() {
		return years;
	}
	public void setYears(String years) {
		this.years = years;
	}
	public String getMbPostNo() {
		return mbPostNo;
	}
	public void setMbPostNo(String mbPostNo) {
		this.mbPostNo = mbPostNo;
	}
	public String getMbAddr1() {
		return mbAddr1;
	}
	public void setMbAddr1(String mbAddr1) {
		this.mbAddr1 = mbAddr1;
	}
	public String getQestnQesitmId() {
		return qestnQesitmId;
	}
	public void setQestnQesitmId(String qestnQesitmId) {
		this.qestnQesitmId = qestnQesitmId;
	}
	public String getCounta() {
		return counta;
	}
	public void setCounta(String counta) {
		this.counta = counta;
	}
	public String getQustnrRespondId() {
		return qustnrRespondId;
	}
	public void setQustnrRespondId(String qustnrRespondId) {
		this.qustnrRespondId = qustnrRespondId;
	}
	public String getSumUnrespond() {
		return sumUnrespond;
	}
	public void setSumUnrespond(String sumUnrespond) {
		this.sumUnrespond = sumUnrespond;
	}
	public String getSumTotRespondUnrespond() {
		return sumTotRespondUnrespond;
	}
	public void setSumTotRespondUnrespond(String sumTotRespondUnrespond) {
		this.sumTotRespondUnrespond = sumTotRespondUnrespond;
	}

	


}
