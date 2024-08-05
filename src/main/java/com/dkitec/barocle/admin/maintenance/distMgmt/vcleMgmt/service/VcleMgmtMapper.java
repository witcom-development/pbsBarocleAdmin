package com.dkitec.barocle.admin.maintenance.distMgmt.vcleMgmt.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.distMgmt.vcleMgmt.vo.VcleMgmtVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("VcleMgmtMapper")
public interface VcleMgmtMapper {

	String checkVcleDispatch(VcleMgmtVO vcleMgmtVO);

	void updateVcleDispatch(VcleMgmtVO vcleMgmtVO);
	
	void deleteDispatch(VcleMgmtVO vcleMgmtVO);
	void deleteDispatchDtl(VcleMgmtVO vcleMgmtVO);

	void insertVcleDispatch(VcleMgmtVO vcleMgmtVO);

	void insertVcleDispatchDtl(VcleMgmtVO vcleMgmtVO);

	void updateVcleStusCd(VcleMgmtVO vcleMgmtVO);

	void updateVcleDispatchDtl(VcleMgmtVO vcleMgmtVO);
	
	List<VcleMgmtVO> getTodayDistVcle(VcleMgmtVO vcleMgmtVO);

	VcleMgmtVO checkVcleDispatchDtl(VcleMgmtVO vcleMgmtVO);
	
	List<VcleMgmtVO> getShiftWorkCdList();

	List<VcleMgmtVO> getDistVcleList(VcleMgmtVO vcleMgmtVO);
	
	List<VcleMgmtVO> getVcleInfoList(VcleMgmtVO vcleMgmtVO);

	int getDistVcleListCnt(VcleMgmtVO vcleMgmtVO);

	String getCenterIdByTeamSeq(String teamSeq);

	int getRoundVcleListCnt(VcleMgmtVO vcleMgmtVO);

	List<VcleMgmtVO> getRoundVcleList(VcleMgmtVO vcleMgmtVO);

	List<VcleMgmtVO> getRoundInfoList(VcleMgmtVO vcleMgmtVO);                                     
	
	
	
}
