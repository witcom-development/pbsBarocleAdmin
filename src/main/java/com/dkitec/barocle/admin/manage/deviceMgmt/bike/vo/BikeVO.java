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
package com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Null;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.IsStringNotNullNumeric;
import com.dkitec.barocle.util.validator.annotation.IsStringNumeric;

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
@Alias("bikeVo")
public class BikeVO extends CommonVo implements Serializable {

	@Size(max=14, message="자전거 아이디는 7자 이하만 가능 합니다.")
	@CheckValue
	private String bikeId;
	@Size(max=14, message="자전거 번호는 7자 이하만 가능 합니다.")
	@CheckValue
	private String bikeNo;
	private String rackId;
	@Size(max=20, message="단말기 아이디는 20자 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9a-zA-Z]*$" , message="단말기 아이디는 영문자, 숫자 조합만 가능 합니다.")
	private String terminalId;
	private String rentHistSeq;
	private String bikeStatusCd;
	private String bikeStatusName;
	private String lastChkDttm;
	private String regDttm;
	private String modDttm;
	private String adminId;
	@Size(max=3, message="숫자 3자리까지 입니다.")
    @IsStringNotNullNumeric(message="숫자 3자리까지 입니다.")
	private String stationEquipOrder;//거치대 설치 순서.
	private String locateStrDttm;
	private String loacteEndDttm;
	private String cascadeYn;
	private String chkType;
	private String totMoveDist;
	private String lostYn;
	private String tabNum;
    private String lostRegId;
    private String lostDate;
    private String bikeTotCnt;//거치대 전체수
    private String cascadeYnCnt;
    private List<String> stationSeqList;
    private List<BikeVO> bikeList;
    private String isParking;
    private String centerId;
    private String batteryStusCd; 	//배터리 정보_20160810_JJH
  //바로클 고도화 2018.01 dwyoon
    private String entrpsCd;
    private String entrpsCdNm;
    
    
    private String bikeRobSeq;
    private String processYn;
    private String regId;
    
    private String faultSeq;
    
    // QR자전거 구축 2019.10
    private String bikeSeCd;
    
    //20201105 solbit add 
    private String rentClsCdName;
    private String rentSeq;
    private String elapseTime;
    
	// QR 자전거 serial No, Device Name 추가 2020.01.02 by dustjm
    private String serialNo;
    
    private String deviceName;
    
    private String stationId;
    
    private String beaconId;
    
    // QR 자전거 로그정보 표출	2020.01.07
    private String bikeStatus;
    private String bikeLock;
    private String deviceId;
    private String bikeTimeStamp;
    private String userType;
    private String userSeq;
    private String devBatt;
    private String beaconBatt;
    private String bikeBatt;
    private String firmFw;
    private String modemFw;
    private String xPos;
    private String yPos;
    
    private String useCnt;
    
    
    // 수리 순번 20210528
    private String repairSeq;
    // 수리내역
    private String repairDesc;
    // 고장내역
    private String checkDesc;
    
	public String getRepairSeq() {
		return repairSeq;
	}
	public void setRepairSeq(String repairSeq) {
		this.repairSeq = repairSeq;
	}
	
	
	
	public String getRepairDesc() {
		return repairDesc;
	}
	public void setRepairDesc(String repairDesc) {
		this.repairDesc = repairDesc;
	}
	public String getCheckDesc() {
		return checkDesc;
	}
	public void setCheckDesc(String checkDesc) {
		this.checkDesc = checkDesc;
	}

	
	
	
	
	
	
	
	
	
	
	
	public String getBatteryStusCd() {
		return batteryStusCd;
	}
	public void setBatteryStusCd(String batteryStusCd) {
		this.batteryStusCd = batteryStusCd;
	}
	public String getCenterId() {
		return centerId;
	}   
	
	public void setCenterId(String centerId) {
		this.centerId = centerId;
	}
	public String getRentClsCdName() {
		return rentClsCdName;
	}
	public void setRentClsCdName(String rentClsCdName) {
		this.rentClsCdName = rentClsCdName;
	}
	
