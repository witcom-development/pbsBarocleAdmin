package com.dkitec.barocle.admin.manage.center.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.manage.center.vo.CenterVO;
import com.dkitec.barocle.admin.manage.center.service.CenterMapper;
import com.dkitec.barocle.admin.manage.center.service.CenterService;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.webutil.StringUtil;
import com.dkitec.barocle.util.webutil.WebUtil;

@Service("centerService")
public class CenterServiceImpl implements CenterService {
	
	@Autowired CenterMapper centerMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int listCenterCount(CenterVO centerVO) {
		return centerMapper.listCenterCount(centerVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public java.util.List<CenterVO> listCenter(CenterVO centerVO) {
		return centerMapper.listCenter(centerVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public java.util.List<java.util.Map<String,String>> getSysCode(java.util.Map<String,String> parameterMap) {
		return centerMapper.getSysCode(parameterMap);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public CenterVO viewCenter(CenterVO centerVO) {
		CenterVO returnVO = null;
		returnVO = centerMapper.viewCenter(centerVO);
		return returnVO;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public String getNextCenterID(){
		String str = centerMapper.getNextCenterID();
		String preFix = "CEN";
		if(!StringUtil.isEmpty(str)){
			int i = Integer.parseInt(str.replace(preFix,""));
			str = WebUtil.getPrefixPKAutoId(preFix,++i);
		} else { str = "CEN001"; }
		return str;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public CenterVO insertCenter(CenterVO centerVO) {
		centerVO.setCenterID(this.getNextCenterID());
		@SuppressWarnings("unused") int resultValue = centerMapper.insertCenter(centerVO);
		return centerVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public CenterVO updateCenter(CenterVO centerVO) {
		@SuppressWarnings("unused") int resultModify = centerMapper.updateCenter(centerVO);
		return centerVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteCenter(CenterVO centerVO) {
		return centerMapper.deleteCenter(centerVO);
	}

}
