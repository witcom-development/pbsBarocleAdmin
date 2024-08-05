package com.dkitec.barocle.admin.maintenance.relocation.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationMapVO;
import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationVO;
import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationWorkArrangeCallVO;
import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationWorkArrangeResultVO;
import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationWorkOrderVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("relocationMapper")
public interface RelocationMapper {

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
	
	List<RelocationWorkArrangeCallVO> getRelocationArrangeCall(RelocationWorkArrangeCallVO vo);
	List<RelocationWorkArrangeResultVO> getRelocationArrangeResult(RelocationWorkArrangeResultVO vo);
	
	int insertRelocationArrangeCall(RelocationWorkArrangeCallVO relocationVo);
}
