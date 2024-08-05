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

import egovframework.rte.psl.dataaccess.mapper.Mapper;

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
@Mapper("stockInventMapper")
public interface StockInventMapper {

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventMapper.getStockInventDetailInfo
	 * @writeDay : 2015. 6. 2. 오후 2:31:44
	 * @return   : InventVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 2.   |   ymshin   |  최초작성
	 */ 
	InventVO getStockInventDetailInfo(InventVO inventVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventMapper.getStockInventList
	 * @writeDay : 2015. 6. 2. 오후 2:31:49
	 * @return   : List<InventVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 2.   |   ymshin   |  최초작성
	 */ 
	List<InventVO> getStockInventList(InventVO inventVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventMapper.getStockInventListCount
	 * @writeDay : 2015. 6. 2. 오후 2:31:58
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 2.   |   ymshin   |  최초작성
	 */ 
	int getStockInventListCount(InventVO inventVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventMapper.getStockInventHistInfo
	 * @writeDay : 2015. 6. 2. 오후 2:43:59
	 * @return   : List<InventVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 2.   |   ymshin   |  최초작성
	 */ 
	List<InventVO> getStockInventHistInfo(InventVO inventVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventMapper.getStockInventHistInfoCnt
	 * @writeDay : 2015. 6. 2. 오후 2:44:07
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 2.   |   ymshin   |  최초작성
	 */ 
	int getStockInventHistInfoCnt(InventVO inventVo);

	int isPartExist(InventVO inventVo);

	int addNewPartInventHistory(InventVO inventVo);

	int addNewPart(InventVO inventVo);

	int setPartInvent(InventVO inventVo);

}
