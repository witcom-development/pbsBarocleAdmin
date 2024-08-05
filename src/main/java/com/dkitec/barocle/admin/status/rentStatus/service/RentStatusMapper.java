/*
 * @Package Name : com.dkitec.barocle.admin.status.rentStatus.service
 * @파일명          : RentStatusMapper.java
 * @작성일          : 2015. 5. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 15.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.rentStatus.service;

import java.util.List;
import java.util.Map;

import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @파일명          : RentStatusMapper.java
 * @작성일          : 2015. 5. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 15.   |   ymshin   |  최초작성
 */
@Mapper("rentStatusMapper")
public interface RentStatusMapper {

	/**
	 * @location : com.dkitec.barocle.admin.status.rentStatus.service.RentStatusMapper.getRentStatusList
	 * @writeDay : 2015. 5. 15. 오후 5:12:06
	 * @return   : List<CommonCodeVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 15.   |   ymshin   |  최초작성
	 */ 
	List<CommonCodeVO> getRentStatusList(BikeRentalVO rentalVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.rentStatus.service.RentStatusMapper.getRentStatusAllCnt
	 * @writeDay : 2015. 5. 15. 오후 5:12:13
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 15.   |   ymshin   |  최초작성
	 */ 
	int getRentStatusAllCnt(BikeRentalVO rentalVo);

	List<String> getSmsAllUsrMpnNo(BikeRentalVO rentalVo);

	BikeRentalVO getRentStatusInfo(BikeRentalVO rentalVo);

	BikeRentalVO getCompulsionInfo(BikeRentalVO rentalVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.rentStatus.service.RentStatusMapper.delCurrnetRentData
	 * @writeDay : 2015. 5. 27. 오후 1:02:54
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 27.   |   ymshin   |  최초작성
	 */ 
	int delCurrnetRentData(BikeRentalVO current);

	/**
	 * @location : com.dkitec.barocle.admin.status.rentStatus.service.RentStatusMapper.getCurrentRentData
	 * @writeDay : 2015. 5. 27. 오후 1:34:28
	 * @return   : BikeRentalVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 27.   |   ymshin   |  최초작성
	 */ 
	BikeRentalVO getCurrentRentData(BikeRentalVO bikeVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.rentStatus.service.RentStatusMapper.addRentHistory
	 * @writeDay : 2015. 5. 27. 오후 1:50:45
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 27.   |   ymshin   |  최초작성
	 */ 
	int addRentHistory(BikeRentalVO current);

	/**
	 * @location : com.dkitec.barocle.admin.status.rentStatus.service.RentStatusMapper.getOverFeePolicy
	 * @writeDay : 2015. 7. 22. 오후 5:06:03
	 * @return   : Map<String,Object>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 7. 22.   |   ymshin   |  최초작성
	 */ 
	Map<String, Object> getOverFeePolicy(Map<String, Object> fee);

	/**
	 * @location : com.dkitec.barocle.admin.status.rentStatus.service.RentStatusMapper.addOverFeeInfo
	 * @writeDay : 2015. 7. 22. 오후 6:28:39
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 7. 22.   |   ymshin   |  최초작성
	 */ 
	int addOverFeeInfo(BikeRentalVO currentInfo);

	int setRentTempPwSend(BikeRentalVO rentalVo);
	
	/**
	 * @location : com.dkitec.barocle.admin.status.rentStatus.service.RentStatusMapper.addRentHistory
	 * @writeDay : 2015. 5. 27. 오후 1:50:45
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 27.   |   ymshin   |  최초작성
	 */ 
	int addExeImpulseReturnHistory(BikeRentalVO currentInfo);
	
	List<BikeRentalVO> getExeImpulseReturnList(BikeRentalVO bikeVo);
	
	int getExeImpulseReturnListCnt(BikeRentalVO rentalVo);
	
	int compExeImpulseProc(BikeRentalVO currentInfo);
	
	BikeRentalVO getExeImpulseCntInfo(BikeRentalVO bikeVo);
	
	BikeRentalVO getExeImpulseReturnInfo(BikeRentalVO bikeVo);
	
	int updateExeImpulseProc(BikeRentalVO currentInfo);
	
	int insertEnfrcFileList(Map<String,List<BikeRentalVO>> map);
	
	BikeRentalVO getEnfrcViewInfo(BikeRentalVO bikeVo);

	public List<BikeRentalVO> listEnfrcFile(BikeRentalVO rentalVo);
	
	String checkBikeStatus(BikeRentalVO rentalVo);
	
	String checkEnfrcInfo(BikeRentalVO rentalVo);
	
	int chkEnfrcFile(BikeRentalVO rentalVo);
	
	int updateEnfrcFile(BikeRentalVO rentalVo);

	String getTeamName(BikeRentalVO rentVo);

	int addBikeRobbedHistory(BikeRentalVO rentalVo);

	int addBikeRtrvlHistory(BikeRentalVO rentalVo);

	BikeRentalVO getSearchBikeNo(BikeRentalVO rentalVo);
	
	BikeRentalVO getBikeMapInfo(BikeRentalVO rentalVo);
	
	
	// 20200617 
	int insertParkingInfo(BikeRentalVO rentalVo);
	
	int updateBikeStatus(BikeRentalVO rentalVo);
}
