package com.dkitec.barocle.admin.repairBikeMall.manageMall.service;

import java.util.List;

import com.dkitec.barocle.admin.repairBikeMall.manageMall.vo.ManageMallVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("manageMallMapper")
public interface ManageMallMapper {
	
	List<ManageMallVo> getRepairPartPriceList(ManageMallVo manageMallVo);
	
	int getRepairPartPriceListCount(ManageMallVo manageMallVo);
	
	int addPartPrice(ManageMallVo manageMallVo);
	
	ManageMallVo getRepairPartPriceDetl(ManageMallVo manageMallVo);
	
	int updatePartPrice(ManageMallVo manageMallVo);
	
    List<ManageMallVo> getbikeMallReportList(ManageMallVo manageMallVo);
	
	int getbikeMallReportListCount(ManageMallVo manageMallVo);
	
	ManageMallVo getbikeMallReportExcel(ManageMallVo manageMallVo);
	
	
	List<ManageMallVo> bikeMallReportBikeExcel(ManageMallVo manageMallVo);
	
	List<ManageMallVo> bikeMallReportExcelAdmin(ManageMallVo manageMallVo);
	
	int addRepMonthSmsHist(ManageMallVo manageMallVo);

}
