package com.dkitec.barocle.admin.statistics.dashBoard.service;

import com.dkitec.barocle.admin.statistics.dashBoard.vo.DashBoardVO;


public interface DashBoardService {
 
	DashBoardVO getDashBoardMain(DashBoardVO vo);
	
	int updateDashBoardMain(DashBoardVO vo);
}
