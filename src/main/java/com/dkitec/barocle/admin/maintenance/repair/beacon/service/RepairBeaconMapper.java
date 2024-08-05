package com.dkitec.barocle.admin.maintenance.repair.beacon.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.repair.beacon.vo.RepairBeaconVO;
import com.dkitec.barocle.admin.status.stationStatus.vo.StationVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("repairBeaconMapper")
public interface RepairBeaconMapper {

	List<RepairBeaconVO> getRepairBeaconList(RepairBeaconVO repairBeaconVo);

	int getRepairBeaconListCount(RepairBeaconVO repairBeaconVo);

	RepairBeaconVO getRepairBeaconInfo(RepairBeaconVO repairBeaconVO);
	RepairBeaconVO getRepairBeaconInfoCurdate(RepairBeaconVO repairBeaconVO);

	List<String> getRepairCodeList(String repairSeq);
	
	int insertRepairBeacon(RepairBeaconVO repairBeaconVo);
	
	int updateRepairBeacon(RepairBeaconVO repairBeaconVo);
	
	int deleteRepairBeacon(RepairBeaconVO repairBeaconVo);
	
	int insertRepairBeaconDetail(RepairBeaconVO repairBeaconVo);
	
	int deleteRepairBeaconDetail(RepairBeaconVO repairBeaconVo);
	
	// 대여소 조회
	StationVO getStationInfo(StationVO stationVo);
	
	
	List<RepairBeaconVO> getStationDairyInfo(RepairBeaconVO repairBeaconVo);
}
