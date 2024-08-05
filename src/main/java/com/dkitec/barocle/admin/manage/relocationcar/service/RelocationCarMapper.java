package com.dkitec.barocle.admin.manage.relocationcar.service;

import com.dkitec.barocle.admin.manage.relocationcar.vo.RelocationCarVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("relocationCarMapper")
public interface RelocationCarMapper {
	
	@SuppressWarnings("rawtypes")
	public java.util.List<java.util.Map> getCenterList(String centerClsCD);
	
	@SuppressWarnings("rawtypes")
	public java.util.List<java.util.Map> getTeamList();
	
	
	public int listRelocationCarCount(RelocationCarVO relocationCarVO);
	
	public java.util.List<RelocationCarVO> listRelocationCar(RelocationCarVO relocationCarVO);
	
	public RelocationCarVO viewRelocationCar(RelocationCarVO relocationCarVO);
	
	public String getNextRelocateCarID();
	
	public int insertRelocationCar(RelocationCarVO relocationCarVO);
	
	public int updateRelocationCar(RelocationCarVO relocationCarVO);
	
	public int deleteRelocationCar(RelocationCarVO relocationCarVO);
	
	public int countGPSDuplication(RelocationCarVO relocationCarVO);
	
	public java.util.List<java.util.Map> getRelocateCarList();	// 관리자 등록 시 재배치 차량정보 가져오기_20160714_JJH
	
	public int insertRelocationCarTeamHist(RelocationCarVO relocationCarVO);	// 팀 이력 등록
	
	public int updateRelocationCarTeamHist(RelocationCarVO relocationCarVO);	// 팀 이력 업데이트

}
