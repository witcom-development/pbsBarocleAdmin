package com.dkitec.barocle.admin.maintenance.distMgmt.distAction.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.distMgmt.distAction.vo.DistActionListVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distAction.vo.DistActionVO;

public interface DistActionService {

	String distActionInsert(DistActionVO distActionVO);

	void setBikeStusCd(DistActionVO distActionVO);

	String getBikeFault(DistActionVO distActionVO);
	
	void updateFaultType(DistActionVO distActionVO);

	void insertDistAct(DistActionVO distActionVO);

	void insertDistActDtl(DistActionVO distActionVO);
	
	List<DistActionListVO> distActionSelect(DistActionListVO vo) ;
	
	int distActionListCnt(DistActionListVO vo);
}
