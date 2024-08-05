package com.dkitec.barocle.admin.repairMgmt.centerStatus.service;

import java.util.List;

import com.dkitec.barocle.admin.repairMgmt.centerStatus.vo.CenterStatusVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.MemberMgmtVO;


public interface CenterStatusService {

	CenterStatusVO getCenterStatus(CenterStatusVO centerStatusVO);

	List<CenterStatusVO> getAdminsStatus(CenterStatusVO centerStatusVO);

	List<CenterStatusVO> getEtcDesc(CenterStatusVO centerStatusVO);
	
	public int insertEtcDesc(CenterStatusVO centerStatusVO);
}
