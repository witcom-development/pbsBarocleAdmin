package com.dkitec.barocle.admin.system.appversion.service;

import com.dkitec.barocle.admin.system.appversion.vo.AppVersionVO;
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("appVersionMapper")
public interface AppVersionMapper {
	
	public int listAppVersionCount(AppVersionVO appVersionVO);
	
	public java.util.List<AppVersionVO> listAppVersion(AppVersionVO appVersionVO);
	
	public java.util.List<CategoryVO> getSysComCD(CategoryVO categoryVO);
	
	public AppVersionVO viewAppVersion(AppVersionVO appVersionVO);
	
	public int insertAppVersion(AppVersionVO appVersionVO);
	
	public int updateAppVersion(AppVersionVO appVersionVO);
	
	public int deleteAppVersion(AppVersionVO appVersionVO);
	
	public AppVersionVO confirmAppVersion(AppVersionVO appVersionVO);
	
}
