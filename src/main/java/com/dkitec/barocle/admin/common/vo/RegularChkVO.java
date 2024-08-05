/*
 * @Package Name : com.dkitec.barocle.admin.manage.deviceMgmt.common.vo
 * @파일명          : RegularChkVO.java
 * @작성일          : 2015. 4. 24.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 24.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.common.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Null;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.IsStringNumeric;

/**
 * @파일명          : RegularChkVO.java
 * @작성일          : 2015. 4. 24.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 24.   |   ymshin   |  최초작성
 */
@SuppressWarnings("serial")
@Alias("regularChkVo")
public class RegularChkVO implements Serializable {

	private String adminId;

	@Pattern(regexp="^\\d{4}-\\d{2}-\\d{2}$", message="적합하지 않은 날짜 형식입니다.")
	private String chkDttm;

	@Size(max=20, message="ID는 20자 이상일수 없습니다.")
	@CheckValue(message="Id는 빈값일수 없습니다.")
	private String equipmentId;
	
	@Size(max=300, message ="300자 이내로 작성해 주세요.")
	private String comments;
	
	private String equipmentClsCd;
	private String equipmentClsName;
	
	private String mode;
	private String modId;
	private String faultSeq;
	
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getEquipmentClsName() {
		return equipmentClsName;
	}
	public void setEquipmentClsName(String equipmentClsName) {
		this.equipmentClsName = equipmentClsName;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getChkDttm() {
		return chkDttm;
	}
	public void setChkDttm(String chkDttm) {
		this.chkDttm = chkDttm;
	}
	
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getEquipmentId() {
		return equipmentId;
	}
	public void setEquipmentId(String equipmentId) {
		this.equipmentId = equipmentId;
	}
	public String getEquipmentClsCd() {
		return equipmentClsCd;
	}
	public void setEquipmentClsCd(String equipmentClsCd) {
		this.equipmentClsCd = equipmentClsCd;
	}
	public String getFaultSeq() {
		return faultSeq;
	}
	public void setFaultSeq(String faultSeq) {
		this.faultSeq = faultSeq;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
	
}
