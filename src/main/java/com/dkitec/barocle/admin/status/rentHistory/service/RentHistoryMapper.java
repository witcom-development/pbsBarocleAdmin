/*
 * @Package Name : com.dkitec.barocle.admin.status.rentHistory.service
 * @파일명          : rentHistoryMapper.java
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

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @파일명          : rentHistoryMapper.java
 * @작성일          : 2015. 5. 14.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 14.   |   ymshin   |  최초작성
 */
@Mapper("rentHistoryMapper")
public interface RentHistoryMapper {

	/**
	 * @location : com.dkitec.barocle.admin.status.rentHistory.service.RentHistoryMapper.getRentHistoryAllCnt
	 * @writeDay : 2015. 5. 14. 오전 11:50:26
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 14.   |   ymshin   |  최초작성
	 */ 
	int getRentHistoryAllCnt(BikeRentalVO rentalVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.rentHistory.service.RentHistoryMapper.getRentHistoryList
	 * @writeDay : 2015. 5. 14. 오전 11:50:34
	 * @return   : List<CommonCodeVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 14.   |   ymshin   |  최초작성
	 */ 
	List<CommonCodeVO> getRentHistoryList(BikeRentalVO rentalVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.rentHistory.service.RentHistoryMapper.getRentHistInfoDetail
	 * @writeDay : 2015. 5. 14. 오후 3:32:44
	 * @return   : BikeRentalVO
	 * @Todo     : 특정 대여번호에 대한 상세데이터
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 14.   |   ymshin   |  최초작성
	 */ 
	BikeRentalVO getRentHistInfoDetail(BikeRentalVO rentalVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.rentHistory.service.RentHistoryMapper.getPenaltyList
	 * @writeDay : 2015. 5. 14. 오후 5:53:16
	 * @return   : List<PenaltyVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 14.   |   ymshin   |  최초작성
	 */ 
	List<PenaltyVO> getPenaltyList(BikeRentalVO rentalVo);


}
