package com.dkitec.barocle.admin.customer.survey.service;

import java.util.List;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.survey.vo.SurveyResultVO;
import com.dkitec.barocle.admin.customer.survey.vo.SurveyVO;

public interface SurveyService {
	
	public int listSurveyCount(SurveyVO surveyVO);
	
	public List<SurveyVO> listSurvey(SurveyVO surveyVO);
	
	public SurveyVO viewSurvey(SurveyVO surveyVO);
	
	public SurveyVO insertSurvey(SurveyVO surveyVO);
	
	public SurveyVO updateSurvey(SurveyVO surveyVO);

	public int deleteSurvey(SurveyVO surveyVO);
	
	public List<SurveyResultVO> viewSurveyResult(SurveyVO surveyVO);

	public List<SurveyVO> getEtcList(SurveyVO surveyVO);			//기타의견 _cms_20161123

	public List<DaumEditorVO> listDaumEditorVO(SurveyVO surveyVO);	//다음 에디터 추가_cms_20161223

	public List<SurveyResultVO> viewSurveyResultExcel(SurveyVO surveyVO);
	
}
