package com.dkitec.barocle.admin.manage.relocationcar.vo;

import javax.validation.GroupSequence;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.center.vo.CenterVO;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.IsNumeric;
import com.dkitec.barocle.util.validator.annotation.SearchDate;

@Alias("relocationCarVO")
@SearchDate(groups=PagingVO.SearchDateValidator.class)
public class RelocationCarVO extends CenterVO implements java.io.Serializable {
	
	private static final long serialVersionUID = 7806575755211149967L;
	
	@CheckValue(message="PK 값이 존재하지 않습니다.",groups={RelocationCarDelete.class})
	private String relocateCarID;
	@CheckValue(message="소속 센터를 선택해 주세요.",groups={RelocationCarInsert.class,RelocationCarUpdate.class})
	private String assignCenterID;
	@CheckValue(message="차종을 입력해 주세요",groups={RelocationCarInsert.class,RelocationCarUpdate.class})
	private String carModlName;
	@CheckValue(message="자량 번호를 입력해 주세요.",groups={RelocationCarInsert.class,RelocationCarUpdate.class})
	private String carNO;
	private String carModlyyYYMM;
	@CheckValue(message="차량 연식을 입력해 주세요.",groups={RelocationCarInsert.class,RelocationCarUpdate.class})
	private String carModlyyYYMM1;
	@CheckValue(message="라향 연식을 선택해 주세요.",groups={RelocationCarInsert.class,RelocationCarUpdate.class})
	private String carModlyyYYMM2;
	@CheckValue(message="사용여부를 선택해 주세요.",groups={RelocationCarInsert.class,RelocationCarUpdate.class})
	private String carUseYN;
	@IsNumeric(groups={RelocationCarInsert.class,RelocationCarUpdate.class})
	private int rackCnt;
	private long nowLocLatitude;
	private long nowLocLongitude;
	@CheckValue(message="GPS 단말기 S/N을 입력해 주세요.",groups={RelocationCarInsert.class,RelocationCarUpdate.class})
	private String gPSTerminalSerialNO;
	private java.util.Date regDttm;
	private String regID;
	private java.util.Date modDttm;
	private String modID;
	private java.util.Date locInfoModDttm;
	private String carDesc;
	private String teamSeq;
	private String teamName;
	
	public RelocationCarVO(){
		this.carUseYN = "Y";
	}
	
	
	public String getRelocateCarID() {
		return relocateCarID;
	}

	public void setRelocateCarID(String relocateCarID) {
		this.relocateCarID = relocateCarID;
	}

	public String getAssignCenterID() {
		return assignCenterID;
	}

	public void setAssignCenterID(String assignCenterID) {
		this.assignCenterID = assignCenterID;
	}

	public String getCarModlName() {
		return carModlName;
	}

	public void setCarModlName(String carModlName) {
		this.carModlName = carModlName;
	}

	public String getCarNO() {
		return carNO;
	}

	public void setCarNO(String carNO) {
		this.carNO = carNO;
	}

	public String getCarModlyyYYMM() {
		return carModlyyYYMM;
	}

	public void setCarModlyyYYMM(String carModlyyYYMM) {
		this.carModlyyYYMM = carModlyyYYMM;
	}

	public String getCarModlyyYYMM1() {
		return carModlyyYYMM1;
	}

	public void setCarModlyyYYMM1(String carModlyyYYMM1) {
		this.carModlyyYYMM1 = carModlyyYYMM1;
	}

	public String getCarModlyyYYMM2() {
		return carModlyyYYMM2;
	}

	public void setCarModlyyYYMM2(String carModlyyYYMM2) {
		this.carModlyyYYMM2 = carModlyyYYMM2;
	}

	public String getCarUseYN() {
		return carUseYN;
	}

	public void setCarUseYN(String carUseYN) {
		this.carUseYN = carUseYN;
	}

	public int getRackCnt() {
		return rackCnt;
	}

	public void setRackCnt(int rackCnt) {
		this.rackCnt = rackCnt;
	}

	public long getNowLocLatitude() {
		return nowLocLatitude;
	}

	public void setNowLocLatitude(long nowLocLatitude) {
		this.nowLocLatitude = nowLocLatitude;
	}

	public long getNowLocLongitude() {
		return nowLocLongitude;
	}

	public void setNowLocLongitude(long nowLocLongitude) {
		this.nowLocLongitude = nowLocLongitude;
	}
	
	public String getgPSTerminalSerialNO() {
		return gPSTerminalSerialNO;
	}
	
	public void setgPSTerminalSerialNO(String gPSTerminalSerialNO) {
		this.gPSTerminalSerialNO = gPSTerminalSerialNO;
	}
	
	public java.util.Date getRegDttm() {
		return regDttm;
	}

	public void setRegDttm(java.util.Date regDttm) {
		this.regDttm = regDttm;
	}

	public String getRegID() {
		return regID;
	}

	public void setRegID(String regID) {
		this.regID = regID;
	}

