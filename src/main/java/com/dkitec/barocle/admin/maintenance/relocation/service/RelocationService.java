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
package com.dkitec.barocle.admin.maintenance.relocation.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationMapVO;
import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationVO;
import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationWorkArrangeCallVO;
import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationWorkArrangeResultVO;
import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationWorkOrderVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

public interface RelocationService {

	List<RelocationVO> getRelocationNeedList(RelocationVO relocationVo);

	int getRelocationNeedListCount(RelocationVO relocationVo);
	
	List<RelocationVO> getRelocationStateList(RelocationVO relocationVo);

	int getRelocationStateListCount(RelocationVO relocationVo);
	
	List<RelocationVO> getRelocationStateDetail(RelocationVO relocationVo);

	int getRelocationStateDetailCount(RelocationVO relocationVo);
	
	List<RelocationVO> getRelocationStateBike(RelocationVO relocationVo);

	int getRelocationStateBikeCount(RelocationVO relocationVo);
	
	
	List<RelocationVO> getRelocationStateStation(RelocationVO relocationVo);
	
	int getRelocationStateStationCount(RelocationVO relocationVo);

	List<RelocationMapVO> getRelocationStateStationMap(RelocationVO relocationVo);
	
	
	List<RelocationWorkOrderVO> getRelocationWorkOrder(RelocationWorkOrderVO relocationVo);
	
	int getRelocationWorkOrderCount(RelocationWorkOrderVO relocationVo);
	
	int insertRelocationArrangeCall(RelocationWorkArrangeCallVO relocationVo);
	 
	
	List<RelocationWorkArrangeCallVO> getRelocationArrangeCall(RelocationWorkArrangeCallVO vo);
	List<RelocationWorkArrangeResultVO> getRelocationArrangeResult(RelocationWorkArrangeResultVO vo);
}
