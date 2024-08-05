package com.dkitec.barocle.admin.cleansvc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.cleansvc.service.CleanStatusMapper;
import com.dkitec.barocle.admin.cleansvc.service.CleanStatusService;
import com.dkitec.barocle.admin.cleansvc.vo.CleanStatusExcelVO;
import com.dkitec.barocle.admin.cleansvc.vo.CleanStatusVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;


@Service(value="CleanStatusService")
public class CleanStatusImpl implements CleanStatusService {

	@Autowired private CleanStatusMapper cleanStatusMapper;
	
	
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CleanStatusVO> getLastClean(CleanStatusVO vo) {//id로 출퇴가져오기
		return cleanStatusMapper.getLastClean(vo);
	}
	
	
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CleanStatusExcelVO> getLastCleanExcel(CleanStatusVO vo) {//id로 출퇴가져오기
		return cleanStatusMapper.getLastCleanExcel(vo);
	}
	
	
	
	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)
	public int insertClean(CleanStatusVO cleanVo) {
		int result = 0;
		
		CleanStatusVO vo = getCheckClean(cleanVo);
		
		if(vo == null){
			
			cleanStatusMapper.insertClean(cleanVo);
			result = 1;
		}
		
		return result;
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public CleanStatusVO getCheckClean(CleanStatusVO vo) {// 이미 등록 되었는지 확인
		return cleanStatusMapper.getCheckClean(vo);
	}
	
	
	
	
}
