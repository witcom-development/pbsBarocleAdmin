package com.dkitec.barocle.admin.customer.counsel.service;

import java.sql.SQLException;
import java.util.List;

import com.dkitec.barocle.admin.customer.counsel.vo.CounselVO;

public interface CounselService {
	
	List<CounselVO> getCounselList(CounselVO counselVo) throws SQLException;
	
	int getCounselListCount(CounselVO counselVo) throws SQLException;
	
	List<CounselVO> getConslLcdList(CounselVO counselVo) throws SQLException;
	
	List<CounselVO> getConslMcdList(CounselVO counselVo) throws SQLException;

}
