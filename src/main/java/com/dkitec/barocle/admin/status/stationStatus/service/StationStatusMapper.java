/*
 * @Package Name : com.dkitec.barocle.admin.status.stationStaus.service
 * @파일명          : StationStatusMapper.java
 * @작성일          : 2015. 5. 18.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 18.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.stationStatus.service;

import java.util.List;

import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.admin.status.stationStatus.vo.StationStatusVO;
import com.dkitec.barocle.admin.status.stationStatus.vo.StationVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @파일명          : StationStatusMapper.java
 * @작성일          : 2015. 5. 18.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 18.   |   ymshin   |  최초작성
 */
@Mapper(value="stationStatusMapper")
public interface StationStatusMapper {

	/**
	 * @location : com.dkitec.barocle.admin.status.stationStaus.service.StationStatusMapper.getStationStatusTotCnt
	 * @writeDay : 2015. 5. 18. 오후 9:32:47
	 * @return   : StationStatusVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 18.   |   ymshin   |  최초작성
	 */ 
	StationStatusVO getStationStatusTotCnt(String langKr);

	/**
	 * @location : com.dkitec.barocle.admin.status.stationStaus.service.StationStatusMapper.getBrokenDeviceTotCnt
	 * @writeDay : 2015. 5. 18. 오후 9:32:52
	 * @return   : StationStatusVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 18.   |   ymshin   |  최초작성
	 */ 
	StationStatusVO getBrokenDeviceTotCnt();

	/**
	 * @location : com.dkitec.barocle.admin.status.stationStaus.service.StationStatusMapper.geBikeStatusTotCnt
	 * @writeDay : 2015. 5. 18. 오후 9:32:58
	 * @return   : StationStatusVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 18.   |   ymshin   |  최초작성
	 */ 
	StationStatusVO geBikeStatusTotCnt();

	/**
	 * @location : com.dkitec.barocle.admin.status.stationStaus.service.StationStatusMapper.getRentStatusTotCnt
	 * @writeDay : 2015. 5. 18. 오후 9:33:04
	 * @return   : StationStatusVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 18.   |   ymshin   |  최초작성
	 */ 
	StationStatusVO getRentStatusTotCnt();

	/**
	 * @location : com.dkitec.barocle.admin.status.stationStaus.service.StationStatusMapper.getStationStautsList
	 * @writeDay : 2015. 5. 19. 오전 10:11:57
	 * @return   : List<StationMapVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 19.   |   ymshin   |  최초작성
	 */ 
	List<StationStatusVO> getStationStautsList(StationStatusVO mapVo);

	List<StationVO> getStationStautsListNew(StationVO mapVo);
	
	List<StationVO> getStationStautsListRound(StationVO mapVo);
	
	/**
	 * @location : com.dkitec.barocle.admin.status.stationStatus.service.StationStatusMapper.getStationApList
	 * @writeDay : 2015. 5. 19. 오후 4:39:58
	 * @return   : List<ApVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 19.   |   ymshin   |  최초작성
	 */ 
	ApVO getStationApList(StationStatusVO mapVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.stationStatus.service.StationStatusMapper.getStationBikeList
	 * @writeDay : 2015. 5. 19. 오후 4:40:04
	 * @return   : List<BikeVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 19.   |   ymshin   |  최초작성
	 */ 
	List<BikeVO> getStationBikeList(StationStatusVO mapVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.stationStatus.service.StationStatusMapper.getStationArmList
	 * @writeDay : 2015. 5. 19. 오후 4:40:25
	 * @return   : List<ArmVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 19.   |   ymshin   |  최초작성
	 */ 
	List<ArmVO> getStationArmList(StationStatusVO mapVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.stationStatus.service.StationStatusMapper.getCurrentStationDetail
	 * @writeDay : 2015. 5. 19. 오후 4:54:50
	 * @return   : StationMapVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 19.   |   ymshin   |  최초작성
	 */ 
	StationStatusVO getCurrentStationDetail(StationStatusVO mapVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.stationStatus.service.StationStatusMapper.getStationRackTotInfo
	 * @writeDay : 2015. 5. 19. 오후 6:10:36
	 * @return   : ArmVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 19.   |   ymshin   |  최초작성
	 */ 
	ArmVO getStationRackTotInfo(StationStatusVO mapVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.stationStatus.service.StationStatusMapper.getStationListCount
	 * @writeDay : 2015. 8. 24. 오후 3:22:12
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 8. 24.   |   ymshin   |  최초작성
	 */ 
	int getStationListCount(StationStatusVO mapVo);

	StationStatusVO getRealStation(StationStatusVO statusVo);				//실시간 매출현황, 홈페이지 가입현황, 자전거 재고현황_cms_20161125

	List<StationStatusVO> getRealStationList(StationStatusVO statusVo);		//상하위 대여소_cms_20161125

	List<StationStatusVO> getRealStationList2(StationStatusVO statusVo);	//전체 및 지역별 이용건수_cms_20161125

	List<StationStatusVO> getRealStationList3(StationStatusVO statusVo);	//지역별 배치현황_cms_20161125	

	List<StationStatusVO> getRealBikeList(StationStatusVO statusVo);		//운영중 자전거_cms_20161125	

	List<StationStatusVO> getNoticeList(StationStatusVO statusVo);			//공지사항 최신항목 5개_cms_20161219

	int exeRentBookingCancelProc(ArmVO armVo);

	int setCancelUsr(ArmVO armVo);
	
	List<StationStatusVO> getStationNameList(StationStatusVO statusVo);

	List<StationStatusVO> getBikeBatLowStationList(StationStatusVO statusVo);	//2020-12-07 : 배터리 부족한 자전거가 거치되어있는 대여소 조회
 
	
}
