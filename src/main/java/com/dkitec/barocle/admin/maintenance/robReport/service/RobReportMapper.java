package com.dkitec.barocle.admin.maintenance.robReport.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.robReport.vo.RobReportVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("robReportMapper")
public interface RobReportMapper {
	
	List<RobReportVO> getRobReportList(RobReportVO robReportVo);

	int getRobReportListCount(RobReportVO robReportVo);
	
}
