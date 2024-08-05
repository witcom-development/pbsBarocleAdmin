package com.dkitec.barocle.admin.statistics.maintain.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;

@SuppressWarnings("serial")
@Alias("maintainStatisticsVo")
public class MaintainStatisticsVO extends CommonVo implements Serializable {
	private String dateType;
	private String deviceType;
	private String searchBgnMt;
	private String searchEndMt;
	private String searchBgnYe;
	private String searchEndYe;
	
	private String faultDttm;
	private String faultCnt;
	private String faultName;
	private String faultTotal;
	private String repairDttm;
	private String repairCnt;
	private String repairName;
	private String repairTotal;
	private String stateCodeCnt;
	
	public String getDateType() {
		return dateType;
	}
	public void setDateType(String dateType) {
		this.dateType = dateType;
	}
	public String getDeviceType() {
		return deviceType;
	}
	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}
	public String getSearchBgnMt() {
		return searchBgnMt;
	}
	public void setSearchBgnMt(String searchBgnMt) {
		this.searchBgnMt = searchBgnMt;
	}
	public String getSearchEndMt() {
		return searchEndMt;
	}
	public void setSearchEndMt(String searchEndMt) {
		this.searchEndMt = searchEndMt;
	}
	public String getSearchBgnYe() {
		return searchBgnYe;
	}
	public void setSearchBgnYe(String searchBgnYe) {
		this.searchBgnYe = searchBgnYe;
	}
	public String getSearchEndYe() {
		return searchEndYe;
	}
	public void setSearchEndYe(String searchEndYe) {
		this.searchEndYe = searchEndYe;
	}
	public String getFaultDttm() {
		return faultDttm;
	}
	public void setFaultDttm(String faultDttm) {
		this.faultDttm = faultDttm;
	}
	public String getFaultCnt() {
		return faultCnt;
	}
	public void setFaultCnt(String faultCnt) {
		this.faultCnt = faultCnt;
	}
	public String getFaultName() {
		return faultName;
	}
	public void setFaultName(String faultName) {
		this.faultName = faultName;
	}
	public String getFaultTotal() {
		return faultTotal;
	}
	public void setFaultTotal(String faultTotal) {
		this.faultTotal = faultTotal;
	}
	public String getRepairDttm() {
		return repairDttm;
	}
	public void setRepairDttm(String repairDttm) {
		this.repairDttm = repairDttm;
	}
	public String getRepairCnt() {
		return repairCnt;
	}
	public void setRepairCnt(String repairCnt) {
		this.repairCnt = repairCnt;
	}
	public String getRepairName() {
		return repairName;
	}
	public void setRepairName(String repairName) {
		this.repairName = repairName;
	}
	public String getRepairTotal() {
		return repairTotal;
	}
	public void setRepairTotal(String repairTotal) {
		this.repairTotal = repairTotal;
	}
	public String getStateCodeCnt() {
		return stateCodeCnt;
	}
	public void setStateCodeCnt(String stateCodeCnt) {
		this.stateCodeCnt = stateCodeCnt;
	}
}
