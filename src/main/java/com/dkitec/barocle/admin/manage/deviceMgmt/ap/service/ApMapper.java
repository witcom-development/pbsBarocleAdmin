/*
 * @Package Name : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service
 * @파일명          : ApMapper.java
 * @작성일          : 2015. 4. 19.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 19.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.manage.deviceMgmt.ap.service;

import java.util.List;

import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @파일명          : ApMapper.java
 * @작성일          : 2015. 4. 19.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 19.   |   ymshin   |  최초작성
 */
@Mapper("apMapper")
public interface ApMapper {

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
	int insertDeviceReg(ApVO vo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApMapper.getAPInfo
	 * @writeDay : 2015. 4. 19. 오후 8:53:13
	 * @return   : ApVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 19.   |   ymshin   |  최초작성
	 */ 
	ApVO getAPInfo(ApVO apVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApMapper.getApList
	 * @writeDay : 2015. 4. 19. 오후 8:53:18
	 * @return   : List<ApVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 19.   |   ymshin   |  최초작성
	 */ 
	List<ApVO> getApList(ApVO apVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApMapper.setAPDevice
	 * @writeDay : 2015. 4. 19. 오후 8:53:22
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 19.   |   ymshin   |  최초작성
	 */ 
	int setAPDevice(ApVO apVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApMapper.isChkIdDup
	 * @writeDay : 2015. 4. 19. 오후 8:55:58
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 19.   |   ymshin   |  최초작성
	 */ 
	int isChkIdDup(ApVO apVo);
	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApMapper.isChkIdDup
	 * @writeDay : 2015. 4. 19. 오후 8:55:58
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 19.   |   ymshin   |  최초작성
	 */ 
	int addApLocateHist(ApVO apVo);
	
	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApMapper.isChkIdDup
	 * @writeDay : 2015. 4. 19. 오후 8:55:58
	 * @return   : int
	 * @Todo     :ap를해당 대여소에 맵핑.
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 19.   |   ymshin   |  최초작성
	 */ 
	int getApListCount(ApVO apVo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApMapper.getStation
	 * @writeDay : 2015. 4. 21. 오후 4:06:58
	 * @return   : List<String>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	List<String> getStation(String stationGrpSeq);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApMapper.getApHistoryInfo
	 * @writeDay : 2015. 4. 22. 오후 2:55:25
	 * @return   : ApVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 22.   |   ymshin   |  최초작성
	 */ 
	ApVO getApHistoryInfo(String deviceId);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApMapper.setApLocateHist
	 * @writeDay : 2015. 4. 22. 오후 3:14:09
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 22.   |   ymshin   |  최초작성
	 */ 
	int setApLocateHist(ApVO vo);

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApMapper.isStationAPExist
	 * @writeDay : 2015. 5. 7. 오후 2:19:39
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 7.   |   ymshin   |  최초작성
	 */ 
	int isStationAPExist(ApVO apVo);

}
