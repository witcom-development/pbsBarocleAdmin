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
package com.dkitec.barocle.admin.manage.deviceMgmt.beacon.service;

import java.sql.SQLException;
import java.util.List;

import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.beacon.vo.BeaconVO;

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
public interface BeaconService {

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
	List<BeaconVO> getBeaconList(BeaconVO beaconVo) throws SQLException;


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
	int getBeaconListCount(BeaconVO beaconVo)  throws SQLException;
	
	BeaconVO getBeaconInfo(BeaconVO beaconVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.beacon.service.BeaconService.isChkIdDup
	 * @writeDay : 2019. 11. 12. 오후 8:47:45
	 * @return   : boolean
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2019. 11. 12.   |   ymshin   |  최초작성
	 */ 
	boolean isChkIdDup(BeaconVO beaconVo) ;
	
	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService.addArmDevice
	 * @writeDay : 2015. 4. 21. 오후 7:30:07
	 * @return   : int
	 * @Todo     : 단건 등록
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	int addBeaconDevice(BeaconVO beaconVo) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService.setArmDevice
	 * @writeDay : 2015. 4. 21. 오후 7:29:25
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	int setBeaconDevice(BeaconVO beaconVo) ;
	
	public BeaconVO getBeaconInfoBySerial(BeaconVO beaconVo);
	
	public int matchingBeacon(BeaconVO beaconVo);
	
	int delConnBeacon(BeaconVO beaconVo) ;

}
