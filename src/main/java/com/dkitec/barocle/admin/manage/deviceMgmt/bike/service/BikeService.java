/*
 * @Package Name : com.dkitec.barocle.admin.manage.DeviceMgmt.service
 * @파일명          : DeviceMgmtService.java
 * @작성일          : 2015. 4. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 15.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.manage.deviceMgmt.bike.service;

import java.sql.SQLException;
import java.util.List;

import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;

/**
 * @파일명          : DeviceMgmtService.java
 * @작성일          : 2015. 4. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 15.   |   ymshin   |  최초작성
 */
public interface BikeService {

	/**
	 * @param string 
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService.getBikeList
	 * @writeDay : 2015. 4. 21. 오후 7:40:12
	 * @return   : List<BikeVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	List<BikeVO> getBikeList(BikeVO bikeVo) throws SQLException;


	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService.getBikeInfo
	 * @writeDay : 2015. 4. 21. 오후 7:42:28
	 * @return   : BikeVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	BikeVO getBikeInfo(BikeVO bikeVo)  throws SQLException;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService.getBikeCurrentInfo
	 * @writeDay : 2015. 4. 21. 오후 7:42:28
	 * @return   : BikeVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	BikeVO getBikeCurrentInfo(BikeVO bikeVo)  throws SQLException;
	/**
	 * @param oldInfo 
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService.setBikeData
	 * @writeDay : 2015. 4. 21. 오후 7:42:28
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	int setBikeDevice(BikeVO bikeVo, BikeVO oldInfo)  throws SQLException;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService.getBikeListCount
	 * @writeDay : 2015. 4. 21. 오후 7:42:28
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	int getBikeListCount(BikeVO bikeVo)  throws SQLException;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService.getChkBikeIDnNo
	 * @writeDay : 2015. 4. 23. 오후 1:15:27
	 * @return   : BikeVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	BikeVO getChkBikeIDnNo(BikeVO bikeVo);



	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService.getBikeHistoryInfoCount
	 * @writeDay : 2015. 4. 23. 오후 1:59:46
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	int getBikeHistoryInfoCount(BikeVO bikeVo);


	/**
	 * @param string 
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService.addNewBikeDevice
	 * @writeDay : 2015. 4. 23. 오후 5:23:26
	 * @return   : void
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	int addNewBikeDevice(BikeVO bikeVo);


	List<String> getStation(String searchWord);


	/**
	 * @param string 
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService.setBikeLasChkDttm
	 * @writeDay : 2015. 5. 4. 오전 10:58:10
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 4.   |   ymshin   |  최초작성
	 */ 
	int setBikeLasChkDttm(List<BikeVO> resultList, String string);


	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService.getOldBikeInfo
	 * @writeDay : 2015. 5. 8. 오전 9:43:03
	 * @return   : BikeVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 8.   |   ymshin   |  최초작성
	 */ 
	BikeVO getOldBikeInfo(String bikeId);


	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService.getBikeHistoryInfo
	 * @writeDay : 2015. 5. 18. 오전 11:05:55
	 * @return   : List<BikeRentalVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 18.   |   ymshin   |  최초작성
	 */ 
	List<BikeRentalVO> getBikeHistoryInfo(BikeVO bikeVo);


	int getBikeRobListCount(BikeVO bikeVo);


	List<BikeVO> getBikeRobList(BikeVO bikeVo);

	BikeVO getQRBikeInfo(BikeVO bikeVo);


	int exeQrMoveProc(BikeVO bikeVo);

	int setBikeRelocateHistNew(BikeVO bikeVo);

	int exeQRBikeRelocate(BikeVO bikeVo);

	BikeVO getBikeLog(BikeVO bikeVo)  throws SQLException;
	
	// 2020-04-28
	List<BikeVO> getBikeLostLog();

	// 2020-11-16
	BikeVO getQRBikeStatusCd(BikeVO bikeVo);
	
	// 2021-05-28
	BikeVO getQRBikeInfoPhone(BikeVO bikeVo);
	
	// 2021-10-26
	List<BikeVO> selectBikeRelocateTarget(BikeVO bikeVo); 
	int updateBikeRelocateSeq(BikeVO bikeVo);
	
	
}
