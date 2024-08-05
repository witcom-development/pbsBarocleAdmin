/*
 * @Package Name : com.dkitec.barocle.admin.status.rentStatus.service
 * @파일명          : RentStatusService.java
 * @작성일          : 2015. 5. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 15.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.rentStatus.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;

/**
 * @파일명          : RentStatusService.java
 * @작성일          : 2015. 5. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 15.   |   ymshin   |  최초작성
 */
public interface RentStatusService {

	/**
	 * @location : com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService.getRentStatusAllCnt
	 * @writeDay : 2015. 5. 15. 오후 5:08:41
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 15.   |   ymshin   |  최초작성
	 */ 
	int getRentStatusAllCnt(BikeRentalVO rentalVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService.getRentStatusList
	 * @writeDay : 2015. 5. 15. 오후 5:08:47
	 * @return   : List<CommonCodeVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 15.   |   ymshin   |  최초작성
	 */ 
	List<CommonCodeVO> getRentStatusList(BikeRentalVO rentalVo);

	List<String> getSmsAllUsrMpnNo(BikeRentalVO rentalVo);

	BikeRentalVO getRentStatusInfo(BikeRentalVO rentalVo);

	BikeRentalVO getCompulsionInfo(BikeRentalVO rentalVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService.getCurrentRentData
	 * @writeDay : 2015. 5. 27. 오후 1:33:27
	 * @return   : BikeRentalVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 27.   |   ymshin   |  최초작성
	 */ 
	BikeRentalVO getCurrentRentData(BikeRentalVO bikeVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService.delCurrnetRentData
	 * @writeDay : 2015. 7. 22. 오후 4:23:42
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 7. 22.   |   ymshin   |  최초작성
	 */ 
	int delCurrnetRentData(BikeRentalVO rentalVo);

	/**
	 * @location : com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService.addRentHistory
	 * @writeDay : 2015. 7. 22. 오후 4:41:03
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 7. 22.   |   ymshin   |  최초작성
	 */ 
	int exeImpulseBikeReturn(BikeRentalVO currentInfo);

	/**
	 * @location : com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService.getOverFeePolicy
	 * @writeDay : 2015. 7. 22. 오후 5:05:11
	 * @return   : Map<String,Object>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 7. 22.   |   ymshin   |  최초작성
	 */ 
	Map<String, Object> getOverFeePolicy(Map<String, Object> fee);

	int setRentTempPwSend(BikeRentalVO rentalVo);
	
	List<BikeRentalVO> getExeImpulseReturnList(BikeRentalVO rentalVo);
	
	int getExeImpulseReturnListCnt(BikeRentalVO rentalVo);

	int compExeImpulseProc(BikeRentalVO currentInfo);
	
	BikeRentalVO getExeImpulseCntInfo(BikeRentalVO rentalVo);
	
	BikeRentalVO getExeImpulseReturnInfo(BikeRentalVO rentalVo);
	int updateExeImpulseProc(BikeRentalVO currentInfo);
	int exeBikeParkingLoication(BikeRentalVO currentInfo);
	public void insertPhysicalEnfrcFile(BikeRentalVO rentalVo) throws IOException;
	
	BikeRentalVO getEnfrcViewInfo(BikeRentalVO bikeVo);
	public List<BikeRentalVO> listEnfrcFile(BikeRentalVO rentalVo);
	
	public void checkEnfrc(BikeRentalVO rentalVo);

	String getTeamName(BikeRentalVO rentVo);

	int addBikeRobbedHistory(BikeRentalVO rentalVo);

	int addBikeRtrvlHistory(BikeRentalVO rentalVo);

	BikeRentalVO getSearchBikeNo(BikeRentalVO rentalVo);
	
	BikeRentalVO getBikeMapInfo(BikeRentalVO rentalVo);
	
	// 202006017
	int insertParkingInfo(BikeRentalVO rentalVo);
	int updateBikeStatus(BikeRentalVO rentalVo);
}
