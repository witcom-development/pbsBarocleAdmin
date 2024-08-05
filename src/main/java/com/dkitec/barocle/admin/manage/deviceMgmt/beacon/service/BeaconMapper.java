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
package com.dkitec.barocle.admin.manage.deviceMgmt.beacon.service;

import java.util.List;

import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.beacon.vo.BeaconVO;

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
@Mapper("beaconMapper")
public interface BeaconMapper {

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
	List<BeaconVO> getBeaconList(BeaconVO beaconVo);

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
	int getBeaconListCount(BeaconVO beaconVo);

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

	BeaconVO getBeaconInfo(BeaconVO beaconVo);

	
	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.beacon.service.BeaconMapper.isChkIdDup
	 * @writeDay : 2015. 4. 19. 오후 8:55:58
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 19.   |   ymshin   |  최초작성
	 */ 
	int isChkIdDup(BeaconVO beaconVo);
	

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApMapper.insertDeviceReg
	 * @writeDay : 2015. 4. 19. 오후 8:51:01
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 19.   |   ymshin   |  최초작성
	 */ 
	int insertDeviceReg(BeaconVO beaconVo);
	
	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmMapper.setArmDevice
	 * @writeDay : 2015. 4. 22. 오후 2:03:52
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 22.   |   ymshin   |  최초작성
	 */ 
	int setBeaconDevice(BeaconVO vo) ;
	
	int setQRBeaconDevice(BeaconVO vo) ;
	
	BeaconVO getBeaconInfoBySerial(BeaconVO beaconVo);
	
	int delMatchingBeaconDevice(BeaconVO beaconVo);
	
	int addMatchingBeaconDevice(BeaconVO beaconVo);
	
	int insertBeaconReg(BeaconVO beaconVo);
}
