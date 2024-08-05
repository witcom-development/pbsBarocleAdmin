package com.dkitec.barocle.admin.repairMgmt.repairWork.service;

import java.util.List;

import com.dkitec.barocle.admin.repairMgmt.repairWork.vo.RepairTermVO;
import com.dkitec.barocle.admin.repairMgmt.repairWork.vo.RepairWorkVO;

public interface RepairWorkService {

	void insertRepairWork(RepairWorkVO repairWorkVO);

	List<RepairWorkVO> getMaintenWrkerAtt(RepairWorkVO repairWorkVO);

	int getMaintenWrkerAttCnt(RepairWorkVO repairWorkVO);

	String getInsertWrkCenterId(RepairWorkVO repairWorkVO);
	
	String getInsertWrkSeq(RepairWorkVO repairWorkVO);

	void updateRepairWorkAprvd(RepairWorkVO repairWorkVO);

	void updateRepairWork(RepairWorkVO repairWorkVO);

	void updateRepairWorkDtl(RepairWorkVO repairWorkVO);

	String getAdminGrpName(RepairWorkVO repairWorkVO);

	void insertRepairTerm(RepairTermVO repairTermVo);

	RepairTermVO getRepairTermInfo(String string);

	void updateRepairTerm(RepairTermVO repairTermVo);

	RepairWorkVO getMaintenWrkerAttD(RepairWorkVO repairWorkVO);
	
	String checkRepairWork(RepairWorkVO repairWorkVO);

	String getCenterNameWithCenterCode(RepairWorkVO repairWorkVO);


}
