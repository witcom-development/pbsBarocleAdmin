package com.dkitec.barocle.admin.repairBikeMall.repairBike.service;

import java.sql.SQLException;
import java.util.List;

import com.dkitec.barocle.admin.repairBikeMall.repairBike.vo.RepairTnsBikeVo;
import com.dkitec.barocle.admin.repairBikeMall.transferBike.vo.TransferBikeVo;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;

public interface RepairTnsBikeService {
	
	List<TransferBikeVo> getRepairTnsBikeList(TransferBikeVo transferBikeVo) throws SQLException;
	
	int getRepairTnsBikeListCount(TransferBikeVo transferBikeVo)  throws SQLException;
	
	int updateRepairTnsBikeYn(TransferBikeVo transferBikeVo);
	
	List<RepairTnsBikeVo> getbikeMallReportList(RepairTnsBikeVo repairTnsBikeVo) throws SQLException;
	
	int getbikeMallReportListCount(RepairTnsBikeVo repairTnsBikeVo)  throws SQLException;

	List<SmsMessageVO> getAdminPhoneNoList(RepairTnsBikeVo repairTnsBikeVo) throws SQLException;
	
	int getRepairBikeCount(TransferBikeVo transferBikeVo)  throws SQLException;
}
