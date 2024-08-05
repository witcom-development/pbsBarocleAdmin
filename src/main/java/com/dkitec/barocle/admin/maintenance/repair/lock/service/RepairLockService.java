/*
 * @Package Name : com.dkitec.barocle.admin.manage.DeviceMgmt.service
 * @파일명          : DeviceMgmtService.java
 * @작성일          : 2015. 4. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 15.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.maintenance.repair.lock.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.repair.lock.vo.RepairLockVO;

public interface RepairLockService {

	List<RepairLockVO> getRepairLockList(RepairLockVO repairLockVo);

	int getRepairLockListCount(RepairLockVO repairLockVO);

	RepairLockVO getRepairLockInfo(RepairLockVO repairLockVO);
	
	List<String> getRepairCodeList(String repairSeq);

	RepairLockVO getRemainBikeYn(RepairLockVO repairLockVo);
	
	String getLockMoveYn(RepairLockVO repairLockVo);
	
	int insertRepairLock(RepairLockVO repairLockVo);
	
	int updateRepairLock(RepairLockVO repairLockVo);
	
	int deleteRepairLock(RepairLockVO repairLockVo);
	
	int insertRepairLockDetail(RepairLockVO repairLockVo);
	
	int deleteRepairLockDetail(RepairLockVO repairLockVo);
}
