/*
 * @Package Name : com.dkitec.barocle.admin.common.service
 * @파일명          : ExcelUploadProcService.java
 * @작성일          : 2015. 8. 14.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 8. 14.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.common.service;
import java.util.HashMap;
import java.util.List;

/**
 * @파일명          : ExcelUploadProcService.java
 * @작성일          : 2015. 8. 14.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 8. 14.   |   ymshin   |  최초작성
 */

public interface ExcelUploadProcService {

	int addDeviceExcelData(List<HashMap<String, String>> addList);

	boolean chkSerialNo(HashMap<String, String> errorMap);

	boolean chkExistStation(String cellStr);

	boolean chkExistCenter(String cellStr);

	String isExistBikeId(String cellStr);

	boolean isAlreadyExistTeminal(String cellStr);

	boolean chkExistDeviceId(HashMap<String, String> errorMap);

	/**
	 * @location : com.dkitec.barocle.admin.common.service.ExcelUploadProcService.isChkExistBikeNo
	 * @writeDay : 2015. 8. 16. 오후 11:24:44
	 * @return   : boolean
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 8. 16.   |   ymshin   |  최초작성
	 */ 
	boolean isChkExistBikeNo(String cellStr);

	/**
	 * @location : com.dkitec.barocle.admin.common.service.ExcelUploadProcService.isExistChkEquipOrder
	 * @writeDay : 2015. 8. 17. 오후 2:06:51
	 * @return   : HashMap<String,String>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 8. 17.   |   ymshin   |  최초작성
	 */ 
	int isExistChkEquipOrder(HashMap<String, String> arm);

	/**
	 * @location : com.dkitec.barocle.admin.common.service.ExcelUploadProcService.addDevicePartStock
	 * @writeDay : 2015. 8. 19. 오후 1:27:21
	 * @return   : Object
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 8. 19.   |   ymshin   |  최초작성
	 */ 
	int addDevicePartStock(List<HashMap<String, String>> addList);

	/**
	 * @location : com.dkitec.barocle.admin.common.service.ExcelUploadProcService.chkExistParts
	 * @writeDay : 2015. 8. 19. 오후 1:54:03
	 * @return   : boolean
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 8. 19.   |   ymshin   |  최초작성
	 */ 
	boolean chkExistParts(String cellStr);

	boolean chkExistEntrps(String cellStr);
	
	boolean chkExistBikeSeCd(String cellStr);
	
	int addCounselExcelData(List<HashMap<String, String>> addList);

}
