package com.dkitec.barocle.admin.maintenance.inspect.bike.service;

import java.util.List;

import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.customer.opinionboard.vo.OpinionBoardVO;
import com.dkitec.barocle.admin.maintenance.inspect.bike.vo.InspectBikeVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("inspectBikeMapper")
public interface InspectBikeMapper {

	List<InspectBikeVO> getInspectBikeList(InspectBikeVO inspectBikeVo);

	int getInspectBikeListCount(InspectBikeVO inspectBikeVo);

	int getObstacleCnt();													//자전거 장애건_현황 _카운트_cms_20161123

	List<InspectBikeVO> getObstacleList(InspectBikeVO inspectBikeVo);		//자전거 장애건_현황_리스트 _cms_20161123

	CategoryVO getObstacleTime();											//자전거 장애건_주기_조회 _cms_20161124
	
	public int insertTeamInfo(InspectBikeVO inspectBikeVo);	// 담당자 등록 180828

}
