package com.dkitec.barocle.admin.service.membermgmt.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@SuppressWarnings("serial")
@Alias("TransitMgmtVO")
public class TransitMgmtVO extends PagingVO implements Serializable {
	private String lang;
	  private String ride_dttm;
	  private String alight_dttm;
	  private String usr_mpn_no;
	  private String mb_id;
	  private String usr_seq;
	  private String transport_cd;

	  public String getLang()
	  {
	    return this.lang;
	  }
	  public void setLang(String lang) {
	    this.lang = lang;
	  }
	  public String getRide_dttm() {
	    return this.ride_dttm;
	  }
	  public void setRide_dttm(String ride_dttm) {
	    this.ride_dttm = ride_dttm;
	  }
	  public String getAlight_dttm() {
	    return this.alight_dttm;
	  }
	  public void setAlight_dttm(String alight_dttm) {
	    this.alight_dttm = alight_dttm;
	  }
	  public String getUsr_mpn_no() {
	    return this.usr_mpn_no;
	  }
	  public void setUsr_mpn_no(String usr_mpn_no) {
	    this.usr_mpn_no = usr_mpn_no;
	  }
	  public String getMb_id() {
	    return this.mb_id;
	  }
	  public void setMb_id(String mb_id) {
	    this.mb_id = mb_id;
	  }
	  public String getTransport_cd() {
	    return this.transport_cd;
	  }
	  public void setTransport_cd(String transport_cd) {
	    this.transport_cd = transport_cd;
	  }
	  public String getUsr_seq() {
	    return this.usr_seq;
	  }
	  public void setUsr_seq(String usr_seq) {
	    this.usr_seq = usr_seq;
	  }

	  public String toString() {
	    return "TransitMgmtVO [lang=" + this.lang + ", ride_dttm=" + this.ride_dttm + 
	      ", alight_dttm=" + this.alight_dttm + ", usr_mpn_no=" + this.usr_mpn_no + 
	      ", mb_id=" + this.mb_id + ", transport_cd=" + this.transport_cd + "]";
	  }
}
