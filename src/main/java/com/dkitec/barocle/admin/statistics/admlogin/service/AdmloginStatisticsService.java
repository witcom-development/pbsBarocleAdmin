package com.dkitec.barocle.admin.statistics.admlogin.service;

import java.util.List;

import com.dkitec.barocle.admin.statistics.admlogin.vo.AdmloginStatisticsVO;


public interface AdmloginStatisticsService {

	// 운영자 접속 현황 총 카운트
	int getAdminLoginCnt(AdmloginStatisticsVO admloginStatisticsVo);
	// 운영자 접속 현황 총 리스트
	List<AdmloginStatisticsVO> getAdminLoginList(AdmloginStatisticsVO admloginStatisticsVo);

}
