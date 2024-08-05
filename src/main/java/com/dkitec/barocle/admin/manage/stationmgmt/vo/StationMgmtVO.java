package com.dkitec.barocle.admin.manage.stationmgmt.vo;

//import java.io.File;
import java.io.Serializable;
import java.util.List;

import javax.validation.GroupSequence;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.sms.SendType;
import com.dkitec.barocle.util.webutil.StringUtil;

@SuppressWarnings("serial")
public class StationMgmtVO extends PagingVO implements Serializable{
	
	
	public interface SearchUseYn{}
	public interface StationModifyCheck{}
	
	@GroupSequence({SearchStartDate.class,SearchEndDate.class, SearchValue.class, SearchUseYn.class})
	public static interface searchCheck{}
	
	@Size(max=15, message="15자 이하만 가능 합니다." , groups=StationModifyCheck.class)
	private String station_no;
	private String station_id;
	
	@Size(max=10, message="10자 이하만 가능 합니다." , groups=StationModifyCheck.class)
	private String station_grp_seq;
	
	@Size(max=10, message="10자 이하만 가능 합니다." , groups=StationModifyCheck.class)
	private String station_cls_cd;
	
	@Size(max=6, message="6자 이하만 가능 합니다." , groups=StationModifyCheck.class)
	private String station_post_no;
	
	@Size(max=200, message="200자 이하만 가능 합니다." , groups=StationModifyCheck.class)
	private String station_addr1;
	@Size(max=200, message="200자 이하만 가능 합니다." , groups=StationModifyCheck.class)
	private String station_addr2;
	
	@Pattern(regexp="Y|N" , message="잘못된 형식입니다.", groups=StationModifyCheck.class)
	private String station_use_yn;
	private String station_latitude;
	private String station_longitude;
	private String station_cls_cd_name;
	
	private String station_grp_name;
	private String station_name;
	private String lang_cls_cd;
	private String device_id;
	private String center_id;
	private String rockCnt;
	
	
	private String user;
	private String cmd;
	private String lang;
	private String excel;
	
	private List<String> nameList;
	private List<String> codeList;
	private List<String> stationGrpRemoteReturnList;
	
	private String[] station_grp_seq_list;
	private String[] remote_return_seq_list;
	private String[] remote_station_name_list;
	private String[] remote_latitude_list;
	private String[] remote_logitude_list;
	private String[] remote_use_yn_list;
	
	// 문자 전송 관련 변수 추가
	private String msg;
	private String destno;
	private String adminId;
	private String districtCd;
	
	// 20210118 추가
	private String noticeSeq;
	 
	public String getNoticeSeq() {
		return noticeSeq;
	}

	public void setNoticeSeq(String noticeSeq) {
		this.noticeSeq = noticeSeq;
	}

	@Size(max=7, message="7자 이하만 가능 합니다." , groups=SearchUseYn.class)
	private String search_gubun;
	
	@Size(max=20, message="20자 이하만 가능 합니다." , groups=SearchUseYn.class)
	private String search_name;
	
	@Size(max=10, message="10자 이하만 가능 합니다." , groups=SearchUseYn.class)
	@Pattern(regexp="^[0-9a-zA-Z]*$", message="특수문자는 사용할수 없습니다.", groups=SearchUseYn.class)  //영문+숫자만 허용
	private String search_grp;
	
	@Size(max=1, message="1자 이하만 가능 합니다." , groups=SearchUseYn.class)
	@Pattern(regexp="^[0-9a-zA-Z]*$", message="특수문자는 사용할수 없습니다.", groups=SearchUseYn.class)  //영문+숫자만 허용
	private String useYN;
	
	@Size(max=15, message="15자 이하만 가능 합니다." , groups=SearchUseYn.class)
	private String searchUse;


	private String name;
	private String group;
	private String gubun;
	private String stationGubun;
	
	private MultipartFile staImgFile;
	
	private String saveImg;
	
	private String station_img_file_name;
	
	private String orderColumn;
	
	private String orderType;
	
	//미사용 시간 설정
	private String unuse_str_dttm;
	
	private String unuse_end_dttm;

	private String histYn;
	
	private String reg_dttm;
	
	private String reg_id;
	
	private String memo;

	private String team_seq;
	
