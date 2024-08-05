package com.dkitec.barocle.admin.manage.relocationcar.service;

import com.dkitec.barocle.admin.manage.relocationcar.vo.RelocationCarVO;

public interface RelocationCarService {
	
	@SuppressWarnings("rawtypes")
	public java.util.List<java.util.Map> getCenterList(String centerClsCD);
	
	@SuppressWarnings("rawtypes")
	public java.util.List<java.util.Map> getTeamList();
	
	public int listRelocationCarCount(RelocationCarVO relocationCarVO);
	
	public java.util.List<RelocationCarVO> listRelocationCar(RelocationCarVO relocationCarVO);
	
	public RelocationCarVO viewRelocationCar(RelocationCarVO relocationCarVO);
	
	public String getNextRelocateCarID();
	
	public RelocationCarVO insertRelocationCar(RelocationCarVO relocationCarVO);
	
	public RelocationCarVO updateRelocationCar(RelocationCarVO relocationCarVO);
	
	public int deleteRelocationCar(RelocationCarVO relocationCarVO);
	
	public int countGPSDuplication(RelocationCarVO relocationCarVO);
	
	public java.util.List<java.util.Map> getRelocateCarList();	// 관리자 등록 시 재배치 차량정보 가져오기_20160714_JJH

}
