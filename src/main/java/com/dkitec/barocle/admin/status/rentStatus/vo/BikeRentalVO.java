/*
 * @Package Name : com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo
 * @파일명          : BikeRentalVO.java
 * @작성일          : 2015. 4. 21.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 21.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.rentStatus.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.barocle.admin.status.rentHistory.vo.PenaltyVO;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.IsDate;
import com.dkitec.barocle.util.validator.annotation.IsStringNotNullNumeric;

/**
 * @파일명          : BikeRentalVO.java
 * @작성일          : 2015. 4. 21.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 21.   |   ymshin   |  최초작성
 */
@Alias("bikeRentalVo")
public class BikeRentalVO extends PagingVO {

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.serialVersionUID
	 * @writeDay : 2015. 5. 14.
	 * @Todo  :
	 */ 
	private static final long serialVersionUID = 1L;
	@IsStringNotNullNumeric( message="숫자 형식이어야 합니다.")
	private String rentHistSeq;
	@IsStringNotNullNumeric( message="숫자 형식이어야 합니다.")
	private String rentSeq;
	@IsDate(message="형식 오류")
	private String rentDttm;
	@IsStringNotNullNumeric( message="숫자 형식이어야 합니다.")
	private String userSeq;
	private String voucherSeq;
	private String rentBikeId;
	private String rentBikeNo;
	private String rentRackId;
	private String rentClsCd;//대여구분
	private String rentClsCdName;//대여구분
	private String returnRackId;
	private String returnDttm;
	private String rentStationId;
	private String rentStationName;
	private String rentStationNo;
	private String rentStationGrpSeq;
	private String rentStationGrpName;
	private String returnStationGrpSeq;
	private String returnStationGrpName;
	private String returnStationId;
	private String returnStationName;
	private String returnStationNo;
	private String useMi; //이용분
	private String useDist;//이용거리
	private String currentSearchTime;//이용거리
	private String mbId;
	private String rentStatusName;
	private String overFee;
	private String overFeeYn = IConstants.N;
	private String overMi;
	private String penaltyPoint;
	private String pageYn;
	private String viewFlg = IConstants.MODE_LIST;
	private String lang = IConstants.LANG_KR;
	private String searchWord;
	private List<String> stationList;
	private List<PenaltyVO> penaltyList;
	private String targetType;//현황이냐 이력이냐.
	private String voucherStrDttm;
	private String voucherEndDttm;
	private String rentEncPwd;
	private String penaltyTot;
	private String terminalId;
	private String penaltySeq;
	private String searchType;
	private String searchTypeName;
	private String longTermChk;
	private String elapseTime;
	private String sortType;
	private String usrSeq;
	private String usrMpnNo;
	private String baseRentTime;
	private String paymentClsCd;
	private String adminId;
	private String rentStatusCd;
	private String mpn_no;
	private String usrClsCdName;
	private String searchParameter;
	//강제 반납 추가 시작
	private String enfrcReturnStationId;
    private String deviceCnncCd;	//잠금장치연결
    private String enfrcReturnCd;	//미반납사유
    private String parkingLocation;	//임의장소
    private String photoYn;			//사진첨부여부
    private String emrgncyYn;		//긴급여부
    private String teamSeq;		//팀시퀀스
    private String enfrcReturnHistSeq;
    private String stationName;
    private String deviceReturnCdNm;
    private String regDttm;
	private String smsYn;
    private String teamId;		//팀시퀀스
    private String centerId;		//팀시퀀스
    private String comptCd;
    private String empCnt;
    private String centerCnt;
    private String teamCnt;
    private String rentBikeStat;
    private String procCd;
    private String regId;
    private String agentId;   
    private String parkingLocationYn;	//임의장소 반납 여부 
    private String parkingLocationReason;
    private String parkingLocationDesc;
    private String enfrcReturnDesc;
	private String enfrcGubunCd;
    private String addr;
    private String centerName;
    private String teamName;
    private String comptDttm;
    
    private String bikeNoYn;
    private String bikeMYIDYn;
    
    private String bikeMYID; //내글 검색
    
    
    private String lostBikeYn;
    //강제 반납 추가 끝
    
	private String startPaymentDttm;
	private String endPaymentDttm;
	
