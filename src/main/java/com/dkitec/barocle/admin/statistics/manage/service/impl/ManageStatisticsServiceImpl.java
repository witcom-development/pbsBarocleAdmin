package com.dkitec.barocle.admin.statistics.manage.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.maintenance.repair.division.vo.RepairDivisionVO;
import com.dkitec.barocle.admin.statistics.manage.service.ManageStatisticsMapper;
import com.dkitec.barocle.admin.statistics.manage.service.ManageStatisticsService;
import com.dkitec.barocle.admin.statistics.manage.vo.ManageStatisticsVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="manageStatisticsService")
public class ManageStatisticsServiceImpl extends EgovAbstractServiceImpl implements ManageStatisticsService {

	@Autowired private ManageStatisticsMapper manageStatisticsMapper;
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getManageDayPeriod(ManageStatisticsVO manageStatisticsVo){
		// TODO Auto-generated method stub
		return manageStatisticsMapper.getManageDayPeriod(manageStatisticsVo);
	}
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getManageMonthPeriod(ManageStatisticsVO manageStatisticsVo){
		// TODO Auto-generated method stub
		return manageStatisticsMapper.getManageMonthPeriod(manageStatisticsVo);
	}
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<ManageStatisticsVO> getIncomeDayList(ManageStatisticsVO manageStatisticsVo) {
		// TODO Auto-generated method stub
		return manageStatisticsMapper.getIncomeDayList(manageStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<ManageStatisticsVO> getIncomeMonthList(ManageStatisticsVO manageStatisticsVo) {
		// TODO Auto-generated method stub
		return manageStatisticsMapper.getIncomeMonthList(manageStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<ManageStatisticsVO> getUserJoinDayList(ManageStatisticsVO manageStatisticsVo) {
		// TODO Auto-generated method stub
		return manageStatisticsMapper.getUserJoinDayList(manageStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<ManageStatisticsVO> getUserJoinMonthList(ManageStatisticsVO manageStatisticsVo) {
		// TODO Auto-generated method stub
		return manageStatisticsMapper.getUserJoinMonthList(manageStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<ManageStatisticsVO> getBikeUseDayList(ManageStatisticsVO manageStatisticsVo) {
		// TODO Auto-generated method stub
		return manageStatisticsMapper.getBikeUseDayList(manageStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<ManageStatisticsVO> getBikeUseMonthList(ManageStatisticsVO manageStatisticsVo) {
		// TODO Auto-generated method stub
		return manageStatisticsMapper.getBikeUseMonthList(manageStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<ManageStatisticsVO> getTimeUseList(ManageStatisticsVO manageStatisticsVo) {
		// TODO Auto-generated method stub
		return manageStatisticsMapper.getTimeUseList(manageStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<ManageStatisticsVO> getHighStationList(ManageStatisticsVO manageStatisticsVo) {
		// TODO Auto-generated method stub
		return manageStatisticsMapper.getHighStationList(manageStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<ManageStatisticsVO> getLowStationList(ManageStatisticsVO manageStatisticsVo) {
		// TODO Auto-generated method stub
		return manageStatisticsMapper.getLowStationList(manageStatisticsVo);
	}


	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getBikeListCnt(ManageStatisticsVO manageStatisticsVo) {
		// TODO Auto-generated method stub
		return manageStatisticsMapper.getBikeListCnt(manageStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<RepairDivisionVO> getBikeList(
			ManageStatisticsVO manageStatisticsVo) {
		// TODO Auto-generated method stub
		return manageStatisticsMapper.getBikeList(manageStatisticsVo);
	}
	
	@Override
	public int getBikeBatteryListCnt(ManageStatisticsVO manageStatisticsVo) {
		// TODO Auto-generated method stub
		return manageStatisticsMapper.getBikeBatteryListCnt(manageStatisticsVo);
	}
	@Override
	public ArrayList<Map<String, String>> getBikeBatteryList(
			ManageStatisticsVO manageStatisticsVo) {
		// TODO Auto-generated method stub
		return manageStatisticsMapper.getBikeBatteryList(manageStatisticsVo);
	}
	@Override
	public ArrayList<Map<String, String>> getBikeBatteryExcelList(ManageStatisticsVO manageStatisticsVo) {
		// TODO Auto-generated method stub
		return manageStatisticsMapper.getBikeBatteryExcelList(manageStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<ManageStatisticsVO> opinionList(ManageStatisticsVO manageStatisticsVo) {
		return manageStatisticsMapper.opinionList(manageStatisticsVo);
	}

}