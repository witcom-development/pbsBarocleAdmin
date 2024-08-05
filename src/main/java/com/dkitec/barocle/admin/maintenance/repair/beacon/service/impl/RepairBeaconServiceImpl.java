/*
 * @Package Name : com.dkitec.barocle.admin.manage.DeviceMgmt.service.serviceImpl
 * @파일명          : DeviceMgmtServiceImpl.java
 * @작성일          : 2015. 4. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 15.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.maintenance.repair.beacon.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.maintenance.repair.beacon.service.RepairBeaconMapper;
import com.dkitec.barocle.admin.maintenance.repair.beacon.service.RepairBeaconService;
import com.dkitec.barocle.admin.maintenance.repair.beacon.vo.RepairBeaconVO;
import com.dkitec.barocle.admin.status.stationStatus.vo.StationVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="repairBeaconService")
public class RepairBeaconServiceImpl extends EgovAbstractServiceImpl implements RepairBeaconService {

	@Autowired private RepairBeaconMapper repairBeaconMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RepairBeaconVO> getRepairBeaconList(RepairBeaconVO repairBeaconVo) {
		return repairBeaconMapper.getRepairBeaconList(repairBeaconVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getRepairBeaconListCount(RepairBeaconVO repairBeaconVo) {
		return repairBeaconMapper.getRepairBeaconListCount(repairBeaconVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public RepairBeaconVO getRepairBeaconInfo(RepairBeaconVO repairBeaconVo) {
		return repairBeaconMapper.getRepairBeaconInfo(repairBeaconVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<String> getRepairCodeList(String repairSeq) {
		return repairBeaconMapper.getRepairCodeList(repairSeq);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertRepairBeacon(RepairBeaconVO repairBeaconVo){
		
		if ( repairBeaconVo.getRepairSeq() != null && "0".compareTo( repairBeaconVo.getRepairSeq()) < 0 ) {
			repairBeaconMapper.updateRepairBeacon(repairBeaconVo);
		} else {
			repairBeaconMapper.insertRepairBeacon(repairBeaconVo);
		}
		
		repairBeaconMapper.deleteRepairBeaconDetail(repairBeaconVo);
		String[] tmpRepairCode = repairBeaconVo.getRepairCode().split(",");
		RepairBeaconVO tmpVo = repairBeaconVo;
		
		for(int i = 0; i < tmpRepairCode.length; i++){
			tmpVo.setRepairCode(tmpRepairCode[i]);
			tmpVo.setRepairSeq( repairBeaconVo.getRepairSeq() );
			repairBeaconMapper.insertRepairBeaconDetail(tmpVo);
		}
		
		return 1;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteRepairBeacon(RepairBeaconVO repairBeaconVo){
		
		if ( repairBeaconVo.getRepairSeq() != null && "0".compareTo( repairBeaconVo.getRepairSeq()) < 0 ) {
			repairBeaconMapper.deleteRepairBeaconDetail(repairBeaconVo);
			repairBeaconMapper.deleteRepairBeacon(repairBeaconVo);
		}
		
		return 1;
	}
	   
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public StationVO getStationInfo(StationVO stationVo) {
		return repairBeaconMapper.getStationInfo(stationVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public RepairBeaconVO getRepairBeaconInfoCurdate(RepairBeaconVO repairBeaconVo) {
		return repairBeaconMapper.getRepairBeaconInfoCurdate(repairBeaconVo);
	}
 
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RepairBeaconVO> getStationDairyInfo(RepairBeaconVO repairBeaconVo) {
		return repairBeaconMapper.getStationDairyInfo(repairBeaconVo);
	}
	
}
