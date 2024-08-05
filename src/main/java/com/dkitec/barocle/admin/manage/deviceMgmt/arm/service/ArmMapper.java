/*
 * @Package Name : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service
 * @파일명          : ArmMapper.java
 * @작성일          : 2015. 4. 19.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 19.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.manage.deviceMgmt.arm.service;

import java.sql.SQLException;
import java.util.List;

import com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @파일명          : ArmMapper.java
 * @작성일          : 2015. 4. 19.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 19.   |   ymshin   |  최초작성
 */
@Mapper("armMapper")
public interface ArmMapper {

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmMapper.getStation
	 * @writeDay : 2015. 4. 22. 오후 1:19:48
	 * @return   : List<String>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 22.   |   ymshin   |  최초작성
	 */ 
	List<String> getStation(String stationGrpSeq) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmMapper.getArmList
	 * @writeDay : 2015. 4. 22. 오후 1:20:22
	 * @return   : List<ArmVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 22.   |   ymshin   |  최초작성
	 */ 
	List<ArmVO> getArmList(ArmVO armVo) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmMapper.getArmListCount
	 * @writeDay : 2015. 4. 22. 오후 1:20:58
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 22.   |   ymshin   |  최초작성
	 */ 
	int getArmListCount(ArmVO armVo) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmMapper.getArmInfo
	 * @writeDay : 2015. 4. 22. 오후 1:21:35
	 * @return   : ArmVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 22.   |   ymshin   |  최초작성
	 */ 
	ArmVO getArmInfo(ArmVO armVo) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmMapper.isChkIdDup
	 * @writeDay : 2015. 4. 22. 오후 1:22:42
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 22.   |   ymshin   |  최초작성
	 */ 
	int isChkIdDup(String apId) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmMapper.getArmLocateInfo
	 * @writeDay : 2015. 4. 22. 오후 1:49:45
	 * @return   : ArmVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 22.   |   ymshin   |  최초작성
	 */ 
	ArmVO getArmLocateInfo(String rackId) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmMapper.addArmDevice
	 * @writeDay : 2015. 4. 22. 오후 1:52:26
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 22.   |   ymshin   |  최초작성
	 */ 
	int addArmDevice(ArmVO vo) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmMapper.addArmLocateHistory
	 * @writeDay : 2015. 4. 22. 오후 1:52:41
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 22.   |   ymshin   |  최초작성
	 */ 
	int addArmLocateHistory(ArmVO vo) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmMapper.setArmLocateHistory
	 * @writeDay : 2015. 4. 22. 오후 2:03:46
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 22.   |   ymshin   |  최초작성
	 */ 
	int setArmLocateHistory(ArmVO vo) ;

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
	int setArmDevice(ArmVO vo) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmMapper.isEquipExist
	 * @writeDay : 2015. 5. 7. 오후 3:43:51
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 7.   |   ymshin   |  최초작성
	 */ 
	int isEquipExist(ArmVO armVo);

}
