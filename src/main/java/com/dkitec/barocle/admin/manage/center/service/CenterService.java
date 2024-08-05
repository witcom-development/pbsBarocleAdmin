package com.dkitec.barocle.admin.manage.center.service;

import com.dkitec.barocle.admin.manage.center.vo.CenterVO;

public interface CenterService {
	
	public int listCenterCount(CenterVO centerVO);
	
	public java.util.List<CenterVO> listCenter(CenterVO centerVO);
	
	public java.util.List<java.util.Map<String,String>> getSysCode(java.util.Map<String,String> parameterMap);
	
	public CenterVO viewCenter(CenterVO centerVO);
	
	public String getNextCenterID(); 
	
	public CenterVO insertCenter(CenterVO centerVO);
	
	public CenterVO updateCenter(CenterVO centerVO);
	
	public int deleteCenter(CenterVO centerVO);

}
