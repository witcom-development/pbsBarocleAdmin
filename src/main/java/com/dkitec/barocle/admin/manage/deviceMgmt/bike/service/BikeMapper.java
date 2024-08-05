/*
 * @Package Name : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service
 * @파일명          : BikeMapper.java
 * @작성일          : 2015. 4. 19.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 19.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.manage.deviceMgmt.bike.service;

import java.util.List;

import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @파일명          : BikeMapper.java
 * @작성일          : 2015. 4. 19.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 19.   |   ymshin   |  최초작성
 */
@Mapper("bikeMapper")
public interface BikeMapper {

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper.getBikeList
	 * @writeDay : 2015. 4. 22. 오후 4:09:59
	 * @return   : List<BikeVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 22.   |   ymshin   |  최초작성
	 */ 
	List<BikeVO> getBikeList(BikeVO bikeVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper.getBikeListCount
	 * @writeDay : 2015. 4. 22. 오후 4:38:51
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 22.   |   ymshin   |  최초작성
	 */ 
	int getBikeListCount(BikeVO bikeVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper.getBikeCurrentInfo
	 * @writeDay : 2015. 4. 22. 오후 5:06:07
	 * @return   : BikeVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 22.   |   ymshin   |  최초작성
	 */ 
	BikeVO getBikeCurrentInfo(BikeVO bikeVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper.getBikeInfo
	 * @writeDay : 2015. 4. 22. 오후 5:06:15
	 * @return   : BikeVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 22.   |   ymshin   |  최초작성
	 */ 
	BikeVO getBikeInfo(BikeVO bikeVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper.getBikeHistoryInfo
	 * @writeDay : 2015. 4. 22. 오후 5:06:55
	 * @return   : List<BikeRentalVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 22.   |   ymshin   |  최초작성
	 */ 
	List<BikeRentalVO> getBikeHistoryInfo(BikeVO bikeVo);
	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper.addBikeLocateHist
	 * @writeDay : 2015. 4. 23. 오후 1:15:59
	 * @return   : int
	 * @Todo     :자전거 배치이력 등록.
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	int addBikeLocateHist(BikeVO bikeVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper.getChkBikeIDnNo
	 * @writeDay : 2015. 4. 23. 오후 1:15:59
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	BikeVO getChkBikeIDnNo(BikeVO bikeVo);
	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper.setBikeHistoryInfo
	 * @writeDay : 2015. 4. 23. 오후 3:54:59
	 * @return   : int
	 * @Todo     :자전거 배치이력 갱신.(최종일자를 현재로 갱신.)
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	int setBikeHistoryInfo(BikeVO bikeVo);
	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper.getBikeHistoryInfoCount
	 * @writeDay : 2015. 4. 23. 오후 1:24:03
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	int getBikeHistoryInfoCount(BikeVO bikeVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper.setBikeDevice
	 * @writeDay : 2015. 4. 23. 오후 1:39:21
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	int setBikeDevice(BikeVO bikeVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper.getBikeHistoryInfoCount
	 * @writeDay : 2015. 4. 23. 오후 2:23:50
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	int getBikeHistoryInfoCount(String bikeId);

	

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper.setMissingTerminal
	 * @writeDay : 2015. 4. 23. 오후 4:01:12
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	int setMissingTerminal(BikeVO bikeVo);


	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper.addNewBikeDevice
	 * @writeDay : 2015. 4. 23. 오후 4:42:16
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	int addNewBikeDevice(BikeVO bikeVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper.getOldBikeInfo
	 * @writeDay : 2015. 4. 23. 오후 5:37:41
	 * @return   : BikeVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	BikeVO getOldBikeInfo(String bikeId);

	List<String> getStation(String searchWord);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper.isBikeParking
	 * @writeDay : 2015. 5. 11. 오후 3:05:50
	 * @return   : boolean
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 11.   |   ymshin   |  최초작성
	 */ 
	String isBikeParking(BikeVO bikeVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper.delBikeParking
	 * @writeDay : 2015. 5. 11. 오후 3:13:03
	 * @return   : int
	 * @Todo     : 분실 등록시 거치되어있는 상태라면 ..
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 11.   |   ymshin   |  최초작성
	 */ 
	int delBikeParking(BikeVO bikeVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeMapper.delBikeParkingInfo
	 * @writeDay : 2015. 7. 15. 오후 5:03:27
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 7. 15.   |   ymshin   |  최초작성
	 */ 
	int delBikeParkingInfo(BikeVO bikeVo);

	int setMissingMtcFaultStatus(BikeVO bikeVo);

	int getBikeRobListCount(BikeVO bikeVo);

	List<BikeVO> getBikeRobList(BikeVO bikeVo);
	
	BikeVO getQRBikeInfo(BikeVO bikeVo);

	int setBikeStatus(BikeVO bikeVo);

	int chkRelocateHist(BikeVO bikeVo);

	int addBikeRelocateHist(BikeVO bikeVo);

	int setBikeRelocateHist(BikeVO bikeVo);
	
	int setBikeRelocateHistNew(BikeVO bikeVo);
	
	BikeVO getBikeLog(BikeVO bikeVo);

	List<BikeVO> getBikeLostLog();

	BikeVO getQRBikeStatusCd(BikeVO bikeVo);
	
	BikeVO getQRBikeInfoPhone(BikeVO bikeVo);
	
	int addDairyReport(BikeVO bikeVo);
	int addDairyRelocate(BikeVO bikeVo);
	
	
	
	// 2021 10 26 재배치 요청 관련 Looping 처리
	BikeVO selectRelocateStationId(BikeVO bikeVo);
	List<BikeVO> selectRelocateSeq(BikeVO bikeVo); 
	int updateBikeRelocateSeq(BikeVO bikeVo);

}
