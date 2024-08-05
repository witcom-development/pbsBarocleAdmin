package com.dkitec.barocle.admin.customer.police.vo;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.SearchDate;

@Alias("policeVO")
@SearchDate(groups=PagingVO.SearchDateValidator.class)
public class PoliceVO extends PagingVO implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -559496987694581145L;
	
	
	private String checkType;
	private String stationName;
	private String fromDate;
	private String toDate;
	private String fromHour;
	private String toHour;
	private String stationId;
	private String bikeNo;
	private String mbId;
	private String mpnNo;
	private String rentStationName;
	private String returnStationName;
	private String rentDttm;
	private String returnDttm;		
	
	private String polReqReqDttm;
	private String polReqInstitutionName;
	private String polReqName;
	private String polReqIssueDttm;
	private String polReqContent;		
	private String polReqSeq;
	private String viewFlg;
	private String pagingYn;
	private String searchStartDate;
	private String searchEndDate;	
	
	private java.util.Date regDttm;
	private String regID;
	private java.util.Date modDttm;
	private String modID;	
	
	
	public String getCheckType() {
		return checkType;
	}

	public void setCheckType(String checkType) {
		this.checkType = checkType;
	}

	public String getStationName() {
		return stationName;
	}

	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	
	public String getFromDate() {
		return fromDate;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public String getToDate() {
		return toDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	public String getFromHour() {
		return fromHour;
	}

	public void setFromHour(String fromHour) {
		this.fromHour = fromHour;
	}

	public String getToHour() {
		return toHour;
	}

	public void setToHour(String toHour) {
		this.toHour = toHour;
	}

	public String getStationId() {
		return stationId;
	}

	public void setStationId(String stationId) {
		this.stationId = stationId;
	}

	
	

	
	public String getBikeNo() {
		return bikeNo;
	}

	public void setBikeNo(String bikeNo) {
		this.bikeNo = bikeNo;
	}

	public String getMbId() {
		return mbId;
	}

	public void setMbId(String mbId) {
		this.mbId = mbId;
	}

	public String getMpnNo() {
		return mpnNo;
	}

	public void setMpnNo(String mpnNo) {
		this.mpnNo = mpnNo;
	}

	public String getRentStationName() {
		return rentStationName;
	}

	public void setRentStationName(String rentStationName) {
		this.rentStationName = rentStationName;
	}

	public String getReturnStationName() {
		return returnStationName;
	}

	public void setReturnStationName(String returnStationName) {
		this.returnStationName = returnStationName;
	}

	public String getRentDttm() {
		return rentDttm;
	}

	public void setRentDttm(String rentDttm) {
		this.rentDttm = rentDttm;
	}

	public String getReturnDttm() {
		return returnDttm;
	}

	public void setReturnDttm(String returnDttm) {
		this.returnDttm = returnDttm;
	}
	
	//수사 협조자료 TB_COM_POL_REQ의 VO 

	
	public String getViewFlg() {
		return viewFlg;
	}

	public void setViewFlg(String viewFlg) {
		this.viewFlg = viewFlg;
	}

	public String getSearchStartDate() {
		return searchStartDate;
	}

	public String getPagingYn() {
		return pagingYn;
	}

	public void setPagingYn(String pagingYn) {
		this.pagingYn = pagingYn;
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

	public void setPolReqReqDttm(String polReqReqDttm) {
		this.polReqReqDttm = polReqReqDttm;
	}

	public void setPolReqIssueDttm(String polReqIssueDttm) {
		this.polReqIssueDttm = polReqIssueDttm;
	}
	
	public PoliceVO(String polReqSeq, String polReqReqDttm, String polReqInstitutionName, String polReqName,
			String polReqIssueDttm, String polReqContent) {
		super();
		this.polReqSeq = polReqSeq;
		this.polReqReqDttm = polReqReqDttm;
		this.polReqInstitutionName = polReqInstitutionName;
		this.polReqName = polReqName;
		this.polReqIssueDttm = polReqIssueDttm;
		this.polReqContent = polReqContent;
	}

	public String getPolReqReqDttm() {
		return polReqReqDttm;
	}

	public void setPolReqReqDttm1(String polReqReqDttm) {
		this.polReqReqDttm = polReqReqDttm;
	}

	public String getPolReqInstitutionName() {
		return polReqInstitutionName;
	}

	public void setPolReqInstitutionName(String polReqInstitutionName) {
		this.polReqInstitutionName = polReqInstitutionName;
	}

	public String getPolReqName() {
		return polReqName;
	}

	public void setPolReqName(String polReqName) {
		this.polReqName = polReqName;
	}

	public String getPolReqIssueDttm() {
		return polReqIssueDttm;
	}

	public void setPolReqIssueDttm1(String polReqIssueDttm) {
		this.polReqIssueDttm = polReqIssueDttm;
	}

	public String getPolReqContent() {
		return polReqContent;
	}

	public void setPolReqContent(String polReqContent) {
		this.polReqContent = polReqContent;
	}

	public String getPolReqSeq() {
		return polReqSeq;
	}

	public void setPolReqSeq(String polReqSeq) {
		this.polReqSeq = polReqSeq;
	}
	

	public PoliceVO(){
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
}
