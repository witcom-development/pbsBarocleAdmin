package com.dkitec.barocle.admin.login.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.datasource.AES256anicar;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
/**
 * @Class Name : UserSessionVO.java
 * @Description : UserSessionVO Class
 */
@Alias("userInfoVo")
public class UserSessionVO extends PagingVO implements Serializable{
	static final long serialVersionUID = 6727378591268487378L;

	/** 사용자 ID	 */
	private String usrId;
	
	/** 사용그룹코드	 */
	private String usrGrpCd;
	
	/** 서비스 조회 권한 코드  */
	private String readAuthCd;
	
	/** 사용자 비밀번호  */
	private String encPasswd;

	/** 비밀번호 일치 여부  */
	private String passwdEqual;
	
	/** 사용자 명	 */
	private String usrName;
	
	/** 제휴 사업자 일련번호	 */
	private String patnrCmpySeq;
	
	/** 부서명*/
	private String deptName;

	
	/** 운영자 전화번호	 */
	private String oprTelNum1;
	/** 운영자 전화번호	 */
	private String oprTelNum2;
	/** 운영자 전화번호	 */
	private String oprTelNum3;

	/** 운영자 휴대폰 번호	 */
	private String oprPhone1;
	/** 운영자 휴대폰 번호	 */
	private String oprPhone2;
	/** 운영자 휴대폰 번호	 */
	private String oprPhone3;
	
	/** 운영자 휴대폰 번호 */
	private String mpnNo;
	/** 운영자 휴대폰 번호 복호화 */
	private String mpnNoDecrypt;
	
	/** 회원 이메일	 */
	private String email;	
	
	/** 사용여부	 */
	private String useYn;

	/** 생성일	 */
	private String regDate;

	/** 수정일자*/
	private String modDate;
	
	/** 사용자 설명 */
	private String userDesc;
	
	/** 메인페이지 URL */
	private String mainPageUrl;
	
	/** 로그인 실패 건 수 */
	private int loginFailCnt;
	
	/** 인증번호 */
	private String smsNum;
	
	/** 인증번호 확인 키 */
	private String smsKey;
	
	/** 사용그룹명 */
	private String usrGrpName;
	/** 사용자 IP */
	private String usrIp;
	/** 로그인일시*/
	private String loginDate;
	
	/** 팀 시퀄스*/
	private String teamSeq;
	
	/** 관리자 일련번호 */
	private String adminSeq;
	
	/** 마지막 로그인 날짜 **/
	private String lastLoginDate;
	
	/** 센터 Id **/
	private String centerId;
	
	/** 소속 정거장 그룹 ID **/
	private String assignStationGrpId;
	
	 public String getCenterId() {
		return centerId;
	}

	public void setCenterId(String centerId) {
		this.centerId = centerId;
	}

	public String getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(String lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

	private String accCrtlYn;
	    private String accCtrlPublIp;
	
	
	public String getLoginDate() {
		return loginDate;
	}

	public void setLoginDate(String loginDate) {
		this.loginDate = loginDate;
	}

	public String getUsrGrpName() {
		return usrGrpName;
	}

	public void setUsrGrpName(String usrGrpName) {
		this.usrGrpName = usrGrpName;
	}

	public String getUsrIp() {
		return usrIp;
	}

	public void setUsrIp(String usrIp) {
		this.usrIp = usrIp;
	}

	public String getSmsKey() {
		return smsKey;
	}

	public void setSmsKey(String smsKey) {
		this.smsKey = smsKey;
	}

	public String getSmsNum() {
		return smsNum;
	}

	public void setSmsNum(String smsNum) {
		this.smsNum = smsNum;
	}

	public int getLoginFailCnt() {
		return loginFailCnt;
	}

	public void setLoginFailCnt(int loginFailCnt) {
		this.loginFailCnt = loginFailCnt;
	}

	public String getPatnrCmpySeq() {
		return patnrCmpySeq;
	}

	public void setPatnrCmpySeq(String patnrCmpySeq) {
		this.patnrCmpySeq = patnrCmpySeq;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
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

	public String getReadAuthCd() {
		return readAuthCd;
	}

	public void setReadAuthCd(String readAuthCd) {
		this.readAuthCd = readAuthCd;
	}

	public String getEncPasswd() {
		return encPasswd;
	}

	public void setEncPasswd(String encPasswd) {
		this.encPasswd = encPasswd;
	}

	public String getPasswdEqual() {
		return passwdEqual;
	}

	public void setPasswdEqual(String passwdEqual) {
		this.passwdEqual = passwdEqual;
	}

	public String getUsrName() {
		return usrName;
	}

	public void setUsrName(String usrName) {
		this.usrName = usrName;
	}

	public String getOprTelNum1() {
		return oprTelNum1;
	}

	public void setOprTelNum1(String oprTelNum1) {
		this.oprTelNum1 = oprTelNum1;
	}

	public String getOprTelNum2() {
		return oprTelNum2;
	}

	public void setOprTelNum2(String oprTelNum2) {
		this.oprTelNum2 = oprTelNum2;
	}

	public String getOprTelNum3() {
		return oprTelNum3;
	}

	public void setOprTelNum3(String oprTelNum3) {
		this.oprTelNum3 = oprTelNum3;
	}

	public String getOprPhone1() {
		return oprPhone1;
	}

	public void setOprPhone1(String oprPhone1) {
		this.oprPhone1 = oprPhone1;
	}

	public String getOprPhone2() {
		return oprPhone2;
	}

	public void setOprPhone2(String oprPhone2) {
		this.oprPhone2 = oprPhone2;
	}

	public String getOprPhone3() {
		return oprPhone3;
	}

	public void setOprPhone3(String oprPhone3) {
		this.oprPhone3 = oprPhone3;
	}

	public String getEmail() {
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

	public String getUserDesc() {
		return userDesc;
	}

	public void setUserDesc(String userDesc) {
		this.userDesc = userDesc;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getMainPageUrl() {
		return mainPageUrl;
	}

	public void setMainPageUrl(String mainPageUrl) {
		this.mainPageUrl = mainPageUrl;
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

	public String getTeamSeq() {
		return teamSeq;
	}

	public void setTeamSeq(String teamSeq) {
		this.teamSeq = teamSeq;
	}

	public String getAdminSeq() {
		return adminSeq;
	}

	public void setAdminSeq(String adminSeq) {
		this.adminSeq = adminSeq;
	}

	public String getAccCrtlYn() {
		return accCrtlYn;
	}

	public void setAccCrtlYn(String accCrtlYn) {
		this.accCrtlYn = accCrtlYn;
	}

	public String getAccCtrlPublIp() {
		return accCtrlPublIp;
	}

	public void setAccCtrlPublIp(String accCtrlPublIp) {
		this.accCtrlPublIp = accCtrlPublIp;
	}

	public String getAssignStationGrpId() {
		return assignStationGrpId;
	}

	public void setAssignStationGrpId(String assignStationGrpId) {
		this.assignStationGrpId = assignStationGrpId;
	}
    
	
}
