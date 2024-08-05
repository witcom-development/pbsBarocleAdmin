/*
 * @Package Name : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service
 * @파일명          : StockBuyMapper.java
 * @작성일          : 2015. 6. 1.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 1.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.stockMgmt.buy.vo.PartsBuyVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @파일명          : StockBuyMapper.java
 * @작성일          : 2015. 6. 1.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 1.   |   ymshin   |  최초작성
 */
@Mapper("stockBuyMapper")
public interface StockBuyMapper {

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyMapper.getStockBuyListCount
	 * @writeDay : 2015. 6. 2. 오후 1:14:00
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 2.   |   ymshin   |  최초작성
	 */ 
	int getStockBuyListCount(PartsBuyVO partsBuyVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyMapper.getBuyPartsList
	 * @writeDay : 2015. 6. 2. 오후 1:14:08
	 * @return   : List<PartsBuyVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 2.   |   ymshin   |  최초작성
	 */ 
	List<PartsBuyVO> getBuyPartsList(PartsBuyVO partsBuyVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyMapper.getStockBuyDetailInfo
	 * @writeDay : 2015. 6. 3. 오후 2:46:13
	 * @return   : PartsBuyVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 3.   |   ymshin   |  최초작성
	 */ 
	PartsBuyVO getStockBuyDetailInfo(PartsBuyVO partsBuyVo);
	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyMapper.getStockBuyPartList
	 * @writeDay : 2015. 6. 3. 오후 2:46:13
	 * @return   : PartsBuyVO
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 3.   |   ymshin   |  최초작성
	 */ 
	List<PartsBuyVO> getStockBuyPartList(PartsBuyVO partsBuyVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyMapper.addStockBuyData
	 * @writeDay : 2015. 6. 3. 오후 6:00:17
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 3.   |   ymshin   |  최초작성
	 */ 
	int addStockBuyData(PartsBuyVO partsBuyVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyMapper.addStockBuyPartList
	 * @writeDay : 2015. 6. 3. 오후 6:00:34
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 3.   |   ymshin   |  최초작성
	 */ 
	int addStockBuyPartList(PartsBuyVO item);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyMapper.delStockBuyData
	 * @writeDay : 2015. 6. 3. 오후 6:05:16
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 3.   |   ymshin   |  최초작성
	 */ 
	int delStockBuyData(PartsBuyVO partsBuyVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyMapper.delStockBuyPartList
	 * @writeDay : 2015. 6. 3. 오후 6:05:23
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 3.   |   ymshin   |  최초작성
	 */ 
	int delStockBuyPartList(PartsBuyVO partsBuyVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyMapper.setStockBuyData
	 * @writeDay : 2015. 6. 3. 오후 6:12:03
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 3.   |   ymshin   |  최초작성
	 */ 
	int setStockBuyData(PartsBuyVO partsBuyVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyMapper.setStockBuyPartList
	 * @writeDay : 2015. 6. 3. 오후 6:12:11
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 3.   |   ymshin   |  최초작성
	 */ 
	int setStockBuyPartList(PartsBuyVO item);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyMapper.getCurrentSeq
	 * @writeDay : 2015. 6. 3. 오후 6:38:04
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 3.   |   ymshin   |  최초작성
	 */ 
	int getCurrentSeq();

	
}
