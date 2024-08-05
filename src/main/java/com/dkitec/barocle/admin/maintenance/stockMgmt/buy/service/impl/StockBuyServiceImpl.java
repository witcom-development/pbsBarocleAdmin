/*
 * @Package Name : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.impl
 * @파일명          : StockBuyServiceImpl.java
 * @작성일          : 2015. 6. 1.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 1.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyMapper;
import com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyService;
import com.dkitec.barocle.admin.maintenance.stockMgmt.buy.vo.PartsBuyVO;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @파일명          : StockBuyServiceImpl.java
 * @작성일          : 2015. 6. 1.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 1.   |   ymshin   |  최초작성
 */
@Service(value="stockBuyService")
public class StockBuyServiceImpl extends EgovAbstractServiceImpl implements StockBuyService {

	@Autowired private StockBuyMapper stockBuyMapper;
	/**
	 * @location   : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.impl.StockBuyService.getStockBuyListCount
	 * @writeDay   : 2015. 6. 2. 오전 11:46:44
	 * @overridden : @see com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyService#getStockBuyListCount(com.dkitec.barocle.admin.maintenance.stockMgmt.buy.vo.PartsBuyVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getStockBuyListCount(PartsBuyVO partsBuyVo) {
		// TODO Auto-generated method stub
		return stockBuyMapper.getStockBuyListCount(partsBuyVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.impl.StockBuyService.getBuyPartsList
	 * @writeDay   : 2015. 6. 2. 오전 11:46:44
	 * @overridden : @see com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyService#getBuyPartsList(com.dkitec.barocle.admin.maintenance.stockMgmt.buy.vo.PartsBuyVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<PartsBuyVO> getBuyPartsList(PartsBuyVO partsBuyVo) {
		// TODO Auto-generated method stub
		return stockBuyMapper.getBuyPartsList(partsBuyVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public PartsBuyVO getStockBuyDetailInfo(PartsBuyVO partsBuyVo) {
		// TODO Auto-generated method stub
		return stockBuyMapper.getStockBuyDetailInfo(partsBuyVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<PartsBuyVO> getStockBuyPartList(PartsBuyVO partsBuyVo) {
		// TODO Auto-generated method stub
		return stockBuyMapper.getStockBuyPartList(partsBuyVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.impl.StockBuyService.addStockBuyData
	 * @writeDay   : 2015. 6. 3. 오후 5:52:35
	 * @overridden : @see com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyService#addStockBuyData(com.dkitec.barocle.admin.maintenance.stockMgmt.buy.vo.PartsBuyVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=false, propagation=Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addStockBuyData(PartsBuyVO partsBuyVo) {
		int result = 0;
		result = stockBuyMapper.addStockBuyData(partsBuyVo);
		int seq = stockBuyMapper.getCurrentSeq();
		if(partsBuyVo.getPartBuyList().size() > 0){
			for(PartsBuyVO item : partsBuyVo.getPartBuyList()) {
				item.setPartBuySeq(String.valueOf(seq));
				result = stockBuyMapper.addStockBuyPartList(item);
			}
		}
		
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.impl.StockBuyService.setStockBuyData
	 * @writeDay   : 2015. 6. 3. 오후 5:52:35
	 * @overridden : @see com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyService#setStockBuyData(com.dkitec.barocle.admin.maintenance.stockMgmt.buy.vo.PartsBuyVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=false, propagation=Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int setStockBuyData(PartsBuyVO partsBuyVo) {
		int result = 0;
		
		result = stockBuyMapper.setStockBuyData(partsBuyVo);
		if(partsBuyVo.getPartBuyList().size() > 0){
			for(PartsBuyVO item : partsBuyVo.getPartBuyList()) {
				item.setPartBuySeq(partsBuyVo.getPartBuySeq());
				item.setPartUnitPrce(item.getPartUnitPrce().replace(",",""));
				if(item.getViewFlg().equals(IConstants.CRUD_C)) {
					result = stockBuyMapper.addStockBuyPartList(item);
				} else if(item.getViewFlg().equals(IConstants.CRUD_U)){
					result = stockBuyMapper.setStockBuyPartList(item);
				} else {
					result = stockBuyMapper.delStockBuyPartList(item);
				}
			}
		}
		return result;
	}

	/**
	 * @location   : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.impl.StockBuyService.delStockBuyData
	 * @writeDay   : 2015. 6. 3. 오후 5:52:35
	 * @overridden : @see com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyService#delStockBuyData(com.dkitec.barocle.admin.maintenance.stockMgmt.buy.vo.PartsBuyVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=false, propagation=Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int delStockBuyData(PartsBuyVO partsBuyVo) {
	    int result = 0;
	    
	    result = stockBuyMapper.delStockBuyData(partsBuyVo);
	    result = stockBuyMapper.delStockBuyPartList(partsBuyVo);
	    
		return result;
	}

}
