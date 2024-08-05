package com.dkitec.barocle.admin.common.service;

import java.util.HashMap;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper(value="excelUploadProcMapper")
public interface ExcelUploadProcMapper {

	int addDeviceExcelDataLocateHist(HashMap<String, String> map);

	int addDeviceExcelData(HashMap<String, String> map);

	int chkSerialNo(HashMap<String, String> errorMap);

	int chkExistCenter(String cellStr);

	int chkExistStation(String cellStr);

	int isExistChkEquipOrder(HashMap<String, String> map);

	int isAlreadyExistTeminal(String cellStr);

	String isExistBikeId(String cellStr);

	int chkExistDeviceId(HashMap<String, String> errorMap);

	/**
	 * @location : com.dkitec.barocle.admin.common.service.ExcelUploadProcMapper.isChkExistBikeNo
	 * @writeDay : 2015. 8. 16. 오후 11:34:14
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 8. 16.   |   ymshin   |  최초작성
	 */ 
	int isChkExistBikeNo(String cellStr);

	/**
	 * @location : com.dkitec.barocle.admin.common.service.ExcelUploadProcMapper.setTerminalIdToBike
	 * @writeDay : 2015. 8. 17. 오전 1:47:14
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 8. 17.   |   ymshin   |  최초작성
	 */ 
	int setTerminalIdToBike(HashMap<String, String> map);

	/**
	 * @location : com.dkitec.barocle.admin.common.service.ExcelUploadProcMapper.isStockExistChk
	 * @writeDay : 2015. 8. 19. 오후 1:52:24
	 * @return   : boolean
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 8. 19.   |   ymshin   |  최초작성
	 */ 
	int isStockExistChk(HashMap<String, String> item);

	/**
	 * @location : com.dkitec.barocle.admin.common.service.ExcelUploadProcMapper.setDevicePartStockitem
	 * @writeDay : 2015. 8. 19. 오후 1:52:31
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 8. 19.   |   ymshin   |  최초작성
	 */ 
	int setDevicePartStockitem(HashMap<String, String> item);

	/**
	 * @location : com.dkitec.barocle.admin.common.service.ExcelUploadProcMapper.addDevicePartStockitem
	 * @writeDay : 2015. 8. 19. 오후 1:52:37
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 8. 19.   |   ymshin   |  최초작성
	 */ 
	int addDevicePartStockitem(HashMap<String, String> item);

	/**
	 * @location : com.dkitec.barocle.admin.common.service.ExcelUploadProcMapper.chkExistParts
	 * @writeDay : 2015. 8. 19. 오후 2:02:37
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 8. 19.   |   ymshin   |  최초작성
	 */ 
	int chkExistParts(String cellStr);

	int chkExistEntrps(String cellStr);
	
	int chkExistBikeSeCd(String cellStr);
}
