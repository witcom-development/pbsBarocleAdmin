package com.dkitec.barocle.admin.customer.survey.service;

import java.util.List;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.survey.vo.SurveyQestItemVO;
import com.dkitec.barocle.admin.customer.survey.vo.SurveyQestVO;
import com.dkitec.barocle.admin.customer.survey.vo.SurveyResultVO;
import com.dkitec.barocle.admin.customer.survey.vo.SurveyVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("surveyMapper")
public interface SurveyMapper {

	public int listSurveyCount(SurveyVO surveyVO);
	
	public List<SurveyVO> listSurvey(SurveyVO surveyVO);
	
	public SurveyVO viewSurvey(SurveyVO surveyVO);
	
	public List<SurveyQestVO> viewSurveyQest(SurveyVO surveyVO);
	
	public List<SurveyQestItemVO> viewSurveyQestItem(SurveyQestVO surveyQestVO);
	
	public int insertSurvey(SurveyVO surveyVO);
	
	public int getNextQestNum2(SurveyQestVO tempSurveyQestVO);
	
	public int getNextQestNum(SurveyVO surveyVO);
	
	public int getNextItemNum(SurveyQestVO surveyQestVO);
	
	public int insertSurveyQest(SurveyQestVO surveyQestVO);
	
	public int insertSurveyQestItem(SurveyQestItemVO surveyQestItemVO);

	public int updateSurvey(SurveyVO surveyVO);
	
	public int deleteSurveyQest(SurveyVO surveyVO);
	
	public int deleteSurveyQestItem(SurveyVO surveyVO);

	public int updateSurveyQest(SurveyQestVO surveyQestVO);
	
	public int updateSurveyQestItem(SurveyQestItemVO surveyQestItemVO);
	
	public int deleteSurvey(SurveyVO surveyVO);
	
	public List<SurveyResultVO> viewSurveyResult(SurveyVO surveyVO);

	public SurveyVO maxOrd(SurveyVO surveyVO);				//maxOrder 값 가져오기 _20161118_cms

	public int maxOrdCnt(SurveyVO surveyVO);				//order 갯수조회 _20161118_cms

	public List<SurveyVO> getEtcList(SurveyVO surveyVO);	// 기타의견_cms_20161123

	public List<DaumEditorVO> getDaumEditorImage(SurveyVO surveyVO);	//다음에디터 추가_cms_20161223

	public int deleteDaumEditorImage(SurveyVO surveyVO);				//다음에디터 이미지삭제_cms_20161223

	public int updateDaumEditorImage(SurveyVO surveyVO);				//다음에디터 이미지저장_cms_20161223

	public List<SurveyResultVO> viewSurveyResultExcel(SurveyVO surveyVO);
	
}
