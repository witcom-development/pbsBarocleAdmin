package com.dkitec.barocle.admin.manage.center.vo;

import javax.validation.GroupSequence;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.SearchDate;

@Alias("centerVO")
@SearchDate(groups=PagingVO.SearchDateValidator.class)
public class CenterVO extends PagingVO implements java.io.Serializable {
	
	private static final long serialVersionUID = 3526077215793728364L;
	
	@CheckValue(message="PK 값이 존재하지 않습니다.",groups={CenterDelete.class})
	private String centerID;
	@CheckValue(message="선터 구분을 선택해 주세요.",groups={CenterInsert.class,CenterUpdate.class})
	private String centerClsCD;
	@CheckValue(message="자치구를 선택해 주세요.",groups={CenterInsert.class,CenterUpdate.class})
	private String districtCD;
	@CheckValue(message="센터명을 입력해 주세요.",groups={CenterInsert.class,CenterUpdate.class})
	private String centerName;
	private String centerTelNO;
	@CheckValue(message="전화번호를 입력해 주세요.",groups={CenterInsert.class,CenterUpdate.class})
	private String centerTelNO1;
	@CheckValue(message="전화번호를 입력해 주세요.",groups={CenterInsert.class,CenterUpdate.class})
	private String centerTelNO2;
	@CheckValue(message="전화번호를 입력해 주세요.",groups={CenterInsert.class,CenterUpdate.class})
	private String centerTelNO3;
	private String oprStrTime;
	private String oprStrTime1;
	private String oprStrTime2;
	private String oprEndTime;
	private String oprEndTime1;
	private String oprEndTime2;
	private String chargerName;
	@CheckValue(message="우편번호를 입력해 주세요.",groups={CenterInsert.class,CenterUpdate.class})
	private String centerPostNO;
	@CheckValue(message="주소를 입력해 주세요.",groups={CenterInsert.class,CenterUpdate.class})
	private String centerAddr1;
	@CheckValue(message="주소를 입력해 주세요.",groups={CenterInsert.class,CenterUpdate.class})
	private String centerAddr2;
	private String centerLatitude;
	private String centerLongitude;
	private String centerDesc;
	private java.util.Date regDttm;
	private String regID;
	private java.util.Date modDttm;
	private String modID;
	
	private String centerGubun;
	private String centerGu;
	private String modName;
	
	private String useYn;		// 사용여부 추가 2020.06.02
	
	
	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getCenterID() {
		return centerID;
	}

	public void setCenterID(String centerID) {
		this.centerID = centerID;
	}

	public String getCenterClsCD() {
		return centerClsCD;
	}

	public void setCenterClsCD(String centerClsCD) {
		this.centerClsCD = centerClsCD;
	}

	public String getDistrictCD() {
		return districtCD;
	}

	public void setDistrictCD(String districtCD) {
		this.districtCD = districtCD;
	}

