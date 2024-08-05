/*
 * @Package Name : com.dkitec.barocle.admin.manage.DeviceMgmt.vo
 * @파일명          : DeviceMgmtVO.java
 * @작성일          : 2015. 4. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 15.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.manage.deviceMgmt.beacon.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;

/**
 * @파일명          : DeviceMgmtVO.java
 * @작성일          : 2015. 4. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 15.   |   ymshin   |  최초작성
 */
@SuppressWarnings("serial")
@Alias("beaconVo")
public class BeaconVO extends CommonVo implements Serializable {

	private String beaconId;
	private String nowLocateId; 
	private String nowLocateClsCd;
	private String beaconBatteryStusCd;
	private String beaconRange;
	private String deviceId;
	private String deviceModlCd;
	private String entrpsCd;
	private String entrpsCdNm;
	private String stationName;
	private String centerName;
	private String stationGrpSeq;
	private String regDttm;
	private String modDttm;
	private String deviceStatusCd;
	private String serialNo;
    private String chkType;
    private String chkId;
    private String regId;
	
    private String oldDeviceId;
	
	public String getModDttm() {
		return modDttm;
	}
	public void setModDttm(String modDttm) {
		this.modDttm = modDttm;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getChkType() {
		return chkType;
	}
	public void setChkType(String chkType) {
		this.chkType = chkType;
	}
	public String getChkId() {
		return chkId;
	}
	public void setChkId(String chkId) {
		this.chkId = chkId;
	}
	public String getBeaconId() {
		return beaconId;
	}
	public void setBeaconId(String beaconId) {
		this.beaconId = beaconId;
	}
	public String getNowLocateId() {
		return nowLocateId;
	}
	public void setNowLocateId(String nowLocateId) {
		this.nowLocateId = nowLocateId;
	}
	public String getNowLocateClsCd() {
		return nowLocateClsCd;
	}
	public void setNowLocateClsCd(String nowLocateClsCd) {
		this.nowLocateClsCd = nowLocateClsCd;
	}
	public String getBeaconBatteryStusCd() {
		return beaconBatteryStusCd;
	}
	public void setBeaconBatteryStusCd(String beaconBatteryStusCd) {
		this.beaconBatteryStusCd = beaconBatteryStusCd;
	}
	public String getBeaconRange() {
		return beaconRange;
	}
	public void setBeaconRange(String beaconRange) {
		this.beaconRange = beaconRange;
	}
	public String getDeviceId() {
		return deviceId;
	}
	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}
	public String getDeviceModlCd() {
		return deviceModlCd;
	}
	public void setDeviceModlCd(String deviceModlCd) {
		this.deviceModlCd = deviceModlCd;
	}
	public String getEntrpsCd() {
		return entrpsCd;
	}
	public void setEntrpsCd(String entrpsCd) {
		this.entrpsCd = entrpsCd;
	}
	public String getEntrpsCdNm() {
		return entrpsCdNm;
	}
	public void setEntrpsCdNm(String entrpsCdNm) {
		this.entrpsCdNm = entrpsCdNm;
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
	public String getStationGrpSeq() {
		return stationGrpSeq;
	}
	public void setStationGrpSeq(String stationGrpSeq) {
		this.stationGrpSeq = stationGrpSeq;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getDeviceStatusCd() {
		return deviceStatusCd;
	}
	public void setDeviceStatusCd(String deviceStatusCd) {
		this.deviceStatusCd = deviceStatusCd;
	}
	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
	public String getOldDeviceId() {
		return oldDeviceId;
	}
	public void setOldDeviceId(String oldDeviceId) {
		this.oldDeviceId = oldDeviceId;
	}
	
	
	
	
}
