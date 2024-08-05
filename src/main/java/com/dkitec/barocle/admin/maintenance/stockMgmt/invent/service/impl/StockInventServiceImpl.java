/*
 * @Package Name : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.impl
 * @파일명          : StockInventServiceImpl.java
 * @작성일          : 2015. 6. 1.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 1.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventMapper;
import com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventService;
import com.dkitec.barocle.admin.maintenance.stockMgmt.invent.vo.InventVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @파일명          : StockInventServiceImpl.java
 * @작성일          : 2015. 6. 1.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 1.   |   ymshin   |  최초작성
 */
@Service(value="stockInventService")
public class StockInventServiceImpl extends EgovAbstractServiceImpl implements StockInventService {

	@Autowired private StockInventMapper stockInventMapper;
	/**
	 * @location   : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.impl.StockInventService.getStockInventListCount
	 * @writeDay   : 2015. 6. 2. 오후 2:14:27
	 * @overridden : @see com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventService#getStockInventListCount(com.dkitec.barocle.admin.maintenance.stockMgmt.invent.vo.InventVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getStockInventListCount(InventVO inventVo) {
		// TODO Auto-generated method stub
		return stockInventMapper.getStockInventListCount(inventVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.impl.StockInventService.getStockInventList
	 * @writeDay   : 2015. 6. 2. 오후 2:14:27
	 * @overridden : @see com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventService#getStockInventList(com.dkitec.barocle.admin.maintenance.stockMgmt.invent.vo.InventVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<InventVO> getStockInventList(InventVO inventVo) {
		// TODO Auto-generated method stub
		return stockInventMapper.getStockInventList(inventVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.impl.StockInventService.getStockInventDetailInfo
	 * @writeDay   : 2015. 6. 2. 오후 2:27:17
	 * @overridden : @see com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventService#getStockInventDetailInfo(com.dkitec.barocle.admin.maintenance.stockMgmt.invent.vo.InventVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public InventVO getStockInventDetailInfo(InventVO inventVo) {
		// TODO Auto-generated method stub
		return stockInventMapper.getStockInventDetailInfo(inventVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.impl.StockInventService.getStockInventHistInfoCnt
	 * @writeDay   : 2015. 6. 2. 오후 2:43:20
	 * @overridden : @see com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventService#getStockInventHistInfoCnt(com.dkitec.barocle.admin.maintenance.stockMgmt.invent.vo.InventVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getStockInventHistInfoCnt(InventVO inventVo) {
		// TODO Auto-generated method stub
		return stockInventMapper.getStockInventHistInfoCnt(inventVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.impl.StockInventService.getStockInventHistInfo
	 * @writeDay   : 2015. 6. 2. 오후 2:43:20
	 * @overridden : @see com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventService#getStockInventHistInfo(com.dkitec.barocle.admin.maintenance.stockMgmt.invent.vo.InventVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<InventVO> getStockInventHistInfo(InventVO inventVo) {
		// TODO Auto-generated method stub
		return stockInventMapper.getStockInventHistInfo(inventVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public boolean isPartExist(InventVO inventVo) {
		// TODO Auto-generated method stub
		int result = stockInventMapper.isPartExist(inventVo);
		return result > 0 ? true : false;
	}

	@Override
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int setPartInvent(InventVO inventVo, int gap) {
		// TODO Auto-generated method stub
		int result = 0;
		result = stockInventMapper.setPartInvent(inventVo);
		if(gap != 0) {
			inventVo.setPartQunt(String.valueOf(gap));
			result = stockInventMapper.addNewPartInventHistory(inventVo);
		}
		return result;
	}

	@Override
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addNewPart(InventVO inventVo) {
		// TODO Auto-generated method stub
		int result = 0;
		result = stockInventMapper.addNewPart(inventVo);
		inventVo.setPartQunt(inventVo.getStockQunt());
		result = stockInventMapper.addNewPartInventHistory(inventVo);
		return result; 
	}

	@Override
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addNewPartBulk(List<InventVO> excelData, String usrId) {
		int result =0;
		if(excelData.size() > 0 ){
			for(InventVO item : excelData) {
				item.setModId(usrId);
				if(this.isPartExist(item)){
					result = stockInventMapper.setPartInvent(item);
					result = stockInventMapper.addNewPartInventHistory(item);
				} else {
					result = this.addNewPart(item);
				}
			}
		}
		
		return result;
	}

}
