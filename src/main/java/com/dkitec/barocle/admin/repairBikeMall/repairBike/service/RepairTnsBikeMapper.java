package com.dkitec.barocle.admin.repairBikeMall.repairBike.service;

import java.util.List;

import com.dkitec.barocle.admin.repairBikeMall.repairBike.vo.RepairTnsBikeVo;
import com.dkitec.barocle.admin.repairBikeMall.transferBike.vo.TransferBikeVo;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("repairTnsBikeMapper")
public interface RepairTnsBikeMapper {
	
	List<TransferBikeVo> getRepairTnsBikeList(TransferBikeVo transferBikeVo);
	
	int getRepairTnsBikeListCount(TransferBikeVo transferBikeVo);
	
	int updateRepairBikeInfoYn(TransferBikeVo transferBikeVo);

	int updateRepairBikePartYn(TransferBikeVo transferBikeVo);
	
	List<RepairTnsBikeVo> getbikeMallReportList(RepairTnsBikeVo repairTnsBikeVo);
	
	int getbikeMallReportListCount(RepairTnsBikeVo repairTnsBikeVo);
	
	List<SmsMessageVO> getAdminPhoneNoList(RepairTnsBikeVo repairTnsBikeVo);
	
	int getRepairBikeCount(TransferBikeVo transferBikeVo);
}
