package com.dkitec.barocle.admin.system.savecarbon.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.system.savecarbon.service.SaveCarbonMapper;
import com.dkitec.barocle.admin.system.savecarbon.service.SaveCarbonService;
import com.dkitec.barocle.admin.system.savecarbon.vo.SaveCarbonVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("saveCarbonService")
public class SaveCarbonServiceImpl implements SaveCarbonService {

	@Autowired 
	private SaveCarbonMapper saveCarbonMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public java.util.List<SaveCarbonVO> getSaveCarbonList(SaveCarbonVO saveCarbonVo){
		return saveCarbonMapper.getSaveCarbonList(saveCarbonVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getSaveCarbonListCnt(SaveCarbonVO saveCarbonVo){
		return saveCarbonMapper.getSaveCarbonListCnt(saveCarbonVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public String getTotalSaveCarbon(SaveCarbonVO saveCarbonVo){
		return saveCarbonMapper.getTotalSaveCarbon(saveCarbonVo);
	}

	@Override
	public List<SaveCarbonVO> getGoalList() {
		// TODO Auto-generated method stub
		return saveCarbonMapper.getGoalList();
	}

	@Override
	public List<SaveCarbonVO> getMeansList() {
		// TODO Auto-generated method stub
		return saveCarbonMapper.getMeansList();
	}

}
