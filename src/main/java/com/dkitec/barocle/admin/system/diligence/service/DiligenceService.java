package com.dkitec.barocle.admin.system.diligence.service;

import java.util.List;

import com.dkitec.barocle.admin.system.diligence.vo.DiligenceVO;

public interface DiligenceService {
	
	public List<DiligenceVO> getDiligenceList(DiligenceVO dalVO) throws Exception;
	
	public int getDiligenceListCnt(DiligenceVO dalVO) throws Exception;
	
	public int insertDiligence(DiligenceVO dalVO);
	
}
