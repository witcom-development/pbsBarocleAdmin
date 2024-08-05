package com.dkitec.barocle.admin.maintenance.repair.ap.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.repair.ap.vo.RepairApVO;
import com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("repairApMapper")
public interface RepairApMapper {

	List<RepairApVO> getRepairApList(RepairApVO repairApVo);

	int getRepairApListCount(RepairApVO repairApVo);
	
	RepairApVO getRepairApInfo(RepairApVO repairApVO);

	List<String> getRepairCodeList(String repairSeq);

	int updateApStatus(RepairApVO repairApVo);

	int updateFaultAp(RepairApVO repairApVo);

	String getApMoveYn(RepairApVO repairApVo);
	
	int updateApMoveHistory(RepairApVO repairApVo);
	
	int insertApMoveHistory(RepairApVO repairApVo);
	
	int insertRepairAp(RepairApVO repairApVo);
	
	int updateRepairAp(RepairApVO repairApVo);
	
	int deleteRepairAp(RepairApVO repairApVo);
	
	int insertRepairApDetail(RepairApVO repairApVo);
	
	int deleteRepairApDetail(RepairApVO repairApVo);
	
	String getRegId(RepairApVO repairApVo);
	
}
