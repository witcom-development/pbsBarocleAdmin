package com.dkitec.barocle.admin.system.savecarbon.service;

import java.util.List;

import com.dkitec.barocle.admin.system.savecarbon.vo.SaveCarbonVO;

public interface SaveCarbonService {

	java.util.List<SaveCarbonVO> getSaveCarbonList(SaveCarbonVO saveCarbonVo);
	
	int getSaveCarbonListCnt(SaveCarbonVO saveCarbonVo);
	
	String getTotalSaveCarbon(SaveCarbonVO saveCarbonVo);

	List<SaveCarbonVO> getGoalList();					//이용목적

	List<SaveCarbonVO> getMeansList();					//이용수단

}
