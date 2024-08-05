package com.dkitec.barocle.admin.repairMgmt.centerStatus.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.repairMgmt.centerStatus.service.CenterStatusMapper;
import com.dkitec.barocle.admin.repairMgmt.centerStatus.service.CenterStatusService;
import com.dkitec.barocle.admin.repairMgmt.centerStatus.vo.CenterStatusVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;


@Service("CenterStatusService")
public class CenterStatusServiceImpl implements CenterStatusService {
	
	@Autowired
	CenterStatusMapper centerStatusMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public CenterStatusVO getCenterStatus(CenterStatusVO centerStatusVO) {
		return centerStatusMapper.getCenterStatus(centerStatusVO);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public List<CenterStatusVO> getAdminsStatus(CenterStatusVO centerStatusVO) {
		return centerStatusMapper.getAdminsStatus(centerStatusVO);
	}

	@Override
	public List<CenterStatusVO> getEtcDesc(CenterStatusVO centerStatusVO) {
		// TODO Auto-generated method stub
		return centerStatusMapper.getEtcDesc(centerStatusVO);
	}

	@Override
	public int insertEtcDesc(CenterStatusVO centerStatusVO) {
		// TODO Auto-generated method stub
		return centerStatusMapper.insertEtcDesc(centerStatusVO);
	}
	
	

}
