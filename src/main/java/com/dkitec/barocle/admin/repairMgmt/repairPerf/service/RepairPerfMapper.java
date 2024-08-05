package com.dkitec.barocle.admin.repairMgmt.repairPerf.service;

import java.util.List;

import com.dkitec.barocle.admin.repairMgmt.repairPerf.vo.RepairPerfVO;
import com.dkitec.barocle.admin.repairMgmt.repairPerf.vo.RepairRoundPerfStaticsVO;
import com.dkitec.barocle.admin.repairMgmt.repairPerf.vo.RepairRoundPerfVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("RepairPerfMapper")
public interface RepairPerfMapper {

	List<RepairPerfVO> getMaintenWrkerPerf(RepairPerfVO repairMgmtPerfVO);

	RepairPerfVO getRepairPerfCmptCnt(RepairPerfVO repairPerfVO);

	
	
	List<RepairRoundPerfVO> getRoundMaintenWrkerPerf(RepairPerfVO repairMgmtPerfVO);

	 List<RepairRoundPerfStaticsVO> getRoundRepairPerfCmptCnt(RepairPerfVO repairPerfVO);



	

}
