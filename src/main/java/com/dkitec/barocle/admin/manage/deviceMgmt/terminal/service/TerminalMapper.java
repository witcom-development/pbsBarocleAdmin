/*
 * @Package Name : com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service
 * @파일명          : TerminalMapper.java
 * @작성일          : 2015. 4. 21.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 21.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service;

import java.util.List;

import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.vo.TerminalVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @파일명          : TerminalMapper.java
 * @작성일          : 2015. 4. 21.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 21.   |   ymshin   |  최초작성
 */
@Mapper("terminalMapper")
public interface TerminalMapper {

	

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper.getTerminalCount
	 * @writeDay : 2015. 4. 23. 오후 5:54:21
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	int getTerminalCount(TerminalVO terminalVo);


	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper.getTerminalList
	 * @writeDay : 2015. 4. 23. 오후 5:55:01
	 * @return   : List<BikeVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	List<BikeVO> getTerminalList(TerminalVO terminalVo);


	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper.isChkIdDup
	 * @writeDay : 2015. 4. 23. 오후 5:57:14
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	int isChkIdDup(TerminalVO terminalVo);


	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper.insertDeviceReg
	 * @writeDay : 2015. 4. 23. 오후 6:07:05
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	int insertDeviceReg(TerminalVO terminalVo);


	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper.insertApLocateHist
	 * @writeDay : 2015. 4. 23. 오후 6:07:09
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	int addTerminalLocateHist(TerminalVO terminalVo);


	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper.getOldTerminalInfo
	 * @writeDay : 2015. 4. 23. 오후 6:20:36
	 * @return   : TerminalVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	TerminalVO getOldTerminalInfo(String deviceId);


	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper.setTerminalLocateInfo
	 * @writeDay : 2015. 4. 23. 오후 6:23:59
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	int setTerminalLocateInfo(TerminalVO terminalVo);


	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper.setTerminalData
	 * @writeDay : 2015. 4. 23. 오후 6:24:06
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	int setTerminalData(TerminalVO terminalVo);


	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper.getTerminalLocateHistory
	 * @writeDay : 2015. 4. 23. 오후 6:25:34
	 * @return   : List<TerminalVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	List<TerminalVO> getTerminalLocateHistory(TerminalVO tereminalVo);


	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper.getTerminalAndBikeHistoryCount
	 * @writeDay : 2015. 4. 23. 오후 6:27:08
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 23.   |   ymshin   |  최초작성
	 */ 
	int getTerminalAndBikeHistoryCount(TerminalVO terminalVo);


	int setTRemoveFromBike(TerminalVO terminalVo);


	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalMapper.getFirmwareSeq
	 * @writeDay : 2015. 4. 30. 오후 7:56:38
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 30.   |   ymshin   |  최초작성
	 */ 
	String getFirmwareSeq(TerminalVO terminalVo);


	TerminalVO getTerminalInfo(TerminalVO terminalVo);
	
	
	
}
