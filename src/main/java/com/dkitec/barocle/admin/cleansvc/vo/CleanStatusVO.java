package com.dkitec.barocle.admin.cleansvc.vo;
import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("cleanStatusVO")
public class CleanStatusVO extends CommonVo implements Serializable {

	/* 공용 */
	private String adminId;			//작성자 아이디
	
	private String searchABType;
	private String searchID;
	
	/* TB_SVC_CLEAN */
	private String clean_seq;			//FK
	
				
	private String reg_id;			//등록자 아이디
	private String clean_type;
	private String reg_dttm;
	private String reg_dt;
	
	private String reg_name;
	private String reg_lat;
	private String reg_long;
	private String reg_addr;
	private String reg_addr_detail;
	
	
	
	public String getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getSearchABType() {
		return searchABType;
	}
	public void setSearchABType(String searchABType) {
		this.searchABType = searchABType;
	}
	public String getSearchID() {
		return searchID;
	}
	public void setSearchID(String searchID) {
		this.searchID = searchID;
	}
	public String getReg_name() {
		return reg_name;
	}
	public void setReg_name(String reg_name) {
		this.reg_name = reg_name;
	}
	public String getReg_lat() {
		return reg_lat;
	}
	public void setReg_lat(String reg_lat) {
		this.reg_lat = reg_lat;
	}
	public String getReg_long() {
		return reg_long;
	}
	public void setReg_long(String reg_long) {
		this.reg_long = reg_long;
	}
	public String getReg_addr() {
		return reg_addr;
	}
	public void setReg_addr(String reg_addr) {
		this.reg_addr = reg_addr;
	}
	public String getReg_addr_detail() {
		return reg_addr_detail;
	}
	public void setReg_addr_detail(String reg_addr_detail) {
		this.reg_addr_detail = reg_addr_detail;
	}

	

	
	
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getClean_seq() {
		return clean_seq;
	}
	public void setClean_seq(String clean_seq) {
		this.clean_seq = clean_seq;
	}
	public String getReg_id() {
		return reg_id;
	}
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	public String getClean_type() {
		return clean_type;
	}
	public void setClean_type(String clean_type) {
		this.clean_type = clean_type;
	}
	public String getReg_dttm() {
		return reg_dttm;
	}
	public void setReg_dttm(String reg_dttm) {
		this.reg_dttm = reg_dttm;
	}
	
	
	
}
