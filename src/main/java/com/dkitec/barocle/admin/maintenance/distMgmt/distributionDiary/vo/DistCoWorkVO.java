package com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("distCoWorkVO")
public class DistCoWorkVO extends CommonVo implements Serializable {
	
	
	public String getBikeCnt() {
		return bikeCnt;
	}
	public void setBikeCnt(String bikeCnt) {
		this.bikeCnt = bikeCnt;
	}
	public String getCoworkInfoSeq() {
		return coworkInfoSeq;
	}
	public void setCoworkInfoSeq(String coworkInfoSeq) {
		this.coworkInfoSeq = coworkInfoSeq;
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
	public String getWorkCnt() {
		return workCnt;
	}
	public void setWorkCnt(String workCnt) {
		this.workCnt = workCnt;
	}
	public String getWorkDate() {
		return workDate;
	}
	public void setWorkDate(String workDate) {
		this.workDate = workDate;
	}
	public String getWorkDtl() {
		return workDtl;
	}
	public void setWorkDtl(String workDtl) {
		this.workDtl = workDtl;
	}
	public String getWorkFrHour() {
		return workFrHour;
	}
	public void setWorkFrHour(String workFrHour) {
		this.workFrHour = workFrHour;
	}
	public String getWorkToHour() {
		return workToHour;
	}
	public void setWorkToHour(String workToHour) {
		this.workToHour = workToHour;
	}
	public String getWorkType() {
		return workType;
	}
	public void setWorkType(String workType) {
		this.workType = workType;
	}
	public String getCoworkName() {
		return coworkName;
	}
	public void setCoworkName(String coworkName) {
		this.coworkName = coworkName;
	}
	public String getWorkCenterId() {
		return workCenterId;
	}
	public void setWorkCenterId(String workCenterId) {
		this.workCenterId = workCenterId;
	}
	public String getIsCoworkDeleteYn() {
		return isCoworkDeleteYn;
	}
	public void setIsCoworkDeleteYn(String isCoworkDeleteYn) {
		this.isCoworkDeleteYn = isCoworkDeleteYn;
	}
	
	private String bikeCnt;    //자전거수량
	private String coworkInfoSeq;    //협동근무 SEQ
	private String modDttm;    //수정시간
	private String modId;    //수정자
	private String regDttm;    //등록일자
	private String regId;    //등록자
	private String workCnt;    //작업인원
	private String workDate;    //작업일자
	private String workDtl;    //작업상세
	private String workDtlSeq;    //작업상세
	public String getWorkDtlSeq() {
		return workDtlSeq;
	}
	public void setWorkDtlSeq(String workDtlSeq) {
		this.workDtlSeq = workDtlSeq;
	}

	private String workFrHour;    //시작시간
	private String workToHour;    //종료시간
	private String workType;    //작업구분
	private String coworkName;    //작업자
	private String workCenterId;  // 작업센터
	private String isCoworkDeleteYn; // 합동근무자 삭제 여부
	
	
	
	
}
