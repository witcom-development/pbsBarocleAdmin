/*
 * @Package Name : com.dkitec.barocle.admin.status.rentHistory.vo
 * @파일명          : PenaltyVO.java
 * @작성일          : 2015. 5. 14.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 14.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.rentHistory.vo;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.validator.annotation.IsStringNotNullNumeric;

/**
 * @파일명          : PenaltyVO.java
 * @작성일          : 2015. 5. 14.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 14.   |   ymshin   |  최초작성
 */
@Alias("penaltyVo")
public class PenaltyVO {
	
	@IsStringNotNullNumeric(message="")
	private String penaltySeq;
	private String penaltyCd;
	private String penaltyName;
	private String penaltyPoint;
	private String viewType;//popupMode
	private String penaltyDesc;
	private String menuType;
	@IsStringNotNullNumeric(message="")
	private String usrSeq;
	private String adminId;
	@IsStringNotNullNumeric(message="")
	private String rentHistSeq;
	
	public String getRentHistSeq() {
		return rentHistSeq;
	}
	public void setRentHistSeq(String rentHistSeq) {
		this.rentHistSeq = rentHistSeq;
	}
	public String getUsrSeq() {
		return usrSeq;
	}
	public void setUsrSeq(String usrSeq) {
		this.usrSeq = usrSeq;
	}
	public String getMenuType() {
		return menuType;
	}
	public void setMenuType(String menuType) {
		this.menuType = menuType;
	}
	public String getPenaltyDesc() {
		return penaltyDesc;
	}
	public void setPenaltyDesc(String penaltyDesc) {
		this.penaltyDesc = penaltyDesc;
	}
	public String getPenaltySeq() {
		return penaltySeq;
	}
	public void setPenaltySeq(String penaltySeq) {
		this.penaltySeq = penaltySeq;
	}
	public String getPenaltyCd() {
		return penaltyCd;
	}
	public void setPenaltyCd(String penaltyCd) {
		this.penaltyCd = penaltyCd;
	}
	public String getPenaltyName() {
		return penaltyName;
	}
	public void setPenaltyName(String penaltyName) {
		this.penaltyName = penaltyName;
	}
	public String getPenaltyPoint() {
		return penaltyPoint;
	}
	public void setPenaltyPoint(String penaltyPoint) {
		this.penaltyPoint = penaltyPoint;
	}
	public String getViewType() {
		return viewType;
	}
	public void setViewType(String viewType) {
		this.viewType = viewType;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	
	
}
