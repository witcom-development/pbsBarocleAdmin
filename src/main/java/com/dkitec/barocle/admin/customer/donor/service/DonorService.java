package com.dkitec.barocle.admin.customer.donor.service;

import java.util.List;
import java.util.Map;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.customer.donor.vo.DonorVO;

public interface DonorService {
	
	public int listDonorCount(DonorVO donorVO);
	
	public List<DonorVO> listDonor(DonorVO donorVO);
	
	public List<CategoryVO> listDonorCategory(CategoryVO categoryVO, String comCD);
	
	public Map<String,DonorVO> viewDonor(DonorVO donorVO) throws Exception;
	
	public List<DaumEditorVO> listDaumEditorVO(DonorVO donorVO);
	
	public DonorVO insertDonor(DonorVO donorVO);
	
	public DonorVO updateDonor(DonorVO donorVO);
	
	public int deleteDonor(DonorVO donorVO);

}
