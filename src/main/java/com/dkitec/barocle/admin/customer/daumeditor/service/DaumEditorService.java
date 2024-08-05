package com.dkitec.barocle.admin.customer.daumeditor.service;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;

public interface DaumEditorService {
	
	public int insertDaumImage(DaumEditorVO daumEditorVO) throws CfoodException;

	//파일 업로드 _cms_20161108
	public int insertDaumFile(DaumEditorVO daumEditorVO) throws CfoodException;
}
