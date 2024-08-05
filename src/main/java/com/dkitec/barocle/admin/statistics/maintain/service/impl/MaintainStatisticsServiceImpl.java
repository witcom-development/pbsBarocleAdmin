package com.dkitec.barocle.admin.statistics.maintain.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.statistics.maintain.service.MaintainStatisticsMapper;
import com.dkitec.barocle.admin.statistics.maintain.service.MaintainStatisticsService;
import com.dkitec.barocle.admin.statistics.maintain.vo.MaintainStatisticsVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="maintainStatisticsService")
public class MaintainStatisticsServiceImpl extends EgovAbstractServiceImpl implements MaintainStatisticsService {

	@Autowired private MaintainStatisticsMapper maintainStatisticsMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getFaultStateCnt(MaintainStatisticsVO maintainStatisticsVo) {
		// TODO Auto-generated method stub
		return maintainStatisticsMapper.getFaultStateCnt(maintainStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getFaultDayCnt(MaintainStatisticsVO maintainStatisticsVo) {
		// TODO Auto-generated method stub
		return maintainStatisticsMapper.getFaultDayCnt(maintainStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<MaintainStatisticsVO> getFaultDayList(MaintainStatisticsVO maintainStatisticsVo) {
		// TODO Auto-generated method stub
		return maintainStatisticsMapper.getFaultDayList(maintainStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getFaultMonthCnt(MaintainStatisticsVO maintainStatisticsVo) {
		// TODO Auto-generated method stub
		return maintainStatisticsMapper.getFaultMonthCnt(maintainStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<MaintainStatisticsVO> getFaultMonthList(MaintainStatisticsVO maintainStatisticsVo) {
		// TODO Auto-generated method stub
		return maintainStatisticsMapper.getFaultMonthList(maintainStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getFaultYearCnt(MaintainStatisticsVO maintainStatisticsVo) {
		// TODO Auto-generated method stub
		return maintainStatisticsMapper.getFaultYearCnt(maintainStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<MaintainStatisticsVO> getFaultYearList(MaintainStatisticsVO maintainStatisticsVo) {
		// TODO Auto-generated method stub
		return maintainStatisticsMapper.getFaultYearList(maintainStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getRepairStateCnt(MaintainStatisticsVO maintainStatisticsVo) {
		// TODO Auto-generated method stub
		return maintainStatisticsMapper.getRepairStateCnt(maintainStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getRepairDayCnt(MaintainStatisticsVO maintainStatisticsVo) {
		// TODO Auto-generated method stub
		return maintainStatisticsMapper.getRepairDayCnt(maintainStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<MaintainStatisticsVO> getRepairDayList(MaintainStatisticsVO maintainStatisticsVo) {
		// TODO Auto-generated method stub
		return maintainStatisticsMapper.getRepairDayList(maintainStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getRepairMonthCnt(MaintainStatisticsVO maintainStatisticsVo) {
		// TODO Auto-generated method stub
		return maintainStatisticsMapper.getRepairMonthCnt(maintainStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<MaintainStatisticsVO> getRepairMonthList(MaintainStatisticsVO maintainStatisticsVo) {
		// TODO Auto-generated method stub
		return maintainStatisticsMapper.getRepairMonthList(maintainStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getRepairYearCnt(MaintainStatisticsVO maintainStatisticsVo) {
		// TODO Auto-generated method stub
		return maintainStatisticsMapper.getRepairYearCnt(maintainStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<MaintainStatisticsVO> getRepairYearList(MaintainStatisticsVO maintainStatisticsVo) {
		// TODO Auto-generated method stub
		return maintainStatisticsMapper.getRepairYearList(maintainStatisticsVo);
	}

}