package com.dkitec.barocle.admin.customer.faq.service;

import java.util.List;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.customer.faq.vo.FaqVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("faqMapper")
public interface FaqMapper {
	
	public int listFaqCount(FaqVO faqVO);
	
	public java.util.List<FaqVO> listFaq(FaqVO faqVO);
	
	public java.util.List<CategoryVO> listCategory(CategoryVO categoryVO);
	
	public FaqVO viewFaq(FaqVO faqVO);
	
	public List<DaumEditorVO> getDaumEditorImage(FaqVO faqVO);
	
	public FaqVO prevFaq(FaqVO faqVO);
	
	public FaqVO nextFaq(FaqVO faqVO);
	
	public int insertFaq(FaqVO faqVO);
	
	public int updateFaq(FaqVO faqVO);
	
	public int deleteDaumEditorImage(FaqVO faqVO);
	
	public int updateDaumEditorImage(FaqVO faqVO);
	
	public int deleteFaq(FaqVO faqVO);
	
	public java.util.Map<String,String> getFaqCategoryInfo(String cateCD);
	
	public java.util.List<FaqVO> getRearrangeList(FaqVO faqVO);
	
	public java.util.List<FaqVO> getRearrangeOtherList(FaqVO faqVO);
	
	public int setRearrangeList(FaqVO faqVO);
	
	public java.util.List<CategoryVO> getCategorySelectionList(CategoryVO categoryVO);
	
	public java.util.List<CategoryVO> getCategorySelectedList(CategoryVO categoryVO);
	
	public String getNextCategorySeq(CategoryVO categoryVO);
	
	public int insertCategory(CategoryVO categoryVO);
	
	public int insertCategoryMLang(CategoryVO categoryVO);
	
	public int updateCategory(CategoryVO categoryVO);
	
	public int updateCategoryMLang(CategoryVO categoryVO);

}
