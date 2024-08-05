package com.dkitec.barocle.admin.repairMgmt.centerStatus.service;

import java.util.List;

import com.dkitec.barocle.admin.repairMgmt.centerStatus.vo.CenterStatusVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("CenterStatusMapper")
public interface CenterStatusMapper {


	CenterStatusVO getCenterStatus(CenterStatusVO centerStatusVO);

	List<CenterStatusVO> getAdminsStatus(CenterStatusVO centerStatusVO);
	
	List<CenterStatusVO> getEtcDesc(CenterStatusVO centerStatusVO);

	public int insertEtcDesc(CenterStatusVO centerStatusVO);
}
