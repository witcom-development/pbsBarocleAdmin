package com.dkitec.barocle.admin.repairMgmt.mgmtStat.vo;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("mgmtStatVO")
public class MgmtStatVO extends CommonVo implements Serializable {
	
	/* 자전거 정비 인원 현황 */
	private String repairCenterUp;				//사업소 소속된 위치 : 강북,강남
	private String repairCenterName;			//사업소 이름
    private String repairAdminNames;			//사업소 소속 정비직원
    private String repairWorkTime;				//사업소 소속 정비직원 근무시간 합
    private String repairDtlTime;				//사업소 소속 정비직원 정비 외 시간 합
    private String repairAdminNamesCnt;			//정비직원 수
    
    
    private List<MgmtStatVO> adminStatusList;	//자전거 정비 인원 현황 리스트
    
    /* 정비 현황(건) */
	private String statusCenterUp    ;          //사업소 소속된 위치 : 강북,강남
	private String statusCenterName  ;          //정비직원 소속 사업소 이름
	private String divsnCnt          ;          //정비 구분자
	private String termCnt           ;          //단말기 정비
	private String bellCnt           ;          //벨 정비
	private String handleCnt         ;          //핸들 정비
	private String brakeCnt          ;          //브레이크 정비
	private String transCnt          ;          //변속기 정비
	private String ttCnt             ;          //타이어 튜브 정비
	private String chainCnt          ;          //체인 정비
	private String chainCvCnt        ;          //체인커버 정비
	private String trghCnt           ;          //물받이 정비
	private String standCnt          ;          //스탠드 정비
	private String etcCnt            ;          //기타 정비
	private String sumCnt            ;          //합계
	private String bikeCnt	         ;			//자전거 수
	private String cmptTermCnt		 ;			//단말기 수
	                                            
	private int statusBikeCnt;			        //자전거 수리 합계
	private int statusTermCnt;			        //단말기 수리 합계
	
	
	
	private List<MgmtStatVO> repairStatusList;	//정비 현황 리스트
	private List<MgmtStatVO> repairStatusCntList;//정비 현황-일,월,누계 리스트
    
    /* 자전거 정비 현황 */
    private String repairCntD;					//자전거 수리완료 일계
    private String repairCntM;					//자전거 수리완료 월계
    private String repairCntY;					//자전거 수리완료 누계(연계)
    
    
    private String searchCenterId;
    
    
	public String getSearchCenterId() {
		return searchCenterId;
	}
	public void setSearchCenterId(String searchCenterId) {
		this.searchCenterId = searchCenterId;
	}
	public String getRepairCenterUp() {
		return repairCenterUp;
	}
	public void setRepairCenterUp(String repairCenterUp) {
		this.repairCenterUp = repairCenterUp;
	}
	public String getRepairCenterName() {
		return repairCenterName;
	}
	public void setRepairCenterName(String repairCenterName) {
		this.repairCenterName = repairCenterName;
	}
	public String getRepairAdminNames() {
		return repairAdminNames;
	}
	public void setRepairAdminNames(String repairAdminNames) {
		this.repairAdminNames = repairAdminNames;
	}
	public String getRepairAdminNamesCnt() {
		return repairAdminNamesCnt;
	}
	public void setRepairAdminNamesCnt(String repairAdminNamesCnt) {
		this.repairAdminNamesCnt = repairAdminNamesCnt;
	}
	public String getRepairCntD() {
		return repairCntD;
	}
	public void setRepairCntD(String repairCntD) {
		this.repairCntD = repairCntD;
	}
	public String getRepairCntM() {
		return repairCntM;
	}
	public void setRepairCntM(String repairCntM) {
		this.repairCntM = repairCntM;
	}
	public String getRepairCntY() {
		return repairCntY;
	}
	public void setRepairCntY(String repairCntY) {
		this.repairCntY = repairCntY;
	}
	public List<MgmtStatVO> getAdminStatusList() {
		return adminStatusList;
	}
	public void setAdminStatusList(List<MgmtStatVO> adminStatusList) {
		this.adminStatusList = adminStatusList;
	}
	public String getStatusCenterUp() {
		return statusCenterUp;
	}
	public void setStatusCenterUp(String statusCenterUp) {
		this.statusCenterUp = statusCenterUp;
	}
	public String getStatusCenterName() {
		return statusCenterName;
	}
	public void setStatusCenterName(String statusCenterName) {
		this.statusCenterName = statusCenterName;
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
	public int getStatusBikeCnt() {
		return statusBikeCnt;
	}
	public void setStatusBikeCnt(int statusBikeCnt) {
		this.statusBikeCnt = statusBikeCnt;
	}
	public int getStatusTermCnt() {
		return statusTermCnt;
	}
	public void setStatusTermCnt(int statusTermCnt) {
		this.statusTermCnt = statusTermCnt;
	}
	public List<MgmtStatVO> getRepairStatusList() {
		return repairStatusList;
	}
	public void setRepairStatusList(List<MgmtStatVO> repairStatusList) {
		this.repairStatusList = repairStatusList;
	}
	public List<MgmtStatVO> getRepairStatusCntList() {
		return repairStatusCntList;
	}
	public void setRepairStatusCntList(List<MgmtStatVO> repairStatusCntList) {
		this.repairStatusCntList = repairStatusCntList;
	}
	public String getBikeCnt() {
		return bikeCnt;
	}
	public void setBikeCnt(String bikeCnt) {
		this.bikeCnt = bikeCnt;
	}
	public String getRepairWorkTime() {
		return repairWorkTime;
	}
	public void setRepairWorkTime(String repairWorkTime) {
		this.repairWorkTime = repairWorkTime;
	}
	public String getRepairDtlTime() {
		return repairDtlTime;
	}
	public void setRepairDtlTime(String repairDtlTime) {
		this.repairDtlTime = repairDtlTime;
	}
	public String getCmptTermCnt() {
		return cmptTermCnt;
	}
	public void setCmptTermCnt(String cmptTermCnt) {
		this.cmptTermCnt = cmptTermCnt;
	}
	
}
