package com.dkitec.barocle.admin.statistics.admlogin.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;

@SuppressWarnings("serial")
@Alias("AdmloginStatisticsVo")
public class AdmloginStatisticsVO extends CommonVo implements Serializable {
	
	private String adminGrpName;
	private String adminName;
	private String adminId;
	private String loginDttm;
	private String adminType;
	private String searchName;
	
	public String getAdminGrpName() {
		return adminGrpName;
	}
	public void setAdminGrpName(String adminGrpName) {
		this.adminGrpName = adminGrpName;
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
	public String getLoginDttm() {
		return loginDttm;
	}
	public void setLoginDttm(String loginDttm) {
		this.loginDttm = loginDttm;
	}
	public String getAdminType() {
		return adminType;
	}
	public void setAdminType(String adminType) {
		this.adminType = adminType;
	}
	public String getSearchName() {
		return searchName;
	}
	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}
	
}
