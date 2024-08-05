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
package com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo;

import java.io.Serializable;
import java.util.List;

import javax.swing.Icon;
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
@Alias("apVo")
public class ApVO extends CommonVo implements Serializable{

	@Size(max=50, message="AP아이디는 50자 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9a-zA-Z]*$" , message="AP아이디는 영문자, 숫자 조합만 가능 합니다.")
	private String deviceId;
	private String deviceModlCd = IConstants.DEVICE_MODEL_CD_AP ;
	@Size(max=50, message="시리얼넘버는 50자 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9a-zA-Z]*$" , message="시리얼넘버는영문자, 숫자 조합만 가능 합니다")
	private String serialNo;

	@Size(max=15, message="IPV4는 12자 이하만 가능 합니다.")
	private String ipV4;
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String deviceStatusCd;
	private String deviceStatusName;
	private String locateAdminId;
	@Size(max=20, message="자전거 ID는 20자 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9a-zA-Z]*$" , message="자전거 ID는 영문자, 숫자 조합만 가능 합니다.")
	private String bikeId;
	private String regDttm;
	@Size(max=10, message="날짜형식이 맞지않습니다.yyyy-mm-dd")
	@Pattern(regexp="^\\d{4}-\\d{2}-\\d{2}$", message="적합하지 않은 날짜 형식입니다.")
	private String lastChkDttm;
    private List<String> stationIdList;
    private List<ApVO> apList;
    private String adminId;
    private String chkType;
    private String chkId;
   //바로클 고도화 2018.01 dwyoon
    private String entrpsCd;
    private String entrpsCdNm;
    
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getLastChkDttm() {
		return lastChkDttm;
	}
	public void setLastChkDttm(String lastChkDttm) {
		this.lastChkDttm = lastChkDttm;
	}
	public String getChkType() {
		return chkType;
	}
	public void setChkType(String chkType) {
		this.chkType = chkType;
	}
	public List<ApVO> getApList() {
		return apList;
	}
	public void setApList(List<ApVO> apList) {
		this.apList = apList;
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
	
	public String getIpV4() {
		return ipV4;
	}
	public void setIpV4(String ipV4) {
		this.ipV4 = ipV4;
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
	
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	
	public String getDeviceStatusName() {
		return deviceStatusName;
	}
	public void setDeviceStatusName(String deviceStatusName) {
		this.deviceStatusName = deviceStatusName;
	}
	public List<String> getStationIdList() {
		return stationIdList;
	}
	public void setStationIdList(List<String> stationIdList) {
		this.stationIdList = stationIdList;
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
