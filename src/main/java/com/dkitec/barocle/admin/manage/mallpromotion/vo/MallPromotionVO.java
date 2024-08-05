package com.dkitec.barocle.admin.manage.mallpromotion.vo;

import javax.validation.GroupSequence;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;
import com.dkitec.barocle.util.validator.annotation.IsStringNumeric;
import com.dkitec.barocle.util.validator.annotation.SearchDate;

@Alias("mallPromotionVO")
@SearchDate(groups=PagingVO.SearchDateValidator.class)
public class MallPromotionVO extends PagingVO implements java.io.Serializable {
	
	private static final long serialVersionUID = -8912419158300184426L;
	
	@IsNumeric(groups={MallPromotionUpdate.class,MallPromotionDelete.class})
	private int shopADSeq;
	@CheckValue(message="대여소를 선택해 주세요.",groups={MallPromotionInsert.class,MallPromotionUpdate.class})
	private String stationID;
	@CheckValue(message="업좀을 선택해 주세요.",groups={MallPromotionInsert.class,MallPromotionUpdate.class})
	private String typeClsCD;
	@CheckValue(message="상가명을 입력해 주세요.",groups={MallPromotionInsert.class,MallPromotionUpdate.class})
	@Size(message="상가명을 100자 이내 입력해 주세요.",max=100)
	private String shopName;
	//@IsNumeric(message="우편번호를 입력해 주세요.",groups={MallPromotionInsert.class,MallPromotionUpdate.class})
	private String shopPostNO;
	@CheckValue(message="주소1을 입력해 주세요.",groups={MallPromotionInsert.class,MallPromotionUpdate.class})
	private String shopAddr1;
	@CheckValue(message="주소2를 입력해 주세요.",groups={MallPromotionInsert.class,MallPromotionUpdate.class})
	private String shopAddr2;
	private String shopTelNO;
	@IsStringNumeric(message="숫자만 입력이 가능합니다.",groups={MallPromotionInsert.class,MallPromotionUpdate.class})
	private String shopTelNO1;
	@IsStringNumeric(message="숫자만 입력이 가능합니다.",groups={MallPromotionInsert.class,MallPromotionUpdate.class})
	private String shopTelNO2;
	@IsStringNumeric(message="숫자만 입력이 가능합니다.",groups={MallPromotionInsert.class,MallPromotionUpdate.class})
	private String shopTelNO3;
	private String shopLatitude;
	private String shopLongitude;
	private java.util.Date regDttm;
	private String regID;
	private java.util.Date modDttm;
	private String modID;
	@CheckValue(groups={MallPromotionInsert.class,MallPromotionUpdate.class})
	@Size(message="홍보문구를 500자 이내 입력해 주세요.",max=500)
	private String adTextDesc;
	
	private String cdDesc1;
	private String cdDesc2;
	private String stationNO;
	private String stationName;
	private String stationGrpSeq;
	private String mainStationID;
	private String stationGrpName;
	
	private String mLang;
		
	public int getShopADSeq() {
		return shopADSeq;
	}

	public void setShopADSeq(int shopADSeq) {
		this.shopADSeq = shopADSeq;
	}

	public String getStationID() {
		return stationID;
	}

	public void setStationID(String stationID) {
		this.stationID = stationID;
	}

	public String getTypeClsCD() {
		return typeClsCD;
	}

