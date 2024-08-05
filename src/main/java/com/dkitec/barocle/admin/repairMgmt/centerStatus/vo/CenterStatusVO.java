package com.dkitec.barocle.admin.repairMgmt.centerStatus.vo;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("centerStatusVO")
public class CenterStatusVO extends CommonVo implements Serializable {
	

	
	/* 화면에 보여줄 변수 */
	//사업소명
	private String workCenterName;			//사업소명
	
	//자전거 입출고현황
	private String dayBikeCnt;				//일계 수리완료 개수
	private String dayTermCnt;				//일계 단말기 수리완료 개수
	private String repairBikeCnt; 			//누계 수리완료 개수
	private String repairTermCnt; 			//누계 단말기 수리완료 개수
	private String repairRemark;	  		//비고
	
	//근무현황
	private String repairWorkAdmins; 		//주간근무자 명단
	private String repairWorkAdminsCnt;		//주간근무자 명수
	
	//정비현황
	private String workAdminName;	 //근무자이름
	private String workTime;		 //근무시간
	private String workDtlTime;		 //근무 외 시간
	private String workAdminBikeCnt; //근무자 수리완료 개수
	private String workAdminTermCnt; //근무자 단말기 수리완료 개수
	private String workAdminRemark;  //근무자 비고
	
	private String etcDesc;  //근무자 비고
	
	public String getEtcDesc() {
		return etcDesc;
	}
	public void setEtcDesc(String etcDesc) {
		this.etcDesc = etcDesc;
	}
	
	//근무자 리스트용
	private List<CenterStatusVO> workAdminList;
	
	/* search */
	
	private String searchCenter;	//사업소 검색
	
	/* 화면 그룹 권한 별 처리 변수 */
	
	private String adminId;
	private String centerId;
	private String adminGrpName;
	
	
	public String getRepairBikeCnt() {
		return repairBikeCnt;
	}
	public void setRepairBikeCnt(String repairBikeCnt) {
		this.repairBikeCnt = repairBikeCnt;
	}
	public String getRepairTermCnt() {
		return repairTermCnt;
	}
	public void setRepairTermCnt(String repairTermCnt) {
		this.repairTermCnt = repairTermCnt;
	}
	public String getRepairRemark() {
		return repairRemark;
	}
	public void setRepairRemark(String repairRemark) {
		this.repairRemark = repairRemark;
	}
	public String getRepairWorkAdmins() {
		return repairWorkAdmins;
	}
	public void setRepairWorkAdmins(String repairWorkAdmins) {
		this.repairWorkAdmins = repairWorkAdmins;
	}
	public String getRepairWorkAdminsCnt() {
		return repairWorkAdminsCnt;
	}
	public void setRepairWorkAdminsCnt(String repairWorkAdminsCnt) {
		this.repairWorkAdminsCnt = repairWorkAdminsCnt;
	}
	public String getWorkAdminName() {
		return workAdminName;
	}
	public void setWorkAdminName(String workAdminName) {
		this.workAdminName = workAdminName;
	}
	public String getWorkTime() {
		return workTime;
	}
	public void setWorkTime(String workTime) {
		this.workTime = workTime;
	}
	public String getWorkAdminBikeCnt() {
		return workAdminBikeCnt;
	}
	public void setWorkAdminBikeCnt(String workAdminBikeCnt) {
		this.workAdminBikeCnt = workAdminBikeCnt;
	}
	public String getWorkAdminTermCnt() {
		return workAdminTermCnt;
	}
	public void setWorkAdminTermCnt(String workAdminTermCnt) {
		this.workAdminTermCnt = workAdminTermCnt;
	}
	public String getWorkAdminRemark() {
		return workAdminRemark;
	}
	public void setWorkAdminRemark(String workAdminRemark) {
		this.workAdminRemark = workAdminRemark;
	}
	public List<CenterStatusVO> getWorkAdminList() {
		return workAdminList;
	}
	public void setWorkAdminList(List<CenterStatusVO> workAdminList) {
		this.workAdminList = workAdminList;
	}
	public String getSearchCenter() {
		return searchCenter;
	}
	public void setSearchCenter(String searchCenter) {
		this.searchCenter = searchCenter;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getCenterId() {
		return centerId;
	}
	public void setCenterId(String centerId) {
		this.centerId = centerId;
	}
	public String getAdminGrpName() {
		return adminGrpName;
	}
	public void setAdminGrpName(String adminGrpName) {
		this.adminGrpName = adminGrpName;
	}
	public String getWorkCenterName() {
		return workCenterName;
	}
	public void setWorkCenterName(String workCenterName) {
		this.workCenterName = workCenterName;
	}
	public String getDayBikeCnt() {
		return dayBikeCnt;
	}
	public void setDayBikeCnt(String dayBikeCnt) {
		this.dayBikeCnt = dayBikeCnt;
	}
	public String getDayTermCnt() {
		return dayTermCnt;
	}
	public void setDayTermCnt(String dayTermCnt) {
		this.dayTermCnt = dayTermCnt;
	}
	public String getWorkDtlTime() {
		return workDtlTime;
	}
	public void setWorkDtlTime(String workDtlTime) {
		this.workDtlTime = workDtlTime;
	}
	
	
	
}
