package com.dkitec.barocle.admin.repairMgmt.repairPerf.service;

import java.util.List;

import com.dkitec.barocle.admin.repairMgmt.repairPerf.vo.RepairPerfVO;
import com.dkitec.barocle.admin.repairMgmt.repairPerf.vo.RepairRoundPerfStaticsVO;
import com.dkitec.barocle.admin.repairMgmt.repairPerf.vo.RepairRoundPerfVO;
import com.dkitec.barocle.admin.repairMgmt.repairWork.vo.RepairWorkVO;


public interface RepairPerfService {

	List<RepairPerfVO> getMaintenWrkerPerf(RepairPerfVO repairMgmtPerfVO);

	RepairPerfVO getRepairPerfCmptCnt(RepairPerfVO repairPerfVO);
	
	String getAdminGrpName(RepairWorkVO wVo);

	String getInsertWrkCenterId(RepairWorkVO wVo);


	List<RepairRoundPerfVO> getRoundMaintenWrkerPerf(RepairPerfVO repairMgmtPerfVO);

	 List<RepairRoundPerfStaticsVO> getRoundRepairPerfCmptCnt(RepairPerfVO repairPerfVO);

	


}
