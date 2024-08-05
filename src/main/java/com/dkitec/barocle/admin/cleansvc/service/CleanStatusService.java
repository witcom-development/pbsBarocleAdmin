package com.dkitec.barocle.admin.cleansvc.service;

import java.util.List;

import com.dkitec.barocle.admin.cleansvc.vo.CleanStatusExcelVO;
import com.dkitec.barocle.admin.cleansvc.vo.CleanStatusVO;


public interface CleanStatusService {
	
	int insertClean(CleanStatusVO cleanVo);
	
	List<CleanStatusVO> getLastClean(CleanStatusVO vo);

	List<CleanStatusExcelVO> getLastCleanExcel(CleanStatusVO vo);
	
	CleanStatusVO getCheckClean(CleanStatusVO vo);

}
