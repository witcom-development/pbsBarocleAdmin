package com.dkitec.barocle.admin.repairBikeMall.transferBike.service;

import java.util.List;

import com.dkitec.barocle.admin.repairBikeMall.transferBike.vo.TransferBikeVo;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("transferBikeMapper")
public interface TransferBikeMapper {
	
	List<TransferBikeVo> getTransferBikeList(TransferBikeVo transferBikeVo);
	
	int getTransferBikeListCount(TransferBikeVo transferBikeVo);
	
	List<TransferBikeVo> getBikeMallList(TransferBikeVo transferBikeVo);
	
	List<TransferBikeVo> getCheckTransferList(TransferBikeVo transferBikeVo);
	
	int getCheckTransferListCount(TransferBikeVo transferBikeVo);
	
	int updateTransferYn(TransferBikeVo transferBikeVo);
	
	int addTransferBikeMain(TransferBikeVo transferBikeVo);
	
	int addTransferBikeInfo(TransferBikeVo transferBikeVo);
	
	int addTransferBikeDetl(TransferBikeVo transferBikeVo);
	
	int updateTransferBikeDetl(TransferBikeVo transferBikeVo);

	int updateTransferBikeDtl(TransferBikeVo transferBikeVo);
	
	List<TransferBikeVo> getTransferBikeListExcel(TransferBikeVo transferBikeVo);
	
	TransferBikeVo getTransInfo(TransferBikeVo transferBikeVo);
	
	List<TransferBikeVo> getBrokenInfo(TransferBikeVo transferBikeVo);
	
	TransferBikeVo getTransferBikeInfo(TransferBikeVo transferBikeVo);
	
	List<TransferBikeVo> getTransferBikeDetail(TransferBikeVo transferBikeVo);
	
	int deleteTransferBikeDetl(String repairOursrcSeq);
	
	int deleteTransferBikeDtl(TransferBikeVo transferBikeVo);
	
	int deleteTransferBikeInfo(TransferBikeVo transferBikeVo);
	
	List<TransferBikeVo> getCheckRepairBikeList(TransferBikeVo transferBikeVo);
	
	int getCheckRepairBikeListCount(TransferBikeVo transferBikeVo);
	
	int updateCollectYn(TransferBikeVo transferBikeVo);
	
	int validationTransferBike(String bikeNo);

}