package com.dkitec.barocle.admin.statistics.dashBoard.service.impl;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.statistics.dashBoard.service.DashBoardMapper;
import com.dkitec.barocle.admin.statistics.dashBoard.service.DashBoardService;
import com.dkitec.barocle.admin.statistics.dashBoard.vo.DashBoardVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service(value="dashBoardService")
public class DashBoardServiceImpl extends EgovAbstractServiceImpl implements DashBoardService {

	/** EgovPropertyService */
	@Resource(name = "propertiesService") protected EgovPropertyService propertiesService;

	@Autowired private DashBoardMapper dashBoardMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.STATICS)
	public DashBoardVO getDashBoardMain(DashBoardVO vo) {
		return dashBoardMapper.getDashBoardMain(vo);
	}

	@Override
	public int updateDashBoardMain(DashBoardVO vo) {
		dashBoardMapper.insertDashBoardMainHist(vo);
		return dashBoardMapper.updateDashBoardMain(vo);
	}
	 
	
}