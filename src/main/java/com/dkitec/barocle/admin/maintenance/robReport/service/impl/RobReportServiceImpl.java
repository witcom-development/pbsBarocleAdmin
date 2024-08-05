package com.dkitec.barocle.admin.maintenance.robReport.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.maintenance.robReport.service.RobReportMapper;
import com.dkitec.barocle.admin.maintenance.robReport.service.RobReportService;
import com.dkitec.barocle.admin.maintenance.robReport.vo.RobReportVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="robReportService")
public class RobReportServiceImpl extends EgovAbstractServiceImpl implements RobReportService {

	@Autowired private RobReportMapper robReportMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RobReportVO> getRobReportList(RobReportVO robReportVo) {
		// TODO Auto-generated method stub
		return robReportMapper.getRobReportList(robReportVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getRobReportListCount(RobReportVO robReportVo) {
		// TODO Auto-generated method stub
		return robReportMapper.getRobReportListCount(robReportVo);
	}
	
	
	
}
