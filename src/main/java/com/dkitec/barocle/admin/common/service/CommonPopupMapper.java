/*
 * @Package Name : com.dkitec.barocle.admin.manage.deviceMgmt.common.service
 * @파일명          : DeviceCommonMapper.java
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
import com.dkitec.barocle.admin.service.paymentmgmt.mileage.vo.MileageVO;
import com.dkitec.barocle.admin.status.rentHistory.vo.PenaltyVO;
import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;
import com.dkitec.barocle.admin.system.teammgmt.vo.TeamMgmtVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @파일명          : DeviceCommonMapper.java
 * @작성일          : 2015. 4. 24.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 24.   |   ymshin   |  최초작성
 */
@Mapper("commonPopupMapper")
public interface CommonPopupMapper {

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.DeviceCommonMapper.setApLastChkDttm
	 * @writeDay : 2015. 4. 24. 오후 2:27:50
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 24.   |   ymshin   |  최초작성
	 */ 
	int setApLastChkDttm(RegularChkVO rVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.DeviceCommonMapper.setArmLastChkDttm
	 * @writeDay : 2015. 4. 24. 오후 2:28:01
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 24.   |   ymshin   |  최초작성
	 */ 
	int setArmLastChkDttm(RegularChkVO rVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.DeviceCommonMapper.setBikeLastChkDttm
	 * @writeDay : 2015. 4. 24. 오후 2:28:08
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 24.   |   ymshin   |  최초작성
	 */ 
	int setBikeLastChkDttm(RegularChkVO rVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.DeviceCommonMapper.setTerminalLastChkDttm
	 * @writeDay : 2015. 4. 24. 오후 2:28:14
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 24.   |   ymshin   |  최초작성
	 */ 
	int setTerminalLastChkDttm(RegularChkVO rVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.DeviceCommonMapper.getApDeviceInfo
	 * @writeDay : 2015. 4. 24. 오후 2:36:21
	 * @return   : List<FindOutDeviceVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 24.   |   ymshin   |  최초작성
	 */ 
	List<FindOutDeviceVO> getApDeviceInfo(FindOutDeviceVO foVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.DeviceCommonMapper.getArmDeviceInfo
	 * @writeDay : 2015. 4. 24. 오후 2:36:26
	 * @return   : List<FindOutDeviceVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 24.   |   ymshin   |  최초작성
	 */ 
	List<FindOutDeviceVO> getArmDeviceInfo(FindOutDeviceVO foVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.DeviceCommonMapper.getBikeDeviceInfo
	 * @writeDay : 2015. 4. 24. 오후 2:36:49
	 * @return   : List<FindOutDeviceVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 24.   |   ymshin   |  최초작성
	 */ 
	List<FindOutDeviceVO> getBikeDeviceInfo(FindOutDeviceVO foVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.DeviceCommonMapper.getTerminalDeviceInfo
	 * @writeDay : 2015. 4. 24. 오후 2:36:56
	 * @return   : List<FindOutDeviceVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 24.   |   ymshin   |  최초작성
	 */ 
	List<FindOutDeviceVO> getTerminalDeviceInfo(FindOutDeviceVO foVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.DeviceCommonMapper.getStations
	 * @writeDay : 2015. 4. 24. 오후 3:32:42
	 * @return   : List<String>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 24.   |   ymshin   |  최초작성
	 */ 
	List<String> getStations(String searchWords);

	int addRegularChkUpInfo(RegularChkVO rVo);
	
	int updateFaultType(RegularChkVO rVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.DeviceCommonMapper.getBeforeChkInfo
	 * @writeDay : 2015. 4. 27. 오전 11:42:50
	 * @return   : RegularChkVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 27.   |   ymshin   |  최초작성
	 */ 
	RegularChkVO getBeforeChkInfo(RegularChkVO rVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.common.service.DeviceCommonMapper.getRentDetail
	 * @writeDay : 2015. 5. 4. 오후 2:36:32
	 * @return   : BikeRentalVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 4.   |   ymshin   |  최초작성
	 */ 
	BikeRentalVO getRentDetail(String rentHistSeq);

	PenaltyVO getPenaltyDetailInfo(PenaltyVO penaltyVo);

	int addRentPenaltyImpose(PenaltyVO penaltyVo);

	int delRentPenaltyImpose(PenaltyVO penaltyVo);

	/**
	 * @location : com.dkitec.barocle.admin.common.service.CommonPopupMapper.getSmsMessageList
	 * @writeDay : 2015. 5. 18. 오전 10:06:44
	 * @return   : List<SmsSendVo>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 18.   |   ymshin   |  최초작성
	 */ 
	List<SmsSendVo> getSmsMessageList();

	TroubleReportVO getTroubleReportInfo(TroubleReportVO troubleReportVo);
	
	String getStationName(TroubleReportVO troubleReportVo);
	
	int insertTrouble(TroubleReportVO troubleReportVo);
	
	int insertTroubleType(TroubleReportVO troubleReportVo);
	
	int updateTrouble(TroubleReportVO troubleReportVo);

	int updateApStatus(TroubleReportVO troubleReportVo);
	
	int updateBikeStatus(TroubleReportVO troubleReportVo);
	
	int updateLockStatus(TroubleReportVO troubleReportVo);
	
	int insertTroubleDetail(TroubleReportVO troubleReportVo);
	
	int deleteTroubleDetail(TroubleReportVO troubleReportVo);

	/**
	 * @location : com.dkitec.barocle.admin.common.service.CommonPopupMapper.isBlackList
	 * @writeDay : 2015. 7. 9. 오후 4:34:25
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 7. 9.   |   ymshin   |  최초작성
	 */ 
	int isBlackList(PenaltyVO penaltyVo);

	/**
	 * @location : com.dkitec.barocle.admin.common.service.CommonPopupMapper.existBlackUsr
	 * @writeDay : 2015. 7. 9. 오후 6:10:14
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 7. 9.   |   ymshin   |  최초작성
	 */ 
	int existBlackUsr(PenaltyVO penaltyVo);

	int chkFaultExist(TroubleReportVO troubleReportVo);
	
	int addMileageImpose(MileageVO mileageVo);
	
	List<TeamMgmtVO> getTeamInfo(TeamMgmtVO teamVo);

	List<FindOutDeviceVO> getBikeDeviceDtlObsInfo(FindOutDeviceVO foVo);
}
