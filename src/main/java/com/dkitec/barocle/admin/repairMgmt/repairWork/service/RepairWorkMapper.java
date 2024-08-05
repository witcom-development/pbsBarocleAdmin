package com.dkitec.barocle.admin.repairMgmt.repairWork.service;

import java.util.List;

import com.dkitec.barocle.admin.repairMgmt.repairWork.vo.RepairTermVO;
import com.dkitec.barocle.admin.repairMgmt.repairWork.vo.RepairWorkVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("RepairWorkMapper")
public interface RepairWorkMapper {

	void insertRepairWork(RepairWorkVO repairWorkVO);

	String getAdminGrpName(RepairWorkVO repairWorkVO);

	void insertRepairWorkDtl(RepairWorkVO repairWorkVO);

	List<RepairWorkVO> getMaintenWrkerAtt(RepairWorkVO repairWorkVO);

	int getMaintenWrkerAttCnt(RepairWorkVO repairWorkVO);

	String getInsertWrkCenterId(RepairWorkVO repairWorkVO);

	void updateRepairWorkAprvd(RepairWorkVO repairWorkVO);

	void updateRepairWork(RepairWorkVO repairWorkVO);

	void updateRepairWorkDtl(RepairWorkVO repairWorkVO);

	List<CommonCodeVO> getAdmComCodeList(CommonCodeVO cVo);

	void insertRepairTerm(RepairTermVO repairTermVO);

	RepairTermVO getRepairTermInfo(String repairSeq);

	void updateRepairTerm(RepairTermVO repairTermVo);

	List<CommonCodeVO> getAdmCenterCodeList();

	RepairWorkVO getMaintenWrkerAttD(RepairWorkVO repairWorkVO);

	String getInsertWrkSeq(RepairWorkVO repairWorkVO);

	String checkRepairWork(RepairWorkVO repairWorkVO);

	String getCenterNameWithCenterCode(RepairWorkVO repairWorkVO);
	 

}
