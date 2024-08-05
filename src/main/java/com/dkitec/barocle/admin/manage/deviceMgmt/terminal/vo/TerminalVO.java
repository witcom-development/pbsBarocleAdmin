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
package com.dkitec.barocle.admin.manage.deviceMgmt.terminal.vo;

import java.io.Serializable;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;
import com.dkitec.barocle.base.IConstants;

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
@Alias("terminalVo")
public class TerminalVO extends CommonVo  implements Serializable{
	
	@Size(max=20, message="최대 20자까지 입력이 가능합니다.")
	@Pattern(regexp="^[0-9a-zA-Z]*$" , message="AP아이디는 영문자, 숫자 조합만 가능 합니다.")
	private String deviceId;
	//private String deviceModlCd = IConstants.DEVICE_MODEL_CD_TERMINAL;
	private String deviceModlCd;
	@Size(max=20, message="최대 20자까지 입력이 가능합니다.")
	private String softWareFw;
	@Size(max=20, message="최대 20자까지 입력이 가능합니다.")
	private String imageFW ;
	@Size(max=20, message="최대 20자까지 입력이 가능합니다.")
	private String voiceFW;
	private String firmwareClsCd;
	private String firmwareVersion;
	private int firmwareSeq;
	@Size(max=20, message="최대 20자까지 입력이 가능합니다.")
	private String serialNo;
	private String deviceStatusCd;
	private String bikeNo;
	
	@Size(max=20, message="최대 20자까지 입력이 가능합니다.")
	private String bikeId;
	private String tabNum = "1";
	private String deviceStatusName;
	private String regDttm;
	private String lastChkDttm;
	private String locateStrDttm;
	private String locateEndDttm;
	private String locateAdminId;
	private String locateEndAdminId;
	private String chkType;
	private String chkId;
	//바로클 고도화 2018.01 dwyoon
	private String entrpsCd;
	private String entrpsCdNm;
	
	// 단말기 표출 정보 추가(배터리상태, 대여상태, 고장상태)
	private String batteryStusCd;
	private String bikeStusCd;
	private String errStusCd;
	private String errStusCdName;
	
	public String getBatteryStusCd() {
		return batteryStusCd;
	}
	public void setBatteryStusCd(String batteryStusCd) {
		this.batteryStusCd = batteryStusCd;
	}
	public String getBikeStusCd() {
		return bikeStusCd;
	}
	public void setBikeStusCd(String bikeStusCd) {
		this.bikeStusCd = bikeStusCd;
	}
	public String getErrStusCd() {
		return errStusCd;
	}
	public void setErrStusCd(String errStusCd) {
		this.errStusCd = errStusCd;
	}
	public String getErrStusCdName() {
		return errStusCdName;
	}
	public void setErrStusCdName(String errStusCdName) {
		this.errStusCdName = errStusCdName;
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
	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
	
	public String getDeviceStatusCd() {
		return deviceStatusCd;
	}
	public void setDeviceStatusCd(String deviceStatusCd) {
		this.deviceStatusCd = deviceStatusCd;
	}
	public String getLocateAdminId() {
		return locateAdminId;
	}
	public void setLocateAdminId(String locateAdminId) {
		this.locateAdminId = locateAdminId;
	}
	public String getBikeId() {
		return bikeId;
	}
	public void setBikeId(String bikeId) {
		this.bikeId = bikeId;
	}
	public String getSoftWareFw() {
		return softWareFw;
	}
	public void setSoftWareFw(String softWareFw) {
		this.softWareFw = softWareFw;
	}
	public String getImageFW() {
		return imageFW;
	}
	public void setImageFW(String imageFW) {
		this.imageFW = imageFW;
	}
	public String getVoiceFW() {
		return voiceFW;
	}
	public void setVoiceFW(String voiceFW) {
		this.voiceFW = voiceFW;
	}
	public String getDeviceStatusName() {
		return deviceStatusName;
	}
	public void setDeviceStatusName(String deviceStatusName) {
		this.deviceStatusName = deviceStatusName;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getLocateStrDttm() {
		return locateStrDttm;
	}
	public void setLocateStrDttm(String locateStrDttm) {
		this.locateStrDttm = locateStrDttm;
	}
	public String getLocateEndDttm() {
		return locateEndDttm;
	}
	public void setLocateEndDttm(String locateEndDttm) {
		this.locateEndDttm = locateEndDttm;
	}
	public String getLocateEndAdminId() {
		return locateEndAdminId;
	}
	public void setLocateEndAdminId(String locateEndAdminId) {
		this.locateEndAdminId = locateEndAdminId;
	}
	public String getTabNum() {
		return tabNum;
	}
	public void setTabNum(String tabNum) {
		this.tabNum = tabNum;
	}
	public String getFirmwareClsCd() {
		return firmwareClsCd;
	}
	public void setFirmwareClsCd(String firmwareClsCd) {
		this.firmwareClsCd = firmwareClsCd;
	}
	public String getFirmwareVersion() {
		return firmwareVersion;
	}
	public void setFirmwareVersion(String firmwareVersion) {
		this.firmwareVersion = firmwareVersion;
	}
	public int getFirmwareSeq() {
		return firmwareSeq;
	}
	public void setFirmwareSeq(int firmwareSeq) {
		this.firmwareSeq = firmwareSeq;
	}
	public String getLastChkDttm() {
		return lastChkDttm;
	}
	public void setLastChkDttm(String lastChkDttm) {
		this.lastChkDttm = lastChkDttm;
	}
	public String getBikeNo() {
		return bikeNo;
	}
	public void setBikeNo(String bikeNo) {
		this.bikeNo = bikeNo;
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
	
	
}
