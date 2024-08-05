package com.dkitec.barocle.admin.system.diligence.service;

import com.dkitec.barocle.admin.system.diligence.vo.DiligenceVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("diligenceMapper")
public interface DiligenceMapper {
	
	public java.util.List<DiligenceVO> getDiligenceList(DiligenceVO dalVO); 

	public int getDiligenceListCnt(DiligenceVO dalVO);
	
	public int insertDiligence(DiligenceVO dalVO);
	
}
