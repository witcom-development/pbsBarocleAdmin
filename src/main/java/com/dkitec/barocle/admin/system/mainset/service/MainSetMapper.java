package com.dkitec.barocle.admin.system.mainset.service;

import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mainSetMapper")
public interface MainSetMapper {
	
	public java.util.List<CategoryVO> listMainSet(CategoryVO categoryVO);
	
	public int updateMainSet(CategoryVO categoryVO);

	public int updateMainSetMbMenu(CategoryVO categorVo);
	
}
