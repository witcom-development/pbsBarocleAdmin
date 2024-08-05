/*
 * @Package Name : com.dkitec.barocle.admin.status.rentHistory.service
 * @파일명          : RentHistoryService.java
 * @작성일          : 2015. 5. 14.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 14.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.rentHistory.service;

import java.util.List;

import com.dkitec.barocle.admin.status.rentHistory.vo.PenaltyVO;
import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;


/**
 * @파일명          : RentHistoryService.java
 * @작성일          : 2015. 5. 14.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 14.   |   ymshin   |  최초작성
 */
public interface RentHistoryService {

	/**
	 * @location : com.dkitec.barocle.admin.status.rentHistory.service.RentHistoryService.getRentHistoryAllCnt
	 * @writeDay : 2015. 5. 14. 오전 11:48:25
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 14.   |   ymshin   |  최초작성
	 */ 
	int getRentHistoryAllCnt(BikeRentalVO rentalVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.rentHistory.service.RentHistoryService.getRentHistoryList
	 * @writeDay : 2015. 5. 14. 오전 11:48:30
	 * @return   : List<CommonCodeVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 14.   |   ymshin   |  최초작성
	 */ 
	List<CommonCodeVO> getRentHistoryList(BikeRentalVO rentalVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.rentHistory.service.RentHistoryService.getRentHistInfoDetail
	 * @writeDay : 2015. 5. 14. 오후 3:31:57
	 * @return   : BikeRentalVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 14.   |   ymshin   |  최초작성
	 */ 
	BikeRentalVO getRentHistInfoDetail(BikeRentalVO rentalVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.rentHistory.service.RentHistoryService.getPenaltyList
	 * @writeDay : 2015. 5. 14. 오후 5:52:06
	 * @return   : List<PenaltyVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 14.   |   ymshin   |  최초작성
	 */ 
	List<PenaltyVO> getPenaltyList(BikeRentalVO rentInfo);


}
