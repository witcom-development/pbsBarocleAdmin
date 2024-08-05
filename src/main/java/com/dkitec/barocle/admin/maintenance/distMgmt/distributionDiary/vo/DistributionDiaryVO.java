package com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo;
import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("distributionDiaryVo")
public class DistributionDiaryVO extends CommonVo implements Serializable{
	
	/* 배송원정보 */
	private String adminId;			//배송원 아이디
	private String adminName;		//배송원 이름
	
	
	private String officeName;		//사업소이름
	
	public String getOfficeName() {
		return officeName;
	}
	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	private String centerId;
	private String centerName;		//센터 이름
	private String teamName;		//팀 이름
	private String teamSeq;			// 팀번호
	
	private String weather;			// 날씨정보
	
	public String getWeather() {
		return weather;
	}
	public void setWeather(String weather) {
		this.weather = weather;
	}
	
	private String vcleNo;			//차량번호
	private String refuel;			//주유량
	private String bfMileage;		//출고 시 주행거리
	private String afMileage;		//입고 시 주행거리
	private String startTime;
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	private String endTime;
	
	/* 주요실적 */
	private String onSiteActionCnt;	//현장조치
	private String bikeRobbedCnt;   //자전거없음
	private String bikeMoveCnt;		//자전거이동
	private String bikeReplaceCnt;	//재배치
	private String warehousingCnt;  //입고
	
	/* 분배목록 */
	private String workTime;		//작업시간
	private String workPlace;		//작업장소
	private String workClassifi;	//작업구분
	private String bikeNo;			//자전거번호
	private String etc;				//비고
	
	/* 분배원 실적용 */
	private String searchVcleNo;			//차량번호
	
	public String getSearchVcleNo() {
		return searchVcleNo;
	}
	public void setSearchVcleNo(String searchVcleNo) {
		this.searchVcleNo = searchVcleNo;
	}
	private String darTp001Cnt;
	private String darTp002Cnt;
	private String darTp003Cnt;
	private String darTp004Cnt;
	private String darTp005Cnt;
	private String darTp006Cnt;  //강반처리
	private String darTp007Cnt;  //방치처리
	private String darTp008Cnt;  //고장처리
	private String darTp009Cnt;  //분실처리
	private String darBikeCnt;  //분실처리
	
	/* 일일실적 */
	private String stationNo;
	private String  moveTime;
	private String relocateTime;
	private String moveCnt; 
	private String relocateCnt;
	
	public String getStationNo() {
		return stationNo;
	}
	public void setStationNo(String stationNo) {
		this.stationNo = stationNo;
	}
	public String getMoveTime() {
		return moveTime;
	}
	public void setMoveTime(String moveTime) {
		this.moveTime = moveTime;
	}
	public String getRelocateTime() {
		return relocateTime;
	}
	public void setRelocateTime(String relocateTime) {
		this.relocateTime = relocateTime;
	}
	public String getMoveCnt() {
		return moveCnt;
	}
	public void setMoveCnt(String moveCnt) {
		this.moveCnt = moveCnt;
	}
	public String getRelocateCnt() {
		return relocateCnt;
	}
	public void setRelocateCnt(String relocateCnt) {
		this.relocateCnt = relocateCnt;
	}
	
	
	
	public String getDarBikeCnt() {
		return darBikeCnt;
	}
	public void setDarBikeCnt(String darBikeCnt) {
		this.darBikeCnt = darBikeCnt;
	}
	private String searchBgnDe;
	
	public String getSearchBgnDe() {
		return searchBgnDe;
	}
	public void setSearchBgnDe(String searchBgnDe) {
		this.searchBgnDe = searchBgnDe;
	}
	
	public String getCenterId() {
		return centerId;
	}
	public void setCenterId(String centerId) {
		this.centerId = centerId;
	}
	
	public String getTeamSeq() {
		return teamSeq;
	}
	public void setTeamSeq(String teamSeq) {
		this.teamSeq = teamSeq;
	}
	
