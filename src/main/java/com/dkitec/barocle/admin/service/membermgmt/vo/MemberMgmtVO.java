package com.dkitec.barocle.admin.service.membermgmt.vo;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;

@SuppressWarnings("serial")
@Alias("memberMgmtVO")
public class MemberMgmtVO extends PagingVO implements Serializable{
	
	private String lang;
	private String excel;
	private String usergubun;
	private String gubun;
	
	private String usr_seq;
	private String usr_birth_date;
	private String sex_cd;
	private String usr_cls_cd;
	private String reg_dttm;
	private String mb_id;
	private String telecom_cls_cd;
	private String mb_tel_no;
	private String mlang_com_cd_name;
	private String penalty_point;
	private List<String> mprNoList;
	
	private String usr_mpn_no;
	private String mpn_lost_yn;
	private String mb_wgt;
	private String mb_email_name;
	
	private String mb_card_no;
	private String card_type_cd;
	private String payment_method_cd;
	private String mpn_no;
	private String card_no;
	private String black_list;
	
	private String penalty_seq;
	private String penalty_desc;
	private String penalty_name;
	private String reg_id;
	
	private String mileage;
	private String mileage_point;
	private String mileage_cls_cd;
	private String mb_id_excel;
	private String card_use_cls_cd;
	private String bookDate;
	private String smsMsg;
	private String listType;

	
	private String rent_dttm;
	private String paymentClsCd;
	private String paymentClsCdName;
	private String readClsCd;
	
	private String phonNo;
	private String senderId;
	
	private String viewTel;			//수신전화버호
	private String sendAdminId;		//발송관리자
	private String sendDt;			//등록일
	private String msg;				//메세지
	private String stateChk;		//발송여부
	private String gwCode;			// KKO : 카카오, 나머지 : 문자

	private String re_station;		//대여소명(대여,반납)_20170109_cms
	private String using_purpose;	//이용목적_20170109_cms
	private String using_means;		//이용수단_20170109_cms
	
	private String carbon_seq;		//절감탄소 seq
	
	private String certYn;
	
	//법인 회원
	private String jurirNo;
	private String jurirFile;
	private String authYn;
	private String aFolder;							// 현패이지경로
	private String attachNm;						// 파일명
	private String imgName;
	private String imgUrl;
	
	private String push_yn;         		//push 알람 허용여부
	private String usr_device_type;         //push 기종 타입
	
	// 화면 타입
	private String main_type;
	
	private String voucher_seq;
	
	// 새싹회원 보호자 정보
	private String parent_sex_cd;
	private String parent_birth_date;
	private String parent_mpn_no;
	
	public String getParent_sex_cd() {
		return parent_sex_cd;
	}

	public void setParent_sex_cd(String parent_sex_cd) {
		this.parent_sex_cd = parent_sex_cd;
	}

	public String getParent_birth_date() {
		return parent_birth_date;
	}

	public void setParent_birth_date(String parent_birth_date) {
		this.parent_birth_date = parent_birth_date;
	}

	public String getParent_mpn_no() {
		return parent_mpn_no;
	}

	public void setParent_mpn_no(String parent_mpn_no) {
		this.parent_mpn_no = parent_mpn_no;
	}

	public String getMainType() {
		return main_type;
	}

	public void setMainType(String main_type) {
		this.main_type = main_type;
	}

	public String getGwCode() {
		return gwCode;
	}

