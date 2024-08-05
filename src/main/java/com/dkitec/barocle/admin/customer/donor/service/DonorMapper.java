package com.dkitec.barocle.admin.customer.donor.service;
import java.util.List;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.donor.vo.DonorVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("donorMapper")
public interface DonorMapper {
	
	public int listDonorCount(DonorVO donorVO);
	
	public java.util.List<DonorVO> listDonor(DonorVO donorVO);
	
	public DonorVO viewDonor(DonorVO donorVO);
	
	public List<DaumEditorVO> getDaumEditorImage(DonorVO donorVO);
	
	public DonorVO prevDonor(DonorVO donorVO);
	
	public DonorVO nextDonor(DonorVO donorVO);
	
	public int insertDonor(DonorVO donorVO);
	
	public int updateDonor(DonorVO donorVO);
	
	public int deleteDaumEditorImage(DonorVO donorVO);
	
	public int updateDaumEditorImage(DonorVO donorVO);
	
	public int deleteDonor(DonorVO donorVO);

}
