package com.dkitec.barocle.admin.customer.police.service;
import java.util.List;

import com.dkitec.barocle.admin.customer.donor.vo.DonorVO;
import com.dkitec.barocle.admin.customer.police.vo.PoliceVO;
import com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("policeMapper")
public interface PoliceMapper {
	
	public int listPoliceCount(PoliceVO policeVO);
	
	public List<PoliceVO> listPolice(PoliceVO policeVO);
	
	
	public List<PoliceVO> listPoliceExcel(PoliceVO policeVO);
	public List<PoliceVO> listPoliceExcel2(PoliceVO policeVO);
	public List<PoliceVO> listPoliceExcel3(PoliceVO policeVO);
	
	
	public int deletePolice(PoliceVO policeVO);
	public int updatePolice(PoliceVO policeVO);
	public int updateIssueDttm(PoliceVO policeVO);
	
	
	
	public int insertPolice(PoliceVO policeVO);
}
