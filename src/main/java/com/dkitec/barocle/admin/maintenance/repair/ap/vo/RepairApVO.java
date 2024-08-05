package com.dkitec.barocle.admin.maintenance.repair.ap.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;
import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
import com.dkitec.barocle.base.IConstants;

@SuppressWarnings("serial")
@Alias("repairApVo")
public class RepairApVO extends CommonVo implements Serializable {

	@Size(max=50, message="AP아이디는 50자 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9a-zA-Z]*$" , message="AP아이디는 영문자, 숫자 조합만 가능 합니다.")
	private String apId;
	private String adminName;
	private String deviceModlCd = IConstants.DEVICE_MODEL_CD_AP ;
	@Size(max=50, message="시리얼넘버는 50자 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9a-zA-Z]*$" , message="시리얼넘버는영문자, 숫자 조합만 가능 합니다")
	private String serialNo;
	@Size(max=12, message="IPV4는 12자 이하만 가능 합니다.")
    @Pattern(regexp="^\\d{1,3}.\\d{1,3}.\\d{1,3}.\\d{1,3}$" , message="IP 패턴과 불일치합니다.")
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
	private String repDttm;
	private String cmptDttm;
	private String histSeq;
	
	@Size(max=10, message="날짜형식이 맞지않습니다.yyyy-mm-dd")
	@Pattern(regexp="^\\d{4}-\\d{2}-\\d{2}$", message="적합하지 않은 날짜 형식입니다.")
	private String lastChkDttm;
    /** 페이징 여부 */
    @Pattern(regexp="Y|N" , message="잘못된 형식입니다.")
    private String pagingYn;
    private String chkType;
    private List<ApVO> apList;
    private String adminId;
    private String division;
    private String divisionValue;
    private String repairCmptYn;
    private String repairSeq;
    private String repairCode;
    private List<String> repairCodeList;
    private String faultSeq;
    private String moveYn;
    
    private String repairApReport;			//특이사항 추가_20161121_cms
    
    private String stationName;					// 대여소명
    private String repairReport;						// 정비내역 수기 입력
    private String regId;								// 장애 작성자
    
    
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public String getRepairReport() {
		return repairReport;
	}
	public void setRepairReport(String repairReport) {
		this.repairReport = repairReport;
	}
	public String getRepairApReport() {
		return repairApReport;
	}
	public void setRepairApReport(String repairApReport) {
		this.repairApReport = repairApReport;
	}
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
	public String getApId() {
		return apId;
	}
	public void setApId(String apId) {
		this.apId = apId;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
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
	public String getRepDttm() {
		return repDttm;
	}
	public void setRepDttm(String repDttm) {
		this.repDttm = repDttm;
	}
	public String getCmptDttm() {
		return cmptDttm;
	}
	public void setCmptDttm(String cmptDttm) {
		this.cmptDttm = cmptDttm;
	}
	public String getDeviceStatusName() {
		return deviceStatusName;
	}
	public void setDeviceStatusName(String deviceStatusName) {
		this.deviceStatusName = deviceStatusName;
	}
	public String getPagingYn() {
		return pagingYn;
	}
	public void setPagingYn(String pagingYn) {
		this.pagingYn = pagingYn;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getDivisionValue() {
		return divisionValue;
	}
	public void setDivisionValue(String divisionValue) {
		this.divisionValue = divisionValue;
	}
	public String getRepairCmptYn() {
		return repairCmptYn;
	}
	public void setRepairCmptYn(String repairCmptYn) {
		this.repairCmptYn = repairCmptYn;
	}
	public String getRepairSeq() {
		return repairSeq;
	}
	public void setRepairSeq(String repairSeq) {
		this.repairSeq = repairSeq;
	}
	public String getRepairCode() {
		return repairCode;
	}
	public void setRepairCode(String repairCode) {
		this.repairCode = repairCode;
	}
	public List<String> getRepairCodeList() {
		return repairCodeList;
	}
	public void setRepairCodeList(List<String> repairCodeList) {
		this.repairCodeList = repairCodeList;
	}
	public String getFaultSeq() {
		return faultSeq;
	}
	public void setFaultSeq(String faultSeq) {
		this.faultSeq = faultSeq;
	}
	public String getMoveYn() {
		return moveYn;
	}
	public void setMoveYn(String moveYn) {
		this.moveYn = moveYn;
	}
	public String getHistSeq() {
		return histSeq;
	}
	public void setHistSeq(String histSeq) {
		this.histSeq = histSeq;
	}
	
}
