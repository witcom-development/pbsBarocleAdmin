package com.dkitec.barocle.admin.customer.daumeditor.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.customer.daumeditor.service.DaumEditorMapper;
import com.dkitec.barocle.admin.customer.daumeditor.service.DaumEditorService;
import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("daumEditorService")
public class DaumEditorServiceImpl implements DaumEditorService {
	
	@Autowired DaumEditorMapper daumEditorMapper;
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertDaumImage(DaumEditorVO daumEditorVO) throws CfoodException {
		return daumEditorMapper.insertDaumEditorImage(daumEditorVO);
	}
	
	//파일업로드_cms_20161108
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertDaumFile(DaumEditorVO daumEditorVO) throws CfoodException {
		return daumEditorMapper.insertDaumEditorFile(daumEditorVO);
	}
	
}
