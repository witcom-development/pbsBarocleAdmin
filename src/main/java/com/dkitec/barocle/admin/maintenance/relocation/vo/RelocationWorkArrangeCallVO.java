package com.dkitec.barocle.admin.maintenance.relocation.vo;

import java.io.Serializable;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;
import com.dkitec.barocle.util.validator.annotation.IsStringNotNullNumeric;

@SuppressWarnings("serial")
@Alias("RelocationWorkArrangeCallVO")
public class RelocationWorkArrangeCallVO extends CommonVo implements Serializable {
	public String getCall_seq() {
		return call_seq;
	}
	public void setCall_seq(String call_seq) {
		this.call_seq = call_seq;
	}
	public String getReq_ymd() {
		return req_ymd;
	}
	public void setReq_ymd(String req_ymd) {
		this.req_ymd = req_ymd;
	}
	public String getReq_hour() {
		return req_hour;
	}
	public void setReq_hour(String req_hour) {
		this.req_hour = req_hour;
	}
	public String getTeam_seq() {
		return team_seq;
	}
	public void setTeam_seq(String team_seq) {
		this.team_seq = team_seq;
	}
	public String getReq_mem_cnt() {
		return req_mem_cnt;
	}
	public void setReq_mem_cnt(String req_mem_cnt) {
		this.req_mem_cnt = req_mem_cnt;
	}
	public String getReq_latitude() {
		return req_latitude;
	}
	public void setReq_latitude(String req_latitude) {
		this.req_latitude = req_latitude;
	}
	public String getReq_longitude() {
		return req_longitude;
	}
	public void setReq_longitude(String req_longitude) {
		this.req_longitude = req_longitude;
	}
	public String getReq_yn() {
		return req_yn;
	}
	public void setReq_yn(String req_yn) {
		this.req_yn = req_yn;
	}
	public String getReq_admin_id() {
		return req_admin_id;
	}
	public void setReq_admin_id(String req_admin_id) {
		this.req_admin_id = req_admin_id;
	}
	public String getReq_dttm() {
		return req_dttm;
	}
	public void setReq_dttm(String req_dttm) {
		this.req_dttm = req_dttm;
	}
	public String getEnd_dttm() {
		return end_dttm;
	}
	public void setEnd_dttm(String end_dttm) {
		this.end_dttm = end_dttm;
	}
	private String call_seq;
	private String req_ymd;
	private String req_hour;
	private String team_seq;
	private String req_mem_cnt;
	private String req_latitude;
	private String req_longitude;
	private String req_yn;
	private String req_admin_id;
	private String req_dttm;
	private String end_dttm;
	private String station_no;
	private String group_seq;
	private String adminName;
	private String initialCount;
	 
	public String getInitialCount() {
		return initialCount;
	}
	public void setInitialCount(String initialCount) {
		this.initialCount = initialCount;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getGroup_seq() {
		return group_seq;
	}
	public void setGroup_seq(String group_seq) {
		this.group_seq = group_seq;
	}
	public String getStation_no() {
		return station_no;
	}
	public void setStation_no(String station_no) {
		this.station_no = station_no;
	}
	  
}
