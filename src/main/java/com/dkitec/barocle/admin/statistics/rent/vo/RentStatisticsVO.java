package com.dkitec.barocle.admin.statistics.rent.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;

@SuppressWarnings("serial")
@Alias("rentStatisticsVo")
public class RentStatisticsVO extends CommonVo implements Serializable {
	private String dateType;
	private String searchBgnMt;
	private String searchEndMt;
	private String stationGrp;
	private String stationGrpName;
	private String stationId;
	private String stationName;
	private String rentDttm;
	private String rentCnt;
	private String returnCnt;
	
	public String getDateType() {
		return dateType;
	}
	
	public void setDateType(String dateType) {
		this.dateType = dateType;
	}
	
	public String getSearchBgnMt() {
		return searchBgnMt;
	}
	
	public void setSearchBgnMt(String searchBgnMt) {
		this.searchBgnMt = searchBgnMt;
	}
	
	public String getSearchEndMt() {
		return searchEndMt;
	}
	
	public void setSearchEndMt(String searchEndMt) {
		this.searchEndMt = searchEndMt;
	}
	
	public String getStationGrp() {
		return stationGrp;
	}
	
	public void setStationGrp(String stationGrp) {
		this.stationGrp = stationGrp;
	}
	
	public String getStationGrpName() {
		return stationGrpName;
	}
	
	public void setStationGrpName(String stationGrpName) {
		this.stationGrpName = stationGrpName;
	}
	
	public String getStationId() {
		return stationId;
	}
	
	public void setStationId(String stationId) {
		this.stationId = stationId;
	}
	
	public String getStationName() {
		return stationName;
	}
	
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	
	public String getRentDttm() {
		return rentDttm;
	}
	
	public void setRentDttm(String rentDttm) {
		this.rentDttm = rentDttm;
	}
	
	public String getRentCnt() {
		return rentCnt;
	}
	
	public void setRentCnt(String rentCnt) {
		this.rentCnt = rentCnt;
	}
	
	public String getReturnCnt() {
		return returnCnt;
	}
	
	public void setReturnCnt(String returnCnt) {
		this.returnCnt = returnCnt;
	}
}
