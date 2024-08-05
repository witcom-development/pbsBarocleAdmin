package com.dkitec.barocle.admin.maintenance.relocation.vo;

import java.io.Serializable;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;
import com.dkitec.barocle.util.validator.annotation.IsStringNotNullNumeric;

@SuppressWarnings("serial")
@Alias("RelocationWorkArrangeResultVO")
public class RelocationWorkArrangeResultVO extends CommonVo implements Serializable {
	  
	public String getResult_seq() {
		return result_seq;
	}
	public void setResult_seq(String result_seq) {
		this.result_seq = result_seq;
	}
	public String getCall_seq() {
		return call_seq;
	}
	public void setCall_seq(String call_seq) {
		this.call_seq = call_seq;
	}
	public String getReq_hour() {
		return req_hour;
	}
	public void setReq_hour(String req_hour) {
		this.req_hour = req_hour;
	}
	public String getGroup_seq() {
		return group_seq;
	}
	public void setGroup_seq(String group_seq) {
		this.group_seq = group_seq;
	}
	public String getMove_seq() {
		return move_seq;
	}
	public void setMove_seq(String move_seq) {
		this.move_seq = move_seq;
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
	public String getStation_id() {
		return station_id;
	}
	public void setStation_id(String station_id) {
		this.station_id = station_id;
	}
	public String getMove_cnt() {
		return move_cnt;
	}
	public void setMove_cnt(String move_cnt) {
		this.move_cnt = move_cnt;
	}
	public String getReq_dttm() {
		return req_dttm;
	}
	public void setReq_dttm(String req_dttm) {
		this.req_dttm = req_dttm;
	}
	private String result_seq;
	private String call_seq;
	private String req_hour;
	private String group_seq;
	private String move_seq;
	private String latitude;
	private String longitude;
	private String station_id;
	private String move_cnt;
	private String req_dttm;
	private String station_no;
	public String getStation_no() {
		return station_no;
	}
	public void setStation_no(String station_no) {
		this.station_no = station_no;
	}
	private String req_latitude;
	private String req_longitude;
	
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
	  
}
