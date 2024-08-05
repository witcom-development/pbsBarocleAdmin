package com.dkitec.barocle.admin.repairMgmt.repairLight.service;

import java.util.List;

import com.dkitec.barocle.admin.repairMgmt.repairLight.vo.RepairLightVO;
import com.dkitec.barocle.admin.repairMgmt.repairWork.vo.RepairWorkVO;


public interface RepairLightService {

	List<RepairLightVO> getMaintenWrkerLight(RepairLightVO repairMgmtLightVO);
	
	String getAdminGrpName(RepairWorkVO wVo);

	String getInsertWrkCenterId(RepairWorkVO wVo);

}
