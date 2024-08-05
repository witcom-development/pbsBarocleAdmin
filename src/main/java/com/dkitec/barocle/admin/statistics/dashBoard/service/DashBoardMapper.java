package com.dkitec.barocle.admin.statistics.dashBoard.service;

import com.dkitec.barocle.admin.statistics.dashBoard.vo.DashBoardVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("DashBoardMapper")
public interface DashBoardMapper {

	DashBoardVO getDashBoardMain(DashBoardVO vo);
	
	int updateDashBoardMain(DashBoardVO vo);
	
	int insertDashBoardMainHist(DashBoardVO vo);
}
	 