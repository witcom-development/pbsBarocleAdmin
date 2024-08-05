package com.dkitec.barocle.admin.statistics.group.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;

@SuppressWarnings("serial")
@Alias("GroupStatisticsVo")
public class GroupStatisticsVO extends CommonVo implements Serializable {
	private String searchBgnMt;
	private String searchEndMt;
	private String dateType;
	private String rentStationGrp;
	private String rentStationGrpName;
	private String returnStationGrp;
	private String returnStationGrpName;
	private String rentDttm;
	private String moveCnt;
	
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
	public String getDateType() {
		return dateType;
	}
	public void setDateType(String dateType) {
		this.dateType = dateType;
	}
	public String getRentStationGrp() {
		return rentStationGrp;
	}
	public void setRentStationGrp(String rentStationGrp) {
		this.rentStationGrp = rentStationGrp;
	}
	public String getRentStationGrpName() {
		return rentStationGrpName;
	}
	public void setRentStationGrpName(String rentStationGrpName) {
		this.rentStationGrpName = rentStationGrpName;
	}
	public String getReturnStationGrp() {
		return returnStationGrp;
	}
	public void setReturnStationGrp(String returnStationGrp) {
		this.returnStationGrp = returnStationGrp;
	}
	public String getReturnStationGrpName() {
		return returnStationGrpName;
	}
	public void setReturnStationGrpName(String returnStationGrpName) {
		this.returnStationGrpName = returnStationGrpName;
	}
	public String getRentDttm() {
		return rentDttm;
	}
	public void setRentDttm(String rentDttm) {
		this.rentDttm = rentDttm;
	}
	public String getMoveCnt() {
		return moveCnt;
	}
	public void setMoveCnt(String moveCnt) {
		this.moveCnt = moveCnt;
	}
}
