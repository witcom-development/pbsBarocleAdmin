package com.dkitec.barocle.admin.system.mainset.service;

import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.system.mainset.vo.MainSetVO;

public interface MainSetService {
	
	public java.util.List<CategoryVO> listMainSet(CategoryVO categoryVO);
	
	public MainSetVO updateMainSet(MainSetVO mainSetVO);
	
}
