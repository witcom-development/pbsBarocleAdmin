package com.dkitec.barocle.admin.system.usermgmt.vo;

import java.io.Serializable;
import java.util.Arrays;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.datasource.AES256anicar;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias(value="userMgmtVO")
public class UserMgmtVO extends PagingVO implements Serializable{

    private static final long serialVersionUID = 1L;
    
    /** 조회조건*/
    /** */
    private String searchPatnrCmpyName;
    
    private String searchType;
    
    private String searchUsrName;
    
    private String searchUsrGrpCd;
    
    private String searchDeptName;
    
    private String searchUsrId;
    
    private String[] excelIds;
    
    private String admin_card_no;
    private String email_recv_yn;
    private String admin_grp_seq;
    private String assign_station_id;
    private String assign_center_id;
    private String PasswdClear;
    
    
    private String accs_ctrl_yn;
    private String accs_ctrl_publ_ip;
    
//    private String ;
    
    /** 사용자 ID	 */
    @Size(min=3, max=20, message="사용자 ID는 2자리 이상 20자 이하만 가능 합니다.")
    @Pattern(regexp="^[a-zA-z가-힣]{1}[\\w가-힣]{1,19}$" , message="사용자 ID는 영문자 혹은 한글로 시작하며, 영문와 한글, 숫자 조합만 가능 합니다.")
	private String usrId;

	/** 그룹코드	 */
	private String usrGrpCd;

	/** 그룹 명	 */
	private String grpName;

	/** 사용자 비밀번호  */
	private String encPwd;
	
	/** 비밀번호 변경 여부  */
	private String pwdChangeY;
	
	/** 사용자 명	 */
	private String usrName;
	
	/** 제휴 사업자 일련번호	 */
	private String patnrCmpySeq;
	
	/** 제휴 사업자 명	 */
	private String patnrCmpyName;
	
	/** 부서명*/
	@Size(max=20, message="부서명은 1자리 이상 20자 이하만 가능 합니다.")
    @Pattern(regexp="^[\\w가-힣_\\-() ]{0,20}$" , message="부서명은 영문, 한글, 숫자, -, _, (, ), 공백 조합만 가능합니다.")
	private String deptName;

	/** 운영자 전화번호	 */
	@Size(min=9, max=11, message="운영자 전화번호는 9자리 이상 11자리 이하만 가능 합니다.")
    @Pattern(regexp="^0[1-9]{1}[0-9]{0,1}[1-9]{1}[0-9]{2,3}[0-9]{4}$" , message="운영자 전화번호 각 자리는 숫자만 가능합니다.")
	private String phoneNo;
	/** 운영자 전화번호	 */
	private String phoneNoDecrypt;

	/** 운영자 휴대폰 번호	 */
	@Size(min=10, max=11, message="운영자 휴대폰 번호는 10자리 이상 11자리 이하만 가능 합니다.")
	private String mpnNo;
	/** 운영자 휴대폰 번호	 */
	private String mpnNoDecrypt;
	private String mpn_no;
	/** 회원 이메일	 */
	@Size(max=100, message="운영자 email은 100자리 이하만 가능 합니다.")
    @Pattern(regexp="^[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(.[_0-9a-zA-Z-]+){1,2}$" , message="운영자 이메일 형식을 확인하세요.")
	private String email;	
	
	/** 사용여부	 */
	@Size(max=1, message="사용여부는 1자리 이하만 가능 합니다.")
    @Pattern(regexp="^[YN ]$" , message="사용여부 값을 확인하세요.")
	private String useYn;

	/** 생성일	 */
	private String regDate;

	/** 수정일자*/
	private String modDate;
	
	/** 제휴 담당장_내 정보 관리 페이지 비밀번호 확인 값*/
	private String checkSum;
	
	private String pageIndex;
	
	private String adminCardPwd;
	
	// 재배치차량 정보, 관리자 등록/수정 ID_20160715_JJH_START
	private String relocateCarCd;
	
	private String cre_Id;
	
	private String mod_Id;
	
	private String preUseYn;
	
	// 배송 팀 관련 정보 추가 
	private String center_id;
	private String team_id;
	
	// 관리자 테이블 팀seq
	private String team_seq;
	
	// 소속 대여소 그룹 아이디
	private String assignStationGrpId;
	
	
	public String getTeam_seq() {
		return team_seq;
	}

	public void setTeam_seq(String team_seq) {
		this.team_seq = team_seq;
	}

	public String getCenter_id() {
		return center_id;
	}

	public void setCenter_id(String center_id) {
		this.center_id = center_id;
	}

