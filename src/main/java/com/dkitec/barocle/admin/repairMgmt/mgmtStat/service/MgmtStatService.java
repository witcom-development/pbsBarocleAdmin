package com.dkitec.barocle.admin.repairMgmt.mgmtStat.service;

import java.util.List;

import com.dkitec.barocle.admin.repairMgmt.mgmtStat.vo.MgmtStatVO;


public interface MgmtStatService {

	List<MgmtStatVO> getMgmtRepairAdminStatus(MgmtStatVO mgmtStatVO);
	
	List<MgmtStatVO> getMgmtRepairStatus(MgmtStatVO mgmtStatVO);
	
	List<MgmtStatVO> getMgmtRepairStatusCnt(MgmtStatVO mgmtStatVO);
	
	MgmtStatVO getMgmtBikeRepairStatus(MgmtStatVO mgmtStatVO);
	
	// 20210203
	List<MgmtStatVO> getMgmtRepairStatusCenter(MgmtStatVO mgmtStatVO);


}
