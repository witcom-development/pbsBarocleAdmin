package com.dkitec.barocle.admin.manage.center.service;

import com.dkitec.barocle.admin.manage.center.vo.CenterVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("centerMapper")
public interface CenterMapper {
	
	public int listCenterCount(CenterVO centerVO);
	
	public java.util.List<CenterVO> listCenter(CenterVO centerVO);
	
	public java.util.List<java.util.Map<String,String>> getSysCode(java.util.Map<String,String> parameterMap);
	
	public CenterVO viewCenter(CenterVO centerVO);
	
	public String getNextCenterID();
	
	public int insertCenter(CenterVO centerVO);
	
	public int updateCenter(CenterVO centerVO);
	
	public int deleteCenter(CenterVO centerVO);

}
