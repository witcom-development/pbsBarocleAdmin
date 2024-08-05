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
package com.dkitec.barocle.admin.manage.deviceMgmt.ap.service;

import java.sql.SQLException;
import java.util.List;

import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;

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
public interface ApService {
	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService.addAPDevice
	 * @writeDay : 2015. 4. 19. 오후 8:18:40
	 * @return   : void
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 19.   |   ymshin   |  최초작성
	 */ 
	int addAPDevice(ApVO apVo) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService.setAPDevice
	 * @writeDay : 2015. 4. 19. 오후 8:19:36
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 19.   |   ymshin   |  최초작성
	 */ 
	int setAPDevice(ApVO apVo, ApVO oldVo) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService.getApList
	 * @writeDay : 2015. 4. 19. 오후 8:25:30
	 * @return   : List<ApVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 19.   |   ymshin   |  최초작성
	 */ 
	List<ApVO> getApList(ApVO apVo) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService.getAPInfo
	 * @writeDay : 2015. 4. 19. 오후 8:40:42
	 * @return   : ApVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 19.   |   ymshin   |  최초작성
	 */ 
	ApVO getAPInfo(ApVO apVo) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService.isChkIdDup
	 * @writeDay : 2015. 4. 19. 오후 8:47:45
	 * @return   : boolean
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 19.   |   ymshin   |  최초작성
	 */ 
	boolean isChkIdDup(ApVO apVo) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService.getApListCount
	 * @writeDay : 2015. 4. 20. 오후 3:25:44
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 20.   |   ymshin   |  최초작성
	 */ 
	int getApListCount(ApVO apVo) ;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService.getStation
	 * @writeDay : 2015. 4. 21. 오후 3:42:38
	 * @return   : List<String>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	List<String> getStation(String stationGrpSeq) ;

	int setRegularChkComplete(List<ApVO> apList, String string);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService.getApHistoryInfo
	 * @writeDay : 2015. 5. 7. 오후 2:07:06
	 * @return   : ApVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 7.   |   ymshin   |  최초작성
	 */ 
	ApVO getApHistoryInfo(ApVO apVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService.isStationAPExist
	 * @writeDay : 2015. 5. 7. 오후 2:18:26
	 * @return   : boolean
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 7.   |   ymshin   |  최초작성
	 */ 
	boolean isStationAPExist(ApVO apVo);



}
