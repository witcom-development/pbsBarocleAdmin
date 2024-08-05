package com.dkitec.barocle.logging.service;

import com.dkitec.barocle.logging.vo.MenuCdVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("loggingMapper")
public interface LoggingMapper {
	
	public MenuCdVO getMenuDesc(MenuCdVO menuCdVO);

}
