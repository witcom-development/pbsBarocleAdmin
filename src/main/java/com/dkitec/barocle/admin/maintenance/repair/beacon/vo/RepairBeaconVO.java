package com.dkitec.barocle.admin.maintenance.repair.beacon.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("repairBeaconVo")
public class RepairBeaconVO extends CommonVo implements Serializable {

	@Size(max=20, message="거치대ID는 20자 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9a-zA-Z]*$" , message="AP아이디는 영문자, 숫자 조합만 가능 합니다.")
	private String rackId;
	private String adminName;
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String rackStatusCd;
	private String rackStatusName;
	private String chkType;
	@Size(max=20, message="날짜형식이 맞지않습니다.yyyy-mm-dd")
	@Pattern(regexp="^\\d{4}-\\d{2}-\\d{2}", message="적합하지 않은 날짜 형식입니다.")
	private String laskChkDttm;
	private String regDttm;
	private String repDttm;
	private String modDttm;
	private String cmptDttm;
	private String adminId;
	@Size(max=3, message="숫자 형식 3자리까지 입니다.")
	@Pattern(regexp="^[0-9]*" , message="숫자 형식 3자리까지 입니다.")
	private String stationEquipOrder;//거치대 설치 순서.
	private String locateStrDttm;
	private String loacteEndDttm;
    private List<RepairBeaconVO> armList;
    private String lastChkDttm;
    private String rackTotCnt;//거치대 전체수
    private String returnableCnt;
    private String cascadeRackCnt;
    private String keepBikeRackCnt;
    private String division;
    private String divisionValue;
    private String repairCmptYn;
    private String repairSeq;
    private	String repairCode;
    private List<String> repairCodeList;
    private String faultSeq;
    private String moveYn;
    private String histSeq;
    private String remainYn;

    private String BeaconReport;			//특이사항 추가_20161121_cms
    
    private String repairReport;			//특이사항 추가_20161121_cms

    private String repairClsCd;
    private String repairMain;
    
    public String getRepairMain() {
		return repairMain;
	}
	public void setRepairMain(String repairMain) {
		this.repairMain = repairMain;
	}
	public String getRepairName() {
		return repairName;
	}
	public void setRepairName(String repairName) {
		this.repairName = repairName;
	}
	public String getRepairType() {
		return repairType;
	}
	public void setRepairType(String repairType) {
		this.repairType = repairType;
	}
	private String repairName;
    private String repairType;
    
    
    public String getRepairClsCd() {
		return repairClsCd;
	}
	public void setRepairClsCd(String repairClsCd) {
		this.repairClsCd = repairClsCd;
	}
	private String stationNo;
    public String getStationNo() {
		return stationNo;
	}
	public void setStationNo(String stationNo) {
		this.stationNo = stationNo;
	}
	private String stationId;
    private String stationName;
    
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
	
	
	public String getRepairReport() {
		return repairReport;
	}
	public void setRepairReport(String repairReport) {
		this.repairReport = repairReport;
	}
	public String getBeaconReport() {
		return BeaconReport;
	}
	public void setBeaconReport(String BeaconReport) {
		this.BeaconReport = BeaconReport;
	}
	public String getChkType() {
		return chkType;
	}
	public void setChkType(String chkType) {
		this.chkType = chkType;
	}
	public String getRackId() {
		return rackId;
	}
	public void setRackId(String rackId) {
		this.rackId = rackId;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getRackStatusCd() {
		return rackStatusCd;
	}
	public void setRackStatusCd(String rackStatusCd) {
		this.rackStatusCd = rackStatusCd;
	}
	public String getLaskChkDttm() {
		return laskChkDttm;
	}
	public void setLaskChkDttm(String laskChkDttm) {
		this.laskChkDttm = laskChkDttm;
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
	public String getCmptDttm() {
		return cmptDttm;
	}
	public void setCmptDttm(String cmptDttm) {
		this.cmptDttm = cmptDttm;
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
	public String getRackStatusName() {
		return rackStatusName;
	}
	public void setRackStatusName(String rackStatusName) {
		this.rackStatusName = rackStatusName;
	}
	public String getLastChkDttm() {
		return lastChkDttm;
	}
	public void setLastChkDttm(String lastChkDttm) {
		this.lastChkDttm = lastChkDttm;
	}
	public List<RepairBeaconVO> getArmList() {
		return armList;
	}
	public void setArmList(List<RepairBeaconVO> armList) {
		this.armList = armList;
	}
	public String getRackTotCnt() {
		return rackTotCnt;
	}
	public void setRackTotCnt(String rackTotCnt) {
		this.rackTotCnt = rackTotCnt;
	}
	public String getReturnableCnt() {
		return returnableCnt;
	}
	public void setReturnableCnt(String returnableCnt) {
		this.returnableCnt = returnableCnt;
	}
	public String getCascadeRackCnt() {
		return cascadeRackCnt;
	}
	public void setCascadeRackCnt(String cascadeRackCnt) {
		this.cascadeRackCnt = cascadeRackCnt;
	}
	public String getKeepBikeRackCnt() {
		return keepBikeRackCnt;
	}
	public void setKeepBikeRackCnt(String keepBikeRackCnt) {
		this.keepBikeRackCnt = keepBikeRackCnt;
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
	public String getRemainYn() {
		return remainYn;
	}
	public void setRemainYn(String remainYn) {
		this.remainYn = remainYn;
	}
}
