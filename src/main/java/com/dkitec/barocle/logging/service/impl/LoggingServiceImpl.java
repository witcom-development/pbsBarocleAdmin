package com.dkitec.barocle.logging.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.logging.service.LoggingMapper;
import com.dkitec.barocle.logging.service.LoggingService;
import com.dkitec.barocle.logging.vo.MenuCdVO;

@Service("loggingService")
public class LoggingServiceImpl implements LoggingService {
	
	@Autowired LoggingMapper loggingMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public MenuCdVO getMenuDesc(MenuCdVO menuCdVO){
		return loggingMapper.getMenuDesc(menuCdVO);
	}
	
}
