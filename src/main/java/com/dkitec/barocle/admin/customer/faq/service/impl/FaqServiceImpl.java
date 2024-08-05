package com.dkitec.barocle.admin.customer.faq.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.faq.service.FaqMapper;
import com.dkitec.barocle.admin.customer.faq.service.FaqService;
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.customer.faq.vo.FaqVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.webutil.StringUtil;
import com.dkitec.barocle.util.webutil.WebUtil;

@Service("faqService")
public class FaqServiceImpl implements FaqService {
	
	@Autowired FaqMapper faqMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int listFaqCount(FaqVO faqVO) {
		return faqMapper.listFaqCount(faqVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<FaqVO> listFaq(FaqVO faqVO) {
		return faqMapper.listFaq(faqVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<CategoryVO> listFaqCategory(CategoryVO categoryVO, String comCD) throws Exception {
		categoryVO.setComCD(comCD);
		return faqMapper.listCategory(categoryVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public Map<String,FaqVO> viewFaq(FaqVO faqVO) throws Exception {
		Map<String,FaqVO> returnMap = null;
		FaqVO returnVO = null;
		try{
			returnMap = new HashMap<String,FaqVO>();
			returnVO = faqMapper.viewFaq(faqVO);
			returnMap.put("returnVO", returnVO);
			//returnMap.put("prevFaqVO", (FaqVO)faqMapper.prevFaq(faqVO));
			//returnMap.put("nextFaqVO", (FaqVO)faqMapper.nextFaq(faqVO));
		} catch (Exception e){
			throw e;
		}
		return returnMap;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<DaumEditorVO> listDaumEditorVO(FaqVO faqVO) {
		return faqMapper.getDaumEditorImage(faqVO);
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public FaqVO insertFaq(FaqVO faqVO) throws Exception {
			@SuppressWarnings("unused") int resultValue = faqMapper.insertFaq(faqVO);
			this.rearrangeOrder(faqVO);
			this.updateDaumEditorImage(faqVO,false);
		return faqVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public FaqVO updateFaq(FaqVO faqVO) throws Exception {
			@SuppressWarnings("unused") int resultModify = faqMapper.updateFaq(faqVO);
			this.rearrangeOrder(faqVO);
			// 수정하기 전 카테고리가 다른 카테고리를 변경한 사항이면 아래와 같이 수정 전 카테고리 표시 순서도 재 정령 해야 한다.
			if(faqVO.getCateCD()!=null&&faqVO.getTempCateCD()!=null&&!faqVO.getCateCD().equals(faqVO.getTempCateCD())){ this.rearrangeOtherOrder(faqVO); }
			this.updateDaumEditorImage(faqVO,true);
		return faqVO;
	}
	
	public boolean updateDaumEditorImage(FaqVO faqVO, boolean mode) throws Exception {
		// * 이미지 파일을 업로드 했다면 noticeVO.imageList에 파일명이 저장되어 있다.
		if(mode){ faqMapper.deleteDaumEditorImage(faqVO); }
		if(!StringUtil.isEmpty(faqVO.getAttach_image_info())){ faqMapper.updateDaumEditorImage(faqVO); }
		return true;
	}
	
	public boolean rearrangeOrder(FaqVO faqVO) throws Exception {
		// 요청한 표시순서
		/*
		FAQ는 각 카테고리 마다 출력순서(qestnOrder)가 존재한다. 기본 출력 순서는 해당 카테고리의 마지막 순서이다.
		이 출력순서는 관리자 임의로 수정이 가능한데, 해당 컨텐츠의 출력순서를 정상적으로 반영할려면 해당 카테고리의 모든 출력순서를 재정의 해야 한다.
		아래 소스는 선택한 컨텐츠의 카테고리의 리스트를 수정하는 내용만 제외하고 모두 받아온다.
		받아온 리스트를 java.util.List 객체에 담고, 수정한 내용인 faqVO를 qestnOrder에 맞춰서 List index에 삽입한 후 모든 qestnOrder를 1부터 재정의한다.
		주의 : 각 카테고리(ex> FAQ_001, FAQ_002...)마다 순서가 존재하며 이는 서로 독립적이다.
		 */
		java.util.List<FaqVO> rearrangeList = faqMapper.getRearrangeList(faqVO);
		// 표시 순번의 숫자는 리스트 목록 크기보다 클 수 없다.
		if((int)faqVO.getQestnOrd()>rearrangeList.size()){ faqVO.setQestnOrd(rearrangeList.size()+1); }
		rearrangeList.add((int)faqVO.getQestnOrd()-1, faqVO);
		int increment = 0;
		for(FaqVO tempVO : rearrangeList){
			tempVO.setQestnOrd(++increment);
			faqMapper.setRearrangeList(tempVO);
		}
		return true;
	}
	
	public boolean rearrangeOtherOrder(FaqVO faqVO) throws Exception {
		/*
		변경한 FAQ의 카테고리가 한 카테고리에서 다른 카테고리로 변경을 하면, 중간에 빈 순서가 존재할 수 있다. (ex. 1,2,5,6...)
		즉 변경전에 카테로리를 tempCateCD로 가져와서 변경전 카테고리의 표시 순서도 재 정렬 한다.
		 */
		java.util.List<FaqVO> rearrangeList = faqMapper.getRearrangeOtherList(faqVO);
		if(rearrangeList!=null&&rearrangeList.size()>0){
			int increment = 0;
			for(FaqVO tempVO : rearrangeList){
				tempVO.setQestnOrd(++increment);
				faqMapper.setRearrangeList(tempVO);
			}
		}
		return true;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteFaq(FaqVO faqVO) throws Exception {
		int resultValue = faqMapper.deleteFaq(faqVO);
		if(resultValue>0){ this.rearrangeOtherOrder(faqVO); }
		return resultValue;
	}

	@Override
	public Map<String,String> getFaqCategoryInfo(String cateCD) throws Exception {
		return faqMapper.getFaqCategoryInfo(cateCD);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public java.util.List<CategoryVO> getCategorySelectionList(CategoryVO categoryVO) {
		return faqMapper.getCategorySelectionList(categoryVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<CategoryVO> getCategorySelectedList(CategoryVO categoryVO) {
		return faqMapper.getCategorySelectedList(categoryVO);
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertCategory(CategoryVO categoryVO) {
		categoryVO.setUseYN("Y");
		String getNextCategorySeq = faqMapper.getNextCategorySeq(categoryVO);
		// 앞에 4글자를 자르고 수치를 구한다.
		getNextCategorySeq = getNextCategorySeq.substring(5,getNextCategorySeq.length());
		int getNextCategoryIntegerValue = Integer.parseInt(getNextCategorySeq) + 1;
		categoryVO.setDspOrd(String.valueOf(getNextCategoryIntegerValue));
		// 신규 CON_CD SEQ를 지정한다.
		categoryVO.setComCD(WebUtil.getPrefixPKAutoId("FAQ_",getNextCategoryIntegerValue));
		int resultValue = faqMapper.insertCategory(categoryVO);
		if(resultValue>0){ faqMapper.insertCategoryMLang(categoryVO); }
		return resultValue;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int updateCategory(CategoryVO categoryVO) {
		int resultValue = faqMapper.updateCategory(categoryVO);
		if(resultValue>0){ faqMapper.updateCategoryMLang(categoryVO); }
		return resultValue;
	}

}
