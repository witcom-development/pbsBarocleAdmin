/*
 * @Package Name : com.dkitec.barocle.admin.status.rentHistory.service.Impl
 * @파일명          : RentalHistoryServiceImpl.java
 * @작성일          : 2015. 5. 14.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 14.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.rentHistory.service.Impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.status.rentHistory.service.RentHistoryMapper;
import com.dkitec.barocle.admin.status.rentHistory.service.RentHistoryService;
import com.dkitec.barocle.admin.status.rentHistory.vo.PenaltyVO;
import com.dkitec.barocle.admin.status.rentHistory.vo.ReturnReqVO;
import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @파일명          : RentalHistoryServiceImpl.java
 * @작성일          : 2015. 5. 14.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 14.   |   ymshin   |  최초작성
 */
@Service(value="rentHistoryService")
public class RentalHistoryServiceImpl extends EgovAbstractServiceImpl implements RentHistoryService {
	
	@Autowired private RentHistoryMapper rentHistoryMapper;

	/**
	 * @location   : com.dkitec.barocle.admin.status.rentHistory.service.Impl.RentHistoryService.getRentHistoryAllCnt
	 * @writeDay   : 2015. 5. 14. 오전 11:49:06
	 * @overridden : @see com.dkitec.barocle.admin.status.rentHistory.service.RentHistoryService#getRentHistoryAllCnt(com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeRentalVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getRentHistoryAllCnt(BikeRentalVO rentalVo) {
		// TODO Auto-generated method stub
		return rentHistoryMapper.getRentHistoryAllCnt(rentalVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.status.rentHistory.service.Impl.RentHistoryService.getRentHistoryList
	 * @writeDay   : 2015. 5. 14. 오전 11:49:06
	 * @overridden : @see com.dkitec.barocle.admin.status.rentHistory.service.RentHistoryService#getRentHistoryList(com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeRentalVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CommonCodeVO> getRentHistoryList(BikeRentalVO rentalVo) {
		// TODO Auto-generated method stub
		return rentHistoryMapper.getRentHistoryList(rentalVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.status.rentHistory.service.Impl.RentHistoryService.getRentHistInfoDetail
	 * @writeDay   : 2015. 5. 14. 오후 3:32:11
	 * @overridden : @see com.dkitec.barocle.admin.status.rentHistory.service.RentHistoryService#getRentHistInfoDetail(com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeRentalVO)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public BikeRentalVO getRentHistInfoDetail(BikeRentalVO rentalVo) {
		// TODO Auto-generated method stub
		return rentHistoryMapper.getRentHistInfoDetail(rentalVo);
	}

	/**
	 * @location   : com.dkitec.barocle.admin.status.rentHistory.service.Impl.RentHistoryService.getPenaltyList
	 * @writeDay   : 2015. 5. 14. 오후 5:52:29
	 * @overridden : @see com.dkitec.barocle.admin.status.rentHistory.service.RentHistoryService#getPenaltyList(java.lang.String)
	 * @Todo       :
	 */ 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<PenaltyVO> getPenaltyList(BikeRentalVO rentalVo) {
		// TODO Auto-generated method stub
		return rentHistoryMapper.getPenaltyList(rentalVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ReturnReqVO> getReturnReqList(ReturnReqVO returnReqVo){
		return rentHistoryMapper.getReturnReqList(returnReqVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getReturnReqListCnt(ReturnReqVO returnReqVo){
		return rentHistoryMapper.getReturnReqListCnt(returnReqVo);
	}

}