	public void setGwCode(String gwCode) {
		this.gwCode = gwCode;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public String getImgName() {
		return imgName;
	}

	public void setImgName(String imgName) {
		this.imgName = imgName;
	}

	public String getAttachNm() {
		return attachNm;
	}

	public void setAttachNm(String attachNm) {
		this.attachNm = attachNm;
	}

	public String getaFolder() {
		return aFolder;
	}

	public void setaFolder(String aFolder) {
		this.aFolder = aFolder;
	}

	public String getTelecom_cls_cd() {
		return telecom_cls_cd;
	}

	public void setTelecom_cls_cd(String telecom_cls_cd) {
		this.telecom_cls_cd = telecom_cls_cd;
	}

	public String getCarbon_seq() {
		return carbon_seq;
	}

	public void setCarbon_seq(String carbon_seq) {
		this.carbon_seq = carbon_seq;
	}

	public String getCertYn() {
		return certYn;
	}

	public void setCertYn(String certYn) {
		this.certYn = certYn;
	}

	public String getRe_station() {
		return re_station;
	}

	public void setRe_station(String re_station) {
		this.re_station = re_station;
	}

	public String getUsing_purpose() {
		return using_purpose;
	}

	public void setUsing_purpose(String using_purpose) {
		this.using_purpose = using_purpose;
	}

	public String getUsing_means() {
		return using_means;
	}

	public void setUsing_means(String using_means) {
		this.using_means = using_means;
	}

	public String getViewTel() {
		return viewTel;
	}

	public void setViewTel(String viewTel) {
		this.viewTel = viewTel;
	}

	public String getSendAdminId() {
		return sendAdminId;
	}

	public void setSendAdminId(String sendAdminId) {
		this.sendAdminId = sendAdminId;
	}

	public String getSendDt() {
		return sendDt;
	}

	public void setSendDt(String sendDt) {
		this.sendDt = sendDt;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getStateChk() {
		return stateChk;
	}

	public void setStateChk(String stateChk) {
		this.stateChk = stateChk;
	}

	public String getSenderId() {
		return senderId;
	}

	public void setSenderId(String senderId) {
		this.senderId = senderId;
	}

	public String getPhonNo() {
		return phonNo;
	}

	public void setPhonNo(String phonNo) {
		this.phonNo = phonNo;
	}

	public String getRent_dttm() {
		return rent_dttm;
	}

	public void setRent_dttm(String rent_dttm) {
		this.rent_dttm = rent_dttm;
	}

	public String getPaymentClsCdName() {
		return paymentClsCdName;
	}

	public void setPaymentClsCdName(String paymentClsCdName) {
		this.paymentClsCdName = paymentClsCdName;
	}

	public String getReadClsCd() {
		return readClsCd;
	}

	public void setReadClsCd(String readClsCd) {
		this.readClsCd = readClsCd;
	}

	public String getPaymentClsCd() {
		return paymentClsCd;
	}

	public void setPaymentClsCd(String paymentClsCd) {
		this.paymentClsCd = paymentClsCd;
	}

	public String getBookDate() {
		return bookDate;
	}

	public void setBookDate(String bookDate) {
		this.bookDate = bookDate;
	}

	public String getSmsMsg() {
		return smsMsg;
	}

	public void setSmsMsg(String smsMsg) {
		this.smsMsg = smsMsg;
	}

	public List<String> getMprNoList() {
		return mprNoList;
	}

	public void setMprNoList(List<String> mprNoList) {
		this.mprNoList = mprNoList;
	}

	public String getMb_id_excel() {
		return mb_id_excel;
	}

	public void setMb_id_excel(String mb_id_excel) {
		this.mb_id_excel = mb_id_excel;
	}

	public String getCard_use_cls_cd() {
		return card_use_cls_cd;
	}

	public void setCard_use_cls_cd(String card_use_cls_cd) {
		this.card_use_cls_cd = card_use_cls_cd;
	}

	public String getExcel() {
		return excel;
	}

	public void setExcel(String excel) {
		this.excel = excel;
	}

	

	public String getUsergubun() {
		return usergubun;
	}

	public void setUsergubun(String usergubun) {
		this.usergubun = usergubun;
	}

	public String getGubun() {
		return gubun;
	}

	public void setGubun(String gubun) {
		this.gubun = gubun;
	}

	public String getMileage() {
		return mileage;
	}

	public void setMileage(String mileage) {
		this.mileage = mileage;
	}

	public String getLang() {
		return lang;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}

	public String getUsr_seq() {
		return usr_seq;
	}

	public void setUsr_seq(String usr_seq) {
		this.usr_seq = usr_seq;
	}

	public String getUsr_birth_date() {
		return usr_birth_date;
	}

	public void setUsr_birth_date(String usr_birth_date) {
		this.usr_birth_date = usr_birth_date;
	}

	public String getSex_cd() {
		return sex_cd;
	}

	public void setSex_cd(String sex_cd) {
		this.sex_cd = sex_cd;
	}

	public String getUsr_cls_cd() {
		return usr_cls_cd;
	}

	public void setUsr_cls_cd(String usr_cls_cd) {
		this.usr_cls_cd = usr_cls_cd;
	}

	public String getReg_dttm() {
		return reg_dttm;
	}

	public void setReg_dttm(String reg_dttm) {
		this.reg_dttm = reg_dttm;
	}

	public String getMb_id() {
		return mb_id;
	}

	public void setMb_id(String mb_id) {
		this.mb_id = mb_id;
	}

	public String getMb_tel_no() {
		return mb_tel_no;
	}

	public void setMb_tel_no(String mb_tel_no) {
		this.mb_tel_no = mb_tel_no;
	}
	public String getMlang_com_cd_name() {
		return mlang_com_cd_name;
	}

	public void setMlang_com_cd_name(String mlang_com_cd_name) {
		this.mlang_com_cd_name = mlang_com_cd_name;
	}

	public String getPenalty_point() {
		return penalty_point;
	}

	public void setPenalty_point(String penalty_point) {
		this.penalty_point = penalty_point;
	}
	

	public String getUsr_mpn_no() {
		return usr_mpn_no;
	}

	public void setUsr_mpn_no(String usr_mpn_no) {
		this.usr_mpn_no = usr_mpn_no;
	}

	public String getMpn_lost_yn() {
		return mpn_lost_yn;
	}

	public void setMpn_lost_yn(String mpn_lost_yn) {
		this.mpn_lost_yn = mpn_lost_yn;
	}

	public String getMb_wgt() {
		return mb_wgt;
	}

	public void setMb_wgt(String mb_wgt) {
		this.mb_wgt = mb_wgt;
	}

	public String getMb_email_name() {
		return mb_email_name;
	}

	public void setMb_email_name(String mb_email_name) {
		this.mb_email_name = mb_email_name;
	}

	
	public String getMb_card_no() {
		return mb_card_no;
	}

	public void setMb_card_no(String mb_card_no) {
		this.mb_card_no = mb_card_no;
	}

	public String getCard_type_cd() {
		return card_type_cd;
	}

	public void setCard_type_cd(String card_type_cd) {
		this.card_type_cd = card_type_cd;
	}

	public String getPayment_method_cd() {
		return payment_method_cd;
	}

	public void setPayment_method_cd(String payment_method_cd) {
		this.payment_method_cd = payment_method_cd;
	}

	public String getMpn_no() {
		return mpn_no;
	}

	public void setMpn_no(String mpn_no) {
		this.mpn_no = mpn_no;
	}

	public String getCard_no() {
		return card_no;
	}

	public void setCard_no(String card_no) {
		this.card_no = card_no;
	}
	

	public String getBlack_list() {
		return black_list;
	}

	public void setBlack_list(String black_list) {
		this.black_list = black_list;
	}

	public String getPenalty_seq() {
		return penalty_seq;
	}

	public void setPenalty_seq(String penalty_seq) {
		this.penalty_seq = penalty_seq;
	}

	public String getPenalty_desc() {
		return penalty_desc;
	}

	public void setPenalty_desc(String penalty_desc) {
		this.penalty_desc = penalty_desc;
	}

	public String getPenalty_name() {
		return penalty_name;
	}

	public void setPenalty_name(String penalty_name) {
		this.penalty_name = penalty_name;
	}

	public String getReg_id() {
		return reg_id;
	}

	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}

	public String getMileage_point() {
		return mileage_point;
	}

	public void setMileage_point(String mileage_point) {
		this.mileage_point = mileage_point;
	}

	
	public String getMileage_cls_cd() {
		return mileage_cls_cd;
	}

	public void setMileage_cls_cd(String mileage_cls_cd) {
		this.mileage_cls_cd = mileage_cls_cd;
	}
	
	

	public String getListType() {
		return listType;
	}

	public void setListType(String listType) {
		this.listType = listType;
	}

	@Override
	public String toString() {
		return "MemberMgmtVO [lang=" + lang + ", excel=" + excel
				+ ", usergubun=" + usergubun + ", gubun=" + gubun
				+ ", usr_seq=" + usr_seq + ", usr_birth_date=" + usr_birth_date
				+ ", sex_cd=" + sex_cd + ", usr_cls_cd=" + usr_cls_cd
				+ ", reg_dttm=" + reg_dttm + ", mb_id=" + mb_id
				+ ", mb_tel_no=" + mb_tel_no + ", mlang_com_cd_name="
				+ mlang_com_cd_name + ", penalty_point=" + penalty_point
				+ ", mprNoList=" + mprNoList + ", usr_mpn_no=" + usr_mpn_no
				+ ", mpn_lost_yn=" + mpn_lost_yn + ", mb_wgt=" + mb_wgt
				+ ", mb_email_name=" + mb_email_name + ", mb_card_no="
				+ mb_card_no + ", card_type_cd=" + card_type_cd
				+ ", payment_method_cd=" + payment_method_cd + ", mpn_no="
				+ mpn_no + ", card_no=" + card_no + ", black_list="
				+ black_list + ", penalty_seq=" + penalty_seq
				+ ", penalty_desc=" + penalty_desc + ", penalty_name="
				+ penalty_name + ", reg_id=" + reg_id + ", mileage=" + mileage
				+ ", mileage_point=" + mileage_point + ", mileage_cls_cd="
				+ mileage_cls_cd + ", mb_id_excel=" + mb_id_excel
				+ ", card_use_cls_cd=" + card_use_cls_cd + ", bookDate="
				+ bookDate + ", smsMsg=" + smsMsg + ", listType=" + listType
				+ ", rent_dttm=" + rent_dttm + ", paymentClsCd=" + paymentClsCd
				+ ", paymentClsCdName=" + paymentClsCdName + ", readClsCd="
				+ readClsCd + ", phonNo=" + phonNo + ", senderId=" + senderId
				+ ", viewTel=" + viewTel + ", sendAdminId=" + sendAdminId
				+ ", sendDt=" + sendDt + ", msg=" + msg + ", stateChk="
				+ stateChk + "telecom_cls_cd="+ telecom_cls_cd    
				+ " , mainType = " + main_type + "]";
	}

	public String getJurirNo() {
		return jurirNo;
	}

	public void setJurirNo(String jurirNo) {
		this.jurirNo = jurirNo;
	}

	public String getJurirFile() {
		return jurirFile;
	}

	public void setJurirFile(String jurirFile) {
		this.jurirFile = jurirFile;
	}

	public String getAuthYn() {
		return authYn;
	}

	public void setAuthYn(String authYn) {
		this.authYn = authYn;
	}

	public String getPush_yn() {
		return push_yn;
	}

	public void setPush_yn(String push_yn) {
		this.push_yn = push_yn;
	}

	public String getUsr_device_type() {
		return usr_device_type;
	}

	public void setUsr_device_type(String usr_device_type) {
		this.usr_device_type = usr_device_type;
	}

	public String getVoucher_seq() {
		return voucher_seq;
	}

	public void setVoucher_seq(String voucher_seq) {
		this.voucher_seq = voucher_seq;
	}

	
	

}
