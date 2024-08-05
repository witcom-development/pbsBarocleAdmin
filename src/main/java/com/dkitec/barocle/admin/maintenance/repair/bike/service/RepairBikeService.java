/*
 * @Package Name : com.dkitec.barocle.admin.manage.DeviceMgmt.service
 * @파일명          : DeviceMgmtService.java
 * @작성일          : 2015. 4. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 15.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.maintenance.repair.bike.service;

import java.sql.SQLException;
import java.util.List;

import com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO;
import com.dkitec.barocle.admin.maintenance.stockMgmt.invent.vo.InventVO;

public interface RepairBikeService {

	List<RepairBikeVO> getRepairBikeList(RepairBikeVO repairBikeVo) throws SQLException;

	int getRepairBikeListCount(RepairBikeVO repairBikeVO)  throws SQLException;

	
	// 20210608 운장자 자전거 수리이력
	int getRepairBikeLisHistCount(RepairBikeVO repairBikeVO)  throws SQLException;
	List<RepairBikeVO> getRepairBikeHistList(RepairBikeVO repairBikeVo) throws SQLException;
	// 20210608 end
	
	RepairBikeVO getRepairBikeInfo(RepairBikeVO repairBikeVO)  throws SQLException;
	
	List<String> getRepairCodeList(String repairSeq) throws SQLException;

	String getBikeMoveYn(RepairBikeVO repairBikeVo);
	
	int insertRepairBike(RepairBikeVO repairBikeVo);
	
	int updateRepairBike(RepairBikeVO repairBikeVo);
	
	int deleteRepairBike(RepairBikeVO repairBikeVo);
	
	String getRemainPartsCnt(InventVO inventVo);

	List<RepairBikeVO> getRepairBikeMallList(RepairBikeVO repairBikeVo);

	int getRepairBikeListMallCount(RepairBikeVO repairBikeVo);

	String getAdminCenterId(RepairBikeVO repairBikeVo);

	void repairBikeCleanUp(RepairBikeVO repairBikeVo);

	void repairBikeFaultCleanUp(RepairBikeVO repairBikeVo);

	String getBikeEntrsName(RepairBikeVO repairBikeVo);

	String getRepairCmptDttm(RepairBikeVO repairBikeVo);
	
	String checkRepairDtlIsBatReplace(RepairBikeVO repairBikeVo);

	void insertBatReplace(RepairBikeVO repairBikeVo);

	List<RepairBikeVO> getBatReplaceList(RepairBikeVO repairBikeVo);

	String getCenterClsCd(RepairBikeVO repairBikeVo);

	String getBikeStatusCd(RepairBikeVO repairBikeVo);
	
	int selectRepairCurrDate(RepairBikeVO repairBikeVo);
}
