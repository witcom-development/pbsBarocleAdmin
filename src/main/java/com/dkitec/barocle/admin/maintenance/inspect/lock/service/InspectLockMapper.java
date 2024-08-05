package com.dkitec.barocle.admin.maintenance.inspect.lock.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.inspect.lock.vo.InspectLockVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("inspectLockMapper")
public interface InspectLockMapper {

	List<InspectLockVO> getInspectLockList(InspectLockVO inspectLockVo);

	int getInspectLockListCount(InspectLockVO inspectLockVo);

}
