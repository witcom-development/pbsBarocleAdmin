package com.dkitec.barocle.admin.customer.photogallery.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.photogallery.service.PhotoGalleryMapper;
import com.dkitec.barocle.admin.customer.photogallery.service.PhotoGalleryService;
import com.dkitec.barocle.admin.customer.photogallery.vo.PhotoGalleryVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.webutil.StringUtil;

@Service("photoGalleryService")
public class PhotoGalleryServiceImpl implements PhotoGalleryService {
	
	@Autowired PhotoGalleryMapper photoGalleryMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int listPhotoGalleryCount(PhotoGalleryVO photoGalleryVO) {
		return photoGalleryMapper.listPhotoGalleryCount(photoGalleryVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<PhotoGalleryVO> listPhotoGallery(PhotoGalleryVO photoGalleryVO) {
		return photoGalleryMapper.listPhotoGallery(photoGalleryVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public Map<String,PhotoGalleryVO> viewPhotoGallery(PhotoGalleryVO photoGalleryVO) throws Exception {
		Map<String,PhotoGalleryVO> returnMap = null;
		PhotoGalleryVO returnVO = null;
		try{
			returnMap = new HashMap<String,PhotoGalleryVO>();
			returnVO = photoGalleryMapper.viewPhotoGallery(photoGalleryVO);
			returnMap.put("returnVO", returnVO);
			//returnMap.put("prevPhotoGalleryVO", (PhotoGalleryVO)photoGalleryMapper.prevPhotoGallery(photoGalleryVO));
			//returnMap.put("nextPhotoGalleryVO", (PhotoGalleryVO)photoGalleryMapper.nextPhotoGallery(photoGalleryVO));
		} catch (Exception e){
			throw e;
		}
		return returnMap;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<DaumEditorVO> listDaumEditorVO(PhotoGalleryVO photoGalleryVO) {
		return photoGalleryMapper.getDaumEditorImage(photoGalleryVO);
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public PhotoGalleryVO insertPhotoGallery(PhotoGalleryVO photoGalleryVO) {
		photoGalleryVO.setDelYN("N");
		@SuppressWarnings("unused") int resultValue = photoGalleryMapper.insertPhotoGallery(photoGalleryVO);
		this.updateDaumEditorImage(photoGalleryVO,false);
		return photoGalleryVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public PhotoGalleryVO updatePhotoGallery(PhotoGalleryVO photoGalleryVO) {
		@SuppressWarnings("unused") int resultModify = photoGalleryMapper.updatePhotoGallery(photoGalleryVO);
		this.updateDaumEditorImage(photoGalleryVO,true);
		return photoGalleryVO;
	}
	
	public boolean updateDaumEditorImage(PhotoGalleryVO photoGalleryVO, boolean mode) {
		// * 이미지 파일을 업로드 했다면 noticeVO.imageList에 파일명이 저장되어 있다.
		if(mode){ photoGalleryMapper.deleteDaumEditorImage(photoGalleryVO); }
		if(!StringUtil.isEmpty(photoGalleryVO.getAttach_image_info())){ photoGalleryMapper.updateDaumEditorImage(photoGalleryVO); }
		return true;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deletePhotoGallery(PhotoGalleryVO photoGalleryVO) {
		photoGalleryVO.setDelYN("Y");
		return photoGalleryMapper.deletePhotoGallery(photoGalleryVO);
	}

}
