package com.dkitec.barocle.admin.customer.photogallery.service;

import java.util.List;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.photogallery.vo.PhotoGalleryVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("photoGalleryMapper")
public interface PhotoGalleryMapper {
	
	public int listPhotoGalleryCount(PhotoGalleryVO photoGalleryVO);
	
	public java.util.List<PhotoGalleryVO> listPhotoGallery(PhotoGalleryVO photoGalleryVO);
	
	public PhotoGalleryVO viewPhotoGallery(PhotoGalleryVO photoGalleryVO);
	
	public List<DaumEditorVO> getDaumEditorImage(PhotoGalleryVO photoGalleryVO);
	
	public PhotoGalleryVO prevPhotoGallery(PhotoGalleryVO photoGalleryVO);
	
	public PhotoGalleryVO nextPhotoGallery(PhotoGalleryVO photoGalleryVO);
	
	public int insertPhotoGallery(PhotoGalleryVO photoGalleryVO);
	
	public int updatePhotoGallery(PhotoGalleryVO photoGalleryVO);
	
	public int deleteDaumEditorImage(PhotoGalleryVO photoGalleryVO);
	
	public int updateDaumEditorImage(PhotoGalleryVO photoGalleryVO);
	
	public int deletePhotoGallery(PhotoGalleryVO photoGalleryVO);

}
