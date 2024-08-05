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
package com.dkitec.barocle.admin.maintenance.repair.division.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.repair.division.vo.RepairDivisionVO;

public interface RepairDivisionService {
	
	int getCodeListCnt(RepairDivisionVO repairDivisionVo);					//수리구분코드수 조회

	List<RepairDivisionVO> getCodeList(RepairDivisionVO repairDivisionVo);	//수리구분코드 조회

	RepairDivisionVO getDivisionUdtList(RepairDivisionVO repairDivisionVo);	//수리구분코드 수정 List

	int getDivisionUdt(RepairDivisionVO repairDivisionVo);					//수리구분코드 수정

	int getDivisionAdd(RepairDivisionVO repairDivisionVo);					//수리구분 등록

	void getDivisionDel(RepairDivisionVO repairDivisionVo);					//수리구분 삭제

}
