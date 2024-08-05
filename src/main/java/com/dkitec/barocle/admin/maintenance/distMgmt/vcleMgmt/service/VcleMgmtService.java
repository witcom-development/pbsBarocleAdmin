package com.dkitec.barocle.admin.maintenance.distMgmt.vcleMgmt.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.distMgmt.vcleMgmt.vo.VcleMgmtVO;

public interface VcleMgmtService {

	void insertVcleDispatch(VcleMgmtVO vcleMgmtVO);
	
	void insertVcleDispatchDtl(VcleMgmtVO vcleMgmtVO);

	String checkVcleDispatch(VcleMgmtVO vcleMgmtVO);

	void updateVcleDispatch(VcleMgmtVO vcleMgmtVO);

	VcleMgmtVO getTodayDistVcle(VcleMgmtVO vcleMgmtVO);

	void updateVcleDispatchDtl(VcleMgmtVO vcleMgmtVO);

	void updateVcleDispatchAll(VcleMgmtVO vcleMgmtVO);

	VcleMgmtVO checkVcleDispatchDtl(VcleMgmtVO vcleMgmtVO);
	
	List<VcleMgmtVO> getShiftWorkCdList();
	
	List<VcleMgmtVO> getDistVcleList(VcleMgmtVO vcleMgmtVO);

	int getDistVcleListCnt(VcleMgmtVO vcleMgmtVO);

	List<VcleMgmtVO> getVcleInfoList(VcleMgmtVO vcleMgmtVO);

	String getCenterIdByTeamSeq(String teamSeq);

	void updateVcleStusCd(VcleMgmtVO vcleMgmtVO);

	void insertDistVcleAll(VcleMgmtVO vcleMgmtVO);
	

	
	int getRoundVcleListCnt(VcleMgmtVO vcleMgmtVO);	
	List<VcleMgmtVO> getRoundVcleList(VcleMgmtVO vcleMgmtVO);
	List<VcleMgmtVO> getRoundInfoList(VcleMgmtVO vcleMgmtVO);
}
