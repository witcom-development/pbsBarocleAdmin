package com.dkitec.barocle.admin.common.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.base.IConstants;

@SuppressWarnings("serial")
@Alias("troubleReportVo")
public class TroubleReportVO implements Serializable{
	private String faultSeq;
	private String mode;
	private String deviceType;
	private String deviceStatus;
	private String equipmentId;
	private String equipmentClsCd;

	private String reportId;
	private String faultCode;
	private String faultContent;
	
	@Size(max=20, message="자전거 ID는 20자 이하만 가능 합니다.")
	private String bikeId;
	@Size(max=20, message="자전거 번호는 20자 이하만 가능 합니다.")
	private String bikeNo;
	@Size(max=20, message="거치대 ID는 20자 이하만 가능 합니다.")
	private String rackId;
	@Size(max=50, message="AP아이디는 50자 이하만 가능 합니다.")
	private String apId;
	
	private String stationId;
	private String stationName;
	private String centerName;
	
	private String stationEquipOrder;
	
	private String lang = IConstants.LANG_KR;

	
	
	public String getFaultSeq() {
		return faultSeq;
	}

	public void setFaultSeq(String faultSeq) {
		this.faultSeq = faultSeq;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getDeviceType() {
		return deviceType;
	}

	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}

	public String getDeviceStatus() {
		return deviceStatus;
	}

	public void setDeviceStatus(String deviceStatus) {
		this.deviceStatus = deviceStatus;
	}

	public String getEquipmentId() {
		return equipmentId;
	}

	public void setEquipmentId(String equipmentId) {
		this.equipmentId = equipmentId;
	}

	public String getEquipmentClsCd() {
		return equipmentClsCd;
	}

	public void setEquipmentClsCd(String equipmentClsCd) {
		this.equipmentClsCd = equipmentClsCd;
	}

	public String getReportId() {
		return reportId;
	}

	public void setReportId(String reportId) {
		this.reportId = reportId;
	}

	public String getFaultCode() {
		return faultCode;
	}

	public void setFaultCode(String faultCode) {
		this.faultCode = faultCode;
	}

	public String getFaultContent() {
		return faultContent;
	}

	public void setFaultContent(String faultContent) {
		this.faultContent = faultContent;
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

	public String getApId() {
		return apId;
	}

	public void setApId(String apId) {
		this.apId = apId;
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
}
