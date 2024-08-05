package com.dkitec.barocle.admin.system.appversion.service;

import com.dkitec.barocle.admin.system.appversion.vo.AppVersionVO;
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;

public interface AppVersionService {
	
	public int listAppVersionCount(AppVersionVO appVersionVO);
	
	public java.util.List<AppVersionVO> listAppVersion(AppVersionVO appVersionVO);
	
	public java.util.List<CategoryVO> getSysComCD(CategoryVO CategoryVO);
	
	public AppVersionVO viewAppVersion(AppVersionVO appVersionVO);
	
	public AppVersionVO insertAppVersion(AppVersionVO appVersionVO);
	
	public AppVersionVO updateAppVersion(AppVersionVO appVersionVO);
	
	public int deleteAppVersion(AppVersionVO appVersionVO);
	
	public AppVersionVO confirmAppVersion(AppVersionVO appVersionVO);

}
