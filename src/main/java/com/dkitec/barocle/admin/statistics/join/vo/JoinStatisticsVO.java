package com.dkitec.barocle.admin.statistics.join.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;

@SuppressWarnings("serial")
@Alias("JoinStatisticsVo")
public class JoinStatisticsVO extends CommonVo implements Serializable {
	private String userType;
	private String userGender;
	private String totAge10;
	private String totAge20;
	private String totAge30;
	private String totAge40;
	private String totAge50;
	private String totAge60;
	private String totAge70;
	private String totEtc;
	private String totAgeTotal;
	private String searchAge10;
	private String searchAge20;
	private String searchAge30;
	private String searchAge40;
	private String searchAge50;
	public String getTotEtc() {
		return totEtc;
	}
	public void setTotEtc(String totEtc) {
		this.totEtc = totEtc;
	}
	public String getSearchEtc() {
		return searchEtc;
	}
	public void setSearchEtc(String searchEtc) {
		this.searchEtc = searchEtc;
	}
	private String searchAge60;
	private String searchAge70;
	private String searchEtc;
	private String searchAgeTotal;
	
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public String getTotAge10() {
		return totAge10;
	}
	public void setTotAge10(String totAge10) {
		this.totAge10 = totAge10;
	}
	public String getTotAge20() {
		return totAge20;
	}
	public void setTotAge20(String totAge20) {
		this.totAge20 = totAge20;
	}
	public String getTotAge30() {
		return totAge30;
	}
	public void setTotAge30(String totAge30) {
		this.totAge30 = totAge30;
	}
	public String getTotAge40() {
		return totAge40;
	}
	public void setTotAge40(String totAge40) {
		this.totAge40 = totAge40;
	}
	public String getTotAge50() {
		return totAge50;
	}
	public void setTotAge50(String totAge50) {
		this.totAge50 = totAge50;
	}
	public String getTotAge60() {
		return totAge60;
	}
	public void setTotAge60(String totAge60) {
		this.totAge60 = totAge60;
	}
	public String getTotAge70() {
		return totAge70;
	}
	public void setTotAge70(String totAge70) {
		this.totAge70 = totAge70;
	}
	public String getTotAgeTotal() {
		return totAgeTotal;
	}
	public void setTotAgeTotal(String totAgeTotal) {
		this.totAgeTotal = totAgeTotal;
	}
	public String getSearchAge10() {
		return searchAge10;
	}
	public void setSearchAge10(String searchAge10) {
		this.searchAge10 = searchAge10;
	}
	public String getSearchAge20() {
		return searchAge20;
	}
	public void setSearchAge20(String searchAge20) {
		this.searchAge20 = searchAge20;
	}
	public String getSearchAge30() {
		return searchAge30;
	}
	public void setSearchAge30(String searchAge30) {
		this.searchAge30 = searchAge30;
	}
	public String getSearchAge40() {
		return searchAge40;
	}
	public void setSearchAge40(String searchAge40) {
		this.searchAge40 = searchAge40;
	}
	public String getSearchAge50() {
		return searchAge50;
	}
	public void setSearchAge50(String searchAge50) {
		this.searchAge50 = searchAge50;
	}
	public String getSearchAge60() {
		return searchAge60;
	}
	public void setSearchAge60(String searchAge60) {
		this.searchAge60 = searchAge60;
	}
	public String getSearchAge70() {
		return searchAge70;
	}
	public void setSearchAge70(String searchAge70) {
		this.searchAge70 = searchAge70;
	}
	public String getSearchAgeTotal() {
		return searchAgeTotal;
	}
	public void setSearchAgeTotal(String searchAgeTotal) {
		this.searchAgeTotal = searchAgeTotal;
	}
}
