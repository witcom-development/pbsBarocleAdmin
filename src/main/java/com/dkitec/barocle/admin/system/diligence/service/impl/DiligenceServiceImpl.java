package com.dkitec.barocle.admin.system.diligence.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.system.diligence.service.DiligenceMapper;
import com.dkitec.barocle.admin.system.diligence.service.DiligenceService;
import com.dkitec.barocle.admin.system.diligence.vo.DiligenceVO;
import com.dkitec.barocle.admin.system.sms.vo.SmsVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("diligenceService")
public class DiligenceServiceImpl implements DiligenceService {

	@Autowired DiligenceMapper diligenceMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<DiligenceVO> getDiligenceList(DiligenceVO dalVO) throws Exception {
		
		List<DiligenceVO> result = null;
		
			result = diligenceMapper.getDiligenceList(dalVO);
			
   		return result;
   		
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getDiligenceListCnt(DiligenceVO dalVO) throws Exception {
		
		int result = 0;
		
			
			result = diligenceMapper.getDiligenceListCnt(dalVO);

   		return result;
   		
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertDiligence(DiligenceVO dalVO) {
		
		 int resultValue = diligenceMapper.insertDiligence(dalVO);
		return resultValue;
	}
	

}
