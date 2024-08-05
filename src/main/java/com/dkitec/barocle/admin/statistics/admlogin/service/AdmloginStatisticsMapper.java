package com.dkitec.barocle.admin.statistics.admlogin.service;

import java.util.List;

import com.dkitec.barocle.admin.statistics.admlogin.vo.AdmloginStatisticsVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("admloginStatisticsMapper")
public interface AdmloginStatisticsMapper {
	
	// 운영자 접속 현황 총 카운트
	int getAdminLoginCnt(AdmloginStatisticsVO admloginStatisticsVo);
	// 운영자 접속 현황 총 리스트
	List<AdmloginStatisticsVO> getAdminLoginList(AdmloginStatisticsVO admloginStatisticsVo);

}
	