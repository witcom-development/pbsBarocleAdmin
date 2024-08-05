/*
 * @Package Name : com.dkitec.barocle.admin.manage.deviceMgmt.common.service
 * @파일명          : DeviceService.java
 * @작성일          : 2015. 4. 24.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 24.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.common.service;

import java.util.List;

import com.dkitec.barocle.admin.common.vo.FindOutDeviceVO;
import com.dkitec.barocle.admin.common.vo.RegularChkVO;
import com.dkitec.barocle.admin.common.vo.SmsSendVo;
import com.dkitec.barocle.admin.common.vo.TroubleReportVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.admin.service.paymentmgmt.mileage.vo.MileageVO;
import com.dkitec.barocle.admin.status.rentHistory.vo.PenaltyVO;
import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;
import com.dkitec.barocle.admin.system.teammgmt.vo.TeamMgmtVO;

/**
 * @파일명          : DeviceService.java
 * @작성일          : 2015. 4. 24.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 24.   |   ymshin   |  최초작성
 */
public interface CommonPopupService {

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.DeviceCommonService.addRegularCheckUpDevice
	 * @writeDay : 2015. 4. 24. 오후 1:56:09
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 24.   |   ymshin   |  최초작성
	 */ 
	int addRegularCheckUpDevice(RegularChkVO rVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.DeviceCommonService.getFindOutDevice
	 * @writeDay : 2015. 4. 24. 오후 2:16:13
	 * @return   : List<FindOutDeviceVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 24.   |   ymshin   |  최초작성
	 */ 
	List<FindOutDeviceVO> getFindOutDevice(FindOutDeviceVO foVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.DeviceCommonService.getBeforeChkInfo
	 * @writeDay : 2015. 4. 27. 오전 11:42:01
	 * @return   : RegularChkVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 27.   |   ymshin   |  최초작성
	 */ 
	RegularChkVO getBeforeChkInfo(RegularChkVO rVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService.setBikeMissingCondition
	 * @writeDay : 2015. 4. 23. 오후 1:29:31
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	int setBikeMissingCondition(BikeVO bikeVo);

	/**
	 * @location : com.dkitec.barocle.admin.common.service.DeviceCommonService.getBikeHistoryInfo
	 * @writeDay : 2015. 5. 14. 오후 8:18:52
	 * @return   : LinkedHashMap<String,Object>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 14.   |   ymshin   |  최초작성
	 */ 
	List<BikeRentalVO> getBikeHistoryInfo(BikeVO bVo);

	PenaltyVO getPenaltyDetailInfo(PenaltyVO penaltyVo);

	int addRentPenaltyImpose(PenaltyVO penaltyVo);

	int delRentPenaltyImpose(PenaltyVO penaltyVo);

	/**
	 * @location : com.dkitec.barocle.admin.common.service.CommonPopupService.getSmsMessageList
	 * @writeDay : 2015. 5. 18. 오전 10:04:24
	 * @return   : List<SmsSendVo>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 18.   |   ymshin   |  최초작성
	 */ 
	List<SmsSendVo> getSmsMessageList();

	/**
	 * @location : com.dkitec.barocle.admin.common.service.CommonPopupService.setBikeMissingRentStatus
	 * @writeDay : 2015. 5. 27. 오후 1:44:28
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 27.   |   ymshin   |  최초작성
	 */ 
	int setBikeMissingRentStatus(BikeRentalVO current);

	TroubleReportVO getTroubleReportInfo(TroubleReportVO troubleReportVo);
	
	String getStationName(TroubleReportVO troubleReportVo);
	
	int insertTrouble(TroubleReportVO troubleReportVo);
	
	int insertTroubleType(TroubleReportVO troubleReportVo);
	
	int updateDeviceStatus(TroubleReportVO troubleReportVo);
	
	int updateTrouble(TroubleReportVO troubleReportVo);
	
	int insertTroubleDetail(TroubleReportVO troubleReportVo);
	
	int deleteTroubleDetail(TroubleReportVO troubleReportVo);

	/**
	 * @location : com.dkitec.barocle.admin.common.service.CommonPopupService.isBlackList
	 * @writeDay : 2015. 7. 9. 오후 4:28:21
	 * @return   : boolean
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 7. 9.   |   ymshin   |  최초작성
	 */ 
	boolean isBlackList(PenaltyVO penaltyVo);

	/**
	 * @location : com.dkitec.barocle.admin.common.service.CommonPopupService.existBlackUsr
	 * @writeDay : 2015. 7. 9. 오후 6:08:51
	 * @return   : boolean
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 7. 9.   |   ymshin   |  최초작성
	 */ 
	boolean existBlackUsr(PenaltyVO penaltyVo);

	boolean chkFaultExist(TroubleReportVO troubleReportVo);
	
	int addMileageImpose(MileageVO mileageVo);
	
	List<TeamMgmtVO> getFindOutTeam(TeamMgmtVO teamVo);

	List<FindOutDeviceVO> getBikeDeviceDtlObsInfo(FindOutDeviceVO foVo);
}
