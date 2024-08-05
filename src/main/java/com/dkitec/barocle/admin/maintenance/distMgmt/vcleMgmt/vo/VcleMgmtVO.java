package com.dkitec.barocle.admin.maintenance.distMgmt.vcleMgmt.vo;
import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("VcleMgmtVO")
public class VcleMgmtVO extends CommonVo implements Serializable{

	/* TB_MTC_VCLE_DISPATCH */
	private String vcleDate;		//운행날짜
	private String refuel;			//주유량
	private String shiftWorkCd; 	//오전조, 오후조 ...(공통코드 교대근무)
	private String adminId;			//탑승자 아이디
	
	public String getNotice() {
		return notice;
	}

	public void setNotice(String notice) {
		this.notice = notice;
	}

	public String getNotice1() {
		return notice1;
	}

	public void setNotice1(String notice1) {
		this.notice1 = notice1;
	}

	public String getNotice2() {
		return notice2;
	}

	public void setNotice2(String notice2) {
		this.notice2 = notice2;
	}

	public String getNotice3() {
		return notice3;
	}

	public void setNotice3(String notice3) {
		this.notice3 = notice3;
	}

	public String getDelYN() {
		return delYN;
	}

	public void setDelYN(String delYN) {
		this.delYN = delYN;
	}

	public String getDelYN1() {
		return delYN1;
	}

	public void setDelYN1(String delYN1) {
		this.delYN1 = delYN1;
	}

	public String getDelYN2() {
		return delYN2;
	}

	public void setDelYN2(String delYN2) {
		this.delYN2 = delYN2;
	}

	public String getDelYN3() {
		return delYN3;
	}

	public void setDelYN3(String delYN3) {
		this.delYN3 = delYN3;
	}

	private String notice;
	private String notice1;
	private String notice2;
	private String notice3;
	
	
	private String delYN;
	private String delYN1;
	private String delYN2;
	private String delYN3;
	
	
	/* TB_MTC_VCLE_DISPATCH_DTL */
	
	private String vcleNo;			//차량번호
	private String vcleNo1;			//차량번호
	private String vcleNo2;			//차량번호
	private String vcleNo3;			//차량번호
	
	private String startTime;		//운행시작
	private String startTime1;		//운행시작
	private String startTime2;		//운행시작
	private String startTime3;		//운행시작

	private String endTime;			//운행종료
	private String endTime1;			//운행종료
	private String endTime2;			//운행종료
	private String endTime3;		//운행종료	
	
	private String bfMileage;		//출고 시 주행거리
	private String afMileage;		//입고 시 주행거리
	private String bfMileage1;		//출고 시 주행거리
	private String afMileage1;		//입고 시 주행거리	
	private String bfMileage2;		//출고 시 주행거리
	private String afMileage2;		//입고 시 주행거리
	
	private String driverType;		//탑승 종류 : 운전자(A) / 동승자(B)
	private String driverType1;		//탑승 종류 : 운전자(A) / 동승자(B)
	private String driverType2;		//탑승 종류 : 운전자(A) / 동승자(B)
	
	private String vcleSeq;			//FK
	
	private String regDttm;			//등록 날짜
	private String regId;			//등록자 아이디
	private String modDttm;			//수정 날짜
	private String modId;			//수정자 아이디
	
	/* TB_SYS_VCLE_INFO */
	private String vcleNoSeq;		//차량일련번호
	private String vcleNoSeq1;		//차량일련번호
	private String vcleNoSeq2;		//차량일련번호
	private String vcleType;		//차종
	private String refuelType;		//유종
	private String modelYeal;		//연식
	private String etc;				//기타
	private String useYn;			//사용여부
	private String centerId;		//센터 아이디
	private String teamId;			//팀 아이디
	private String vcleStusCd;		//차량상태 : 입고, 출고....
	
	/* search */
	private String searchAdmin;		//탑승자 검색
	private String searchVcleNo;	//차량번호 검색
	private String searchBgnDe;		// 조회시작일자
	private String searchEndDe;		// 조회종료일자


	public String getSearchEndDe() {
		return searchEndDe;
	}

	public void setSearchEndDe(String searchEndDe) {
		this.searchEndDe = searchEndDe;
	}

	//
	private String driverName;		//운전자이름
	private String adminNames;		//동승자들 이름
	
	//
	private String vcleStusCdName;	//차량상태 코드 이름
	private String shiftWorkCdName; //교대근무 공통코드 이름

	
	public String getSearchBgnDe() {
		return searchBgnDe;
	}

	public void setSearchBgnDe(String searchBgnDe) {
		this.searchBgnDe = searchBgnDe;
	}
	
	
	
	
	public String getDriverType1() {
		return driverType1;
	}

	public void setDriverType1(String driverType1) {
		this.driverType1 = driverType1;
	}

	public String getDriverType2() {
		return driverType2;
	}

	public void setDriverType2(String driverType2) {
		this.driverType2 = driverType2;
	}
	
	public String getVcleNo1() {
		return vcleNo1;
	}

	public void setVcleNo1(String vcleNo1) {
		this.vcleNo1 = vcleNo1;
	}

	public String getVcleNo2() {
		return vcleNo2;
	}

	public void setVcleNo2(String vcleNo2) {
		this.vcleNo2 = vcleNo2;
	}

	public String getVcleNo3() {
		return vcleNo3;
	}

