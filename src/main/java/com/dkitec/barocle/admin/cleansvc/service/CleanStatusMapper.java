package com.dkitec.barocle.admin.cleansvc.service;

import java.util.List;

import com.dkitec.barocle.admin.cleansvc.vo.CleanStatusExcelVO;
import com.dkitec.barocle.admin.cleansvc.vo.CleanStatusVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("CleanStatusMapper")
public interface CleanStatusMapper {
	
	void insertClean(CleanStatusVO cleanVo);
	
	List<CleanStatusVO> getLastClean(CleanStatusVO vo);
	
	
	List<CleanStatusExcelVO> getLastCleanExcel(CleanStatusVO vo);

	CleanStatusVO getCheckClean(CleanStatusVO cleanVo);
	

}
