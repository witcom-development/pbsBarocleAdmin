package com.dkitec.barocle.admin.manage.relocationcar.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.manage.relocationcar.service.RelocationCarMapper;
import com.dkitec.barocle.admin.manage.relocationcar.service.RelocationCarService;
import com.dkitec.barocle.admin.manage.relocationcar.vo.RelocationCarVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.webutil.StringUtil;
import com.dkitec.barocle.util.webutil.WebUtil;

@Service("relocationCarService")
public class RelocationCarServiceImpl implements RelocationCarService {
	
	@Autowired RelocationCarMapper relocationCarMapper;
	
	@Override
	@SuppressWarnings("rawtypes")
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public java.util.List<java.util.Map> getCenterList(String centerClsCD) {
		return relocationCarMapper.getCenterList(centerClsCD);
	}
	
	@Override
	@SuppressWarnings("rawtypes")
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public java.util.List<java.util.Map> getTeamList() {
		return relocationCarMapper.getTeamList();
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int listRelocationCarCount(RelocationCarVO relocationCarVO) {
		return relocationCarMapper.listRelocationCarCount(relocationCarVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public java.util.List<RelocationCarVO> listRelocationCar(RelocationCarVO relocationCarVO) {
		return relocationCarMapper.listRelocationCar(relocationCarVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public RelocationCarVO viewRelocationCar(RelocationCarVO relocationCarVO) {
		RelocationCarVO returnVO = null;
		returnVO = relocationCarMapper.viewRelocationCar(relocationCarVO);
		return returnVO;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public String getNextRelocateCarID(){
		String str = relocationCarMapper.getNextRelocateCarID();
		String preFix = "CAR";
		if(!StringUtil.isEmpty(str)){
			int i = Integer.parseInt(str.replace(preFix,""));
			str = WebUtil.getPrefixPKAutoId(preFix,++i);
		} else { str = "CAR001"; }
		return str;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public RelocationCarVO insertRelocationCar(RelocationCarVO relocationCarVO) {
		relocationCarVO.setRelocateCarID(this.getNextRelocateCarID());
		@SuppressWarnings("unused") int resultValue = relocationCarMapper.insertRelocationCar(relocationCarVO);
		
		if (relocationCarVO.getTeamSeq() != null) {
			@SuppressWarnings("unused") int result = relocationCarMapper.insertRelocationCarTeamHist(relocationCarVO);
		}
		
		return relocationCarVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public RelocationCarVO updateRelocationCar(RelocationCarVO relocationCarVO) {
		@SuppressWarnings("unused") int resultModify = relocationCarMapper.updateRelocationCar(relocationCarVO);
		
		if (relocationCarVO.getTeamSeq() != null) {
			@SuppressWarnings("unused") int updateResult = relocationCarMapper.updateRelocationCarTeamHist(relocationCarVO);
			@SuppressWarnings("unused") int insertResult = relocationCarMapper.insertRelocationCarTeamHist(relocationCarVO);
		}
		
		return relocationCarVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteRelocationCar(RelocationCarVO relocationCarVO) {
		return relocationCarMapper.deleteRelocationCar(relocationCarVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int countGPSDuplication(RelocationCarVO relocationCarVO) {
		return relocationCarMapper.countGPSDuplication(relocationCarVO);
	}
	
	// 관리자 등록 시 재배치 차량정보 가져오기_20160714_JJH
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public java.util.List<java.util.Map> getRelocateCarList(){
		java.util.List<java.util.Map> returnMap = relocationCarMapper.getRelocateCarList();
		
		return returnMap;
	}
	// 관리자 등록 시 재배치 차량정보 가져오기_20160714_END
}