	public String getTeam_id() {
		return team_id;
	}

	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}

	public String getRelocateCarCd() {
		return relocateCarCd;
	}

	public void setRelocateCarCd(String relocateCarCd) {
		this.relocateCarCd = relocateCarCd;
	}
	
	public String getCre_Id() {
		return cre_Id;
	}

	public void setCre_Id(String cre_Id) {
		this.cre_Id = cre_Id;
	}

	public String getMod_Id() {
		return mod_Id;
	}

	public void setMod_Id(String mod_Id) {
		this.mod_Id = mod_Id;
	}
	// 재배치차량 정보_20160715_JJH_END

	public String getMpn_no() {
		return mpn_no;
	}

	public void setMpn_no(String mpn_no) {
		this.mpn_no = mpn_no;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(String pageIndex) {
		this.pageIndex = pageIndex;
	}

	public String getCheckSum() {
		return checkSum;
	}

	public void setCheckSum(String checkSum) {
		this.checkSum = checkSum;
	}

	public String getSearchPatnrCmpyName() {
		return searchPatnrCmpyName;
	}

	public void setSearchPatnrCmpyName(String searchPatnrCmpyName) {
		this.searchPatnrCmpyName = searchPatnrCmpyName;
	}

	public String getSearchUsrName() {
		return searchUsrName;
	}

	public void setSearchUsrName(String searchUsrName) {
		this.searchUsrName = searchUsrName;
	}

	public String getSearchUsrGrpCd() {
		return searchUsrGrpCd;
	}

	public void setSearchUsrGrpCd(String searchUsrGrpCd) {
		this.searchUsrGrpCd = searchUsrGrpCd;
	}

	public String getSearchDeptName() {
		return searchDeptName;
	}

	public void setSearchDeptName(String searchDeptName) {
		this.searchDeptName = searchDeptName;
	}

	public String getSearchUsrId() {
		return searchUsrId;
	}

	public void setSearchUsrId(String searchUsrId) {
		this.searchUsrId = searchUsrId;
	}

	public String[] getExcelIds() {
		return excelIds;
	}

	public void setExcelIds(String[] excelIds) {
		this.excelIds = excelIds;
	}

	public void setPhoneNoDecrypt(String phoneNoDecrypt) {
		this.phoneNoDecrypt = phoneNoDecrypt;
	}

	public void setMpnNoDecrypt(String mpnNoDecrypt) {
		this.mpnNoDecrypt = mpnNoDecrypt;
	}

	public String getUsrId() {
		return usrId;
	}

	public void setUsrId(String usrId) {
		this.usrId = usrId;
	}

	public String getUsrGrpCd() {
		return usrGrpCd;
	}

	public void setUsrGrpCd(String usrGrpCd) {
		this.usrGrpCd = usrGrpCd;
	}
	
	public String getGrpName() {
		return grpName;
	}

	public void setGrpName(String grpName) {
		this.grpName = grpName;
	}
	
	public String getEncPwd() {
		return encPwd;
	}

	public void setEncPwd(String encPwd) {
		this.encPwd = encPwd;
	}

	public String getPwdChangeY() {
		return pwdChangeY;
	}

	public void setPwdChangeY(String pwdChangeY) {
		this.pwdChangeY = pwdChangeY;
	}

	public String getUsrName() {
		return usrName;
	}

	public void setUsrName(String usrName) {
		this.usrName = usrName;
	}

	public String getPatnrCmpySeq() {
		return patnrCmpySeq;
	}

	public void setPatnrCmpySeq(String patnrCmpySeq) {
		this.patnrCmpySeq = patnrCmpySeq;
	}

	public String getPatnrCmpyName() {
		return patnrCmpyName;
	}

	public void setPatnrCmpyName(String patnrCmpyName) {
		this.patnrCmpyName = patnrCmpyName;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	private void setPhoneNoDecrypt(){
		phoneNoDecrypt = "";
		if(phoneNo != null && phoneNo.length()>0){
			try {
				phoneNoDecrypt = AES256anicar.decrypt(this.phoneNo);
			} catch (Exception e) {
			}
		}
	}
	
	public String getPhoneNoDecrypt(){
		if(this.phoneNoDecrypt == null || this.phoneNoDecrypt.length() == 0){
			setPhoneNoDecrypt();
		}
		return phoneNoDecrypt;
	}
	


	public String getMpnNo() {
		return mpnNo;
	}

	public void setMpnNo(String mpnNo) {
		this.mpnNo = mpnNo;
	}
	
	private void setMpnNoDecrypt(){
		mpnNoDecrypt = "";
		if(mpnNo != null && mpnNo.length()>0){
			try {
				mpnNoDecrypt = AES256anicar.decrypt(this.mpnNo);
			} catch (Exception e) {
			}
		}
	}
	
	public String getMpnNoDecrypt(){
		if(this.mpnNoDecrypt == null || this.mpnNoDecrypt.length() == 0){
			setMpnNoDecrypt();
		}
		return mpnNoDecrypt;
	}

	

	public String getEmail() {
		return email;
	}
	
	public String getEmailDecrypt() {
		if(email != null && email.length()>0){
			try {
				email = AES256anicar.decrypt(this.email);
			} catch (Exception e) {
				email = "";
			}
		}
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getModDate() {
		return modDate;
	}

	public void setModDate(String modDate) {
		this.modDate = modDate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
	public String getAdmin_card_no() {
		return admin_card_no;
	}

	public void setAdmin_card_no(String admin_card_no) {
		this.admin_card_no = admin_card_no;
	}

	
	public String getEmail_recv_yn() {
		return email_recv_yn;
	}

	public void setEmail_recv_yn(String email_recv_yn) {
		this.email_recv_yn = email_recv_yn;
	}

	public String getAdmin_grp_seq() {
		return admin_grp_seq;
	}

	public void setAdmin_grp_seq(String admin_grp_seq) {
		this.admin_grp_seq = admin_grp_seq;
	}

	public String getAssign_station_id() {
		return assign_station_id;
	}

	public void setAssign_station_id(String assign_station_id) {
		this.assign_station_id = assign_station_id;
	}

	public String getAssign_center_id() {
		return assign_center_id;
	}

	public void setAssign_center_id(String assign_center_id) {
		this.assign_center_id = assign_center_id;
	}
	

	public String getPasswdClear() {
		return PasswdClear;
	}

	public void setPasswdClear(String passwdClear) {
		PasswdClear = passwdClear;
	}
	
	public String getAccs_ctrl_yn() {
		return accs_ctrl_yn;
	}

	public void setAccs_ctrl_yn(String accs_ctrl_yn) {
		this.accs_ctrl_yn = accs_ctrl_yn;
	}

	public String getAccs_ctrl_publ_ip() {
		return accs_ctrl_publ_ip;
	}

	public void setAccs_ctrl_publ_ip(String accs_ctrl_publ_ip) {
		this.accs_ctrl_publ_ip = accs_ctrl_publ_ip;
	}

	
	public String getAdminCardPwd() {
		return adminCardPwd;
	}

	public void setAdminCardPwd(String adminCardPwd) {
		this.adminCardPwd = adminCardPwd;
	}

	public String getPreUseYn() {
		return preUseYn;
	}

	public void setPreUseYn(String preUseYn) {
		this.preUseYn = preUseYn;
	}

	@Override
	public String toString() {
		return "UserMgmtVO [searchPatnrCmpyName=" + searchPatnrCmpyName
				+ ", searchType=" + searchType + ", searchUsrName="
				+ searchUsrName + ", searchUsrGrpCd=" + searchUsrGrpCd
				+ ", searchDeptName=" + searchDeptName + ", searchUsrId="
				+ searchUsrId + ", excelIds=" + Arrays.toString(excelIds)
				+ ", admin_card_no=" + admin_card_no + ", email_recv_yn="
				+ email_recv_yn + ", admin_grp_seq=" + admin_grp_seq
				+ ", assign_station_id=" + assign_station_id
				+ ", assign_center_id=" + assign_center_id + ", PasswdClear="
				+ PasswdClear + ", accs_ctrl_yn=" + accs_ctrl_yn
				+ ", accs_ctrl_publ_ip=" + accs_ctrl_publ_ip + ", usrId="
				+ usrId + ", usrGrpCd=" + usrGrpCd + ", grpName=" + grpName
				+ ", encPwd=" + encPwd + ", pwdChangeY=" + pwdChangeY
				+ ", usrName=" + usrName + ", patnrCmpySeq=" + patnrCmpySeq
				+ ", patnrCmpyName=" + patnrCmpyName + ", deptName=" + deptName
				+ ", phoneNo=" + phoneNo + ", phoneNoDecrypt=" + phoneNoDecrypt
				+ ", mpnNo=" + mpnNo + ", mpnNoDecrypt=" + mpnNoDecrypt
				+ ", mpn_no=" + mpn_no + ", email=" + email + ", useYn="
				+ useYn + ", regDate=" + regDate + ", modDate=" + modDate
				+ ", checkSum=" + checkSum + ", pageIndex=" + pageIndex
				+ ", adminCardPwd=" + adminCardPwd + ", relocateCarCd="
				+ relocateCarCd + ", cre_Id=" + cre_Id + ", mod_Id=" + mod_Id +", preUseYn=" + preUseYn
				+ "]";
	}

	public String getAssignStationGrpId() {
		return assignStationGrpId;
	}

	public void setAssignStationGrpId(String assignStationGrpId) {
		this.assignStationGrpId = assignStationGrpId;
	}
	
}
