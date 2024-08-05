package com.dkitec.barocle.admin.customer.faq.service;

import java.util.List;
import java.util.Map;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.customer.faq.vo.FaqVO;

public interface FaqService {
	
	public int listFaqCount(FaqVO faqVO);
	
	public java.util.List<FaqVO> listFaq(FaqVO faqVO);
	
	public java.util.List<CategoryVO> listFaqCategory(CategoryVO categoryVO, String comCD) throws Exception;
	
	public Map<String,FaqVO> viewFaq(FaqVO faqVO) throws Exception;
	
	public List<DaumEditorVO> listDaumEditorVO(FaqVO faqVO);
	
	public FaqVO insertFaq(FaqVO faqVO) throws Exception;
	
	public FaqVO updateFaq(FaqVO faqVO) throws Exception;
	
	public int deleteFaq(FaqVO faqVO) throws Exception;
	
	public Map<String,String> getFaqCategoryInfo(String cateCD) throws Exception;
	
	public java.util.List<CategoryVO> getCategorySelectionList(CategoryVO categoryVO);
	
	public java.util.List<CategoryVO> getCategorySelectedList(CategoryVO categoryVO);
	
	public int insertCategory(CategoryVO categoryVO);
	
	public int updateCategory(CategoryVO categoryVO);
	
}