	public void setTypeClsCD(String typeClsCD) {
		this.typeClsCD = typeClsCD;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getShopPostNO() {
		return shopPostNO;
	}

	public void setShopPostNO(String shopPostNO) {
		this.shopPostNO = shopPostNO;
	}

	public String getShopAddr1() {
		return shopAddr1;
	}

	public void setShopAddr1(String shopAddr1) {
		this.shopAddr1 = shopAddr1;
	}

	public String getShopAddr2() {
		return shopAddr2;
	}

	public void setShopAddr2(String shopAddr2) {
		this.shopAddr2 = shopAddr2;
	}

	public String getShopTelNO() {
		return shopTelNO;
	}

	public void setShopTelNO(String shopTelNO) {
		this.shopTelNO = shopTelNO;
	}

	public String getShopTelNO1() {
		return shopTelNO1;
	}

	public void setShopTelNO1(String shopTelNO1) {
		this.shopTelNO1 = shopTelNO1;
	}

	public String getShopTelNO2() {
		return shopTelNO2;
	}

	public void setShopTelNO2(String shopTelNO2) {
		this.shopTelNO2 = shopTelNO2;
	}

	public String getShopTelNO3() {
		return shopTelNO3;
	}

	public void setShopTelNO3(String shopTelNO3) {
		this.shopTelNO3 = shopTelNO3;
	}

	public String getShopLatitude() {
		return shopLatitude;
	}

	public void setShopLatitude(String shopLatitude) {
		this.shopLatitude = shopLatitude;
	}

	public String getShopLongitude() {
		return shopLongitude;
	}

	public void setShopLongitude(String shopLongitude) {
		this.shopLongitude = shopLongitude;
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

	public String getAdTextDesc() {
		return adTextDesc;
	}

	public void setAdTextDesc(String adTextDesc) {
		this.adTextDesc = adTextDesc;
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

	public String getStationNO() {
		return stationNO;
	}

	public void setStationNO(String stationNO) {
		this.stationNO = stationNO;
	}

	public String getStationName() {
		return stationName;
	}

	public void setStationName(String stationName) {
		this.stationName = stationName;
	}

	public String getStationGrpSeq() {
		return stationGrpSeq;
	}

	public void setStationGrpSeq(String stationGrpSeq) {
		this.stationGrpSeq = stationGrpSeq;
	}

	public String getMainStationID() {
		return mainStationID;
	}

	public void setMainStationID(String mainStationID) {
		this.mainStationID = mainStationID;
	}

	public String getStationGrpName() {
		return stationGrpName;
	}

	public void setStationGrpName(String stationGrpName) {
		this.stationGrpName = stationGrpName;
	}

	public String getmLang() {
		return mLang;
	}

	public void setmLang(String mLang) {
		this.mLang = mLang;
	}
	
	@Override
	public String toString() {
		return "MallPromotionVO [shopADSeq=" + shopADSeq + ", stationID="
				+ stationID + ", typeClsCD=" + typeClsCD + ", shopName="
				+ shopName + ", shopPostNO=" + shopPostNO + ", shopAddr1="
				+ shopAddr1 + ", shopAddr2=" + shopAddr2 + ", shopTelNO="
				+ shopTelNO + ", shopTelNO1=" + shopTelNO1 + ", shopTelNO2="
				+ shopTelNO2 + ", shopTelNO3=" + shopTelNO3 + ", shopLatitude="
				+ shopLatitude + ", shopLongitude=" + shopLongitude
				+ ", regDttm=" + regDttm + ", regID=" + regID + ", modDttm="
				+ modDttm + ", modID=" + modID + ", adTextDesc=" + adTextDesc
				+ ", cdDesc1=" + cdDesc1 + ", cdDesc2=" + cdDesc2
				+ ", stationNO=" + stationNO + ", stationName=" + stationName
				+ ", stationGrpSeq=" + stationGrpSeq + ", mainStationID="
				+ mainStationID + ", stationGrpName=" + stationGrpName
				+ ", mLang=" + mLang + ", getCurrentPageNo()="
				+ getCurrentPageNo() + ", getRecordCountPerPage()="
				+ getRecordCountPerPage() + ", getPageSize()=" + getPageSize()
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
	
	private interface MallPromotionList{}
	private interface MallPromotionEdit{}
	private interface MallPromotionInsert{}
	private interface MallPromotionUpdate{}
	private interface MallPromotionDelete{}
	
	@GroupSequence({MallPromotionList.class})
	public static interface MallPromotionListVal{}
	
	@GroupSequence({MallPromotionEdit.class})
	public static interface MallPromotionEditVal{}
	
	@GroupSequence({GetMode.class,MallPromotionInsert.class,MallPromotionUpdate.class})
	public static interface MallPromotionPersistVal{}
	
	@GroupSequence({GetMode.class,MallPromotionDelete.class})
	public static interface MallPromotionDeleteVal{}

}
