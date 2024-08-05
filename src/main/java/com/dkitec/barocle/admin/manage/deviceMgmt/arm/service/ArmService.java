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
package com.dkitec.barocle.admin.manage.deviceMgmt.arm.service;

import java.sql.SQLException;
import java.util.List;

import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO;

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
public interface ArmService {

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService.getStation
	 * @writeDay : 2015. 4. 21. 오후 7:21:21
	 * @return   : Object
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	List<String> getStation(String stationGrpSeq) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService.getArmList
	 * @writeDay : 2015. 4. 21. 오후 7:24:45
	 * @return   : List<ApVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	List<ArmVO> getArmList(ArmVO armVo) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService.getArmListCount
	 * @writeDay : 2015. 4. 21. 오후 7:24:57
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	int getArmListCount(ArmVO armVo) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService.getArmInfo
	 * @writeDay : 2015. 4. 21. 오후 7:27:49
	 * @return   : ArmVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	ArmVO getArmInfo(ArmVO armVo) ;

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
	int setArmDevice(ArmVO armVo, ArmVO oldVo) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService.isChkIdDup
	 * @writeDay : 2015. 4. 21. 오후 7:29:32
	 * @return   : boolean
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	boolean isChkIdDup(String apId) ;

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
	int addArmDevice(ArmVO armVo) ;

	/**
	 * @param string 
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService.setArmLasChkDttm
	 * @writeDay : 2015. 5. 6. 오후 7:58:55
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 6.   |   ymshin   |  최초작성
	 */ 
	int setArmLasChkDttm(List<ArmVO> resultList, String string);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService.isEquipExist
	 * @writeDay : 2015. 5. 7. 오후 3:38:50
	 * @return   : boolean
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 7.   |   ymshin   |  최초작성
	 */ 
	boolean isEquipExist(ArmVO armVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService.getArmLocateInfo
	 * @writeDay : 2015. 5. 7. 오후 4:25:16
	 * @return   : ArmVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 7.   |   ymshin   |  최초작성
	 */ 
	ArmVO getArmLocateInfo(String rackId);

}
