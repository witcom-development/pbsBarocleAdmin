/*
 * @Package Name : com.dkitec.barocle.admin.status.stationStaus.vo
 * @파일명          : StationStatusVO.java
 * @작성일          : 2015. 5. 18.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 18.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.stationStatus.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.beacon.vo.BeaconVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;


/**
 * @파일명          : StationStatusVO.java
 * @작성일          : 2015. 5. 18.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 18.   |   ymshin   |  최초작성
 */
@SuppressWarnings("serial")
@Alias("statusVo")
public class StationStatusVO extends PagingVO{
	
	private String stationTotCnt;//대여소 전체 수
	private String rackTotCnt;//거치대 전체수
	private String bikeTotCnt;//자전거 전체수(폐기,분실제외)
	private String bikeTotErrorCnt;//자전거(폐기,분실)
	private String brokenBikeTotCnt;//자전거 장애중
	private String brokenRackTotCnt;//거치대 장애중
	private String brokenApTotCnt;//무선AP 장애주
	private String standByBikeTotCnt;//대기중인 자전거
	private String repairingBikeTotCnt;//수리중인 자전거
	private String repairingCompleteTotCnt;//수리완료 자전거
	private String warehousedBikeTotCnt;//센터입고
	private String rentStableTotCnt;//정상 대여중
	private String longTermNonReturnTotCnt;//장기 미반납
	private String movePlacementotCnt;//배치이동
    private String impulseBikeReturnTotCnt;//강제반납.
	private String stationOrderType;//desc, asca
	private String sharedOrderType;//desc, asca
	private String orderColumn;//대여소, 거치율
	private String locateNo;//위치NO
	private String stationName;//대여소 이름
	private String rackRate;//거치율
	private String parkingRackTotCnt;
	private String parkingBikeTotCnt;
	private String bikeStatusName;//자전거 상태 
	private String shared;//점유율
	private String lang = IConstants.LANG_KR;
	private String mainStationYn;
	private String stationLatitude;
	private String stationLongitude;
	private String parkingRack;
	private String parkingBike;
	private String criticalFlg; 
	private String closeFlg;
	private String systemWarning;
	private String currnetStatus;
	private String stationAddr;
	private String stationGrpSeq;
	@CheckValue(message="빈값일 수 없습니다.")
	private String stationId;//대여소 Id
    private String stationPostNo;
	private List<BikeVO> bikeList;
	private List<ArmVO> armList;
	private ApVO apInfo;
	private ArmVO armInfo;
    private String equipmentFaultYN;
	private String stationUseYn;
	private String stationImgFileName;
	private String viewType;
	private String pageYn = IConstants.Y;
    private String defaultLevel;
    private String paramSearchWord;
    private String batteryStusCd;	//배터리 정보_20160810_JJH
    private String defaultTeamYn;	// 2020-11-25 : 대여소현황에서 사용자가 검색조건 팀을 직접 변경했는지 확인하는 값
	
	/*실시간 현황 관리*/
    private String bil001Amt;			// 정기-7일_cms_20161125	
    private String bil002Amt;			// 정기-30일_cms_20161125
    private String bil003Amt;			// 정기-90일_cms_20161125
    private String bil004Amt;			// 정기-180일_cms_20161125
    private String bil005Amt;			// 정기-365일_cms_20161125
    private String bil006Amt;			// 일일(회원)_cms_20161125
    private String bil007Amt;			// 일일(비회원)_cms_20161125
    private String bil008Amt;			// 단체_cms_20161125
    private String bil009Amt;			// 초과요금_cms_20161125
    private String bil010Amt;			// 보증금_cms_20161125
    private String bil011Amt;			// 프리미엄 정기-7일_cms_20161125
    private String bil012Amt;			// 프리미엄 정기-30일_cms_20161125
    private String bil013Amt;			// 프리미엄 정기-90일_cms_20161125
    private String bil014Amt;			// 프리미엄 정기-180일_cms_20161125
    private String bil015Amt;			// 프리미엄 정기-365일_cms_20161125
    private String bil016Amt;			// 프리미엄 일일(회원)_cms_20161125
    private String bil017Amt;			// 프리미엄 일일(비회원)_cms_20161125
    private String totCnt;				// 홈페이지 가입자수(전체)_cms_20161125
    private String yoilCnt;				// 금일 홈페이지 가입자수	_cms_20161125
    private String bikeCnt;				// 자전거 총 댓수_cms_20161125
    