	public String getDarTp001Cnt() {
		return darTp001Cnt;
	}
	public void setDarTp001Cnt(String darTp001Cnt) {
		this.darTp001Cnt = darTp001Cnt;
	}
	public String getDarTp002Cnt() {
		return darTp002Cnt;
	}
	public void setDarTp002Cnt(String darTp002Cnt) {
		this.darTp002Cnt = darTp002Cnt;
	}
	public String getDarTp003Cnt() {
		return darTp003Cnt;
	}
	public void setDarTp003Cnt(String darTp003Cnt) {
		this.darTp003Cnt = darTp003Cnt;
	}
	public String getDarTp004Cnt() {
		return darTp004Cnt;
	}
	public void setDarTp004Cnt(String darTp004Cnt) {
		this.darTp004Cnt = darTp004Cnt;
	}
	public String getDarTp005Cnt() {
		return darTp005Cnt;
	}
	public void setDarTp005Cnt(String darTp005Cnt) {
		this.darTp005Cnt = darTp005Cnt;
	}
	public String getDarTp006Cnt() {
		return darTp006Cnt;
	}
	public void setDarTp006Cnt(String darTp006Cnt) {
		this.darTp006Cnt = darTp006Cnt;
	}
	public String getDarTp007Cnt() {
		return darTp007Cnt;
	}
	public void setDarTp007Cnt(String darTp007Cnt) {
		this.darTp007Cnt = darTp007Cnt;
	}
	public String getDarTp008Cnt() {
		return darTp008Cnt;
	}
	public void setDarTp008Cnt(String darTp008Cnt) {
		this.darTp008Cnt = darTp008Cnt;
	}
	public String getDarTp009Cnt() {
		return darTp009Cnt;
	}
	public void setDarTp009Cnt(String darTp009Cnt) {
		this.darTp009Cnt = darTp009Cnt;
	}
	private String currBikeStatuCd;  //현재 자전거 상태
	
	
	public String getCurrBikeStatuCd() {
		return currBikeStatuCd;
	}
	public void setCurrBikeStatuCd(String currBikeStatuCd) {
		this.currBikeStatuCd = currBikeStatuCd;
	}

	private String bikeId;			//자전거번호
	
	public String getBikeId() {
		return bikeId;
	}
	public void setBikeId(String bikeId) {
		this.bikeId = bikeId;
	}
	
	private String comptCd;			// 처리완료구분(강제반납용)
	
	public String getComptCd() {
		return comptCd;
	}
	public void setComptCd(String comptCd) {
		this.comptCd = comptCd;
	}

	//
	private int modifyDate;			//날짜 수정값(-1 전날, 1 다음날 ..) 
	
	public String getOnSiteActionCnt() {
		return onSiteActionCnt;
	}
	public void setOnSiteActionCnt(String onSiteActionCnt) {
		this.onSiteActionCnt = onSiteActionCnt;
	}
	public String getBikeRobbedCnt() {
		return bikeRobbedCnt;
	}
	public void setBikeRobbedCnt(String bikeRobbedCnt) {
		this.bikeRobbedCnt = bikeRobbedCnt;
	}
	public String getBikeMoveCnt() {
		return bikeMoveCnt;
	}
	public void setBikeMoveCnt(String bikeMoveCnt) {
		this.bikeMoveCnt = bikeMoveCnt;
	}
	public String getBikeReplaceCnt() {
		return bikeReplaceCnt;
	}
	public void setBikeReplaceCnt(String bikeReplaceCnt) {
		this.bikeReplaceCnt = bikeReplaceCnt;
	}
	public String getWarehousingCnt() {
		return warehousingCnt;
	}
	public void setWarehousingCnt(String warehousingCnt) {
		this.warehousingCnt = warehousingCnt;
	}
	public String getWorkTime() {
		return workTime;
	}
	public void setWorkTime(String workTime) {
		this.workTime = workTime;
	}
	public String getWorkPlace() {
		return workPlace;
	}
	public void setWorkPlace(String workPlace) {
		this.workPlace = workPlace;
	}
	public String getWorkClassifi() {
		return workClassifi;
	}
	public void setWorkClassifi(String workClassifi) {
		this.workClassifi = workClassifi;
	}
	public String getBikeNo() {
		return bikeNo;
	}
	public void setBikeNo(String bikeNo) {
		this.bikeNo = bikeNo;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getCenterName() {
		return centerName;
	}
	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getVcleNo() {
		return vcleNo;
	}
	public void setVcleNo(String vcleNo) {
		this.vcleNo = vcleNo;
	}
	public String getRefuel() {
		return refuel;
	}
	public void setRefuel(String refuel) {
		this.refuel = refuel;
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
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public int getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(int modifyDate) {
		this.modifyDate = modifyDate;
	}
	
}
