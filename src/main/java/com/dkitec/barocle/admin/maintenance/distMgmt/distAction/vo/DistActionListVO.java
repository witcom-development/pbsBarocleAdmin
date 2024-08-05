package com.dkitec.barocle.admin.maintenance.distMgmt.distAction.vo;
import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("distActionListVO")
public class DistActionListVO extends CommonVo implements Serializable{
	 
	
	private String adminName;
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getRetType() {
		return retType;
	}
	public void setRetType(String retType) {
		this.retType = retType;
	}
	public String getBikeNo() {
		return bikeNo;
	}
	public void setBikeNo(String bikeNo) {
		this.bikeNo = bikeNo;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getCenterName() {
		return centerName;
	}
	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getSearchCenterId() {
		return searchCenterId;
	}
	public void setSearchCenterId(String searchCenterId) {
		this.searchCenterId = searchCenterId;
	}
	public String getSearchAdminName() {
		return searchAdminName;
	}
	public void setSearchAdminName(String searchAdminName) {
		this.searchAdminName = searchAdminName;
	}
	public String getSearchBikeNo() {
		return searchBikeNo;
	}
	public void setSearchBikeNo(String searchBikeNo) {
		this.searchBikeNo = searchBikeNo;
	}
	private String retType;
	private String retTypeName;
	public String getRetTypeName() {
		return retTypeName;
	}
	public void setRetTypeName(String retTypeName) {
		this.retTypeName = retTypeName;
	}
	private String bikeNo;
	private String addr;
	private String latitude;
	private String longitude;
	private String regDttm;
	private String centerName;
	private String teamName;
	private String followName;
	public String getFollowName() {
		return followName;
	}
	public void setFollowName(String followName) {
		this.followName = followName;
	}
	public String getFollow() {
		return follow;
	}
	public void setFollow(String follow) {
		this.follow = follow;
	}
	private String follow;
	
	private String searchCenterId;
	private String searchAdminName;
	private String searchBikeNo;
	
}
