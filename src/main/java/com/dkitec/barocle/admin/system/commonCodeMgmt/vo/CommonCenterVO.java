package com.dkitec.barocle.admin.system.commonCodeMgmt.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

@SuppressWarnings("serial")
@Alias("commonCenterVo")
public class CommonCenterVO implements Serializable {

	private String centerId;
	private String centerClsCd;
	private String centerName;
	
	public String getCenterId() {
		return centerId;
	}
	public void setCenterId(String centerId) {
		this.centerId = centerId;
	}
	public String getCenterClsCd() {
		return centerClsCd;
	}
	public void setCenterClsCd(String centerClsCd) {
		this.centerClsCd = centerClsCd;
	}
	public String getCenterName() {
		return centerName;
	}
	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}

	
}