	public java.util.Date getModDttm() {
		return modDttm;
	}

	public void setModDttm(java.util.Date modDttm) {
		this.modDttm = modDttm;
	}

	public String getModID() {
		return modID;
	}

	public void setModID(String modID) {
		this.modID = modID;
	}
	
	public java.util.Date getLocInfoModDttm() {
		return locInfoModDttm;
	}

	public void setLocInfoModDttm(java.util.Date locInfoModDttm) {
		this.locInfoModDttm = locInfoModDttm;
	}

	public String getCarDesc() {
		return carDesc;
	}

	public void setCarDesc(String carDesc) {
		this.carDesc = carDesc;
	}
	
	
	public String getTeamSeq() {
		return teamSeq;
	}

	public void setTeamSeq(String teamSeq) {
		this.teamSeq = teamSeq;
	}
	
	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	
	@Override
	public String toString() {
		return "RelocationCarVO [relocateCarID=" + relocateCarID
				+ ", assignCenterID=" + assignCenterID + ", carModlName="
				+ carModlName + ", carNO=" + carNO + ", carModlyyYYMM="
				+ carModlyyYYMM + ", carModlyyYYMM1=" + carModlyyYYMM1
				+ ", carModlyyYYMM2=" + carModlyyYYMM2 + ", carUseYN="
				+ carUseYN + ", rackCnt=" + rackCnt + ", nowLocLatitude="
				+ nowLocLatitude + ", nowLocLongitude=" + nowLocLongitude
				+ ", gPSTerminalSerialNO=" + gPSTerminalSerialNO + ", regDttm="
				+ regDttm + ", regID=" + regID + ", modDttm=" + modDttm
				+ ", modID=" + modID + ", locInfoModDttm=" + locInfoModDttm
				+ ", carDesc=" + carDesc + ", getCenterID()=" + getCenterID()
				+ ", getCenterClsCD()=" + getCenterClsCD()
				+ ", getDistrictCD()=" + getDistrictCD() + ", getCenterName()="
				+ getCenterName() + ", getCenterTelNO()=" + getCenterTelNO()
				+ ", getCenterTelNO1()=" + getCenterTelNO1()
				+ ", getCenterTelNO2()=" + getCenterTelNO2()
				+ ", getCenterTelNO3()=" + getCenterTelNO3()
				+ ", getOprStrTime()=" + getOprStrTime()
				+ ", getOprStrTime1()=" + getOprStrTime1()
				+ ", getOprStrTime2()=" + getOprStrTime2()
				+ ", getOprEndTime()=" + getOprEndTime()
				+ ", getOprEndTime1()=" + getOprEndTime1()
				+ ", getOprEndTime2()=" + getOprEndTime2()
				+ ", getChargerName()=" + getChargerName()
				+ ", getCenterPostNO()=" + getCenterPostNO()
				+ ", getCenterAddr1()=" + getCenterAddr1()
				+ ", getCenterAddr2()=" + getCenterAddr2()
				+ ", getCenterLatitude()=" + getCenterLatitude()
				+ ", getCenterLongitude()=" + getCenterLongitude()
				+ ", getCenterDesc()=" + getCenterDesc()
				+ ", getCenterGubun()=" + getCenterGubun() + ", getCenterGu()="
				+ getCenterGu() + ", getModName()=" + getModName()
				+ ", getTeamSeq()=" + getTeamSeq()
				+ ", getTeamName()=" + getTeamName()
				+ ", toString()=" + super.toString() + ", getCurrentPageNo()="
				+ getCurrentPageNo() + ", getRecordCountPerPage()="
				+ getRecordCountPerPage() + ", getPageSize()=" + getPageSize()
				+ ", getTotalRecordCount()=" + getTotalRecordCount()
				+ ", getFirstRecordIndex()=" + getFirstRecordIndex()
				+ ", getSearchValue()=" + getSearchValue()
				+ ", getSearchParameter()=" + getSearchParameter()
				+ ", getSearchDate()=" + getSearchDate()
				+ ", getSearchStartDate()=" + getSearchStartDate()
				+ ", getSearchEndDate()=" + getSearchEndDate() + ", getMode()="
				+ getMode() + ", getClass()=" + getClass() + ", hashCode()="
				+ hashCode() + "]";
	}
	
	private interface RelocationCarList{}
	private interface RelocationCarEdit{}
	private interface RelocationCarInsert{}
	private interface RelocationCarUpdate{}
	private interface RelocationCarDelete{}
	
	@GroupSequence({RelocationCarList.class})
	public static interface RelocationCarListVal{}
	
	@GroupSequence({RelocationCarEdit.class})
	public static interface RelocationCarEditVal{}
	
	@GroupSequence({GetMode.class,RelocationCarInsert.class,RelocationCarUpdate.class})
	public static interface RelocationCarPersistVal{}
	
	@GroupSequence({GetMode.class,RelocationCarDelete.class})
	public static interface RelocationCarDeleteVal{}

}
