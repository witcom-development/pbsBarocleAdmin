package com.dkitec.barocle.admin.maintenance.inspect.station.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.inspect.station.vo.InspectStationVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("inspectStationMapper")
public interface InspectStationMapper {

	List<InspectStationVO> getInspectStationList(InspectStationVO inspectApVo);

	int getInspectStationListCount(InspectStationVO inspectApVo);
	
}