	public void setVcleNo3(String vcleNo3) {
		this.vcleNo3 = vcleNo3;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getStartTime1() {
		return startTime1;
	}

	public void setStartTime1(String startTime1) {
		this.startTime1 = startTime1;
	}

	public String getStartTime2() {
		return startTime2;
	}

	public void setStartTime2(String startTime2) {
		this.startTime2 = startTime2;
	}

	public String getStartTime3() {
		return startTime3;
	}

	public void setStartTime3(String startTime3) {
		this.startTime3 = startTime3;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getEndTime1() {
		return endTime1;
	}

	public void setEndTime1(String endTime1) {
		this.endTime1 = endTime1;
	}

	public String getEndTime2() {
		return endTime2;
	}

	public void setEndTime2(String endTime2) {
		this.endTime2 = endTime2;
	}

	public String getEndTime3() {
		return endTime3;
	}

	public void setEndTime3(String endTime3) {
		this.endTime3 = endTime3;
	}
	
	public String getVcleNo() {
		return vcleNo;
	}

	public void setVcleNo(String vcleNo) {
		this.vcleNo = vcleNo;
	}

	public String getVcleDate() {
		return vcleDate;
	}

	public void setVcleDate(String vcleDate) {
		this.vcleDate = vcleDate;
	}

	public String getRefuel() {
		return refuel;
	}

	public void setRefuel(String refuel) {
		this.refuel = refuel;
	}

	public String getVcleSeq() {
		return vcleSeq;
	}

	public void setVcleSeq(String vcleSeq) {
		this.vcleSeq = vcleSeq;
	}
	
	public String getVcleNoSeq1() {
		return vcleNoSeq1;
	}

	public void setVcleNoSeq1(String vcleNoSeq1) {
		this.vcleNoSeq1 = vcleNoSeq1;
	}

	public String getVcleNoSeq2() {
		return vcleNoSeq2;
	}

	public void setVcleNoSeq2(String vcleNoSeq2) {
		this.vcleNoSeq2 = vcleNoSeq2;
	}


	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}


	public String getRegDttm() {
		return regDttm;
	}

	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public String getModDttm() {
		return modDttm;
	}

	public void setModDttm(String modDttm) {
		this.modDttm = modDttm;
	}

	public String getModId() {
		return modId;
	}

	public void setModId(String modId) {
		this.modId = modId;
	}

	public String getSearchAdmin() {
		return searchAdmin;
	}

	public void setSearchAdmin(String searchAdmin) {
		this.searchAdmin = searchAdmin;
	}

	public String getDriverName() {
		return driverName;
	}

	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}

	public String getAdminNames() {
		return adminNames;
	}

	public void setAdminNames(String adminNames) {
		this.adminNames = adminNames;
	}

	public String getSearchVcleNo() {
		return searchVcleNo;
	}

	public void setSearchVcleNo(String searchVcleNo) {
		this.searchVcleNo = searchVcleNo;
	}

	public String getBfMileage1() {
		return bfMileage1;
	}

	public void setBfMileage1(String bfMileage1) {
		this.bfMileage1 = bfMileage1;
	}

	public String getAfMileage1() {
		return afMileage1;
	}

	public void setAfMileage1(String afMileage1) {
		this.afMileage1 = afMileage1;
	}

	public String getBfMileage2() {
		return bfMileage2;
	}

	public void setBfMileage2(String bfMileage2) {
		this.bfMileage2 = bfMileage2;
	}

	public String getAfMileage2() {
		return afMileage2;
	}

	public void setAfMileage2(String afMileage2) {
		this.afMileage2 = afMileage2;
	}
	
	public String getDriverType() {
		return driverType;
	}

	public void setDriverType(String driverType) {
		this.driverType = driverType;
	}

	public String getVcleNoSeq() {
		return vcleNoSeq;
	}

	public void setVcleNoSeq(String vcleNoSeq) {
		this.vcleNoSeq = vcleNoSeq;
	}

	public String getVcleType() {
		return vcleType;
	}

	public void setVcleType(String vcleType) {
		this.vcleType = vcleType;
	}

	public String getRefuelType() {
		return refuelType;
	}

	public void setRefuelType(String refuelType) {
		this.refuelType = refuelType;
	}

	public String getModelYeal() {
		return modelYeal;
	}

	public void setModelYeal(String modelYeal) {
		this.modelYeal = modelYeal;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getCenterId() {
		return centerId;
	}

	public void setCenterId(String centerId) {
		this.centerId = centerId;
	}

	public String getTeamId() {
		return teamId;
	}

	public void setTeamId(String teamId) {
		this.teamId = teamId;
	}

	public String getVcleStusCd() {
		return vcleStusCd;
	}

	public void setVcleStusCd(String vcleStusCd) {
		this.vcleStusCd = vcleStusCd;
	}

	public String getShiftWorkCd() {
		return shiftWorkCd;
	}

	public void setShiftWorkCd(String shiftWorkCd) {
		this.shiftWorkCd = shiftWorkCd;
	}

	public String getBfMileage() {
		return bfMileage;
	}

	public void setBfMileage(String bfMileage) {
		this.bfMileage = bfMileage;
	}

	public String getAfMileage() {
		return afMileage;
	}

	public void setAfMileage(String afMileage) {
		this.afMileage = afMileage;
	}

	public String getVcleStusCdName() {
		return vcleStusCdName;
	}

	public void setVcleStusCdName(String vcleStusCdName) {
		this.vcleStusCdName = vcleStusCdName;
	}

	public String getShiftWorkCdName() {
		return shiftWorkCdName;
	}

	public void setShiftWorkCdName(String shiftWorkCdName) {
		this.shiftWorkCdName = shiftWorkCdName;
	}

}
