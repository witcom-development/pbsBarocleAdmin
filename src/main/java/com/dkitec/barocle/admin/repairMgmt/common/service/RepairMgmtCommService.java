package com.dkitec.barocle.admin.repairMgmt.common.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.stockMgmt.invent.vo.InventVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCenterVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;

public interface RepairMgmtCommService {

	List<CommonCodeVO> getAdmComCodeList(CommonCodeVO cVo);

	List<CommonCenterVO> getAdmCenterCodeList();

	List<InventVO> getPartsStockCnt(InventVO inventVo);
	
	

}
