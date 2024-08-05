package com.dkitec.barocle.admin.manage.mallpromotion.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.manage.mallpromotion.vo.MallPromotionVO;
import com.dkitec.barocle.admin.manage.mallpromotion.service.MallPromotionMapper;
import com.dkitec.barocle.admin.manage.mallpromotion.service.MallPromotionService;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("mallPromotionService")
public class MallPromotionServiceImpl implements MallPromotionService {
	
	@Autowired MallPromotionMapper mallPromotionMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int listMallPromotionCount(MallPromotionVO mallPromotionVO) {
		return mallPromotionMapper.listMallPromotionCount(mallPromotionVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public java.util.List<MallPromotionVO> listMallPromotion(MallPromotionVO mallPromotionVO) {
		return mallPromotionMapper.listMallPromotion(mallPromotionVO);
	}

	@Override
	@SuppressWarnings("rawtypes")
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<Map> getStationGroup(String str) {
		return mallPromotionMapper.getStationGroup(str);
	}

	@Override
	@SuppressWarnings("rawtypes")
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<Map> getStationID(Map map) {
		return mallPromotionMapper.getStationID(map);
	}
	
	@Override
	@SuppressWarnings("rawtypes")
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<Map> getMallPromotionType(String str) {
		return mallPromotionMapper.getMallPromotionType(str);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public MallPromotionVO viewMallPromotion(MallPromotionVO mallPromotionVO) {
		MallPromotionVO returnVO = null;
		returnVO = mallPromotionMapper.viewMallPromotion(mallPromotionVO);
		return returnVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public MallPromotionVO insertMallPromotion(MallPromotionVO mallPromotionVO) {
		@SuppressWarnings("unused") int resultValue = mallPromotionMapper.insertMallPromotion(mallPromotionVO);
		return mallPromotionVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public MallPromotionVO updateMallPromotion(MallPromotionVO mallPromotionVO) {
		@SuppressWarnings("unused") int resultModify = mallPromotionMapper.updateMallPromotion(mallPromotionVO);
		return mallPromotionVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteMallPromotion(MallPromotionVO mallPromotionVO) {
		return mallPromotionMapper.deleteMallPromotion(mallPromotionVO);
	}

}
