/*
 * @Package Name : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service
 * @파일명          : StockBuyService.java
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

/**
 * @파일명          : StockBuyService.java
 * @작성일          : 2015. 6. 1.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 1.   |   ymshin   |  최초작성
 */
public interface StockBuyService {

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyService.getStockBuyListCount
	 * @writeDay : 2015. 6. 2. 오전 11:40:44
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 2.   |   ymshin   |  최초작성
	 */ 
	int getStockBuyListCount(PartsBuyVO partsBuyVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyService.getBuyPartsList
	 * @writeDay : 2015. 6. 2. 오전 11:40:49
	 * @return   : List<PartsBuyVO>
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 2.   |   ymshin   |  최초작성
	 */ 
	List<PartsBuyVO> getBuyPartsList(PartsBuyVO partsBuyVo);

	PartsBuyVO getStockBuyDetailInfo(PartsBuyVO partsBuyVo);

	List<PartsBuyVO> getStockBuyPartList(PartsBuyVO partsBuyVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyService.addStockBuyData
	 * @writeDay : 2015. 6. 3. 오후 5:46:04
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 3.   |   ymshin   |  최초작성
	 */ 
	int addStockBuyData(PartsBuyVO partsBuyVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyService.setStockBuyData
	 * @writeDay : 2015. 6. 3. 오후 5:46:12
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 3.   |   ymshin   |  최초작성
	 */ 
	int setStockBuyData(PartsBuyVO partsBuyVo);

	/**
	 * @location : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyService.delStockBuyData
	 * @writeDay : 2015. 6. 3. 오후 5:46:18
	 * @return   : int
	 * @Todo     :
	 * -------------------------------------------------------------
	 *      수정일      |      수정자      |              수정내용
	 * -------------------------------------------------------------
	 *    2015. 6. 3.   |   ymshin   |  최초작성
	 */ 
	int delStockBuyData(PartsBuyVO partsBuyVo);

}
