package com.dkitec.barocle.admin.maintenance.inspect.lock.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;

@SuppressWarnings("serial")
@Alias("inspectLockVo")
public class InspectLockVO extends CommonVo implements Serializable {

	@Size(max=20, message="거치대ID는 20자 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9a-zA-Z]*$" , message="AP아이디는 영문자, 숫자 조합만 가능 합니다.")
	private String rackId;
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String rackStatusCd;
	private String rackStatusName;
	private String chkType;
	@Size(max=20, message="날짜형식이 맞지않습니다.yyyy-mm-dd")
	@Pattern(regexp="^\\d{4}-\\d{2}-\\d{2}", message="적합하지 않은 날짜 형식입니다.")
	private String laskChkDttm;
	private String regDttm;
	private String modDttm;
	private String adminId;
	@Size(max=3, message="숫자 형식 3자리까지 입니다.")
	@Pattern(regexp="^[0-9]*" , message="숫자 형식 3자리까지 입니다.")
	private String stationEquipOrder;//거치대 설치 순서.
	private String locateStrDttm;
	private String loacteEndDttm;
    private List<String> StationIdList;
    private List<InspectLockVO> armList;
    private String lastChkDttm;
    private String rackTotCnt;//거치대 전체수
    private String returnableCnt;
    private String cascadeRackCnt;
    private String keepBikeRackCnt;
    private String repairCmptYn;
    private String repairSeq;
    private String faultSeq;
    private String reportYn;
    
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
	
	public List<String> getStationIdList() {
		return StationIdList;
	}
	public void setStationIdList(List<String> stationIdList) {
		StationIdList = stationIdList;
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
	public List<InspectLockVO> getArmList() {
		return armList;
	}
	public void setArmList(List<InspectLockVO> armList) {
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
	public String getFaultSeq() {
		return faultSeq;
	}
	public void setFaultSeq(String faultSeq) {
		this.faultSeq = faultSeq;
	}
	public String getReportYn() {
		return reportYn;
	}
	public void setReportYn(String reportYn) {
		this.reportYn = reportYn;
	}
	
}
