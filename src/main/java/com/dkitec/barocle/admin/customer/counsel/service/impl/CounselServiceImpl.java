package com.dkitec.barocle.admin.customer.counsel.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.customer.counsel.service.CounselMapper;
import com.dkitec.barocle.admin.customer.counsel.service.CounselService;
import com.dkitec.barocle.admin.customer.counsel.vo.CounselVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="counselService")
public class CounselServiceImpl extends EgovAbstractServiceImpl implements CounselService {
	
	@Autowired private CounselMapper counselMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CounselVO> getCounselList(CounselVO counselVo) throws SQLException {
		return counselMapper.getCounselList(counselVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getCounselListCount(CounselVO counselVo) throws SQLException {
		return counselMapper.getCounselListCount(counselVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CounselVO> getConslLcdList(CounselVO counselVo) throws SQLException {
		return counselMapper.getConslLcdList(counselVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CounselVO> getConslMcdList(CounselVO counselVo) throws SQLException {
		return counselMapper.getConslMcdList(counselVo);
	}
	
	

}
