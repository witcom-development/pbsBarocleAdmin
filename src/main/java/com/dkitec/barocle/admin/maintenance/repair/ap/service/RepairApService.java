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
package com.dkitec.barocle.admin.maintenance.repair.ap.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.repair.ap.vo.RepairApVO;

public interface RepairApService {

	List<RepairApVO> getRepairApList(RepairApVO repairApVo);

	int getRepairApListCount(RepairApVO repairApVO);
	
	RepairApVO getRepairApInfo(RepairApVO repairApVO);
	
	List<String> getRepairCodeList(String repairSeq);

	String getApMoveYn(RepairApVO repairApVo);

	int insertRepairAp(RepairApVO repairApVo);
	
	int updateRepairAp(RepairApVO repairApVo);
	
	int deleteRepairAp(RepairApVO repairApVo);
	
	int insertRepairApDetail(RepairApVO repairApVo);
	
	int deleteRepairApDetail(RepairApVO repairApVo);
	
	String getRegId(RepairApVO repairApVo);
}
