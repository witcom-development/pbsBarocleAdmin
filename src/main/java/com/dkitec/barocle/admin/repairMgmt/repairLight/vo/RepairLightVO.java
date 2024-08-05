package com.dkitec.barocle.admin.repairMgmt.repairLight.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("repairLightVO")
public class RepairLightVO extends CommonVo implements Serializable {
	
	
	/* 조회화면에 필요한 변수 */
	private String repairSeq;			 //수리 일련번호
	
	private String repairAdminName   ;   //정비직원 이름
	private String repairAdminId   ;   //정비직원 이름
	public String getRepairAdminId() {
		return repairAdminId;
	}
	public void setRepairAdminId(String repairAdminId) {
		this.repairAdminId = repairAdminId;
	}

	private String repairCenterName  ;   //정비직원 소속 사업소 이름
	private String repairTeamName  ;   //정비직원 소속 사업소 이름
	
	public String getRepairTeamName() {
		return repairTeamName;
	}
	public void setRepairTeamName(String repairTeamName) {
		this.repairTeamName = repairTeamName;
	}
	 
	public String REB_009;
	public String getREB_009() {
		return REB_009;
	}
	public void setREB_009(String rEB_009) {
		REB_009 = rEB_009;
	}
	public String getREB_018() {
		return REB_018;
	}
	public void setREB_018(String rEB_018) {
		REB_018 = rEB_018;
	}
	public String getREB_024() {
		return REB_024;
	}
	public void setREB_024(String rEB_024) {
		REB_024 = rEB_024;
	}
	public String getREB_057() {
		return REB_057;
	}
	public void setREB_057(String rEB_057) {
		REB_057 = rEB_057;
	}

	public String REB_018;
	public String REB_024;
	public String REB_057;
	
	
	private String repairTotCnt;		 //자전거 단말기 총계
	private String repairBikeCnt;		 //자전거 수리 합계
	private String repairTermCnt;		 //단말기 수리 합계
	
	/* search */
	private String searchCenter;		 //사업소 검색
	private String searchAdmin;			 //정비직원 검색
	private String searchOffice;			 //정비직원 검색
	
	public String getSearchOffice() {
		return searchOffice;
	}
	public void setSearchOffice(String searchOffice) {
		this.searchOffice = searchOffice;
	}

	/* 화면 그룹 권한 별 처리 변수 */
	private String adminId;
	private String centerId;
	private String adminGrpName;
	
	
	public String getRepairSeq() {
		return repairSeq;
	}
	public void setRepairSeq(String repairSeq) {
		this.repairSeq = repairSeq;
	}
	 
	public String getSearchCenter() {
		return searchCenter;
	}
	public void setSearchCenter(String searchCenter) {
		this.searchCenter = searchCenter;
	}
	public String getSearchAdmin() {
		return searchAdmin;
	}
	public void setSearchAdmin(String searchAdmin) {
		this.searchAdmin = searchAdmin;
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
	public String getRepairAdminName() {
		return repairAdminName;
	}
	public void setRepairAdminName(String repairAdminName) {
		this.repairAdminName = repairAdminName;
	}
	public String getRepairCenterName() {
		return repairCenterName;
	}
	public void setRepairCenterName(String repairCenterName) {
		this.repairCenterName = repairCenterName;
	}
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
	public String getRepairTotCnt() {
		return repairTotCnt;
	}
	public void setRepairTotCnt(String repairTotCnt) {
		this.repairTotCnt = repairTotCnt;
	}
 
	
	


	
}
