package com.dkitec.barocle.admin.customer.photogallery.service;

import java.util.List;
import java.util.Map;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.photogallery.vo.PhotoGalleryVO;

public interface PhotoGalleryService {
	
	public int listPhotoGalleryCount(PhotoGalleryVO photoGalleryVO);
	
	public java.util.List<PhotoGalleryVO> listPhotoGallery(PhotoGalleryVO photoGalleryVO);
	
	public Map<String,PhotoGalleryVO> viewPhotoGallery(PhotoGalleryVO photoGalleryVO) throws Exception;
	
	public List<DaumEditorVO> listDaumEditorVO(PhotoGalleryVO photoGalleryVO);
	
	public PhotoGalleryVO insertPhotoGallery(PhotoGalleryVO photoGalleryVO);
	
	public PhotoGalleryVO updatePhotoGallery(PhotoGalleryVO photoGalleryVO);
	
	public int deletePhotoGallery(PhotoGalleryVO photoGalleryVO);

}
