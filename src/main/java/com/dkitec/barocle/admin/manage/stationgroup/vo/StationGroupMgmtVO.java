package com.dkitec.barocle.admin.manage.stationgroup.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.GroupSequence;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@SuppressWarnings("serial")
public class StationGroupMgmtVO extends PagingVO implements Serializable{

	public interface stationGroup_seqCheck{}
	public interface stationGroup_NameCheck{}
	
	@GroupSequence({stationGroup_seqCheck.class})
	public static interface seqCheck{}
	
	@GroupSequence({SearchStartDate.class,SearchEndDate.class, SearchValue.class})
	public static interface searchCheck{}
	
	@GroupSequence({stationGroup_NameCheck.class})
	public static interface groupName_DuplCheck{}
	
	
	
	@Size(min=0,max=20,message="키값의 길이가 잘못 되었습니다.", groups=stationGroup_seqCheck.class) //길이 체크
	private String station_grp_seq;
	
	
	@NotEmpty(message="그룹병이 없습니다..", groups=stationGroup_NameCheck.class)  //공백체크
	@Size(min=1,max=25,message="그룹명의 길이가 잘못 되었습니다.", groups=stationGroup_NameCheck.class) //길이 체크
	private String station_grp_name;
	
	
	private String comptb_can_yn;
	private String main_station_id;
	private String mod_dttm;
	private String station_id;
	
	private String lang_cls_cd;
	private String lang;
	private String cmd;
	private String user;
	
	private List<String> nameList;
	private List<String> codeList;
	
//	@NotEmpty(message="키 값이 없습니다."\n groups=stationGroup_seqCheck.class)  //공백체크
//	@Size(min=1,max=20,message="키값의 길이가 잘못 되었습니다."\ngroups=stationGroup_seqCheck.class) //길이 체크
//	@Pattern(regexp="^[0-9a-zA-Z]*$"\nmessage="특수문자는 사용할수 없습니다."\n groups=stationGroup_seqCheck.class)  //영문+숫자만 허용
//	@Pattern(regexp="^[가-힣]*$"\nmessage="한글만 사용가능합니다."\n groups=stationGroup_seqCheck.class) //한글만 허용
//	@Pattern(regexp="^[0-9]*$"\nmessage="숫자만 사용 가능합니다.."\n groups=stationGroup_seqCheck.class) //숫자만 허용
	
	
	
	
	public String getStation_grp_seq() {
		return station_grp_seq;
	}

	public void setStation_grp_seq(String station_grp_seq) {
		this.station_grp_seq = station_grp_seq;
	}

	public String getCmd() {
		return cmd;
	}

	public void setCmd(String cmd) {
		this.cmd = cmd;
	}

	public String getStation_grp_name() {
		return station_grp_name;
	}

	public void setStation_grp_name(String station_grp_name) {
		this.station_grp_name = station_grp_name;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getComptb_can_yn() {
		return comptb_can_yn;
	}

	public void setComptb_can_yn(String comptb_can_yn) {
		this.comptb_can_yn = comptb_can_yn;
	}

	public String getLang_cls_cd() {
		return lang_cls_cd;
	}

	public void setLang_cls_cd(String lang_cls_cd) {
		this.lang_cls_cd = lang_cls_cd;
	}

	public String getMain_station_id() {
		return main_station_id;
	}

	public void setMain_station_id(String main_station_id) {
		this.main_station_id = main_station_id;
	}

	public String getLang() {
		return lang;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}

	public String getMod_dttm() {
		return mod_dttm;
	}

	public void setMod_dttm(String mod_dttm) {
		this.mod_dttm = mod_dttm;
	}

	public List<String> getNameList() {
		return nameList;
	}

	public void setNameList(List<String> nameList) {
		this.nameList = nameList;
	}

	public List<String> getCodeList() {
		return codeList;
	}

	public void setCodeList(List<String> codeList) {
		this.codeList = codeList;
	}
	

	public String getStation_id() {
		return station_id;
	}

	public void setStation_id(String station_id) {
		this.station_id = station_id;
	}

	@Override
	public String toString() {
		return "StationGroupMgmtVO [station_grp_seq=" + station_grp_seq
				+ " , station_grp_name=" + station_grp_name + " , cmd=" + cmd
				+ " , user=" + user + " , comptb_can_yn=" + comptb_can_yn
				+ " , main_station_id=" + main_station_id + " , mod_dttm="
				+ mod_dttm + " , station_id=" + station_id + " , lang_cls_cd="
				+ lang_cls_cd + " , lang=" + lang + " , nameList=" + nameList
				+ " , codeList=" + codeList + "]";
	}


	
	



	
}
