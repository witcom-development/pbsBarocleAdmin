package com.dkitec.barocle.admin.statistics.route.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;

@SuppressWarnings("serial")
@Alias("routeStatisticsVo")
public class RouteStatisticsVO extends CommonVo implements Serializable {
	
	private String searchBgnDe;
	private String searchEndDe;
	
	private String stationLatitude;
	private String stationLongitude;
	
	private String rentStationGrp;
	private String returnStationGrp;
	private String rentStationId;
	private String returnStationId;
	
	private String rentHistSeq;
	private String moveOrd;
	private String moveLatitude;
	private String moveLongitude;
	
	//주요이동결로 자전거번호 추가 (통계 > 주요 이동경로 현황 )
	private String searchBikeNo;
	
	//주요이동경로 자전거 이동궤적 마커 표시
	private String mordArr;
	
	
	
	public String getMordArr() {
		return mordArr;
	}
	public void setMordArr(String mordArr) {
		this.mordArr = mordArr;
	}
	public String getSearchBikeNo() {
		return searchBikeNo;
	}
	public void setSearchBikeNo(String searchBikeNo) {
		this.searchBikeNo = searchBikeNo;
	}
	public String getSearchBgnDe() {
		return searchBgnDe;
	}
	public void setSearchBgnDe(String searchBgnDe) {
		this.searchBgnDe = searchBgnDe;
	}
	public String getSearchEndDe() {
		return searchEndDe;
	}
	public void setSearchEndDe(String searchEndDe) {
		this.searchEndDe = searchEndDe;
	}
	public String getStationLatitude() {
		return stationLatitude;
	}
	public void setStationLatitude(String stationLatitude) {
		this.stationLatitude = stationLatitude;
	}
	public String getStationLongitude() {
		return stationLongitude;
	}
	public void setStationLongitude(String stationLongitude) {
		this.stationLongitude = stationLongitude;
	}
	public String getRentStationGrp() {
		return rentStationGrp;
	}
	public void setRentStationGrp(String rentStationGrp) {
		this.rentStationGrp = rentStationGrp;
	}
	public String getReturnStationGrp() {
		return returnStationGrp;
	}
	public void setReturnStationGrp(String returnStationGrp) {
		this.returnStationGrp = returnStationGrp;
	}
	public String getRentStationId() {
		return rentStationId;
	}
	public void setRentStationId(String rentStationId) {
		this.rentStationId = rentStationId;
	}
	public String getReturnStationId() {
		return returnStationId;
	}
	public void setReturnStationId(String returnStationId) {
		this.returnStationId = returnStationId;
	}
	public String getRentHistSeq() {
		return rentHistSeq;
	}
	public void setRentHistSeq(String rentHistSeq) {
		this.rentHistSeq = rentHistSeq;
	}
	public String getMoveOrd() {
		return moveOrd;
	}
	public void setMoveOrd(String moveOrd) {
		this.moveOrd = moveOrd;
	}
	public String getMoveLatitude() {
		return moveLatitude;
	}
	public void setMoveLatitude(String moveLatitude) {
		this.moveLatitude = moveLatitude;
	}
	public String getMoveLongitude() {
		return moveLongitude;
	}
	public void setMoveLongitude(String moveLongitude) {
		this.moveLongitude = moveLongitude;
	}
	
}
