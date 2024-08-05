package com.dkitec.barocle.admin.customer.counsel.service;

import java.util.List;

import com.dkitec.barocle.admin.customer.counsel.vo.CounselVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("counselMapper")
public interface CounselMapper {
	
	List<CounselVO> getCounselList(CounselVO counselVo);
	
	int getCounselListCount(CounselVO counselVo);
	
	List<CounselVO> getConslLcdList(CounselVO counselVo);
	
	List<CounselVO> getConslMcdList(CounselVO counselVo);

}
