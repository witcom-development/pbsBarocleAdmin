package com.dkitec.barocle.admin.maintenance.repair.lock.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.repair.lock.vo.RepairLockVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("repairLockMapper")
public interface RepairLockMapper {

	List<RepairLockVO> getRepairLockList(RepairLockVO repairLockVo);

	int getRepairLockListCount(RepairLockVO repairLockVo);

	RepairLockVO getRepairLockInfo(RepairLockVO repairLockVO);

	List<String> getRepairCodeList(String repairSeq);
	
	int updateLockStatus(RepairLockVO repairLockVo);

	int updateFaultLock(RepairLockVO repairLockVo);

	RepairLockVO getRemainBikeYn(RepairLockVO repairLockVo);
	
	String getLockMoveYn(RepairLockVO repairLockVo);
	
	int updateLockMoveHistory(RepairLockVO repairLockVo);
	
	int insertLockMoveHistory(RepairLockVO repairLockVo);

	int updateLockLocationInfo(RepairLockVO repairLockVo);
	
	int insertRepairLock(RepairLockVO repairLockVo);
	
	int updateRepairLock(RepairLockVO repairLockVo);
	
	int deleteRepairLock(RepairLockVO repairLockVo);
	
	int insertRepairLockDetail(RepairLockVO repairLockVo);
	
	int deleteRepairLockDetail(RepairLockVO repairLockVo);
	
}