	public String getElapseTime() {
		return elapseTime;
	}
	public void setElapseTime(String elapseTime) {
		this.elapseTime = elapseTime;
	}
	public String getRentSeq() {
		return rentSeq;
	}
	public void setRentSeq(String rentSeq) {
		this.rentSeq = rentSeq;
	}
	public String getBikeTotCnt() {
		return bikeTotCnt;
	}
	public void setBikeTotCnt(String bikeTotCnt) {
		this.bikeTotCnt = bikeTotCnt;
	}
	public String getCascadeYnCnt() {
		return cascadeYnCnt;
	}
	public void setCascadeYnCnt(String cascadeYnCnt) {
		this.cascadeYnCnt = cascadeYnCnt;
	}
	public String getBikeId() {
		return bikeId;
	}
	public void setBikeId(String bikeId) {
		this.bikeId = bikeId;
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
	public String getBikeStatusCd() {
		return bikeStatusCd;
	}
	public void setBikeStatusCd(String bikeStatusCd) {
		this.bikeStatusCd = bikeStatusCd;
	}
	public String getLastChkDttm() {
		return lastChkDttm;
	}
	public void setLastChkDttm(String lastChkDttm) {
		this.lastChkDttm = lastChkDttm;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getModDttm() {
		return modDttm;
	}
	public void setModDttm(String modDttm) {
		this.modDttm = modDttm;
	}
	public String getStationEquipOrder() {
		return stationEquipOrder;
	}
	public void setStationEquipOrder(String stationEquipOrder) {
		this.stationEquipOrder = stationEquipOrder;
	}
	public String getLocateStrDttm() {
		return locateStrDttm;
	}
	public void setLocateStrDttm(String locateStrDttm) {
		this.locateStrDttm = locateStrDttm;
	}
	public String getLoacteEndDttm() {
		return loacteEndDttm;
	}
	public void setLoacteEndDttm(String loacteEndDttm) {
		this.loacteEndDttm = loacteEndDttm;
	}
	
	public String getCascadeYn() {
		return cascadeYn;
	}
	public void setCascadeYn(String cascadeYn) {
		this.cascadeYn = cascadeYn;
	}
	public String getBikeNo() {
		return bikeNo;
	}
	public void setBikeNo(String bikeNo) {
		this.bikeNo = bikeNo;
	}
	public String getTotMoveDist() {
		return totMoveDist;
	}
	public void setTotMoveDist(String totMoveDist) {
		this.totMoveDist = totMoveDist;
	}
	public String getLostYn() {
		return lostYn;
	}
	public void setLostYn(String lostYn) {
		this.lostYn = lostYn;
	}
	public String getLostRegId() {
		return lostRegId;
	}
	public void setLostRegId(String lostRegId) {
		this.lostRegId = lostRegId;
	}
	public String getLostDate() {
		return lostDate;
	}
	public void setLostDate(String lostDate) {
		this.lostDate = lostDate;
	}
	public String getTabNum() {
		return tabNum;
	}
	public void setTabNum(String tabNum) {
		this.tabNum = tabNum;
	}
	public List<String> getStationSeqList() {
		return stationSeqList;
	}
	public void setStationSeqList(List<String> stationSeqList) {
		this.stationSeqList = stationSeqList;
	}
	public String getBikeStatusName() {
		return bikeStatusName;
	}
	public void setBikeStatusName(String bikeStatusName) {
		this.bikeStatusName = bikeStatusName;
	}
	public List<BikeVO> getBikeList() {
		return bikeList;
	}
	public void setBikeList(List<BikeVO> bikeList) {
		this.bikeList = bikeList;
	}
	public String getChkType() {
		return chkType;
	}
	public void setChkType(String chkType) {
		this.chkType = chkType;
	}
	public String getRentHistSeq() {
		return rentHistSeq;
	}
	public void setRentHistSeq(String rentHistSeq) {
		this.rentHistSeq = rentHistSeq;
	}
	public String getIsParking() {
		return isParking;
	}
	public void setIsParking(String isParking) {
		this.isParking = isParking;
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
	public String getBikeRobSeq() {
		return bikeRobSeq;
	}
	public void setBikeRobSeq(String bikeRobSeq) {
		this.bikeRobSeq = bikeRobSeq;
	}
	public String getProcessYn() {
		return processYn;
	}
	public void setProcessYn(String processYn) {
		this.processYn = processYn;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getFaultSeq() {
		return faultSeq;
	}
	public void setFaultSeq(String faultSeq) {
		this.faultSeq = faultSeq;
	}
	public String getBikeSeCd() {
		return bikeSeCd;
	}
	public void setBikeSeCd(String bikeSeCd) {
		this.bikeSeCd = bikeSeCd;
	}
	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
	public String getDeviceName() {
		return deviceName;
	}
	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}
	public String getStationId() {
		return stationId;
	}
	public void setStationId(String stationId) {
		this.stationId = stationId;
	}
	public String getBeaconId() {
		return beaconId;
	}
	public void setBeaconId(String beaconId) {
		this.beaconId = beaconId;
	}
	public String getBikeStatus() {
		return bikeStatus;
	}
	public void setBikeStatus(String bikeStatus) {
		this.bikeStatus = bikeStatus;
	}
	public String getBikeLock() {
		return bikeLock;
	}
	public void setBikeLock(String bikeLock) {
		this.bikeLock = bikeLock;
	}
	public String getDeviceId() {
		return deviceId;
	}
	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}
	public String getBikeTimeStamp() {
		return bikeTimeStamp;
	}
	public void setBikeTimeStamp(String bikeTimeStamp) {
		this.bikeTimeStamp = bikeTimeStamp;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}
	public String getDevBatt() {
		return devBatt;
	}
	public void setDevBatt(String devBatt) {
		this.devBatt = devBatt;
	}
	public String getBeaconBatt() {
		return beaconBatt;
	}
	public void setBeaconBatt(String beaconBatt) {
		this.beaconBatt = beaconBatt;
	}
	public String getBikeBatt() {
		return bikeBatt;
	}
	public void setBikeBatt(String bikeBatt) {
		this.bikeBatt = bikeBatt;
	}
	public String getFirmFw() {
		return firmFw;
	}
	public void setFirmFw(String firmFw) {
		this.firmFw = firmFw;
	}
	public String getModemFw() {
		return modemFw;
	}
	public void setModemFw(String modemFw) {
		this.modemFw = modemFw;
	}
	public String getxPos() {
		return xPos;
	}
	public void setxPos(String xPos) {
		this.xPos = xPos;
	}
	public String getyPos() {
		return yPos;
	}
	public void setyPos(String yPos) {
		this.yPos = yPos;
	}
	public String getUseCnt() {
		return useCnt;
	}
	public void setUseCnt(String useCnt) {
		this.useCnt = useCnt;
	}
	
	
}
