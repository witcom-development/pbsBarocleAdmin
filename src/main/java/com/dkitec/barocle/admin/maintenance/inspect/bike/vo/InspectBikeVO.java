package com.dkitec.barocle.admin.maintenance.inspect.bike.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;
import com.dkitec.barocle.util.validator.annotation.IsStringNotNullNumeric;

@SuppressWarnings("serial")
@Alias("inspectBikeVo")
public class InspectBikeVO extends CommonVo implements Serializable {

	@Size(max=10, message="자전거 아이디는 10자 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9a-zA-Z]*$" , message="자전거ID는 영문자, 숫자 조합만 가능 합니다.")
	private String bikeId;
	@Size(max=10, message="자전거 번호는 10자 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9]*$" , message="자전거No는 숫자여야만 합니다.")
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
    private String lostRegId;
    private String lostDate;
    private String bikeTotCnt;//거치대 전체수
    private String cascadeYnCnt;
    private List<String> stationSeqList;
    private List<InspectBikeVO> bikeList;
    private String repairCmptYn;
    private String repairSeq;
    private String faultSeq;
    private String reportYn;
    private String searchVal;
    
    private String bikeStatusComCd;
    
    private String teamSeq;
    
    
	public String getTeamSeq() {
		return teamSeq;
	}
	public void setTeamSeq(String teamSeq) {
		this.teamSeq = teamSeq;
	}
	public String getBikeStatusComCd() {
		return bikeStatusComCd;
	}
	public void setBikeStatusComCd(String bikeStatusComCd) {
		this.bikeStatusComCd = bikeStatusComCd;
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
	public List<InspectBikeVO> getBikeList() {
		return bikeList;
	}
	public void setBikeList(List<InspectBikeVO> bikeList) {
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
	public String getSearchVal() {
		return searchVal;
	}
	public void setSearchVal(String searchVal) {
		this.searchVal = searchVal;
	}
	
}
