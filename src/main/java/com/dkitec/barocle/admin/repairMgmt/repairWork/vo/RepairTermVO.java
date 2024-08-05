package com.dkitec.barocle.admin.repairMgmt.repairWork.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("repairTermVO")
public class RepairTermVO extends CommonVo implements Serializable {
	
	/* TB_MTC_REPAIR_TERM_INFO */
	private String termSeq;			//단말기 수리 일련번호
	private String repairSeq;		//fk - 수리 일련번호
	private String termAdminId;		//단말기 수리자 아이디
	private String termAdminName;	//단말기 수리자 이름
	private String termCmptYn;		//단말기 수리완료 여부
	private String termCenterId;	//작성자 소속 사업소 아이디
	private String regDttm;			//등록 일시
	private String termCmptDttm;	//수리완료 일시
	
	
	public String getTermSeq() {
		return termSeq;
	}
	public void setTermSeq(String termSeq) {
		this.termSeq = termSeq;
	}
	public String getRepairSeq() {
		return repairSeq;
	}
	public void setRepairSeq(String repairSeq) {
		this.repairSeq = repairSeq;
	}
	public String getTermAdminId() {
		return termAdminId;
	}
	public void setTermAdminId(String termAdminId) {
		this.termAdminId = termAdminId;
	}
	public String getTermAdminName() {
		return termAdminName;
	}
	public void setTermAdminName(String termAdminName) {
		this.termAdminName = termAdminName;
	}
	public String getTermCmptYn() {
		return termCmptYn;
	}
	public void setTermCmptYn(String termCmptYn) {
		this.termCmptYn = termCmptYn;
	}
	public String getTermCenterId() {
		return termCenterId;
	}
	public void setTermCenterId(String termCenterId) {
		this.termCenterId = termCenterId;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getTermCmptDttm() {
		return termCmptDttm;
	}
	public void setTermCmptDttm(String termCmptDttm) {
		this.termCmptDttm = termCmptDttm;
	}
	
	

	
	
}