    private String highStation;			// 상위 대여소_cms_20161125
    private String lowStation;			// 하위 대여소_cms_20161125
    
    private String stationGrpName;		// 지역별 명_cms_20161125
    private String stationClsCd;		// 지역별 건수_cms_20161125
    private String tot;					// 전체 건수_cms_20161125
    
    private String highGrpName;			// 지역별 상위 배치_cms_20161125
    private String rowGrpName;			// 지역별 하위 배치_cms_20161125
    private String relocGrpName;		// 지역별 재 배치_cms_20161125
    
    private String bikeStusCnt;			// 운영중 자전거_cms_20161125
    
    private String bilTot;				// 실시간 매출현황 전체 합계_cms_20161201
    
    
    private String noticeSeq;			// 공지사항 seq_cms_20161219
    private String noticeTitle;			// 공지사항 title_cms_20161219
    private String siteClsCd;			// 공지사항 공지대상_cms_20161219
    private String mainNoticeYn;		// 공지사항 공지여부_cms_20161219
    private String postStrDttm;			// 공지사항 공지시작일_cms_20161219
    private String postEndDttm;			// 공지사항 공지종료일_cms_20161219

    private String totRelocateCnt;		// 지역별 배치 전체Count_cms_20161222
    private String stationGrpNm;		// 지역별 배치 전체List_cms_20161222
    
    private String bikeReleaseCnt;		//자전거 출고 수량_20170109_cms
    
    private String teamNm;
    
    private String memo;
    
    private String dstncLt;
    
    private List<BeaconVO> beaconList;
    
    private String stationSeCd;
    
    private String parkingQRBikeCnt;
    
    private String parkingELECBikeCnt;
    
    private String stationGrpId;
    
