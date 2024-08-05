package com.dkitec.barocle.admin.statistics.zeropay.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.statistics.zeropay.service.ZeropayStatisticsMapper;
import com.dkitec.barocle.admin.statistics.zeropay.service.ZeropayStatisticsService;
import com.dkitec.barocle.admin.statistics.zeropay.vo.ZeropayStatisticsVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="zeropayStatisticsService")
public class ZeropayStatisticsServiceImpl extends EgovAbstractServiceImpl implements ZeropayStatisticsService {

	@Autowired private ZeropayStatisticsMapper zeropayStatisticsMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.STATICS)
	public List<ZeropayStatisticsVO> getTicketList(ZeropayStatisticsVO zeropayStatisticsVo) {
		// TODO Auto-generated method stub
		return zeropayStatisticsMapper.getTicketList(zeropayStatisticsVo);
	}

	@Override
	public int getTicketListCnt(ZeropayStatisticsVO zeropayStatisticsVo) {
		// TODO Auto-generated method stub
		return zeropayStatisticsMapper.getTicketListCnt(zeropayStatisticsVo);
	}

	@Override
	public int getDailyTicketPmtListCnt(ZeropayStatisticsVO zeropayStatisticsVo) {
		// TODO Auto-generated method stub
		return zeropayStatisticsMapper.getDailyTicketPmtListCnt(zeropayStatisticsVo);
	}

	@Override
	public List<ZeropayStatisticsVO> getDailyTicketPmtList(ZeropayStatisticsVO zeropayStatisticsVo) {
		// TODO Auto-generated method stub
		return zeropayStatisticsMapper.getDailyTicketPmtList(zeropayStatisticsVo);
	}

	@Override
	public int getPaymentTypeListCnt(ZeropayStatisticsVO zeropayStatisticsVo) {
		// TODO Auto-generated method stub
		return zeropayStatisticsMapper.getPaymentTypeListCnt(zeropayStatisticsVo);
	}

	@Override
	public List<ZeropayStatisticsVO> getPaymentTypeList(ZeropayStatisticsVO zeropayStatisticsVo) {
		// TODO Auto-generated method stub
		return zeropayStatisticsMapper.getPaymentTypeList(zeropayStatisticsVo);
	}

	@Override
	public int getSeasonTicketPmtListCnt(ZeropayStatisticsVO zeropayStatisticsVo) {
		// TODO Auto-generated method stub
		return zeropayStatisticsMapper.getSeasonTicketPmtListCnt(zeropayStatisticsVo);
	}

	@Override
	public List<ZeropayStatisticsVO> getSeasonTicketPmtList(ZeropayStatisticsVO zeropayStatisticsVo) {
		// TODO Auto-generated method stub
		return zeropayStatisticsMapper.getSeasonTicketPmtList(zeropayStatisticsVo);
	}



	
}