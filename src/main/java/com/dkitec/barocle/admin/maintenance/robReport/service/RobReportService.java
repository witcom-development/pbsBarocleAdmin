package com.dkitec.barocle.admin.maintenance.robReport.service;

import java.util.List;

import com.dkitec.barocle.admin.maintenance.robReport.vo.RobReportVO;

public interface RobReportService {

	List<RobReportVO> getRobReportList(RobReportVO robReportVo);

	int getRobReportListCount(RobReportVO robReportVo);
	
}
