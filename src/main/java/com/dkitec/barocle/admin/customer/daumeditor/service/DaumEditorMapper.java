package com.dkitec.barocle.admin.customer.daumeditor.service;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("daumEditorMapper")
public interface DaumEditorMapper {
	
	public int insertDaumEditorImage(DaumEditorVO daumEditorVO);

	public int insertDaumEditorFile(DaumEditorVO daumEditorVO);			//파일업로드_cms_20161108
}
