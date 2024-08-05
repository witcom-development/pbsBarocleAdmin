package com.dkitec.barocle.admin.system.teammgmt.vo;

import java.io.Serializable;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;



/**
 * 팀 정보를 담고있는 VO 클래스를 정의한다.
 * @author dustjm
 * @since 2018.02.02
 * @version 1.0
 * @see 
 * <pre>
 *  == 개정이력(Modification Information) ==
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2018.02.02  dustjm          최초 생성
 * 
 * </pre>
 */
@Alias(value="teamMgmtVO")
public class TeamMgmtVO extends PagingVO implements Serializable{

	private static final long serialVersionUID = -2132379045115001026L;

	
	private String teamSeq;
	
	private String centerId;
	private String centerNm;
	private String teamId;
	private String teamNm;
	private String mpnNo1;
	private String mpnNo2;
	
	/** 생성일	 */
	private String creDate;
	private String creId;
	
	/** 수정일	 */
	private String modDate;
	private String modId;
	
	private int adminCount;
	
	private int carCount;
	
	private String pageIndex;

	public String getTeamSeq() {
		return teamSeq;
	}

	public void setTeamSeq(String teamSeq) {
		this.teamSeq = teamSeq;
	}

	public String getCenterId() {
		return centerId;
	}

	public void setCenterId(String centerId) {
		this.centerId = centerId;
	}

	public String getCenterIdNm() {
		return centerNm;
	}

	public void setCenterIdNm(String centerNm) {
		this.centerNm = centerNm;
	}

	public String getTeamId() {
		return teamId;
	}

	public void setTeamId(String teamId) {
		this.teamId = teamId;
	}

	public String getTeamNm() {
		return teamNm;
	}

	public void setTeamIdNm(String teamNm) {
		this.teamNm = teamNm;
	}

	public String getMpnNo1() {
		return mpnNo1;
	}

	public void setMpnNo1(String mpnNo1) {
		this.mpnNo1 = mpnNo1;
	}

	public String getMpnNo2() {
		return mpnNo2;
	}

	public void setMpnNo2(String mpnNo2) {
		this.mpnNo2 = mpnNo2;
	}

	public String getCreDate() {
		return creDate;
	}

	public void setCreDate(String creDate) {
		this.creDate = creDate;
	}

	public String getCreId() {
		return creId;
	}

	public void setCreId(String creId) {
		this.creId = creId;
	}

	public String getModDate() {
		return modDate;
	}

	public void setModDate(String modDate) {
		this.modDate = modDate;
	}

	public String getModId() {
		return modId;
	}

	public void setModId(String modId) {
		this.modId = modId;
	}

	public String getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(String pageIndex) {
		this.pageIndex = pageIndex;
	}

	public String getCenterNm() {
		return centerNm;
	}

	public void setCenterNm(String centerNm) {
		this.centerNm = centerNm;
	}

	public int getAdminCount() {
		return adminCount;
	}

	public void setAdminCount(int adminCount) {
		this.adminCount = adminCount;
	}

	public void setTeamNm(String teamNm) {
		this.teamNm = teamNm;
	}

	public int getCarCount() {
		return carCount;
	}

	public void setCarCount(int carCount) {
		this.carCount = carCount;
	}
	
}
