package com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("distCoWorkDtlVO")
public class DistCoWorkDtlVO extends CommonVo implements Serializable {
	
	private String coworkDtlSeq;    //합동근무 상세 SEQ
	private String coworkInfoSeq;    //외부키(합동근무 SEQ)
	private String coWorkId;    //합동근무자
	private String regDttm;    //등록일자	
	
	public String getCoworkDtlSeq() {
		return coworkDtlSeq;
	}
	public void setCoworkDtlSeq(String coworkDtlSeq) {
		this.coworkDtlSeq = coworkDtlSeq;
	}
	public String getCoworkInfoSeq() {
		return coworkInfoSeq;
	}
	public void setCoworkInfoSeq(String coworkInfoSeq) {
		this.coworkInfoSeq = coworkInfoSeq;
	}
	public String getCoWorkId() {
		return coWorkId;
	}
	public void setCoWorkId(String coWorkId) {
		this.coWorkId = coWorkId;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}


}
