/*
 * @Package Name : com.dkitec.barocle.admin.manage.deviceMgmt.common.vo
 * @파일명          : FindOutDeviceVO.java
 * @작성일          : 2015. 4. 24.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 24.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.common.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.base.IConstants;

/**
 * @파일명          : FindOutDeviceVO.java
 * @작성일          : 2015. 4. 24.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 24.   |   ymshin   |  최초작성
 */
@SuppressWarnings("serial")
@Alias("foDeviceVo")
public class FindOutDeviceVO implements Serializable{

	
	private String deviceType;
	
	@Size(max=10, message="코드 형식이 아닙니다.")
	private String deviceStatusCd;
	private String deviceStatusName;
	private String searchType;
	private String searchWords;
	
	@Size(max=20, message="자전거 ID는 20자 이하만 가능 합니다.")
	private String bikeId;
	@Size(max=20, message="자전거 번호는 20자 이하만 가능 합니다.")
	private String bikeNo;
	@Size(max=20, message="거치대 ID는 20자 이하만 가능 합니다.")
	private String rackId;
	@Size(max=50, message="단말기 ID는 50자 이하만 가능 합니다.")
	private String terminalId;
	@Size(max=50, message="AP아이디는 50자 이하만 가능 합니다.")
	private String apId;
	@Size(max=50, message="시리얼 번호는 50자 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9a-zA-Z]*$" , message="시리얼 번호는 영문자, 숫자 조합만 가능 합니다.")
	private String serialNo;
	
	private String stationName;
	private String centerName;
	
	private String stationEquipOrder;
	
	private List<String> stations;
	
	private String lang = IConstants.LANG_KR;
	
	private String stationGroupId;
	private String stationGroupName;
	private String stationId;
	
	private String faultContent;
	private String reportContent;
	private String batReplaceTime;
	
	public String getStationId() {
		return stationId;
	}
	public void setStationId(String stationId) {
		this.stationId = stationId;
	}
	public String getStationGroupId() {
		return stationGroupId;
	}
	public void setStationGroupId(String stationGroupId) {
		this.stationGroupId = stationGroupId;
	}
	public String getStationGroupName() {
		return stationGroupName;
	}
	public void setStationGroupName(String stationGroupName) {
		this.stationGroupName = stationGroupName;
	}
	public String getDeviceStatusName() {
		return deviceStatusName;
	}
	public void setDeviceStatusName(String deviceStatusName) {
		this.deviceStatusName = deviceStatusName;
	}
	public String getDeviceType() {
		return deviceType;
	}
	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}
	public String getDeviceStatusCd() {
		return deviceStatusCd;
	}
	public void setDeviceStatusCd(String deviceStatusCd) {
		this.deviceStatusCd = deviceStatusCd;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchWords() {
		return searchWords;
	}
	public void setSearchWords(String searchWords) {
		this.searchWords = searchWords;
	}
	public String getBikeId() {
		return bikeId;
	}
	public void setBikeId(String bikeId) {
		this.bikeId = bikeId;
	}
	public String getBikeNo() {
		return bikeNo;
	}
	public void setBikeNo(String bikeNo) {
		this.bikeNo = bikeNo;
	}
	public String getRackId() {
		return rackId;
	}
	public void setRackId(String rackId) {
		this.rackId = rackId;
	}
	public String getTerminalId() {
		return terminalId;
	}
	public void setTerminalId(String terminalId) {
		this.terminalId = terminalId;
	}
	public String getApId() {
		return apId;
	}
	public void setApId(String apId) {
		this.apId = apId;
	}
	public List<String> getStations() {
		return stations;
	}
	public void setStations(List<String> stations) {
		this.stations = stations;
	}
	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public String getCenterName() {
		return centerName;
	}
	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}
	public String getStationEquipOrder() {
		return stationEquipOrder;
	}
	public void setStationEquipOrder(String stationEquipOrder) {
		this.stationEquipOrder = stationEquipOrder;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getFaultContent() {
		return faultContent;
	}
	public void setFaultContent(String faultContent) {
		this.faultContent = faultContent;
	}
	public String getReportContent() {
		return reportContent;
	}
	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}
	public String getBatReplaceTime() {
		return batReplaceTime;
	}
	public void setBatReplaceTime(String batReplaceTime) {
		this.batReplaceTime = batReplaceTime;
	}
	
}
