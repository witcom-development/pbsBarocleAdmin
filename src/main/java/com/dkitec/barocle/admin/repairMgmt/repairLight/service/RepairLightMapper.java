package com.dkitec.barocle.admin.repairMgmt.repairLight.service;

import java.util.List;

import com.dkitec.barocle.admin.repairMgmt.repairLight.vo.RepairLightVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("RepairLightMapper")
public interface RepairLightMapper {

	List<RepairLightVO> getMaintenWrkerLight(RepairLightVO repairMgmtLightVO);

	RepairLightVO getRepairLightCmptCnt(RepairLightVO repairLightVO);



	

}
