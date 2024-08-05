package com.dkitec.barocle.admin.repairBikeMall.repairBike.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("repairTnsBikeVo")
public class RepairTnsBikeVo extends CommonVo implements Serializable {
	
	private String regDttm;
	private String centerName;
	private String repairCnt;
	private String totPrice;
	private String mpnNo;
	private String months;
	private String sendDttm;
	
	// 회수 요청 문자 관련 변수
	private String msg;
	private String adminId;
	private String districtCd;
	
	public String getSendDttm() {
		return sendDttm;
	}
	public void setSendDttm(String sendDttm) {
		this.sendDttm = sendDttm;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getDistrictCd() {
		return districtCd;
	}
	public void setDistrictCd(String districtCd) {
		this.districtCd = districtCd;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getMonths() {
		return months;
	}
	public void setMonths(String months) {
		this.months = months;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getCenterName() {
		return centerName;
	}
	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}
	public String getRepairCnt() {
		return repairCnt;
	}
	public void setRepairCnt(String repairCnt) {
		this.repairCnt = repairCnt;
	}
	public String getTotPrice() {
		return totPrice;
	}
	public void setTotPrice(String totPrice) {
		this.totPrice = totPrice;
	}
	public String getMpnNo() {
		return mpnNo;
	}
	public void setMpnNo(String mpnNo) {
		this.mpnNo = mpnNo;
	}

}
