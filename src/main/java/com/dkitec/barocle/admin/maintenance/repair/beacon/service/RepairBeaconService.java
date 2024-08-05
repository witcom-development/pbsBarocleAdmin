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
package com.dkitec.barocle.admin.maintenance.repair.beacon.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.repair.beacon.vo.RepairBeaconVO;
import com.dkitec.barocle.admin.status.stationStatus.vo.StationVO;

public interface RepairBeaconService {

	List<RepairBeaconVO> getRepairBeaconList(RepairBeaconVO repairBeaconVo);

	int getRepairBeaconListCount(RepairBeaconVO repairBeaconVO);

	RepairBeaconVO getRepairBeaconInfo(RepairBeaconVO repairBeaconVO);
	
	List<String> getRepairCodeList(String repairSeq);
 
	int insertRepairBeacon(RepairBeaconVO repairBeaconVo);
	
	
	int deleteRepairBeacon(RepairBeaconVO repairBeaconVo);

	StationVO getStationInfo(StationVO stationVo);
	
	RepairBeaconVO getRepairBeaconInfoCurdate(RepairBeaconVO repairBeaconVO);
	
	List<RepairBeaconVO> getStationDairyInfo(RepairBeaconVO repairBeaconVo);
}
