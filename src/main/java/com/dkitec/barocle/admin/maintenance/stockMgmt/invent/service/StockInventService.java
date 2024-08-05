/*
 * @Package Name : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service
 * @파일명          : StockInventService.java
 * @작성일          : 2015. 6. 1.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 1.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.stockMgmt.invent.vo.InventVO;

/**
 * @파일명          : StockInventService.java
 * @작성일          : 2015. 6. 1.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 1.   |   ymshin   |  최초작성
 */
public interface StockInventService {

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventService.getStockInventListCount
	 * @writeDay : 2015. 6. 2. 오후 2:14:01
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 2.   |   ymshin   |  최초작성
	 */ 
	int getStockInventListCount(InventVO inventVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventService.getStockInventList
	 * @writeDay : 2015. 6. 2. 오후 2:14:08
	 * @return   : List<InventVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 2.   |   ymshin   |  최초작성
	 */ 
	List<InventVO> getStockInventList(InventVO inventVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventService.getStockInventDetailInfo
	 * @writeDay : 2015. 6. 2. 오후 2:27:05
	 * @return   : InventVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 2.   |   ymshin   |  최초작성
	 */ 
	InventVO getStockInventDetailInfo(InventVO inventVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventService.getStockInventHistInfoCnt
	 * @writeDay : 2015. 6. 2. 오후 2:42:56
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 2.   |   ymshin   |  최초작성
	 */ 
	int getStockInventHistInfoCnt(InventVO inventVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventService.getStockInventHistInfo
	 * @writeDay : 2015. 6. 2. 오후 2:43:02
	 * @return   : List<InventVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 2.   |   ymshin   |  최초작성
	 */ 
	List<InventVO> getStockInventHistInfo(InventVO inventVo);

	boolean isPartExist(InventVO inventVo);
	int setPartInvent(InventVO inventVo, int gap);
	int addNewPart(InventVO inventVo);

	int addNewPartBulk(List<InventVO> excelData, String usrId);



}
