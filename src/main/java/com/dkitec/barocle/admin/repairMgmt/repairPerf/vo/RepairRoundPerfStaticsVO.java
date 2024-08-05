package com.dkitec.barocle.admin.repairMgmt.repairPerf.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("repairRoundPerfStaticsVO")
public class RepairRoundPerfStaticsVO extends CommonVo implements Serializable {
	 
	public String getR01() {
		return R01;
	}
	public void setR01(String r01) {
		R01 = r01;
	}
	public String getR02() {
		return R02;
	}
	public void setR02(String r02) {
		R02 = r02;
	}
	public String getR03() {
		return R03;
	}
	public void setR03(String r03) {
		R03 = r03;
	}
	public String getR04() {
		return R04;
	}
	public void setR04(String r04) {
		R04 = r04;
	}
	public String getR05() {
		return R05;
	}
	public void setR05(String r05) {
		R05 = r05;
	}
	public String getR06() {
		return R06;
	}
	public void setR06(String r06) {
		R06 = r06;
	}
	 
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	
	private String centerName;
	
	public String getCenterName() {
		return centerName;
	}
	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}
	
	private String stationName;
	private String R01;
	private String R02;
	private String R03;
	private String R04;
	private String R05;
	private String R06;
	private String tot;
	private String stationCnt;
	public String getStationCnt() {
		return stationCnt;
	}
	public void setStationCnt(String stationCnt) {
		this.stationCnt = stationCnt;
	}
	public String getTot() {
		return tot;
	}
	public void setTot(String tot) {
		this.tot = tot;
	}

	private String adminName;
	
}
