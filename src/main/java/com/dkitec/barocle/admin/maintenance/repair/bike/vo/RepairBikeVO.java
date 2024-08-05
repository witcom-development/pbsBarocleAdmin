package com.dkitec.barocle.admin.maintenance.repair.bike.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;
import com.dkitec.barocle.util.validator.annotation.IsStringNotNullNumeric;

@SuppressWarnings("serial")
@Alias("repairBikeVo")
public class RepairBikeVO extends CommonVo implements Serializable {

	@Size(max=10, message="자전거 아이디는 10자 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9a-zA-Z]*$" , message="자전거ID는 영문자, 숫자 조합만 가능 합니다.")
	private String bikeId;
	private String adminName;
	@Size(max=10, message="자전거 번호는 10자 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9]*$" , message="자전거No는 숫자여야만 합니다.")
	private String bikeNo;
	private String rackId;
	private String bikeStatusCd;
	private String bikeStatusName;
	private String repDttm;
	private String cmptDttm;
	private String adminId;
	@Size(max=3, message="숫자 3자리까지 입니다.")
    @IsStringNotNullNumeric(message="숫자 3자리까지 입니다.")
    private String division;
    private String divisionValue;
    private String repairCmptYn;
    private String repairSeq;
    private	String repairCode;
    private List<String> repairCodeList;
    private String partsData;
    private String modifyPartsData;
    private String modId;
    private String faultSeq;
    private String moveYn;
    private String histSeq;
    
    private String bikeReport;			//특이사항 추가_20161121_cms
    private String repairReport;		// 정비내역 수기입력 추가 2018.02.27
    private String bikeStusCd;
    private String bikeStatusComCd;
    
    private String centerName;
    private String centerClsCd;			//센터 구분 코드 추가 2020.10.20
    
    @Size(max=1)
    private String onlyMyListYn;		//내 목록만 보기 추가 2020.07.13
    
    private String entrpsCd;			//자전거 납품처 추가 2020.07.13
    
    private String batReplaceTime;		//배터리 교체일자 추가 2020.10.06
    private String bfBatStat;			//배터리 변경 전 상태 추가 2020.10.14
    private String afBatStat;			//배터리 변경 후 상태 추가 2020.10.14
    
    @Size(max=1)
    private String editRepairYn;		//당일건은 수리완료이라도 수리 가능하게 2020.08.21
    
	public String getCenterName() {
		return centerName;
	}
	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}
	public String getBikeStatusComCd() {
		return bikeStatusComCd;
	}
	public void setBikeStatusComCd(String bikeStatusComCd) {
		this.bikeStatusComCd = bikeStatusComCd;
	}
	public String getBikeStusCd() {
		return bikeStusCd;
	}
	public void setBikeStusCd(String bikeStusCd) {
		this.bikeStusCd = bikeStusCd;
	}
	public String getRepairReport() {
		return repairReport;
	}
	public void setRepairReport(String repairReport) {
		this.repairReport = repairReport;
	}
	public String getBikeReport() {
		return bikeReport;
	}
	public void setBikeReport(String bikeReport) {
		this.bikeReport = bikeReport;
	}
	public String getBikeId() {
		return bikeId;
	}
	public void setBikeId(String bikeId) {
		this.bikeId = bikeId;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getRackId() {
		return rackId;
	}
	public void setRackId(String rackId) {
		this.rackId = rackId;
	}
	public String getBikeStatusCd() {
		return bikeStatusCd;
	}
	public void setBikeStatusCd(String bikeStatusCd) {
		this.bikeStatusCd = bikeStatusCd;
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
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getBikeNo() {
		return bikeNo;
	}
	public void setBikeNo(String bikeNo) {
		this.bikeNo = bikeNo;
	}
	public String getBikeStatusName() {
		return bikeStatusName;
	}
	public void setBikeStatusName(String bikeStatusName) {
		this.bikeStatusName = bikeStatusName;
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
	public String getPartsData() {
		return partsData;
	}
	public void setPartsData(String partsData) {
		this.partsData = partsData;
	}
	public String getModifyPartsData() {
		return modifyPartsData;
	}
	public void setModifyPartsData(String modifyPartsData) {
		this.modifyPartsData = modifyPartsData;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
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
	public String getOnlyMyListYn() {
		return onlyMyListYn;
	}
	public void setOnlyMyListYn(String onlyMyListYn) {
		this.onlyMyListYn = onlyMyListYn;
	}
	public String getEntrpsCd() {
		return entrpsCd;
	}
	public void setEntrpsCd(String entrpsCd) {
		this.entrpsCd = entrpsCd;
	}
	public String getEditRepairYn() {
		return editRepairYn;
	}
	public void setEditRepairYn(String editRepairYn) {
		this.editRepairYn = editRepairYn;
	}
	public String getBatReplaceTime() {
		return batReplaceTime;
	}
	public void setBatReplaceTime(String batReplaceTime) {
		this.batReplaceTime = batReplaceTime;
	}
	public String getBfBatStat() {
		return bfBatStat;
	}
	public void setBfBatStat(String bfBatStat) {
		this.bfBatStat = bfBatStat;
	}
	public String getAfBatStat() {
		return afBatStat;
	}
	public void setAfBatStat(String afBatStat) {
		this.afBatStat = afBatStat;
	}
	public String getCenterClsCd() {
		return centerClsCd;
	}
	public void setCenterClsCd(String centerClsCd) {
		this.centerClsCd = centerClsCd;
	}
	
}