	//반경 추가 2019-10-24
	private String dstnc_lt;
	
	private String beaconId1;
	
	private String beaconId2;
	
	// 정거장 구분 추가 2020-01-03
	private String station_se_cd;
	
	private String rack_entrps_cd;
	
	private String reason;
	
	private String title;
	private String text;
	private String html;
	
	private String cnt;
	private String templateCd;
	
	private String remote_return_seq;
	private String remote_station_name;
	private String remote_latitude;
	private String remote_logitude;
	private String remote_use_yn;
	private String mod_dttm;
	private String mod_id;
	
	public String getRack_entrps_cd() {
		return rack_entrps_cd;
	}

	public void setRack_entrps_cd(String rack_entrps_cd) {
		this.rack_entrps_cd = rack_entrps_cd;
	}

	public String getStation_se_cd() {
		return station_se_cd;
	}

	public void setStation_se_cd(String station_se_cd) {
		this.station_se_cd = station_se_cd;
	}

	public String getBeaconId1() {
		return beaconId1;
	}

	public void setBeaconId1(String beaconId1) {
		this.beaconId1 = beaconId1;
	}

	public String getBeaconId2() {
		return beaconId2;
	}

	public void setBeaconId2(String beaconId2) {
		this.beaconId2 = beaconId2;
	}

	public String getTeam_seq() {
		return team_seq;
	}

