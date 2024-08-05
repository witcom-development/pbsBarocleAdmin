package com.dkitec.barocle.admin.statistics.rent.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.statistics.rent.service.RentStatisticsMapper;
import com.dkitec.barocle.admin.statistics.rent.service.RentStatisticsService;
import com.dkitec.barocle.admin.statistics.rent.vo.RentStatisticsVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="rentStatisticsService")
public class RentStatisticsServiceImpl extends EgovAbstractServiceImpl implements RentStatisticsService {

	@Autowired private RentStatisticsMapper rentStatisticsMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getRentDayCnt(RentStatisticsVO rentStatisticsVo) {
		// TODO Auto-generated method stub
		return rentStatisticsMapper.getRentDayCnt(rentStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<RentStatisticsVO> getRentDayList(RentStatisticsVO rentStatisticsVo) {
		// TODO Auto-generated method stub
		return rentStatisticsMapper.getRentDayList(rentStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getRentMonthCnt(RentStatisticsVO rentStatisticsVo) {
		// TODO Auto-generated method stub
		return rentStatisticsMapper.getRentMonthCnt(rentStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<RentStatisticsVO> getRentMonthList(RentStatisticsVO rentStatisticsVo) {
		// TODO Auto-generated method stub
		return rentStatisticsMapper.getRentMonthList(rentStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getReturnDayCnt(RentStatisticsVO rentStatisticsVo) {
		// TODO Auto-generated method stub
		return rentStatisticsMapper.getReturnDayCnt(rentStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<RentStatisticsVO> getReturnDayList(RentStatisticsVO rentStatisticsVo) {
		// TODO Auto-generated method stub
		return rentStatisticsMapper.getReturnDayList(rentStatisticsVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getReturnMonthCnt(RentStatisticsVO rentStatisticsVo) {
		// TODO Auto-generated method stub
		return rentStatisticsMapper.getReturnMonthCnt(rentStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<RentStatisticsVO> getReturnMonthList(RentStatisticsVO rentStatisticsVo) {
		// TODO Auto-generated method stub
		return rentStatisticsMapper.getReturnMonthList(rentStatisticsVo);
	}
	
}	