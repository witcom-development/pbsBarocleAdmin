package com.dkitec.barocle.admin.repairBikeMall.manageMall.service;

import java.sql.SQLException;
import java.util.List;

import com.dkitec.barocle.admin.repairBikeMall.manageMall.vo.ManageMallVo;

public interface ManageMallService {
	
	List<ManageMallVo> getRepairPartPriceList(ManageMallVo manageMallVo) throws SQLException;
	
	int getRepairPartPriceListCount(ManageMallVo manageMallVo)  throws SQLException;
	
	int addPartPrice(ManageMallVo manageMallVo)  throws SQLException;
	
	ManageMallVo getRepairPartPriceDetl(ManageMallVo manageMallVo) throws SQLException;

	int updatePartPrice(ManageMallVo manageMallVo)  throws SQLException;
	
    List<ManageMallVo> getbikeMallReportList(ManageMallVo manageMallVo) throws SQLException;
	
	int getbikeMallReportListCount(ManageMallVo manageMallVo)  throws SQLException;
	
	ManageMallVo getbikeMallReportExcel(ManageMallVo manageMallVo) throws SQLException;
	
	List<ManageMallVo> bikeMallReportBikeExcel(ManageMallVo manageMallVo) throws SQLException;
	
	
	List<ManageMallVo> bikeMallReportExcelAdmin(ManageMallVo manageMallVo) throws SQLException;
	
	int addRepMonthSmsHist(ManageMallVo manageMallVo)  throws SQLException;
	
}
