package com.dkitec.barocle.admin.statistics.admlogin.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.statistics.admlogin.service.AdmloginStatisticsMapper;
import com.dkitec.barocle.admin.statistics.admlogin.service.AdmloginStatisticsService;
import com.dkitec.barocle.admin.statistics.admlogin.vo.AdmloginStatisticsVO;
import com.dkitec.barocle.datasource.ContextHolder;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="admloginStatisticsService")
public class AdmloginStatisticsServiceImpl extends EgovAbstractServiceImpl implements AdmloginStatisticsService {

	@Autowired private AdmloginStatisticsMapper admloginStatisticsMapper;

	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public int getAdminLoginCnt(AdmloginStatisticsVO admloginStatisticsVo) {
		// TODO Auto-generated method stub
		return admloginStatisticsMapper.getAdminLoginCnt(admloginStatisticsVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<AdmloginStatisticsVO> getAdminLoginList(AdmloginStatisticsVO admloginStatisticsVo) {
		// TODO Auto-generated method stub
		return admloginStatisticsMapper.getAdminLoginList(admloginStatisticsVo);
	}

}