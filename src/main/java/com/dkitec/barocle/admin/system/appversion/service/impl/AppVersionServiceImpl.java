package com.dkitec.barocle.admin.system.appversion.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.system.appversion.service.AppVersionMapper;
import com.dkitec.barocle.admin.system.appversion.service.AppVersionService;
import com.dkitec.barocle.admin.system.appversion.vo.AppVersionVO;
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("appVersionService")
public class AppVersionServiceImpl implements AppVersionService {

	@Autowired AppVersionMapper appVersionMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int listAppVersionCount(AppVersionVO appVersionVO) {
		return appVersionMapper.listAppVersionCount(appVersionVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public java.util.List<AppVersionVO> listAppVersion(AppVersionVO appVersionVO) {
		return appVersionMapper.listAppVersion(appVersionVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public java.util.List<CategoryVO> getSysComCD(CategoryVO categoryVO) {
		return appVersionMapper.getSysComCD(categoryVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public AppVersionVO viewAppVersion(AppVersionVO appVersionVO) {
		return (AppVersionVO)appVersionMapper.viewAppVersion(appVersionVO);
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public AppVersionVO insertAppVersion(AppVersionVO appVersionVO) {
		@SuppressWarnings("unused") int resultValue = appVersionMapper.insertAppVersion(appVersionVO);
		return appVersionVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public AppVersionVO updateAppVersion(AppVersionVO appVersionVO) {
		@SuppressWarnings("unused") int resultValue = appVersionMapper.updateAppVersion(appVersionVO);
		return appVersionVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteAppVersion(AppVersionVO appVersionVO) {
		int resultValue = appVersionMapper.deleteAppVersion(appVersionVO);
		return resultValue;
	}

	@Override
	public AppVersionVO confirmAppVersion(AppVersionVO appVersionVO) {
		return appVersionMapper.confirmAppVersion(appVersionVO);
	}
	
}
