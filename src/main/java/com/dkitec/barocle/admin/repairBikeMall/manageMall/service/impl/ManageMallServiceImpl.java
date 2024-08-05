package com.dkitec.barocle.admin.repairBikeMall.manageMall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.repairBikeMall.manageMall.service.ManageMallMapper;
import com.dkitec.barocle.admin.repairBikeMall.manageMall.service.ManageMallService;
import com.dkitec.barocle.admin.repairBikeMall.manageMall.vo.ManageMallVo;

import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="manageMallService")
public class ManageMallServiceImpl  extends EgovAbstractServiceImpl implements ManageMallService{
	
	@Autowired private ManageMallMapper manageMallMapper;
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ManageMallVo> getRepairPartPriceList(ManageMallVo manageMallVo) {
		// TODO Auto-generated method stub
		return manageMallMapper.getRepairPartPriceList(manageMallVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getRepairPartPriceListCount(ManageMallVo manageMallVo) {
		// TODO Auto-generated method stub
		return manageMallMapper.getRepairPartPriceListCount(manageMallVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int addPartPrice(ManageMallVo manageMallVo) {
		// TODO Auto-generated method stub
		return manageMallMapper.addPartPrice(manageMallVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public ManageMallVo getRepairPartPriceDetl(ManageMallVo manageMallVo) {
		// TODO Auto-generated method stub
		return manageMallMapper.getRepairPartPriceDetl(manageMallVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int updatePartPrice(ManageMallVo manageMallVo) {
		// TODO Auto-generated method stub
		return manageMallMapper.updatePartPrice(manageMallVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ManageMallVo> getbikeMallReportList(ManageMallVo manageMallVo) {
		// TODO Auto-generated method stub
		return manageMallMapper.getbikeMallReportList(manageMallVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getbikeMallReportListCount(ManageMallVo manageMallVo) {
		// TODO Auto-generated method stub
		return manageMallMapper.getbikeMallReportListCount(manageMallVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public ManageMallVo getbikeMallReportExcel(ManageMallVo manageMallVo) {
		// TODO Auto-generated method stub
		return manageMallMapper.getbikeMallReportExcel(manageMallVo);
	}
	
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ManageMallVo> bikeMallReportBikeExcel(ManageMallVo manageMallVo) {
		// TODO Auto-generated method stub
		return manageMallMapper.bikeMallReportBikeExcel(manageMallVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<ManageMallVo> bikeMallReportExcelAdmin(ManageMallVo manageMallVo) {
		// TODO Auto-generated method stub
		return manageMallMapper.bikeMallReportExcelAdmin(manageMallVo);
	}
	
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int addRepMonthSmsHist(ManageMallVo manageMallVo) {
		// TODO Auto-generated method stub
		return manageMallMapper.addRepMonthSmsHist(manageMallVo);
	}
}
