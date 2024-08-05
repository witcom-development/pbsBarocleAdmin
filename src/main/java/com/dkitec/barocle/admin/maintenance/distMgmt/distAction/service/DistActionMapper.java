package com.dkitec.barocle.admin.maintenance.distMgmt.distAction.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.distMgmt.distAction.vo.DistActionListVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distAction.vo.DistActionVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("distActionMapper")
public interface DistActionMapper {

	void insertDistAct(DistActionVO distActionVO);
	
	void insertDistActDtl(DistActionVO distActionVO);
	
	void setBikeStusCd(DistActionVO distActionVO);

	String getBikeFault(DistActionVO distActionVO);

	void updateFaultType(DistActionVO distActionVO);
	
	// 2022 01 19 회수작업 추가
	List<DistActionListVO> distActionSelect(DistActionListVO vo) ;
	
	int distActionListCnt(DistActionListVO vo);
	
}