	private String usrClsCd;
	private String latitude;
	private String longitude;
	private String nearStationId;

	
    private String enfrcFileNo;
	private List<String> enfrcFileNoList;
	private String enfrcFileState;
	private List<String> enfrcFileStateList;
	private String enfrcFileOrd;
	private List<MultipartFile> enfrcFile;
	private List<String> oldFileNameList;
	private String fileName;
	private String fileOriName;
	private List<String> fileSavePathList;
	private String fileSavePath;
	private float fileSize;
	private byte[] fileByte;

	
	//도난추정
	private String manageCenter;
	private String reportDate;
	private String reportCd;
	private String reportNm;
	private String reportPno;
	private String reportDetail;
	private String reportYn;
	
	
	//회수
	private String rtrvlDate;
	private String rtrvlNm ;
	private String rtrvlPlace;
	private String rtrvlCd;
	private String rtrvlDetail;
	
	// qr
	private String stationSeCd;
	private String stationClsCd;
	private String bikeSeCd;
	
	//2020-12-23 : 자전거 검색 장애상태 표출 추가
	private String faultSeq;
	private String faultName;
	
	
    public String getEnfrcReturnDesc() {
		return enfrcReturnDesc;
	}
	public void setEnfrcReturnDesc(String enfrcReturnDesc) {
		this.enfrcReturnDesc = enfrcReturnDesc;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getEnfrcGubunCd() {
		return enfrcGubunCd;
	}
	public void setEnfrcGubunCd(String enfrcGubunCd) {
		this.enfrcGubunCd = enfrcGubunCd;
	}
	public String getParkingLocationDesc() {
		return parkingLocationDesc;
	}
	public void setParkingLocationDesc(String parkingLocationDesc) {
		this.parkingLocationDesc = parkingLocationDesc;
	}
	public String getParkingLocationReason() {
		return parkingLocationReason;
	}
	public void setParkingLocationReason(String parkingLocationReason) {
		this.parkingLocationReason = parkingLocationReason;
	}
	public String getParkingLocationYn() {
		return parkingLocationYn;
	}
	public void setParkingLocationYn(String parkingLocationYn) {
		this.parkingLocationYn = parkingLocationYn;
	}
	public String getAgentId() {
		return agentId;
	}
	public void setAgentId(String agentId) {
		this.agentId = agentId;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getProcCd() {
		return procCd;
	}
	public void setProcCd(String procCd) {
		this.procCd = procCd;
	}
    public String getRentBikeStat() {
		return rentBikeStat;
	}
	public void setRentBikeStat(String rentBikeStat) {
		this.rentBikeStat = rentBikeStat;
	}
	public String getStartPaymentDttm() {
		return startPaymentDttm;
	}
	public void setStartPaymentDttm(String startPaymentDttm) {
		this.startPaymentDttm = startPaymentDttm;
	}
	public String getEndPaymentDttm() {
		return endPaymentDttm;
	}
	public void setEndPaymentDttm(String endPaymentDttm) {
		this.endPaymentDttm = endPaymentDttm;
	}
	public String getSearchParameter() {
		return searchParameter;
	}
	public void setSearchParameter(String searchParameter) {
		this.searchParameter = searchParameter;
	}
	public String getUsrClsCdName() {
		return usrClsCdName;
	}
	public void setUsrClsCdName(String usrClsCdName) {
		this.usrClsCdName = usrClsCdName;
	}
	public String getMpn_no() {
		return mpn_no;
	}
	public void setMpn_no(String mpn_no) {
		this.mpn_no = mpn_no;
	}
	public String getRentStatusCd() {
		return rentStatusCd;
	}
	public void setRentStatusCd(String rentStatusCd) {
		this.rentStatusCd = rentStatusCd;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getRentStationGrpSeq() {
		return rentStationGrpSeq;
	}
	public void setRentStationGrpSeq(String rentStationGrpSeq) {
		this.rentStationGrpSeq = rentStationGrpSeq;
	}
	public String getRentStationGrpName() {
		return rentStationGrpName;
	}
	public void setRentStationGrpName(String rentStationGrpName) {
		this.rentStationGrpName = rentStationGrpName;
	}
	public String getRentSeq() {
		return rentSeq;
	}
	public void setRentSeq(String rentSeq) {
		this.rentSeq = rentSeq;
	}
	public String getRentClsCdName() {
		return rentClsCdName;
	}
	public void setRentClsCdName(String rentClsCdName) {
		this.rentClsCdName = rentClsCdName;
	}
	public String getTerminalId() {
		return terminalId;
	}
	public void setTerminalId(String terminalId) {
		this.terminalId = terminalId;
	}
	public String getUsrMpnNo() {
		return usrMpnNo;
	}
	public void setUsrMpnNo(String usrMpnNo) {
		this.usrMpnNo = usrMpnNo;
	}
	public String getTargetType() {
		return targetType;
	}
	public void setTargetType(String targetType) {
		this.targetType = targetType;
	}
	public String getVoucherStrDttm() {
		return voucherStrDttm;
	}
	public void setVoucherStrDttm(String voucherStrDttm) {
		this.voucherStrDttm = voucherStrDttm;
	}
	public String getVoucherEndDttm() {
		return voucherEndDttm;
	}
	public void setVoucherEndDttm(String voucherEndDttm) {
		this.voucherEndDttm = voucherEndDttm;
	}
	public String getRentEncPwd() {
		return rentEncPwd;
	}
	public void setRentEncPwd(String rentEncPwd) {
		this.rentEncPwd = rentEncPwd;
	}
	public String getReturnStationGrpName() {
		return returnStationGrpName;
	}
	public void setReturnStationGrpName(String returnStationGrpName) {
		this.returnStationGrpName = returnStationGrpName;
	}
	public String getReturnStationGrpSeq() {
		return returnStationGrpSeq;
	}
	public void setReturnStationGrpSeq(String returnStationGrpSeq) {
		this.returnStationGrpSeq = returnStationGrpSeq;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	public List<String> getStationList() {
		return stationList;
	}
	public void setStationList(List<String> stationList) {
		this.stationList = stationList;
	}
	public String getPageYn() {
		return pageYn;
	}
	public void setPageYn(String pageYn) {
		this.pageYn = pageYn;
	}
	public String getRentStationNo() {
		return rentStationNo;
	}
	public void setRentStationNo(String rentStationNo) {
		this.rentStationNo = rentStationNo;
	}
	public String getReturnStationNo() {
		return returnStationNo;
	}
	public void setReturnStationNo(String returnStationNo) {
		this.returnStationNo = returnStationNo;
	}
	
	public String getRentHistSeq() {
		return rentHistSeq;
	}
	public void setRentHistSeq(String rentHistSeq) {
		this.rentHistSeq = rentHistSeq;
	}
	public String getRentDttm() {
		return rentDttm;
	}
	public void setRentDttm(String rentDttm) {
		this.rentDttm = rentDttm;
	}
	public String getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}
	public String getRentBikeId() {
		return rentBikeId;
	}
	public void setRentBikeId(String rentBikeId) {
		this.rentBikeId = rentBikeId;
	}
	public String getRentRackId() {
		return rentRackId;
	}
	public void setRentRackId(String rentRackId) {
		this.rentRackId = rentRackId;
	}
	public String getRentClsCd() {
		return rentClsCd;
	}
	public void setRentClsCd(String rentClsCd) {
		this.rentClsCd = rentClsCd;
	}
	public String getReturnRackId() {
		return returnRackId;
	}
	public void setReturnRackId(String returnRackId) {
		this.returnRackId = returnRackId;
	}
	public String getReturnDttm() {
		return returnDttm;
	}
	public void setReturnDttm(String returnDttm) {
		this.returnDttm = returnDttm;
	}
	
	public String getRentStationId() {
		return rentStationId;
	}
	public void setRentStationId(String rentStationId) {
		this.rentStationId = rentStationId;
	}
	public String getReturnStationId() {
		return returnStationId;
	}
	public void setReturnStationId(String returnStationId) {
		this.returnStationId = returnStationId;
	}
	public String getUseMi() {
		return useMi;
	}
	public void setUseMi(String useMi) {
		this.useMi = useMi;
	}
	public String getUseDist() {
		return useDist;
	}
	public void setUseDist(String useDist) {
		this.useDist = useDist;
	}
	public String getMbId() {
		return mbId;
	}
	public void setMbId(String mbId) {
		this.mbId = mbId;
	}
	public String getOverFee() {
		return overFee;
	}
	public void setOverFee(String overFee) {
		this.overFee = overFee;
	}
	public String getPenaltyPoint() {
		return penaltyPoint;
	}
	public void setPenaltyPoint(String penaltyPoint) {
		this.penaltyPoint = penaltyPoint;
	}
	public String getRentStatusName() {
		return rentStatusName;
	}
	public void setRentStatusName(String rentStatusName) {
		this.rentStatusName = rentStatusName;
	}
	public String getRentBikeNo() {
		return rentBikeNo;
	}
	public void setRentBikeNo(String rentBikeNo) {
		this.rentBikeNo = rentBikeNo;
	}
	public String getRentStationName() {
		return rentStationName;
	}
	public void setRentStationName(String rentStationName) {
		this.rentStationName = rentStationName;
	}
	public String getReturnStationName() {
		return returnStationName;
	}
	public void setReturnStationName(String returnStationName) {
		this.returnStationName = returnStationName;
	}
	public String getViewFlg() {
		return viewFlg;
	}
	public void setViewFlg(String viewFlg) {
		this.viewFlg = viewFlg;
	}
	public List<PenaltyVO> getPenaltyList() {
		return penaltyList;
	}
	public void setPenaltyList(List<PenaltyVO> penaltyList) {
		this.penaltyList = penaltyList;
	}
	public String getPenaltyTot() {
		return penaltyTot;
	}
	public void setPenaltyTot(String penaltyTot) {
		this.penaltyTot = penaltyTot;
	}
	public String getPenaltySeq() {
		return penaltySeq;
	}
	public void setPenaltySeq(String penaltySeq) {
		this.penaltySeq = penaltySeq;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	
	public String getSearchTypeName() {
		return searchTypeName;
	}
	public void setSearchTypeName(String searchTypeName) {
		this.searchTypeName = searchTypeName;
	}
	public String getLongTermChk() {
		return longTermChk;
	}
	public void setLongTermChk(String longTermChk) {
		this.longTermChk = longTermChk;
	}
	public String getElapseTime() {
		return elapseTime;
	}
	public void setElapseTime(String elapseTime) {
		this.elapseTime = elapseTime;
	}
	public String getVoucherSeq() {
		return voucherSeq;
	}
	public void setVoucherSeq(String voucherSeq) {
		this.voucherSeq = voucherSeq;
	}
	public String getCurrentSearchTime() {
		return currentSearchTime;
	}
	public void setCurrentSearchTime(String currentSearchTime) {
		this.currentSearchTime = currentSearchTime;
	}
	public String getSortType() {
		return sortType;
	}
	public void setSortType(String sortType) {
		this.sortType = sortType;
	}
	public String getUsrSeq() {
		return usrSeq;
	}
	public void setUsrSeq(String usrSeq) {
		this.usrSeq = usrSeq;
	}
	public String getBaseRentTime() {
		return baseRentTime;
	}
	public void setBaseRentTime(String baseRentTime) {
		this.baseRentTime = baseRentTime;
	}
	public String getOverFeeYn() {
		return overFeeYn;
	}
	public void setOverFeeYn(String overFeeYn) {
		this.overFeeYn = overFeeYn;
	}
	public String getPaymentClsCd() {
		return paymentClsCd;
	}
	public void setPaymentClsCd(String paymentClsCd) {
		this.paymentClsCd = paymentClsCd;
	}
	public String getOverMi() {
		return overMi;
	}
	public void setOverMi(String overMi) {
		this.overMi = overMi;
	}
	
	public String getEnfrcReturnStationId() {
		return enfrcReturnStationId;
	}
	public void setEnfrcReturnStationId(String enfrcReturnStationId) {
		this.enfrcReturnStationId = enfrcReturnStationId;
	}
	public String getDeviceCnncCd() {
		return deviceCnncCd;
	}
	public void setDeviceCnncCd(String deviceCnncCd) {
		this.deviceCnncCd = deviceCnncCd;
	}
	public String getEnfrcReturnCd() {
		return enfrcReturnCd;
	}
	public void setEnfrcReturnCd(String enfrcReturnCd) {
		this.enfrcReturnCd = enfrcReturnCd;
	}
	public String getParkingLocation() {
		return parkingLocation;
	}
	public void setParkingLocation(String parkingLocation) {
		this.parkingLocation = parkingLocation;
	}
	public String getPhotoYn() {
		return photoYn;
	}
	public void setPhotoYn(String photoYn) {
		this.photoYn = photoYn;
	}
	public String getEmrgncyYn() {
		return emrgncyYn;
	}
	public void setEmrgncyYn(String emrgncyYn) {
		this.emrgncyYn = emrgncyYn;
	}
	@Override
	public String toString() {
		return "BikeRentalVO [rentHistSeq=" + rentHistSeq + ", rentSeq="
				+ rentSeq + ", rentDttm=" + rentDttm + ", userSeq=" + userSeq
				+ ", voucherSeq=" + voucherSeq + ", rentBikeId=" + rentBikeId
				+ ", rentBikeNo=" + rentBikeNo + ", rentRackId=" + rentRackId
				+ ", rentClsCd=" + rentClsCd + ", rentClsCdName="
				+ rentClsCdName + ", returnRackId=" + returnRackId
				+ ", returnDttm=" + returnDttm + ", rentStationId="
				+ rentStationId + ", rentStationName=" + rentStationName
				+ ", rentStationNo=" + rentStationNo + ", rentStationGrpSeq="
				+ rentStationGrpSeq + ", rentStationGrpName="
				+ rentStationGrpName + ", returnStationGrpSeq="
				+ returnStationGrpSeq + ", returnStationGrpName="
				+ returnStationGrpName + ", returnStationId=" + returnStationId
				+ ", returnStationName=" + returnStationName
				+ ", returnStationNo=" + returnStationNo + ", useMi=" + useMi
				+ ", useDist=" + useDist + ", currentSearchTime="
				+ currentSearchTime + ", mbId=" + mbId + ", rentStatusName="
				+ rentStatusName + ", overFee=" + overFee + ", overFeeYn="
				+ overFeeYn + ", overMi=" + overMi + ", penaltyPoint="
				+ penaltyPoint + ", pageYn=" + pageYn + ", viewFlg=" + viewFlg
				+ ", lang=" + lang + ", searchWord=" + searchWord
				+ ", stationList=" + stationList + ", penaltyList="
				+ penaltyList + ", targetType=" + targetType
				+ ", voucherStrDttm=" + voucherStrDttm + ", voucherEndDttm="
				+ voucherEndDttm + ", rentEncPwd=" + rentEncPwd
				+ ", penaltyTot=" + penaltyTot + ", terminalId=" + terminalId
				+ ", penaltySeq=" + penaltySeq + ", searchType=" + searchType
				+ ", searchTypeName=" + searchTypeName + ", longTermChk="
				+ longTermChk + ", elapseTime=" + elapseTime + ", sortType="
				+ sortType + ", usrSeq=" + usrSeq + ", usrMpnNo=" + usrMpnNo
				+ ", baseRentTime=" + baseRentTime + ", paymentClsCd="
				+ paymentClsCd + ", adminId=" + adminId + ", rentStatusCd="
				+ rentStatusCd + ", mpn_no=" + mpn_no + ", usrClsCdName="
				+ usrClsCdName + ", searchParameter=" + searchParameter 
				+ ", enfrcReturnStationId=" + enfrcReturnStationId 
				+ ", deviceCnncCd=" + deviceCnncCd
				+ ", enfrcReturnCd=" + enfrcReturnCd
				+ ", parkingLocation=" + parkingLocation
				+ ", photoYn=" + photoYn
				+ ", emrgncyYn=" + emrgncyYn
				+ ", teamSeq=" + teamSeq
				+ ", comptCd=" + comptCd
				+ ", latitude=" + latitude + ", longitude=" + longitude
				+ ", enfrcFileNo=" + enfrcFileNo + ", enfrcFileNoList=" + enfrcFileNoList
				+ ", enfrcFileState=" + enfrcFileState + ", enfrcFileStateList=" + enfrcFileStateList
				+ ", firmwareFileOrd=" + enfrcFileOrd + ", enfrcFile=" + enfrcFile
				+ ", oldFileNameList=" + oldFileNameList + ", fileName=" + fileName
				+ ", fileSavePathList=" + fileSavePathList + ", fileSavePath=" + fileSavePath
				+ ", fileSize=" + fileSize + ", fileByte=" + fileByte
				+ ", enfrcReturnHistSeq=" + enfrcReturnHistSeq
				//fileupload 임시
				+ "]";
	}
	public String getUsrClsCd() {
		return usrClsCd;
	}
	public void setUsrClsCd(String usrClsCd) {
		this.usrClsCd = usrClsCd;
	}
	public String getTeamSeq() {
		return teamSeq;
	}
	public void setTeamSeq(String teamSeq) {
		this.teamSeq = teamSeq;
	}
	public String getEnfrcReturnHistSeq() {
		return enfrcReturnHistSeq;
	}
	public void setEnfrcReturnHistSeq(String enfrcReturnHistSeq) {
		this.enfrcReturnHistSeq = enfrcReturnHistSeq;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public String getDeviceReturnCdNm() {
		return deviceReturnCdNm;
	}
	public void setDeviceReturnCdNm(String deviceReturnCdNm) {
		this.deviceReturnCdNm = deviceReturnCdNm;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getSmsYn() {
		return smsYn;
	}
	public void setSmsYn(String smsYn) {
		this.smsYn = smsYn;
	}
	public String getTeamId() {
		return teamId;
	}
	public void setTeamId(String teamId) {
		this.teamId = teamId;
	}
	public String getCenterId() {
		return centerId;
	}
	public void setCenterId(String centerId) {
		this.centerId = centerId;
	}
	public String getComptCd() {
		return comptCd;
	}
	public void setComptCd(String comptCd) {
		this.comptCd = comptCd;
	}
	public String getEmpCnt() {
		return empCnt;
	}
	public void setEmpCnt(String empCnt) {
		this.empCnt = empCnt;
	}
	public String getCenterCnt() {
		return centerCnt;
	}
	public void setCenterCnt(String centerCnt) {
		this.centerCnt = centerCnt;
	}
	public String getTeamCnt() {
		return teamCnt;
	}
	public void setTeamCnt(String teamCnt) {
		this.teamCnt = teamCnt;
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
	public String getNearStationId() {
		return nearStationId;
	}
	public void setNearStationId(String nearStationId) {
		this.nearStationId = nearStationId;
	}
	public String getEnfrcFileNo() {
		return enfrcFileNo;
	}
	public void setEnfrcFileNo(String enfrcFileNo) {
		this.enfrcFileNo = enfrcFileNo;
	}
	public List<String> getEnfrcFileNoList() {
		return enfrcFileNoList;
	}
	public void setEnfrcFileNoList(List<String> enfrcFileNoList) {
		this.enfrcFileNoList = enfrcFileNoList;
	}
	public String getEnfrcFileState() {
		return enfrcFileState;
	}
	public void setEnfrcFileState(String enfrcFileState) {
		this.enfrcFileState = enfrcFileState;
	}
	public List<String> getEnfrcFileStateList() {
		return enfrcFileStateList;
	}
	public void setEnfrcFileStateList(List<String> enfrcFileStateList) {
		this.enfrcFileStateList = enfrcFileStateList;
	}
	public String getEnfrcFileOrd() {
		return enfrcFileOrd;
	}
	public void setEnfrcFileOrd(String enfrcFileOrd) {
		this.enfrcFileOrd = enfrcFileOrd;
	}
	public List<MultipartFile> getEnfrcFile() {
		return enfrcFile;
	}
	public void setEnfrcFile(List<MultipartFile> enfrcFile) {
		this.enfrcFile = enfrcFile;
	}
	public List<String> getOldFileNameList() {
		return oldFileNameList;
	}
	public void setOldFileNameList(List<String> oldFileNameList) {
		this.oldFileNameList = oldFileNameList;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public String getFileOriName() {
		return fileOriName;
	}
	public void setFileOriName(String fileOriName) {
		this.fileOriName = fileOriName;
	}
	public List<String> getFileSavePathList() {
		return fileSavePathList;
	}
	public void setFileSavePathList(List<String> fileSavePathList) {
		this.fileSavePathList = fileSavePathList;
	}
	public String getFileSavePath() {
		return fileSavePath;
	}
	public void setFileSavePath(String fileSavePath) {
		this.fileSavePath = fileSavePath;
	}
	public float getFileSize() {
		return fileSize;
	}
	public void setFileSize(float fileSize) {
		this.fileSize = fileSize;
	}
	public byte[] getFileByte() {
		return fileByte;
	}
	public void setFileByte(byte[] fileByte) {
		this.fileByte = fileByte;
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
	public String getComptDttm() {
		return comptDttm;
	}
	public void setComptDttm(String comptDttm) {
		this.comptDttm = comptDttm;
	}
	public String getBikeNoYn() {
		return bikeNoYn;
	}
	public void setBikeNoYn(String bikeNoYn) {
		this.bikeNoYn = bikeNoYn;
	}
	public String getBikeMYID() {
		return bikeMYID;
	}
	public void setBikeMYID(String bikeMYID) {
		this.bikeMYID = bikeMYID;
	}
	public String getBikeMYIDYn() {
		return bikeMYIDYn;
	}
	public void setBikeMYIDYn(String bikeMYIDYn) {
		this.bikeMYIDYn = bikeMYIDYn;
	}
	public String getLostBikeYn() {
		return lostBikeYn;
	}
	public void setLostBikeYn(String lostBikeYn) {
		this.lostBikeYn = lostBikeYn;
	}
	public String getManageCenter() {
		return manageCenter;
	}
	public void setManageCenter(String manageCenter) {
		this.manageCenter = manageCenter;
	}
	public String getReportDate() {
		return reportDate;
	}
	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}
	public String getReportCd() {
		return reportCd;
	}
	public void setReportCd(String reportCd) {
		this.reportCd = reportCd;
	}
	public String getReportNm() {
		return reportNm;
	}
	public void setReportNm(String reportNm) {
		this.reportNm = reportNm;
	}
	public String getReportPno() {
		return reportPno;
	}
	public void setReportPno(String reportPno) {
		this.reportPno = reportPno;
	}
	public String getReportDetail() {
		return reportDetail;
	}
	public void setReportDetail(String reportDetail) {
		this.reportDetail = reportDetail;
	}
	public String getReportYn() {
		return reportYn;
	}
	public void setReportYn(String reportYn) {
		this.reportYn = reportYn;
	}
	public String getRtrvlDate() {
		return rtrvlDate;
	}
	public void setRtrvlDate(String rtrvlDate) {
		this.rtrvlDate = rtrvlDate;
	}
	public String getRtrvlNm() {
		return rtrvlNm;
	}
	public void setRtrvlNm(String rtrvlNm) {
		this.rtrvlNm = rtrvlNm;
	}
	public String getRtrvlPlace() {
		return rtrvlPlace;
	}
	public void setRtrvlPlace(String rtrvlPlace) {
		this.rtrvlPlace = rtrvlPlace;
	}
	public String getRtrvlCd() {
		return rtrvlCd;
	}
	public void setRtrvlCd(String rtrvlCd) {
		this.rtrvlCd = rtrvlCd;
	}
	public String getRtrvlDetail() {
		return rtrvlDetail;
	}
	public void setRtrvlDetail(String rtrvlDetail) {
		this.rtrvlDetail = rtrvlDetail;
	}
	public String getStationSeCd() {
		return stationSeCd;
	}
	public void setStationSeCd(String stationSeCd) {
		this.stationSeCd = stationSeCd;
	}
	public String getStationClsCd() {
		return stationClsCd;
	}
	public void setStationClsCd(String stationClsCd) {
		this.stationClsCd = stationClsCd;
	}
	public String getBikeSeCd() {
		return bikeSeCd;
	}
	public void setBikeSeCd(String bikeSeCd) {
		this.bikeSeCd = bikeSeCd;
	}
	public String getFaultSeq() {
		return faultSeq;
	}
	public void setFaultSeq(String faultSeq) {
		this.faultSeq = faultSeq;
	}
	public String getFaultName() {
		return faultName;
	}
	public void setFaultName(String faultName) {
		this.faultName = faultName;
	}
	
}