	public String getStationSeCd() {
		return stationSeCd;
	}
	public void setStationSeCd(String stationSeCd) {
		this.stationSeCd = stationSeCd;
	}
	public List<BeaconVO> getBeaconList() {
		return beaconList;
	}
	public void setBeaconList(List<BeaconVO> beaconList) {
		this.beaconList = beaconList;
	}
	public String getBikeReleaseCnt() {
		return bikeReleaseCnt;
	}
	public void setBikeReleaseCnt(String bikeReleaseCnt) {
		this.bikeReleaseCnt = bikeReleaseCnt;
	}
	public String getDstncLt() {
		return dstncLt;
	}
	public void setDstncLt(String dstncLt) {
		this.dstncLt = dstncLt;
	}
	public String getStationGrpNm() {
		return stationGrpNm;
	}
	public void setStationGrpNm(String stationGrpNm) {
		this.stationGrpNm = stationGrpNm;
	}
	public String getTotRelocateCnt() {
		return totRelocateCnt;
	}
	public void setTotRelocateCnt(String totRelocateCnt) {
		this.totRelocateCnt = totRelocateCnt;
	}
	public String getSiteClsCd() {
		return siteClsCd;
	}
	public void setSiteClsCd(String siteClsCd) {
		this.siteClsCd = siteClsCd;
	}
	public String getMainNoticeYn() {
		return mainNoticeYn;
	}
	public void setMainNoticeYn(String mainNoticeYn) {
		this.mainNoticeYn = mainNoticeYn;
	}
	public String getPostStrDttm() {
		return postStrDttm;
	}
	public void setPostStrDttm(String postStrDttm) {
		this.postStrDttm = postStrDttm;
	}
	public String getPostEndDttm() {
		return postEndDttm;
	}
	public void setPostEndDttm(String postEndDttm) {
		this.postEndDttm = postEndDttm;
	}
	public String getNoticeSeq() {
		return noticeSeq;
	}
	public void setNoticeSeq(String noticeSeq) {
		this.noticeSeq = noticeSeq;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getBilTot() {
		return bilTot;
	}
	public void setBilTot(String bilTot) {
		this.bilTot = bilTot;
	}
	public String getBikeStusCnt() {
		return bikeStusCnt;
	}
	public void setBikeStusCnt(String bikeStusCnt) {
		this.bikeStusCnt = bikeStusCnt;
	}
	public String getLowStation() {
		return lowStation;
	}
	public void setLowStation(String lowStation) {
		this.lowStation = lowStation;
	}
	public String getBil001Amt() {
		return bil001Amt;
	}
	public void setBil001Amt(String bil001Amt) {
		this.bil001Amt = bil001Amt;
	}
	public String getBil002Amt() {
		return bil002Amt;
	}
	public void setBil002Amt(String bil002Amt) {
		this.bil002Amt = bil002Amt;
	}
	public String getBil003Amt() {
		return bil003Amt;
	}
	public void setBil003Amt(String bil003Amt) {
		this.bil003Amt = bil003Amt;
	}
	public String getBil004Amt() {
		return bil004Amt;
	}
	public void setBil004Amt(String bil004Amt) {
		this.bil004Amt = bil004Amt;
	}
	public String getBil005Amt() {
		return bil005Amt;
	}
	public void setBil005Amt(String bil005Amt) {
		this.bil005Amt = bil005Amt;
	}
	public String getBil006Amt() {
		return bil006Amt;
	}
	public void setBil006Amt(String bil006Amt) {
		this.bil006Amt = bil006Amt;
	}
	public String getBil007Amt() {
		return bil007Amt;
	}
	public void setBil007Amt(String bil007Amt) {
		this.bil007Amt = bil007Amt;
	}
	public String getBil008Amt() {
		return bil008Amt;
	}
	public void setBil008Amt(String bil008Amt) {
		this.bil008Amt = bil008Amt;
	}
	public String getBil009Amt() {
		return bil009Amt;
	}
	public void setBil009Amt(String bil009Amt) {
		this.bil009Amt = bil009Amt;
	}
	public String getBil010Amt() {
		return bil010Amt;
	}
	public void setBil010Amt(String bil010Amt) {
		this.bil010Amt = bil010Amt;
	}
	public String getBil011Amt() {
		return bil011Amt;
	}
	public void setBil011Amt(String bil011Amt) {
		this.bil011Amt = bil011Amt;
	}
	public String getBil012Amt() {
		return bil012Amt;
	}
	public void setBil012Amt(String bil012Amt) {
		this.bil012Amt = bil012Amt;
	}
	public String getBil013Amt() {
		return bil013Amt;
	}
	public void setBil013Amt(String bil013Amt) {
		this.bil013Amt = bil013Amt;
	}
	public String getBil014Amt() {
		return bil014Amt;
	}
	public void setBil014Amt(String bil014Amt) {
		this.bil014Amt = bil014Amt;
	}
	public String getBil015Amt() {
		return bil015Amt;
	}
	public void setBil015Amt(String bil015Amt) {
		this.bil015Amt = bil015Amt;
	}
	public String getBil016Amt() {
		return bil016Amt;
	}
	public void setBil016Amt(String bil016Amt) {
		this.bil016Amt = bil016Amt;
	}
	public String getBil017Amt() {
		return bil017Amt;
	}
	public void setBil017Amt(String bil017Amt) {
		this.bil017Amt = bil017Amt;
	}
	public String getTotCnt() {
		return totCnt;
	}
	public void setTotCnt(String totCnt) {
		this.totCnt = totCnt;
	}
	public String getYoilCnt() {
		return yoilCnt;
	}
	public void setYoilCnt(String yoilCnt) {
		this.yoilCnt = yoilCnt;
	}
	public String getBikeCnt() {
		return bikeCnt;
	}
	public void setBikeCnt(String bikeCnt) {
		this.bikeCnt = bikeCnt;
	}
	public String getStationGrpName() {
		return stationGrpName;
	}
	public void setStationGrpName(String stationGrpName) {
		this.stationGrpName = stationGrpName;
	}
	public String getStationClsCd() {
		return stationClsCd;
	}
	public void setStationClsCd(String stationClsCd) {
		this.stationClsCd = stationClsCd;
	}
	public String getTot() {
		return tot;
	}
	public void setTot(String tot) {
		this.tot = tot;
	}
	public String getHighGrpName() {
		return highGrpName;
	}
	public void setHighGrpName(String highGrpName) {
		this.highGrpName = highGrpName;
	}
	public String getRowGrpName() {
		return rowGrpName;
	}
	public void setRowGrpName(String rowGrpName) {
		this.rowGrpName = rowGrpName;
	}
	public String getRelocGrpName() {
		return relocGrpName;
	}
	public void setRelocGrpName(String relocGrpName) {
		this.relocGrpName = relocGrpName;
	}
	public String getHighStation() {
		return highStation;
	}
	public void setHighStation(String highStation) {
		this.highStation = highStation;
	}
	public String getBatteryStusCd() {
		return batteryStusCd;
	}
	public void setBatteryStusCd(String batteryStusCd) {
		this.batteryStusCd = batteryStusCd;
	}
	public String getParamSearchWord() {
		return paramSearchWord;
	}
	public void setParamSearchWord(String paramSearchWord) {
		this.paramSearchWord = paramSearchWord;
	}
	public String getParamSearchType() {
		return paramSearchType;
	}
	public void setParamSearchType(String paramSearchType) {
		this.paramSearchType = paramSearchType;
	}
	private String paramSearchType;
       
	public String getEquipmentFaultYN() {
		return equipmentFaultYN;
	}
	public void setEquipmentFaultYN(String equipmentFaultYN) {
		this.equipmentFaultYN = equipmentFaultYN;
	}
	public String getDefaultLevel() {
		return defaultLevel;
	}
	public void setDefaultLevel(String defaultLevel) {
		this.defaultLevel = defaultLevel;
	}
	public String getPageYn() {
		return pageYn;
	}
	public void setPageYn(String pageYn) {
		this.pageYn = pageYn;
	}
	public String getViewType() {
		return viewType;
	}
	public void setViewType(String viewType) {
		this.viewType = viewType;
	}
	public String getStationTotCnt() {
		return stationTotCnt;
	}
	public void setStationTotCnt(String stationTotCnt) {
		this.stationTotCnt = stationTotCnt;
	}
	public String getRackTotCnt() {
		return rackTotCnt;
	}
	public void setRackTotCnt(String rackTotCnt) {
		this.rackTotCnt = rackTotCnt;
	}
	public String getBikeTotCnt() {
		return bikeTotCnt;
	}
	public void setBikeTotCnt(String bikeTotCnt) {
		this.bikeTotCnt = bikeTotCnt;
	}
	public String getBrokenBikeTotCnt() {
		return brokenBikeTotCnt;
	}
	public void setBrokenBikeTotCnt(String brokenBikeTotCnt) {
		this.brokenBikeTotCnt = brokenBikeTotCnt;
	}
	public String getBrokenRackTotCnt() {
		return brokenRackTotCnt;
	}
	public void setBrokenRackTotCnt(String brokenRackTotCnt) {
		this.brokenRackTotCnt = brokenRackTotCnt;
	}
	public String getBrokenApTotCnt() {
		return brokenApTotCnt;
	}
	public void setBrokenApTotCnt(String brokenApTotCnt) {
		this.brokenApTotCnt = brokenApTotCnt;
	}
	public String getStandByBikeTotCnt() {
		return standByBikeTotCnt;
	}
	public void setStandByBikeTotCnt(String standByBikeTotCnt) {
		this.standByBikeTotCnt = standByBikeTotCnt;
	}
	public String getRepairingBikeTotCnt() {
		return repairingBikeTotCnt;
	}
	public void setRepairingBikeTotCnt(String repairingBikeTotCnt) {
		this.repairingBikeTotCnt = repairingBikeTotCnt;
	}
	public String getWarehousedBikeTotCnt() {
		return warehousedBikeTotCnt;
	}
	public void setWarehousedBikeTotCnt(String warehousedBikeTotCnt) {
		this.warehousedBikeTotCnt = warehousedBikeTotCnt;
	}
	public String getRentStableTotCnt() {
		return rentStableTotCnt;
	}
	public void setRentStableTotCnt(String rentStableTotCnt) {
		this.rentStableTotCnt = rentStableTotCnt;
	}
	public String getLongTermNonReturnTotCnt() {
		return longTermNonReturnTotCnt;
	}
	public void setLongTermNonReturnTotCnt(String longTermNonReturnTotCnt) {
		this.longTermNonReturnTotCnt = longTermNonReturnTotCnt;
	}
	public String getMovePlacementotCnt() {
		return movePlacementotCnt;
	}
	public void setMovePlacementotCnt(String movePlacementotCnt) {
		this.movePlacementotCnt = movePlacementotCnt;
	}
	public String getBikeTotErrorCnt() {
		return bikeTotErrorCnt;
	}
	public void setBikeTotErrorCnt(String bikeTotErrorCnt) {
		this.bikeTotErrorCnt = bikeTotErrorCnt;
	}
	public String getRepairingCompleteTotCnt() {
		return repairingCompleteTotCnt;
	}
	public void setRepairingCompleteTotCnt(String repairingCompleteTotCnt) {
		this.repairingCompleteTotCnt = repairingCompleteTotCnt;
	}
	public String getImpulseBikeReturnTotCnt() {
		return impulseBikeReturnTotCnt;
	}
	public void setImpulseBikeReturnTotCnt(String impulseBikeReturnTotCnt) {
		this.impulseBikeReturnTotCnt = impulseBikeReturnTotCnt;
	}
	public String getStationOrderType() {
		return stationOrderType;
	}
	public void setStationOrderType(String stationOrderType) {
		this.stationOrderType = stationOrderType;
	}
	public String getSharedOrderType() {
		return sharedOrderType;
	}
	public void setSharedOrderType(String sharedOrderType) {
		this.sharedOrderType = sharedOrderType;
	}
	public String getOrderColumn() {
		return orderColumn;
	}
	public void setOrderColumn(String orderColumn) {
		this.orderColumn = orderColumn;
	}
	public String getLocateNo() {
		return locateNo;
	}
	public void setLocateNo(String locateNo) {
		this.locateNo = locateNo;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public String getRackRate() {
		return rackRate;
	}
	public void setRackRate(String rackRate) {
		this.rackRate = rackRate;
	}
	public String getParkingRackTotCnt() {
		return parkingRackTotCnt;
	}
	public void setParkingRackTotCnt(String parkingRackTotCnt) {
		this.parkingRackTotCnt = parkingRackTotCnt;
	}
	public String getParkingBikeTotCnt() {
		return parkingBikeTotCnt;
	}
	public void setParkingBikeTotCnt(String parkingBikeTotCnt) {
		this.parkingBikeTotCnt = parkingBikeTotCnt;
	}
	public String getBikeStatusName() {
		return bikeStatusName;
	}
	public void setBikeStatusName(String bikeStatusName) {
		this.bikeStatusName = bikeStatusName;
	}
	public String getShared() {
		return shared;
	}
	public void setShared(String shared) {
		this.shared = shared;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getStationLatitude() {
		return stationLatitude;
	}
	public void setStationLatitude(String stationLatitude) {
		this.stationLatitude = stationLatitude;
	}
	public String getStationLongitude() {
		return stationLongitude;
	}
	public void setStationLongitude(String stationLongitude) {
		this.stationLongitude = stationLongitude;
	}
	public String getParkingRack() {
		return parkingRack;
	}
	public void setParkingRack(String parkingRack) {
		this.parkingRack = parkingRack;
	}
	public String getParkingBike() {
		return parkingBike;
	}
	public void setParkingBike(String parkingBike) {
		this.parkingBike = parkingBike;
	}
	public String getCriticalFlg() {
		return criticalFlg;
	}
	public void setCriticalFlg(String criticalFlg) {
		this.criticalFlg = criticalFlg;
	}
	public String getCloseFlg() {
		return closeFlg;
	}
	public void setCloseFlg(String closeFlg) {
		this.closeFlg = closeFlg;
	}
	public String getSystemWarning() {
		return systemWarning;
	}
	public void setSystemWarning(String systemWarning) {
		this.systemWarning = systemWarning;
	}
	public String getCurrnetStatus() {
		return currnetStatus;
	}
	public void setCurrnetStatus(String currnetStatus) {
		this.currnetStatus = currnetStatus;
	}
	public String getStationAddr() {
		return stationAddr;
	}
	public void setStationAddr(String stationAddr) {
		this.stationAddr = stationAddr;
	}
	public String getStationGrpSeq() {
		return stationGrpSeq;
	}
	public void setStationGrpSeq(String stationGrpSeq) {
		this.stationGrpSeq = stationGrpSeq;
	}
	public String getStationId() {
		return stationId;
	}
	public void setStationId(String stationId) {
		this.stationId = stationId;
	}
	public String getStationPostNo() {
		return stationPostNo;
	}
	public void setStationPostNo(String stationPostNo) {
		this.stationPostNo = stationPostNo;
	}
	public List<BikeVO> getBikeList() {
		return bikeList;
	}
	public void setBikeList(List<BikeVO> bikeList) {
		this.bikeList = bikeList;
	}
	public List<ArmVO> getArmList() {
		return armList;
	}
	public void setArmList(List<ArmVO> armList) {
		this.armList = armList;
	}
	public ApVO getApInfo() {
		return apInfo;
	}
	public void setApInfo(ApVO apInfo) {
		this.apInfo = apInfo;
	}
	public ArmVO getArmInfo() {
		return armInfo;
	}
	public void setArmInfo(ArmVO armInfo) {
		this.armInfo = armInfo;
	}
	public String getStationUseYn() {
		return stationUseYn;
	}
	public void setStationUseYn(String stationUseYn) {
		this.stationUseYn = stationUseYn;
	}
	public String getStationImgFileName() {
		return stationImgFileName;
	}
	public void setStationImgFileName(String stationImgFileName) {
		this.stationImgFileName = stationImgFileName;
	}
	public String getMainStationYn() {
		return mainStationYn;
	}
	public void setMainStationYn(String mainStationYn) {
		this.mainStationYn = mainStationYn;
	}
	public String getTeamNm() {
		return teamNm;
	}
	public void setTeamNm(String teamNm) {
		this.teamNm = teamNm;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getParkingQRBikeCnt() {
		return parkingQRBikeCnt;
	}
	public void setParkingQRBikeCnt(String parkingQRBikeCnt) {
		this.parkingQRBikeCnt = parkingQRBikeCnt;
	}
	public String getParkingELECBikeCnt() {
		return parkingELECBikeCnt;
	}
	public void setParkingELECBikeCnt(String parkingELECBikeCnt) {
		this.parkingELECBikeCnt = parkingELECBikeCnt;
	}
	public String getDefaultTeamYn() {
		return defaultTeamYn;
	}
	public void setDefaultTeamYn(String defaultTeamYn) {
		this.defaultTeamYn = defaultTeamYn;
	}
	public String getStationGrpId() {
		return stationGrpId;
	}
	public void setStationGrpId(String stationGrpId) {
		this.stationGrpId = stationGrpId;
	}
	
	
}
