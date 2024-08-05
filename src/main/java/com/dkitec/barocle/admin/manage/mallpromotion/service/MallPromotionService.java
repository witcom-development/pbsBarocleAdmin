package com.dkitec.barocle.admin.manage.mallpromotion.service;

import com.dkitec.barocle.admin.manage.mallpromotion.vo.MallPromotionVO;

public interface MallPromotionService {
	
	public int listMallPromotionCount(MallPromotionVO mallPromotionVO);
	
	public java.util.List<MallPromotionVO> listMallPromotion(MallPromotionVO mallPromotionVO);
	
	@SuppressWarnings("rawtypes")
	public java.util.List<java.util.Map> getStationGroup(String str);
	
	@SuppressWarnings("rawtypes")
	public java.util.List<java.util.Map> getStationID(java.util.Map map);
	
	@SuppressWarnings("rawtypes")
	public java.util.List<java.util.Map> getMallPromotionType(String str);
	
	public MallPromotionVO viewMallPromotion(MallPromotionVO mallPromotionVO);
	
	public MallPromotionVO insertMallPromotion(MallPromotionVO mallPromotionVO);
	
	public MallPromotionVO updateMallPromotion(MallPromotionVO mallPromotionVO);
	
	public int deleteMallPromotion(MallPromotionVO mallPromotionVO);

}
