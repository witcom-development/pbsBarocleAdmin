package com.dkitec.barocle.admin.repairBikeMall.transferBike.service;

import java.sql.SQLException;
import java.util.List;

import com.dkitec.barocle.admin.repairBikeMall.transferBike.vo.TransferBikeVo;

public interface TransferBikeService {
	
	List<TransferBikeVo> getTransferBikeList(TransferBikeVo transferBikeVo) throws SQLException;
	
	int getTransferBikeListCount(TransferBikeVo transferBikeVo)  throws SQLException;
	
	List<TransferBikeVo> getBikeMallList(TransferBikeVo transferBikeVo) throws SQLException;

	List<TransferBikeVo> getCheckTransferList(TransferBikeVo transferBikeVo) throws SQLException;
	
	int getCheckTransferListCount(TransferBikeVo transferBikeVo)  throws SQLException;
	
	int updateTransferYn(TransferBikeVo transferBikeVo);
	
	// int addTransferBike(TransferBikeVo transferBikeVo);
	String addTransferBike(TransferBikeVo transferBikeVo);
	
	List<TransferBikeVo> getTransferBikeListExcel(TransferBikeVo transferBikeVo) throws SQLException;
	
	TransferBikeVo getTransInfo(TransferBikeVo transferBikeVo) throws SQLException;
	
	List<TransferBikeVo> getBrokenInfo(TransferBikeVo transferBikeVo) throws SQLException;
	
	TransferBikeVo getTransferBikeInfo(TransferBikeVo transferBikeVo) throws SQLException;
	
	List<TransferBikeVo> getTransferBikeDetail(TransferBikeVo transferBikeVo) throws SQLException;
	
	int updateBrokenInfo(TransferBikeVo transferBikeVo) throws SQLException;
	
	List<TransferBikeVo> getCheckRepairBikeList(TransferBikeVo transferBikeVo) throws SQLException;
	
	int getCheckRepairBikeListCount(TransferBikeVo transferBikeVo)  throws SQLException;
	
	int updateCollectYn(TransferBikeVo transferBikeVo);
	
	int validationTransferBike(TransferBikeVo transferBikeVo);
}