	public String getCenterName() {
		return centerName;
	}

	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}

	public String getCenterTelNO() {
		return centerTelNO;
	}

	public void setCenterTelNO(String centerTelNO) {
		this.centerTelNO = centerTelNO;
	}

	public String getCenterTelNO1() {
		return centerTelNO1;
	}

	public void setCenterTelNO1(String centerTelNO1) {
		this.centerTelNO1 = centerTelNO1;
	}

	public String getCenterTelNO2() {
		return centerTelNO2;
	}

	public void setCenterTelNO2(String centerTelNO2) {
		this.centerTelNO2 = centerTelNO2;
	}

	public String getCenterTelNO3() {
		return centerTelNO3;
	}

	public void setCenterTelNO3(String centerTelNO3) {
		this.centerTelNO3 = centerTelNO3;
	}

	public String getOprStrTime() {
		return oprStrTime;
	}

	public void setOprStrTime(String oprStrTime) {
		this.oprStrTime = oprStrTime;
	}

	public String getOprStrTime1() {
		return oprStrTime1;
	}

	public void setOprStrTime1(String oprStrTime1) {
		this.oprStrTime1 = oprStrTime1;
	}

	public String getOprStrTime2() {
		return oprStrTime2;
	}

	public void setOprStrTime2(String oprStrTime2) {
		this.oprStrTime2 = oprStrTime2;
	}

	public String getOprEndTime() {
		return oprEndTime;
	}

	public void setOprEndTime(String oprEndTime) {
		this.oprEndTime = oprEndTime;
	}

	public String getOprEndTime1() {
		return oprEndTime1;
	}

	public void setOprEndTime1(String oprEndTime1) {
		this.oprEndTime1 = oprEndTime1;
	}

	public String getOprEndTime2() {
		return oprEndTime2;
	}

	public void setOprEndTime2(String oprEndTime2) {
		this.oprEndTime2 = oprEndTime2;
	}

	public String getChargerName() {
		return chargerName;
	}

	public void setChargerName(String chargerName) {
		this.chargerName = chargerName;
	}

	public String getCenterPostNO() {
		return centerPostNO;
	}

	public void setCenterPostNO(String centerPostNO) {
		this.centerPostNO = centerPostNO;
	}

	public String getCenterAddr1() {
		return centerAddr1;
	}

	public void setCenterAddr1(String centerAddr1) {
		this.centerAddr1 = centerAddr1;
	}

	public String getCenterAddr2() {
		return centerAddr2;
	}

	public void setCenterAddr2(String centerAddr2) {
		this.centerAddr2 = centerAddr2;
	}

	public String getCenterLatitude() {
		return centerLatitude;
	}

	public void setCenterLatitude(String centerLatitude) {
		this.centerLatitude = centerLatitude;
	}

	public String getCenterLongitude() {
		return centerLongitude;
	}

	public void setCenterLongitude(String centerLongitude) {
		this.centerLongitude = centerLongitude;
	}

	public String getCenterDesc() {
		return centerDesc;
	}

	public void setCenterDesc(String centerDesc) {
		this.centerDesc = centerDesc;
	}

	public java.util.Date getRegDttm() {
		return regDttm;
	}

	public void setRegDttm(java.util.Date regDttm) {
		this.regDttm = regDttm;
	}

	public String getRegID() {
		return regID;
	}

	public void setRegID(String regID) {
		this.regID = regID;
	}

	public java.util.Date getModDttm() {
		return modDttm;
	}

	public void setModDttm(java.util.Date modDttm) {
		this.modDttm = modDttm;
	}

	public String getModID() {
		return modID;
	}

	public void setModID(String modID) {
		this.modID = modID;
	}

	public String getCenterGubun() {
		return centerGubun;
	}

	public void setCenterGubun(String centerGubun) {
		this.centerGubun = centerGubun;
	}

	public String getCenterGu() {
		return centerGu;
	}

	public void setCenterGu(String centerGu) {
		this.centerGu = centerGu;
	}
	
	public String getModName() {
		return modName;
	}

	public void setModName(String modName) {
		this.modName = modName;
	}
	
	@Override
	public String toString() {
		return "CenterVO [centerID=" + centerID + ", centerClsCD="
				+ centerClsCD + ", districtCD=" + districtCD + ", centerName="
				+ centerName + ", centerTelNO=" + centerTelNO
				+ ", centerTelNO1=" + centerTelNO1 + ", centerTelNO2="
				+ centerTelNO2 + ", centerTelNO3=" + centerTelNO3
				+ ", oprStrTime=" + oprStrTime + ", oprStrTime1=" + oprStrTime1
				+ ", oprStrTime2=" + oprStrTime2 + ", oprEndTime=" + oprEndTime
				+ ", oprEndTime1=" + oprEndTime1 + ", oprEndTime2="
				+ oprEndTime2 + ", chargerName=" + chargerName
				+ ", centerPostNO=" + centerPostNO + ", centerAddr1="
				+ centerAddr1 + ", centerAddr2=" + centerAddr2
				+ ", centerLatitude=" + centerLatitude + ", centerLongitude="
				+ centerLongitude + ", centerDesc=" + centerDesc + ", regDttm="
				+ regDttm + ", regID=" + regID + ", modDttm=" + modDttm
				+ ", modID=" + modID + ", centerGubun=" + centerGubun
				+ ", centerGu=" + centerGu + ", modName=" + modName
				+ ", getCurrentPageNo()=" + getCurrentPageNo()
				+ ", getRecordCountPerPage()=" + getRecordCountPerPage()
				+ ", getPageSize()=" + getPageSize()
				+ ", getTotalRecordCount()=" + getTotalRecordCount()
				+ ", getFirstRecordIndex()=" + getFirstRecordIndex()
				+ ", getSearchValue()=" + getSearchValue()
				+ ", getSearchParameter()=" + getSearchParameter()
				+ ", getSearchDate()=" + getSearchDate()
				+ ", getSearchStartDate()=" + getSearchStartDate()
				+ ", getSearchEndDate()=" + getSearchEndDate()
				+ ", toString()=" + super.toString() + ", getMode()="
				+ getMode() + ", getClass()=" + getClass() + ", hashCode()="
				+ hashCode() + "]";
	}
	
	private interface CenterList{}
	private interface CenterEdit{}
	private interface CenterInsert{}
	private interface CenterUpdate{}
	private interface CenterDelete{}
	
	@GroupSequence({CenterList.class})
	public static interface CenterListVal{}
	
	@GroupSequence({CenterEdit.class})
	public static interface CenterEditVal{}
	
	@GroupSequence({GetMode.class,CenterInsert.class,CenterUpdate.class})
	public static interface CenterPersistVal{}
	
	@GroupSequence({GetMode.class,CenterDelete.class})
	public static interface CenterDeleteVal{}
	
}
