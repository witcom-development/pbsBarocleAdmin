package com.dkitec.barocle.admin.repairMgmt.repairPerf.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("repairPerfVO")
public class RepairPerfVO extends CommonVo implements Serializable {
	
	
	/* 조회화면에 필요한 변수 */
	private String repairSeq;			 //수리 일련번호
	
	private String repairAdminName   ;   //정비직원 이름
	private String repairCenterName  ;   //정비직원 소속 사업소 이름
	private String divsnCnt    ;         //정비 구분자
	private String termCnt     ;         //단말기 정비
	private String bellCnt     ;         //벨 정비
	private String handleCnt   ;         //핸들 정비
	private String brakeCnt    ;         //브레이크 정비
	private String transCnt    ;         //변속기 정비
	private String ttCnt       ;         //타이어 튜브 정비
	private String chainCnt    ;         //체인 정비
	private String chainCvCnt  ;         //체인커버 정비
	private String trghCnt     ;         //물받이 정비
	private String standCnt    ;         //스탠드 정비
	private String etcCnt      ;         //기타 정비
	private String sumCnt      ;         //합계
	private String bikeCnt     ;         //자전거 수리완료
	private String cmptTermCnt ;		 //단말기 수리완료
	
	
	private String repairTotCnt;		 //자전거 단말기 총계
	private String repairBikeCnt;		 //자전거 수리 합계
	private String repairTermCnt;		 //단말기 수리 합계
	
	/* search */
	private String searchCenter;		 //사업소 검색
	private String searchAdmin;			 //정비직원 검색
	
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
	public String getDivsnCnt() {
		return divsnCnt;
	}
	public void setDivsnCnt(String divsnCnt) {
		this.divsnCnt = divsnCnt;
	}
	public String getTermCnt() {
		return termCnt;
	}
	public void setTermCnt(String termCnt) {
		this.termCnt = termCnt;
	}
	public String getBellCnt() {
		return bellCnt;
	}
	public void setBellCnt(String bellCnt) {
		this.bellCnt = bellCnt;
	}
	public String getHandleCnt() {
		return handleCnt;
	}
	public void setHandleCnt(String handleCnt) {
		this.handleCnt = handleCnt;
	}
	public String getBrakeCnt() {
		return brakeCnt;
	}
	public void setBrakeCnt(String brakeCnt) {
		this.brakeCnt = brakeCnt;
	}
	public String getTransCnt() {
		return transCnt;
	}
	public void setTransCnt(String transCnt) {
		this.transCnt = transCnt;
	}
	public String getTtCnt() {
		return ttCnt;
	}
	public void setTtCnt(String ttCnt) {
		this.ttCnt = ttCnt;
	}
	public String getChainCnt() {
		return chainCnt;
	}
	public void setChainCnt(String chainCnt) {
		this.chainCnt = chainCnt;
	}
	public String getChainCvCnt() {
		return chainCvCnt;
	}
	public void setChainCvCnt(String chainCvCnt) {
		this.chainCvCnt = chainCvCnt;
	}
	public String getTrghCnt() {
		return trghCnt;
	}
	public void setTrghCnt(String trghCnt) {
		this.trghCnt = trghCnt;
	}
	public String getStandCnt() {
		return standCnt;
	}
	public void setStandCnt(String standCnt) {
		this.standCnt = standCnt;
	}
	public String getEtcCnt() {
		return etcCnt;
	}
	public void setEtcCnt(String etcCnt) {
		this.etcCnt = etcCnt;
	}
	public String getSumCnt() {
		return sumCnt;
	}
	public void setSumCnt(String sumCnt) {
		this.sumCnt = sumCnt;
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
	public String getBikeCnt() {
		return bikeCnt;
	}
	public void setBikeCnt(String bikeCnt) {
		this.bikeCnt = bikeCnt;
	}
	public String getCmptTermCnt() {
		return cmptTermCnt;
	}
	public void setCmptTermCnt(String cmptTermCnt) {
		this.cmptTermCnt = cmptTermCnt;
	}	
	
	


	
}
