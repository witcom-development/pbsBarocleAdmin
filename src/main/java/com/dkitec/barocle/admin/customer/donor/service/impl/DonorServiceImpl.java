package com.dkitec.barocle.admin.customer.donor.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.faq.service.FaqMapper;
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.customer.donor.service.DonorMapper;
import com.dkitec.barocle.admin.customer.donor.service.DonorService;
import com.dkitec.barocle.admin.customer.donor.vo.DonorVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.webutil.StringUtil;

@Service("donorService")
public class DonorServiceImpl implements DonorService {
	
	@Autowired DonorMapper donorMapper;
	@Autowired FaqMapper faqMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int listDonorCount(DonorVO donorVO) {
		return donorMapper.listDonorCount(donorVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<DonorVO> listDonor(DonorVO donorVO) {
		return donorMapper.listDonor(donorVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<CategoryVO> listDonorCategory(CategoryVO categoryVO, String comCD) {
		categoryVO.setComCD(comCD);
		return faqMapper.listCategory(categoryVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public Map<String,DonorVO> viewDonor(DonorVO donorVO) throws Exception {
		Map<String,DonorVO> returnMap = null;
		DonorVO returnVO = null;
		try{
			returnMap = new HashMap<String,DonorVO>();
			returnVO = donorMapper.viewDonor(donorVO);
			returnMap.put("returnVO", returnVO);
			//returnMap.put("prevDonorVO", (DonorVO)donorMapper.prevDonor(donorVO));
			//returnMap.put("nextDonorVO", (DonorVO)donorMapper.nextDonor(donorVO));
		} catch (Exception e){
			throw e;
		}
		return returnMap;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<DaumEditorVO> listDaumEditorVO(DonorVO donorVO) {
		return donorMapper.getDaumEditorImage(donorVO);
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public DonorVO insertDonor(DonorVO donorVO) {
		@SuppressWarnings("unused") int donorSequenceNumber = donorMapper.insertDonor(donorVO);
		this.updateDaumEditorImage(donorVO,false);
		return donorVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public DonorVO updateDonor(DonorVO donorVO) {
		@SuppressWarnings("unused") int resultModify = donorMapper.updateDonor(donorVO);
		this.updateDaumEditorImage(donorVO,true);
		return donorVO;
	}
	
	public boolean updateDaumEditorImage(DonorVO donorVO, boolean mode) {
		// * 이미지 파일을 업로드 했다면 noticeVO.imageList에 파일명이 저장되어 있다.
		if(mode){ donorMapper.deleteDaumEditorImage(donorVO); }
		if(!StringUtil.isEmpty(donorVO.getAttach_image_info())){ donorMapper.updateDaumEditorImage(donorVO); }
		return true;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteDonor(DonorVO donorVO) {
		return donorMapper.deleteDonor(donorVO);
	}

}