	public void setTeam_seq(String team_seq) {
		this.team_seq = team_seq;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public String getGubun() {
		return gubun;
	}

	public void setGubun(String gubun) {
		this.gubun = gubun;
	}

	public String getStationGubun() {
		return stationGubun;
	}

	public void setStationGubun(String stationGubun) {
		this.stationGubun = stationGubun;
	}

	public String getExcel() {
		return excel;
	}

	public void setExcel(String excel) {
		this.excel = excel;
	}

	public String getLang() {
		return lang;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}

	public String getCmd() {
		return cmd;
	}

	public void setCmd(String cmd) {
		this.cmd = cmd;
	}

	public String getStation_no() {
		return station_no;
	}

	public void setStation_no(String station_no) {
		this.station_no = station_no;
	}

	public String getStation_id() {
		return station_id;
	}

	public void setStation_id(String station_id) {
		this.station_id = station_id;
	}

	public String getStation_grp_seq() {
		return station_grp_seq;
	}

	public void setStation_grp_seq(String station_grp_seq) {
		this.station_grp_seq = station_grp_seq;
	}

	public String getStation_cls_cd() {
		return station_cls_cd;
	}

	public void setStation_cls_cd(String station_cls_cd) {
		this.station_cls_cd = station_cls_cd;
	}

	public String getStation_post_no() {
		return station_post_no;
	}

	public void setStation_post_no(String station_post_no) {
		this.station_post_no = station_post_no;
	}

	public String getStation_addr1() {
		return station_addr1;
	}

	public void setStation_addr1(String station_addr1) {
		this.station_addr1 = station_addr1;
	}

	public String getStation_addr2() {
		return station_addr2;
	}

	public void setStation_addr2(String station_addr2) {
		this.station_addr2 = station_addr2;
	}

	public String getStation_use_yn() {
		return station_use_yn;
	}

	public void setStation_use_yn(String station_use_yn) {
		this.station_use_yn = station_use_yn;
	}

	public String getStation_latitude() {
		return station_latitude;
	}

	public void setStation_latitude(String station_latitude) {
		this.station_latitude = station_latitude;
	}

	public String getStation_longitude() {
		return station_longitude;
	}

	public void setStation_longitude(String station_longitude) {
		this.station_longitude = station_longitude;
	}

	public String getStation_name() {
		return station_name;
	}

	public void setStation_name(String station_name) {
		this.station_name = station_name;
	}

	public String getLang_cls_cd() {
		return lang_cls_cd;
	}

	public void setLang_cls_cd(String lang_cls_cd) {
		this.lang_cls_cd = lang_cls_cd;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
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
	

	public String getDevice_id() {
		return device_id;
	}

	public void setDevice_id(String device_id) {
		this.device_id = device_id;
	}

	public String getRockCnt() {
		return rockCnt;
	}

	public void setRockCnt(String rockCnt) {
		this.rockCnt = rockCnt;
	}

	public String getStation_grp_name() {
		return station_grp_name;
	}

	public void setStation_grp_name(String station_grp_name) {
		this.station_grp_name = station_grp_name;
	}

	public String getStation_cls_cd_name() {
		return station_cls_cd_name;
	}

	public void setStation_cls_cd_name(String station_cls_cd_name) {
		this.station_cls_cd_name = station_cls_cd_name;
	}
	

	public String getCenter_id() {
		return center_id;
	}

	public void setCenter_id(String center_id) {
		this.center_id = center_id;
	}

	
	public String getSearch_gubun() {
		return search_gubun;
	}

	public void setSearch_gubun(String search_gubun) {
		this.search_gubun = search_gubun;
	}

	public String getSearch_name() {
		return search_name;
	}

	public void setSearch_name(String search_name) {
		this.search_name = search_name;
	}

	public String getSearch_grp() {
		return search_grp;
	}

	public void setSearch_grp(String search_grp) {
		this.search_grp = search_grp;
	}

	public String getUseYN() {
		return useYN;
	}

	public void setUseYN(String useYN) {
		this.useYN = useYN;
	}

	public String getSearchUse() {
		return searchUse;
	}

	public void setSearchUse(String searchUse) {
		this.searchUse = searchUse;
	}
	
	public MultipartFile getStaImgFile() {
		return staImgFile;
	}

	public void setStaImgFile(MultipartFile staImgFile) {
		this.staImgFile = staImgFile;
	}

	
	public String getStation_img_file_name() {
		return station_img_file_name;
	}

	public void setStation_img_file_name(String station_img_file_name) {
		this.station_img_file_name = station_img_file_name;
	}

	public String getSaveImg() {
		return saveImg;
	}

	public void setSaveImg(String saveImg) {
		this.saveImg = saveImg;
	}

	

	@Override
	public String toString() {
		return "StationMgmtVO [station_no=" + station_no + " , station_id="
				+ station_id + " , station_grp_seq=" + station_grp_seq
				+ " , station_cls_cd=" + station_cls_cd + " , station_post_no="
				+ station_post_no + " , station_addr1=" + station_addr1
				+ " , station_addr2=" + station_addr2 + " , station_use_yn="
				+ station_use_yn + " , station_latitude=" + station_latitude
				+ " , station_longitude=" + station_longitude
				+ " , station_cls_cd_name=" + station_cls_cd_name
				+ " , station_grp_name=" + station_grp_name
				+ " , station_name=" + station_name + " , lang_cls_cd="
				+ lang_cls_cd + " , device_id=" + device_id + " , center_id="
				+ center_id + " , rockCnt=" + rockCnt + " , user=" + user
				+ " , cmd=" + cmd + " , lang=" + lang + " , nameList="
				+ nameList + " , codeList=" + codeList + " , search_gubun="
				+ search_gubun + " , search_name=" + search_name
				+ " , search_grp=" + search_grp + " , useYN=" + useYN
				+ " , unuse_str_dttm=" + unuse_str_dttm + " , unuse_end_dttm=" + unuse_end_dttm
				+ " , searchUse=" + searchUse+ " , histYn=" + histYn 
				+ " , title=" + title + " , text=" + text + " , html=" + html 
				+ " , msg=" + msg + " , destno=" + destno 
			+ " reason = " + reason
				+ " , cnt=" + cnt + " , templateCd=" + templateCd + ", noticeSeq = " + noticeSeq + "]";
	}

	public String getOrderColumn() {
		return orderColumn;
	}

	public void setOrderColumn(String orderColumn) {
		this.orderColumn = orderColumn;
	}

	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	public String getUnuse_str_dttm() {
		return unuse_str_dttm;
	}

	public void setUnuse_str_dttm(String unuse_str_dttm) {
		this.unuse_str_dttm = unuse_str_dttm;
	}

	public String getUnuse_end_dttm() {
		return unuse_end_dttm;
	}

	public void setUnuse_end_dttm(String unuse_end_dttm) {
		this.unuse_end_dttm = unuse_end_dttm;
	}
	
	public String getHistYn() {
		return histYn;
	}

	public void setHistYn(String histYn) {
		this.histYn = histYn;
	}

	public String getReg_dttm() {
		return reg_dttm;
	}

	public void setReg_dttm(String reg_dttm) {
		this.reg_dttm = reg_dttm;
	}

	public String getReg_id() {
		return reg_id;
	}

	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getDstnc_lt() {
		return dstnc_lt;
	}

	public void setDstnc_lt(String dstnc_lt) {
		this.dstnc_lt = dstnc_lt;
	}

	public String getReason() {
		return reason;
	} 

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getDestno() {
		return destno;
	}
	public void setDestno(String destno) {
		this.destno = destno;
	}
	
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getDistrictCd() {
		// TODO Auto-generated method stub
		return districtCd;
	}
	public void setDistrictCd(String districtCd) {
		this.districtCd = districtCd;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getHtml() {
		return html;
	}

	public void setHtml(String html) {
		this.html = html;
	}

	public String getCnt() {
		return cnt;
	}

	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	
	public String getTemplateCd() {
		return templateCd;
	}

	public void setTemplateCd(String templateCd) {
		this.templateCd = templateCd;
	}

	/*public void setTemplateCd1(SendType sms097) {
		// TODO Auto-generated method stub
		
	}
	public void setTemplateCd2(SendType sms099) {
		// TODO Auto-generated method stub
		
	}*/
	
	public boolean setTemplateCd(SendType sendType){
		boolean check = true;
		//this.autoSendId = sendType.getCode();
		
		String str = sendType.toString();
		//String str = SmsSender.getMsg(this.autoSendId);
		if(check){
			this.msg = str;
		}
		return check;
	}

	public String getRemote_latitude() {
		return remote_latitude;
	}

	public void setRemote_latitude(String remote_latitude) {
		this.remote_latitude = remote_latitude;
	}

	public String getRemote_logitude() {
		return remote_logitude;
	}

	public void setRemote_logitude(String remote_logitude) {
		this.remote_logitude = remote_logitude;
	}

	public String getRemote_use_yn() {
		return remote_use_yn;
	}

	public void setRemote_use_yn(String remote_use_yn) {
		this.remote_use_yn = remote_use_yn;
	}

	public String getRemote_station_name() {
		return remote_station_name;
	}

	public void setRemote_station_name(String remote_station_name) {
		this.remote_station_name = remote_station_name;
	}

	public String getMod_dttm() {
		return mod_dttm;
	}

	public void setMod_dttm(String mod_dttm) {
		this.mod_dttm = mod_dttm;
	}

	public String getMod_id() {
		return mod_id;
	}

	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

	public List<String> getStationGrpRemoteReturnList() {
		return stationGrpRemoteReturnList;
	}

	public void setStationGrpRemoteReturnList(
			List<String> stationGrpRemoteReturnList) {
		this.stationGrpRemoteReturnList = stationGrpRemoteReturnList;
	}
	
	public String[] getRemote_station_name_list() {
		return remote_station_name_list;
	}

	public void setRemote_station_name_list(String[] remote_station_name_list) {
		this.remote_station_name_list = remote_station_name_list;
	}

	public String[] getRemote_latitude_list() {
		return remote_latitude_list;
	}

	public void setRemote_latitude_list(String[] remote_latitude_list) {
		this.remote_latitude_list = remote_latitude_list;
	}

	public String[] getRemote_logitude_list() {
		return remote_logitude_list;
	}

	public void setRemote_logitude_list(String[] remote_logitude_list) {
		this.remote_logitude_list = remote_logitude_list;
	}

	public String[] getRemote_use_yn_list() {
		return remote_use_yn_list;
	}

	public void setRemote_use_yn_list(String[] remote_use_yn_list) {
		this.remote_use_yn_list = remote_use_yn_list;
	}

	public String[] getRemote_return_seq_list() {
		return remote_return_seq_list;
	}

	public void setRemote_return_seq_list(String[] remote_return_seq_list) {
		this.remote_return_seq_list = remote_return_seq_list;
	}

	public String getRemote_return_seq() {
		return remote_return_seq;
	}

	public void setRemote_return_seq(String remote_return_seq) {
		this.remote_return_seq = remote_return_seq;
	}

	public String[] getStation_grp_seq_list() {
		return station_grp_seq_list;
	}

	public void setStation_grp_seq_list(String[] station_grp_seq_list) {
		this.station_grp_seq_list = station_grp_seq_list;
	}
}