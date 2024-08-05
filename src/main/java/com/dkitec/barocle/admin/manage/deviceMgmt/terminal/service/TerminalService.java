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
package com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service;

import java.sql.SQLException;
import java.util.List;

import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.vo.TerminalVO;

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
public interface TerminalService {
	
	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.terminal.getTerminalList
	 * @writeDay : 2015. 4. 21. 오후 7:42:28
	 * @return   : List<BikeVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	List<BikeVO> getTerminalList(TerminalVO terminalVo)  throws SQLException;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.terminal.getTerminalListCount
	 * @writeDay : 2015. 4. 21. 오후 7:42:28
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	int getTerminalListCount(TerminalVO terminalVo)  throws SQLException;
	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.terminal.getTerminalInfo
	 * @writeDay : 2015. 4. 21. 오후 7:42:28
	 * @return   : TerminalVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	TerminalVO getTerminalInfo(TerminalVO terminalVo)  throws SQLException;
	/**
	 * @param string 
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.terminal.addNewTerminalData
	 * @writeDay : 2015. 4. 21. 오후 7:42:28
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	int addNewTerminalData(TerminalVO terminalVo, String string)  throws SQLException;
	/**
	 * @param string 
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.terminal.setTerminalData
	 * @writeDay : 2015. 4. 21. 오후 7:42:28
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	int setTerminalData(TerminalVO terminalVo, String string)  throws SQLException;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.terminal.getTerminalAndBikeHistory
	 * @writeDay : 2015. 4. 21. 오후 7:42:28
	 * @return   : List<TerminalVO>
	 * @Todo     :자전거-단말기 연결 이력
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	List<TerminalVO> getTerminalAndBikeHistory(TerminalVO tereminalVo)  throws SQLException;
	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.terminal.isChkIdDup
	 * @writeDay : 2015. 4. 21. 오후 7:42:28
	 * @return   : boolean
	 * @Todo     : 단말기 ID 중복체크
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */ 
	boolean isChkIdDup(TerminalVO terminalVo)  throws SQLException;
	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.terminal.getTerminalAndBikeHistoryCount
	 * @writeDay : 2015. 4. 21. 오후 7:42:28
	 * @return   : int
	 * @Todo     : 
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 4. 21.   |   ymshin   |  최초작성
	 */
	int getTerminalAndBikeHistoryCount(TerminalVO terminalVo)  throws SQLException;

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalService.getFirmwareSeq
	 * @writeDay : 2015. 5. 27. 오후 2:46:42
	 * @return   : String
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 5. 27.   |   ymshin   |  최초작성
	 */ 
	String getFirmwareSeq(TerminalVO terminalVo);

}
