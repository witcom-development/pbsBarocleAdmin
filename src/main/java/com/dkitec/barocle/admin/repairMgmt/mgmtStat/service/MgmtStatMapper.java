package com.dkitec.barocle.admin.repairMgmt.mgmtStat.service;

import java.util.List;

import com.dkitec.barocle.admin.repairMgmt.mgmtStat.vo.MgmtStatVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("MgmtStatMapper")
public interface MgmtStatMapper {

	List<MgmtStatVO> getMgmtRepairAdminStatus(MgmtStatVO mgmtStatVO);
	
	List<MgmtStatVO> getMgmtRepairStatus(MgmtStatVO mgmtStatVO);
	
	MgmtStatVO getMgmtRepairStatusCnt(MgmtStatVO mgmtStatVO);
	
	MgmtStatVO getMgmtBikeRepairStatus(MgmtStatVO mgmtStatVO);

	MgmtStatVO getMgmtRepairStatusDCnt(MgmtStatVO mgmtStatVO);

	MgmtStatVO getMgmtRepairStatusMCnt(MgmtStatVO mgmtStatVO);

	List<MgmtStatVO> getMgmtRepairStatusCenter(MgmtStatVO mgmtStatVO);
}
