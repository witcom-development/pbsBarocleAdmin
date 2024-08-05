package com.dkitec.barocle.admin.maintenance.distMgmt.distAction.vo;
import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("distActionVo")
public class DistActionVO extends CommonVo implements Serializable{
	
	/* TB_SYS_DIST_ACT_INFO */
	private String actSeq;		//일련번호
	private String actType;		//행위타입(A-현장조치, B-입고처리)
	private String actDate;		//행위날짜
	private String actBatYn;	//배치 처리여부
	private String bikeRepairYn;//자전거 수리 여부
	private String regDttm;		//등록 일시
	private String regId;		//등록자 ID
	private String modDttm;		//수정 일시
	private String modId;		//수정자 ID
	
	private String follow;
	
	public String getFollow() {
		return follow;
	}
	public void setFollow(String follow) {
		this.follow = follow;
	}
	/* TB_SYS_DIST_ACT_DTL */
	private String dtlSeq;		//일련번호
	private String tableName;	//처리해야할 테이블 이름
	private String actDesc;		//추가 입력사항
	
	private String adminId;
	private String actBikeId;
	private String bikeNo;
	private String bikeStusCd;
	private String faultSeq;
	private String latitude;
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	private String longitude;
	private String addr;
	
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getActBikeId() {
		return actBikeId;
	}
	public void setActBikeId(String actBikeId) {
		this.actBikeId = actBikeId;
	}
	
	public String getBikeNo() {
		return bikeNo;
	}
	public void setBikeNo(String bikeNo) {
		this.bikeNo = bikeNo;
	}
	public String getBikeStusCd() {
		return bikeStusCd;
	}
	public void setBikeStusCd(String bikeStusCd) {
		this.bikeStusCd = bikeStusCd;
	}
	public String getBikeRepairYn() {
		return bikeRepairYn;
	}
	public void setBikeRepairYn(String bikeRepairYn) {
		this.bikeRepairYn = bikeRepairYn;
	}
	public String getActSeq() {
		return actSeq;
	}
	public void setActSeq(String actSeq) {
		this.actSeq = actSeq;
	}
	public String getActType() {
		return actType;
	}
	public void setActType(String actType) {
		this.actType = actType;
	}
	public String getActDate() {
		return actDate;
	}
	public void setActDate(String actDate) {
		this.actDate = actDate;
	}
	public String getActBatYn() {
		return actBatYn;
	}
	public void setActBatYn(String actBatYn) {
		this.actBatYn = actBatYn;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getModDttm() {
		return modDttm;
	}
	public void setModDttm(String modDttm) {
		this.modDttm = modDttm;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
	public String getDtlSeq() {
		return dtlSeq;
	}
	public void setDtlSeq(String dtlSeq) {
		this.dtlSeq = dtlSeq;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getActDesc() {
		return actDesc;
	}
	public void setActDesc(String actDesc) {
		this.actDesc = actDesc;
	}
	public String getFaultSeq() {
		return faultSeq;
	}
	public void setFaultSeq(String faultSeq) {
		this.faultSeq = faultSeq;
	}

}
