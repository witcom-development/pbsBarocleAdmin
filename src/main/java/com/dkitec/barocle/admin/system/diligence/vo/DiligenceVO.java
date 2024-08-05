package com.dkitec.barocle.admin.system.diligence.vo;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("diligenceAndLazinessVO")
public class DiligenceVO extends PagingVO implements java.io.Serializable {
	
	private static final long serialVersionUID = -1L;
	
	private java.util.List<DiligenceVO> dalList;
	
	private String dclzSeq;		
	private String dclzCd;		    //근태코드
	private String dclzCdNm;		//근태코드명
	private String dclzStrDt;		//근태시작일
	private String dclzEndDt;		//근태종료일
	private String prvonsh;			//사유
	private String confmCd;			//승인상태
	private String regId;
	private String regDttm;
	
	public java.util.List<DiligenceVO> getDalList() {
		return dalList;
	}
	public void setDalList(java.util.List<DiligenceVO> dalList) {
		this.dalList = dalList;
	}
	public String getDclzSeq() {
		return dclzSeq;
	}
	public void setDclzSeq(String dclzSeq) {
		this.dclzSeq = dclzSeq;
	}
	public String getDclzCd() {
		return dclzCd;
	}
	public void setDclzCd(String dclzCd) {
		this.dclzCd = dclzCd;
	}
	public String getDclzCdNm() {
		return dclzCdNm;
	}
	public void setDclzCdNm(String dclzCdNm) {
		this.dclzCdNm = dclzCdNm;
	}
	public String getDclzStrDt() {
		return dclzStrDt;
	}
	public void setDclzStrDt(String dclzStrDt) {
		this.dclzStrDt = dclzStrDt;
	}
	public String getDclzEndDt() {
		return dclzEndDt;
	}
	public void setDclzEndDt(String dclzEndDt) {
		this.dclzEndDt = dclzEndDt;
	}
	public String getPrvonsh() {
		return prvonsh;
	}
	public void setPrvonsh(String prvonsh) {
		this.prvonsh = prvonsh;
	}
	public String getConfmCd() {
		return confmCd;
	}
	public void setConfmCd(String confmCd) {
		this.confmCd = confmCd;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	
	
	
}
