/*
 * @Package Name : com.dkitec.barocle.admin.status.stationStaus.vo
 * @파일명          : StationStatusVO.java
 * @작성일          : 2015. 5. 18.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 18.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.stationStatus.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.beacon.vo.BeaconVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;


/**
 * @파일명          : StationStatusVO.java
 * @작성일          : 2015. 5. 18.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 18.   |   ymshin   |  최초작성
 */
@SuppressWarnings("serial")
@Alias("stationVo")
public class StationVO extends PagingVO{
	
	
	private int weight;
	
	
	public int getWeight() {
		return weight;
	}
	public void setWeight(int weight) {
		this.weight = weight;
	}


	private String stationGrpSeq; 
	public String getStationGrpSeq() {
		return stationGrpSeq;
	}
	public void setStationGrpSeq(String stationGrpSeq) {
		this.stationGrpSeq = stationGrpSeq;
	}
 
	public String getParamSearchWord() {
		return paramSearchWord;
	}
	public void setParamSearchWord(String paramSearchWord) {
		this.paramSearchWord = paramSearchWord;
	}
 
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public String getStationId() {
		return stationId;
	}
	public void setStationId(String stationId) {
		this.stationId = stationId;
	}
	public String getStationUseYn() {
		return stationUseYn;
	}
	public void setStationUseYn(String stationUseYn) {
		this.stationUseYn = stationUseYn;
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
	public String getStationNo() {
		return stationNo;
	}
	public void setStationNo(String stationNo) {
		this.stationNo = stationNo;
	}
	public String getParkingBike() {
		return parkingBike;
	}
	public void setParkingBike(String parkingBike) {
		this.parkingBike = parkingBike;
	}
	public String getShared() {
		return shared;
	}
	public void setShared(String shared) {
		this.shared = shared;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getImgSrc() {
		return imgSrc;
	}
	public void setImgSrc(String imgSrc) {
		this.imgSrc = imgSrc;
	}
	
	
	public String getParamStationGrpSeq() {
		return paramStationGrpSeq;
	}
	public void setParamStationGrpSeq(String paramStationGrpSeq) {
		this.paramStationGrpSeq = paramStationGrpSeq;
	}
	public String getParamCenterId() {
		return paramCenterId;
	}
	public void setParamCenterId(String paramCenterId) {
		this.paramCenterId = paramCenterId;
	}
	public String getParamTeamSeq() {
		return paramTeamSeq;
	}
	public void setParamTeamSeq(String paramTeamSeq) {
		this.paramTeamSeq = paramTeamSeq;
	}


	private String paramStationGrpSeq; 
	private String paramSearchWord; 
	private String paramCenterId; 
	private String paramTeamSeq; 
	
	private String stationName;//대여소 이름
	private String stationId;//대여소 Id
	private String stationUseYn;
	private String stationLatitude;
	private String stationLongitude;
	private String stationNo;
	private String parkingBike;
	private String shared;//점유율
	private String teamName;//
	private String imgSrc;//
	private String day1;
	public String getDay1() {
		return day1;
	}
	public void setDay1(String day1) {
		this.day1 = day1;
	}
	public String getDay7() {
		return day7;
	}
	public void setDay7(String day7) {
		this.day7 = day7;
	}


	private String day7;

	
	 
	
}
