package com.dkitec.barocle.admin.repairMgmt.repairPerf.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("repairRoundPerfVO")
public class RepairRoundPerfVO extends CommonVo implements Serializable {
	
	private String stationName;
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
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
	private String regDttm;
	private String repairMain;
	private String repairName;
	private String repairType;  
	private String adminName;
	private String centerName;
	
	public String getCenterName() {
		return centerName;
	}
	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}  

	
	public String getSearchAdmin() {
		return searchAdmin;
	}
	public void setSearchAdmin(String searchAdmin) {
		this.searchAdmin = searchAdmin;
	}
	public String getSearchCenter() {
		return searchCenter;
	}
	public void setSearchCenter(String searchCenter) {
		this.searchCenter = searchCenter;
	}
	private String searchAdmin;
	private String searchCenter;
	
}
