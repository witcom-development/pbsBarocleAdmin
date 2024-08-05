package com.dkitec.barocle.admin.maintenance.inspect.ap.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.inspect.ap.vo.InspectApVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("inspectApMapper")
public interface InspectApMapper {

	List<InspectApVO> getInspectApList(InspectApVO inspectApVo);

	int getInspectApListCount(InspectApVO inspectApVo);
	
	int updateApStatus(InspectApVO inspectApVo);
	
	int insertFaultAp(InspectApVO inspectApVo);
	
	int insertFaultApDetail(InspectApVO inspectApVo);
	
	int insertRepairAp(InspectApVO inspectApVo);
	
}
