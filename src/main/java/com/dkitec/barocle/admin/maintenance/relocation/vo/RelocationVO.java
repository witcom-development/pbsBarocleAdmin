package com.dkitec.barocle.admin.maintenance.relocation.vo;

import java.io.Serializable;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;
import com.dkitec.barocle.util.validator.annotation.IsStringNotNullNumeric;

@SuppressWarnings("serial")
@Alias("relocationVo")
public class RelocationVO extends CommonVo implements Serializable {
	private String stationGrp;
	private String stationName;
	private String rockCnt;
	private String returnableCnt;
	private String cascadeRackCnt;
	private String bikeTotCnt;
	
	// 20210713 재배치 대여소 목록용
	public String getMoveCnt() {
		return moveCnt;
	}
	public void setMoveCnt(String moveCnt) {
		this.moveCnt = moveCnt;
	}
	public String getRelocateCnt() {
		return relocateCnt;
	}
	public void setRelocateCnt(String relocateCnt) {
		this.relocateCnt = relocateCnt;
	}
	private String moveCnt;
	private String relocateCnt;
	
	// 20210713 재배치 대여소 목록용 end
	
	private String adminName;
    private String adminId;
    private String adminPhone;
    private String adminEmail;
    
    private String searchType;
    private String searchValue;
    private String adminType;
    private String adminTypeName;
    
    private String relocateStrDttm;
    private String relocateEndDttm;
	
    /** 페이징 여부 */
    @Pattern(regexp="Y|N" , message="잘못된 형식입니다.")
    private String pagingYn;
    private String chkType;
    private String relocationCmptYn;
    @Size(max=3, message="숫자 3자리까지 입니다.")
    @IsStringNotNullNumeric(message="숫자 3자리까지 입니다.")
	private String stationEquipOrder;
	private String stationGrpSeq;
	private String stationId;
    private String bikeNo;
    private String threshold;
    private String thresholdHigh;
    private String thresholdLow;
    private String thresholdValue;
    private String sortType;
    private String sortValue;
    
    private String viewType;
    private String fromStationName;
    private String fromStationEquipOrder;
    private String moveagnAdmin;
    private String toSationName;
    private String toStationEquipOrder;
    private String relocationAdmin;
    
	public String getStationGrp() {
		return stationGrp;
	}
	public void setStationGrp(String stationGrp) {
		this.stationGrp = stationGrp;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public String getRockCnt() {
		return rockCnt;
	}
	public void setRockCnt(String rockCnt) {
		this.rockCnt = rockCnt;
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
	public String getBikeTotCnt() {
		return bikeTotCnt;
	}
	public void setBikeTotCnt(String bikeTotCnt) {
		this.bikeTotCnt = bikeTotCnt;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminPhone() {
		return adminPhone;
	}
	public void setAdminPhone(String adminPhone) {
		this.adminPhone = adminPhone;
	}
	public String getAdminEmail() {
		return adminEmail;
	}
	public void setAdminEmail(String adminEmail) {
		this.adminEmail = adminEmail;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	public String getAdminType() {
		return adminType;
	}
	public void setAdminType(String adminType) {
		this.adminType = adminType;
	}
	public String getAdminTypeName() {
		return adminTypeName;
	}
	public void setAdminTypeName(String adminTypeName) {
		this.adminTypeName = adminTypeName;
	}
	public String getRelocateStrDttm() {
		return relocateStrDttm;
	}
	public void setRelocateStrDttm(String relocateStrDttm) {
		this.relocateStrDttm = relocateStrDttm;
	}
	public String getRelocateEndDttm() {
		return relocateEndDttm;
	}
	public void setRelocateEndDttm(String relocateEndDttm) {
		this.relocateEndDttm = relocateEndDttm;
	}
	public String getPagingYn() {
		return pagingYn;
	}
	public void setPagingYn(String pagingYn) {
		this.pagingYn = pagingYn;
	}
	public String getChkType() {
		return chkType;
	}
	public void setChkType(String chkType) {
		this.chkType = chkType;
	}
	public String getRelocationCmptYn() {
		return relocationCmptYn;
	}
	public void setRelocationCmptYn(String relocationCmptYn) {
		this.relocationCmptYn = relocationCmptYn;
	}
	public String getStationEquipOrder() {
		return stationEquipOrder;
	}
	public void setStationEquipOrder(String stationEquipOrder) {
		this.stationEquipOrder = stationEquipOrder;
	}
	public String getBikeNo() {
		return bikeNo;
	}
	public String getStationGrpSeq() {
		return stationGrpSeq;
	}
	public void setStationGrpSeq(String stationGrpSeq) {
		this.stationGrpSeq = stationGrpSeq;
	}
	public String getStationId() {
		return stationId;
	}
	public void setStationId(String stationId) {
		this.stationId = stationId;
	}
	public void setBikeNo(String bikeNo) {
		this.bikeNo = bikeNo;
	}
	public String getThreshold() {
		return threshold;
	}
	public void setThreshold(String threshold) {
		this.threshold = threshold;
	}
	public String getThresholdHigh() {
		return thresholdHigh;
	}
	public void setThresholdHigh(String thresholdHigh) {
		this.thresholdHigh = thresholdHigh;
	}
	public String getThresholdLow() {
		return thresholdLow;
	}
	public void setThresholdLow(String thresholdLow) {
		this.thresholdLow = thresholdLow;
	}
	public String getThresholdValue() {
		return thresholdValue;
	}
	public void setThresholdValue(String thresholdValue) {
		this.thresholdValue = thresholdValue;
	}
	public String getSortType() {
		return sortType;
	}
	public void setSortType(String sortType) {
		this.sortType = sortType;
	}
	public String getSortValue() {
		return sortValue;
	}
	public void setSortValue(String sortValue) {
		this.sortValue = sortValue;
	}
	public String getViewType() {
		return viewType;
	}
	public void setViewType(String viewType) {
		this.viewType = viewType;
	}
	public String getFromStationName() {
		return fromStationName;
	}
	public void setFromStationName(String fromStationName) {
		this.fromStationName = fromStationName;
	}
	public String getFromStationEquipOrder() {
		return fromStationEquipOrder;
	}
	public void setFromStationEquipOrder(String fromStationEquipOrder) {
		this.fromStationEquipOrder = fromStationEquipOrder;
	}
	public String getMoveagnAdmin() {
		return moveagnAdmin;
	}
	public void setMoveagnAdmin(String moveagnAdmin) {
		this.moveagnAdmin = moveagnAdmin;
	}
	public String getToSationName() {
		return toSationName;
	}
	public void setToSationName(String toSationName) {
		this.toSationName = toSationName;
	}
	public String getToStationEquipOrder() {
		return toStationEquipOrder;
	}
	public void setToStationEquipOrder(String toStationEquipOrder) {
		this.toStationEquipOrder = toStationEquipOrder;
	}
	public String getRelocationAdmin() {
		return relocationAdmin;
	}
	public void setRelocationAdmin(String relocationAdmin) {
		this.relocationAdmin = relocationAdmin;
	}
}
