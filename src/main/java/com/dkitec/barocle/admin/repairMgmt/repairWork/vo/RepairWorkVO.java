package com.dkitec.barocle.admin.repairMgmt.repairWork.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("repairWorkVO")
public class RepairWorkVO extends CommonVo implements Serializable {
	
	/* TB_SYS_REPAIR_WORK */
	private String adminId;			//작성자 아이디
	private String centerId;		//작성자 소속 사업소 아이디
	private String workDate;		//작성날짜
	private int    workTime;		//근무시간
	private String approved;		//승인여부
	private String approverId;		//승인자 아이디
	
	/* TB_SYS_REPAIR_DTL */
	private String workSeq;			//FK
	private String dtlCd;			//사유 코드
	private String etc;				//기타 사유
	private int    dtlTime;			//근무 외 시간
	private String regDttm;			//등록 날짜
	private String regId;			//등록자 아이디
	private String modDttm;			//수정 날짜
	private String modId;			//수정자 아이디
	
	/* search */
	private String searchAprd;		//승인여부 검색
	private String searchCenter;	//사업소 검색
	private String searchAdmin;		//정비직원 검색
	
	/* 일괄 승인 처리에 필요한 변수 */
	private String[] workSeqArr;
	private String[] approvedArr;
	
	/* 화면에 보여줄 변수 */
	private String adminName;
	private String dtlName;
	private String approverName;
	
	/* 화면 그룹 권한 별 처리 변수 */
	private String adminGrpName;
	
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

	public String getApproved() {
		return approved;
	}

	public void setApproved(String approved) {
		this.approved = approved;
	}

	public String getApproverId() {
		return approverId;
	}

	public void setApproverId(String approverId) {
		this.approverId = approverId;
	}

	public String getWorkDate() {
		return workDate;
	}

	public void setWorkDate(String workDate) {
		this.workDate = workDate;
	}

	public String getWorkSeq() {
		return workSeq;
	}

	public void setWorkSeq(String workSeq) {
		this.workSeq = workSeq;
	}

	public String getSearchAprd() {
		return searchAprd;
	}

	public void setSearchAprd(String searchAprd) {
		this.searchAprd = searchAprd;
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

	public String getDtlCd() {
		return dtlCd;
	}

	public void setDtlCd(String dtlCd) {
		this.dtlCd = dtlCd;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
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

	public String[] getWorkSeqArr() {
		return workSeqArr;
	}

	public void setWorkSeqArr(String[] workSeqArr) {
		this.workSeqArr = workSeqArr;
	}

	public String[] getApprovedArr() {
		return approvedArr;
	}

	public void setApprovedArr(String[] approvedArr) {
		this.approvedArr = approvedArr;
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	public String getApproverName() {
		return approverName;
	}

	public void setApproverName(String approverName) {
		this.approverName = approverName;
	}

	public String getDtlName() {
		return dtlName;
	}

	public void setDtlName(String dtlName) {
		this.dtlName = dtlName;
	}

	public String getAdminGrpName() {
		return adminGrpName;
	}

	public void setAdminGrpName(String adminGrpName) {
		this.adminGrpName = adminGrpName;
	}

	public int getWorkTime() {
		return workTime;
	}

	public void setWorkTime(int workTime) {
		this.workTime = workTime;
	}

	public int getDtlTime() {
		return dtlTime;
	}

	public void setDtlTime(int dtlTime) {
		this.dtlTime = dtlTime;
	}
	
}
