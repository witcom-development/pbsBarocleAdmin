package com.dkitec.barocle.admin.maintenance.repair.bike.service;

import java.sql.SQLException;
import java.util.List;

import com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO;
import com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairPartsVO;
import com.dkitec.barocle.admin.maintenance.stockMgmt.invent.vo.InventVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("repairBikeMapper")
public interface RepairBikeMapper {

	// 20210608 운장자 자전거 수리이력
	int getRepairBikeLisHistCount(RepairBikeVO repairBikeVO)  throws SQLException;
	List<RepairBikeVO> getRepairBikeHistList(RepairBikeVO repairBikeVo) throws SQLException;
	// 20210608 end
	
	List<RepairBikeVO> getRepairBikeList(RepairBikeVO repairBikeVo);

	int getRepairBikeListCount(RepairBikeVO repairBikeVo);

	RepairBikeVO getRepairBikeInfo(RepairBikeVO repairBikeVo);

	List<String> getRepairCodeList(String repairSeq);

	List<RepairPartsVO> getRepairPartsChgInfo(RepairBikeVO repairBikeVo); 
	
	int updateBikeStatus(RepairBikeVO repairBikeVo);
	
	int updateFaultBike(RepairBikeVO repairBikeVo);
	
	String getBikeMoveYn(RepairBikeVO repairBikeVo);

	int deleteBikeParkingInfo(RepairBikeVO repairBikeVo);
	
	int updateBikeMoveHistory(RepairBikeVO repairBikeVo);
	
	int insertBikeMoveHistory(RepairBikeVO repairBikeVo);

	int updateBikeLocationInfo(RepairBikeVO repairBikeVo);
	
	int insertRepairBike(RepairBikeVO repairBikeVo);
	
	int updateRepairBike(RepairBikeVO repairBikeVo);
	
	int deleteRepairBike(RepairBikeVO repairBikeVo);
	
	int insertRepairBikeDetail(RepairBikeVO repairBikeVo);
	
	int deleteRepairBikeDetail(RepairBikeVO repairBikeVo);
	
	int insertChangeParts(RepairPartsVO repairPartsVo);
	
	int deleteChangeParts(RepairBikeVO repairBikeVo);
	
	int updateUsePart(RepairPartsVO repairPartsVo);
	
	int insertUsePartHistory(RepairPartsVO repairPartsVo);
	
	String getRemainPartsCnt(InventVO inventVo);
	
	int updateBikeStatusCmi(RepairBikeVO repairBikeVo);
	
	int insertBikeStatusHistory(RepairBikeVO repairBikeVo);

	List<RepairBikeVO> getRepairBikeMallList(RepairBikeVO repairBikeVo);

	int getRepairBikeMallListCount(RepairBikeVO repairBikeVo);

	String getAdminCenterId(RepairBikeVO repairBikeVo);

	int repairBikeCleanUp(RepairBikeVO repairBikeVo);

	int repairBikeFaultCleanUp(RepairBikeVO repairBikeVo);

	String getBikeEntrsName(RepairBikeVO repairBikeVo);

	String getRepairCmptDttm(RepairBikeVO repairBikeVo);

	String checkRepairDtlIsBatReplace(RepairBikeVO repairBikeVo);

	int insertBatReplace(RepairBikeVO repairBikeVo);

	List<RepairBikeVO> getBatReplaceList(RepairBikeVO repairBikeVo);

	String getCenterClsCd(RepairBikeVO repairBikeVo);

	String getBikeStatusCd(RepairBikeVO repairBikeVo);
	
	int selectRepairCurrDate(RepairBikeVO repairBikeVo);
}
