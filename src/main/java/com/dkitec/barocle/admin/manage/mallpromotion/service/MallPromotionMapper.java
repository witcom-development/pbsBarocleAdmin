package com.dkitec.barocle.admin.manage.mallpromotion.service;


import com.dkitec.barocle.admin.manage.mallpromotion.vo.MallPromotionVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mallPromotionMapper")
public interface MallPromotionMapper {
	
	public int listMallPromotionCount(MallPromotionVO mallPromotionVO);
	
	public java.util.List<MallPromotionVO> listMallPromotion(MallPromotionVO mallPromotionVO);
	
	@SuppressWarnings("rawtypes")
	public java.util.List<java.util.Map> getStationGroup(String str);
	
	@SuppressWarnings("rawtypes")
	public java.util.List<java.util.Map> getStationID(java.util.Map map);
	
	@SuppressWarnings("rawtypes")
	public java.util.List<java.util.Map> getMallPromotionType(String str);
	
	public MallPromotionVO viewMallPromotion(MallPromotionVO mallPromotionVO);
	
	public int insertMallPromotion(MallPromotionVO mallPromotionVO);
	
	public int updateMallPromotion(MallPromotionVO mallPromotionVO);
	
	public int deleteMallPromotion(MallPromotionVO mallPromotionVO);

}
