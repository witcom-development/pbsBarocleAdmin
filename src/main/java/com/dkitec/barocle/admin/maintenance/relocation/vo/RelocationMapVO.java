package com.dkitec.barocle.admin.maintenance.relocation.vo;

import java.io.Serializable;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;
import com.dkitec.barocle.util.validator.annotation.IsStringNotNullNumeric;

@SuppressWarnings("serial")
@Alias("relocationMapVo")
public class RelocationMapVO implements Serializable {
 
	public String getRelocateCnt() {
		return relocateCnt;
	}
	public void setRelocateCnt(String relocateCnt) {
		this.relocateCnt = relocateCnt;
	}
	public String getImgSrc() {
		return imgSrc;
	}
	public void setImgSrc(String imgSrc) {
		this.imgSrc = imgSrc;
	}
	public String getStationId() {
		return stationId;
	}
	public void setStationId(String stationId) {
		this.stationId = stationId;
	}
	public String getStationNo() {
		return stationNo;
	}
	public void setStationNo(String stationNo) {
		this.stationNo = stationNo;
	}
	public String getStationGrp() {
		return stationGrp;
	}
	public void setStationGrp(String stationGrp) {
		this.stationGrp = stationGrp;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public String getMoveCnt() {
		return moveCnt;
	}
	public void setMoveCnt(String moveCnt) {
		this.moveCnt = moveCnt;
	}
	public String getRelocatCnt() {
		return relocatCnt;
	}
	public void setRelocatCnt(String relocatCnt) {
		this.relocatCnt = relocatCnt;
	}
	public String getTotCnt() {
		return totCnt;
	}
	public void setTotCnt(String totCnt) {
		this.totCnt = totCnt;
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
	public String getStationGrpName() {
		return stationGrpName;
	}
	public void setStationGrpName(String stationGrpName) {
		this.stationGrpName = stationGrpName;
	}
	private String relocateCnt;
	private String imgSrc;
	private String stationId;
	private String stationNo;
	private String stationGrp;
	private String stationName;
	private String moveCnt;
	private String relocatCnt;
	private String totCnt;
	private String stationLatitude;
	private String stationLongitude;
	private String stationGrpName;
	private String centerName;
	public String getCenterName() {
		return centerName;
	}
	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}
 
}
